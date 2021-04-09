
======================== �������� ������ ========================

create database ��������_����

create schema lecture_4

set search_path to lecture_4

1. �������� ������� "�����" � ������:
- id 
- ���
- ��������� (����� �� ����)
- ���� ��������
* ����������� 
    CREATE TABLE table_name (
        column_name TYPE column_constraint,
    );
* ��� id �������� serial, ����������� primary key
* ��� � ���� �������� - not null
* ��������� - ����������� ���

create table author (
	id serial primary key,
	author_name varchar(50) not null unique, 
	nick_name varchar(50),
	born_date date not null,
	create_date timestamp default now()
)


1*  �������� ������� "������������" � ������: id ������������, ���, ��������, id ������
* ��� id ������������ �������� serial, ����������� primary key
* �������� - not null
* ��� > 0 CHECK (��� > 0)
* id ������ ���� �������� ��� �����������

create table books (
	id serial primary key,
	book_name varchar(100) not null, 
	book_year int2 check (book_year between 1000 and 2100) not null, --inn varchar(12) check (length(inn) = 12)
	author_id int2
)

create table books (
	id serial primary key,
	book_name varchar(100) not null, 
	book_year int2 check (book_year between 1000 and 2100) not null, --inn varchar(12) check (length(inn) = 12)
	author_id int2 references author(id)
)

======================== ���������� ������� ========================

2. �������� ������ �� 3-� ����� ��������� � ������� �������:
���� �������� ����, 08.02.1828
������ ������� ���������, ��. ���������, 03.10.1814
������ ��������, 12.01.1949
* ����� ��������� ��������� ����� ������������:
    INSERT INTO table (column1, column2, �)
    VALUES
     (value1, value2, �),
     (value1, value2, �) ,...;

select * from author a

insert into author (author_name, nick_name, born_date)
values ('���� �������� ����', null, '08.02.1828'),
	('������ ������� ���������', '��. ���������', '03.10.1814'),
	('������ ��������', null, '12.01.1949')

null !== ''     
	
2. �������� ������ �� 5-� ����� �������������, id ������ - ��������� NULL:
�������� ����� ��� ��� �����, 1916
��������, 1837
����� ������ �������, 1840
���������� ���, 1980
������� �������� �����, 1994

insert into books (book_name, book_year)
select unnest(array['�������� ����� ��� ��� �����','��������','����� ������ �������',
	'���������� ���','������� �������� �����']),
	unnest(array[1916, 1837, 1840, 1980, 1994])
	
insert into books (book_name, book_year)
values ('����� ������', 1916)
	
select * from books b	

insert into books (
from "dvd-rental".film fbook_name, book_year)
select f.title, f.release_year

delete from books

SELECT setval('books_id_seq', 1)

select * from books_id_seq

alter sequence books_id_seq restart with 1

======================== ����������� ������� ========================


3. �������� ���� "����� ��������" � ������� � ��������
* ALTER TABLE table_name 
  ADD COLUMN new_column_name TYPE;
 
 select * from author a
 select * from books b	
 
alter table author add column born_place varchar(50) 

alter table author alter column born_place set not null
 
 3* � ������� ������������ �������� ������� id ������ - ������� ���� - ������ �� �������
 * ALTER TABLE table_name ADD CONSTRAINT constraint_name constraint_definition
 
alter table books add constraint books_author_fkey 
	foreign key (author_id) references author(id)
 
 select * from author a;
 select * from books b	

 ======================== ����������� ������ ========================

4. �������� ������, ��������� ���������� ����� ��������
��������:
���� �������� ���� - �������
������ ������� ��������� - ���������� �������
������ �������� - ������
* UPDATE table
  SET column1 = value1,
   column2 = value2 ,...
  WHERE
   condition;

select * from author a;

update author
set born_place = '�������'
where id = 1

update author
set born_place = '���������� �������'
where id = 2

update author
set born_place = '������'
where id = 3

4*. � ������� ������������ ���������� id �������:

���� �������� ����: 
    �������� ����� ��� ��� �����
������ ������� ���������: 
    ��������
    ����� ������ �������
������ ��������:
    ���������� ���
    ������� �������� �����

select * from books b	
    
update books
set author_id = 1
where id = 1

update books
set author_id = 2
where id in (7,8)

update books
set author_id = (select id from author where author_name = '������ ��������')
where id in (9,10)
 
 ======================== �������� ������ ========================
 
 5. ������� ������������ " �������� ����� ��� ��� �����"

delete from books 
where id = 1

delete from books 

select * from books b

5.1 ������� ������ 

delete from author 
where id = 2

select * from author a

truncate author cascade

drop table author

drop schema lecture_4

drop database

select alm_sales_amount1('2007-02-17', '2007-02-20')

create trigger update_rental_date
before update on rental
for each row execute procedure update_last_rental_date();

create table test (
	id serial
)

select * from test333

insert into test333 (id)
values (1), (2)

update test333
set id = 5
where id = 1

create function f5 (out x numeric) as $$
begin 
	select count(*) from test333 into x;
end;
$$ language plpgsql

