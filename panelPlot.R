# panel plot
# 

groups<-c("het men","queer men","women")

#I'm not sure what I use this for yet...
status<-c(1,1,3)

#set up in initial plot

par(mfrow=c(ceiling(length(scenario)/2),2))

for(i in scenario){

	vacc.times<-seq(vaccStart,tmax/year,length.out=1+nstep)

	with(as.data.frame(soln[[1]]),{
			max.inf<-max(IG,IB,IQ)
			#max.inf<-200000
		plot(0,0,type="n",xlim<-c(0,tmax/year),ylim<-c(0,max.inf),
			las=1,axes=TRUE,xlab="",ylab="")
		lines(time/year,IB,col="blue",lty=1,lwd=3)
		lines(time/year,IQ,col="orchid1",lty=1,lwd=3)
		lines(time/year,IG,col="red",lty=1,lwd=3)
		
		text(max(time/year)*0.8,c(max.inf,max.inf*0.9,max.inf*0.8,max.inf*0.7)*0.6,
			labels=c("Vaccine Rates",paste(groups,v.list[[i]],sep="=")),
			cex=0.6
		)
	})

	with(as.data.frame(soln[[i]]),{
		lines(time/year,IB,col="blue",lty=i,lwd=3)
		lines(time/year,IQ,col="darkorchid1",lty=i,lwd=3)
		lines(time/year,IG,col="red",lty=i,lwd=3)
	})

	abline(v=vaccStart,col="gray")

	legend("topright",legend=c("Girls","Straight Boys","Queer Boys"),
		col=c("red","blue","darkorchid1"),
		lty=1,
		lwd=3,
		cex=0.5
		)
	with(as.data.frame(soln[[1]]),{
		monthToYear<-seq(0,tmax/year,by=52)
		max.inf<-signif(max(IG,IB,IQ),digits=3)
		popAxis<-seq(0,max.inf,by=max.inf/10)

		# axis(1,monthToYear,(1:length(monthToYear)))
		mtext("time (years)",side=1,line=2.5)
		# axis(2,popAxis)	
		mtext("Infected", side=2,line=2.5)
	})


}
