USE employees;

/*
In your script, use DISTINCT to find the unique titles in the titles table.
*/

SELECT DISTINCT
    title
FROM
    titles;

-- OR

SELECT 
    title
FROM
    titles
GROUP BY title;

/*
Find your query for employees whose last names start and end with 'E'.
Update the query find just the unique last names that start and end with 'E' using GROUP BY.
*/

SELECT 
    last_name
FROM
    employees
WHERE
    last_name LIKE 'e%e'
GROUP BY last_name;

/*
Update your previous query to now find unique combinations of first and last name 
where the last name starts and ends with 'E'. You should get 846 rows.
*/

SELECT DISTINCT
    last_name
FROM
    employees
WHERE
    last_name LIKE 'e%e'
GROUP BY last_name , first_name;

/*
Find the unique last names with a 'q' but not 'qu'.
*/

SELECT 
    last_name, COUNT(*)
FROM
    employees
WHERE
    last_name LIKE '%q%'
        AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

-- OR

SELECT DISTINCT
    last_name
FROM
    employees
WHERE
    last_name LIKE '%q%'
        AND last_name NOT LIKE '%qu%';
    
/*
Which (across all employees) name is the most common, the least common? 
Find this for both first name, last name, and the combination of the two.
*/

-- Most/Least Common First/Last Name // 
SELECT 
    first_name, COUNT(first_name)
FROM
    employees
GROUP BY first_name
ORDER BY COUNT(first_name) DESC
LIMIT 5;

SELECT 
    CONCAT(first_name, ' ', last_name), COUNT(*)
FROM
    employees
GROUP BY CONCAT(first_name, ' ', last_name);

/*
Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY 
to find the number of employees for each gender with those names.
*/

SELECT 
    COUNT(*), gender
FROM
    employees
WHERE
    first_name IN ('Irena' , 'Vidya', 'Maya')
GROUP BY gender;
    
/*
Recall the query the generated usernames for the employees from the last lesson.
Are there any duplicate usernames?
*/

SELECT 
    LOWER(CONCAT(SUBSTR(first_name, 1, 1),
                    SUBSTR(last_name, 1, 4),
                    '_',
                    SUBSTR(birth_date, 6, 2),
                    SUBSTR(birth_date, 3, 2))) AS username,
    COUNT(*) AS duplicate_count
FROM
    employees
GROUP BY username
HAVING (duplicate_count > 1);
        
/*
Bonus: how many duplicate usernames are there?
*/

SELECT 
    LOWER(CONCAT(SUBSTR(first_name, 1, 1),
                    SUBSTR(last_name, 1, 4),
                    '_',
                    SUBSTR(birth_date, 6, 2),
                    SUBSTR(birth_date, 3, 2))) AS username,
    COUNT(*) AS duplicate_count
FROM
    employees
GROUP BY username
HAVING (duplicate_count > 1);