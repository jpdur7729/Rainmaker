-- ------------------------------------------------------------------------------
--                     Author    : F2 - JPD
--                     Time-stamp: "2021-01-15 15:54:58 jpdur"
-- ------------------------------------------------------------------------------

-- Version 1 add if data point is defined at company level 1 or 2
CREATE or ALTER PROCEDURE [dbo].[ADD_DATAPOINT_VALUE_COMPANYL12](
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
      set @CompanyID = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)

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
      EXEC CREATE_DATAPOINT @NodeID,@CompanyID,@DPVID OUTPUT

      -- Debug
      -- select @DPVID

      -- Add the Value within the structure
      EXEC ADD_DATAPOINT_VALUE @DPVID,@Scenario ,@DateValue ,@Amount 

END
GO


-- Version 0 add only if data point is defined at company level 2
CREATE or ALTER PROCEDURE [dbo].[ADD_DATAPOINT_VALUE_COMPANYL2](
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
      set @CompanyID = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)

      -- Identify the NodeID we want to associate to a give DataPoint
      declare @NodeID as varchar(36)
      set @NodeID = (select ID from NodeDefCompany  where Name = @BottomLevelName and Level = 2 and ParentLevelName = @TopLevelName 	and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyId)

      -- Get the DataPointValue ID corresponding to that NodeCompany
      declare @DPVID as varchar(36)
      EXEC CREATE_DATAPOINT @NodeID,@CompanyID,@DPVID OUTPUT

	  -- Debug
	  -- select @DPVID

      -- Add the Value within the structure
      EXEC ADD_DATAPOINT_VALUE @DPVID,@Scenario ,@DateValue ,@Amount 

END
GO

-- Add Data into the Data Point Structure
CREATE or ALTER PROCEDURE [dbo].[ADD_DATAPOINT_VALUE](@DataPointID as varchar(36),@Scenario as varchar(100),@DateValue as date,@Amount as float)
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

-- delete from DataPointMapping 
-- ---------------------------------------------------------
-- Create ID of Data Point in order to store the value 
-- ---------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[CREATE_DATAPOINT](@NodeDefID as varchar(36),@CompanyID as varchar(36),@ResID as varchar(36) OUTPUT)
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

CREATE or ALTER PROCEDURE [dbo].[DATA_COMPANY_COMPANY](
       @TopLevelName as varchar(100),@BottomLevelName as varchar(100),
       @HierarchyName as varchar(100),@IndustryName as varchar(100),@CompanyName as varchar(100),
       @GrandParentName as varchar(100),
       @DPDate as date,@DPAmount as float,@DPScenario as varchar(100)
       )
as
BEGIN

if @BottomLevelName is not null and len(@BottomLevelName) <> 0 begin 
      declare @HierarchyID as nvarchar(36)
      declare @IndustryID as nvarchar(36)
      declare @CompanyID as nvarchar(36)

      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
      set @IndustryID = (select ID from IndustryList where Name = @IndustryName )
      set @CompanyID = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)

      merge into Hierarchies using (
      	    select
	    (select ID from NodeDefCompany  where Name = @TopLevelName    and Level = 1 and ParentLevelName = @GrandParentName 	and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyId) as ParentNodeDefID,
	    (select ID from NodeDefCompany  where Name = @BottomLevelName and Level = 2 and ParentLevelName = @TopLevelName 	and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyId) as NodeDefID
	    ) x
	    on x.ParentNodeDefID = Hierarchies.ParentNodeDefID and x.NodeDefID = Hierarchies.NodeDefID
	    when not matched then
	    insert values ('JPDUR',getdate(),getdate(),x.ParentNodeDefID,x.NodeDefID);
END

END
GO


-- ---------------------------------------------------------
-- Create ID of Data Point in order to store the value 
-- ---------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[CREATE_DATAPOINT_internal](@NodeDefID as varchar(36),@CompanyID as varchar(36))
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

-- -- Full example to test that all works as expected 
-- declare @ResID as varchar(36)
-- set @ResID = 'Test before'
-- EXEC Create_datapoint 'Node1','Company1',@ResID OUTPUT 
-- print @ResID


