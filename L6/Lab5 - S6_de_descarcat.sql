S5 - L5.pdf

IV. [Exerci?ii – definire tabele]
1. Sa se creeze tabelul ANGAJATI_JF (pnu se alcatuieste din prima litera din prenume 
si primele doua din numele studentului) corespunzator schemei relationale:
ANGAJATI_JF(cod_ang number(4), nume varchar2(20), prenume varchar2(20), 
email char(15), data_ang date, job varchar2(10), cod_sef number(4), 
salariu number(8, 2), cod_dep number(2))
in urmatoarele moduri:
Se presupune ca valoarea implicita a coloanei data_ang este SYSDATE.
Observa?ie: Nu pot exista doua tabele cu acelasi nume in cadrul unei scheme,
deci recrearea unui tabel va fi precedata de suprimarea sa prin comanda:
DROP TABLE ANGAJATI_JF;

a) fara precizarea vreunei chei sau constrangeri;

create table ANGAJATI_JF(
  cod_ang number(4) primary key, 
  nume varchar2(20) not null, 
  prenume varchar2(20), 
  email char(15), 
  data_ang date default sysdate, 
  job varchar2(10), 
  cod_sef number(4), 
  salariu number(8, 2) not null, 
  cod_dep number(2)); --table ANGAJATI_JF created.
  
  select * from angajati_JF; --0 rez
  drop table angajati_JF; --table ANGAJATI_JF dropped.
  
b) cu precizarea cheilor primare la nivel de coloana ?i a 
constrangerilor NOT NULL pentru coloanele nume si salariu;
Se presupune ca valoarea implicita a coloanei data_ang este SYSDATE;

select * from angajati_JF;
    
SELECT constraint_name, constraint_type, table_name
FROM     user_constraints
WHERE  lower(table_name) IN ('angajati_jf','angajati_da');
--SYS_C00527493	C	ANGAJATI_JF
--SYS_C00527492	C	ANGAJATI_JF
--SYS_C00527494	P	ANGAJATI_JF  
-- drop table angajati_JF;


c) cu precizarea cheii primare la nivel de tabel ?i 
a constrangerilor NOT NULL pentru coloanele nume si salariu.
Se presupune ca valoarea implicita a coloanei data_ang este SYSDATE;

create table ANGAJATI_JF(
  cod_ang number(4), 
  nume varchar2(20) constraint nulL_nume_JF not null, 
  prenume varchar2(20), 
  email char(15), 
  data_ang date default sysdate, 
  job varchar2(10), 
  cod_sef number(4), 
  salariu number(8, 2) constraint null_salariu_JF not null, 
  cod_dep number(2),
  constraint pk_ang_JF primary key (cod_ang)
  ); --table ANGAJATI_JF created.
  
  select * from angajati_JF;
  SELECT constraint_name, constraint_type, table_name
FROM     user_constraints
WHERE  lower(table_name) ='angajati_jf';
  Observa?ie: Tipul constrangerilor este marcat prin:
• P – pentru cheie primara
• R – pentru constrangerea de integritate referentiala (cheie externa);
• U – pentru constrangerea de unicitate (UNIQUE);
• C – pentru constrangerile de tip CHECK.

--NULL_SALARIU_JF	C	ANGAJATI_JF
--NULL_NUME_JF	C	ANGAJATI_JF
--PK_ANG_JF	P	ANGAJATI_JF

2.	Adaugati urmatoarele inregistrari in tabelul ANGAJATI_JF:

Cod_ang	Nume	Prenume	   Email	Data_ang	Job	        Cod_sef	Salariu	Cod_dep
    100	Nume1	Prenume1	Null	Null	    Director	null	20000	10
    101	Nume2	Prenume2	Nume2	02-02-2004	Inginer	    100	    10000	10
    102	Nume3	Prenume3	Nume3	05-06-2004	Analist	    101	    5000	20
    103	Nume4	Prenume4	Null	Null	    Inginer	    100	    9000	20
    104	Nume5	Prenume5	Nume5	Null	    Analist	    101	    3000	30
    
    
Prima si a patra inregistrare vor fi introduse specificand coloanele pentru care 
introduce?i date efectiv, iar celelalte vor fi inserate fara precizarea 
coloanelor in comanda INSERT.
Salva?i comenzile de inserare.

