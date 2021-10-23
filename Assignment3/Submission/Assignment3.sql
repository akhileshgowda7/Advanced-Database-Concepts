-- Script for Assignment 3

-- Creating database with full name

CREATE DATABASE akhilesh_gowda_mandya_ramesh;

-- Connecting to database 
\c akhilesh_gowda_mandya_ramesh;

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

\qecho 'Problem 6'

-- Consider the query ``Find the cname and headquarter of
-- each company that employs persons who earns less than 55000 and who do
-- not live in Bloomington.''

-- A possible way to write this query in Pure SQL is 

select c.cname, c.headquarter
from   company c
where  c.cname in (select w.cname
                   from   worksfor w
                   where  w.salary < 55000 and 
                          w.pid = SOME (select p.pid
                                        from   person p
                                        where  p.city <> 'Bloomington'));

\qecho 'step-1 removing the first IN' 

select DISTINCT c.cname, c.headquarter
from   company c,worksFor w
where  c.cname=w.cname and w.salary < 55000 and 
                          w.pid = SOME (select p.pid
                                        from   person p
                                        where  p.city <> 'Bloomington');

\qecho 'step-2 removing SOME' 

select DISTINCT c.cname, c.headquarter
from   company c,worksFor w,person p
where  c.cname=w.cname and w.salary < 55000 and w.pid = p.pid and p.city <> 'Bloomington';

\qecho 'step-3 CONVERTING TO RA Sql'

select DISTINCT c.cname, c.headquarter
from   company c JOIN (select w.* from worksFor w where salary < 55000)w on c.cname=w.cname JOIN  (select p.* from person p where city <> 'Bloomington')p on w.pid = p.pid;

\qecho 'step-4 OPTIMIZING' 

select DISTINCT c.cname, c.headquarter
from   company c JOIN (select w.* from worksFor w where salary < 55000)w on c.cname=w.cname JOIN  (select pid,city from person where city <> 'Bloomington')p on w.pid = p.pid;


-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.

\qecho 'Problem 7'

-- Consider the query ``Find the pid of each person who has
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

\qecho 'step-1 removing exists'

select p.pid
from   person p,skill s
where (p.pid, s.skill) not in (select ps.pid, ps.skill 
                                               from   personSkill ps) and
        not exists (select 1
                    from   skill s1, skill s2
                    where  s1.skill <> s2.skill and
                           (p.pid, s1.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps) and
                           (p.pid, s2.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps));


\qecho 'step-2 removing first and (converting it to intersect)'

select p.pid
from   person p,skill s
where (p.pid, s.skill) not in (select ps.pid, ps.skill 
                                               from   personSkill ps)
INTERSECT
select p.pid
from   person p,skill s where not exists (select 1
                    from   skill s1, skill s2
                    where  s1.skill <> s2.skill and
                           (p.pid, s1.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps) and
                           (p.pid, s2.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps));
\qecho 'step-3 removing last but one and(converting it to intersect)'


select p.pid
from   person p,skill s
where (p.pid, s.skill) not in (select ps.pid, ps.skill 
                                               from   personSkill ps)
INTERSECT

(select p.pid
from   person p,skill s where not exists (select q.pid
    from(select p.*,s1.*,s2.*
                    from   skill s1, skill s2
                    where  s1.skill <> s2.skill
                     INTERSECT
                     select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p
                    where  (p.pid, s1.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps) and
                           (p.pid, s2.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps))q));

\qecho 'step-4 removing the last and'

select p.pid
from   person p,skill s
where (p.pid, s.skill) not in (select ps.pid, ps.skill 
                                               from   personSkill ps)
INTERSECT

(select p.pid
from   person p,skill s where not exists (select q.pid
    from(select p.*,s1.*,s2.*
                    from   skill s1, skill s2
                    where  s1.skill <> s2.skill
                     INTERSECT
                     select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p
                    where  (p.pid, s1.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps) 
                    INTERSECT
                    select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p
                    where     (p.pid, s2.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps))q));

\qecho 'step-5 removing the first not in'

