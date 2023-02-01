CREATE VIEW BasicInformation AS

SELECT s.idnr, s.name, s.login, s.program, sb.branch

    FROM Students s
    LEFT JOIN StudentBranches sb ON s.idnr = sb.student
        ORDER BY s.idnr;


CREATE VIEW FinishedCourses AS

    SELECT t.student, t.course, t.grade, c.credits
    FROM Taken t
    LEFT JOIN Courses c ON c.code = t.course
        ORDER BY t.student;


CREATE VIEW PassedCourses AS

    SELECT * FROM FinishedCourses
    WHERE grade != 'U';


CREATE VIEW Registrations AS

    SELECT r.student, r.course, 'registered' AS status
    FROM Registered r
    UNION
    SELECT wl.student, wl.course, 'waiting' AS status
    FROM WaitingList wl;


CREATE VIEW UnreadMandatory AS

    SELECT bi.idnr AS student, course
    FROM MandatoryProgram mp
    INNER JOIN BasicInformation bi ON mp.program = bi.program
    WHERE bi.idnr NOT IN (SELECT pc.student FROM PassedCourses pc)

    UNION

    SELECT bi.idnr AS student, course
    FROM MandatoryBranch mb
    INNER JOIN BasicInformation bi on mb.program = bi.program and mb.branch = bi.branch
    WHERE bi.idnr NOT IN (SELECT pc.student FROM PassedCourses pc);

/*
CREATE VIEW PathToGraduation AS

    SELECT bi.idnr, totalCredits, mandatoryLeft, mathCredits, researchCredits, qualified

    FROM BasicInformation bi
    LEFT JOIN


    )
    FROM courses c
    WHERE SUM(c.credits) as sum
*/
