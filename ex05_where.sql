-- ex05_where.sql


/*
 


 		[WITH <Sub Query>]
        SELECT column_list
        FROM table_name
        [WHERE search_condition]
        [GROUP BY group_by_expression]
        [HAVING search_condition]
        [ORDER BY order_expression [ASC|DESC]]



		select 컬럼리스트	3. 컬럼 지정(보고 싶은 컬럼만 가져오기) > Projection
		from 테이블			1. 테이블 지정
		where 조건;			2. 조건 지정(보고 싶은 행만 가져오기) > Selection
		
		
		where절
		- 레코드(행)을 검색한다.
		- 원하는 행만 추출하는 역할
		
		
		
*/


-- 컬럼(5), 레코드(14)
SELECT 
	*
FROM TBLCOUNTRY;

SELECT 
	name, capital			--3.
FROM TBLCOUNTRY				--1.
	WHERE continent = 'AS';	--2.

	
SELECT * FROM TBLCOUNTRY
	WHERE name = '대한민국';

SELECT * FROM TBLCOUNTRY
	WHERE CAPITAL = '카이로';
	
SELECT * FROM TBLCOUNTRY
	WHERE POPULATION  = 4405;
	
SELECT * FROM TBLCOUNTRY
	WHERE POPULATION >= 4405;
	
SELECT * FROM TBLCOUNTRY
	WHERE CONTINENT = 'AS' OR CONTINENT = 'EU';
	
SELECT * FROM TBLCOUNTRY
	WHERE AREA >= 20 AND POPULATION <= 10000;
	

-- tblComedian
SELECT * FROM TBLCOMEDIAN ;

-- 1. 몸무게가 60kg 이상이고, 키가 170cm 미만인 사람을 가져오시오.

SELECT * FROM TBLCOMEDIAN 
	WHERE WEIGHT >= 60 AND HEIGHT < 170;

-- 2. 몸무게가 70kg 이하인 여자만 가져오시오

SELECT * FROM TBLCOMEDIAN 
	WHERE GENDER ='f' AND  WEIGHT <= 70; 

-- tblInsa;
SELECT * FROM TBLINSA ;

-- 3. 부서(buseo)가 '개발부'이고, 급여(basicpay)가 150만원 이상 받은 직원을 가져오시오.

SELECT * FROM TBLINSA 
	WHERE BUSEO = '개발부' AND BASICPAY >= 1500000;


-- 4. 급여(basicpay) + 수당(sudang)을 합한 금액이 200만원 이상 받는 직원을 가져오시오.

SELECT * FROM TBLINSA 
	WHERE (BASICPAY + SUDANG) >= 2000000;
	

SELECT * FROM TBLINSA 
	WHERE CITY = '서울';

SELECT * FROM TBLINSA 
	WHERE 1 = 1; --조건절에 반드시 컬럼이 포함되지 않아도 된다.
	

/*


	between
	- where절에서 사용 > 조건으로 사용
	- 컬럼명 between 최솟값 and 최댓값
	- 범위 조건
	- 가독성(***)


*/
	
	
SELECT * FROM TBLINSA WHERE BASICPAY >= 1000000 AND BASICPAY <=1200000; --무난
SELECT * FROM TBLINSA WHERE 1200000 >= BASICPAY AND BASICPAY >= 1000000;


SELECT * FROM TBLINSA WHERE BASICPAY BETWEEN 1000000 AND 1200000;

-- 비교 연산
-- 1. 숫자형
SELECT * FROM TBLINSA WHERE BASICPAY >= 1000000 AND BASICPAY <= 1200000;
SELECT * FROM TBLINSA WHERE BASICPAY BETWEEN 1020000 AND 1100000;

-- 2. 문자형(문자코드)
SELECT * FROM TBLINSA WHERE NAME > '이순신'; -- name.compareTO("이순신")

SELECT * FROM EMPLOYEES WHERE FIRST_NAME >= 'J' AND FIRST_NAME <= 'L';
SELECT * FROM EMPLOYEES WHERE FIRST_NAME BETWEEN 'J' AND 'L';

-- 3. 날짜시간형
SELECT * FROM TBLINSA WHERE IBSADATE >= '2000-01-01'; --2000년 이후에 입사한 직원


