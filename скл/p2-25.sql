1. Получите атрибуты id фильма, название, описание, год релиза из таблицы фильмы.
Переименуйте поля так, чтобы все они начинались со слова Film (FilmTitle вместо title и тп)
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- as - для задания псевдонимов 

select film_id, title, description, release_year
from film 

select
	film_id as "FilmFilm_id",
	title "FilmTitle",
	description as "FilmDdescription",
	release_year "год выпуска фильма"
from
	film 

2. В одной из таблиц есть два атрибута:
rental_duration - длина периода аренды в днях  
rental_rate - стоимость аренды фильма на этот промежуток времени. 
Для каждого фильма из данной таблицы получите стоимость его аренды в день

- используйте ER - диаграмму, чтобы найти подходящую таблицу
- стоимость аренды в день - отношение rental_rate к rental_duration

select title, rental_rate / rental_duration
from film

select title, rental_duration * rental_rate,
	rental_duration / rental_rate,
	rental_duration + rental_rate,
	rental_duration - rental_rate
from film

2* В полученной таблице задайте вычисленному столбцу псевдоним cost_per_day

- as - для задания синонимов 

select title, rental_rate / rental_duration  as cost_per_day
from film

select title, round(rental_rate / rental_duration, 2)  as cost_per_day
from film

select round(1::numeric / 2, 2) --numeric, decimal

3.1 Отсортировать список фильмов по убыванию стоимости за день аренды (п.2)

- используйте order by (по умолчанию сортирует по возрастанию)
- desc - сортировка по убыванию

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film
order by cost_per_day desc

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film
order by round(rental_rate / rental_duration, 2) desc

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film
order by 2 desc

3.1* Отсортируйте таблицу платежей по возрастанию суммы платежа (amount)

- используйте ER - диаграмму, чтобы найти подходящую таблицу
- используйте order by 
- asc - сортировка по возрастанию 

select payment_id, amount, payment_date
from payment 
order by amount

select payment_id, amount, payment_date
from payment 
order by amount, payment_id desc

3.2 Вывести топ-10 самых дорогих фильмов по стоимости за день аренды
- используйте limit

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film
order by 2 desc
limit 10

3.3 Вывести топ-5 самых дорогих фильмов по стоимости аренды за день, начиная с 4-ой позиции
- воспользуйтесь Limit и offset

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film
order by 2 desc
limit 10
offset 57

3.3* Вывести топ-15 самых низких платежей, начиная с позиции 14000
- воспользуйтесь Limit и Offset

select payment_id, amount
from payment 
order by 2
offset 13999
limit 15

4. Вывести все уникальные годы выпуска фильмов
- воспользуйтесь distinct

select distinct release_year
from film 

4* Вывести уникальные имена покупателей

- используйте ER - диаграмму, чтобы найти подходящую таблицу
- воспользуйтесь distinct

select distinct first_name
from customer

select count(distinct first_name)
from customer 

==========

логический порядок

FROM
ON
JOIN
WHERE
GROUP BY
WITH CUBE или WITH ROLLUP
HAVING
SELECT <-- объявляем алиасы (псевдонимы)
DISTINCT
ORDER by

select t.ry
from (
select f.title, f.release_year as ry
from film f) as t

название_схемы.название_таблицы --from
название_таблицы.название_столбца --select

select film.title
from "dvd-rental".film

==========

5.1. Вывести весь список фильмов, имеющих рейтинг 'PG-13', в виде: "название - год выпуска"

- используйте ER - диаграмму, чтобы найти подходящую таблицу
- "||" - оператор конкатенации 
- where - конструкция фильтрации
- "=" - оператор сравнения

select title, release_year, rating
from film
where rating = 'PG-13'

select title || ' - ' || release_year, rating
from film
where rating = 'PG-13'

select concat(title, ' - ', release_year), rating
from film
where rating = 'PG-13'

select concat('Hello', null, 'world!')

select 'Hello' || null || 'world!'

5.2 Вывести весь список фильмов, имеющих рейтинг, начинающийся на 'PG'

- cast(название столбца as тип) - преобразование
- like - поиск по шаблону
- ilike - регистронезависимый поиск

select title, rating
from film

select title, rating
from film
where cast(rating as text) like 'PG%'

select title, rating
from film
where rating::text like '__-%'

select title, rating
from film
where rating::text like '__'

select 'A''B'

select regexp_match('hello', '.e.')

select title, rating
from film
where rating::text like '%PG%' and length(rating::text) = 5

select title, rating
from film
where rating::text ilike '%pg%'

select title, rating
from film
where upper(rating::text) like '%PG%'

select title, rating
from film
where lower(rating::text) like '%pg%'

select *
from film
where release_year is not null -- is null

select title
from film
where rating::text like 'PG-13'

5.2* Получить информацию по покупателям с именем содержашим подстроку'jam' (независимо от регистра написания), в виде: "имя фамилия" - одной строкой.

- "||" - оператор конкатенации
- where - конструкция фильтрации
- ilike - регистронезависимый поиск

create index aa on customer(lower(first_name))

explain analyze
select concat(last_name, ' ', first_name)
from customer
where first_name ilike '%jam%'

select strpos('Hello world!', 'world')

select character_length('Hello world!')

select overlay('Hello world!' placing 'Petr' from 7 for 5)

select position('world' in 'Hello world!')

select overlay('Hello world!' placing 'Petr' from (select position('world' in 'Hello world!')) for 5)

6. Получить id покупателей, арендовавших фильмы в срок с 27-05-2005 по 28-05-2005 включительно

- используйте ER - диаграмму, чтобы найти подходящую таблицу
- between - задает промежуток (аналог ... >= ... and ... <= ...)

select customer_id, rental_id, rental_date
from rental
where rental_date between '27-05-2005 00:00:00' and '28-05-2005'::date + interval '1 day'
order by rental_date desc

select customer_id, rental_id, rental_date
from rental
where rental_date >= '27-05-2005' and rental_date <= '28-05-2005' -- '2005-05-27'
order by rental_date desc

select '28/02/2020'::date + interval '10 year' + interval '125 days'

select customer_id, rental_id, rental_date
from rental
where date(rental_date) between '27-05-2005' and '28-05-2005'
order by rental_date desc

6* Вывести платежи поступившие после 30-04-2007

- используйте ER - диаграмму, чтобы найти подходящую таблицу
- > - строгое больше (< - строгое меньше)

select payment_id, amount, payment_date
from payment
where date(payment_date) > '30-04-2007'

select extract(day from payment_date),
	extract(week from payment_date),
	extract(month from payment_date),
	extract(year from payment_date),
	payment_date
from payment

select date_trunc('day', payment_date),
	date_trunc('week', payment_date),
	date_trunc('month', payment_date),
	date_trunc('year', payment_date)
from payment

select extract(epoch from payment_date)
from payment 

select now()

create function foo10 (x int, y int, out z numeric) as $$
begin
	select power(x,y) into z;
end;$$
language plpgsql

select foo10(2,3)