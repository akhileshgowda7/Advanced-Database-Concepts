-- Script for B561 2021 Assignment 7

-- colaboration with Vishwas shivakumar, vshivak

create database akhilesh_gowda;

\c akhilesh_gowda
\o Assignment7.txt

\qecho 'Problem 7'
create table PC(parent int, child int);

insert into PC values 
   (1,2),
   (1,3),
   (1,4),
   (2,5),
   (2,6),
   (3,7),
   (4,8),
   (5,9),
   (7,10),
   (7,11),
   (9,12);

create or replace function nonrecursivesameGeneration()
returns table(m int,n int) as
$$
declare
i record;
begin
drop table if exists pairs;
create table pairs(m int, n int);
drop table if exists totalpairs;
create table totalpairs(m int,n int);
insert into totalpairs select p.child,p1.child from pc p,pc p1 where p.child<>p1.child;
insert into pairs (SELECT parent, parent FROM PC) UNION (select child, child from PC);
for i in (select a.m,a.n from totalpairs a)
loop
     insert into pairs SELECT i.m, i.n
                            FROM pairs pr, PC t, pc t1
                            WHERE i.m=t.child and i.n=t1.child and pr.m = t.parent and pr.n = t1.parent;
end loop;
return QUERY (select distinct pr1.m,pr1.n from pairs pr1);
end;
$$language plpgsql;


select * from nonrecursivesameGeneration() order by m, n;

-- Consider the following recursive query that computes the {\tt
-- sameGeneration} relation:

WITH RECURSIVE sameGeneration(m, n) AS
          ((SELECT parent, parent FROM PC) UNION (select child, child from PC)
          UNION
          SELECT  t1.child, t2.child
          FROM    sameGeneration pair, PC t1, PC t2
          WHERE   pair.m = t1.parent and pair.n = t2.parent)
SELECT DISTINCT pair.m, pair.n from sameGeneration pair order by m, n;

-- Write a non-recursive function sameGeneration() in the language
-- plpgsql that computes the sameGeneration relation.

\qecho 'Problem 8'

create table partSubpart(pid int, sid int, quantity int);
create table basicPart(pid int, weight int);

insert into partSubpart values 
   (1,2,1),
   (1,3,3),
   (1,4,2),
   (2,5,1),
   (2,6,4),
   (3,7,2),
   (4,8,1),
   (5,9,2),
   (7,10,2),
   (7,11,3),
   (9,12,5);

insert into basicPart values
  (6,  1),
  (8,  4),
  (10, 1),
  (11, 5),
  (12, 3);

\qecho 'Problem 8.a'

-- Write a {\bf recursive} function {\tt recursiveAggregatedWeight(p
-- integer)} that returns the aggregated weight of a part {\tt p}.

-- Test your function.
-- Run the following query which for each part, computed is aggregatd
-- weight


create or replace function recursiveAggregatedWeight(p integer)
returns integer AS
$$
DECLARE res integer;
i RECORD;
BEGIN 
res = 0;
if exists(select 1 from basicPart bp where bp.pid = p) 
   then return(select weight from basicPart bp where bp.pid = p);
else 
   For i in(select * from partSubpart ps where ps.pid = p)
   loop 
   res = res + recursiveAggregatedWeight(i.sid)*(i.quantity);
   End loop;
end if;
return res;
end;
$$ language plpgsql;


with part as 
  (select pid as P
   from   partSubPart
   union  
   select sid as P
   from   partSubpart)
select part.P, recursiveAggregatedWeight(part.P) 
from   part order by 1;


\qecho 'Problem 8.b'

-- Write a {\bf non-recursive} function {\tt
-- nonRecursiveAggregatedWeight(p integer)} that returns the aggregated
-- weight of a part {\tt p}.  Test your function.

-- Test your function.
-- Run the following query which for each part, computed is aggregatd
-- weight

create table temp(product integer, cost integer);

create or replace function Cost_product()
returns table(product integer,cost integer) as
$$
select pid,cost * quantity from partSubPart join temp on(sid = temp.product)
except 
select * from temp
$$
Language SQL;

create or replace function nonRecursiveAggregatedWeight(p integer)
returns integer as
$$
begin 
if exists(select 1 from basicPart bp where bp.pid = p) then return 
   (select weight from basicPart bp where bp.pid = p);
else
Drop table if exists temp;
create table temp(product integer, cost integer);
insert into temp select * from basicPart;
while exists(select * from Cost_product())
loop
insert into temp select * from Cost_product();
end loop;
end if;
return(select sum(h.cost) from temp h where h.product = p group by(h.product));
end;
$$ language plpgsql;


