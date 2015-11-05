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


