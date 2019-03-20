# tidymanhattan
Tidyverse supported R package for GWAS data visualization

**package is under development**

Idea here is to create functions that generates customizable plots for visualizing GWAS data

Included functions:

- ``tidydata()``

Tidies up a run of the mill GWAS summary statitics to a compressed tibble.

- ``tidymanhattan()``

Main plot function to create a Manhattan plot with the tidies up tibble.


```r
#require(tidyverse)
#require(ggrepel)
SNPs<-tidyregion(data=gwasResults,top_signal=SNPsOfInterest)
test<-tidydata(gwasResults,SNPs)
```


```r
tidymanhattan(test,highlight.snps=TRUE)
```

```
## [1] "colors are chosen as dodgerblue and dodgerblue4"
## [1] "Pandejo... Why U No choose color for highlighting SNP ? Lucky for you, I'm choosing Orange"
## [1] "Line of significance drawn at 1e-05 and 5e-08"
## [1] "X-axis text font set at 14"
## [1] "Y-axis text font set at 14"
## [1] "X axis title font set at 20"
## [1] "Y axis title font set at 20"
```

<img src="E:/Codes/tidymanhattan/knit/README_files/figure-html/unnamed-chunk-2-1.png" width="1344" />
