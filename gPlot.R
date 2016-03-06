library(tidyr)
library(dplyr)
library(ggplot2)

theme_set(theme_bw())

# If incl.queer == false then remove these groups from the thing
if(plot.queer){
	inf<-c("time","IB","IQ","IG")
	col.pal<-rep(c("blue","orchid1","red"),1)
	labs<-c("hetero. boys","queer boys", "girls")
	anno.lab<-lapply(v.list,function(x) paste(c("v_h","v_q","v_g"),"=",x))
	xvals <- rep((tmax-(tmax-equil.time)/10)*month,3)
}else{
	inf<-c("time","IB","IG")
	col.pal<-rep(c("blue","red"),1)
	labs<-c("boys", "girls")
	anno.lab<-lapply(v.list,function(x) paste(c("v_b","v_g"),"=",x[c(1,3)]))
	xvals <- rep((tmax-(tmax-equil.time)/10)*month,2)
}

base <- as.data.frame(soln[[1]][,inf])
base <- base %>% gather(key=Group,value=Num,-time)




for (i in scenario){

	sol.inf <- as.data.frame(soln[[i]][,inf])
	inf.max<-apply(sol.inf[,inf[-1]],2,max)
	

	sol.plot <- sol.inf %>% gather(key=Group,value=Num,-time)

	# png(filename)
	print(
		ggplot(sol.plot, aes(x=time*month, y=Num))
		+ geom_line(aes(color=Group),linetype="dashed",size=1)
		+ scale_color_manual("Population\nGroup\n", 
			labels=labs,
			values=col.pal
		)
		+ ylab("Number Infected")
		+ xlab("time (years)")
		+ ggtitle("Reduction in HPV Prevalence\nUnder Vaccination Strategy")
		+ annotate("text",
			x=xvals,
			y=inf.max+max(inf.max)/20,
			label=anno.lab[[i]]
		)
		+ geom_hline(yintercept=inf.max,size=2,colour=col.pal)
		+ geom_vline(xintercept=vaccStart*month,size=1,color="gray",linetype=3)
		+ xlim((vaccStart*0.95)*month, tmax*month) #omits the first part of the function
	)
	# dev.off()
}
