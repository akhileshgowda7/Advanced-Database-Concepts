-- Script for B561 2021 Assignment 7

create database dvgassignment7;

\c dvgassignment7


\qecho 'Problem 6: Practive Problem'

--- Topological sort
create table Graph (source int, target int);
create table Vertex (vertex int);
create table subGraph (source int, target int);

insert into Graph values
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

create or replace function inDegreeZeroVertex() returns integer as
$$
   select source 
   from   subGraph e
   where  source not in (select target
                         from   subGraph);
$$ language sql;


create or replace function topologicalSort() 
returns int[] as
$$
declare v integer;
        topologicalOrder int[] := '{}';
begin
   drop table if exists subGraph;
   drop table if exists Vertex;
   
   create table subGraph (source int, target int);
   create table Vertex (vertex int);

   insert into subGraph select * from Graph;
   insert into Vertex (select source
                       from   Graph
                       union  
                       select target
                       from   Graph);

    while exists (select 1 from subGraph)
    loop
      v := (select inDegreeZeroVertex());
      topologicalOrder := array_append(topologicalOrder, v);
      delete from subGraph where source = v;   
    end loop;

    return array_cat(topologicalOrder, 
                     (select array(select vertex
                                   from   Vertex 
                                   where  vertex not in (select unnest(topologicalOrder)))));
end;
$$ language plpgsql;

table Graph;

select * from topologicalSort();

drop table Graph;
drop table Vertex;
drop table subGraph;


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

-- Consider a parent-child relation PC(parent, child). (You can assume
-- that PC is a rooted tree and the domain of the attributes parent
-- and child is int.) An edge (p,c) in PC indicates that node p is a
-- parent of node c. Now consider a pair of nodes (m,n) in PC (m and n
-- maybe the same nodes.) We say that m and n are in the same
-- generation when the distance from m to the root of PC is the same
-- as the distance from n to the root of PC.

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

create table if not exists SG(m integer, n integer); 

create or replace function new_SG_pairs()
returns table (source integer, target integer) AS
$$
(select   t1.child as m, t2.child as n
 from     SG, PC t1, PC t2 
 where    SG.m=t1.parent and SG.n = t2.parent)
except
(select   *
 from     SG);
$$ language sql;

create or replace function sameGeneration()
returns table (m int, n int) as 
$$
begin
   drop table if exists SG;
   create table SG(m integer, n integer); 

   insert into SG select distinct t1.parent as m, t1.parent as n 
                  from   PC t1
                  where  not exists (select 1 from PC t2 where t2.child = t1.parent);

   while exists(select new_SG_pairs()) 
   loop
        insert into SG select * from new_SG_pairs();
   end loop;
   return query
          select * from SG order by 1,2;
end;
$$ language plpgsql;

table PC;

select * from sameGeneration();

drop table PC;


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

-- The solution is based on the following rules: 
-- ps_triples(p,s,q) :- partsubpart(p,s,q)                                                                         
-- ps_triples(p,s,q*q1) :- ps_triples(p,s1,q1), partsubpart(s1,s,q)                                                       

-- The ps_triples relation contains each triple (p,s,q) where "p" is a
-- part, "s" is a direct or indirect subpart of "p" and "q" is
-- quantity with which "s" occurs as as subpart of "p".

-- We can then compute the weight of each part "p"
-- by computing the sum of the quantities of
-- the basics part of "p" multiplied by their respective weight


WITH RECURSIVE ps_triples(pid,sid,quantity) AS (
    SELECT pid, sid, quantity FROM partSubPart
    UNION
    SELECT ps1.pid, ps2.sid, ps1.quantity*ps2.quantity
    FROM   ps_triples ps1 JOIN partSubPart ps2 ON (ps1.sid = ps2.pid))
SELECT ps.pid, SUM(ps.quantity*bp.weight) as aggregatedweight
FROM   ps_triples ps JOIN basicPart bp ON (ps.sid=bp.pid)
GROUP  BY(ps.pid)
UNION 
SELECT pid, weight
FROM   basicPart order by 1;




-- We can turn these ideas into a function AggregatedWeight(p)
-- which computes the aggregated weight of part "p"

create or replace function recursiveAggregatedWeight(part int)
returns bigint as
$$
   select case when part in (select pid from basicPart) then (select weight 
                                                              from   basicPart
                                                              where  pid = part)
               else (select sum(recursiveAggregatedWeight(sid)*quantity)
                     from   partSubpart 
                     where  pid = part)
           end;
$$ language sql;

-- Test your function.
-- Run the following query which for each part, computed is aggregatd
-- weight

table partSubPart;
table basicPart;

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


-- The following is a iterative solution for the same problem

create table if not exists ps_triples(pid int, sid int, quantity int);
delete from ps_triples;

create or replace function new_ps_triples()
returns table (pid integer, sid integer, quantity integer) as
$$
  select  t.pid, ps.sid, t.quantity*ps.quantity
  from    ps_triples t, partSubpart ps
  where   t.sid = ps.pid
  except
  select  * from ps_triples;
