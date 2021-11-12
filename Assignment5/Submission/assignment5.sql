-- Script for Assignment 5

-- Creating database with full name

CREATE DATABASE mandya_ramesh_akhilesh_gowda;

-- Connecting to database 
\c mandya_ramesh_akhilesh_gowda


-- Relation schemas and instances for assignment 5

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


-- We define the following functions and predicates

/*
Functions:
set_union(A,B)               A union B
set_intersection(A,B)        A intersection B
set_difference(A,B)          A - B
add_element(x,A)             {x} union A
remove_element(x,A)          A - {x}
make_singleton(x)            {x}
choose_element(A)            choose some element from A
bag_union(A,B)               the bag union of A and B
bag_to_set(A)                coerce a bag A to the corresponding set

Predicates:
is_in(x,A)                   x in A
is_not_in(x,A)               not(x in A)
is_empty(A)                  A is the emptyset
is_not_emptyset(A)           A is not the emptyset
subset(A,B)                  A is a subset of B
superset(A,B)                A is a super set of B
equal(A,B)                   A and B have the same elements
overlap(A,B)                 A intersection B is not empty
disjoint(A,B)                A and B are disjoint 
*/

-- Set Operations: union, intersection, difference

-- Set union $A \cup B$:
create or replace function set_union(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) union select unnest(B) order by 1);
$$ language sql;

-- Set intersection $A\cap B$:
create or replace function set_intersection(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) intersect select unnest(B) order by 1);
$$ language sql;

-- Set difference $A-B$:
create or replace function set_difference(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) except select unnest(B) order by 1);
$$ language sql;


-- Add element to set
create or replace function add_element(x anyelement, A anyarray) 
returns anyarray as
$$
   select bag_to_set(x || A);
$$ language sql;


-- Add element to set
create or replace function remove_element(x anyelement, A anyarray) 
returns anyarray as
$$
   select array_remove(A, x);
$$ language sql;


-- Make singleton  x --->  {x}

create or replace function make_singleton(x anyelement) 
returns anyarray as
$$
   select add_element(x,'{}');
$$ language sql;


-- Choose some element from set A
create or replace function choose_element(A anyarray) 
returns anyelement as
$$
   select x 
   from (select UNNEST(A) as x) q
   order by random();
$$ language sql;


-- Bag operations

-- Bag union 
create or replace function bag_union(A anyarray, B anyarray) 
returns anyarray as
$$
   select A || B;
$$ language sql;

-- bag To set
create or replace function bag_to_set(A anyarray)
returns anyarray as
$$
   select array(select distinct unnest(A) order   by 1);
$$ language sql;


-- Set Predicates: set membership, set non membership, emptyset, subset, superset, overlap, disjoint

-- Set membership $x \in A$:
create or replace function is_in(x anyelement, A anyarray) 
returns boolean as
$$
   select x = SOME(A);
$$ language sql;

-- Set non membership $x \not\in A$:
create or replace function is_not_in(x anyelement, A anyarray) 
returns boolean as
$$
   select not(x = SOME(A));
$$ language sql;

-- emptyset test $A = \emptyset$:
create or replace function is_empty(A anyarray) 
returns boolean as
$$
   select A <@ '{}';
$$ language sql;


-- non emptyset test $A \neq \emptyset$:
create or replace function is_not_empty(A anyarray) 
returns boolean as
$$
   select not(A <@ '{}');
$$ language sql;

-- Subset test $A\subseteq B$:
create or replace function subset(A anyarray, B anyarray) 
returns boolean as
$$
   select A <@ B;
$$ language sql;

-- Superset test $A \supseteq B$:
create or replace function superset(A anyarray, B anyarray) 
returns boolean as
$$
   select A @> B;
$$ language sql;

-- Equality test $A = B$
create or replace function equal(A anyarray, B anyarray) 
returns boolean as
$$
   select A <@ B and A @> B;
$$ language sql;

-- Overlap test $A\cap B \neq \emptyset$:
create or replace function overlap(A anyarray, B anyarray) 
returns boolean as
$$
   select A && B;
$$ language sql;

-- Disjointness test $A\cap B = \emptyset$:
create or replace function disjoint(A anyarray, B anyarray) 
returns boolean as
$$
   select not A && B;
$$ language sql;


-- Set Operations: union, intersection, difference

-- Set union $A \cup B$:
create or replace function setunion(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) union select unnest(B) order by 1);
$$ language sql;

-- Set intersection $A\cap B$:
create or replace function setintersection(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) intersect select unnest(B) order by 1);
$$ language sql;

