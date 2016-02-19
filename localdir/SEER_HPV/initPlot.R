status<-c(1,1,3)

#set up in initial plot

with(as.data.frame(soln[[1]]),{
		max.inf<-max(IG,IB,IQ)
		#max.inf<-200000
	plot(0,0,type="n",xlim<-c(0,tmax),ylim<-c(0,max.inf),
		las=1,axes=F,xlab="",ylab="")
})

vacc.times<-seq(vaccStart,tmax,by=tmax/nstep)

for(i in scenario){
	with(as.data.frame(soln[[i]]),{
		lines(time,IB,col="blue",lty=i,lwd=3)
		lines(time,IQ,col="darkorchid1",lty=i,lwd=3)
		lines(time,IG,col="red",lty=i,lwd=3)
	})

}

abline(v=vaccStart,col="gray")

legend("topright",legend=c("Girls","Straight Boys","Queer Boys"),
	col=c("red","blue","darkorchid1"),
	lty=1,
	lwd=3
	)
with(as.data.frame(soln[[1]]),{
	monthToYear<-seq(0,tmax,by=52)
	max.inf<-signif(max(IG,IB,IQ),digits=3)
	popAxis<-seq(0,max.inf,by=max.inf/10)

	axis(1,monthToYear,(1:length(monthToYear)))
	mtext("time (years)",side=1,line=2.5)
	axis(2,popAxis)	
	mtext("Infected", side=2,line=2.5)
})


# 
# with(as.data.frame(soln[[1]]),{
# 	max.inf<-max(IG,IB,IQ)*1.1 # the factof for 1.1 is to provide nice plotting window
# 	plot(0,0,type="n",xlim<-c(0,tmax),ylim<-c(0,max.inf),
# 		las=1,
# 		xlab="time",
# 		ylab="Number of Cases")
# 	#lines(time,SB,col="blue",lty=status[1])
# 	lines(time,IB,col="blue",lty=status[2],lwd=3)
# 	#lines(time,VB,col="blue",lty=status[3])
# 	#lines(time,SQ,col="darkorchid1",lty=status[1])
# 	lines(time,IQ,col="darkorchid1",lty=status[2],lwd=3)
# 	#lines(time,VQ,col="darkorchid1",lty=status[3])
# 	#lines(time,SG,col="red",lty=status[1])
# 	lines(time,IG,col="red",lty=status[2],lwd=3)
# 	#lines(time,VG,col="red",lty=status[3])
# 	abline(v=vaccStart,col="gray")
# 	
# 	legend("topright",legend=c("Girls","Straight Boys","Queer Boys"),
# 		col=c("red","blue","darkorchid1"),
# 		lty=1,
# 		lwd=3
# 		)
# })