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
#include<system.h>
#define ALT_CI_MEM_READ_0(A,B) __builtin_custom_fnii(ALT_CI_MEM_READ_0_N,(A),(B))


int main()
{	float x1[30]={0};
int i=0;
	for (i=0;i<30;i++){
		x1[i]=i+0.5;
	}
	printf("hello world\n");
	printf("%f\n",ALT_CI_MEM_READ_0(x1,20*4));

  return 0;
}