$$ language sql;


-- the function ps_triples computes for                                                                            
-- each part each of its basic subpart along                                                                       
-- with the number of times that that subpart                                                                      
-- occurs                                                                                                          

create or replace function ps_triples()
returns table (pid integer, sid integer, quantity integer) as
$$
begin
   drop table ps_triples;
   create table ps_triples(pid integer, sid integer, quantity integer);

   insert into ps_triples select * from partSubPart;

   while exists(select * from new_ps_triples())
   loop
     insert into ps_triples select * from new_ps_triples();
   end loop;

   return query (select * from ps_triples ps
                 where  ps.sid in (select p.pid from basicPart p) order by 1,2);
end;
$$ language plpgsql;

-- the function nonRecursiveAggregatedWeight returns for each part (including basic parts),                                     
-- the aggregated cost of that part                                                                                

create or replace function nonRecursiveAggregatedWeight(part integer) 
returns bigint as
$$
select case when part in (select pid from basicPart) then (select weight
                                                           from   basicPart
                                                           where  pid = part)
       else    (select  sum(ps.quantity * bp.weight)
                from    ps_triples() ps, basicPart bp
                where   ps.pid = part and ps.sid = bp.pid)
       end;        
$$ language sql;



-- Test your function.
-- Run the following query which for each part, computed is aggregatd
-- weight

table partSubPart;
table basicPart;


with part as 
  (select pid as P
   from   partSubPart
   union  
   select sid as P
   from   partSubpart)
select part.P, nonRecursiveAggregatedWeight(part.P) 
from   part order by 1;

\qecho 'Problem 9 -- Practice Problem'

-- Heap Sort


﻿-- Implementing Heap Data Structure
create table raw_data(ind integer,
                      val integer);

INSERT INTO raw_data VALUES (1, 3), (2, 1), (3, 2), (4, 0), (5, 7), (6, 8), (7,9), (8, 11),
 (9, 1), (10, 3);

SELECT * FROM raw_data;

-- Heap Data Structure, you can use CREATE TYPE to create a new data structure in sql,
-- but here, I prefered a table-like data structure.
CREATE TABLE heap(ind INTEGER, 
                  val INTEGER,
                  left_child INTEGER,
                  right_child INTEGER,
                  parent INTEGER);

DO $$
DECLARE 
    i INTEGER;
    n INTEGER := (SELECT COUNT(*) FROM raw_data);
    k INTEGER := n/2;
BEGIN
    INSERT INTO heap VALUES (0, NULL, NULL, NULL, NULL);

    FOR i IN SELECT ind FROM raw_data LOOP
	INSERT INTO heap SELECT * FROM raw_data WHERE ind = i;
	IF (i <= k) THEN
	    UPDATE heap SET left_child = 2*i WHERE ind = i;
	    UPDATE heap SET right_child = 2*i+1 WHERE ind = i;
	    IF (i > 1) THEN
	        UPDATE heap SET parent = i/2 WHERE ind = i;
	    ELSE
		UPDATE heap SET parent = NULL WHERE ind = i;
	    END IF;
	ELSE
	    UPDATE heap SET parent = i/2 WHERE ind = i;
	END IF;
    END LOOP;
END $$;

SELECT * FROM heap;



-- As describe in the resource page, we need several function to maintain the heap properties

CREATE OR REPLACE FUNCTION percolatingDown (k INTEGER, n INTEGER) 
	RETURNS void AS
$$
    DECLARE
        child INTEGER;
        tmp INTEGER := (SELECT val FROM heap WHERE ind = k);
    BEGIN
        WHILE (2*k <= n) LOOP
	    child := 2*k;

	    IF ((SELECT child <> n) 
	        AND 
	        ((SELECT val FROM heap WHERE ind = child) > (SELECT val FROM heap WHERE ind = child + 1)))
	    THEN
	        child := child + 1;
	    END IF;

	    IF (tmp > (SELECT val FROM heap WHERE ind = child)) THEN
	        UPDATE heap SET val = (SELECT val FROM heap WHERE ind = child) WHERE ind = k;
	    ELSE
		EXIT;
	    END IF;
	    k := child;
        END LOOP;
        UPDATE heap SET val = tmp WHERE ind = k;
    END;
$$ LANGUAGE plpgsql;   


-- Build the Heap
CREATE OR REPLACE FUNCTION build_heap() RETURNS VOID AS
$$
DECLARE n INTEGER := (SELECT COUNT(*) FROM heap) - 1;
DECLARE k INTEGER := n/2;

BEGIN
    WHILE k > 0 LOOP
	PERFORM percolatingDown(k,n);
	k := k-1;
    END LOOP;

END;
$$ LANGUAGE PLPGSQL;

CREATE TABLE IF NOT EXISTS sort_data (ind INTEGER,
				      val INTEGER);
				      
