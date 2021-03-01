-- ------------------------------------------------------------------------------
--                     Author    : F2 - JPD
--                     Time-stamp: "2021-03-01 11:35:24 jpdur"
-- ------------------------------------------------------------------------------

-- Create Function in order to get the DataPointID from DataPointMapping 
CREATE or ALTER FUNCTION [dbo].[PS_STG_GetDataPointValue_Num] (@NodeDefID as varchar(36), @CompanyID as varchar(36), @Scenario as varchar(100), @DateValue as date)
RETURNS float

BEGIN

-- Get the DataPoint ID 
declare @DPVID as varchar(36)
set @DPVID = (select dbo.PS_STG_GetDataPointID(@NodeDefID,@CompanyID) )

-- Return a float value
declare @result as float 

-- Get the data 
set @result = (select NumValue from DataPointValues where DataPointID = @DPVID and Scenario = @Scenario and DataPointDate = @DateValue )
return @result 

END