select q1.pid from(select p.*,s.*
from   person p,skill s EXCEPT select p.*,s.*
from   person p,skill s,personSkill ps
where p.pid=ps.pid and s.skill=ps.skill)q1
                                
INTERSECT

(select p.pid
from   person p,skill s where not exists (select q.pid
    from(select p.*,s1.*,s2.*
                    from   skill s1, skill s2
                    where  s1.skill <> s2.skill
                     INTERSECT
                     select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p
                    where  (p.pid, s1.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps) 
                    INTERSECT
                    select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p
                    where     (p.pid, s2.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps))q));

\qecho 'step-6 removing last Not in'

select q1.pid from(select p.*,s.*
from   person p,skill s EXCEPT select p.*,s.*
from   person p,skill s,personSkill ps
where p.pid=ps.pid and s.skill=ps.skill)q1
                                
INTERSECT

(select p.pid
from   person p,skill s where not exists (select q.pid
    from(select p.*,s1.*,s2.*
                    from   skill s1, skill s2
                    where  s1.skill <> s2.skill
                     INTERSECT
                     select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p
                    where  (p.pid, s1.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps) 
                    INTERSECT
                    (select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p
                         EXCEPT select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p,personSkill ps where p.pid=ps.pid and s2.skill=ps.skill))q));


\qecho 'step-7 removing last but one not in'

select q1.pid from(select p.*,s.*
from   person p,skill s EXCEPT select p.*,s.*
from   person p,skill s,personSkill ps
where p.pid=ps.pid and s.skill=ps.skill)q1
                                
INTERSECT

select p.pid
from   person p,skill s where not exists (select q.pid
    from(select p.*,s1.*,s2.*
                    from   skill s1, skill s2
                    where  s1.skill <> s2.skill
                     INTERSECT
                     (select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p
                     EXCEPT select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p,personSkill ps
                    where  p.pid=ps.pid and s1.skill=ps.skill )
                    INTERSECT
                    (select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p
                         EXCEPT select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p,personSkill ps where p.pid=ps.pid and s2.skill=ps.skill))q);


\qecho 'step-8 removing Not exist'

select q1.pid from(select p.*,s.*
from   person p,skill s EXCEPT select p.*,s.*
from   person p,skill s,personSkill ps
where p.pid=ps.pid and s.skill=ps.skill)q1
                                
INTERSECT

select DISTINCT q2.pid
from(select p.pid
from   person p,skill s
EXCEPT
select DISTINCT q3.pid
from(select p.pid
from  skill s ,(select q.pid
    from(select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p
                    where  s1.skill <> s2.skill
                     INTERSECT
                     (select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p
                     EXCEPT select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p,personSkill ps
                    where  p.pid=ps.pid and s1.skill=ps.skill )
                    INTERSECT
                    (select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p
                         EXCEPT select p.*,s1.*,s2.*
                    from   skill s1, skill s2,person p,personSkill ps where p.pid=ps.pid and s2.skill=ps.skill))q)p)q3)q2;

\qecho 'step-9 converting to RA SQL' 

select q1.pid from(select p.*,s.*
from   person p CROSS JOIN skill s EXCEPT select p.*,s.*
from   person p JOIN personSkill ps on p.pid=ps.pid JOIN skill s on s.skill=ps.skill)q1
                                
INTERSECT

select DISTINCT q2.pid
from(select p.pid
from   person p CROSS JOIN skill s
EXCEPT
select DISTINCT q3.pid
from(select p.pid
from  skill s CROSS JOIN (select q.pid
    from(select p.*,s1.*,s2.*
                    from   skill s1 JOIN skill s2 on s1.skill <> s2.skill CROSS JOIN person p
                    
                     INTERSECT

                     (select p.*,s1.*,s2.*
                    from   skill s1 JOIN skill s2 on s1.skill <> s2.skill CROSS JOIN person p
                     EXCEPT select p.*,s1.*,s2.*
                    from   skill s1 CROSS JOIN skill s2 CROSS JOIN person p JOIN personSkill ps on  p.pid=ps.pid and s1.skill=ps.skill
                     )
                    INTERSECT
                    (select p.*,s1.*,s2.*
                    from   skill s1 CROSS JOIN skill s2 CROSS JOIN person p
                         EXCEPT select p.*,s1.*,s2.*
                    from   skill s1 CROSS JOIN skill s2 CROSS JOIN person p JOIN personSkill ps on (p.pid=ps.pid and s2.skill=ps.skill)))q)p)q3)q2;



