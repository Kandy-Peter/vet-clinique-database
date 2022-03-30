/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL(10, 2) NOT NULL
);

ALTER TABLE animals ADD COLUMN species varchar(50);
ALTER TABLE animals DROP COLUMN species;

/* Create the owners table */

CREATE TABLE owners (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    age INT NOT NULL
);

-- Create the species Tbale

CREATE TABLE species (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Add column species_id which is a foreign key referencing species table --

ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species (id);

-- Add column species_id which is a foreign key referencing species table --

ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners (id);