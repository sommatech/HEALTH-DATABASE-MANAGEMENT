# HEALTH-DATABASE-MANAGEMENT

  This database is use to organize, store, and fetch data related to patients, doctors, specialization, and states, enabling the health sector to generate valuable insights of the patient details. This design is established to handle the creation and management of a database system designed to track and handle patient records and details in an health organization (hospital).
**Report of the Health Database** 
  
  The project involves a sequential approach of analyzing the hospital database design and implementing the design of different patients.
  
1.	**Creation of Tables and Data Insertion**: tables were created using the necessary procedure and data were inserted into the various tables for easy identification.

2.	**Patient Age Analysis**:  fetches patients with the same age, providing valuable insights into potential patients from its their age status for standardization. Retrieves the second-oldest patient with the doctor and department (specialization) that is responsible for his or her treatment for easy identification.

3.	 **Doctor-Patient Retrieval**: Provides a count of patients managed by each doctor, sorted by the number of doctors, which helps in proper accountabity and managing of the patient.

5.	**Row-Based Data Retrieval**: fetching the patient first and name with their age selecting only odd-numbered rows, demonstrating data filtering capabilities which could be useful for sampling or segmented reporting

6.	**Create view for the table**: the view implementation is use to extract the patients of a certain age for clarification which is use for health organization.

7.	**Stored Procedure Implementation**: Procedures were developed to automate doctor and department of a certain patient, including updating patient’s department, doctors and state details or records with error handling.

**Project Impact of business******

  	Enhanced Data Organization: The well-structured database facilitates efficient data management, minimizes unnecessary repetition or duplication of data within a system, and It ensures that the data remains correct and unaltered during storage, retrieval, and processing.

  	Maximize Inventory management: The database design gives room for efficient tracking and management of patients’ recovery level by tracking the doctor’s and the department responsible for the patient treatment.
  
  	Decision-Making improvement: Advanced queries offer valuable insights into patients’ treatment, the department they are taking their treatment from, and doctors’ progress on the patient, and the state which helps in supporting strategic decision-making.
  
  	Streamlined Processes: Stored procedures streamline routine tasks like updating patient recovery rates and generating reports, enhancing operational efficiency and minimizing database errors.


  The tools used are:
    SQLProgramming, Database Design, Stored Procedure, Views, Logical Reporting.
  
  	Enhanced Clarity: The database structure facilitates tracking of patient data and doctor data for ensuring greater transparency and accountability in health sector.
