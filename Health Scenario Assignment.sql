
CREATE DATABASE HospitalDB;

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    PhoneNumber VARCHAR(15));
    
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialty VARCHAR(100),
    PhoneNumber VARCHAR(15));

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    AppointmentTime TIME,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID));
    
CREATE TABLE Medications (
    MedicationID INT PRIMARY KEY,
    PatientID INT,
    MedicationName VARCHAR(100),
    Dosage VARCHAR(50),
    PrescribedDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID));

CREATE TABLE Billing (
    BillID INT PRIMARY KEY,
    AppointmentID INT,
    Amount DECIMAL(10, 2),
    PaymentStatus VARCHAR(20),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID));
    
INSERT INTO Patients (PatientID, FirstName, LastName, DateOfBirth, PhoneNumber) VALUES
   (1001, 'Grace', 'Joe', '1995-03-22', '123-456-7891'),
   (1002, 'Aisha', 'Sani', '1987-07-15', '123-456-7892'),
   (1003, 'Usman', 'Brown', '1990-01-10', '123-456-7893'),
   (1004, 'James', 'Prince', '1985-09-25', '123-456-7894'),
   (1005, 'Musa', 'Isah', '1992-11-30', '123-456-7895');

INSERT INTO Doctors (DoctorID, FirstName, LastName, Specialty, PhoneNumber) VALUES
   (2001, 'Blessing', 'Doe', 'Pediatrics', '123-456-7800'),
   (2002, 'Aminah', 'Musa', 'General Practice', '123-456-7801'),
   (2003, 'Halima', 'Abdullahi', 'Dermatology', '123-456-7802'),
   (2004, 'Sadiya', 'Abubakar', 'Diagnostic Medicine', '123-456-7803'),
   (2005, 'Edith', 'Grey', 'Surgery', '123-456-7804');

INSERT INTO Appointments (AppointmentID, PatientID, DoctorID, AppointmentDate, AppointmentTime) VALUES
   (3001, 1001, 2002, '2024-11-20', '10:00:00'),
   (3002, 1002, 2004, '2024-11-21', '11:30:00'),
   (3003, 1003, 2001, '2024-12-01', '09:00:00'),
   (3004, 1004, 2005, '2024-11-25', '14:00:00'),
   (3005, 1005, 2003, '2024-11-22', '13:00:00');
   
INSERT INTO Medications (MedicationID, PatientID, MedicationName, Dosage, PrescribedDate) VALUES
   (4001, 1001, 'Amoxicillin', '500mg', '2024-11-10'),
   (4002, 1002, 'Paracetamol', '200mg', '2024-11-15'),
   (4003, 1003, 'ORS', '1000mg', '2024-11-18'),
   (4004, 1004, 'Zinc', '50mg', '2024-11-12'),
   (4005, 1005, 'Folic acid', '20mg', '2024-11-05');
   
INSERT INTO Billing (BillID, AppointmentID, Amount, PaymentStatus) VALUES
   (5001, 3001, 3000, 'Paid'),
   (5002, 302, 2000, 'Unpaid'),
   (5003, 3003, 1000, 'Paid'),
   (5004, 3004, 250, 'Unpaid'),
   (5005, 3005, 500, 'Pending');
   
INSERT INTO Patients (PatientID, FirstName, LastName, DateOfBirth, PhoneNumber) VALUES
   (1006, 'John', 'Smith', '1990-05-15', '123-456-7890');

UPDATE Patients SET PhoneNumber = '987-654-3210' 
WHERE FirstName = 'John' AND LastName = 'Smith';

UPDATE Doctors SET Specialty = 'Cardiologist' 
WHERE FirstName = 'Jane' AND LastName = 'Doe';


UPDATE Appointments SET AppointmentDate = '2024-12-01' WHERE AppointmentID = 3003;

SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM Patients WHERE PatientID = 1004;
SET FOREIGN_KEY_CHECKS = 1;

DELETE FROM Doctors WHERE DoctorID = 2002;

DELETE FROM Medications;

SELECT * FROM Patients WHERE DateOfBirth > '2000-01-01';

SELECT * FROM Doctors WHERE Specialty = 'Pediatrics';

SELECT * FROM Appointments WHERE AppointmentDate = '2024-11-20';

SELECT * FROM Patients ORDER BY LastName ASC;

SELECT Meds.* FROM Medications Meds
JOIN Patients P ON Meds.PatientID = P.PatientID
WHERE P.FirstName = 'John' AND P.LastName = 'Smith'
ORDER BY Meds.PrescribedDate DESC;

SELECT * FROM Patients WHERE LastName LIKE 'A%';

SELECT * FROM Appointments 
WHERE AppointmentDate BETWEEN '2024-11-01' AND '2024-12-31';

SELECT * FROM Doctors WHERE Specialty LIKE '%surgery%';

SELECT * FROM Medications WHERE Dosage = '500mg' IN ('500mg', '1000mg');

SELECT * FROM Patients 
WHERE PhoneNumber IN ('123-456-7890', '987-654-3210');

SELECT COUNT(*) AS TotalPatients FROM Patients;

SELECT AVG(Amount) AS AverageAmount FROM Billing;

SELECT MAX(Amount) AS MaxAmount
FROM Billing;

SELECT SUM(Amount) AS Total
FROM Billing;

SELECT MedicationName, COUNT(*) AS Meds_count
FROM Medications
GROUP BY MedicationName;

