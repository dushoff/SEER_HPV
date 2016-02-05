### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: base.gplots.pdf 

##################################################################

# make files

Sources = Makefile .gitignore README.md LICENSE mac.mk

######################################################################

ms = ../makestuff
# -include $(ms)/git.def
-include $(ms)/os.mk

Dropbox = ~/Dropbox
-include ../local.def

##################################################################

Sources += $(wildcard *.R)

## description reads the Positions file and saves a data frame called desc, which describes the variable names and widths
Sources += SEERPositions.txt
description.Rout: SEERPositions.txt description.R
	$(run-R)

######################################################################

# Crunching. Current idea is to put small stuff here, for convenience, and big stuff in Dropbox, for less remaking.

# It is OK to leave confidential files in the repo _directory_, as long as we don't push them to the repo.

output = $(Dropbox)/HPV_vacc_boys/SEER_output

$(output):
	mkdir $@

data = $(Dropbox)/HPV_vacc_boys/SEER_1973_2012_TEXTDATA/incidence/yr1973_2012.seer9

example: $(output)/COLRECT.read.Rout
$(output)/COLRECT.read.Rout: description.Rout $(data)/COLRECT.TXT read.R
	$(run-R)

## Make a smaller data set; right now it picks 1/500th of the data at random
COLRECT.sample.TXT: $(data)/COLRECT.TXT
%.sample.TXT: $(data)/COLRECT.TXT
	perl -nE "BEGIN{srand(42)} print if rand()<1/500" $< > $@

COLRECT.sample.Rout: description.Rout COLRECT.sample.TXT read.R
%.sample.Rout: description.Rout %.sample.TXT read.R
	$(run-R)

seerdic:
	$(MAKE) /home/dushoff/Dropbox/HPV_vacc_boys/SEER_1973_2012_TEXTDATA/incidence/seerdic.pdf.go

######################################################################

############## Sim stuff

### Older stuff

parameterTest.Rout: parameterTest.R
	$(run-R)

test.initPlot.Rout: test.sim.Rout initPlot.R
	$(run-R)

model.Rout: parameterTest.Rout model.R
	$(run-R)

## Transmission parameters

base.men.Rout:

RMatrixFunction.Rout: RMatrixFunction.R
	$(run-R)

base.Trans.Rout: RMatrixFunction.Rout base.Trans.R
	$(run-R)

paramVacc.Rout: base.Trans.Rout paramVacc.R
	$(run-R)

base.%.Rout: base.Trans.Rout paramVacc.Rout base.%.R
	$(run-R)

naive.model.Rout: naiveTrans.Rout paramVacc.Rout simpleModel.R

## Terminology.
## Base refers to a set of parameters, not to an implementation.
## Current base would be base.queers...
## If we collapse men, we would have base.men...
## If we eliminate diagonals, we would have base.noQueers...

## If we eventually tune, we're going to need redudancy, as in
## mBase.men... is tuned to men and applied to men.

## Pipeline: make betas from mixing and transmission assumptions
## Beta now refers to the matrix that we're going to use to transmit; it includes rate of effective mixing (contact plus partner switching), and transmission probabilities (-ish), which we will call taus.

## .queer is the default scenario
## .men lumps the two groups of men together
## .noQueer ignores queer behaviour entirely
scen = queer men noQueer
base_scen = $(scen:%=base.%)

base.queer.model.Rout: base.queer.Rout simpleModel.R
%.model.Rout: %.Rout simpleModel.R
	$(run-R)

base.gplots.pdf: $(base_scen:%=%.gPlot.Rout.pdf)
	$(pdfcat)

base.queer.sim.Rout: queer.model.Rout sim.R
%.sim.Rout: %.model.Rout sim.R
	$(run-R)

base.queer.panelPlot.Rout: queer.sim.Rout panelPlot.R
%.panelPlot.Rout: %.sim.Rout panelPlot.R
	$(run-R)

base.queer.indiPlot.Rout: queer.sim.Rout indiPlot.R
%.indiPlot.Rout: %.sim.Rout indiPlot.R
	$(run-R)

base.queer.gPlot.Rout: queer.sim.Rout gPlot.R
%.gPlot.Rout: %.sim.Rout gPlot.R
	$(run-R)

Sources += SEERdicDescription.txt

##################################################################

### Makestuff

gitroot=../

Makefile: start.makestuff

repo = https://github.com/dushoff
%.makestuff:
	-cd $(dir $(ms)) && mv -f $(notdir $(ms)) .$(notdir $(ms))
	cd $(dir $(ms)) && git clone $(repo)/$(notdir $(ms)).git
	-cd $(dir $(ms)) && rm -rf $(ms) .$(notdir $(ms))
	touch $@

-include local.mk
-include $(gitroot)/local.mk
-include $(ms)/git.mk

-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
