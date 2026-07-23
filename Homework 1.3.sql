-- TASK 1.3 MAHAMMAD RASULOV






--  CREATE TABLE

CREATE TABLE DEPARTMENTS (
    DepartmentID NUMBER DEFAULT SEQ_DEPARTMENT.NEXTVAL,
    DeptCode VARCHAR2(10) NOT NULL,
    DeptName VARCHAR2(50) NOT NULL,
    FloorNumber NUMBER(3) NOT NULL,
    Phone VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_Departments PRIMARY KEY (DepartmentID),
    CONSTRAINT UQ_Dept_Code UNIQUE (DeptCode),
    CONSTRAINT CK_Dept_Floor CHECK (FloorNumber >= 0)
);

CREATE TABLE DOCTORS (
    DoctorID NUMBER DEFAULT SEQ_DOCTOR.NEXTVAL,
    DepartmentID NUMBER NOT NULL,
    LicenseNo VARCHAR2(20) NOT NULL,
    FirstName VARCHAR2(50) NOT NULL,
    LastName VARCHAR2(50) NOT NULL,
    Specialty VARCHAR2(50) NOT NULL,
    Phone VARCHAR2(20) NOT NULL,
    Email VARCHAR2(100) NOT NULL,
    WorkingHours VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_Doctors PRIMARY KEY (DoctorID),
    CONSTRAINT UQ_Doctor_License UNIQUE (LicenseNo),
    CONSTRAINT UQ_Doctor_Email UNIQUE (Email),
    CONSTRAINT FK_Doctor_Dept FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENTS(DepartmentID)
);

CREATE TABLE PATIENTS (
    PatientID NUMBER DEFAULT SEQ_PATIENT.NEXTVAL,
    NationalID VARCHAR2(20) NOT NULL,
    FirstName VARCHAR2(50) NOT NULL,
    LastName VARCHAR2(50) NOT NULL,
    BirthDate DATE NOT NULL,
    Gender VARCHAR2(10) NOT NULL,
    Phone VARCHAR2(20) NOT NULL,
    Address VARCHAR2(200) NOT NULL,
    BloodType VARCHAR2(5) NOT NULL,
    EmergencyContact VARCHAR2(100) NOT NULL,
    CONSTRAINT PK_Patients PRIMARY KEY (PatientID),
    CONSTRAINT UQ_Patient_NationalID UNIQUE (NationalID),
    CONSTRAINT CK_Patient_Gender CHECK (Gender IN ('Male','Female','Other')),
    CONSTRAINT CK_Patient_BloodType CHECK (BloodType IN ('A+','A-','B+','B-','AB+','AB-','O+','O-'))
);

CREATE TABLE APPOINTMENTS (
    AppointmentID NUMBER DEFAULT SEQ_APPOINTMENT.NEXTVAL,
    PatientID NUMBER NOT NULL,
    DoctorID NUMBER NOT NULL,
    AppDateTime DATE NOT NULL,
    Status VARCHAR2(20) DEFAULT 'Scheduled' NOT NULL,
    ComplaintNote VARCHAR2(500) NULL,
    CONSTRAINT PK_Appointments PRIMARY KEY (AppointmentID),
    CONSTRAINT CK_Appt_Status CHECK (Status IN ('Scheduled','Completed','Cancelled')),
    CONSTRAINT FK_Appt_Patient FOREIGN KEY (PatientID) REFERENCES PATIENTS(PatientID),
    CONSTRAINT FK_Appt_Doctor FOREIGN KEY (DoctorID) REFERENCES DOCTORS(DoctorID)
);

CREATE TABLE EXAMINATIONS (
    ExamID NUMBER DEFAULT SEQ_EXAM.NEXTVAL,
    AppointmentID NUMBER NOT NULL,
    Diagnosis VARCHAR2(200) NOT NULL,
    TreatmentPlan VARCHAR2(500) NOT NULL,
    ExamDate DATE NOT NULL,
    Fee NUMBER(10,2) NOT NULL,
    CONSTRAINT PK_Examinations PRIMARY KEY (ExamID),
    CONSTRAINT UQ_Exam_Appt UNIQUE (AppointmentID),
    CONSTRAINT CK_Exam_Fee CHECK (Fee >= 0),
    CONSTRAINT FK_Exam_Appt FOREIGN KEY (AppointmentID) REFERENCES APPOINTMENTS(AppointmentID)
);

