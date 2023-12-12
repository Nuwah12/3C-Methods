##########
# Perform APA and view results with GENOVA
# 12/12/23
# Noah Burget
##########
library(GENOVA2)

## Your objects should be stored in a named list 'explist'
## Let's define some parameters for the plots
CHROM <- '8' # Chromosome name to plot
START <-  131e6# Start position to plot
END <-  132e6# End position to plot
SCORE.LIMS <- c(0,20) # The range of scores to plot
DIFF.LIMS <- c(-10,10) # The range of differences to plot when plotting difference matrices
plot.legend <- TRUE
dist.thresh <- c(200e3, Inf) # Range of loop sizes to include in aggregate calculation
outlier.filter <- c(0,1) # Quantiles of data to be used as thresholds. [0,1] performs no outlier filtering
metric <- 'lfc' # Metric to use for aggregate difference calculation: 'diff' for subtraction, 'lfc' for log2 fold changes

## Define data to be plotted
c1 <- explist[[1]]
c2 <- explist[[2]]
# Or, you can use the explist to plot multiple

## For APA, we need a set of regions to aggregate.
# The dataframe should be in BEDPE (chrom1,start1,end1,chrom2,start2,end2) format
loops <- ''

########## Perform APA ##########
apa.res <- GENOVA2::APA(c1,
                        dist_thresh = dist.thresh,
                        bedpe=loops,
                        outlier_filter = outlier_filter)
### Visualize the results of APA
visualise(apa.res, 
          title = 'Aggregate Peak Analysis',
          metrix = metric)

