-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-01 09:56:43 jpdur"
-- ------------------------------------------------------------------------------

-- Version 1 add if data point is defined at company level 1 or 2
CREATE or ALTER PROCEDURE [dbo].[PS_STG_ADD_DATAPOINT_VALUE_COMPANYL12](
       @TopLevelName as varchar(100),@BottomLevelName as varchar(100),@IndustryLevelName as varchar(100),
       @HierarchyName as varchar(100),@IndustryName as varchar(100),@CompanyName as varchar(100),
       @Scenario as varchar(100),@DateValue as date,@Amount as float)
as
BEGIN
      declare @HierarchyID as nvarchar(36)
      declare @IndustryID as nvarchar(36)
      declare @CompanyID as nvarchar(36)

      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
      set @IndustryID = (select ID from IndustryList where Name = @IndustryName )
      -- set @CompanyID = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @CompanyID = (select ID from CompanyList where Name = @CompanyName)

      -- Identify the NodeID we want to associate to a give DataPoint
      declare @NodeID as varchar(36)

	  -- @BottomLevelName is '' if not populated 
      if len(@BottomLevelName) <> 0  begin
      	 set @NodeID = (select ID from NodeDefCompany  where Name = @BottomLevelName and Level = 2 and ParentLevelName = @TopLevelName 	 and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyId)
      end
      else begin
      	 set @NodeID = (select ID from NodeDefCompany  where Name = @TopLevelName    and Level = 1 and ParentLevelName = @IndustryLevelName and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyId)
      end 
      -- Get the DataPointValue ID corresponding to that NodeCompany
      declare @DPVID as varchar(36)
      EXEC PS_STG_CREATE_DATAPOINT @NodeID,@CompanyID,@DPVID OUTPUT

      -- Debug
      -- select @DPVID

      -- Add the Value within the structure
      EXEC PS_STG_ADD_DATAPOINT_VALUE @DPVID,@Scenario ,@DateValue ,@Amount 

END
GO