CREATE TABLE MEDICATIONS (
    MedicationID NUMBER DEFAULT SEQ_MEDICATION.NEXTVAL,
    Barcode VARCHAR2(50) NOT NULL,
    MedName VARCHAR2(100) NOT NULL,
    Dosage VARCHAR2(50) NOT NULL,
    Instructions VARCHAR2(300) NOT NULL,
    CONSTRAINT PK_Medications PRIMARY KEY (MedicationID),
    CONSTRAINT UQ_Med_Barcode UNIQUE (Barcode)
);

CREATE TABLE PRESCRIPTION (
    ExamID NUMBER NOT NULL,
    MedicationID NUMBER NOT NULL,
    Quantity NUMBER NOT NULL,
    DurationDays NUMBER NOT NULL,
    CONSTRAINT PK_Prescription PRIMARY KEY (ExamID, MedicationID),
    CONSTRAINT CK_Presc_Qty CHECK (Quantity > 0),
    CONSTRAINT CK_Presc_Days CHECK (DurationDays > 0),
    CONSTRAINT FK_Presc_Exam FOREIGN KEY (ExamID) REFERENCES EXAMINATIONS(ExamID),
    CONSTRAINT FK_Presc_Med FOREIGN KEY (MedicationID) REFERENCES MEDICATIONS(MedicationID)
);


--  CREATE INDEXES


CREATE INDEX IX_Appt_DateTime     ON APPOINTMENTS (AppDateTime);
CREATE INDEX IX_Appt_DoctorID     ON APPOINTMENTS (DoctorID);
CREATE INDEX IX_Appt_PatientID    ON APPOINTMENTS (PatientID);
CREATE INDEX IX_Med_MedName       ON MEDICATIONS  (MedName);\








INSERT INTO DEPARTMENTS (DepartmentID, DeptCode, DeptName, FloorNumber, Phone)
VALUES (1, 'CARD', 'Kardiologiya', 3, '+994-12-404-1111');
 
INSERT INTO DEPARTMENTS (DepartmentID, DeptCode, DeptName, FloorNumber, Phone)
VALUES (2, 'NEURO', 'Nevrologiya', 2, '+994-12-404-2222');
 
INSERT INTO DEPARTMENTS (DepartmentID, DeptCode, DeptName, FloorNumber, Phone)
VALUES (3, 'ORTHO', 'Ortopediya', 4, '+994-12-404-3333');
 
INSERT INTO DEPARTMENTS (DepartmentID, DeptCode, DeptName, FloorNumber, Phone)
VALUES (4, 'DERM', 'Dermatologiya', 1, '+994-12-404-4444');
 
INSERT INTO DEPARTMENTS (DepartmentID, DeptCode, DeptName, FloorNumber, Phone)
VALUES (5, 'PEDIA', 'Pediatriya', 5, '+994-12-404-5555');
 
INSERT INTO DEPARTMENTS (DepartmentID, DeptCode, DeptName, FloorNumber, Phone)
VALUES (6, 'PSYCH', 'Psixiatriya', 6, '+994-12-404-6666');
 
COMMIT;
 
-- =====================================================
-- 2. DOCTORS CƏDVƏLINƏ VERİLƏNLƏR
-- (DepartmentID FK referensi ilə)
-- =====================================================
 
INSERT INTO DOCTORS (DoctorID, DepartmentID, LicenseNo, FirstName, LastName, Specialty, Phone, Email, WorkingHours)
VALUES (1, 1, 'LIC-2020-001', 'Rəfael', 'Hüseynov', 'Cardiolog', '+994-50-123-4567', 'rafael.huseynov@hospital.az', '08:00-16:00');
 
