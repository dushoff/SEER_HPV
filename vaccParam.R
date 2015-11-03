v<-c(0,0,1)
w<-c(0,0)

status<-c(1,2,3)
max.pop<-max(NG,NB,NQ)

thingstotest<-1

last<-nstep+1
new.init<-c(soln[last,"SB"],soln[last,"IB"],soln[last,"VB"],
            soln[last,"SQ"],soln[last,"IQ"],soln[last,"VQ"],
            soln[last,"SG"],soln[last,"IG"],soln[last,"VG"])

parms<-c(NB=NB,NQ=NQ,NG=NG,
         beta.mf=beta.mf,beta.fm=beta.fm,beta.mm=beta.mm,beta.ff=beta.ff,
         gamma=gamma,
         b=b,d=d,
         v=v,w=w,eps=eps,
         p=p,q=q)