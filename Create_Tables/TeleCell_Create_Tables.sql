-- SUBSCRIBER TABLE
CREATE TABLE SUBSCRIBER (SUBSCRIBER_ID  NUMBER          NOT NULL  PRIMARY KEY,   
                        FULL_NAME      VARCHAR2(50)    NOT NULL,  
                        PHONE_NUMBER    VARCHAR2(10)    NOT NULL,
                        EMAIL           VARCHAR2(100)   NOT NULL, 
                        PASS_WORD       VARCHAR2(6)    NOT NULL,
                        BIRTHDATE       DATE           NOT NULL,
                        CONSTRAINT SUBSCRIBER_UNIQUE UNIQUE (PHONE_NUMBER));
                        
                    
---   PACKAGE_CONTENT TABLE           

CREATE TABLE PACKAGE_CONTENT  (PACKAGE_ID      NUMBER PRIMARY KEY NOT NULL,
                               PACKAGE_NAME    VARCHAR2(100),
                               DATA_GB         NUMBER,
                               VOICE           NUMBER,
                               SMS             NUMBER);


 --    SUBSCRIBER_PACKAGE_REMAINDER TABLE                                             
CREATE TABLE SUBSCRIBER_PACKAGE_REMAINDER (SUBSCRIBER_ID      NUMBER,
                                           PACKAGE_ID   NUMBER,
                                           DATA_GB_REMAIN  NUMBER,
                                           VOICE_REMAIN    NUMBER,
                                           SMS_REMAIN      NUMBER,
                                           PHONE_NUMBER VARCHAR2(10));
                               
ALTER TABLE SUBSCRIBER_PACKAGE_REMAINDER
ADD CONSTRAINT SUBSCRIBER_PACKAGE_REMAINDER_FK1 FOREIGN KEY
(
  SUBSCRIBER_ID 
)
REFERENCES SUBSCRIBER
(
  SUBSCRIBER_ID 
)
ENABLE;
     
ALTER TABLE SUBSCRIBER_PACKAGE_REMAINDER
ADD CONSTRAINT SUBSCRIBER_PACKAGE_REMAINDER_FK2 FOREIGN KEY
(
  PACKAGE_ID 
)
REFERENCES PACKAGE_CONTENT
(
  PACKAGE_ID 
)
ENABLE;


ALTER TABLE SUBSCRIBER_PACKAGE_REMAINDER
ADD CONSTRAINT SUBSCRIBER_PACKAGE_REMAINDER_FK3 FOREIGN KEY
(
  PHONE_NUMBER 
)
REFERENCES SUBSCRIBER
(
  PHONE_NUMBER 
)
ENABLE;
                          
                          
-- SUBSCRIPTION TABLE                                            
CREATE TABLE SUBSCRIPTION (SUBSCRIBER_ID      NUMBER PRIMARY KEY,
                          PACKAGE_ID    NUMBER,
                          SDATE         DATE,
                          EDATE         DATE);
                          
                          
ALTER TABLE SUBSCRIPTION
ADD CONSTRAINT SUBSCRIPTION_FK1 FOREIGN KEY
(
  SUBSCRIBER_ID 
)
REFERENCES SUBSCRIBER
(
  SUBSCRIBER_ID 
)
ENABLE;
                          
-- SUBSCRIBER_PACKAGE_USE TABLE

CREATE TABLE SUBSCRIBER_PACKAGE_USE (SUBSCRIBER_ID    NUMBER PRIMARY KEY,  
                                     PHONE_NUMBER     VARCHAR2(10),
                                     DATA_GB_USE      NUMBER(5,2),
                                     VOICE_USE        NUMBER(4),
                                     SMS_USE          NUMBER(5));
                        
commit;