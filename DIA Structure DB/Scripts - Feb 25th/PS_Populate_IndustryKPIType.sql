-- -------------------------------------------------------------------------
--                  Author    : FIS - JPD
--                  Time-stamp: "2021-02-25 17:38:13 jpdur"
-- -------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Add in to the Industry the current/new Industry
-- Extra precaution --> The name of the industry is assumed to be unique to prevent issues
-- Not in that table as it is actually inherited from Investran
-- ----------------------------------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[PS_Populate_Industry] (@IndustryName as varchar(255), @InvIndustryId as integer = 0)
as
BEGIN

	merge into RM_Industry
	using (
	      select @IndustryName as InvIndustryName, @InvIndustryId as InvIndustryId
	) x
	on x.InvIndustryName = RM_Industry.InvIndustryName 
	WHEN NOT MATCHED THEN
	     INSERT VALUES (NEWID(),x.InvIndustryID,x.InvIndustryName) ;

END
GO

-- InvIndustryID is not known ==> 0 by default
EXEC PS_Populate_Industry 'TestIndustry1'
EXEC PS_Populate_Industry 'TestIndustry2'

select * from RM_Industry

-- ----------------------------------------------------------------------------------------
-- Add in the KPI Type (Balance Sheet,Income Statement) then later on Cash Flow
-- Extra precaution --> The name of the KPIType is assumed to be unique to prevent issues
-- ----------------------------------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[PS_Populate_KPIType] (@KPITypeName as varchar(255))
as
BEGIN

	merge into RMX_KPIType
	using (
	      select @KPITypeName as Name
	) x
	on x.Name = RMX_KPIType.Name 
	WHEN NOT MATCHED THEN
	     INSERT (ID,Name) VALUES (NEWID(),x.Name);

END
GO

EXEC PS_Populate_KPIType 'Balance Sheet'
EXEC PS_Populate_KPIType 'Income Statement'

select * from RMX_KPIType
