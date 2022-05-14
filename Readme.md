
# QuickMap Function (QMap)

The QuickMap function was written to provide a tool for plotting data on maps, taking into account the altimetry and bathymetry.The code works using functions from the 'maps','mapplots','oceanmap','extrafont','ggplot2', and 'marmap' packages. All of these packages are installed and loaded using the function or by running it empty. The data frame must have longitude and latitude data in the first and second columns, respectively.

You two different maps using a data frame:

Use a 2x2 data frame with the extreme values of longitude and latitude to get a Map with legend in Meters(m). In addition, this map will show "Longitude" and "Latitude" as axes labels (single map example).

If you have a data frame with more than two columns, you will get a map with a legend in Meters (m), Longitude, and Latitude as axes labels. The stations will be indicated by black dots with rownames as station codes below each dot. Also, will provide "stations" as a label (basic map example).


#### This function has 11 parameters:

* df: This is the data frame.

* vnames: This argument in data frames without values of variables has "Stations" as the default value. It must be a character.

* n: This is the number of the column of the variable you want to represent on the map.

* sunits: The default value for units of altimetry and bathymetry is Meters (m). It must a character.

* ftext: This is the font text selected for all labels. The default value is "Times New Roman". The fonts could be selected from the list provided through the function fonts().

* col1: The color of the dots for stations / variables is black by default.

* xlab: This must be a character. The default value for the x axis label is "Longitude".

* ylab: This must be a character. The default value for the y axis label is "Latitude".

* sta: It is the number of the column with the station codes, if it is absent the function will be use the rownames as station codes.

* pox: This argument provides the horizontal position of the station codes.

* poy: This argument provides the vertical position of the station codes.

Note: If this is the first time you are using the extrafont package, you need to import the fonts registered in the system.
 
      
##### The following examples show you the possible maps that can be obtained through the QMap function. The stringi package is required.

```{r}
load("QuickMap.Rdata")

# require(stringi)

set.seed(125)

Dat = data.frame(Lon = runif(40,-18, -4), Lat = runif(40,36, 45))
Dat$Sta = stringi::stri_rand_strings(40,3,'[A-Za-z0-9]')
table(Dat$Sta)

set.seed(125)
Dat = data.frame(Lon = runif(40,-17, -5), Lat = runif(40,36, 40))
Dat$Sta = stringi::stri_rand_strings(40,2,'[a-z]')
Dat = Dat[order(-Dat$Lon),]

Dat$var = c()
for(i in seq_along(Dat$Lon)){
  if(Dat$Lon[i] < -9.5){
    Dat$var[i] = runif(40, 3600, 27000)
  } else {
    Dat$var[i] = NA
  }
}

Dat$var2 = c()
for(i in seq_along(Dat$Lon)){
  if(Dat$Lon[i] < -9.5){
    Dat$var2[i] = runif(40, 10, 57000)
  } else {
    Dat$var2[i] = NA
  }
}
head(Dat)
str(Dat)

```

##### Single map

```{r}
df = data.frame(Lon = c(20,50), Lat = c(20,40))
QMap(df)
```

##### Basic  map
```{r}
QMap(Dat) 
```


##### Stations map
```{r}
QMap(Dat,vnames="Stations",col1='orange')
```

##### Variable with specific name
```{r}
QMap(Dat, col1 = 'yellow', n = 4, vnames = expression("Abundance ind km"^2), sunits = 'Elevation - Depth (m)',
sta = 3)
```

##### Variables and fonts


```{r}
QMap(Dat,col1='yellow', n = 4, sunits = 'Elevation - Depth (m)', ftext = "Nirmala UI")
```

```{r}
QMap(df,  vnames = expression("Biomass ind"^2), col1 = "orange", n = 4, sunits =  "Elevation - Depth (m)", 
ftext = "Malgun Gothic" , xlab = "Longitudea", ylab = "Latitudea")
```

