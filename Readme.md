
# QuickMap Function (QMap)

The QuickMap function was designed to contribute to mapping the different kind of data such as abundance, biomass or occurrence, taking into account the altimetry and bathymetry which improve the graphic quality and representation of the stored information. Given that the QuickMap function relies on functions from packages such as 'maps', 'mapplots', 'oceanmap', 'extrafont', 'ggplot2', 'ggfortify', 'ggspatial', 'sf', and 'marmap', ensure these packages are installed and loaded either through the function or by running it with no arguments. Additionally, the data frame should have longitude and latitude data in its first and second columns, respectively.

You can generate two different maps using a data frame:

For the first map, use a 2x2 data frame containing the extreme values of longitude and latitude. This map will include a legend in Meters (m) and display "Longitude" and "Latitude" as axis labels.

For the second map, if your data frame contains more than two columns, it will also include a legend in Meters (m), with "Longitude" and "Latitude" as axis labels. In this case, stations will be marked by black dots, with station codes displayed below each dot, and labeled as "stations".

This function offers 13 parameters:

* df: The data frame.
* vnames: Character argument representing variable names. Default is "Stations" if variables are not provided.
* n: Column number of the variable to be represented on the map.
* sunits: Units of altimetry and bathymetry, default is "Meters (m)".
* ftext: Selected font for all labels, default is "Times New Roman".
* col1: Dot color for stations/variables, default is black.
* xlab: X-axis label, default is "Longitude".
* ylab: Y-axis label, default is "Latitude".
* sta: Column number with station codes; if absent, row names will be used as station codes.
* pox: Horizontal position of station codes.
* poy: Vertical position of station codes.
* Apos: Location option for north arrow.
* Bpos: Location option for bar scale.
* angle: Change the angle of x-axis text. It is useful for thin maps.  

Note: If you are using the extrafont package for the first time, import the fonts registered in the system.

#### The examples below demonstrate the potential maps achievable with the QMap function. The stringi package is necessary for their generation.

```{r}
load("QuickMap.Rdata")

# require(stringi)

set.seed(125)

Dat = data.frame(Lon = runif(40,-18, -4), Lat = runif(40,36, 45))
Dat$Sta = stringi::stri_rand_strings(40,3,'[A-Za-z0-9]')
table(Dat$Sta)

set.seed(125)
Dat = data.frame(Lon = runif(40,-17, -5), Lat = runif(40,36, 45))
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

