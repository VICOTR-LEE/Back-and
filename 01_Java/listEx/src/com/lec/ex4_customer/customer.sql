DROP TABLE CUSTOMER;
DROP TABLE CUS_LEVEL;
DROP SEQUENCE CUSTOMER_SEQ;
CREATE TABLE CUS_LEVEL(
    LEVELNO NUMBER(1,0) PRIMARY KEY,
    LEVELNAME VARCHAR2(20),
    LOW NUMBER(9,0),
    HIGH NUMBER(9,0));

CREATE SEQUENCE CUSTOMER_SEQ MAXVALUE 999999 NOCACHE NOCYCLE;

CREATE TABLE CUSTOMER(
    cID NUMBER(6,0) PRIMARY KEY,
    cTEL VARCHAR2(20) NOT NULL,
    cNAME VARCHAR2(30) NOT NULL,
    cPOINT NUMBER(9,0) DEFAULT 1000,
    cAMOUNT NUMBER(9,0) DEFAULT 0,
    LEVELNO NUMBER(1,0) DEFAULT 1 REFERENCES CUS_LEVEL(LEVELNO));
    
-- 더미데이터 입력(CUS_LEVEL)

INSERT INTO CUS_LEVEL VALUES (1, 'NORMAL',0,999999);
INSERT INTO CUS_LEVEL VALUES (2, 'SILVER', 1000000,1999999);
INSERT INTO CUS_LEVEL VALUES (3, 'GOLD', 2000000,2999999);
INSERT INTO CUS_LEVEL VALUES (4, 'VIP', 3000000,3999999);
INSERT INTO CUS_LEVEL VALUES (5, 'VVIP', 4000000,99999999);

SELECT * FROM CUS_LEVEL;

INSERT INTO CUSTOMER (cID, cTEL, cNAME)
        VALUES (CUSTOMER_SEQ.NEXTVAL, '010-9999-9999','홍길동');
INSERT INTO CUSTOMER 
        VALUES (CUSTOMER_SEQ.NEXTVAL, '010-9999-9999','홍길동',0,4000000,5);
INSERT INTO CUSTOMER 
        VALUES (CUSTOMER_SEQ.NEXTVAL, '010-7777-7777','신길동',0,100000,1);

SELECT * FROM CUSTOMER;

-- 프로그램에 필요한 QUERY
-- 0. 레벨이름들 검색 : Vector<String> gitLevelNNames()
SELECT LEVELNAME FROM CUS_LEVEL;
-- 1. 아이디검색 : CustomerDto cIdgetCustomer(int cId)
        -- CID, CTEL, CNAME, CPOINT, CAMOUNT, LEVELNAME, forlevelLUP
SELECT CID, CTEL, CNAME, CPOINT, CAMOUNT, LEVELNAME,    
          (SELECT  HIGH+1-CAMOUNT FROM CUSTOMER WHERE CID=C.CID AND LEVELNO!=5) forlevelUP
    FROM CUSTOMER C, CUS_LEVEL L
    WHERE C.LEVELNO=L.LEVELNO AND CID =1;

-- 2. 폰4자리(FULL)검색 : ARRAYLIST<CUSTOMERDTO> CTELGETCUSTOMER
SELECT CID, CTEL, CNAME, CPOINT, CAMOUNT, LEVELNAME,    
          (SELECT  HIGH+1-CAMOUNT FROM CUSTOMER WHERE CID=C.CID AND LEVELNO!=5)
    FROM CUSTOMER C, CUS_LEVEL L
    WHERE C.LEVELNO=L.LEVELNO AND cTEL  LIKE '%'||'7777'  ORDER BY CAMOUNT DESC;
-- 3. 고객이름검색 
        -- CID, CTEL, CNAME, CPOINT, CAMOUNT, LEVELNAME, forlevelLUP
SELECT CID, CTEL, CNAME, CPOINT, CAMOUNT, LEVELNAME,    
          (SELECT  HIGH+1-CAMOUNT FROM CUSTOMER WHERE CID=C.CID AND LEVELNO!=5)
    FROM CUSTOMER C, CUS_LEVEL L
    WHERE C.LEVELNO=L.LEVELNO AND CNAME = '홍길동'  ORDER BY CAMOUNT DESC;        
