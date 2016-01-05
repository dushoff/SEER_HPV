# Parameter file!

#Vital parameters (unit is months)

#parameter to state whether we include queer boys in the model
incl.queer<-TRUE

qProp<- 0.2


year <- 1
month <- year/12
day <- year/365.25
week <- day*7

L <- 200 # They stay in our population for 200 months
D <- 16 # Average infection period

fProp <- 0.5


#chosen effective mixing rates
r.hw<-2.5

if(incl.queer){
	r.qq <- 8
	r.qw <- 0.75	
	r.hw<-r.hw
}else{
	r.qq <- 0
	r.qw <- 0.75
	r.hw<-r.hw*(1-qProp)+r.qw*(qProp)
}

r.ww<-0.125

d<-rep(1/L, 3) #death rate (boy, queer, girl) = birth rate

# transmission parameters
# transmission matrix (why so specific, where did you get them?)
beta.mf<- 0.0795     #transmission from female to male
beta.fm<- 0.0845     #transmission from male to female
beta.mm<- 0.09     #transmission from male to male
beta.ff<- 0.07   #transmission from female to female

beta.b<-c(0,0,beta.mf)
beta.g<-c(beta.fm,beta.fm,beta.ff)

if(incl.queer){
	beta.q<-c(0,beta.mm,beta.mf)
	beta.g<-c(beta.fm,beta.fm,beta.ff)
}else{
	beta.q<-c(0,0,0)
	beta.g<-c(beta.fm,0,beta.ff)
}

Beta.mat<-matrix(c(beta.b,beta.q,beta.g),nrow=3)

gam<-rep(1/D,3)   #recovery rate of HPV 

#proportion of groups
n.w <- fProp

if(incl.queer){
	n.h<- (1-fProp)*(1-qProp)
	n.q<-qProp*(1-fProp) 
}else{
	n.h <- (1-fProp)
	n.q <- 0
}

n<-c(n.h,n.q,n.w)

# Effective mixing rates. What are the parameters here?
r.h<-c(0,0,r.hw)
m.h<-n.h*r.h
r.q<-c(0,r.qq,r.qw)
m.q<-n.q*r.q

#solve for the values
r.w<-c(m.h[3],m.q[3],r.ww*n.w)/n.w
m.w<-n.w*r.w
R.mat<-matrix(c(r.h,r.q,r.w),nrow=3,byrow=T)
M.mat<-matrix(c(m.h,m.q,m.w),nrow=3,byrow=T)

c<-apply(R.mat,1,sum)
P.mat<-apply(R.mat,2,function(x){x/c})


betaM<-Beta.mat*M.mat

# Initial conditions

# Initial conditions

#boy initial conditions
NB<-1330000


#MSM initial conditions
NQ <- NB*qProp

if(incl.queer){
	NB<-(1-qProp)*NB
	IQ<-1
}else{

	IQ<-0
}
VQ<-0
SQ<-NQ-IQ-VQ

IB<-1
VB<-0
SB<-NB-IB-VB

# girl initial conditions
NG<-1280000
IG<-1
VG<-0
SG<-NG-IG-VG

# time parameters
tmax<-4000
nstep<-300
times<-seq(0,tmax,by=tmax/nstep)

