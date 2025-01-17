#include <stdio.h>
#include <sys/alt_stdio.h>
#include <sys/alt_alarm.h>
#include <sys/times.h>
#include <system.h>
#include <math.h>
#include<stdlib.h>


#define ALT_CI_COSS_0(A) __builtin_custom_fnf(ALT_CI_COSS_0_N,(A))


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
//misc
#define PIx2 6.28318531
#define PIx2fx 0x6487ED80
// Generates the vector x and stores it in the memory
float x1[N1]={0};
float x2[N2]={0};
float x3[N3]={0};

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
		result += (x[i] + x[i]*x[i]);
	}
	return result;
}

static inline int my_floor(float x)
{
    return (int) x - (x < (int) x);
}

float sumVector_cos(float x[], unsigned int M)
{
	float result=0.0;
	int i=0;
	for (i=0; i<M; i++){
		result += (x[i]/2) + (x[i]*x[i]*cosf(floor(x[i]/4)-32));
	}
	return result;
}
float sumVector_cos_custom(float x[], unsigned int M)
{
	float result=0.0;
	float x_squared=0.0;
	float cos_out=0.0;
	float mult_out2=0.0;
	float mult_out1=0.0;
	float inter_result=0.0;
	int i=0;
	for (i=0; i<M; i++){
		//x_squared=ALT_CI_DSD_FP_MULT_CORDIC_0(x[i],x[i]);
		//cos_out=ALT_CI_COS_0(x[i]);
		//mult_out1=ALT_CI_DSD_FP_MULT_CORDIC_0(x[i],0.5);
		//mult_out2=ALT_CI_DSD_FP_MULT_CORDIC_0(x_squared,cos_out);
		//inter_result=ALT_CI_DSD_FP_ADD_CORDIC_0(mult_out1,mult_out2);
		//result = ALT_CI_DSD_FP_ADD_CORDIC_0(result, inter_result);
		printf("%f, %f\n", x[i], ALT_CI_COSS_0(x[i]));
	}
	return result;
}

int main()
{
	clock_t t1, t2, t3, t4, t5, t6;
	char a[50], b[50], c[50];

	printf("Hi, v1.7\n");
	printf("Running algorithm for task: ");
	printf((task)?"4+\n":"1-3\n");
	printf("Dividing result by 1024 is: ");
	printf((div_1024)?"ON\n":"OFF\n");
	////////////////
	//test case 1 //
	////////////////
	printf("gen vector 1, ");
	generateVector(x1, N1, S1);
	printf("sum vector 1\n");
	float y1=0.0;
	if (task) {t1 = times(NULL); y1 = sumVector_cos_custom(x1, N1); t2 = times(NULL);}
	else {t1 = times(NULL); y1 = sumVector(x1, N1); t2 = times(NULL);}
	gcvt(t2-t1, 10, a);
	alt_putstr("Time = "); alt_putstr(a); alt_putstr("; ");
	printf("Result = %f\n", ((div_1024)?y1/1024:y1));

	/*///////////////
	//test case 2 //
	////////////////
	printf("gen vector 2, ");
	generateVector(x2, N2, S2);
	printf("sum vector 2\n");
	float y2=0.0;
	if (task) {t3 = times(NULL); y2 = sumVector_cos_custom(x2, N2); t4 = times(NULL);}
	else {t3 = times(NULL); y2 = sumVector(x2, N2); t4 = times(NULL);}
	gcvt(t4-t3, 10, b);
	alt_putstr("Time = "); alt_putstr(b); alt_putstr("; ");
	printf("Result = %f\n", ((div_1024)?y2/1024:y2));

	////////////////
	//test case 3 //
	////////////////
	printf("gen vector 3, ");
	generateVector(x3, N3, S3);
	printf("sum vector 3\n");
	float y3=0.0;
	if (task) {t5 = times(NULL); y3 = sumVector_cos_custom(x3, N3); t6 = times(NULL);}
	else {t5 = times(NULL); y3 = sumVector(x3, N3); t6 = times(NULL);}
	gcvt(t6-t5, 10, c);
	alt_putstr("Time = "); alt_putstr(c); alt_putstr("; ");
	printf("Result = %f\n", ((div_1024)?y3/1024:y3));
*/

	return 0;
}
