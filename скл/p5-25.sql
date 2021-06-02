============= оконные функции =============

1. Выведите таблицу с 3-мя полями: название фильма, имя актера и количество фильмов, в которых он снимался
* Используйте таблицу film
* Соедините с film_actor
* Соедините с actor
* count - агрегатная функция подсчета значений
* Задайте окно с использованием предложений over и partition by

select f.title, a.last_name, count(f.film_id) over (partition by a.actor_id)
from film f
join film_actor fa using(film_id)
join actor a using(actor_id)

1.1. Выведите таблицу, содержащую имена покупателей, арендованные ими фильмы и средний платеж каждого покупателя
* используйте таблицу customer
* соедините с paymen
* соедините с rental
* соедините с inventory
* соедините с film
* avg - функция, вычисляющая среднее значение
* Задайте окно с использованием предложений over и partition by

select c.last_name, f.title, avg(p.amount) over (partition by c.customer_id),
	sum(p.amount) over (partition by c.customer_id),
	min(p.amount) over (partition by c.customer_id),
	max(p.amount) over (partition by c.customer_id),
	last_value(p.amount) over (partition by c.customer_id),
	amount
from customer c
join payment p on p.customer_id = c.customer_id
join rental r on p.rental_id = r.rental_id
join inventory i on r.inventory_id = i.inventory_id
join film f on f.film_id =i.film_id


select *
from (
	select c.last_name, f.title, 
		row_number() over (partition by c.customer_id order by p.payment_date),
		f.film_id
	from customer c
	join payment p on p.customer_id = c.customer_id
	join rental r on p.rental_id = r.rental_id
	join inventory i on r.inventory_id = i.inventory_id
	join film f on f.film_id =i.film_id) t
where t.row_number = 8 and t.film_id = 611

select c.last_name, f.title, 
	lag(p.amount) over (partition by c.customer_id),
	p.amount,
	lead(p.amount) over (partition by c.customer_id),
	sum(p.amount) over (partition by c.customer_id)
from customer c
join payment p on p.customer_id = c.customer_id
join rental r on p.rental_id = r.rental_id
join inventory i on r.inventory_id = i.inventory_id
join film f on f.film_id =i.film_id

select c.last_name, f.title, 
	lag(p.amount, 3) over (partition by c.customer_id),
	p.amount,
	lead(p.amount, 5) over (partition by c.customer_id),
	sum(p.amount) over (partition by c.customer_id)
from customer c
join payment p on p.customer_id = c.customer_id
join rental r on p.rental_id = r.rental_id
join inventory i on r.inventory_id = i.inventory_id
join film f on f.film_id =i.film_id

select c.last_name, f.title, 
	row_number() over (partition by c.customer_id order by p.amount),
	rank() over (partition by c.customer_id order by p.amount),
	dense_rank() over (partition by c.customer_id order by p.amount),
	p.amount
from customer c
join payment p on p.customer_id = c.customer_id
join rental r on p.rental_id = r.rental_id
join inventory i on r.inventory_id = i.inventory_id
join film f on f.film_id =i.film_id

select c.last_name, f.title, 
	sum(p.amount) over (partition by c.customer_id, date(p.payment_date) order by p.payment_date),
	p.amount, date(p.payment_date)
from customer c
join payment p on p.customer_id = c.customer_id
join rental r on p.rental_id = r.rental_id
join inventory i on r.inventory_id = i.inventory_id
join film f on f.film_id =i.film_id


============= общие табличные выражения =============

2.  При помощи CTE выведите таблицу со следующим содержанием:
Фамилия и Имя сотрудника (staff) и количество прокатов двд (retal), которые он продал
* Создайте CTE:
 - Используйте таблицу staff
 - соедините с rental
 - || - оператор конкатенации
 * напишите запрос к полученной CTE:
 - сгруппируйте по fio
 - count - агрегатная функция подсчета значений
 - выведите значения в виде: fio, количество прокатов(rental_id)

 explain analyse
with cte as (
	select concat(s.last_name, ' ', s.first_name) as st, r.rental_id, s.staff_id
	from staff s
	join rental r on r.staff_id = s.staff_id
)
select cte.st, count(cte.rental_id)
from cte 
group by cte.staff_id, cte.st

explain analyse
select cte.st, count(cte.rental_id)
from (select concat(s.last_name, ' ', s.first_name) as st, r.rental_id, s.staff_id
	from staff s
	join rental r on r.staff_id = s.staff_id ) cte
group by cte.staff_id, cte.st

with cte1 as (
	select concat(s.last_name, ' ', s.first_name) as st, s.staff_id
	from staff s
),
	cte2 as (
	select r.rental_id, r.staff_id
	from rental r
)
select cte1.st, count(cte2.rental_id)
from cte1 
join cte2 on cte2.staff_id = cte1.staff_id
group by cte1.staff_id, cte1.st

