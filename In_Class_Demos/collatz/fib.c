
#include <stdio.h>

int main()
{
  int number = fibonacci(2);
  printf("4th term in fibonacci sequence: %i", number);

  return 0;
}

int fibonacci(int n)
{
  int temp, a = 1, b = 1;
  printf(a + "\n");
  for(int i = 1; i < n; i++)
  {
      temp = b;
      b += a;
      a = temp;
      printf(a + "\n");
  }
  return a;
}
