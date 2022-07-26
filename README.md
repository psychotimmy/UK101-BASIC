# UK101

Repository with BASIC programs that work on the Compukit UK101. Original sources acknowledged where known.

They've (mostly) been tested using an implementation of <a href="http://searle.x10host.com/uk101FPGA/index.html">Grant Searle's FPGA UK101</a> using the CEGMON monitor and 40K RAM expansion. There's also <a href="https://uk101.sourceforge.net/">Tim Baldwin's Java based UK101 simulator</a> if you don't fancy messing around with hardware.

1. Primes.bas - Program 6 from the UK101 Manual. Simple prime number generator.

2. Primes2.bas - A faster algorithm for generating prime numbers. Remove BASIC lines 195 and 196 if not running CEGMON.

3. Sunrise-sunset.bas - Program to calculate sunrise and sunset times for any given latitude / longitude. From Sky & Telescope, August 1994. 
Remove BASIC line 14 if not running CEGMON.

4. Acey-Ducey (Acey- Deucy).bas - Bizarre card game, probably bug-ridden, taken directly from the Compukit UK101 Manual - program 7.

5. Minefield.bas Minesweeper type game (needs original monitor MONUK02 ROM installed). Recovered from an internet forum - originally published in a magazine. Author unknown.

6. Visible.bas - Fill the visible display RAM with 16 rows of 48 characters A-P. (Original monitor)

7. Hundred.bas - The 100 door problem. Work out which doors will be open after inverting their status (i.e. closed/open) after 100 passes, where on the
                 first pass all doors are visited, then every second door, then every third door and so on. (Original monitor)

8. Lepassetemps.bas - Le passe temps (Connect 4 type game). Original monitor (change BASIC line 20 to use CEGMON). Written by A. Knight and published
                      in Practical Electronics magazine, July 1980.

9. Life.bas - An implementation of John Conway's Life game. Requires CEGMON and a 2K VDU RAM space (64x32).

10. TheValley-Version1.bas - An implementation of The Valley. No variations. Requires patched CEGMON, 32K RAM and a 2K VDU RAM space (64×32).

11. TheValley-Version2.bas - An implementation of The Valley. Most variations. Requires patched CEGMON, 32K RAM and a 2K VDU RAM space (64×32).

12. TheValley-Version3.bas - An implementation of The Valley. Limited variations. Requires patched CEGMON, 16K RAM and a 2K VDU RAM space (64×32).

13. TheValley-Version4.bas - An implementation of The Valley. Limited variations, identical to version 3. Requires standard CEGMON, 16K RAM, standard 1K VDU RAM space (48×16).

14. TheValley-Version5.bas - An implementation of The Valley. Limited variations, identical to version 3. Requires original monitor (MONUK02), 16K RAM, standard 1K VDU RAM space (48×16).

15. TheValley-Version6b.bas - An implementation of The Valley. Abbreviated. Requires original monitor (MONUK02), 8K RAM, standard 1K VDU RAM space (48x16). **Important** - the preloader for this version, TheValley-Version6a.bas, must be run first as it initialises the USR for getting keyboard input, along with the monster strengths for the game.
