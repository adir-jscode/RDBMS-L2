-- Active: 1747529255063@@127.0.0.1@5432@conservation_db
CREATE Table rangers(
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL UNIQUE
);

CREATE Table species(
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientfic_name VARCHAR(50) UNIQUE,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(20) NOT NULL
);