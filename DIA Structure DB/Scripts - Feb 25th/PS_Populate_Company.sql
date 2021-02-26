-- -------------------------------------------------------------------------
--                  Author    : FIS - JPD
--                  Time-stamp: "2021-02-26 06:59:20 jpdur"
-- -------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------
-- Add in to the Company the current/new Company
-- Extra precaution --> The name of the industry is assumed to be unique to prevent issues
-- Not in that table as it is actually inherited from Investran
-- ----------------------------------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[PS_Populate_Company] (@CompanyName as varchar(255), @InvCompanyId as integer = 0)
as
BEGIN

	merge into RM_Company
	using (
	      select @CompanyName as InvCompanyName, @InvCompanyID as InvCompanyID
	) x
	on x.InvCompanyName = RM_Company.InvCompanyName 
	WHEN NOT MATCHED THEN
	     INSERT (ID,InvCompanyID,InvCompanyName) VALUES (NEWID(),x.InvCompanyID,x.InvCompanyName) ;

END
GO

-- InvCompanyID is not known ==> 0 by default
EXEC PS_Populate_Company 'TestCo'

select * from RM_Company

