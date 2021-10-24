-- Script for Assignment 3

-- Creating database with full name

CREATE DATABASE akhilesh_gowda_mandya_ramesh;

-- Connecting to database 
\c akhilesh_gowda_mandya_ramesh

-- Relation schemas and instances for assignment 2

CREATE TABLE Person(pid integer,
                    pname text,
                    city text,
                    primary key (pid));

CREATE TABLE Company(cname text,
                     headquarter text,
                     primary key (cname));

CREATE TABLE Skill(skill text,
                   primary key (skill));


CREATE TABLE worksFor(pid integer,
                      cname text,
                      salary integer,
                      primary key (pid),
                      foreign key (pid) references Person (pid),
                      foreign key (cname) references Company(cname));


CREATE TABLE companyLocation(cname text,
                             city text,
                             primary key (cname, city),
                             foreign key (cname) references Company (cname));


CREATE TABLE personSkill(pid integer,
                         skill text,
                         primary key (pid, skill),
                         foreign key (pid) references Person (pid) on delete cascade,
                         foreign key (skill) references Skill (skill) on delete cascade);


CREATE TABLE hasManager(eid integer,
                        mid integer,
                        primary key (eid, mid),
                        foreign key (eid) references Person (pid),
                        foreign key (mid) references Person (pid));

CREATE TABLE Knows(pid1 integer,
                   pid2 integer,
                   primary key(pid1, pid2),
                   foreign key (pid1) references Person (pid),
                   foreign key (pid2) references Person (pid));



INSERT INTO Person VALUES
     (1001,'Jean','Cupertino'),
     (1002,'Vidya', 'Cupertino'),
     (1003,'Anna', 'Seattle'),
     (1004,'Qin', 'Seattle'),
     (1005,'Megan', 'MountainView'),
     (1006,'Ryan', 'Chicago'),
     (1007,'Danielle','LosGatos'),
     (1008,'Emma', 'Bloomington'),
     (1009,'Hasan', 'Bloomington'),
     (1010,'Linda', 'Chicago'),
     (1011,'Nick', 'MountainView'),
     (1012,'Eric', 'Cupertino'),
     (1013,'Lisa', 'Indianapolis'), 
     (1014,'Deepa', 'Bloomington'), 
     (1015,'Chris', 'Denver'),
     (1016,'YinYue', 'Chicago'),
     (1017,'Latha', 'LosGatos'),
     (1018,'Arif', 'Bloomington'),
     (1019,'John', 'NewYork');

INSERT INTO Company VALUES
     ('Apple', 'Cupertino'),
     ('Amazon', 'Seattle'),
     ('Google', 'MountainView'),
     ('Netflix', 'LosGatos'),
     ('Microsoft', 'Redmond'),
     ('IBM', 'NewYork'),
     ('ACM', 'NewYork'),
     ('Yahoo', 'Sunnyvale');


INSERT INTO worksFor VALUES
     (1001,'Apple', 65000),
     (1002,'Apple', 45000),
     (1003,'Amazon', 55000),
     (1004,'Amazon', 55000),
     (1005,'Google', 60000),
     (1006,'Amazon', 55000),
     (1007,'Netflix', 50000),
     (1008,'Amazon', 50000),
     (1009,'Apple',60000),
     (1010,'Amazon', 55000),
     (1011,'Google', 70000), 
     (1012,'Apple', 50000),
     (1013,'Yahoo', 55000),
     (1014,'Apple', 50000), 
     (1015,'Amazon', 60000),
     (1016,'Amazon', 55000),
     (1017,'Netflix', 60000),
     (1018,'Apple', 50000),
     (1019,'Microsoft', 50000);

INSERT INTO companyLocation VALUES
   ('Apple', 'Bloomington'),
   ('Amazon', 'Chicago'),
   ('Amazon', 'Denver'),
   ('Amazon', 'Columbus'),
   ('Google', 'NewYork'),
   ('Netflix', 'Indianapolis'),
   ('Netflix', 'Chicago'),
   ('Microsoft', 'Bloomington'),
   ('Apple', 'Cupertino'),
   ('Amazon', 'Seattle'),
   ('Google', 'MountainView'),
   ('Netflix', 'LosGatos'),
   ('Microsoft', 'Redmond'),
   ('IBM', 'NewYork'),
   ('Yahoo', 'Sunnyvale');

