#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/alt_stdio.h>
#include <sys/alt_alarm.h>
#include <sys/times.h>
#include <alt_types.h>
#include <system.h>
#include <math.h>

//0 = x+x*x
//1 = x+cos
#define task 1
#define div_1024 0
//Test case 1
#define S1 5
#define N1 52
// Test case 2
#define S2 0.1
#define N2 2551
// Test case 3
#define S3 0.001
#define N3 255001
// Generates the vector x and stores it in the memory
float x1[N1]={0};
float x2[N2]={0};
float x3[N3]={0};

double x1d[N1]={0};
double x2d[N2]={0};
double x3d[N3]={0};

void generateVector(float* x, unsigned int n, float s)
{
	int i;
	x[0] = 0;
	for (i=1; i<n; i++){
		x[i] = x[i-1] + s;
	}
}
void generateVector_d(double* x, unsigned int n, double s)
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
		result += (x[i] + x[i]*x[i]);
		printf("%d; %f\n", i, result);
	}
	return result;
}
void sumVector_cos(float x[], double xd[], unsigned int M)
{
	float ff=0, df=0, naive=0;
	double fd=0, dd=0;
	int i=0;
	for (i=0; i<M; i++){
		ff += (x[i]/2) + (x[i]*x[i]*cosf(floor(x[i]/4)-32));
		df += (xd[i]/2) + (xd[i]*xd[i]*cos(floor(xd[i]/4)-32));
		fd += (x[i]/2) + (x[i]*x[i]*cosf(floor(x[i]/4)-32));
		dd += (xd[i]/2) + (xd[i]*xd[i]*cos(floor(xd[i]/4)-32));
		naive += (x[i]/2) + (x[i]*x[i]*cos(floor(x[i]/4)-32));
		printf("index: %d, ff: %f, df: %f, fd: %f, dd: %f, naive: %f\n", i, result1, result2, result3, result4, result5);
	}
}

int main()
{
	clock_t t1, t2, t3, t4, t5, t6;
	char a[50], b[50], c[50];
	////////////////
	printf("Running algorithm for task: ");
	printf((task)?"4+\n":"1-3\n");
	printf("Dividing result by 1024 is: ");
	printf((div_1024)?"ON\n":"OFF\n");
	////////////////
	//test case 1 //
	////////////////
	printf("gen vector 1, ");
	generateVector(x1, N1, S1);
	generateVector_d(x1d, N1, S1);
	printf("sum vector 1\n");
	float y1=0.0;
	if (task) {t1 = times(NULL); y1 = sumVector_cos(x1, x1d, N1); t2 = times(NULL);}
	else {t1 = times(NULL); y1 = sumVector(x1, N1); t2 = times(NULL);}
	gcvt(t2-t1, 10, a);
	alt_putstr("Time = "); alt_putstr(a); alt_putstr("; ");
	printf("Result = %f\n", ((div_1024)?y1/1024:y1));

	////////////////
	//test case 2 //
	////////////////
	printf("gen vector 2, ");
	generateVector(x2, N2, S2);
	generateVector_d(x2d, N2, S2);
	printf("sum vector 2\n");
	float y2=0.0;
	if (task) {t3 = times(NULL); y2 = sumVector_cos(x2, x2d, N2); t4 = times(NULL);}
	else {t3 = times(NULL); y2 = sumVector(x2, N2); t4 = times(NULL);}
	gcvt(t4-t3, 10, b);
	alt_putstr("Time = "); alt_putstr(b); alt_putstr("; ");
	printf("Result = %f\n", ((div_1024)?y2/1024:y2));

	////////////////
	//test case 3 //
	////////////////
	printf("gen vector 3, ");
	generateVector(x3, N3, S3);
	generateVector_d(x3d, N3, S3);
	printf("sum vector 3\n");
	float y3=0.0;
	if (task) {t5 = times(NULL); y3 = sumVector_cos(x3, x3d, N3); t6 = times(NULL);}
	else {t5 = times(NULL); y3 = sumVector(x3, N3); t6 = times(NULL);}
	gcvt(t6-t5, 10, c);
	alt_putstr("Time = "); alt_putstr(c); alt_putstr("; ");
	printf("Result = %f\n", ((div_1024)?y3/1024:y3));

	return 0;
}
