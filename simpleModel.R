b <- 1
q <- 2
g <- 3

disdyn <- function(S, I, V, N
	, v, d, w, gam, eps
	, iProp, betaV
){
	Lam <- sum(betaV*iProp)
	return(c(
		Sdot = (1-v)*d*N + w*V - Lam*S + gam*I - d*S
		, Idot = Lam*(S+eps*V) - gam*I - d*I
		, Vdot = v*d*N - w*V - Lam*eps*V - d*V
	))
}

HPV.vf<-function(t,y,parms,...){
	with(as.list(c(y,parms)),{
		#check to see if the vaccine has been implemented
		if(!is.null(vaccStart) && t<vaccStart){
			v<-v*0
		}
		iProp <- c(IB/NB, IQ/NQ, IG/NG)

		bvec <- disdyn(S=SB, I=IB, V=VB, N=NB
			, v=v[b], d=d[b], w=w[b], gam=gam[b], eps=eps[b]
			, iProp=iProp, betaV = betaM[b, ]
		)

		qvec <- disdyn(S=SQ, I=IQ, V=VQ, N=NQ
			, v=v[q], d=d[q], w=w[q], gam=gam[q], eps=eps[q]
			, iProp=iProp, betaV = betaM[q, ]
		)

		gvec <- disdyn(S=SG, I=IG, V=VG, N=NG
			, v=v[g], d=d[g], w=w[g], gam=gam[g], eps=eps[g]
			, iProp=iProp, betaV = betaM[g, ]
		)
	
		return(list(c(bvec, qvec, gvec)))
	})
}
