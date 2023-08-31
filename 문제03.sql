-- 문제03.sql



-- 집계함수 > count()


SELECT * FROM TBLCOUNTRY;
-- 1. tblCountry. 아시아(AS)와 유럽(EU)에 속한 나라의 개수?? -> 7개
    SELECT
   		 COUNT(*)
    FROM TBLCOUNTRY
   		WHERE CONTINENT = 'AS' OR CONTINENT = 'EU';
	

-- 2. 인구수가 7000 ~ 20000 사이인 나라의 개수?? -> 2개
    SELECT
    	COUNT(*)
    FROM TBLCOUNTRY
   		WHERE POPULATION BETWEEN 7000 AND 20000 ;

SELECT * FROM EMPLOYEES;
-- 3. hr.employees. job_id > 'IT_PROG' 중에서 급여가 5000불이 넘는 직원이 몇명? -> 2명
	SELECT
		COUNT(*)
	FROM EMPLOYEES
		WHERE JOB_ID = 'IT_PROG' AND SALARY >= 5000;

	SELECT*FROM TBLINSA;
-- 4. tblInsa. tel. 010을 안쓰는 사람은 몇명?(연락처가 없는 사람은 제외) -> 42명
    SELECT
    	COUNT(*)
    FROM TBLINSA
   		WHERE NOT TEL LIKE '010%' AND TEL IS NOT NULL;
    

-- 5. city. 서울, 경기, 인천 -> 그 외의 지역 인원수? -> 18명
	SELECT
    	COUNT(*)
	FROM TBLINSA
		WHERE NOT CITY IN ('서울', '경기', '인천');

-- 6. 여름태생(7~9월) + 여자 직원 총 몇명? -> 7명
	SELECT
		COUNT(*)
	FROM TBLINSA
		WHERE SSN LIKE '__07__-2%' OR SSN LIKE  '__08%__-2%' OR SSN LIKE '__09%__-2%';

-- 7. 개발부 + 직위별 인원수? -> 부장 ?명, 과장 ?명, 대리 ?명, 사원 ?명
	
	SELECT
		COUNT(CASE
			WHEN JIKWI = '부장' THEN 'O'
		END) AS 부장,
		COUNT(CASE
			WHEN JIKWI = '과장' THEN 'O'
		END) AS 과장,
		COUNT(CASE
			WHEN JIKWI = '대리' THEN 'O'
		END) AS 대리,
		COUNT(CASE
			WHEN JIKWI = '사원' THEN 'O'
		END) AS 사원
	FROM TBLINSA
		WHERE BUSEO = '개발부';

