/*Author:  Duy Do
Email:   ddo@csu.fullerton.edu
Course:  CPSC 240
Assignment:  7
Due date:  05/14/2015

Name of this file:  c1

GNU compiler:  gcc -c c1.c -o c1.o

Purpose:  This is subprogram number <1> out of 6 designed for the purpose of investigating the role of the system stack in process of calling subprograms.

*/

#include <stdio.h>

extern long c2();

int main(){
  long a = 3, b =  8;
  printf("Values in wo variables in c1 are %ld and %ld\n", a, b);
  puts("");

  long value_from_c2 = c2();
  printf("Values in two variables in c1 are %ld and %ld\n", a, b);
  printf("Value received from c2 is %ld\n", value_from_c2);
  return 0;
}
  
