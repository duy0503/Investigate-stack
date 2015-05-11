#include <stdio.h>

extern long findframe();

long c5(long num){
  long sum = findframe();
  printf("Number received from findframe is %ld\n", sum);
  printf("Number received from c4 is %ld\n", num);
  sum += num;
  return sum;
}