-- Set difference $A-B$:
create or replace function setdifference(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) except select unnest(B) order by 1);
$$ language sql;


-- Set Predicates: set membership, subset, superset, overlap, disjoint

-- Set membership $x \in A$:
create or replace function isIn(x anyelement, A anyarray) 
returns boolean as
$$
   select x = SOME(A);
$$ language sql;

-- Subset test $A\subseteq B$:
create or replace function subset(A anyarray, B anyarray) 
returns boolean as
$$
   select A <@ B;
$$ language sql;

-- Superset test $A \supseteq B$:
create or replace function superset(A anyarray, B anyarray) 
returns boolean as
$$
   select A @> B;
$$ language sql;

-- Overlap test $A\cap B \neq \emptyset$:
create or replace function overlap(A anyarray, B anyarray) 
returns boolean as
$$
   select A && B;
$$ language sql;

-- Disjointness test $A\cap B = \emptyset$:
create or replace function disjoint(A anyarray, B anyarray) 
returns boolean as
$$
   select not A && B;
$$ language sql;

-- Complex-object views on the Person, Company, companyLocation,
-- worksFor, Skill, personSkill, and Knows database

-- Define the view {\tt companyHasEmployees(cname,employees)} which
-- associates with each company, identified by a cname, the set of
-- pids of persons who work for that company. 

create or replace view companyHasEmployees as
   select cname, array(select pid 
                       from   worksfor w
                       where  w.cname = c.cname order by 1) as employees
   from   company c order by 1;


-- Define a view {\tt cityHasCompanies(city,companies)} which associates
-- with each city the set of cnames of companies who are located in that
-- city. 

create or replace view cityHasCompanies as
   select city, array_agg(cname order by 1) as companies
   from   companyLocation 
   group by city order by 1;




-- Define a view {\tt companyLocations(cname,locations)} which associates
-- with each company, identified by a cname, the set of cities in which
-- that company is located.  

create or replace view companyHasLocations     as
   select cname, array(select city 
                       from   companyLocation cc
                       where  c.cname = cc.cname order by 1) as locations
   from   company c
   order by 1;



-- Define a view {\tt knowsPersons(pid,persons)} which associates with each
-- person, identified by a pid, the set of pids of persons he or she
-- knows.

create or replace view knowsPersons as
   select p.pid, array(select k.pid2 
                       from   knows k
                       where  k.pid1 = p.pid order by pid2) as persons
   from   person p
   order by 1;




-- The view {\tt isKnownByPersons(pid,persons)} which associates with
-- each person, identified by a pid, the set of pids of persons who know
-- that person.  Observe that there may be persons who are not known by
-- any one.

create or replace view isKnownByPersons as
   select distinct p.pid, array(select k.pid1 
                                from   knows k
                                where  k.pid2 = p.pid order by pid1) as persons
   from   person p
   order by 1;


-- Define a view {\tt personHasSkills(pid,skills)} which associates with
-- each person, identified by a pid, his or her set of job skills.
-- Observe that a person may not have any job skills.  (Test your view.)

create or replace view personHasSkills  as
   select distinct p.pid, array(select s.skill
                                from   personSkill s
                                where  s.pid = p.pid order by 1) as skills
   from   person p order by 1;





-- Define a view {\tt skillOfPersons(skills,persons)} which associates
-- with each job skill the set of pids of persons who have that job
-- skill.  Observe that there may be job skills that are not job skills
-- of any person.  (Test your view.)

create or replace view  skillOfPersons as
    select js.skill, array(select ps.pid
                           from   personSkill ps
                           where  ps.skill = js.skill order by 1) as persons
    from   Skill js order by 1;


-- Problem 1

\qecho 'Problem 1.a' 

-- Find the cname and headquarter of each company that employs at
-- least two persons who each have both the AI and the Programming job
-- skills.  

select DISTINCT c.cname,c.headquarter
from company c, companyHasEmployees e,worksfor w
where c.cname=w.cname and w.cname=e.cname and w.pid in (select ps.pid
                                                        from personHasSkills ps
                                                        where subset(ARRAY['AI','Programming'],ps.skills)) and cardinality(e.employees)>=2;
                                                    
\qecho 'Problem 1.b'  
-- Find each skill that is not a job skill of any person who works for
-- Yahoo or for Netflix.

