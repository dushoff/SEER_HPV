library(deSolve)

tmax2<-tmax+1500
times<-seq(tmax,tmax2,by=(tmax2-tmax)/nstep)

soln.vacc<-ode(y=new.init,parms=parms,times=times,
               func=HPV.vf)