insert into angajati_JF(Cod_ang,Nume,Prenume,Email,Data_ang,Job,Cod_sef,Salariu,Cod_dep) 
values( 100	,'Nume1',	'Prenume1',	Null	,Null,	'Director',	null,	20000	,10);
select * from angajati_JF;

insert into angajati_JF
values (101, 'Nume2','Prenume2','Nume2@gmail.com',
        to_date('02-02-2004', 'dd-mm-yyyy'), 'Inginer',	100,10000,10);
        
insert into angajati_JF
values (102, 'Nume3','Prenume3','Nume3@gmail.com',
        to_date('05-06-2004', 'dd-mm-yyyy'), 'Analist',	101,5000,20);

insert into angajati_JF
values (103, 'Nume4','Prenume4',Null,
        to_date('28-03-2023', 'dd-mm-yyyy'), 'Inginer',	100,9000,20);
        
insert into angajati_JF
values (104, 'Nume4','Prenume4','Nume5@gmail.com',
        to_date('05-06-2004', 'dd-mm-yyyy'), 'Analist',	101,3000,30);

select * from angajati_JF;
commit;

100	Nume1	Prenume1			Director		20000	10
101	Nume2	Prenume2	Nume2@gmail.com	02-FEB-04	Inginer	100	10000	10
102	Nume3	Prenume3	Nume3@gmail.com	05-JUN-04	Analist	101	5000	20
103	Nume4	Prenume4		28-MAR-23	Inginer	100	9000	20
104	Nume5	Prenume5	Nume5@gmail.com		Analist	101	3000	30

--truncate table angajati_JF;
--rollback;
--select * from angajati_JF;
--
--delete from angajati_JF;

3. Creati tabelul ANGAJATI10_JF, prin copierea angajatilor din departamentul 10 
din tabelul ANGAJATI_JF. Listati structura noului tabel. Ce se observa?

create table angajati10_JF as
  Select * from angajati_JF where cod_dep =10;
  
  select * from angajati10_JF; --2 rez
  
  
SELECT constraint_name, constraint_type, table_name
FROM     user_constraints
WHERE  lower(table_name) IN ('angajati10_jf');
--SYS_C00527544	C	ANGAJATI10_JF
--SYS_C00527543	C	ANGAJATI10_JF
--doar contrangerile de not null peste coloanele nume si salriu au fost copiate
desc angajati10_JF;
Name     Null     Type         
-------- -------- ------------ 
COD_ANG           NUMBER(4)    --lipseste pk
NUME     NOT NULL VARCHAR2(20) 
PRENUME           VARCHAR2(20) 
EMAIL             CHAR(15)     
DATA_ANG          DATE         
JOB               VARCHAR2(10) 
COD_SEF           NUMBER(4)    
SALARIU  NOT NULL NUMBER(8,2)  
COD_DEP           NUMBER(2)    

desc angajati_JF;

Name     Null     Type         
-------- -------- ------------ 
COD_ANG  NOT NULL NUMBER(4)    --este setata PK
NUME     NOT NULL VARCHAR2(20) 
PRENUME           VARCHAR2(20) 
EMAIL             CHAR(15)     
DATA_ANG          DATE         
JOB               VARCHAR2(10) 
COD_SEF           NUMBER(4)    
SALARIU  NOT NULL NUMBER(8,2)  
COD_DEP           NUMBER(2) 



4. Introduceti coloana comision in tabelul ANGAJATI_JF. 
Coloana va avea tipul de date NUMBER(4,2).

alter table angajati_JF
add (comision number(4,2));

select * from angajati_JF;

5. Este posibila modificarea tipului coloanei comision in NUMBER(6,2)?

--de rezolvat

alter table angajati_JF
modify (comision number(6,2));

--Table ANGAJATI_JF altered.

--apoi pot sa micsorez?
alter table angajati_JF
modify (comision number(4,2));
--table ANGAJATI_JF altered. (toate infomatiiile din coloana comision sunt nule)

select * from angajati_JF;
5-2 .Este posibil? modificarea tipului coloanei salariu in NUMBER(6,2)?
-- SALARIU  NOT NULL NUMBER(8,2) 
alter table angajati_JF
modify (salariu number(7,2));
-- SQL Error: ORA-01440: coloana de modificat trebuie sa fie goala pentru a micsora precizia sau scala

