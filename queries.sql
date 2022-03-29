-- 1. Find all animals whose name ends in "mon".
-- 2. List the name of all animals born between 2016 and 2019.
-- 3. List the name of all animals that are neutered and have less than 3 escape attempts.
-- 4. List date of birth of all animals named either "Agumon" or "Pikachu".
-- 5. List name and escape attempts of animals that weigh more than 10.5kg.
-- 6. Find all animals that are neutered.
-- 7. Find all animals not named Gabumon.
-- 8. Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN DATE '2016-01-01' AND '2019-01-01';

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM ANIMALS WHERE name <> 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-------------------TRANSACTION ---------------------

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals; 

--undo changes with ROLLBACK----------

ROLLBACK;
SELECT * FROM animals;

-------------Insert Trasnaction------------------
-----------Update the animals table by setting the "species" column to "digimon" for all animals that have a name ending in "mon".

BEGIN TRANSACTION;

UPDATE animals SET species = 'digimon' WHERE name like '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

COMMIT;
SELECT * FROM animals;

