-- Script for Assignment 3

-- Creating database with full name

CREATE DATABASE dirk;

-- Connecting to database 
\c dirk

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
-- Find each pair $(c,n)$ where $c$ is the cname of a company that pays
-- an average salary between 50000 and 55000 and where $n$ is the number
-- of employees who work for company $c$.

select  w.cname, count(w.pid)
from    worksFor w
group  by (w.cname)
having (50000 <= avg(w.salary) and avg(w.salary) <= 55000)
order by 1;


\qecho 'Problem 2'
-- Find the pid and name of each person who lacks at least 4 job skils
-- and who knows at least 4 persons.

select p.pid, p.pname
from   person p
where (select count(1) from skill) - 
                (select count(1) from personSkill ps where ps.pid = p.pid) >= 4 and
      (select count(1) from knows k where k.pid1 = p.pid) >= 4
order by 1;

\qecho 'Problem 3'
-- Find the pid and name of each person who has fewer than 2 of the
-- combined set of job skills of persons who work for Google.

select p.pid, p.pname
from   person p
where  
  (select count(1)
   from   (select ps.skill
           from   personSkill ps
           where  ps.pid = p.pid
           intersect
           select ps.skill
           from   personSkill ps 
           where  ps.pid in (select w.pid
                             from   worksfor w 
                             where  w.cname = 'Google')) q) < 2
order by 1;


\qecho 'Problem 4'
-- Find the cname of each company that employs at least 3 persons and
-- that pays the lowest average salary among such companies.

create or replace function averageSalary(c text) returns
  numeric as
  $$
    select avg(salary)
    from   worksfor 
    where cname = c;
  $$ language sql;

with companyAtLeast3 as (select c.cname
                         from   company c
                         where  (select count(1)
                                 from   worksFor w
                                 where  w.cname = c.cname) >= 3)
select c.cname
from   companyAtLeast3 c
where  averageSalary(c.cname) = (select min(averageSalary(c1.cname))
                                 from   companyAtLeast3 c1);



\qecho 'Problem 5'
-- Find each pair $(c_1,c_2)$ of different company cnames such that,
-- among all companies, company $c_2$ pays the closest average salary
--- compared to the average salary paid by company $c_1$.

create or replace function closest(c1 text) 
   returns table (c2 text) as
$$
   select c.cname
   from   company c
   where  abs(averageSalary(c1) - averageSalary(c.cname)) =
                 (select min(abs(averageSalary(c1) - averageSalary(w1.cname)))
                  from   worksfor w1 where w1.cname <> c1) and c.cname <> c1;
$$ language sql;

select distinct w1.cname, w2.cname
from   company w1, company w2
where  w2.cname in (select *
                    from   closest(w1.cname))
order by 1,2;


\qecho 'Problem 6'
--Without using set predicates, find each pid of a person who does not
--know each person who (1) works for Apple and
-- (2) who makes less than 55000.

select p.pid
from   person p
where (select count(1)
       from   (select w.pid
               from   worksfor w
               where  w.cname = 'Apple' and w.salary < 55000
               except 
               select k.pid2
               from   knows k
               where  k.pid1 = p.pid) q) > 0
order by 1;


\qecho 'Problem 7'
-- Without using set predicates, find each pairs $(s_1,s_2)$ of skills
-- such that the set of persons with skill $s_1$ is the same as the set
-- of persons with skill $s_2$.

select s1.skill as s1, s2.skill as s2
from skill s1, skill s2
where 
(select count(1)
            from   (select ps.pid
                       from    personSkill ps
                       where ps.skill = s1.skill
                       except
                       select ps.pid
                       from   personSkill ps
                       where ps.skill = s2.skill) q) = 0
 and                       
(select count(1)
            from   (select ps.pid
                       from    personSkill ps
                       where ps.skill = s2.skill
                       except
                       select ps.pid
                       from   personSkill ps
                       where ps.skill = s1.skill) q) = 0
order by 1,2;


