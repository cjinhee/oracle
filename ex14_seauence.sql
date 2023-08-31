-- ex14_seauence.sql

/*

	시퀀스, sequence
	- 데이터베이스 객체 중 하나
	- 오라클 전용 객체(다른 DBMS 제품에는 없음)
	- 일련 번호를 생성하는 객체(***)
	- (주로) 식별자(일련번호)를 만드는데 사용한다. > PK 값으로 사용한다.
	
	시퀀스 객체 생성하기
	- create sequence 시퀀스명;
	
	시퀀스 객체 삭제하기
	- drop sequence 시퀀스명;
	
	시퀀스 객체 사용하기(함수)
	- 시퀀스객체.nextVal (***)
	- 시퀀스객체.currVal


*/

CREATE SEQUENCE seqNum;

SELECT seqNum.nextVal FROM dual;	--일련 번호 생성

SELECT * FROM TBLMEMO;	

DELETE FROM TBLMEMO;

CREATE SEQUENCE seqMemo;
	
INSERT INTO TBLMEMO (seq, name, memo, regdate) 
				VALUES (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);			

SELECT 'A' || seqNum.nextVal FROM dual; -- A11

-- nextVal 호출하면 나오게될 숫자를 반환 > 확인용
-- Queue, Stack > pop()/ppek()
SELECT seqNum.currVal FROM dual;

-- currVal는 최소 1번 이상의 nextVal를 호출해야 사용이 가능하다.

SELECT seqNum.nextVal FROM dual;


/*


	시퀀스 객체 생성하기
	
	create sequence 시퀀스명;
	
	create sequence 시퀀스명 
				increment by n	--증감치(양수/음수)
				start with n	--시작값(Seed) 
				maxvalue n		--최댓값
				minvalue n		--최솟값
				cycle			--순환
				cache n;		--임시저장


*/
DROP SEQUENCE seqTest;

CREATE SEQUENCE seqTest
				--INCREMENT BY 2;
				--START WITH 10;
				--MAXVALUE 10
				--CYCLE
				cache 20;
			
SELECT seqTest.nextVal FROM dual;


SELECT * FROM TBLINSA;
   


