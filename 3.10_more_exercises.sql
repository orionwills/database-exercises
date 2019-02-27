USE world;

SELECT TABLES;

SELECT 
    city.Name,
    countrylanguage.Language,
    countrylanguage.Percentage
FROM
    city
        INNER JOIN
    countrylanguage ON city.CountryCode = countrylanguage.CountryCode
WHERE
    name LIKE '%Santa Monica%';

SELECT Region, COUNT(*)
FROM country
GROUP BY Region
ORDER BY Region DESC;