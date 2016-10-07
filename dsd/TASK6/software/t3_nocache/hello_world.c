#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/alt_stdio.h>
#include <sys/alt_alarm.h>
#include <sys/times.h>
#include <alt_types.h>
#include <system.h>
#include <math.h>

#define test_case 3
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
double x2[N]={0};

void generateVector(float* x, unsigned int n, float s)
{
	int i;
	x[0] = 0;
	for (i=1; i<n; i++){
		x[i] = x[i-1] + s;
	}
}
void generateVector_D(double* x, unsigned int n, double s)
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
	}
	return sum;
}
void sumVector_Diff(float x[], double x2[], unsigned int M, float result, double result2, double result3, float result4)
{
	int i=0;
	float result5=0.0;
	for (i=0; i<M; i++){
		//result += (x[i]/2) + (x[i]*x[i]*cosf(floor(x[i]/4)-32));
		//result2 += (x2[i]/2) + (x2[i]*x2[i]*cos(floor(x2[i]/4)-32));
		//result3 += (float)((x2[i]/2) + (x2[i]*x2[i]*cos(floor(x2[i]/4)-32)));
		//result4 += (double)((x[i]/2) + (x[i]*x[i]*cosf(floor(x[i]/4)-32)));
		result5 += (x[i]/2) + (x[i]*x[i]*cos(floor(x[i]/4)-32));
		//printf("Index: %d;FF: %f; DD: %f;FD: %f; DF: %f \n", i, result, result2, result3, result4);
		printf("Index: %d, cos(float): %f\n", i, result5);
	}
}
int main()
{
	clock_t exec_t1, exec_t2;
	char a[50], b[50];
	// Define input vector
	printf("gen vector\n");
	generateVector(x, N, step);
	generateVector_D(x2, N, step);

	//>normal|<kahan
	char normal = 0;
	char kahan = 0;
	char diff = 1;

	if(normal){
		printf("sum vector\n");
		exec_t1 = times(NULL);
		float  y = sumVector(x, N);
		exec_t2 = times(NULL);

		//y /= 1024;

		gcvt(exec_t2-exec_t1, 10, a);
		alt_putstr("Time = "); alt_putstr(a); alt_putstr("\n");
		printf("Result is %f\n", y);
	}

	if (kahan){
		printf("sum vector kahan\n");
		exec_t1 = times(NULL);
		float  z = sumVector_kahan(x, N);
		exec_t2 = times(NULL);

		//z /= 1024;

		gcvt(exec_t2-exec_t1, 10, b);
		alt_putstr("Time = "); alt_putstr(b); alt_putstr("\n");
		printf("Result is %f\n", z);
	}

	if(diff){
			printf("sum vector\n");
			float result=0.0, result4=0.0;
			double result2=0.0, result3=0.0;
			exec_t1 = times(NULL);
			sumVector_Diff(x, x2, N, result, result2, result3, result4);
			exec_t2 = times(NULL);
			float y = result;
			double z = result2;
			//y /= 1024;

			gcvt(exec_t2-exec_t1, 10, a);
			alt_putstr("Time = "); alt_putstr(a); alt_putstr("\n");
			printf("Result f is %f\n", y);
			printf("Result d is %f\n", z);
		}

	return 0;
}
