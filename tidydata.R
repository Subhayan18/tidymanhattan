tidydata <- function(data, snp){

  # Add highlight and annotation information
  # Check if SNPs to be highlighted are declared
  if(missing(snp)) {snp = character(0)}

don <<- data %>% 
  
  # Compute chromosome size
  group_by(CHR) %>% 
  summarise(chr_len=max(BP)) %>% 
  
  # Calculate cumulative position of each chromosome
  mutate(tot=cumsum(chr_len)-chr_len) %>%
  select(-chr_len) %>%
  
  # Add this info to the initial dataset

  left_join(data, ., by=c("CHR"="CHR")) %>%
  
  # Add a cumulative position of each SNP
  arrange(CHR, BP) %>%
  mutate( Chromosome=BP+tot) %>%

  mutate(is_highlight=ifelse(SNP %in% snp, "yes", "no"))

# Then we need to prepare the X axis. Indeed we do not want to display the cumulative position of SNP in bp, but just show the chromosome name instead.
axisdf <<- don %>% group_by(CHR) %>% summarize(center=( max(Chromosome) + min(Chromosome) ) / 2 )
}

