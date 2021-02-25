-- -------------------------------------------------------------------------
--                  Author    : FIS - JPD
--                  Time-stamp: "2021-02-25 17:40:40 jpdur"
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