INSERT INTO DOCTORS (DoctorID, DepartmentID, LicenseNo, FirstName, LastName, Specialty, Phone, Email, WorkingHours)
VALUES (2, 1, 'LIC-2020-002', 'Leyla', 'Məmmədova', 'Cardiolog', '+994-50-223-4567', 'leyla.mammadova@hospital.az', '10:00-18:00');
 
INSERT INTO DOCTORS (DoctorID, DepartmentID, LicenseNo, FirstName, LastName, Specialty, Phone, Email, WorkingHours)
VALUES (3, 2, 'LIC-2020-003', 'Elçin', 'Qasımov', 'Neurolog', '+994-50-323-4567', 'elchin.gasimov@hospital.az', '08:00-16:00');
 
INSERT INTO DOCTORS (DoctorID, DepartmentID, LicenseNo, FirstName, LastName, Specialty, Phone, Email, WorkingHours)
VALUES (4, 2, 'LIC-2020-004', 'Zəfər', 'Ağayev', 'Neurolog', '+994-50-423-4567', 'zafer.agayev@hospital.az', '12:00-20:00');
 
INSERT INTO DOCTORS (DoctorID, DepartmentID, LicenseNo, FirstName, LastName, Specialty, Phone, Email, WorkingHours)
VALUES (5, 3, 'LIC-2020-005', 'Elmira', 'Məmmədzadə', 'Ortoped', '+994-50-523-4567', 'elmira.mammadzade@hospital.az', '09:00-17:00');
 
INSERT INTO DOCTORS (DoctorID, DepartmentID, LicenseNo, FirstName, LastName, Specialty, Phone, Email, WorkingHours)
VALUES (6, 3, 'LIC-2020-006', 'Kamran', 'Nəbiyev', 'Ortoped', '+994-50-623-4567', 'kamran.nabiyev@hospital.az', '08:00-16:00');
 
INSERT INTO DOCTORS (DoctorID, DepartmentID, LicenseNo, FirstName, LastName, Specialty, Phone, Email, WorkingHours)
VALUES (7, 4, 'LIC-2020-007', 'Sona', 'Suleymanova', 'Dermatolog', '+994-50-723-4567', 'sona.suleymanova@hospital.az', '10:00-18:00');
 
INSERT INTO DOCTORS (DoctorID, DepartmentID, LicenseNo, FirstName, LastName, Specialty, Phone, Email, WorkingHours)
VALUES (8, 4, 'LIC-2020-008', 'Vəli', 'Əhmədov', 'Dermatolog', '+994-50-823-4567', 'vali.ahmadov@hospital.az', '09:00-17:00');
 
INSERT INTO DOCTORS (DoctorID, DepartmentID, LicenseNo, FirstName, LastName, Specialty, Phone, Email, WorkingHours)
VALUES (9, 5, 'LIC-2020-009', 'Aysel', 'Quliyeva', 'Pediatr', '+994-50-923-4567', 'aysel.guliyeva@hospital.az', '08:00-16:00');
 
INSERT INTO DOCTORS (DoctorID, DepartmentID, LicenseNo, FirstName, LastName, Specialty, Phone, Email, WorkingHours)
VALUES (10, 6, 'LIC-2020-010', 'Araz', 'İbrahimov', 'Psixiyatrist', '+994-51-023-4567', 'araz.ibrahimov@hospital.az', '10:00-18:00');
 
COMMIT;
 
-- =====================================================
-- 3. PATIENTS CƏDVƏLINƏ VERİLƏNLƏR
-- =====================================================
 
INSERT INTO PATIENTS (PatientID, NationalID, FirstName, LastName, BirthDate, Gender, Phone, Address, BloodType, EmergencyContact)
VALUES (1, '1AB123456789', 'Mübariz', 'Həsənov', TO_DATE('1980-05-15', 'YYYY-MM-DD'), 'Male', '+994-50-111-1111', 'Bakı, Nizami rayonu, Ə.Hacıyev 123', 'O+', 'Sevinc Həsənova +994-50-111-1112');
 
