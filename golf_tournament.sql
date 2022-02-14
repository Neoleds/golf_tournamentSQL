drop database neo;
create database neo;
use neo;

CREATE TABLE player(
	id_number VARCHAR(12) PRIMARY KEY NOT NULL,
    player_name VARCHAR(50) NOT NULL,
    age INT
);

CREATE TABLE jacket(
	model_number INT PRIMARY KEY,
	initial VARCHAR(10) NOT NULL,
    size VARCHAR(5),
    material VARCHAR(50),
    player_id_number VARCHAR(12),
    FOREIGN KEY (player_id_number) REFERENCES player(id_number),
    KEY (initial)
);

CREATE TABLE competition(
	competition_name VARCHAR(100) PRIMARY KEY,
    datum DATE
);

CREATE TABLE participation(
	player_id_number VARCHAR(12),
    competition_name VARCHAR(100),
    FOREIGN KEY (player_id_number) REFERENCES player(id_number),
    FOREIGN KEY (competition_name) REFERENCES competition(competition_name),
    PRIMARY KEY (player_id_number, competition_name)
);

CREATE TABLE rain(
	weather_type VARCHAR(20) PRIMARY KEY,
    wind_speed INT
);

CREATE TABLE construction(
	serial_number INT PRIMARY KEY,
    density INT
);

CREATE TABLE golf_club(
	id_number INT NOT NULL,
    material VARCHAR(50),
    player_id_number VARCHAR(12),
    construction_serial_number INT,
    FOREIGN KEY (player_id_number) REFERENCES player(id_number),
    FOREIGN KEY (construction_serial_number) REFERENCES construction(serial_number),
    PRIMARY KEY (id_number, player_id_number)
);

CREATE TABLE competition_has_rain(
	weather_type VARCHAR(20),
    competition_name VARCHAR(100),
    time_for_competition DATETIME,
    FOREIGN KEY (weather_type) REFERENCES rain(weather_type),
    FOREIGN KEY (competition_name) REFERENCES competition(competition_name),
    PRIMARY KEY (weather_type, competition_name)
);

INSERT INTO player VALUES ("199610141111" , "Johan Andersson", 25);
INSERT INTO player VALUES ("199610141112" , "Nicklas Jansson", 30);
INSERT INTO player VALUES ("199610141113" , "Annika Persson", 35);

INSERT INTO jacket VALUES (1, "JA", "L", "Fleece", "199610141111");
INSERT INTO jacket VALUES (2, "JA", "L", "Gortex", "199610141111");

INSERT INTO construction VALUES (1, 10);
INSERT INTO construction VALUES (2, 5);

INSERT INTO golf_club VALUES (1, "Trä", "199610141112", 1);
INSERT INTO golf_club VALUES (2, "Trä", "199610141113", 2);

INSERT INTO competition VALUES ("Big golf cup Skövde", "2021-10-06");

INSERT INTO participation VALUES ("199610141111", "Big golf cup Skövde");
INSERT INTO participation VALUES ("199610141112", "Big golf cup Skövde");
INSERT INTO participation VALUES ("199610141113", "Big golf cup Skövde");

INSERT INTO rain VALUES ("Hagel", 10);
INSERT INTO competition_has_rain VALUES ("Hagel", "Big golf cup Skövde", "2021-10-06 12:00:00");

SELECT age FROM player WHERE id_number = "199610141111";
SELECT datum FROM competition WHERE competition_name = "Big golf cup Skövde";
SELECT material FROM golf_club WHERE id_number = 1;
SELECT * FROM jacket WHERE player_id_number = "199610141111";
SELECT player_name FROM player INNER JOIN participation ON id_number = player_id_number; 
SELECT wind_speed FROM rain INNER JOIN competition_has_rain ON competition_name = "Big golf cup Skövde";
SELECT player_name FROM player WHERE age < 30;
DELETE FROM jacket WHERE player_id_number = 199610141111;
DELETE FROM player WHERE player_name = "Nicklas Jansson" AND id_number = "199610141112";
SELECT AVG (age) FROM player;