DELETE FROM sort_data;


-- Insert Method
CREATE OR REPLACE FUNCTION heap_insert(x INTEGER) RETURNS void AS
$$
DECLARE 
    n INTEGER := (SELECT count(*) FROM heap) - 1;
    pos INTEGER;
    
BEGIN 
    pos := n + 1;
    INSERT INTO heap VALUES (pos, x, NULL, NULL, pos/2);

    WHILE ((pos > 1) AND (x < (SELECT val FROM heap WHERE ind = pos/2))) LOOP
        UPDATE heap SET val = (SELECT val FROM heap WHERE ind = pos/2) WHERE ind = pos;
        pos := pos/2;

    END LOOP; 

    UPDATE heap SET val = x WHERE ind = pos;

    PERFORM percolatingDown(1, n+1);
END;    
$$ LANGUAGE PLPGSQL;

-- Delete Method
CREATE OR REPLACE FUNCTION heap_extract_min() RETURNS INTEGER AS
$$
DECLARE 
    n INTEGER := (SELECT COUNT(*) FROM heap);
    min INTEGER := (SELECT val FROM heap WHERE ind = 1);
BEGIN
    IF (n = 0) THEN
	RETURN NULL;
    END IF;

    DELETE FROM heap WHERE ind = 1;

    UPDATE heap SET ind = ind - 1 WHERE ind > 0;

    PERFORM percolatingDown(1, n-1);

    RETURN min;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM heap ORDER BY ind;
select heap_insert(4);	
SELECT heap_extract_min();
-- Heap Sort
CREATE OR REPLACE FUNCTION heap_sort() RETURNS VOID AS
$$
DECLARE 
    n INTEGER := (SELECT COUNT(*) FROM heap) - 1;
    i INTEGER := n;
    k INTEGER := 2;
    tmp INTEGER;

BEGIN
    PERFORM build_heap();
    WHILE (i > 0) LOOP
        tmp := (SELECT val FROM heap WHERE ind = i);
        UPDATE heap SET val = (SELECT val FROM heap WHERE ind = 1) WHERE ind = i;
        UPDATE heap SET val = tmp WHERE ind = 1;
        n := n - 1;
        PERFORM percolatingDown(1, n);
        
        i := i - 1;
    END LOOP;

    WHILE (k <= (SELECT COUNT(*) FROM heap)) LOOP
	INSERT INTO sort_data (SELECT k-1, h.val FROM heap h WHERE h.ind = (SELECT COUNT(*) FROM heap) - k +1);
        k := k+1;
    END LOOP;

END;


$$ LANGUAGE plpgsql;

select * from raw_data order by ind;
--
--  ind | val
-- -----+-----
--    1 |   3
--    2 |   1
--    3 |   2
--    4 |   0
--    5 |   7
--    6 |   8
--    7 |   9
--    8 |  11
--    9 |   1
--   10 |   3
-- (10 rows) 


select heap_sort();


select * from sort_data ORDER BY ind;
-- 
--  ind | val
-- -----+-----
--    1 |   0
--    2 |   1
--    3 |   2
--    4 |   3
--    5 |   3
--    6 |   4
--    7 |   7
--    8 |   8
--    9 |   9
--   10 |  11
-- (10 rows)




\qecho 'Problem 10 -- Practice Problem'
-- Dijkstra 
-- Create the table that will be used to implement Dijkstra's algorithm

CREATE TABLE weightedGraph (Source INTEGER, Target INTEGER, Weight INTEGER);

-- Populate the weightedGraph
INSERT INTO weightedGraph VALUES
  (0, 1, 2),
  (1, 0, 2),
  (0, 4, 10),
  (4, 0, 10),
  (1, 3, 3),
  (3, 1, 3),
  (1, 4, 7),
  (4, 1, 7),
  (2, 3, 4),
  (3, 2, 4),
  (3, 4, 5),
  (4, 3, 5),
  (4, 2, 6),
  (2, 4, 6);
 
-- The table path tracks the distance between a source node and each other node in
-- the graph
CREATE TABLE  Path (Node INTEGER, Dist INTEGER);



-- This function returns a table representing the children of nodes
-- in the distance table but whose distances from the start
-- node computed
CREATE OR REPLACE FUNCTION Stop_Condition () 
RETURNS TABLE (Val INTEGER) AS
$$
  SELECT 1
  FROM   weightedGraph g, Path p
  WHERE  g.source = p.node AND
         g.target NOT IN (SELECT p1.node
                          FROM   Path p1
                          WHERE  p1.dist <= p.dist + g.weight);
$$ LANGUAGE SQL;



