USE employees;

/*
Using the example in the Associative Table Joins section as a guide, 
write a query that shows each department along with the 
name of the current manager for that department.
*/

SELECT 
    dept_name AS 'Department Name',
    CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager'
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    employees e ON dm.emp_no = e.emp_no
WHERE
    dm.to_date > NOW()
ORDER BY dept_name;

/*
Find the name of all departments currently managed by women.
*/

SELECT 
    dept_name AS 'Department Name',
    CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager'
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    employees e ON dm.emp_no = e.emp_no
WHERE
    dm.to_date > NOW() AND  e.gender = 'F'
ORDER BY dept_name;

/*
Find the current titles of employees currently working in the Customer Service department.
*/

SELECT 
    t.title AS 'Title', COUNT(*)
FROM
    titles t
        JOIN
    dept_emp de ON t.emp_no = de.emp_no
        JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    d.dept_name = 'Customer Service'
        AND de.to_date > NOW()
        AND t.to_date > NOW()
GROUP BY t.title;

/*
Find the current salary of all current managers.
*/

SELECT 
    d.dept_name AS 'Department',
    CONCAT(e.first_name, ' ', e.last_name) AS 'Name',
    s.salary AS 'Salary'
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    employees e ON dm.emp_no = e.emp_no
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    dm.to_date > NOW()
        AND s.to_date > NOW()
ORDER BY dept_name;

/*
Find the number of employees in each department.
*/

SELECT 
    d.dept_no AS 'dept_no',
    d.dept_name AS 'dept_name',
    COUNT(*) AS 'num_employees'
FROM
    departments AS d
        JOIN
    dept_emp de ON de.dept_no = d.dept_no
WHERE
    de.to_date > NOW()
GROUP BY d.dept_name, d.dept_no
ORDER BY d.dept_no;

/*
Which department has the highest average salary?
*/

SELECT 
    d.dept_name AS 'dept_name', AVG(s.salary) AS 'salary'
FROM
    departments d
        JOIN
    dept_emp de ON d.dept_no = de.dept_no
        JOIN
    salaries s ON de.emp_no = s.emp_no
WHERE
    de.to_date > NOW() AND s.to_date > NOW()
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC
LIMIT 1;

/*
Who is the highest paid employee in the Marketing department?
*/

SELECT 
    e.first_name, e.last_name
FROM
    departments d
        JOIN
    dept_emp de ON d.dept_no = de.dept_no
        JOIN
    employees e ON de.emp_no = e.emp_no
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    d.dept_name = 'Marketing'
        AND de.to_date > NOW()
        AND s.to_date > NOW()
ORDER BY s.salary DESC
LIMIT 1;

/*
Which current department manager has the highest salary?
*/

SELECT 
    e.first_name, e.last_name, s.salary, d.dept_name
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    employees e ON dm.emp_no = e.emp_no
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    dm.to_date > NOW() AND s.to_date > NOW()
ORDER BY s.salary DESC
LIMIT 1;

/*
Bonus Find the names of all current employees, their department name, and their current manager's name.
*/

SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name', d.dept_name AS 'Department Name', CONCAT(e.first_name, ' ', e.last_name) AS 'Manager Name' FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN employees e ON de.emp_no = e.emp_no
JOIN dept_manager dm ON d.emp_no = dm.emp_no
JOIN employees e2 ON dm.emp_no = e.emp_no
GROUP BY CONCAT(e.first_name, ' ', e.last_name), d.dept_name;