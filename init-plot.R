status<-c(1,2,3)
max.pop<-max(NG,NB,NQ)

with(as.data.frame(soln),{
    plot(0,0,type="n",xlim<-c(0,tmax),ylim<-c(0,max.pop),
         las=1,
         xlab="time",
         ylab="Number of Cases")
    lines(time,SB,col="blue",lty=status[1])
    lines(time,IB,col="blue",lty=status[2])
    lines(time,VB,col="blue",lty=status[3])
    lines(time,SQ,col="darkorchid1",lty=status[1])
    lines(time,IQ,col="darkorchid1",lty=status[2])
    lines(time,VQ,col="darkorchid1",lty=status[3])
    lines(time,SG,col="red",lty=status[1])
    lines(time,IG,col="red",lty=status[2])
    lines(time,VG,col="red",lty=status[3])
    
})