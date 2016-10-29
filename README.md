pythonify
=========

Build a wall (of semicolons and brackets) and make your coworkers pay for it!
This is a perl script that pushes brackets and semicolons far away from the rest of your code. It will also fix your indentation.

###Usage:
- get a c, c++, or java file you want pythonified
- perl pythonify.pl inputfile outputfile

###Notes:
- if your source file has lines longer than 100 characters, change the wallIndex to something higher
- if you have lots of brackets on the same line it might not work perfectly
