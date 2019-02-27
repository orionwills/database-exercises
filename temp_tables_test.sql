USE ada_680;

CREATE TABLE my_numbers(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    n INT UNSIGNED NOT NULL,
    PRIMARY KEY (ID)
);

INSERT INTO my_numbers(n) VALUES
	(1), (123), (45), (42);
    
ALTER TABLE my_numbers ADD n_plus_one INT UNSIGNED;
UPDATE my_numbers SET n_plus_one = n + 1    
    
    
    
    
    
SELECT * FROM my_numbers;

UPDATE my_numbers SET n = n -1;

USE ada_680;

CREATE TEMPORARY TABLE employees_with_current_salaries AS
SELECT 
    e.emp_no,
    birth_date,
    first_name,
    last_name,
    gender,
    hire_date,
    salary AS current_salary
FROM
    employees.employees e
        JOIN
    employees.salaries s ON e.emp_no = s.emp_no
WHERE
    to_date > NOW()
LIMIT 100;

SELECT * from employees_with_current_salaries;
