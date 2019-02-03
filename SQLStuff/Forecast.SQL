Create View 
	Forecast
as
	SELECT
		W.ForecastTime
		,WRef.WeatherType
		,Case ForecastCode
			When 'W'
				Then WTypeRef.Description
			When 'V'
				Then VisRef.Description
			When 'U'
				Then CONCAT(W.ForecastValue,' - ',UVRef.Description)
			Else W.ForecastValue
		End as ForecastValue
		,WRef.Units

	FROM
		WeatherForecast W
	LEFT JOIN
		WeatherDataTypeRef WRef
	on
		WRef.Abreviation = W.ForecastCode
	and
		WRef.DataType = 'Forecast'

	LEFT JOIN
		WeatherTypeRef WTypeRef
	on
		WTypeRef.Code = W.ForecastValue
	and
		W.ForecastCode = 'W'

	LEFT JOIN
		VisibilityRef VisRef
	on
		VisRef.Code = W.ForecastValue
	and
		W.ForecastCode = 'V'

	LEFT JOIN
		UVIndexRef UVRef
	on
		UVRef.Code = W.ForecastValue
	and
		W.ForecastCode = 'U'

	WHERE
		W.ForecastTime >= Date_add(Sysdate(), INTERVAL -3 HOUR)
