-- ------------------------------------------------------------------------------
--		       Author	 : FIS - JPD
--		       Time-stamp: "2021-03-01 06:52:00 jpdur"
-- ------------------------------------------------------------------------------

-- INSERT [dbo].[RM_ClassType] ([Id], [Name]) VALUES (N'fdb21d5b-dc8b-42c0-a555-9b62f9b22dc6', N'User Defined')
-- INSERT [dbo].[RM_ClassType] ([Id], [Name]) VALUES (N'3306b822-bd96-43c6-9afc-be78fa763c8e', N'Forecast')
-- INSERT [dbo].[RM_ClassType] ([Id], [Name]) VALUES (N'3e426637-f13d-4a0d-aea9-c84e7b1c28c6', N'Budgets')
-- INSERT [dbo].[RM_ClassType] ([Id], [Name]) VALUES (N'e95b7ac1-7145-4cd9-a978-d47011f8b333', N'Actuals')

merge into RM_ClassType target using (
-- INSERT [dbo].[RM_ClassType] ([Id], [Name]) VALUES (N'fdb21d5b-dc8b-42c0-a555-9b62f9b22dc6', N'User Defined')
select 'fdb21d5b-dc8b-42c0-a555-9b62f9b22dc6' as ID, 'User Defined' as Name
) x on x.ID = Target.ID when NOT MATCHED THEN INSERT ([Id], [Name]) VALUES (x.ID,x.Name) ;
merge into RM_ClassType target using (
-- INSERT [dbo].[RM_ClassType] ([Id], [Name]) VALUES (N'3306b822-bd96-43c6-9afc-be78fa763c8e', N'Forecast')
select '3306b822-bd96-43c6-9afc-be78fa763c8e' as ID, 'Forecast' as Name
) x on x.ID = Target.ID when NOT MATCHED THEN INSERT ([Id], [Name]) VALUES (x.ID,x.Name) ;
merge into RM_ClassType target using (
-- INSERT [dbo].[RM_ClassType] ([Id], [Name]) VALUES (N'3e426637-f13d-4a0d-aea9-c84e7b1c28c6', N'Budgets')
select '3e426637-f13d-4a0d-aea9-c84e7b1c28c6' as ID, 'Budgets' as Name
) x on x.ID = Target.ID when NOT MATCHED THEN INSERT ([Id], [Name]) VALUES (x.ID,x.Name) ;
merge into RM_ClassType target using (
-- INSERT [dbo].[RM_ClassType] ([Id], [Name]) VALUES (N'e95b7ac1-7145-4cd9-a978-d47011f8b333', N'Actuals')
select 'e95b7ac1-7145-4cd9-a978-d47011f8b333' as ID, 'Actuals' as Name
) x on x.ID = Target.ID when NOT MATCHED THEN INSERT ([Id], [Name]) VALUES (x.ID,x.Name) ;

-- GO

-- INSERT [dbo].[RMX_BatchStatus] ([Id], [Name]) VALUES (N'eb13337a-e51c-4157-aca7-1b2a6a317161', N'Held')
-- INSERT [dbo].[RMX_BatchStatus] ([Id], [Name]) VALUES (N'8b710373-e236-454c-994d-1f5fb5251458', N'Posted')
-- INSERT [dbo].[RMX_BatchStatus] ([Id], [Name]) VALUES (N'6757f7bf-ca44-419f-96a5-e1f91bd23c2a', N'Draft')

merge into RMX_BatchStatus target using (
-- INSERT [dbo].[RMX_BatchStatus] ([Id], [Name]) VALUES (N'eb13337a-e51c-4157-aca7-1b2a6a317161', N'Held')
select 'eb13337a-e51c-4157-aca7-1b2a6a317161' as ID, 'Held' as Name
) x on x.ID = Target.ID when NOT MATCHED THEN INSERT ([Id], [Name]) VALUES (x.ID,x.Name) ;
merge into RMX_BatchStatus target using (
-- INSERT [dbo].[RMX_BatchStatus] ([Id], [Name]) VALUES (N'8b710373-e236-454c-994d-1f5fb5251458', N'Posted')
select '8b710373-e236-454c-994d-1f5fb5251458' as ID, 'Posted' as Name
) x on x.ID = Target.ID when NOT MATCHED THEN INSERT ([Id], [Name]) VALUES (x.ID,x.Name) ;
merge into RMX_BatchStatus target using (
-- INSERT [dbo].[RMX_BatchStatus] ([Id], [Name]) VALUES (N'6757f7bf-ca44-419f-96a5-e1f91bd23c2a', N'Draft')
select '6757f7bf-ca44-419f-96a5-e1f91bd23c2a' as ID, 'Draft' as Name
) x on x.ID = Target.ID when NOT MATCHED THEN INSERT ([Id], [Name]) VALUES (x.ID,x.Name) ;

