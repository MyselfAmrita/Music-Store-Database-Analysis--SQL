/* Question Set 2  */

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

select customer.email,customer.first_name,customer.last_name, genre.name
from customer JOIN
invoice ON customer.customer_id=invoice.customer_id JOIN
invoice_line ON invoice.invoice_id=invoice_line.invoice_id JOIN
track ON invoice_line.track_id=track.track_id JOIN
genre ON track.genre_id=genre.genre_id 
order by email asc;



/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */
select *
from artist;

select artist.artist_id,artist.name,count(artist.artist_id) as Number_of_songs
from artist JOIN
album2 ON artist.artist_id=album2.artist_id JOIN
track ON album2.album_id=track.album_id JOIN
genre ON track.genre_id=genre.genre_id 
WHERE genre.name LIKE "Rock"
group by artist.artist_id,artist.name
order by Number_of_songs desc;


/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

select name, track.milliseconds
from track
where milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc;

