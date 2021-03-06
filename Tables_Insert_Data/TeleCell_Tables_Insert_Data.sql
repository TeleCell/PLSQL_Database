-- SEQUENCE DROP
/*

DROP SEQUENCE SEQ_SUBSCRIBER_ID;
DROP SEQUENCE SEQ_PACKAGE_ID;

*/

-- SUBSCR?BER_ID NO ???N
CREATE SEQUENCE SEQ_SUBSCRIBER_ID
 START WITH     1
 INCREMENT BY   1
 NOCACHE  
 NOCYCLE;


CREATE SEQUENCE SEQ_PACKAGE_ID
 START WITH     1000
 INCREMENT BY   1
 NOCACHE  
 NOCYCLE;
 



-- SUBSCRIBER INSERT DATA

INSERT INTO SUBSCRIBER (SUBSCRIBER_ID,FULL_NAME,PHONE_NUMBER,EMAIL,PASS_WORD, BIRTHDATE)
    VALUES (SEQ_SUBSCRIBER_ID.NEXTVAL,    '?a??l Berrak Y?ksel',     '5393155555',    'cagil.berrak.yuksel@ext.i2i-systems.com',     'Cagil1', '01/01/1998');
INSERT INTO SUBSCRIBER (SUBSCRIBER_ID,FULL_NAME,PHONE_NUMBER,EMAIL,PASS_WORD, BIRTHDATE)
    VALUES (SEQ_SUBSCRIBER_ID.NEXTVAL,    'Tar?k Deniz',             '5343205555',    'ahmet.tarik.deniz@ext.i2i-systems.com',       'Tarik1', '01/01/1998');
INSERT INTO SUBSCRIBER (SUBSCRIBER_ID,FULL_NAME,PHONE_NUMBER,EMAIL,PASS_WORD, BIRTHDATE)
    VALUES (SEQ_SUBSCRIBER_ID.NEXTVAL,    'Muhammed G?rken Ac?r',    '5464765555',    'muhammed.gorkem.acir@ext.i2i-systems.com',    'Gorkem', '01/01/1998');
INSERT INTO SUBSCRIBER (SUBSCRIBER_ID,FULL_NAME,PHONE_NUMBER,EMAIL,PASS_WORD, BIRTHDATE)
    VALUES (SEQ_SUBSCRIBER_ID.NEXTVAL,    'Ali K?SE',                '5362295555',    'ali.kose@ext.i2i-systems.com',                'Ali123', '01/01/1998');
    
commit;

--  PACKAGE_CONTENT INSERT DATA
    
INSERT INTO PACKAGE_CONTENT (PACKAGE_ID,PACKAGE_NAME,DATA_GB,VOICE,SMS)
    VALUES (SEQ_PACKAGE_ID.NEXTVAL,    'COMPTIBLE YOUTH 2GB',      2,     250,     250);
INSERT INTO PACKAGE_CONTENT (PACKAGE_ID,PACKAGE_NAME,DATA_GB,VOICE,SMS)
    VALUES (SEQ_PACKAGE_ID.NEXTVAL,    'COMPTIBLE YOUTH 4GB',      4,     500,     250);
INSERT INTO PACKAGE_CONTENT (PACKAGE_ID,PACKAGE_NAME,DATA_GB,VOICE,SMS)
    VALUES (SEQ_PACKAGE_ID.NEXTVAL,    'COMPTIBLE YOUTH 8GB',      8,     750,     500);
INSERT INTO PACKAGE_CONTENT (PACKAGE_ID,PACKAGE_NAME,DATA_GB,VOICE,SMS)
    VALUES (SEQ_PACKAGE_ID.NEXTVAL,    'COMPTIBLE YOUTH 10GB',     10,    1000,    750);
INSERT INTO PACKAGE_CONTENT (PACKAGE_ID, PACKAGE_NAME, DATA_GB, VOICE, SMS)
    VALUES (SEQ_PACKAGE_ID.NEXTVAL,    'COMPTIBLE YOUTH 14GB',     14,    1500,    1000);   
    
    commit;
    

INSERT INTO SUBSCRIBER_PACKAGE_REMAINDER (SUBSCRIBER_ID,PACKAGE_ID,DATA_GB_REMAIN,VOICE_REMAIN,SMS_REMAIN,PHONE_NUMBER)
    VALUES (1,     1003,     3,     250,      350 ,       '5393155555');
INSERT INTO SUBSCRIBER_PACKAGE_REMAINDER (SUBSCRIBER_ID,PACKAGE_ID,DATA_GB_REMAIN,VOICE_REMAIN,SMS_REMAIN,PHONE_NUMBER)
    VALUES (2,     1001,     1,     350,      30 ,        '5343205555');
INSERT INTO SUBSCRIBER_PACKAGE_REMAINDER (SUBSCRIBER_ID,PACKAGE_ID,DATA_GB_REMAIN,VOICE_REMAIN,SMS_REMAIN,PHONE_NUMBER)
    VALUES (3,     1002,     4,     250,      100 ,       '5464765555');
INSERT INTO SUBSCRIBER_PACKAGE_REMAINDER (SUBSCRIBER_ID,PACKAGE_ID,DATA_GB_REMAIN,VOICE_REMAIN,SMS_REMAIN,PHONE_NUMBER)
    VALUES (4,     1000,     1,     200,      150 ,       '5362295555');
  commit;

-- SUBSCRIPTION INSERT DATA  

INSERT INTO SUBSCRIPTION (SUBSCRIBER_ID,PACKAGE_ID,SDATE,EDATE)
    VALUES (1,     1003,     '25/09/2020',        '25/09/2021');
INSERT INTO SUBSCRIPTION (SUBSCRIBER_ID,PACKAGE_ID,SDATE,EDATE)
    VALUES (2,     1001,     '20/05/2021',       '20/05/2022');
INSERT INTO SUBSCRIPTION (SUBSCRIBER_ID,PACKAGE_ID,SDATE,EDATE)
    VALUES (3,     1002,     '05/12/2020',       '05/12/2021');
INSERT INTO SUBSCRIPTION (SUBSCRIBER_ID,PACKAGE_ID,SDATE,EDATE)
    VALUES (4,     1000,     '15/04/2021',       '15/04/2022');

commit;

-- SUBSCRIBER_PACKAGE_USE INSERT DATA
   
INSERT INTO SUBSCRIBER_PACKAGE_USE (SUBSCRIBER_ID,PHONE_NUMBER,DATA_GB_USE,VOICE_USE,SMS_USE)
    VALUES (1,   '5393155555',      7,      750,      400);
INSERT INTO SUBSCRIBER_PACKAGE_USE (SUBSCRIBER_ID,PHONE_NUMBER,DATA_GB_USE,VOICE_USE,SMS_USE)
    VALUES (2,   '5343205555',      3,      150,      220);
INSERT INTO SUBSCRIBER_PACKAGE_USE (SUBSCRIBER_ID,PHONE_NUMBER,DATA_GB_USE,VOICE_USE,SMS_USE)
    VALUES (3,   '5464765555',      4,      500,      400);
INSERT INTO SUBSCRIBER_PACKAGE_USE (SUBSCRIBER_ID,PHONE_NUMBER,DATA_GB_USE,VOICE_USE,SMS_USE)
    VALUES (4,   '5362295555',      1,      50,       100);   
   
   
   commit;
   
    
     