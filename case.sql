SELECT  T1.EMP_NM , 
        CASE SUBSTR(T1.RRN_NO, 7, 1) 
            WHEN '1' THEN '����' 
            WHEN '2' THEN '����' 
        END AS GENDER 
FROM AMT_MST_TEST T1;



SELECT  T1.EMP_NM ,
        TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER(SUBSTR(JOIN_DT, 1, 4)) AS PERIOD ,
        CASE 
            WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER(SUBSTR(T1.JOIN_DT, 1, 4)) >= 5 THEN '[����]�޿�����' 
            WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER(SUBSTR(T1.JOIN_DT, 1, 4)) >= 3 THEN '[�븮]���޿�����' 
            WHEN TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - TO_NUMBER(SUBSTR(T1.JOIN_DT, 1, 4)) >= 1 THEN '[����]���޿�����' 
            ELSE '[���޴��ƴ�]' 
        END UP_POSI 
FROM AMT_MST_TEST T1;
