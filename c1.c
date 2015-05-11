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
  
