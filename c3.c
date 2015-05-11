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
