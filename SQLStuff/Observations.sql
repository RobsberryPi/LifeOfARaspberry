ALTER VIEW Observations 
as
SELECT
	W.ObservationTime
	,WRef.WeatherType
	,Case ObservationCode
		When 'W'
			Then WTypeRef.Description
		When 'U'
			Then CONCAT(W.ObservationValue,' - ',UVRef.Description)
		Else W.ObservationValue
	End as ObservationValue
	,WRef.Units

FROM
	WeatherObservations W
LEFT JOIN
	WeatherDataTypeRef WRef
on
	WRef.Abreviation = W.ObservationCode
and
	WRef.DataType = 'Observations'

LEFT JOIN
	WeatherTypeRef WTypeRef
on
	WTypeRef.Code = W.ObservationValue
and
	W.ObservationCode = 'W'

LEFT JOIN
	UVIndexRef UVRef
on
	UVRef.Code = W.ObservationValue
and
	W.ObservationCode = 'U'

ORDER BY
	W.ObservationTime
	,WRef.WeatherType