INSERT INTO PATIENTS (PatientID, NationalID, FirstName, LastName, BirthDate, Gender, Phone, Address, BloodType, EmergencyContact)
VALUES (2, '2AB234567890', 'Sevinc', 'Abbasova', TO_DATE('1985-03-22', 'YYYY-MM-DD'), 'Female', '+994-50-222-2222', 'Bakı, Yasamal rayonu, Ş.Mehdiyev 456', 'A+', 'Mübariz Həsənov +994-50-111-1111');
 
INSERT INTO PATIENTS (PatientID, NationalID, FirstName, LastName, BirthDate, Gender, Phone, Address, BloodType, EmergencyContact)
VALUES (3, '3AB345678901', 'Fərid', 'Qasımov', TO_DATE('1975-07-08', 'YYYY-MM-DD'), 'Male', '+994-50-333-3333', 'Gəncə, Gəncə rayonu, Azadlıq prospekti 789', 'B+', 'Rana Qasımova +994-50-333-3334');
 
INSERT INTO PATIENTS (PatientID, NationalID, FirstName, LastName, BirthDate, Gender, Phone, Address, BloodType, EmergencyContact)
VALUES (4, '4AB456789012', 'Rana', 'Qasımova', TO_DATE('1982-11-30', 'YYYY-MM-DD'), 'Female', '+994-50-444-4444', 'Gəncə, Gəncə rayonu, Cəvdət Heydarov 321', 'O-', 'Fərid Qasımov +994-50-333-3333');
 
INSERT INTO PATIENTS (PatientID, NationalID, FirstName, LastName, BirthDate, Gender, Phone, Address, BloodType, EmergencyContact)
VALUES (5, '5AB567890123', 'Nigar', 'Məmmədzadə', TO_DATE('1990-02-14', 'YYYY-MM-DD'), 'Female', '+994-50-555-5555', 'Bakı, Səbail rayonu, Hövsan yolu 654', 'AB+', 'Ali Məmmədov +994-50-555-5556');
 
INSERT INTO PATIENTS (PatientID, NationalID, FirstName, LastName, BirthDate, Gender, Phone, Address, BloodType, EmergencyContact)
VALUES (6, '6AB678901234', 'Ali', 'Məmmədov', TO_DATE('1988-09-25', 'YYYY-MM-DD'), 'Male', '+994-50-666-6666', 'Sumqayıt, Quba rayonu, Lənkəran yolu 987', 'A-', 'Nigar Məmmədzadə +994-50-555-5555');
 
INSERT INTO PATIENTS (PatientID, NationalID, FirstName, LastName, BirthDate, Gender, Phone, Address, BloodType, EmergencyContact)
VALUES (7, '7AB789012345', 'Sərdar', 'Yusifov', TO_DATE('1992-06-18', 'YYYY-MM-DD'), 'Male', '+994-50-777-7777', 'Bakı, Xətai rayonu, Heydər Əliyev prospekti 111', 'B-', 'Gül Yusifova +994-50-777-7778');
 
INSERT INTO PATIENTS (PatientID, NationalID, FirstName, LastName, BirthDate, Gender, Phone, Address, BloodType, EmergencyContact)
VALUES (8, '8AB890123456', 'Gül', 'Yusifova', TO_DATE('1987-12-03', 'YYYY-MM-DD'), 'Female', '+994-50-888-8888', 'Bakı, Xətai rayonu, Mətbuat prospekti 222', 'AB-', 'Sərdar Yusifov +994-50-777-7777');
 
INSERT INTO PATIENTS (PatientID, NationalID, FirstName, LastName, BirthDate, Gender, Phone, Address, BloodType, EmergencyContact)
VALUES (9, '9AB901234567', 'Tərlan', 'Əliyev', TO_DATE('1995-04-10', 'YYYY-MM-DD'), 'Male', '+994-50-999-9999', 'Şəki, Şəki rayonu, Mirzə Fətəli Axundzadə 333', 'O+', 'Aynur Əliyeva +994-50-999-9900');
 
