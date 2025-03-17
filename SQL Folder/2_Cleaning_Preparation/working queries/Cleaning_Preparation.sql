-- Check for missing values
SELECT 
    SUM(CASE WHEN REPORT_NUMBER IS NULL THEN 1 ELSE 0 END) AS missing_report_numbers,
    SUM(CASE WHEN REPORT_DATE IS NULL THEN 1 ELSE 0 END) AS missing_dates,
    SUM(CASE WHEN TRAFFICWAY_DESC IS NULL THEN 1 ELSE 0 END) AS missing_trafficway,
    SUM(CASE WHEN ROAD_SURFACE_CONDITION_DESC IS NULL THEN 1 ELSE 0 END) AS missing_road_conditions
FROM oct2024_crash;

-- Fix any formatting issues like newlines in text fields
-- 1. Disable safe update mode
SET SQL_SAFE_UPDATES = 0;
-- 2. Update
UPDATE oct2024_crash
SET TRAFFICWAY_DESC = REPLACE(TRAFFICWAY_DESC, '\n', ' '),
    WEATHER_CONDITION_DESC = REPLACE(WEATHER_CONDITION_DESC, '\n', ' '),
    LIGHT_CONDITION_DESC = REPLACE(LIGHT_CONDITION_DESC, '\n', ' ');
    
-- 3. Re-enable safe update mode
SET SQL_SAFE_UPDATES = 1;

-- ===================================
-- Modify the column to be a proper DATE type if it's not already
-- ALTER TABLE oct2024_crash MODIFY COLUMN REPORT_DATE DATE;

-- For string-format dates
-- CREATE INDEX idx_report_date ON oct2024_crash(REPORT_DATE(10));



-- First, create a temporary column to hold the converted dates:

ALTER TABLE oct2024_crash ADD COLUMN temp_date DATE;


-- Next, update the temporary column with the converted date values:
-- 1. Disable safe update mode
SET SQL_SAFE_UPDATES = 0;


UPDATE oct2024_crash SET temp_date = STR_TO_DATE(REPORT_DATE, '%d-%b-%y');

-- 3. Re-enable safe update mode
SET SQL_SAFE_UPDATES = 1;

-- Then, modify the original column to the DATE type:

ALTER TABLE oct2024_crash MODIFY COLUMN REPORT_DATE DATE;


-- Finally, copy the converted dates back to the original column and drop the temporary column:

UPDATE oct2024_crash SET REPORT_DATE = temp_date;
ALTER TABLE oct2024_crash DROP COLUMN temp_date;


