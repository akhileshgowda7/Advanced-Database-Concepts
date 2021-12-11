CREATE FUNCTION sum(A int[]) RETURNS int8 AS
$$
DECLARE
s int8:=0;
x int;
BEGIN
foreach x in ARRAY A
LOOP
s:=s+x;
END LOOP;
RETURN s;
END;
$$ LANGUAGE plpgsql;
