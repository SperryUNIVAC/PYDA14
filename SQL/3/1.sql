select 
count(city) over (partition by city) as city_count 
from 
	(select 
		full_address.city
	from 
		"dvd-rental".customer as customer 
	left join 
		(select 
			address.city_id,
			address.address_id,
			address.address,
			address.district,
			city.city,
			city.country
		from 
			"dvd-rental".address as address 
		left join 
			(select 
				city.city_id,	
				city.city, 	
				country.country
			from 
				"dvd-rental".city as city
			left join 
				"dvd-rental".country as country 	
			on 
				city.country_id = country.country_id)
			as city
		on 
			address.city_id = city.city_id) 
	as full_address
	on 
		customer.address_id = full_address.address_id)
as city_list
order by city_count desc;




