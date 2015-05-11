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
  
  
