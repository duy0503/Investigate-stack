/*Author:  Duy Do
Email:   ddo@csu.fullerton.edu
Course:  CPSC 240
Assignment:  7
Due date:  05/14/2015

Name of this file:  c3

GNU compiler:  gcc -c c3.c -o c3.o

Purpose:  This is subprogram number <3> out of 6 designed for the purpose of investigating the role of the system stack in process of calling subprograms.

*/
#include <stdio.h>

extern long c4(long);
long c3(long num){
  long first = -16;
  long second = num;
  long third = first + second;
  long fourth = c4(third);

  
  printf("Value of the first variable in c3 is %ld\n", first);
  printf("Value of the second variable in c3 is %ld\n", second);
  printf("Value of the third variable in c3 is %ld\n", third);
  printf("Value of the fourth variable in c3 is %ld\n", fourth);
  puts("");
  return fourth;
}
