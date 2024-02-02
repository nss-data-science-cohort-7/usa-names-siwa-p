SELECT * 
FROM names 
ORDER BY num_registered DESC
LIMIT 10;

-- Q1) How many rows are in the names table?

SELECT COUNT(*)
FROM names;

-- there are 1957046 rows in names table

-- Q2) How many total registered people appear in the dataset?
SELECT SUM(num_registered)
FROM names;

-- THERE ARE IN TOTAL 351653025 REGISTERED PEOPLE IN THE DATASET


--	Q3) Which name had the most appearances in a single year in the dataset?

SELECT name, num_registered
FROM names
WHERE num_registered = (SELECT MAX(num_registered) FROM names);

-- Linda 


-- Q4) What range of years are included?
SELECT (MAX(year)- Min(year)) AS year_range
FROM names;

-- Year range = 138

-- Q5) What year has the largest number of registrations?

SELECT year, SUM(num_registered)
FROM names
GROUP BY year
ORDER BY SUM(num_registered) DESC
LIMIT 5;


-- YEAR 1957 HAS THE LARGEST NUMBER OF REGISTRATIONS.

-- Q6) How many different (distinct) names are contained in the dataset?

SELECT COUNT(DISTINCT name) 
FROM names;

-- There are in total 98400 distinct names in the dataset

--Q7) Are there more males or more females registered?

SELECT gender, COUNT(*) 
FROM names
GROUP BY gender;


-- There are more females registered.

-- Q8) What are the most popular male and female names overall (i.e., the most total registrations)?

SELECT *
FROM names
WHERE num_registered = (SELECT MAX(num_registered)
						FROM names 
						GROUP BY gender);

