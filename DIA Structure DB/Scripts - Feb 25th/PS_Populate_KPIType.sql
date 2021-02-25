-- -------------------------------------------------------------------------
--                  Author    : FIS - JPD
--                  Time-stamp: "2021-02-25 17:40:32 jpdur"
-- -------------------------------------------------------------------------

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
	     INSERT (ID,Name) VALUES (NEWID(),x.Name)

END
GO

EXEC PS_Populate_KPIType 'Balance Sheet'
EXEC PS_Populate_KPIType 'Income Statement'

select * from RMX_KPIType
