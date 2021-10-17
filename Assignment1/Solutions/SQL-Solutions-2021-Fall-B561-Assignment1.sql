-- Creating database with full name

-- This is a test


CREATE DATABASE dirkvangucht;

-- Connecting to database 
\c dirkvangucht;

-- Relation schemas and instances for assignment 1

\qecho 'Problem 1'

-- Provide 4 conceptually different examples that illustrate how the
-- presence or absence of primary and foreign keys affect insert and
-- deletes in these relations.  To solve this problem, you will need to
-- experiment with the relation schemas and instances for this
-- assignment.  For example, you should consider altering primary keys
-- and foreign key constraints and then consider various sequences of
-- insert and delete operations.  You may need to change some of the
-- relation instances to observe the desired effects.  Certain inserts
-- and deletes should succeed but other should generate error
-- conditions.  (Consider the lecture notes about keys, foreign keys,
-- and inserts and deletes as a guide to solve this problem.)


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
     (1013,'Netflix', 55000),
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
   ('IBM', 'NewYork');

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
 (1013,'AI'),
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
 (1014, 1012);


\qecho 'Problem 1 conceptual example 1'
INSERT INTO Company VALUES ('Apple', 'Bloomington');
-- Fails because cname is primary key and there already is tuple with 'Apple' in Company.
-- Error message:
-- ERROR:  duplicate key value violates unique constraint "company_pkey"
-- DETAIL:  Key (cname)=(Apple) already exists.

\qecho 'Problem 1 conceptual example 2'
INSERT INTO hasManager VALUES ('1001', '1020');
-- Fails because mid is a foreign key referencing pid in Person and 
-- Person 1020 is not present in Person
-- Error message:
-- ERROR:  insert or update on table "hasmanager" violates foreign key constraint "hasmanager_mid_fkey"
-- DETAIL:  Key (mid)=(1020) is not present in table "person".


\qecho 'Problem 1 conceptual example 3'
DELETE FROM Person WHERE pid = 1001;
-- Fails because there are relations whose foreign key(s) referencing the 
-- the primary key pid value in Person
-- Error message
-- ERROR:  update or delete on table "person" violates foreign key constraint "worksfor_pid_fkey" on table "worksfor"
-- DETAIL:  Key (pid)=(1001) is still referenced from table "worksfor".

\qecho 'Problem 1 conceptual example 4'
DELETE FROM Skill WHERE skill = 'AI';
-- This succeeds and because of ON DELETE CASCADE in personSkill 
-- on foreign key skill in that relation, the tuple in personSkill with
-- skill value 'AI' are deleted
DELETE FROM Skill;
-- This also succeeds for the same reason.
-- After this, the Skill and personSkill relation are empty
-- We now repopulate the Skill and personSkill table to restore the database


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
 (1013,'AI'),
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
*/

\qecho 'Problem 2'
-- Find the pid, pname of each person who (a) lives in Bloomington, (b)
-- works for a company where he or she earns a salary that is higher than
-- 30000, and (c) has at least one manager.

select p.pid, p.pname
from   Person p
where  p.city = 'Bloomington' and
       p.pid in (select  pw.pid
                 from    worksFor pw
                 where   pw.salary > 30000) and
       exists (select 1
               from   hasManager hm
               where  hm.eid = p.pid) order by 1,2;

/*
-- Alternatively,

select distinct p.pid, p.pname
from   Person p, worksFor pw, hasManager hm
where  p.city = 'Bloomington' and
       p.pid = pw.pid and pw.salary > 30000 and
       hm.eid = p.pid order by 1,2;
*/


\qecho 'Problem 3'
-- Find the pairs $(c_1, c_2)$ of names of companies whose headquarters
-- are located in the same city.

select c1.cname, c2.cname
from   company c1, company c2
where  c1.cname <> c2.cname and
       c1.headquarter = c2.headquarter order by 1,2;


\qecho 'Problem 4'
-- Find the pid and pname of each person who lives in a city that is
-- different than each city in which his or her managers live.
-- (Persons who have no manager should not be included in the answer.)


