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

    SELECT student, course, credits FROM FinishedCourses
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
    INNER JOIN BasicInformation bi ON mb.program = bi.program AND mb.branch = bi.branch
    WHERE bi.idnr NOT IN (SELECT pc.student FROM PassedCourses pc);


CREATE VIEW PassedClassifiedCourses AS

    SELECT
        pc.student,
        pc.course,
        pc.credits,
        c.classification

    FROM PassedCourses pc
    LEFT JOIN classified c ON pc.course = c.course
    WHERE classification = 'math';

/*Make separate VIEWs for maths, research, etc.? */
/*Check if they mean finished and not passed?*/



/*DROP VIEW PassedClassifiedCourses; */
/*DROP VIEW PathToGraduation; */
/*SELECT * FROM  ;*/



CREATE VIEW PathToGraduation AS

    SELECT
        bi.idnr AS student,
        GREATEST(0,SUM(pc.credits)) AS totalPoints,
        GREATEST(0, COUNT(um.course)) AS mandatoryLeft,   /*Why count(um.course)?*/
        GREATEST(0, SUM(pcc.credits)) AS mathCredits
     /*, researchCredits, qualified */
    FROM BasicInformation bi
    LEFT JOIN PassedCourses pc ON bi.idnr = pc.student
    LEFT JOIN UnreadMandatory um ON bi.idnr = um.student
    INNER JOIN PassedClassifiedCourses pcc ON pc.course = pcc.course AND pcc.classification = 'math'
    GROUP BY bi.idnr
    ORDER BY bi.idnr;