INSERT INTO Skill VALUES
   ('Programming'),
   ('AI'),
   ('Networks'),
   ('OperatingSystems'),
   ('Databases');

INSERT INTO personSkill VALUES
 (1001,'Programming'),
 (1001,'AI'),
 (1002,'Programming'),
 (1002,'AI'),
 (1004,'AI'),
 (1004,'Programming'),
 (1005,'AI'),
 (1005,'Programming'),
 (1005,'Networks'),
 (1006,'Programming'),
 (1006,'OperatingSystems'),
 (1007,'OperatingSystems'),
 (1007,'Programming'),
 (1009,'OperatingSystems'),
 (1009,'Networks'),
 (1010,'Networks'),
 (1011,'Networks'),
 (1011,'OperatingSystems'),
 (1011,'AI'),
 (1011,'Programming'),
 (1012,'AI'),
 (1012,'OperatingSystems'),
 (1012,'Programming'),
 (1013,'Programming'),
 (1013,'OperatingSystems'),
 (1013,'Networks'),
 (1014,'OperatingSystems'),
 (1014,'AI'),
 (1014,'Networks'),
 (1015,'Programming'),
 (1015,'AI'),
 (1016,'OperatingSystems'),
 (1016,'AI'),
 (1017,'Networks'),
 (1017,'Programming'),
 (1018,'AI'),
 (1019,'Networks'),
 (1010,'Databases'),
 (1011,'Databases'),
 (1013,'Databases'),
 (1014,'Databases'),
 (1017,'Databases'),
 (1019,'Databases'),
 (1005,'Databases'),
 (1006,'AI'),
 (1009,'Databases');
 

INSERT INTO hasManager VALUES
 (1004, 1003),
 (1006, 1003),
 (1015, 1003),
 (1016, 1004),
 (1016, 1006),
 (1008, 1015),
 (1010, 1008),
 (1013, 1007),
 (1017, 1013),
 (1002, 1001),
 (1009, 1001),
 (1014, 1012),
 (1011, 1005);


INSERT INTO Knows VALUES
 (1011,1009),
 (1007,1016),
 (1011,1010),
 (1003,1004),
 (1006,1004),
 (1002,1014),
 (1009,1005),
 (1018,1009),
 (1007,1017),
 (1017,1019),
 (1019,1013),
 (1016,1015),
 (1001,1012),
 (1015,1011),
 (1019,1006),
 (1013,1002),
 (1018,1004),
 (1013,1007),
 (1014,1006),
 (1004,1014),
 (1001,1014),
 (1010,1013),
 (1010,1014),
 (1004,1019),
 (1018,1007),
 (1014,1005),
 (1015,1018),
 (1014,1017),
 (1013,1018),
 (1007,1008),
 (1005,1015),
 (1017,1014),
 (1015,1002),
 (1018,1013),
 (1018,1010),
 (1001,1008),
 (1012,1011),
 (1002,1015),
 (1007,1013),
 (1008,1007),
 (1004,1002),
 (1015,1005),
 (1009,1013),
 (1004,1012),
 (1002,1011),
 (1004,1013),
 (1008,1001),
 (1008,1019),
 (1019,1008),
 (1001,1019),
 (1019,1001),
 (1004,1003),
 (1006,1003),
 (1015,1003),
 (1016,1004),
 (1016,1006),
 (1008,1015),
 (1010,1008),
 (1017,1013),
 (1002,1001),
 (1009,1001),
 (1011,1005),
 (1014,1012),
 (1010,1002),
 (1010,1012),
 (1010,1018);

\qecho 'Problem 1'
-- Find each pair $(c,n)$ where $c$ is the cnameof a company that pays
-- an average salary between 50000 and 55000 and where $n$ is the number
-- of employees who work for company $c$.


select w.cname,count(w.pid)
from  worksFor w
Group by w.cname
having avg(w.salary)>=50000
INTERSECT
select w.cname,count(w.pid)
from  worksFor w
Group by w.cname
having avg(w.salary)<=55000 order by 1;

