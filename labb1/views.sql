CREATE VIEW BasicInformation AS
    SELECT idnr, name, login, program
    FROM Students
    WHERE true;
