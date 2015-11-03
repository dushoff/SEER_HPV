start<-round((nstep+1)*0.7)

something<-c(0,1,1)

with(as.data.frame(soln),{
    plot(0,0,type="n",xlim<-c(time[start],tmax2),ylim<-c(0,400000),
         las=1)
    lines(time,IB,col="blue",lty=2)
    lines(time,IQ,col="darkorchid1",lty=2)
    lines(time,IG,col="red",lty=2)
})


with(as.data.frame(soln.vacc),{
    abline(v=tmax,col="gray")
    #lines(time,SB,col="blue",lty=status[1])
    lines(time,IB,col="blue",lty=status[2])
    #lines(time,VB,col="blue",lty=status[3])
    #lines(time,SQ,col="darkorchid1",lty=status[1])
    lines(time,IQ,col="darkorchid1",lty=status[2])
    #lines(time,VQ,col="darkorchid1",lty=status[3])
    #lines(time,SG,col="red",lty=status[1])
    lines(time,IG,col="red",lty=status[2])
    #lines(time,VG,col="red",lty=status[3])
    
})