INSERT INTO PATIENTS (PatientID, NationalID, FirstName, LastName, BirthDate, Gender, Phone, Address, BloodType, EmergencyContact)
VALUES (10, '10AB012345678', 'Aynur', 'Əliyeva', TO_DATE('1993-08-21', 'YYYY-MM-DD'), 'Female', '+994-50-101-0101', 'Şəki, Şəki rayonu, Dəmiryolçuları 444', 'A+', 'Tərlan Əliyev +994-50-999-9999');
 
COMMIT;
 
-- =====================================================
-- 4. APPOINTMENTS CƏDVƏLINƏ VERİLƏNLƏR
-- (PatientID və DoctorID FK referensi ilə)
-- =====================================================
 
INSERT INTO APPOINTMENTS (AppointmentID, PatientID, DoctorID, AppDateTime, Status, ComplaintNote)
VALUES (1, 1, 1, TO_DATE('2024-01-15 09:00', 'YYYY-MM-DD HH24:MI'), 'Completed', 'Göğüs ağrısı və ürəkdə çıtırtı hissi');
 
INSERT INTO APPOINTMENTS (AppointmentID, PatientID, DoctorID, AppDateTime, Status, ComplaintNote)
VALUES (2, 2, 2, TO_DATE('2024-01-16 10:30', 'YYYY-MM-DD HH24:MI'), 'Completed', 'Qanın yüksək təzyiqi, baş ağrısı');
 
INSERT INTO APPOINTMENTS (AppointmentID, PatientID, DoctorID, AppDateTime, Status, ComplaintNote)
VALUES (3, 3, 3, TO_DATE('2024-01-17 11:00', 'YYYY-MM-DD HH24:MI'), 'Scheduled', 'Baş fırlanması, dəngəlik');
 
INSERT INTO APPOINTMENTS (AppointmentID, PatientID, DoctorID, AppDateTime, Status, ComplaintNote)
VALUES (4, 4, 4, TO_DATE('2024-01-18 14:30', 'YYYY-MM-DD HH24:MI'), 'Completed', 'Migren, səs-kötü sənsasiyası');
 
INSERT INTO APPOINTMENTS (AppointmentID, PatientID, DoctorID, AppDateTime, Status, ComplaintNote)
VALUES (5, 5, 5, TO_DATE('2024-01-19 08:00', 'YYYY-MM-DD HH24:MI'), 'Scheduled', 'Sağ çiyin ağrısı, hərəkət məhdudiyyəti');
 
INSERT INTO APPOINTMENTS (AppointmentID, PatientID, DoctorID, AppDateTime, Status, ComplaintNote)
VALUES (6, 6, 6, TO_DATE('2024-01-20 15:30', 'YYYY-MM-DD HH24:MI'), 'Completed', 'Sol tiz ağrısı, şişkinlik');
 
INSERT INTO APPOINTMENTS (AppointmentID, PatientID, DoctorID, AppDateTime, Status, ComplaintNote)
VALUES (7, 7, 7, TO_DATE('2024-01-21 09:30', 'YYYY-MM-DD HH24:MI'), 'Scheduled', 'Dəri qaşınması, qızarması');
 
INSERT INTO APPOINTMENTS (AppointmentID, PatientID, DoctorID, AppDateTime, Status, ComplaintNote)
VALUES (8, 8, 8, TO_DATE('2024-01-22 13:00', 'YYYY-MM-DD HH24:MI'), 'Completed', 'Dəridə çıxıntı, ağ plaqalar');
 
INSERT INTO APPOINTMENTS (AppointmentID, PatientID, DoctorID, AppDateTime, Status, ComplaintNote)
VALUES (9, 9, 9, TO_DATE('2024-01-23 10:00', 'YYYY-MM-DD HH24:MI'), 'Scheduled', 'Uşaq qızılcığı şübhəsi, yüksək temperatur');
 
