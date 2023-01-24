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
    idnr TEXT PRIMARY KEY NOT NULL CHECK(LENGTH(idnr) = 10),
    name TEXT NOT NULL,
    login TEXT NOT NULL,
    program TEXT NOT NULL
);

CREATE TABLE Branches (

    name TEXT NOT NULL,
    program TEXT NOT NULL,
    PRIMARY KEY (name, program)
);

CREATE TABLE Courses (
    code VARCHAR(6) PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    credits INT NOT NULL,
    department text NOT NULL
);

CREATE TABLE LimitedCourses(
    code TEXT PRIMARY KEY NOT NULL,
    capacity INT NOT NULL CHECK(capacity > 0),
    FOREIGN KEY(code) REFERENCES Courses(code)
);

CREATE TABLE StudentBranches (
    student TEXT PRIMARY KEY,
    branch TEXT,
    program TEXT NOT NULL,
    FOREIGN KEY(student) REFERENCES Students(idnr),
    FOREIGN KEY(branch, program) REFERENCES Branches(name, program)
);

CREATE TABLE Classifications(
    name TEXT PRIMARY KEY NOT NULL

);

CREATE TABLE Classified(
    course TEXT PRIMARY KEY,
    classification TEXT PRIMARY KEY,

    PRIMARY KEY(course, classification),
    FOREIGN KEY(course) REFERENCES Courses(code),
    FOREIGN KEY(classification) REFERENCES Classifications(name)

);

CREATE TABLE MandatoryProgram(
    course TEXT NOT NULL,
    program TEXT NOT NULL,
    PRIMARY KEY(course, program),
    FOREIGN KEY(course) REFERENCES Courses(code)
);

CREATE TABLE MandatoryBranch(
    course TEXT PRIMARY KEY
    FOREIGN KEY(course) REFERENCES Courses(code)

);

CREATE TABLE ();
CREATE TABLE ();
CREATE TABLE ();
CREATE TABLE ();
CREATE TABLE ();



SELECT * FROM Students;