SELECT Specialty, COUNT(*) AS Doctor_count
FROM Doctors
GROUP BY Specialty
HAVING COUNT(*) > 3;

SELECT PaymentStatus, SUM(Amount) AS TotalAmount
FROM Billing
GROUP BY PaymentStatus;

SELECT p.FirstName, p.LastName, a.AppointmentDate
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID;

SELECT d.FirstName, d.LastName, a.AppointmentTime
FROM Appointments a
JOIN Doctors d ON a.DoctorID = d.DoctorID;

SELECT a.AppointmentDate, a.AppointmentTime
FROM Appointments a
INNER JOIN Doctors d ON a.DoctorID = d.DoctorID
WHERE d.FirstName = 'Jane' AND d.LastName = 'Doe';

SELECT p.FirstName AS Patient_FirstName, p.LastName AS Patient_LastName, 
       d.FirstName AS Doctor_FirstName, d.LastName AS Doctor_LastName
FROM Appointments a
JOIN Patients p ON a.PatientID = p.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID;

SELECT p.FirstName AS Patient_FirstName, p.LastName AS Patient_LastName, a.AppointmentDate
FROM Patients p
LEFT JOIN Appointments a ON p.PatientID = a.PatientID;

SELECT d.FirstName AS Doctor_FirstName, d.LastName AS Doctor_LastName, p.FirstName AS Patient_FirstName, p.LastName AS Patient_LastName
FROM Doctors d
RIGHT JOIN Appointments a ON d.DoctorID = a.DoctorID
LEFT JOIN Patients p ON a.PatientID = p.PatientID;

SELECT p.FirstName AS Patient_FirstName, p.LastName AS Patient_LastName, 
       d.FirstName AS Doctor_FirstName, d.LastName AS Doctor_LastName
FROM Patients p
LEFT JOIN Appointments a ON p.PatientID = a.PatientID
LEFT JOIN Doctors d ON a.DoctorID = d.DoctorID

UNION

SELECT p.FirstName AS Patient_FirstName, p.LastName AS Patient_LastName, 
       d.FirstName AS Doctor_FirstName, d.LastName AS Doctor_LastName
FROM Doctors d
LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID
LEFT JOIN Patients p ON a.PatientID = p.PatientID;

SELECT p.FirstName, p.LastName
FROM Patients p
LEFT JOIN Appointments a ON p.PatientID = a.PatientID
WHERE a.AppointmentID IS NULL;

SELECT FirstName, LastName
FROM Doctors
WHERE DoctorID IN (
    SELECT DISTINCT DoctorID
    FROM Appointments
    WHERE AppointmentDate = '2024-11-15');

SELECT MedicationName, PrescribedDate
FROM Medications
WHERE PatientID = 1004
ORDER BY PrescribedDate DESC
LIMIT 1;


CREATE VIEW DoctorAppointments AS
SELECT d.DoctorID, d.FirstName, d.LastName, COUNT(a.AppointmentID) AS Number_Of_appointments
FROM Doctors d
LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID, d.FirstName, d.LastName;

SELECT * FROM DoctorAppointments;

DROP VIEW DoctorAppointments;

START TRANSACTION;
UPDATE Billing
SET Amount = 3000
WHERE BillID = 1;

ROLLBACK;  

START TRANSACTION;
INSERT INTO Medications (PatientID, MedicationName, Dosage, PrescribedDate)
VALUES (1, 'SP', '500mg', '2024-11-13');

COMMIT; 

CREATE INDEX idx_phone_number ON Patients (PhoneNumber);

DROP INDEX idx_phone_number ON Patients;

ALTER TABLE Doctors
MODIFY Specialty VARCHAR(100) NOT NULL;

ALTER TABLE Patients
ADD CONSTRAINT unique_email UNIQUE (Email);

ALTER TABLE Billing
ADD CONSTRAINT check_amount CHECK (Amount > 0);

SELECT d.FirstName, d.LastName, COUNT(a.AppointmentID) AS Number_Of_appointments
FROM Doctors d
LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID, d.FirstName, d.LastName;

SELECT Specialty, COUNT(*) AS Specialty_Count
FROM Doctors
GROUP BY Specialty
ORDER BY Specialty_Count DESC
LIMIT 1;

SELECT AVG(TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE())) AS Average_Age
FROM Patients;

SELECT p.FirstName, p.LastName
FROM Patients p
JOIN Medications m ON p.PatientID = m.PatientID
GROUP BY p.PatientID
HAVING COUNT(DISTINCT m.MedicationName) > 3;

SELECT p.FirstName, p.LastName
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID
GROUP BY p.PatientID
HAVING COUNT(DISTINCT a.DoctorID) > 1;

SELECT p.FirstName AS PatientFirstName, p.LastName AS PatientLastName,
       d.FirstName AS DoctorFirstName, d.LastName AS DoctorLastName,
       SUM(b.Amount) AS TotalBilled
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID
JOIN Billing b ON a.AppointmentID = b.AppointmentID
GROUP BY p.PatientID, d.DoctorID;

UPDATE Billing
SET PaymentStatus = 'Paid'
WHERE Amount < 1000;

DELETE FROM Appointments
WHERE AppointmentDate < CURDATE();

SELECT * FROM Appointments
WHERE AppointmentDate = CURDATE();

SELECT FirstName, LastName, 
       TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) AS Age
FROM Patients;

SELECT * FROM Appointments
WHERE AppointmentDate BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY);