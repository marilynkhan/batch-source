CREATE TABLE user_table (
    userid      INTEGER PRIMARY KEY,
    user_type   VARCHAR2(30),
    username    VARCHAR2(300) UNIQUE,
    upassword   VARCHAR2(300),
    FOREIGN KEY ( userid )
        REFERENCES acc_holder_info ( userid )
)

CREATE TABLE acc_holder_info (
    userid            INTEGER UNIQUE,
    acc_number INTEGER PRIMARY KEY,
    acc_holder_name   VARCHAR2(200),
    address           VARCHAR(100),
    city              VARCHAR(60),
    state             VARCHAR(60),
    country           VARCHAR(50),
    email             VARCHAR(100),
    phone             VARCHAR(20),
    FOREIGN KEY (acc_number) REFERENCES bank_account (acc_number)
)

CREATE TABLE bank_account (
    userid       INTEGER UNIQUE,
    acc_number   INTEGER PRIMARY KEY,
    acc_number1  INTEGER,
    acc_type     VARCHAR2(20),
    acc_status   VARCHAR2(20),
    old_balance      NUMBER,
    updated_balance NUMBER,
    FOREIGN KEY (userid )
        REFERENCES transac_table ( userid)
)

CREATE TABLE transac_table (
    userid          INTEGER PRIMARY KEY,
    transactionid   NUMBER UNIQUE,
    acc_number      INTEGER,
    acc_number2     INTEGER,
    acc_type        VARCHAR2(20),
    acc_status      VARCHAR2(30),
    trans_type      VARCHAR(20),
    trans_amount    NUMBER(10,3),
    trans_time      DATE
)

CREATE SEQUENCE USERID_SEQ
INCREMENT BY 1
START WITH 100;

CREATE SEQUENCE ACC_NUMBER_SEQ
INCREMENT BY 1
START WITH 50;

CREATE OR REPLACE TRIGGER TR_INSERT_USERID
BEFORE INSERT ON user_table
FOR EACH ROW
BEGIN
  SELECT USERID_SEQ.NEXTVAL INTO :NEW.USERID FROM DUAL;
END;

CREATE OR REPLACE TRIGGER TR_INSERT_ACC_NUMBER
BEFORE INSERT ON acc_holder_infO
FOR EACH ROW
BEGIN
  SELECT ACC_NUMBER_SEQ.NEXTVAL INTO :NEW.acc_number FROM DUAL;
END;

INSERT INTO transac_table VALUES (USERID_SEQ.NEXTVAL,10,ACC_NUMBER_SEQ.NEXTVAL, NULL, 'checking', 'blocked', 'deposit', 6897.41, (TO_DATE('2017/03/07 01:02:44', 'yyyy/mm/dd hh24:mi:ss')));
INSERT INTO transac_table  VALUES (USERID_SEQ.NEXTVAL,19,ACC_NUMBER_SEQ.NEXTVAL, NULL, 'checking', 'closed', 'withdraw', 2986.78, (TO_DATE('2017/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss')));
INSERT INTO transac_table VALUES (USERID_SEQ.NEXTVAL,17,ACC_NUMBER_SEQ.NEXTVAL, NULL, 'saving', 'blocked', 'withdraw', 8358.30, (TO_DATE('2017/01/13 20:02:44', 'yyyy/mm/dd hh24:mi:ss')));
INSERT INTO  transac_table VALUES (USERID_SEQ.NEXTVAL,12 ,ACC_NUMBER_SEQ.NEXTVAL, NULL, 'CD', 'open', 'withdraw', 5302.69, (TO_DATE('2017/02/23 12:02:44', 'yyyy/mm/dd hh24:mi:ss')));
INSERT INTO transac_table VALUES (USERID_SEQ.NEXTVAL,15 ,ACC_NUMBER_SEQ.NEXTVAL, NULL, 'checking', 'overdrawn', 'Balance_Inquiry', 16363.30, (TO_DATE('2017/06/25 15:02:00', 'yyyy/mm/dd hh24:mi:ss')));
INSERT INTO transac_table VALUES (USERID_SEQ.NEXTVAL,20,ACC_NUMBER_SEQ.NEXTVAL, NULL,'checking', 'closed', 'deposit', 1451.19, (TO_DATE('2017/09/18 19:01:40', 'yyyy/mm/dd hh24:mi:ss')));


