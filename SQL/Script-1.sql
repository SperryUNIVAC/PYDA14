set search_path to "dvd-rental" -- ���������� ��������� � �� �� ���������


	
-- CTRL + SHIFT + F �������� � ������������ ��������������
-- � ���������� �������� ������ ����������, ���� ��� ��������� ����������
-- round(   , 2) ���������� �� 2 �����
-- order by 1, 2 desc  ��������� 1�� �������, ����� �������� �� �����������
-- offset 1300 ������� � ������� 1299
-- limit 5 ������ 5
select round(1::numeric /2, 2) --���������� ���������� � ����������� ����
/* ���������� ����������� ������ � select
 * ��� ���� ������� ���������� ����� ������
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
 * � ����� �������� �� �� ��� ������ � ��� ������ �� ���������, ��� ���� ��� �� ��������� ��� ��� ���� ���
 * ��� �� ���������
 * 
 * � ���� � ���������� ���� ��������� (��� ��������� ����� ����������� ��� �����), �� ��������� ������ � ����-�� 
 * �� ����� ������ ����� ������������ ���������
 * */

SELECT
	customer_count
FROM
	(
	SELECT
		customer.store_id,
		count(customer.store_id) AS customer_count
	FROM
		customer  -- ������� ��������� ����� �������� ���� � ����� ������, ������ ��� �� ���� ������ "dvd-rental" ����� customer
	GROUP BY
		customer.store_id) AS cust_coun
WHERE
	cust_coun.customer_count > 300;
-- ��� ��� ��� � ����

--� ������ �������.�������
--� ���� �����.�������

--concate(1, 2) ������ 2 �������

/* ����� �������� ���� ��� ������ � ��� ������
 * �������� � ������� ��� ������ "�������"
 * � ����� � ���� ������� �� ������� ������ �� ������ � ������� ������� ����� ������������� ��������
 * � ���� ����� -������� ������������ �� ������������ �����, ��������
 * where cast(rating as text) like 'PG%'
 * ��� �����������
 * where rating::text like 'PG%'
 * ��� ���
 * where rating::text like 'PG%' and lenght(rating::text) = 5
 * ilike �� ������� �� �������� 
 * ������ ��� ����� ����� pg_typeoff(�������)
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
	

 -- ��� ��� ������� ����� - ��� ����� �����

-- ��������� �������� ������ ������������ � ������� � �������

select 
	customer.store_id,
	count(customer.store_id) as customer_count,
	s.first_name as stuff_name,
	s.last_name as stuff_surname
from customer 
-- ���� ����� ����������� ���������� �����
right join staff as s on customer.store_id = s.store_id 
-- ���� ���� ������ � ����������� ��� ��������� ��� ����������� ����������!!!
right join staff as s on customer.store_id = s.store_id
-- ��� ������ ��� �������!!!!!!!!!
group by customer.store_id, s.first_name, s.last_name -- ��� ��� ����� � ������� ������ ���� 
-- ������� � ���, ������ ��� ����� ������ �� ����������
-- �� ��� �� ��������� ���� �� ������ ������� � ������� � �� ��� ��� ������ 
-- � ������� ���� customer.store_id �� ��������� ��������
-- ��� �� ��� �������� ���� ������������ ����������, � �� �����������
-- !!! � ��� ����� � ����������� ������� ���� ��������� ���� � ��� ����� ���� �������� (���� ������ �����.�����������)


select 
	customer.store_id,
	count(customer.store_id) as customer_count,
	s.first_name as stuff_name,
	s.last_name as stuff_surname,
	st.city as store_city
from customer 
join staff as s using(store_id) -- ������ ����� �������� ����������� � on �� using
join address as a on s.address_id = a.address_id 
join city as st on a.city_id = st.city_id 
group by customer.store_id, s.first_name, s.last_name, st.city
having count(customer.store_id) > 300;


/* ������� ������ ����� �������� � �����
 * select
 *     case
 *        when ������� then �����
 *        when ������� then �����  
 *        else ������� ��� ���
 *     end	 
 */
 
/* ��� ���� �������� union
 * select ...
 * union
 * select ...
 * ������ ������ ������ �������� �� 1�� ������� � �������������� 
 * ������ ������� �� ������� ������� ���� ��� �� ��������� 
 * 
 * union all ������� 2 ������ ��� ����������� �� �������
 * ��� ���� ��������� ������ �����������
 * except ��������� �����-�� ������ �� �������
 * 
 */

select f.title 
from film as f
join film_actor fa using(film_id)
-- where ����������� �� �����������
group by film_id 
having count(fa.actor_id) >10 
-- having ����� �����������


