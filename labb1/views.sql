DROP VIEW BasicInformation;

CREATE VIEW BasicInformation AS
    SELECT Students.idnr, Students.name, Students.login, Students.program, StudentBranches.branch
    FROM Students, StudentBranches
    WHERE StudentBranches.student = Students.idnr;

/*CREATE VIEW BasicInformation AS
SELECT table1.column1,
       table2.column2
FROM
    table1, table2
WHERE table1.column1 = table2.column1;*/