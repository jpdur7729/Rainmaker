-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-27 16:38:59 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_DataItem] ( @HierarchyName as varchar(100) ,@IndustryName as varchar(100) ,@CompanyName as varchar(100) )
as
BEGIN

      declare @HierarchyID as nvarchar(36)
      -- Alias KPITypeID
      set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from RM_KPIIndustryTemplate where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      declare @KPICompanyConfigurationID as nvarchar(36)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @KPICompanyConfigurationID = (select ID from RM_KPICompanyConfiguration where CompanyID = @CompanyID )

      -- Create the defualt value for RM_DataItem
      declare @IsDebit as BIT
      set @IsDebit = 1
      declare @IsAggregate as BIT
      set @IsAggregate = 1
      declare @Scale as BIT
      set @Scale = 1

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

      -- The key criteria in that table is the unicity of the name so
      merge into RM_DataItem RM_DI
      using (
      	    select distinct Name,@IndustryID as IndustryID,@HierarchyID as KPITypeID,@IsDebit as IsDebit,@IsAggregate as IsAggregate,@Scale as Scale,
	    (select ID from RMX_ValueType where Name = 'Default') as ValueTypeID
	    from #FinalLeaves 
      ) x
      on x.Name = RM_DI.Name and x.IndustryID = RM_DI.IndustryID and x.KPITypeId = RM_DI.KPITypeID
      WHEN NOT MATCHED then
      	   INSERT (IndustryID,KPITypeID,IsDebit,IsAggregate,Scale,ValueTypeID,Name)
	   VALUES (x.IndustryID,x.KPITypeID,x.IsDebit,x.IsAggregate,x.Scale,x.ValueTypeID,x.Name) ;
      
END
GO

