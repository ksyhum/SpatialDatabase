-- how many trip in Q1 ?
select trip_id
from indego_trips_day

-- Which day the most using bike sharing?
select i.day, count(*)
from indego_trips_day i
group by i.day


-- Which pass_holder the most using bike sharing?	
select passholder_type AS pass_type, COUNT (*)
from indego_trips_day
group by pass_type

-- Which bike_type the most using bike sharing?	
select  bike_type AS bike_type, COUNT (*)
from indego_trips_day
group by bike_type
	
-- what is the max,min and average duration in Q1

select 
	MAX(duration) AS longest_duration, -- in minutes
	AVG(duration) AS average_duration,
	MIN(duration) AS shortest_duration
from
	indego_trips_day

-- what time the most using bike sharing	
SELECT
  CASE
    WHEN EXTRACT(HOUR FROM start_time) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM start_time) BETWEEN 12 AND 15 THEN 'Afternoon'
    WHEN EXTRACT(HOUR FROM start_time) BETWEEN 16 AND 19 THEN 'Evening'
    ELSE 'Night'  -- Mengasumsikan jam 20-05 sebagai Malam
  END AS time,
  COUNT(trip_id) AS jumlah_perjalanan
FROM indego_trips_day
GROUP BY time
ORDER BY time;


-- what month the most using bike sharing
SELECT
  CASE
    WHEN EXTRACT(MONTH FROM start_time) = 01 THEN 'JANUARY'
    WHEN EXTRACT(MONTH FROM start_time) = 02 THEN 'FEBRUARY'
    ELSE 'MARCH'  -- Defaulting to March for any other month
  END AS month_trip,
  COUNT(trip_id) AS jumlah_perjalanan
FROM indego_trips_day
GROUP BY month_trip
ORDER BY month_trip;

-- which station is the most start trip

select
	s.station_name,
	count(trip_id) as number_of_trips
from indego_trips_day i
join stations s on s.station_id = i.start_station
group by s.station_name
order by number_of_trips desc

-- The busiest route bike_sharing
SELECT 
    s.station_name AS start_station_name,  -- Alias to differentiate start station name
    e.station_name AS end_station_name,      -- Alias to differentiate end station name
    i.start_station,
    i.start_lat,
    i.start_lon,
    i.end_station,
    i.end_lat,
    i.end_lon,
    COUNT(i.trip_id) AS number_of_trips
FROM
    indego_trips_day i
JOIN
    stations s ON s.station_id = i.start_station  -- Join for start station
JOIN
    stations e ON e.station_id = i.end_station        -- Join for end station
WHERE
	i.start_station <> i.end_station
GROUP BY 
    s.station_name, 
    e.station_name, 
    i.start_station, 
    i.start_lat, 
    i.start_lon, 
    i.end_station, 
    i.end_lat, 
    i.end_lon
ORDER BY 
    number_of_trips DESC;



-- Which neighbor have the most start trip
SELECT
  n.name,
  COUNT(i.trip_id) AS jumlah_trip
FROM
  phili_neighbor AS n
JOIN
  indego_trips_day AS i ON ST_Contains(n.geometry, ST_SetSRID(ST_MakePoint(i.start_lon, i.start_lat), 4326))
GROUP BY
  n.name
ORDER BY 
	jumlah_trip DESC

-- Which neighbor have the most end trip
SELECT
  n.name,
  COUNT(i.trip_id) AS jumlah_trip_akhir
FROM
  phili_neighbor AS n
JOIN
  indego_trips_day AS i ON ST_Contains(n.geometry, ST_SetSRID(ST_MakePoint(i.end_lon, i.end_lat), 4326))
GROUP BY
  n.name
ORDER BY 
  jumlah_trip_akhir DESC


-- where is the bicycle collision bertween 2018-2022
SELECT *
FROM bicycle_crashes
where
	bicycle_co > 0


	
-- How many crash based on year

