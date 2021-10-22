-- Script for Assignment 2

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



create table tree(parent integer,
                  child integer);

insert into tree values
 (1,2),
 (1,3),
 (1,4),
 (2,5),
 (2,6),
 (3,7),
 (5,8),
 (8,9),
 (8,10),
 (8,11),
 (7,12),
 (7,13),
 (12,14),
 (14,15);


\qecho 'Problem 1'

-- Consider the query “Find the pid and name of each person who works
-- for Google and who has a higher salary than some other person who he
-- or she knows and who also works for Google.”

-- (a) Formulate this query in SQL by only using the EXISTS or NOT EXISTS set predicates.

select p.pid,p.pname 
from person p 
where exists(select 1 
             from worksFor w 
             where p.pid=w.pid and w.cname='Google' and exists(select 1 
                                                               from knows k 
                                                               where p.pid=k.pid1 and exists(select 1 
                                                                                             from worksFor w1, person p1 
                                                                                             where p1.pid=k.pid2 and w1.pid=k.pid2 and w1.cname='Google' and w.salary>w1.salary)));

-- (b) Formulate this query in SQL by only using the IN, NOT IN, SOME,
-- or ALL set membership predicates.
select p.pid,p.pname 
from person p where p.pid IN (select w.pid 
                              from worksFor w 
                              where w.cname='Google' and p.pid IN(select k.pid1 
                                                                  from knows k 
                                                                  where  k.pid2 IN(select p1.pid 
                                                                                   from worksFor w1, person p1 
                                                                                   where p1.pid=w1.pid and w1.pid=k.pid2 and w1.cname='Google' and w.salary>w1.salary)));

-- (c) Formulate this query in SQL without using set predicates.

select p.pid,p.pname 
from person p,worksFor w ,knows k,worksFor w1, person p1 
where p.pid=w.pid and w.cname='Google' and p.pid=k.pid1 and p1.pid=k.pid2 and w1.pid=k.pid2 and w1.cname='Google' and w.salary>w1.salary;
                                                                              

\qecho 'Problem 2'

-- Consider the query “Find the cname of each company with headquarter in
-- Cupertino, but that is not located in Indianapolis, along with the
-- pid, name, and salary of each person who works for that company and
-- who has the next-to-lowest salary at that company.

-- (a) Formulate this query in SQL by only using the EXISTS or NOT EXISTS
-- set predicates. You can not use the set operations INTERSECT, UNION,
-- and EXCEPT.

select DISTINCT c.cname, p.pid,p.pname,w.salary from person p, worksfor w,companyLocation l,company c 
where p.pid=w.pid and c.cname=l.cname and c.headquarter='Cupertino' and l.city<>'Indianapolis' 
and exists(select 1 from  worksfor w1 where w1.salary<w.salary and w.cname=w1.cname 
    and not exists(select 1 from worksfor w2,worksFor w3  where  w2.salary<w.salary and w3.salary<w2.salary)) ;


-- (b) Formulate this query in SQL by only using the IN, NOT IN, SOME, or
-- ALL set membership predicates. You can not use the set oper- ations
-- INTERSECT, UNION, and EXCEPT.
select DISTINCT c.cname, p.pid,p.pname,w.salary from person p, worksfor w,companyLocation l,company c 
where p.pid=w.pid and c.cname=l.cname and c.headquarter='Cupertino' and l.city<>'Indianapolis' and w.cname 
IN(select w1.cname from  worksfor w1 where w1.salary<w.salary  and w.cname 
    not IN(select w2.cname from worksfor w2,worksFor w3  where  w2.salary<w.salary and w3.salary<w2.salary)) ;


-- (c) Formulate this query in SQL without using set predicates.
                                                                                                                                                                    
