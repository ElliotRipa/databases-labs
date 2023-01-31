DROP VIEW BasicInformation;

CREATE VIEW BasicInformation AS

    SELECT s.idnr, s.name, s.login, s.program, sb.branch
    FROM students s
    LEFT JOIN studentbranches sb on s.idnr = sb.student
    ORDER BY s.idnr;

CREATE VIEW FinishedCourses AS

    SELECT