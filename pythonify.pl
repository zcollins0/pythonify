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

# find brackets and semicolons on their own lines
for (my $i = 0; $i < @lines; $i++) {
    if ($lines[$i] =~ m/^\s*\{\s*$/ or $lines[$i] =~ m/^\s*\}\s*$/ or $lines[$i] =~ m/^\s*\};\s*$/) {
        $lines[$i - 1] = $lines[$i - 1] . $lines[$i];
        splice(@lines, $i, 1);
    }
}

# sort out brackets that don't end the line
for (my $i = 0; $i < @lines; $i++) {
    my $lindex = rindex($lines[$i], "{");
    if ($lindex > -1 and $lindex != (length($lines[$i]) - 1)) {
        my $lstring = substr($lines[$i], $lindex + 1);
        splice(@lines, $i + 1, 0, $lstring);
        $lines[$i] = substr($lines[$i], 0, length($lines[$i]) - length($lstring));
    }
}

#fix indentation
my $indentationLevel = 0;
for (my $i = 0; $i < @lines; $i++) {
    # trim whitespace from both ends
    $lines[$i] =~ s/^\s+|\s+$//g;
    my $nextIndentationLevel = ($lines[$i] =~ tr/\{//) - ($lines[$i] =~ tr/\}//);
    for (my $k = 0; $k < $indentationLevel; $k++) { substr($lines[$i], 0, 0) = "    "; }
    print "$nextIndentationLevel\n";
    $indentationLevel += $nextIndentationLevel;
}

# build the wall
for (my $i = 0; $i < @lines; $i++) {
    if ($lines[$i] =~ /\/\//) { next; }
    my $lobindex = rindex($lines[$i], "{");
    my $lcbindex = rindex($lines[$i], "}");
    my $lscindex = rindex($lines[$i], ";");
    if ($lobindex == -1 and $lcbindex == -1 and $lscindex == -1) { next; }
    if ($lobindex == -1) { $lobindex = 10000; }
    if ($lcbindex == -1) { $lcbindex = 10000; }
    if ($lscindex == -1) { $lscindex = 10000; }
    my $lindex = ($lobindex, $lcbindex)[$lobindex > $lcbindex];
    $lindex = ($lindex, $lscindex)[$lindex > $lscindex];

    if ($lindex == -1) { next; }
    my $wallIndex = 80;
    my $numSpaces = $wallIndex - $lindex;
    for (my $k = 0; $k < $numSpaces; $k++) { substr($lines[$i], $lindex, 0) = " "; }
}

open(my $ofh, '>', $outputFile);
print $ofh "//'$inputFile' pythonified!\n";
print $ofh join("\n", @lines);
print $ofh "\n";
close $ofh;
