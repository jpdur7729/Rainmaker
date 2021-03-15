-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-27 09:32:01 jpdur"
-- ------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------
-- Create the frequency and the start date for which a company will capture DataPoints
-- Always to be created with the records in RM_KPICompanyRecurrenceAssociation
-- 	  if not "Error flagged call Administrator"
-- ------------------------------------------------------------------------------------
-- Successfully tested 2021-03-12 ... No longer an Administrator error
-- ------------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Populate_RM_KPICompanyConfiguration] (
       @IndustryName as varchar(100),
       @CompanyName as varchar(100),
       @StartCollectionDate as date,
       @NbPeriods as integer)
as
BEGIN
      -- We normalise the date to be the 1st day of the month
      set @StartCollectionDate = DATEADD(DAY, 1, EOMONTH(@StartCollectionDate, -1))

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from RainmakerLDCJP_OAT.dbo.RM_KPIIndustryTemplate where IndustryID = @IndustryID )

      declare @CompanyID as nvarchar(36)
      -- set @CompanyID   = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)
      set @CompanyID   = (select ID from CompanyList where Name = @CompanyName)

      -- ID to be reused when created the RM_KPICompanyRecurrenceAssociation
	  declare @KPICompanyConfigurationID as nvarchar(36)
      set @KPICompanyConfigurationID = NEWID()

      -- Bit field default value is 1
      declare @IsConfirmed as BIT
      set @IsConfirmed = 1

      declare @cnt as integer
      set @cnt = (select count(*) from RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfiguration where @KPIIndustryTemplateID = KPIIndustryTemplateID and @CompanyID = CompanyID)

      if (@cnt = 0) begin 
      	 -- We add the nodes from RM_Node associated to the instrustry
      	 merge into RainmakerLDCJP_OAT.dbo.RM_KPICompanyConfiguration RM_KCompConf
      	 using (
      	 select @KPIIndustryTemplateID as KPIIndustryTemplateID,@CompanyID as CompanyID,
      	     (select ID from RainmakerLDCJP_OAT.dbo.RMX_CollectionRecurrence where Name= 'End after X periods') as CollectionRecurrenceID
	     ) x
      	 on
      	 x.KPIIndustryTemplateID = RM_KCompConf.KPIIndustryTemplateID and x.CompanyID = RM_KCompConf.CompanyID
      	 when NOT MATCHED THEN
              INSERT (ID,CreatedOn,KPIIndustryTemplateId,CompanyID,CollectionRecurrenceID,IsConfirmed,NoOfRecurrences,StartDate)
	      VALUES (@KPICompanyConfigurationID,getdate(),x.KPIIndustryTemplateId,x.CompanyID,x.CollectionRecurrenceID,@IsConfirmed,@NbPeriods,@StartCollectionDate) ;

         -- We normalise the date to be the 1st day of the month
      	 declare @StartCollectionQuarter as date 
      	 set @StartCollectionQuarter = DATEADD(qq, DATEDIFF(qq, 0, @StartCollectionDate), 0)

         -- Create the intermediate table 
	 select case when Name = 'Financials' then (select ID from RainmakerLDCJP_OAT.dbo.RMX_CollectionPeriod where Name = 'Monthly')
	 	     	       	 	              else (select ID from RainmakerLDCJP_OAT.dbo.RMX_CollectionPeriod where Name = 'Quarterly')
		end as CollectionPeriodID,
		case when Name = 'Financials' then 1
	 	     	       	 	          else 3
		end as NbMonths,
		KPICat.ID as KPICategoryID
	 into #InterTable 
	 from RainmakerLDCJP_OAT.dbo.RMX_KPICategory KPICat where Name <> 'All Financials'

	 -- Add the StartDate/EndDate and insert into RM_KPICompanyRecurrenceAssociation
	 INSERT into RainmakerLDCJP_OAT.dbo.RM_KPICompanyRecurrenceAssociation
	 select NEWID() as ID,
      	 	@KPICompanyConfigurationID as KPICompanyConfigurationID,
	        case when NbMonths = 1 then @StartCollectionDate
	 	     	      	           else @StartCollectionQuarter
		end as StartDate,
		case when NbMonths = 1 then EOMONTH(DATEADD(m,18,@StartCollectionDate))
	 	     	      	       else EOMONTH(DATEADD(m,18,@StartCollectionQuarter))
		end as EndDate,
		CollectionPeriodID,
		KPICategoryID
	 from #InterTable

      end -- end the case where the insert is required  

END
GO

