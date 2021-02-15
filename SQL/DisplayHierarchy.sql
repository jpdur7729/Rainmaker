-- ------------------------------------------------------------------------------
--                     Author    : F2 - JPD
--                     Time-stamp: "2021-01-15 07:33:43 jpdur"
-- ------------------------------------------------------------------------------

-- Create Function in order to get the DataPointID from DataPointMapping 
CREATE or ALTER FUNCTION [dbo].[GetDataPointID] (@NodeDefID as varchar(36), @CompanyID as varchar(36))
RETURNS varchar(36)

BEGIN

declare @result as varchar(36)

set @result = (select ID from DataPointMapping where NodeDefID = @NodeDefID and CompanyID = @CompanyID)

return @result 

END


-- Create Function in order to get the DataPointID from DataPointMapping 
CREATE or ALTER FUNCTION [dbo].[GetDataPointValue_Num] (@NodeDefID as varchar(36), @CompanyID as varchar(36), @Scenario as varchar(100), @DateValue as date)
RETURNS float

BEGIN

-- Get the DataPoint ID 
declare @DPVID as varchar(36)
set @DPVID = (select dbo.GetDataPointID(@NodeDefID,@CompanyID) )

-- Return a float value
declare @result as float 

-- Get the data 
set @result = (select NumValue from DataPointValues where DataPointID = @DPVID and Scenario = @Scenario and DataPointDate = @DateValue )
return @result 

END

-- ---------------------------------------------------------
-- Display root Hierarchy for IncomeStatement/Balance Sheet
-- ---------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[DISPLAY_HIERARCHY_ROOT](@HierarchyName as varchar(100))
as
BEGIN

declare @HierarchyID as varchar(36)
set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )

-- Debug check Data
-- select @HierarchyID,@HierarchyName

-- List the Tree for Hierarchies one level
select hl.Name as 'Hierarchy',n1.Name as 'Level1'--,n1.SortOrder
       from Hierarchies H1, NodeDef n1, HierarchyList hl
       where H1.ParentNodeDefID = @HierarchyID and hl.ID = @HierarchyID
	   and H1.NodeDefID = n1.ID
       order by n1.SortOrder

END 
GO

EXEC DISPLAY_HIERARCHY_ROOT 'Income Statement'


-- -----------------------------------------------------------------
-- Display Hierarchy for IncomeStatement/Balance Sheet + Industry
-- -----------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[DISPLAY_HIERARCHY_INDUSTRY](@HierarchyName as varchar(100),@IndustryName as varchar(100))
as
BEGIN

declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )

---- Debug Check IDs have been captured
--select @IndustryName,@IndustryID,@HierarchyName,@HierarchyID 

---- List the Tree for Hierarchies only the level just down without dynamic name of columns
select hlist.Name as 'Hierarchy',n1.Name as 'Level1',n3.Name as IndustryLevel
       from Hierarchies h1,  Hierarchies h3, NodeDef n1,  NodeDefIndustry n3, HierarchyList hlist
       where hlist.ID = @HierarchyID 
	   and h1.ParentNodeDefID = @HierarchyID
       	   and n1.ID = h1.NodeDefID and n1.HierarchyID = @HierarchyID
       	   and h3.ParentNodeDefID = h1.NodeDefID
       	   and n3.ID = h3.NodeDefID and n3.HierarchyID = @HierarchyID and n3.IndustryID = @IndustryID
order by n1.SortOrder,n3.SortOrder

