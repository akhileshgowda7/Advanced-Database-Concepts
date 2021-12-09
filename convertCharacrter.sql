CREATE OR REPLACE FUNCTION convert (a char) returns float AS
$$
Begin
IF(a='t') THEN RETURN 1;
ELSE IF(a='f') THEN RETURN 0;
ELSE IF(a='u') THEN RETURN 0.5;
ELSE RETURN(2);
END IF; 
END IF; 
END IF; 
END;
$$ language plpgsql;


select convert('u');