select p.pid, p.pname
from   Person p
where  exists (select 1
               from   hasManager hm
               where  hm.eid =  p.pid) and
       p.city not in (select m.city
                      from   Person m
                      where  (p.pid, m.pid) in (select hm1.eid, hm1.mid
                                                from   hasManager hm1)) order by  1;

/*
-- Alternatively,
select q.pid, q.pname
from 
  (select p.*, hm.*
   from   Person p, hasManager hm
   where  hm.eid =  p.pid 
   except
   select p.*, hm.*
   from   Person p, hasManager hm, Person m, hasManager hm1
   where  p.city = m.city and p.pid = hm1.eid and m.pid = hm1.mid) q
order by 1;
*/


\qecho 'Problem 5'
-- Find each skill that is the skill of at most 2 persons.

select s.skill
from   Skill s
except
select s.skill
from   Skill s
where  exists (select 1
               from   personSkill ps1, 
                      personSkill ps2, 
                      personSkill ps3
               where  ps1.skill = s.skill and 
                      ps2.skill = s.skill and
                      ps3.skill = s.skill and
                      ps1.pid <> ps2.pid and 
                      ps2.pid <> ps3.pid and 
                      ps1.pid <> ps3.pid)
order by 1;		      

/*
-- Alternatively,

select s.skill
from   Skill s
except
select s.skill
from   Skill s, personSkill ps1, 
                personSkill ps2, 
                personSkill ps3
where  ps1.skill = s.skill and 
       ps2.skill = s.skill and
       ps3.skill = s.skill and
       ps1.pid <> ps2.pid and 
       ps2.pid <> ps3.pid and 
       ps1.pid <> ps3.pid
order by 1;       
*/