INSERT INTO bank_account  VALUES (120, 50, NULL, 'checking', 'closed', 14625.74, 14625.74 );
INSERT INTO bank_account VALUES (121, 51, NULL, 'CD', 'overdrawn', 18740.55, 18740.55);
INSERT INTO bank_account  VALUES (122, 52, NULL, 'CD', 'overdrawn', 5624.92, 5024.00);
INSERT INTO bank_account  VALUES (123, 53, NULL, 'checking', 'open', 8994.83, 9023.00);
INSERT INTO bank_account  VALUES (124, 54, NULL, 'saving', 'closed', 9071.77, 5000.34);
INSERT INTO bank_account  VALUES (125, 55, NULL, 'CD', 'open', 10613.86, 10613.86);


INSERT INTO acc_holder_info  VALUES (120, 50, 'Josie Davidson', '7397 kirkwood', 'worcester', 'MASSACHUSETTS', 'united states', 'Jo.DAVID1932@mailinator.com', '(417) 783-2657');
INSERT INTO acc_holder_info VALUES (121, 51, 'Nathaniel Guy', '3407 ellsworth', 'sioux falls', 'SOUTH DAKOTA', 'united states', 'Nathan.GUY7815@dispostable.com', '(530) 277-8116');
INSERT INTO acc_holder_info VALUES (122, 52, 'Ramon Brewer', '7256 milwaukee', 'fort lauderdale', 'FLORIDA', 'united states', 'Ramon.BREW6437@yopmail.com', '(904) 805-3554');
INSERT INTO acc_holder_info  VALUES (123, 53, 'Rylie Gay', '1982 kirby', 'orlando', 'FLORIDA', 'united states', 'Ry.G1469@mailinator.com', '(681) 972-6138');
INSERT INTO acc_holder_info  VALUES (124, 54, 'Bentlee Simmons', '7860 117th', 'san bernardino', 'CALIFORNIA', 'united states', 'Bent.SIMMONS9843@mailinator.com', '(801) 372-8916');
INSERT INTO acc_holder_info VALUES (125, 55, 'Benjamin Odom', '8933 millard', 'tucson', 'ARIZONA', 'united states', 'Benjami.ODOM2629@monumentmail.com', '(985) 419-5319');


INSERT INTO user_table VALUES (120, 'Account_Holder', 'quinbray5090', '7keJQ15mfB');
INSERT INTO user_table VALUES (121, 'Account_Holder', 'lesar5319', 'fwYMKNPXas');
INSERT INTO user_table VALUES (122, 'Admin1', 'colhatfi4580', 'nQd8GUCkP');
INSERT INTO user_table VALUES (123, 'Admin2', 'tarawar5535', 'SsWr8jIl3v');
INSERT INTO user_table  VALUES (124, 'Account_Holder', 'ingherrer8634', 'JwgspWz');
INSERT INTO user_table VALUES (125, 'Account_Holder', 'drewcox2642', 'Og4KiIkW6');

CREATE OR REPLACE PROCEDURE DEPOSIT_PROCEDURE
(
    DEPOSIT_AMOUNT   IN    NUMBER,
    IN_ACC_NUMBER  IN  NUMBER,
     CURRENT_BALANCE OUT BANK_ACCOUNT.UPDATED_BALANCE%TYPE
)

IS
   
BEGIN
        SELECT   UPDATED_BALANCE
        INTO    CURRENT_BALANCE
        FROM    BANK_ACCOUNT
        WHERE   ACC_NUMBER = IN_ACC_NUMBER;

 IF  DEPOSIT_AMOUNT > 0   
    THEN
            UPDATE  BANK_ACCOUNT          
            SET     UPDATED_BALANCE  = CURRENT_BALANCE + DEPOSIT_AMOUNT
            WHERE   ACC_NUMBER= IN_ACC_NUMBER;
            dbms_output.put_line('Money has been deposited successfully');
    COMMIT;
