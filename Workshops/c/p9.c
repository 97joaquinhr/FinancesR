#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int main(){
	int a,b,c;
	for (c=500;c>3;c--){
		for(b=c-1;b>2;b--){
			for(a=b-1;a>1;a--){
				if(a+b+c<1000)
					break;
				else if(a+b+c==1000){
					if(a*a+b*b==c*c){
						printf("a=%i,b=%i,c=%i",a,b,c);
						return 0;
					}
				}
			}
		}
	}
}