-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-26 17:09:46 jpdur"
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
-- List of Hierarchies
if exists (select * from dbo.sysobjects where id = object_id(N'HierarchyList') and OBJECTPROPERTY(id, N'IsTable') = 1)
drop table HierarchyList
GO

-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Step 2 // Creates the view accordingly
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
create or alter VIEW HierarchyList
as
	Select Id as ID, Name as Name from RMX_KpiType 

