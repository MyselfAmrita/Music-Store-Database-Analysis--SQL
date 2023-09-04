/* Q1: Who is the senior most employee based on job title? */
select *
from employee
order by levels desc
limit 1;

/* Q2: Which countries have the most Invoices? */
Select max(billing_country),count(*)
from invoice
group by billing_country
limit 1;

/* Q3: What are top 3 values of total invoice? */
select * from invoice order by total desc limit 3;

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */
select billing_city,sum(total) AS Total_Invoice
from invoice
group by billing_city
order by Total_Invoice desc;

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/
select c.customer_id,c.first_name,c.last_name,sum(v.total) AS money_spent
from customer c join invoice v ON c.customer_id=v.customer_id
group by c.customer_id,c.first_name,c.last_name
order by sum(v.total) desc
limit 1;