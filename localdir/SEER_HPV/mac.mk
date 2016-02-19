gitroot = ~/Desktop/SEER_HPV
CURDIR = ~/Desktop/SEER_HPV

%.go:
	$(MAKE) $*
	open $* &


