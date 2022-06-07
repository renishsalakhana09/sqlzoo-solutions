--SUM and COUNT
/*Contents
1	World Country Profile: Aggregate functions
2	You might want to look at these examples first
3	Total world population
4	List of continents
5	GDP of Africa
6	Count the big countries
7	Baltic states population
8	Using GROUP BY and HAVING
9	Counting the countries of each continent
10	Counting big countries in each continent
11	Counting big continents 
*/
--#1
/*
Show the total population of the world.
*/
SELECT SUM(population)
FROM world;


--#2
/*
List all the continents - just once each.
*/
SELECT DISTINCT(continent)
FROM world

--#3
/*
Give the total GDP of Africa
*/
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa';

--#4
/*
How many countries have an area of at least 1000000
*/

SELECT COUNT(name) from world where area >=1000000;

--#5
/*
What is the total population of ('Estonia', 'Latvia', 'Lithuania')
*/

select SUM(population) from world where name IN ('Estonia', 'Latvia', 'Lithuania');

--#6
/*
For each continent show the continent and number of countries.
*/
SELECT continent, COUNT(name)
FROM world
GROUP BY continent
;


--#7
/*
For each continent show the continent and number of countries with populations of at least 10 million.
*/
SELECT continent, COUNT(name)
FROM world
WHERE population >= 10000000
GROUP BY continent
;

--#8
/*
List the continents that have a total population of at least 100 million.
*/
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) > 100000000
;