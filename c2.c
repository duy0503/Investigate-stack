/*Author:  Duy Do
Email:   ddo@csu.fullerton.edu
Course:  CPSC 240
Assignment:  7
Due date:  05/14/2015

Name of this file:  c2

GNU compiler:  gcc -c c2.c -o c2.o

Purpose:  This is subprogram number <2> out of 6 designed for the purpose of investigating the role of the system stack in process of calling subprograms.

*/
#include <stdio.h>
#include <stdlib.h>

extern long c3(long);
long c2(){
  long first = -4;
  long* second = malloc(sizeof(long));
  *second = -1;
  long third = 7;
  printf("Values in three variables in c2 are %ld, %ld, %ld\n", first, *second, third);
  puts("");

  long value_from_c3 = c3(first);
  
  printf("Value received from c3 is %ld\n", value_from_c3);
  puts("");
  free(second);
  return value_from_c3;
}
  
  
