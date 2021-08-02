
CREATE OR REPLACE PROCEDURE CHECK_USER( PIS_PHONE IN VARCHAR2, 
                                        PIS_PASS IN VARCHAR2, 
                                        CHECKER OUT NUMBER) IS
V_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)INTO V_COUNT FROM SUBSCRIBER WHERE PIS_PASS=PASS_WORD AND PIS_PHONE=PHONE_NUMBER ;
    IF (V_COUNT=0) THEN
    DBMS_OUTPUT.PUT_LINE('Giriþ reddedildi.');
    CHECKER:=0;
    ELSE
    DBMS_OUTPUT.PUT_LINE('Giriþ onaylandý.');
    CHECKER:=1;
    END IF;
END CHECK_USER;
/



        ---    O  O  0    ---




 

CREATE OR REPLACE PROCEDURE GET_BALANCES(   PIS_PHONE IN VARCHAR2, 
                                            REMAIN_GB OUT NUMBER, 
                                            REMAIN_VOICE OUT NUMBER, 
                                            REMAIN_SMS OUT NUMBER) IS
FIRSTNAME   VARCHAR2(50);
CHECKER     NUMBER ;
RANDOM_NUMBER NUMBER(5);
WARN_GB     NUMBER(5,2);
WARN_MIN    NUMBER;
WARN_SMS    NUMBER;
REM_GB      NUMBER;
REM_MIN     NUMBER;
REM_SMS     NUMBER;
BEGIN
    SELECT COUNT(*)INTO CHECKER FROM SUBSCRIBER WHERE PHONE_NUMBER=PIS_PHONE;
    IF CHECKER=1 THEN
        SELECT FULL_NAME INTO FIRSTNAME FROM SUBSCRIBER WHERE PHONE_NUMBER=PIS_PHONE;
        SELECT DATA_GB_REMAIN, VOICE_REMAIN, SMS_REMAIN INTO REM_GB, REM_MIN, REM_SMS
        FROM SUBSCRIBER_PACKAGE_REMAINDER WHERE PHONE_NUMBER=PIS_PHONE;
        
        IF REM_GB>0 AND REM_MIN>0 AND REM_SMS>0 THEN
            SELECT DATA_GB_REMAIN, VOICE_REMAIN, SMS_REMAIN INTO REMAIN_GB, REMAIN_VOICE, REMAIN_SMS
            FROM SUBSCRIBER_PACKAGE_REMAINDER WHERE PHONE_NUMBER=PIS_PHONE;
            SELECT ROUND(DBMS_RANDOM.VALUE(1,10)) RANDOM INTO RANDOM_NUMBER FROM DUAL;
            DBMS_OUTPUT.PUT_LINE('Merhaba ' || FIRSTNAME || ',');
            DBMS_OUTPUT.PUT_LINE('Kalan GB: ' ||  REMAIN_GB);
            DBMS_OUTPUT.PUT_LINE('Kalan Dakika: ' || REMAIN_VOICE);
            DBMS_OUTPUT.PUT_LINE('Kalan Sms: ' || REMAIN_SMS);
            
            REM_GB   :=  REMAIN_GB-RANDOM_NUMBER/50;
            REM_MIN  :=  REMAIN_VOICE-2*RANDOM_NUMBER+1;
            REM_SMS  :=  REMAIN_SMS-RANDOM_NUMBER-4;
            UPDATE SUBSCRIBER_PACKAGE_REMAINDER SET   DATA_GB_REMAIN=REM_GB,
                                        VOICE_REMAIN=REM_MIN,
                                        SMS_REMAIN=REM_SMS 
                                  WHERE PHONE_NUMBER=PIS_PHONE;
                                  
            SELECT DATA_GB_USE, VOICE_USE, SMS_USE INTO WARN_GB,WARN_MIN,WARN_SMS
            FROM SUBSCRIBER_PACKAGE_USE WHERE PHONE_NUMBER=PIS_PHONE;
            
            IF REMAIN_GB<WARN_GB/5
            THEN DBMS_OUTPUT.PUT_LINE('Internetinizin %80inini kullandýnýz.');
            END IF;
            IF REMAIN_VOICE<WARN_MIN/5
            THEN DBMS_OUTPUT.PUT_LINE('Dakikanýzýn %80inini kullandýnýz.');
            END IF;
            IF REMAIN_SMS<WARN_SMS/5
            THEN DBMS_OUTPUT.PUT_LINE('Smslerinizin %80inini kulland?n?z.');
            END IF;
            COMMIT;
            
        ELSE    
            SELECT DATA_GB_USE,VOICE_USE,SMS_USE INTO REMAIN_GB, REMAIN_VOICE, REMAIN_SMS
            FROM SUBSCRIBER_PACKAGE_USE WHERE PHONE_NUMBER=PIS_PHONE;
            UPDATE SUBSCRIBER_PACKAGE_REMAINDER SET   DATA_GB_REMAIN=REMAIN_GB,
                                        VOICE_REMAIN=REMAIN_VOICE,
                                        SMS_REMAIN=REMAIN_SMS 
                                  WHERE PHONE_NUMBER=PIS_PHONE;
            DBMS_OUTPUT.PUT_LINE('Merhaba ' || FIRSTNAME || ',');
            DBMS_OUTPUT.PUT_LINE('Paketin yenilendi.');
            DBMS_OUTPUT.PUT_LINE('Kalan GB: ' ||  REMAIN_GB);
            DBMS_OUTPUT.PUT_LINE('Kalan Dakika: ' || REMAIN_VOICE);
            DBMS_OUTPUT.PUT_LINE('Kalan Sms: ' || REMAIN_SMS);
            COMMIT;
        END IF;
    ELSE 
    REMAIN_GB:=0;
    REMAIN_VOICE:=0;
    REMAIN_SMS:=0;
    DBMS_OUTPUT.PUT_LINE('Yanl?? Numara!');
    END IF;
    
