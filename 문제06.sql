

--1. traffic_accident. 각 교통 수단 별(지하철, 철도, 항공기, 선박, 자동차) 발생한 총 교통 사고 발생 수, 총 사망자 수, 사건 당 평균 사망자 수를 가져오시오.
	SELECT * FROM TRAFFIC_ACCIDENT;
	
	SELECT
	 	TRANS_TYPE,
	 	SUM(TOTAL_ACCT_NUM) AS "교통사고발생수",
	 	SUM(DEATH_PERSON_NUM) AS "총사망자수",
	 	ROUND(AVG(DEATH_PERSON_NUM)) AS "평균 사망자 수"
	FROM TRAFFIC_ACCIDENT
		GROUP BY TRANS_TYPE;
	

--2. tblZoo. 종류(family)별 평균 다리의 갯수를 가져오시오.
	SELECT * FROM TBLZOO;
    
	SELECT
		FAMILY,
		AVG(LEG)
	FROM TBLZOO
		GROUP BY FAMILY;
    

    
--3. tblZoo. 체온이 변온인 종류 중 아가미 호흡과 폐 호흡을 하는 종들의 갯수를 가져오시오.

        SELECT
        	BREATH,
        	COUNT(FAMILY)
        FROM TBLZOO
       		WHERE THERMO = 'variable'
       			GROUP BY BREATH ;
        

--4. tblZoo. 사이즈와 종류별로 그룹을 나누고 각 그룹의 갯수를 가져오시오.

        SELECT
        	family,
        	sizeof,
        	COUNT(*)
        FROM TBLZOO
       		GROUP BY ROLLUP(SIZEOF, FAMILY);
        


--12. tblAddressBook. 관리자의 실수로 몇몇 사람들의 이메일 주소가 중복되었다. 중복된 이메일 주소만 가져오시오.

    	SELECT * FROM TBLADDRESSBOOK;
    	
    	SELECT
    		EMAIL
    	FROM TBLADDRESSBOOK
    		;
			

            

--15. tblAddressBook. 성씨별 인원수가 100명 이상 되는 성씨들을 가져오시오.




            
            

--17. tblAddressBook. 이메일이 스네이크 명명법으로 만들어진 사람들 중에서 여자이며, 20대이며, 키가 150~160cm 사이며, 고향이 서울 또는 인천인 사람들만 가져오시오.





--20. tblAddressBook. '건물주'와 '건물주자제분'들의 거주지가 서울과 지방의 비율이 어떻게 되느냐?






