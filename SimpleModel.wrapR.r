# This file was generated automatically by wrapR.pl
# You probably don't want to edit it
load('parameter-test.RData')

pdfname <- "SimpleModel.Rout.pdf"
csvname <- "SimpleModel.Rout.csv"
pdf(pdfname)
# End RR preface

source('SimpleModel.R', echo=TRUE)
# Begin RR postscript

# If you see this in your terminal, the R script SimpleModel.wrap.R (or something it called) did not close properly
save.image(file="SimpleModel.RData")
