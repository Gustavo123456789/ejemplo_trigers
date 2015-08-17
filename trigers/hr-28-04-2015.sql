-- ejercicio 8 pag A-14
SELECT employee_id "EMP #"
      ,LAST_NAME AS EMPLOYEE
      ,JOB_ID JOB
      ,HIRE_DATE "HIRE DATE"
FROM EMPLOYEES;

--EJERCICIO 7 A-21
SELECT FIRST_NAME||' '||LAST_NAME
      ,HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE Between '01/01/94' AND '31/12/94';
--OPCION 2
SELECT FIRST_NAME||' '||LAST_NAME
      ,HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE > '01/01/94' AND HIRE_DATE < '31/12/94';

--ejerciCIO 12 PAG A 22
SELECT  LAST_NAME
FROM Employees
WHERE LAST_NAME LIKE '__a%';

--ELERCIICO 13 PAG A23
SELECT  LAST_NAME
FROM Employees
WHERE LAST_NAME LIKE '%a%e%';

SELECT  LAST_NAME
FROM Employees
WHERE LAST_NAME LIKE '%a%e%' OR LAST_NAME LIKE '%e%a%';


-- EJERCICIO 4 PAG A 28
SELECT Employee_Id
      , FIRST_NAME
      ,Salary
      ,Salary*1.155 "NUEVO SALARIO"
      ,SALARY * 0.155 INCREMENTO
FROM Employees;

-- EJERCICIO 7 PAG A - 30
SELECT Employee_Id
      ,LAST_NAME
      ,lPAD(SALARY,15,'*') AS SALARY
FROM Employees;

--EJERCICIO 9 PAG A 31
SELECT LAST_NAME
      ,ROUND(SYSDATE - HIRE_DATE,0) TUNARE
FROM Employees
ORDER BY TUNARE DESC;

--EJERCIICO 2 PAG A 36
SELECT  LAST_NAME
      , HIRE_DATE
      , HIRE_DATE REVIEW -- LUNES, THE DIEZ DIAS DE MARZO,2004
      ,TO_CHAR(HIRE_DATE, 'DDSP')||' DE '||
       TO_CHAR(HIRE_DATE, 'Month')||' DE '||
       TO_CHAR(HIRE_DATE, 'YYYY') "REVIEW2"
FROM EMPLOYEES;

-- EJERCICIO 5 PAG A 37
SELECT LAST_NAME, JOB_ID
      , DECODE(JOB_ID, 'AD_PRES','A'
                      ,'ST_MAN','B'
                      ,'IT_PROG','C'
                      ,'SA_REP','D'
                      ,'ST_CLERK','E'
                      ,'0') GRADO
FROM EMPLOYEES;