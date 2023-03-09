a.)

SELECT s.student, SUM(sf.filesize)
FROM Submission s
LEFT JOIN SubmittedFile sf ON s.idnr = sf.submission
GROUP BY s.student;


b.)

SELECT s.idnr
FROM Submission s
LEFT JOIN SubmittedFile sf ON sf.submission = s.idnr
WHERE s.course = 'TDA357' AND s.assignment = 'Lab 1'
WHERE 'tables.sql' NOT IN sf.filename OR 'views.sql' NOT IN sf.filename;
GROUP BY s.idnr //?

