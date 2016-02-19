# vaccination parameters

# v<-c(0,0,0.3)		#vaccination rates (boy, queer, girl)
# w<-c(0,0)			#rate of vaccination decay (boy, girl)
# eps<-c(1-0.9		# protection by vaccine 0 is perfect, 1 is no protection
vaccStart<-1500		# in months (125 years)

#List testing for solutions

	v.list<-list(
		c(0,0,0),
		c(0,0,0.5),
		c(0,0.1,0.5),
		c(0.5,0.5,0.5)
	)
	w.list<-list(
		c(0,0,0),
		c(0,0,0),
		c(0,0,0),
		c(0,0,0)
	)
	eps.list<-list(
		c(1-0.9,0,1-0.9),
		c(1-0.9,0,1-0.9),
		c(1-0.9,0,1-0.9),
		c(1-0.9,0,1-0.9)
	)

if(length(v.list)!=length(w.list) || 
		length(v.list)!=length(eps.list) ||
		length(w.list)!=length(eps.list)){
	warning("Number of scenarios for vaccination not the same\n
		Check the v.list, w.list, or eps.list")
}	
	