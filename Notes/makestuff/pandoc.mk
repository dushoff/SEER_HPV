%.html: %.md
	pandoc $< > $@