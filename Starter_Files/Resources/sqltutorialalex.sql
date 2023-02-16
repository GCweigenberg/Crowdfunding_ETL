SELECT fristname, lastname, jobtitle, salary,
CASE
	WHEN jobtitle = 'Salesman' THEN Salary + (Salary * .5)
	WHEN jobtitle = 'Accountant' THEN Salary + (Salary * .2)
	WHEN jobtitle = 'Receptionist' THEN Salary + (Salary * .7)
	ELSE Salary + (Salary * -.03)
END AS SalaryAfterRaise
FROM employeedemographics
JOIN employeesalary
ON employeedemographics.employeeid = employeesalary.employeeid

WITH CTE_employee AS (
SELECT Fristname, Lastname,gender, salary
	, COUNT(gender) OVER (PARTITION by Gender) AS TotalGender
	, AVG(salary) OVER (Partition BY Gender) AS Avgsalary
FROM employeedemographics emp
JOIN employeesalary sal
ON emp.employeeid = sal.employeeid
WHERE salary >= '35000')
SELECT Fristname, Avgsalary
FROM cte_employee