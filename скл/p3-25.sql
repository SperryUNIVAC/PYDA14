create table table_one (
	name_one varchar(255) not null
);

create table table_two (
	name_two varchar(255) not null
);

insert into table_one (name_one)
values ('one'), ('two'), ('three'), ('four'), ('five')

insert into table_two (name_two)
values ('four'), ('five'), ('six'), ('seven'), ('eight')

select * from table_one

select * from table_two

--left, right, inner, full outer, cross

select t1.name_one, t2.name_two
from table_one t1
left join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1
right join table_two t2 on t1.name_one = t2.name_two

select table_one.name_one, table_two.name_two
from table_one
right join table_two on table_one.name_one = table_two.name_two

select t1.name_one, t2.name_two
from table_one t1
inner join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1
join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1
full outer join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1
full outer join table_two t2 on t1.name_one = t2.name_two
where t1.name_one is null or t2.name_two is null

select t1.name_one, t2.name_two
from table_one t1
cross join table_two t2 

select t1.name_one, t2.name_two
from table_one t1, table_two t2 

delete from table_one;
delete from table_two;

insert into table_one (name_one)
select unnest(array[1,1,2])

insert into table_two (name_two)
select unnest(array[1,1,3])

select t1.name_one, t2.name_two
from table_one t1
join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1
cross join table_two t2 
where t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1
join table_two t2 on t1.name_one = t2.name_two

select t1.name_one, t2.name_two
from table_one t1
left join table_two t2 on t1.name_one = t2.name_two

1a	1c 
1b	1d
2	3

============= ���������� =============

1. �������� ������ �������� ���� ������� � �� ������ (������� language)
* ����������� ������� film
* ��������� � language
* �������� ���������� � �������:
title, language."name"

select f.title, l."name"
from film f
join "language" l using(language_id)

select f.title, l."name"
from film f
join "language" l on l.language_id = f.language_id

1.1 �������� ��� ������ � �� ���������:
* ����������� ������� film
* ��������� � �������� film_category
* ��������� � �������� category
* �������� ���������� � �������:
title, category."name"
--using

select f.title, c."name"
from film f
join film_category fc using(film_id)
join category c using(category_id)

2. �������� ������ ���� �������, ����������� � ������ Lambs Cincinatti (film_id = 508). 
* ����������� ������� film
* ��������� � film_actor
* ��������� � actor
* ������������, ��������� where � "title like" (��� ��������) ��� "film_id =" (��� id)

select f.title, a.last_name
from film f
join film_actor fa on fa.film_id = f.film_id
join actor a on a.actor_id = fa.actor_id
where f.film_id = 508

2.1 �������� ��� �������� �� ������ Woodridge (city_id = 576)
* ����������� ������� store
* ��������� ������� � address 
* ��������� ������� � city 
* ��������� ������� � country 
* ������������ , ��������� where � "city like" (��� �������� ������) ��� "city_id ="  (��� id)
* �������� ������ ����� ������� ��������� � �� id:
store_id, postal_code, country, city, district, address, address2, phone

select store_id, postal_code, country, city, district, address, address2, phone
from city c
join address a on a.city_id = c.city_id
join country c2 on c.country_id = c2.country_id
join store s on s.address_id = a.address_id
where c.city_id = 576

select concat(t1.name_one, t2.name_two)
from table_one t1
full outer join table_two t2 on t1.name_one = t2.name_two
where t1.name_one is null or t2.name_two is null

select 
	case 
		when t1.name_one is null then t2.name_two
		when t2.name_two is null then t1.name_one
		else '���-�� ����� �� ���'
	end
from table_one t1
full outer join table_two t2 on t1.name_one = t2.name_two
where t1.name_one is null or t2.name_two is null

select 1 as x, 1 as y
union all
select 1 as x, 1 as y

select 1 as x, 1 as y
union
select 1 as x, 2 as y
except 
select 1 as x, 1 as y


============= ���������� ������� =============

