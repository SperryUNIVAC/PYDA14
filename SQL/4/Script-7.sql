create schema ELC;

set search_path to ELC

create table ethnic_gr (
	ethnic_id serial primary key,
	ethnic_group varchar unique not null);

create table language_gr (
	language_id serial primary key,
	language_group varchar unique not null);

create table country_gr (
	country_id serial primary key,
	country_group varchar unique not null);

insert into ethnic_gr (ethnic_group) 
values
('Balkars'),
('Finns'),
('Mari'),
('Livonians'),	
('Nokhchiy'),
('Basques'),
('Ashkenazim'),
('Roma'),
('Jenische'),
('Circassians'),
('Faroe'),
('Sicilian'),
('Frisians'),
('S?mi'),
('Welsh'),
('Manx'),
('Walloons'),
('Crimeans'),
('Romansch'),
('Galician'),
('Montenegrins');

insert into language_gr (language_group) 
values 
('Karachay-Balkar'),
('Finnish'),
('Mari'), 
('Russian'),
('Latvian'), 
('Livonian'),	
('Chechen'), 
('Basque'),
('Yiddish'), 
('Hebrew'), 
('English'),
('Romani'),
('Yenish'),
('Circassian'),
('Faroese'),
('Sicilian'),
('Frisian'),
('Saami'),
('Welsh'),
('Manx'),
('Belgian French'), 
('French'),
('Crimeans'),
('Turkish'),
('Romansch'),
('Galician'),
('Shtokavian'),
('Spanish'),
('German'),
('Ukrainian'),
('Hungarian'),
('Romanian'),
('Portuguese'),
('Bulgarian'),
('Italian'),
('Greek'),
('Slovak'),
('Persian'),
('Danish'),
('Greenlandic'),
('Bokm?l'),
('Nynorsk');


insert into country_gr (country_group) 
values 
('Russia'),
('Finland'),
('United States'), 
('Canada'), 
('Latvia'), 
('Estonia'),
('Turkey'), 
('Kazakhstan'),
('Spain'), 
('Brazil'),
('Romania'),
('France'),
('Bulgaria'),
('Hungary'),
('Argentina'),	
('United Kingdom'),
('Serbia'),
('Italy'),
('Greece'),
('Germany'),
('Slovakia'),
('Iran'),
('North Macedonia'),
('Sweden'),
('Ukraine'),
('Portugal'),
('Israel'), 
('Australia'), 
('South Africa'), 
('Belarus'), 
('Chile'),
('Austria'), 
('Switzerland'), 
('Luxembourg'), 
('Belgium'),
('Syria'), 
('Jordan'), 
('Denmark'),
('Norway'),
('Netherlands'), 
('Montenegro'); 


create table ethnic_language (
	ethnic_group varchar not null,
	language_id int2 references language_gr(language_id));

create table ethnic_country (
	ethnic_group varchar not null,
	country_id int2 references country_gr(country_id));
	
insert into 
ethnic_language (ethnic_group, language_id) 
values 
('Balkars', 1),
('Balkars', 4),
('Finns', 2),
('Finns', 4),
('Finns', 11),
('Mari', 3),
('Mari', 4),
('Livonians', 4),
('Livonians', 5),
('Livonians', 6),
('Nokhchiy', 7),
('Nokhchiy', 4),
('Nokhchiy', 24),
('Basques', 8),
('Basques', 28),
('Ashkenazim', 11),
('Ashkenazim', 9),
('Ashkenazim', 10),
('Ashkenazim', 4),
('Ashkenazim', 28),
('Ashkenazim', 22),
('Ashkenazim', 29),
('Ashkenazim', 30),
('Ashkenazim', 31),
('Ashkenazim', 32),
('Ashkenazim', 33),
('Roma', 11),
('Roma', 4),
('Roma', 12),
('Roma', 33),
('Roma', 28),
('Roma', 24),
('Roma', 22),
('Roma', 31),
('Roma', 34),
('Roma', 27),
('Roma', 35),
('Roma', 36),
('Roma', 37),
('Roma', 38),
('Roma', 29),
('Roma', 30),
('Jenische', 13),
('Jenische', 22),
('Jenische', 29),
('Circassians', 14),
('Circassians', 4),
('Circassians', 24),
('Faroe', 15),
('Faroe', 39),
('Faroe', 40),
('Faroe', 41),
('Faroe', 42),
('Sicilian', 16),
('Sicilian', 35),
('Frisians', 17),
('Frisians', 29),
('Frisians', 39),
('S?mi', 18),
('S?mi', 2),
('S?mi', 4),
('S?mi', 39),
('S?mi', 41),
('S?mi', 42),
('Welsh', 19),
('Welsh', 11),
('Manx', 20),
('Manx', 11),
('Walloons', 21),
('Walloons', 22),
('Crimeans', 4),
('Crimeans', 23),
('Crimeans', 24),
('Romansch', 25),
('Romansch', 29),
('Galician', 26),
('Galician', 28),
('Montenegrins', 27);

insert into 
ethnic_country (ethnic_group, country_id) 
values 
('Balkars', 1),
('Finns', 1),
('Finns', 2),
('Finns', 3),
('Mari', 1),
('Livonians', 1),
('Livonians', 5),
('Livonians', 6),
('Nokhchiy', 1),
('Nokhchiy', 7),
('Nokhchiy', 8),
('Basques', 9),
('Ashkenazim', 1),
('Ashkenazim', 3),
('Ashkenazim', 4),
('Ashkenazim', 27),
('Ashkenazim', 15),
('Ashkenazim', 29),
('Ashkenazim', 16),
('Ashkenazim', 20),
('Ashkenazim', 12),
('Ashkenazim', 25),
('Ashkenazim', 30),
('Ashkenazim', 14),
('Ashkenazim', 31),
('Roma', 3),
('Roma', 9),
('Roma', 10),
('Roma', 11),
('Roma', 7),
('Roma', 12),
('Roma', 13),
('Roma', 14),
('Roma', 34),
('Roma', 15),
('Roma', 1),
('Roma', 18),
('Roma', 19),
('Roma', 21),
('Roma', 20),
('Roma', 22),
('Jenische', 20),
('Jenische', 32),
('Jenische', 33),
('Jenische', 34),
('Jenische', 35),
('Jenische', 12),
('Circassians', 1),
('Circassians', 7),
('Faroe', 38),
('Faroe', 39),
('Sicilian', 18),
('S?mi', 1),
('S?mi', 2),
('S?mi', 38),
('S?mi', 39),
('Welsh', 16),
('Manx', 16),
('Walloons', 12),
('Walloons', 35),
('Crimeans', 1),
('Crimeans', 7),
('Romansch', 33),
('Romansch', 20),
('Galician', 9),
('Montenegrins', 41);