-- ---------------------------------------------------------
-- Create ID of Data Point in order to store the value 
-- ---------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[CREATE_DATAPOINT_OLD](@NodeDefID as varchar(36),@CompanyID as varchar(36))
as
BEGIN

merge into DataPointMapping DPM using (
	select @NodeDefID as NodeDefID, @CompanyID as CompanyID
    ) x
    on x.NodeDefID = DPM.NodeDefID and x.CompanyID = DPM.CompanyID
    WHEN NOT MATCHED THEN
    INSERT VALUES (NEWID(),'JPDUR',getdate(),getdate(),x.NodeDefID,x.CompanyID) ;

END
GO

-- ---------------------------------------------------------
-- Create node at the Hierarchy/Generic level "Category" 
-- ---------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[CREATE_NODE](@LevelName as varchar(100),@HierarchyName as varchar(100),@SortOrder as integer = 0,@LevelNumber as integer = 1)
as
BEGIN

declare @HierarchyID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

merge into NodeDef using (
      select @LevelName as Name,@LevelNumber as Level,@HierarchyID  as HierarchyID
      ) x
      on x.Name = NodeDef.Name and x.Level = NodeDef.Level and x.HierarchyID = NodeDef.HierarchyID
      WHEN NOT MATCHED THEN
      INSERT VALUES (NEWID(),'JPDUR',getdate(),getdate(),x.Name,x.Level,x.HierarchyID,@SortOrder)
      WHEN MATCHED THEN
      UPDATE set SortOrder = @SortOrder;

END
GO

-- EXEC CREATE_NODE 'Test','Income Statement'
-- select * from NodeDef where HierarchyID in (select ID from HierarchyList where name = 'Income Statement')
-- -- delete from NodeDef where HierarchyID in (select ID from HierarchyList where name = 'Income Statement')

-- ---------------------------------------------------------
-- Create node at the Industry level "SubCategory1" 
-- ---------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[CREATE_NODEINDUSTRY](@LevelName as varchar(100),
       @HierarchyName as varchar(100),@IndustryName as varchar(100),
       @ParentLevelName as varchar(100),
       @SortOrder as integer = 0,
       @LevelNumber as integer = 1)
as
BEGIN

declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )

merge into NodeDefIndustry using (
      select @LevelName as Name, @IndustryID as IndustryID, @HierarchyID as HierarchyID, @ParentLevelName as ParentLevelName
      ) x
      on x.IndustryID = NodeDefIndustry.IndustryID and x.HierarchyID = NodeDefIndustry.HierarchyID
            and x.Name = NodeDefIndustry.Name and x.ParentLevelName = NodeDefIndustry.ParentLevelName 
      when not matched then
      insert values (NEWID(),'JPDUR',getdate(),getdate(),x.Name,x.IndustryID,x.HierarchyID,@SortOrder,x.ParentLevelName) 
      WHEN MATCHED THEN
      UPDATE set SortOrder = @SortOrder;

END
GO

-- ---------------------------------------------------------
-- Create node at the Industry level "SubCategory1" 
-- ---------------------------------------------------------
--CREATE or ALTER PROCEDURE [dbo].[CREATE_NODEINDUSTRY_OLD](@LevelName as varchar(100),
--       @HierarchyName as varchar(100),@IndustryName as varchar(100),
--       @SortOrder as integer = 0,@LevelNumber as integer = 1)
--as
--BEGIN

--declare @HierarchyID as nvarchar(36)
--declare @IndustryID as nvarchar(36)

--set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
--set @IndustryID = (select ID from IndustryList where Name = @IndustryName )

--merge into NodeDefIndustry using (
--      select @LevelName as Name, @IndustryID as IndustryID, @HierarchyID as HierarchyID
--      ) x
--      on x.IndustryID = NodeDefIndustry.IndustryID and x.HierarchyID = NodeDefIndustry.HierarchyID and x.Name = NodeDefIndustry.Name
--      when not matched then
--      insert values (NEWID(),'JPDUR',getdate(),getdate(),x.Name,x.IndustryID,x.HierarchyID,@SortOrder) ;

