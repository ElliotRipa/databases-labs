INSERT INTO Programs VALUES ('Prog1');
INSERT INTO Programs VALUES ('Prog2');

INSERT INTO Branches VALUES ('B1','Prog1');
INSERT INTO Branches VALUES ('B2','Prog1');
INSERT INTO Branches VALUES ('B1','Prog2');

INSERT INTO Students VALUES ('1111111111','N1','ls1','Prog1');
INSERT INTO Students VALUES ('2222222222','N2','ls2','Prog1');
INSERT INTO Students VALUES ('3333333333','N3','ls3','Prog2');
INSERT INTO Students VALUES ('4444444444','N4','ls4','Prog1');
INSERT INTO Students VALUES ('5555555555','Nx','ls5','Prog2');
INSERT INTO Students VALUES ('6666666666','Nx','ls6','Prog2');

INSERT INTO Courses VALUES ('CCC111','C1',22.5,'Dep1');
INSERT INTO Courses VALUES ('CCC222','C2',20,'Dep1');
INSERT INTO Courses VALUES ('CCC333','C3',30,'Dep1');
INSERT INTO Courses VALUES ('CCC444','C4',60,'Dep1');
INSERT INTO Courses VALUES ('CCC555','C5',50,'Dep1');

INSERT INTO LimitedCourses VALUES ('CCC222',1);
INSERT INTO LimitedCourses VALUES ('CCC333',2);

INSERT INTO Classifications VALUES ('math');
INSERT INTO Classifications VALUES ('research');
INSERT INTO Classifications VALUES ('seminar');

INSERT INTO Classified VALUES ('CCC333','math');
INSERT INTO Classified VALUES ('CCC444','math');
INSERT INTO Classified VALUES ('CCC444','research');
INSERT INTO Classified VALUES ('CCC444','seminar');

INSERT INTO PartOfBranch VALUES ('2222222222','B1','Prog1');
INSERT INTO PartOfBranch VALUES ('3333333333','B1','Prog2');
INSERT INTO PartOfBranch VALUES ('4444444444','B1','Prog1');
INSERT INTO PartOfBranch VALUES ('5555555555','B1','Prog2');

INSERT INTO MandatoryProgramCourses VALUES ('CCC111','Prog1');

INSERT INTO MandatoryBranchCourses VALUES ('CCC333', 'B1', 'Prog1');
INSERT INTO MandatoryBranchCourses VALUES ('CCC444', 'B1', 'Prog2');

INSERT INTO RecommendedBranchCourses VALUES ('CCC222', 'B1', 'Prog1');
INSERT INTO RecommendedBranchCourses VALUES ('CCC333', 'B1', 'Prog2');

INSERT INTO Registered VALUES ('1111111111','CCC111');
INSERT INTO Registered VALUES ('1111111111','CCC222');
INSERT INTO Registered VALUES ('1111111111','CCC333');
INSERT INTO Registered VALUES ('2222222222','CCC222');
INSERT INTO Registered VALUES ('5555555555','CCC222');
INSERT INTO Registered VALUES ('5555555555','CCC333');

INSERT INTO Grades VALUES('4444444444','CCC111','5');
INSERT INTO Grades VALUES('4444444444','CCC222','5');
INSERT INTO Grades VALUES('4444444444','CCC333','5');
INSERT INTO Grades VALUES('4444444444','CCC444','5');

INSERT INTO Grades VALUES('5555555555','CCC111','5');
INSERT INTO Grades VALUES('5555555555','CCC222','4');
INSERT INTO Grades VALUES('5555555555','CCC444','3');

INSERT INTO Grades VALUES('2222222222','CCC111','U');
INSERT INTO Grades VALUES('2222222222','CCC222','U');
INSERT INTO Grades VALUES('2222222222','CCC444','U');

INSERT INTO WaitingList VALUES('3333333333','CCC222',1);
INSERT INTO WaitingList VALUES('3333333333','CCC333',1);
INSERT INTO WaitingList VALUES('2222222222','CCC333',2);
