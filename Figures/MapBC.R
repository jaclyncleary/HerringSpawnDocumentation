###############################################################################
# 
# Author:       Matthew H. Grinnell
# Affiliation:  Pacific Biological Station, Fisheries and Oceans Canada (DFO) 
# Group:        Offshore Assessment, Aquatic Resources, Research, and Assessment
# Address:      3190 Hammond Bay Road, Nanaimo, BC, Canada, V9T 6N7
# Contact:      e-mail: matt.grinnell@dfo-mpo.gc.ca | tel: (250) 756.7055
# Project:      Herring
# Code name:    MapBC.R
# Version:      1.0
# Date started: Apr 21, 2017
# Date edited:  Apr 21, 2017
# 
# Overview: 
# Make the coastwide plot of herring sections and statistical areas
# 
# Requirements: 
# The saved R image (*.RData), from the script 'Summary.R' for one of the BC
# Pacific herring locations.
# 
# Notes: 
# 
###############################################################################


########################
##### Housekeeping #####
########################

# General options
rm( list=ls( ) )      # Clear the workspace
sTime2 <- Sys.time( )  # Start the timer
graphics.off( )       # Turn graphics off

# Install missing packages and load required packages (if required)
UsePackages <- function( pkgs, locn="https://cran.rstudio.com/" ) {
  # Reverse the list 
  rPkgs <- rev( pkgs )
  # Identify missing (i.e., not yet installed) packages
  newPkgs <- rPkgs[!(rPkgs %in% installed.packages( )[, "Package"])]
  # Install missing packages if required
  if( length(newPkgs) )  install.packages( newPkgs, repos=locn )
  # Loop over all packages
  for( i in 1:length(rPkgs) ) {
    # Load required packages using 'library'
    eval( parse(text=paste("suppressPackageStartupMessages(library(", rPkgs[i], 
                "))", sep="")) )
  }  # End i loop over package names
}  # End UsePackages function

# Make packages available
UsePackages( pkgs=c("tidyverse", "scales") )


#################### 
##### Controls ##### 
####################     

# Location of the saved R image
locImage <- "C:/Grinnell/Workspace/Herring/DataSummaries/WCVI"


######################
##### Parameters #####
######################




################
##### Data #####
################

# Load a saved workspace
load( file=file.path(locImage, "Image.RData") )


################ 
##### Main ##### 
################     




###################
##### Figures #####
###################

# Plot the BC coast and regions
BCMap <- ggplot( data=shapes$landAllCropDF, aes(x=Eastings, y=Northings) ) +
  geom_polygon( data=shapes$landAllCropDF, aes(group=group),
                fill="lightgrey" ) +
  geom_point( data=shapes$extAllDF, colour="transparent" ) +
  geom_path( data=shapes$regAllDF, aes(group=Region), size=0.75, 
             colour="black", linetype="dashed" ) +
  geom_path( data=shapes$saAllDF, aes(group=StatArea), size=0.25, 
             colour="black" ) +
  geom_label( data=shapes$regCentDF, alpha=0.5, aes(label=Region) ) +
  annotate( geom="text", x=1100000, y=800000, label="British\nColumbia",
            size=5 ) +
  annotate( geom="text", x=650000, y=550000, label="Pacific\nOcean", 
            size=5 ) +
  coord_equal( ) +
  labs( x="Eastings (km)", y="Northings (km)", caption=geoProj ) +
  scale_x_continuous( labels=function(x) comma(x/1000), expand=c(0, 0) ) + 
  scale_y_continuous( labels=function(x) comma(x/1000), expand=c(0, 0) ) +
  myTheme +
  theme_bw( ) +
  ggsave( filename="BC.pdf", width=figWidth, 
          height=min(8, 5.75/shapes$xyAllRatio) )


##################
##### Tables #####
##################




##################
##### Output #####
##################

## Save the workspace image 
#save.image( file="MapBC.R.image.RData" ) 


############### 
##### End ##### 
############### 

# Print end of file message and elapsed time
cat( "End of file MapBC.R: ", sep="" ) ;  print( Sys.time( ) - sTime2 )
