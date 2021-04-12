-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-04-07 07:04:38 jpdur"
-- ------------------------------------------------------------------------------

-- Recusively builds a Genealogical string for any node
-- It relies on the View NodeListView
CREATE or ALTER FUNCTION [dbo].[PS_UniqueTreeName] (@RefNodeID as varchar(36))
RETURNS varchar(1000)
BEGIN

	declare @TreeString as varchar(1000)

	if ((@RefNodeID is null) or (EXISTS(select * from HierarchyList where ID = @RefNodeID)))
	begin
		-- We stop nothing to return but we could return the name of the Hierarchy 
		return ''
	end
	
	-- Extract the name 
	select @TreeString = Name from NodeListView where NodeDefID = @RefNodeID

	-- Concatenate with the string corresponding to parent in a very similar way to directories
	return dbo.PS_UniqueTreeName((select ParentNodeDefID from Hierarchies where NodeDefID = @RefNodeID))+'/'+@TreeString

END
GO


