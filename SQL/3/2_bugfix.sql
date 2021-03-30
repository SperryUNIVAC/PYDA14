set search_path to "dvd-rental"
/* классический метод. Меня дико смутило что там всего 2 магазина и 
 * я чето очень протупил и не вдуплил - а из чего там вообще выбирать */
SELECT
	customer.store_id,
	count(customer.store_id) AS customer_count
FROM
	"dvd-rental".customer
GROUP BY
	customer.store_id
HAVING
	count(customer.store_id) > 300;

/*стало интересно понял ли я логику и я написал это же через подзапросы*/
SELECT
	customer_count
FROM
	(
	SELECT
		customer.store_id,
		count(customer.store_id) AS customer_count
	FROM
		"dvd-rental".customer
	GROUP BY
		customer.store_id) AS cust_coun
WHERE
	cust_coun.customer_count > 300;

/*уфф еле вдуплил как последовательно джойнить.*/
SELECT
	cs.customer_id,
	cs.first_name,
	cs.last_name,
	ad.address,
	ad.district,
	ct.city,
	cn.country
FROM
	"dvd-rental".customer AS cs
JOIN "dvd-rental".address AS ad ON
	cs.address_id = ad.address_id
JOIN "dvd-rental".city AS ct ON
	ad.city_id = ct.city_id
JOIN "dvd-rental".country AS cn ON
	ct.country_id = cn.country_id;	
	
/*со следующими у меня возникла проблема
 * я понятия не имею как вобще работает логика операторов в SQL ((
 * в нормальном языке программирования я создаю переменную 1 даю ей имя А
 * создаю переменную 2 даю ей имя Б
 * создаю переменную А+Б даю ей имя С
 * я не могу понять подобное применимо к SQL
 * вот я создал джойнами таблицу, прекрасно
 * как мне теперь передать результат этой работы в функцию count??
 * ну я могу извратится сделать это через подзапрос, но он выдал мне батарею ошибок и я никак не могу врубится 
 * в правильный синтаксис этого подзапроса
 * 
 * вообще это какой-то извращенный гибрид стекового и функционального языка
 * я в его парадигму не могу врубится поэтому я даже не понимаю 
 * в какой последовательности работают эти несчастные операторы
 * ну базовая конструкция очевидна 
 * ВЫБРАТЬ фигню ИЗ другой фигни ГДЕ фигня больше 5 ПОКАЗАТЬ 3 последних фигни ПО УБЫВЫАНИЮ фигней
 * а вот как это склетить с второй такой же логической цепочкой - я реально в саму идею врубится не могу
 * */


SELECT
	cs.store_id,
	sf.first_name,
	sf.last_name,
	ct.city
FROM
	"dvd-rental".customer AS cs
JOIN "dvd-rental".store AS st ON
	cs.store_id = st.store_id
JOIN "dvd-rental".staff AS sf ON
	cs.store_id = sf.store_id
JOIN "dvd-rental".address AS ad ON
	sf.address_id = ad.address_id
JOIN "dvd-rental".city AS ct ON
	ad.city_id = ct.city_id

