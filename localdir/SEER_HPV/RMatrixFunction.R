



make.R.matrix <- function(fProp=0.5,qProp=0.2,
	r.hw=2.5,r.qq=8,r.qw=0.75,r.ww=0.125){

	#Generates an R mixing matrix based on female/male populations and proportion
	#of gay men
	#Generates a matrix that has three mixing scenarios
	#(1) Separated queer men from straight men and include queer mixing
	#(2) Amalgamate queer men and straight men, but still include queer mixing
	#(3) Only consider heterosexual mixing
	#
	#To make these models comparative, I each scenario sets the same average 
	#Contact rate 
	
	
	n.w <- fProp
	n.m <- 1-fProp
	n.h <- n.m*(1-qProp)
	n.q <- n.m*(qProp)

	r.h<-c(0,0,r.hw)
	m.h<-n.h*r.h
	r.q<-c(0,r.qq,r.qw)
	m.q<-n.q*r.q

	#solve for the values
	r.w<-c(m.h[3],m.q[3],r.ww*n.w)/n.w
	m.w<-n.w*r.w
	R.mat<-matrix(c(r.h,r.q,r.w),nrow=3,byrow=T)

	
	c.1 <- apply(R.mat,1,sum)
	c <- sum(c(n.h,n.q,n.w)*c.1)
	
	return(R.mat)
}

