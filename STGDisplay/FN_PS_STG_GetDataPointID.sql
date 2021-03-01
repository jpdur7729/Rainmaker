-- ------------------------------------------------------------------------------
--                     Author    : F2 - JPD
--                     Time-stamp: "2021-03-01 11:36:53 jpdur"
-- ------------------------------------------------------------------------------


-- Create Function in order to get the DataPointID from DataPointMapping 
CREATE or ALTER FUNCTION [dbo].[PS_STG_GetDataPointID] (@NodeDefID as varchar(36), @CompanyID as varchar(36))
RETURNS varchar(36)

BEGIN

declare @result as varchar(36)

set @result = (select ID from DataPointMapping where NodeDefID = @NodeDefID and CompanyID = @CompanyID)

return @result 

END

