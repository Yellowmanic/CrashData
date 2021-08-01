--Data Exploration

---- Accident by Weather Count
SELECT weather, COUNT(WEATHER) as count
FROM CrashData2019
GROUP BY WEATHER
ORDER BY 2 DESC

-- Accident by Weekday  
Select DATENAME(dw, WEEKDAY) as Weekday, count(WEEKDAY) as count
FROM CrashData2019
GROUP BY WEEKDAY
ORDER BY 2 DESC

-- Accident by Hour 
SELECT HOUR, count(HOUR) as count
FROM CrashData2019
Group BY HOUR
ORDER BY 2 DESC
-- Accidents by Road Type 
SELECT 
(CASE
WHEN (HWY_CLSS_C = 8) THEN 'Service Drive'
WHEN (HWY_CLSS_C = 3) THEN 'M Route'
WHEN (HWY_CLSS_C = 6) THEN 'M Business Route'
WHEN (HWY_CLSS_C = 7) THEN 'Connector'
WHEN (HWY_CLSS_C = 1) THEN 'Interstate'
WHEN (HWY_CLSS_C = 5) THEN 'US Business Route'
WHEN (HWY_CLSS_C = 2) THEN 'US Route' 
WHEN (HWY_CLSS_C = 9) THEN 'Road' 
WHEN (HWY_CLSS_C = 4) THEN 'Interstate Business Loop'
ELSE 'Other'
END) as Road_Classification, count(HWY_CLSS_C) as Accidents
FROM CrashData2019
Group BY HWY_CLSS_C

-- Casuality Severity by Percentage
SELECT (CASE
WHEN (HIGH_SEVER = 1) THEN 'Fatal Injury'
WHEN (HIGH_SEVER = 2) THEN 'Serious Injury'
WHEN (HIGH_SEVER = 5) THEN 'No Injury'
WHEN (HIGH_SEVER = 3) THEN 'Minor Injury'
WHEN (HIGH_SEVER = 4) THEN 'Possible Injury'
END) as severity, count(HIGH_SEVER) as count, CAST(CAST(count(HIGH_SEVER)* 100 AS DEC(10, 2))/(Select Count(*) FROM CrashData2019) as DEC(10,2)) as percentage 
FROM CrashData2019
GROUP BY HIGH_SEVER

--Casuality Groups

--Speed Limit Range by percent and count 
SELECT CASE
WHEN (SPEEDLIMIT >= 0 and SPEEDLIMIT <= 20) THEN '0-20'
WHEN (SPEEDLIMIT >= 25 and SPEEDLIMIT <= 45) THEN '25-45'
WHEN (SPEEDLIMIT >= 50) THEN '50+'
END AS speedrange, count(SPEEDLIMIT) as count, CAST(CAST(count(SPEEDLIMIT)* 100 AS DEC(10, 2))/(Select Count(*) FROM CrashData2019) as DEC(10,2)) as percentage
FROM CrashData2019
GROUP BY CASE WHEN(SPEEDLIMIT >= 0 and SPEEDLIMIT <= 20) THEN '0-20'
WHEN (SPEEDLIMIT >= 25 and SPEEDLIMIT <= 45) THEN '25-45'
WHEN (SPEEDLIMIT >= 50) THEN '50+' END

--Crash Type
SELECT CASE
WHEN(CRSHTYPEO = 2) THEN 'Head On'
WHEN(CRSHTYPEO = 10) THEN 'Backing'
WHEN(CRSHTYPEO = 3) THEN 'Head On-Left Turn'
WHEN(CRSHTYPEO = 98) THEN 'Unknown'
WHEN(CRSHTYPEO = 27) THEN 'Rear End-Right Turn '
WHEN(CRSHTYPEO = 8) THEN 'Sideswipe-Same'
WHEN(CRSHTYPEO = 97) THEN 'Other'
WHEN(CRSHTYPEO = 4) THEN 'Angle'
WHEN(CRSHTYPEO = 9) THEN 'Sideswipe-Opposite'
WHEN(CRSHTYPEO = 1) THEN 'Single Motor Vehicle'
WHEN(CRSHTYPEO = 6) THEN 'Rear End-Left Turn'
WHEN(CRSHTYPEO = 5) THEN 'Rear End'
ELSE 'Not Entered'
END as CrashType, count(CRSHTYPEO) as count
FROM CrashData2019
Group BY CRSHTYPEO
ORDER BY count DESC

--Crashes Over Time
SELECT DATE_FULL as DATE_FULL, count(DATE_FULL) as Accidents
FROM CrashData2019
GROUP BY DATE_FULL
ORDER BY DATE_FULL

--Enviroment Related(Road Condtions)

--Vehicle Type and Pedestrians
SELECT sum(PEDESTRIAN) as pedestrian, sum(BICYCLE) as bicycle, sum(MOTORCYCLE) as motorcycle, sum(TRAIN) as train, sum(SCHOOLBUS) as bus 
FROM CrashData2019

--Other Factors
SELECT sum(ELDERLY) as Elderly, sum(YOUNG) as Young 
FROM CrashData2019