3. ����������� ���������� ������� � ������ Grosse Wonderful (id - 384)
* ����������� ������� film
* ��������� � film_actor
* ������������, ��������� where � "title like" (��� ��������) ��� "film_id =" (��� id) 
* ��� �������� ����������� ������� count, ����������� actor_id � �������� ��������� ������ �������
--��, ������� ���������� 

select f.title, fa.actor_id
from film f
join film_actor fa on fa.film_id = f.film_id
where f.film_id = 384

select f.title, count(fa.actor_id), f.description, f.rating, f.release_year
from film f
join film_actor fa on fa.film_id = f.film_id
where f.film_id = 384
group by f.film_id

select f.film_id, f.title, count(fa.actor_id), f.description, f.rating, f.release_year
from film f
join film_actor fa on fa.film_id = f.film_id
where f.film_id = 384
group by f.film_id

FROM
ON
JOIN
WHERE
GROUP by --�����, �� �� � ������ ���� ��� �����������
WITH CUBE ��� WITH ROLLUP
HAVING
select --������ 
DISTINCT
ORDER by


3.1 ���������� ������� ��������� ������ �� ���� �� ���� �������
* ����������� ������� film
* ��������� ������ �� ���� rental_rate/rental_duration
* avg - �������, ����������� ������� ��������
--4 ���������

select avg(rental_rate/rental_duration),
	sum(rental_rate/rental_duration),
	max(rental_rate/rental_duration),
	min(rental_rate/rental_duration)
from film 

select string_agg(last_name, ', ')
from staff

select array_agg(last_name)
from staff

============= ����������� =============

4. �������� ������ �������, � ������� ��������� ������ 10 �������

* ����������� ������� film
* ��������� � film_actor
* ������������ �������� ������� �� film_id
* ��� ������ ������ ���������� ����������� �������
* �������������� ����������� �����, ��� ������ ������� � ������������ > 10
--having, numeric, alias

explain analyze
select f.title
from film f
join film_actor fa using(film_id)
-- where - ������� ����������� �� �����������
-- where fa.actor_id != 5
group by f.film_id
having count(fa.actor_id) > 10
--having - ������� ����������� ����� �����������

explain analyze
select title 
from film f 
where film_id in (
	select film_id 
	from film_actor fa 
	group by film_id 
	having count(actor_id) > 10 )

4.1 �������� ������ ��������� �������, ������� ����������������� ������ ������� ����� 5 ����
* ����������� ������� film
* ��������� � �������� film_category
* ��������� � �������� category
* ������������ ���������� ������� �� category.name
* ��� ������ ������ ���������� ������ ����������������� ������ �������
* �������������� ����������� �����, ��� ������ ��������� �� ������� ������������������ > 5 ����

explain analyze
select c."name"
from film f
join film_category fc on fc.film_id = f.film_id
join category c on c.category_id = fc.category_id
group by c.category_id
having avg(f.rental_duration) > 5

============= ���������� =============

5. �������� ���������� �������, �� ���������� ������ �� ���� ������, ��� ������� �������� �� ���� �������
* �������� ���������, ������� ����� ��������� ������� �������� ��������� ������ �� ���� (������� 3.1)
* ����������� ������� film
* ������������ ������ � �������������� �������, ��������� �������� > (���������)
* count - ���������� ������� �������� ��������

select avg(rental_rate/rental_duration)
from film 

select count(f.film_id)
from film f
where f.rental_rate/f.rental_duration > (select avg(rental_rate/rental_duration) from film)

select count(f.film_id)
from film f
where f.film_id in (select fa.film_id from film_actor fa where f.film_id < 100)

6. �������� ������, � ���������� ������������ � ����� "C"
* �������� ���������:
 - ����������� ������� category
 - ������������ ������ � ������� ��������� like 
* ��������� � �������� film_category
* ��������� � �������� film
* �������� ���������� � �������:
title, category."name"
--position and time

select category_id
from category 
where name ilike 'c%'

