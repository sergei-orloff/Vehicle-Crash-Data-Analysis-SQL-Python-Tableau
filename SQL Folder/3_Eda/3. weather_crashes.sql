SELECT WEATHER, sum(crashes) as weather_crashes
FROM
(
	SELECT REPORT_DATE, WEATHER_CONDITION_DESC AS WEATHER, count(REPORT_NUMBER) as crashes
	FROM crash_2024oct_clean
	GROUP BY REPORT_DATE, WEATHER_CONDITION_DESC
) a
GROUP BY WEATHER
ORDER BY weather_crashes DESC;

