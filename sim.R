library(deSolve)

#initial conditions

init<-c(SB=SB,IB=IB,VB=VB,SQ=SQ,IQ=IQ,VQ=VQ,SG=SG,IG=IG,VG=VG)

#parameters

soln<-ode(y=init,times=times,
			func=HPV.vf,
			parms=c(NB=NB,NQ=NQ,NG=NG,
					beta.mf=beta.mf,beta.fm=beta.fm,beta.mm=beta.mm,beta.ff=beta.ff,
					gamma=gamma,
					b=b,d=d,
					v=v,w=w,eps=eps,
					p=p,q=q)
)

#List definition for testing
#because I have a number of lists, I want to lapply over the position
# scenario<-1:(length(v.list))
# soln<-lapply(scenario,function(scenario){
# 	
# 	if(scenario>1){	
# 		v<-c(1,1,1)
# 	}
# 	
# 	parms=c(NB=NB,NQ=NQ,NG=NG,
# 		beta.mf=beta.mf,beta.fm=beta.fm,beta.mm=beta.mm,beta.ff=beta.ff,
# 		gamma=gamma,
# 		b=b,d=d,
# 		v=v,w=w,eps=eps,
# 		p=p,q=q
# 		)
# 
# 	
# 	return(
# 		ode(y=init,times=times,
# 			func=HPV.vf,
# 			parms=parms
# 		)
# 	)
# })

