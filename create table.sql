CREATE TABLE indego_trips_2024_q1 (
    trip_id BIGINT PRIMARY KEY,
    duration INTEGER,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    start_station INTEGER,
    start_lat NUMERIC(10, 6),
    start_lon NUMERIC(10, 6),
    end_station INTEGER,
    end_lat NUMERIC(10, 6),
    end_lon NUMERIC(10, 6),
    bike_id TEXT,
    plan_duration INTEGER,
    trip_route_category VARCHAR(255),
    passholder_type VARCHAR(255),
    bike_type VARCHAR(255)
);

CREATE TABLE stations (
    station_id INTEGER PRIMARY KEY,
    station_name VARCHAR(255),
    go_live_date DATE,
    status VARCHAR(50)
);



CREATE TABLE bike_network (
    column1 INTEGER,
    objectid INTEGER PRIMARY KEY,
    seg_id INTEGER,
    streetname VARCHAR(255),
    st_code INTEGER,
    oneway CHAR(10),
    class INTEGER,
    type VARCHAR(50),
    shape_length NUMERIC,
    GEOMETRY(LINESTRING, 4326)
);

CREATE TABLE phili_neighbor (
    column1 INTEGER,
    name VARCHAR(255),
    listname VARCHAR(255),
    mapname VARCHAR(255),
    shape_leng NUMERIC,
    shape_area NUMERIC,
    cartodb_id INTEGER PRIMARY KEY,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    GEOMETRY(MULTIPOLYGON, 4326)
);


CREATE TABLE indego_trips_with_day (
    trip_id BIGINT PRIMARY KEY,
    duration INTEGER,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    start_station INTEGER,
    start_lat NUMERIC(10, 6),
    start_lon NUMERIC(10, 6),
    end_station INTEGER,
    end_lat NUMERIC(10, 6),
    end_lon NUMERIC(10, 6),
    bike_id TEXT,
    plan_duration INTEGER,
    trip_route_category VARCHAR(255),
    passholder_type VARCHAR(255),
    bike_type VARCHAR(255),
	day TEXT
);


CREATE TABLE bicycle_crashes (
    bicycle_co INTEGER,
    bicycle_de INTEGER,
    bicycle_su INTEGER,
    crash_month INTEGER,
    crash_year INTEGER,
    crn BIGINT,
    day_of_week INTEGER,
    dec_lat NUMERIC(10, 6),
    dec_long NUMERIC(10, 6),
    bicycle INTEGER,
    geometry GEOMETRY(POINT, 4326)
);

CREATE TABLE hospital (
	name VARCHAR(100),
    address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(2),
    zip VARCHAR(10),
    phone VARCHAR(15),
    type VARCHAR(50),
    geom GEOMETRY(Point, 4326)
);

CREATE TABLE road_network (
    Shape_Len NUMERIC,
    SEG_ID INTEGER,
    RESPONSIBL TEXT,
    TNODE_ INTEGER,
    ONEWAY TEXT,
    CLASS INTEGER,
    STNAME TEXT,
    FNODE_ INTEGER,
    R_F_ADD INTEGER,
    STREETLABE TEXT,
    L_F_ADD INTEGER,
    ST_NAME TEXT,
    ZIP_RIGHT VARCHAR(5),
    R_T_ADD INTEGER,
    ZIP_LEFT VARCHAR(5),
    ST_TYPE TEXT,
    ST_CODE INTEGER,
    LENGTH NUMERIC,
    UPDATE_ INTEGER,
    MULTI_REP INTEGER,
    geometry GEOMETRY(LINESTRING, 4326)
);