--END
--GO

-- EXEC CREATE_NODEINDUSTRY 'Test Indust','Income Statement','Industry 1'
-- select * from NodeDefIndustry where HierarchyID in (select ID from HierarchyList where name = 'Income Statement')
-- -- delete from NodeDefIndustry where HierarchyID in (select ID from HierarchyList where name = 'Income Statement')

-- ---------------------------------------------------------
-- Create node at the Company level "SubCategory2 or 3" 
-- ---------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[CREATE_NODECOMPANY](@LevelName as varchar(100),
       @HierarchyName as varchar(100),@IndustryName as varchar(100),@CompanyName as varchar(100),
       @ParentLevelName as varchar(100),
       @SortOrder as integer,@LevelNumber as integer)
as
BEGIN

declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)
declare @CompanyID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )
set @CompanyID = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)

merge into NodeDefCompany using (
      select @LevelName as Name, @IndustryID as IndustryID, @HierarchyID as HierarchyID, @CompanyID as CompanyID,@ParentLevelName as ParentLevelName
      ) x
      on x.IndustryID = NodeDefCompany.IndustryID and x.HierarchyID = NodeDefCompany.HierarchyID and x.CompanyID = NodeDefCompany.CompanyID
      	 and x.Name = NodeDefCompany.Name and x.ParentLevelName = NodeDefCompany.ParentLevelName
      when not matched then
      insert values (NEWID(),'JPDUR',getdate(),getdate(),x.Name,@LevelNumber,x.CompanyID,x.IndustryID,x.HierarchyID,@SortOrder,x.ParentLevelName) 
      WHEN MATCHED THEN
      UPDATE set SortOrder = @SortOrder;

END
GO

-- EXEC CREATE_NODECOMPANY 'Test level 1','Income Statement','Industry 1','SaasCo',null,0,1
-- EXEC CREATE_NODECOMPANY 'Test level 2','Income Statement','Industry 1','SaasCo',null,0,2
-- select * from NodeDefCompany where HierarchyID in (select ID from HierarchyList where name = 'Income Statement')
-- -- delete from NodeDefCompany where HierarchyID in (select ID from HierarchyList where name = 'Income Statement')


-- ----------------------------------------------
-- Create link between Category and Subcategory 
-- ----------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[LINK_GENERIC](
       @TopLevelName as varchar(100),@BottomLevelName as varchar(100),
       @HierarchyName as varchar(100)
       )
as
BEGIN

declare @HierarchyID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

merge into Hierarchies using (
      select @HierarchyID as ParentNodeDefID,
      -- select ID from NodeDef where Name = @BottomLevelName and level = "&$E$1&" and HierarchyID = @HierarchyID ') as NodeDefID)
      (select ID from NodeDef where Name = @BottomLevelName and HierarchyID = @HierarchyID) as NodeDefID
      ) x 
      on x.ParentNodeDefID = Hierarchies.ParentNodeDefID and x.NodeDefID = Hierarchies.NodeDefID 
      when not matched then 
      insert values ('JPDUR',getdate(),getdate(),x.ParentNodeDefID,x.NodeDefID);
      
END
GO


CREATE or ALTER PROCEDURE [dbo].[LINK_GENERIC_INDUSTRY](
       @TopLevelName as varchar(100),@BottomLevelName as varchar(100),
       @HierarchyName as varchar(100),@IndustryName as varchar(100)
       )
as
BEGIN
declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )

merge into Hierarchies using (
      select
--      (select ID from NodeDef where Name = @TopLevelName and level = "&$E$1&" and HierarchyID = @HierarchyID  )as ParentNodeDefID,
      (select ID from NodeDef where Name = @TopLevelName and HierarchyID = @HierarchyID  )as ParentNodeDefID,
      (select ID from NodeDefIndustry where Name = @BottomLevelName and HierarchyID = @HierarchyID and IndustryID = @IndustryID and ParentLevelName = @TopLevelName) as NodeDefID
      ) x
      on x.ParentNodeDefID = Hierarchies.ParentNodeDefID and x.NodeDefID = Hierarchies.NodeDefID
      when not matched then
      insert values ('JPDUR',getdate(),getdate(),x.ParentNodeDefID,x.NodeDefID);

