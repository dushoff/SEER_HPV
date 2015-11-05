status<-c(1,1,3)

with(as.data.frame(soln),{
	max.inf<-max(IG,IB,IQ)*1.1 # the factof for 1.1 is to provide nice plotting window
	plot(0,0,type="n",xlim<-c(0,tmax),ylim<-c(0,max.inf),
		las=1,
		xlab="time",
		ylab="Number of Cases")
	#lines(time,SB,col="blue",lty=status[1])
	lines(time,IB,col="blue",lty=status[2],lwd=3)
	#lines(time,VB,col="blue",lty=status[3])
	#lines(time,SQ,col="darkorchid1",lty=status[1])
	lines(time,IQ,col="darkorchid1",lty=status[2],lwd=3)
	#lines(time,VQ,col="darkorchid1",lty=status[3])
	#lines(time,SG,col="red",lty=status[1])
	lines(time,IG,col="red",lty=status[2],lwd=3)
	#lines(time,VG,col="red",lty=status[3])
	abline(v=vaccStart,col="gray")
	
	legend("topright",legend=c("Girls","Straight Boys","Queer Boys"),
		col=c("red","blue","darkorchid1"),
		lty=1,
		lwd=3
		)
})