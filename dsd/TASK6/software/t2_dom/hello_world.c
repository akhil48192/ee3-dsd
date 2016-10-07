#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/alt_stdio.h>
#include <sys/alt_alarm.h>
#include <sys/times.h>
#include <alt_types.h>
#include <system.h>

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

void generateVector(float* x, unsigned int n, double s)
{
	int i;
	x[0] = 0;
	for (i=1; i<n; i++){
		x[i] = x[i-1] + s;
	}
}

typedef struct float_tp{
	int sign;
	int exp;
	int f_bit;
	}float_tp;
float_tp convert(float in){
	int bitview=*(int*)&in;
	int exp=((bitview&2139095040)>>23)-127;
	int sig=(bitview&8388607);
	float_tp result;
	result.sign=bitview>>31;
	result.exp=exp;
	result.f_bit=sig;
	return result;
}

float rev_conv(float_tp in){
	int tmp=(in.sign<<31)+((in.exp+127)<<23)+in.f_bit;
	float result=*(float*)&tmp;
	return result;
}

float add(float_tp A,float_tp B){
	int exp_diff=A.exp-B.exp;
	int exp_res=0;
	int M_A=8388608+A.f_bit;
	int M_B=8388608+B.f_bit;
	if(exp_diff>0){
		B.exp+=exp_diff;
		exp_res=A.exp;
		M_B=M_B>>exp_diff;
	}
	if(exp_diff<0){
		exp_res=B.exp;
		A.exp+=exp_diff;
		M_A=M_A>>exp_diff;
	}
	if(exp_diff==0)
	exp_res=A.exp;

	int M_res=M_A+M_B;

	while((M_res&-16777216)!=0){
		M_res=M_res>>1;
		exp_res++;
	}
	while((M_res&8388608)!=8388608){
		M_res=M_res<<1;
		exp_res--;
	}
	float_tp result;
	result.sign=0;
	result.exp=exp_res;
	result.f_bit=M_res-8388608;
	return rev_conv(result);
}
float sumVector(float x[], unsigned int M)
{
	float result=0;
	int i=0;
	for (i=0; i<M; i++){
		result = add(convert(result),convert(add(convert(x[i]),convert(x[i]*x[i]))));
		//result = add(convert(result),convert(x[i]));
	}
	return result;
}
float sumVector_o(float x[], unsigned int M)
{
	float result=0;
	int i=0;
	for (i=0; i<M; i++){
		result += (x[i] + x[i]*x[i]);
		//result += x[i];
	}
	return result;
}
float sumVector_o(float x[], unsigned int M)
{
	float result=0;
	int i=0;
	for (i=0; i<M; i++){
		result += (x[i] + x[i]*x[i]);
		//result += x[i];
	}
	return result;
}
float sumVector_kahan(float x[], unsigned int M)
{
	float c=0.0, sum=x[0];
	float y,t;
	int i=0;
	for (i=1; i<M; i++){
		y = (x[i]+x[i]*x[i]) - c;
		//y = x[i] - c ;
		t = sum + y;
		c = (t - sum) - y;
		sum = t;
		//sum += (x[i] + x[i]*x[i]);
	}
	return sum;
}
int main()
{
	alt_putstr("start\n");

	float test_Array[2] = {3.14159, 2.71828};
	float test_result = (float)10000.0 + sumVector_kahan(test_Array, 2);
	printf("asdf_k: %f\n", test_result);

	test_result = (float)10000.0 + sumVector_o(test_Array, 2);
	printf("asdf_o: %f\n", test_result);

	test_result = sumVector(test_Array, 2);
	printf("asdf_f: %f\n", test_result);

	clock_t exec_t1, exec_t2, exec_t3, exec_t4, exec_t5, exec_t6;
	// Define input vector
	generateVector(x, N, step);

	printf("fin\n");

	exec_t1 = times(NULL);
	float  y = sumVector(x, N);
	exec_t2 = times(NULL);

	y /= 1024;

	printf("fin\n");

	exec_t3 = times(NULL);
	float  z = sumVector_kahan(x, N);
	exec_t4 = times(NULL);

	z /= 1024;

	printf("fin\n");

	exec_t5 = times(NULL);
	float  z2 = sumVector_o(x, N);
	exec_t6 = times(NULL);

	z2 /= 1024;

	//small c library
	char a[50], d[50], e[50], f[50];
	gcvt(exec_t2-exec_t1, 10, a);
	alt_putstr("Time = "); alt_putstr(a); alt_putstr("\n");
	//non small c library
	char b[50];
	gcvt(y, 10, b);
	alt_putstr("Result = "); alt_putstr(b); alt_putstr("\n");

	char c[50];
	gcvt(exec_t4-exec_t3, 10, d);
	alt_putstr("Time = "); alt_putstr(d); alt_putstr("\n");
	gcvt(z, 10, c);
	alt_putstr("Result_kahan = "); alt_putstr(c); alt_putstr("\n");

	gcvt(exec_t6-exec_t5, 10, f);
	alt_putstr("Time = "); alt_putstr(f); alt_putstr("\n");
	gcvt(z2, 10, e);
	alt_putstr("Result_o = "); alt_putstr(e); alt_putstr("\n");
	//printf("Result is: %f\n", y);
	//while(1){ };
	//exit(NULL);
	return 0;
}
