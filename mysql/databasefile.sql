DROP DATABASE IF EXISTS bbms;
CREATE DATABASE bbms;
use bbms;

-- Database name: Blood Bank Management System

DROP TABLE IF EXISTS blood;
DROP TABLE IF EXISTS hospital;
DROP TABLE IF EXISTS private_facility;
DROP TABLE IF EXISTS donor;
DROP TABLE IF EXISTS donor_medical;
DROP TABLE IF EXISTS patient;
DROP TABLE IF EXISTS patient_medical;
DROP TABLE IF EXISTS blood_transfusion;
DROP TABLE IF EXISTS blood_donations;
DROP TABLE IF EXISTS blood_compatible_blood_types;
DROP TABLE IF EXISTS compatible_blood_types;

CREATE TABLE `blood` (
  `blood_type` VARCHAR(3) PRIMARY KEY NOT NULL,
  `compatible_types` VARCHAR(30)
);

CREATE TABLE `hospital` (
  `hospital_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `hospital_name` VARCHAR(100),
  `address` VARCHAR(255),
  `contact_number` VARCHAR(15),
  `email` VARCHAR(100),
  `head_doctor_name` VARCHAR(100),
  `services_offered` TEXT,
  `emergency_services_availability` BOOLEAN
);

CREATE TABLE `private_facility` (
  `facility_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `facility_name` VARCHAR(100),
  `address` VARCHAR(255),
  `contact_number` VARCHAR(15),
  `email` VARCHAR(100),
  `contact_person` VARCHAR(100),
  `services_offered` TEXT,
  `emergency_services_availability` BOOLEAN
);

CREATE TABLE `donor` (
  `donor_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50),
  `last_name` VARCHAR(50),
  `date_of_birth` DATE,
  `gender` ENUM ('Female', 'Male', 'Walmart Bag'),
  `contact_number` VARCHAR(15),
  `email` VARCHAR(100),
  `home_address` VARCHAR(255)
);

CREATE TABLE `donor_medical` (
  `donor_medical_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `donor_id` INT NOT NULL,
  `allergies` TEXT,
  `weight` DECIMAL(10,2),
  `blood_type` VARCHAR(3),
  `medical_condition` TEXT,
  `medical_history` TEXT,
  `insurance_details` TEXT,
  FOREIGN KEY (`donor_id`) REFERENCES `donor` (`donor_id`) ON DELETE CASCADE,
  FOREIGN KEY (`blood_type`) REFERENCES `blood` (`blood_type`) ON DELETE CASCADE
);

CREATE TABLE `patient` (
  `patient_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50),
  `last_name` VARCHAR(50),
  `date_of_birth` DATE,
  `gender` ENUM ('Female', 'Male', 'Walmart Bag'),
  `contact_number` VARCHAR(15),
  `email` VARCHAR(100),
  `home_address` VARCHAR(255)
);

CREATE TABLE `patient_medical` (
  `patient_medical_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `patient_id` INT NOT NULL,
  `blood_type` VARCHAR(3),
  `allergies` TEXT,
  `medical_condition` TEXT,
  `medical_history` TEXT,
  `insurance_details` VARCHAR(100),
  FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`) ON DELETE CASCADE,
  FOREIGN KEY (`blood_type`) REFERENCES `blood` (`blood_type`) ON DELETE CASCADE
);

CREATE TABLE `blood_transfusion` (
  `transfusion_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `patient_medical_id` INT NOT NULL,
  `hospital_id` INT,
  `private_facility_id` INT,
  `admission_date` DATE,
  `discharge_date` DATE,
  `transfusion_date` DATE,
  `room_number` VARCHAR(20),
  FOREIGN KEY (`patient_medical_id`) REFERENCES `patient_medical` (`patient_medical_id`) ON DELETE CASCADE,
  FOREIGN KEY (`private_facility_id`) REFERENCES `private_facility` (`facility_id`) ON DELETE CASCADE,
  FOREIGN KEY (`hospital_id`) REFERENCES `hospital` (`hospital_id`) ON DELETE CASCADE
);

