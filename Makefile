### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: model.Rout 

##################################################################

# make files

Sources = Makefile .gitignore README.md LICENSE

######################################################################

ms = ../makestuff
# -include $(ms)/git.def

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

parameter-test.Rout: parameter-test.R
	$(run-R)
	
SimpleModel.Rout: parameter-test.Rout SimpleModel.R
	$(run-R)

model.Rout: parameter-test.Rout model.R
	$(run-R)

test.sim.Rout: SimpleModel.Rout sim.R
	$(run-R)

test.init-plot.Rout: test.sim.Rout init-plot.R
	$(run-R)

## Work on pipeline logic here; why do the new params depend on the previous sim?
vaccParam.Rout: test.sim.Rout vaccParam.R
	$(run-R)

vaccSim.Rout: vaccParam.Rout vaccSim.R
	$(run-R)

vaccPlot.Rout: vaccSim.Rout vaccPlot.R
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
