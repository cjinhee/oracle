-- ex10_string_function / 문자열 함수



/*


	문자열 함수
	
	대소문자 변환
	- upper(), lower(), initcap()
	- varchar2 upper(컬럼)
	- varchar2 lower(컬럼)
	- varchar2 initcap(컬럼)
		_영어 데이터만 가능

*/


SELECT
	FIRST_NAME,
	UPPER(FIRST_NAME),
	LOWER(FIRST_NAME)
FROM EMPLOYEES;

SELECT
	'abc',
	INITCAP('abc'),	-- 첫문자를 대문자로
	INITCAP('aBC')	-- 나머지 문자는 소문자로
FROM dual;


-- 이름에(first_name)에 'an' 포함된 직원 > 대소문자 구분없이
SELECT
	FIRST_NAME
FROM EMPLOYEES
	WHERE FIRST_NAME like '%an%' OR FIRST_NAME like '%AN%' OR FIRST_NAME like '%An%' OR FIRST_NAME like '%aN%';	
	
	
	
SELECT
	FIRST_NAME
FROM EMPLOYEES
	WHERE LOWER(FIRST_NAME) like '%an%';
	

/*
	문자열 추출 함수
	- substr() > substring()
	- varchar2 substr(컬럼, 시작위치, 가져올 문자 개수)

*/



SELECT
	ADDRESS,
	SUBSTR(ADDRESS, 3, 5)
FROM TBLADDRESSBOOK;


SELECT
	NAME,
	SSN,
	SUBSTR(SSN, 1, 2) AS 생년,
	SUBSTR(ssn, 3, 2) AS 생월,
	SUBSTR(ssn, 5, 2) AS 생일,
	SUBSTR(ssn, 8, 1) AS 성별	
FROM TBLINSA;


-- tblInsa > 김, 이, 박, 최, 정 > 각각 몇명?

SELECT COUNT(*) FROM TBLINSA WHERE SUBSTR(NAME, 1, 1) = '김';

SELECT
	count(CASE
		WHEN substr(NAME, 1, 1) = '김' THEN 1
	END) AS 김,
	count(CASE
		WHEN substr(NAME, 1, 1) = '이' THEN 1
	END) AS 이,
	count(CASE
		WHEN substr(NAME, 1, 1) = '박' THEN 1
	END) AS 박,
	count(CASE
		WHEN substr(NAME, 1, 1) = '최' THEN 1
	END) AS 최,
	count(CASE
		WHEN substr(NAME, 1, 1) = '정' THEN 1
	END) AS 정,
	COUNT(CASE
		WHEN substr(name, 1, 1) not IN ('김', '이', '박', '최', '정') THEN 1
	END) AS 나머지
FROM TBLINSA;


/*


	문자열 길이
	- length()
	- number length(컬럼)
	
	
*/

-- 컬럼 리스트에서 사용
SELECT name, LENGTH(name) FROM TBLCOUNTRY;

-- 조건절에서 사용
SELECT name, LENGTH(name) FROM TBLCOUNTRY WHERE LENGTH(NAME) > 3;

SELECT name, LENGTH(name) AS leng FROM TBLCOUNTRY WHERE leng > 3;	--error 실행순서 때문에 안됨
SELECT name, LENGTH(name) AS leng FROM TBLCOUNTRY ORDER BY leng asc;

-- 정렬에서 사용
SELECT name, LENGTH(name) FROM TBLCOUNTRY ORDER BY LENGTH(NAME) DESC;





/*

	문자열 검색(indexOf)
	- instr()
	- 검색어의 위치 반환
	- number instr(컬럼, 검색어)
	- number instr(컬럼, 검색어, 시작위치)
	- number instr(컬럼, 검색어, 시작위치, -1) // lastIndexOf
	- 못찾으면 0을 반환

*/

SELECT
	'안녕하세요, 홍길동님',
	INSTR('안녕하세요. 홍길동님.', '홍길동') AS r1,
	INSTR('안녕하세요. 홍길동님.', '아무개') AS r2,
	INSTR('안녕하세요. 홍길동님. 홍길동님', '홍길동') AS r3,
	INSTR('안녕하세요. 홍길동님. 홍길동님', '홍길동', 11) AS r4,
	INSTR('안녕하세요. 홍길동님. 홍길동님', '홍길동', -1) AS r5
FROM dual;



/*

	패딩
	- lpad(), rpad()
	- lefr padding, right padding
	- varchar2 lpad(컬럼, 개수, 문자)
	- varchar2 rpad(컬럼, 개수, 문자)
	- 주어진 너비보다 데이터다 부족하면 나머지를 입력한 문자로 채워줘라.


*/

SELECT
	LPAD('a', 5),	--%5s, 나머지를 스페이스로 채운것
	LPAD('a', 5, 'b'),	-- 나머지를 b로 채워라
	LPAD('aa', 5, 'b'),
	LPAD('aaa', 5, 'b'),
	LPAD('aaaa', 5, 'b'),
	LPAD('aaaaa', 5, 'b'),
	LPAD('1', 3, '0'),	-- 이 경우를 가장 많이 씀
	rpad('1', 3, '0')
FROM dual;


/*
  
	공백 제거
	- trim(), ltrim(), rtrim()
	- varchar2 trim(컬럼)
	- varchar2 ltrim(컬럼) 
	- varchar2 rtrim(컬럼) 
 
 */

SELECT
	'     하나     둘     셋     ',
	TRIM('     하나     둘     셋     '),
	LTRIM('     하나     둘     셋     '),
	RTRIM('     하나     둘     셋     ')
FROM dual;



/*

	문자열 치환
	- replace()
	- varchar2 replace(컬럼, 찾을 문자열, 바꿀 문자열)
	
	- regexp_replace : 정규식
*/

SELECT
	REPLACE('홍길동', '홍', '김'),
	REPLACE('홍길동', '이', '김'),
	REPLACE('홍길홍', '홍', '김')
FROM dual;


SELECT
	NAME,
	REGEXP_REPLACE(name, '김.{2}','김OO' ),
	tel,
	REGEXP_REPLACE(tel, '(\d{3})-(\d{4})-\d{4}', '\1-\2-XXXX')
FROM TBLINSA;



/*

	문자열 치환
	- decode()
	- replace()와 유사
	- varchar2 decode(컬럼, 찾을 문자열, 바꿀 문자열, [찾을 문자열, 바꿀 문자열] x N)

*/


-- tblComedian. 성별 > 남자, 여자
SELECT
	gender,
	CASE
		WHEN gender = 'm' THEN '남자'
		WHEN gender = 'f' THEN '여자'
	END AS g1,
	REPLACE(GENDER, 'm', '남자') AS g2,
	DECODE(GENDER, 'm', '남자', 'f', '여자') AS g3
FROM TBLCOMEDIAN;


-- tblComedian. 남자수? 여자수?
SELECT
	COUNT(CASE
		WHEN gender = 'm' THEN 1
	END) AS m1,
	COUNT(CASE
		WHEN gender = 'f' THEN 1
	END) AS f1,
	COUNT(DECODE(GENDER, 'm', 1)) AS m2,
	COUNT(DECODE(GENDER, 'f', 1)) AS f2
FROM TBLCOMEDIAN;


	

