calc_index_l8<-function(dat.frame){
  ##This function assumes it is supplied with a data frame
  ##This function needs a data frame with Landsat 8 bands as columns
  ##The data frame should have the column names b1 for band1, etc.
  ##The function will return remote sensing indices: NDVI, a Simple Ratio, SAVI
  
  ndvi<-(dat.frame$b5-dat.frame$b4)/(dat.frame$b5+dat.frame$b4) 
  indices<-data.frame(ndvi=ndvi)
  indices$sr<-(dat.frame$b5/dat.frame$b4)
  indices$savi <- 1.5*(dat.frame$b5-dat.frame$b4) /
    (dat.frame$b5+dat.frame$b4+0.5)
  return(indices)
}