-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.

\qecho 'Problem 8'

-- Consider the query ``Find the pid and name of each person who
-- works for a company located in Bloomington but who does not knows any
-- person who lives in Chicago.''

 
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

\qecho 'step-1 removing the first exists and removing the first not exists' 

select p.pid, p.pname
from   person p,worksFor w, companyLocation c
where p.pid = w.pid and w.cname = c.cname and c.city = 'Bloomington'
EXCEPT
select p.pid, p.pname
from   person p,worksFor w, companyLocation c,knows k
where p.pid = w.pid and w.cname = c.cname and c.city = 'Bloomington' and
       p.pid=k.pid1 and exists (select 1
                                    from   person p
                                    where  k.pid2 = p.pid and  p.city = 'Chicago');

\qecho 'step-2 removing the last exists' --removing the last exists

select p.pid, p.pname
from   person p,worksFor w, companyLocation c
where p.pid = w.pid and w.cname = c.cname and c.city = 'Bloomington'
EXCEPT
select p.pid, p.pname
from   person p,worksFor w, companyLocation c,knows k,person p1
where p.pid = w.pid and w.cname = c.cname and c.city = 'Bloomington' and
       p.pid=k.pid1 and k.pid2 = p1.pid and  p1.city = 'Chicago';

\qecho 'step-3 converting to RA SQL' 
  
select p.pid, p.pname
from   person p JOIN worksFor w ON p.pid = w.pid JOIN (select c.cname,c.city from companyLocation c where c.city='Bloomington')c ON w.cname = c.cname
EXCEPT
select p.pid, p.pname
from   person p JOIN  worksFor w ON p.pid = w.pid JOIN (select c.cname,c.city from companyLocation c where c.city='Bloomington')c ON w.cname = c.cname JOIN  knows k ON p.pid=k.pid1 JOIN (select p1.pid from person p1 where p1.city = 'Chicago')p1 ON  k.pid2 = p1.pid 
;
 

\qecho 'step-4 optimising the RA query' 

select p.pid, p.pname
from   (select p.pid,p.pname from person p)p JOIN (select pid,cname from worksFor) w ON p.pid = w.pid JOIN (select c.* from companyLocation c where c.city='Bloomington')c ON w.cname = c.cname
EXCEPT
select p.pid, p.pname
from   (select p.pid,p.pname from person p)p JOIN(select pid,cname from worksFor ) w ON p.pid = w.pid JOIN (select c.* from companyLocation c where c.city='Bloomington')c ON w.cname = c.cname JOIN knows k ON p.pid=k.pid1 JOIN (select p1.pid from person p1 where p1.city = 'Chicago')p1 ON  k.pid2 = p1.pid 
;

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.


\qecho 'Problem 9'

-- Consider the query ''Find the cname and headquarter of each company
-- that (1) employs at least one person and (2) whose workers who make
-- at most 70000 have both the programming and AI skills.”

select c.cname, c.headquarter
from   company c
where  exists (select 1 from worksfor w where w.cname = c.cname) and
       not exists (select 1
                   from   worksfor w
                   where  w.cname = c.cname and w.salary <= 70000 and
                          (w.pid not in (select ps.pid from personskill ps where skill = 'Programming') or
                           w.pid not in (select ps.pid from personskill ps where skill = 'AI')));


\qecho 'step-1 removing exists' 

select DISTINCT c.cname, c.headquarter
from   company c,worksfor w
where  w.cname = c.cname and
       not exists (select 1
                   from   worksfor w
                   where  w.cname = c.cname and w.salary <= 70000 and
                          (w.pid not in (select ps.pid from personskill ps where skill = 'Programming') or
                           w.pid not in (select ps.pid from personskill ps where skill = 'AI')));