-- This function executes Dijkstra's algorithm 
CREATE OR REPLACE FUNCTION Dijkstra (source INTEGER) 
RETURNS TABLE (target INTEGER, distance INTEGER) AS
$$
  BEGIN
  DROP TABLE IF EXISTS Path;
  CREATE TABLE  Path (Node INTEGER, Dist INTEGER);
  -- Initially populate the 'Path' table with the adjacent nodes of the 'source' nodes 
  -- along with their respective 'weight' 
  
  INSERT INTO Path SELECT source, 0;
 
   -- Keep adding nodes to the table of path and distances until all nodes that
  -- can be reached from the sources have been added
  
  WHILE (EXISTS(SELECT Stop_Condition()))
  LOOP
    -- Add nodes that are immediate neighbors of the nodes that have already
    -- been added to the path's table
    INSERT INTO Path (SELECT g.target, p.dist+g.weight
                      FROM   path p, weightedGraph g
                      WHERE  p.node = g.source AND
                             NOT EXISTS (SELECT 1
                                         FROM   path p_one
                                         WHERE  g.target = p_one.Node AND
                                                p_one.Dist <= (p.Dist+g.Weight)));
   END LOOP;

   RETURN QUERY (SELECT node, dist
                 FROM   Path p
                 WHERE  not exists (SELECT 1
                                    FROM   Path p1
                                    WHERE  p.node = p1.node and p.dist > p1.dist));
  END;
$$ LANGUAGE PLPGSQL;

table weightedGraph;

WITH Node(node) as (select source from weightedGraph union select target from weightedGraph)
SELECT n.node as source, q.target as target, distance
FROM   Node n, lateral (select target, distance from Dijkstra(n.node)) q order by 1, 3, 2;


\qecho 'Problem 11'

-- Write a PostgreSQL program frequentSets(t int) that returns the sets
-- of all t-frequent sets.

create table Document(doc int, words text[]);

insert into Document values
  (1, '{"A", "B", "C", "D", "E"}'),
  (2, '{"A", "B", "C", "E", "F"}'),
  (3, '{"A", "E", "F"}'),
  (4, '{"E", "A"}');

table document;


-- The relation "FrequentSets" will at any time contains subsets of
-- "word" that are frequent according to a certain threshold "t".
-- Initially this set will be empty and at the end it will contain all
-- of the frequent sets.
create table FrequentSets(F text[]);

create table currentLevelFrequentSets(current_F text[]);

create table nextLevelFrequentSets(next_F text[]);


-- The function 'addWord' adds a word "w" to a set of words "S".
create or replace function addWord(S text[], w text) returns text[] as
$$
   select array(select UNNEST(S) 
                union
                select w order by 1);
$$ language sql;

-- The function 'removeWord' removes a word "w" from a set of words
-- "S".
create or replace function removeWord(S text[], w text) returns text[] as
$$
   select array(select UNNEST(S) 
                except 
                select w order by 1);
$$ language sql;
-- The function 'isFrequent' determines if an itemset X is frequent by
-- counting the number of documents whose words contain X, and then,
-- to verify if this number is at least "t".
create or replace function isFrequent(X text[], t integer)
returns boolean as
$$
   select (select count(1)
           from   document d
           where  X <@ d.words) >= t;
$$ language sql;

-- The function 'isCandidate' implements the 'Apriori' pruning rule:
-- Given a itemset C, we consider each set of the form C - {w} where w
-- is in C.  I.e., we consider each strict subset of C with one less
-- element than C.  If one of these subsets in not frequent then we
-- can deduce that C can not be frequent either.  On the other end, if
-- each of these subsets is frequent, then we need to proceed with C
-- and determine whether or not it is frequent.

create or replace function isCandidate(C text[]) returns boolean as
$$
select not exists(select  1
                  from    UNNEST(C) w
                  where   removeWord(C,w) not in (select current_F
                                                  from   currentLevelFrequentSets));
$$ language sql;

-- This function produces new candidates, based on the frequent sets
-- at the current level, by adding to each such set each possible word
-- that occurs among the words that appears somewhere in a frequent
-- set at the current level, and to verify that doing so yield a
-- candidate in accordance with the Apriori rule.

create or replace function new_Candidates()
returns table (C text[]) AS
$$
  with remainingWord as (select distinct unnest(current_F) as w
                         from   currentLevelFrequentSets)
  select distinct addWord(current_F,w)
  from   currentLevelFrequentSets, remainingWord

  where  not(array[w] <@ current_F) and 
         isCandidate(addWord(current_F, w));
$$ language sql;


-- The function 'frequentSets' returns the frequent sets relative to
-- threshold 't'.
create or replace function FrequentSets(t integer)
returns table(frequentSet text[]) as
$$
begin
drop table   currentLevelFrequentSets;
create table currentLevelFrequentSets(current_F text[]);
insert into  currentLevelFrequentSets select array[word]
                                      from   (select distinct unnest(words) as word 
                                              from Document) q
                                      where  isFrequent(array[word],t);

drop table   frequentSets;
create table frequentSets(F text[]);
insert into  frequentSets select current_F from currentLevelFrequentSets;