explain analyze
select f.title
from film f
join film_category fc on fc.film_id = f.film_id
join category c on c.category_id = fc.category_id
where c.category_id in (
	select category_id
	from category 
	where name ilike 'c%') --104.53
	
explain analyze
select f.title
from film f
join film_category fc on fc.film_id = f.film_id
join (
	select category_id
	from category 
	where name ilike 'c%') c on c.category_id = fc.category_id  --99.85
	
explain analyze
select f.title
from film f
join film_category fc on fc.film_id = f.film_id
join (
	select category_id
	from category 
	where name ilike 'c%') c on c.category_id = fc.category_id
where c.category_id is not null --99.85

explain analyze
select f.title
from (
	select category_id
	from category 
	where name ilike 'c%') c 
join film_category fc on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id --99.85

explain analyze
select f.title
from film f
right join film_category fc on fc.film_id = f.film_id and 
	fc.category_id in (
		select category_id
		from category 
		where name ilike 'c%')
where f.title is not null --97.55

6.1. �������� ������, � ���������� ������������ � ����� "C", �� ����������� ������ ���������� � ������� ����������
* ����������� ������� film
* ��������� � �������� film_category
* �������� ���������:
 - ����������� ������� category
 - ������������ ������ � ������� ��������� like 
* ����������� ��������� ������ ���������� � ���������� � ������� ��������� in



7. �������� ������� � 3-�� ������: �������� ������, ��� ������ � ���������� �������, � ������� �� ��������
* ����������� ������� film
* ��������� � film_actor
* ��������� � actor
* count - ���������� ������� �������� ��������
* ������� ���� � �������������� ����������� over � partition by
-- ������ 2 ��� kcu

explain analyze

select *
from (
	select f.title, a.last_name, count(f.film_id) over (partition by a.actor_id)
	from film f
	join film_actor fa on fa.film_id = f.film_id
	join actor a on a.actor_id = fa.actor_id) t
where t.count > 20

explain analyze
select f.title, a.last_name, count(f.film_id) over (partition by a.actor_id)
	from film f
	join film_actor fa on fa.film_id = f.film_id
	join actor a on a.actor_id = fa.actor_id

explain analyze	
select f.title, a.last_name, (select count(*) from film_actor fa1 where fa1.actor_id = fa.actor_id)
from film f
join film_actor fa on fa.film_id = f.film_id
join actor a on a.actor_id = fa.actor_id

select a.last_name, count(fa.film_id), a.actor_id
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id

explain analyze	
select f.title, t.last_name, t.count
from film f
join film_actor fa on fa.film_id = f.film_id
join (
	select a.last_name, count(fa.film_id), a.actor_id
	from actor a
	join film_actor fa on a.actor_id = fa.actor_id
	group by a.actor_id) t on t.actor_id = fa.actor_id

explain analyze
select
	title,
	actor_full_name,
 count(title) over ( partition by actor_full_name ) as film_cnt
from
	(
	select
		title,
		fa.actor_id ,
		concat(first_name, ' ', last_name) as actor_full_name
	from
		film_actor fa
	inner join film f on
		f.film_id = fa.film_id
	inner join actor a on
		fa.actor_id = a.actor_id) ff
order by
	actor_full_name
	
��������� � ����� ��� ���� ������ over(.....) �������� 
(select count() from film_actor fa1 where fa1.idactor=fa.id_actor) �� ����� ������
��� ��� count  ����� ��������� ������ ���
	
select tc.table_name, tc.constraint_name, c.column_name, c.data_type
from information_schema.table_constraints tc
join information_schema.key_column_usage kcu on tc.constraint_schema = kcu.constraint_schema
	and tc.table_name = kcu.table_name 
	and tc.constraint_name = kcu.constraint_name
join information_schema."columns" c on kcu.table_name = c.table_name
	and c.column_name = kcu.column_name
	and kcu.constraint_schema = c.table_schema
where tc.constraint_schema = 'dvd-rental' and tc.constraint_type = 'PRIMARY KEY'
