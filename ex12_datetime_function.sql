-- ex12_datetime_function

/*


	날짜 시간 함수
	
	sysdate
	- 현재 시스템의 시각을 반환
	- Calendar.getInstance()
	- date sysdate


*/

SELECT SYSDATE FROM dual;


/*
 
 	날짜연산
 	1. 시각 - 시각 = 시간
 	2. 시각 + 시간 = 시각
 	3. 시각 - 시간 = 시각
 	
 */

-- 1. 시각 - 시각 = 시간(일)
SELECT
	NAME,
	IBSADATE,
	ROUND(SYSDATE - IBSADATE) AS 근무일수, -- 9088.6
	round((SYSDATE - IBSADATE) / 365 ) AS 근무년수, --사용금지
	ROUND((SYSDATE - IBSADATE) * 24) AS 근무시수,
	ROUND((SYSDATE - IBSADATE) * 24 * 60) AS 근무분수,
	ROUND((SYSDATE - IBSADATE) * 24 * 60 * 60) AS 근무초수
FROM TBLINSA;


-- 오라클 > 식별자 최대 길이 > 30바이트(UTF-8)

SELECT
	TITLE,
	ADDDATE,
	COMPLETEDATE,
	ROUND((COMPLETEDATE - ADDDATE) * 24) AS 실행하기까지걸린시간
FROM TBLTODO
	WHERE COMPLETEDATE IS NOT NULL
	ORDER BY ROUND((COMPLETEDATE - ADDDATE) * 24) DESC;



-- 2. 시각 + 시간(일) = 시각
-- 3. 시각 - 시간(일) = 시각
SELECT
	SYSDATE,
	SYSDATE + 100 AS "100일뒤",
	SYSDATE - 100 AS "100일전",
	SYSDATE + (3 / 24) AS "3시간 후",
	SYSDATE - (5 /24) AS "5시간 전",
	SYSDATE + (30 / 60 / 24) AS "30분 뒤"
FROM dual;


/*

	시각 - 시각 = 시간(일) > 일 > 시 > 분 > 초 환산
						  > 일 > 월 > 년 환산 불가능
	
	시각 + 시간(일) = 시각 > 일, 시, 분, 초 가능
						  > 월, 일 불가능

*/
SELECT SYSDATE + 3 * 30 FROM dual;


/*
 
 	months_between()
 	- number months_between(date, date)
 	- 시각 - 시각 = 시간(월)
 
 */

SELECT
	name,
	ROUND(SYSDATE - ibsadate) AS "근무일수",
	ROUND((SYSDATE - IBSADATE) / 30) AS "근무월수",
	ROUND(MONTHS_BETWEEN(SYSDATE, IBSADATE)) AS "근무월수",
	ROUND(MONTHS_BETWEEN(SYSDATE, IBSADATE) / 12) AS "근무년수"
FROM TBLINSA;



/*

	add months()
	- date add_months(date, 시간)
	- 시각 + 시간(월) = 시각


*/
SELECT
	SYSDATE,
	ADD_MONTHS(SYSDATE, 3),
	ADD_MONTHS(SYSDATE, -2),
	ADD_MONTHS(SYSDATE, 5 * 12)
FROM dual;


/*
 	시각 - 시각
 	1. 일, 시, 분, 초 > 연산자(-)
 	2. 월, 년 > months_between()
 	
 	시각 +- 시간
 	1. 일, 시, 분, 초 > 연산자(+,-)
 	2. 월, 년 > add_months()
 
 */


SELECT
	SYSDATE,
	LAST_DAY(SYSDATE) -- 해당 날짜 포함된 마지막 날짜 반환(해당월이 며칠까지?)
FROM dual;




















