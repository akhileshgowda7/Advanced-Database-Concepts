-- Creating database with full name


-- CREATE DATABASE dirkvangucht;

-- Connecting to database 
\c dirkvangucht;

-- Relation schemas and instances for assignment 2
/*
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
     ('ACM', 'NewYork');
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
 (1019,'Networks');

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
 (1014,1012);
*/

\qecho 'Problem 1'

-- Consider the query “Find the pid and name of each person who works
-- for Google and who has a higher salary than some other person who he
-- or she knows and who also works for Google.”

-- (a) Formulate this query in SQL by only using the EXISTS or NOT EXISTS set predicates.

select p.pid, p.pname
from   Person p
where  exists (select 1
               from   worksfor w1
               where  w1.pid = p.pid and
                      w1.cname = 'Google' and
                      exists (select 1 
                              from   worksfor w2
                              where  w1.salary > w2.salary and
                                     w2.cname = 'Google' and 
                                     exists (select 1
                                             from   knows k 
                                             where p.pid = k.pid1 and w2.pid = k.pid2)));


-- (b) Formulate this query in SQL by only using the IN, NOT IN, SOME,
-- or ALL set membership predicates.

select p.pid, p.pname
from   Person p 
where  p.pid in (select w1.pid 
                 from   worksfor w1 
                 where  w1.cname = 'Google' and
                        w1.salary > some (select w2.salary
                                          from   worksfor w2
                                          where  w2.cname = 'Google' and 
                                                 (p.pid, w2.pid) in (select k.pid1, k.pid2
                                                                     from   knows k)));

-- (c) Formulate this query in SQL without using and set predicates.

select distinct p.pid, p.pname
from   Person p, worksfor w1, worksfor w2, knows k
where  p.pid = w1.pid and 
       w1.cname = 'Google' and
       w2.cname = 'Google' and
       w1.salary > w2.salary and
       p.pid = k.pid1 and
       w2.pid = k.pid2;



\qecho 'Problem 2'

-- Consider the query “Find the cname of each company with headquarter in
-- Cupertino, but that is not located in Indianapolis, along with the
-- pid, name, and salary of each person who works for that company and
-- who has the next to lowest salary (i.e., the second lowest salary) at
-- that company.

-- (a) Formulate this query in SQL by only using the EXISTS or NOT EXISTS
-- set predicates. You can not use the set operations INTERSECT, UNION,
-- and EXCEPT.


with company as (select  c.cname
                 from    company  c
                 where   c.headquarter = 'Cupertino' and
                 not exists (select 1
                             from    companyLocation  cl
                             where   cl.cname = c.cname and cl.city = 'Indianapolis')),
     person as (select p.pid, p.pname, c.cname, w.salary
                from   company c, person p, worksFor w
                where  p.pid = w.pid and w.cname = c.cname)
select p.cname, p.pid, p.pname, p.salary
from   person p
where  exists (select 1
               from   person   p1
               where  p1.cname = p.cname and p1.salary < p.salary) and
       not exists (select 1
                   from   person  p1, person   p2
                   where  p1.cname = p.cname and
                          p2.cname = p1.cname and
                          p2.salary < p1.salary  and 
                          p1.salary < p.salary) order by 1,2;

-- (b) Formulate this query in SQL by only using the IN, NOT IN, SOME, or
-- ALL set membership predicates. You can not use the set oper- ations
-- INTERSECT, UNION, and EXCEPT.


with company as (select  c.cname
                 from    company  c
                 where   c.headquarter = 'Cupertino' and
                         c.cname not in (select cl.cname 
                                         from   companyLocation  cl
                                         where  cl.city = 'Indianapolis')),
     person as (select p.pid, p.pname, c.cname, w.salary
                from   company c, person p, worksFor w
                where  p.pid = w.pid and w.cname = c.cname)
select p.cname, p.pid, p.pname, p.salary
from   person p
where  p.cname in (select p1.cname
                   from   person   p1
                   where  p1.salary < p.salary) and
       p.cname not in (select p1.cname
                       from   person  p1, person   p2
                       where  p2.cname = p1.cname and
                              p2.salary < p1.salary  and 
                              p1.salary < p.salary) order by 1,2;


-- (c) Formulate this query in SQL without using set predicates.

