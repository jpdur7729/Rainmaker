-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-03-01 16:01:39 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_DataItem_partial] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      -- Alias KPITypeID
      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      declare @KPICompanyConfigurationID as nvarchar(36)
      -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)
      set @KPICompanyConfigurationID = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfiguration where CompanyID = @CompanyID )

      declare @Description as nvarchar(50)
      set @Description = 'Created by STG_DIA_Populate_RM_DataItem_partial'

      -- Create the defualt value for RM_DataItem
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

      -- -------------------------------------------------------------------------------------------
      -- Create a temporary table with all the final leaves for a given Hierarchy/Industry/Company
      -- These are all the level1 when there is no level 2 and all level 2 for the company
      -- -------------------------------------------------------------------------------------------
      select * into #FinalLeaves from (
      	     select Name from NodeDefCompany where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID and level = 2
      	     	    union
      	     select Name from NodeDefCompany where HierarchyID = @HierarchyID and IndustryID = @IndustryID and CompanyID = @CompanyID and level = 1
      	     and ID not in (select ParentNodeDefID from Hierarchies)
      ) as tmp

      -- Create the list of Unique Names with the ID that will be used to create RM_DataItem and Dim_RM_DataItem
      select * into #FinalLeavesUniqueID from (select top 1 NEWID() as RM_DataItemID,Name from #FinalLeaves) as tmp
      delete from #FinalLeavesUniqueID

      -- Populate the structure with all the distinct Names 
      merge into #FinalLeavesUniqueID Target
      using (
	  select distinct Name from #FinalLeaves
      ) x
	  on x.Name = Target.Name 
	  when not matched then 
	       insert VALUES (NEWID(),x.name) ;

      -- The key criteria in that table is the unicity of the name so
      merge into RainmakerLDCJP_OAT.dbo.RM_DataItem RM_DI
      using (
      	    select RM_DataItemID,Name,
	    	   @IndustryID as IndustryID,@HierarchyID as KPITypeID,@IsDebit as IsDebit,@IsAggregate as IsAggregate,@Scale as Scale,
		   @Description as Description,
	    	   (select ID from RainmakerLDCJP_OAT.dbo.RMX_ValueType where Name = 'Numeric') as ValueTypeID
	    from #FinalLeavesUniqueID 
      ) x
      on x.Name = RM_DI.Name and x.IndustryID = RM_DI.IndustryID and x.KPITypeId = RM_DI.KPITypeID
      WHEN NOT MATCHED then
      	   INSERT (ID,IndustryID,KPITypeID,IsDebit,IsAggregate,Scale,ValueTypeID,Name,Description,createdOn,IsActive)
	   VALUES (x.RM_DataItemID,x.IndustryID,x.KPITypeID,x.IsDebit,x.IsAggregate,x.Scale,x.ValueTypeID,x.Name,x.Description,getdate(),@IsActive) ;
      
      -- The key criteria in that table is the unicity of the name so
      -- a similar merge is made into the Dim_RM_DataItem
      merge into RainmakerLDCJP_OAT.dbo.Dim_RM_DataItem RM_DI
      using (
      	    select RM_DataItemID,Name,
	    	   @IndustryID as IndustryID,@HierarchyID as KPITypeID,@IsDebit as IsDebit,@IsAggregate as IsAggregate,@Scale as Scale,
		   @Description as Description,
	    	   (select ID from RainmakerLDCJP_OAT.dbo.RMX_ValueType where Name = 'Numeric') as ValueTypeID,
		   -- Add the InvIndustryID and the InvIndustryName
		   (select InvIndustryID   from RainmakerLDCJP_OAT.dbo.RM_Industry where ID = @IndustryID) as InvIndustryID,
		   (select InvIndustryName from RainmakerLDCJP_OAT.dbo.RM_Industry where ID = @IndustryID) as InvIndustryName
	    from #FinalLeavesUniqueID 
      ) x
      on x.Name = RM_DI.DataItemName and x.IndustryID = RM_DI.IndustryID and x.KPITypeId = RM_DI.KPITypeID
      WHEN NOT MATCHED then
      	   INSERT (DataItemID,IndustryID,KPITypeName,KPITypeID,IsDebit,IsAggregate,Scale,ValueTypeName,ValueTypeID,DataItemName,DataItemDescription,IsSystemDefined,IsActive,InvIndustryID,InvIndustryName)
	   VALUES (x.RM_DataItemID,x.IndustryID,@HierarchyName,x.KPITypeID,x.IsDebit,x.IsAggregate,x.Scale,'Numeric',x.ValueTypeID,x.Name,x.Description,@IsSystemDefined,@IsActive,x.InvIndustryID,x.InvIndustryName) ;

END
GO

