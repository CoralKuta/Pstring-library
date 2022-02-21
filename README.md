# Pstring-library
## Assembly x86

P-string (pascal string) is a convention for storing a string with it's length in the first byte.
This program has some library functions that makes working with p-strings easier. For example:
- pstrlen - returns the length of the string.
- swapCase - swaps lower case to upper case, and upper case to lower case.
- replaceChar - changes all the appearances of one character to another.

All is written in Assembly language, using conventions of registers and allocations of stack frames.
The program asks for 2 strings, their lengths and a menu option, and exectues the relevant function.