END IF;
    EXCEPTION
    WHEN OTHERS    
    THEN            
        ROLLBACK;  
END;
/

CREATE OR REPLACE  PROCEDURE withdrawal_procedure(from_acc_number IN NUMBER,
                                             withdraw_amount IN NUMBER,
                                        CURRENT_BALANCE OUT BANK_ACCOUNT.UPDATED_BALANCE%TYPE)
IS
 
BEGIN
  SELECT UPDATED_BALANCE
    INTO CURRENT_BALANCE
    FROM BANK_ACCOUNT
    WHERE ACC_NUMBER = FROM_ACC_NUMBER;

  IF current_balance < withdraw_amount then
  UPDATE bank_account
   set UPDATED_BALANCE =current_balance - withdraw_amount
        WHERE acc_number = from_acc_number;
   dbms_output.put_line('Your account is overdrawn');
  else
    update BANK_ACCOUNT
      set UPDATED_BALANCE = current_balance- withdraw_amount
      where acc_number = from_acc_number;
  end if; 
  dbms_output.put_line('Money has been withdrawn successfully');
  
  EXCEPTION
    WHEN OTHERS    
    THEN         
        ROLLBACK; 
        COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE BALANCE_INQUIRY (
            IN_ACCOUNT_NUMBER IN NUMBER, CURRENT_ACC_BALANCE OUT BANK_ACCOUNT.UPDATED_BALANCE%TYPE) IS
BEGIN
        
        SELECT UPDATED_BALANCE INTO CURRENT_ACC_BALANCE
        FROM BANK_ACCOUNT
        WHERE ACC_NUMBER = IN_ACCOUNT_NUMBER;
        IF CURRENT_ACC_BALANCE >= 0 THEN
       DBMS_OUTPUT.PUT_LINE('YOUR CURRENT BALANCE IS: '|| CURRENT_ACC_BALANCE);
        ELSE
        DBMS_OUTPUT.PUT_LINE('YOU ACCOUNT IS OVERDRAWN: '|| CURRENT_ACC_BALANCE);
        END IF;
COMMIT;
 EXCEPTION
    WHEN OTHERS    
    THEN           
        ROLLBACK;   
END;
/

CREATE OR REPLACE PROCEDURE DELETE_ACCOUNT (
            IN_ACC_NUMBER INTEGER
            ) IS

CURRENT_BALANCE BANK_ACCOUNT.UPDATED_BALANCE%TYPE;
CURRENT_BALANCE_IS_NEGATIVE EXCEPTION;
BEGIN
SELECT UPDATED_BALANCE
    INTO CURRENT_BALANCE
    FROM BANK_ACCOUNT
    WHERE ACC_NUMBER = IN_ACC_NUMBER;
    
        IF CURRENT_BALANCE = 0
        THEN
        DELETE FROM BANK_ACCOUNT
        WHERE ACC_NUMBER = IN_ACC_NUMBER;
        END IF;
         DBMS_OUTPUT.PUT_LINE('THE ACCOUNT '||IN_ACC_NUMBER ||'HAS BEEN DELETED');
        COMMIT;
EXCEPTION
    WHEN CURRENT_BALANCE_IS_NEGATIVE
    THEN    
     DBMS_OUTPUT.PUT_LINE('YOU OWE THE BANK MONEY');
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE CREATE_NEW_ACCOUNT (
                IN_USER_ID IN INTEGER,  NEW_ACC_NUMBER OUT BANK_ACCOUNT.ACC_NUMBER%TYPE) IS
 
 USERID_DOESNOT_EXIST EXCEPTION;
 BEGIN
    
   SELECT ACC_NUMBER_SEQ.NEXTVAL INTO NEW_ACC_NUMBER FROM DUAL;
   IF IN_USER_ID IS NOT NULL THEN
   UPDATE BANK_ACCOUNT SET ACC_NUMBER1 = NEW_ACC_NUMBER WHERE USERID = IN_USER_ID;
   END IF;
   COMMIT;
   DBMS_OUTPUT.PUT_LINE('YOUR HAVE SUCCESSFULY CREATED A NEW ACCOUNT: '|| NEW_ACC_NUMBER);
   EXCEPTION
    WHEN USERID_DOESNOT_EXIST   
    THEN  
    DBMS_OUTPUT.PUT_LINE('PLEASE ENTER A VALID USERID');
        ROLLBACK; 
   END;
   /
   
   CREATE OR REPLACE PROCEDURE UNREGISTER_USER(NEW_ACC_NUM OUT INTEGER, 
                                               NEW_USER_ID  OUT INTEGER,
                                               USER_NAME IN VARCHAR2,
                                               USER_PASS IN VARCHAR2,
                                               NEW_USER_NAME IN VARCHAR2
                                               ) IS
    