INSERT INTO APPOINTMENTS (AppointmentID, PatientID, DoctorID, AppDateTime, Status, ComplaintNote)
VALUES (10, 10, 10, TO_DATE('2024-01-24 16:00', 'YYYY-MM-DD HH24:MI'), 'Completed', 'Yuxusuzluq, depressiv əhval');
 
INSERT INTO APPOINTMENTS (AppointmentID, PatientID, DoctorID, AppDateTime, Status, ComplaintNote)
VALUES (11, 1, 2, TO_DATE('2024-02-01 11:00', 'YYYY-MM-DD HH24:MI'), 'Scheduled', 'Yoxlama viziti, reytinq kontrol');
 
INSERT INTO APPOINTMENTS (AppointmentID, PatientID, DoctorID, AppDateTime, Status, ComplaintNote)
VALUES (12, 3, 3, TO_DATE('2024-02-02 09:30', 'YYYY-MM-DD HH24:MI'), 'Cancelled', 'Xəstə iptal etdi');
 
INSERT INTO APPOINTMENTS (AppointmentID, PatientID, DoctorID, AppDateTime, Status, ComplaintNote)
VALUES (13, 2, 1, TO_DATE('2024-02-05 10:00', 'YYYY-MM-DD HH24:MI'), 'Completed', 'Aralıq yoxlama viziti');
 
INSERT INTO APPOINTMENTS (AppointmentID, PatientID, DoctorID, AppDateTime, Status, ComplaintNote)
VALUES (14, 4, 3, TO_DATE('2024-02-10 14:00', 'YYYY-MM-DD HH24:MI'), 'Scheduled', 'Nevroloji yoxlama');
 
INSERT INTO APPOINTMENTS (AppointmentID, PatientID, DoctorID, AppDateTime, Status, ComplaintNote)
VALUES (15, 6, 5, TO_DATE('2024-02-11 09:00', 'YYYY-MM-DD HH24:MI'), 'Completed', 'Ortopedik rehabilitasiya');
 
COMMIT;
 
-- =====================================================
-- 5. EXAMINATIONS CƏDVƏLINƏ VERİLƏNLƏR
-- (AppointmentID FK referensi ilə, UNIQUE constraint)
-- =====================================================
 
INSERT INTO EXAMINATIONS (ExamID, AppointmentID, Diagnosis, TreatmentPlan, ExamDate, Fee)
VALUES (1, 1, 'Angina Pectoris', 'Aspihin 100mg gündə 1x, Atorvastatin 20mg gündə 1x', TO_DATE('2024-01-15', 'YYYY-MM-DD'), 150.50);
 
INSERT INTO EXAMINATIONS (ExamID, AppointmentID, Diagnosis, TreatmentPlan, ExamDate, Fee)
VALUES (2, 2, 'Hipertenziya Səviyyə 2', 'Lisinopril 10mg gündə 2x, Amlodipine 5mg gündə 1x', TO_DATE('2024-01-16', 'YYYY-MM-DD'), 120.00);
 
INSERT INTO EXAMINATIONS (ExamID, AppointmentID, Diagnosis, TreatmentPlan, ExamDate, Fee)
VALUES (3, 3, 'Periferik Vestibulyar Dəngəlik', 'Betahistin 16mg gündə 3x, Fizioterapi', TO_DATE('2024-01-17', 'YYYY-MM-DD'), 95.75);
 
INSERT INTO EXAMINATIONS (ExamID, AppointmentID, Diagnosis, TreatmentPlan, ExamDate, Fee)
VALUES (4, 4, 'Migrenə ilə Aura', 'Sumatriptan 50mg zərurətində, Propranolol 40mg gündə 2x', TO_DATE('2024-01-18', 'YYYY-MM-DD'), 110.25);
 
INSERT INTO EXAMINATIONS (ExamID, AppointmentID, Diagnosis, TreatmentPlan, ExamDate, Fee)
VALUES (5, 5, 'Rotator Cuff Tənəzzül', 'Fizikal terapiya, Naproxen 500mg gündə 2x, Injektion', TO_DATE('2024-01-19', 'YYYY-MM-DD'), 200.00);
 