-- 6. Setati o valoare DEFAULT pentru coloana salariu.
alter table angajati_JF
modify (salariu default 1111);
--de rezolvat

-- lipseste salariul si data de angajare
insert into angajati_JF (Cod_ang, Nume, Prenume, Job, Cod_sef, Cod_dep) 
values (105, 'Nume6', 'Prenume6', 'Inginer', 100, 20);

insert into angajati_JF (Cod_ang, Nume, Prenume, Job, Cod_sef, Cod_dep, salariu)
values (106, 'Num76', 'Prenume76', 'Inginer', 100, 20, 2222);

select * from angajati_JF;

--alter table angajati_JF
--drop column comission;

-- 105	Nume6	Prenume6		06-APR-22	Inginer	100	1111	20	
-- 106	Num76	Prenume76		06-APR-22	Inginer	100	2222	20	

7. Modificati tipul coloanei comision in NUMBER(2, 2) si 
al coloanei salariu in NUMBER(10,2), 
in cadrul aceleiasi instructiuni.
desc angajati_JF;

-- inainte
SALARIU  NOT NULL NUMBER(8,2)  
COD_DEP           NUMBER(2)    
COMISION          NUMBER(4,2)  


--de rezolvat

-- dupa: 
SALARIU  NOT NULL NUMBER(10,2) 
COD_DEP           NUMBER(2)    
COMISION          NUMBER(2,2)       
--
--update angajati_JF
--set comision= null
--where lower(job)  like 'i%';

--8. Actualiza?i valoarea coloanei comision, setand-o la valoarea 0.1 pentru 
--salariatii al caror job incepe cu litera I. (UPDATE)
--select * from angajati_JF;


--de rezolvat
update angajati_JF
set comision = 0.1
where upper(job) like 'I%';

select * from angajati_JF;
commit;

-- atentie daca facem update  comision=1.1 

--de rezolvat


-- ORA-01438: value larger than specified precision allowed for this column

-- atentie daca facem update  comision=0.129345 

--de rezolvat 


-- 100	Nume1	Prenume1			                    Director	20000	10	
-- 101	Nume2	Prenume2	Nume2@gmail.com	02-FEB-04	Inginer	100	10000	10	0.13
-- 102	Nume3	Prenume3	Nume3@gmail.com	05-JUN-04	Analist	101	5000	20	
-- 103	Nume4	Prenume4		            06-APR-22	Inginer	100	9000	20	0.13
-- 104	Nume5	Prenume5	Nume5@gmail.com             Analist	101	3000	30	
-- 105	Nume6	Prenume6		            06-APR-22	Inginer	100	1111	20	0.13
-- 106	Num76	Prenume76		            06-APR-22	Inginer	100	2222	20	0.13

12. Redenumiti tabelul ANGAJATI_JF in ANGAJATI3_JF.

--de rezolvat 

-- angajati_JF TO succeeded.
select * from angajati_JF; -- ORA-00942: tabelul sau vizualizarea nu exista
select * from angajati3_JF; 
desc angajati3_JF;

SELECT constraint_name, constraint_type, table_name
FROM     user_constraints
WHERE  lower(table_name) IN ('angajati3_JF');


13. Consultati vizualizarea TAB din dictionarul datelor. 
Redenumiti angajati3_JF in angajati_JF.

select * from tab;
rename angajati3_JF to angajati_JF;
--Table renamed.
select * from angajati_JF;
select * from angajati3_JF;  --ORA-00942: tabelul sau vizualizarea nu exista

14. Suprimati continutul tabelului angajati10_JF, fara a suprima structura acestuia.

create table angajati10_JF as
  Select * from angajati_JF where cod_dep =10;
  
  select * from angajati10_JF;
  
  delete from angajati10_JF; --tabela goala
  rollback; -- avem cele 2 inregistrari
  
  truncate table angajati10_JF; --se pastreaza structura tabelei (DELETE+COMMIT)
  rollback; -- in continuare tabela este goala
  
  drop table angajati10_JF;
  select * from angajati10_JF; -- ORA-00942: tabelul sau vizualizarea nu exista
  
