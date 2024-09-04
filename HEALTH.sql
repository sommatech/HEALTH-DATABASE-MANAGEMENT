

CREATE DATABASE Healthcare_PatientDb;

USE Healthcare_PatientDb;

CREATE TABLE Patient(
      [PatientID] NVARCHAR(20), 
	  [PatientName] NVARCHAR(30), 
	  [Age] INT,
	  [Gender] NVARCHAR(3), 
	  [DoctorID] INT,
	  [StateID] INT
	  );

INSERT INTO Patient(PatientID, PatientName, Age, Gender, DoctorID, StateID)
VALUES   
     ('PT01','John Doe', '45', 'M', '1', '101'),
     ('PT02', 'Jane Smith','30', 'F','2', '102'), 
     ('PT03', 'Mercy johnson', '60', 'F','3', '103'),
     ('PT04', 'Michael Brown', '50', 'M','4', '104'),
     ('PT05', 'Patricia Davis', '40', 'F','1', '105'),
     ('PT06', 'Robert Miller', '55', 'M','2', '106'),
	 ('PT07', 'Linda Wilson', '35', 'F','3', '107'),
     ('PT08', 'William Moore', '65', 'M','4', '108'),
	 ('PT09', 'Barbara Taylor', '28', 'F','1', '109'),
	 ('PT10', 'James Anderson', '70','M','2', '110');



CREATE TABLE Doctor
(
     [DoctorID] INT,
	  [DoctorName] NVARCHAR(20),
	  [Specialization] NVARCHAR(30)
	  );

INSERT INTO Doctor (DoctorID, DoctorName,Specialization)
VALUES  
	('1', 'Dr. Smith', 'Cardiology'),
	('2', 'Dr. Adams', 'Neurology'),
	('3', 'Dr. White','Orthopedics'),
	('4', 'Dr. Johnson', 'Dermatology');


CREATE TABLE State_master
(
	 [StateID] INT,
	 [StateName] NVARCHAR(20)
	 );

INSERT INTO State_master(StateID, StateName)
VALUES  
	('101', 'Lagos'),
	('102', 'Abuja'),
	('103', 'Kano'),
	('104', 'Delta'),
	('105','Ido'),
	('106','Ibadan'),
	('107','Enugu'),
	('108','Kaduna'),
	('109','Ogun'),
	('110','Anambra');




CREATE TABLE  Depart_ment
(
       [DepartmentID] INT,
	   [DepartmentName] NVARCHAR(30)
	  );

INSERT INTO  Depart_ment(DepartmentID, DepartmentName)
VALUES
    ('1', 'Cardiology'),
	('2','Neurology'),
	('3','Orthopedics'),
	('4', 'Dermatology');


----------------1. write a SQL query to fetch products with the same Age
	
SELECT * 
FROM Patient
WHERE Age IN (
   SELECT (Age)
   FROM Patient
   GROUP BY Age
   HAVING COUNT (Age) > 1
);


----------------2. write a SQL query to fetch find the second oldest patient and their doctor and department..
 
SELECT PT.PatientID, PT.PatientName,PT.Age,D.DoctorName
FROM Patient PT
INNER JOIN Doctor D
ON PT.DoctorID = d.DoctorID
ORDER BY Age DESC
OFFSET  1 ROW
FETCH NEXT 1 ROW ONLY



----------------3. write a query to get the maximum age per department and the patient name.

SELECT PT.PatientName, PT.Age MAXAge, DM.DepartmentName
FROM  Patient PT
JOIN Doctor D
ON  PT.DoctorID = D.DoctorID
JOIN Depart_ment DM 
ON D.DoctorID = DM.DepartmentID
JOIN (SELECT PT.DoctorID, MAX (Age) AS MAXAge
FROM Patient PT
GROUP BY DoctorID) M ON D.DoctorID = D.DoctorID
AND PT. Age = MAXAge
 
 

 -------------4. write a query to fetch doctor-wise count of patients sorted by count in descending order.

 SELECT COUNT(DISTINCT PT.PatientName) count_of_dw, PT.DoctorID, D.DoctorName
 FROM Patient PT, Doctor D
 WHERE PT.DoctorID = D.DoctorID 
 GROUP BY PT.DoctorID, D.DoctorName 
 ORDER BY COUNT(*) DESC


 
 -------------5.query to fetch only the first name from the PatientName and append the age.
SELECT CONCAT(LEFT(PatientName,
        CHARINDEX (' ',PatientName )-1), '_',Age) FirstName_Age
FROM Patient PT


--------------6. query to fetch patients with odd ages.
SELECT PatientName, Age FROM Patient PT
WHERE Age % 2 = 1

----------------7. Create a view to fetch patient details with an age greater than 50
CREATE VIEW vw_pt_age_50 
AS
 SELECT PT.PatientID, PT.PatientName,PT.Age, PT.Gender, DM.DepartmentName, SM.StateID
 FROM Patient PT
 INNER JOIN Doctor D 
 ON PT.DoctorID = D.DoctorID
INNER JOIN State_master SM 
 ON PT.StateID = SM.StateID
 INNER JOIN Depart_ment DM 
 ON D.DoctorID = DM.DepartmentID
 WHERE PT.Age > 50
SELECT*FROM vw_pt_age_50 

---------------8.Create a procedure to update the patient's age by 10% where the department is 'Cardiology' and the doctor is not 'Dr. Smith'.

CREATE PROCEDURE PatientAgerise
AS
 BEGIN 
	UPDATE PT
	SET PT.Age = PT.Age * 1.10
	FROM Patient PT
	INNER JOIN Doctor D ON PT.DoctorID = D.DoctorID
	INNER JOIN Depart_ment DM ON D.DoctorID = DM.DepartmentID
	WHERE DM.DepartmentName ='Cardiology' 
	  AND D.DoctorName NOT IN ('Dr. Smith');
END
GO;
EXEC PatientAgerise;
GO 


-------------9.Create a stored procedure to fetch patient details along with their doctor, department, and state, including error handling.

CREATE PROCEDURE sp_fetch_testabl_details
AS
BEGIN
    BEGIN TRY
        SELECT 
            PT.PatientID,
			PT.PatientName,
			PT.Age,
            D.DoctorName,
			DM.DepartmentName,
			SM.StateName
        FROM Patient PT
        INNER JOIN Doctor D ON D.DoctorID = PT.DoctorID
        INNER JOIN Depart_ment DM ON D.DoctorID = DM.DepartmentID
        INNER JOIN State_Master SM ON PT.StateID = SM.StateID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(500)
		SET @ErrorMessage = ERROR_MESSAGE()
        RAISERROR (@ErrorMessage, 16,1);
    END CATCH
END;
GO