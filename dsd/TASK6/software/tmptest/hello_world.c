#include <stdio.h>
#include <unistd.h>
#include <sys/alt_stdio.h>
#include <sys/alt_alarm.h>
#include <sys/times.h>
#include <alt_types.h>
#include <system.h>
#include <math.h>
#include <stdlib.h>

//0 = custom
//1 = x+cos
#define task 0
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

#define N4 100
float x4[N4] = {10.9723	, 77.2785	, 210.851	, 96.4603	, 98.1499	, 145.173	, 46.4648	, 66.6482	, 14.1594	, 130.903	, 233.585	, 250.265	, 245.551	, 204.254	, 230.823	, 91.1879	, 22.7418	, 253.154	, 236.203	, 89.8401	, 172.162	, 56.5453	, 127.008	, 55.2051	, 191.927	, 227.897	, 254.837	, 99.7938	, 200.357	, 132.955	, 213.634	, 211.329	, 210.234	, 169.485	, 52.7898	, 53.3837	, 59.6574	, 99.2546	, 120.032	, 73.8167	, 230.157	, 98.6173	, 69.0819	, 220.708	, 47.8709	, 44.9053	, 56.8962	, 70.6127	, 43.0595	, 38.099	, 160.453	, 215.221	, 94.6443	, 32.4609	, 15.4261	, 31.5715	, 5.35805	, 15.2636	, 131.365	, 205.715	, 148.219	, 89.999	, 162.045	, 103.453	, 4.4839	, 214.834	, 156.836	, 64.1413	, 59.0891	, 21.8682	, 137.958	, 34.2465	, 120.485	, 207.04	, 254.955	, 168.356	, 251.945	, 56.8511	, 238.969	, 40.0048	, 94.95	, 144.422	, 0.225848	, 189.594	, 176.883	, 15.652	, 221.166	, 182.241	, 30.9156	, 97.5312	, 132.956	, 179.134	, 187.53	, 40.0008	, 27.587	, 192.014	, 254.835	, 184.423	, 1.15545	, 58.9243	, };

#define MY_COS8(A) __builtin_custom_fnf(ALT_CI_COS8_0_N,(A))
#define MY_COS(A) __builtin_custom_fnf(ALT_CI_COS_0_N,(A))

/*float sumVector_cos_custom(float x[], unsigned int M)
{
	float result = 0.0;
	float x_squared = 0.0;
	float cos_out = 0.0;
	float mult_out2 = 0.0;
	float mult_out1 = 0.0;
	int i = 0;
	for (i = 0; i < M; i++) {
		x_squared = ALT_CI_FPMUL_0(x[i], x[i]);
		//cos_out = cosf(floor(ALT_CI_FPMUL_0(x[i], (float)0.25))-32);
		cos_out = ALT_CI_COS_0(x[i]);
		mult_out1 = ALT_CI_FPMUL_0(x[i], (float)0.5);
		mult_out2 = ALT_CI_FPMUL_0(x_squared, cos_out);
		result = ALT_CI_FPADD_0(ALT_CI_FPADD_0(mult_out1, mult_out2), result);
	}
	return result;
}*/


//c
void generateVector(float* x, unsigned int n, float s)
{
	int i;
	x[0] = 0;
	for (i=1; i<n; i++){
		x[i] = x[i-1] + s;
	}
}

static inline int my_floor(float x)
{
    return (int) x - (x < (int) x);
}

void custom(float x[], unsigned int M)
{
	int tmp;
	int i=0;
	for (i=0; i<M; i++){
		tmp = MY_COS(x[i]);
		printf("i: %d;xi: %f;floor: %d;cos: %f; cordic: %f\n", i, x[i], (int)(floor(x[i]/4)-32), cos((int)(floor(x[i]/4)-32)), tmp);
	}
}

void custom_2(float x[], unsigned int M)
{
	int tmp;
	int i=0;
	for (i=0; i<M; i++){
		tmp = MY_COS8(x[i]);
		printf("i: %d;xi: %f;floor: %d;cos: %f; cordic: %f\n", i, x[i], (int)(floor(x[i]/4)-32), cos((int)(floor(x[i]/4)-32)), tmp);
	}
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
	else {t1 = times(NULL); custom(x4, N4); t2 = times(NULL);}
	gcvt(t2-t1, 10, a);
	alt_putstr("Time = "); alt_putstr(a); alt_putstr("; ");
	printf("Result = %f\n", ((div_1024)?y1/1024:y1));

	////////////////
	//test case 2 //
	////////////////
	printf("gen vector 2, ");
	generateVector(x2, N2, S2);
	printf("sum vector 2\n");
	float y2=0.0;
	if (task) {t3 = times(NULL); y2 = sumVector_cos_custom(x2, N2); t4 = times(NULL);}
	else {t3 = times(NULL); custom_2(x4, N4); t4 = times(NULL);}
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
	else {t5 = times(NULL); t6 = times(NULL);}
	gcvt(t6-t5, 10, c);
	alt_putstr("Time = "); alt_putstr(c); alt_putstr("; ");
	printf("Result = %f\n", ((div_1024)?y3/1024:y3));


	return 0;
}