\qecho 'step-2 removing not exists and converting or to union' 

select DISTINCT c.cname, c.headquarter
from   company c,worksfor w
where  w.cname = c.cname 
EXCEPT
(select DISTINCT c.cname, c.headquarter
from   company c,worksfor w
where  w.cname = c.cname  and w.salary <= 70000 and
w.pid not in (select ps.pid from personskill ps where skill = 'Programming') 

UNION

select DISTINCT c.cname, c.headquarter
from   company c,worksfor w
where  w.cname = c.cname  and w.salary <= 70000 and
w.pid not in (select ps.pid from personskill ps where skill = 'AI'));

\qecho 'step-3 removing last not in' -- removing last not in

select DISTINCT c.cname, c.headquarter
from   company c,worksfor w
where  w.cname = c.cname 
EXCEPT
(select DISTINCT c.cname, c.headquarter
from   company c,worksfor w
where  w.cname = c.cname  and w.salary <= 70000 and
w.pid not in (select ps.pid from personskill ps where skill = 'Programming') 

UNION
select q.cname,q.headquarter
from(
select DISTINCT c.cname, c.headquarter,w.pid
from   company c,worksfor w
where  w.cname = c.cname  and w.salary <= 70000 
EXCEPT
select DISTINCT c.cname, c.headquarter,w.pid
from   company c,worksfor w,personskill ps
where  w.cname = c.cname  and w.salary <= 70000 and
w.pid=ps.pid and skill = 'AI')q);

\qecho 'step-4 removing the remaining not in ' 

select DISTINCT c.cname, c.headquarter
from   company c,worksfor w
where  w.cname = c.cname 
EXCEPT
(select q1.cname,q1.headquarter
from(select DISTINCT c.cname, c.headquarter,w.pid
from   company c,worksfor w
where  w.cname = c.cname  and w.salary <= 70000
EXCEPT 
select DISTINCT c.cname, c.headquarter,w.pid
from   company c,worksfor w,personskill ps
where  w.cname = c.cname  and w.salary <= 70000 and
w.pid=ps.pid and skill = 'Programming')q1

UNION
select q.cname,q.headquarter
from(
select DISTINCT c.cname, c.headquarter,w.pid
from   company c,worksfor w
where  w.cname = c.cname  and w.salary <= 70000 
EXCEPT
select DISTINCT c.cname, c.headquarter,w.pid
from   company c,worksfor w,personskill ps
where  w.cname = c.cname  and w.salary <= 70000 and
w.pid=ps.pid and skill = 'AI')q);

\qecho 'step-5 converting to RA SQL' 

select DISTINCT c.cname, c.headquarter
from company c JOIN worksfor w on w.cname = c.cname 
EXCEPT
(select q1.cname,q1.headquarter
from(select DISTINCT c.cname, c.headquarter,w.pid
from    company c JOIN (select w.* from worksfor w where w.salary <= 70000)w on w.cname = c.cname
EXCEPT 
select DISTINCT c.cname, c.headquarter,w.pid
from  company c JOIN (select w.* from worksfor w where w.salary <= 70000)w on w.cname = c.cname JOIN(select ps.* from personskill ps where skill = 'Programming')ps on w.pid=ps.pid
)q1

UNION
select q.cname,q.headquarter
from(
select DISTINCT c.cname, c.headquarter,w.pid
from   company c JOIN (select w.* from worksfor w where w.salary <= 70000 )w on w.cname = c.cname 
EXCEPT
select DISTINCT c.cname, c.headquarter,w.pid
from  company c JOIN (select w.* from worksfor w where w.salary <= 70000)w on w.cname = c.cname JOIN (select ps.* from personskill ps where skill = 'AI')ps on w.pid=ps.pid
)q);


\qecho 'step-6 optimizing' 

