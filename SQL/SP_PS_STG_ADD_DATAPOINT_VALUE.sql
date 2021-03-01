-- ------------------------------------------------------------------------------
--                     Author    : F2 - JPD
--                     Time-stamp: "2021-03-01 10:09:27 jpdur"
-- ------------------------------------------------------------------------------

-- Add Data into the Data Point Structure
CREATE or ALTER PROCEDURE [dbo].[PS_STG_ADD_DATAPOINT_VALUE](@DataPointID as varchar(36),@Scenario as varchar(100),@DateValue as date,@Amount as float)
as
BEGIN

merge into DataPointValues DPV using (
      select @DataPointID as DataPointID,@Scenario as Scenario,@DateValue as DataPointDate,@Amount as NumValue
      ) x
      on x.DataPointID = DPV.DataPointID and x.Scenario = DPV.Scenario and x.DataPointDate = DPV.DataPointDate
      When not matched then
        INSERT VALUES ('JPDUR',getdate(),getdate(),x.DataPointID,x.Scenario,x.DataPointDate,x.NumValue,null,null)
      WHEN MATCHED THEN 
        UPDATE set updatedAt = getdate(), NumValue=x.NumValue 
	;

END 
GO
