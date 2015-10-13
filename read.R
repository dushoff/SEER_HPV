lastWidth <- 1
dat <- with(desc, read.fwf(input_files[[1]]
	, widths=c(diff(startCol), lastWidth)
	, col.names=varName
))

print(summary(dat))

# rdsave(dat)
