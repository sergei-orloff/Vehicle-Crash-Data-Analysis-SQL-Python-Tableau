-- Modify the data set excluding some columns.

SELECT 
	REPORT_NUMBER, 
	REPORT_DATE, 
	REPORT_STATE, 
	ROAD_SURFACE_CONDITION_DESC, 
	WEATHER_CONDITION_DESC, 
	LIGHT_CONDITION_DESC, 
	VEHICLE_LICENSE_NUMBER 
FROM `CRUSH PROJECT`.oct2024_crash_2;