select s1.skill as s1, s2.skill as s2
from skill s1, skill s2
where 
      (select count(1)
       from   (select ps1.pid
               from   personSkill ps1
               where  ps1.skill = s1.skill and
                      ps1.pid not in (select ps2.pid
                                      from   personSkill ps2
                                      where  ps2.skill = s2.skill) q) = 0
 and                       
(select count(1)
            from   (select ps.pid
                       from    personSkill ps
                       where ps.skill = s2.skill
                       except
                       select ps.pid
                       from   personSkill ps
                       where ps.skill = s1.skill) q) = 0
order by 1,2;





\qecho 'Problem 8'
-- Find each pairs $(s_1,s_2,n)$ of different skills $s_1$ an $s_2$ and
-- such that (1) the number of persons with skill $s_1$ is the same as
-- the number of persons with skill $s_2$ and (2) where $n$ is the number
-- of such persons associated with $s_1$ and $s_2$.


select s1.skill as s1, s2.skill as s2, 
       (select count(1) from personSkill where skill = s1.skill) as n
from   skill s1, skill s2
where  s1.skill <> s2.skill and 
      (select count(1)
       from   (select ps1.pid
               from   personSkill ps1
               where  ps1.skill = s1.skill 
               except
               select ps2.pid
               from   personSkill ps2
               where  ps2.skill = s2.skill) q12)=
      (select count(1)
       from   (select ps2.pid
               from   personSkill ps2
               where  ps2.skill = s2.skill 
               except
               select ps1.pid
               from   personSkill ps1
               where  ps1.skill = s1.skill) q21);





select s1.skill as s1, s2.skill as s2, 
       (select count(1) from personSkill where skill = s1.skill) as n
from   skill s1, skill s2
where  s1.skill <> s2.skill and 
      (select count(1)
       from   (select ps1.pid
               from   personSkill ps1
               where  ps1.skill = s1.skill and
                      ps1.pid not in (select ps2.pid
                                      from   personSkill ps2
                                      where  ps2.skill = s2.skill)) q12)=
      (select count(1)
       from   (select ps2.pid
               from   personSkill ps2
               where  ps2.skill = s2.skill and
                      ps2.pid not in (select ps1.pid
                                      from   personSkill ps1
                                      where  ps1.skill = s1.skill)) q21);


-- Alternative Much faster

with skillNumberPersons as
     (select skill, count(pid) as ct_pid
      from   personSkill
      group by (skill)
      union  
      select skill, 0 as ct_pid
      from   skill
      where  skill not in (select  skill from personskill))
select s1.skill as s1, s2.skill as s2, s1.ct_pid as n
from   skillNumberPersons s1 join skillNumberPersons s2    on (s1.ct_pid = s2.ct_pid)
where  s1.skill <> s2.skill;


with skillNumberPersons as
     (select s.skill, (select count(pid) from personSkill where skill = s.skill)  as      ct_pid
      from   Skill s)
select s1.skill  as s1, s2.skill  as s2, s1.ct_pid   as n
from   skillNumberPersons s1 join skillNumberPersons s2    on (s1.ct_pid = s2.ct_pid)
where  s1.skill <> s2.skill;










select *
from   person p, (select pid, count(skill) as ct_skill
                  from   personSkill
                  group by (pid)
                  union
                  select pid, 0 as ct_skill
                  from   person
                  where  pid not in (select pid from personSkill)) q
where p.pid = q.pid and ct_skill >= 3
order by 1;




\qecho 'Problem 9'

\qecho 'Problem 9a'

create or replace function numberOfSkills(c text)
  returns table (pid integer, salary int, numberOfSkills bigint) as
  $$
  select w.pid, w.salary, count(distinct ps.skill)
  from   worksFor w, personSkill ps
  where  w.pid = ps.pid and w.cname = c
  group by (w.pid)
  union
  select w.pid, w.salary, 0
  from   worksfor w
  where  w.cname = c and w.pid not in (select ps.pid from personSkill ps);
  $$ language sql;


\qecho 'Problem 9b'
select t.pid, t.salary, t.numberOfSkills from numberOfSkills('Apple') t 
order by 3,1;

select t.pid, t.salary, t.numberOfSkills from numberOfSkills('Amazon') t
order by 3,1;

select t.pid, t.salary, t.numberOfSkills from numberOfSkills('ACM') t
order by 3,1;

\qecho 'Problem 9c'

create or replace function numberOfSkills(c text)
  returns table (pid integer, salary int, numberOfSkills bigint) as
  $$
  select w.pid, w.salary, (select count(ps.skill) from personSkill ps where ps.pid = w.pid)
  from    worksfor w
  where w.cname = c;
  $$ language sql;

\qecho 'Problem 9d'

select t.pid, t.salary, t.numberOfSkills from numberOfSkills('Apple') t 
order by 3,1;

select t.pid, t.salary, t.numberOfSkills from numberOfSkills('Amazon') t
order by 3,1;

select t.pid, t.salary, t.numberOfSkills from numberOfSkills('ACM') t
order by 3,1;

\qecho 'Problem 9e'
-- Using the function {\tt numberOfSkills} but without using set
-- predicates, write the following query: ``{\it Find each pair $(c,p)$
-- where $c$ is the name of a company and where $p$ is the pid of a
-- person who (1) works for company $c$, (2) makes more than 50000 and
-- (3) has the most job skills among all the employees who work for
-- company $c$}."

select  w.cname, w.pid
from    worksFor w
where   w.salary > 50000 and
        (select count(ps.skill) from personSkill ps where ps.pid = w.pid)
             = (select max(t.numberOfSkills)
                from   numberOfSkills(w.cname) t)
order by 1,2;  



\qecho 'Problem 10'

create table P (coefficient integer,
                degree integer);

create table Q (coefficient integer,
                degree integer);


insert into P values (2,2), (-5,1), (5,0);

insert into Q values (4,4), (3,3), (1,2), (-1,1);

\qecho 'Polynomial P = 2x^2 - 5x + 5'
\qecho 'Polynomial Q = 4x^4 + 3x^3 + x^2 -x'

\qecho 'P'
select * from P order by degree;
\qecho 'Q'
select * from Q order by degree;

\qecho 'Problem 10a'
-- Multiplication of polynomials                                           

create or replace function multiplyPolynomials(polynomial1 text, polynomial2 text)
  returns table(coefficient integer, degree integer) as
$$
begin
 return query execute
   'select sum(p1.coefficient * p2.coefficient)::integer AS coefficient, 
             p1.degree + p2.degree AS degree
      from   '||polynomial1||' p1, '||polynomial2||' p2
      group by(p1.degree + p2.degree) order by 2 desc;';
END;
$$ LANGUAGE plpgsql;

-- Alternatively, using the FORMAT function
/*
create or replace function multiplyPolynomials(P text, Q text)
  returns table(coefficient integer, degree integer) as
$$
BEGIN
 RETURN QUERY EXECUTE
   FORMAT('SELECT SUM(p.coefficient * q.coefficient)::integer AS coefficient, 
             p.degree + q.degree AS degree
           FROM   %1$s p, %2$s q
           GROUP BY(p.degree + q.degree) order by 2 desc;', P, Q);
END;
$$ LANGUAGE plpgsql;
*/

\qecho 'Problem 10b.i'
select * from multiplyPolynomials('P','Q');


\qecho 'Problem 10b.ii'
select * from multiplyPolynomials('P','P');

\qecho 'Problem 10b.iii'
select * from multiplyPolynomials('P', 'multiplyPolynomials(''Q'',''P'')');

\qecho 'Problem 11'
-- Write a function the do the composition P(Q(x)) of two polynomials P and Q.

--  We first write a function which considers how composition works
--  for a monomial P(x) of the form  cx^k.
--  note that we need to compute the polynomial c(Q(x))^k
--      c * Q(x) * Q(x) * ... * Q(x) (k multiplications)
--  we wrire a recursive function for this.
 

\qecho 'Problem 11.a'
create or replace function raisePolynomialtoPower(polynomial text, c integer,
                                                  k integer)
  returns table(coefficient integer, degree integer) as
$$
begin
   if k = 0 
     then return query select c as coefficient, 0 as degree;
     else return query execute
   'select sum(p1.coefficient * p2.coefficient)::integer AS coefficient,               
             p1.degree + p2.degree AS degree
    from   '||polynomial||' p1, raisePolynomialtoPower('''||polynomial||''','||c||','||k||'-1) p2
    group by(p1.degree + p2.degree) order by 2 desc;';
   end if;
end;
$$ LANGUAGE plpgsql;




create or replace function raisePolynomialtoPower(polynomial text, c integer,
                                                  k integer)
  returns table(coefficient integer, degree integer) as
$$
begin
   if k = 0 
     then return query select c as coefficient, 0 as degree;
     else return query execute
   'select sum(p1.coefficient * p2.coefficient)::integer AS coefficient,               
             p1.degree + p2.degree AS degree
    from   '||polynomial||' p1, raisePolynomialtoPower('''||polynomial||''','||c||','||k||'-1) p2
    group by(p1.degree + p2.degree) order by 2 desc;';
   end if;
end;
$$ LANGUAGE plpgsql;




-- Composition of polynomials P(Q(x))

/*
Polyomial 'P' can be thought of as a collection of monomials
polynomials, i.e., polynomials of the form cx^k.

For each of these monomials, we need to compute c*(Q(x))^k and
accumulate its result.

This can be done by map-applying the raisePolynomialtoPower(Q(x),c,k)
function call to the set of monomials in P(x): see the 'from' clause
in the compositionPolynomials function.


The result of all these raisePolynomialtoPower calls will accumulated
in this 'from' clause.  

The 'group by' clause will then aggregate the coefficient by degree
and these coefficients with be summed using the 'sum' aggregate
functions.
*/


create or replace function compositionPolynomials(polynomial1 text, polynomial2 text) 
  returns table(coefficient integer, degree integer) as
$$
begin 
return query execute
   'select  sum(r.coefficient)::integer, r.degree
    from '||polynomial1||' p, lateral (select * from raisePolynomialtoPower('''||polynomial2||''',p.coefficient,p.degree)) r
    group by r.degree order by 2 desc,1;';
end;
$$ language plpgsql;


\qecho 'Problem 11.a.i'
-- the polynomial P(Q(x));
select * from compositionPolynomials('P','Q');

\qecho 'Problem 11.a.ii'
-- the polynomial Q(P(x)); and
select * from compositionPolynomials('Q','P');

\qecho 'Problem 11.a.iii'
-- the polynomial P(P(P(x))).
create view PP as (select * from compositionPolynomials('P','P'));
select * from compositionPolynomials('PP','P');

\qecho 'Problem 12'
-- Boolean Matrix Multiplication
/*
create table M (rw integer, colmn integer, value boolean);
create table N (rw integer, colmn integer, value boolean);

insert into M values (1, 1, true), (1,2,false), (1,3,true), (2,1,false), (2,2,true), 
                     (2,3,true), (3,1,true), (3,2,false), (3,3,true);
insert into N values (1, 1, true), (1,2,true), (1,3,true), (2,1,false), (2,2,false), 
                     (2,3,false), (3,1,true), (3,2,false), (3,3,true);

*/

\qecho 'Problem 12.a'

create or replace function booleanMatrixMultiplication (M text, N text) 
  returns table (rw integer, colmn integer, value boolean) as
$$  
begin
  return query execute 
       'select m.rw, n.colmn, bool_or(m.value and n.value)
        from   '||M||' m, '||N||' n
        where  m.colmn = n.rw
        group by (m.rw, n.colmn)
        order by 1,2,3;';
end;  
$$ language plpgsql;

-- select * from booleanMatrixMultiplication('M','N'); 

-- select * from booleanMatrixMultiplication('M','booleanMatrixMultiplication(''M'',''M'')');


create table M_Knows(rw integer, colmn integer, value boolean);

insert into M_Knows 
     select rw.pid as rw, colmn.pid as colmn, 
                exists (select 1
                        from   Knows k
                        where  rw.pid = k.pid1 and colmn.pid = k.pid2)
     from   person rw, person colmn;

\qecho 'Problem 12.b'
-- M_Knows ∗ M_Knows
select count(1) from booleanMatrixMultiplication('M_Knows','M_Knows')
where value;
\qecho 'There are 189 values that are 'true''


\qecho 'Problem 12.c'
-- M_Knows ∗ (M_Knows ∗ M_Knows)

select count(1) from booleanMatrixMultiplication('M_Knows','booleanMatrixMultiplication(''M_Knows'',''M_Knows'')')
where  value;
\qecho 'There are 324 values that are 'true''

\qecho 'Problem 13'
/*

Develop appropriate insert and delete triggers that implement the
primary key and foreign key constraints that are specified for the
{\tt Person}, {\tt Knows}, {\tt Company}, and {\tt Worksfor}
relations.  Your triggers should report appropriate error conditions.

For this problem, implement the triggers such that foreign key
constraints are maintained using the cascading delete semantics.

Test your triggers using appropriate inserts and deletes.
*/

-- Develop appropriate insert and delete triggers that implement the
-- primary key and foreign key constraints that are specified for the
-- Person, Company, and Worksfor relations. 

/*
drop table jobskill cascade;
drop table person cascade;
drop table company cascade;
drop table worksfor;
drop table knows;
drop table personskill;


create table person (pid integer,
                     name text,
                     city text,
                     birthyear integer);

create table knows (pid1 integer,
                    pid2 integer);



create table company(cname text,
                     city text);

create table worksfor(pid integer,
                      cname text,
                      salary integer);

*/

-- Trigger for checking primary key on Person
CREATE OR REPLACE FUNCTION check_Person_pid_key_constraint() 
RETURNS trigger AS
$$
BEGIN
 IF NEW.pid IN (SELECT pid FROM Person) THEN
    RAISE EXCEPTION 'pid already exists';
 END IF;
 RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

--DROP TRIGGER IF EXISTS check_Person_pid_key_constraint
--  ON Person;
CREATE TRIGGER check_Person_pid_key_constraint
 BEFORE INSERT
 ON Person
 FOR EACH ROW
 EXECUTE PROCEDURE check_Person_pid_key_constraint();

-- Triggers to implement delete on Person with cascading delete semantics
-- on Worksfor and Knows

CREATE OR REPLACE FUNCTION Person_foreign_keys_constraints_cascade_delete() 
RETURNS trigger AS
$$
BEGIN
  DELETE FROM Worksfor WHERE pid = OLD.pid;
  RETURN OLD;
END;
$$ language 'plpgsql';

-- DROP TRIGGER IF EXISTS Person_foreign_keys_constraints_cascade_delete
--  ON Person;
CREATE TRIGGER Person_foreign_keys_constraints_cascade_delete
 BEFORE DELETE
 ON Person
 FOR EACH ROW
 EXECUTE PROCEDURE Person_foreign_keys_constraints_cascade_delete();

-- Check primary key (cname, city) for Company upon insert
CREATE OR REPLACE FUNCTION check_Company_key_constraint() 
RETURNS trigger AS
$$
BEGIN
 IF (NEW.cname, NEW.city) IN (SELECT cname, city FROM Company) THEN
    RAISE EXCEPTION 'cname, city pair already exists';
 END IF;
 RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

--DROP TRIGGER IF EXISTS check_Company_key_constraint
--  ON Company;
CREATE TRIGGER check_Company_key_constraint
 BEFORE INSERT
 ON Company
 FOR EACH ROW
 EXECUTE PROCEDURE check_Company_key_constraint();

-- Check primary key and foreign key constraint for Worksfor upon insert

CREATE OR REPLACE FUNCTION check_Worksfor_primary_and_foreign_key_constraints() 
RETURNS trigger AS
$$
BEGIN
 IF NEW.pid IN (SELECT pid FROM Worksfor) THEN
    RAISE EXCEPTION 'primary key violation';
 ELSE IF NOT EXISTS (SELECT 1 FROM Person WHERE NEW.pid = pid)
      THEN RAISE EXCEPTION 'foreign key violation referencing person';
      ELSE IF NOT EXISTS (SELECT 1 FROM Company WHERE NEW.cname = cname)
           THEN RAISE EXCEPTION 'foreign key violation referencing company';
           END IF;
      END IF;
 END IF;
 RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

--DROP TRIGGER IF EXISTS check_Worksfor_primary_and_foreign_key_constraints
--  ON Worksfor;
CREATE TRIGGER check_Worksfor_primary_and_foreign_key_constraints
 BEFORE INSERT
 ON Worksfor
 FOR EACH ROW
 EXECUTE PROCEDURE check_Worksfor_primary_and_foreign_key_constraints();

-- Create trigger for delete on company with cascading deletes on Worksfor
-- We must make sure that this only happens when the company really is deleted
-- Notice that it is possible that a company is located in multiple cities.

CREATE OR REPLACE FUNCTION Company_foreign_keys_constraints_cascade_delete() 
RETURNS trigger AS
$$
BEGIN
  DELETE FROM Worksfor WHERE cname = OLD.cname;
  RETURN OLD;
END;
$$ language 'plpgsql';

--DROP TRIGGER IF EXISTS Company_foreign_keys_constraints_cascade_delete
--  ON Company;
CREATE TRIGGER Person_foreign_keys_constraints_cascade_delete
 BEFORE DELETE
 ON Company
 FOR EACH ROW
 EXECUTE PROCEDURE Company_foreign_keys_constraints_cascade_delete();


\qecho 'Problem 14'

-- The only adjustment need to be made for the insert trigger on
-- the worksfor relation


CREATE OR REPLACE FUNCTION check_Worksfor_primary_and_foreign_key_constraints() 
RETURNS trigger AS
$$
BEGIN
 IF NEW.pid IN (SELECT pid FROM Worksfor) 
 THEN  RAISE EXCEPTION 'primary key violation';
 ELSE IF NOT EXISTS (SELECT 1 FROM Person WHERE NEW.pid = pid)
      THEN RAISE EXCEPTION 'foreign key violation referencing person';
      ELSE IF NOT EXISTS (SELECT 1 FROM Company WHERE NEW.cname = cname)
           THEN RAISE EXCEPTION 'foreign key violation referencing company';
           ELSE IF ((SELECT count(1) FROM personSkill WHERE NEW.pid = pid) < 2)
                THEN RAISE EXCEPTION 'insufficient job skills';
                END IF;
           END IF;
      END IF;
 END IF;
 RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS check_Worksfor_primary_and_foreign_key_constraints
ON Worksfor;
CREATE TRIGGER check_Worksfor_primary_and_foreign_key_constraints
 BEFORE INSERT
 ON Worksfor
 FOR EACH ROW
 EXECUTE PROCEDURE check_Worksfor_primary_and_foreign_key_constraints();



\qecho 'Problem 15'
/*
Consider the following view definition

create or replace view PersonIsKnownByNumberofPersons as 
  (select p1.pid, p1.name, 
         (select count(1)
          from   Person p2
          where (p2.pid, p1.pid) in (select k.pid1, k.pid2
                                     from Knows k)) as NumberofKnownByPersons
    from Person p1);                                                          

This view defines the set of tuples $(p,n,c)$ where $p$ and $n$ are
the pid and name of a person and $c$ is the number of persons who know
the person with pid $p$.

You should not create this view!  Rather your task is to create a
relation {\tt PersonIsKnownByNumberofPersons} that maintains a {\bf
materialized view} in accordance with the above view definition under
insert and delete operations on the {\tt Person} and {\tt Knows}
relation.

Your triggers should be designed to be {\bf incremental}.  In
particular, when an insert or delete occurs, you should not always
have to reevaluate all the number of persons who know persons.  Rather
the maintenance of {\tt PersonIsKnownByNumberofPersons} should only
apply to the person information that is affected by the insert or
delete.
*/

create table PersonIsKnownByNumberofPersons(pid integer, name text, NumberofKnownByPersons integer);

CREATE OR REPLACE FUNCTION Insert_Maintain_PersonIsKnownByNumberofPersons()
RETURNS trigger AS
$$
BEGIN
  IF EXISTS(SELECT 1 
            FROM   PersonIsKnownByNumberofPersons p
            where  p.pid = new.pid2) 
  THEN  UPDATE PersonIsKnownByNumberofPersons 
             SET NumberofKnownByPersons = NumberofKnownByPersons + 1 where pid = new.pid2;
  ELSE  INSERT INTO PersonKnownByNumberofPersons
            VALUES(new.pid2, (select p.name from person p where p.pid = new.pid2), 1);
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';


CREATE TRIGGER Insert_Maintain_PersonIsKnownByNumberofPersons
 BEFORE INSERT ON Knows
 FOR EACH ROW
 EXECUTE PROCEDURE Insert_Maintain_PersonIsKnownByNumberofPersons();


CREATE OR REPLACE FUNCTION Delete_Maintain_PersonIsKnownByNumberofPersons() 
RETURNS trigger AS
$$
BEGIN
  IF (SELECT p.NumberofKnownByPersons 
      FROM   PersonIsKnownByNumberofPersons p 
      WHERE  p.pid=old.pid2) >= 2
  THEN  UPDATE PersonIsKnownByNumberofPersons 
          SET NumberofKnownByPersons  = NumberofKnownByPersons - 1 where pid = old.pid2;
  ELSE  DELETE FROM PersonIsKnownByNumberofPersons where pid = old.pid2;
  END IF;
  RETURN OLD;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER Delete_Maintain_PersonIsKnownByNumberofPersons
 BEFORE DELETE ON Knows
 FOR EACH ROW
 EXECUTE PROCEDURE Delete_Maintain_PersonIsKnownByNumberofPersons();


-- Connect to default database
-- \c postgres

-- Drop database created for this assignment
-- 
-- DROP DATABASE dirk;