with part as 
  (select pid as P
   from   partSubPart
   union  
   select sid as P
   from   partSubpart)
select part.P, nonRecursiveAggregatedWeight(part.P) 
from   part order by 1;

\qecho 'Problem 11'

-- Write a PostgreSQL program frequentSets(t int) that returns the set
-- of all t-frequent set.

create table document(doc int, words text[]);

insert into document values
  (1, '{"A", "B", "C", "D", "E"}'),
  (2, '{"A", "B", "C", "E", "F"}'),
  (3, '{"A", "E", "F"}'),
  (4, '{"E", "A"}');


drop table if exists wtable;
create table wtable(word text);
insert into wtable select distinct unnest(d.words) from document d;

drop table if exists temptable;
create table temptable(W text[]);
insert into temptable values ('{}');

create or replace function func()
returns table (frequentset text[]) AS
$$
   select array(select * from UNNEST(t1.W) union select t2.word)::text[] as W
   from temptable t1, wtable t2
   where t2.word not in (select * from UNNEST(t1.W))
   except
   select W from temptable;
$$ language sql;

create or replace function frequentSets(t int) returns table (frequentset text[]) as
$$
declare c int  := 0;
declare r RECORD;
begin
   while exists(select * from func())
   loop
      for r in select * from func()
      loop
         select into c count(*) from document d where r.frequentset <@ d.words;
         insert into temptable select r.frequentset; 
         c := 0;
      end loop;
   end loop;
   return query select W from temptable where (select count(*) from document d where W <@ d.words) >= t ;
end;
$$ language plpgsql;

-- Tests:

\qecho 'frequentSets(0)'
select * from frequentSets(0) order by 1;

\qecho 'frequentSets(1)'
select * from frequentSets(1) order by 1;

\qecho 'frequentSets(2)'
select * from frequentSets(2) order by 1;

\qecho 'frequentSets(3)'
select * from frequentSets(3) order by 1;

\qecho 'frequentSets(4)'
select * from frequentSets(4) order by 1;

\qecho 'frequentSets(5)'
select * from frequentSets(5) order by 1;


\qecho 'Problem 12'

drop table if exists Graph;
create table Graph(source int, target int);


\qecho 'Problem 12.a'

-- Write a {\bf recursive} function {\tt recursiveHamiltonian()} that
-- returns {\tt true} if the graph stored in {\tt Graph} is
-- Hamiltonian, and {\tt false} otherwise.  

-- Test your function on the following graphs.


CREATE TABLE tempGraph(source int, target int);
create or replace function recursiveHamiltonian() returns text AS 
$$
DECLARE
initialSource integer;
initialDestination integer;
Paths integer;
BEGIN
   
   Paths := (SELECT count(*) FROM Graph);
   SELECT INTO initialSource, initialDestination 
               source, target
               from Graph
               LIMIT 1;
   INSERT INTO tempGraph VALUES(initialSource, initialDestination);

   return (SELECT recursiveFunctionToDetectGraph(initialSource, initialDestination, Paths));

END;
$$ LANGUAGE plpgsql;

create or replace function recursiveFunctionToDetectGraph(initialSource integer, initialDestination integer, Paths integer) returns text AS 
$$
DECLARE
tempSource integer := 0;
tempDestination integer := 0;
GraphTemp integer := 0;
BEGIN
   SELECT INTO tempSource, tempDestination 
               source, target
               FROM Graph where source = initialDestination;
   
   if tempDestination IS NULL OR tempSource IS NULL THEN
      return 'f';
   else 
      if tempSource = 0 AND tempDestination = 0 THEN
         return 'f';
      END IF;
      
      IF EXISTS(SELECT 1 from tempGraph where source = tempSource AND target = tempDestination) THEN
         return 'f';
      ELSE
         INSERT INTO tempGraph VALUES(tempSource, tempDestination);
         GraphTemp:= (SELECT count(*) from tempGraph);
         if tempDestination=initialSource AND GraphTemp=Paths THEN
            return 't';
         else 
            if not tempSource = 0 AND not tempDestination = 0 THEN
               return (SELECT recursiveFunctionToDetectGraph(initialSource, tempDestination, Paths)); 
            else 
               return 'f';
            END IF;
         END IF;
      END IF;
   END IF;  

END;
$$ LANGUAGE plpgsql;

insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,1);

select * from recursiveHamiltonian();
TRUNCATE table tempGraph;

delete from Graph;

insert into Graph values
 (1,2),
 (2,3),
 (3,1),
 (4,5),
 (5,4);

