
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
     (1012,'Apple', 45000),
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

/*
\qecho 'Example'

select w.pid, w.cname
from   worksfor w
where  w.cname in (select cl.cname
                   from   companyLocation cl
                   where  cl.city = 'Bloomington') and 
       w.salary <= ALL (select w1.salary
                        from   worksfor w1
                        where  w1.cname = w.cname);

-- Translation of 'and' in 'where' clause

select q.pid, q.cname
from   (select w.*
        from   worksfor w
        where  w.cname in (select cl.cname
                           from   companyLocation cl
                           where  cl.city = 'Bloomington') 
        intersect
        select w.*
        from   worksfor w
        where  w.salary <= ALL (select w1.salary
                                from   worksfor w1
                                where  w1.cname = w.cname)) q;

-- Translation of 'in' and '<= ALL' predicate

select q.pid, q.cname
from   (select w.*
        from   worksfor w, companyLocation cl
        where  w.cname = cl.cname and cl.city = 'Bloomington'
        intersect
        (select w.*
         from   worksfor w
         except
         select w.*
         from   worksfor w, worksfor w1
         where  w.salary > w1.salary and w1.cname = w.cname)) q;


-- Move constant selection 'cl.city = 'Bloomington' into the where
-- clause

select q.pid, q.cname
from   (select w.*
        from   worksfor w, (select cl.* from companyLocation cl  where cl.city = 'Bloomington') cl
        where  w.cname = cl.cname
        intersect
        (select w.*
         from   worksfor w
         except
         select w.*
         from   worksfor w, worksfor w1
         where  w.salary > w1.salary and w1.cname = w.cname)) q;

-- Introduction of 'natural join' and 'join'

select q.pid, q.cname
from   (select w.*
        from   worksfor w
               natural join (select cl.* from companyLocation cl  where cl.city = 'Bloomington') cl
        intersect
        (select w.*
         from   worksfor w
         except
         select w.*
         from   worksfor w join worksfor w1 on (w.salary > w1.salary and w1.cname = w.cname))) q;


-- We can now start the optimization

-- In the 'from' clause We have a query of the form 'A intersect (B-C)' which is equal to
-- '(A intersect B) - C.   In this case, we notice that A is a subset of B
-- and therefore the 'from' clause can be simplified to 'A - C'
-- We get:


select q.pid, q.cname
from   (select w.*
        from   worksfor w
               natural join (select cl.* from companyLocation cl  where cl.city = 'Bloomington') cl
        except
        select w.*
        from   worksfor w join worksfor w1 on (w.salary > w1.salary and w1.cname = w.cname)) q;

-- We can now push the projections over the joins.  Observe that the natural join is a semijoin.
-- We get the optimized RA SQL query

select q.pid, q.cname
from   (select w.*
        from   worksfor w
               natural join (select cl.cname from companyLocation cl  where cl.city = 'Bloomington') cl
        except
        select w.*
        from   worksfor w join (select w1.cname, w1.salary 
                                from   worksfor w1) w1 on (w.salary > w1.salary and w1.cname = w.cname)) q;



*/

\qecho 'Problem 6'

-- Consider the query ``\emph{Find the cname and headquarter of
-- each company that employs persons who earns less than 55000 and who do
-- not live in Bloomington}.''

-- A possible way to write this query in Pure SQL is 

select c.cname, c.headquarter
from   company c
where  c.cname in (select w.cname
                   from   worksfor w
                   where  w.salary < 55000 and 
                          w.pid = SOME (select p.pid
                                        from   person p
                                        where  p.city <> 'Bloomington'));

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.

-- Replace 'in' and '=some' with 'exists'

select c.cname, c.headquarter
from   company c
where  exists (select w.cname
               from   worksfor w
               where  c.cname = w.cname and w.salary < 55000 and 
                      exists (select p.pid
                              from   person p
                              where  w.pid = p.pid and p.city <> 'Bloomington'));


-- Eliminate outer 'exists'

