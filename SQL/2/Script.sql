/* ����� ���� ��������� ������ */ 
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where Constraint_Type = 'PRIMARY KEY';

/* ����� ���� ���������� �����������, ����-�� � ��� ����� ��� ��� ������� */ 
select * from "dvd-rental".customer where activebool = false; 

/* ����� ���� ������� 2006 ���� */ 
select * from "dvd-rental".film where release_year = 2006; 

/* ����� ���� ��������� ������ */ 
select * from  "dvd-rental".payment order by payment_date limit 10;