select * from recursiveHamiltonian();
TRUNCATE table tempGraph;
delete from Graph;

\qecho 'Problem 12.b'

-- Write a {\bf non-recursive} function {\tt nonRecursiveHamiltonian}
-- that returns {\tt true} if the graph stored in {\tt Graph} is
-- Hamiltonian, and {\tt false} otherwise. 

-- Test your function on the following graphs.



CREATE OR REPLACE function nonRecursiveHamiltonian() returns text AS
$$
DECLARE
initialSource integer := 0;
initialDestination integer := 0;
tempSource integer:= 0;
GraphTemp integer:= 0;
countGraph integer:= 0;
BEGIN
SELECT INTO initialSource, initialDestination
   source, target 
   from graph
   LIMIT 1;
   INSERT INTO tempGraph VALUES(initialSource, initialDestination);

   WHILE EXISTS(SELECT 1 from graph where source = initialDestination) 
   LOOP
      SELECT INTO tempSource, initialDestination
         source, target 
         from graph
         where source = initialDestination;
      IF EXISTS(SELECT 1 from tempGraph where source = tempSource AND target = initialDestination) THEN
         EXIT;
      ELSE
         INSERT INTO tempGraph VALUES(tempSource, initialDestination);
      END IF;
   END LOOP;
   countGraph := (SELECT count(*) FROM Graph);
   GraphTemp:= (SELECT count(*) from tempGraph);
   if initialSource = tempSource AND countGraph = GraphTemp THEN
      return 't';
   else 
      return 'f';
   END IF;   
END;
$$ LANGUAGE plpgsql;

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,1);

SELECT * FROM nonRecursiveHamiltonian();
TRUNCATE table tempGraph;

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,1),
 (4,5),
 (5,4);

SELECT * FROM nonRecursiveHamiltonian();
TRUNCATE table tempGraph;

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,5),
 (5,6),
 (6,7),
 (7,8),
 (8,9),
 (9,10),
 (10,1);

 SELECT * FROM nonRecursiveHamiltonian();
TRUNCATE table tempGraph;

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,5),
 (5,6),
 (6,7),
 (7,8),
 (8,9),
 (9,10);

SELECT * FROM nonRecursiveHamiltonian();
TRUNCATE table tempGraph;

\qecho 'Problem 14'

-- Write, in PostgreSQL, a basic MapReduce program, i.e., a mapper func-
-- tion and a reducer function, as well as a 3-phases simulation that
-- imple- ments the semijoin of two relations R(A,B) and S(A,B,C),

-- Test the function on the following relations:

drop table if exists R;
drop table if exists S;
create table R(A integer, B integer);
create table S(A integer, B integer, C integer);

insert into R values
   (1,1),
   (1,2),
   (1,3),
   (2,2),
   (2,3);

insert into S values
   (1,1,1),
   (1,1,2),
   (1,2,3),
   (1,4,1),
   (2,2,1),
   (3,4,2);

Create table EncodingOfRandS(key text,value jsonb);
Insert into EncodingOfRandS 
Select 'R' as key,jsonb_build_object('a',r.a,'b',r.b) as value from R r
union
Select 'S' as key,jsonb_build_object('a',s.a,'b',s.b) as value from S s order by 1,2;


Create or Replace Function mapper(key text, value jsonb) returns table(key jsonb, value text) as
$$
  Select value, key;
$$ language sql;


Create or Replace Function reducer(key jsonb,valuesArray text[]) returns table(key text,value jsonb) as
$$
  Select 'R semijoin S'::text,key where Array['R','S'] <@ valuesArray;
$$ language sql;

  
With Map_Phase as (Select m.key,m.value from EncodingOfRandS, Lateral(Select key,value from mapper(key,value))m),
     Group_Phase as (Select key,array_agg(value) as value from Map_Phase Group by (key)),
     Reduce_Phase as (Select r.key,r.value from Group_Phase, Lateral(Select key,value from reducer(key,value))r)
Select p.value->'a'as a,p.value->'b' as b from Reduce_Phase p order by value;


\qecho 'Problem 16'

-- Write, in PostgreSQL, a basic MapReduce program, i.e., a mapper func-
-- tion and a reducer function, as well as a 3-phases simulation that
-- imple- ments the SQL query

-- Here R is a relation with schema (A, B). You can assume that the
-- domains of A and B are integers. Use the encoding and decoding methods
-- described above.

drop table R;
create table R(A integer, B integer);

insert into R values
   (1,1),
   (1,2),
   (1,3),
   (2,2),
   (2,3),
   (3,2);


