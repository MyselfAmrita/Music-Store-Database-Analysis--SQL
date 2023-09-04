/* Question Set 3  */

/* Q1: Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */

/* Steps to Solve: First, find which artist has earned the most according to the InvoiceLines. Now use this artist to find 
which customer spent the most on this artist. For this query, you will need to use the Invoice, InvoiceLine, Track, Customer, 
Album, and Artist tables. Note, this one is tricky because the Total spent in the Invoice table might not be on a single product, 
so you need to use the InvoiceLine table to find out how many of each product was purchased, and then multiply this by the price
for each artist. */


select c.customer_id,(c.first_name),c.last_name,a2.name as Artist_name,SUM(l.unit_price*l.quantity) AS total_sales
from Customer c JOIN invoice i ON c.customer_id=i.customer_id
JOIN invoice_line l ON i.invoice_id=l.invoice_id
JOIN track t ON l.track_id=t.track_id
JOIN album2 a1 ON t.album_id=a1.album_id
JOIN artist a2 ON a1.artist_id=a2.artist_id
group by c.customer_id,c.first_name,c.last_name,a2.artist_id,a2.name
order by total_sales;



/* Q2: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */

/* Steps to Solve:  There are two parts in question- first most popular music genre and second need data at country level. */


select i.billing_country,g.name,count(g.name) as Popular_music_genre
from  invoice i 
JOIN invoice_line l ON i.invoice_id=l.invoice_id
JOIN track t ON l.track_id=t.track_id
JOIN genre g ON t.genre_id=g.genre_id
group by billing_country,g.name
order by Popular_music_genre desc;


/* Q3: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

/* Steps to Solve:  Similar to the above question. There are two parts in question- 
first find the most spent on music for each country and second filter the data for respective customers. */



With Recursive 
	customer_with_country AS(
		select c.customer_id,c.first_name,c.last_name,i.billing_country,sum(i.total) as Total_spent
        from customer c JOIN invoice i ON c.customer_id=i.customer_id
        group by 1,2,3,4),
    max_spent_country AS(
    select billing_country,max(Total_spent) as max_total_spent
    from customer_with_country
    group by billing_country)
select cc.customer_id,cc.first_name,cc.last_name,cc.billing_country,cc.total_spent
from customer_with_country cc JOIN max_spent_country ma ON cc.billing_country=ma.billing_country
where cc.total_spent=ma.max_total_spent;
	