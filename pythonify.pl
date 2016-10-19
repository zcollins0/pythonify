#!/usr/bin/perl
# pythonify!

use warnings;

my ($inputFile, $outputFile) = @ARGV;

if ((not defined $inputFile) or (not defined $outputFile)) {
    die "\nUsage: perl pythonify.pl <inputfile> <outputFile>";
}

open(my $ifh, '<:encoding(UTF-8)', $inputFile) or die "\nCould not open file '$inputFile'";
open(my $ofh, '>', $outputFile);

print $ofh "//'$inputFile' pythonified!\n";

close $ofh; close $ifh;