END
GO

CREATE or ALTER PROCEDURE [dbo].[LINK_INDUSTRY_COMPANY](
       @TopLevelName as varchar(100),@BottomLevelName as varchar(100),
       @HierarchyName as varchar(100),@IndustryName as varchar(100),@CompanyName as varchar(100),
       @GrandParentLevelName as varchar(100)
       )
as
BEGIN
declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)
declare @CompanyID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )
set @CompanyID = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)

merge into Hierarchies using (
      select
      (select ID from NodeDefIndustry where Name = @TopLevelName		  and ParentLevelName = @GrandParentLevelName  and HierarchyID = @HierarchyID and IndustryID = @IndustryID )as ParentNodeDefID,
      (select ID from NodeDefCompany  where Name = @BottomLevelName and Level = 1 and ParentLevelName = @TopLevelName 	       and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyId) as NodeDefID
      ) x
      on x.ParentNodeDefID = Hierarchies.ParentNodeDefID and x.NodeDefID = Hierarchies.NodeDefID
      when not matched then
      insert values ('JPDUR',getdate(),getdate(),x.ParentNodeDefID,x.NodeDefID);

END
GO

CREATE or ALTER PROCEDURE [dbo].[LINK_INDUSTRY_COMPANY_OLD](
       @TopLevelName as varchar(100),@BottomLevelName as varchar(100),
       @HierarchyName as varchar(100),@IndustryName as varchar(100),@CompanyName as varchar(100)
       )
as
BEGIN
declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)
declare @CompanyID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )
set @CompanyID = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)

merge into Hierarchies using (
      select
      (select ID from NodeDefIndustry where Name = @TopLevelName							and HierarchyID = @HierarchyID and IndustryID = @IndustryID )as ParentNodeDefID,
      (select ID from NodeDefCompany  where Name = @BottomLevelName and Level = 1 and ParentLevelName = @TopLevelName 	and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyId) as NodeDefID
      ) x
      on x.ParentNodeDefID = Hierarchies.ParentNodeDefID and x.NodeDefID = Hierarchies.NodeDefID
      when not matched then
      insert values ('JPDUR',getdate(),getdate(),x.ParentNodeDefID,x.NodeDefID);

END
GO
-- Create link between Company level 1 and Company level 2
CREATE or ALTER PROCEDURE [dbo].[LINK_COMPANY_COMPANY](
       @TopLevelName as varchar(100),@BottomLevelName as varchar(100),
       @HierarchyName as varchar(100),@IndustryName as varchar(100),@CompanyName as varchar(100),
       @GrandParentName as varchar(100)
       )
as
BEGIN

if @BottomLevelName is not null and len(@BottomLevelName) <> 0 begin 
      declare @HierarchyID as nvarchar(36)
      declare @IndustryID as nvarchar(36)
      declare @CompanyID as nvarchar(36)

      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
      set @IndustryID = (select ID from IndustryList where Name = @IndustryName )
      set @CompanyID = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)

      merge into Hierarchies using (
      	    select
	    (select ID from NodeDefCompany  where Name = @TopLevelName    and Level = 1 and ParentLevelName = @GrandParentName 	and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyId) as ParentNodeDefID,
	    (select ID from NodeDefCompany  where Name = @BottomLevelName and Level = 2 and ParentLevelName = @TopLevelName 	and HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyId) as NodeDefID
	    ) x
	    on x.ParentNodeDefID = Hierarchies.ParentNodeDefID and x.NodeDefID = Hierarchies.NodeDefID
	    when not matched then
	    insert values ('JPDUR',getdate(),getdate(),x.ParentNodeDefID,x.NodeDefID);
END

END
GO
