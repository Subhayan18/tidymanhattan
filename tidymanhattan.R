#tidydata(data=gwasResults)

tidymanhattan <- function(color,add.significance.line,levels,x.axis.font,y.axis.font){

	# Check if the tidydata has been run 
	if(exists("don") == "FALSE") stop(" No data available! \n Did you forget to use 'tidydata' ?", call. = FALSE)

	# Check if the colors has been declared
	if(missing(color)) { color <- c("dodgerblue", "dodgerblue4") }  
	print(paste0("colors are chosen as ", noquote(color[1]), " and ", noquote(color[2])))

	# Check if Significance lines are declared
	if(missing(levels)) { levels <- c(1.0e-05,5.0e-08) }
	if(length(levels)>2) stop(" More than two lines is a bit of overkill isn't it ?", call. = FALSE)
	levels.transformed = c(-log(levels[1],10), -log(levels[2],10))

	# Check if Significance lines are declared
	if(missing(add.significance.line)) { add.significance.line <- "TRUE" }
	if(add.significance.line == "TRUE") { if (length(levels) > 1) { 
		print(paste0("Line of significance drawn at ", levels[1], " and ", levels[2])) 
		} else { print(paste0("Line of significance drawn at ", levels[1])) }}

	# Check if X-axis fonts are declared
	if(missing(x.axis.font)) {x.axis.font = 14}
	print("X-axis title font set at 14")

	# Check if Y-axis fonts are declared
	if(missing(y.axis.font)) {y.axis.font = 14}
	print("Y-axis title font set at 14")

# Ready to make the plot using ggplot2:
ggplot(don, aes(x=Chromosome, y=-log10(P))) +
    
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

    # Custom the theme:
    theme_bw() +
    theme( 
      axis.text.x = element_text(size = x.axis.font,face = "bold"),
      axis.text.y = element_text(size = y.axis.font,face = "bold"),
      legend.position="none",
      panel.border = element_blank(),
      panel.grid.major.x = element_blank(),
      panel.grid.minor.x = element_blank(),
      # plot.title = element_text(size = 50),  
      axis.title.x = element_text(size = 20),  
      axis.title.y = element_text(size = 20)
    ) # +
    #ggtitle("Manhattan plot of XXXX ")
}
tiff("test.tiff")
tidymanhattan(add.significance.line=FALSE,levels = c(0.00003,1.0e-9))
dev.off()