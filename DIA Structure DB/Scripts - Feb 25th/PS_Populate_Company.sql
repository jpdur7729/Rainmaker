-- -------------------------------------------------------------------------
--                  Author    : FIS - JPD
--                  Time-stamp: "2021-02-26 09:02:09 jpdur"
-- -------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Add in to the Company the current/new Company
-- Extra precaution --> The name of the industry is assumed to be unique to prevent issues
-- Not in that table as it is actually inherited from Investran
-- ----------------------------------------------------------------------------------------
-- RM_IsActive is to be set to 1 in order for the Company to appear in the system
-- ----------------------------------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[PS_Populate_Company] (@CompanyName as varchar(255), @IndustryName as varchar(255), @InvCompanyId as integer = 0)
as
BEGIN

	merge into RM_Company
	using (
	      select @CompanyName as InvCompanyName, @InvCompanyID as InvCompanyID,
	      (select ID from RM_Industry where InvIndustryName = @IndustryName) as IndustryID
	) x
	on x.InvCompanyName = RM_Company.InvCompanyName 
	WHEN NOT MATCHED THEN
	     INSERT (ID,InvCompanyID,InvCompanyName,InvIndustry,RM_IsActive)
	     VALUES (NEWID(),x.InvCompanyID,x.InvCompanyName,x.IndustryID,1) ;

END
GO

-- EXEC PS_Populate_Company 'SaasCo','Industry 1'
-- EXEC PS_Populate_Company 'TestCo','Industry 3'
-- EXEC PS_Populate_Company 'TechCo','Industry 2'

-- select * from RM_Company