-- GO
-- INSERT [dbo].[RMX_CollectionPeriod] ([Id], [Name], [ShortName]) VALUES (N'1c430f5b-7fc2-4e52-8180-78bb83aa5fdf', N'Yearly', NULL)
-- INSERT [dbo].[RMX_CollectionPeriod] ([Id], [Name], [ShortName]) VALUES (N'ab4a8b0c-11c0-4309-851f-adeeda0029c2', N'6 Months (Bi-Annual)', NULL)
-- INSERT [dbo].[RMX_CollectionPeriod] ([Id], [Name], [ShortName]) VALUES (N'9f7cbe1e-16e8-4842-bea3-b1b910745ac7', N'Monthly', NULL)
-- INSERT [dbo].[RMX_CollectionPeriod] ([Id], [Name], [ShortName]) VALUES (N'85bad1c7-210b-4a7e-9dae-ca2b62e6a996', N'Quarterly', NULL)

merge into RMX_CollectionPeriod Target using (
--INSERT [dbo].[RMX_CollectionPeriod] ([Id], [Name], [ShortName]) VALUES (N'1c430f5b-7fc2-4e52-8180-78bb83aa5fdf', N'Yearly', NULL)
select '1c430f5b-7fc2-4e52-8180-78bb83aa5fdf' as ID, 'Yearly' as Name, NULL as ShortName
) x on x.ID = Target.ID when NOT MATCHED THEN INSERT ([Id], [Name], [ShortName]) VALUES (x.ID,x.Name,x.ShortName) ;
merge into RMX_CollectionPeriod Target using (
--INSERT [dbo].[RMX_CollectionPeriod] ([Id], [Name], [ShortName]) VALUES (N'ab4a8b0c-11c0-4309-851f-adeeda0029c2', N'6 Months (Bi-Annual)', NULL)
select 'ab4a8b0c-11c0-4309-851f-adeeda0029c2' as ID, '6 Months (Bi-Annual)' as Name, NULL as ShortName
) x on x.ID = Target.ID when NOT MATCHED THEN INSERT ([Id], [Name], [ShortName]) VALUES (x.ID,x.Name,x.ShortName) ;
merge into RMX_CollectionPeriod Target using (
--INSERT [dbo].[RMX_CollectionPeriod] ([Id], [Name], [ShortName]) VALUES (N'9f7cbe1e-16e8-4842-bea3-b1b910745ac7', N'Monthly', NULL)
select '9f7cbe1e-16e8-4842-bea3-b1b910745ac7' as ID, 'Monthly' as Name, NULL as ShortName
) x on x.ID = Target.ID when NOT MATCHED THEN INSERT ([Id], [Name], [ShortName]) VALUES (x.ID,x.Name,x.ShortName) ;
merge into RMX_CollectionPeriod Target using (
--INSERT [dbo].[RMX_CollectionPeriod] ([Id], [Name], [ShortName]) VALUES (N'85bad1c7-210b-4a7e-9dae-ca2b62e6a996', N'Quarterly', NULL)
select '85bad1c7-210b-4a7e-9dae-ca2b62e6a996' as ID, 'Quarterly' as Name, NULL as ShortName
) x on x.ID = Target.ID when NOT MATCHED THEN INSERT ([Id], [Name], [ShortName]) VALUES (x.ID,x.Name,x.ShortName) ;

-- GO
-- INSERT [dbo].[RMX_CollectionRecurrence] ([Id], [Name]) VALUES (N'324a62e0-7d6a-420e-8d79-43e4f2a303b0', N'End After X periods')
-- INSERT [dbo].[RMX_CollectionRecurrence] ([Id], [Name]) VALUES (N'6e9078be-9e13-43bb-817d-57f6768a6d15', N'2 Years')
-- INSERT [dbo].[RMX_CollectionRecurrence] ([Id], [Name]) VALUES (N'084d4bff-a548-4860-945d-940f00a81f7c', N'1 Year')
-- GO
-- INSERT [dbo].[RMX_KpiCategory] ([Id], [Name]) VALUES (N'f2a1f6d6-0433-4c25-85fb-11d6a73de64f', N'Financials')
-- INSERT [dbo].[RMX_KpiCategory] ([Id], [Name]) VALUES (N'c4f68c58-d02e-49d3-8546-5a2f74651e88', N'All Financials')
-- INSERT [dbo].[RMX_KpiCategory] ([Id], [Name]) VALUES (N'b7f59c1a-6f52-462f-b034-f50a85bdfdb8', N'Non Financials')