\qecho 'Problem 2'
-- Find the pid and name of each person who lacks at least 4 job skills
-- and who knows at least 4 persons.


select p.pid,p.pname
from person p
where  p.pid Not In (select ps.pid from personSkill ps) and p.pid in (select p.pid
from  knows k
where p.pid=k.pid1
group by k.pid1
having count(k.pid1)>=4)
UNION
select p.pid,p.pname
from personSkill ps,person p
where p.pid=ps.pid and p.pid in (select p.pid
from  knows k
where p.pid=k.pid1
group by k.pid1
having count(k.pid1)>=4)
group by p.pid
having count(ps.skill)<=1 order by 1 ;


\qecho 'Problem 3'
-- Find the pid and name of each person who has fewer than 2 of the
-- combined set of job skills of persons who work for Google.

select p.pid,p.pname
from person p
where p.pid Not in (select ps.pid from personSkill ps)
UNION
select p.pid,p.pname
from person p, personSkill ps
where p.pid=ps.pid and ps.skill IN (select distinct ps.skill from personSkill ps, worksFor w where ps.pid=w.pid and w.cname='Google')
Group by p.pid
having count(ps.skill)<2 order by 1;

\qecho 'Problem 4'
-- Find the cname of each company that employs at least 3 persons and
-- that pays the lowest average salary among such companies.
with average as(select w.cname,avg(w.salary) from worksFor w group by w.cname having count(w.pid)>=3 )

select a.cname
from average a
where a.avg=(select min(avg)
             from average);


\qecho 'Problem 5'
-- Find each pair $(c_1,c_2)$ of different company cnames such that,
-- among all companies, company $c_2$ pays the closest average salary
--- compared to the average salary paid by company $c_1$.

with closest as (
select w1.cname as c1 ,w2.cname as c2,abs(avg(w1.salary)-avg(w2.salary)) as diff
from worksFor w1,worksFor w2
where w1.cname<>w2.cname
group by w1.cname,w2.cname order by 1,3)

select cl.c1,cl.c2
from closest cl
where cl.diff=(select min(cl2.diff)
               from closest cl2
               where cl2.c1=cl.c1);


\qecho 'Problem 6'
--Without using set predicates, find each pid of a person who does not
--know each person who (1) works for Apple and
-- (2) who makes less than 55000.

select k.pid1
from knows k
EXCEPT
select distinct k.pid1
from knows k 
where (select count(1)
       from(select w.pid
            from worksFor w
            where  w.cname='Apple' and w.salary<55000 
            EXCEPT
            select  k1.pid2
            from knows k1
            where k1.pid1=k.pid1
           )q)=0 order by 1;

\qecho 'Problem 7'
-- Without using set predicates, find each pairs $(s_1,s_2)$ of skills
-- such that the set of persons with skill $s_1$ is the same as the set
-- of persons with skill $s_2$.


select DISTINCT ps1.skill as s1,ps2.skill as s2
from personSkill ps1, personSkill ps2
where (select count(1) from(select ps3.pid from personSkill ps3 
                                   where ps3.skill=ps1.skill EXCEPT
                                    select ps4.pid from personSkill ps4 
                                   where ps4.skill=ps2.skill)q)=0 ;
\qecho 'Problem 8'
-- Find each pairs $(s_1,s_2,n)$ of different skills $s_1$ an $s_2$ and
-- such that (1) the number of persons with skill $s_1$ is the same as
-- the number of persons with skill $s_2$ and (2) where $n$ is the number
-- of such persons associated with $s_1$ and $s_2$.

with counting as (select ps.skill,count(ps.pid)
                  from personSkill ps
                  group by ps.skill)


select DISTINCT c1.skill as s1,c2.skill as s2,c1.count as n
from counting c1, counting c2
where c1.skill<>c2.skill and c1.count=c2.count order by 3;


\qecho 'Problem 9'

