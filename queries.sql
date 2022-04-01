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

-- Insert Trasnaction
-- Update the animals table by setting the "species" column to "digimon" for all animals that have a name ending in "mon".

BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name like '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;
SELECT * FROM animals;

-- Delete all records in the animals table, then roll back the transaction.

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;
SAVEPOINT delete_animals;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO delete_animals;
SELECT * FROM animals;
UPDATE animals
SET weight_kg = (weight_kg * -1)
WHERE weight_kg < 1;
COMMIT;
SELECT * FROM animals;

-- QUERIES questions--------

-- How many animals are there?

SELECT
    COUNT(*)
FROM
    animals;

-- How many animals have never tried to escape?

SELECT
    COUNT(name)
FROM animals
WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT
    AVG(weight_kg)
FROM animals;

-- Who escapes the most, neutered or not neutered animals?

SELECT
    name, species, escape_attempts
FROM
    animals
WHERE
    escape_attempts = (SELECT MAX(escape_attempts) FROM animals);
-- What is the minimum and maximum weight of each type of animal?

SELECT
    species, MIN(weight_kg), MAX(weight_kg)
FROM
    animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT
    species, AVG(escape_attempts)
FROM
    animals
WHERE
    date_of_birth
BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

------------- Write queries (using JOIN) to answer the following questions: ------

-- What animals belong to Melody Pond?
    SELECT * FROM animals
    JOIN owners ON animals.owner_id = 4;

    -- or
    SELECT name FROM animals
    JOIN owners ON animals.owner_id = owners.id
    WHERE owners.id = 4;

-- List of all animals that are pokemon (their type is Pokemon)
    SELECT * FROM animals
    JOIN species ON animals.species_id = species.id
    WHERE species.id = 1;

-- List all owners and their animals, remember to include those that don't own any animal.
    SELECT * FROM owners
    LEFT JOIN animals ON animals.owner_id = owners.id;

-- How many animals are there per species?
    SELECT species.name, COUNT(animals.species_id) FROM animals
    JOIN species ON animals.species_id = species.id
    GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
    SELECT owners.id, owners.full_name, animals.species_id, animals.name FROM animals
    JOIN owners ON animals.owner_id = owners.id
    WHERE owners.id = 2 AND animals.species_id = 2;

-- List all animals owned by Dean Winchester that haven't tried to escape.

    SELECT owners.id, owners.full_name, animals.name, animals.escape_attempts FROM animals
    JOIN owners ON animals.escape_attempts = owners.id
    WHERE owners.id = 5 AND animals.escape_attempts = 0;

-- Who owns the most animals?

    SELECT owners.full_name, COUNT(animals.owner_id) FROM animals
    JOIN owners ON animals.owner_id = owners.id
    GROUP BY owners.full_name
    ORDER BY COUNT(*);

-- Who was the last animal seen by William Tatcher?

SELECT animals.name, MAX(visits.date_of_visit)
FROM animals
JOIN visits ON visits.animals_id = animals.id
WHERE vets_id = 1
GROUP BY animals.name
ORDER BY MAX(visits.date_of_visit) DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?

SELECT animals.name, MIN(visits.date_of_visit)
FROM animals
JOIN visits ON visits.animals_id = animals.id
WHERE vets_id = 1
GROUP BY animals.name
ORDER BY MIN(visits.date_of_visit) DESC LIMIT 1;

-- List all vets and their specialties, including vets with no specialties.

SELECT vets.name FROM vets
LEFT JOIN specializations ON specializations.vets_id = vets.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT animals.name FROM animals
JOIN visits ON visits.animals_id = animals.id
WHERE vets_id = 3 AND date_of_visit BETWEEN DATE '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?

SELECT animals.id, animals.name FROM animals
JOIN visits ON animals_id = animals.id
GROUP BY animals.id, animals.name
ORDER BY COUNT(visits.animals_id) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?

SELECT animals.name, MIN(visits.date_of_visit) FROM animals
JOIN visits ON animals_id = animals.id
WHERE vets_id = 2
GROUP BY animals.id, animals.name
ORDER BY MIN(visits.date_of_visit) ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT * FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON vets.id = animals.owner_id
GROUP BY animals.id, vets.id, visits.vets_id, visits.animals_id, visits.date_of_visit
ORDER BY MIN(visits.date_of_visit) DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT vets.name, COUNT(visits.vets_id) FROM visits
JOIN vets ON visits.vets_id = vets.id
JOIN animals ON visits.animals_id = animals.id
JOIN specializations ON vets.id = specializations.vets_id
WHERE specializations.species_id != animals.species_id
GROUP BY vets.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT species.name, COUNT(animals.species_id) FROM visits
JOIN animals ON id = visits.animals_id
JOIN species ON species.id = animals.species_id
WHERE visits.vets_id = 2
GROUP BY species.name LIMIT 1;