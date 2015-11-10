library(deSolve)

#initial conditions

init<-c(SB=SB,IB=IB,VB=VB,SQ=SQ,IQ=IQ,VQ=VQ,SG=SG,IG=IG,VG=VG)

scenario<-1:length(v.list)
soln<-list()
for(i in scenario){
	v<-v.list[[i]]
	w<-w.list[[i]]
	eps<-eps.list[[i]]
	
	soln[[i]]<-ode(y=init,times=times,
				func=HPV.vf,
				parms=c(NB=NB,NQ=NQ,NG=NG,
						betaM=betaM,gam=gam,d=d,
						v=v,w=w,eps=eps,vaccStart=vaccStart
					)
	)
}

HPV.vf(y=init,t=times,parms=c(NB=NB,NQ=NQ,NG=NG,
						betaM=betaM,gam=gam,d=d,
						v=v,w=w,eps=eps,vaccStart=vaccStart))
