#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/alt_stdio.h>
#include <sys/alt_alarm.h>
#include <sys/times.h>
#include <alt_types.h>
#include <system.h>

#define test_case 1
#if test_case == 1
//Test case 1
#define step 5
#define N 52
#elif test_case == 2
// Test case 2
#define step 0.1
#define N 2551
#else
//Test case 3
#define step 0.001
#define N 255001
#endif
// Generates the vector x and stores it in the memory
float x[N]={0};

void generateVector(float* x, unsigned int n, float s)
{
	int i;
	x[0] = 0;
	for (i=1; i<n; i++){
		x[i] = x[i-1] + s;
	}
}
float sumVector(float x[], unsigned int M)
{
	float result=0;
	int i=0;
	for (i=0; i<M; i++){
		result += (x[i]+x[i]*x[i]);
	}
	return result;
}
float sumVector_kahan(float x[], unsigned int M)
{
	float c=0, sum=0;
	float y,t;
	int i=0;
	for (i=0; i<M; i++){
		y = (x[i]+x[i]*x[i]) - c;
		t = sum + y;
		c = (t - sum) - y;
		sum = t;
	}
	return sum;
}

int main()
{
	clock_t exec_t1, exec_t2, exec_t3, exec_t4;
	generateVector(x, N, step);

	exec_t1 = times(NULL);
	float  y = sumVector(x, N);
	exec_t2 = times(NULL);

	y /= 1024;

	exec_t3 = times(NULL);
	float  z = sumVector_kahan(x, N);
	exec_t4 = times(NULL);

	z /= 1024;

	//small c library
	char a[50], b[50], c[50], d[50];

	gcvt(exec_t2-exec_t1, 10, a);
	alt_putstr("Time = "); alt_putstr(a); alt_putstr("\n");
	gcvt(y, 10, b);
	alt_putstr("Result = "); alt_putstr(b); alt_putstr("\n");

	gcvt(exec_t4-exec_t3, 10, c);
	alt_putstr("Time = "); alt_putstr(c); alt_putstr("\n");
	gcvt(z, 10, d);
	alt_putstr("Result_kahan = "); alt_putstr(d); alt_putstr("\n");

	return 0;
}
