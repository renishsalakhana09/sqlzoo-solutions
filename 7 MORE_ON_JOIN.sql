--More JOIN operations

--#1
/*
List the films where the yr is 1962 [Show id, title]
*/
SELECT id, title
FROM movie
WHERE yr=1962

--#2
/*
Give year of 'Citizen Kane'.
*/
SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

--#3
/*
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
*/
SELECT id, title, yr
FROM movie
WHERE title LIKE '%star trek%'
ORDER BY yr

--#4
/*What id number does the actor 'Glenn Close' have?
*/

SELECT id from actor where name='Glenn Close';

--#5
/*
What is the id of the film 'Casablanca'
*/
SELECT id
FROM movie
WHERE title = 'Casablanca'
;

--#6
/*
Obtain the cast list for 'Casablanca'.
what is a cast list?
Use movieid=11768 this is the value that you obtained in the previous question.
*/

SELECT name
FROM actor, casting
WHERE id=actorid AND movieid = (SELECT id FROM movie WHERE title = 'Casablanca')
;

--#7
/*
Obtain the cast list for the film 'Alien'
*/

SELECT name
FROM casting JOIN actor ON casting.actorid = actor.id
JOIN movie ON movie.id = casting.movieid
WHERE title = 'Alien';

--#8
/*
List the films in which 'Harrison Ford' has appeared
*/

SELECT title
FROM casting JOIN actor ON casting.actorid = actor.id
JOIN movie ON movie.id = casting.movieid
WHERE name = 'Harrison Ford';


--#9
/*
List the films where 'Harrison Ford' has appeared - but not in the star role.
[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
*/


SELECT title
FROM movie, actor, casting
WHERE name='Harrison Ford'
AND movie.id = movieid
AND actor.id = actorid
AND ord!=1


--#10
/*
List the films together with the leading star for all 1962 films.
*/

SELECT title, name
FROM movie, actor, casting
WHERE yr=1962
AND movie.id = movieid
AND actor.id = actorid
AND ord=1
;


--#11
/*
Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
*/
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 WHERE name='John Travolta'
 GROUP BY yr) AS t
)
;

--#12
/*
List the film title and the leading actor for all of the films 'Julie Andrews' played in.
*/

SELECT title, name 
FROM movie JOIN casting ON movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE movieid IN (
  SELECT movieid 
  FROM movie, actor, casting
  WHERE name='Julie Andrews'
  AND movie.id=movieid
  AND actor.id=actorid)
AND ord=1
;

--#13
--Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.

SELECT name from actor join casting ON casting.actorid=actor.id 
where ord =1
group by name 
HAVING COUNT(movieid)>=15
;

--#14
--List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

SELECT title ,COUNT(actorid) from movie join casting on casting.movieid=movie.id 
where yr =1978
group by title
order by count(actorid) desc,title;
;

--#15
--List all the people who have worked with 'Art Garfunkel'.

SELECT name
FROM actor JOIN casting ON casting.actorid = actor.id
WHERE movieid IN(SELECT movieid FROM casting WHERE actorid = (SELECT id FROM actor WHERE name = 'Art Garfunkel'))
AND name <> 'Art Garfunkel';