with cte as (
	select concat(s.last_name, ' ', s.first_name) as st, r.rental_id, s.staff_id
	from staff s
	join rental r on r.staff_id = s.staff_id
)
select cte.st, count(cte.rental_id)
from cte 
group by cte.staff_id, cte.st
union all
select cte.st, count(cte.rental_id)
from cte 
group by cte.staff_id, cte.st

2.1. Выведите фильмы, с категорией начинающейся с буквы "C"
* Создайте CTE:
 - Используйте таблицу category
 - Отфильтруйте строки с помощью оператора like 
* Соедините полученное табличное выражение с таблицей film_category
* Соедините с таблицей film
* Выведите информацию о фильмах:
title, category."name"

with all_we_want as 
	(select category_id, name
	from category 
	where name ilike 'c%')
select f.title, a.name
from all_we_want a
join film_category fc on fc.category_id = a.category_id
join film f on f.film_id = fc.film_id

 ============= общие табличные выражения (рекурсивные) =============
 
 3.Вычислите факториал
 + Создайте CTE
 * стартовая часть рекурсии (т.н. "anchor") должна позволять вычислять начальное значение
 *  рекурсивная часть опираться на данные с предыдущей итерации и иметь условие останова
 + Напишите запрос к CTE

with recursive r as (
	--якорь, стартовая часть
	select 1 as i, 1 as factorial
	union
	--рекурсивная часть
	select i + 1 as i, 
		factorial * (i + 1) as factorial
	from r 
	where i < 10
)
select *
from r

create table geo ( 
	id int primary key, 
	parent_id int references geo(id), 
	name varchar(1000) );

insert into geo (id, parent_id, name)
values 
	(1, null, 'Планета Земля'),
	(2, 1, 'Континент Евразия'),
	(3, 1, 'Континент Северная Америка'),
	(4, 2, 'Европа'),
	(5, 4, 'Россия'),
	(6, 4, 'Германия'),
	(7, 5, 'Москва'),
	(8, 5, 'Санкт-Петербург'),
	(9, 6, 'Берлин');

select * from geo

-- опасно для выполнения
with recursive r(a, b, c) as (
	select id, parent_id, name, 1 as level
	from geo 
	where id = 5
	union
	select r.a, r.b, r.c, level + 1 as level
	from geo
	join r on geo.parent_id = r.a
)
select *
from r

with recursive r(a, b, c) as (
	select id, parent_id, name, 1 as level
	from geo 
	where id = 2
	union
	select geo.id, geo.parent_id, geo."name", level + 1 as level
	from geo
	join r on geo.parent_id = r.a
)
select *
from r

with recursive r(a, b, c) as (
	select id, parent_id, name
	from geo 
	where id = 7
	union
	select geo.id, geo.parent_id, geo."name"
	from geo
	join r on geo.id = r.b
)
select *
from r
where b is null


create table test (
	date_event timestamp,
	field varchar(50),
	old_value varchar(50),
	new_value varchar(50)
)

insert into test (date_event, field, old_value, new_value)
values
('2017-08-05', 'val', 'ABC', '800'),
('2017-07-26', 'pin', '', '10-AA'),
('2017-07-21', 'pin', '300-L', ''),
('2017-07-26', 'con', 'CC800', 'null'),
('2017-08-11', 'pin', 'EKH', 'ABC-500'),
('2017-08-16', 'val', '990055', '100')

select * from test

select generate_series(1, 100, 5)

select generate_series(date('01/01/2021'), date('01/08/2021'), interval '5 days')

explain analyze
select
	gs::date as change_date,
	fields.field as field_name,
	case 
		when (
			select new_value 
			from test t 
			where t.field = fields.field and t.date_event = gs::date) is not null 
			then (
				select new_value 
				from test t 
				where t.field = fields.field and t.date_event = gs::date)
		else (
			select new_value 
			from test t 
			where t.field = fields.field and t.date_event < gs::date 
			order by date_event desc 
			limit 1) 
	end as field_value
from 
	generate_series((select min(date(date_event)) from test), (select max(date(date_event)) from test), interval '1 day') as gs, 
	(select distinct field from test) as fields
order by 
	field_name, change_date
	
explain analyze	
select
	distinct field, gs, first_value(new_value) over (partition by value_partition)
from
	(select
		t2.*,
		t3.new_value,
		sum(case when t3.new_value is null then 0 else 1 end) over (order by t2.field, t2.gs) as value_partition
	from
		(select
			field,
			generate_series((select min(date_event)::date from test), (select max(date_event)::date from test), interval '1 day')::date as gs
		from test) as t2
	left join test t3 on t2.field = t3.field and t2.gs = t3.date_event::date) t4
order by 
	field, gs
	
