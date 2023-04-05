use sakila;
select film_id 
from film
where title like 'Hunch%';

select count(*)
from inventory
where film_id = (select film_id 
from film
where title like 'Hunch%');

select title, length
from film
where length > (select avg(length)
from film);

select first_name, last_name from actor
where actor_id in (
select actor_id from film_actor
where film_id = (select film_id from film
where title = 'Alone Trip'));

select title from film
where film_id in(
select film_id from film_category
where category_id = (
select category_id from category
where name = 'Family'));

select * from customer;

select concat(first_name,' ',last_name) name, email from customer
where address_id in
(select address_id from address
where city_id in 
(select city_id from city
where country_id = 
(select country_id from country
where country = 'Canada')));

select concat(c.first_name,' ', c.last_name) name, c.email from customer c
join address a 
on c.address_id = a.address_id
join city ct
on a.city_id = ct.city_id
join country co
on ct.country_id = co.country_id
where co.country = 'Canada';

select * from film_actor;

select actor_id from(
select count(actor_id) film_appearances, actor_id
from film_actor
group by actor_id
order by 1 desc
limit 1) temp;

select title from film
where film_id in (
select film_id from film_actor
where actor_id = (
select actor_id from(
select count(actor_id) film_appearances, actor_id
from film_actor
group by actor_id
order by 1 desc
limit 1) temp));

select * from customer;


select customer_id 
from (select customer_id, sum(amount) from payment
group by customer_id
order by 2 desc
limit 1) temp_2;

select * from rental;
select * from inventory;
select * from film;


select title from film
where film_id in (
select film_id from inventory
where inventory_id in (
select inventory_id from rental
where customer_id = (
select customer_id 
from (select customer_id, sum(amount) from payment
group by customer_id
order by 2 desc
limit 1) temp_2)));

select * from payment;
select * from customer;

select customer_id as client_id, sum(amount) as total_amount_spent from payment
group by client_id
having total_amount_spent > (
select avg(total) from (
select customer_id, sum(amount) total from payment
group by customer_id) temp_3);

