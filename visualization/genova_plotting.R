##########
# Plotting 3C experiments with GENOVA
# 12/7/23
# Noah Burget
##########
library(GENOVA2)
library(readr)
setwd('/mnt/data0/noah/3C_methods/3C-Methods/visualization')

######################
CHROM<-'1'
START<-160e6
END<-161e6
cool0hr <- '/mnt/data0/noah/3C_methods/3C-Methods/testing/s38_221203_Granta519EBF1KI_cl27_0hr_MicroC_25U_Nova_5000_unbalanced.cool'
cool6hr <- '/mnt/data0/noah/3C_methods/3C-Methods/testing/s42_221203_Granta519EBF1KI_cl27_6hr_MicroC_25U_Nova_5000_unbalanced.cool'
cool24hr <- '/mnt/data0/noah/3C_methods/3C-Methods/testing/s40_221203_Granta519EBF1KI_cl27_24hr_MicroC_25U_Nova_5000_unbalanced.cool'
######################

### Load data with GENOVA
cool.obj0hr <- GENOVA2::load_contacts(signal_path = cool0hr, # Path to .cool file
                          sample_name='0hr', # Sample name - this is what this sample will be called in downstream analyses
                          resolution = 10000, # Bin size of matrix
                          balancing = T, # Whether or not to apply balancing weights to contact counts 
                          scale_bp = NULL, # NULL = no internal coverage normalization
                          colour="green", # Color of sample - this is the color the same will appear as im downstream analysis
                          centromeres = NULL, # Dataframe of centromere locations. If null, centromeres are inferred from the longest stretch of empty bins                          
                          
                          ) 
cool.obj24hr <- GENOVA2::load_contacts(signal_path = cool24hr,
                                    sample_name='24hr',
                                    resolution = 10000,
                                    balancing = T,
                                    scale_bp = NULL,
                                    colour="red")
cool.obj6hr <- GENOVA2::load_contacts(signal_path = cool6hr,
                                       sample_name='6hr',
                                       resolution = 5000,
                                       balancing = T,
                                       scale_bp = NULL,
                                      colour="blue")

### Simple plotting of the matrix
GENOVA2::hic_matrixplot(exp1 = cool.obj0hr, # Contacts object
               chrom=CHROM,start=START,end=END, # Region to plot
               inferno = T, # Use the default color map 'inferno'
               cut.off = 30, # Max. contact value
               colour_bar = T) # Show legend

# Plot 2 different experiments on different sides (triangles) of matrix
GENOVA2::hic_matrixplot(exp1 = cool.obj0hr,
                        exp2 = cool.obj24hr,
                        coplot='dual', # DUAL = 2 matrices about main diag.
                        chrom=CHROM,start=START,end=END,
                        cut.off = 30,
                        colour_bar = T)
# Plot the difference of two matrices
GENOVA2::hic_matrixplot(exp1 = cool.obj0hr,
                        exp2 = cool.obj24hr,
                        coplot='diff', # DIFF = calculates differences between matrices
                        chrom=CHROM,start=START,end=END,
                        cut.off = 25,
                        colour_bar=T)

### Computing insulation score & plotting
insulation.0hrvs24hr <- GENOVA2::insulation_score(list(cool.obj0hr, cool.obj24hr), window=25)
visualise(insulation.0hrvs24hr,chr=CHROM,start=START,end=END,contrast=2)

### Deciding on window size for calculating insulation score -- "Domainograms"
id <- insulation_domainogram(list(cool.obj0hr, cool.obj24hr),
                             chrom=CHROM,
                             start=START,
                             end=END,
                             window_range=c(1,101), # Range of windows to calculate insulation score with
                             step=2) # Use every other window value (1,3,5,7,etc)
visualise(id)

### Calculate Relative Contact Probability
rcp.0vs24 <- RCP(explist = list(cool.obj0hr, cool.obj24hr), chromsToUse = '1')
visualise(rcp.0vs24)

### Pileup plots with predefined peak regions
loops <- read.table('s38_221203_Granta519EBF1KI_cl27_0hr_MicroC_25U_Nova.hg38.mapq_30.1000.mcool.mustache_5kb.dots.bedpe',sep='\t')
loops$V1 <- gsub("\\D" ,"", loops$V1)
loops$V4 <- gsub("\\D" ,"", loops$V4)
apa <- GENOVA2::APA(list('0hr'=cool.obj0hr, '24hr'=cool.obj24hr), 
                    bedpe=loops, 
                    dist_thres = c(200e3, Inf),
                    outlier_filter = c(0,1),
                    size_bin = 21)
visualise(apa)
quant.apa <- quantify(apa)
# Plot the fold change
boxplot(split(quant.apa$per_loop$background,
              f = quant.apa$per_loop$sample),
        col = c('red', 'darkgrey'), outline = F)