with company as (select  c.cname
                 from    company  c
                 where   c.headquarter = 'Cupertino'
                 except
                 select  c.cname
                 from    companyLocation  c
                 where   c.city = 'Indianapolis'),
     person as (select c.cname, p.pid, p.pname, w.salary
                from   company c, person p, worksFor w
                where  p.pid = w.pid and w.cname = c.cname)
select p.*
from   person p, person p1
where  p1.cname = p.cname and p1.salary < p.salary
except
select p.*
from   person p, person p1, person p2
where  p1.cname = p.cname and
       p2.cname = p.cname and
       p2.salary < p1.salary  and 
       p1.salary < p.salary order by 1,2;


\qecho 'Problem 3'

-- Consider the query “Find each (c, p) pair where c is the cname of a 
-- company and p is the pid of a person who works for that company and 
-- who is known by all other persons who work for that company.

-- (a) Formulate this query in SQL by only using the EXISTS or NOT EXISTS set predicates. 
-- You can not use the set operations INTERSECT, UNION, and EXCEPT.

select w.cname, w.pid
from   worksFor w
where  not exists (select 1
                   from   worksFor w1
                   where  w1.cname = w.cname and w1.pid <> w.pid and
                          not exists (select 1
                                      from   Knows k
                                      where  w1.pid = k.pid1 and w.pid = k.pid2))
order by 1,2;



-- (b) Formulate this query in SQL by only using the IN, NOT IN, SOME, or ALL set membership predicates. 
-- You can not use the set oper- ations INTERSECT, UNION, and EXCEPT.

select w.cname, w.pid
from   worksFor w
where  w.cname not in (select w1.cname
                       from   worksFor w1
                       where  w1.pid <> w.pid and
                              (w1.pid, w.pid) not in (select k.pid1, k.pid2
                                                      from   Knows k))
order by 1,2;

-- (c) Formulate this query in SQL without using set predicates.

select w.cname, w.pid
from   worksFor w
except
(
select q.cname, q.pid
from 
  (select w.cname, w.pid, w1.cname as w1cname, w1.pid as w1pid
   from   worksFor w, worksFor w1
   where  w1.cname = w.cname and w1.pid <> w.pid 
   except  
   select w.cname, w.pid, w1.cname as w1cname, w1.pid as w1pid
   from   worksFor w, worksFor w1, knows k
   where  w1.pid = k.pid1 and w.pid = k.pid2) q
)
order by 1,2;



\qecho 'Problem 4'

-- Consider the query “Find each skill that is not a jobskill of any person
-- who works for Yahoo or for Netflix.

-- (a) Formulate this query in SQL using subqueries and set predicates. 
-- You can not use the set operations INTERSECT, UNION, and EXCEPT.

select s.skill
from   Skill s
where  s.skill not in (select ps.skill
                       from   personSkill ps
                       where  ps.pid in (select w.pid
                                         from   worksFor w
                                         where  w.cname = 'Yahoo' or w.cname = 'Netflix'));


-- (b) Formulate this query in SQL without using predicates.

select s.skill
from   Skill s
except
select s.skill
from   Skill s, personSkill ps, worksFor w
where  s.skill = ps.skill and
       ps.pid  = w.pid and
       (w.cname = 'Yahoo' or w.cname = 'Netflix');


\qecho 'Problem 5'

--  Consider the query “Find the pid and name of each person who
--  manages all but 1 person who work for Google.


-- (a) Formulate this query in SQL using subqueries and set predicates. 
-- You can not use the set operations INTERSECT, UNION, and EXCEPT.

with personGoogle as (select p.pid, p.pname
                      from   person p
                      where  p.pid in (select w.pid from worksFor w where w.cname = 'Google'))
select p.pid, pname
from   personGoogle p
where  exists (select 1 from personGoogle q 
               where  (q.pid, p.pid) not in (select * from hasmanager)) and 
       not exists (select 1
                   from   personGoogle q1, personGoogle q2
                   where  q1.pid <> q2.pid and 
                          (q1.pid, p.pid) not in (select * from hasmanager) and 
                          (q2.pid, p.pid) not in (select * from hasmanager));  

-- Actually, we can drop the first 'exists' since it is always true because
-- one can not be a manager of one self.

