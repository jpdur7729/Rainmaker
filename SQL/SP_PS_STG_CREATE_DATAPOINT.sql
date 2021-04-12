-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-04-05 09:45:52 jpdur"
-- ------------------------------------------------------------------------------

-- Ready to be modified in order to delete one extra level of Stored Procedure

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
       EXEC PS_STG_Create_datapoint_internal @NodeDefID,@CompanyID 

-- Copy the ID in the output parameter 
set @ResID = (select ID from @IDTable)        

END 
GO

-- CREATE or ALTER PROCEDURE [dbo].[PS_STG_CREATE_DATAPOINT](
-- @NodeDefID as varchar(36),@CompanyID as varchar(36),@ResID as varchar(36) OUTPUT)
-- as
-- BEGIN

-- -- Interediate table to process the result returned by the stored procedure 
-- declare @IDTable  table         
-- (                                
--    [ID] [nvarchar](56) NOT NULL
-- )                                
                                 
-- -- insert into @ListLinks
-- merge into DataPointMapping DPM using (
-- 	select @NodeDefID as NodeDefID, @CompanyID as CompanyID
--     ) x
--     on x.NodeDefID = DPM.NodeDefID and x.CompanyID = DPM.CompanyID
--     WHEN NOT MATCHED THEN
--     INSERT VALUES (NEWID(),'JPDUR',getdate(),getdate(),x.NodeDefID,x.CompanyID)
-- 	-- Added so that even if the record already ezxists then the DataPoint ID is provided
-- 	WHEN MATCHED THEN 
-- 	UPDATE set updatedAt = getdate()
--     OUTPUT inserted.ID into @IDTable;         

-- -- Copy the ID in the output parameter 
-- set @ResID = (select ID from @IDTable)        

-- END 
-- GO
