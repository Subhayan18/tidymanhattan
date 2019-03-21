setwd("E:\\Codes\\tidymanhattan")
#load(file=paste(find.package('tidymanhattan'),"/data/gwasResults.rda",sep=""))
#load(file=paste(find.package('tidymanhattan'),"/data/SNPsOfInterest.rda",sep=""))

load(file=paste(getwd(),"/data/gwasResults.rda",sep=""))
load(file="E:\\Codes\\tidymanhattan\\data\\SNPsOfInterest.rda")

require(devtools)
require(roxygen2)
#require(tidyverse)
#require(ggrepel)
install(tidymanhattan)

SNPs<-tidyregion(data=gwasResults,top_signal=SNPsOfInterest)
test<-tidydata(gwasResults,SNPsOfInterest)
tidymanhattan(test,highlight.snps=TRUE,title="Bleh")

##==========USEFUL===========##
use_data(data)
roxygen2::install('tidymanhattan')

