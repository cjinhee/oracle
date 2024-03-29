-- ex15_insert.sql


/*


	INSERT
	- DML
	- 테이블에 데이터를 추가하는 명령어
	
	INSERT 구문
	- insert into 테이블명 (컬럼리스트) values (값리스트);




*/


-- 메모 테이블			
DROP TABLE TBLMEMO;

			
CREATE TABLE TBLMemo
(
	seq number(3) PRIMARY KEY,				--메모번호(PK)
	name varchar2(30) DEFAULT '익명',		--작성자(UQ)
	memo varchar2(1000),					--메모(NN)
	regdate DATE DEFAULT sysdate NOT NULL	--작성날짜
);

DROP SEQUENCE seqMemo;
CREATE SEQUENCE seqMemo;

SELECT * FROM TBLMEMO;			

--1. 표준
-- : 원본 테이블의 정의된 컬럼 순서대로 컬럼리스트와 값리스트를 구성하는 방법
-- : 특별한 이유가 없으면 이 방식 사용
INSERT INTO TBLMEMO (seq, name, memo, regdate) 
				VALUES (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);							


--2. 컬럼리스트의 순서는 원본 테이블과 상관없다.
-- : 컬럼리스트와 값리스트의 순서만 동일하면 된다.
INSERT INTO TBLMEMO (seq, memo, regdate, name) 
				VALUES (seqMemo.nextVal, '메모입니다.', sysdate, '홍길동');				

--3. ORA-00947: not enough values
INSERT INTO TBLMEMO (seq, name, memo, regdate) 
				VALUES (seqMemo.nextVal, '메모입니다.', sysdate);		

--4. ORA-00913: too many values
INSERT INTO TBLMEMO (seq, memo, regdate) 
				VALUES (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);		

--5. null 컬럼 조작
--5. a null 상수
INSERT INTO TBLMEMO (seq, name, memo, regdate) 
				VALUES (seqMemo.nextVal, '홍길동', NULL, sysdate);	
			
--5. b 컬럼 생략
INSERT INTO TBLMEMO (seq, name, regdate) 
				VALUES (seqMemo.nextVal, '홍길동', sysdate);		

--6. default 컬럼 조작
--6. a 컬럼 생략 > null 대입 > default 호출
INSERT INTO TBLMEMO (seq, memo, regdate) 
				VALUES (seqMemo.nextVal, '메모입니다.', sysdate);		

--6. b null 상수 > null 대입(개발자 의지 표현) > default 동작 안함
INSERT INTO TBLMEMO (seq, name, memo, regdate) 
				VALUES (seqMemo.nextVal, NULL, '메모입니다.', sysdate);		

--6. c default 상수
INSERT INTO TBLMEMO (seq, name, memo, regdate) 
				VALUES (seqMemo.nextVal, default, '메모입니다.', sysdate);		


SELECT * FROM TBLMEMO;

--7. 단축
-- 컬럼리스트를 생략할 수 있다.
INSERT INTO TBLMEMO VALUES (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);		

--컬럼리스트를 생략하면 테이블의 원본 컬럼 순서대로 값리스트를 작성해야 한다.
INSERT INTO TBLMEMO VALUES (seqMemo.nextVal, '메모입니다.', sysdate, '홍길동');	

--null 컬럼을 생략 불가능
INSERT INTO TBLMEMO VALUES (seqMemo.nextVal, '홍길동', sysdate);	
INSERT INTO TBLMEMO VALUES (seqMemo.nextVal, '홍길동', NULL, sysdate);	

--default 컬럼을 생략 불가능
INSERT INTO TBLMEMO VALUES (seqMemo.nextVal, '메모입니다.', sysdate);	
INSERT INTO TBLMEMO VALUES (seqMemo.nextVal, default, '메모입니다.', sysdate);	

--8.
--tblMemo 테이블 > 복사 > 새 테이블 생성(tblMemoCopy)
CREATE TABLE TBLMemoCopy
(
	seq number(3) PRIMARY KEY,				--메모번호(PK)
	name varchar2(30) DEFAULT '익명',		--작성자(UQ)
	memo varchar2(1000),					--메모(NN)
	regdate DATE DEFAULT sysdate NOT NULL	--작성날짜
);


SELECT * FROM tblMemo;
SELECT * FROM tblMemoCopy;

INSERT INTO tblMemoCopy SELECT * FROM tblMemo; -- Sub Query

--9. 
--tblMemo 테이블 > 복사 > 새 테이블 생성(tblMemoCopy2)
--제약사항이 복사가 안된다.
--임시 테스트용으로만 사용 > 다량의ㅏ 데이터, 임시 데이터
CREATE TABLE tblMemoCopy2 AS SELECT * FROM tblMemo;

SELECT * FROM TBLMEMOCOPY2;

INSERT INTO TBLMEMOCOPY2 (seq, name, memo, regdate) 
				VALUES (15, '홍길동', '메모입니다.', sysdate);							