select f5()

alter table test333 add column last_update timestamp

alter table test333 rename to test222

create trigger last_updated before
update
    on
    "dvd-rental".test for each row execute procedure "dvd-rental".last_updated()

 ======================================================= ������� ���� ������ =======================================================
 
 ======================== json ========================
 �������� ������� orders
 
CREATE TABLE orders (
     ID serial PRIMARY KEY,
     info json NOT NULL
);

INSERT INTO orders (info)
VALUES
 (
'{ "customer": "John Doe", "items": {"product": "Beer","qty": 6}}'
 ),
 (
'{ "customer": "Lily Bush", "items": {"product": "Diaper","qty": 24}}'
 ),
 (
'{ "customer": "Josh William", "items": {"product": "Toy Car","qty": 1}}'
 ),
 (
'{ "customer": "Mary Clark", "items": {"product": "Toy Train","qty": 2}}'
 );
 
select * from orders

INSERT INTO orders (info)
VALUES
 (
'{ "a": { "a": { "a": { "a": { "a": { "c": "b"}}}}}}'
 )
 
|{��������_������: quantity, product_id: quantity, product_id: quantity}|����� ����� ������|


6. �������� ����� ���������� �������:
* CAST ( data AS type) �������������� �����
* SUM - ���������� ������� �����
* -> ���������� JSON
*->> ���������� �����

select pg_typeof(info->'items'->'qty')
from orders

select pg_typeof(info->'items'->>'qty')
from orders

select sum((info->'items'->>'qty')::numeric)
from orders

select info->'a'->'a'->'a'->'a'->'a'->>'c'
from orders

6*  �������� ������� ���������� �������, ��������� ������������ �� "Toy"

select avg((info->'items'->>'qty')::numeric)
from orders
where info->'items'->>'product' ilike 'toy%'

======================== array ========================
7. �������� ������� ��� ����������� ����������� ������� (special_features) �
������ -- ������� ��������� �������� ������� special_features
* array_length(anyarray, int) - ���������� ����� ��������� ����������� �������

'a,b,c,d,d,d'
['a','b','c','d','d','d']

select title, special_features
from film 

select title, array_length(special_features, 1), special_features
from film 

select array_length('{{1,2,3,4,5},{1,2,3,4,5},{1,2,3,4,5}}'::text[], 1)

select array_length('{{1,2,3,4,5},{1,2,6,4,5},{1,2,3,4,5}}'::text[], 2)

select cardinality('{{1,2,3,4,5},{1,2,3,4,5},{1,2,3,4,5}}'::text[])

array_length ���������� ����� ��������� � ��������� ����������� �������:

select f.title, cardinality (f.special_features) as "����������"
from film f

cardinality ���������� ����� ����� ��������� ������� �� ���� ����������. 
���������� ��� ����� �����, ������� ����� ������� unnest:

7* �������� ��� ������ ���������� ����������� ��������: 'Trailers','Commentaries'
* ����������� ���������:
@> - ��������
<@ - ���������� �
*  ARRAY[��������] - ��� �������� �������

https://postgrespro.ru/docs/postgresql/12/functions-subquery
https://postgrespro.ru/docs/postgrespro/12/functions-array

-- ������ �������� --
explain analyze
select title, special_features
from film
where special_features::text ilike '%Trailers%' or special_features::text ilike '%Commentaries%'

select title, special_features
from film
where special_features[1] = 'Trailers' or special_features[1] = 'Commentaries' or
	special_features[2] = 'Trailers' or special_features[2] = 'Commentaries' or
	special_features[3] = 'Trailers' or special_features[3] = 'Commentaries' or
	special_features[4] = 'Trailers' or special_features[4] = 'Commentaries' 

-- ���-�� ������� �������� --
explain analyze
select title, string_agg(usf, ', ')
from (
	select film_id, title, unnest(special_features) usf
	from film) as t
where t.usf = 'Trailers' or t.usf = 'Commentaries'
group by film_id, title

-- ������� �������� --
explain analyze
select title, special_features, array_position(special_features, 'Trailers')
from film
where array_position(special_features, 'Trailers') is not null or 
	array_position(special_features, 'Commentaries') is not null
	
select title, special_features, array_positions(special_features, 'Trailers')
from film
where cardinality(array_positions(special_features, 'Trailers')) > 0 or 
	cardinality(array_positions(special_features, 'Commentaries')) > 0 

select array_positions('{1,2,1,4,1}'::text[], '1')

explain analyze
select title, special_features
from film
where 'Trailers' = any(special_features) or 'Commentaries' = any(special_features) --any = some

select title, special_features
from film
where 'Trailers' = all(special_features) or 'Commentaries' = all(special_features) 

explain analyze
select title, special_features
from film
where  special_features @> array['Trailers'] or special_features @> array['Commentaries'] 

select title, special_features
from film
where  special_features <@ array['Trailers'] or special_features <@ array['Commentaries'] 
	or special_features <@ array['Trailers', 'Commentaries']

explain analyze
select title, special_features
from film
where  special_features && array['Trailers'] or special_features && array['Commentaries'] 