##This R script creates a fake remote sensing dataset with
##the same band names as Landsat 8
##the rnorm function is used for the dataset, and means/sds were set to mimic 
##known vegetation spectral profiles
##This script sources a function to calculate remote sensing indices
##This script then adds those columns onto the fake dataset

source("functions/calc_index_l8.r")
l8bands<-data.frame(band=c(1:6,7), 
                    wave=c(443,482, 562, 655, 865, 1609,2201)
                        )

dat<-data.frame(plot=letters[1:10], 
                b1=rnorm(n=10, mean=0.1, sd=0.05), 
                b2=rnorm(n=10, mean=0.1, sd=0.05), 
                b3=rnorm(n=10, mean=0.2, sd=0.08), 
                b4=rnorm(n=10, mean=0.13, sd=0.06), 
                b5=rnorm(n=10, mean=0.4, sd=0.1), 
                b6=rnorm(n=10, mean=0.25, sd=0.05), 
                b7=rnorm(n=10, mean=0.2, sd=0.05)
                )
##always useful to look at your data to play with, make sure it's not weird
plot(dat); summary(dat); str(dat)
color<-terrain.colors(n=nrow(dat))
plot(l8bands$wave, as.numeric(dat[1,2:8]), 
     ylab="wavelength (nm)",
     xlab= "%reflectance",
     ylim=c(0,0.6),
     type="b", pch=19, cex=1.5,
     col=color[1])
for (i in 2:nrow(dat)){
  points(l8bands$wave, as.numeric(dat[i,2:8]), pch=19, cex=1.5, col=color[i])
  lines(l8bands$wave, as.numeric(dat[i,2:8]), col=color[i])
}

indices<-calc_index_l8(dat)

dat<- cbind(dat, indices)

##see what we did, and did it work?
names(dat); summary(dat); str(dat)

