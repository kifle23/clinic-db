CREATE DATABASE clinic;

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE
);

CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admitted_at TimeStamp,
  patient_id INTEGER REFERENCES patients(id),
  status VARCHAR(255)
);

CREATE TABLE treatments (
    id SERIAL PRIMARY KEY,
    type VARCHAR(255),
    name VARCHAR(255)
);

CREATE TABLE medical_histories_treatments (
  medical_history_id INTEGER REFERENCES medical_histories(id),
  treatment_id INTEGER REFERENCES treatments(id),
  PRIMARY KEY (medical_history_id, treatment_id)
);

CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TimeStamp,
  payed_at TimeStamp,
  medical_history_id INTEGER REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL,
  quantity INTEGER,
  total_price DECIMAL,
  invoice_id INTEGER REFERENCES invoices(id),
  treatment_id INTEGER REFERENCES treatments(id)
);

CREATE INDEX idx_patient_id ON medical_histories (patient_id);
CREATE INDEX idx_medical_history_id ON medical_histories_treatments (medical_history_id);
CREATE INDEX idx_treatment_id ON medical_histories_treatments (treatment_id);
CREATE INDEX idx_medical_history_id_invoices ON invoices (medical_history_id);
CREATE INDEX idx_invoice_id ON invoice_items (invoice_id);
CREATE INDEX idx_treatment_id_invoice_items ON invoice_items (treatment_id);
