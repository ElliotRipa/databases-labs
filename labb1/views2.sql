DROP VIEW BasicInformation;

CREATE VIEW BasicInformation AS

    SELECT s.idnr, s.name, s.login, s.program, sb.branch
    FROM students s
    LEFT JOIN studentbranches sb on s.idnr = sb.student
    ORDER BY s.idnr;





/*DROP VIEW PassedClassifiedCourses; */
/*DROP VIEW PathToGraduation; */
/*SELECT * FROM  ;*/



CREATE VIEW PathToGraduation2 AS

SELECT
    bi.idnr AS student,
    GREATEST(0,SUM(pc.credits)) AS totalCredits,
    GREATEST(0, COUNT(um.course)) AS mandatoryLeft,
    GREATEST(0, SUM(pcc.credits)) AS mathCredits
    /*, researchCredits, qualified */

FROM BasicInformation bi
        LEFT JOIN PassedCourses pc ON bi.idnr = pc.student
        LEFT JOIN UnreadMandatory um ON bi.idnr = um.student
        LEFT JOIN PassedClassifiedCourses pcc ON bi.idnr = pcc.student

GROUP BY bi.idnr
ORDER BY bi.idnr;






