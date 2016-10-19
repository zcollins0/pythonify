#!/usr/bin/perl
# pythonify!

use warnings;

my ($inputFile, $outputFile) = @ARGV;

if ((not defined $inputFile) or (not defined $outputFile)) {
    die "\nUsage: perl pythonify.pl <inputfile> <outputFile>";
}

open(my $ifh, '<', $inputFile) or die "\nCould not open file '$inputFile'";
chomp (my @lines = <$ifh>);
close $ifh;

for (my $i = 0; $i < @lines; $i++) {
    if ($lines[$i] =~ m/^\s*\{\s*$/ or $lines[$i] =~ m/^\s*\}\s*$/ or $lines[$i] =~ m/^\s*\};\s*$/) {
        $lines[$i - 1] = $lines[$i - 1] . $lines[$i];
        splice(@lines, $i, 1);
    }
}

open(my $ofh, '>', $outputFile);
print $ofh "//'$inputFile' pythonified!\n";
print $ofh join("\n", @lines);
print $ofh "\n";
close $ofh;
