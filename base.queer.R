# T/F statement for plotting queers

plot.queer <- TRUE

R.mat <- make.R.matrix(fProp=fProp,qProp=qProp,
	r.qq=r.qq,r.hw = r.hw,r.qw = r.qw,r.ww = r.ww)

M.mat <- apply(R.mat,2,function(x){x*n})

#M.mat<-matrix(c(m.h,m.q,m.w),nrow=3,byrow=T)

c<-apply(R.mat,1,sum)
P.mat<-apply(R.mat,2,function(x){x/c})

betaM<-tau.mat*M.mat

print(plot.queer)