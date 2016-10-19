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

open(my $ofh, '>', $outputFile);
print $ofh "//'$inputFile' pythonified!\n";
print $ofh join("\n", @lines);
print $ofh "\n";
close $ofh;