-- 15. Creati tabelul DEPARTAMENTE_JF, corespunzator schemei relationale:
-- DEPARTAMENTE_JF (cod_dep# number(2), nume varchar2(15), cod_director number(4))
-- specificand doar constrangerea NOT NULL pentru nume
-- (nu precizati deocamdata constrangerea de cheie primara). 

drop table departamente_JF;

CREATE TABLE departamente_JF 
(cod_dep number(2), 
nume varchar2(15) constraint NL_nume_JF NOT NULL, 
cod_director number(4)); 

DESC departamente_JF;

/*
Name         Null     Type         
------------ -------- ------------ 
COD_DEP               NUMBER(2)    
NUME         NOT NULL VARCHAR2(15) 
COD_DIRECTOR          NUMBER(4)   

16. Introduceti urmatoarele inregistrari in tabelul DEPARTAMENTE_pnu:
Cod_dep	Nume	Cod_director
10	Administrativ	100
20	Proiectare	101
30	Programare	Null
*/

insert into departamente_JF
values(10,	'Administrativ',	100);
insert into departamente_JF
values(20, 'Proiectare',	101);
insert into departamente_JF
values(30,	'Programare',	Null);

-- atentie
insert into departamente_JF
values(30,	'DE_STERS',	Null);

select * from departamente_JF;
/*
10	Administrativ	100
20	Proiectare	101
30	Programare	
30	DE_STERS	
*/

alter table departamente_JF
add constraint pk_depart_JF primary key (cod_dep); 

-- SQL Error: ORA-02437: (GRUPA32.PK_DEPART_JF) nu a putut fi validata - cheia primara a fost violata
--*Cause:    attempted to validate a primary key with duplicate values or null
--           values.
--*Action:   remove the duplicates and null values before enabling a primary
--           key.
;
delete from departamente_JF
where nume = 'DE_STERS'; -- 1 rows deleted.

select * from departamente_JF;
commit;

17. Introduce?i constangerea de cheie primara asupra coloanei cod_dep,
fara suprimarea si recrearea tabelului 
(comanda ALTER).
Observa?ie:
o Introducerea unei constrangeri dupa crearea tabelului presupune ca toate liniile existente in tabel la 
momentul respectiv satisfac noua constrangere.
o Specificarea constrangerilor permite numirea acestora.
o In situatia in care constrangerile sunt precizate la nivel de coloana sau tabel 
(in CREATE TABLE) ele vor primi implicit nume atribuite de sistem, daca nu se specifica vreun alt nume 
intr-o clauza CONSTRAINT.
Exemplu : CREATE TABLE alfa (
X NUMBER CONSTRAINT nn_x NOT NULL,
Y VARCHAR2 (10) NOT NULL
);

-- atentie
alter table departamente_JF  --PK = Unique + NOT NULL
add constraint pk_depart_JF primary key (cod_director);
--SQL Error: ORA-01449: coloana contine valori NULL; nu se poate modifica in NOT NULL

--corect
alter table departamente_JF
add constraint pk_depart_JF primary key (cod_dep); 

--table DEPARTAMENTE_JF altered.

--alter table departamente_JF
--drop constraint pk_depart_JF;


desc departamente_JF;
18. Sa se precizeze constrangerea de cheie externa pentru coloana cod_dep din ANGAJATI_pnu:
a) fara suprimarea tabelului (ALTER TABLE);

alter table angajati_JF
add constraint fk_ang_JF foreign key (cod_dep)
references departamente_JF(cod_dep);

desc angajati_JF;

select * from angajati_JF;

delete from angajati_JF
where cod_ang in (105,106);


--de rezolvat 

