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

SELECT name, num_registered, year
FROM names
WHERE num_registered = (SELECT MAX(num_registered) FROM names);

-- Linda 


-- Q4) What range of years are included?
SELECT MAX(year), Min(year)
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

SELECT SUM(num_registered), name, gender
FROM names 
GROUP BY name, gender
ORDER BY SUM(num_registered) DESC
LIMIT 5;


-- The most popular Male and Female names are Linda and James
-- Use SUM instead

-- JAMES AND MARY
						
-- Q9) What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?

SELECT SUM(num_registered), name, gender, year
FROM names
WHERE year BETWEEN 2000 AND 2009
GROUP BY name, gender, year
ORDER BY SUM(num_registered) DESC
LIMIT 20;

-- Jacob in the year 2000. and Emily in the same year

-- Q10) Which year had the most variety in names (i.e. had the most distinct names)?

SELECT year, COUNT(DISTINCT name) AS name_variety_count
FROM names
GROUP BY year
ORDER BY name_variety_count DESC
LIMIT 1;

-- THE YEAR 2008 HAD THE MOST VARIETY IN NAMES

--Q11) What is the most popular name for a girl that starts with the letter X?

SELECT name, SUM(num_registered) AS name_count
FROM names
WHERE name LIKE 'X%'AND gender = 'F'
GROUP BY gender, name
ORDER BY name_count DESC
LIMIT 1;

-- XIMENA IS THE MOST POPULAR NAME FOR A GIRL THAT BEGINS WITH LETTER X

-- Q12) How many distinct names appear that start with a 'Q', but whose second letter is not 'u'?

SELECT COUNT(DISTINCT(name))
FROM names
WHERE name LIKE 'Q%' AND name NOT LIKE '_u%';

-- There are 46 names that start with a 'Q' whose second letter is not 'u'


-- Q13) Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.

SELECT name, SUM(num_registered)
FROM names
WHERE name IN ('Stephen','Steven')
GROUP BY name;

--Stephen is the more poplular spelling

--Q14) What percentage of names are "unisex" - that is what percentage of names have been used both for boys and for girls?

SELECT COUNT(*)
FROM (SELECT COUNT(DISTINCT name)
FROM names
WHERE gender IN('M', 'F')
GROUP BY name
HAVING COUNT(DISTINCT gender) = 2) AS sub;

/
SELECT COUNT(DISTINCT name) 
FROM names;

-- 15) How many names have made an appearance in every single year since 1880?
WITH year_count AS(
	SELECT name, COUNT(DISTINCT year) AS years_appeared
	FROM names 
	WHERE year>= 1880
	GROUP BY name 
	HAVING COUNT(DISTINCT year) = (SELECT MAX(year)- MIN(year) +1 FROM names)
)
SELECT COUNT(*) AS total_names
FROM year_count;

-- 921 NAMES appeared every year since 1880

-- 16. How many names have only appeared in one year?
WITH name_count AS (
	SELECT name
	FROM names
	GROUP BY name
	HAVING COUNT(DISTINCT year) =1
	)
SELECT COUNT(*)
FROM name_count;

-- 21123 names appeared only a single year


-- 17. How many names only appeared in the 1950s?	
	
WITH names_50s AS (
	SELECT name, MIN(year) AS first_year, MAX(year) AS last_year
	FROM names
	GROUP BY 1
	HAVING MIN(year) >= 1950 AND MAX(year) <= 1959
)

SELECT COUNT(*)
FROM names_50s;

-- 661 names only appeared in the 1950s.

-- 18. How many names made their first appearance in the 2010s?
WITH first_appearance_count AS (
	SELECT name, MIN(year) AS first_year
	FROM names
	GROUP BY 1
	HAVING MIN(year) >= 2010
	)
SELECT COUNT(*)
FROM first_appearance_count;

-- 11270 names made their first appearance in the 2010s.


-- 19. Find the names that have not be used in the longest.
SELECT name, MAX(year) as last_year
FROM names
GROUP BY 1
ORDER BY 2;



-- 20. Come up with a question that you would like to answer using this dataset. Then write a query to answer this question.

