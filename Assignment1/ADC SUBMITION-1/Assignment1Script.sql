-- Creating database with full name
 
 CREATE DATABASE akhilesh_gowda_mandya_ramesh;




--CREATE DATABASE yourname;

-- Connecting to database 
\c akhilesh_gowda_mandya_ramesh;

create table Person(pid integer,pname text, city text,primary key(pid));

create table Company (cname text, headquarter text,primary key(cname));

create table skill(skill text, primary key(skill));

create table worksFor(pid integer,cname text,salary integer,primary key(pid), foreign key(pid) references person(pid),foreign key(cname) references company(cname));

create table companyLocation(cname text, city text, primary key(cname,city),foreign key(cname) references company(cname));

create table personSkill(pid integer,skill text,primary key(pid,skill),foreign key(pid) references person(pid),foreign key(skill) references skill(skill));

create table hasManager(eid integer,mid integer,primary key(eid,mid),foreign key(eid) references person(pid),foreign key(mid)references person(pid));

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

create table compny(compnyName text, headquarter text,primary key(compnyName));

insert into compny values('UPLERS','Gujurat');;

insert into compny values('CISCO','San Jose');
INSERT 0 1
insert into compny values('Capgemini','Paris');


create table compnyLoc(compnyName text, city text,primary key(compnyName),foreign key(compnyName) references  compny(compnyName)); 

insert into  compnyLoc values('CISCO','DELHI');
insert into  compnyLoc values('UPLERS','Banglore');
insert into  compnyLoc values('Capgemini','Mumbai')


\qecho 'Problem 1 conceptual example 1'
insert into compny values('UPLERS','Indianapolis');

\qecho 'Problem 1 conceptual example 2'
delete from compny where compnyName='UPLERS';

\qecho 'Problem 1 conceptual example 3'
insert into compnyloc values('ACCENTURE','NEW YORK')

\qecho 'Problem 1 conceptual example 4'
insert into compny values('ACCENTURE','NEW YORK');


-- Before starting with the rest of the assignment, make sure to
-- use the originally given data set in data.sql

\qecho 'Problem 2'
-- Find the pid, pname of each person who (a) lives in Bloomington, (b)
-- works for a company where he or she earn a salary that is higher than
-- 30000, and (c) has at least one manager.
select p.pid,p.pname from person p,worksFor w,hasManager h where p.city='Bloomington' and p.pid=w.pid and w.salary>30000 and p.pid=h.eid ;



\qecho 'Problem 3'
-- Find the pairs $(c_1, c_2)$ of different company names who
-- headquarters are located in the same city.  
select c1.cname as cname, c2.Cname as cname from company c1,company c2 where c1.cname<>c2.cname and c1.headquarter = c2.headquarter order by c1.cname;


\qecho 'Problem 4'
-- Find the pid and pname of each person who lives in a city that is
-- different than each city in which his or her managers live.
-- (Persons who have no manager should not be included in the answer.)

select p.pid, p.pname from person p,hasManager h where p.pid=h.eid and not exists (select 1 from person p1,person p2,hasManager h1 where p.pid=p1.pid and p1.pid=h1.eid and p2.pid=h1.mid and p1.city=p2.city) ORDER BY pid;


\qecho 'Problem 5'
-- Find each skill that is the skill of at most 2 persons.
 select  s.skill from skill s EXCEPT (select distinct s1.skill from skill s1, personSkill p,personSkill p1,personSkill p2 where s1.skill=p.skill and s1.skill=p1.skill and s1.skill=p2.skill);


\qecho 'Problem 6
-- Find the pid, pname, and salary of each employee who has at least two
-- managers such that these managers have a common job skill but provided
-- that it is not the `Networks' skill.

select Distinct p.pid,p.pname,w.salary from person p, hasManager h, worksFor w where p.pid=h.eid and w.pid = h.eid and EXISTS(select 1 from hasManager h1,personSkill ps1,personSkill ps2 where h.eid=h1.eid and h.mid<>h1.mid and h.mid=ps1.pid and h1.mid=ps2.pid and ps1.skill=ps2.skill and ps1.skill<>'Networks');

\qecho 'Problem 7'
-- Find the cname of each company that not only employs persons
-- who live in MountainView.
select c.cname from company c where  EXISTS (select 1 from person p, worksFor w where p.pid=w.pid and c.cname=w.cname and p.city<>'MountainView') ORDER BY c.cname;


\qecho 'Problem 8'
-- For each company, list its name along with the highest salary made by
-- employees who work for it.
 select w.cname, w.salary from worksFor w Where  Not Exists(select 1 from worksFor w1 where w.cname=w1.cname and w.salary <w1.salary) order by cname;


\qecho 'Problem 9'
-- Find the pid and pname of each employee who has a salary that is
-- higher than the salary of each of his or her managers.  (Employees who
-- have no manager should not be included.)
select p1.pid,p1.pname from person p1, person p2, hasManager h1, worksFor w1,worksFor w2 where p1.pid=h1.eid and p2.pid=h1.mid and w1.pid=h1.eid and w2.pid=h1.mid and w1.salary>w2.salary order by pid;


\qecho 'Problem 10'
select p.pid,p.pname,w.cname,w.salary from Person p, worksFor w where p.pid = w.pid and p.city = 'Bloomington' and w.salary >= 40000 and w.cname <> 'Apple';


\qecho 'Problem 11'
select p.pid,p.pname from person p,person m,hasManager hm,company c, worksFor w where c.cname=w.cname and p.pid=w.pid and c.headquarter='LosGatos' and hm.eid=p.pid and hm.mid=m.pid and m.city<>'LosGatos';


\qecho 'Problem 12'
select  s.skill from skill s where  NOT EXISTS(select 1 from person p, personSkill ps where p.pid=ps.pid and ps.skill = s.skill and p.city='Bloomington');


\qecho 'Problem 13'
select DISTINCT m.pid,m.pname from person m where NOT EXISTS(select e.pid,e.pname from hasManager hm, person e where hm.mid=m.pid and hm.eid=e.pid and e.city<>m.city) ORDER BY m.pid;


\qecho 'Problem 18'
-- Each person works for a company and has at least two job skills.
select not exists(select 1 from worksfor w where not exists (select 1 from personSkill ps1,personSkill ps2 where ps1.pid=w.pid and ps2.pid=w.pid and ps1.skill<>ps2.skill))as constraintSatisfied;


\qecho 'Problem 19'
-- Some person has a salary that is strictly higher than the salary of
-- each of his or her managers.
select  exists(select 1 from  hasManager h where Exists(select 1 from worksFor w1, worksFor w2 where w1.pid=h.eid and w2.pid=h.mid and w1.salary>w2.salary))as constraintSatisfied;


\qecho 'Problem 20'
-- Each employee and his or her managers work for the same company.
select not exists(select 1 from HasManager h where not Exists(select 1 from worksFor w1, worksfor w2 where w1.pid=h.eid and w2.pid=h.mid and w1.cname=w2.cname)) as constraintSatisfied;


-- Connect to default database
\c postgres;

-- Drop database created for this assignment
DROP DATABASE akhilesh_gowda_mandya_ramesh;
