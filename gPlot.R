library(tidyr)
library(dplyr)
library(ggplot2)

theme_set(theme_bw())
inf<-c("time","IB","IQ","IG")

base <- as.data.frame(soln[[1]][,inf])
base <- base %>% gather(key=Group,value=Num,-time)


for (i in scenario){

filename<-paste0(script.dir,"/test.gPlot.",i,".png")
sol.inf <- as.data.frame(soln[[i]][,inf])
inf.max<-apply(sol.inf[,2:4],2,max)

sol.plot <- sol.inf %>% gather(key=Group,value=Num,-time)

col.pal<-rep(c("blue","orchid1","red"),1)

print(
	ggplot(sol.plot, aes(x=time, y=Num))
	+ geom_line(aes(color=Group),linetype="dashed",size=1)
	+ scale_color_manual(values=col.pal)
	+ geom_hline(yintercept=inf.max,size=2,color=col.pal)
	#+ geom_line(data = sol.plot,aes(color=Group,linetype="dashed"),size=1)
)

}
