# tidymanhattan
Tidyverse supported R package for GWAS data visualization

**package is under development**

Idea here is to create functions that generates customizable plots for visualizing GWAS data

Included functions:

- ``tidydata()``

Tidies up a run of the mill GWAS summary statitics to a compressed tibble.

- ``tidymanhattan()``

Main plot function to create a Manhattan plot with the tidies up tibble.

```{r}
#require(tidyverse)
#require(ggrepel)
SNPs<-tidyregion(data=gwasResults,top_signal=SNPsOfInterest)
test<-tidydata(gwasResults,SNPs)
```

```{r, fig.width=14,fig.height=8}
tidymanhattan(test,highlight.snps=TRUE)
```
