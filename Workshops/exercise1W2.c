#include<stdio.h>
int main(){
	float L=1000000,APR=0.11,MFP=15000,MPR;
	MPR=APR/12;
	int m=0;
	while(L>=MFP){
		L*=(MPR+1);
		//printf("%f\n", L);
		L-=MFP;
		m++;
	}
	printf("months to finish: %i\n",m);
	printf("Last payment: %f",L);
}
