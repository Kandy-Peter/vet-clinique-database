CREATE DATABASE medical_histories;

CREATE TABLE patients (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(70) NOT NULL,
    date_of_birth DATE NOT NULL
);

CREATE TABLE medical_histories (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    admitted_at TIMESTAMP NOT NULL,
    patient_id INT NOT NULL,
    status VARCHAR(70)
    CONSTRAINT fk_patient_id FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE treatments (
    id BIGSERIAL NOT NULL PRIMARY KEY,,
    type VARCHAR(100),
    name VARCHAR(70)
);

CREATE TABLE invoices (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    total_amount DECIMAL(10, 2),
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,
    CONSTRAINT fk_medical_history_id FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

CREAT TABLE invoice_items (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    unit_price DECIMAL(10, 2),
    quantity INT,
    total_price DECIMAL(10, 2),
    invoice_id INT,
    treatment_id INT,
    CONSTRAINT fk_invoice_id FOREIGN KEY (invoice_id) REFERENCES invoices(id),
    CONSTRAINT fk_treatment_id FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

-- Join table for many to many relationship between table treatment and medical_histories

CREATE TABLE medical_history_treatment (
    medical_history_id INT,
    treatment_id INT,
    CONSTRAINT fk_medical_history_id FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id),
    CONSTRAINT fk_treatment_id FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

------- Create indexes ---------

CREATE INDEX ON medical_histories (patient_id);
CREATE INDEX ON invoices (medical_history_id);
CREATE INDEX ON invoice_items (invoice_id);
CREATE INDEX ON invoice_items (treatment_id);
CREATE INDEX ON medical_history_treatment (medical_history_id);
CREATE INDEX ON medical_history_treatment (treatment_id);