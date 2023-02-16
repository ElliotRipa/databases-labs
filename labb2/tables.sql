CREATE TABLE Students(
    idnr    CHAR(10) PRIMARY KEY NOT NULL,
    login   TEXT NOT NULL UNIQUE,
    name    TEXT NOT NULL,
    program TEXT NOT NULL,
    FOREIGN KEY (program) REFERENCES Programs(name)
);

CREATE TABLE Programs(
    name TEXT PRIMARY KEY NOT NULL,

)

CREATE TABLE Branches(
    name TEXT NOT NULL,
    program TEXT NOT NULL,
    PRIMARY KEY (name, program),
    FOREIGN KEY (program) REFERENCES Programs(name)

);

CREATE TABLE Courses (
    code CHAR(6) PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    credits INT NOT NULL,
    department TEXT NOT NULL

);


CREATE TABLE LimitedCourses(
    capacity INT NOT NULL,
    course INT NOT NULL UNIQUE,
    FOREIGN KEY (course) REFERENCES Courses(code),
    PRIMARY KEY(course, code)

);

CREATE TABLE Classifications(
    name TEXT PRIMARY KEY NOT NULL
);

CREATE TABLE Classified(
    course CHAR(6) NOT NULL,
    classification TEXT NOT NULL,

    FOREIGN KEY(course) REFERENCES Courses(code),
    FOREIGN KEY(classification) REFERENCES Classifications(name),

    PRIMARY KEY (course, classification)
);

CREATE TABLE WaitingList(
    course CHAR(6) NOT NULL,
    position INT NOT NULL,
    student CHAR(10) NOT NULL,

    FOREIGN KEY(course) REFERENCES Courses(code),
    FOREIGN KEY(student) REFERENCES Students(idnr)

    PRIMARY KEY(course, position, student)

)

CREATE TABLE PartOfBranch(
    student CHAR(10) PRIMARY KEY NOT NULL,
    program TEXT NOT NULL,
    branch TEXT NOT NULL,

    FOREIGN KEY (student) REFERENCES Student(idnr),
    FOREIGN KEY (program, branch) REFERENCES Branches(program, name)
);

CREATE TABLE MandatoryBranchCourses(
    program TEXT NOT NULL,
    branch TEXT NOT NULL,
    course CHAR(6) NOT NULL,

    FOREIGN KEY(course) REFERENCES Courses(code),
    FOREIGN KEY(program, branch) REFERENCES Branches(program, name),
    PRIMARY KEY (program, branch, course)

);

CREATE TABLE MandatoryProgramCourses(
    program TEXT PRIMARY KEY NOT NULL,
    course CHAR(6) NOT NULL,

    FOREIGN KEY program REFERENCES Program(name),
    FOREIGN KEY course REFERENCES Courses(name)

);

CREATE TABLE RecommendedBranchCourses(
    program TEXT NOT NULL,
    branch TEXT NOT NULL,
    course CHAR(6) NOT NULL,

    PRIMARY KEY(program, branch, course),
    FOREIGN KEY(program, branch) REFERENCES Branches(program, name)

);

CREATE TABLE Registered(
    student CHAR(10) PRIMARY KEY NOT NULL,
    course CHAR(6) NOT NULL,

    FOREIGN KEY (student) REFERENCES Students(idnr),
    FOREIGN KEY (course) REFERENCES Courses(code)

);


CREATE TABLE Grades(
    student TEXT NOT NULL,
    course CHAR(6) NOT NULL,
    grade CHAR(1) NOT NULL,

    UNIQUE(student, course),

    FOREIGN KEY(student) REFERENCES Students(idnr),
    FOREIGN KEY(course) REFERENCES Courses(code)

);
