
QMap = function (df,v.names,n,sunits,skl,ftext,col1,xlab,ylab,pox,poy){
  
  pck =c('maps','mapplots','oceanmap','extrafont','ggplot2','marmap')
  if(length(pck[!pck %in% rownames(data.frame(installed.packages()))])>0){
    install.packages(pck[!pck %in% rownames(data.frame(installed.packages()))])
    lapply(pck[1:5],require,character.only=TRUE)
  } else {
    lapply(pck[1:5],require,character.only=TRUE)
  }
  
  if (dim(df)[1]>2){
    Lon1 = min(df[,1]); Lon2 = max(df[,1])
    Lat1 = min(df[,2]); Lat2 = max(df[,2]) 
    
    skl = ifelse(missing(skl),1,skl)
    v.names = ifelse(missing(v.names),colnames(df)[n],v.names)
    n = ifelse(missing(n),NULL,n)
    
    M = c()
    for (i in seq_along(colnames(df))){
      if(n==0){
        M = rep(1,(dim(df)[1]))
      } else if (is.null(n)) {
      M = rep(0,(dim(df)[1]))
    } else{
      M = as.numeric(df[,n]/skl)
    }
  }
  Bath = marmap::getNOAA.bathy(Lon1,Lon2,Lat1,Lat2, resolution = 1, keep = TRUE)
  autoplot(Bath,geom = c("r","c")) + marmap::scale_fill_etopo() +
    geom_point(aes(x = df[,1], y = df[,2], size = M),data = df, colour = col1) +
    theme(text=element_text(family = ifelse(missing(ftext),"Times New Roman",ftext), size = 14, color = "black"),
          axis.text = element_text(family = ifelse(missing(ftext),"Times New Roman",ftext), size = 14, color = "black"))+
    labs(x=ifelse(missing(xlab),"Longitude",xlab),
         y=ifelse(missing(ylab),"Latitude",ylab),
         fill = ifelse(missing(sunits),"Depth (m)",sunits),
         size = v.names) +
    geom_text(data = df, mapping = aes(x = df[,1], y = df[,2], label = rownames(df)),
              family = ifelse(missing(ftext),"Times New Roman",ftext), size = 3,
              position = position_nudge(x = ifelse(missing(pox),0,pox), y = ifelse(missing(poy),0,poy))) +
    theme(legend.title.align = 0.5)
  
} else {
  
  Min = signif(sapply(df,min),digits = 4)
  Max = signif(sapply(df,max),digits = 4)
  Bath = marmap::getNOAA.bathy(Min[1],Max[1],Min[2],Max[2], resolution = 1, keep = TRUE)
  autoplot(Bath,geom = c("r","c")) + 
    marmap::scale_fill_etopo() +
    labs(x = ifelse(missing(xlab),"Longitude",xlab),
         y = ifelse(missing(ylab),"Latitude",ylab)) + 
    theme(text = element_text(family = ifelse(missing(ftext),"Times New Roman",ftext), size = 14, color = "black"),
          axis.text = element_text(family = ifelse(missing(ftext),"Times New Roman",ftext), size = 14, color = "black")) +
    theme(legend.position = "none")
 }
}


save(QMap, file = "QuickMap.Rdata")
load("QuickMap.Rdata")