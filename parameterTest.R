# Parameter file!

#Vital parameters


d<-c(0.005,0.005,0.005) #death rate (boy, queer, girl) = birth rate

# vaccination parameters

# v<-c(0,0,0.3)		#vaccination rates (boy, queer, girl)
# w<-c(0,0)			#rate of vaccination decay (boy, girl)
# eps<-c(1-0.9		# protection by vaccine 0 is perfect, 1 is no protection
vaccStart<-1500		# in months (125 years)

#List testing for solutions
v.list<-list(
	c(0,0,0),
	c(0,0,0.3),
	c(0,0,0.5)
)
w.list<-list(
	c(0,0,0),
	c(0,0,0),
	c(0,0,0)
)
eps.list<-list(
	rep(1-0.9,3),
	rep(1-0.9,3),
	rep(1-0.9,3)
)

# transmission parameters
# transmission matrix


beta.mf<- 0.0800     #transmission from female to male
beta.fm<- 0.0845     #transmission from male to female
beta.mm<- 0.09     #transmission from male to male
beta.ff<- 0.07   #transmission from female to female

beta.b<-c(0,0,beta.mf)
beta.q<-c(0,beta.mm,beta.mf)
beta.g<-c(beta.fm,beta.fm,beta.ff)

betaM<-matrix(c(beta.b,beta.q,beta.g),nrow=3)

gam<-c(1/16,1/16,1/16)   #recovery rate of HPV

#sexual interaction parameters

p.msm<- 0.90 #proportion of MSM interactions that are same-sex
p.wsw<- 0.05 #proportion of female interactions that are opposite-sex

mixMat<-matrix(
	c(
		0,0,(1-p.wsw),
		0,p.msm^2,(1-p.msm)*(1-p.wsw),
		(1-p.wsw),(1-p.msm)*(1-p.wsw),p.wsw^2
	),
	nrow=3
)

betaM<-betaM*mixMat

# Initial conditions

#boy initial conditions
NB<-1330000
NB<-0.7*NB
IB<-1
VB<-0
SB<-NB-IB-VB

#MSM initial conditions
NQ<-0.3*NB
IQ<-1
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