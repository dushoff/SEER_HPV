# Parameter file!

#Vital parameters (unit is months)

year <- 12
month <- year/12
day <- year/365.25
week <- day*7

L <- 200*month # They stay in our population for 200 months
D <- 16*month # Average infection period

fProp <- 0.5
qProp <- 0.2

d<-rep(1/L, 3) #death rate (boy, queer, girl) = birth rate

# transmission parameters
# transmission matrix (why so specific, where did you get them?)
beta.mf<- 0.0800     #transmission from female to male
beta.fm<- 0.0845     #transmission from male to female
beta.mm<- 0.09     #transmission from male to male
beta.ff<- 0.07   #transmission from female to female

beta.b<-c(0,0,beta.mf)
beta.q<-c(0,beta.mm,beta.mf)
beta.g<-c(beta.fm,beta.fm,beta.ff)

betaM<-matrix(c(beta.b,beta.q,beta.g),nrow=3)

gam<-c(1/16,1/16,1/16)   #recovery rate of HPV FIX!!!

#proportion of groups
n.w <- fProp
n.m <- 1-fProp
n.h<- (1-fProp)*(1-qProp)
n.q<-0.2*0.5 ## FIX!!!

n<-c(n.h,n.q,n.w)

# Effective mixing rates. What are the parameters here?
r.h<-c(0,0,2.5)
m.h<-n.h*r.h
r.q<-c(0,5,0.5)
m.q<-n.q*r.q

#solve for the values
r.w<-c(m.h[3],m.q[3],0.5*n.w)/n.w
m.w<-n.w*r.w
R.mat<-matrix(c(r.h,r.q,r.w),nrow=3,byrow=T)
M.mat<-matrix(c(m.h,m.q,m.w),nrow=3,byrow=T)

c<-apply(R.mat,1,sum)
P.mat<-apply(R.mat,2,function(x){x/c})


betaM<-betaM*M.mat

# Initial conditions

#boy initial conditions
NB<-1330000
NB<-0.7*NB
IB<-1
VB<-0
SB<-NB-IB-VB

#MSM initial conditions
NQ<-0.3*NB
IQ<-10
VQ<-0
SQ<-NQ-IQ-VQ

# girl initial conditions
NG<-1280000
IG<-1
VG<-0
SG<-NG-IG-VG

# time parameters
tmax<-3000
nstep<-300
times<-seq(0,tmax,by=tmax/nstep)
