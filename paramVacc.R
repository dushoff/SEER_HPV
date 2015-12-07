# vaccination parameters

# v<-c(0,0,0.3)		#vaccination rates (boy, queer, girl)
# w<-c(0,0)			#rate of vaccination decay (boy, girl)
# eps<-c(1-0.9		# protection by vaccine 0 is perfect, 1 is no protection
vaccStart<-1500		# in months (125 years)

#List testing for solutions
v.list<-list(
	c(0,0,0),
	c(0,0,0.3),
	c(0,0,0.5)
)
w.list<-list(
	c(0,0,0),
	c(0,0,0),
	c(0,0,0)
)
eps.list<-list(
	rep(1-0.9,3),
	rep(1-0.9,3),
	rep(1-0.9,3)
)