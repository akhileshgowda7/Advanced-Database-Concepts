-- Script for Assignment 6

-- Creating database with full name

CREATE DATABASE akhilesh_gowda_mandya_ramesh;

-- Connecting to database 
\c akhilesh_gowda_mandya_ramesh



\qecho 'Problem 1'

create table P (outcome int,
                probability float);

\qecho 'Test case 1 - uniform mass function'
insert into P values
  (1, 0.2),
  (2, 0.2),
  (3, 0.2),
  (4, 0.2),
  (5, 0.2);

create or replace function RelationOverProbabilityFunction1(n int , l1 int, u1 int, l2 int, u2 int)
returns table(outc int,prob int) as
$$
with cp AS ( 
    SELECT *,
        sum(p.probability) OVER (
            ORDER BY probability DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumprob
    FROM p
),
fp AS ( 
    SELECT
        cp.outcome,
        cp.probability,
        cp.cumprob - cp.probability AS startprob,
        cp.cumprob AS endprob
    FROM cp

)

SELECT floor(random()*(u1-l1+1)+1)::int x,fp.outcome
FROM fp
CROSS JOIN (SELECT random() as val FROM generate_series(l2,u2)) AS random_value
WHERE random_value.val BETWEEN fp.startprob AND fp.endprob
$$ language sql;

select * from RelationOverProbabilityFunction(100, 1, 150, 1, 5);

delete from P;

\qecho 'Test case 2 - non-uniform function'
insert into P values
  (1, 0.25),
  (2, 0.10),
  (3, 0.40),
  (4, 0.10),
  (5, 0.15);

select * from RelationOverProbabilityFunction(100, 1, 150, 1, 5);

\qecho 'Problem 5'

-- Data
-- Relation schemas and instances for assignment 6

create table Student(sid text,
                     sname text,
                     major text,
                     byear int,
                     primary key(sid));

-- We don't specify any constraints on enroll
create table Enroll (sid text,
                     cno text,
                     grade text);

insert into Student values 
 ('s100','Eric','CS',1988),
 ('s101','Nick','Math',1991),
 ('s102','Chris','Biology',1977),
 ('s103','Dinska','CS',1978),
 ('s104','Zanna','Math',2001),
 ('s105','Vince','CS',2001);


insert into Enroll values 
 ('s100','c200','A'),
 ('s100','c201','B'),
 ('s100','c202','A'),
 ('s101','c200','B'),
 ('s101','c201','A'),
 ('s102','c200','B'),
 ('s103','c201','A'),
 ('s101','c202','A'),
 ('s101','c301','C'),
 ('s101','c302','A'),
 ('s102','c202','A'),
 ('s102','c301','B'),
 ('s102','c302','A'),
 ('s104','c201','D');

Create View enroll_withtid as 
select row_number() over (order by sid) as tid, *from enroll;


create or replace view indexonCno as 
select cno, array_agg(tid) as tid from enroll_withtid
group by cno;


create or replace view indexonGrade as 
select grade,array_agg(tid) as tid from enroll_withtid
group by grade;

create or replace function set_intersection(A anyarray, B anyarray)
returns anyarray as
$$
select array(select unnest(A) intersect select unnest(B) order by 1)
$$ language SQL;


Create or replace function FindStudents(cond text,c text, g text)
returns table (sid text, sname text, major text, byyear int) as
$$
begin
return query execute 'select * from Student where sid in
  (
     select sid from enroll_withtid where tid IN
     (
      Select unnest(set_intersection(ic.tid,ig.tid)) from indexOnCno ic,indexOnGrade ig
      where ic.cno = '''|| c ||''''|| cond ||' ig.grade = '''||g||'''
    )
  );';
end;
$$ language plpgsql;

\qecho 'Problem 5.a'
 select * from FindStudents('and', 'c202', 'A');

\qecho 'Problem 5.b'
select * from FindStudents('or', 'c202', 'A');

\qecho 'Problem 5.c'
select * from FindStudents('and not', 'c202', 'A');



\c postgres

drop database akhilesh_gowda_mandya_ramesh;
