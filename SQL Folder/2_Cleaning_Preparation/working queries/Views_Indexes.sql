-- Create indexes for better query performance
CREATE INDEX idx_report_date ON oct2024_crash(REPORT_DATE);
CREATE INDEX idx_road_condition ON oct2024_crash(ROAD_SURFACE_CONDITION_DESC);
CREATE INDEX idx_weather_condition ON oct2024_crash(WEATHER_CONDITION_DESC);

-- Create useful views
CREATE VIEW fatal_crashes AS
SELECT * FROM oct2024_crash WHERE FATALITIES > 0;

CREATE VIEW crash_by_conditions AS
SELECT 
    ROAD_SURFACE_CONDITION_DESC,
    WEATHER_CONDITION_DESC,
    COUNT(*) AS crash_count,
    SUM(FATALITIES) AS total_fatalities,
    SUM(INJURIES) AS total_injuries
FROM oct2024_crash
GROUP BY ROAD_SURFACE_CONDITION_DESC, WEATHER_CONDITION_DESC;
