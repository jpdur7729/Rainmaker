-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-27 09:09:07 jpdur"
-- ------------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_RM_NodeIndustryAssociation] ( @IndustryName as varchar(100) )
as
BEGIN

      declare @IndustryID as nvarchar(36)
      declare @KPIIndustryTemplateID as varchar(36)
      set @IndustryID  = (select ID from IndustryList where Name = @IndustryName )
      set @KPIIndustryTemplateID  = (select ID from RM_KPIIndustryTemplate where IndustryID = @IndustryID )

      -- We add the nodes from RM_Node associated to the instrustry
      merge into RM_NodeIndustryAssociation RM_NIA
      using (
      	    Select RM_NODE_ID as NodeId,@KPIIndustryTemplateID as KPIIndustryTemplateID,
	    	   Name as NodeAlias,1 as Weight,SortOrder as Sequence 
			   from NodeDefIndustry 
			   where IndustryId = @IndustryID
	  ) x
      on
      x.NodeID = RM_NIA.NodeId
      when NOT MATCHED THEN
          INSERT (NodeId,KPIIndustryTemplateId,NodeAlias,Weight,Sequence)
	  VALUES(x.NodeID,x.KPIIndustryTemplateId,x.NodeAlias,x.Weight,x.Sequence);

END
GO

