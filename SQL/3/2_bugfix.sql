/* ������������ �����. ���� ���� ������� ��� ��� ����� 2 �������� � 
 * � ���� ����� �������� � �� ������� - � �� ���� ��� ������ �������� */
select 
	customer.store_id,
	count(customer.store_id) as customer_count
from "dvd-rental".customer
group by customer.store_id
having count(customer.store_id) > 300;

/*����� ��������� ����� �� � ������ � � ������� ��� �� ����� ����������*/
select 
	customer_count
from (select 
		customer.store_id,
		count(customer.store_id) as customer_count
	from "dvd-rental".customer
	group by customer.store_id)
as cust_coun
where cust_coun.customer_count > 300;

/*��� ��� ������� ��� ��������������� ��������.*/
select 
	cs.customer_id,
	cs.first_name, 
	cs.last_name,
	ad.address,
	ad.district,
	ct.city,
	cn.country
from "dvd-rental".customer as cs
join "dvd-rental".address as ad 
	on cs.address_id = ad.address_id	
join "dvd-rental".city as ct 
	on ad.city_id = ct.city_id
join "dvd-rental".country as cn
	on ct.country_id = cn.country_id;	
	
/*�� ���������� � ���� �������� ��������
 * � ������� �� ���� ��� ����� �������� ������ ���������� � SQL ((
 * � ���������� ����� ���������������� � ������ ���������� 1 ��� �� ��� �
 * ������ ���������� 2 ��� �� ��� �
 * ������ ���������� �+� ��� �� ��� �
 * � �� ���� ������ �������� ��������� � SQL
 * ��� � ������ �������� �������, ���������
 * ��� ��� ������ �������� ��������� ���� ������ � ������� count??
 * �� � ���� ���������� ������� ��� ����� ���������, �� �� ����� ��� ������� ������ � � ����� �� ���� �������� 
 * � ���������� ��������� ����� ����������
 * 
 * ������ ��� �����-�� ����������� ������ ��������� � ��������������� �����
 * � � ��� ��������� �� ���� �������� ������� � ���� �� ������� 
 * � ����� ������������������ �������� ��� ���������� ���������
 * �� ������� ����������� �������� 
 * ������� ����� �� ������ ����� ��� ����� ������ 5 �������� 3 ��������� ����� �� ��������� ������
 * � ��� ��� ��� �������� � ������ ����� �� ���������� �������� - � ������� � ���� ���� �������� �� ����
 * */


select 
	cs.store_id,
	sf.first_name, 
	sf.last_name,
	ct.city
from "dvd-rental".customer as cs
join "dvd-rental".store as st 
	on cs.store_id = st.store_id	
join "dvd-rental".staff as sf
	on	cs.store_id = sf.store_id
join "dvd-rental".address as ad 
	on sf.address_id = ad.address_id	
join "dvd-rental".city as ct 
	on ad.city_id = ct.city_id

