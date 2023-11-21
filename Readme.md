
# QuickMap Function (QMap)

The QuickMap function was designed to facilitate the plotting of data on maps, considering altimetry and bathymetry. The code utilizes functions from the 'maps,' 'mapplots,' 'oceanmap,' 'extrafont,' 'ggplot2,' and 'marmap' packages. All these packages are automatically installed and loaded either by calling the function or by running it with no arguments.

To generate maps using a data frame, you have two options:

For a 2x2 data frame with extreme values of longitude and latitude, the function produces a map with a legend in meters (m). This map includes "Longitude" and "Latitude" as axes labels (single map example).

If your data frame has more than two columns, the function creates a map with a legend in meters (m) and includes Longitude and Latitude as axes labels. Black dots indicate stations, with row names serving as station codes below each dot. The label 'stations' is also provided (basic map example).

#### This function has 11 parameters:

* df: This is the data frame.

* vnames: This argument, in data frames without values of variables, defaults to "Stations" and must be a character.

* n: This is the column number of the variable you want to represent on the map.

* sunits: The default value for units of altimetry and bathymetry is Meters (m) and must be a character.

* ftext: This is the font text selected for all labels, with a default value of "Times New Roman." Fonts can be selected from the list provided through the fonts() function.

* col1: The color of the dots for stations/variables is black by default.

* xlab: Must be a character, and the default value for the x-axis label is "Longitude."

* ylab: Must be a character, and the default value for the y-axis label is "Latitude."

* sta: It is the number of the column with the station codes. If absent, the function will use the row names as station codes.

* pox: This argument provides the horizontal position of the station codes.

* poy: This argument provides the vertical position of the station codes.

Note: If this is the first time you are using the extrafont package, you need to import the fonts registered in the system.

#### The following examples demonstrate the possible maps that can be obtained through the QMap function. The stringi package is required.

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

