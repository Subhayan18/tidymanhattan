tidydata <- function(data, snp){

  # Add highlight and annotation information
  # Check if SNPs to be highlighted are declared
  if(missing(snp)) {snp = character(0)}

don <- data %>% 
  
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
}