\qecho 'Problem 9a'
create or replace function numberOfSkills(c text)
returns table(pid integer,salary int, numberOfskills bigint) as 
$$
(select w.pid,w.salary,count(ps.skill)
from worksFor w, personSkill ps         
where w.pid=ps.pid and w.cname=c
group by w.pid
UNION
select w.pid,w.salary,'0'            
from worksFor w, personSkill ps
where  w.cname=c and w.pid not in ( select ps.pid from personSkill ps) group by w.pid)
$$ language sql;

\qecho 'Problem 9b'

select * from numberOfSkills('Apple') order by 3;
select * from numberOfSkills('Amazon') order by 3;
select * from numberOfSkills('ACM') order by 3;

\qecho 'Problem 9c'
create or replace function numberOfSkills(c text)
returns table(pid integer,salary int, numberOfskills bigint) as 
$$
(select DISTINCT w.pid,w.salary, (select count(1) from personSkill ps where ps.pid=w1.pid ) 
from worksFor w, personSkill ps ,worksFor w1, personSkill ps1        
where  w.cname=c and w1.pid=ps1.pid and w.pid=w1.pid and ps.skill<>ps1.skill
UNION
select w.pid,w.salary,'0'            
from worksFor w
where  w.cname=c and w.pid not in ( select ps.pid from personSkill ps))
$$ language sql;

\qecho 'Problem 9d'

select * from numberOfSkills('Apple') order by 3;
select * from numberOfSkills('Amazon')order by 3;
select * from numberOfSkills('ACM')order by 3;

\qecho 'Problem 9e'
-- Using the function {\tt numberOfSkills} but without using set
-- predicates, write the following query: ``{\it Find each pair $(c,p)$
-- where $c$ is the name of a company and where $p$ is the pid of a
-- person who (1) works for company $c$, (2) makes more than 50000 and
-- (3) has the most job skills among all the employees who work for
-- company $c$}."

create or replace function numberOfSkills(c text)
returns table(pid integer,salary int, numberOfskills bigint) as 
$$
(select w.pid,w.salary,count(ps.skill)
from worksFor w, personSkill ps         
where w.pid=ps.pid and w.cname = c
group by w.pid
UNION
(select w.pid,w.salary,0 as count          
from worksFor w
where w.cname = c
 EXCEPT select w.pid,w.salary ,0 as count            
from worksFor w, personSkill ps
where w.pid = ps.pid and w.cname = c))
$$ language sql;

select w.cname, n.pid
from worksFor w,numberOfSkills(w.cname) n
where w.pid=n.pid and w.salary>50000 and n.numberOfskills=(select max(numberOfSkills) from numberOfSkills(w.cname) )order by 1;

\qecho 'Problem 10'
CREATE TABLE P(coefficient integer,degree integer);
CREATE TABLE Q(coefficient integer,degree integer);

INSERT INTO P VALUES (2,2),(-5,1),(5,0);
INSERT INTO Q VALUES (4,4),(3,3),(1,2),(-1,1);
\qecho 'Polynomial P = 2x^2 - 5x + 5'
\qecho 'Polynomial Q = 4x^4 + 3x^3 + x^2 - x'
\qecho 'P'
select * from P order by 2;

\qecho 'Q'

select * from Q order by 2;
\qecho 'Problem 10a'
CREATE or Replace function multiplyPolynomials(polynomial_p1 text,polynomial_p2 text) returns table(coefficient integer, degree integer) as
$$
BEGIN
 return query
   execute 'select cast(sum(p1.coefficient * p2.coefficient) as integer) as coefficient, (p1.degree + p2.degree) AS degree FROM '  || polynomial_p1||' as p1,' ||polynomial_p2||' as p2 Group BY p1.degree+p2.degree' ;
   end ;
$$ language plpgsql;

\qecho 'Problem 10b.i'
select * from multiplyPolynomials('P','Q') order by 2 DESC;

\qecho 'Problem 10b.ii'
select * from multiplyPolynomials('P','P') order by 2 DESC;

\qecho 'Problem 10b.iii'
CREATE VIEW  qp as (select * from multiplyPolynomials('Q','P') );
select * from multiplyPolynomials('P','qp') order by 2 desc;
-- Connect to default database

\c postgres

-- Drop database created for this assignment
DROP DATABASE akhilesh_gowda_mandya_ramesh;