CREATE TABLE `blood_donations` (
  `blood_donation_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `donor_medical_id` INT NOT NULL,
  `hospital_id` INT,
  `private_facility_id` INT,
  `collection_date` DATE,
  `expiry_date` DATE,
  `contaminated` BOOLEAN,
  `blood_description` TEXT,
  `component_type` VARCHAR(20),
  `anticoagulant_used` VARCHAR(50),
  `quantity` DECIMAL(10,2),
  FOREIGN KEY (`private_facility_id`) REFERENCES `private_facility` (`facility_id`) ON DELETE CASCADE,
  FOREIGN KEY (`hospital_id`) REFERENCES `hospital` (`hospital_id`) ON DELETE CASCADE,
  FOREIGN KEY (`donor_medical_id`) REFERENCES `donor_medical` (`donor_medical_id`) ON DELETE CASCADE
);

INSERT INTO blood (blood_type, compatible_types) 
VALUES 
    ('A-', 'A-,O-'),
    ('A+', 'A+,A-,O+,O-'),
    ('B-', 'B-,O-'),
    ('B+', 'B+,B-,O+,O-'),
    ('AB-', 'AB-,A-,B-,O-'),
    ('AB+', 'A+,A-,B+,B-,AB+,AB-,O-,O+'),
    ('O-', 'O-'),
    ('O+', ' O+,O-');

INSERT INTO hospital (hospital_name, address, contact_number, email, head_doctor_name, services_offered, emergency_services_availability)
VALUES
  ('City General Hospital', '123 Main St, Cityville', '555-123-4567', 'info@citygeneral.com', 'Dr. Smith', 'General Medicine, Surgery, Pediatrics', true),
  ('County Medical Center', '456 Oak St, Townsville', '555-987-6543', 'info@countymedical.com', 'Dr. Johnson', 'Cardiology, Radiology, Emergency Care', true),
  ('Suburb Health Clinic', '789 Pine St, Suburbia', '555-789-0123', 'info@suburbclinic.com', 'Dr. Williams', 'Family Medicine, Dermatology', false),
  ('Hilltop Hospital', '101 Cedar St, Hilltop', '555-456-7890', 'info@hilltophospital.com', 'Dr. Davis', 'Orthopedics, Neurology', true),
  ('Rural Medical Center', '222 Maple St, Countryside', '555-234-5678', 'info@ruralcenter.com', 'Dr. Taylor', 'Obstetrics, Gynecology', false),
  ('Downtown Medical Center', '321 Elm St, Downtown', '555-111-2222', 'info@downtownmedical.com', 'Dr. Anderson', 'Internal Medicine, Pediatrics', true),
  ('Sunset Community Hospital', '789 Sunset Blvd, Suburbia', '555-333-4444', 'info@sunsetcommunity.com', 'Dr. White', 'Emergency Care, Psychiatry', false),
  ('Riverfront General Hospital', '456 River Rd, Riverside', '555-555-5555', 'info@riverfronthospital.com', 'Dr. Miller', 'Cardiology, Orthopedics', true),
  ('Green Valley Clinic', '876 Oak St, Greenvale', '555-777-8888', 'info@greenvalleyclinic.com', 'Dr. Brown', 'Family Medicine, Dermatology', false),
  ('Harbor Medical Center', '987 Harbor Ave, Seaside', '555-999-0000', 'info@harbormedical.com', 'Dr. Moore', 'Ophthalmology, ENT', true),
  ('Unity Hospital', '555 Unity Dr, Harmony', '555-121-2121', 'info@unityhospital.com', 'Dr. Adams', 'General Surgery, Neurology', true),
  ('Mountain View Hospital', '789 Peak St, Mountaintop', '555-343-4343', 'info@mountainview.com', 'Dr. Wilson', 'Obstetrics, Gynecology', false),
  ('Central Medical Center', '123 Central Ave, Middletown', '555-565-6565', 'info@centralmedical.com', 'Dr. Garcia', 'Urology, Nephrology', true),
  ('Silver Lake Clinic', '456 Silver St, Lakeside', '555-787-8787', 'info@silverlakeclinic.com', 'Dr. Rodriguez', 'Pulmonology, Rheumatology', false),
  ('Maple Grove Hospital', '101 Maple Ln, Mapleville', '555-909-0909', 'info@maplegrovehospital.com', 'Dr. Thomas', 'Pediatric Surgery, Hematology', true);

INSERT INTO private_facility (facility_name, address, contact_number, email, contact_person, services_offered, emergency_services_availability)
VALUES
  ('Elite Care Center', '789 Oak Lane, Prestige City', '111-222-3333', 'elitecare@example.com', 'Dr. Anderson', 'Specialized Services', true),
  ('Advanced Diagnostics Hub', '456 Tech Blvd, Innovatown', '222-333-4444', 'advanceddiagnostics@example.com', 'Dr. White', 'Diagnostic Services', false),
  ('Surgical Excellence Center', '123 Main St, Medisurge City', '333-444-5555', 'surgicalexcellence@example.com', 'Dr. Miller', 'Surgical Services', true),
  ('Rapid Response Medical Center', '789 Emergency Ave, Lifesaver Town', '444-555-6666', 'rapidresponse@example.com', 'Dr. Brown', 'Emergency Services', false),
  ('Wellness Oasis Clinic', '101 Health St, Vitalityville', '555-666-7777', 'wellnessoasis@example.com', 'Dr. Taylor', 'General Medicine', true),
  ('Premium Health Hub', '321 Wellness Dr, Healthtopia', '666-777-8888', 'premiumhealthhub@example.com', 'Dr. Smith', 'Cardiology, Radiology', true),
  ('Community Health Center', '555 Harmony Ave, Serenity Town', '777-888-9999', 'communityhealth@example.com', 'Dr. Johnson', 'Family Medicine, Dermatology', false),
  ('Urgent Care Express', '876 Urgency St, Rapidville', '888-999-0000', 'urgentcare@example.com', 'Dr. Williams', 'Urgent Care Services', true),
  ('Green Life Wellness Center', '987 Nature Ln, Greenside', '999-000-1111', 'greenlifewellness@example.com', 'Dr. Davis', 'Holistic Medicine, Nutrition', false),
  ('Prestige Medical Solutions', '210 Prestige Rd, Elitemed City', '000-111-2222', 'prestigemedical@example.com', 'Dr. Martinez', 'Internal Medicine, Pediatrics', true),
  ('Health Harmony Center', '345 Serenity Blvd, Tranquil Town', '111-222-3333', 'healthharmony@example.com', 'Dr. Johnson', 'Wellness Programs, Holistic Care', true),
  ('Swift Surgical Solutions', '567 Medisurge Rd, Rapid City', '222-333-4444', 'swiftsurgery@example.com', 'Dr. Brown', 'Advanced Surgical Services', false),
  ('Urgent Health Express', '789 Urgency Ave, Rapidville', '333-444-5555', 'urgenthealth@example.com', 'Dr. White', 'Urgent Care, Emergency Services', true),
  ('Wellbeing Oasis Clinic', '901 Wellness Dr, Vitalitytown', '444-555-6666', 'wellbeingoasis@example.com', 'Dr. Taylor', 'Wellness Consultations, Nutrition', false),
  ('Elite Emergency Care', '123 Lifesaver Ln, Lifesave City', '555-666-7777', 'eliteemergency@example.com', 'Dr. Smith', 'Emergency Medicine, Critical Care', true);

INSERT INTO donor (first_name, last_name, date_of_birth, gender, contact_number, email, home_address)
VALUES
  ('John', 'Doe', '1990-05-15', 'Male', '123-456-7890', 'john.doe@example.com', '123 Main St, Cityville'),
  ('Jane', 'Smith', '1985-08-22', 'Female', '987-654-3210', 'jane.smith@example.com', '456 Oak St, Townsville'),
  ('David', 'Johnson', '1978-12-01', 'Male', '555-123-7890', 'david.johnson@example.com', '789 Pine St, Villagetown'),
  ('Emily', 'Brown', '1995-04-30', 'Female', '333-444-5555', 'emily.brown@example.com', '101 Cedar St, Hamletville'),
  ('Michael', 'Taylor', '1980-10-18', 'Male', '777-888-9999', 'michael.taylor@example.com', '222 Maple St, Countryside'),
  ('Olivia', 'Williams', '1992-09-12', 'Female', '111-222-3333', 'olivia.williams@example.com', '456 Pine St, Cityville'),
  ('Ethan', 'Jones', '1987-03-25', 'Male', '222-333-4444', 'ethan.jones@example.com', '789 Cedar St, Townsville'),
  ('Ava', 'Brown', '1975-11-30', 'Female', '333-444-5555', 'ava.brown@example.com', '101 Oak St, Suburbia'),
  ('Noah', 'Smith', '1988-04-15', 'Male', '444-555-6666', 'noah.smith@example.com', '222 Maple St, Hilltop'),
  ('Sophia', 'Johnson', '1995-08-05', 'Female', '555-666-7777', 'sophia.johnson@example.com', '345 Birch St, Countryside'),
  ('Logan', 'Davis', '1980-06-20', 'Male', '666-777-8888', 'logan.davis@example.com', '678 Elm St, Cityville'),
  ('Isabella', 'Martinez', '1993-02-18', 'Female', '777-888-9999', 'isabella.martinez@example.com', '789 Pine St, Townsville'),
  ('Mason', 'Anderson', '1982-07-12', 'Male', '888-999-0000', 'mason.anderson@example.com', '901 Oak St, Suburbia'),
  ('Aria', 'Taylor', '1990-12-05', 'Female', '999-000-1111', 'aria.taylor@example.com', '234 Cedar St, Hilltop'),
  ('Carter', 'White', '1984-04-30', 'Male', '000-111-2222', 'carter.white@example.com', '567 Maple St, Countryside');

INSERT INTO donor_medical (donor_id, blood_type, allergies, weight, medical_condition, medical_history, insurance_details)
VALUES
  (1, 'A-', 'Pollen', 68.5, 'Seasonal allergies', 'No significant medical history', 'Standard Health Insurance'),
  (2, 'A+', 'None', 72.3, 'No issues', 'No major health issues', 'Comprehensive Health Coverage'),
  (3, 'A+', 'Peanuts', 80.0, 'Nut allergy', 'General good health', 'Basic Medical Insurance'),
  (4, 'O-', 'Shellfish', 65.8, 'Shellfish allergy', 'No significant medical history', 'Standard Health Insurance'),
  (5, 'A-', 'None', 70.2, 'No issues', 'No major health issues', 'Comprehensive Health Coverage'),
  (6, 'B+', 'None', 75.9, 'No issues', 'No significant medical history', 'Basic Medical Insurance'),
  (7, 'A-', 'Latex', 82.4, 'Latex allergy', 'No major health issues', 'Comprehensive Health Coverage'),
  (8, 'AB-', 'None', 88.0, 'No issues', 'General good health', 'Basic Medical Insurance'),
  (9, 'O+', 'Pollen', 69.1, 'Seasonal allergies', 'No significant medical history', 'Standard Health Insurance'),
  (10, 'B-', 'Peanuts', 76.7, 'Nut allergy', 'No major health issues', 'Comprehensive Health Coverage'),
  (11, 'AB+', 'Pollen', 79.5, 'Seasonal allergies', 'General good health', 'Basic Medical Insurance'),
  (12, 'O-', 'Shellfish', 72.8, 'Shellfish allergy', 'No significant medical history', 'Standard Health Insurance'),
  (13, 'A-', 'None', 68.9, 'No issues', 'No major health issues', 'Comprehensive Health Coverage'),
  (14, 'B+', 'None', 74.6, 'No issues', 'General good health', 'Basic Medical Insurance'),
  (15, 'A-', 'Pollen', 77.3, 'Seasonal allergies', 'No major health issues', 'Comprehensive Health Coverage');

INSERT INTO patient (first_name, last_name, date_of_birth, gender, contact_number, email, home_address)
VALUES
  ('Mark', 'Johnson', '1982-07-12', 'Male', '555-876-5432', 'mark.johnson@example.com', '789 Oak St, Cityville'),
  ('Linda', 'Williams', '1990-03-25', 'Female', '555-567-8901', 'linda.williams@example.com', '123 Pine St, Townsville'),
  ('Robert', 'Davis', '1975-11-30', 'Male', '555-234-5678', 'robert.davis@example.com', '456 Cedar St, Suburbia'),
  ('Susan', 'Martinez', '1988-04-15', 'Female', '555-987-6543', 'susan.martinez@example.com', '101 Maple St, Hilltop'),
  ('James', 'Anderson', '1995-08-05', 'Male', '555-333-4444', 'james.anderson@example.com', '222 Birch St, Countryside'),
  ('Laura', 'Miller', '1987-12-18', 'Female', '555-111-2222', 'laura.miller@example.com', '789 Elm St, Metropolis'),
  ('William', 'Jones', '1993-06-08', 'Male', '555-444-5555', 'william.jones@example.com', '456 Pine St, Villageville'),
  ('Megan', 'Clark', '1980-02-14', 'Female', '555-999-8888', 'megan.clark@example.com', '101 Oak St, Countryside'),
  ('Brian', 'White', '1992-09-22', 'Male', '555-777-6666', 'brian.white@example.com', '222 Maple St, Cityville'),
  ('Olivia', 'Johnson', '1985-04-30', 'Female', '555-333-2222', 'olivia.johnson@example.com', '789 Cedar St, Villageville'),
  ('Christopher', 'Anderson', '1997-11-15', 'Male', '555-222-1111', 'christopher.anderson@example.com', '456 Birch St, Metropolis'),
  ('Amanda', 'Lee', '1983-08-10', 'Female', '555-666-7777', 'amanda.lee@example.com', '101 Spruce St, Countryside'),
  ('Daniel', 'Young', '1990-03-25', 'Male', '555-888-9999', 'daniel.young@example.com', '222 Pine St, Cityville'),
  ('Sophia', 'Moore', '1988-06-12', 'Female', '555-111-3333', 'sophia.moore@example.com', '789 Elm St, Townsville'),
  ('Jackson', 'Baker', '1994-01-08', 'Male', '555-555-5555', 'jackson.baker@example.com', '456 Oak St, Metropolis');

INSERT INTO patient_medical (patient_id, blood_type, allergies, medical_condition, medical_history, insurance_details)
VALUES
  (1, 'A+', 'Pollen', 'Fractured leg', 'No major health issues', 'Comprehensive Health Coverage'),
  (2, 'AB+', 'Pollen', 'Respiratory infection', 'Asthma', 'Chronic Illness Plan'),
  (3, 'B-', 'Penicillin', 'Heart attack', 'Hypertension', 'Cardiac Care Insurance'),
  (4, 'O-', 'Shellfish', 'Food poisoning', 'No major health issues', 'Standard Health Insurance'),
  (5, 'AB-', 'Peanuts', 'Anemia', 'Iron deficiency', 'Anemia Management Coverage'),
  (6, 'B+', 'Latex', 'Broken arm', 'Previous fracture history', 'Orthopedic Care Plan'),
  (7, 'AB+', 'Penicillin', 'Influenza', 'No major health issues', 'Comprehensive Health Coverage'),
  (8, 'B-', 'Latex', 'Stroke', 'History of hypertension', 'Vascular Health Insurance'),
  (9, 'O-', 'Pollen', 'Allergic reaction', 'No major health issues', 'Standard Health Insurance'),
  (10, 'AB-', 'Pollen', 'Diabetes management', 'Type 2 diabetes', 'Diabetes Care Insurance'),
  (11, 'A-', 'Pollen', 'Concussion', 'Head injury', 'Head Trauma Protection Plan'),
  (12, 'B-', 'Penicillin', 'Kidney infection', 'No major health issues', 'Standard Health Insurance'),
  (13, 'A-', 'Peanuts', 'Appendicitis', 'No major health issues', 'Standard Health Insurance'),
  (14, 'A+', 'Shellfish', 'Pneumonia', 'No major health issues', 'Standard Health Insurance'),
  (15, 'A-', 'Pollen', 'Hernia repair', 'No major health issues', 'Standard Health Insurance');

INSERT INTO blood_transfusion (patient_medical_id, hospital_id, private_facility_id, admission_date, discharge_date, transfusion_date)
VALUES
  (1, NULL, 1, '2022-06-01', '2022-06-10', '2022-06-07'),
  (2, NULL, 1, '2022-07-15', '2022-07-25', '2022-07-21'),
  (3, NULL, 2, '2022-08-20', '2022-08-30', '2022-08-22'),
  (4, NULL, 3, '2022-09-10', '2022-09-20', '2022-09-11'),
  (5, NULL, 4, '2022-10-05', '2022-10-15', '2022-10-12'),
  (6, 1, NULL, '2022-11-01', '2022-11-10', '2022-11-07'),
  (7, 3, NULL, '2022-12-15', '2022-12-25', '2022-12-16'),
  (8, 3, NULL, '2023-01-20', '2023-01-30', '2023-01-21'),
  (9, 4, NULL, '2023-02-10', '2023-02-20', '2023-02-16'),
  (10, 5, NULL, '2023-03-05', '2023-03-15', '2023-03-06'),
  (11, 1, NULL, '2023-04-01', '2023-04-10', '2023-04-12'),
  (12, 2, NULL, '2023-05-15', '2023-05-25', '2023-05-16'),
  (13, 1, NULL, '2023-06-10', '2023-06-20', '2023-06-12'),
  (14, 4, NULL, '2023-07-05', '2023-07-15', '2023-07-13'),
  (15, 5, NULL, '2023-08-20', '2023-08-30', '2023-08-22');

INSERT INTO blood_donations (donor_medical_id, hospital_id, private_facility_id, collection_date, expiry_date, contaminated, blood_description, component_type, anticoagulant_used, quantity)
VALUES
  (1, 1, NULL, '2023-01-15', '2023-02-15',  false, 'Whole blood donation', 'Whole Blood', 'CPD-A', 350),
  (1, NULL, 2, '2023-02-22', '2023-03-22',  false, 'Plasma donation', 'Plasma', 'ACD-A', 400),
  (2, 1, NULL, '2023-01-20', '2023-02-20',  false, 'Platelet donation', 'Platelets', 'CPDA-1', 200),
  (3, NULL, 1, '2023-02-01', '2023-03-01',  true, 'Contaminated blood', 'Whole Blood', 'CPD-A',400),
  (4, NULL, 1, '2023-02-10', '2023-03-10', false, 'Red blood cell donation', 'Red Blood Cells', 'CPDA-1',250),
  (5, 2, NULL, '2023-02-15', '2023-03-15', false, 'Platelet donation', 'Platelets', 'CPDA-1', 250),
  (5, NULL, 6, '2023-03-28', '2023-04-28', false, 'Whole blood donation', 'Whole Blood', 'ACD-A', 500),
  (7, 7, NULL, '2023-03-05', '2023-04-05', false, 'Red blood cell donation', 'Red Blood Cells', 'CPDA-1', 300),
  (8, NULL, 8, '2023-03-10', '2023-04-10', false, 'Plasma donation', 'Plasma', 'ACD-A', 400),
  (9, 3, NULL, '2023-03-15', '2023-04-15', true, 'Contaminated blood', 'Whole Blood', 'CPD-A', 600),
  (1, 1, NULL, '2023-03-20', '2023-04-20',  false, 'Plasma donation', 'Plasma', 'ACD-A', 350),
  (2, NULL, 2, '2023-04-22', '2023-04-22', true, 'Contaminated blood', 'Whole Blood', 'CPD-A', 450),
  (3, 1, NULL, '2023-04-24', '2023-04-24',  false, 'Whole blood donation', 'Whole Blood', 'CPDA-1', 550),
  (4, 2, NULL, '2023-05-25', '2023-05-25', false, 'Platelet donation', 'Platelets', 'CPDA-1', 280),
  (12, 3, NULL, '2023-06-26', '2023-06-26',  false, 'Whole blood donation', 'Whole Blood', 'ACD-A',  370),
  (10, 5, NULL, '2023-07-27', '2023-07-27', false, 'Platelet donation', 'Platelets', 'CPDA-1', 470),
  (8, NULL, 1, '2023-08-20', '2023-08-20', false, 'Red blood cell donation', 'Red Blood Cells', 'CPDA-1', 180);
