CREATE VIEW BasicInformation AS

SELECT s.idnr, s.name, s.login, s.program, sb.branch

    FROM students s
    LEFT JOIN studentbranches sb ON s.idnr = sb.student
        ORDER BY s.idnr;


CREATE VIEW FinishedCourses AS

    SELECT t.student, t.course, t.grade, c.credits
    FROM Taken t
    LEFT JOIN courses c ON c.code = t.course
        ORDER BY t.student;


CREATE VIEW PassedCourses AS

    SELECT * FROM FinishedCourses
    WHERE grade != 'U';


CREATE VIEW Registrations AS

    SELECT r.student, r.course, 'registered' AS status
    FROM Registered r
    UNION
    SELECT wl.student, wl.course, 'waiting' AS status
    FROM waitinglist wl;

/*
CREATE VIEW UnreadMandatory AS

    SELECT bi.idnr
    FROM BasicInformation bi
    UNION
    FROM Taken t;
    SELECT t.
*/

