# UK101

Repository with BASIC programs that work on the Compukit UK101. Original sources acknowledged where known.

They've (mostly) been tested using an implementation of <a href="http://searle.x10host.com/uk101FPGA/index.html">Grant Searle's FPGA UK101</a> using the CEGMON monitor and 40K RAM expansion.

1. Primes.bas - Program 6 from the UK101 Manual. Simple prime number generator.

2. Primes2.bas - A faster algorithm for generating prime numbers. Remove BASIC lines 195 and 196 if not running CEGMON.

3. Sunrise-sunset.bas - Program to calculate sunrise and sunset times for any given latitude / longitude. From Sky & Telescope, August 1994. 
Remove BASIC line 14 if not running CEGMON.

4. Acey-Ducey (Acey- Deucy).bas - Bizarre card game, probably bug-ridden, taken directly from the Compukit UK101 Manual - program 7.

5. Minefield.bas Minesweeper type game (needs original monitor MONUK02 ROM installed). Recovered from an internet forum - originally published in a magazine. Author unknown.

6. Visible.bas - Fill the visible display RAM with 16 rows of 48 characters A-P. (Original monitor)

7. Hundred.bas - The 100 door problem. Work out which doors will be open after inverting their status (i.e. closed/open) after 100 passes, where on the
                 first pass all doors are visited, then every second door, then every third door and so on. (Original monitor)
