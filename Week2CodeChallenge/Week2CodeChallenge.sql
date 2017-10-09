--CREATE TABLES
CREATE TABLE DEPARTMENT (
    DEPARTMENT_ID NUMBER PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR2(30)
);

CREATE TABLE EMPLOYEE (
    EMPLOYEE_ID NUMBER PRIMARY KEY, 
    EMP_FIRSTNAME VARCHAR2(20),
    EMP_LASTNAME VARCHAR2(20), 
    DEPARTMENT_ID NUMBER, 
    SALARY NUMBER, 
    EMP_EMAIL VARCHAR2(50)
);
    
ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_EMPLOYEE_DEPARTMENT
FOREIGN KEY (DEPARTMENT_ID)
REFERENCES DEPARTMENT(DEPARTMENT_ID);

--SEQUENCES FOR PKS
CREATE SEQUENCE SQ_DEPARTMENT_PK
START WITH 1
INCREMENT BY 2;

CREATE SEQUENCE SQ_EMPLOYEE_PK
START WITH 1
INCREMENT BY 2;


--TRIGGERS TO CREATE PK
CREATE OR REPLACE TRIGGER DEPARTMENT_INSERT
BEFORE INSERT ON DEPARTMENT
FOR EACH ROW
BEGIN
    SELECT SQ_DEPARTMENT_PK.NEXTVAL INTO :NEW.DEPARTMENT_ID
    FROM DUAL;
END;

CREATE OR REPLACE TRIGGER EMPLOYEE_INSERT
BEFORE INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    SELECT SQ_EMPLOYEE_PK.NEXTVAL INTO :NEW.EMPLOYEE_ID
    FROM DUAL;
END;

--INSERT DEPARTMENTS AND EMPLOYEES
INSERT INTO DEPARTMENT (DEPARTMENT_NAME) VALUES('TECHNOLOGY');
INSERT INTO DEPARTMENT (DEPARTMENT_NAME) VALUES('FINANCIAL');
INSERT INTO DEPARTMENT (DEPARTMENT_NAME) VALUES('MEDIA');

INSERT INTO EMPLOYEE (EMP_FIRSTNAME,EMP_LASTNAME,DEPARTMENT_ID,SALARY,EMP_EMAIL) VALUES ('JESSICA','SMITH',1,55,'RAND@EMIAL.COM');
INSERT INTO EMPLOYEE (EMP_FIRSTNAME,EMP_LASTNAME,DEPARTMENT_ID,SALARY,EMP_EMAIL) VALUES ('JOSE','LOPEZ',3,56,'RAND01@EMIAL.COM');
INSERT INTO EMPLOYEE (EMP_FIRSTNAME,EMP_LASTNAME,DEPARTMENT_ID,SALARY,EMP_EMAIL) VALUES ('KATE','JONES',5,60,'RAND02@EMIAL.COM');
INSERT INTO EMPLOYEE (EMP_FIRSTNAME,EMP_LASTNAME,DEPARTMENT_ID,SALARY,EMP_EMAIL) VALUES ('MILES','GOLDY',1,55,'RAND03@EMIAL.COM');
INSERT INTO EMPLOYEE (EMP_FIRSTNAME,EMP_LASTNAME,DEPARTMENT_ID,SALARY,EMP_EMAIL) VALUES ('ROSE','JIMENEZ',3,56,'RAND04@EMIAL.COM');
INSERT INTO EMPLOYEE (EMP_FIRSTNAME,EMP_LASTNAME,DEPARTMENT_ID,SALARY,EMP_EMAIL) VALUES ('BILL','DAVIS',5,60,'RAND05@EMIAL.COM');


--STORED PROCEDURE TO RAISE SALARY
CREATE OR REPLACE FUNCTION DEP_EXISTS
(D_ID IN NUMBER)
RETURN NUMBER
IS FOUND NUMBER;
BEGIN
    SELECT DEPARTMENT_ID INTO FOUND FROM DEPARTMENT
    WHERE DEPARTMENT_ID = D_ID;
    RETURN FOUND;
END;

CREATE OR REPLACE PROCEDURE SP_GIVE_RAISE
(D_ID IN NUMBER, AVG_SALARY OUT NUMBER, DEP_FOUND OUT BOOLEAN)
IS
BEGIN
    
    IF DEP_EXISTS(D_ID)>0 THEN
        DEP_FOUND := TRUE;
        --UPDATE SALARIES
        UPDATE EMPLOYEE SET SALARY = SALARY * 1.10
        WHERE DEPARTMENT_ID = D_ID;
        --FIND AVG SALARY
        SELECT AVG(SALARY) INTO AVG_SALARY FROM EMPLOYEE
        WHERE DEPARTMENT_ID = D_ID;
    ELSE
        DEP_FOUND := FALSE;
        AVG_SALARY := NULL;
    END IF;
    COMMIT; 
END;
