CREATE OR REPLACE FUNCTION factorial_recursive(n integer) returns integer As
$$
Begin
if n=0 THEN
RETURN 1;
else
return n*factorial_recursive(n-1);
END IF;
END;
$$ language plpgsql;

select factorial_recursive(5);

