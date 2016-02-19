
msrepo = https://github.com/dushoff

gitroot = ./
export ms = $(gitroot)/makestuff

-include local.mk
-include $(gitroot)/local.mk
export ms = $(gitroot)/makestuff
-include $(ms)/os.mk

Makefile: $(ms) 

$(ms):
	cd $(dir $(ms)) && git clone $(msrepo)/$(notdir $(ms)).git

$(coursedirs): local.mk
	$(MAKE) -f stuff.mk $(gitroot)
	cd $(gitroot) && git clone $(courserepo)/$(notdir $@).git
	cp local.mk $@

local.mk:
	echo gitroot = $(shell pwd) > $@

$(gitroot):
	mkdir $@
