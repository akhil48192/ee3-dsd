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
float x1[N1] = { 0 };
float x2[N2] = { 0 };
float x3[N3] = { 0 };

#define MY_COS(A) __builtin_custom_fnf(ALT_CI_COSS_0_N,(A))
#define MY_ADD(A,B) __builtin_custom_fnff(ALT_CI_DSD_FP_ADD_CORDIC_0_N,(A),(B))
#define MY_MULT(A,B) __builtin_custom_fnff(ALT_CI_DSD_FP_MULT_CORDIC_0_N,(A),(B))
#define MY_COS_ROM(A) __builtin_custom_ini(ALT_CI_COS_ROM_0_N,(A))

static inline int my_floor(float x) {
	return (int) x - (x < (int) x);
}

float sumVector_cos_custom(float x[], unsigned int M) {
	float result = 0.0;
	float x_squared = 0.0;
	float cos_out = 0.0;
	float mult_out2 = 0.0;
	float mult_out1 = 0.0;
	int i = 0;
	for (i = 0; i < M; i++) {
		x_squared = MY_MULT(x[i], x[i]);
		//cos_out = cosf(floor(MY_MULT(x[i], (float)0.25)) - 32);
		//cos_out = cosf(MY_COS_ROM(x[i]));
		cos_out = MY_COS(x[i]);
		mult_out1 = MY_MULT(x[i], (float)0.5);
		mult_out2 = MY_MULT(x_squared, cos_out);
		result = MY_ADD(MY_ADD(mult_out1, mult_out2), result);
		printf("i: %d; c: %f\n", i, result);
	}
	return result;
}

float sumVector_cos_customm(float x[], unsigned int M) {
	float result = 0.0;
	float x_squared = 0.0;
	float cos_out = 0.0;
	float mult_out2 = 0.0;
	float mult_out1 = 0.0;
	float c = 0, sum = 0;
	float y, t;
	int i = 0;
	for (i = 0; i < M; i++) {
		x_squared = MY_MULT(x[i], x[i]);
		//cos_out = cosf(my_floor(MY_MULT(x[i], (float)0.25)) - 32);
		cos_out = MY_COS(x[i]);
		mult_out1 = MY_MULT(x[i], (float)0.5);
		mult_out2 = MY_MULT(x_squared, cos_out);
		result = MY_ADD(mult_out1, mult_out2);
		y = MY_ADD(result, -c);
		t = MY_ADD(sum, y);
		c = MY_ADD(MY_ADD(t, -sum), -y);
		sum = t;
	}
	return sum;
}

//c
void generateVector(float* x, unsigned int n, float s) {
	int i;
	x[0] = 0;
	for (i = 1; i < n; i++) {
		x[i] = x[i - 1] + s;
	}
}

void custom(float x[], unsigned int M) {
	float tmp = 0.0;
	int i = 0;
	int j = 0;
	for (i = 0; i < M; i++) {
		tmp = MY_ADD(MY_ADD(x[i], (float)1), (float)2);
	}
}

void custom_2(float x[], unsigned int M) {
	float tmp;
	int i = 0;
	for (i = 0; i < M; i++) {
		tmp = MY_ADD(x[i], (float)3);
	}
}

float sumVector_cos(float x[], unsigned int M) {
	float result = 0.0;
	int i = 0;
	for (i = 0; i < M; i++) {
		result += (x[i] / 2) + (x[i] * x[i] * cosf(floor(x[i] / 4) - 32));
	}
	return result;
}

int main() {
	clock_t t1, t2, t3, t4, t5, t6;
	char a[50], b[50], c[50];

	printf("Hi, v1.9\n");
	printf("Running algorithm for task: ");
	printf((task) ? "4+\n" : "1-3\n");
	printf("Dividing result by 1024 is: ");
	printf((div_1024) ? "ON\n" : "OFF\n");

	generateVector(x1, N1, S1);
	generateVector(x2, N2, S2);
	generateVector(x3, N3, S3);
	////////////////
	//test case 1 //
	////////////////
	printf("gen vector 1, ");
	generateVector(x1, N1, S1);
	printf("sum vector 1\n");
	float y1 = 0.0;
	if (task) {
		t1 = times(NULL);
		y1 = sumVector_cos_custom(x1, N1);
		t2 = times(NULL);
	} else {
		printf("something went wrong\n");
		t1 = times(NULL);
		custom(x3, N3);
		t2 = times(NULL);
	}
	gcvt(t2 - t1, 10, a);
	alt_putstr("Time = ");
	alt_putstr(a);
	alt_putstr("; ");
	printf("Result = %f\n", ((div_1024) ? y1 / 1024 : y1));

	////////////////
	//test case 2 //
	////////////////
	printf("gen vector 2, ");
	generateVector(x2, N2, S2);
	printf("sum vector 2\n");
	float y2 = 0.0;
	if (task) {
		t3 = times(NULL);
		y2 = sumVector_cos_custom(x2, N2);
		t4 = times(NULL);
	} else {
		printf("something went wrong\n");
		t3 = times(NULL);
		custom_2(x3, N3);
		t4 = times(NULL);
	}
	gcvt(t4 - t3, 10, b);
	alt_putstr("Time = ");
	alt_putstr(b);
	alt_putstr("; ");
	printf("Result = %f\n", ((div_1024) ? y2 / 1024 : y2));

	////////////////
	//test case 3 //
	////////////////
	printf("gen vector 3, ");
	generateVector(x3, N3, S3);
	printf("sum vector 3\n");
	float y3 = 0.0;
	if (task) {
		t5 = times(NULL);
		y3 = sumVector_cos_custom(x3, N3);
		t6 = times(NULL);
	} else {
		printf("something went wrong\n");
		t5 = times(NULL);
		t6 = times(NULL);
	}
	gcvt(t6 - t5, 10, c);
	alt_putstr("Time = ");
	alt_putstr(c);
	alt_putstr("; ");
	printf("Result = %f\n", ((div_1024) ? y3 / 1024 : y3));

	return 0;
}
