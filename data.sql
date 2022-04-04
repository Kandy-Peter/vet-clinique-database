/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', 0, true,  10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, true,  8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, false,  15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, true,  11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', 0, false,  -11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, true,  -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, false,  -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-06-12', 1, true,  -45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', 7, true,  20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, true,  17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-05-14', 4, true,  22);

-- -------OWNERS TABLE -----------------

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

-- ------------species table -------------

INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

---------modify the animals table -----------
--------If the name ends in "mon" it will be Digimon-------
UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

-------All other animals are Pokemon-----------

UPDATE animals
SET species_id = 1
WHERE species_id IS NULL;

------ insert some owner_id information---------
UPDATE animals SET owner_id = 1 WHERE id = 1;

UPDATE animals SET owner_id = 2 WHERE id IN (2, 3);

UPDATE animals SET owner_id = 3 WHERE id IN (4, 6);

UPDATE animals SET owner_id = 4 WHERE id IN (5, 7, 10);

UPDATE animals SET owner_id = 5 WHERE id IN (8, 9);

--- Insert the ellemts in the vets table ------

INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');

-- Insert into the the specialization tbale ----

INSERT INTO specializations (vet_id, species_id) VALUES (1, 1);
INSERT INTO specializations (vet_id, species_id) VALUES (3, 1);
INSERT INTO specializations (vet_id, species_id) VALUES (3, 2);
INSERT INTO specializations (vet_id, species_id) VALUES (4, 2);

--------- insert data into the visits table------

INSERT INTO visits (animals_id, vets_id, date_of_visit)
VALUES
  (1, 1, '2020-5-24'),
  (1, 3, '2020-7-22'),
  (2, 4, '2021-2-2'),
  (3, 2, '2020-1-5'),
  (3, 2, '2020-3-8'),
  (3, 2, '2020-5-14'),
  (4, 3, '2021-5-4'),
  (5, 4, '2021-2-24'),
  (6, 2, '2019-12-21'),
  (6, 1, '2020-8-10'),
  (6, 2, '2021-4-7'),
  (7, 3, '2019-9-29'),
  (8, 4, '2020-10-3'),
  (8, 4, '2020-11-4'),
  (9, 2, '2019-1-24'),
  (9, 2, '2019-5-15'),
  (9, 2, '2020-2-27'),
  (9, 2, '2020-8-3'),
  (10, 3, '2020-5-24'),
  (10, 1, '2021-1-11');


  
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
