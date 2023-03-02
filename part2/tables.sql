CREATE TABLE Departments(
    name            TEXT PRIMARY KEY NOT NULL,
    abbreviation    TEXT UNIQUE NOT NULL
);


CREATE TABLE Programs(
    name TEXT PRIMARY KEY NOT NULL,
    abbreviation TEXT NOT NULL

);

CREATE TABLE HostedBy(
    program TEXT NOT NULL,
    department TEXT NOT NULL,

    PRIMARY KEY(program, department),

    FOREIGN KEY(program) REFERENCES Programs(name),
    FOREIGN KEY(department) REFERENCES Departments(name)

);


CREATE TABLE Students(
    idnr    CHAR(10) PRIMARY KEY NOT NULL,
    login   TEXT NOT NULL,
    name    TEXT NOT NULL,
    program TEXT NOT NULL,

    FOREIGN KEY(program) REFERENCES Programs(name)

);


CREATE TABLE Branches(
    name TEXT NOT NULL,
    program TEXT NOT NULL,

    PRIMARY KEY(name, program),

    FOREIGN KEY(program) REFERENCES Programs(name)

);


CREATE TABLE Courses(
    code CHAR(6) PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    credits FLOAT NOT NULL,
    department TEXT NOT NULL,

    FOREIGN KEY(department) REFERENCES Departments(name)
);


CREATE TABLE PrerequisiteFor(

    course CHAR(6) NOT NULL,
    prerequisite CHAR(6) NOT NULL,

    FOREIGN KEY(course) REFERENCES courses(code),
    FOREIGN KEY(prerequisite) REFERENCES Courses(code),

    PRIMARY KEY(course, prerequisite)
);


CREATE TABLE LimitedCourses(
    course CHAR(6) NOT NULL PRIMARY KEY,
    capacity INT NOT NULL,

    FOREIGN KEY(course) REFERENCES Courses(code)

);


CREATE TABLE Classifications(
    name TEXT PRIMARY KEY NOT NULL

);


CREATE TABLE Classified(
    course CHAR(6) NOT NULL,
    classification TEXT NOT NULL,

    FOREIGN KEY(course) REFERENCES Courses(code),
    FOREIGN KEY(classification) REFERENCES Classifications(name),

    PRIMARY KEY(course, classification)

);


CREATE TABLE WaitingList(
    student CHAR(10) NOT NULL,
    course CHAR(6) NOT NULL,
    position INT NOT NULL,

    FOREIGN KEY(course) REFERENCES Courses(code),
    FOREIGN KEY(student) REFERENCES Students(idnr),

    PRIMARY KEY(course, position),

    UNIQUE(course, student)

);


CREATE TABLE PartOfBranch(
    student CHAR(10) PRIMARY KEY NOT NULL,
    branch TEXT NOT NULL,
    program TEXT NOT NULL,

    FOREIGN KEY(student) REFERENCES Students(idnr),
    FOREIGN KEY(program, branch) REFERENCES Branches(program, name)

);


CREATE TABLE MandatoryBranchCourses(
    course CHAR(6) NOT NULL,
    branch TEXT NOT NULL,
    program TEXT NOT NULL,

    FOREIGN KEY(course) REFERENCES Courses(code),
    FOREIGN KEY(program, branch) REFERENCES Branches(program, name),

    PRIMARY KEY(program, branch, course)

);


CREATE TABLE MandatoryProgramCourses(
    course CHAR(6) NOT NULL,
    program TEXT NOT NULL,

    FOREIGN KEY(program) REFERENCES Programs(name),
    FOREIGN KEY(course) REFERENCES Courses(code),

    PRIMARY KEY(program, course)

);


CREATE TABLE RecommendedBranchCourses(
    course CHAR(6) NOT NULL,
    branch TEXT NOT NULL,
    program TEXT NOT NULL,

    PRIMARY KEY(program, branch, course),
    FOREIGN KEY(program, branch) REFERENCES Branches(program, name)

);


CREATE TABLE Registered(
    student CHAR(10) NOT NULL,
    course CHAR(6) NOT NULL,

    FOREIGN KEY(student) REFERENCES Students(idnr),
    FOREIGN KEY(course) REFERENCES Courses(code),

    PRIMARY KEY(student, course)

);


CREATE TABLE Grades(
    student TEXT NOT NULL,
    course CHAR(6) NOT NULL,
    grade CHAR(1) NOT NULL,

    PRIMARY KEY(student, course),

    FOREIGN KEY(student) REFERENCES Students(idnr),
    FOREIGN KEY(course) REFERENCES Courses(code),

    CHECK(grade IN ('U', '3', '4', '5'))

);

