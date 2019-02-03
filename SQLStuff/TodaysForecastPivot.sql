Alter View
	TodaysForecastPivot
AS

SELECT 
    TF.ForecastTime
    ,CONCAT_WS('°',MAX(if(TF.WeatherType='Feels Like Temperature',ForecastValue,Null)), MAX(if(TF.WeatherType='Feels Like Temperature',Units,Null)))  as FeelsLikeTemperature
	,MAX(if(TF.WeatherType='Max UV Index',ForecastValue,Null)) as UVIndex
    ,CONCAT(MAX(if(TF.WeatherType='Precipitation Probability',ForecastValue,Null)), MAX(if(TF.WeatherType='Precipitation Probability',Units,Null))) as PrecipitationChance
    ,CONCAT(MAX(if(TF.WeatherType='Screen Relative Humidity',ForecastValue,Null)), MAX(if(TF.WeatherType='Screen Relative Humidity',Units,Null))) as ScreenRelativeHumidity
    ,CONCAT_WS('°',MAX(if(TF.WeatherType='Temperature',ForecastValue,Null)), MAX(if(TF.WeatherType='Temperature',Units,Null))) as Temperature
    ,MAX(if(TF.WeatherType='Visibility',ForecastValue,Null)) as Visibility
    ,MAX(if(TF.WeatherType='Weather Type',ForecastValue,Null)) as WeatherType
    ,MAX(if(TF.WeatherType= 'Wind Direction',ForecastValue,Null)) as WindDirection
    ,CONCAT_WS(' ',MAX(if(TF.WeatherType= 'Wind Speed',ForecastValue,Null)), MAX(if(TF.WeatherType='Wind Speed',Units,Null))) as WindSpeed
    ,CONCAT_WS(' ',MAX(if(TF.WeatherType= 'Wind Gust',ForecastValue,Null)), MAX(if(TF.WeatherType='Wind Gust',Units,Null))) as WindGust
FROM 
	RaspberryFields.TodaysForecast TF
Group by
	TF.ForecastTime

;