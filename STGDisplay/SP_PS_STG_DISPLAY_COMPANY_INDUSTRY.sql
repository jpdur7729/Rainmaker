-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-06-15 17:35:55 jpdur"
-- ------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------------
-- Local/STG agnostic ot display list of Companies with their associated Industry
-- -------------------------------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[PS_STG_DISPLAY_COMPANY_INDUSTRY]
as
BEGIN

     declare @cnt as integer

     -- In Local no need for DIA synonyms so that is the criterion to distinguish
     select @cnt = count(*) from sys.synonyms where name like 'DIA%'

     if (@cnt < 10) begin 
         select CompanyList.Name,IndustryList.Name as IndustryName from CompanyList, IndustryList where CompanyList.IndustryID = IndustryList.ID order by 1
     end 
     else begin 
     	 select CompanyList.Name,IndustryID as IndustryName from CompanyList order by 1
     end
     
END 
GO