select q.cname, q.pid,q.pname,q.salary                                                                                                                                                                    
from(select c.cname, p.pid,p.pname,w.salary
from person p, worksfor w,companyLocation l,company c,worksfor w1
where p.pid=w.pid and c.cname=l.cname and c.headquarter='Cupertino' and l.city<>'Indianapolis' and w1.salary<w.salary and w.cname=w1.cname EXCEPT 
select c.cname, p.pid,p.pname,w.salary from person p, worksfor w,companyLocation l,company c,worksfor w1,worksfor w2,worksFor w3 
where p.pid=w.pid and c.cname=l.cname and c.headquarter='Cupertino' and l.city<>'Indianapolis' and w1.salary<w.salary and w.cname=w1.cname 
and w2.salary<w.salary and w3.salary<w2.salary)q;



\qecho 'Problem 3'
-- Consider the query “Find each (c, p) pair where c is the cname of a 
-- company and p is the pid of a person who works for that company and 
-- who is known by all other persons who work for that company.

-- (a) Formulate this query in SQL by only using the EXISTS or NOT EXISTS set predicates. 
-- You can not use the set operations INTERSECT, UNION, and EXCEPT.

select w.cname,p.pid from person p, worksFor w where p.pid=w.pid 
and not exists(select 1 from worksFor w2,person p2 where  w2.pid=p2.pid and w.cname=w2.cname and w.pid<>w2.pid 
    and not exists(select 1 from knows k where w.pid=k.pid2 and w2.pid=k.pid1)) order by p.pid;

-- (b) Formulate this query in SQL by only using the IN, NOT IN, SOME, or ALL set membership predicates. 
-- You can not use the set oper- ations INTERSECT, UNION, and EXCEPT.

select w.cname,p.pid from person p, worksFor w where p.pid=w.pid and w.cname 
not IN(select w2.cname from worksFor w2,person p2 where  w2.pid=p2.pid and w.pid<>w2.pid and w.pid 
    not IN(select k.pid2 from knows k where w2.pid=k.pid1))order by p.pid;


-- (c) Formulate this query in SQL without using set predicates.

select q1.wcname,q1.ppid 
from ((SELECT w.cname as wcname,p.pid as ppid 
      from person p , worksFor w 
      where p.pid=w.pid)
      EXCEPT (select q.wcname,q.ppid 
               from ((select w.cname as wcname, p.pid as ppid, p1.pid,w1.pid
                     from worksFor w,person p, worksFor w1, person p1
               where  p.pid=w.pid and p1.pid=w1.pid and w.cname=w1.cname and w.pid<>w1.pid) EXCEPT (select w.cname as wcname,p.pid as ppid,p1.pid,w1.pid
                                                                                                   from person p,person p1,worksFor w, worksFor w1, knows k 
                                                                                                   where p.pid=w.pid and p1.pid=w1.pid and w.cname=w1.cname and w.pid<>w1.pid and w.pid=k.pid2 and w1.pid=k.pid1))q))q1 order by q1.ppid;


\qecho 'Problem 4'

-- Consider the query “Find each skill that is not a jobskill of any person
-- who works for Yahoo or for Netflix.

-- (a) Formulate this query in SQL using subqueries and set predicates. 
-- You can not use the set operations INTERSECT, UNION, and EXCEPT.

select s.skill from skill s where  not exists (select 1 from personSkill ps,person p,worksFor w where s.skill=ps.skill and p.pid=ps.pid and p.pid=w.pid and (w.cname='Yahoo' OR w.cname='Netflix'));

-- (b) Formulate this query in SQL without using predicates.
select s.skill from skill s  EXCEPT (select ps.skill from personSkill ps,person p,worksFor w where p.pid=ps.pid and p.pid=w.pid and (w.cname='Yahoo' OR w.cname='Netflix'));

\qecho 'Problem 5'

--  Consider the query “Find the pid and name of each person who
--  manages all but 1 person who work for Google.

-- (a) Formulate this query in SQL using subqueries and set predicates. 
-- You can not use the set operations INTERSECT, UNION, and EXCEPT.
select p.pid,p.pname from person p, hasManager h where p.pid=h.mid and not exists(select 1 from hasManager h2,worksFor w2 where h2.eid=w2.pid and w2.cname='Google' and h.mid<>h2.mid);

-- (b) Formulate this query in SQL without using set predicates.
-- Needs work
select p.pid,p.pname from person p, hasManager h where p.pid=h.mid EXCEPT(select p.pid,p.pname from hasManager h2,worksFor w2,hasManager h,person p where h2.eid=w2.pid and w2.cname='Google' 
    and h.mid<>h2.mid and p.pid=h.mid );


