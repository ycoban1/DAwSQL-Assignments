CREATE FUNCTION faktoriyel (@number int)
RETURNS int
AS
BEGIN
    declare @i int = 1, @result int=1
	while (@i<=@number)
		begin
			set @result = @result * @i
			set @i +=1
		end
    RETURN @result
END

--First of all, we create the function by running the above codes. 
--Then we can get the factorial of the number we want with the following line.

select [dbo].[faktoriyel] (2)