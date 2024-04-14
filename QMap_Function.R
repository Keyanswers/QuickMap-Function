QMap = function (df,vnames,n,sunits,ftext,col1,xlab,ylab,sta, pox, poy, Apos, Bpos){
  
  pck =c('maps','mapplots','oceanmap','extrafont','ggplot2','ggfortify','ggspatial','sf','marmap')
  if(length(pck[!pck %in% rownames(data.frame(installed.packages()))])>0){
    install.packages(pck[!pck %in% rownames(data.frame(installed.packages()))])
    lapply(pck[1:8],require,character.only=TRUE)
  } else {
    lapply(pck[1:8],require,character.only=TRUE) 
  }
  
  Lon1 = min(df[,1]); Lon2 = max(df[,1])
  Lat1 = min(df[,2]); Lat2 = max(df[,2])
  
  Bath = marmap::getNOAA.bathy(Lon1,Lon2,Lat1,Lat2, resolution = 1, keep = TRUE)
  
  Df = na.omit(df)
  n = ifelse(missing(n),0,n)
  vnames = ifelse(missing(vnames),colnames(Df)[n],vnames)
  
  if (missing(sta)){
    sta = rownames(Df)
  } else {
    sta = as.character(Df[,sta])
    rownames(Df) = sta
  }
  
  M = c()
  for (i in seq_along(colnames(Df))){
    if(n==0){
      M = rep(2.5,(dim(Df)[1]))
    } else{
      M = as.numeric(Df[,n])
    }
  }
  
  if (dim(Df)[1]>2 & mean(M,na.rm=TRUE)==2.5){
    
    marmap::autoplot.bathy(Bath,geom = c("r","c")) + marmap::scale_fill_etopo() +
      geom_point(aes(x = Df[,1], y = Df[,2], size = factor(M, labels=" ")),data = Df, colour = ifelse(missing(col1),"black",col1)) +
      theme(text=element_text(family = ifelse(missing(ftext),"Times New Roman",ftext), size = 16, color = "black"),
            axis.text = element_text(family = ifelse(missing(ftext),"Times New Roman",ftext), size = 16, color = "black")) +
      labs(x=ifelse(missing(xlab),"Longitude",xlab),
           y=ifelse(missing(ylab),"Latitude",ylab),
           fill = ifelse(missing(sunits),"Meters (m)",sunits),
           size = ifelse(is.na(vnames),"Stations",vnames))+
      geom_text(data = Df, mapping = aes(x = Df[,1], y = Df[,2], label = sta),
                family = ifelse(missing(ftext),"Times New Roman",ftext), size = 4,
                position = position_nudge(x = ifelse(missing(pox),0,pox), y = ifelse(missing(poy),-0.09,poy))) +
      theme(legend.title = element_text(hjust = 0.5)) +
      annotation_north_arrow(location = ifelse(missing(Apos),"tl",Apos),
                             which_north = "true",
                             pad_x = unit(0.2, "cm"),
                             pad_y = unit(0.2, "cm"),
                             style = north_arrow_nautical,
                             width = unit(2, "cm"),
                             height = unit(2,"cm")) + 
      annotation_scale(text_cex = 1.2, location = ifelse(missing(Bpos),"bl",Bpos)) +
      coord_sf(crs = 4326)
    
  } else if (dim(Df)[1]>2 & mean(M,na.rm=TRUE)!=2.5) {
      
    marmap::autoplot.bathy(Bath,geom = c("r","c")) + marmap::scale_fill_etopo() +
      geom_point(aes(x = Df[,1], y = Df[,2], size = M),data = Df, colour = ifelse(missing(col1),"black",col1)) +
      theme(text=element_text(family = ifelse(missing(ftext),"Times New Roman",ftext), size = 16, color = "black"),
            axis.text = element_text(family = ifelse(missing(ftext),"Times New Roman",ftext), size = 16, color = "black"))+
      labs(x=ifelse(missing(xlab),"Longitude",xlab),
           y=ifelse(missing(ylab),"Latitude",ylab),
           fill = ifelse(missing(sunits),"Meters (m)",sunits),
           size = vnames) +
      geom_text(data = Df, mapping = aes(x = Df[,1], y = Df[,2], label = sta),
                family = ifelse(missing(ftext),"Times New Roman",ftext), size = 4,
                position = position_nudge(x = ifelse(missing(pox),0,pox), y = ifelse(missing(poy),0,poy))) +
      theme(legend.title = element_text(hjust = 0.5)) +
      annotation_north_arrow(location = ifelse(missing(Apos),"tl",Apos),
                             which_north = "true",
                             pad_x = unit(0.2, "cm"),
                             pad_y = unit(0.2, "cm"),
                             style = north_arrow_nautical,
                             width = unit(2, "cm"),
                             height = unit(2,"cm")) + 
      annotation_scale(text_cex = 1.2, location = ifelse(missing(Bpos),"bl",Bpos)) +
      coord_sf(crs = 4326)
    
  } else {
    
    Min = signif(sapply(Df,min),digits = 4)
    Max = signif(sapply(Df,max),digits = 4)
    Bath = marmap::getNOAA.bathy(Min[1],Max[1],Min[2],Max[2], resolution = 1, keep = TRUE)
    marmap::autoplot.bathy(Bath,geom = c("r","c")) + 
      marmap::scale_fill_etopo() + 
      labs(x = ifelse(missing(xlab),"Longitude",xlab),
           y = ifelse(missing(ylab),"Latitude",ylab),
           fill = ifelse(missing(sunits),"Meters (m)",sunits)) + 
      theme(text = element_text(family = ifelse(missing(ftext),"Times New Roman",ftext), size = 14, color = "black"),
            axis.text = element_text(family = ifelse(missing(ftext),"Times New Roman",ftext), size = 14, color = "black")) +
      theme(legend.title = element_text(hjust = 0.5)) +
      annotation_north_arrow(location = ifelse(missing(Apos),"tl",Apos),
                             which_north = "true",
                             pad_x = unit(0.2, "cm"),
                             pad_y = unit(0.2, "cm"),
                             style = north_arrow_nautical,
                             width = unit(2, "cm"),
                             height = unit(2,"cm")) + 
      annotation_scale(text_cex = 1.2, location = ifelse(missing(Bpos),"bl",Bpos)) +
      coord_sf(crs = 4326)
  }
}
save(QMap, file="QuickMap.Rdata")
load("QuickMap.Rdata")
