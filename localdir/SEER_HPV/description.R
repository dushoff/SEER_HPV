desc_columns <- c(1, 7, 11, 32, 41, 100)

descTab <- read.fwf(input_files[[1]]
	, widths=diff(desc_columns)
)

desc <- with(descTab, data.frame(
	startCol = V2
	, varName = V3
))

print(summary(desc))

# rdsave(desc)