--Posibile erori:
-- ORA-02270: no matching unique or primary key for this column-list (pt ca nu este setata cheia primara pe tabela de departamente

--ORA-02298: cannot validate (GRUPA34.FK_ANG_DEPART_JF) - parent keys not found
--02298. 00000 - "cannot validate (%s.%s) - parent keys not found"
-- angajatii lucreaza pe departamente care nu se gasesc in tabela departamente_JF
--insert  into angajati_JF
--values (105, 'Nume6', 'Prenume6', 'Nume6@gmail.com', Null, 'Analist', 101, 3000, 50, 0.2);
delete from angajati_JF
where cod_ang =105;

SELECT constraint_name, constraint_type, table_name
FROM     user_constraints
WHERE  lower(table_name) = 'angajati_jf';

NULL_SALARIU_JF	C	ANGAJATI_JF
NULL_NUME_JF	C	ANGAJATI_JF
FK_ANG_DEPART_JF	R	ANGAJATI_JF --FK
PK_ANG_JF	P	ANGAJATI_JF  --PK

b) prin suprimarea si recrearea tabelului, cu precizarea noii constrangeri la nivel de coloana 
({DROP, CREATE} TABLE). De asemenea, se vor mai preciza constrangerile (la nivel de coloana, 
in masura in care este posibil):
- PRIMARY KEY pentru cod_ang;
- FOREIGN KEY pentru cod_sef;
- UNIQUE pentru combinatia nume + prenume;
- UNIQUE pentru email;
- NOT NULL pentru nume;
- verificarea cod_dep > 0;
- verificarea ca salariul sa fie mai mare decat comisionul*100.

--drop table departamente_JF; --SQL Error: ORA-02449: cheile unice/primare din tabela sunt referite de cheile externe

drop table angajati_JF; --table ANGAJATI_JF dropped.

SELECT constraint_name, constraint_type, table_name
FROM     user_constraints
WHERE  lower(table_name) = 'departamente_JF';

--de rezolvat 
--eu

create  table ANGAJATI_JF(
  cod_ang number(4) , 
  nume varchar2(20) constraint null_nume_JF not null, 
  prenume varchar2(20), 
  email char(15) , 
  data_ang date default sysdate, 
  job varchar2(10), 
  cod_sef number(4) , 
  salariu number(8, 2),
  cod_dep number(2) ,
  comision number(4,2),
  constraint unq_nume_pren_JF unique(nume, prenume),
  constraint ck_sal_com_JF check(salariu>comision *100),
  constraint pk_ang_JF primary key(cod_ang),
  constraint unq_email_JF unique(email),
  constraint fk_ang_ang_JF foreign key(cod_sef) references angajati_JF(cod_ang),
  constraint ck_cod_dep_JF check(cod_dep>0),
  constraint fk_ang_depart_JF foreign key(cod_dep) references departamente_JF(cod_dep)  
    );

SELECT constraint_name, constraint_type, table_name
FROM     user_constraints
WHERE  lower(table_name) IN ('angajati_jf');

CK_SAL_COM_JF	C	ANGAJATI_JF
CK_COD_DEP_JF	C	ANGAJATI_JF
NULL_NUME_JF	C	ANGAJATI_JF
FK_ANG_DEPART_JF	R	ANGAJATI_JF
FK_ANG_ANG_JF	R	ANGAJATI_JF
UNQ_NUME_PREN_JF	U	ANGAJATI_JF
UNQ_EMAIL_JF	U	ANGAJATI_JF
PK_ANG_JF	P	ANGAJATI_JF

19. Suprimati si recreati tabelul, specificand toate constrangerile la nivel de tabel 
(in masura in care este posibil).
/

drop table angajati_JF;

create  table ANGAJATI_JF(
  cod_ang number(4) , 
  nume varchar2(20) constraint null_nume_JF not null, 
  prenume varchar2(20), 
  email char(15) , 
  data_ang date default sysdate, 
  job varchar2(10), 
  cod_sef number(4) , 
  salariu number(8, 2),
  cod_dep number(2) ,
  comision number(4,2),
  constraint unq_nume_pren_JF unique(nume, prenume),
  constraint ck_sal_com_JF check(salariu>comision *100),
  constraint pk_ang_JF primary key(cod_ang),
  constraint unq_email_JF unique(email),
  constraint fk_ang_ang_JF foreign key(cod_sef) references angajati_JF(cod_ang),
  constraint ck_cod_dep_JF check(cod_dep>0),
  constraint fk_ang_depart_JF foreign key(cod_dep) references departamente_JF(cod_dep)  
    );
    
    drop table ANGAJATI_JF;

  SELECT * FROM USER_CONSTRAINTS WHERE lower(TABLE_NAME) = 'angajati_JF';

