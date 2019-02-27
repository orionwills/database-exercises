USE employees;

/*
Update your queries for employees whose names start and end with 'E'. 
Use concat() to combine their first and last name together as a single column named full_name.
*/

SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees
WHERE last_name LIKE 'e%'
	AND last_name LIKE '%e'
	ORDER BY emp_no;
    
    
    
/*
Convert the names produced in your last query to all uppercase.
*/

SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS full_name FROM employees
WHERE last_name LIKE 'e%'
	AND last_name LIKE '%e'
	ORDER BY emp_no;

/*
For your query of employees born on Christmas and hired in the 90s, use datediff() 
to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE())
*/

SELECT
DATEDIFF(CURDATE(), hire_date) AS tenure,
CONCAT(first_name, ' ', last_name) AS full_name FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	AND	birth_date LIKE '%-12-25'
    ORDER BY birth_date, hire_date DESC;

/*
Find the smallest and largest salary from the salaries table.
*/

SELECT MIN(salary) as low_salary, MAX(salary) as high_salary FROM salaries;

/*
Use your knowledge of built in SQL functions to generate a username for all of the employees. 
A username should be all lowercase, and consist of the first character of the employees first name, 
the first 4 characters of the employees last name, an underscore, the month the employee was born, 
and the last two digits of the year that they were born.
*/

SELECT LOWER(CONCAT(
		SUBSTR(first_name, 1, 1),
		SUBSTR(last_name, 1, 4),
        '_',
        SUBSTR(birth_date, 6, 2),
        SUBSTR(birth_date, 3, 2))) AS username,
	first_name,
    last_name,
    birth_date
FROM employees;

