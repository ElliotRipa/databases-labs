CREATE TABLE Assignment (

	CHAR(6)	course,
	TEXT	name,
	TEXT 	description,
	TIME	deadline

	PRIMARY KEY(course, name)
);

CREATE TABLE Registered(

	TEXT	student,
	CHAR(6)	course

	PRIMARY KEY(student, course)
);

CREATE TABLE Submission (

	INT	idnr PRIMARY KEY AUTO_INCREMENT,					//a.)
	TEXT	student,
	CHAR(6)	course,
	TEXT	Assignment,
	TIME	stime UNIQUE

	UNIQUE(student, stime)								// f.)

	FOREIGN KEY(course, assignment) REFERENCES Assignment(course, name)
	FOREIGN KEY(student, course) REFERENCES Registered(student, course)		// b.)
);

CREATE TABLE SubmittedFile (

	INT 	submission,
	TEXT	filename,
	TEXT	contents

	PRIMARY KEY(submission, filename)
);


CREATE VIEW SubmittedFileButCooler (							// c.)

	SELECT *, length(contents) AS filesize
	FROM SubmittedFile
);

CREATE TRIGGER DeleteFilesToo								// d.)

	BEFORE DELETE ON Submission
	BEGIN
		DELETE FROM SubmittedFile
		WHERE submission = (SELECT idnr FROM deleted)
	END

CREATE TRIGGER DeleteSubmissionToo							// e.)

	AFTER DELETE ON SubmittedFile
	IF 0 == COUNT(SELECT * FROM SubmittedFile sf WHERE sf.submission = Submission.idnr)
	BEGIN
		DELETE FROM Submission
		WHERE idnr = (SELECT submission FROM deleted)
	END













