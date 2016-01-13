
make.R.matrix <- function(fProp=0.5,qProp=0.2,incl.queer=TRUE,sep.queer=TRUE,
	r.hw=2.5,r.qq=8,r.qw=0.75,r.ww=0.125){

	if(sep.queer && !incl.queer){
		warning("Cannot separate queer men but ignore queer interactions")
	}
	
	
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

	if(!sep.queer && incl.queer){
		r.mm <- qProp*r.qq
		r.mw <- (1-qProp)*r.hw + qProp*r.qw
		r.wm <- r.mw*n.m/n.w
	
		r.m <- c(r.mm,0,r.mw)
		r.q <- rep(0,3)
		r.w <- c(r.wm,0,r.ww)
	
		R.mat<-matrix(c(r.m,r.q,r.w),nrow=3,byrow=T)
	}

	if(!sep.queer && !incl.queer){
		r.mm <- 0
		r.ww <- 0 

	
		r.wm <- c/(2*n.w)
		r.mw <- r.wm*(n.w)/(n.m)
	
		r.m <- c(r.mm,0,r.mw)
		r.q <- rep(0,3)
		r.w <- c(r.wm,0,r.ww)
	
		R.mat <- matrix(c(r.m,r.q,r.w),nrow=3,byrow=T)
	}
	
	return(R.mat)
}


fProp <- 0.5
qProp <- 0.2

r.hw<-2.5
r.qq <- 8
r.qw <- 0.75	
r.ww<-0.125

R.1 <- make.R.matrix(fProp=fProp,qProp=qProp)
R.2 <- make.R.matrix(fProp=fProp,qProp=qProp,sep.queer=FALSE)
R.3 <- make.R.matrix(fProp=fProp,qProp=qProp,incl.queer=FALSE,sep.queer=FALSE)

c.1 <- apply(R.1,1,sum)
c.2 <- apply(R.2,1,sum)
c.3 <- apply(R.3,1,sum)

c.1.bar <- sum(c((1-fProp)*(1-qProp),(1-fProp)*qProp,fProp)*c.1)
c.2.bar <- sum(c((1-fProp),0,fProp)*c.2)
c.3.bar <- sum(c((1-fProp),0,fProp)*c.3)