explain analyze
with recursive r(a, b, c) as (
    select temp_t.i, temp_t.field, t.new_value
    from 
	    (select min(date(t.date_event)) as i, f.field
	    from test t, (select distinct field from test) as f
	    group by f.field) as temp_t
    left join test t on temp_t.i = t.date_event and temp_t.field = t.field
    union all
    select a + 1, b, 
    	case 
    		when t.new_value is null then c
    		else t.new_value
		end
    from r  
    left join test t on t.date_event = a + 1 and b = t.field
    where a < (select max(date(date_event)) from test)
)    
SELECT *
FROM r
order by b, a

explain analyze
with recursive r as (
 	--стартовая часть рекурсии
 	 	select
 	     	min(t.date_event) as c_date
		   ,max(t.date_event) as max_date
	from test t
	union
	-- рекурсивная часть
	select
	     r.c_date+ INTERVAL '1 day' as c_date
	    ,r.max_date
	from r
	where r.c_date < r.max_date
 ),
t as (select t.field
		, t.new_value
		, t.date_event
		, case when lead(t.date_event) over (partition by t.field order by t.date_event) is null
			   then max(t.date_event) over ()
			   else lead(t.date_event) over (partition by t.field order by t.date_event)- INTERVAL '1 day'
		  end	  
			   as next_date
		, min (t.date_event) over () as min_date
		, max(t.date_event) over () as max_date	  
from (
select t1.date_event
		,t1.field
		,t1.new_value
		,t1.old_value
from test t1
union all
select distinct min (t2.date_event) over () as date_event --первые стартовые даты
		,t2.field
		,null as new_value
		,null as old_value
from test t2) t
)
select r.c_date, t.field , t.new_value
from r
join t on r.c_date between t.date_event and t.next_date
order by t.field,r.c_date

Sort  (cost=473.21..476.66 rows=1378 width=158) (actual time=0.254..0.256 rows=81 loops=1)
  Sort Key: t.field, r.c_date
  Sort Method: quicksort  Memory: 30kB
  CTE r
    ->  Recursive Union  (cost=13.00..15.96 rows=31 width=16) (actual time=0.017..0.043 rows=27 loops=1)
          ->  Aggregate  (cost=13.00..13.01 rows=1 width=16) (actual time=0.014..0.014 rows=1 loops=1)
                ->  Seq Scan on test t_1  (cost=0.00..12.00 rows=200 width=8) (actual time=0.009..0.009 rows=6 loops=1)
          ->  WorkTable Scan on r r_1  (cost=0.00..0.23 rows=3 width=16) (actual time=0.000..0.000 rows=1 loops=27)
                Filter: (c_date < max_date)
                Rows Removed by Filter: 0
  CTE t
    ->  WindowAgg  (cost=55.79..70.79 rows=400 width=182) (actual time=0.055..0.059 rows=9 loops=1)
          ->  WindowAgg  (cost=55.79..63.79 rows=400 width=166) (actual time=0.042..0.048 rows=9 loops=1)
                ->  Sort  (cost=55.79..56.79 rows=400 width=158) (actual time=0.040..0.040 rows=9 loops=1)
                      Sort Key: t_2.field, t_2.date_event
                      Sort Method: quicksort  Memory: 25kB
                      ->  Subquery Scan on t_2  (cost=0.00..38.50 rows=400 width=158) (actual time=0.003..0.023 rows=9 loops=1)
                            ->  Append  (cost=0.00..34.50 rows=400 width=190) (actual time=0.003..0.022 rows=9 loops=1)
                                  ->  Seq Scan on test t1  (cost=0.00..12.00 rows=200 width=362) (actual time=0.003..0.004 rows=6 loops=1)
                                  ->  Subquery Scan on "*SELECT* 2"  (cost=16.50..20.50 rows=200 width=190) (actual time=0.016..0.017 rows=3 loops=1)
                                        ->  HashAggregate  (cost=16.50..18.50 rows=200 width=190) (actual time=0.016..0.017 rows=3 loops=1)
                                              Group Key: min(t2.date_event) OVER (?), t2.field, NULL::text, NULL::text
                                              ->  WindowAgg  (cost=0.00..14.50 rows=200 width=190) (actual time=0.009..0.010 rows=6 loops=1)
                                                    ->  Seq Scan on test t2  (cost=0.00..12.00 rows=200 width=126) (actual time=0.002..0.003 rows=6 loops=1)
  ->  Nested Loop  (cost=0.00..314.62 rows=1378 width=158) (actual time=0.075..0.171 rows=81 loops=1)
        Join Filter: ((r.c_date >= t.date_event) AND (r.c_date <= t.next_date))
        Rows Removed by Join Filter: 162
        ->  CTE Scan on r  (cost=0.00..0.62 rows=31 width=8) (actual time=0.018..0.049 rows=27 loops=1)
        ->  CTE Scan on t  (cost=0.00..8.00 rows=400 width=166) (actual time=0.002..0.003 rows=9 loops=27)