SELECT crash_year, count(*)
FROM bicycle_crashes
where
	bicycle_co > 0
group by crash_year
order by crash_year 

-- The most bicycle crash based on year and neighbor

WITH CrashData AS (
  SELECT
    ST_SetSRID(ST_MakePoint(dec_long, dec_lat), 4326) AS crash_geom,
    crash_year
  FROM
    bicycle_crashes
  WHERE
    bicycle_co > 0
)

SELECT
  n.name,
  c.crash_year,
  COUNT(*) AS crash_count
FROM
  phili_neighbor n
JOIN
  CrashData c
ON
  ST_Contains(n.geometry, c.crash_geom)
GROUP BY
  n.name, c.crash_year
ORDER BY
  c.crash_year, crash_count DESC;

-- 10 segment bike network that occur crash

WITH CrashData AS (
  SELECT
    ST_SetSRID(ST_MakePoint(dec_long, dec_lat), 4326) AS crash_geom,
    crash_year
  FROM
    bicycle_crashes
  WHERE
    bicycle_co > 0
),

NearestBikeNetwork AS (
  SELECT
    c.crash_geom,
    c.crash_year,
    b.streetname,
	b.geometry,
    ST_ClosestPoint(b.geometry, c.crash_geom) AS closest_point_on_bike_path,
    ROW_NUMBER() OVER (PARTITION BY c.crash_geom ORDER BY ST_Distance(b.geometry, c.crash_geom)) AS rn
  FROM
    CrashData c
  CROSS JOIN
    bike_network b
)

SELECT
  n.streetname,
  COUNT(*) AS crash_count,
  n.geometry  
FROM
  NearestBikeNetwork n
WHERE
  n.rn = 1  -- Selects only the nearest bike network path for each crash
GROUP BY
  n.streetname, n.geometry
ORDER BY
   crash_count DESC
limit 10;

-- Fatal bicycle accident

SELECT *
FROM bicycle_crashes
WHERE bicycle_de > 0

-- Fatal bicycle accident with street name
	
WITH CrashData AS (
  SELECT
    ST_SetSRID(ST_MakePoint(dec_long, dec_lat), 4326) AS crash_geom,
    crash_year
  FROM
    bicycle_crashes
  WHERE
    bicycle_de > 0
),

NearestBikeNetwork AS (
  SELECT
    b.streetname,
	b.geometry,
    ST_ClosestPoint(b.geometry, c.crash_geom) AS closest_point_on_bike_path,
    ROW_NUMBER() OVER (PARTITION BY c.crash_geom ORDER BY ST_Distance(b.geometry, c.crash_geom)) AS rn
  FROM
    CrashData c
  CROSS JOIN
    bike_network b
)

SELECT
  n.streetname,
  COUNT(*) AS crash_count
FROM
  NearestBikeNetwork n
WHERE
  n.rn = 1  -- Selects only the nearest bike network path for each crash
GROUP BY
  n.streetname
ORDER BY
   crash_count DESC

-- distance fatal accident to hospital

WITH CrashData AS (
  SELECT
    ST_SetSRID(ST_MakePoint(dec_long, dec_lat), 4326) AS crash_geom
  FROM
    bicycle_crashes
  WHERE
    bicycle_de > 0
),

NearestHospital AS (
  SELECT
    c.crash_geom,
    h.street AS hospital_street,
    h.geom AS hospital_geom,
    ST_DistanceSphere(h.geom, c.crash_geom) AS distance_to_hospital,  -- Calculating distance in meters
    ROW_NUMBER() OVER (PARTITION BY c.crash_geom ORDER BY ST_DistanceSphere(h.geom, c.crash_geom)) AS rn
  FROM
    CrashData c
  CROSS JOIN
    hospitals h
)

SELECT
  crash_geom AS crash_location,
  hospital_street,
  distance_to_hospital  -- Distance is now in meters
FROM
  NearestHospital
WHERE
  rn = 1
ORDER BY
  distance_to_hospital;


