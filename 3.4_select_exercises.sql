USE albums_db;

SHOW TABLES;

-- The name of all albums by Pink Floyd

SELECT * FROM albums WHERE artist = 'Pink Floyd';

-- The year Sgt. Pepper's Lonely Hearts Club Band was released

SELECT release_date FROM albums WHERE name = 'Sgt. Pepper''s Lonely Hearts Club Band';

-- The genre for the album Nevermind

SELECT genre FROM albums WHERE name = 'Nevermind';

/* 
Which albums were released in the 1990s
release_date for error checking
*/

SELECT name, release_date FROM albums WHERE release_date BETWEEN 1990 AND 1999;

/*
Which albums had less than 20 million certified sales
sales added for error checking
*/

SELECT name, sales FROM albums WHERE sales < 20;

/*
All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
We looked for exactly "Rock" and not genres that contained "rock", so it was returned exactly as it was requested
*/

SELECT name, genre FROM albums WHERE genre = 'Rock';

/*
All albums where genre contains the word "rock"alter
*/

SELECT name, genre FROM albums WHERE genre LIKE '%rock%';