drop table   nextLevelFrequentSets;
create table nextLevelFrequentSets(next_F text[]);



while exists(select new_Candidates())
loop
   delete from nextLevelFrequentSets;
   insert into nextLevelFrequentSets (select C 
                                      from   new_Candidates()
                                      where  isFrequent(C,t));
                                      
   insert into frequentSets select * from nextLevelFrequentSets;
   
   delete from currentLevelFrequentSets;
   insert into currentLevelFrequentSets select * from nextLevelFrequentSets;                                     
end loop;

return query (select F from frequentSets
              union 
              select '{}'  
              where  t <= (select count(1) from document) order by 1);
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

\qecho 'Problem 12.a'

-- Write a {\bf recursive} function {\tt recursiveHamiltonian()} that
-- returns {\tt true} if the graph stored in {\tt Graph} is
-- Hamiltonian, and {\tt false} otherwise.

create table Graph(source int, target int);

create or replace function recursiveGraphPath(graphNodes int[]) 
returns   table (path int[]) as
$$
select '{}'
union 
select array[node]
from   unnest(graphNodes) node
union
select array_append(p.path,node)
from   unnest(graphNodes) node, lateral(select path
                                        from   recursiveGraphPath(array_remove(graphNodes, node))) p
where  (p.path[array_upper(p.path,1)],node) in (select * from Graph);                                
$$ language sql;

create or replace function recursiveHamiltonianPath()
returns table (hamiltonPath int[]) as
$$
with graphNode as (select source from Graph
                   union
                   select target from Graph)
select path
from   recursiveGraphPath(array(select * from graphNode)) 
where  cardinality(path) = (select count(1) 
                            from   graphNode) and
       (path[array_upper(path,1)],path[1]) in (select * from   Graph);
$$ language sql;


create or replace function recursiveHamiltonian()
returns boolean as
$$
select exists(select recursiveHamiltonianPath());
$$ language sql;

-- Test your function on the following graphs.


-- delete from Graph;
-- insert into Graph values (1,2), (2,3), (3,1);

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,1);

select recursiveHamiltonian();

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,1),
 (4,5),
 (5,4);

select recursiveHamiltonian();

\qecho 'Problem 12.b'

-- Write a {\bf non-recursive} function {\tt nonRecursiveHamiltonian}
-- that returns {\tt true} if the graph stored in {\tt Graph} is
-- Hamiltonian, and {\tt false} otherwise. 

create table graphNode(node int);
create table graphPath(path int[]);

create or replace function nonRecursiveHamiltonian()
returns boolean as
$$
declare
   i int;
   ct_nodes int;
begin
  drop table graphNode;
  create table graphNode(node int);
  insert into graphNode (select source from Graph union select target from Graph);

  drop table graphPath;
  create table graphPath(path int[]);
  insert into graphPath values ('{}'::int[]);
  insert into graphPath select array[node] from graphNode;

  ct_nodes := (select count(1) from graphNode);
  
  for i in 1..ct_nodes loop
     insert into   graphPath select array_append(p.path::int[],n.node::int)
                             from   graphPath p, graphNode n
                             where  n.node not in (select * from unnest(p.path)) and
                                    cardinality(p.path) = i-1 and
                                    (p.path[cardinality(p.path)],n.node) in (select * from Graph);
     delete from graphPath p where cardinality(p.path) = i-1;                                    
  end loop;

  return (select exists (select p.path
                         from   graphPath p
                         where  cardinality(p.path) = ct_nodes and
                                (p.path[cardinality(p.path)],p.path[1]) in (select * from Graph)));
end;
$$ language plpgsql;


delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,1);

select nonRecursiveHamiltonian();


delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,1),
 (4,5),
 (5,4);

select nonRecursiveHamiltonian();


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

select nonRecursiveHamiltonian();


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

select nonRecursiveHamiltonian();

\qecho 'Problem 13-- Practice Problem'

-- Write, in PostgreSQL, a basic MapRe- duce program, i.e., a mapper
-- function and a reducer function, as well as a 3-phases simulation that
-- implements the symmetric difference of two unary relations R(a) and
-- S(a), i.e., the relation (R − S) ∪ (S − R). You can assume that the
-- domain of the attribute ‘a’ is integer.

-- EncodingOfRandS;

create table R(a int); 
insert into R values (1),(2),(3),(4);
create table S(a int);
insert into S values (2),(4),(5);

create table EncodingOfRandS(key text, value jsonb);

insert into EncodingOfRandS
   select 'R' as key, jsonb_build_object('a', r.a) as value
   from   R r
   union
   select 'S' as key, jsonb_build_object('a', s.a) as value
   from   S s
   order by 1;

table EncodingOfRandS;

/*
 key |  value   
-----+----------
 R   | \{"a": 1\}
 R   | \{"a": 4\}
 R   | \{"a": 2\}
 R   | \{"a": 3\}
 S   | \{"a": 4\}
 S   | \{"a": 5\}
 S   | \{"a": 2\}
(7 rows)
*/