select distinct c.cname, c.headquarter
from   company c, worksfor w
where  c.cname = w.cname and w.salary < 55000 and 
       exists (select p.pid
               from   person p
               where  w.pid = p.pid and p.city <> 'Bloomington');


-- Eliminate inner 'exists'

select distinct c.cname, c.headquarter
from   company c, worksfor w, person p
where  c.cname = w.cname and w.salary < 55000 and 
       w.pid = p.pid and p.city <> 'Bloomington';

-- Introduce relational operators (joins)

select distinct c.cname, c.headquarter
from   company c
       join worksfor w on (c.cname = w.cname)
       join person p on (w.pid = p.pid)
where  w.salary < 55000 and p.city <> 'Bloomington';

-- We can now begin with the optimization 
-- Step 1:  push selection down over joins and projections

select distinct c.cname, c.headquarter
from   company c
       join (select w.* from worksfor w where w.salary < 55000) w on (c.cname = w.cname)
       join (select p.* from person p where p.city <> 'Bloomington') p on (w.pid = p.pid);

-- Step 2:  push projections down

select distinct c.cname, c.headquarter
from   company c
       join (select w.cname, w.pid from worksfor w where w.salary < 55000) w on (c.cname = w.cname)
       join (select p.pid from person p where p.city <> 'Bloomington') p on (w.pid = p.pid);

-- Step 3: introducing semi-joins

select distinct cname, headquarter
from   company
       natural join (select cname
                     from   (select cname, pid from worksfor where salary < 55000) w 
                             natural join (select pid from person p where city <> 'Bloomington') p) q;

\qecho 'Problem 7'

