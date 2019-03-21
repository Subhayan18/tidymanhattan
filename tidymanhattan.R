tidymanhattan <- function(data, color, add.significance.line, levels, x.axis.font, y.axis.font,
				highlight.snps, highlight.col, title, x.axis.title.font, y.axis.title.font,
				plot.title.font){

	# Check if the tidydata has been run 
	if(missing(data)) stop(" No data available! 
		\n Did you just forget to use 'tidydata' ? Oh God! ", call. = FALSE)
	# Check if the declared data has proper dimension
	if(is.null(dim(data)) == "TRUE") stop(" No data available! 
		\n Why on earth did you declare a data with no dimension ? 
		\n That's it. I'm out!", call. = FALSE)

	# Check if the colors has been declared
	if(missing(color)) { color <- c("dodgerblue", "dodgerblue4") }  
	print(paste0("colors are chosen as ", noquote(color[1]), " and ", noquote(color[2])))

	# Check if Significance lines are declared
	if(missing(levels)) { levels <- c(1.0e-05,5.0e-08) }
	if(length(levels)>2) stop(" More than two lines is a bit of overkill isn't it ?", call. = FALSE)
	levels.transformed = c(-log(levels[1],10), -log(levels[2],10))

	# Check if Highlighted SNPs are declared
	if(missing(highlight.snps)) { highlight.snps <- "FALSE" }

	# Check if the colors of Highlighted SNPs are declared
	if(highlight.snps == "TRUE" & missing(highlight.col)) { highlight.col <- "orange3" } 
	print("Pandejo... Why U No choose color for highlighting SNP ? Lucky for you, I'm choosing Orange")

	# Check if Significance lines are declared
	if(missing(add.significance.line)) { add.significance.line <- "TRUE" }
	if(add.significance.line == "TRUE") { if (length(levels) > 1) { 
		print(paste0("Line of significance drawn at ", levels[1], " and ", levels[2])) 
		} else { print(paste0("Line of significance undeclared! Default drawn at ", levels[1])) }}

	# Check if X-axis fonts are declared
	if(missing(x.axis.font)) {x.axis.font = 14}
	print(paste0("X-axis text font set at ",x.axis.font))

	# Check if Y-axis fonts are declared
	if(missing(y.axis.font)) {y.axis.font = 14}
	print(paste0("Y-axis text font set at ",y.axis.font))

	# Check if X axis title font are declared
	if(missing(x.axis.title.font)) {x.axis.title.font = 20}
	print(paste0("X axis title font set at ",x.axis.title.font))

	# Check if Y axis title font are declared
	if(missing(y.axis.title.font)) {y.axis.title.font = 20}
	print(paste0("Y axis title font set at ",y.axis.title.font))

	# Check if plot.title.font fonts are declared
	if(!missing(title) & missing(plot.title.font)) {plot.title.font = 40;
	print(paste0("Main title font set at ",plot.title.font))}
	if(missing(title) & missing(plot.title.font)) {plot.title.font = 40}

	# Then we need to prepare the X axis. 
	# Indeed we do not want to display the cumulative position of SNP in bp, but just show the chromosome name instead.

	axisdf <- data %>% group_by(CHR) %>% summarize(center=( max(Chromosome) + min(Chromosome) ) / 2 )

# Ready to make the plot using ggplot2:
ggplot(data, aes(x=Chromosome, y=-log10(P))) +
    
	# Show all points
	geom_point( aes(color=as.factor(CHR)), alpha=0.8, size=1.3) +
	scale_color_manual(values = rep(c(color[1], color[2]), 22 )) +

	# custom X axis:
	scale_x_continuous( label = axisdf$CHR, breaks= axisdf$center, expand = c(0, 0)) +
	scale_y_continuous(expand = c(0, 0) ) +     # remove space between plot area and x axis

	# Add line of significance
	{if (add.significance.line == "TRUE") geom_hline(yintercept=levels.transformed[1], color = "blue4", size=1, linetype = "solid")} +
	{if (add.significance.line == "TRUE" & length(levels) > 1)
		 geom_hline(yintercept=levels.transformed[2], color = "brown3", size=1, linetype = "solid")} +

	# Add highlighted points
	{if (highlight.snps == "TRUE") geom_point(data=subset(data, is_highlight=="yes"), color=highlight.col, size=2)}+
    
    # Custom the theme:
    theme_bw() +
    theme( 
      axis.text.x = element_text(size = x.axis.font,face = "bold"),
      axis.text.y = element_text(size = y.axis.font,face = "bold"),
      legend.position="none",
      panel.border = element_blank(),
      panel.grid.major.x = element_blank(),
      panel.grid.minor.x = element_blank(),
      plot.title = element_text(size = plot.title.font),  
      axis.title.x = element_text(size = x.axis.title.font),  
      axis.title.y = element_text(size = x.axis.title.font)
    ) +
    {if (!missing(title)) ggtitle(title)}
}