BEGIN

SELECT ACC_NUMBER_SEQ.NEXTVAL INTO NEW_ACC_NUM FROM DUAL;
SELECT USERID_SEQ.NEXTVAL INTO NEW_USER_ID FROM DUAL;

IF USER_NAME IS NOT NULL AND USER_PASS IS NOT NULL THEN
INSERT INTO TRANSAC_TABLE(USERID, ACC_NUMBER) VALUES (NEW_USER_ID, NEW_ACC_NUM);
INSERT INTO BANK_ACCOUNT (USERID, ACC_NUMBER) VALUES (NEW_USER_ID, NEW_ACC_NUM);
INSERT INTO ACC_HOLDER_INFO(USERID, ACC_NUMBER, ACC_HOLDER_NAME) VALUES(NEW_USER_ID, NEW_ACC_NUM, NEW_USER_NAME);
INSERT INTO USER_TABLE VALUES(NEW_USER_ID,'ACCOUNT_HOLDER', USER_NAME, USER_PASS);
DBMS_OUTPUT.PUT_LINE('You are a registered user now, your userid and account number is: '||NEW_USER_ID||''||NEW_ACC_NUM);
END IF;
COMMIT;

 EXCEPTION
    WHEN OTHERS
    THEN  
        ROLLBACK; 
END;
/

CREATE OR REPLACE PACKAGE SUPERUSER_FUNCTION AS

PROCEDURE UPDATE_ACC_HOLDER ( 
      IN_USER_ID     ACC_HOLDER_INFO.USERID%TYPE,
    NEW_NAME    IN  ACC_HOLDER_INFO.ACC_HOLDER_NAME%TYPE,
    NEW_ADDRESS     IN ACC_HOLDER_INFO.ADDRESS%TYPE,
    NEW_CITY        IN ACC_HOLDER_INFO.CITY%TYPE,
    NEW_STATE        IN ACC_HOLDER_INFO.STATE%TYPE,
    NEW_COUNTRY      IN ACC_HOLDER_INFO.COUNTRY%TYPE,
    NEW_PHONE       IN ACC_HOLDER_INFO.PHONE%TYPE,
    NEW_EMAIL        IN ACC_HOLDER_INFO.EMAIL%TYPE);
    
    PROCEDURE DELETE_ACCOUNT_HOLDER(
    IN_USER_ID IN ACC_HOLDER_INFO.USERID%TYPE);
    
    PROCEDURE ADD_ACC_HOLDER (
        NEW_USERID OUT USER_TABLE.USERID%TYPE,
        NEW_ACCOUNT_NUMBER OUT INTEGER,
        NEW_USER_NAME IN USER_TABLE.USERNAME%TYPE,
        NEW_USER_PASW IN USER_TABLE.UPASSWORD%TYPE,
        NEW_HOLDER_NAME IN VARCHAR2
        );
   
END SUPERUSER_FUNCTION;
 
CREATE OR REPLACE PACKAGE BODY SUPERUSER_FUNCTION AS

