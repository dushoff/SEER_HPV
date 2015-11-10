# Parameter file!

#Vital parameters

b<-c(0.005,0.005) #birth rate (boy,girl)
d<-c(0.005,0.005) #death rate (boy, girl)

# vaccination parameters

# v<-c(0,0,0.3)    #vaccination rates (boy, queer, girl)
# w<-c(0,0)       #rate of vaccination decay (boy, girl)
# eps<-c(1-0.9)         # protection by vaccine 0 is perfect, 1 is no protection
vaccStart<-1500 #in days

#List testing for solutions
v.list<-list(
	c(0,0,0),
	c(0,0,0.3),
	c(0,0,0.5)
)
w.list<-list(
	c(0,0),
	c(0,0),
	c(0,0)
)
eps.list<-list(
	c(1-0.9),
	c(1-0.9),
	c(1-0.9)
)


# transmission parameters

beta.mf<- 0.0800     #transmission from female to male
beta.fm<- 0.0845     #transmission from male to female
beta.mm<- 0.09     #transmission from male to male
beta.ff<- 0.07   #transmission from female to female

gamma<-c(1/16,1/16)   #recovery rate of HPV

#sexual interaction parameters

p<- 0.90 #proportion of MSM interactions that are same-sex
q<- 0.95 #proportion of female interactions that are opposite-sex

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