select unnest (set_difference(ARRAY(select s.skill
                       from Skill s),ARRAY(select DISTINCT unnest(ps.skills)
                                           from worksfor w, personHasSkills ps
                                           where w.pid=ps.pid and (w.cname='Yahoo' or w.cname='Netflix')))) as skill;


\qecho 'Problem 1.c'  
-- Find the set of companies that employ at least 3 persons who each
-- know at least five persons.  (So this query returns {\bf only one}
-- object, i.e., the set of companies specified in the query.)

select ARRAY_agg(q1.cname) as companies
from(select DISTINCT q.cname,cardinality(ARRAY_agg(q.emp)) as emp1
from (select ce.cname,unnest(ce.employees) as emp
from companyHasEmployees ce
)q  where q.emp IN (select kp.pid from knowsPersons kp where cardinality(kp.persons)>=5) group by q.cname)q1 where q1.emp1>=3;

\qecho 'Problem 1.d' 
-- Find the pid and name of each person $p$ along with the set of pids
-- of persons who (1) know $p$ and (2) who have the AI skill but not
-- the Programming skill.

select p.pid,p.pname,q.persons
from person p natural join (select k.pid,set_intersection(k.persons,set_difference(ARRAY(select ps.pid
from personHasSkills ps
where subset('{"AI"}',ps.skills)),ARRAY(select ps.pid
from personHasSkills ps
where subset('{"Programming"}',ps.skills)))) as persons 
from isKnownByPersons k)q;

\qecho 'Problem 1.e' 
-- Find each pairs $(s_1,s_2)$ of different skills $s_1$ and $s_2$
-- such that the number of employees who have skill $s_1$ and who make
-- strictly more than 55000 is strictly less than the number of
-- employees who have skill $s_2$ and who make at most 55000.

SELECT q.skill, q1.skill
FROM(SELECT q2.skill, cardinality(array_agg(q2.person)) as person
     FROM(SELECT q5.skill, q5.person
          FROM(SELECT sp.skill, UNNEST(sp.persons) as person
               FROM skillOfPersons sp)q5, worksfor w
               WHERE w.pid = q5.person and w.salary>55000)q2
          GROUP BY(q2.skill))q, (SELECT q3.skill, cardinality(array_agg(q3.person)) as person
                                FROM(SELECT q4.skill, q4.person
                            FROM(SELECT sp.skill, UNNEST(sp.persons) as person
                                FROM skillOfPersons sp)q4, worksfor w
                                WHERE w.pid = q4.person and w.salary<=55000)q3
                        GROUP BY(q3.skill))q1
WHERE q.person < q1.person and q.skill <> q1.skill;

\qecho 'Problem 2' 
-- Find the following set of sets \[\{S \mid S \subseteq \text{Skill}
-- \land |S| \leq 3\}.\] I.e., this is the set consisting of each set of
-- job skills whose size (cardinality) is at most 3.

select '{}' as skills
union
select make_singleton(s.skill) as skills
from skill s
union
(select array[s1.skill,s2.skill] as skills
from skill s1, skill s2
where s1.skill != s2.skill and s1.skill > s2.skill
order by s1.skill)
union
(select array[s1.skill,s2.skill, s3.skill] as skills
from skill s1, skill s2, skill s3
where s1.skill != s2.skill and s2.skill!= s3.skill and s3.skill != s1.skill
and s1.skill > s2.skill and s2.skill > s3.skill
order by s1.skill);

\qecho 'Problem 4'
-- Let $t$ be a number called a \emph{threshold}.  We say that a
-- (unordered) pair of different person pids $\{p_1,p_2\}$
-- \emph{co-occur} with frequency at least $t$ if there are at least $t$
-- skills that are skills of both the person with pid $p_1$ and the
-- person with pid $p_2$.

-- Write a function {\tt coOccur(t integer)} that returns the (unordered)
-- pairs $\{p_1,p_2\}$ of person pid that co-occur with frequency at
-- least {\tt t}.

-- Test your {\tt coOccur} function for $t$ in the range $[0,3]$.

CREATE OR REPLACE FUNCTION coOccur(t integer)
RETURNS TABLE (PAIR text) AS
$$
SELECT DISTINCT ADD_ELEMENT(TA.PID2,MAKE_SINGLETON(TA.PID1)) AS PAIR
FROM
(SELECT T1.PID AS PID1, T2.PID AS PID2, CARDINALITY(SET_INTERSECTION(T1.SKILLS,T2.SKILLS)) AS COMMON_SKILL_COUNT 
 FROM
(SELECT PID,SKILLS FROM personHasSkills) AS T1,
(SELECT PID,SKILLS FROM personHasSkills) AS T2
WHERE T1.PID <> T2.PID) TA WHERE TA.COMMON_SKILL_COUNT >= t
ORDER BY 1;
$$ LANGUAGE SQL;

