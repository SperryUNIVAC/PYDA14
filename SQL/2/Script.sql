/* вывод всех первичных ключей */ 
select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where Constraint_Type = 'PRIMARY KEY';

/* вывод всех неактивных покупателей, чего-то у нас вроде как все активны */ 
select * from "dvd-rental".customer where activebool = false; 

/* вывод всех фильмов 2006 года */ 
select * from "dvd-rental".film where release_year = 2006; 

/* вывод всех первичных ключей */ 
select * from  "dvd-rental".payment order by payment_date limit 10;



