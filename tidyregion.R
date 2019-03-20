tidyregion <- function(data, top_signal,window){

	# Check if the data is declared 
	if(missing(data)) stop(" No data available! ", call. = FALSE)

	# Check if the top_signal is decalred 
	if(missing(top_signal)) stop(" No top_signal is declared. Are you out of SNPs ?", call. = FALSE)

	# Check if window is decalred
	if(missing(window)) { window = 500000 }

signal_coord <- data[,c('CHR','BP','SNP')] %>%
	filter(SNP %in% top_signal) %>%
	mutate(left.window = BP - window) %>%
	mutate(right.window = BP + window) %>%
	select(CHR,left.window,right.window)

snp_loc<-noquote(as.character(subset(data,data$CHR == signal_coord$CHR[1] & 
	data$BP > signal_coord$left.window[1] & data$BP < signal_coord$right.window[1])$SNP))
for (i in 2 : nrow(signal_coord)){
  snp_loc<-c(snp_loc,noquote(as.character(subset(data,data$CHR == signal_coord$CHR[i] 
	& data$BP > signal_coord$left.window[i] & data$BP < signal_coord$right.window[i])$SNP))) 
}
snp_loc<-noquote(as.character(unique(snp_loc)))
}