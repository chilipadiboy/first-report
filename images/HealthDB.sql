CREATE TABLE User (
IC_number char(9) NOT NULL,
Name varchar(50) NOT NULL,
Email varchar(50) NOT NULL,
Address varchar(50) NOT NULL,
Emergency_Contact varchar(100) NOT NULL,
User_login varchar(10) NOT NULL,
Salt varchar(8) NOT NULL,
Hash varchar(128) NOT NULL,
Priv_Key varchar(128) NOT NULL,
Admin_ID varchar(9) NOT NULL,
PRIMARY KEY (IC_number),
UNIQUE (IC_number, Email, User_login, Salt, Priv_Key),
FOREIGN KEY (Admin_ID) REFERENCES Admin(Admin_ID) ON DELETE CASCADE
);

CREATE TABLE Phone (
IC_number varchar(9) NOT NULL,
phone_number int(8) NOT NULL,
PRIMARY KEY (IC_number, phone_number),
FOREIGN KEY IC_number REFERENCES User (IC_number) ON DELETE CASCADE
);

CREATE TABLE Therapist (
IC_number varchar(9) NOT NULL,
Therapist_ID varchar(9) NOT NULL,
PRIMARY KEY (IC_number),
UNIQUE (Therapist_ID),
FOREIGN KEY IC_number REFERENCES User (IC_number) ON DELETE CASCADE
);

CREATE TABLE Patient (
IC_number varchar(9) NOT NULL,
Patient_ID varchar(9) NOT NULL,
PRIMARY KEY (IC_number),
UNIQUE (Patient_ID),
FOREIGN KEY IC_number REFERENCES User (IC_number) ON DELETE CASCADE
);

CREATE TABLE Researcher (
IC_number varchar(9) NOT NULL,
Researcher_ID varchar(9) NOT NULL,
PRIMARY KEY (IC_number),
UNIQUE (Researcher_ID),
FOREIGN KEY IC_number REFERENCES User (IC_number) ON DELETE CASCADE
);

CREATE TABLE Admin (
IC_number varchar(9) NOT NULL,
Admin_ID varchar(9) NOT NULL,
PRIMARY KEY (IC_number),
UNIQUE (Admin_ID),
FOREIGN KEY IC_number REFERENCES User (IC_number) ON DELETE CASCADE
);

CREATE TABLE Records_OwnBy_WrittenBy (
Patient_ID varchar(9) NOT NULL,
Therapist_ID varchar(9) NOT NULL,
Record_ID varchar(9) NOT NULL,
Digital_Signature varchar(128) NOT NULL,
Record_Type varchar(16) NOT NULL,
Description varchar(128) NOT NULL,
Start_Update_Validity int(8) NOT NULL,
End_Update_Validity int(8) NOT NULL,
CHECK (Record_Type in ("Readings", "Documents", "Images", "Videos", "Time_Series_Data")),
UNIQUE (Record_ID, Digital_Signature),
PRIMARY KEY (Patient_ID, Therapist_ID, Record_ID),
FOREIGN KEY Patient_ID REFERENCES Patient(Patient_ID) ON DELETE CASCADE,
FOREIGN KEY Therapist_ID REFERENCES Therapist(Therapist_ID) ON DELETE CASCADE
);

CREATE TABLE Treat (
Patient_ID varchar(9) NOT NULL,
Therapist_ID varchar(9) NOT NULL,
Start_Treatment int(8) NOT NULL,
End_Treatment int(8) NOT NULL,
PRIMARY KEY (Patient_ID, Therapist_ID),
FOREIGN KEY Patient_ID REFERENCES Patient(Patient_ID) ON DELETE CASCADE,
FOREIGN KEY Therapist_ID REFERENCES Therapist(Therapist_ID) ON DELETE CASCADE
);

CREATE TABLE Read (
Record_ID varchar(9) NOT NULL,
Therapist_ID varchar(9),
Patient_ID varchar(9),
Researcher_ID varchar(9),
Start_Read_Validity int(8) NOT NULL,
End_Read_Validity int(8) NOT NULL,
PRIMARY KEY (Record_ID, Therapist_ID, Patient_ID),
FOREIGN KEY Therapist_ID REFERENCES Therapist(Therapist_ID) ON DELETE CASCADE,
FOREIGN KEY Patient_ID REFERENCES Patient(Patient_ID) ON DELETE CASCADE,
FOREIGN KEY Researcher_ID REFERENCES Researcher(Researcher_ID) ON DELETE CASCADE,
FOREIGN KEY Record_ID REFERENCES Records(Record_ID) ON DELETE CASCADE
);



insert into User values ('T1234567A', 'alice', 'alice@gmail.com', 'Some Street Address', '98763647_Name_Relationship', 'root0', 'a1s2d3f4', 'privatekey123', 'ID1234567');
insert into User values ('P2234567A', 'bob', 'bob@gmail.com', 'Some Street Address', '98763647_Name_Relationship', 'root1', 'q1w2e3r4', 'privatekey234', 'ID1234567');
insert into User values ('R3234567A', 'eve', 'eve@gmail.com', 'Some Street Address', '98763647_Name_Relationship', 'root2', 'z1x2c3v4', 'privatekey345', 'ID1234567');
insert into User values ('A4234567A', 'judy', 'judy@gmail.com', 'Some Street Address', '98763647_Name_Relationship', 'root3', 'z1a2q3w4', 'privatekey456', 'ID1234567');

insert into Phone values ('T1234567A', 93749783);
insert into Phone values ('P2234567A', 92435654);
insert into Phone values ('R3234567A', 97468456);
insert into Phone values ('A4234567A', 91236345);

insert into Therapist values ('T1234567A', 'TID123456');
insert into Patient values ('P2234567A', 'PID123456');
insert into Researcher values ('R3234567A', 'RID123456');
insert into Admin values ('A4234567A', 'AID123456');

insert into Records_OwnBy_WrittenBy values ('P2234567A', 'T1234567A', 'rec012345', 'digisgn123', 'Readings', 'BP, Dizzy spell, 25122017 10;35;01, 120/80', 2512017, 30112018);
insert into Treat values ('P2234567A', 'T1234567A', 2512017, 30112018);

insert into Read values ('rec012345', 'TID123456', , , 2512017, 30112018);
insert into Read values ('rec012345', , 'TID123456', , 2512017, 30112018);
insert into Read values ('rec012345', , , 'TID123456', 2512017, 30112018);