CK_COD_DEP_JF	C
CK_SAL_COM_JF	C
NULL_NUME_JF	C
FK_ANG_DEPART_JF	R
FK_ANG_ANG_JF	R
UNQ_EMAIL_JF	U
UNQ_NUME_PREN_JF	U
PK_ANG_JF	P
select * from angajati_JF;

insert into angajati_JF(Cod_ang,	Nume	,Prenume,	Email,	Data_ang	,Job,	Cod_sef,	Salariu,	Cod_dep)
values( 100	,'Nume1',	'Prenume1',	Null	,Null,	'Director',	null,	20000	,10);


insert into angajati_JF
values (101, 	'Nume2',	'Prenume2',	'Nume2@gmail.com', to_date(	'02-02-2004', 'dd-mm-yyyy'), 	'Inginer',	100,	10000	,10, 0.1);

insert into angajati_JF
values (102, 'Nume3', 'Prenume3', 'Nume3@gmail.com', to_date('05-06-2004', 'dd-mm-yyyy'), 'Analist', 101, 5000, 20, null);

insert into angajati_JF (Cod_ang, Nume, Prenume, Job, Cod_sef, Salariu, Cod_dep)
values (103, 'Nume4', 'Prenume4', 'Inginer', 100, 9000, 20);
--atentie la data de angajare a lui 103 

insert into angajati_JF
values (104, 'Nume5', 'Prenume5', 'Nume5@gmail.com', Null, 'Analist', 101, 3000, 30, 0.2);

select * from angajati_JF;
commit;

delete from angajati_JF;
rollback;

insert into angajati_JF  --inserare prin copiere din tabela mea
select * from angajati_JF;
-----
insert into angajati_JF(Cod_ang, Nume ,Prenume, Email, Data_ang ,Job, Cod_sef, Salariu, Cod_dep)
values( 100 ,'Nume1', 'Prenume1', Null ,Null, 'Director', null, 20000 ,10);
select * from angajati_JF;
insert into angajati_JF
values (101, 'Nume2', 'Prenume2', 'Nume2@gmail.com', to_date( '02-02-2004', 'dd-mm-yyyy'), 'Inginer', 100, 10000 ,10, 0.1);
insert into angajati_JF
values (102, 'Nume3', 'Prenume3', 'Nume3@gmail.com', to_date('05-06-2004', 'dd-mm-yyyy'), 'Analist', 101, 5000, 20, null);
insert into angajati_JF (Cod_ang, Nume, Prenume, Job, Cod_sef, Salariu, Cod_dep)
values (103, 'Nume4', 'Prenume4', 'Inginer', 100, 9000, 20);
--atentie la data de angajare a lui 103
insert into angajati_JF
values (104, 'Nume5', 'Prenume5', 'Nume5@gmail.com', Null, 'Analist', 101, 3000, 30, 0.2);
-----------
commit;


select * from departamente_JF;



25. (incercati sa) adaugati o noua inregistrare in tabelul ANGAJATI_pnu, 
care sa corespunda codului de departament 50. Se poate?


insert  into angajati_JF
values (105, 'Nume6', 'Prenume6', 'Nume6@gmail.com', Null, 'Analist', 101, 3000, 50, 0.2);
SQL Error: ORA-02291: constrangere de integritate (GRUPA33.FK_ANG_DEPART_JF) violata - cheia parinte negasita
--dept 50 nu exista in lista de departamente

--atentie
insert into angajati_JF
values (105, 'Nume5', 'Prenume5', 'Nume5@gmail.com', Null, 'Analist', 101, 3000, 30, 0.2);
--SQL Error: ORA-00001: restrictia unica (GRUPA34.UNQ_NUME_PREN_JF) nu este respectata

insert  into angajati_JF
values (105, 'Nume6', 'Prenume5', 'Nume5@gmail.com', Null, 'Analist', 101, 3000, 30, 0.2);
--SQL Error: ORA-00001: restrictia unica (GRUPA34.UNQ_EMAIL_JF) nu este respectata


29. (incercati sa) introduceti un nou angajat, specificand valoarea 114 pentru cod_sef.
Ce se obtine?

insert into angajati_JF
values (105, 'Nume6', 'Prenume6', 'Nume6@gmail.com', null, 'Analist', 114, 3000, 20, 0.2);