-- mapper function
CREATE OR REPLACE FUNCTION mapper(key text, value jsonb)
RETURNS TABLE(key jsonb, value text) AS
$$
    SELECT value, key;
$$ LANGUAGE SQL;

-- reducer function
CREATE OR REPLACE FUNCTION reducer(key jsonb, valuesArray text[])
RETURNS TABLE(key text, value jsonb) AS
$$
    SELECT 'R symmetric difference'::text, key
    WHERE  ARRAY['R'] <@ valuesArray and not (ARRAY['S'] <@ valuesArray)
    UNION
    SELECT 'R symmetric difference'::text, key
    WHERE  ARRAY['S'] <@ valuesArray and not (ARRAY['R'] <@ valuesArray);

--    EXCEPT
--     SELECT 'R symmetric difference S'::text, key
--     WHERE  not(ARRAY['R','S'] <@ valuesArray);
$$ LANGUAGE SQL;

-- 3-phases simulation of MapReduce Program followed by a decoding step
WITH
Map_Phase AS (
    SELECT m.key, m.value
    FROM   encodingOfRandS, LATERAL(SELECT key, value FROM mapper(key, value)) m
),
Group_Phase AS (
    SELECT key, array_agg(value) as value
    FROM   Map_Phase
    GROUP  BY (key)
),
Reduce_Phase AS (
    SELECT r.key, r.value
    FROM   Group_Phase, LATERAL(SELECT key, value FROM reducer(key, value)) r
)
SELECT p.value->'a' as a FROM Reduce_Phase p
order by 1;

/*
a 
---
2
4
(2 rows)
*/


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

-- Create Tables
DROP TABLE IF EXISTS R;
CREATE TABLE R(
    A INTEGER,
    B INTEGER
);

DROP TABLE IF EXISTS S;
CREATE TABLE S(
    A INTEGER,
    B INTEGER,
    C INTEGER
);

-- Populate table
INSERT INTO R VALUES (1, 2), (2, 4), (3, 6), (4,6);
INSERT INTO S VALUES (1, 2, 7), (2, 5, 8), (1, 4, 9), (3, 6, 10), (5, 7, 11);

-- EncodingofRandS

drop table if exists EncodingOfRandS;

create table EncodingOfRandS(key text, value jsonb);

insert into EncodingOfRandS
   select 'R' as Key, json_build_object('a', a, 'b', b)::jsonb as Value
   from   R
   union
   select 'S' as Key, json_build_object('a', a, 'b', b, 'c', c)::jsonb as Value
   from   S order by 1;

table EncodingOfRandS;


-- Map function

CREATE OR REPLACE FUNCTION Map(KeyIn text, ValueIn jsonb)
RETURNS TABLE(KeyOut jsonb, ValueOut jsonb) AS
$$
  SELECT CASE WHEN KeyIn = 'R' THEN ValueIn
         ELSE ValueIn - 'c' END,
         CASE WHEN KeyIn = 'R' THEN jsonb_build_object('RelName', 'R')
         ELSE jsonb_build_object('RelName', 'S') END;
$$ LANGUAGE SQL;


-- select map('R', '{"a": 1, "b":2}'::jsonb);

-- select map('S', '{"a": 2, "b":2, "c": 3}'::jsonb);

-- Reduce function
CREATE OR REPLACE FUNCTION Reduce(KeyIn jsonb, ValuesIn jsonb[])
RETURNS TABLE(KeyOut text, ValueOut jsonb) AS
$$
    SELECT  'R semijoin S'::text, KeyIn
    WHERE   ARRAY['{"RelName": "R"}', '{"RelName": "S"}']::jsonb[] <@ ValuesIn;
$$ LANGUAGE SQL;


-- Simulate MapReduce Program

WITH
Map_Phase AS (
    SELECT m.KeyOut, m.ValueOut 
    FROM   encodingOfRandS, LATERAL(SELECT KeyOut, ValueOut FROM Map(key, value)) m
),
Group_Phase AS (
    SELECT KeyOut, array_agg(Valueout) as ValueOut
    FROM   Map_Phase
    GROUP  BY (KeyOut)
),
Reduce_Phase AS (
    SELECT r.KeyOut, r.ValueOut
    FROM   Group_Phase gp, LATERAL(SELECT KeyOut, ValueOut FROM Reduce(gp.KeyOut, gp.ValueOut)) r
)
SELECT ValueOut->'a' as A, ValueOut->'b' as B FROM Reduce_Phase order by 1,2;


\qecho 'Problem 15 -- Practice Problem'

-- Write, in PostgreSQL, a basic MapRe- duce program, i.e., a mapper

-- function and a reducer function, as well as a 3-phases simulation that
-- implements the natural join R ◃▹ S of two rela- tions R(A, B) and
-- S(B,C). You can assume that the domains of A, B, and C are
-- integer. Use the encoding and decoding methods described above.


