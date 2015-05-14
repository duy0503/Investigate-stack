/*Author:  Duy Do
Email:   ddo@csu.fullerton.edu
Course:  CPSC 240
Assignment:  7
Due date:  05/14/2015

Name of this file:  c5

GNU compiler:  gcc -c c5.c -o c5.o

Purpose:  This is subprogram number <5> out of 6 designed for the purpose of investigating the role of the system stack in process of calling subprograms.

*/
#include <stdio.h>

extern long findframe();

long c5(long num){
  long sum = findframe();
  printf("Number received from findframe is %ld\n", sum);
  printf("Number received from c4 is %ld\n", num);
  sum += num;
  return sum;
}