select DISTINCT c.cname, c.headquarter
from  (select c.cname,c.headquarter from company c)c JOIN (select w.cname from worksfor w)w on w.cname = c.cname 
EXCEPT
(select q1.cname,q1.headquarter
from(select DISTINCT c.cname, c.headquarter,w.pid
from   (select c.cname,c.headquarter from company c)c JOIN (select w.pid,w.cname,w.salary from worksfor w where w.salary <= 70000)w on w.cname = c.cname
EXCEPT 
select DISTINCT c.cname, c.headquarter,w.pid
from   (select c.cname,c.headquarter from company c)c JOIN (select w.pid,w.cname,w.salary from worksfor w where w.salary <= 70000)w on w.cname = c.cname JOIN(select ps.pid,skill from personskill ps where skill = 'Programming')ps on w.pid=ps.pid
)q1

UNION
select q.cname,q.headquarter
from(
select DISTINCT c.cname, c.headquarter,w.pid
from   (select c.cname,c.headquarter from company c)c JOIN (select w.pid,w.cname,w.salary from worksfor w where w.salary <= 70000 )w on w.cname = c.cname 
EXCEPT
select DISTINCT c.cname, c.headquarter,w.pid
from   (select c.cname,c.headquarter from company c)c JOIN (select w.pid,w.cname,w.salary from worksfor w where w.salary <= 70000)w on w.cname = c.cname JOIN (select ps.pid,skill from personskill ps where skill = 'AI')ps on w.pid=ps.pid
)q);

\qecho 'Problem 10'

-- Consider the following Pure SQL query.

-- This query returns a pair (p,t) if p is the pid of a person who
-- manages at least two persons and returns the pair (p,f) otherwise.

-- Using the insights gained from Problem 2, translate
-- this Pure SQL query to an equivalent RA SQL query.

select p.pid,  exists (select 1
                      from   hasManager hm1, hasManager hm2
                      where  hm1.mid = p.pid and hm2.mid = p.pid and
                             hm1.eid <> hm2.eid)
from   Person p;


\qecho 'step-1 converting exists to where'

--converting exists to where--

select p.pid, 't'
from   Person p
where
exists (select 1
from   hasManager hm1, hasManager hm2
where  hm1.mid = p.pid and hm2.mid = p.pid and
hm1.eid <> hm2.eid) 

UNION

(select p.pid,'f'
from   Person p
where
not exists (select 1
                      from   hasManager hm1, hasManager hm2
                      where  hm1.mid = p.pid and hm2.mid = p.pid and
                             hm1.eid <> hm2.eid));

\qecho 'step-2 converting exists'

select p.pid, 't'
from   Person p,hasManager hm1, hasManager hm2
where  hm1.mid = p.pid and hm2.mid = p.pid and
hm1.eid <> hm2.eid

UNION

(select p.pid,'f'
from   Person p
where
not exists (select 1
                      from   hasManager hm1, hasManager hm2
                      where  hm1.mid = p.pid and hm2.mid = p.pid and
                             hm1.eid <> hm2.eid));

\qecho 'step-3 converting not exists'

select p.pid, 't'
from   Person p,hasManager hm1, hasManager hm2
where  hm1.mid = p.pid and hm2.mid = p.pid and
hm1.eid <> hm2.eid

UNION

(select p.pid,'f'
from   Person p

EXCEPT select p.pid,'f'
from   Person p ,hasManager hm1, hasManager hm2
where  hm1.mid = p.pid and hm2.mid = p.pid and
                             hm1.eid <> hm2.eid);

\qecho 'step-4 converting to RA SQL' 

select  DISTINCT p.pid, 't'
from   Person p JOIN hasManager hm1 on hm1.mid = p.pid JOIN hasManager hm2 on ( hm2.mid = p.pid and hm1.eid <> hm2.eid)

UNION

(select DISTINCT p.pid,'f'
from   Person p

EXCEPT select DISTINCT p.pid,'f'
from   Person p JOIN hasManager hm1 on hm1.mid = p.pid JOIN hasManager hm2 on (hm2.mid = p.pid  and hm1.eid <> hm2.eid));



-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE akhilesh_gowda_mandya_ramesh;