\qecho 'Problem 6'
-- Find the pid, pname, and salary of each employee who has at least two
-- managers such that these managers have a common job skill but provided
-- that it is not the `Networks' skill.

select  p.pid, p.pname, pw.salary
from    Person p, worksFor pw
where   p.pid = pw.pid and
        exists (select 1
                from   hasManager hm1, hasManager hm2
                where  hm1.eid = p.pid and
                       hm2.eid = p.pid and
                       hm1.mid <> hm2.mid and
                       (hm1.mid, hm2.mid) in (select ps1.pid, ps2.pid
                                              from   personSkill ps1, personSkill ps2
                                              where  ps1.skill = ps2.skill and ps1.skill <> 'Networks'))
order by 1;

/*
-- Alternatively,

select  distinct p.pid, p.pname, pw.salary
from    Person p, worksFor pw,
        hasManager hm1, hasManager hm2,
	personSkill ps1, personSkill ps2
where   p.pid = pw.pid and
        hm1.eid = p.pid and
        hm2.eid = p.pid and
        hm1.mid <> hm2.mid and
        hm1.mid = ps1.pid and
	hm2.mid = ps2.pid and
        ps1.skill = ps2.skill and
	ps1.skill <> 'Networks'
order by 1;
*/


\qecho 'Problem 7'
-- Find the cname of each company that not only employs persons
-- who live in MountainView.
-- (In other words, there exists at least one employee of such a company
-- who does not live in MountainView.)


select c.cname
from   company c
where  exists (select pw.pid
               from   worksFor pw
               where  pw.cname = c.cname and
                      pw.pid not in  (select p.pid
                                      from   person p
                                      where  p.city = 'MountainView'))
order by 1;

/*
-- Alternatively,

select pw.cname
from   worksFor pw
except
select pw.cname
from   worksFor pw, person p
where  pw.pid = p.pid and
       p.city = 'MountainView'
order by 1;
*/

\qecho 'Problem 8'
-- For each company, list its name along with the highest salary made by
-- employees who work for it.  

select pw.cname, pw.salary
from   worksfor pw
where  pw.salary >= all (select pw1.salary
                         from   worksfor pw1
                         where  pw1.cname = pw.cname)
order by 1;


-- Alternatively,

/*
select pw.cname, pw.salary
from   worksfor pw
except
select pw.cname, pw.salary
from   worksfor pw, worksfor pw1
where  pw1.cname = pw.cname and pw.salary < pw1.salary
order by 1;
*/


\qecho 'Problem 9'
-- Find the pid and pname of each employee who has a salary that is
-- higher than the salary of each of his or her managers.  (Employees who
-- have no manager should not be included.)

select  p.pid, p.pname
from    person p
where   exists (select 1 from hasManager hm where hm.eid = p.pid) and
        p.pid in (select pw.pid
                  from   worksfor pw
                  where  pw.salary > all (select m.salary
                                          from   worksfor m, hasManager hm1
                                          where  hm1.eid = p.pid and hm1.mid = m.pid))
order by 1;

/*
-- Alternatively,
select q.ppid, q.pname
from 
  (select p.pid as ppid, p.pname, hm.*, pw.*
   from   person p, hasManager hm, worksfor pw
   where  p.pid = hm.eid and
          p.pid = pw.pid
   except
   select p.pid, p.pname, hm.*, pw.*
   from   person p, hasManager hm, worksfor pw,
          worksfor m, hasManager hm1
   where  p.pid = hm.eid and
          p.pid = pw.pid and
          pw.salary <= m.salary and
          hm1.eid = p.pid and m.pid = hm1.mid) q       
order by 1;
*/

\qecho 'Problem 10'
select distinct p.pid, p.pname, w.cname, w.salary
from   Person p, worksFor w
where  p.pid = w.pid and
       p.city = 'Bloomington' and
       40000 <= w.salary and
       w.cname <> 'Apple';


\qecho 'Problem 11'
select p.pid, p.pname
from   Person p
where  exists (select 1
               from  Company c, worksFor w
               where c.cname = w.cname and 
                     p.pid = w.pid and 
                     c.headquarter = 'LosGatos' and 
                     exists (select 1
                             from   hasManager hm, Person m
                             where  hm.eid = p.pid and 
                                    hm.mid = m.pid and 
                                    m.city <> 'LosGatos'));


\qecho 'Problem 12'
select s.skill
from   Skill s
where  not exists (select 1
                   from   Person p, personSkill ps
                   where  p.pid = ps.pid and 
                          ps.skill = s.skill and 
                          p.city = 'Bloomington');

\qecho 'Problem 13'
select m.pid, m.pname
from   Person m 
where  not exists (select 1
                   from   hasManager hm
                   where  hm.mid = m.pid and 
                          not exists (select 1
                                      from   Person e
                                      where  hm.eid = e.pid and 
                                             e.city = m.city));



\qecho 'Problem 18'
-- Each person works for a company and has at least two job skills.

select not exists (select 1
                   from   Person p
                   where  not(exists (select 1
                                      from   worksFor w
                                      where  w.pid = p.pid)
                              and
                              not exists (select 1
                                          from   personSkill ps1, personSkill ps2
                                          where  ps1.pid = p.pid and ps2.pid = p.pid and
                                                 ps1.skill <> ps2.skill))) as "constraintSatisfied";

\qecho 'Problem 19'

-- Some person has a salary that is strictly higher than the salary of
-- each of his or her managers.

select exists (select 1
               from   Person p, worksFor pw
               where  p.pid = pw.pid and
                      not exists (select 1
                                  from   hasManager hm, worksFor mw
                                  where  hm.eid = p.pid and hm.mid = mw.pid and
                                         pw.salary <= mw.salary)) as "constraintSatisfied";



\qecho 'Problem 20'
-- Each employee and his or her managers work for the same company.

select not exists (select 1
                   from   hasManager em, worksFor e, worksFor m
                   where  em.eid = e.pid and
                          em.mid = m.pid and
                          e.cname <> m.cname) as "constaintSatisfied";

-- Connect to default database
\c postgres;

-- Drop database created for this assignment
DROP DATABASE dirkvangucht;

