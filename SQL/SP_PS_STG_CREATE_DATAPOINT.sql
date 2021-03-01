-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-01 09:51:47 jpdur"
-- ------------------------------------------------------------------------------

-- Version 1 add if data point is defined at company level 1 or 2
CREATE or ALTER PROCEDURE [dbo].[PS_STG_CREATE_DATAPOINT](
@NodeDefID as varchar(36),@CompanyID as varchar(36),@ResID as varchar(36) OUTPUT)
as
BEGIN

-- Interediate table to process the result returned by the stored procedure 
declare @IDTable  table         
(                                
   [ID] [nvarchar](56) NOT NULL
)                                
                                 
-- insert into @ListLinks
insert @IDTable         
       EXEC Create_datapoint_internal @NodeDefID,@CompanyID 

-- Copy the ID in the output parameter 
set @ResID = (select ID from @IDTable)        

END 
GO