END GET_BALANCES;
/



        ---    O  O  0    ---


CREATE OR REPLACE PROCEDURE CREATE_USER (PIS_F_NAME    IN  VARCHAR2, 
                                        PIS_P_NUMBER   IN  VARCHAR2,
                                        PIS_E_MAIL     IN  VARCHAR2, 
                                        PIS_P_WORD     IN  VARCHAR2,
                                        PIS_B_DAY      IN  VARCHAR2,
                                        CHECKER        OUT NUMBER) IS
PIS_S_ID NUMBER;
CHECK_AGE NUMBER:=0;
CHECK_PHONE_PWORD NUMBER:=1;
BEGIN

    IF MONTHS_BETWEEN(SYSDATE,TO_DATE(PIS_B_DAY,'DD/MM/YYYY'))>144 THEN CHECK_AGE:=1;
    END IF;   
    
    IF CHECK_AGE=1 THEN SELECT COUNT(*) INTO CHECK_PHONE_PWORD  FROM SUBSCRIBER
    WHERE PHONE_NUMBER=PIS_P_NUMBER 
        OR LENGTH(PIS_P_NUMBER)<>10; 
    END IF;
    
    IF CHECK_PHONE_PWORD=0 THEN 
    INSERT INTO SUBSCRIBER
    VALUES (SEQ_SUBSCRIBER_ID.NEXTVAL,
            UPPER(PIS_F_NAME),
            PIS_P_NUMBER,
            PIS_E_MAIL,
            PIS_P_WORD,
            TO_DATE(PIS_B_DAY,'DD/MM/YYYY'));
         
        
            
    DBMS_OUTPUT.PUT_LINE('Eklendi!');
    SELECT SUBSCRIBER_ID INTO PIS_S_ID FROM SUBSCRIBER WHERE PHONE_NUMBER=PIS_P_NUMBER;
    INSERT INTO SUBSCRIBER_PACKAGE_USE
    VALUES (PIS_S_ID,PIS_P_NUMBER,0,0,0);
    DBMS_OUTPUT.PUT_LINE('COMPTIBLE YOUTH 2GB PACKAGE');
    INSERT INTO SUBSCRIBER_PACKAGE_REMAINDER
    VALUES (PIS_S_ID,1000,2,250,250,PIS_P_NUMBER);
    INSERT INTO SUBSCRIPTION
    VALUES (PIS_S_ID,1000,'29/07/2021','29/07/2022');
    CHECKER:=1;
    COMMIT;
    ELSE CHECKER:=0;
    DBMS_OUTPUT.PUT_LINE('Eklenemedi!');
    DBMS_OUTPUT.PUT_LINE('Bu telefon numarasý zaten kayýtlý!');
    COMMIT;
    END IF;
    
