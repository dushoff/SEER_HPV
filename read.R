dat <- with(desc, read.fwf(input_files[[1]]
	, widths=c(diff(startCol), 1)
	, col.names=varName
))

print(summary(dat))

# rdsave(dat)
