-- ------------------------------------------------------------------------------
--                     Author    : F2 - JPD
--                     Time-stamp: "2021-02-15 15:03:01 jpdur"
-- ------------------------------------------------------------------------------

-- Populate with TestData the definition of Data Points

-- Definition of 3 high level hierarchies
insert into HierarchyList values (NEWID(),'JPDUR',getdate(),getdate(),'Balance Sheet')
insert into HierarchyList values (NEWID(),'JPDUR',getdate(),getdate(),'Income Statement')
insert into HierarchyList values (NEWID(),'JPDUR',getdate(),getdate(),'Profit Loss')
select Name from HierarchyList

-- Definition of 3 Industries
insert into IndustryList values (NEWID(),'JPDUR',getdate(),getdate(),'Industry 1')
insert into IndustryList values (NEWID(),'JPDUR',getdate(),getdate(),'Industry 2')
insert into IndustryList values (NEWID(),'JPDUR',getdate(),getdate(),'Industry 3')
select Name from IndustryList

-- Definition of 3 Companies
insert into CompanyList values (NEWID(),'JPDUR',getdate(),getdate(),'SaasCo',(select ID From IndustryList where Name = 'Industry 1'))
insert into CompanyList values (NEWID(),'JPDUR',getdate(),getdate(),'TechCo',(select ID From IndustryList where Name = 'Industry 2'))
insert into CompanyList values (NEWID(),'JPDUR',getdate(),getdate(),'TestCo',(select ID From IndustryList where Name = 'Industry 3'))
select Name from CompanyList

