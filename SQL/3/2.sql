select 
	customer.first_name, 
	customer.last_name,
	full_address.address,
	full_address.district,
	full_address.city,
	full_address.country
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
	customer.address_id = full_address.address_id;