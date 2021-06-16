/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-06-16 14:23:52 jpdur"
   ------------------------------------------------------------------------------ */

-- 2021-06-16 // Synonym + eliminate from CompanyLevel the nodes flagged as P 
-- ---------------------------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_DataItem] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      -- Alias KPITypeID
      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from DIARM_KPI_IND_Template where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      declare @KPICompanyConfigurationID as nvarchar(36)
      -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)
      set @KPICompanyConfigurationID = (select ID from DIARM_KPI_CMP_Template where CompanyID = @CompanyID )

      declare @Description as nvarchar(50)
      set @Description = 'JPD /'+@HierarchyName+'/'+@IndustryName

      -- Create the default value for RM_DataItem
      declare @IsDebit as BIT
      set @IsDebit = 1
      declare @IsSystemDefined as BIT
      set @IsSystemDefined = 0
      declare @IsAggregate as BIT
      set @IsAggregate = 1
      declare @IsActive as BIT
      set @IsActive = 1
      declare @Scale as integer
      set @Scale = 2

      -- Store the value type ID needed
      declare  @ValueTypeID as varchar(36) =  (select ID from DIARMX_ValueType where Name = 'Numeric')

      -- Process all the final Leaves for the Hierarchy/Industry/Company
      select * into #ListNodesDataItemNames from (
      	     select ID as STGID,Name,' ' as Port from NodeDef         where HierarchyID = @HierarchyID
	     union 
      	     select ID as STGID,Name,Port        from NodeDefIndustry where HierarchyID = @HierarchyID and IndustryID = @IndustryID
	     union 
      	     select ID as STGID,Name,Port        from NodeDefCompany  where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID and Port <> 'P'
      ) tmp

      -- ---------------------------------------------------------------------------------
      -- Eliminate all the Nodes which are a parent --> we only get the FinalLeaves
      -- For NodeDefIndustry Port = 'D' if it is actually a Data Point to be uzed
      -- that way the test/filter works also for the mixed situation where some data are
      -- captured only down to industry and other items are extended at the company level
      -- ---------------------------------------------------------------------------------
      select * into #FinalLeaves from
      	     (select * from #ListNodesDataItemNames where
	     	     STGID not in (select ParentNodeDefID from Hierarchies)
		     or Port = 'D' ) tmp

      -- Debug
      select 'Data-Item',* from #FinalLeaves

      -- Eliminate duplicate Names 
      select *,NEWID() as RM_DataItemID into #FinalLeavesUName from (select distinct Name from #FinalLeaves) tmp

      -- To prevent any issues Select the data from RM_DataItem
      select * into #KPIListDataItem
      from DIARM_DataItem
      where CreatedOn > '01-Apr-2021' and KPITypeId = @HierarchyID and IndustryId = @IndustryID

      ---- Update the list of DataItems accordingly for those already existing 
      --merge into #FinalLeavesUName fl
      --using #KPIListDataItem KPIListDataItem
      --on KPIListDataItem.Name = fl.Name
      --when MATCHED THEN
      --	   UPDATE SET RM_DataItemID = KPIListDataItem.ID;

      -- Keep and store the DateTime to be used to flag all records
      declare @CurrentDateTime as datetime = getdate() 

	  -- select '#KPIListDataItem-Analysis0',Name,count(*) from #KPIListDataItem group by Name having count(*) > 1 order by 3 desc,2

      -- Now that we have the list of names let's process the copy RM_DataItem table
      merge into #KPIListDataItem as KPIListDataItem
      using #FinalLeavesUName fl
      on KPIListDataItem.Name = fl.Name
      when not MATCHED THEN
      	   INSERT (Id     , IndustryId, KPITypeId,   IsDebit, IsAggregate, Scale, ValueTypeId,CreatedBy,CreatedOn       , Description,   Name, IsSystemDefined, IsActive)
	       VALUES (NEWID(),@IndustryID,@HIerarchyID,@IsDebit,@IsAggregate,@Scale,@ValueTypeID,'JPD'    ,@CurrentDateTime,@Description,fl.Name,@IsSystemDefined,@IsActive) ;

	   -- select '#KPIListDataItem',* from #KPIListDataItem
	   -- select '#KPIListDataItem-Analysis',Name,count(*) from #KPIListDataItem group by Name having count(*) > 1 order by 3 desc,2
	   
      -- Update the list of Nodes/Final Leaves accordingly for all the Names
      merge into #FinalLeavesUName fl
      using #KPIListDataItem KPIListDataItem
      on KPIListDataItem.Name = fl.Name
      when MATCHED THEN
      	   UPDATE SET RM_DataItemID = KPIListDataItem.ID;

      -- For the Different Final Leaves with the same name we indicate it points to the same DataItem
      select * into #FinalLeaves2 from (select fl.*,fu.RM_DataItemID from #FinalLeaves fl,#FinalLeavesUName fu where fl.Name = fu.name) tmp

	 -- select 'cnt #FinalLeaves',count(*) from #FinalLeaves
	 -- select 'cnt #FinalLeaves2',count(*) from #FinalLeaves2

      -- Insert the new records into the RM_DataItem table flagged because they all have 
      -- the same CreatedOn value 
      INSERT INTO DIARM_DataItem
      select * from #KPIListDataItem where CreatedOn = @CurrentDateTime

      -- ---------------------------------------------------------------------------
      -- Update the various NodeDef/NodeDefIndustry,NodeDefCompany tables with the
      -- correct value of RM_NODE_ID obtained
      -- ---------------------------------------------------------------------------
	  -- Currently no RM_DataItemID field at the top level
      -- merge into NodeDef NodeDef
      -- using #FinalLeaves2 fl
      -- on NodeDef.ID = fl.STGID
      -- when MATCHED then
      -- 	   update set RM_DataItemID = fl.RM_DataItemID;
      merge into NodeDefIndustry NodeDef
      using #FinalLeaves2 fl
      on NodeDef.ID = fl.STGID
      when MATCHED then
      	   update set RM_DataItemID = fl.RM_DataItemID;
      merge into NodeDefCompany NodeDef
      using #FinalLeaves2 fl
      on NodeDef.ID = fl.STGID
      when MATCHED then
      	   update set RM_DataItemID = fl.RM_DataItemID;

END
GO

