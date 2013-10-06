SELECT "mountains".* FROM "mountains" 
INNER JOIN "trip_mountains" ON "mountains"."id" = "trip_mountains"."mountain_id" 
INNER JOIN "trips" ON "trip_mountains"."trip_id" = "trips"."id" 
INNER JOIN "trip_participations" ON "trips"."id" = "trip_participations"."trip_id" 
WHERE "trip_participations"."user_id" = $1 ORDER BY height desc  [["user_id", 1]]

SELECT mountains FROM mountains
INNER JOIN trip_mountains ON mountains.id = trip_mountains.mountain_id 
INNER JOIN trips ON trip_mountains.trip_id = trips.id 
INNER JOIN trip_participations ON trips.id = trip_participations.trip_id 
WHERE trip_participations.user_id = 1 

SELECT mountains.* FROM mountains 
  INNER JOIN trip_mountains ON mountains.id = trip_mountains.mountain_id 
  INNER JOIN trips ON trip_mountains.trip_id = trips.id 
  INNER JOIN trip_participations ON trips.id = trip_participations.trip_id 
  WHERE trip_participations.user_id = 1

SELECT mountains.* FROM mountains 
INNER JOIN mountain_lists ON mountains.id = mountain_lists.mountain_id 
WHERE mountain_lists.list_id = 3 AND height > 1219 

SELECT mountains.* FROM mountains INNER JOIN mountain_lists ON mountains.id = mountain_lists.mountain_id WHERE mountain_lists.list_id = 3 AND height > 1219 AND   INNER JOIN trip_mountains ON mountains.id = trip_mountains.mountain_id INNER JOIN trips ON trip_mountains.trip_id = trips.id
 INNER JOIN trip_participations ON trips.id = trip_participations.trip_id WHERE trip_participations.user_id = 1  

ORDER BY height desc 

SELECT
mountains.*
FROM mountains
LEFT JOIN players ON (teams.id = players.team_id)
WHERE
players.team_id IS NULL

SELECT *
FROM teams
WHERE NOT EXISTS (SELECT 1 FROM players WHERE players.team_id = teams.team_id)

SELECT mountains FROM mountains
INNER JOIN trip_mountains ON mountains.id = trip_mountains.mountain_id 
INNER JOIN trips ON trip_mountains.trip_id = trips.id 
INNER JOIN trip_participations ON trips.id = trip_participations.trip_id 
WHERE NOT EXISTS trip_participations.user_id = 1 AND INNER JOIN mountain_lists ON mountains.id = mountain_lists.mountain_id 
WHERE mountain_lists.list_id = 1