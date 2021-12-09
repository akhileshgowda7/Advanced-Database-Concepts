CREATE OR REPLACE FUNCTION factorial_iterative(n integer) returns integer AS
$$
DECLARE
result integer;
i integer;
BEGIN
result:=1;
FOR i in 1..n
LOOP
result:=i*result;
END LOOP;
return result;
end;
$$ language plpgsql;

select factorial_iterative(5);
