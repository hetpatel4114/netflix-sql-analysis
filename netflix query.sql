USE netflix;
CREATE TABLE netflix
(
	show_id	VARCHAR(5),
	type    VARCHAR(10),
	title	VARCHAR(250),
	director VARCHAR(550),
	casts	VARCHAR(1050),
	country	VARCHAR(550),
	date_added	VARCHAR(55),
	release_year	INT,
	rating	VARCHAR(15),
	duration	VARCHAR(15),
	listed_in	VARCHAR(250),
	description VARCHAR(550)
);

SELECT * FROM netflix LIMIT 15;

-- 1. Count the number of Movies vs TV Shows
SELECT type, COUNT(*) FROM netflix GROUP BY 1;

-- 2. Find the most common rating for movies and TV shows
SELECT rating, COUNT(*) AS total_count FROM netflix GROUP BY rating ORDER BY total_count DESC LIMIT 1;

-- 3. List all movies released in a specific year (e.g., 2020)
SELECT title FROM netflix WHERE type = 'Movie'AND release_year = 2020;

-- 4. Find the top 5 countries with the most content on Netflix
SELECT country, COUNT(*) AS total_content FROM netflix WHERE country IS NOT NULL GROUP BY country ORDER BY total_content DESC LIMIT 5;

-- 5. Identify the longest movie
SELECT title, duration FROM netflix WHERE type = 'Movie' ORDER BY CAST(REPLACE(duration, ' min', '') AS UNSIGNED) DESC LIMIT 10;

-- 6. Find content added in the last 5 years
SELECT title AS content, date_added FROM netflix Where STR_TO_DATE(date_added, '%M %d, %Y') >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT type,title,director FROM netflix WHERE director = 'Rajiv Chilaka' ;

-- 8. List all TV shows with more than 5 seasons
SELECT type, title, duration FROM netflix WHERE type = 'TV Show' AND CAST(REPLACE(REPLACE(duration, ' Seasons', ''),' Season', '') AS UNSIGNED) > 5;

-- 9. Count the number of content items in each genre
SELECT listed_in AS genre, COUNT(*) AS total_content FROM netflix GROUP BY listed_in ORDER BY total_content DESC;

-- 10.Find each year and the average numbers of content release in India on netflix. return top 5 year with highest avg content release!
SELECT release_year, COUNT(*) AS total_content FROM netflix WHERE country LIKE '%India%' GROUP BY release_year ORDER BY total_content DESC LIMIT 5;

-- 11. List all movies that are documentaries
SELECT title, type, listed_in FROM netflix WHERE type = 'Movie' AND listed_in LIKE '%Documentaries%';

-- 12. Find all content without a director
SELECT title, type FROM netflix WHERE director IS NULL OR director = '';

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT title, COUNT(*) AS total_movies FROM netflix WHERE type = 'Movie' AND casts LIKE '%Salman Khan%' AND release_year >= YEAR(CURDATE()) - 10 GROUP BY title;

