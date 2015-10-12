### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: COLRECT.sample.Rout 

##################################################################

# make files

Sources = Makefile .gitignore README.md LICENSE

######################################################################

ms = ../makestuff
# -include $(ms)/git.def

data = ~/Dropbox/HPV_vacc_boys/SEER_1973_2012_TEXTDATA/incidence/yr1973_2012.seer9 

##################################################################

Sources += $(wildcard *.R)

Sources += SEERPositions.txt
description.Rout: SEERPositions.txt description.R
	$(run-R)

%.read.Rout: description.Rout $(data)/%.TXT read.R
	$(run-R)

COLRECT.small.TXT: /home/dushoff/Dropbox/HPV_vacc_boys/SEER_1973_2012_TEXTDATA/incidence/yr1973_2012.seer9/COLRECT.TXT
	perl -nE "BEGIN{srand(42)} print if rand()<1/500" $< > $@

COLRECT.sample.Rout: description.Rout COLRECT.small.TXT read.R
	$(run-R)

%.sample.Rout: description.Rout %.small.TXT read.R
	$(run-R)

COLRECT.read.Rout: description.Rout /home/dushoff/Dropbox/HPV_vacc_boys/SEER_1973_2012_TEXTDATA/incidence/yr1973_2012.seer9/COLRECT.TXT read.R
	$(run-R)

### Makestuff

Makefile: start.makestuff

repo = https://github.com/dushoff
%.makestuff:
	-cd $(dir $(ms)) && mv -f $(notdir $(ms)) .$(notdir $(ms))
	cd $(dir $(ms)) && git clone $(repo)/$(notdir $(ms)).git
	-cd $(dir $(ms)) && rm -rf $(ms) .$(notdir $(ms))
	touch $@

-include $(ms)/local.mk
-include local.mk
-include $(ms)/git.mk

-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
# -include $(ms)/oldlatex.mk
