current: pngtarget

target: patchWork1.gplot.Rout 

pngtarget: patchWork1.gplot.Rout 
	$(MAKE) $<.png
	$(MAKE) $<.png.go

pdftarget: patchWork1.gplot.Rout 
	$(MAKE) $<.pdf
	$(MAKE) $<.pdf.go

vtarget: patchWork1.gplot.Rout 
	$(MAKE) $<.go

Sources += parameter-test.R SimpleModel.R sim.R init-plot.R

###########################################

SUPPRESS_EMPTY_ROUT_RULE=1

parameter-test.Rout: parameter-test.R
	$(run-R)
	
SimpleModel.Rout: parameter-test.Rout SimpleModel.R
	$(run-R)

test.sim.Rout: parameter-test.Rout SimpleModel.Rout sim.R
	$(run-R)

test.init-plot.Rout: test.sim.Rout parameter-test.Rout SimpleModel.Rout init-plot.R
	$(run-R)

	##################################################################

Sources.tgz: $(Sources)
	tar czf $@ $^

%.go:
	$(MAKE) $*
	xdg-open $* &