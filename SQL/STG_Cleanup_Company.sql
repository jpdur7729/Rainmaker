-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-06-15 14:51:21 jpdur"
-- ------------------------------------------------------------------------------

-- -------------------------------------------------------------
-- Cleanup all data related to a Company but the Company itself
-- -------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[PS_STG_CLEANUP_COMPANY](
       @CompanyName as varchar(250))
as
BEGIN

     -- Elimitate DataPointValues and DataPointMapping
     delete from DataPointValues where DataPointID in (select ID from DataPointMapping where CompanyID in (select ID from CompanyList where Name = @CompanyName))
     delete from DataPointMapping where CompanyID in (select ID from CompanyList where Name = @CompanyName)
 
     -- Elimitate the NodeDefData and the corresponding Hierarchies nodes
     delete from Hierarchies where NodeDefID in (select ID from NodeDefCompany where CompanyId in (select ID from CompanyList where Name = @CompanyName))
     delete from NodeDefCompany where CompanyId in (select ID from CompanyList where Name = @CompanyName)

END
GO