-- declare @query as nvarchar(MAX)
-- set @query  = 'select hlist.Name as Hierarchy,n1.Name as Level1,n2.Name as Level2,n3.Name as ''' + @IndustryName + ''' '
-- set @query += 'from Hierarchies h1, Hierarchies h2, Hierarchies h3, NodeDef n1, NodeDef n2, NodeDefIndustry n3, HierarchyList hlist '
-- set @query += 'where hlist.ID = @HierarchyID  '
-- set @query += 'and h1.ParentNodeDefID = @HierarchyID '
-- set @query += 'and n1.ID = h1.NodeDefID and n1.HierarchyID = @HierarchyID '
-- set @query += 'and h2.ParentNodeDefId = h1.NodeDefId '
-- set @query += 'and n2.ID = h2.NodeDefID and n2.HierarchyID=@HierarchyID '
-- set @query += 'and h3.ParentNodeDefID = h2.NodeDefID '
-- set @query += 'and n3.ID = h3.NodeDefID and n3.HierarchyID = @HierarchyID and n3.IndustryID = @IndustryID '
-- set @query += 'order by 2,3,4'

-- -- https://stackoverflow.com/questions/28481189/exec-sp-executesql-with-multiple-parameters
-- DECLARE @paramdef nvarchar (500)
-- SET @paramdef = '@HierarchyID nvarchar (36), @IndustryID nvarchar (36)'

-- -- Execute with the parameters
-- execute SP_executesql @query, @paramdef, @HierarchyID, @IndustryID

END
GO

-- -----------------------------------------------------------------
-- Display Hierarchy for IncomeStatement/Balance Sheet + Industry
-- -----------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[DISPLAY_HIERARCHY_INDUSTRY_OLD](@HierarchyName as varchar(100),@IndustryName as varchar(100))
as
BEGIN

declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )

-- Debug Check IDs have been captured
-- select @IndustryName,@IndustryID,@HierarchyName,@HierarchyID 

-- ---- List the Tree for Hierarchies only the level just down without dynamic name of columns
-- select hlist.Name as 'Hierarchy',n1.Name as 'Level1',n2.Name as 'Level2',n3.Name as IndustryLevel
--        from Hierarchies h1, Hierarchies h2, Hierarchies h3, NodeDef n1, NodeDef n2, NodeDefIndustry n3, HierarchyList hlist
--        where hlist.ID = @HierarchyID 
-- 	   and h1.ParentNodeDefID = @HierarchyID
--        	   and n1.ID = h1.NodeDefID and n1.HierarchyID = @HierarchyID
--        	   and h2.ParentNodeDefId = h1.NodeDefId
--        	   and n2.ID = h2.NodeDefID and n2.HierarchyID=@HierarchyID
--        	   and h3.ParentNodeDefID = h2.NodeDefID
--        	   and n3.ID = h3.NodeDefID and n3.HierarchyID = @HierarchyID and n3.IndustryID = @IndustryID
-- order by 2,3,4

declare @query as nvarchar(MAX)
set @query  = 'select hlist.Name as Hierarchy,n1.Name as Level1,n2.Name as Level2,n3.Name as ''' + @IndustryName + ''' '
set @query += 'from Hierarchies h1, Hierarchies h2, Hierarchies h3, NodeDef n1, NodeDef n2, NodeDefIndustry n3, HierarchyList hlist '
set @query += 'where hlist.ID = @HierarchyID  '
set @query += 'and h1.ParentNodeDefID = @HierarchyID '
set @query += 'and n1.ID = h1.NodeDefID and n1.HierarchyID = @HierarchyID '
set @query += 'and h2.ParentNodeDefId = h1.NodeDefId '
set @query += 'and n2.ID = h2.NodeDefID and n2.HierarchyID=@HierarchyID '
set @query += 'and h3.ParentNodeDefID = h2.NodeDefID '
set @query += 'and n3.ID = h3.NodeDefID and n3.HierarchyID = @HierarchyID and n3.IndustryID = @IndustryID '
set @query += 'order by 2,3,4'

-- https://stackoverflow.com/questions/28481189/exec-sp-executesql-with-multiple-parameters
DECLARE @paramdef nvarchar (500)
SET @paramdef = '@HierarchyID nvarchar (36), @IndustryID nvarchar (36)'

-- Execute with the parameters
execute SP_executesql @query, @paramdef, @HierarchyID, @IndustryID

END
GO

EXEC DISPLAY_HIERARCHY_INDUSTRY 'Income Statement','Industry 1'
EXEC DISPLAY_HIERARCHY_INDUSTRY 'Income Statement','Industry 2'

-- -- Check data per Industry 
-- select * from IndustryList
-- select * from NodeDefIndustry where IndustryID in (select ID from IndustryList where Name = 'Industry 2') -- 6CB076DB-32EE-4E73-886E-90CCA0B111A6
-- select distinct IndustryID from NodeDefIndustry
-- select * from Hierarchies where NodeDefID in (select ID from NodeDefIndustry)
-- select * from Hierarchies where NodeDefID in (select ID from NodeDefIndustry where IndustryID in (select ID from IndustryList where Name = 'Industry 2'))
-- select TOP 10  * from NodeDef

-- -----------------------------------------------------------------
-- Display Hierarchy for IncomeStatement/Balance Sheet + Industry
-- -----------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[DISPLAY_HIERARCHY_INDUSTRY_v2](@HierarchyName as varchar(100),@IndustryName as varchar(100),@CompanyName as varchar(100))
as
BEGIN

declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)
declare @CompanyID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )
set @CompanyID = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)

-- Debug Check IDs have been captured
select @IndustryName,@IndustryID,@HierarchyName,@HierarchyID,@CompanyName,@CompanyID 

---- List the Tree for Hierarchies only the level just down without dynamic name of columns
select hlist.Name as 'Hierarchy',n2.Name as 'Level2',n3.Name as IndustryLevel,n4.Name as CompanyLevel1
       from Hierarchies h2, Hierarchies h3, Hierarchies h4, NodeDef n2, NodeDefIndustry n3, NodeDefCompany n4, HierarchyList hlist
       where hlist.ID = @HierarchyID 
	   and h2.ParentNodeDefID = @HierarchyID
       	   and n2.ID = h2.NodeDefID and n2.HierarchyID=@HierarchyID
       	   and h3.ParentNodeDefID = h2.NodeDefID
       	   and n3.ID = h3.NodeDefID and n3.HierarchyID = @HierarchyID and n3.IndustryID = @IndustryID
       	   and h4.ParentNodeDefID = h3.NodeDefID
       	   and n4.ID = h4.NodeDefID and n4.HierarchyID = @HierarchyID and n4.IndustryID = @IndustryID and n4.CompanyID = @CompanyID
order by n2.SortOrder,n3.SortOrder,n4.SortOrder

-- declare @query as nvarchar(MAX)
-- set @query  = 'select hlist.Name as Hierarchy,n1.Name as Level1,n2.Name as Level2,n3.Name as ''' + @IndustryName + ''' '
-- set @query += 'from Hierarchies h1, Hierarchies h2, Hierarchies h3, NodeDef n1, NodeDef n2, NodeDefIndustry n3, HierarchyList hlist '
-- set @query += 'where hlist.ID = @HierarchyID  '
-- set @query += 'and h1.ParentNodeDefID = @HierarchyID '
-- set @query += 'and n1.ID = h1.NodeDefID and n1.HierarchyID = @HierarchyID '
-- set @query += 'and h2.ParentNodeDefId = h1.NodeDefId '
-- set @query += 'and n2.ID = h2.NodeDefID and n2.HierarchyID=@HierarchyID '
-- set @query += 'and h3.ParentNodeDefID = h2.NodeDefID '
-- set @query += 'and n3.ID = h3.NodeDefID and n3.HierarchyID = @HierarchyID and n3.IndustryID = @IndustryID '
-- set @query += 'order by 2,3,4'

-- -- https://stackoverflow.com/questions/28481189/exec-sp-executesql-with-multiple-parameters
-- DECLARE @paramdef nvarchar (500)
-- SET @paramdef = '@HierarchyID nvarchar (36), @IndustryID nvarchar (36)'

-- -- Execute with the parameters
-- execute SP_executesql @query, @paramdef, @HierarchyID, @IndustryID

END
GO

EXEC DISPLAY_HIERARCHY_INDUSTRY_v2 'Balance Sheet', 'Industry 1','SaasCo'

-- select * from Hierarchies where ParentNodeDefID = '9BB49076-D39D-4E30-A360-AC942F469526'


-- -----------------------------------------------------------------
-- Display Hierarchy for IncomeStatement/Balance Sheet + Industry
-- -----------------------------------------------------------------
CREATE or ALTER PROCEDURE [dbo].[DISPLAY_HIERARCHY_INDUSTRY_v3](@HierarchyName as varchar(100),@IndustryName as varchar(100),@CompanyName as varchar(100))
as
BEGIN

declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)
declare @CompanyID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )
set @CompanyID = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)

-- Debug Check IDs have been captured
select @IndustryName,@IndustryID,@HierarchyName,@HierarchyID,@CompanyName,@CompanyID 

---- List the Tree for Hierarchies only the level just down without dynamic name of columns
select hlist.Name as 'Hierarchy',n2.Name as 'Level2',n3.Name as IndustryLevel,n4.Name as CompanyLevel1,n5.Name as CompanyLevel2
       from Hierarchies h2, Hierarchies h3, Hierarchies h4, NodeDef n2, NodeDefIndustry n3, NodeDefCompany n4, HierarchyList hlist,
       Hierarchies h5, NodeDefCompany n5
       where hlist.ID = @HierarchyID 
	   and h2.ParentNodeDefID = @HierarchyID
       	   and n2.ID = h2.NodeDefID and n2.HierarchyID=@HierarchyID
       	   and h3.ParentNodeDefID = h2.NodeDefID
       	   and n3.ID = h3.NodeDefID and n3.HierarchyID = @HierarchyID and n3.IndustryID = @IndustryID
       	   and h4.ParentNodeDefID = h3.NodeDefID
       	   and n4.ID = h4.NodeDefID and n4.HierarchyID = @HierarchyID and n4.IndustryID = @IndustryID and n4.CompanyID = @CompanyID and n4.level = 1
	   ----------------
       	   and h5.ParentNodeDefID = h4.NodeDefID
       	   and n5.ID = h5.NodeDefID and n5.HierarchyID = @HierarchyID and n5.IndustryID = @IndustryID and n5.CompanyID = @CompanyID and n5.level = 2
order by n2.SortOrder,n3.SortOrder,n4.SortOrder,n5.SortOrder

-- declare @query as nvarchar(MAX)
-- set @query  = 'select hlist.Name as Hierarchy,n1.Name as Level1,n2.Name as Level2,n3.Name as ''' + @IndustryName + ''' '
-- set @query += 'from Hierarchies h1, Hierarchies h2, Hierarchies h3, NodeDef n1, NodeDef n2, NodeDefIndustry n3, HierarchyList hlist '
-- set @query += 'where hlist.ID = @HierarchyID  '
-- set @query += 'and h1.ParentNodeDefID = @HierarchyID '
-- set @query += 'and n1.ID = h1.NodeDefID and n1.HierarchyID = @HierarchyID '
-- set @query += 'and h2.ParentNodeDefId = h1.NodeDefId '
-- set @query += 'and n2.ID = h2.NodeDefID and n2.HierarchyID=@HierarchyID '
-- set @query += 'and h3.ParentNodeDefID = h2.NodeDefID '
-- set @query += 'and n3.ID = h3.NodeDefID and n3.HierarchyID = @HierarchyID and n3.IndustryID = @IndustryID '
-- set @query += 'order by 2,3,4'

-- -- https://stackoverflow.com/questions/28481189/exec-sp-executesql-with-multiple-parameters
-- DECLARE @paramdef nvarchar (500)
-- SET @paramdef = '@HierarchyID nvarchar (36), @IndustryID nvarchar (36)'

-- -- Execute with the parameters
-- execute SP_executesql @query, @paramdef, @HierarchyID, @IndustryID

END
GO

EXEC DISPLAY_HIERARCHY_INDUSTRY_v3 'Balance Sheet', 'Industry 1','SaasCo'


CREATE or ALTER PROCEDURE [dbo].[DISPLAY_HIERARCHY_INDUSTRY_v4](@HierarchyName as varchar(100),@IndustryName as varchar(100),@CompanyName as varchar(100))
as
BEGIN

declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)
declare @CompanyID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )
set @CompanyID = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)

---- Debug Check IDs have been captured
--select @IndustryName,@IndustryID,@HierarchyName,@HierarchyID,@CompanyName,@CompanyID 

-- ---- List the Tree for Hierarchies only the level just down without dynamic name of columns
-- select hlist.Name as 'Hierarchy',n2.Name as 'Level2',n3.Name as IndustryLevel,n4.Name as CompanyLevel1,n5.Name as CompanyLevel2
--        from Hierarchies h2, Hierarchies h3, Hierarchies h4, NodeDef n2, NodeDefIndustry n3, NodeDefCompany n4, HierarchyList hlist,
--        Hierarchies h5, NodeDefCompany n5
--        where hlist.ID = @HierarchyID 
-- 	   and h2.ParentNodeDefID = @HierarchyID
--        	   and n2.ID = h2.NodeDefID and n2.HierarchyID=@HierarchyID
--        	   and h3.ParentNodeDefID = h2.NodeDefID
--        	   and n3.ID = h3.NodeDefID and n3.HierarchyID = @HierarchyID and n3.IndustryID = @IndustryID
--        	   and h4.ParentNodeDefID = h3.NodeDefID
--        	   and n4.ID = h4.NodeDefID and n4.HierarchyID = @HierarchyID and n4.IndustryID = @IndustryID and n4.CompanyID = @CompanyID and n4.level = 1
-- 	   ----------------
--        	   and h5.ParentNodeDefID = h4.NodeDefID
--        	   and n5.ID = h5.NodeDefID and n5.HierarchyID = @HierarchyID and n5.IndustryID = @IndustryID and n5.CompanyID = @CompanyID and n5.level = 2
-- order by n2.SortOrder,n3.SortOrder,n4.SortOrder,n5.SortOrder

select Hierarchy,Level1,IndustryLevel,CompanyLevel1,coalesce(CompanyLevel2,'') as CompanyLevel2
from
       (select hlist.Name as 'Hierarchy',n2.Name as 'Level1',n3.Name as IndustryLevel,n4.Name as CompanyLevel1,
	   h4.NodeDefID as NodeDefID,
       n2.SortOrder as SOL1,n3.SortOrder as SOL2,n4.SortOrder as SOL3
       from Hierarchies h2, Hierarchies h3, Hierarchies h4, NodeDef n2, NodeDefIndustry n3, NodeDefCompany n4, HierarchyList hlist
       where hlist.ID = @HierarchyID 
	   and h2.ParentNodeDefID = @HierarchyID
       	   and n2.ID = h2.NodeDefID and n2.HierarchyID=@HierarchyID
       	   and h3.ParentNodeDefID = h2.NodeDefID
       	   and n3.ID = h3.NodeDefID and n3.HierarchyID = @HierarchyID and n3.IndustryID = @IndustryID
       	   and h4.ParentNodeDefID = h3.NodeDefID
       	   and n4.ID = h4.NodeDefID and n4.HierarchyID = @HierarchyID and n4.IndustryID = @IndustryID and n4.CompanyID = @CompanyID and n4.level = 1)
	   Extract1
left join
     (	select n5.Name as CompanyLevel2,n5.SortOrder as SortOrderCL2, h5.ParentNodeDefID as ParentNodeDefID
	       from Hierarchies h5, NodeDefCompany n5
       	   where n5.ID = h5.NodeDefID and n5.HierarchyID = @HierarchyID and n5.IndustryID = @IndustryID and n5.CompanyID = @CompanyID and n5.level = 2)
	   Extract2

      on Extract2.ParentNodeDefID = Extract1.NodeDefID

order by SOL1,SOL2,SOL3,SortOrderCL2

END
GO

EXEC DISPLAY_HIERARCHY_INDUSTRY_v4 'Balance Sheet', 'Industry 1','SaasCo'


CREATE or ALTER PROCEDURE [dbo].[DISPLAY_HIERARCHY_INDUSTRY_DATA](@HierarchyName as varchar(100),@IndustryName as varchar(100),@CompanyName as varchar(100),
@Scenario as varchar(100),@DateValue as date)
as
BEGIN

declare @HierarchyID as nvarchar(36)
declare @IndustryID as nvarchar(36)
declare @CompanyID as nvarchar(36)

set @HierarchyID = (select ID from HierarchyList where Name = @HierarchyName )
set @IndustryID = (select ID from IndustryList where Name = @IndustryName )
set @CompanyID = (select ID from CompanyList where Name = @CompanyName and IndustryID = @IndustryID)

---- Debug Check IDs have been captured
--select @IndustryName,@IndustryID,@HierarchyName,@HierarchyID,@CompanyName,@CompanyID 

-- ---- List the Tree for Hierarchies only the level just down without dynamic name of columns
-- select hlist.Name as 'Hierarchy',n2.Name as 'Level2',n3.Name as IndustryLevel,n4.Name as CompanyLevel1,n5.Name as CompanyLevel2
--        from Hierarchies h2, Hierarchies h3, Hierarchies h4, NodeDef n2, NodeDefIndustry n3, NodeDefCompany n4, HierarchyList hlist,
--        Hierarchies h5, NodeDefCompany n5
--        where hlist.ID = @HierarchyID 
-- 	   and h2.ParentNodeDefID = @HierarchyID
--        	   and n2.ID = h2.NodeDefID and n2.HierarchyID=@HierarchyID
--        	   and h3.ParentNodeDefID = h2.NodeDefID
--        	   and n3.ID = h3.NodeDefID and n3.HierarchyID = @HierarchyID and n3.IndustryID = @IndustryID
--        	   and h4.ParentNodeDefID = h3.NodeDefID
--        	   and n4.ID = h4.NodeDefID and n4.HierarchyID = @HierarchyID and n4.IndustryID = @IndustryID and n4.CompanyID = @CompanyID and n4.level = 1
-- 	   ----------------
--        	   and h5.ParentNodeDefID = h4.NodeDefID
--        	   and n5.ID = h5.NodeDefID and n5.HierarchyID = @HierarchyID and n5.IndustryID = @IndustryID and n5.CompanyID = @CompanyID and n5.level = 2
-- order by n2.SortOrder,n3.SortOrder,n4.SortOrder,n5.SortOrder

select Hierarchy,Level1,IndustryLevel,CompanyLevel1,coalesce(CompanyLevel2,'') as CompanyLevel2,coalesce(AmountL2,AmountL1) as Amount
     ,SOL1,SOL2,SOL3,SortOrderCL2
from
       (select hlist.Name as 'Hierarchy',n2.Name as 'Level1',n3.Name as IndustryLevel,n4.Name as CompanyLevel1,
	   h4.NodeDefID as NodeDefID,
	   dbo.GetDataPointValue_Num(n4.ID, @CompanyID, @Scenario, @DateValue) as AmountL1,
       n2.SortOrder as SOL1,n3.SortOrder as SOL2,n4.SortOrder as SOL3
       from Hierarchies h2, Hierarchies h3, Hierarchies h4, NodeDef n2, NodeDefIndustry n3, NodeDefCompany n4, HierarchyList hlist
       where hlist.ID = @HierarchyID 
	   and h2.ParentNodeDefID = @HierarchyID
       	   and n2.ID = h2.NodeDefID and n2.HierarchyID=@HierarchyID
       	   and h3.ParentNodeDefID = h2.NodeDefID
       	   and n3.ID = h3.NodeDefID and n3.HierarchyID = @HierarchyID and n3.IndustryID = @IndustryID
       	   and h4.ParentNodeDefID = h3.NodeDefID
       	   and n4.ID = h4.NodeDefID and n4.HierarchyID = @HierarchyID and n4.IndustryID = @IndustryID and n4.CompanyID = @CompanyID and n4.level = 1)
	   Extract1
left join
     (	select n5.Name as CompanyLevel2,n5.SortOrder as SortOrderCL2, h5.ParentNodeDefID as ParentNodeDefID,
     	       dbo.GetDataPointValue_Num(n5.ID, @CompanyID, @Scenario, @DateValue) as AmountL2

	       from Hierarchies h5, NodeDefCompany n5
       	   where n5.ID = h5.NodeDefID and n5.HierarchyID = @HierarchyID and n5.IndustryID = @IndustryID and n5.CompanyID = @CompanyID and n5.level = 2)
	   Extract2

      on Extract2.ParentNodeDefID = Extract1.NodeDefID

order by SOL1,SOL2,SOL3,SortOrderCL2

END
GO
