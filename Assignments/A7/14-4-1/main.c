/* main.c
 * Prompts user for hex number and converts
 * it to an int.
 */

#include <stdio.h>
#include "hexToInt.h"
int writeStr(char *);
int readLn(char *, int);

int main()
{
  int theNumber;
  char theString[9];

  writeStr("Enter up to 32-bit hex number: ");
  readLn(theString, 9);
  theNumber = hexToInt(theString);

  printf("The integer is: %i\n", theNumber);

  return 0;
}