\qecho 'coOccur 0'
select * from coOccur(0);
\qecho 'coOccur 1'
select * from coOccur(1);
\qecho 'coOccur 2'
select * from coOccur(2);
\qecho 'coOccur 3'
select * from coOccur(3);


\qecho 'Problem 5' 
-- Let $A$ and $B$ be sets such that $A\cup B\neq\emptyset$.  The
-- \emph{Jaccard index} $J(A,B)$ is defined as the quantity \[
-- \frac{|A\cap B|}{|A \cup B|}.\] The Jaccard index is a frequently used
-- measure to determine the similarity between two sets.  Note that if
-- $A\cap B=\emptyset$ then $J(A,B) = 0$, and if $A = B$ then $J(A,B) =
-- 1$.

-- Let $t$ be a number called a \emph{threshold}.  We assume that $t$ is
-- a {\tt float} in the range $[0,1]$.

-- Write a function {\tt JaccardSimilar(t float)} that returns the set of
-- unordered pairs $\{s_1,s_2\}$ of different skills such that the set of
-- persons who have skill $s_1$ and the set of persons who have skill
-- $s_2$ have a Jaccard index of at least {\tt t}.

-- Test your function {\tt JaccardSimilar} for the following values for
-- $t$: $0$, $0.25$, $0.5$, $0.75$, and $1$.

-- \section{Nested Relations and Semi-structured databases}

-- Consider the lecture on Nested and Semi-structured Data models.  In
-- that lecture, we considered the {\tt studentGrades} nested relation
-- and we constructed it using a PostgreSQL query starting from the {\tt
-- Enroll} relation.

CREATE TABLE student (sid TEXT, sname TEXT, major TEXT, byear INT);
INSERT INTO student VALUES
('s100', 'Eric'  , 'CS'     , 1988),
('s101', 'Nick'  , 'Math'   , 1991),
('s102', 'Chris' , 'Biology', 1977),
('s103', 'Dinska', 'CS'     , 1978),
('s104', 'Zanna' , 'Math'   , 2001),
('s105', 'Vince' , 'CS'     , 2001);

CREATE TABLE course (cno TEXT, cname TEXT, dept TEXT);
INSERT INTO course VALUES
('c200', 'PL'      , 'CS'),
('c201', 'Calculus', 'Math'),
('c202', 'Dbs'     , 'CS'),
('c301', 'AI'      , 'CS'),
('c302', 'Logic'   , 'Philosophy');

CREATE TABLE enroll (sid TEXT, cno TEXT, grade TEXT);
insert into enroll values 
     ('s100','c200', 'A'),
     ('s100','c201', 'B'),
     ('s100','c202', 'A'),
     ('s101','c200', 'B'),
     ('s101','c201', 'A'),
     ('s102','c200', 'B'),
     ('s103','c201', 'A'),
     ('s101','c202', 'A'),
     ('s101','c301', 'C'),
     ('s101','c302', 'A'),
     ('s102','c202', 'A'),
     ('s102','c301', 'B'),
     ('s102','c302', 'A'),
     ('s104','c201', 'D');


create or replace function JaccardSimilar(t float)
returns table (pair text[2]) as
$$
select array[s1.skill, s2.skill] as pair
from skillofpersons s1, skillofpersons s2
where s1.skill < s2.skill
and cast(cardinality(set_intersection(s1.persons,s2.persons)) as float)
/cast(cardinality(set_union(s1.persons,s2.persons)) as float) >= t;
$$ language sql;

\qecho 't=0'
select * from JaccardSimilar(0);
\qecho 't=0.25'
select * from JaccardSimilar(0.25);
\qecho 't=0.50'
select * from JaccardSimilar(0.50);
\qecho 't=0.75'
select * from JaccardSimilar(0.75);
\qecho 't=1'
select * from JaccardSimilar(1);

\qecho 'Problem 6'

-- Write a PostgreSQL view {\tt courseGrades} that creates the nested
-- relation of type \[{\tt (cno, gradeInfo\{(grade, students
-- \{(sid)\})\})}\] This view should compute for each course, the grade
-- information of the students enrolled in this course.  In particular,
-- for each course and for each grade, this relation stores in a set the
-- students who obtained that grade in that course.

-- Test your view.

CREATE TYPE studentType AS (sid text);

