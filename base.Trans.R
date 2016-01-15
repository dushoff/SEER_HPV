# Parameter file!

#Vital parameters (unit is months)

#parameter to state whether we include queer boys in the model as separate things
incl.queer <- TRUE #includes queer interactions
sep.queer <- TRUE #separates queer men from straight men when modelling


year <- 1
month <- year/12
day <- year/365.25
week <- day*7

L <- 200 # They stay in our population for 200 months
D <- 16 # Average infection period

fProp <- 0.5
qProp<- 0.2

	r.qq <- 8
	r.qw <- 0.125	
	r.hw<- 2.5
	r.ww<-0.125

d<-rep(1/L, 3) #death rate (boy, queer, girl) = birth rate

# transmission parameters
# transmission matrix (why so specific, where did you get them?)
beta.mf<- 0.0795     #transmission from female to male
beta.fm<- 0.0845     #transmission from male to female
beta.mm<- 0.09     #transmission from male to male
beta.ff<- 0.07   #transmission from female to female

beta.b<-c(beta.mm,beta.mm,beta.mf)
beta.q<-beta.b
beta.g<-c(beta.fm,beta.fm,beta.ff)

Beta.mat<-matrix(c(beta.b,beta.q,beta.g),nrow=3)

gam<-rep(1/D,3)   #recovery rate of HPV 

#proportion of groups
n.w <- fProp
n.m <- (1-fProp)
n.q <- qProp*n.m
n.h <- (1-qProp)*n.m

if(sep.queer){
	n<-c(n.h,n.q,n.w)	
}else{
	n<-c(n.m,0,n.w)
}

R.mat <- make.R.matrix(fProp=fProp,qProp=qProp,incl.queer = incl.queer,
	sep.queer = sep.queer,
	r.qq=r.qq,r.hw = r.hw,r.qw = r.qw,r.ww = r.ww)

M.mat <- apply(R.mat,2,function(x){x*n})

#M.mat<-matrix(c(m.h,m.q,m.w),nrow=3,byrow=T)

c<-apply(R.mat,1,sum)
P.mat<-apply(R.mat,2,function(x){x/c})

betaM<-Beta.mat*M.mat

# Initial conditions

# Initial conditions

#boy initial conditions
NB<-1000000


#MSM initial conditions
NQ <- NB*qProp

if(sep.queer){
	NQ<-qProp*NB
	NB<-(1-qProp)*NB
	IQ<-1
}else{
	NQ<-0
	IQ<-0
}
VQ<-0
SQ<-NQ-IQ-VQ

IB<-1
VB<-0
SB<-NB-IB-VB

# girl initial conditions
NG<-1000000
IG<-1
VG<-0
SG<-NG-IG-VG

# time parameters
tmax<-4000
nstep<-300
times<-seq(0,tmax,by=tmax/nstep)


