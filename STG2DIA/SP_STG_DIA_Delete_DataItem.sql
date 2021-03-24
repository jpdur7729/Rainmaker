-- ------------------------------------------------------------------------------
--                     Author    : FIS - JPD
--                     Time-stamp: "2021-02-27 09:09:07 jpdur"
-- ------------------------------------------------------------------------------

-- Run as usual from the STG database

CREATE or ALTER PROCEDURE [dbo].[STG_DIA_Delete_DataItem_ID] ( @DataItemID as varchar(36) )
as
BEGIN


-- Last tables to cleanup are the places where the DataItem was defined
-- Dim is nothing more than a presentation of the data
delete from RainmakerLDCJP_OAT.dbo.Dim_RM_DataItem where DataItemID = @DataItemID
delete from RainmakerLDCJP_OAT.dbo.RM_DataItem where ID = @DataItemID

-- ColumnName	ColumnValue
-- [dbo].[Dim_RM_DataItem].[DataItemId]	59CCA678-AC9D-415D-9A4E-11700005B1BB
-- [dbo].[RM_DataItem].[Id]	59CCA678-AC9D-415D-9A4E-11700005B1BB

END
GO


-- EXEC STG_DIA_Delete_DataItem_ID '59CCA678-AC9D-415D-9A4E-11700005B1BB'
 --EXEC STG_DIA_Delete_DataItem_ID '01407907-8EA3-4B30-8FB0-14FF941D6B99'
 --EXEC STG_DIA_Delete_DataItem_ID '4A3BE206-C3CA-4AEB-B4CE-17C75E934F1A'
 --EXEC STG_DIA_Delete_DataItem_ID 'D51385BD-E93E-4095-BB2D-1B9C53931382'
 --EXEC STG_DIA_Delete_DataItem_ID '7174E00B-CD5B-497A-91BB-1EE9A86F5173'
 --EXEC STG_DIA_Delete_DataItem_ID '18095AD4-7511-41F7-8F0C-25BE66E4111C'
 --EXEC STG_DIA_Delete_DataItem_ID '7892C21C-029C-4E65-8119-3339139FD502'
 --EXEC STG_DIA_Delete_DataItem_ID 'E5EED9A4-09D7-4FF2-BF64-4587E1EF82AB'
 --EXEC STG_DIA_Delete_DataItem_ID '02DA2B3A-3AF6-4FE9-9D66-4BEC349C83E9'
 --EXEC STG_DIA_Delete_DataItem_ID '3752B1FD-C0E0-4694-BA8F-5D789EF8028F'
 --EXEC STG_DIA_Delete_DataItem_ID '1A5E5065-F557-44BF-AE6C-682856FDF476'
 --EXEC STG_DIA_Delete_DataItem_ID 'C83A9C8B-CFF9-4330-8EFE-762300D49BE4'
 --EXEC STG_DIA_Delete_DataItem_ID '13035BD9-8C1A-4203-9FA5-7829F8D461F9'
 --EXEC STG_DIA_Delete_DataItem_ID 'C3346853-8110-4DE7-90C7-81A89739C2D4'
 --EXEC STG_DIA_Delete_DataItem_ID '61E3462A-CCE2-447F-8C6A-83EA7C9406BA'
 --EXEC STG_DIA_Delete_DataItem_ID '786DFC07-32DF-478F-935F-88B4DA50673B'
 --EXEC STG_DIA_Delete_DataItem_ID 'B5E015C9-1B7A-42D5-9C1F-9AE4772F3CEF'
 --EXEC STG_DIA_Delete_DataItem_ID 'CB8B3E39-9828-4BE4-B4EE-9EF3399E45C5'
 --EXEC STG_DIA_Delete_DataItem_ID '67876DC2-D178-4270-9402-A250FBF9CBC1'
 --EXEC STG_DIA_Delete_DataItem_ID 'C4B0866E-21CC-4E61-B8CD-C83618B8E283'
 --EXEC STG_DIA_Delete_DataItem_ID '3F5FC4D3-8A86-45B9-B37D-D1BD5FA65658'
 --EXEC STG_DIA_Delete_DataItem_ID '51662B50-8693-467E-94A9-F35056EDD68F'
