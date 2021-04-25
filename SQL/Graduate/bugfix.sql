set search_path to "bookings"

--������� 5 (����� �����, ����������� � �������� �������� ����, ��������� ������ ���, ��� �� �� ������������)

select 
	departure_airport,
	date_trunc('day', actual_departure_local) as date_day,
	sum(count(bp.seat_no)) over (partition by date_trunc('day', actual_departure_local) order by departure_airport) as total
from tickets as t 
join boarding_passes as bp using(ticket_no)
join flights_v as f using(flight_id)
where actual_departure_local is not null
group by departure_airport, date_trunc('day', actual_departure_local)
order by "departure_airport", date_trunc('day', actual_departure_local)

-- ������� 6
-- ��� � ��� ������� ���������, ����� �����, �� �������, ��� ��� ����� ������ �������������� ����
select 
	aircraft_code,
	count(aircraft_code),
	sum(count(aircraft_code)) over(),
	round((100*count(aircraft_code)::numeric / (sum(count(aircraft_code)) over())), 2)  as percentum
from flights_v as f1
where status = 'Arrived'
group by aircraft_code

--������� 7 ���������������, ������ ����� 675 ����� ������ ������ 
-- 45 ��������� ���� �� ����-���� ��������� � ����� ������� �������
-- � ������ ���� ����� ��� ����
with cte as(
select 
	departure_city || ' - ' || arrival_city as route,
	fare_conditions, 
	amount 
from flights_v as fv 
join ticket_flights as tf using(flight_id)
where status = 'Arrived')
select 
	route,
	max(amount) as max_economy,
	min_business,
	max(amount) - min_business as mimimax
from cte
join (select route, min(amount) as min_business
	  from cte
      where fare_conditions = 'Business'
      group by route, amount)
as business using(route)
where fare_conditions = 'Economy' 
group by route, amount, min_business
order by route