PROCEDURE UPDATE_ACC_HOLDER ( 
      IN_USER_ID     ACC_HOLDER_INFO.USERID%TYPE,
    NEW_NAME    IN  ACC_HOLDER_INFO.ACC_HOLDER_NAME%TYPE,
    NEW_ADDRESS     IN ACC_HOLDER_INFO.ADDRESS%TYPE,
    NEW_CITY        IN ACC_HOLDER_INFO.CITY%TYPE,
    NEW_STATE        IN ACC_HOLDER_INFO.STATE%TYPE,
    NEW_COUNTRY      IN ACC_HOLDER_INFO.COUNTRY%TYPE,
    NEW_PHONE       IN ACC_HOLDER_INFO.PHONE%TYPE,
    NEW_EMAIL        IN ACC_HOLDER_INFO.EMAIL%TYPE) IS
BEGIN
IF IN_USER_ID IS NOT NULL THEN
UPDATE ACC_HOLDER_INFO
        SET
            ACC_HOLDER_NAME = NEW_NAME,
            ADDRESS = NEW_ADDRESS,
            CITY = NEW_CITY,
            STATE = NEW_STATE,
            COUNTRY = NEW_COUNTRY,
           EMAIL = NEW_EMAIL,
            PHONE = NEW_PHONE
    WHERE
        USERID = IN_USER_ID; 

DBMS_OUTPUT.put_line('Admin just updated the account holder table for: '||IN_USER_ID);
END IF;
COMMIT;
EXCEPTION
    WHEN OTHERS
    THEN  
        ROLLBACK; 
END UPDATE_ACC_HOLDER;

PROCEDURE DELETE_ACCOUNT_HOLDER(
    IN_USER_ID IN ACC_HOLDER_INFO.USERID%TYPE) IS
    IN_USER_TYPE USER_TABLE.USER_TYPE%TYPE;
    BEGIN
    
    IF IN_USER_TYPE != 'Admin1' AND IN_USER_TYPE !='Admin2' THEN
    DELETE FROM ACC_HOLDER_INFO WHERE USERID=IN_USER_ID;
    DBMS_OUTPUT.PUT_LINE('Admin successfully deleted userid '||IN_USER_ID);
    END IF;
    COMMIT;
    EXCEPTION
        WHEN OTHERS
        THEN  
        ROLLBACK; 
END DELETE_ACCOUNT_HOLDER;

  PROCEDURE ADD_ACC_HOLDER (
        NEW_USERID OUT USER_TABLE.USERID%TYPE,
        NEW_ACCOUNT_NUMBER OUT INTEGER,
        NEW_USER_NAME IN USER_TABLE.USERNAME%TYPE,
        NEW_USER_PASW IN USER_TABLE.UPASSWORD%TYPE,
        NEW_HOLDER_NAME IN VARCHAR2
        ) IS
BEGIN
SELECT ACC_NUMBER_SEQ.NEXTVAL INTO NEW_ACCOUNT_NUMBER FROM DUAL;
SELECT USERID_SEQ.NEXTVAL INTO NEW_USERID FROM DUAL;

IF NEW_USER_NAME IS NOT NULL AND NEW_USER_PASW IS NOT NULL THEN
INSERT INTO TRANSAC_TABLE(USERID, ACC_NUMBER) VALUES (NEW_USERID, NEW_ACCOUNT_NUMBER);
INSERT INTO BANK_ACCOUNT (USERID, ACC_NUMBER) VALUES (NEW_USERID, NEW_ACCOUNT_NUMBER);
INSERT INTO ACC_HOLDER_INFO(USERID, ACC_NUMBER, ACC_HOLDER_NAME) VALUES(NEW_USERID, NEW_ACCOUNT_NUMBER, NEW_HOLDER_NAME);
INSERT INTO USER_TABLE VALUES(NEW_USERID,'ACCOUNT_HOLDER', NEW_USER_NAME, NEW_USER_PASW);
DBMS_OUTPUT.PUT_LINE('Admin just created a new account holder profile with userid and account number: '||NEW_USERID || 'and' || NEW_ACCOUNT_NUMBER);
END IF;
COMMIT;

 EXCEPTION
    WHEN OTHERS
    THEN  
        ROLLBACK; 
END ADD_ACC_HOLDER;
  END SUPERUSER_FUNCTION;  