-- Consider the query ``\emph{Find the pid of each person who has
-- all-but-one job skill."

-- A possible way to write this query in Pure SQL is


select p.pid
from   person p
where  exists (select 1
               from   skill s
               where  (p.pid, s.skill) not in (select ps.pid, ps.skill 
                                               from   personSkill ps)) and
        not exists (select 1
                    from   skill s1, skill s2
                    where  s1.skill <> s2.skill and
                           (p.pid, s1.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps) and
                           (p.pid, s2.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps));
-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.


-- Step 1: Replace 'and' by intersection


select q.pid
from
 (select p.*
  from   person p
  where  exists (select 1
                 from   skill s
                 where  (p.pid, s.skill) not in (select ps.pid, ps.skill 
                                                 from   personSkill ps))
  intersect
  select p.*
  from   person p
  where  not exists (select 1
                     from   skill s1, skill s2
                     where  s1.skill <> s2.skill and
                            (p.pid, s1.skill) not in (select ps.pid, ps.skill 
                                                      from   personSkill ps) and
                            (p.pid, s2.skill) not in (select ps.pid, ps.skill 
                                                      from   personSkill ps))) q;

-- Step 2: Translate the 'exists' and 'not exists' set predicates

select q.pid
from (
 (select p.*
  from   person p, skill s
  where  (p.pid, s.skill) not in (select ps.pid, ps.skill 
                                  from   personSkill ps))
  intersect
  (select p.*
   from   person p
   except
   select p.*
   from   person p, skill s1, skill s2
   where  s1.skill <> s2.skill and
          (p.pid, s1.skill) not in (select ps.pid, ps.skill 
                                    from   personSkill ps) and
          (p.pid, s2.skill) not in (select ps.pid, ps.skill 
                                    from   personSkill ps))) q;


-- Step 3: Translate outermost 'not in' predicate

select q.pid
from (
 (select q1.pid, q1.pname, q1.city
  from   (select p.*, s.*
          from   person   p, skill s
          except 
          select p.*, s.*
          from   person p, skill s, personSkill ps
          where  p.pid = ps.pid and s.skill = ps.skill) q1)
  intersect
  (select p.*
   from   person p
   except
   select p.*
   from   person p, skill s1, skill s2
   where  s1.skill <> s2.skill and
          (p.pid, s1.skill) not in (select ps.pid, ps.skill 
                                    from   personSkill ps) and
          (p.pid, s2.skill) not in (select ps.pid, ps.skill 
                                    from   personSkill ps))) q;


-- Step 4: Translate 'and not' and 'and not' into 'except' and 'except'

select q.pid
from (
 (select q1.pid, q1.pname, q1.city
  from   (select p.*, s.*
          from   person   p, skill s
          except 
          select p.*, s.*
          from   person p, skill s, personSkill ps
          where  p.pid = ps.pid and s.skill = ps.skill) q1)
  intersect
  (select p.*
   from   person p
   except
   (select q2.pid, q2.pname, q2.city
    from 
       (select p.*, s1.*, s2.*
        from   person p, skill s1, skill s2
        where  s1.skill <> s2.skill
        except 
        select p.*, s1.*, s2.*
        from   person p, skill s1, skill s2, personSkill ps
        where  p.pid = ps.pid and s1.skill = ps.skill
        except
        select p.*, s1.*, s2.*
        from   person p, skill s1, skill s2, personSkill ps
        where  p.pid = ps.pid and s2.skill = ps.skill) q2))) q;


-- we can now introduce joins


select q.pid
from (
 (select q1.pid, q1.pname, q1.city
  from   (select p.*, s.*
          from   person   p cross join skill s
          except 
          select p.*, s.*
          from   person p
                 join personSkill ps on (p.pid = ps.pid)
                 join skill s on ( s.skill = ps.skill)) q1)
  intersect
  (select p.*
   from   person p
   except
   (select q2.pid, q2.pname, q2.city
    from 
       (select p.*, s1.*, s2.*
        from   person p cross join
               skill s1 join skill s2 on (s1.skill <> s2.skill)
        except 
        select p.*, s1.*, s2.*
        from   skill s2 cross join
               person p
               join   personSkill ps on(p.pid = ps.pid)
               join   skill s1 on (ps.skill = s1.skill)
        where  p.pid = ps.pid and s1.skill = ps.skill
        except
        select p.*, s1.*, s2.*
        from   skill s1 cross join
               person p
               join   personSkill ps on(p.pid = ps.pid)
               join   skill s2 on (ps.skill = s2.skill)) q2))) q;



-- We can now start the optimization
-- because pid -> pname and citt and we never use these attributes, 
-- we can eliminate them from the query


with person as (select pid from   person)
select q.pid
from (
 (select q1.pid
  from   (select p.*, s.*
          from   person   p cross join skill s
          except 
          select p.*, s.*
          from   person p
                 join personSkill ps on (p.pid = ps.pid)
                 join skill s on ( s.skill = ps.skill)) q1)
  intersect
  (select p.pid
   from   person p
   except
   (select q2.pid
    from 
       (select p.*, s1.*, s2.*
        from   person p cross join
               skill s1 join skill s2 on (s1.skill <> s2.skill)
        except 
        select p.*, s1.*, s2.*
        from   skill s2 cross join
               person p
               join   personSkill ps on(p.pid = ps.pid)
               join   skill s1 on (ps.skill = s1.skill)
        where  p.pid = ps.pid and s1.skill = ps.skill
        except
        select p.*, s1.*, s2.*
        from   skill s1 cross join
               person p
               join   personSkill ps on(p.pid = ps.pid)
               join   skill s2 on (ps.skill = s2.skill)) q2))) q;

-- We can also eliminae the outmost project

with person as (select pid from   person)
 select pid
 from   (select pid, skill
         from   person cross join skill
         except 
         select p.pid, s.skill
         from   person p
                natural join personSkill ps 
                natural join skill s) q1
  intersect
  (select pid
   from   person
   except
   (select q2.pid
    from 
       (select pid, s1.skill, s2.skill
        from   person p cross join
               skill s1 join skill s2 on (s1.skill <> s2.skill)
        except 
        select p.pid, s1.skill, s2.skill
        from   skill s2 cross join
               person p
               join  personSkill ps on (p.pid = ps.pid)
               join  skill s1 on (ps.skill = s1.skill)
        except
        select p.pid, s1.skill, s2.skill
        from   skill s1 cross join
               person p
               join   personSkill ps on(p.pid = ps.pid)
               join   skill s2 on (ps.skill = s2.skill)) q2));


-- we can now exploit foreign key constraints


with person as (select pid from   person)
 select pid
 from   (select pid, skill
         from   person cross join skill
         except 
         select pid, skill
         from   personSkill) q1
  intersect
  (select pid
   from   person
   except
   (select q2.pid
    from 
       (select pid, s1.skill, s2.skill
        from   person p cross join
               skill s1 join skill s2 on (s1.skill <> s2.skill)
        except 
        select ps.pid, ps.skill, s2.skill
        from   skill s2 cross join
               personSkill ps
        except
        select ps.pid, s1.skill, ps.skill
        from   skill s1 cross join
               personSkill ps) q2));



-- We can further symplify by exploiting a set equality


with person as (select pid from   person)
 select pid
 from   (select pid, skill
         from   person cross join skill
         except 
         select pid, skill
         from   personSkill) q1
   except
   (select q2.pid
    from 
       (select pid, s1.skill, s2.skill
        from   person p cross join
               skill s1 join skill s2 on (s1.skill <> s2.skill)
        except 
        select ps.pid, ps.skill, s2.skill
        from   skill s2 cross join
               personSkill ps
        except
        select ps.pid, s1.skill, ps.skill
        from   skill s1 cross join
               personSkill ps) q2);

-- Further simplification



with person as (select pid from   person),
     skillPair as (select ps.pid, ps.skill as psSkill, s.skill
                   from   skill s cross join personSkill ps)
 select pid
 from   (select pid, skill
         from   person cross join skill
         except 
         select pid, skill
         from   personSkill) q1
   except
   (select q2.pid
    from 
       (select pid, s1.skill, s2.skill
        from   person p cross join
               skill s1 join skill s2 on (s1.skill <> s2.skill)
        except 
        select pid, psSkill, skill
        from   skillPair
        except
        select pid, skill, psSkill
        from   skillPair) q2);


\qecho 'Problem 8'

-- Consider the query ``\emph{Find the pid and name of each person who
-- works for a company located in Bloomington but who does not knows any
-- person who lives in Chicago.}.''

 
-- A possible way to write this query in Pure SQL is

select p.pid, p.pname
from   person p
where  exists (select 1
               from   worksFor w, companyLocation c
               where  p.pid = w.pid and w.cname = c.cname and c.city = 'Bloomington') and
       p.pid not in (select k.pid1
                     from   knows k
                     where  exists (select 1
                                    from   person p
                                    where  k.pid2 = p.pid and  p.city = 'Chicago'));

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.


-- Step 1:  Replace 'not in' by 'not exists' and rename the innermost variable 'p' to 'p1'

select p.pid, p.pname
from   person p
where  exists (select 1
               from   worksFor w, companyLocation c
               where  p.pid = w.pid and w.cname = c.cname and c.city = 'Bloomington') and
       not exists (select k.pid1
                   from   knows k
                   where  p.pid = k.pid1 and
                          exists (select 1
                                  from   person p1
                                  where  k.pid2 = p1.pid and  p1.city = 'Chicago'));

-- Step 2: Resolve the innermost 'exists'

select p.pid, p.pname
from   person p
where  exists (select 1
               from   worksFor w, companyLocation c
               where  p.pid = w.pid and w.cname = c.cname and c.city = 'Bloomington') and
       not exists (select k.pid1
                   from   knows k, person p1
                   where  p.pid = k.pid1 and k.pid2 = p1.pid and  p1.city = 'Chicago');


-- Step 3:  Replace the 'and not' and introduce 'except'

select pid, pname
from (select p.*
      from   person p
      where  exists (select 1
                     from   worksFor w, companyLocation c
                     where  p.pid = w.pid and w.cname = c.cname and c.city = 'Bloomington') 
      except
      select p.*
      from   person p
      where  exists (select k.pid1
                     from   knows k
                     where  p.pid = k.pid1 and
                            exists (select 1
                                    from   person p1
                                    where  k.pid2 = p1.pid and  p1.city = 'Chicago'))) q;

-- Step 4:  Resolve the remaining 'exists' recursively


select pid, pname
from (select p.*
      from   person p, worksFor w, companyLocation c
      where  p.pid = w.pid and w.cname = c.cname and c.city = 'Bloomington'
      except
      select p.*
      from   person p, knows k, person p1
      where  p.pid = k.pid1 and k.pid2 = p1.pid and  p1.city = 'Chicago') q;


-- Step 5:  Moving constant selection to appropriate relations

select pid, pname
from (select p.*
      from   person p, worksFor w, (select c.* from companyLocation c where c.city = 'Bloomington') c
      where  p.pid = w.pid and w.cname = c.cname 
      except
      select p.*
      from   person p, knows k, (select p1.* from person p1 where p1.city = 'Chicago') p1
      where  p.pid = k.pid1 and k.pid2 = p1.pid) q;


-- Step 6:  Introducing natural joins and joins

select pid, pname
from (select p.*
      from   person p
             natural join worksFor w
             join (select c.* from companyLocation c where c.city = 'Bloomington') c on (w.cname = c.cname)
      except
      select p.*
      from   person p
             join knows k on (p.pid = k.pid1)
             join (select p1.* from person p1 where p1.city = 'Chicago') p1 on (k.pid2 = p1.pid)) q;


-- We can begin the optimization

-- Use the 'pid' primary key constraint in 'Person'

select p.pid, p.pname
from   person p
       natural join worksFor w
       join (select c.* from companyLocation c where c.city = 'Bloomington') c on (w.cname = c.cname)
except
select p.pid, p.pname
from   person p
       join knows k on (p.pid = k.pid1)
       join (select p1.* from person p1 where p1.city = 'Chicago') p1 on (k.pid2 = p1.pid);

-- Push projects down over joins and introduce semi-joins

select pid, pname
from   person
       natural join (select pid 
                     from   (select pid, cname from worksFor) w
                            natural join (select cname 
                                          from   companyLocation
                                          where  city = 'Bloomington') c) q
except
select pid, pname
from   person
       join (select pid1 
             from   knows k 
                    join   (select pid 
                            from   person
                            where  city = 'Chicago') p1 on (k.pid2 = p1.pid)) q on (pid = q.pid1);




\qecho 'Problem 9'

-- Consider the query ``\emph{}.''  Find the cname and headquarter of
-- each company that employs person and whose workers that make at most
-- have both the programming and AI skills.

select c.cname, c.headquarter
from   company c
where  exists (select 1 from worksfor w where w.cname = c.cname) and
       not exists (select 1
                   from   worksfor w
                   where  w.cname = c.cname and w.salary <= 70000 and
                          (w.pid not in (select ps.pid from personskill ps where skill = 'Programming') or
                           w.pid not in (select ps.pid from personskill ps where skill = 'AI')));


-- Step 1  Replace 'and not' by 'except'

select c.cname, c.headquarter
from   company c
where  exists (select 1 from worksfor w where w.cname = c.cname)
except 
select c.cname, c.headquarter
from   company c
where  exists (select 1
               from   worksfor w
               where  w.cname = c.cname and w.salary <= 70000 and
                      (w.pid not in (select ps.pid from personskill ps where skill = 'Programming') or
                       w.pid not in (select ps.pid from personskill ps where skill = 'AI')));


-- Step 2  Remove 'exists'

select c.cname, c.headquarter
from   company c, worksfor w 
where  w.cname = c.cname
except 
select c.cname, c.headquarter
from   company c, worksfor w
where  w.cname = c.cname and w.salary <= 70000 and
       (w.pid not in (select ps.pid from personskill ps where skill = 'Programming') or
        w.pid not in (select ps.pid from personskill ps where skill = 'AI'));

-- Step 3  expand 'or' using the distribution law of 'and' over 'or'

select c.cname, c.headquarter
from   company c, worksfor w 
where  w.cname = c.cname
except 
select c.cname, c.headquarter
from   company c, worksfor w
where  w.cname = c.cname and w.salary <= 70000 and w.pid not in (select ps.pid from personskill ps where skill = 'Programming') or
       w.cname = c.cname and w.salary <= 70000 and w.pid not in (select ps.pid from personskill ps where skill = 'AI');

-- Step 4 Replace 'or' by 'union'

select c.cname, c.headquarter
from   company c, worksfor w 
where  w.cname = c.cname
except 
(select c.cname, c.headquarter
 from   company c, worksfor w
 where  w.cname = c.cname and w.salary <= 70000 and 
        w.pid not in (select ps.pid from personskill ps where skill = 'Programming') 
 union 
 select c.cname, c.headquarter
 from   company c, worksfor w
 where  w.cname = c.cname and w.salary <= 70000 and 
        w.pid not in (select ps.pid from personskill ps where skill = 'AI'));

-- Step 5 Replace 'not in' with 'not exists'


select c.cname, c.headquarter
from   company c, worksfor w 
where  w.cname = c.cname
except 
(select c.cname, c.headquarter
 from   company c, worksfor w
 where  w.cname = c.cname and w.salary <= 70000 and 
        not exists (select 1
                    from   personskill ps 
                    where  w.pid = ps.pid and ps.skill = 'Programming') 
 union 
 select c.cname, c.headquarter
 from   company c, worksfor w
 where  w.cname = c.cname and w.salary <= 70000 and 
        not exists (select 1
                    from   personskill ps 
                    where  w.pid = ps.pid and skill = 'AI'));


-- Step 6 Replace 'not exists' with except

select c.cname, c.headquarter
from   company c, worksfor w 
where  w.cname = c.cname
except 
(select q.ccname, q.headquarter
 from 
   (select c.cname as ccname, c.headquarter, w.*
    from   company c, worksfor w
    where  w.cname = c.cname and w.salary <= 70000 
    except
    select c.*, w.*
    from   company c, worksfor w, personskill ps
    where  w.pid = ps.pid and ps.skill = 'Programming') q
 union 
 select q.ccname, q.headquarter
 from 
   (select c.cname as ccname, c.headquarter, w.*
    from   company c, worksfor w
    where  w.cname = c.cname and w.salary <= 70000 
    except
    select c.*, w.*
    from   company c, worksfor w, personskill ps
    where  w.pid = ps.pid and ps.skill = 'AI') q);

-- Step 7  Push selections and introduce joins and natural joins

select cname, headquarter
from   company natural join worksfor
except 
(select q.ccname, q.headquarter
 from 
   (select c.cname as ccname, c.headquarter, w.*
    from   company c
           natural join (select * 
                         from   worksfor 
                         where  salary <= 70000) w
    except
    select c.*, w.*
    from   company c 
           cross join worksfor w
           join  (select * 
                  from   personskill 
                  where  skill = 'Programming') ps on w.pid = ps.pid) q
 union 
 select q.ccname, q.headquarter
 from 
   (select c.cname as ccname, c.headquarter, w.*
    from   company c
           natural join (select * 
                         from   worksfor 
                         where  salary <= 70000) w
    except
    select c.*, w.*
    from   company c 
           cross join worksfor w
           join  (select * 
                  from   personskill 
                  where  skill = 'AI') ps on w.pid = ps.pid) q);



-- We will use some temporary views
with E as 
    (select c.cname as ccname, c.headquarter, w.*
     from   company c
            natural join (select *
                          from   worksfor
                          where  salary <= 70000) w),
     W as (select * from worksfor),
     Programming as (select w.*
                     from   W w join (select *
                                      from   personSkill
                                      where  skill = 'Programming') ps on w.pid = ps.pid),
     AI as (select w.*
            from   W w join (select *
                             from   personSkill
                             where  skill = 'AI') ps on w.pid = ps.pid)
select cname, headquarter
from   company natural join worksfor
except 
(select q.ccname, q.headquarter
 from   (select e.*
         from E e
         except
         select c.*, w.*
         from   company c 
                cross join Programming w) q
 union 
 select q.ccname, q.headquarter
 from   (select e.*
         from   E e
         except
         select c.*, w.*
         from   company c 
                cross join AI w) q);


-- Apply the law that 'Project_L(E1) union Project_L(E2) = Project_L(E1 union E2).
-- I.e., 'projection' distributes over 'union'


with E as 
    (select c.cname as ccname, c.headquarter, w.*
     from   company c
            natural join (select *
                          from   worksfor
                          where  salary <= 70000) w),
     W as (select * from worksfor),
     Programming as (select w.*
                     from   W w join (select *
                                      from   personSkill
                                      where  skill = 'Programming') ps on w.pid = ps.pid),
     AI as (select w.*
            from   W w join (select *
                             from   personSkill
                             where  skill = 'AI') ps on w.pid = ps.pid)
select cname, headquarter
from   company natural join worksfor
except 
(select q.ccname, q.headquarter
 from  ( (select e.*
          from   E e
          except
          select c.*, w.*
          from   company c 
                 cross join Programming w)
          union 
          (select e.*
           from   E e
           except
           select c.*, w.*
           from   company c 
                  cross join AI w)) q);


-- Use the set equality '(E - C X Programming) union (E- C X AI)
--                      = E - C X (Programming intersection AI)'


with E as 
    (select c.cname as ccname, c.headquarter, w.*
     from   company c
            natural join (select *
                          from   worksfor
                          where  salary <= 70000) w),
     W as (select * from worksfor),
     Programming as (select w.*
                     from   W w join (select *
                                      from   personSkill
                                      where  skill = 'Programming') ps on w.pid = ps.pid),
     AI as (select w.*
            from   W w join (select *
                             from   personSkill
                             where  skill = 'AI') ps on w.pid = ps.pid)
select cname, headquarter
from   company natural join worksfor
except 
(select q.ccname, q.headquarter
 from  (select e.*
        from   E e
        except
        (select c.*, q.*
         from   Company c 
                cross join (select *
                            from   Programming
                            intersect 
                            select *
                            from   AI) q)) q);


-- Pushing down projections

with 
     E as (select c.cname as ccname, c.headquarter, w.*
           from   company c
                  natural join (select cname, pid
                                from   worksfor 
                                where  salary <= 70000) w),
     W as (select cname, pid from worksfor),
     Programming as (select w.*
                     from   W w join (select pid
                                      from   personSkill
                                      where  skill = 'Programming') ps on w.pid = ps.pid),
     AI as (select w.*
            from   W w join (select pid
                             from   personSkill
                             where  skill = 'AI') ps on w.pid = ps.pid)
select cname, headquarter
from   company natural join worksfor
except 
(select q.ccname, q.headquarter
 from  (select e.*
        from   E e
        except
        (select c.*, q.*
         from   Company c 
                cross join (select *
                            from   Programming
                            intersect 
                            select *
                            from   AI) q)) q);

-- Introducing semi-joins

with 
     E as (select c.*, w.cname as wcname, w.pid
           from   company c
                  natural join (select cname, pid
                                from   worksfor 
                                where  salary <= 70000) w),
     W as (select cname, pid from worksfor),
     Programming as (select W.*
                     from   W natural join (select pid
                                            from   personSkill
                                            where  skill = 'Programming') ps),
     AI as (select W.*
            from   W natural join (select pid
                                   from   personSkill
                                   where  skill = 'AI') ps)
select cname, headquarter
from   company natural join worksfor
except 
(select cname, headquarter
 from  (select E.*
        from   E
        except
        (select C.*, S.*
         from   Company  C
                cross join (select *
                            from   Programming
                            intersect 
                            select *
                            from   AI) S)) q);


-- Pushing expression 'E' over 'except'  
-- Law  'A - B = A - (A natural join B)'

with E as  (select c.*, w.cname   as wcname, w.pid
            from   company c
                   join (select cname, pid
                         from   worksfor
                         where  salary <= 70000) w on (c.cname = w.cname)),
    W as (select cname, pid from worksfor),
    Programming as (select w.*
                    from   W w natural join (select pid 
                                             from   personSkill
                                             where  skill = 'Programming') p),
    AI as (select w.*
           from   W w natural join (select pid 
                                    from   personSkill
                                    where  skill = 'AI') p)
select cname, headquarter
from   company natural join (select cname from worksfor) w
except 
(select cname, headquarter
 from  ( select e.*
         from   E e
         except
         (select e.*
          from   E e
                 natural join (select *
                               from   Programming
                               intersect 
                               select *
                               from   AI) q)) q);




\qecho 'Problem 10'

-- Consider the following Pure SQL query.

select p.pid, exists (select 1
                      from   hasManager hm1, hasManager hm2
                      where  hm1.mid = p.pid and hm2.mid = p.pid and
                             hm1.eid <> hm2.eid)
from   Person p;

-- This query returns a pair (p,t) if p is the pid of a person who
-- manages at least two persons and returns the pair (p,f) other- wise.11

-- Using the insights gained from Problem~\ref{existsInSelect}, translate
-- this Pure SQL query to an equivalent RA SQL query.

-- Step 1: Rewrite the query as follows (observe that there are 2 cases)

select p.pid, true
from   Person p
where  exists (select 1
               from   hasManager hm1, hasManager hm2
               where  hm1.mid = p.pid and hm2.mid = p.pid and
                      hm1.eid <> hm2.eid)
union
select p.pid, false
from   Person p
where  not exists (select 1
                   from   hasManager hm1, hasManager hm2
                   where  hm1.mid = p.pid and hm2.mid = p.pid and
                          hm1.eid <> hm2.eid);


-- Step 2: Move constants 'true' and 'false' to queries in the respective
-- from clauses

select p.pid, c.booleanValue
from   Person p, (select true as booleanValue) c, hasManager hm1, hasManager hm2
where  hm1.mid = p.pid and hm2.mid = p.pid and hm1.eid <> hm2.eid
union
(select p.pid, c.booleanValue
 from   Person p, (select false as booleanValue) c
 except
 select p.pid, c.booleanValue
 from   Person p, (select false as booleanValue) c, hasManager hm1, hasManager hm2
 where  hm1.mid = p.pid and hm2.mid = p.pid and     hm1.eid <> hm2.eid)
 order by 1,2;

-- Step 3: Introduce joins


select p.pid, c.booleanValue
from   (select true as booleanValue) c
        cross join Person p
        join hasManager hm1 on (hm1.mid = p.pid)
        join hasManager hm2 on (hm1.mid = hm2.mid and hm1.eid <> hm2.eid)
union
(select p.pid, c.booleanValue
 from   Person p, (select false as booleanValue) c
 except
 select p.pid, c.booleanValue
 from   (select false as booleanValue) c
         cross join Person p
         join hasManager hm1 on (hm1.mid = p.pid)
         join hasManager hm2 on (hm1.mid = hm2.mid and hm1.eid <> hm2.eid))
 order by 1,2;


-- Step 4:  Optimize by pushing projections over joins and taking into
-- account foreign key constrains.


with person as (select pid   from  person)
select  q.mid, c.booleanValue
from   (select true as booleanValue) c
          cross join
          (select hm1.mid from hasManager hm1 join hasManager hm2 on (hm1.mid = hm2.mid and hm1.eid <> hm2.eid)) q
union
(select p.pid, c.booleanValue
 from   Person p, (select false as booleanValue) c
 except
 select q.mid, c.booleanValue
 from   (select false as booleanValue) c
        cross join
         (select hm1.mid from hasManager hm1 join hasManager hm2 on (hm1.mid = hm2.mid and hm1.eid <> hm2.eid)) q)
order by 1,2;









-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE dirk;





