-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-26 17:09:39 jpdur"
-- ------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------------
-- Idea is mapping the RM_*** tables to previous staging tables
-- It relies on the idea that as part of the staginf process we only ask for these
-- tables/view to provide an association between a Hierarchy/Industry/Company name
-- and the corresponding ID
-- The actual definition of the staging tables add some extra field actually not used
-- -------------------------------------------------------------------------------------

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Step 1 // Checking that all the XXXList Tables are dropped in order to create views
--           with a similar name
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- List of Companies
if exists (select * from dbo.sysobjects where id = object_id(N'CompanyList') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table CompanyList
GO

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Step 2 // Creates the view accordingly
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Only Companies where RM_IsActive = 1 are to be taken into account 
create or alter VIEW CompanyList
as 
	Select Id as ID, InvCompanyName as Name,InvIndustry as IndustryID
	       from RM_Company
	       where RM_IsActive = 1
GO

-- Verification that the 2 reference tables are linked
select * from CompanyList cl ,IndustryList il where cl.IndustryID = il.ID
