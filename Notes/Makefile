# 3SS
### Hooks for the editor to set the default target
current: target

target pngtarget pdftarget vtarget acrtarget: test.pdf 

##################################################################

# make files

Sources = Makefile .gitignore README.md stuff.mk LICENSE.md
include stuff.mk
# include $(ms)/perl.def

##################################################################

## Content

## Pushing from here does not work yet!

# Sources += $(wildcard *.tex)

Notes.pdf: Notes.tex

test.pdf: test.tex

test.Rout: test.R

######################################################################

### Makestuff

## Change this name to download a new version of the makestuff directory
# Makefile: start.makestuff

-include $(ms)/git.mk
-include $(ms)/visual.mk

-include $(ms)/wrapR.mk
-include $(ms)/newlatex.mk