-- Create Tables
DROP TABLE IF EXISTS R;
CREATE TABLE R(
    A INTEGER,
    B INTEGER
);

DROP TABLE IF EXISTS S;
CREATE TABLE S(
    B INTEGER,
    C INTEGER
);

-- Populate table
INSERT INTO R VALUES (1, 2), (2, 4), (3, 6), (4,6);
INSERT INTO S VALUES (2, 7), (2, 5), (6, 4), (6, 8), (5, 7);

table R;
table S;

-- EncodingofRandS

drop table if exists EncodingOfRandS;

create table EncodingOfRandS(key text, value jsonb);

insert into EncodingOfRandS
   select 'R' as Key, json_build_object('a', a, 'b', b)::jsonb as Value
   from   R
   union
   select 'S' as Key, json_build_object('b', b, 'c', c)::jsonb as Value
   from   S order by 1;

table EncodingOfRandS;

-- Map function

CREATE OR REPLACE FUNCTION Map(KeyIn text, ValueIn jsonb)
RETURNS TABLE(KeyOut jsonb, ValueOut jsonb) AS
$$
  SELECT CASE WHEN KeyIn = 'R' THEN ValueIn - 'a'
         ELSE ValueIn - 'c' END,
         CASE WHEN KeyIn = 'R' THEN jsonb_build_object('a', ValueIn -> 'a')
         ELSE jsonb_build_object('c', ValueIn -> 'c') END;
$$ LANGUAGE SQL;

-- Reduce function
CREATE OR REPLACE FUNCTION Reduce(KeyIn jsonb, ValuesIn jsonb[])
RETURNS TABLE(KeyOut text, ValueOut jsonb) AS
$$
   with R as (select distinct e->'a' as    a
              from   unnest(valuesIn) e
              where  not(e->'a') is null),
        S as (select distinct e->'c' as    c
              from   unnest(valuesIn) e
              where  not(e->'c') is null),
        R_cross_join_S as (select jsonb_build_object('a',r.a,'b',keyIn -> 'b', 'c', s.c) as object
                           from   R r, S s)
   select 'R_cross_join_S', object from R_cross_join_S;;
$$ LANGUAGE SQL;

-- Simulate MapReduce Program

WITH
Map_Phase AS (
    SELECT m.KeyOut, m.ValueOut 
    FROM   encodingOfRandS, LATERAL(SELECT KeyOut, ValueOut FROM Map(key, value)) m
),
Group_Phase AS (
    SELECT KeyOut, array_agg(Valueout) as ValueOut
    FROM   Map_Phase
    GROUP  BY (KeyOut)
),
Reduce_Phase AS (
    SELECT r.KeyOut, r.ValueOut
    FROM   Group_Phase gp, LATERAL(SELECT KeyOut, ValueOut FROM Reduce(gp.KeyOut, gp.ValueOut)) r
)
SELECT ValueOut->'a' as a, ValueOut->'b' as b, ValueOut-> 'c' as c FROM Reduce_Phase order by 1,2,3;


\qecho 'Problem 16'

-- Write, in PostgreSQL, a basic MapReduce program, i.e., a mapper func-
-- tion and a reducer function, as well as a 3-phases simulation that
-- imple- ments the SQL query

drop table R;
create table R(A integer, B integer);

insert into R values
   (1,1),
   (1,2),
   (1,3),
   (2,2),
   (2,3),
   (3,2);

table R;

SELECT r.A, array_agg(r.B), sum(r.B) FROM R r
GROUP BY (r.A)
HAVING COUNT(r.B) < 3;

-- Here R is a relation with schema (A, B). You can assume that the
-- domains of A and B are integers. Use the encoding and decoding methods
-- described above.


create table EncodingofR(key text, value jsonb);

insert into EncodingofR
  select 'R' as key, json_build_object('a', a, 'b', b) as value
  from   R;

select key, value from EncodingofR;


-- key |      value       
-- -----+------------------
-- R   | {"a": 1, "b": 1}
-- R   | {"a": 1, "b": 2}
-- R   | {"a": 1, "b": 3}
-- R   | {"a": 2, "b": 1}
-- R   | {"a": 3, "b": 1}
-- R   | {"a": 3, "b": 2}
-- (6 rows)

-- Map function
CREATE OR REPLACE FUNCTION Map(KeyIn text, ValueIn jsonb)
RETURNS TABLE(KeyOut jsonb, ValueOut jsonb) AS
$$
    SELECT ValueIn::jsonb - 'b', ValueIn::jsonb - 'a';    
$$ LANGUAGE SQL;

create or replace function json_sum(IntArray jsonb[]) 
returns bigint as
$$
   select sum((x ->> 'b')::int)
   from   (select x from unnest(IntArray) x) q;
$$ language sql;

