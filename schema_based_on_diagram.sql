CREATE DATABASE medical_histories;

CREATE TABLE patients (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(70) NOT NULL,
    date_of_birth DATE NOT NULL
)

CREATE TABLE medical_histories (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    admitted_at TIMESTAMP NOT NULL,
    patient_id INT NOT NULL,
    status VARCHAR(70)
    CONSTRAINT fk_patient_id FOREIGN KEY (patient_id) REFERENCES patients(id)
)

CREATE TABLE treatments (
    id BIGSERIAL NOT NULL PRIMARY KEY,,
    type VARCHAR(100),
    name VARCHAR(70)
)