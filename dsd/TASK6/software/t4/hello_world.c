#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/alt_stdio.h>
#include <sys/alt_alarm.h>
#include <sys/times.h>
#include <alt_types.h>
#include <system.h>
#include <math.h>

#define test_case 2
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
		result += (x[i]/2) + (x[i]*x[i]*cosf(floor(x[i]/4)-32));
		//if (i<280) printf("index: %d; result: %f\n", i, result);
	}
	return result;
}
float sumVector_kahan(float x[], unsigned int M)
{
	float c=0, sum=0;
	float y,t;
	int i=0;
	for (i=0; i<M; i++){
		y = (x[i]/2) + (x[i]*x[i]*cosf(floor(x[i]/4)-32)) - c;
		t = sum + y;
		c = (t - sum) - y;
		sum = t;
		//if (1) printf("index: %d; result: %f\n", i, sum);
	}
	return sum;
}
int main()
{
	clock_t exec_t1, exec_t2;
	char a[50], b[50];
	// Define input vector
	printf("gen vector\n");
	generateVector(x, N, step);

	int k=1;

	if(k==1){
		printf("sum vector\n");
		exec_t1 = times(NULL);
		float  y = sumVector(x, N);
		exec_t2 = times(NULL);

		//y /= 1024;

		gcvt(exec_t2-exec_t1, 10, a);
		alt_putstr("Time = "); alt_putstr(a); alt_putstr("\n");
		printf("Result is %f\n", y);
	}

	if (k==1){
		printf("sum vector kahan\n");
		exec_t1 = times(NULL);
		float  z = sumVector_kahan(x, N);
		exec_t2 = times(NULL);

		//z /= 1024;

		gcvt(exec_t2-exec_t1, 10, b);
		alt_putstr("Time = "); alt_putstr(b); alt_putstr("\n");
		printf("Result is %f\n", z);
	}

	return 0;
}
