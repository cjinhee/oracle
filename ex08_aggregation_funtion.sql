-- ex08


/*


	함수, Function
	1. 내장형 함수(Built -in Function)
	2. 사용자 정의 함수


	집계 함수, Aggregation Function(*******************)
	- 아주 쉬움 > 뒤에 나오는 수업과 결합 > 꽤 어려움;;
	1. count()
	2. sum()
	3. avg()
	4. max()
	5. min()
	
	
	1. count()
	- 결과 테이블의 레코드 수를 반환한다.
	- number count(컬럼명)
	- null 값은 카운트에서 제외된다.(****)


*/

-- tblCountry. 총 나라 몇개국?
SELECT COUNT(*) FROM TBLCOUNTRY;			--14(모든 레코드, 일부 컬럼에 null 무관)
SELECT COUNT(NAME) FROM TBLCOUNTRY;			--14
SELECT COUNT(POPULATION) FROM TBLCOUNTRY;	--13

SELECT * FROM TBLCOUNTRY;			--14
SELECT NAME FROM TBLCOUNTRY;		--14
SELECT POPULATION FROM TBLCOUNTRY;	--13


-- 모든 직원수?
SELECT COUNT(*) FROM TBLINSA; --60

-- 연락처가 있는 직원 수?
SELECT COUNT(tel) FROM TBLINSA; --57

-- 연락처가 없는 직원 수?
SELECT COUNT(*) - COUNT(tel) FROM TBLINSA; --3

SELECT COUNT(*) FROM TBLINSA WHERE tel IS NOT NULL; --57
SELECT COUNT(*) FROM TBLINSA WHERE tel IS NULL; --3

-- tblInsa. 어느 부서들 있나요?
SELECT DISTINCT buseo FROM TBLINSA;

-- tblInsa. 부서 총 몇개?
SELECT COUNT(DISTINCT buseo) FROM TBLINSA; --7

-- tblComedian. 남자수? 여자수?
SELECT * FROM TBLCOMEDIAN;

SELECT COUNT(*) FROM TBLCOMEDIAN WHERE GENDER = 'm';
SELECT COUNT(*) FROM TBLCOMEDIAN WHERE GENDER = 'f';

-- 남자수 + 여자수 > 1개의 테이블로 가져오시오.
SELECT 
	COUNT(CASE
		WHEN GENDER = 'm' THEN 1
	END) AS 남자인원수,
	COUNT(CASE
		WHEN gender = 'f' THEN 1
	END) AS 여자인원수
FROM TBLCOMEDIAN;


-- tblInsa. 기획부 몇명?, 총무부 몇명?, 개발부 몇명?, 총인원?, 나머지부서 몇명?
SELECT COUNT(*) FROM TBLINSA WHERE BUSEO = '기획부'; --7
SELECT COUNT(*) FROM TBLINSA WHERE BUSEO = '총무부'; --7
SELECT COUNT(*) FROM TBLINSA WHERE BUSEO = '개발부'; --14

SELECT
	COUNT(CASE
		WHEN BUSEO = '기획부' THEN 'O'
	END) AS 기획부,
	COUNT(CASE
		WHEN BUSEO = '총무부' THEN 'O'
	END) AS 총무부,
	COUNT(CASE
		WHEN BUSEO = '개발부' THEN 'O'
	END) AS 개발부,
	COUNT(*) AS 전체인원수,
	COUNT(
		CASE
			WHEN BUSEO not IN ('기획부', '총무부', '개발부') THEN 'O'
		END
	) AS 나머지
FROM TBLINSA;



/*


	2. sum()
	- 해당 컬럼의 합을 구한다.
	- number sum(컬럼명)
	- 해당 컬럼 > 숫자형 


*/

SELECT * FROM TBLCOMEDIAN;

SELECT SUM(height), SUM(weight) FROM TBLCOMEDIAN;
SELECT SUM(FIRST) FROM TBLCOMEDIAN; -- ORA-01722: invalid NUMBER