INSERT INTO EXAMINATIONS (ExamID, AppointmentID, Diagnosis, TreatmentPlan, ExamDate, Fee)
VALUES (6, 6, 'Qonaqçı Ağrı Sindromu', 'Fizikal terapiya, Ibuprofen 400mg gündə 3x', TO_DATE('2024-01-20', 'YYYY-MM-DD'), 85.50);
 
INSERT INTO EXAMINATIONS (ExamID, AppointmentID, Diagnosis, TreatmentPlan, ExamDate, Fee)
VALUES (7, 7, 'Allergic Dermatitis', 'Mometazon furoat krem, Setirizin 10mg gündə 1x', TO_DATE('2024-01-21', 'YYYY-MM-DD'), 75.00);
 
INSERT INTO EXAMINATIONS (ExamID, AppointmentID, Diagnosis, TreatmentPlan, ExamDate, Fee)
VALUES (8, 8, 'Psoriasis Vulgaris', 'Betametazon dipropionat krem, UVB terapiya', TO_DATE('2024-01-22', 'YYYY-MM-DD'), 125.00);
 
INSERT INTO EXAMINATIONS (ExamID, AppointmentID, Diagnosis, TreatmentPlan, ExamDate, Fee)
VALUES (9, 9, 'Suspekt Qızılcıq', 'Qoruya tədbirlər, Asetaminofen 250mg 4-6 saat', TO_DATE('2024-01-23', 'YYYY-MM-DD'), 60.00);
 
INSERT INTO EXAMINATIONS (ExamID, AppointmentID, Diagnosis, TreatmentPlan, ExamDate, Fee)
VALUES (10, 10, 'Major Depressiv Pozisyon', 'Sertralin 50mg gündə 1x, Psixoterapiya həftəlik', TO_DATE('2024-01-24', 'YYYY-MM-DD'), 180.00);
 
INSERT INTO EXAMINATIONS (ExamID, AppointmentID, Diagnosis, TreatmentPlan, ExamDate, Fee)
VALUES (11, 13, 'Qanın Təzyiqi Kontrol Altında', 'Davam edir mövcud dərmanlar', TO_DATE('2024-02-05', 'YYYY-MM-DD'), 80.00);
 
INSERT INTO EXAMINATIONS (ExamID, AppointmentID, Diagnosis, TreatmentPlan, ExamDate, Fee)
VALUES (12, 14, 'Periodic Migren Kontrol Altında', 'Davam edir terapiya', TO_DATE('2024-02-10', 'YYYY-MM-DD'), 95.00);
 
INSERT INTO EXAMINATIONS (ExamID, AppointmentID, Diagnosis, TreatmentPlan, ExamDate, Fee)
VALUES (13, 15, 'Rotator Cuff Bərpa Prosesi', 'Intensiv fizikal terapiya', TO_DATE('2024-02-11', 'YYYY-MM-DD'), 110.00);
 
COMMIT;
 
-- =====================================================
-- 6. MEDICATIONS CƏDVƏLINƏ VERİLƏNLƏR
-- =====================================================
 
INSERT INTO MEDICATIONS (MedicationID, Barcode, MedName, Dosage, Instructions)
VALUES (1, 'MED-2024-001', 'Aspirin', '100mg', 'Gündə 1 dəfə, yeməkdən sonra su ilə');
 
INSERT INTO MEDICATIONS (MedicationID, Barcode, MedName, Dosage, Instructions)
VALUES (2, 'MED-2024-002', 'Atorvastatin', '20mg', 'Gündə 1 dəfə, əsasən axşam yeməkdən sonra');
 
INSERT INTO MEDICATIONS (MedicationID, Barcode, MedName, Dosage, Instructions)
VALUES (3, 'MED-2024-003', 'Lisinopril', '10mg', 'Gündə 2 dəfə, sabah və axşam');
 