--SQL Error: ORA-02291: constrangere de integritate (GRUPA33.FK_ANG_ANG_JF) violata - cheia parinte negasita

--angajatul 114 nu exista in baza de date
30. Adaugati un nou angajat, avand codul 114. incercati din nou introducerea inregistrarii de la exercitiul 29.

--de rezolvat 


select * from angajati_JF;

21. Ce se intampla daca se incearca suprimarea tabelului departamente_pnu?

drop table departamente_JF; 
--SQL Error: ORA-02449: cheile unice/primare din tabela sunt referite de cheile externe
truncate table departamente_JF; 
--SQL Error: ORA-02266: cheile unice/primare din tabela sunt referite de cheile externe activate
delete from departamente_JF; 
--SQL Error: ORA-02292: constrangerea de integritate (GRUPA33.fk_ang_depart_JF) violata - gasita inregistrarea copil

26. Adaugati un nou departament, cu numele Testare, codul 60 si directorul null in DEPARTAMENTE_pnu. COMMIT.
--de rezolvat 

commit;

27. (incercati sa) stergeti departamentul 20 din tabelul DEPARTAMENTE_pnu. Comentati.
--de rezolvat 


28. Stergeti departamentul 60 din DEPARTAMENTE_pnu. ROLLBACK.
--de rezolvat 

select * from departamente_JF;


commit;

31. Se doreste stergerea automata a angajatilor dintr-un departament, odata cu suprimarea departamentului.
Pentru aceasta, este necesara introducerea clauzei ON DELETE CASCADE in definirea constrangerii de cheie externa.
Suprimati constrangerea de cheie externa asupra tabelului ANGAJATI_pnu si reintroduceti aceasta constrangere, 
specificand clauza ON DELETE CASCADE.

SELECT constraint_name, constraint_type, table_name
FROM     user_constraints
WHERE  lower(table_name) IN ('departamente_JF', 'angajati_JF');

--sterg vechea constrangere FK dintre tabela angajati si cea de departamente
alter table angajati_JF
drop constraint FK_ANG_DEPART_JF;
--table ANGAJATI_JF altered.


--adaug FK intre tabela angajati si cea de departamente
alter table angajati_JF
add constraint FK_ANG_DEPART2_JF foreign key(cod_dep) 
            references departamente_JF(cod_dep) on delete cascade;

32. Stergeti departamentul 20 din DEPARTAMENTE_pnu. Ce se intampla? Rollback.

select * from angajati_JF;
-- 7 rez, dintre care 4 lucreaza in dept 20
-- exista angajati care lucreaza in dept 20

delete from departamente_JF 
where cod_dep =20;
--1 rows deleted.

select * from angajati_JF;
--3 rez

rollback;
select * from angajati_JF; --7 rez
select * from departamente_JF; --3 rez
--commit;

-- ON DELETE SET NULL

alter table angajati_JF
drop constraint FK_ANG_DEPART2_JF ;
--table ANGAJATI_JF altered.

--de rezolvat 


select * from angajati_JF;
-- 7 rez, dintre care 4 lucreaza in dept 20

delete from departamente_JF 
where cod_dep =20;
--1 rows deleted.

select * from departamente_JF;

select * from angajati_JF;
--7 rez, cei care lucrau in dept 20, acum au dept setata null

rollback;

------  V. [Definirea secven?elor]  -------


CREATE SEQUENCE nume_secv
[INCREMENT BY n]
[START WITH n]
[{MAXVALUE n | NOMAXVALUE}]
[{MINVALUE n | NOMINVALUE}]
[{CYCLE | NOCYCLE}]
[{CACHE n | NOCACHE}];

/*
38. Creati o secventa pentru generarea codurilor de departamente, SEQ_DEPT_PNU. 
Secventa va incepe de la 400, va creste cu 10 de fiecare data si va avea valoarea maxima 
10000, nu va cicla si nu va incarca nici un numar inainte de cerere.
*/

drop sequence   seq_dept_JF;

create  sequence seq_dept_JF
start with 400
increment by 10
maxvalue 10000
nocycle
nocache;
--Sequence SEQ_DEPT_JF created.

select seq_dept_JF.nextval
from dual;

--I -> 400
--II ->410

select seq_dept_JF.currval
from dual;