drop table if exists EncodingOfRandS;
create table EncodingOfRandS(key text, b jsonb);
insert into EncodingOfRandS
   select r.A as key, jsonb_build_object('b', r.B) as b from R r
   order by 1;


-- mapper function
CREATE OR REPLACE FUNCTION mapper(key integer, b jsonb)
RETURNS TABLE(key integer, b jsonb) AS
$$
    SELECT key, b;
$$ LANGUAGE SQL;

--Reducer function
CREATE OR REPLACE FUNCTION reducer(key integer, valuesArray text[])
RETURNS TABLE(key jsonb, b text[]) AS
$$
  select jsonb_build_object('key', key, 'sum', (select sum(s::integer) from unnest(valuesArray) s)), valuesArray;
$$ LANGUAGE SQL;


WITH Map_phase1 AS
   (
      SELECT mapperRefN.key, mapperRefN.b from EncodingOfRandS enR,
      LATERAL(select key, b from mapper(enR.key:: integer, enR.b))mapperRefN

   ),
 Group_Phase1 AS
   (
      SELECT mpn.key, array_agg(mpn.b->'b') as b from Map_phase1 mPn
      group by(mPn.key)
   ),
   Reduce_Phase1 AS 
   (
      select rMp.key, rMp.b from Group_Phase1, LATERAL(SELECT key, b from reducer(key, b:: text[]))rMp
   )
select key->('key') as a, b , key->('sum') as sum_bs 
from Reduce_Phase1 
where cardinality(b)<3
order by 1;


\qecho 'Problem 17'

drop table if exists R;
drop table if exists S;

create table R(K int, V int);
create table S(K int, W int);

insert into R values
   (1,1),
   (1,2),
   (1,3),
   (2,2),
   (2,3),
   (3,2),
   (7,7);

insert into S values
   (1,1),
   (1,2),
   (1,3),
   (3,2),
   (4,1),
   (4,2),
   (5,1),
   (5,2),
   (6,4),
   (6,5);

\qecho 'Problem 17.a'

-- Define a PostgreSQL view coGroup that computes a complex-object
-- relation that represent the co-group transformation R.cogroup(S). Show
-- that this view works.

CREATE TYPE valuesType AS (RV_values int[], SW_values int[]);

create or replace view coGroup as
WITH Kvalues AS (
   SELECT r.K FROM R r 
   
   UNION 
   
   SELECT s.K FROM S s
),
R_K AS (
   SELECT r.K, ARRAY_AGG(r.V) AS RV_values
   FROM R r
   GROUP BY (r.K)
   UNION
   
   SELECT k.K, '{}' AS RV_VALUES FROM Kvalues k
   WHERE k.K NOT IN (SELECT r.K FROM R r)),
S_K AS (
   SELECT s.K, ARRAY_AGG(s.W) AS SW_values
   FROM S s
   GROUP BY (s.K)

   UNION
   
   SELECT k.K, '{}' AS SW_VALUES FROM Kvalues k
   WHERE k.K NOT IN (SELECT s.K FROM S s)
)
SELECT K as key, array_agg(row(RV_values, SW_values)::valuesType) as values
FROM R_K NATURAL JOIN S_K GROUP BY R_K.K ;


--demo of view
SELECT key, UNNEST (values) as values
FROM coGroup;

\qecho 'Problem 17.b'

-- Write a PostgreSQL query that use this {\tt coGroup} view to
-- compute the semi join $R\, \ltimes\, S$, in other words compute the
-- relation $R \bowtie \pi_{K}(S)$.

WITH
 coGroupData as (
SELECT key, UNNEST (values) as v
FROM coGroup)

SELECT c1.key as k, unnest((c1.v).rv_values) as v
FROM coGroupData c1
WHERE (c1.v).rv_values = (c1.v).sw_values;

\qecho 'Problem 17.c'

-- Write a PostgreSQL query that uses this coGroup view to implement
-- the SQL query

WITH
 coGroupData as (
SELECT key, UNNEST (values) as v
FROM coGroup)

SELECT c1.key as rk, c2.key as ck
FROM coGroupData c1, coGroupData c2
WHERE not (c1.v).rv_values && (c2.v).sw_values
and CARDINALITY((c1.v).rv_values) > 0 AND CARDINALITY((c2.v).sw_values) > 0;

SELECT distinct r.K as rK, s.K as sK
FROM   R r, S s
WHERE  NOT ARRAY(SELECT r1.V
                 FROM   R r1
                 WHERE  r1.K = r.K) && ARRAY(SELECT s1.W
                                             FROM   S s1
                                             WHERE  s1.K = s.K);
\o 
\c postgres
drop database akhilesh_gowda;

