set search_path to "dvd-rental" -- установить обращение к БД по умолчанию


	
-- CTRL + SHIFT + F приводит к стандартному форматированию
-- в подзапросе доступны только псевдонимы, типа как локальные переменные
-- round(   , 2) округление до 2 знака
-- order by 1, 2 desc  сортровка 1го столбца, потом второрго по возрастанию
-- offset 1300 начиная с позиции 1299
-- limit 5 первые 5
select round(1::numeric /2, 2) --корректное округление с привелением типа
/* псевдонимы объявляются только в select
 * при этом порядок выполнения такой всегда
 * from
 * on
 * join
 * where
 * group by
 * with
 * hawing
 * SELECT !!!
 * distinc
 * order by
 * в итоге несмотря на то что селект у нас первый по написанию, что бывы там не понабрали все что выше его
 * это не воспримет
 * 
 * а если в подзапросе есть псевдоним (сам подзапрос тодже обязательно его имеет), то обратится сверху к чему-то 
 * мы можем только через подзапросный псевдоним
 * */

SELECT
	customer_count
FROM
	(
	SELECT
		customer.store_id,
		count(customer.store_id) AS customer_count
	FROM
		customer  -- выбрать дефолтную схему работает даже в таком случае, теперь тут не надо писать "dvd-rental" перед customer
	GROUP BY
		customer.store_id) AS cust_coun
WHERE
	cust_coun.customer_count > 300;
-- вот это оно и есть

--в селект таблица.столбец
--в фром схема.таблица

--concate(1, 2) склеит 2 столбца

/* можно объявить свой тип данных и это удобно
 * допустим я объявил тип данных "рейтинг"
 * в итоге я могу выбрать из таблицы только те фильмы у которых рейтинг равен определенному значению
 * и даже круче -рейтинг начинающийся на определенную букву, например
 * where cast(rating as text) like 'PG%'
 * или приведением
 * where rating::text like 'PG%'
 * или так
 * where rating::text like 'PG%' and lenght(rating::text) = 5
 * ilike не зависит от регистра 
 * узнать тип можно выбор pg_typeoff(столбец)
 *  */



select
	customer.store_id,
	count(customer.store_id) as customer_count
from
	"dvd-rental".customer
group by
	customer.store_id
having
	count(customer.store_id) > 300;
	

 -- там где обычный джойн - это иннер джойн

-- попробуем написать запрос одновременно с джойном и каунтом

select 
	customer.store_id,
	count(customer.store_id) as customer_count,
	s.first_name as stuff_name,
	s.last_name as stuff_surname
from customer 
-- сюда можно попробовать подпихнуть джойн
right join staff as s on customer.store_id = s.store_id 
-- надо было просто в группировку все подсунуть для корректного завершения!!!
right join staff as s on customer.store_id = s.store_id
-- вот теперь все заебись!!!!!!!!!
group by customer.store_id, s.first_name, s.last_name -- все что стоит в селекте должно быть 
-- указано и тут, потому что иначе запрос не отработает
-- но это не сработает если мы должны вывести в селекте и то что уже входит 
-- в счетчик типа customer.store_id по очевидным причинам
-- что бы это забороть надо использовать подзапросы, а не группировку
-- !!! а еще можно в группировке указать один первичный ключ и все будет тоже работать (надо курить функц.зависимости)


select 
	customer.store_id,
	count(customer.store_id) as customer_count,
	s.first_name as stuff_name,
	s.last_name as stuff_surname,
	st.city as store_city
from customer 
join staff as s using(store_id) -- иногда можно заменить конструкцию с on на using
join address as a on s.address_id = a.address_id 
join city as st on a.city_id = st.city_id 
group by customer.store_id, s.first_name, s.last_name, st.city
having count(customer.store_id) > 300;


/* сложное уловие можно записать в стиле
 * select
 *     case
 *        when условие then вывод
 *        when условие then вывод  
 *        else вывести чет еще
 *     end	 
 */
 
/* еще есть оператор union
 * select ...
 * union
 * select ...
 * итогом станет строки запросов из 1го селекта и пристыкованные 
 * строки запроса из второго селекта если они не совпадают 
 * 
 * union all выведет 2 строки вне зависимости от запроса
 * при этом типизация должна соблюдаться
 * except исключает какие-то строки из запроса
 * 
 */

select f.title 
from film as f
join film_actor fa using(film_id)
-- where срабатывает до группировки
group by film_id 
having count(fa.actor_id) >10 
-- having после группировки


