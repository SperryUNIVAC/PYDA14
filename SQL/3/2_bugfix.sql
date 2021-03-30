set search_path to "dvd-rental"
/* ������������ �����. ���� ���� ������� ��� ��� ����� 2 �������� � 
 * � ���� ����� �������� � �� ������� - � �� ���� ��� ������ �������� */
SELECT
	customer.store_id,
	count(customer.store_id) AS customer_count
FROM
	"dvd-rental".customer
GROUP BY
	customer.store_id
HAVING
	count(customer.store_id) > 300;

/*����� ��������� ����� �� � ������ � � ������� ��� �� ����� ����������*/
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

/*��� ��� ������� ��� ��������������� ��������.*/
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

