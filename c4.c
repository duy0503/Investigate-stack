/*Author:  Duy Do
Email:   ddo@csu.fullerton.edu
Course:  CPSC 240
Assignment:  7
Due date:  05/14/2015

Name of this file:  c4

GNU compiler:  gcc -c c4.c -o c4.o

Purpose:  This is subprogram number <4> out of 6 designed for the purpose of investigating the role of the system stack in process of calling subprograms.

*/
#include <stdio.h>

extern long c5(long);
long c4(long num){
  long first = 13;
  long second = first - num;
  long val_from_c5 = c5(second);
  
  printf("Value received from c3 is %ld\n", num);
  printf("The declared value is %ld\n", first);
  printf("The difference value is %ld\n", second);
  printf("The value received from c5 is %ld\n", val_from_c5);
  puts("");
  return val_from_c5;
}
  
