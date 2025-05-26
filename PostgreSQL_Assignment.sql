-- Active: 1747529255063@@127.0.0.1@5432@conservation_db
CREATE Table rangers(
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL UNIQUE
);

CREATE Table species(
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(50) UNIQUE,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(20) NOT NULL
);

CREATE Table sightings(
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INTEGER REFERENCES rangers(ranger_id),
    species_id INTEGER REFERENCES species(species_id),
    sighting_time TIMESTAMP without time zone NOT NULL,
    location VARCHAR(50) NOT NULL,
    notes TEXT
);

DROP TABLE rangers;
DROP Table species;
DROP Table sightings;

SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;

INSERT INTO rangers (name,region) VALUES
('Alice Green',' Northern Hills'),
('Bob White','River Delta'),
('Carol King','Mountain Range');

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status)
VALUES
  ('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
  ('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
  ('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
  ('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes)
VALUES
  (1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
  (2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
  (3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
  (1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


-- problem 1
INSERT INTO rangers (name,region) VALUES
('Derek Fox','Coastal Plains');

-- problem 2
SELECT COUNT( DISTINCT sightings.species_id) AS unique_species_sighted
FROM sightings
JOIN species ON species.species_id = sightings.species_id;

-- problem 3

SELECT * FROM sightings WHERE location LIKE '%Pass';

-- problem 4

SELECT name,count(sightings.sighting_id) FROM rangers
JOIN sightings on  rangers.ranger_id = sightings.ranger_id 
GROUP BY rangers.name;

-- problem 5
SELECT common_name FROM sightings
JOIN species on species.species_id = sightings.sighting_id
WHERE species.species_id NOT in (sightings.species_id);

-- problem 6
SELECT common_name,sighting_time,name FROM sightings
JOIN rangers on rangers.ranger_id = sightings.sighting_id
JOIN species on species.species_id = sightings.sighting_id
ORDER BY sighting_time DESC LIMIT 2;

-- problem 7
UPDATE species set conservation_status = 'Historic' WHERE  extract(year from discovery_date::date) <1800;


-- problem 8
CREATE view timeofday
as
SELECT sighting_id , extract(HOUR from sighting_time::time) as "time_of_day " FROM sightings;

SELECT * FROM timeofday;
-- problem 9

DELETE FROM rangers
WHERE ranger_id = (SELECT rangers.ranger_id FROM rangers
JOIN sightings on rangers.ranger_id = sightings.sighting_id
WHERE rangers.ranger_id NOT in (sightings.ranger_id));



