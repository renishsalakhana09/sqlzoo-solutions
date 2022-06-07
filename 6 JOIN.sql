--The JOIN operation
/*
Sixth section of sqlzoo, Join
*/


--#1
/*
The first example shows the goal scored by 'Bender'.
Show matchid and player name for all goals scored by Germany.
*/
SELECT matchid, player FROM goal
WHERE teamid = 'GER'


--#2
/*
From the previous query you can see that Lars Bender's goal was scored in game 1012. Notice that the column matchid in the goal table corresponds to the id column in the game table.
Show id, stadium, team1, team2 for game 1012
*/

SELECT id,stadium,team1,team2
FROM game
WHERE id=1012;

--#3
/*
You can combine the two steps into a single query with a JOIN. You will get all the game details and all the goal details if you use
SELECT *
  FROM game JOIN goal ON (id=matchid)
Show the player, teamid and mdate and for every German goal. teamid='GER'
*/

SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (game.id=goal.matchid)
WHERE teamid='GER';


--#4
/*
Use the same JOIN as in the previous question.
Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
*/

SELECT team1, team2, player
FROM game
  JOIN goal ON (id=matchid AND player LIKE 'Mario%')
;


--#5
/*
The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id
Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
*/

SELECT player, teamid, coach, gtime
FROM goal
  JOIN eteam ON (teamid=id AND gtime<=10)
;

--#6
/*
To JOIN game with eteam you could use either
game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)
Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id
List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
*/

select mdate,teamname from game JOIN eteam ON (team1=eteam.id AND coach LIKE '%Santos%')
;


--#7
/*
List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
*/

SELECT player from goal join game on (id=matchid AND stadium ='National Stadium, Warsaw')
;


--#8
/*
The example query shows all goals scored in the Germany-Greece quarterfinal.
Instead show the name of all players who scored a goal against Germany.
*/

SELECT DISTINCT(player) from game join goal on matchid=id 
where ((team1='GER' OR team2='GER') AND teamid!='GER')
;
--#9
/*
Show teamname and the total number of goals scored.
*/
SELECT teamname, COUNT(player)
FROM eteam
  JOIN goal ON id=teamid
GROUP BY teamname

--#9 other solution   
select teamname,COUNT(player) from eteam join goal on (id=teamid) 
group by teamname
order by teamname
;

--#10
/*
Show the stadium and the number of goals scored in each stadium.
*/

SELECT stadium,COUNT(player) AS GOALS from game join goal on (id=matchid) 
group by stadium
;


--#11
/*
For every match involving 'POL', show the matchid, date and the number of goals scored.
*/

SELECT matchid,mdate,COUNT(player) AS Goalers from game join goal on (matchid=id AND (team1='POL' OR team2='POL')) 
GROUP BY matchid,mdate
;


--#12
/*
For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
*/

SELECT id,mdate ,COUNT(player) from game join goal on (id=matchid AND (team1='GER' OR team2='GER') AND teamid='GER') group by id,mdate;

--#13
/*
List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
mdate	team1	score1	team2	score2
1 July 2012	ESP	4	ITA	0
10 June 2012	ESP	1	ITA	1
10 June 2012	IRL	1	CRO	3
...
Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0.
You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2.
*/

SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
  FROM game LEFT JOIN goal ON matchid = id
  GROUP BY mdate, matchid, team1, team2
  ;