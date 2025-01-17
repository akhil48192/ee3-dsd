/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include <unistd.h>
#include <sys/alt_stdio.h>
#include <sys/alt_alarm.h>
#include <sys/times.h>
#include <alt_types.h>
#include <system.h>
#include <math.h>
#include <stdlib.h>



#define ALT_CI_SUM_VECTOR_0(A,B) __builtin_custom_fnii(ALT_CI_SUM_VECTOR_0_N,(A),(B))


int main()
{
	char a[50];
clock_t t1,t2;
float x[255001]={0};
int i=0;
int n=4*255001;
float result1=0;
float result2=0;
float result3=0;
float result4=0;
float result5=0;
float result6=0;
	for (i=0;i<255001;i++){
		x[i]=i*0.001;
	}
	printf("hello world\n");
	t1 = times(NULL);
	result1=ALT_CI_SUM_VECTOR_0((int)x,n);
	t2 = times(NULL);
	result2=ALT_CI_SUM_VECTOR_0((int)x,n);
	result3=ALT_CI_SUM_VECTOR_0((int)x,n);
	result4=ALT_CI_SUM_VECTOR_0((int)x,n);
	result5=ALT_CI_SUM_VECTOR_0((int)x,n);
	result6=ALT_CI_SUM_VECTOR_0((int)x,n);
	printf("%f\n",result1);
	printf("%f\n",result2);
	printf("%f\n",result3);
	printf("%f\n",result4);
	printf("%f\n",result5);
	gcvt(t2-t1, 10, a);
	alt_putstr("Time = "); alt_putstr(a); alt_putstr("; ");
  return 0;
}
