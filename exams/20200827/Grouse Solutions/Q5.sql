CREATE TABLE Assignment (

	CHAR(6)	course,
	TEXT	name,
	TEXT 	description,
	TIME	deadline

	PRIMARY KEY(course, name)
);

CREATE TABLE Registered(

	student	TEXT,
	course	TEXT

	PRIMARY KEY(student, course)
);

CREATE TABLE Submission (

	idnr		INT PRIMARY KEY,
	student		TEXT,
	course		TEXT,
	assignment	TEXT,
	stime		TIMESTAMP

	UNIQUE(student, stime)								// f.)

	FOREIGN KEY(course, assignment) REFERENCES Assignment(course, name)
	FOREIGN KEY(student, course) REFERENCES Registered(student, course)		// b.)
);

CREATE TABLE SubmittedFile (

	submission	INT,
	filename	TEXT,
	contents	TEXT

	PRIMARY KEY(submission, filename)

	FOREIGN KEY(submission) REFERENCES Submission(idnr) ON DELETE CASCADE		// d.)

);


CREATE VIEW SubmittedFileButCooler							// c.)

	SELECT *, length(contents) AS filesize
	FROM SubmittedFile;


CREATE TRIGGER DeleteSubmissionToo							// e.)

	AFTER DELETE ON SubmittedFile
	IF 0 == COUNT(SELECT * FROM SubmittedFile sf WHERE sf.submission = Submission.idnr)
	BEGIN
		DELETE FROM Submission
		WHERE idnr = (SELECT submission FROM deleted)
	END

