
c=500
while(c>3){
  b=c-1
  while(b>2){
    a=b-1
    while(a>1){
      if(a+b+c<1000){
				break
			}else if(a+b+c==1000){
				if(a*a+b*b==c*c){
					print(paste("a: ",a))
				  print(paste("b: ",b))
				  print(paste("c: ",c))
				  break
				}
			}
      a=a-1
    }
    b=b-1
  }
  c=c-1
}
