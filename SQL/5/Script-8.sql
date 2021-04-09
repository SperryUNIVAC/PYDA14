set search_path to "dvd-rental"

select 
	customer_id, 
	rental_date, 
	return_date, 
	rental_id, 
	row_number() over (partition by customer_id order by rental_date desc) as rental_func
from rental

-- задание 2
-- первый вариант запроса, что бы поучится и посмотреть как он это считает

select
	customer_id,
	special_features,
	count(customer_id) over (partition by customer_id order by customer_id desc)
from rental
join inventory as i using(inventory_id)
join film as f using(film_id)
where array_to_string(special_features, ' ') like '%Behind the Scenes%' 

-- итоговый вариант запроса

select
	customer_id,
	count(customer_id) as Behind_the_Scenes 
from rental
join inventory as i using(inventory_id)
join film as f using(film_id)
where array_to_string(special_features, ' ') like '%Behind the Scenes%' 
group by customer_id 


create materialized view customers_like_Behind_the_Scenes
as
select
	customer_id,
	count(customer_id) as Behind_the_Scenes 
from rental
join inventory as i using(inventory_id)
join film as f using(film_id)
where array_to_string(special_features, ' ') like '%Behind the Scenes%' 
group by customer_id
with no data

refresh materialized view customers_like_Behind_the_Scenes

select * from customers_like_Behind_the_Scenes

/*оказалось, что своим умом я допер до самой плохой практики выколупывания значения, просто потому что 
 * не прошарил, какой функцией расколупать массив на предмет наличия в нем элемента ((
 * зато смастерил этот костыль своим умом)
 * вот три варианта более прямых
 */


select
	customer_id,
	count(customer_id) as Behind_the_Scenes 
from rental
join inventory as i using(inventory_id)
join film as f using(film_id)
where array_position(special_features, 'Behind the Scenes') is not null
group by customer_id 



select
	customer_id,
	count(customer_id) as Behind_the_Scenes 
from rental
join inventory as i using(inventory_id)
join film as f using(film_id)
where 'Behind the Scenes' = any(special_features)
group by customer_id 


select
	customer_id,
	count(customer_id) as Behind_the_Scenes 
from rental
join inventory as i using(inventory_id)
join film as f using(film_id)
where  special_features && array['Behind the Scenes']
group by customer_id 


	

