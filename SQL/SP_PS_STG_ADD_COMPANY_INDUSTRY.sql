/* ------------------------------------------------------------------------------
                       Author    : FIS - JPD
                       Time-stamp: "2021-06-14 08:15:45 jpdur"
   ------------------------------------------------------------------------------ */

-- --------------------------------------------------------------------------------------
-- For Local DB // Easy way to create/add a Company and an industry if it does not exist 
-- --------------------------------------------------------------------------------------
-- Limitation:
--	If the company exists with another industry - No flag and no change
--	To be added in a further version for ease of control 2021-06-14
-- --------------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[PS_STG_ADD_COMPANY_INDUSTRY](
       @CompanyName as varchar(250),@IndustryName as varchar(250))
as
BEGIN

      -- The IndustryName is unique
      merge into RM_Industry
      using (
      	    select @IndustryName as InvIndustryName
      ) x
      on RM_Industry.InvIndustryName = x.InvIndustryName
      when not matched then
      	   INSERT VALUES (NEWID(),0,@IndustryName)
      ; 

      -- The CompanyName is unique
      merge into RM_Company
      using (
      	    select @CompanyName as InvCompanyName, (select ID from RM_Industry where InvIndustryName = @IndustryName) as InvIndustry
      ) x
      on RM_Company.InvCompanyName = x.InvCompanyName
      when not matched then
      	   INSERT VALUES (NEWID(),0,x.InvCompanyName,null,null,x.InvIndustry,-1,1)

      ; 

END
GO
