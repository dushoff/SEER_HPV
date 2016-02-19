

#Redefine the number of susceptibles/vaccinated for male group; we keep the number
#of infected people to start the same, one individual

NB <- NB+NQ
SB <- SB+SQ+1 #(double counted the number of infectious individuals)
VB <- VB+VB

# T/F statement for plotting queers

plot.queer <- FALSE # not including queer men in the system

R.mat <- make.R.matrix(fProp=fProp,qProp=qProp,
	r.qq=r.qq,r.hw = r.hw,r.qw = r.qw,r.ww = r.ww)


#Convert base Rmat to the amalgamated case

r.mw<-sum((n[c(b,q)]/n.m)*R.mat[c(b,q),g])
r.mm<-sum(n[c(b,q)]/n.m*diag(R.mat)[c(b,q)])

r.wm<-r.mw*n.m/n.w

# redefine the queer rows and columns so they are zero
# And newly calculated men/women contact rates
R.mat[q,]<-rep(0,3)
R.mat[,q]<-rep(0,3)

R.mat[b,g]<-r.mw
R.mat[g,b]<-r.wm

# Remove all queer interactions, set diag to zero
diag(R.mat) <- rep(0,3)

n <- c(n.m,0,n.w)

M.mat <- apply(R.mat,2,function(x){x*n})

c<-apply(R.mat,1,sum)
P.mat<-apply(R.mat,2,function(x){x/c})

betaM<-tau.mat*M.mat


