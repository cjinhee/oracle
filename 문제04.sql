-- 문제04.sql


-- 집계함수 > sum(), avg(), max(), min()


--sum()
SELECT * FROM TBLCOUNTRY;
--1. 유럽과 아프리카에 속한 나라의 인구 수 합? tblCountry > 14,198
	SELECT 
		SUM(POPULATION) 
	FROM TBLCOUNTRY 
		WHERE CONTINENT IN ('EU', 'AF');

	SELECT*FROM EMPLOYEES;
--2. 매니저(108)이 관리하고 있는 직원들의 급여 총합? hr.employees > 39,600
	SELECT
		SUM(SALARY)
	FROM EMPLOYEES
		WHERE MANAGER_ID = 108;

--3. 직업(ST_CLERK, SH_CLERK)을 가지는 직원들의 급여 합? hr.employees > 120,000
	SELECT
		SUM(SALARY)
	FROM EMPLOYEES
		WHERE JOB_ID IN ('ST_CLERK', 'SH_CLERK');

	
	SELECT*FROM TBLINSA;
--4. 서울에 있는 직원들의 급여 합(급여 + 수당)? tblInsa > 33,812,400
	SELECT
		SUM(BASICPAY+SUDANG)
	FROM TBLINSA
		WHERE CITY = '서울';

--5. 장급(부장+과장)들의 급여 합? tblInsa > 36,289,000
	SELECT
		SUM(BASICPAY)
	FROM TBLINSA
		WHERE JIKWI IN ('부장', '과장');


--avg()
	
	SELECT*FROM TBLCOUNTRY;
--1. 아시아에 속한 국가의 평균 인구수? tblCountry > 39,165
	SELECT
		AVG(POPULATION)
	FROM TBLCOUNTRY
		WHERE CONTINENT = 'AS';

	
	SELECT*FROM EMPLOYEES;
--2. 이름(first_name)에 'AN'이 포함된 직원들의 평균 급여?(대소문자 구분없이) hr.employees > 6,270.4
	SELECT
		AVG(SALARY)
	FROM EMPLOYEES
		WHERE LOWER(FIRST_NAME) LIKE '%an%';

	
	SELECT*FROM TBLINSA;
--3. 장급(부장+과장)의 평균 급여? tblInsa > 2,419,266.66
	SELECT
		AVG(BASICPAY)		
	FROM TBLINSA
		WHERE JIKWI IN ('부장', '과장');


--4. 사원급(대리+사원)의 평균 급여? tblInsa > 1,268,946.66
	SELECT
		AVG(BASICPAY)
	FROM TBLINSA
		WHERE JIKWI IN ('대리', '사원');
	

--5. 장급(부장,과장)의 평균 급여와 사원급(대리,사원)의 평균 급여의 차액? tblInsa > 1,150,320
	SELECT
		AVG(BASICPAY)
	FROM TBLINSA
		WHERE JIKWI IN ('부장', '과장');

--max(),min()
	SELECT*FROM TBLCOUNTRY;
--1. 면적이 가장 넓은 나라의 면적은? tblCountry > 959
	SELECT 
		max(AREA)
	FROM TBLCOUNTRY;

SELECT* FROM TBLINSA;
--2. 급여(급여+수당)가 가장 적은 직원은 총 얼마를 받고 있는가? tblInsa > 988,000
	SELECT
		MIN(BASICPAY+SUDANG)
	FROM TBLINSA;






