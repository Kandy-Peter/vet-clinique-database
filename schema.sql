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