with personGoogle as (select p.pid, p.pname
                      from   person p
                      where  p.pid in (select w.pid from worksFor w where w.cname = 'Google'))
select p.pid, pname
from   personGoogle p
where  not exists (select 1
                   from   personGoogle q1, personGoogle q2
                   where  q1.pid <> q2.pid and 
                          (q1.pid, p.pid) not in (select * from hasmanager) and 
                          (q2.pid, p.pid) not in (select * from hasmanager));  

-- (b) Formulate this query in SQL without using set predicates.
-- Needs work


with personGoogle as (select p.pid, p.pname
                      from   person p, worksFor w
                      where  p.pid = w.pid and w.cname = 'Google')
select p.pid, pname
from   personGoogle p
except
(select q.ppid, q.ppname
 from  
   (select p.pid as ppid, p.pname as ppname, q1.*, q2.*
    from   personGoogle p, personGoogle q1, personGoogle q2
    where  q1.pid <> q2.pid 
    except
    (select p.*, q1.*, q2.*
     from   personGoogle p, personGoogle q1, personGoogle q2, hasmanager hm
     where  q1.pid = hm.eid and p.pid = hm.mid
     union
     select p.*, q1.*, q2.*
     from   personGoogle p, personGoogle q1, personGoogle q2, hasmanager hm
     where  q2.pid = hm.eid and p.pid = hm.mid)) q
 );








\qecho 'Problem 6'
-- Problem 1 in RA SQL2

with   worksForGoogle as (select pid, salary from worksfor where cname = 'Google')
select distinct p.pid, p.pname
from   Person p
       JOIN worksforGoogle w1 ON (p.pid = w1.pid)
       JOIN worksforGoogle w2 ON (w1.salary > w2.salary)
       JOIN Knows ON (p.pid = pid1 and w2.pid = pid2);



\qecho 'Problem 7'
-- Problem 2 in RA SQL

with company as (select  cname
                 from    company 
                 where   headquarter = 'Cupertino'
                 except
                 select  cname
                 from    companyLocation
                 where   city = 'Indianapolis'),
     person as (select p.pid, p.pname, c.cname, w.salary
                from   person p 
                       JOIN worksfor w ON (p.pid = w.pid)
                       JOIN company c ON  (w.cname = c.cname))
select p.*
from   person p
       JOIN person p1 ON p1.cname = p.cname and p1.salary < p.salary
except
select p.*
from   person p
       JOIN person p1 ON (p1.cname = p.cname and p1.salary < p.salary)
       JOIN person p2 ON (p2.cname = p.cname and
                          p2.salary < p1.salary  and 
                          p1.salary < p.salary)
order by 1,2;


\qecho 'Problem 8'
-- Problem 3 in RA SQL

select cname, pid
from   worksFor
except
(
select q.cname, q.pid
from 
  (select w.cname, w.pid, w1.cname as w1cname, w1.pid as w1pid
   from   worksFor w
          JOIN worksFor w1 ON (w1.cname = w.cname and w1.pid <> w.pid)
   except  
   select w.cname, w.pid, w1.cname as w1cname, w1.pid as w1pid
   from   worksFor w
          JOIN worksFor w1 ON (w1.cname = w.cname)
          JOIN Knows k ON (w1.pid = pid1 and w.pid = pid2)) q
)  
order by 1,2;


\qecho 'Problem 9'
-- Problem 4 in RA SQL

select skill
from   Skill
except
select s.skill
from   Skill s
       JOIN personSkill ps ON (s.skill = ps.skill)
       JOIN worksFor w ON (ps.pid  = w.pid and (w.cname = 'Yahoo' or w.cname = 'Netflix'));

\qecho 'Problem 10'
-- Problem 5 in RA SQL

with personGoogle as (select p.pid, p.pname
                      from   person p JOIN worksFor w ON (p.pid = w.pid)
                      where  w.cname = 'Google')
select p.pid, pname
from   personGoogle p
except
(select q.ppid, q.ppname
 from  
   (select p.pid as ppid, p.pname as ppname, q1.*, q2.*
    from   personGoogle p
           CROSS JOIN 
           (personGoogle q1 JOIN personGoogle q2 on q1.pid <> q2.pid)
    except
    (select p.*, q1.*, q2.*
     from   personGoogle p
            JOIN hasmanager hm ON (p.pid = hm.mid)
            JOIN personGoogle q1 ON (q1.pid = hm.eid)
            CROSS JOIN personGoogle q2
     union
     select p.*, q1.*, q2.*
     from   personGoogle p
            JOIN hasmanager hm ON (p.pid = hm.mid)
            JOIN personGoogle q2 ON (q2.pid = hm.eid)
            CROSS JOIN personGoogle q1)) q
 );

