-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-04-13 08:28:23 jpdur"
-- ------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Recusively builds a Genealogical string for any node found in CollectionDimension
-- Actually the function is in 2 parts and is a wrapper 
-- Part 1 // Extract the DataItem Name
-- Part 2 // Then Recursively add the Names of the Node
-- -----------------------------------------------------------------------------------
CREATE or ALTER FUNCTION [dbo].[STG_DIA_FullPathName] (@CollectionDimensionID as varchar(36))
RETURNS varchar(1000)
BEGIN

	declare @TreeString as varchar(1000)

	-- From Collection Dimension ==> Back to DataItem ID and KPICollectionNodeID
	declare @KPICollectionDataItemID as varchar(36) = (select KPICollectionDataItemID from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Dimension where ID = @CollectionDimensionID   )
	declare @DataItemID              as varchar(36) = (select DataItemID              from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_DataItem  where ID = @KPICollectionDataItemID )
	declare @KPICollectionNodeID     as varchar(36) = (select KPICollectionNodeID     from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_DataItem  where ID = @KPICollectionDataItemID )

	-- Extract the name of the DataItem
	select @TreeString = Name from RainmakerLDCJP_OAT.dbo.RM_DataItem where ID = @DataItemID

	-- Concatenate with the string corresponding to parent in a very similar way to directories
	return dbo.STG_DIA_FullPathName_RNode(@KPICollectionNodeID)+'/'+@TreeString

END
GO

CREATE or ALTER FUNCTION [dbo].[STG_DIA_FullPathName_RNode] (@CollectionNodeID as varchar(36))
RETURNS varchar(1000)
BEGIN

	declare @TreeString as varchar(1000)

	if (@CollectionNodeID is null)
	begin
		-- We stop nothing to return but we could return the name of the Hierarchy 
		return ''
	end
	
	-- Extract the name 
	select @TreeString = Name from RainmakerLDCJP_OAT.dbo.RM_KPI_Node where ID in (select NodeID from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node where ID = @CollectionNodeID)

	-- Concatenate with the string corresponding to parent in a very similar way to directories
	return dbo.STG_DIA_FullPathName_RNode((select ParentKPICollectionNodeID from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node where ID = @CollectionNodeID))+'/'+@TreeString

END
GO

-- select top 10 * from RainmakerLDCJP_OAT.dbo.RM_KPI_Collection_Node
