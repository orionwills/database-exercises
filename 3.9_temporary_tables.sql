USE ada_680;

/*
Create a file named 3.9_temporary_tables.sql to do your work for this exercise.

Using the example from the lesson, re-create the employees_with_departments table.

Add a column named full_name to this table. 
It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
Update the table so that full name column contains the correct data
Remove the first_name and last_name columns from the table.
What is another way you could have ended up with this same table?
*/





CREATE TEMPORARY TABLE employees_with_departments AS SELECT
	emp_no,
    first_name,
    last_name,
    dept_no,
    dept_name 
    FROM
    employees.employees
        JOIN
    employees.dept_emp de USING (emp_no)
        JOIN
    employees.departments d USING (dept_no)
    LIMIT 100;

DESCRIBE employees.employees;

ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

UPDATE employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

SELECT * FROM employees_with_departments;

/*
Create a temporary table based on the payments table from the sakila database.

Write the SQL necessary to transform the amount column such that it is stored as an 
integer representing the number of cents of the payment. For example, 1.99 should become 199.
*/


CREATE TEMPORARY TABLE sakila_amount AS SELECT
p.amount FROM sakila.payment p
LIMIT 100;

ALTER TABLE sakila_amount ADD amount_times_100 INT UNSIGNED;

UPDATE sakila_amount SET amount_times_100 = amount * 100;

ALTER TABLE sakila_amount DROP COLUMN amount;

ALTER TABLE sakila_amount ADD amount INT UNSIGNED;

UPDATE sakila_amount SET amount = amount_times_100;

ALTER TABLE sakila_amount DROP COLUMN amount_times_100;

SELECT * FROM sakila_amount;

/*
Find out how the average pay in each department compares to the overall average pay.
In order to make the comparison easier, you should use the Z-score for salaries.
In terms of salary, what is the best department to work for? The worst?
*/

USE ada_680; 

SELECT AVG(salary), STDDEV(salary) FROM employees.salaries
WHERE to_date > NOW();


SELECT a.dept_name, AVG(a.z_salary) as avg_z_salary FROM
(SELECT d.dept_name, s.emp_no, salary, ((salary-a.avg_salary)/a.stdev_salary) AS z_salary
FROM employees.salaries s
JOIN agg a
JOIN employees.dept_emp de ON s.emp_no = de.emp_no
JOIN employees.departments d ON de.dept_no = d.dept_no
WHERE s.to_date > NOW()
) a
GROUP BY a.dept_name;


-- temptable method

CREATE TEMPORARY TABLE agg as
SELECT AVG(salary) AS avg_salary, STDDEV(salary) AS stdev_salary FROM employees.salaries
WHERE to_date > NOW();

SELECT * FROM agg;







DROP TABLE employees_with_departments;

CREATE TABLE employees_with_departments AS SELECT
    dept_no,
    dept_name,
    salary
    FROM
    employees.employees
        JOIN
    employees.dept_emp de USING (emp_no)
        JOIN
    employees.departments d USING (dept_no)
		JOIN employees.salaries s USING (emp_no)
        WHERE s.to_date > NOW();
    
    SELECT * FROM employees_with_departments;
    
USE employees;

DROP TABLE e_w_d;

CREATE TEMPORARY TABLE e_w_d AS (
SELECT 
    d.dept_name AS 'dept_name', AVG(s.salary) AS 'avg_salary'
FROM
    employees.departments d
        JOIN
    employees.dept_emp de ON d.dept_no = de.dept_no
        JOIN
    employees.salaries s ON de.emp_no = s.emp_no
WHERE
    de.to_date > NOW() AND s.to_date > NOW()
    GROUP BY d.dept_name)
    LIMIT 10000;

SELECT * FROM e_w_d;

ALTER TABLE e_w_d ADD overall_avg INT;
ALTER TABLE e_w_d ADD stddev INT;
ALTER TABLE e_w_d ADD z_score DECIMAL(14,4);
UPDATE e_w_d SET overall_avg = (SELECT AVG(salary) FROM employees.salaries);
UPDATE e_w_d SET stddev = (SELECT STDDEV(salary) FROM employees.salaries);
UPDATE e_w_d SET overall_avg = (SELECT AVG(salary) FROM employees.salaries);
UPDATE e_w_d SET z_score = (overall_avg - avg_salary) / stddev;

-- And here we start over

CREATE TEMPORARY TABLE emps AS (
SELECT e.emp_no, s.salary FROM
employees.employees e
JOIN employees.salaries s ON e.emp_no = s.emp_no)
LIMIT 10000;

ALTER TABLE emps ADD avg_sal DECIMAL(14,4);
ALTER TABLE emps ADD z_sal DECIMAL(14,4);

UPDATE emps SET z_sal = (salary - (
SELECT AVG(s.salary) FROM employees.salaries e
JOIN employees.salaries s ON e.emp_no = s.emp_no)) / (
SELECT STDDEV(s.salary) FROM employees.salaries e
JOIN employees.salaries s ON e.emp_no = s.emp_no)
LIMIT 10000;


SELECT * FROM emps;

