ALTER VIEW TodaysForecast 
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
	W.ForecastTime between Date_add(Sysdate(), INTERVAL -3 HOUR) and Date_add(Date_add(Date(Sysdate()), INTERVAL 1 DAY),INTERVAL -1 Second)

ORDER BY
	W.ForecastTime
	,WRef.WeatherType