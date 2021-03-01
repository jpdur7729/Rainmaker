-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-01 09:51:36 jpdur"
-- ------------------------------------------------------------------------------

-- Version 1 add if data point is defined at company level 1 or 2
CREATE or ALTER PROCEDURE [dbo].[PS_STG_CREATE_DATAPOINT_internal](
@NodeDefID as varchar(36),@CompanyID as varchar(36))
as
BEGIN

merge into DataPointMapping DPM using (
	select @NodeDefID as NodeDefID, @CompanyID as CompanyID
    ) x
    on x.NodeDefID = DPM.NodeDefID and x.CompanyID = DPM.CompanyID
    WHEN NOT MATCHED THEN
    INSERT VALUES (NEWID(),'JPDUR',getdate(),getdate(),x.NodeDefID,x.CompanyID)
	-- Added so that even if the record already ezxists then the DataPoint ID is provided
	WHEN MATCHED THEN 
	UPDATE set updatedAt = getdate()
    OUTPUT inserted.ID;

END
GO
