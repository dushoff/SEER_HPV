# Parameter file!

#Vital parameters (unit is months)

year <- 1
month <- year/12
day <- year/365.25
week <- day*7

L <- 200 # They stay in our population for 200 months
D <- 16 # Average infection period

fProp <- 0.5
qProp<- 0.2

#contact rates between groups
r.qq <- 8
r.qw <- 0.125
r.hw<- 2.5
r.ww<-0.125


#define the position of each group in the model
b <- 1
q <- 2
g <- 3

group<-c(b,q,g)

d<-rep(1/L, 3) #death rate (boy, queer, girl) = birth rate

# transmission parameters
# transmission matrix (why so specific, where did you get them?)
tau.mf<- 0.0795     #transmission from female to male
tau.fm<- 0.0845     #transmission from male to female
tau.mm<- 0.09     #transmission from male to male
tau.ff<- 0.07   #transmission from female to female

tau.b<-c(tau.mm,tau.mm,tau.mf)
tau.q<-tau.b
tau.g<-c(tau.fm,tau.fm,tau.ff)

tau.mat<-matrix(c(tau.b,tau.q,tau.g),nrow=3)

gam<-rep(1/D,3)   #recovery rate of HPV 

#proportion of groups
n.w <- fProp
n.m <- (1-fProp)
n.q <- qProp*n.m
n.h <- (1-qProp)*n.m

n<-c(n.h,n.q,n.w)	

# Initial conditions

#boy initial conditions
NB<-1000000


#MSM initial conditions
NQ <- NB*qProp
NB <- NB*(1-qProp)

IQ <- 1
VQ <- 0
SQ <- NQ-IQ-VQ

IB <- 1
VB <- 0
SB <- NB-IB-VB

# girl initial conditions
NG <- 1000000
IG <- 1
VG <- 0
SG <- NG-IG-VG
 
# time parameters
tmax <- 4000
nstep <- 300
times <- seq(0,tmax,by=tmax/nstep)



