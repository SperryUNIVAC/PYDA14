set search_path to "bookings"

-- задание 1
select a.airport_code, a.airport_name, a.city 
from airports as a
where a.city in 
	(select  ap.city
	 from airports as ap
	 group by ap.city
	 having count(*) > 1)
order by a.city, a.airport_code;

--задание 2
select distinct ap.airport_name, af.model
from flights as f 
join (select aircraft_code
from aircrafts as a
order by "range" desc
limit 1) foo using(aircraft_code)
join airports as ap on f.departure_airport = ap.airport_code
join aircrafts as af using(aircraft_code)

--задание 3
select flight_no, flight_id, actual_departure - scheduled_departure as delayed_time
from flights_v as fv
where actual_departure - scheduled_departure is not null
order by "delayed_time" desc
limit 10

--задание 4
select ticket_no, boarding_no
from tickets as t2 
left join boarding_passes as bp using(ticket_no)
where boarding_no is null

--задание 5
select 
	departure_airport,
	date_trunc('day', actual_departure_local) as date_day,
	count(bp.seat_no) as passengers,
	sum(count(bp.seat_no)) over (partition by departure_airport order by date_trunc('day', actual_departure_local) rows between unbounded preceding and current row) as total,
	seats_count.seats - count(bp.seat_no) as free_seats,
	round((100*(seats_count.seats - count(bp.seat_no))/seats_count.seats::numeric), 2) as free_percent
	from tickets as t 
join boarding_passes as bp using(ticket_no)
join flights_v as f using(flight_id)
join (select 
		count(st.seat_no) as seats,
		st.aircraft_code
	from seats as st
	group by st.aircraft_code) as seats_count using(aircraft_code)
where actual_departure_local is not null
group by seats_count.seats, actual_departure_local, departure_airport
order by "departure_airport" 

--задание 6
select 
 	f1.flight_id,
	f1.aircraft_code,
	last_value(f2.uniq_total) over (partition by f1.aircraft_code) as group_value,
	last_value(f2.total) over () as total_value,
	round(100*(last_value(f2.uniq_total) over (partition by f1.aircraft_code))/((last_value(f2.total) over ())::numeric), 3) as percent_value 
from flights_v as f1
left join (select 
				flight_id,
				aircraft_code, 
				row_number() over (partition by aircraft_code) as uniq_total,
				row_number() over () as total
			from flights_v as foo) 
as f2 using(flight_id)	
where status = 'Arrived'

--задание 7
with cte as(
select 
	flight_id,
	aircraft_code,
	departure_city || ' - ' || arrival_city as route,
	fare_conditions, 
	amount 
from flights_v as fv 
join ticket_flights as tf using(flight_id)
where status = 'Arrived')
select
    cte.flight_id,
	cte.aircraft_code,
	cte.route,
    min_bus_am - max_econ_am as nimimax
from cte
join (select
    flight_id,
	min(amount) over (partition by route) as min_bus_am
from cte
where fare_conditions = 'Business')
as business using(flight_id)
join (select
    flight_id,
	max(amount) over (partition by route) as max_econ_am
from cte
where fare_conditions = 'Economy') 
as economy using(flight_id)
where (min_bus_am - max_econ_am)<0

















with cte as(
select 
	flight_id,
	aircraft_code,
	departure_city || ' - ' || arrival_city as route,
	fare_conditions, 
	amount 
from flights_v as fv 
join ticket_flights as tf using(flight_id)
where status = 'Arrived')
select
    flight_id,
	aircraft_code,
	route,
	max(amount) over (partition by route) as max_econ_am
from cte
where fare_conditions = 'Economy'

