Understanding when forest fires are likely to occur and what causes them is important for managing them. 
The data used in this project is associated with a research paper on predicting forest fires in Portugal.

This is a basic project to familiarise myself with using R. It is mostly practicing visualisation and normalisation of data. 

Descriptions of the variables in the data set:

<b>X:</b> X-axis spatial coordinate within the Montesinho park map: 1 to 9 <br>
<b>Y:</b> Y-axis spatial coordinate within the Montesinho park map: 2 to 9 <br>
<b>month:</b> Month of the year: 'jan' to 'dec' <br>
<b>day:</b> Day of the week: 'mon' to 'sun' <br>
<b>FFMC:</b> Fine Fuel Moisture Code index from the FWI system: 18.7 to 96.20 <br>
<b>DMC:</b> Duff Moisture Code index from the FWI system: 1.1 to 291.3 <br>
<b>DC:</b> Drought Code index from the FWI system: 7.9 to 860.6 <br>
<b>ISI:</b> Initial Spread Index from the FWI system: 0.0 to 56.10 <br>
<b>temp:</b> Temperature in Celsius degrees: 2.2 to 33.30 <br>
<b>RH:</b> Relative humidity in percentage: 15.0 to 100 <br>
<b>wind:</b> Wind speed in km/h: 0.40 to 9.40 <br>
<b>rain:</b> Outside rain in mm/m2 : 0.0 to 6.4 <br>
<b>area:</b> The burned area of the forest (in ha): 0.00 to 1090.84 <br>

<b>Visualisations</b> <br>
<b>Forest Fires per day of the week</b> <br>
<img src="https://github.com/elliecrossleyfells/forestfires_R_project/blob/main/fires_by_day.png" width="400">

<b>Forest Fires per Month</b> <br>
<img src="https://github.com/elliecrossleyfells/forestfires_R_project/blob/main/fires_per_month.png" width="400">

<b>Forest Fires per Month and average monthly temperature </b> <br>
<img src="https://github.com/elliecrossleyfells/forestfires_R_project/blob/main/avgtemp_fires.png" width="400">

<b>Forest Fires per month compared with causation variables (DMC, DC, RH%)</b>  <br>
<img src="https://github.com/elliecrossleyfells/forestfires_R_project/blob/main/fires_causingvariables.png" width="400">

<b>Findings</b> <br>
Forest fires are more common in March, August and September. This is correlated with higher temperatures in these months. <br>
March rising temperatures caused by seasonality which contribute to drier conditions and an increased likelihood of fires. Seasonal winds in March as well as agricultural activities like slash-and-burn practice or land clearing, may spread fires more rapidly, however this has not been analysed in this dataset and more analysis would be required to confirm this hypothesis. <br>
Forest fires are more likely on a weekend, likely caused by increased human leisure activities. <br>
March, August and September see low humidity levels (RH). This leads to drier vegetation, which is more prone to ignition and burning. <br>
Increases in Duff Moisture Code (DMC) and Drought Code (DC) in March, August and September indicate that moisture content in organic material is decreasing, making it more flammable. 
