
#include <stdio.h>
#include <system.h>
#include <math.h>
#define ALT_CI_COS_ROM_0(A) __builtin_custom_inf(ALT_CI_COS_ROM_0_N,(A))
#define S2 0.1
#define N2 2551
//misc
#define PIx2 6.28318531
#define PIx2fx 0x6487ED80
// Generates the vector x and stores it in the memory

float x2[N2]={0};

void generateVector(float* x, unsigned int n, float s)
{
	int i;
	x[0] = 0;
	for (i=1; i<n; i++){
		x[i] = x[i-1] + s;
	}
}
int main()
{int i=0;
printf("start\n");
generateVector(x2,N2,S2);
  for (i=0;i<200;i++){
	 printf("%f    %f \n",fmod((floor(x2[i]/4)-32),PIx2),ALT_CI_COS_ROM_0(x2[i])/pow(2,28));
  }

  return 0;
}