--Lighting 
SELECT CASE
WHEN Lighting = 1 THEN 'Daylight'
WHEN Lighting = 3 THEN 'Dusk'
WHEN Lighting = 2 THEN 'Dawn'
WHEN Lighting = 4 THEN 'Dark-lighted'
WHEN Lighting = 5 THEN 'Dark-Unlighted'
ELSE 'not entered'
END as Lighting
FROM CrashData2019

--Weather
Select CASE
WHEN (Weather = 10) THEN 'Smoke'
WHEN (Weather = 1) THEN 'Clear'
WHEN (Weather = 2) THEN 'Cloudy'
WHEN (Weather = 3) THEN 'Fog'
WHEN (Weather = 8) THEN 'Blowing Snow'
WHEN (Weather = 7) THEN 'Sleet or Hail'
WHEN (Weather = 98) THEN 'Unknown'
WHEN (Weather = 9) THEN 'Blowing Sand, Soil, Dirt'
WHEN (Weather = 4) THEN 'Rain'
WHEN (Weather = 6) THEN 'Severe Crosswinds'
WHEN (Weather = 5) THEN 'Snow'
ELSE 'not entered' END as Weather
From Crashdata2019



-- Changing the values to strings based on the documentation.
SELECT DATE_FULL, HOUR, DATENAME(dw, WEEKDAY) as Weekday, CASE
WHEN(CRSHTYPEO = 2) THEN 'Head On'
WHEN(CRSHTYPEO = 10) THEN 'Backing'
WHEN(CRSHTYPEO = 3) THEN 'Head On-Left Turn'
WHEN(CRSHTYPEO = 98) THEN 'Unknown'
WHEN(CRSHTYPEO = 27) THEN 'Rear End-Right Turn '
WHEN(CRSHTYPEO = 8) THEN 'Sideswipe-Same'
WHEN(CRSHTYPEO = 97) THEN 'Other'
WHEN(CRSHTYPEO = 4) THEN 'Angle'
WHEN(CRSHTYPEO = 9) THEN 'Sideswipe-Opposite'
WHEN(CRSHTYPEO = 1) THEN 'Single Motor Vehicle'
WHEN(CRSHTYPEO = 6) THEN 'Rear End-Left Turn'
WHEN(CRSHTYPEO = 5) THEN 'Rear End'
ELSE 'Not Entered'
END as CrashType, CASE
WHEN (HWY_CLSS_C = 8) THEN 'Service Drive'
WHEN (HWY_CLSS_C = 3) THEN 'M Route'
WHEN (HWY_CLSS_C = 6) THEN 'M Business Route'
WHEN (HWY_CLSS_C = 7) THEN 'Connector'
WHEN (HWY_CLSS_C = 1) THEN 'Interstate'
WHEN (HWY_CLSS_C = 5) THEN 'US Business Route'
WHEN (HWY_CLSS_C = 2) THEN 'US Route' 
WHEN (HWY_CLSS_C = 9) THEN 'Road' 
WHEN (HWY_CLSS_C = 4) THEN 'Interstate Business Loop'
ELSE 'Other'
END as RoadType, 
CASE
WHEN (HIGH_SEVER = 1) THEN 'Fatal Injury'
WHEN (HIGH_SEVER = 2) THEN 'Serious Injury'
WHEN (HIGH_SEVER = 5) THEN 'No Injury'
WHEN (HIGH_SEVER = 3) THEN 'Minor Injury'
WHEN (HIGH_SEVER = 4) THEN 'Possible Injury'
END as Severity, CASE
WHEN (SPEEDLIMIT >= 0 and SPEEDLIMIT <= 20) THEN '0-20'
WHEN (SPEEDLIMIT >= 25 and SPEEDLIMIT <= 45) THEN '25-45'
WHEN (SPEEDLIMIT >= 50) THEN '50+'
END AS speedlimit, CASE
WHEN Lighting = 1 Then 'Daylight'
WHEN Lighting = 3 Then 'Dusk'
WHEN Lighting = 2 Then 'Dawn'
WHEN Lighting = 4 Then 'Dark-lighted'
WHEN Lighting = 5 Then 'Dark-Unlighted'
ELSE 'not entered' END as Lighting,
CASE
WHEN (Weather = 10) THEN 'Smoke'
WHEN (Weather = 1) THEN 'Clear'
WHEN (Weather = 2) THEN 'Cloudy'
WHEN (Weather = 3) THEN 'Fog'
WHEN (Weather = 8) THEN 'Blowing Snow'
WHEN (Weather = 7) THEN 'Sleet or Hail'
WHEN (Weather = 98) THEN 'Unknown'
WHEN (Weather = 9) THEN 'Blowing Sand, Soil, Dirt'
WHEN (Weather = 4) THEN 'Rain'
WHEN (Weather = 6) THEN 'Severe Crosswinds'
WHEN (Weather = 5) THEN 'Snow'
ELSE 'not entered' END as Weather , ELDERLY, YOUNG, KCOUNT, ALCOHOL, DRUG, CNTNAME, X, Y
FROM CrashData2019