merge into RMX_KpiCategory target using (
-- INSERT [dbo].[RMX_KpiCategory] ([Id], [Name]) VALUES (N'f2a1f6d6-0433-4c25-85fb-11d6a73de64f', N'Financials')
select 'f2a1f6d6-0433-4c25-85fb-11d6a73de64f' as ID, 'Financials' as Name
) x on x.ID = Target.ID when NOT MATCHED THEN INSERT VALUES (x.ID,x.Name) ;
merge into RMX_KpiCategory target using (
-- INSERT [dbo].[RMX_KpiCategory] ([Id], [Name]) VALUES (N'c4f68c58-d02e-49d3-8546-5a2f74651e88', N'All Financials')
select 'c4f68c58-d02e-49d3-8546-5a2f74651e88' as ID, 'All Financials' as Name
) x on x.ID = Target.ID when NOT MATCHED THEN INSERT VALUES (x.ID,x.Name) ;
merge into RMX_KpiCategory target using (
-- INSERT [dbo].[RMX_KpiCategory] ([Id], [Name]) VALUES (N'b7f59c1a-6f52-462f-b034-f50a85bdfdb8', N'Non Financials')
select 'b7f59c1a-6f52-462f-b034-f50a85bdfdb8' as ID, 'Non Financials' as Name
) x on x.ID = Target.ID when NOT MATCHED THEN INSERT VALUES (x.ID,x.Name) ;


-- GO
-- INSERT [dbo].[RMX_KpiType] ([Id], [Name], [IsFinancial], [IsTemplate]) VALUES (N'85b6085c-698d-4834-bed7-585cd0f53452', N'Non-Financials', 0, 0)
-- INSERT [dbo].[RMX_KpiType] ([Id], [Name], [IsFinancial], [IsTemplate]) VALUES (N'268a3f58-5a12-42d7-bcf2-620fdda6b532', N'Non-Financial KPIS', 0, 1)
-- INSERT [dbo].[RMX_KpiType] ([Id], [Name], [IsFinancial], [IsTemplate]) VALUES (N'0f39aa09-efe5-4524-b1da-7169e2e11e6d', N'Balance Sheet', 1, 1)
-- INSERT [dbo].[RMX_KpiType] ([Id], [Name], [IsFinancial], [IsTemplate]) VALUES (N'5ff41e39-363f-4fb5-a51e-f423dbc15469', N'Other Financial KPIS', 1, 1)
-- INSERT [dbo].[RMX_KpiType] ([Id], [Name], [IsFinancial], [IsTemplate]) VALUES (N'192cec9c-780a-4e82-aa50-fa07eaceb306', N'Financials', 1, 0)
-- INSERT [dbo].[RMX_KpiType] ([Id], [Name], [IsFinancial], [IsTemplate]) VALUES (N'3a526188-bf41-4e0d-ac80-fb156ba76a01', N'Income Statement', 1, 1)
-- INSERT [dbo].[RMX_KpiType] ([Id], [Name], [IsFinancial], [IsTemplate]) VALUES (N'646a9649-0e42-4442-8aa0-fd1d8cce117e', N'Cashflows', 1, 1)
-- GO
-- INSERT [dbo].[RMX_ValueType] ([Id], [Name]) VALUES (N'73c5c9e0-cda8-46a8-8ea3-10b87ef5df66', N'Percent')
-- INSERT [dbo].[RMX_ValueType] ([Id], [Name]) VALUES (N'02bbae47-2a1b-44d9-9102-97686b752484', N'Ratio')
-- INSERT [dbo].[RMX_ValueType] ([Id], [Name]) VALUES (N'b0d6e33c-762b-4998-be11-d159e348bba3', N'Numeric')
-- GO
-- INSERT [dbo].[RMX_WorkflowStatus] ([Id], [Name]) VALUES (N'6e295556-f14f-493d-b810-2e0c558ea5da', N'Not Started')
-- INSERT [dbo].[RMX_WorkflowStatus] ([Id], [Name]) VALUES (N'81400d58-72f3-4597-990a-58e389520395', N'Pending Review')
-- INSERT [dbo].[RMX_WorkflowStatus] ([Id], [Name]) VALUES (N'827d965f-07a9-43f6-a709-90a7cb3ee52f', N'Approved')
-- INSERT [dbo].[RMX_WorkflowStatus] ([Id], [Name]) VALUES (N'08a3deeb-a561-4168-aff9-9430eef198f9', N'In Progress')
-- INSERT [dbo].[RMX_WorkflowStatus] ([Id], [Name]) VALUES (N'4cb629ed-f626-40f0-97d9-9d8ca7c5d710', N'Abandoned')
-- INSERT [dbo].[RMX_WorkflowStatus] ([Id], [Name]) VALUES (N'cb324289-8cb3-423b-a882-b908730c1834', N'Rejected')
-- GO
