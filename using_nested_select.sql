--#1)Using nested SELECT
--he result of a SELECT statement may be used as a value in another statement. 
--For example the statement 
SELECT continent FROM world WHERE name = 'Brazil' 
--evaluates to 'South America' so we can use this value to obtain a list of all countries in the same continent as 'Brazil'
--List each country in the same continent as 'Brazil'.


SELECT name from world where continent = (SELECT continent from world where name = 'South America')

--#2)Alias
SELECT name FROM world WHERE continent = 
SELECT continent FROM world WHERE name='Brazil') AS brazil_continent

--#3)Multiple Results
--The phrase (SELECT continent FROM world WHERE name = 'Brazil' OR name='Mexico') will return two values ('North America' and 'South America'). You should use:

SELECT name, continent FROM world
WHERE continent IN
  (SELECT continent 
     FROM world WHERE name='Brazil'
                   OR name='Mexico');
				   
--#4)Show each country that has a population greater than the population of ALL countries in Europe.

--Note that we mean greater than every single country in Europe; not the combined population of Europe.

SELECT name FROM world
 WHERE population > ALL
      (SELECT population FROM world
        WHERE continent='Europe');
		

				   
				   
				   