END CREATE_USER;
/



        ---    O  O  0    ---
        
        
        

CREATE OR REPLACE PROCEDURE CHANGE_PASSWORD(PIS_PHONE       IN VARCHAR2,
                                            PIS_MAIL        IN VARCHAR2, 
                                            PIS_NEW_PASS    IN VARCHAR2, 
                                            CHECKER         OUT NUMBER) IS
CHECK_MAIL_PHONE NUMBER;
BEGIN
    SELECT COUNT(*)INTO CHECK_MAIL_PHONE FROM SUBSCRIBER   
    WHERE PHONE_NUMBER=PIS_PHONE AND EMAIL=PIS_MAIL AND PASS_WORD<>PIS_NEW_PASS;
    
    IF CHECK_MAIL_PHONE=1 THEN 
    UPDATE SUBSCRIBER SET PASS_WORD=PIS_NEW_PASS WHERE (PHONE_NUMBER=PIS_PHONE AND EMAIL=PIS_MAIL);
    COMMIT;
    CHECKER:=1;
    DBMS_OUTPUT.PUT_LINE('Þifre deðiþti!');
    ELSE CHECKER:=0;
    DBMS_OUTPUT.PUT_LINE('');
    END IF;
END CHANGE_PASSWORD;
/




        ---    O  O  0    ---




CREATE OR REPLACE PROCEDURE SHOW_PROFILE (  PIS_PHONE   IN VARCHAR, 
                                            FNAME       OUT VARCHAR, 
                                            E_MAIL      OUT VARCHAR, 
                                            PACK_NAME   OUT VARCHAR, 
                                            GB_FULL     OUT NUMBER, 
                                            VOICE_FULL    OUT NUMBER, 
                                            SMS_FULL    OUT NUMBER) IS

CHECK_PHONE     NUMBER;
BEGIN
    SELECT COUNT(*)INTO CHECK_PHONE FROM SUBSCRIBER WHERE PHONE_NUMBER=PIS_PHONE;
    IF CHECK_PHONE=1 THEN
        SELECT FULL_NAME,EMAIL INTO FNAME, E_MAIL FROM SUBSCRIBER WHERE PHONE_NUMBER=PIS_PHONE;
        
        SELECT PACKAGE_NAME,VOICE,SMS,DATA_GB INTO PACK_NAME,VOICE_FULL, SMS_FULL,GB_FULL FROM PACKAGE_CONTENT
        WHERE PACKAGE_ID=(SELECT PACKAGE_ID FROM SUBSCRIBER_PACKAGE_REMAINDER WHERE PHONE_NUMBER=PIS_PHONE);
        
        DBMS_OUTPUT.PUT_LINE('Ýsminiz: '||FNAME);
        DBMS_OUTPUT.PUT_LINE('Mailiniz: '||E_MAIL);
        DBMS_OUTPUT.PUT_LINE('Paketiniz: '||PACK_NAME);
        DBMS_OUTPUT.PUT_LINE('Paketinizin içeriði: '||VOICE_FULL||' VOICE '||SMS_FULL||' SMS '||GB_FULL||' GB ');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Telefon numarasý yanlýþ.');
        FNAME       :=0;
        E_MAIL      :=0;
        PACK_NAME   :=0;
        VOICE_FULL  :=0; 
        SMS_FULL    :=0;
        GB_FULL     :=0;
        
    END IF;
END SHOW_PROFILE;
