

disdyn <- function(S, I, V, N
	, v, d, w, gam, eps, alpha
	, iProp, betaV
){
	Lam <- sum(betaV*iProp)
	return(c(
		Sdot = (1-v)*d*N + w*V - Lam*S*exp(-alpha*I/N) + gam*I - d*S
		, Idot = Lam*(S+(1-eps)*V)*exp(-alpha*I/N) - gam*I - d*I
		, Vdot = v*d*N - w*V - Lam*(1-eps)*V*exp(-alpha*I/N) - d*V
	))
}

HPV.vf<-function(t,y,parms,...){
	with(as.list(c(y,parms)),{
		#check to see if the vaccine has been implemented
		if(!is.null(vaccStart) && t<vaccStart){
			v<-v*0
		}
		if(NQ==0){
			iProp <-c(IB/NB,0,IG/NG)
		}else{
			iProp <- c(IB/NB, IQ/NQ, IG/NG)
		}
			
		bvec <- disdyn(S=SB, I=IB, V=VB, N=NB
			, v=v[b], d=d[b], w=w[b], gam=gam[b], eps=eps[b], alpha=alpha
			, iProp=iProp, betaV = betaM[b, ]
		)

		qvec <- disdyn(S=SQ, I=IQ, V=VQ, N=NQ
			, v=v[q], d=d[q], w=w[q], gam=gam[q], eps=eps[q], alpha=alpha
			, iProp=iProp, betaV = betaM[q, ]
		)

		gvec <- disdyn(S=SG, I=IG, V=VG, N=NG
			, v=v[g], d=d[g], w=w[g], gam=gam[g], eps=eps[g], alpha=alpha
			, iProp=iProp, betaV = betaM[g, ]
		)
	
		return(list(c(bvec, qvec, gvec)))
	})
}