CREATE OR REPLACE FUNCTION Reduce(KeyIn jsonb, ValuesIn jsonb[])
RETURNS TABLE(KeyOut text, ValueOut jsonb) AS
$$
select 'result'::text, json_build_object(
                           'a', KeyIn -> 'a',
                           'bS', ValuesIn,  
                           'sum', json_sum(ValuesIn::jsonb[]))
where cardinality(valuesIn) < 3;
$$ LANGUAGE SQL;


-- Simulate MapReduce Program
WITH
Map_Phase AS (
    SELECT m.KeyOut, m.ValueOut 
    FROM   encodingOfR, LATERAL(SELECT KeyOut, ValueOut FROM Map(key, value)) m
),
Group_Phase AS (
    SELECT KeyOut, array_agg(Valueout) as ValueOut
    FROM   Map_Phase
    GROUP  BY (KeyOut)
),
Reduce_Phase AS (
    SELECT r.KeyOut, r.ValueOut
    FROM   Group_Phase gp, LATERAL(SELECT KeyOut, ValueOut FROM Reduce(gp.KeyOut, gp.ValueOut)) r
)
SELECT gp.ValueOut -> 'a' as A, 
       array_agg(q.B -> 'b') as bS,
       gp.ValueOut -> 'sum' as sum_bS 
FROM  Reduce_Phase gp, lateral (select B from jsonb_array_elements(gp.ValueOut -> 'bS') as B) q
group by(gp.ValueOut -> 'a',gp.ValueOut -> 'sum');





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

table R;
table S;

\qecho 'Problem 17.a'

-- Define a PostgreSQL view coGroup that computes a complex-object
-- relation that represent the co-group transformation R.cogroup(S). Show
-- that this view works.

CREATE TYPE VWs AS (vs INT[], ws INT[]);

CREATE VIEW cogroup AS
    WITH Ks AS
         (SELECT k FROM R UNION SELECT k FROM S),
         Rk AS
         (SELECT k, ARRAY(SELECT r.v FROM R r WHERE r.k = ks.k) AS vs FROM Ks ks),
         Sk AS
         (SELECT k, ARRAY(SELECT s.w FROM S s WHERE s.k = ks.k) AS ws FROM Ks ks)
    SELECT k, (vs, ws)::VWs AS vws
    FROM Rk NATURAL JOIN Sk;

SELECT * FROM cogroup;

\qecho 'Problem 17.b'

-- Write a PostgreSQL query that use this {\tt coGroup} view to
-- compute the semi join $R\, \ltimes\, S$, in other words compute the
-- relation $R \bowtie \pi_{K}(S)$.


SELECT c.k, v
FROM   cogroup c, UNNEST((c.vws).vs) v
WHERE  (SELECT count(1)
        FROM   UNNEST((c.vws).ws) q) >= 1;

\qecho 'Problem 17.c'

-- Write a PostgreSQL query that uses this coGroup view to implement
-- the SQL query

SELECT distinct r.K as rK, s.K as sK
FROM   R r, S s
WHERE  NOT ARRAY(SELECT s1.W
                 FROM   S s1
                 WHERE  s1.K = s.K) && ARRAY(SELECT r1.V
                                             FROM   R r1
                                             WHERE  r1.K = r.K);

table cogroup;


select distinct r.K, s.K
from   cogroup r JOIN cogroup s
       on (not (r.vws).vs && (s.vws).ws and
           not (r.vws).vs = '{}' and
           not (s.vws).ws = '{}') order by 1,2;


\qecho 'Problem 18-- Practice Problem'

drop table if exists A;
drop table if exists B;

create table A (x int);
create table B (x int);

drop table if exists R;
drop table if exists S;

create or replace view R(K, V) as
  select x, x from A;

create or replace view S(K, W) as
  select x, x from B;

CREATE TYPE VWs AS (vs INT[], ws INT[]);

CREATE OR REPLACE VIEW cogroup AS
    WITH Ks AS
         (SELECT k FROM R UNION SELECT k FROM S),
         Rk AS
         (SELECT k, ARRAY(SELECT r.v FROM R r WHERE r.k = ks.k) AS vs FROM Ks ks),
         Sk AS
         (SELECT k, ARRAY(SELECT s.w FROM S s WHERE s.k = ks.k) AS ws FROM Ks ks)
    SELECT k, (vs, ws)::VWs AS vws
    FROM Rk NATURAL JOIN Sk;


\qecho 'Problem 18.a'
- Write a PostgreSQL query that uses the cogroup transformation to compute A ∩ B.

select k as x
from   cogroup c
where  (c.vws).vs = (c.vws).ws;



\qecho 'Problem 19.b'

-- Write a PostgreSQL query that uses the cogroup operator to compute the
-- symmetric difference of A and B, i.e., the expression (A − B) ∪ (B −
-- A).

select k as x
from   cogroup c
where  (c.vws).vs <@ array[]::int[] or
       (c.vws).ws <@ array[]::int[];


\c postgres
drop database dvgassignment7;

