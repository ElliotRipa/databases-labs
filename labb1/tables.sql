-- This script deletes everything in your database
\set QUIET true
SET client_min_messages TO WARNING; -- Less talk please.
-- This script deletes everything in your database
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO CURRENT_USER;
-- This line makes psql stop on the first error it encounters
-- You may want to remove this when running tests that are intended to fail
\set ON_ERROR_STOP ON
SET client_min_messages TO NOTICE; -- More talk
\set QUIET false



CREATE TABLE Students (
    idnr    CHAR(10) PRIMARY KEY NOT NULL,
    name    TEXT NOT NULL,
    login   TEXT NOT NULL,
    program TEXT NOT NULL

);


CREATE TABLE Branches (
    name     TEXT NOT NULL,
    program  TEXT NOT NULL,

    PRIMARY KEY (name, program)

);


CREATE TABLE Courses (
    code        CHAR(6) PRIMARY KEY NOT NULL,
    name        TEXT NOT NULL,
    credits     INT NOT NULL,
    department  TEXT NOT NULL

);


CREATE TABLE LimitedCourses(
    code     CHAR(6) PRIMARY KEY NOT NULL,
    capacity INT NOT NULL CHECK(capacity > 0),

    FOREIGN KEY(code) REFERENCES Courses(code)

);


CREATE TABLE StudentBranches (
    student CHAR(10) PRIMARY KEY NOT NULL,
    branch  TEXT,
    program TEXT NOT NULL,

    FOREIGN KEY(student) REFERENCES Students(idnr),
    FOREIGN KEY(branch, program) REFERENCES Branches(name, program)

);


CREATE TABLE Classifications(
    name TEXT PRIMARY KEY NOT NULL

);


CREATE TABLE Classified(
    course         CHAR(6) NOT NULL,
    classification TEXT NOT NULL,

    PRIMARY KEY(course, classification),

    FOREIGN KEY(course) REFERENCES Courses(code),
    FOREIGN KEY(classification) REFERENCES Classifications(name)   --Weird considering multiple classifications possible.
);


CREATE TABLE MandatoryProgram(
    course  CHAR(6) NOT NULL,
    program TEXT NOT NULL,

    PRIMARY KEY(program, course),

    FOREIGN KEY(course) REFERENCES Courses(code)

);


CREATE TABLE MandatoryBranch(
    course  CHAR(6) NOT NULL,
    branch  TEXT NOT NULL,
    program TEXT NOT NULL,

    PRIMARY KEY(course, branch, program),

    FOREIGN KEY(course) REFERENCES Courses(code),
    FOREIGN KEY(branch, program) REFERENCES Branches(name, program)

);


CREATE TABLE RecommendedBranch(
    course  CHAR(6) NOT NULL,
    branch  TEXT NOT NULL,
    program TEXT NOT NULL,

    PRIMARY KEY (course, branch, program),

    FOREIGN KEY(course) REFERENCES Courses(code),
    FOREIGN KEY(branch, program) REFERENCES Branches(name, program)

);


CREATE TABLE Registered(

    student TEXT NOT NULL,
    course  CHAR(6) NOT NULL,

    PRIMARY KEY(student, course)

);


CREATE TABLE Taken(
    student CHAR(10) NOT NULL,
    course CHAR(6) NOT NULL,
    grade CHAR(1) CHECK(grade IN ('U', '3', '4', '5')),

    PRIMARY KEY(student, course),

    FOREIGN KEY(student) REFERENCES Students(idnr),
    FOREIGN KEY(course) REFERENCES Courses(code)

);


CREATE TABLE WaitingList(
    student  CHAR(10) NOT NULL,
    course   CHAR(6) NOT NULL,
    position INT NOT NULL,

    PRIMARY KEY (student, course),

    FOREIGN KEY (student) REFERENCES Students(idnr),
    FOREIGN KEY (course) REFERENCES LimitedCourses(code)

);


SELECT * FROM Students;






