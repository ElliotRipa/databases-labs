
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
    WHERE (bi.idnr, course) NOT IN (SELECT pc.student, pc.course FROM PassedCourses pc)

    UNION

    SELECT bi.idnr AS student, course
    FROM MandatoryBranch mb
    INNER JOIN BasicInformation bi ON mb.program = bi.program AND mb.branch = bi.branch
    WHERE (bi.idnr, course) NOT IN (SELECT pc.student, pc.course FROM PassedCourses pc);


CREATE VIEW PassedMathCredits AS

    SELECT pc.student, SUM(pc.credits) AS credits

    FROM PassedCourses pc
    LEFT JOIN classified c ON pc.course = c.course
    WHERE classification = 'math'
    GROUP BY pc.student;


CREATE VIEW PassedResearchCredits AS

    SELECT pc.student, SUM(pc.credits) AS credits

    FROM PassedCourses pc
    LEFT JOIN classified c ON pc.course = c.course
    WHERE classification = 'research'
    GROUP BY pc.student;


CREATE VIEW PassedSeminarCourses AS

    SELECT pc.student, COUNT(pc.credits) AS course

    FROM PassedCourses pc
    LEFT JOIN classified c ON pc.course = c.course
    WHERE classification = 'seminar'
    GROUP BY pc.student;


CREATE VIEW RecommendedCourses AS

    SELECT bi.idnr, rb.course, c.credits AS credits
    FROM BasicInformation bi

    INNER JOIN RecommendedBranch rb ON (bi.program, bi.branch) = (rb.program, rb.branch)
    LEFT JOIN Courses c ON c.code = rb.course;



CREATE VIEW PassedRecommendedCredits AS

    SELECT
           pc.student,
           SUM(pc.credits) AS credits

    FROM PassedCourses pc
    LEFT JOIN RecommendedCourses rc ON rc.course = pc.course
    WHERE pc.student = rc.idnr
    GROUP BY pc.student;



CREATE VIEW Qualified AS

    SELECT bi.idnr
    FROM BasicInformation bi
    WHERE
        bi.idnr NOT IN (SELECT um.student FROM UnreadMandatory um)
        AND (SELECT pmc.credits FROM PassedMathCredits pmc WHERE bi.idnr = pmc.student) >= 20
        AND (SELECT prc.credits FROM PassedResearchCredits prc WHERE bi.idnr = prc.student) >= 10
        AND (SELECT psc.course FROM PassedSeminarCourses psc WHERE bi.idnr = psc.student) > 0
        AND (SELECT prc.credits FROM PassedRecommendedCredits prc WHERE bi.idnr = prc.student) >= 10;


CREATE VIEW totalCredits AS
    SELECT
    bi.idnr AS student,
    SUM(pc.credits) AS totalCredits

    FROM BasicInformation bi

    LEFT JOIN PassedCourses pc ON bi.idnr = pc.student

    GROUP BY bi.idnr;


CREATE VIEW mandatoryLeft AS
    SELECT
        bi.idnr AS student,
        COUNT(um.course) AS mandatoryLeft

        FROM BasicInformation bi

        LEFT JOIN UnreadMandatory um ON bi.idnr = um.student

        GROUP BY bi.idnr;


CREATE VIEW PathToGraduation AS

    SELECT
        bi.idnr AS student,
        COALESCE(tc.TotalCredits, 0) AS totalCredits,
        COALESCE(ml.MandatoryLeft, 0) AS mandatoryLeft,
        COALESCE(pmc.credits, 0) AS mathCredits,
        COALESCE(prc.credits, 0) AS researchCredits,
        COALESCE(psc.course, 0) AS seminarCourses,
        bi.idnr IN (SELECT qualified.idnr FROM qualified) as qualified

    FROM BasicInformation bi

        LEFT JOIN TotalCredits tc ON bi.idnr = tc.student
        LEFT JOIN MandatoryLeft ml ON bi.idnr = ml.student
        LEFT JOIN PassedMathCredits pmc ON bi.idnr = pmc.student
        LEFT JOIN PassedResearchCredits prc ON bi.idnr = prc.student
        LEFT JOIN PassedSeminarCourses psc ON bi.idnr = psc.student
        LEFT JOIN Qualified q ON bi.idnr = q.idnr

    ORDER BY bi.idnr;





/* OLD
 CREATE VIEW PathToGraduation AS

    SELECT
        bi.idnr AS student,
        COALESCE(SUM(pc.credits), 0) AS totalCredits,
        COALESCE(COUNT(um.course), 0) AS mandatoryLeft,
        COALESCE(pmc.credits, 0) AS mathCredits,
        COALESCE(prc.credits, 0) AS researchCredits,
        COALESCE(psc.course, 0) AS seminarCourses,
        bi.idnr IN (SELECT qualified.idnr FROM qualified) as qualified

    FROM BasicInformation bi

        LEFT JOIN PassedCourses pc ON bi.idnr = pc.student
        LEFT JOIN UnreadMandatory um ON bi.idnr = um.student
        LEFT JOIN PassedMathCredits pmc ON pc.student = pmc.student
        LEFT JOIN PassedResearchCredits prc ON pc.student = prc.student
        LEFT JOIN PassedSeminarCourses psc ON pc.student = psc.student
        LEFT JOIN Qualified q ON bi.idnr = q.idnr

    GROUP BY bi.idnr, pmc.credits, prc.credits, PSC.course, q.idnr
    ORDER BY bi.idnr;

 */