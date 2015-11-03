HPV.vf<-function(t,y,parms,...){
	with(as.list(c(y,parms)),{
		dSB<- ((1-v[1])*b[1]*(NB) + w[1]*VB - beta.mf*SB*(q*IG/NG)
			+ gamma[1]*IB - d[1]*SB
		)

		dIB<- beta.mf*(q*IG/NG)*(SB+eps*VB) - gamma[1]*IB - d[1]*IB 

		dVB<- v[1]*b[1]*(NB) - w[1]*VB - beta.mf*VB*(q*IG/NG) - d[1]*VB
		
		dSQ<- ((1-v[2])*b[1]*(NQ) 
			+ w[2]*VQ - SQ*(p^2*beta.mm*IQ/NQ
			+ (1-p)*(q)*beta.mm*IG/NG) + gamma[1]*IQ - d[1]*SQ
		)

		dIQ<- ((p^2*beta.mm*IQ/NQ+(1-p)*(q)*beta.mm*IG/NG)*(SQ+eps*VQ) 
			- gamma[1]*IQ - d[1]*IQ
		)

		dVQ<- v[2]*b[1]*(NQ) - w[1]*VQ - eps*VQ*(p^2*beta.mm*IQ/NQ+(1-p)*(q)*beta.mm*IG/NG) - d[1]*VQ
		
		dSG<- (1-v[3])*b[2]*NG + w[2]*VG - SG*(q*beta.fm*IB/NB+q*(1-p)*beta.fm*IQ/NQ+(1-q)^2*beta.ff*IG/NG) + gamma[2]*IG - d[2]*SG
		dIG<- (q*beta.fm*IB/NB+q*(1-p)*beta.fm*IQ/NQ+(1-q)^2*beta.ff*IG/NG)*(SG+eps*VG) - gamma[2]*IG - d[2]*IG
		dVG<- v[3]*b[2]*NG - w[2]*VG - eps*VG*(q*beta.fm*IB/NB+q*(1-p)*beta.fm*IQ/NQ+(1-q)^2*beta.ff*IG/NG) - d[2]*VG
	
		res<-c(dSB,dIB,dVB,dSQ,dIQ,dVQ,dSG,dIG,dVG)
		list(res)
		})
}
