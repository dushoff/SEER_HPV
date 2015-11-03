library(deSolve)

HPV.vf<-function(t,y,parms,...){
    with(as.list(c(y,parms)),{
        
        dSB<- (1-v[1])*b[1]*(NB) + w[1]*VB - beta.mf*SB*(q*IG/NG) + gamma[1]*IB - d[1]*SB
        dIB<- beta.mf*(q*IG/NG)*(SB+eps*VB) - gamma[1]*IB - d[1]*IB 
        dVB<- v[1]*b[1]*(NB) - w[1]*VB - beta.mf*VB*(q*IG/NG) - d[1]*VB
        
        dSQ<- (1-v[2])*b[1]*(NQ) + w[2]*VQ - SQ*(p^2*beta.mm*IQ/NQ+(1-p)*(q)*beta.mm*IG/NG) + gamma[1]*IQ - d[1]*SQ
        dIQ<- (p^2*beta.mm*IQ/NQ+(1-p)*(q)*beta.mm*IG/NG)*(SQ+eps*VQ) - gamma[1]*IQ - d[1]*IQ
        dVQ<- v[2]*b[1]*(NQ) - w[1]*VQ - eps*VQ*(p^2*beta.mm*IQ/NQ+(1-p)*(q)*beta.mm*IG/NG) - d[1]*VQ
        
        dSG<- (1-v[3])*b[2]*NG + w[2]*VG - SG*(q*beta.fm*IB/NB+q*(1-p)*beta.fm*IQ/NQ+(1-q)^2*beta.ff*IG/NG) + gamma[2]*IG - d[2]*SG
        dIG<- (q*beta.fm*IB/NB+q*(1-p)*beta.fm*IQ/NQ+(1-q)^2*beta.ff*IG/NG)*(SG+eps*VG) - gamma[2]*IG - d[2]*IG
        dVG<- v[3]*b[2]*NG - w[2]*VG - eps*VG*(q*beta.fm*IB/NB+q*(1-p)*beta.fm*IQ/NQ+(1-q)^2*beta.ff*IG/NG) - d[2]*VG
    
        res<-c(dSB,dIB,dVB,dSQ,dIQ,dVQ,dSG,dIG,dVG)
        list(res)
        })
}

#Vital parametrs

b<-c(0.005,0.005) #birth rate (boy,girl)
d<-c(0.005,0.005) #death rate (boy, girl)

# vaccination parameters

v<-c(0,0,0)     #vaccination rates (boy, queer, girl)
w<-c(0,0)       #rate of vaccination decay (boy, girl)
eps<-1-0.9          # protection by vaccine 0 is perfect, 1 is no protection

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


NB<-1330000
NB<-0.7*NB
IB<-1
VB<-0
SB<-NB-IB-VB


NQ<-0.3*NB
IQ<-1
VQ<-0
SQ<-NQ-IQ-VQ


NG<-1280000
IG<-1
VG<-0
SG<-NG-IG-VG

#initial conditions
init<-c(SB=SB,IB=IB,VB=VB,SQ=SQ,IQ=IQ,VQ=VQ,SG=SG,IG=IG,VG=VG)

#parameters
parms<-c(NB=NB,NQ=NQ,NG=NG,
         beta.mf=beta.mf,beta.fm=beta.fm,beta.mm=beta.mm,beta.ff=beta.ff,
         gamma=gamma,
         b=b,d=d,
         v=v,w=w,eps=eps,
         p=p,q=q)

tmax<-1500
nstep<-100
times<-seq(0,tmax,by=tmax/nstep)

soln<-ode(y=init,parms=parms,times=times,
          func=HPV.vf)

status<-c(1,2,3)
max.pop<-max(NG,NB,NQ)

with(as.data.frame(soln),{
    plot(0,0,type="n",xlim<-c(0,tmax),ylim<-c(0,max.pop),
         las=1)
    lines(time,SB,col="blue",lty=status[1])
    lines(time,IB,col="blue",lty=status[2])
    lines(time,VB,col="blue",lty=status[3])
    lines(time,SQ,col="darkorchid1",lty=status[1])
    lines(time,IQ,col="darkorchid1",lty=status[2])
    lines(time,VQ,col="darkorchid1",lty=status[3])
    lines(time,SG,col="red",lty=status[1])
    lines(time,IG,col="red",lty=status[2])
    lines(time,VG,col="red",lty=status[3])
    
})
last<-nstep+1
new.init<-c(soln[last,"SB"],soln[last,"IB"],soln[last,"VB"],
            soln[last,"SQ"],soln[last,"IQ"],soln[last,"VQ"],
            soln[last,"SG"],soln[last,"IG"],soln[last,"VG"])

v<-c(0,0,1)

parms<-c(NB=NB,NQ=NQ,NG=NG,
         beta.mf=beta.mf,beta.fm=beta.fm,beta.mm=beta.mm,beta.ff=beta.ff,
         gamma=gamma,
         b=b,d=d,
         v=v,w=w,eps=eps,
         p=p,q=q)

tmax2<-tmax+1500
times<-seq(tmax,tmax2,by=(tmax2-tmax)/nstep)

soln.vacc<-ode(y=new.init,parms=parms,times=times,
               func=HPV.vf)

start<-round((nstep+1)*0.7)

with(as.data.frame(soln),{
    plot(0,0,type="n",xlim<-c(time[start],tmax2),ylim<-c(0,400000),
         las=1)
    lines(time,IB,col="blue",lty=2)
    lines(time,IQ,col="darkorchid1",lty=2)
    lines(time,IG,col="red",lty=2)
})


with(as.data.frame(soln.vacc),{
    abline(v=tmax,col="gray")
    #lines(time,SB,col="blue",lty=status[1])
    lines(time,IB,col="blue",lty=status[2])
    #lines(time,VB,col="blue",lty=status[3])
    #lines(time,SQ,col="darkorchid1",lty=status[1])
    lines(time,IQ,col="darkorchid1",lty=status[2])
    #lines(time,VQ,col="darkorchid1",lty=status[3])
    #lines(time,SG,col="red",lty=status[1])
    lines(time,IG,col="red",lty=status[2])
    #lines(time,VG,col="red",lty=status[3])
    
})