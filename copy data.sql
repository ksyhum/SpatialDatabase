COPY indego_trips_2024_q1 FROM 'D:\Humam\KTH\Spatial database\Spatial Database Project\trips-2024-q1-modified.csv' DELIMITER ',' CSV HEADER;
COPY stations FROM 'D:\Humam\KTH\Spatial database\Spatial Database Project\station indigo.csv' DELIMITER ';' CSV HEADER;
COPY bike_network FROM 'D:\Humam\KTH\Spatial database\Spatial Database Project\bike_network.csv' DELIMITER ',' CSV HEADER;
COPY phili_neighbor FROM 'D:\Humam\KTH\Spatial database\Spatial Database Project\phili_neighbor.csv' DELIMITER ',' CSV HEADER;
COPY indego_trips_with_day FROM 'D:\Humam\KTH\Spatial database\Spatial Database Project\trips-2024-q1-dengan-hari.csv' DELIMITER ',' CSV HEADER;
COPY bicycle_crashes FROM 'D:\Humam\KTH\Spatial database\Spatial Database Project\point_crash.csv' DELIMITER ',' CSV HEADER;
COPY hospitals FROM 'D:\Humam\KTH\Spatial database\Spatial Database Project\hospital_new.csv' DELIMITER ',' CSV HEADER;
COPY road_network FROM 'D:\Humam\KTH\Spatial database\Spatial Database Project\street_new.csv' DELIMITER ',' CSV HEADER;