Planning time: 0.300 ms
Execution time: 0.385 ms


============= представления =============

4. Создайте view с колонками клиент (ФИО; email) и title фильма, который он брал в прокат последним
+ Создайте представление:
* Создайте CTE, 
- возвращает строки из таблицы rental, 
- дополнено результатом row_number() в окне по customer_id
- упорядочено в этом окне по rental_date по убыванию (desc)
* Соеднините customer и полученную cte 
* соедините с inventory
* соедините с film
* отфильтруйте по row_number = 1

create view task_1 as 
	with cte as (
		select r.*, 
		row_number() over (partition by r.customer_id order by r.rental_date desc)
	from rental r 
	)
	select concat(c.last_name, ' ', c.first_name), c.email, f.title
	from cte 
	join customer c on c.customer_id = cte.customer_id
	join inventory i on cte.inventory_id = i.inventory_id
	join film f on f.film_id =i.film_id
	where cte.row_number = 1

explain analyse
select *
from task_1

4.1. Создайте представление с 3-мя полями: название фильма, имя актера и количество фильмов, в которых он снимался
+ Создайте представление:
* Используйте таблицу film
* Соедините с film_actor
* Соедините с actor
* count - агрегатная функция подсчета значений
* Задайте окно с использованием предложений over и partition by

create view task_2 as 
	select f.title, a.last_name, count(f.film_id) over (partition by a.actor_id)
	from film f
	join film_actor fa using(film_id)
	join actor a using(actor_id)
	
select *
from task_2 as t1, task_2 as t2, task_1

============= материализованные представления =============

5. Создайте матеиализованное представление с колонками клиент (ФИО; email) и title фильма, который он брал в прокат последним
Иницилизируйте наполнение и напишите запрос к представлению.
+ Создайте материализованное представление без наполнения (with NO DATA):
* Создайте CTE, 
- возвращает строки из таблицы rental, 
- дополнено результатом row_number() в окне по customer_id
- упорядочено в этом окне по rental_date по убыванию (desc)
* Соеднините customer и полученную cte 
* соедините с inventory
* соедините с film
* отфильтруйте по row_number = 1
+ Обновите представление
+ Выберите данные

create materialized view task_3 as 
	with cte as (
		select r.*, 
		row_number() over (partition by r.customer_id order by r.rental_date desc)
	from rental r 
	)
	select concat(c.last_name, ' ', c.first_name), c.email, f.title
	from cte 
	join customer c on c.customer_id = cte.customer_id
	join inventory i on cte.inventory_id = i.inventory_id
	join film f on f.film_id =i.film_id
	where cte.row_number = 1
with no data 

refresh materialized view task_3

explain analyze

select *
from task_3


5.1. Содайте наполенное материализованное представление, содержащее:
список категорий фильмов, средняя продолжительность аренды которых более 5 дней
+ Создайте материализованное представление с наполнением (with DATA)
* Используйте таблицу film
* Соедините с таблицей film_category
* Соедините с таблицей category
* Сгруппируйте полученную таблицу по category.name
* Для каждой группы посчитайте средню продолжительность аренды фильмов
* Воспользуйтесь фильтрацией групп, для выбора категории со средней продолжительностью > 5 дней
 + Выберите данные
 
create materialized view task_4 as 
	select avg(f.rental_duration)
	from film f
	join film_category fc using(film_id)
	join category c using(category_id)
	group by c.category_id
	having avg(f.rental_duration) > 5
with data

explain analyze

select *
from task_4

create function process_table_audit() returns trigger as $$
    begin 
   		if (TG_OP = 'DELETE') then 
       		insert into emp_audit select 'D', now(), user, old.*, TG_TABLE_NAME;
       	elsif (TG_OP = 'UPDATE') then 
           	insert into emp_audit select 'U', now(), user, new.*, TG_TABLE_NAME;
       	elsif (TG_OP = 'INSERT') then 
           	insert into emp_audit select 'I', now(), user, new.*, TG_TABLE_NAME;
       	end if;
       	return null; -- возвращаемое значение для триггера AFTER игнорируется
    end;
$$ language plpgsql;

create function process_table_audit(x int, out y int) as $$

create function process_table_audit(x int) returns set of as $$
	begin return .....

create trigger table_audit
after insert or update or delete on some_table
when условие 
for each row execute /*procedure*/ function process_table_audit();


explain analyze
select avg(f.rental_duration)
from film f
join film_category fc using(film_id)
join category c using(category_id)
group by c.category_id
having avg(f.rental_duration) > 5


Ссылка на сервис по анализу плана запроса https://explain.depesz.com/
 
https://habr.com/ru/post/203320/
 