-- 4. 포인트로만 구매 : (1번 id가 100원 구매) : int buyWithPoint (int cId, int cAmount)
UPDATE CUSTOMER SET CPOINT = CPOINT - 100 WHERE CID=1;
-- 5. 물품구매 : int buy(cId, int cAmount)
        -- 물품구매 update에는 cPoint, cAmount, levelNo가 수정
        -- 5-1. cPoint, cAmount 변경
UPDATE CUSTOMER SET cPOINT = cPOINT + (1000000*0.05),
    cAMOUNT = cAMOUNT + 1000000
    WHERE CID=1;
    SELECT * FROM CUSTOMER;
        -- 5-2 levelNo 변경하기 전 현 레벨번호와 수정될 레벨 번호
SELECT CID, CNAME, CAMOUNT, C.LEVELNO 현레벨, L.LEVELNO 수정될레벨
    FROM CUSTOMER C, CUS_LEVEL L 
    WHERE CAMOUNT BETWEEN LOW AND HIGH;
        -- 5-3 levelNo를 수정
UPDATE CUSTOMER SET LEVELNO = ( SELECT C.LEVELNO
                                                                    FROM CUSTOMER C, CUS_LEVEL L 
                                                                    WHERE CAMOUNT BETWEEN LOW AND HIGH AND CID=1)
            WHERE CID=1;
SELECT * FROM CUSTOMER;
        -- 5-1 과 5-3 을 합쳐 CPOINT, CAMOUNT, LEVELNO를 한꺼번에 수정
UPDATE CUSTOMER SET cPOINT = cPOINT + (1000000*0.05),
                      cAMOUNT = cAMOUNT + 1000000,
                      LEVELNO = (SELECT L.LEVELNO
                                    FROM CUSTOMER C, CUS_LEVEL L
                                    WHERE CAMOUNT+1000000 BETWEEN LOW AND HIGH AND CID=1)
    WHERE CID=1; -- DAO에 들어갈 QUERY
  SELECT * FROM CUSTOMER;
        
-- 6. 등급별출력 : ArrayList<CustomerDto> levelNameGetCustomer(String levelName)
        --     CID, CNAME, CPOINT, CAMOUNT, LEVELNAME, forlevelLUP
SELECT CID, CTEL, CNAME, CPOINT, CAMOUNT, LEVELNAME,    
          (SELECT  HIGH+1-CAMOUNT FROM CUSTOMER WHERE CID=C.CID AND LEVELNO!=5)
    FROM CUSTOMER C, CUS_LEVEL L
    WHERE C.LEVELNO=L.LEVELNO AND LEVELNAME='NORMAL' ORDER BY CAMOUNT DESC;        
-- 7. 전체출력 : ArrayList<CustomerDto> getCustomers()
--     CID, CNAME, CPOINT, CAMOUNT, LEVELNAME, forlevelLUP
SELECT CID, CTEL, CNAME, CPOINT, CAMOUNT, LEVELNAME,    
          (SELECT  HIGH+1-CAMOUNT FROM CUSTOMER WHERE CID=C.CID AND LEVELNO!=5)
    FROM CUSTOMER C, CUS_LEVEL L
    WHERE C.LEVELNO=L.LEVELNO  ORDER BY CAMOUNT DESC;   
-- 8. 회원가입 : int insertCustomer (String cTel,String  cName)
INSERT INTO CUSTOMER (CID, CTEL, CNAME)
    VALUES (CUSTOMER_SEQ.NEXTVAL, '010-6666-6666', '유길동');
-- 9. 번호수정 : int updateCustomer(int cId , String cTel)
UPDATE CUSTOMER SET CTEL = '010-5555-5555' WHERE CID=4;
-- 10. 회원탈퇴 : int deleteCustomer(String cTel)
DELETE FROM CUSTOMER WHERE CTEL =  '010-6666-6666';
COMMIT;