CREATE TYPE gradeStudentsType AS (grade text, students studentType[]);

CREATE VIEW courseGrades AS
(WITH E as (SELECT DISTINCT cno, grade, array_agg(row(sid)::studentType) as students
            FROM enroll
            GROUP BY (cno, grade)),
      F as (SELECT DISTINCT cno, array_agg(row(grade, students)::gradeStudentsType) as gradeInfo
           FROM E
           GROUP BY (cno))       
SELECT * FROM F ORDER BY cno, gradeInfo);

SELECT DISTINCT * FROM courseGrades;

-- Problem 7

-- Starting from the {\tt courseGrades} view in
-- Problem~\ref{nestedrelation} solve the following queries:

\qecho 'Problem 7.a'
-- Find each pair $(c,S)$ where $c$ is the cno of a course and $S$ is the
-- set of sids of students who received an `A' or a `B' in course $c$.
-- The type of your answer relation should be (cno: text,
-- students:(sid:text)[]).

select cno, array_agg(row(s.sid)::studentType) as students
from courseGrades cg, unnest(gradeInfo)gi, unnest(students)s
where gi.grade='A' or gi.grade='B'
group by (cno);

\qecho 'Problem 7.b'
-- Find each $(s,C)$ pairs where $s$ is the sid of a students and $C$ is
-- the set of cnos of courses in which the student received an `A'.  The
-- type of your answer relation should be (sid:text,
-- courses:(cno:text)[]).

CREATE TYPE courseType AS (cno text);

select s.sid, array_agg(row(cno)::courseType) as courses
from courseGrades cg, unnest(gradeInfo)gi, unnest(students)s
where gi.grade='A'
GROUP BY (s.sid)
ORDER BY s.sid;

\qecho 'Problem 8'
-- Write a PostgreSQL view {\tt jcourseGrades} that creates a
-- semi-structured database which stores {\tt jsonb} objects whose
-- structure conforms with the structure of tuples as described for the
-- {\tt courseGrades} in Problem 6.

-- Test your view.

CREATE VIEW jcourseGrades AS(
WITH
   E AS(select cno, grade, jsonb_agg(jsonb_build_object('sid',e.sid)) as Students
       from enroll e
       GROUP BY (cno,grade)
       order by (cno,grade)),
   F AS(select jsonb_build_object('cno', cno, 'courseinfo',jsonb_agg(jsonb_build_object('grade',grade, 'students',Students))) as courseinfo
       from E
       GROUP BY (cno)
       ORDER BY (cno))
   select courseinfo from F
);

-- Test your view.

select g.courseinfo from jCourseGrades g;


-- Problem 9
-- Starting from the {\tt jcourseGrades} view in
-- Problem~\ref{jsoncourseGrades} solve the following queries. Note that
-- the output of each of these queries is a nested relation.

\qecho 'Problem 9.a'
-- Find each pair $(c,s)$ where $c$ is the cno of a course and $s$ is the
-- sid of a student who did not received an `A' in course $c$.  

SELECT jg.courseinfo ->> 'cno' as cno, (s ->> 'sid') as sid
FROM jCourseGrades jg, jsonb_array_elements(jg.courseinfo -> 'courseinfo') gi,
jsonb_array_elements(gi -> 'students') s
WHERE (gi -> 'grade')::jsonb <> '"A"';

\qecho 'Problem 9.b'
-- Find each $(s,C)$ pairs where $s$ is the sid of a students and $C$ is
-- the set of cnos of courses in which the student received an `A'.

select array[row(c2.cno),row(c1.cno)] as coursepair,(select bag_to_set( 
      (select array_agg(s1->'sid')
      from jcourseGrades as j1, jcourseGrades as j2,
      jsonb_array_elements(j1.courseinfo->'courseinfo') grade1,
      jsonb_array_elements(j2.courseinfo->'courseinfo') grade2,
      jsonb_array_elements(grade1->'students') s1,
      jsonb_array_elements(grade2->'students') s2            
               
WHERE (grade1->'grade')::jsonb ='"B"' and (grade2->'grade')::jsonb ='"B"' 
and (j1.courseinfo->>'cno') = c1.cno
and (j2.courseinfo->>'cno') = c2.cno
and s1->'sid' = s2->'sid'
GROUP BY (j1.courseinfo->'cno',j2.courseinfo->'cno')) )) as students 
from course c1,course c2 WHERE c1.cno > c2.cno;


\c postgres

drop database mandya_ramesh_akhilesh_gowda;

