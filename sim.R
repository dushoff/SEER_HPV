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
						beta.mf=beta.mf,beta.fm=beta.fm,beta.mm=beta.mm,beta.ff=beta.ff,
						gamma=gamma,
						b=b,d=d,
						v=v,w=w,eps=eps,
						p=p,q=q)
	)
}

# lapply() is super annoying because I cannot redefine parms within the function
# it doesn't seem to understand that v is a variable that will be filled later
# 

