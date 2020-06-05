SELECT  T1.EMP_NM , 
        CASE SUBSTR(T1.RRN_NO, 7, 1) 
            WHEN '1' THEN '남자' 
            WHEN '2' THEN '여자' 
        END AS GENDER 
FROM AMT_MST_TEST T1;



SELECT  T1.EMP_NM ,
        TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER(SUBSTR(JOIN_DT, 1, 4)) AS PERIOD ,
        CASE 
            WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER(SUBSTR(T1.JOIN_DT, 1, 4)) >= 5 THEN '[과장]급예정자' 
            WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER(SUBSTR(T1.JOIN_DT, 1, 4)) >= 3 THEN '[대리]진급예정자' 
            WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER(SUBSTR(T1.JOIN_DT, 1, 4)) >= 1 THEN '[주임]진급예정자' 
            ELSE '[진급대상아님]' 
        END UP_POSI 
FROM AMT_MST_TEST T1;
