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
  