\qecho 'Problem 16'

-- Create a view {\tt Triangle} that contains each triple of pids of different persons $(p_1,p_2,p_3)$
-- that mutually know each other.   

-- Then test your view.

create view Triangle as (
select  p1.pid as p1, p2.pid as p2, p3.pid as p3
from    Person p1, Person p2, Person p3
where   (p1.pid, p2.pid) in (select * from knows) and
           (p2.pid, p1.pid) in (select * from knows) and
           (p1.pid, p3.pid) in (select * from knows) and
           (p3.pid, p1.pid) in (select * from knows) and
           (p2.pid, p3.pid) in (select * from knows) and
           (p3.pid, p2.pid) in (select * from knows) and
           p1.pid <> p2.pid and p1.pid <> p3.pid and p2.pid <> p3.pid);

select p1, p2, p3 from Triangle;

\qecho 'Problem 17'


-- Define a parameterized view SalaryBelow(cname text, salary integer) that returns, 
-- for a given company identified by cname and a given salary value, 
-- the subrelation of Person of persons who work for company cname and whose salary is strictly below salary.

-- Test your view for the parameter values (’IBM’,60000), (’IBM’,50000), and (’Apple’,65000).

create or replace function SalaryBelow(cname text, salary integer)
  returns table (pid integer, pname text, city text) as
  $$
    select pid, pname, city
    from   Person
    where  pid in (select w.pid
                   from   worksFor w 
                   where  w.salary < SalaryBelow.salary and w.cname = SalaryBelow.cname);
  $$ language sql;

select * from SalaryBelow('IBM', 60000);

select * from SalaryBelow('IBM', 50000);

select * from SalaryBelow('Apple', 65000);

\qecho 'Problem 18'

-- Define a parameterized view KnowsPersonAtCompany(p integer, c text) that returns
-- for a person with pid p the subrelation of Person of persons who p knows and 
-- who work for the company with cname c.

-- Test you view for the parameters (1001, ‘Amazon’), (1001,‘Apple’), and (1015,‘Netflix’).

create or replace function KnowsPersonAtCompany(p integer, c text)
  returns table (pid integer, pname text, city text) as
  $$
    select Person.pid, Person.pname, Person.city
    from   Person 
    where  Person.pid in (select pid2
                          from   Knows
                          where  pid1 = p)
           and
           Person.pid in (select w.pid 
                          from   worksFor w 
                          where  w.cname = c);
  $$ language sql;

select * from KnowsPersonAtCompany(1001, 'Amazon');

select * from KnowsPersonAtCompany(1001, 'Apple');

select * from KnowsPersonAtCompany(1015, 'Netflix');

\qecho 'Problem 19'

create or replace function KnownByPersonAtCompany(p integer, c text)
  returns table (pid integer, pname text, city text) as
  $$
    select pid, pname, city
    from   Person
    where  pid in (select pid1
                   from   Knows
                   where  pid2 = p)
          and
          pid in (select w.pid 
                  from   worksFor w 
                  where  w.cname = c);
  $$ language sql;


select * from KnownByPersonAtCompany(1001, 'Amazon');

select * from KnownByPersonAtCompany(1001, 'Apple');

select * from KnownByPersonAtCompany(1015, 'Netflix');


\qecho 'Problem 20'


create or replace recursive view sameGeneration (n1,n2)                                                                                                                                     
 as  ((select  e.parent as n1, e.parent as n2
       from    Tree e
       union   
       select  e.child as n1, e.child as n2
       from    Tree e)                                                                                                                                                             
       union                                                                                                                                                                   
       select  e1.child, e2.child
       from    Tree e1, sameGeneration sg, Tree e2
       where   e1.parent = sg.n1 and e2.parent = sg.n2 );   

 
select * from sameGeneration;


-- Connect to default database
\c postgres;

-- Drop database created for this assignment
-- DROP DATABASE dirkvangucht;

/*