SELECT
	SUM(BASICPAY) AS "지출 급여 합",
	SUM(SUDANG) AS "지출 수당 합",
	SUM(BASICPAY) + SUM(SUDANG) AS "총 지출",
	SUM(BASICPAY + SUDANG) AS "총 지출" 
FROM TBLINSA;

SELECT sum(*) FROM TBLINSA; -- 이건 안됨

/*

	3. avg()
	- 해당 컬럼의 평균값을 구한다.
	- number avg(컬럼명)
	- 숫자형만 적용 가능

*/

-- tblInsa. 평균 급여?
SELECT SUM(basicpay) / 60 FROM TBLINSA; -- 1556526
SELECT SUM(basicpay) / COUNT(*) FROM TBLINSA; -- 1556526직원수를 count(*) 로 표현
SELECT AVG(BASICPAY) FROM TBLINSA; --1556526


-- tblCountry, 평균 인구수?
-- 0과 null은 다른 값
SELECT AVG(POPULATION) FROM TBLCOUNTRY; 							--15588
SELECT sum(POPULATION) / COUNT(*) FROM TBLCOUNTRY;					--14475 /  인구수의 총합을 14로 나눈것임
SELECT sum(POPULATION) / COUNT(POPULATION) FROM TBLCOUNTRY;			--15588
SELECT COUNT(POPULATION), COUNT(*)FROM TBLCOUNTRY;					-- null값을 가지고있음



-- 회사 > 성과급 지급 > 출처 > 1팀 공로~
-- 1. 균등 지급: 총지급액 / 모든직원수 = sum() / count(*)
-- 2. 차등 지급: 총지급액 / 1팀직원수 = sum() / count(1팀) = avg()


SELECT avg(name) FROM TBLINSA; -- 에러남
SELECT avg(ibsadate) FROM TBLINSA; -- 에러


/*

	4. max()
	- object max(컬럼명)
	- 최댓값 반환
	
	5. min()
	- object min(컬럼명)
	- 최솟값 반환
	
	- 숫자형, 문자형, 날짜형 모두 적용 가능


*/


SELECT MAX(SUDANG), MIN(SUDANG) FROM TBLINSA;		--숫자형
SELECT MAX(NAME), MIN(NAME) FROM TBLINSA;			--문자형 
SELECT MAX(IBSADATE), MIN(IBSADATE) FROM TBLINSA;	--날짜형

SELECT
	COUNT(*) AS 직원수,
	SUM(BASICPAY) AS 총급여합,
	AVG(BASICPAY) AS 평균급여,
	MAX(BASICPAY) AS 최고급여,
	MIN(BASICPAY) AS 최저급여
FROM TBLINSA;


-- 집계 함수 사용 주의점!!!

-- 1. ORA-00937: not a single-group group function
-- 컬럼 리스트에서는 집계함수와 일반컬럼을 동시에 사용할 수 없다.

SELECT COUNT(*) FROM TBLINSA;	--직원수
SELECT NAME FROM TBLINSA;		--직원명

-- 요구사항] 직원들 이름과 총직원수를 동시에 가져오시오. > 불가능!!
SELECT COUNT(*), NAME FROM TBLINSA;	--error

-- 2. ORA-00934: group function is not allowed here
-- where절에는 집계 함수를 사용할 수 없다.
-- 집계 함수(집합), 컬럼(개인)
-- where절 > 개개인(레코드)의 데이터를 접근해서 조건 검색 > 집합값 호출 불가능

-- 요구사항] 평균 급여보다 더 많이 받는 직원들?
SELECT avg(basicpay) FROM TBLINSA;	--1556526



SELECT * FROM TBLINSA WHERE BASICPAY >= 1556526;
SELECT * FROM TBLINSA WHERE BASICPAY >= avg(basicpay);	--error