insert into departamente_JF
values(seq_dept_JF.nextval, 'Dept_sec', null);  --420
--SQL Error: ORA-01438: valoare mai mare decat precizia specificata permisa pentru aceasta coloana

desc departamente_JF;
Name         Null     Type         
------------ -------- ------------ 
COD_DEP      NOT NULL NUMBER(2)    
NUME         NOT NULL VARCHAR2(15) 
COD_DIRECTOR          NUMBER(4)    

--create table dept_JF
--as select * from departments;

insert into dept_JF
values(seq_dept_JF.nextval, 'Dept_sec', null, null); 
--1 rows inserted.
select * from dept_JF;
--430	Dept_sec		null null
--440	Dept_sec		null null 

delete from dept_JF
where department_id between 430 and 470;
commit;

rollback;


40. Creati o secventa pentru generarea codurilor de angajati, SEQ_EMP_PNU.

drop sequence seq_ang_JF;

create sequence seq_ang_JF
start with 100
maxvalue 120 --- ca sa apara o eroare cand ajunge la maxvalue
nocycle
nocache;

41. Sa se modifice toate liniile din angajati_JF (daca nu mai exista, il recreati),
regenerand codul angajatilor astfel incat sa utilizeze secventa SEQ_EMP_PNU si 
sa avem continuitate in codurile angajatilor.

 --7 ang
--(100..106)

--de rezolvat 

--SQL Error: ORA-02292: constrangerea de integritate (GRUPA34.FK_ANG_ANG_JF) violata - gasita inregistrarea copil

select * from angajati_JF;

delete from angajati_JF
where cod_ang =105; --nu rezolva problema
commit;

update angajati_JF --6 ang
set cod_ang = seq_ang_JF.nextval; --(107---112)
--SQL Error: ORA-02292: constrangerea de integritate (GRUPA34.FK_ANG_ANG_JF) violata - gasita inregistrarea copil

--rezolvare:
update angajati_JF
set cod_sef = null;
6 rows updated.

--dupa 2 update-uri esuate am ajuns la val 113

update angajati_JF
set cod_ang = seq_ang_JF.nextval;
6 rows updated.

--113	Nume1	Prenume1			Director		20000	10	
--114	Nume2	Prenume2	Nume2@gmail.com	02-02-2004	Inginer		10000	10	0,1
--115	Nume3	Prenume3	Nume3@gmail.com	05-06-2004	Analist		5000		
--116	Nume4	Prenume4		15-04-2021	Inginer		9000		
--117	Nume5	Prenume5	Nume5@gmail.com		Analist		3000	30	0,2
--118	Nume7	Prenume7	Nume7@gmail.com		Analist		3000		0,2


---incerc sa mai fac un update, dar atimge val maxima
ORA-08004: sequence SEQ_ANG_JF.NEXTVAL exceeds MAXVALUE and cannot be instantiated


rollback;
--
--100	Nume1	Prenume1			Director		20000	10	
--101	Nume2	Prenume2	Nume2@gmail.com	02-02-2004	Inginer	100	10000	10	0,1
--102	Nume3	Prenume3	Nume3@gmail.com	05-06-2004	Analist	101	5000		
--103	Nume4	Prenume4		14-04-2021	Inginer	100	9000		
--104	Nume5	Prenume5	Nume5@gmail.com		Analist	101	3000	30	0,2
--114	Nume7	Prenume7	Nume7@gmail.com		Analist	100	3000		0,2


--modific codul unui angajat care nu este sef -> se poate
update angajati_JF 
set cod_ang = seq_ang_JF.nextval
where cod_ang =104;

--100	Nume1	Prenume1			Director		20000	10	
--101	Nume2	Prenume2	Nume2@gmail.com	02-02-2004	Inginer	100	10000	10	0,1
--102	Nume3	Prenume3	Nume3@gmail.com	05-06-2004	Analist	101	5000		
--103	Nume4	Prenume4		15-04-2021	Inginer	100	9000		
--119	Nume5	Prenume5	Nume5@gmail.com		Analist	101	3000	30	0,2
--114	Nume7	Prenume7	Nume7@gmail.com		Analist	100	3000		0,2


Stergeti toate secventele si toate tabelele create dupa finalizarea acestui Laborator5.pdf
