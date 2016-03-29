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
						betaM=betaM,gam=gam,alpha=alpha,d=d,
						v=v,w=w,eps=eps,vaccStart=vaccStart
					)
	)
}

thresh<-1
pop.min<-10

inf.soln<-soln[[1]][,c("time","IB","IQ","IG")]
equil.time<-inf.soln[1,1]
for(i in 2:dim(inf.soln)[1]){
		if(inf.soln[i,"IB"]-inf.soln[i-1,"IB"]<thresh && inf.soln[i,"IB"]>pop.min){
			equil.time <- inf.soln[i,1]
			break
			
		}
}