\qecho 'Problem 6'
-- Problem 1 in RA SQL2

select DISTINCT p.pid,p.pname 
from person p JOIN worksFor w on (p.pid=w.pid and w.cname='Google') JOIN knows k on (p.pid=k.pid1 ) JOIN worksFor w1 ON ( w1.pid=k.pid2 and w1.cname='Google'and w.salary>w1.salary) 
JOIN person p1 on (p1.pid=k.pid2);
 

\qecho 'Problem 7'
-- Problem 2 in RA SQL

select DISTINCT q.cname, q.pid,q.pname,q.salary                                                                                                                                                                    
from(select c.cname, p.pid,p.pname,w.salary
from person p JOIN worksfor w on(p.pid=w.pid) JOIN company c on (c.headquarter='Cupertino' and c.cname=w.cname) JOIN companyLocation l on (l.city<>'Indianapolis') JOIN worksfor w1 on (w1.salary<w.salary and w.cname=w1.cname)
 EXCEPT 
select c.cname, p.pid,p.pname,w.salary from person p JOIN worksfor w on (p.pid=w.pid) JOIN company c on (c.headquarter='Cupertino' and c.cname=w.cname) join companyLocation l on (l.city<>'Indianapolis') JOIN worksfor w1 on(w1.salary<w.salary and w.cname=w1.cname) JOIN worksfor w2 on (w2.salary<w.salary) JOIN worksFor w3 on (w3.salary<w2.salary))q;


\qecho 'Problem 8'
-- Problem 3 in RA SQL
select q1.wcname,q1.ppid 
from ((SELECT w.cname as wcname,p.pid as ppid 
      from person p JOIN worksFor w on(p.pid=w.pid))
      EXCEPT (select q.wcname,q.ppid 
               from ((select w.cname as wcname, p.pid as ppid, p1.pid,w1.pid
                     from person p JOIN worksFor w on(p.pid=w.pid) JOIN worksFor w1 on (w.cname=w1.cname and w.pid<>w1.pid) JOIN person p1 on (p1.pid=w1.pid)) EXCEPT (select w.cname as wcname,p.pid as ppid,p1.pid,w1.pid
                                                                                                                                                                       from person p JOIN worksFor w on (p.pid=w.pid) JOIN worksFor w1 on (w.cname=w1.cname and w.pid<>w1.pid) JOIN person p1 on (p1.pid=w1.pid)JOIN knows k on (w.pid=k.pid2 and w1.pid=k.pid1)))q))q1 order by q1.ppid;


\qecho 'Problem 9'
-- Problem 4 in RA SQL
select DISTINCT s.skill from skill s  EXCEPT (select ps.skill from person p JOIN personSkill ps on (p.pid=ps.pid) JOIN worksFor w ON (p.pid=w.pid and (w.cname='Yahoo' OR w.cname='Netflix')));

\qecho 'Problem 10'
-- Problem 5 in RA SQL
select DISTINCT p.pid,p.pname from person p JOIN hasManager h on(p.pid=h.mid) EXCEPT(select p.pid,p.pname from person p JOIN hasManager h on(p.pid=h.mid) JOIN worksFor w2 on (w2.cname='Google') JOIN hasManager h2 on (h2.eid=w2.pid and h.mid<>h2.mid) );




\qecho 'Problem 16'

-- Create a view {\tt Triangle} that contains each triple of pids of different persons $(p_1,p_2,p_3)$
-- that mutually know each other.  
CREATE VIEW triangle AS select p1.pid as ps1,p2.pid as ps2,p3.pid as ps3 from person p1,person p2,person p3, knows k,knows k2,knows k3,knows k4,knows k5,knows k6 where p1.pid=k.pid1 and p2.pid=k.pid2 and p2.pid=k2.pid1 and p3.pid=k2.pid2 and p1.pid=k3.pid1 and p3.pid=k3.pid2 and p2.pid=k4.pid1 and p1.pid=k4.pid2 and p3.pid=k5.pid1 and p2.pid=k5.pid2 and p3.pid=k6.pid1 and p1.pid=k6.pid2 ; 

