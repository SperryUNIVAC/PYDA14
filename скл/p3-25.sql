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

============= соединения =============

1. Выведите список названий всех фильмов и их языков (таблица language)
* Используйте таблицу film
* Соедините с language
* Выведите информацию о фильмах:
title, language."name"

select f.title, l."name"
from film f
join "language" l using(language_id)

select f.title, l."name"
from film f
join "language" l on l.language_id = f.language_id

1.1 Выведите все фильмы и их категории:
* Используйте таблицу film
* Соедините с таблицей film_category
* Соедините с таблицей category
* Выведите информацию о фильмах:
title, category."name"
--using

select f.title, c."name"
from film f
join film_category fc using(film_id)
join category c using(category_id)

2. Выведите список всех актеров, снимавшихся в фильме Lambs Cincinatti (film_id = 508). 
* Используйте таблицу film
* Соедините с film_actor
* Соедините с actor
* Отфильтруйте, используя where и "title like" (для названия) или "film_id =" (для id)

select f.title, a.last_name
from film f
join film_actor fa on fa.film_id = f.film_id
join actor a on a.actor_id = fa.actor_id
where f.film_id = 508

2.1 Выведите все магазины из города Woodridge (city_id = 576)
* Используйте таблицу store
* Соедините таблицу с address 
* Соедините таблицу с city 
* Соедините таблицу с country 
* отфильтруйте , используя where и "city like" (для названия города) или "city_id ="  (для id)
* Выведите полный адрес искомых магазинов и их id:
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
		else 'что-то пошло не так'
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


============= агрегатные функции =============

3. Подсчитайте количество актеров в фильме Grosse Wonderful (id - 384)
* Используйте таблицу film
* Соедините с film_actor
* Отфильтруйте, используя where и "title like" (для названия) или "film_id =" (для id) 
* Для подсчета используйте функцию count, используйте actor_id в качестве выражения внутри функции
--ФЗ, Аксиомы Армстронга 

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
GROUP by --знает, но не в каждой СУБД это реализовано
WITH CUBE или WITH ROLLUP
HAVING
select --алиасы 
DISTINCT
ORDER by


3.1 Посчитайте среднюю стоимость аренды за день по всем фильмам
* Используйте таблицу film
* Стоимость аренды за день rental_rate/rental_duration
* avg - функция, вычисляющая среднее значение
--4 агрегации

select avg(rental_rate/rental_duration),
	sum(rental_rate/rental_duration),
	max(rental_rate/rental_duration),
	min(rental_rate/rental_duration)
from film 

select string_agg(last_name, ', ')
from staff

select array_agg(last_name)
from staff

============= группировки =============

4. Выведите список фильмов, в которых снималось больше 10 актеров

* Используйте таблицу film
* Соедините с film_actor
* Сгруппируйте итоговую таблицу по film_id
* Для каждой группы посчитайте колличество актеров
* Воспользуйтесь фильтрацией групп, для выбора фильмов с колличеством > 10
--having, numeric, alias

explain analyze
select f.title
from film f
join film_actor fa using(film_id)
-- where - условие выполняется до группировки
-- where fa.actor_id != 5
group by f.film_id
having count(fa.actor_id) > 10
--having - условие выполняется после группировки

explain analyze
select title 
from film f 
where film_id in (
	select film_id 
	from film_actor fa 
	group by film_id 
	having count(actor_id) > 10 )

4.1 Выведите список категорий фильмов, средняя продолжительность аренды которых более 5 дней
* Используйте таблицу film
* Соедините с таблицей film_category
* Соедините с таблицей category
* Сгруппируйте полученную таблицу по category.name
* Для каждой группы посчитайте средню продолжительность аренды фильмов
* Воспользуйтесь фильтрацией групп, для выбора категории со средней продолжительностью > 5 дней

explain analyze
select c."name"
from film f
join film_category fc on fc.film_id = f.film_id
join category c on c.category_id = fc.category_id
group by c.category_id
having avg(f.rental_duration) > 5

============= подзапросы =============

5. Выведите количество фильмов, со стоимостью аренды за день больше, чем среднее значение по всем фильмам
* Напишите подзапрос, который будет вычислять среднее значение стоимости аренды за день (задание 3.1)
* Используйте таблицу film
* Отфильтруйте строки в результирующей таблице, используя опретаор > (подзапрос)
* count - агрегатная функция подсчета значений

select avg(rental_rate/rental_duration)
from film 

select count(f.film_id)
from film f
where f.rental_rate/f.rental_duration > (select avg(rental_rate/rental_duration) from film)

select count(f.film_id)
from film f
where f.film_id in (select fa.film_id from film_actor fa where f.film_id < 100)

6. Выведите фильмы, с категорией начинающейся с буквы "C"
* Напишите подзапрос:
 - Используйте таблицу category
 - Отфильтруйте строки с помощью оператора like 
* Соедините с таблицей film_category
* Соедините с таблицей film
* Выведите информацию о фильмах:
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

6.1. Выведите фильмы, с категорией начинающейся с буквы "C", но используйте данные подзапроса в условии фильтрации
* Используйте таблицу film
* Соедините с таблицей film_category
* Напишите подзапрос:
 - Используйте таблицу category
 - Отфильтруйте строки с помощью оператора like 
* Используйте результат работы подзапроса в фильтрации с помощью оператора in



7. Выведите таблицу с 3-мя полями: название фильма, имя актера и количество фильмов, в которых он снимался
* Используйте таблицу film
* Соедините с film_actor
* Соедините с actor
* count - агрегатная функция подсчета значений
* Задайте окно с использованием предложений over и partition by
-- разбор 2 доп kcu

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
	
правильно я понял что если вместо over(.....) написать 
(select count() from film_actor fa1 where fa1.idactor=fa.id_actor) то будет дольще
так как count  будет считаться каждый раз
	
select tc.table_name, tc.constraint_name, c.column_name, c.data_type
from information_schema.table_constraints tc
join information_schema.key_column_usage kcu on tc.constraint_schema = kcu.constraint_schema
	and tc.table_name = kcu.table_name 
	and tc.constraint_name = kcu.constraint_name
join information_schema."columns" c on kcu.table_name = c.table_name
	and c.column_name = kcu.column_name
	and kcu.constraint_schema = c.table_schema
where tc.constraint_schema = 'dvd-rental' and tc.constraint_type = 'PRIMARY KEY'