--2000-01-01 ~ 2000-12-31
SELECT * FROM TBLINSA 
	WHERE IBSADATE >= '2000-01-01' AND IBSADATE <= '2000-12-31';

SELECT * FROM TBLINSA 
	WHERE IBSADATE BETWEEN '2000-01-01' AND '2000-12-31';

/*
 
 	in
 	- where절에서 사용 > 조건으로 사용
 	- 열거형 조건
 	- 컬럼명 in (값, 값, 값)
 	- 가독성 향상
 

 */

--tblInsa. 개발부 + 총무부
SELECT * FROM TBLINSA 
	WHERE BUSEO = '개발부' OR  BUSEO = '총무부' OR BUSEO = '홍보부';
	
SELECT * FROM TBLINSA 
	WHERE BUSEO IN ('개발부', '총무부', '홍보부');


-- 서울 or 인천 > 과장 or 부장 + 급여(250~300)
SELECT * FROM TBLINSA 
	WHERE CITY IN ('서울', '인천') AND JIKWI IN ('과장', '부장')
			AND BASICPAY BETWEEN 2500000 AND 3000000;
		

-- between, in > 사용 금지!! > 성능 문제 > 비교 연산자보다 느림 
		
		
/*
  
 	like
 	- where절에서 사용 > 조건으로 사용
 	- 패턴 비교 
 	- 컬럼명 like '패턴 문자열'
 	- 정규 표현식 초간단 버전 
 	
 	패턴 문자열 구성요소
 	1. _: 임의의 문자 1개(.)
 	2. %: 임의의 문자 N개 0~무한대(.*)
 
 */

		
-- 김OO
SELECT * FROM TBLINSA WHERE NAME LIKE '김__' ;
SELECT * FROM TBLINSA WHERE NAME LIKE '_길_' ;
SELECT * FROM TBLINSA WHERE NAME LIKE '__수' ;

SELECT * FROM EMPLOYEES WHERE FIRST_NAME LIKE 'S_____';
SELECT * FROM EMPLOYEES WHERE FIRST_NAME LIKE 'S____';
SELECT * FROM EMPLOYEES WHERE FIRST_NAME LIKE 'S______';

SELECT * FROM EMPLOYEES WHERE FIRST_NAME LIKE 'S%';

SELECT * FROM TBLINSA WHERE NAME LIKE '김%';
SELECT * FROM TBLINSA WHERE NAME LIKE '%수';
SELECT * FROM TBLINSA WHERE NAME LIKE '%길%';

SELECT * FROM TBLINSA WHERE SSN LIKE '______-2______';
SELECT * FROM TBLINSA WHERE SSN LIKE '%-2%';


/*
 
 	RDBMS에서의 null
 	- 컬럼값(셀)이 비어있는 상태
 	- null 상수 제공
 	- 대부분의 언어는 null은 연산의 대상이 될 수 없다.(******************)
 	
	null 조건
	- where절에서 사용
	- 컬럼명 is null 
 

 */

-- 인구수가 미기재된 나라?
SELECT * FROM TBLCOUNTRY WHERE POPULATION = null;
SELECT * FROM TBLCOUNTRY WHERE POPULATION is null;

-- 인구수가 기재된 나라?
SELECT * FROM TBLCOUNTRY WHERE POPULATION <> null;
SELECT * FROM TBLCOUNTRY WHERE NOT POPULATION is null;
SELECT * FROM TBLCOUNTRY WHERE POPULATION is NOT null; --**

-- is null
-- is not null

SELECT * FROM TBLINSA WHERE tel IS NULL;

-- 아직 실행하지 않은 할 일 ?
SELECT * FROM TBLTODO WHERE COMPLETEDATE IS NULL ;

-- 실행 완료한 일?
SELECT * FROM TBLTODO WHERE COMPLETEDATE IS NOT NULL ;

-- 도서관 > 대여 테이블(컬럼: 대여날짜, 반납날짜)

-- 아직 반납을 안한 사람은? 
SELECT * FROM 도서대여 WHERE 반납날짜 IS NULL;

-- 반납이 완료된 사람은?
SELECT * FROM 도서대여 WHERE 반납날짜 IS NOT NULL;



/*

	강의실 <-> 집
	- 스크립트 파일(*.sql)
	- 백업/복구 

*/