-- Then test your view.
select *from triangle;

\qecho 'Problem 17'


-- Define a parameterized view SalaryBelow(cname text, salary integer) that returns, 
-- for a given company identified by cname and a given salary value, 
-- the subrelation of Person of persons who work for company cname and whose salary is strictly below salary.
CREATE FUNCTION salaryBelow(cnameW text, salaryW integer) RETURNS TABLE( pid integer,pname text,city text) AS $$ select p.pid,p.pname,p.city from worksFor w,person p where p.pid=w.pid and w.salary < salaryW and w.cname = cnameW; $$ LANGUAGE SQL;


-- Test your view for the parameter values (’IBM’,60000), (’IBM’,50000), and (’Apple’,65000).
select * from salaryBelow ('IBM',60000);
select * from salaryBelow('IBM',50000);
select * from salaryBelow('Apple',65000);


\qecho 'Problem 18'

-- Define a parameterized view KnowsPersonAtCompany(p integer, c text) that returns
-- for a person with pid p the subrelation of Person of persons who p knows and 
-- who work for the company with cname c.
CREATE FUNCTION KnowsPersonAtCompany(p integer, c text) RETURNS TABLE( pid integer,pname text,city text) AS $$ select p2.pid ,p2.pname,p2.city from person p1, person p2, knows k,worksFor w where p1.pid=k.pid1 and p2.pid=k.pid2 and p1.pid=p and w.pid = p2.pid and w.cname=c;$$ LANGUAGE SQL ;

-- Test you view for the parameters (1001, ‘Amazon’), (1001,‘Apple’), and (1015,‘Netflix’).

select * from KnowsPersonAtCompany (1001, 'Amazon');
select * from KnowsPersonAtCompany (1001,'Apple');
select * from KnowsPersonAtCompany (1015,'Netflix');



\qecho 'Problem 19'

-- Define a parameterized view KnownByPersonAtCompany(p integer, c text)
-- that returns the subrelation of Person of persons who know the person
-- with pid p and who work for the company with cname c.  

CREATE FUNCTION KnownByPersonAtCompany(p integer, c text) RETURNS TABLE( pid integer,pname text,city text) AS $$ select p1.pid ,p1.pname,p1.city from person p1, person p2, knows k,worksFor w where p1.pid=k.pid1 and p2.pid=k.pid2 and p2.pid=p and w.pid = p1.pid and w.cname=c;$$ LANGUAGE SQL ;


-- Test your view for the parameters (1001, ‘Amazon’), (1001,‘Apple’),
-- and (1015,‘Netflix’).
select * from KnownByPersonAtCompany (1001, 'Amazon');
select * from KnownByPersonAtCompany(1001,'Apple');
select * from KnownByPersonAtCompany(1015,'Netflix');



\qecho 'Problem 20'

-- Let Tree(parent : integer, child : integer) be a rooted parent-child tree. 
-- So a pair (n,m) in Tree indicates that node n is a parent of node m. 

-- The sameGeneration(n1, n2) binary relation is inductively defined using the following two rules:
--  If n is a node in T , then the pair (n, n) is in the sameGeneration relation. (Base rule)

--   If $n_1$ is the parent of $m_1$ in $Tree$ and $n_2$ is the parent of
--   $m_2$ in $Tree$ and $(n_1,n_2)$ is a pair in the {\tt sameGeneration}
--   relation then $(m_1,m_2)$ is a pair in the {\tt sameGeneration}
--   relation. ({\bf Inductive Rule})

-- Write a \blue{recursive view} for the {\tt sameGeneration} relation.
-- 
-- Test your view.

CREATE Recursive View sameGeneration(n1, n2) AS
(select T.parent,T.parent FROM Tree T )
UNION(
select T1.child,T2.Child from Tree T1, Tree T2, sameGeneration S where T1.parent=s.n1 and T2.parent=s.n2 );
select *from sameGeneration Order by 1;




-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE akhilesh_gowda_mandya_ramesh;





