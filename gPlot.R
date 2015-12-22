library(tidyr)
library(dplyr)
library(ggplot2)

theme_set(theme_bw())
inf<-c("time","IB","IQ","IG")

base <- as.data.frame(soln[[1]][,inf])
base <- base %>% gather(key=Group,value=Num,-time)


for (i in scenario){

	#hardcode for now
	# filename <- paste0("~/Desktop/test.gPlot.",i,".png")
	#filename<-paste0(script.dir,"/test.gPlot.",i,".png")
	sol.inf <- as.data.frame(soln[[i]][,inf])
	inf.max<-apply(sol.inf[,2:4],2,max)

	sol.plot <- sol.inf %>% gather(key=Group,value=Num,-time)

	col.pal<-rep(c("blue","orchid1","red"),1)

	# png(filename)
	print(
		ggplot(sol.plot, aes(x=time*month, y=Num))
		+ geom_line(aes(color=Group),linetype="dashed",size=1)
		+ scale_color_manual("Population\nGroup\n", 
			labels=c("hetero. boys","queer boys", "girls"),
			values=col.pal
		)
		+ ylab("Number Infected")
		+ xlab("time (years)")
		+ ggtitle("Reduction in HPV Prevalence\nUnder Vaccination Stragety")
		+ annotate("text",
			x=rep((tmax-(tmax-equil.time)/10)*month,3),
			y=inf.max+max(inf.max)/20,
			label=paste(c("v_h","v_q","v_g"),"=",v.list[[i]])
		)
		+ geom_hline(yintercept=inf.max,size=2,color=col.pal)
		+ geom_vline(xintercept=vaccStart*month,size=1,color="gray",linetype=3)
		+ xlim(equil.time*month, tmax*month) #omits the first part of the function
	)
	# dev.off()
}