INSERT INTO MEDICATIONS (MedicationID, Barcode, MedName, Dosage, Instructions)
VALUES (4, 'MED-2024-004', 'Amlodipine', '5mg', 'Gündə 1 dəfə, sabah');
 
INSERT INTO MEDICATIONS (MedicationID, Barcode, MedName, Dosage, Instructions)
VALUES (5, 'MED-2024-005', 'Betahistin', '16mg', 'Gündə 3 dəfə, yeməklərlə birlikdə');
 
INSERT INTO MEDICATIONS (MedicationID, Barcode, MedName, Dosage, Instructions)
VALUES (6, 'MED-2024-006', 'Sumatriptan', '50mg', 'Migrenə başladığında, 2 saat sonra təkrar olunur');
 
INSERT INTO MEDICATIONS (MedicationID, Barcode, MedName, Dosage, Instructions)
VALUES (7, 'MED-2024-007', 'Propranolol', '40mg', 'Gündə 2 dəfə, sabah və axşam');
 
INSERT INTO MEDICATIONS (MedicationID, Barcode, MedName, Dosage, Instructions)
VALUES (8, 'MED-2024-008', 'Naproxen', '500mg', 'Gündə 2 dəfə, yeməkdən sonra');
 
INSERT INTO MEDICATIONS (MedicationID, Barcode, MedName, Dosage, Instructions)
VALUES (9, 'MED-2024-009', 'Ibuprofen', '400mg', 'Gündə 3 dəfə, yeməklərlə birlikdə');
 
INSERT INTO MEDICATIONS (MedicationID, Barcode, MedName, Dosage, Instructions)
VALUES (10, 'MED-2024-010', 'Mometazon Furoat', '0.1%', 'Günə 1-2 dəfə, təsirlənmiş dəriyə sürtün');
 
INSERT INTO MEDICATIONS (MedicationID, Barcode, MedName, Dosage, Instructions)
VALUES (11, 'MED-2024-011', 'Setirizin', '10mg', 'Gündə 1 dəfə, axşam');
 
INSERT INTO MEDICATIONS (MedicationID, Barcode, MedName, Dosage, Instructions)
VALUES (12, 'MED-2024-012', 'Betametazon Dipropionat', '0.05%', 'Günə 1-2 dəfə, təsirlənmiş dəriyə sürtün');
 
INSERT INTO MEDICATIONS (MedicationID, Barcode, MedName, Dosage, Instructions)
VALUES (13, 'MED-2024-013', 'Asetaminofen', '250mg', 'Hər 4-6 saatda, maksimum gündə 1000mg');
 
INSERT INTO MEDICATIONS (MedicationID, Barcode, MedName, Dosage, Instructions)
VALUES (14, 'MED-2024-014', 'Sertralin', '50mg', 'Gündə 1 dəfə, sabah');
 
COMMIT;
 
-- =====================================================
-- 7. PRESCRIPTION CƏDVƏLINƏ VERİLƏNLƏR
-- (ExamID, MedicationID kombinasiyası - UNIQUE)
-- =====================================================
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (1, 1, 30, 30);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (1, 2, 30, 30);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (2, 3, 60, 30);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (2, 4, 30, 30);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (3, 5, 90, 30);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (4, 6, 3, 3);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (4, 7, 60, 30);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (5, 8, 60, 30);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (6, 9, 90, 30);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (7, 10, 30, 7);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (7, 11, 30, 14);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (8, 12, 30, 14);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (9, 13, 20, 5);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (10, 14, 30, 30);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (11, 3, 60, 30);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (11, 4, 30, 30);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (12, 6, 5, 7);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (12, 7, 60, 30);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (13, 8, 60, 30);
 
INSERT INTO PRESCRIPTION (ExamID, MedicationID, Quantity, DurationDays)
VALUES (13, 9, 90, 30);
 


SELECT * FROM doctors;

SELECT * FROM appointments;

SELECT * FROM PRESCRIPTION;

SELECT * FROM MEDICATIONS;

SELECT * FROM PATIENTS;

SELECT * FROM EXAMINATIONS;

SELECT * FROM DEPARTMENTS;










