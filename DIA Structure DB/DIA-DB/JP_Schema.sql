--USE [RainmakerLDCJP_OAT]
--GO
/****** Object:  Table [dbo].[RM_Attribute]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_Attribute](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](150) NULL,
	[AttributeGroupId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_RM_Attribute] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_AttributeGroup]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_AttributeGroup](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](150) NULL,
	[IsConfirmed] [bit] NOT NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [datetime2](7) NOT NULL,
	[IsSystemDefined] [bit] NOT NULL,
 CONSTRAINT [PK_RM_AttributeGroup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_AttributeGroupIndustryAssociation]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_AttributeGroupIndustryAssociation](
	[Id] [uniqueidentifier] NOT NULL,
	[AttributeGroupId] [uniqueidentifier] NOT NULL,
	[IndustryId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_RM_AttributeGroupIndustryAssociation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_Audit]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_Audit](
	[Id] [uniqueidentifier] NOT NULL,
	[RecordId] [uniqueidentifier] NULL,
	[Screen] [int] NOT NULL,
	[Action] [int] NOT NULL,
	[Field] [int] NOT NULL,
	[OldValue] [nvarchar](max) NULL,
	[NewValue] [nvarchar](max) NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_RM_Audit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_BI_KPI_Batch]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_BI_KPI_Batch](
	[FactId] [int] IDENTITY(1,1) NOT NULL,
	[BatchId] [uniqueidentifier] NOT NULL,
	[BatchStatusID] [uniqueidentifier] NOT NULL,
	[BatchStatus] [nvarchar](50) NULL,
	[KpiTypeId] [uniqueidentifier] NOT NULL,
	[KpiType] [nvarchar](50) NULL,
	[KPICollectionNodeId] [uniqueidentifier] NOT NULL,
	[DataItemID] [uniqueidentifier] NULL,
	[DataItem] [nvarchar](150) NULL,
	[CompanyID] [uniqueidentifier] NULL,
	[CurrencyID] [nvarchar](10) NULL,
	[GLDate] [datetime2](7) NOT NULL,
	[EffectiveDate] [datetime2](7) NOT NULL,
	[Amount] [decimal](28, 12) NULL,
	[Percentage] [decimal](28, 12) NULL,
	[Ratio] [decimal](28, 12) NULL,
	[RM_Scenario] [nvarchar](255) NULL,
	[RM_TimePeriod] [nvarchar](255) NULL,
	[RM_Geography] [nvarchar](255) NULL,
	[RM_Sector] [nvarchar](255) NULL,
	[RM_Dimension_01] [nvarchar](255) NULL,
	[RM_Dimension_02] [nvarchar](255) NULL,
	[RM_Dimension_03] [nvarchar](255) NULL,
	[RM_Dimension_04] [nvarchar](255) NULL,
	[RM_Dimension_05] [nvarchar](255) NULL,
	[RM_Dimension_06] [nvarchar](255) NULL,
	[RM_Dimension_07] [nvarchar](255) NULL,
	[RM_Dimension_08] [nvarchar](255) NULL,
	[RM_Dimension_09] [nvarchar](255) NULL,
	[RM_Dimension_10] [nvarchar](255) NULL,
	[DimensionSequence] [int] NULL,
	[ProcessedDate] [datetime] NULL,
	[AsOfDate] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_BI_KPI_Pivot]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_BI_KPI_Pivot](
	[BatchId] [uniqueidentifier] NOT NULL,
	[BatchStatusID] [uniqueidentifier] NOT NULL,
	[BatchStatus] [nvarchar](50) NULL,
	[KpiTypeId] [uniqueidentifier] NOT NULL,
	[KpiType] [nvarchar](50) NULL,
	[CompanyID] [uniqueidentifier] NULL,
	[CurrencyID] [nvarchar](10) NULL,
	[GLDate] [datetime2](7) NOT NULL,
	[EffectiveDate] [datetime2](7) NOT NULL,
	[RM_Scenario] [nvarchar](255) NULL,
	[RM_TimePeriod] [nvarchar](255) NULL,
	[RM_Geography] [nvarchar](255) NULL,
	[RM_Sector] [nvarchar](255) NULL,
	[RM_Dimension_01] [nvarchar](255) NULL,
	[RM_Dimension_02] [nvarchar](255) NULL,
	[RM_Dimension_03] [nvarchar](255) NULL,
	[RM_Dimension_04] [nvarchar](255) NULL,
	[RM_Dimension_05] [nvarchar](255) NULL,
	[RM_Dimension_06] [nvarchar](255) NULL,
	[RM_Dimension_07] [nvarchar](255) NULL,
	[RM_Dimension_08] [nvarchar](255) NULL,
	[RM_Dimension_09] [nvarchar](255) NULL,
	[RM_Dimension_10] [nvarchar](255) NULL,
	[DimensionSequence] [int] NULL,
	[AsOfDate] [datetime2](7) NULL,
	[Accrued Revenue (Local)] [decimal](28, 12) NULL,
	[Adjusted EBIT (Local)] [decimal](28, 12) NULL,
	[Adjusted EBITDA (Local)] [decimal](28, 12) NULL,
	[Adjusted EBT (Local)] [decimal](28, 12) NULL,
	[Administrative Expense Overheads (Local)] [decimal](28, 12) NULL,
	[Administrative Expenses (Local)] [decimal](28, 12) NULL,
	[Amortization Expenses (Local)] [decimal](28, 12) NULL,
	[Bank & Cash in hand (Local)] [decimal](28, 12) NULL,
	[Bank and Cash on Hand (Local)] [decimal](28, 12) NULL,
	[Beginning Cash Balance Direct Entry (Local)] [decimal](28, 12) NULL,
	[Capex (Local)] [decimal](28, 12) NULL,
	[Capex Project Spend Adjustments (Local)] [decimal](28, 12) NULL,
	[Capex Special Project Spending (Local)] [decimal](28, 12) NULL,
	[Capital Contribution Reserves (Local)] [decimal](28, 12) NULL,
	[Capitalized Expenditures (Local)] [decimal](28, 12) NULL,
	[Cash (Local)] [decimal](28, 12) NULL,
	[COGS (Local)] [decimal](28, 12) NULL,
	[Commitment Fees (Local)] [decimal](28, 12) NULL,
	[Common Equity (Local)] [decimal](28, 12) NULL,
	[Common Stock (Local)] [decimal](28, 12) NULL,
	[Cost of Goods Sold (Local)] [decimal](28, 12) NULL,
	[Current Accounts Payable (Local)] [decimal](28, 12) NULL,
	[Current Accrued Expenses (Local)] [decimal](28, 12) NULL,
	[Current Assets (Local)] [decimal](28, 12) NULL,
	[Current Inventory (Local)] [decimal](28, 12) NULL,
	[Current Liabilities (Local)] [decimal](28, 12) NULL,
	[Current Liability Accruals (Local)] [decimal](28, 12) NULL,
	[Current Year RE Adjustments (Local)] [decimal](28, 12) NULL,
	[Debtors Receivable (Local)] [decimal](28, 12) NULL,
	[Deferred Other Assets (Local)] [decimal](28, 12) NULL,
	[Deferred Taxes (Local)] [decimal](28, 12) NULL,
	[Depreciation and Amortization (Local)] [decimal](28, 12) NULL,
	[Depreciation Expenses (Local)] [decimal](28, 12) NULL,
	[Development Costs (Local)] [decimal](28, 12) NULL,
	[Direct Sales Expense (Local)] [decimal](28, 12) NULL,
	[EBIT (Local)] [decimal](28, 12) NULL,
	[EBITDA (Local)] [decimal](28, 12) NULL,
	[EBT (Local)] [decimal](28, 12) NULL,
	[Ending Cash Balance Direct Entry (Local)] [decimal](28, 12) NULL,
	[F/X Translation Expenses (Local)] [decimal](28, 12) NULL,
	[Financing - Issuing Debt (Local)] [decimal](28, 12) NULL,
	[Financing - Issuing Equity (Local)] [decimal](28, 12) NULL,
	[Financing - Paying Dividends (Local)] [decimal](28, 12) NULL,
	[Financing - Purchase Treasury Stock (Local)] [decimal](28, 12) NULL,
	[Financing - Repayment of Borrowings (Local)] [decimal](28, 12) NULL,
	[Financing Costs (Local)] [decimal](28, 12) NULL,
	[Fixed Assets (Local)] [decimal](28, 12) NULL,
	[Fixed Assets Adjustments (Local)] [decimal](28, 12) NULL,
	[Foreign Exchange (Local)] [decimal](28, 12) NULL,
	[Foreign Exchange Translations (Local)] [decimal](28, 12) NULL,
	[Free Cash Flow (after debt) (Local)] [decimal](28, 12) NULL,
	[Free Cash Flow (before debt) (Local)] [decimal](28, 12) NULL,
	[General Expense Overheads (Local)] [decimal](28, 12) NULL,
	[General Expenses (Local)] [decimal](28, 12) NULL,
	[Goodwill (Local)] [decimal](28, 12) NULL,
	[Hardware Fixed Asset Closing Adjust (Local)] [decimal](28, 12) NULL,
	[Income Statement (Local)] [decimal](28, 12) NULL,
	[Infrastructure Capex Spend (Local)] [decimal](28, 12) NULL,
	[Intangible Asset Adjustments (Local)] [decimal](28, 12) NULL,
	[Intangible Assets (Local)] [decimal](28, 12) NULL,
	[Intercompany Receivables (Local)] [decimal](28, 12) NULL,
	[Interest Expense (Local)] [decimal](28, 12) NULL,
	[Interest Expenses (Local)] [decimal](28, 12) NULL,
	[Interest Expenses Payable (Local)] [decimal](28, 12) NULL,
	[Interests Receivable (Local)] [decimal](28, 12) NULL,
	[Investing - Loan Collections (Local)] [decimal](28, 12) NULL,
	[Investing - Purchase of Assets (Local)] [decimal](28, 12) NULL,
	[Investing - Purchase of Debt (Local)] [decimal](28, 12) NULL,
	[Investing - Purchase of Equity (Local)] [decimal](28, 12) NULL,
	[Investing - Sales of Assets (Local)] [decimal](28, 12) NULL,
	[Investing - Sales of Debt (Local)] [decimal](28, 12) NULL,
	[Investing - Sales of Equity (Local)] [decimal](28, 12) NULL,
	[Lease Asset Adjustments (Local)] [decimal](28, 12) NULL,
	[Lease Assets (Local)] [decimal](28, 12) NULL,
	[Long Term Asset Adjustments (Local)] [decimal](28, 12) NULL,
	[Long Term Credit Facility Notes (Local)] [decimal](28, 12) NULL,
	[Long Term Interest Income (Local)] [decimal](28, 12) NULL,
	[Long Term Investment Accretions (Local)] [decimal](28, 12) NULL,
	[Long Term Investment Adjustments (Local)] [decimal](28, 12) NULL,
	[Long Term Investment Purchases (Local)] [decimal](28, 12) NULL,
	[Long Term Liabilities (Local)] [decimal](28, 12) NULL,
	[Long Term Note Income (Local)] [decimal](28, 12) NULL,
	[LT Credit Facility Note Borrowings (Local)] [decimal](28, 12) NULL,
	[LT Credit Facility Note Repayments (Local)] [decimal](28, 12) NULL,
	[LT Note Income (Local)] [decimal](28, 12) NULL,
	[Net Assets (Local)] [decimal](28, 12) NULL,
	[Net Profit from Sales (Local)] [decimal](28, 12) NULL,
	[Non-Current Assets (Local)] [decimal](28, 12) NULL,
	[Non-Recurring Revenues (Local)] [decimal](28, 12) NULL,
	[Notes Payable (Local)] [decimal](28, 12) NULL,
	[Offset Incomes (Local)] [decimal](28, 12) NULL,
	[Operating - Collections (Local)] [decimal](28, 12) NULL,
	[Operating - Dividends (Local)] [decimal](28, 12) NULL,
	[Operating - Interest Income (Local)] [decimal](28, 12) NULL,
	[Operating - Other Operating Receipt (Local)] [decimal](28, 12) NULL,
	[Operating - Other Payments (Local)] [decimal](28, 12) NULL,
	[Operating - Payment of Taxes (Local)] [decimal](28, 12) NULL,
	[Operating - Payments of Interest (Local)] [decimal](28, 12) NULL,
	[Operating - Payments to Employees (Local)] [decimal](28, 12) NULL,
	[Operating - Payments to Suppliers (Local)] [decimal](28, 12) NULL,
	[Other Accounts Receivable (Local)] [decimal](28, 12) NULL,
	[Other Assets (Local)] [decimal](28, 12) NULL,
	[Other Capex Expenditures (Local)] [decimal](28, 12) NULL,
	[Other Comprehensive Income (Local)] [decimal](28, 12) NULL,
	[Other Equity (Local)] [decimal](28, 12) NULL,
	[Other Expense Overheads (Local)] [decimal](28, 12) NULL,
	[Other Expenses (Local)] [decimal](28, 12) NULL,
	[Other Expenses Payable (Local)] [decimal](28, 12) NULL,
	[Other Fee Income (Local)] [decimal](28, 12) NULL,
	[Other Income (Local)] [decimal](28, 12) NULL,
	[Other Interest Expense Adjustments (Local)] [decimal](28, 12) NULL,
	[Other Interest Expenses (Local)] [decimal](28, 12) NULL,
	[Other Long Term Obligations (Local)] [decimal](28, 12) NULL,
	[Other LT Obligations (Local)] [decimal](28, 12) NULL,
	[Other Offset Income (Local)] [decimal](28, 12) NULL,
	[Other Reserves (Local)] [decimal](28, 12) NULL,
	[Overhead Expenses (Local)] [decimal](28, 12) NULL,
	[Overheads (Local)] [decimal](28, 12) NULL,
	[Owners Equity (Local)] [decimal](28, 12) NULL,
	[Paid in Capital Common Stock (Local)] [decimal](28, 12) NULL,
	[Paid in Capital Preferred Stock (Local)] [decimal](28, 12) NULL,
	[Preferred Equity (Local)] [decimal](28, 12) NULL,
	[Preferred Stock (Local)] [decimal](28, 12) NULL,
	[Prepaid Expenses (Local)] [decimal](28, 12) NULL,
	[Product Subscriptions (Local)] [decimal](28, 12) NULL,
	[PY RE Brought Forward (Local)] [decimal](28, 12) NULL,
	[Realized F/X Gain or Loss (Local)] [decimal](28, 12) NULL,
	[Realized Gain or Loss (Local)] [decimal](28, 12) NULL,
	[Realized Gain or Loss on Investments (Local)] [decimal](28, 12) NULL,
	[Realized Investment Gain or Loss (Local)] [decimal](28, 12) NULL,
	[Recurring Revenues (Local)] [decimal](28, 12) NULL,
	[Reserves (Local)] [decimal](28, 12) NULL,
	[Retained Earnings (Local)] [decimal](28, 12) NULL,
	[Revenues (Local)] [decimal](28, 12) NULL,
	[Revenues net of COGS (Local)] [decimal](28, 12) NULL,
	[Sales Expenses (Local)] [decimal](28, 12) NULL,
	[Sales Revenue (Local)] [decimal](28, 12) NULL,
	[Sales Revenue Receivable (Local)] [decimal](28, 12) NULL,
	[Service Contracts (Local)] [decimal](28, 12) NULL,
	[SG&A (Local)] [decimal](28, 12) NULL,
	[SG&A Other Cost of Sales (Local)] [decimal](28, 12) NULL,
	[SG&A Other Costs (Local)] [decimal](28, 12) NULL,
	[Short Term Interest Income (Local)] [decimal](28, 12) NULL,
	[Short Term Stock Investments (Local)] [decimal](28, 12) NULL,
	[ST Dividend Income (Local)] [decimal](28, 12) NULL,
	[ST Dividend Income - Brokerage (Local)] [decimal](28, 12) NULL,
	[ST Interest Income (Local)] [decimal](28, 12) NULL,
	[ST Interest Income - Bank Balances (Local)] [decimal](28, 12) NULL,
	[Tangible Asset Adjustments (Local)] [decimal](28, 12) NULL,
	[Tangible Assets (Local)] [decimal](28, 12) NULL,
	[Tax Expenses (Local)] [decimal](28, 12) NULL,
	[Taxes (Local)] [decimal](28, 12) NULL,
	[Total Assets (Local)] [decimal](28, 12) NULL,
	[Total Enterprise Value (Local)] [decimal](28, 12) NULL,
	[Total Equity (Local)] [decimal](28, 12) NULL,
	[Total Expenses (Local)] [decimal](28, 12) NULL,
	[Total Liabilities (Local)] [decimal](28, 12) NULL,
	[Total Net Debt (Local)] [decimal](28, 12) NULL,
	[Total Revenue (Local)] [decimal](28, 12) NULL,
	[Total Revenues (Local)] [decimal](28, 12) NULL,
	[Trading Working Capital (Local)] [decimal](28, 12) NULL,
	[Translation Difference (Local)] [decimal](28, 12) NULL,
	[Unrealized F/X Gain or Loss (Local)] [decimal](28, 12) NULL,
	[Unrealized Gain or Loss (Local)] [decimal](28, 12) NULL,
	[Unrealized Investment Gain or Loss (Local)] [decimal](28, 12) NULL,
	[Unused Line Fees (Local)] [decimal](28, 12) NULL,
	[Variable Cost Expenses (Local)] [decimal](28, 12) NULL,
	[Variable Costs (Local)] [decimal](28, 12) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_BI_Transaction_Pivot]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_BI_Transaction_Pivot](
	[FactId] [int] NOT NULL,
	[BatchStatusID] [int] NOT NULL,
	[LegalEntityID] [int] NOT NULL,
	[SpecDealID] [int] NULL,
	[SpecPositionID] [int] NULL,
	[IssuerID] [int] NULL,
	[SecurityID] [int] NULL,
	[LotID] [int] NULL,
	[CurrencyID] [int] NOT NULL,
	[GLDate] [datetime] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[RM_Scenario] [nvarchar](255) NULL,
	[RM_TimePeriod] [nvarchar](255) NULL,
	[RM_Geography] [nvarchar](255) NULL,
	[RM_Sector] [nvarchar](255) NULL,
	[RM_Dimension_01] [nvarchar](255) NULL,
	[RM_Dimension_02] [nvarchar](255) NULL,
	[RM_Dimension_03] [nvarchar](255) NULL,
	[RM_Dimension_04] [nvarchar](255) NULL,
	[RM_Dimension_05] [nvarchar](255) NULL,
	[RM_Dimension_06] [nvarchar](255) NULL,
	[RM_Dimension_07] [nvarchar](255) NULL,
	[RM_Dimension_08] [nvarchar](255) NULL,
	[RM_Dimension_09] [nvarchar](255) NULL,
	[RM_Dimension_10] [nvarchar](255) NULL,
	[04.01.01.01.01 EBITDA (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.01 EBITDA (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.01 EBITDA (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.02 EBIT (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.02 EBIT (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.02 EBIT (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.03 EBT (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.03 EBT (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.03 EBT (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.04 Adjusted EBITDA (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.04 Adjusted EBITDA (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.04 Adjusted EBITDA (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.05 Adjusted EBIT (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.05 Adjusted EBIT (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.05 Adjusted EBIT (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.06 Adjusted EBT (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.06 Adjusted EBT (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.06 Adjusted EBT (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.07 Revenues net of COGS (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.07 Revenues net of COGS (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.07 Revenues net of COGS (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.08 Total Revenue (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.08 Total Revenue (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.08 Total Revenue (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.09 Net Profit from Sales (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.09 Net Profit from Sales (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.09 Net Profit from Sales (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.10 Total Expenses (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.10 Total Expenses (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.10 Total Expenses (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.11 Total Enterprise Value (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.11 Total Enterprise Value (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.11 Total Enterprise Value (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.12 Total Net Debt (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.12 Total Net Debt (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.12 Total Net Debt (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.13 Total Assets (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.13 Total Assets (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.13 Total Assets (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.14 Net Assets (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.14 Net Assets (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.14 Net Assets (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.15 Cash (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.15 Cash (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.15 Cash (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.15 Net working Capital (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.15 Net working Capital (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.15 Net working Capital (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.16 Net Debt (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.16 Net Debt (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.16 Net Debt (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.16 Total Liabilities (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.16 Total Liabilities (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.16 Total Liabilities (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.17 Equity (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.17 Equity (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.17 Equity (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.17 Total Equity (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.17 Total Equity (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.17 Total Equity (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.18 Owners Equity (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.18 Owners Equity (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.18 Owners Equity (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.19 Minority Interests and Other Assets (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.19 Minority Interests and Other Assets (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.19 Minority Interests and Other Assets (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.20 Gross Interest Expense (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.20 Gross Interest Expense (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.20 Gross Interest Expense (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.21 Book Value of Debt (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.21 Book Value of Debt (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.21 Book Value of Debt (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.22 Total Assets Less Current Liab. (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.22 Total Assets Less Current Liab. (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.22 Total Assets Less Current Liab. (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.23 Cost of Revenue (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.23 Cost of Revenue (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.23 Cost of Revenue (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.24 Free Cash Flow (before debt) (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.24 Free Cash Flow (before debt) (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.24 Free Cash Flow (before debt) (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.25 Free Cash Flow (after debt) (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.25 Free Cash Flow (after debt) (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.25 Free Cash Flow (after debt) (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.01.26 Capex (Local)] [decimal](28, 12) NULL,
	[04.01.01.01.26 Capex (LE)] [decimal](28, 12) NULL,
	[04.01.01.01.26 Capex (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.02.13 Gross Revenue (Local)] [decimal](28, 12) NULL,
	[04.01.01.02.13 Gross Revenue (LE)] [decimal](28, 12) NULL,
	[04.01.01.02.13 Gross Revenue (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.02.14 Net Revenue (Local)] [decimal](28, 12) NULL,
	[04.01.01.02.14 Net Revenue (LE)] [decimal](28, 12) NULL,
	[04.01.01.02.14 Net Revenue (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.02.15 Gross Profit (Local)] [decimal](28, 12) NULL,
	[04.01.01.02.15 Gross Profit (LE)] [decimal](28, 12) NULL,
	[04.01.01.02.15 Gross Profit (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.02.16 EBITDA (Incl. exceptional items) (Local)] [decimal](28, 12) NULL,
	[04.01.01.02.16 EBITDA (Incl. exceptional items) (LE)] [decimal](28, 12) NULL,
	[04.01.01.02.16 EBITDA (Incl. exceptional items) (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.02.17 EBITD (Local)] [decimal](28, 12) NULL,
	[04.01.01.02.17 EBITD (LE)] [decimal](28, 12) NULL,
	[04.01.01.02.17 EBITD (Quantity)] [decimal](28, 12) NULL,
	[04.01.01.02.18 Net Profit (Local)] [decimal](28, 12) NULL,
	[04.01.01.02.18 Net Profit (LE)] [decimal](28, 12) NULL,
	[04.01.01.02.18 Net Profit (Quantity)] [decimal](28, 12) NULL,
	[04.01.02.01.01 Agency Revenue by Geography (Local)] [decimal](28, 12) NULL,
	[04.01.02.01.01 Agency Revenue by Geography (LE)] [decimal](28, 12) NULL,
	[04.01.02.01.01 Agency Revenue by Geography (Quantity)] [decimal](28, 12) NULL,
	[04.01.02.01.02 Pipeline - Meeting / RFP (Local)] [decimal](28, 12) NULL,
	[04.01.02.01.02 Pipeline - Meeting / RFP (LE)] [decimal](28, 12) NULL,
	[04.01.02.01.02 Pipeline - Meeting / RFP (Quantity)] [decimal](28, 12) NULL,
	[04.01.02.01.03 Pipeline - Pitch (Local)] [decimal](28, 12) NULL,
	[04.01.02.01.03 Pipeline - Pitch (LE)] [decimal](28, 12) NULL,
	[04.01.02.01.03 Pipeline - Pitch (Quantity)] [decimal](28, 12) NULL,
	[04.01.02.01.04 Pipeline - Pitched (Local)] [decimal](28, 12) NULL,
	[04.01.02.01.04 Pipeline - Pitched (LE)] [decimal](28, 12) NULL,
	[04.01.02.01.04 Pipeline - Pitched (Quantity)] [decimal](28, 12) NULL,
	[04.01.02.01.05 Pipeline - Contract Out (Local)] [decimal](28, 12) NULL,
	[04.01.02.01.05 Pipeline - Contract Out (LE)] [decimal](28, 12) NULL,
	[04.01.02.01.05 Pipeline - Contract Out (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.01 Debt Maturity (fiscal-year 1) (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.01 Debt Maturity (fiscal-year 1) (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.01 Debt Maturity (fiscal-year 1) (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.02 Debt Maturity (fiscal-year 2) (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.02 Debt Maturity (fiscal-year 2) (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.02 Debt Maturity (fiscal-year 2) (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.03 Debt Maturity (fiscal-year 3) (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.03 Debt Maturity (fiscal-year 3) (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.03 Debt Maturity (fiscal-year 3) (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.04 Debt Maturity (fiscal-year 4) (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.04 Debt Maturity (fiscal-year 4) (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.04 Debt Maturity (fiscal-year 4) (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.05 Debt Maturity (fiscal-year 5) (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.05 Debt Maturity (fiscal-year 5) (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.05 Debt Maturity (fiscal-year 5) (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.06 Book Value of Debt (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.06 Book Value of Debt (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.06 Book Value of Debt (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.07 Debt Recoursed to Fund (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.07 Debt Recoursed to Fund (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.07 Debt Recoursed to Fund (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.08 Enterprise Value of M&A Trx (Net) (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.08 Enterprise Value of M&A Trx (Net) (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.08 Enterprise Value of M&A Trx (Net) (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.09 Free Cash Flow (after debt service) (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.09 Free Cash Flow (after debt service) (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.09 Free Cash Flow (after debt service) (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.10 Free Cash Flow (before debt serv.) (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.10 Free Cash Flow (before debt serv.) (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.10 Free Cash Flow (before debt serv.) (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.11 Interest Coverage Ratio (TTM) (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.11 Interest Coverage Ratio (TTM) (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.11 Interest Coverage Ratio (TTM) (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.12 Management Ownership % (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.12 Management Ownership % (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.12 Management Ownership % (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.13 Number of Employees (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.13 Number of Employees (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.13 Number of Employees (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.14 Number of Employees (exited only) (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.14 Number of Employees (exited only) (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.14 Number of Employees (exited only) (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.15 Number of M&A Transactions (net) (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.15 Number of M&A Transactions (net) (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.15 Number of M&A Transactions (net) (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.16 Number of Board Seats (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.16 Number of Board Seats (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.16 Number of Board Seats (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.17 Capex % of Sales (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.17 Capex % of Sales (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.17 Capex % of Sales (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.18 EBITDA Margin % (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.18 EBITDA Margin % (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.18 EBITDA Margin % (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.19 Gross Margin % (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.19 Gross Margin % (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.19 Gross Margin % (Quantity)] [decimal](28, 12) NULL,
	[04.02.01.01.20 Operating Margin % (Local)] [decimal](28, 12) NULL,
	[04.02.01.01.20 Operating Margin % (LE)] [decimal](28, 12) NULL,
	[04.02.01.01.20 Operating Margin % (Quantity)] [decimal](28, 12) NULL,
	[04.02.02.01.01 Internal staff client hours (Local)] [decimal](28, 12) NULL,
	[04.02.02.01.01 Internal staff client hours (LE)] [decimal](28, 12) NULL,
	[04.02.02.01.01 Internal staff client hours (Quantity)] [decimal](28, 12) NULL,
	[04.02.02.01.02 Croudie hours (Local)] [decimal](28, 12) NULL,
	[04.02.02.01.02 Croudie hours (LE)] [decimal](28, 12) NULL,
	[04.02.02.01.02 Croudie hours (Quantity)] [decimal](28, 12) NULL,
	[04.02.02.01.03 Agency operations headcount (Local)] [decimal](28, 12) NULL,
	[04.02.02.01.03 Agency operations headcount (LE)] [decimal](28, 12) NULL,
	[04.02.02.01.03 Agency operations headcount (Quantity)] [decimal](28, 12) NULL,
	[04.02.02.01.04 Sales & Marketing headcount (Local)] [decimal](28, 12) NULL,
	[04.02.02.01.04 Sales & Marketing headcount (LE)] [decimal](28, 12) NULL,
	[04.02.02.01.04 Sales & Marketing headcount (Quantity)] [decimal](28, 12) NULL,
	[04.02.02.01.05 Cost per sales & marketing employee (Local)] [decimal](28, 12) NULL,
	[04.02.02.01.05 Cost per sales & marketing employee (LE)] [decimal](28, 12) NULL,
	[04.02.02.01.05 Cost per sales & marketing employee (Quantity)] [decimal](28, 12) NULL,
	[04.02.02.01.06 Overall agency revenue / hour work (Local)] [decimal](28, 12) NULL,
	[04.02.02.01.06 Overall agency revenue / hour work (LE)] [decimal](28, 12) NULL,
	[04.02.02.01.06 Overall agency revenue / hour work (Quantity)] [decimal](28, 12) NULL,
	[04.02.02.01.07 Cost per internal staff hour (Local)] [decimal](28, 12) NULL,
	[04.02.02.01.07 Cost per internal staff hour (LE)] [decimal](28, 12) NULL,
	[04.02.02.01.07 Cost per internal staff hour (Quantity)] [decimal](28, 12) NULL,
	[04.02.02.01.08 Cost per Croudie hour (Local)] [decimal](28, 12) NULL,
	[04.02.02.01.08 Cost per Croudie hour (LE)] [decimal](28, 12) NULL,
	[04.02.02.01.08 Cost per Croudie hour (Quantity)] [decimal](28, 12) NULL,
	[04.02.02.01.09 Staff client hours/agency employee (Local)] [decimal](28, 12) NULL,
	[04.02.02.01.09 Staff client hours/agency employee (LE)] [decimal](28, 12) NULL,
	[04.02.02.01.09 Staff client hours/agency employee (Quantity)] [decimal](28, 12) NULL,
	[04.02.02.01.10 Rev. per sales & market. employee (Local)] [decimal](28, 12) NULL,
	[04.02.02.01.10 Rev. per sales & market. employee (LE)] [decimal](28, 12) NULL,
	[04.02.02.01.10 Rev. per sales & market. employee (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.01 LOC Outstanding (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.01 LOC Outstanding (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.01 LOC Outstanding (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.02 LOC Peak Balance (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.02 LOC Peak Balance (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.02 LOC Peak Balance (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.03 Total Contributions (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.03 Total Contributions (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.03 Total Contributions (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.04 Total Current Inv. Cost (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.04 Total Current Inv. Cost (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.04 Total Current Inv. Cost (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.05 Total Distributions (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.05 Total Distributions (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.05 Total Distributions (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.06 Total Fund NAV (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.06 Total Fund NAV (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.06 Total Fund NAV (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.07 Total Fund Size (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.07 Total Fund Size (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.07 Total Fund Size (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.08 Total Fund Size (other tranches) (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.08 Total Fund Size (other tranches) (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.08 Total Fund Size (other tranches) (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.09 Total Invested Capital (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.09 Total Invested Capital (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.09 Total Invested Capital (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.10 Total Invested Commitments (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.10 Total Invested Commitments (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.10 Total Invested Commitments (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.11 Total Realized Proceeds (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.11 Total Realized Proceeds (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.11 Total Realized Proceeds (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.12 Total Reported Value (Unrealized) (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.12 Total Reported Value (Unrealized) (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.12 Total Reported Value (Unrealized) (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.13 Fund Contributions (All Funds) (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.13 Fund Contributions (All Funds) (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.13 Fund Contributions (All Funds) (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.14 Total Invested Capital (All Funds) (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.14 Total Invested Capital (All Funds) (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.14 Total Invested Capital (All Funds) (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.15 Total Distributions (All Funds) (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.15 Total Distributions (All Funds) (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.15 Total Distributions (All Funds) (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.16 Total Investment Value (All Funds) (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.16 Total Investment Value (All Funds) (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.16 Total Investment Value (All Funds) (Quantity)] [decimal](28, 12) NULL,
	[F04.01.01.01.17 Total Realized Proceeds (All Funds (Local)] [decimal](28, 12) NULL,
	[F04.01.01.01.17 Total Realized Proceeds (All Funds (LE)] [decimal](28, 12) NULL,
	[F04.01.01.01.17 Total Realized Proceeds (All Funds (Quantity)] [decimal](28, 12) NULL,
	[F04.02.01.01.01 Number of Active Positions (Local)] [decimal](28, 12) NULL,
	[F04.02.01.01.01 Number of Active Positions (LE)] [decimal](28, 12) NULL,
	[F04.02.01.01.01 Number of Active Positions (Quantity)] [decimal](28, 12) NULL,
	[F04.02.01.01.02 Number of Investors (Local)] [decimal](28, 12) NULL,
	[F04.02.01.01.02 Number of Investors (LE)] [decimal](28, 12) NULL,
	[F04.02.01.01.02 Number of Investors (Quantity)] [decimal](28, 12) NULL,
	[F04.02.01.01.03 Number of Total Positions (Local)] [decimal](28, 12) NULL,
	[F04.02.01.01.03 Number of Total Positions (LE)] [decimal](28, 12) NULL,
	[F04.02.01.01.03 Number of Total Positions (Quantity)] [decimal](28, 12) NULL,
	[F04.02.01.01.04 Fund Commitments (All Funds) (Local)] [decimal](28, 12) NULL,
	[F04.02.01.01.04 Fund Commitments (All Funds) (LE)] [decimal](28, 12) NULL,
	[F04.02.01.01.04 Fund Commitments (All Funds) (Quantity)] [decimal](28, 12) NULL,
	[F04.02.01.01.05 Unfunded Commitments (All Funds) (Local)] [decimal](28, 12) NULL,
	[F04.02.01.01.05 Unfunded Commitments (All Funds) (LE)] [decimal](28, 12) NULL,
	[F04.02.01.01.05 Unfunded Commitments (All Funds) (Quantity)] [decimal](28, 12) NULL,
	[F04.02.01.01.06 Total IRR % (All Funds) (Local)] [decimal](28, 12) NULL,
	[F04.02.01.01.06 Total IRR % (All Funds) (LE)] [decimal](28, 12) NULL,
	[F04.02.01.01.06 Total IRR % (All Funds) (Quantity)] [decimal](28, 12) NULL,
	[F04.02.01.01.07 Total MOIC (All Funds) (Local)] [decimal](28, 12) NULL,
	[F04.02.01.01.07 Total MOIC (All Funds) (LE)] [decimal](28, 12) NULL,
	[F04.02.01.01.07 Total MOIC (All Funds) (Quantity)] [decimal](28, 12) NULL,
	[F04.02.01.01.08 No. Active Positions (All Funds) (Local)] [decimal](28, 12) NULL,
	[F04.02.01.01.08 No. Active Positions (All Funds) (LE)] [decimal](28, 12) NULL,
	[F04.02.01.01.08 No. Active Positions (All Funds) (Quantity)] [decimal](28, 12) NULL,
	[F04.02.01.01.09 No. Total Positions (All Funds) (Local)] [decimal](28, 12) NULL,
	[F04.02.01.01.09 No. Total Positions (All Funds) (LE)] [decimal](28, 12) NULL,
	[F04.02.01.01.09 No. Total Positions (All Funds) (Quantity)] [decimal](28, 12) NULL,
	[F04.02.01.01.10 Total IRR % (Local)] [decimal](28, 12) NULL,
	[F04.02.01.01.10 Total IRR % (LE)] [decimal](28, 12) NULL,
	[F04.02.01.01.10 Total IRR % (Quantity)] [decimal](28, 12) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_ClassType]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_ClassType](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](150) NULL,
 CONSTRAINT [PK_RM_ClassType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_Company]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_Company](
	[Id] [uniqueidentifier] NOT NULL,
	[InvCompanyId] [int] NOT NULL,
	[InvCompanyName] [nvarchar](200) NOT NULL,
	[InvNameAlias] [nvarchar](20) NULL,
	[InvCurrency] [nvarchar](3) NULL,
	[InvIndustry] [nvarchar](255) NULL,
	[InvDomainId] [int] NOT NULL,
	[RM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_RM_Company] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_CompanyFund]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_CompanyFund](
	[RM_CompanyID] [uniqueidentifier] NOT NULL,
	[RM_FundId] [uniqueidentifier] NOT NULL,
	[InvDealID] [int] NOT NULL,
	[InvDealName] [nvarchar](200) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_CompanyUserEmail]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_CompanyUserEmail](
	[Id] [uniqueidentifier] NOT NULL,
	[UserEmailId] [uniqueidentifier] NOT NULL,
	[CompanyId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_RM_CompanyUserEmail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_Configuration]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_Configuration](
	[SeqNo] [int] IDENTITY(1,1) NOT NULL,
	[ConfigurationName] [nvarchar](100) NOT NULL,
	[ConfigurationValue] [nvarchar](1000) NULL,
	[ConfigurationType] [nvarchar](100) NULL,
	[ConfigurationEncrypted] [varbinary](128) NULL,
 CONSTRAINT [PK_RM_Configuration] PRIMARY KEY CLUSTERED 
(
	[ConfigurationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_Configuration_Audit]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_Configuration_Audit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SeqNo] [int] NOT NULL,
	[ConfigurationName] [nvarchar](100) NOT NULL,
	[ConfigurationValue] [nvarchar](1000) NULL,
	[ConfigurationType] [nvarchar](100) NULL,
	[ConfigurationEncrypted] [varbinary](128) NULL,
	[ChangeType] [nchar](1) NOT NULL,
	[ChangedBy] [nvarchar](128) NOT NULL,
	[ChangedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_RM_Configuration_Audit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_DashboardComments]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_DashboardComments](
	[Id] [uniqueidentifier] NOT NULL,
	[DashboardId] [uniqueidentifier] NOT NULL,
	[Comments] [nvarchar](500) NULL,
	[EntityId] [int] NULL,
	[EntityTypeId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_RM_DashboardComments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_DataItem]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_DataItem](
	[Id] [uniqueidentifier] NOT NULL,
	[IndustryId] [uniqueidentifier] NULL,
	[KPITypeId] [uniqueidentifier] NOT NULL,
	[IsDebit] [bit] NOT NULL,
	[IsAggregate] [bit] NOT NULL,
	[Scale] [int] NOT NULL,
	[ValueTypeId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime2](7) NOT NULL,
	[Description] [nvarchar](300) NULL,
	[Name] [nvarchar](150) NULL,
	[IsSystemDefined] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_RM_DataItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_DataItemAttributeGroupAssociation]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_DataItemAttributeGroupAssociation](
	[Id] [uniqueidentifier] NOT NULL,
	[KPIIndustryTemplateId] [uniqueidentifier] NOT NULL,
	[NodeDataItemAssociationId] [uniqueidentifier] NOT NULL,
	[AttributeGroupId] [uniqueidentifier] NOT NULL,
	[ParentId] [uniqueidentifier] NOT NULL,
	[IsChecked] [bit] NOT NULL,
	[IsMandatory] [bit] NOT NULL,
	[Sequence] [int] NOT NULL,
 CONSTRAINT [PK_RM_DataItemAttributeGroupAssociation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_DefaultNodeDataItemAssociation]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_DefaultNodeDataItemAssociation](
	[Id] [uniqueidentifier] NOT NULL,
	[DefaultNodeId] [uniqueidentifier] NOT NULL,
	[DataItemId] [uniqueidentifier] NOT NULL,
	[KpiTypeId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_RM_DefaultNodeDataItemAssociation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_Dim_NodeHierarchy]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_Dim_NodeHierarchy](
	[NodeId] [uniqueidentifier] NOT NULL,
	[Lvls] [int] NULL,
	[Sequence] [int] NULL,
	[DataItemId] [uniqueidentifier] NULL,
	[KPITypeId] [uniqueidentifier] NULL,
	[KPITypeName] [nvarchar](50) NULL,
	[CompanyId] [uniqueidentifier] NULL,
	[Level01] [nvarchar](100) NULL,
	[Level02] [nvarchar](100) NULL,
	[Level03] [nvarchar](100) NULL,
	[Level04] [nvarchar](100) NULL,
	[Level05] [nvarchar](100) NULL,
	[Level06] [nvarchar](100) NULL,
	[Level07] [nvarchar](100) NULL,
	[Level08] [nvarchar](100) NULL,
	[Level09] [nvarchar](100) NULL,
	[Level10] [nvarchar](100) NULL,
	[Level11] [nvarchar](100) NULL,
	[Level12] [nvarchar](100) NULL,
	[Level13] [nvarchar](100) NULL,
	[Level14] [nvarchar](100) NULL,
	[Level15] [nvarchar](100) NULL,
	[Level16] [nvarchar](100) NULL,
	[Level17] [nvarchar](100) NULL,
	[Level18] [nvarchar](100) NULL,
	[Level19] [nvarchar](100) NULL,
	[Level20] [nvarchar](100) NULL,
	[Level21] [nvarchar](100) NULL,
	[Level22] [nvarchar](100) NULL,
	[Level23] [nvarchar](100) NULL,
	[Level24] [nvarchar](100) NULL,
	[Level25] [nvarchar](100) NULL,
	[Level26] [nvarchar](100) NULL,
	[Level27] [nvarchar](100) NULL,
	[Level28] [nvarchar](100) NULL,
	[Level29] [nvarchar](100) NULL,
	[Level30] [nvarchar](100) NULL,
	[Level31] [nvarchar](100) NULL,
	[Level32] [nvarchar](100) NULL,
	[Level33] [nvarchar](100) NULL,
	[Level34] [nvarchar](100) NULL,
	[Level35] [nvarchar](100) NULL,
	[Level36] [nvarchar](100) NULL,
	[Level37] [nvarchar](100) NULL,
	[Level38] [nvarchar](100) NULL,
	[Level39] [nvarchar](100) NULL,
	[Level40] [nvarchar](100) NULL,
	[Level41] [nvarchar](100) NULL,
	[Level42] [nvarchar](100) NULL,
	[Level43] [nvarchar](100) NULL,
	[Level44] [nvarchar](100) NULL,
	[Level45] [nvarchar](100) NULL,
	[Level46] [nvarchar](100) NULL,
	[Level47] [nvarchar](100) NULL,
	[Level48] [nvarchar](100) NULL,
	[Level49] [nvarchar](100) NULL,
	[Level50] [nvarchar](100) NULL,
	[Level01Weight] [decimal](20, 15) NULL,
	[Level02Weight] [decimal](20, 15) NULL,
	[Level03Weight] [decimal](20, 15) NULL,
	[Level04Weight] [decimal](20, 15) NULL,
	[Level05Weight] [decimal](20, 15) NULL,
	[Level06Weight] [decimal](20, 15) NULL,
	[Level07Weight] [decimal](20, 15) NULL,
	[Level08Weight] [decimal](20, 15) NULL,
	[Level09Weight] [decimal](20, 15) NULL,
	[Level10Weight] [decimal](20, 15) NULL,
	[Level11Weight] [decimal](20, 15) NULL,
	[Level12Weight] [decimal](20, 15) NULL,
	[Level13Weight] [decimal](20, 15) NULL,
	[Level14Weight] [decimal](20, 15) NULL,
	[Level15Weight] [decimal](20, 15) NULL,
	[Level16Weight] [decimal](20, 15) NULL,
	[Level17Weight] [decimal](20, 15) NULL,
	[Level18Weight] [decimal](20, 15) NULL,
	[Level19Weight] [decimal](20, 15) NULL,
	[Level20Weight] [decimal](20, 15) NULL,
	[Level21Weight] [decimal](20, 15) NULL,
	[Level22Weight] [decimal](20, 15) NULL,
	[Level23Weight] [decimal](20, 15) NULL,
	[Level24Weight] [decimal](20, 15) NULL,
	[Level25Weight] [decimal](20, 15) NULL,
	[Level26Weight] [decimal](20, 15) NULL,
	[Level27Weight] [decimal](20, 15) NULL,
	[Level28Weight] [decimal](20, 15) NULL,
	[Level29Weight] [decimal](20, 15) NULL,
	[Level30Weight] [decimal](20, 15) NULL,
	[Level31Weight] [decimal](20, 15) NULL,
	[Level32Weight] [decimal](20, 15) NULL,
	[Level33Weight] [decimal](20, 15) NULL,
	[Level34Weight] [decimal](20, 15) NULL,
	[Level35Weight] [decimal](20, 15) NULL,
	[Level36Weight] [decimal](20, 15) NULL,
	[Level37Weight] [decimal](20, 15) NULL,
	[Level38Weight] [decimal](20, 15) NULL,
	[Level39Weight] [decimal](20, 15) NULL,
	[Level40Weight] [decimal](20, 15) NULL,
	[Level41Weight] [decimal](20, 15) NULL,
	[Level42Weight] [decimal](20, 15) NULL,
	[Level43Weight] [decimal](20, 15) NULL,
	[Level44Weight] [decimal](20, 15) NULL,
	[Level45Weight] [decimal](20, 15) NULL,
	[Level46Weight] [decimal](20, 15) NULL,
	[Level47Weight] [decimal](20, 15) NULL,
	[Level48Weight] [decimal](20, 15) NULL,
	[Level49Weight] [decimal](20, 15) NULL,
	[Level50Weight] [decimal](20, 15) NULL,
	[ProcessedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_Dim_TransactionHierarchy]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_Dim_TransactionHierarchy](
	[TransTypeID] [int] NULL,
	[TransTypeName] [nvarchar](100) NULL,
	[Level1] [nvarchar](100) NULL,
	[Level2] [nvarchar](100) NULL,
	[Level3] [nvarchar](100) NULL,
	[Level4] [nvarchar](100) NULL,
	[Level5] [nvarchar](100) NULL,
	[Level6] [nvarchar](100) NULL,
	[Level7] [nvarchar](100) NULL,
	[Level8] [nvarchar](100) NULL,
	[Level9] [nvarchar](100) NULL,
	[Level10] [nvarchar](100) NULL,
	[Level11] [nvarchar](100) NULL,
	[Level12] [nvarchar](100) NULL,
	[Level13] [nvarchar](100) NULL,
	[Level14] [nvarchar](100) NULL,
	[Level15] [nvarchar](100) NULL,
	[Level16] [nvarchar](100) NULL,
	[Level17] [nvarchar](100) NULL,
	[Level18] [nvarchar](100) NULL,
	[Level19] [nvarchar](100) NULL,
	[Level20] [nvarchar](100) NULL,
	[Level21] [nvarchar](100) NULL,
	[Level22] [nvarchar](100) NULL,
	[Level23] [nvarchar](100) NULL,
	[Level24] [nvarchar](100) NULL,
	[Level25] [nvarchar](100) NULL,
	[Level26] [nvarchar](100) NULL,
	[Level27] [nvarchar](100) NULL,
	[Level28] [nvarchar](100) NULL,
	[Level29] [nvarchar](100) NULL,
	[Level30] [nvarchar](100) NULL,
	[Level31] [nvarchar](100) NULL,
	[Level32] [nvarchar](100) NULL,
	[Level33] [nvarchar](100) NULL,
	[Level34] [nvarchar](100) NULL,
	[Level35] [nvarchar](100) NULL,
	[Level36] [nvarchar](100) NULL,
	[Level37] [nvarchar](100) NULL,
	[Level38] [nvarchar](100) NULL,
	[Level39] [nvarchar](100) NULL,
	[Level40] [nvarchar](100) NULL,
	[Level41] [nvarchar](100) NULL,
	[Level42] [nvarchar](100) NULL,
	[Level43] [nvarchar](100) NULL,
	[Level44] [nvarchar](100) NULL,
	[Level45] [nvarchar](100) NULL,
	[Level46] [nvarchar](100) NULL,
	[Level47] [nvarchar](100) NULL,
	[Level48] [nvarchar](100) NULL,
	[Level49] [nvarchar](100) NULL,
	[Level50] [nvarchar](100) NULL,
	[Level1Weight] [decimal](20, 15) NULL,
	[Level2Weight] [decimal](20, 15) NULL,
	[Level3Weight] [decimal](20, 15) NULL,
	[Level4Weight] [decimal](20, 15) NULL,
	[Level5Weight] [decimal](20, 15) NULL,
	[Level6Weight] [decimal](20, 15) NULL,
	[Level7Weight] [decimal](20, 15) NULL,
	[Level8Weight] [decimal](20, 15) NULL,
	[Level9Weight] [decimal](20, 15) NULL,
	[Level10Weight] [decimal](20, 15) NULL,
	[Level11Weight] [decimal](20, 15) NULL,
	[Level12Weight] [decimal](20, 15) NULL,
	[Level13Weight] [decimal](20, 15) NULL,
	[Level14Weight] [decimal](20, 15) NULL,
	[Level15Weight] [decimal](20, 15) NULL,
	[Level16Weight] [decimal](20, 15) NULL,
	[Level17Weight] [decimal](20, 15) NULL,
	[Level18Weight] [decimal](20, 15) NULL,
	[Level19Weight] [decimal](20, 15) NULL,
	[Level20Weight] [decimal](20, 15) NULL,
	[Level21Weight] [decimal](20, 15) NULL,
	[Level22Weight] [decimal](20, 15) NULL,
	[Level23Weight] [decimal](20, 15) NULL,
	[Level24Weight] [decimal](20, 15) NULL,
	[Level25Weight] [decimal](20, 15) NULL,
	[Level26Weight] [decimal](20, 15) NULL,
	[Level27Weight] [decimal](20, 15) NULL,
	[Level28Weight] [decimal](20, 15) NULL,
	[Level29Weight] [decimal](20, 15) NULL,
	[Level30Weight] [decimal](20, 15) NULL,
	[Level31Weight] [decimal](20, 15) NULL,
	[Level32Weight] [decimal](20, 15) NULL,
	[Level33Weight] [decimal](20, 15) NULL,
	[Level34Weight] [decimal](20, 15) NULL,
	[Level35Weight] [decimal](20, 15) NULL,
	[Level36Weight] [decimal](20, 15) NULL,
	[Level37Weight] [decimal](20, 15) NULL,
	[Level38Weight] [decimal](20, 15) NULL,
	[Level39Weight] [decimal](20, 15) NULL,
	[Level40Weight] [decimal](20, 15) NULL,
	[Level41Weight] [decimal](20, 15) NULL,
	[Level42Weight] [decimal](20, 15) NULL,
	[Level43Weight] [decimal](20, 15) NULL,
	[Level44Weight] [decimal](20, 15) NULL,
	[Level45Weight] [decimal](20, 15) NULL,
	[Level46Weight] [decimal](20, 15) NULL,
	[Level47Weight] [decimal](20, 15) NULL,
	[Level48Weight] [decimal](20, 15) NULL,
	[Level49Weight] [decimal](20, 15) NULL,
	[Level50Weight] [decimal](20, 15) NULL,
	[ProcessedDate] [datetime] NULL,
	[PRIMLevel] [tinyint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_ETL_Activity]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_ETL_Activity](
	[SeqNo] [int] IDENTITY(1,1) NOT NULL,
	[SourceTableName] [nvarchar](300) NULL,
	[STGTableName] [nvarchar](300) NULL,
	[DestinationTableName] [nvarchar](300) NULL,
	[LoadType] [nvarchar](25) NULL,
	[ExecOrder] [smallint] NOT NULL,
	[LastRunDate] [datetime] NULL,
	[SourceStoredProcedureName] [nvarchar](128) NULL,
	[StoredProcedureName] [nvarchar](128) NULL,
	[UseDataFlow] [bit] NOT NULL,
 CONSTRAINT [PK_RM_ETL_Activity] PRIMARY KEY CLUSTERED 
(
	[SeqNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_ETL_Activity_DetailLog]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_ETL_Activity_DetailLog](
	[SeqNo] [int] IDENTITY(1,1) NOT NULL,
	[PackageName] [nvarchar](300) NULL,
	[TableName] [nvarchar](200) NULL,
	[LoadType] [nvarchar](50) NULL,
	[Status] [nvarchar](100) NULL,
	[BatchID] [int] NULL,
	[RowsCount] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[DetailDescription] [nvarchar](max) NULL,
	[ErrorCode] [nvarchar](100) NULL,
	[ErrorDescription] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_Fact_Transaction]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_Fact_Transaction](
	[FactID] [int] IDENTITY(1,1) NOT NULL,
	[BatchStatusID] [int] NULL,
	[LegalEntityID] [int] NOT NULL,
	[TransTypeID] [int] NOT NULL,
	[SpecDealID] [int] NULL,
	[SpecPositionID] [int] NULL,
	[IssuerID] [int] NULL,
	[SecurityID] [int] NULL,
	[LotID] [int] NULL,
	[CurrencyID] [int] NOT NULL,
	[GLDate] [datetime] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[Amount] [numeric](28, 12) NULL,
	[LEAmount] [numeric](28, 12) NULL,
	[Quantity] [numeric](28, 12) NULL,
	[RM_Scenario] [nvarchar](255) NULL,
	[RM_TimePeriod] [nvarchar](255) NULL,
	[RM_Geography] [nvarchar](255) NULL,
	[RM_Sector] [nvarchar](255) NULL,
	[RM_Dimension_01] [nvarchar](255) NULL,
	[RM_Dimension_02] [nvarchar](255) NULL,
	[RM_Dimension_03] [nvarchar](255) NULL,
	[RM_Dimension_04] [nvarchar](255) NULL,
	[RM_Dimension_05] [nvarchar](255) NULL,
	[RM_Dimension_06] [nvarchar](255) NULL,
	[RM_Dimension_07] [nvarchar](255) NULL,
	[RM_Dimension_08] [nvarchar](255) NULL,
	[RM_Dimension_09] [nvarchar](255) NULL,
	[RM_Dimension_10] [nvarchar](255) NULL,
	[ProcessedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_Fund]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_Fund](
	[Id] [uniqueidentifier] NOT NULL,
	[InvFundId] [int] NOT NULL,
	[InvFundName] [nvarchar](200) NOT NULL,
	[InvDomainId] [int] NOT NULL,
	[RM_IsActive] [bit] NOT NULL,
	[InvCurrency] [nvarchar](3) NULL,
	[InvNameAlias] [nvarchar](20) NULL,
 CONSTRAINT [PK_RM_Fund] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_FundUserEmail]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_FundUserEmail](
	[Id] [uniqueidentifier] NOT NULL,
	[UserEmailId] [uniqueidentifier] NOT NULL,
	[FundId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_RM_FundUserEmail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_Industry]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_Industry](
	[Id] [uniqueidentifier] NOT NULL,
	[InvIndustryId] [int] NOT NULL,
	[InvIndustryName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_RM_Industry] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_InvestmentCommentary]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_InvestmentCommentary](
	[Id] [uniqueidentifier] NOT NULL,
	[EntityId] [int] NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[InvestmentCommentaryTypeId] [uniqueidentifier] NOT NULL,
	[OrderIndex] [int] NULL,
 CONSTRAINT [PK_RM_InvestmentCommentary] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_InvestmentCommentaryHistory]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_InvestmentCommentaryHistory](
	[Id] [uniqueidentifier] NOT NULL,
	[InvestmentCommentaryId] [uniqueidentifier] NOT NULL,
	[CommentaryText] [nvarchar](max) NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_RM_InvestmentCommentaryHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_InvestmentCommentaryType]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_InvestmentCommentaryType](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](150) NULL,
 CONSTRAINT [PK_RM_InvestmentCommentaryType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_KPI_Collection_Batch]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_KPI_Collection_Batch](
	[Id] [uniqueidentifier] NOT NULL,
	[KpiTypeId] [uniqueidentifier] NOT NULL,
	[ReportingDate] [datetime2](7) NOT NULL,
	[CompanyId] [uniqueidentifier] NOT NULL,
	[CollectionPeriodId] [uniqueidentifier] NOT NULL,
	[BatchStatusId] [uniqueidentifier] NOT NULL,
	[WorkflowId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime2](7) NOT NULL,
	[ScenarioTypeId] [uniqueidentifier] NOT NULL,
	[AsOfDate] [datetime2](7) NULL,
 CONSTRAINT [PK_RM_KPI_Collection_Batch] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_KPI_Collection_Batch_Dimension]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_KPI_Collection_Batch_Dimension](
	[Id] [uniqueidentifier] NOT NULL,
	[KPICollectionBatchId] [uniqueidentifier] NOT NULL,
	[KPICollectionDimensionId] [uniqueidentifier] NOT NULL,
	[EffectiveDate] [datetime2](7) NOT NULL,
	[Amount] [decimal](18, 7) NULL,
	[Percentage] [decimal](18, 7) NULL,
	[Ratio] [decimal](18, 7) NULL,
 CONSTRAINT [PK_RM_KPI_Collection_Batch_Dimension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_KPI_Collection_DataItem]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_KPI_Collection_DataItem](
	[Id] [uniqueidentifier] NOT NULL,
	[KPICollectionNodeId] [uniqueidentifier] NOT NULL,
	[DataItemId] [uniqueidentifier] NOT NULL,
	[Sequence] [int] NOT NULL,
 CONSTRAINT [PK_RM_KPI_Collection_DataItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_KPI_Collection_Dimension]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_KPI_Collection_Dimension](
	[Id] [uniqueidentifier] NOT NULL,
	[KPICollectionDataItemId] [uniqueidentifier] NOT NULL,
	[AttributeId] [uniqueidentifier] NULL,
	[ParentKPICollectionDimensionId] [uniqueidentifier] NULL,
	[Sequence] [int] NOT NULL,
 CONSTRAINT [PK_RM_KPI_Collection_Dimension] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_KPI_Collection_Node]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_KPI_Collection_Node](
	[Id] [uniqueidentifier] NOT NULL,
	[WorkflowId] [uniqueidentifier] NOT NULL,
	[NodeId] [uniqueidentifier] NOT NULL,
	[ParentKPICollectionNodeId] [uniqueidentifier] NULL,
	[KpiTypeId] [uniqueidentifier] NOT NULL,
	[Sequence] [int] NOT NULL,
 CONSTRAINT [PK_RM_KPI_Collection_Node] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_KPICommentary]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_KPICommentary](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](150) NULL,
 CONSTRAINT [PK_RM_KPICommentary] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_KPICommentaryCompanyAssocation]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_KPICommentaryCompanyAssocation](
	[Id] [uniqueidentifier] NOT NULL,
	[KPICompanyConfigTemplateId] [uniqueidentifier] NOT NULL,
	[KPICommentaryId] [uniqueidentifier] NOT NULL,
	[OrderIndex] [int] NOT NULL,
 CONSTRAINT [PK_RM_KPICommentaryCompanyAssocation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_KPICommentaryIndustryAssociation]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_KPICommentaryIndustryAssociation](
	[Id] [uniqueidentifier] NOT NULL,
	[KPIIndustryTemplateId] [uniqueidentifier] NOT NULL,
	[KPICommentaryId] [uniqueidentifier] NOT NULL,
	[OrderIndex] [int] NOT NULL,
 CONSTRAINT [PK_RM_KPICommentaryIndustryAssociation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_KPICompanyConfigDataItemAttributeAssociation]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_KPICompanyConfigDataItemAttributeAssociation](
	[Id] [uniqueidentifier] NOT NULL,
	[KPICompanyConfigTemplateId] [uniqueidentifier] NOT NULL,
	[KPICompanyConfigNodeDataItemAssociationId] [uniqueidentifier] NOT NULL,
	[AttributeGroupId] [uniqueidentifier] NOT NULL,
	[ParentAttributeGroupId] [uniqueidentifier] NOT NULL,
	[IsChecked] [bit] NOT NULL,
	[IsMandatory] [bit] NOT NULL,
	[Sequence] [int] NOT NULL,
 CONSTRAINT [PK_RM_KPICompanyConfigDataItemAttributeAssociation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_KPICompanyConfigNodeAssociation]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_KPICompanyConfigNodeAssociation](
	[Id] [uniqueidentifier] NOT NULL,
	[KPICompanyConfigurationId] [uniqueidentifier] NOT NULL,
	[NodeId] [uniqueidentifier] NOT NULL,
	[IsChecked] [bit] NOT NULL,
	[KpiTypeId] [uniqueidentifier] NOT NULL,
	[Weight] [int] NOT NULL,
	[Sequence] [int] NOT NULL,
 CONSTRAINT [PK_RM_KPICompanyConfigNodeAssociation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_KPICompanyConfigNodeDataItemAssociation]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_KPICompanyConfigNodeDataItemAssociation](
	[Id] [uniqueidentifier] NOT NULL,
	[KPICompanyConfigurationId] [uniqueidentifier] NOT NULL,
	[KPICompanyConfigNodeAssociationId] [uniqueidentifier] NOT NULL,
	[DataItemId] [uniqueidentifier] NOT NULL,
	[IsChecked] [bit] NOT NULL,
	[Sequence] [int] NOT NULL,
 CONSTRAINT [PK_RM_KPICompanyConfigNodeDataItemAssociation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_KPICompanyConfiguration]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_KPICompanyConfiguration](
	[Id] [uniqueidentifier] NOT NULL,
	[KPIIndustryTemplateId] [uniqueidentifier] NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime2](7) NOT NULL,
	[IsConfirmed] [bit] NOT NULL,
	[CompanyId] [uniqueidentifier] NOT NULL,
	[CollectionRecurrenceId] [uniqueidentifier] NOT NULL,
	[NoOfRecurrences] [int] NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_RM_KPICompanyConfiguration] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_KPICompanyRecurrenceAssociation]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_KPICompanyRecurrenceAssociation](
	[Id] [uniqueidentifier] NOT NULL,
	[KPICompanyConfigurationId] [uniqueidentifier] NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NULL,
	[CollectionPeriodId] [uniqueidentifier] NOT NULL,
	[KpiCategoryId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_RM_KPICompanyRecurrenceAssociation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_KPICompanyRecurrenceScenarioAssociation]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_KPICompanyRecurrenceScenarioAssociation](
	[Id] [uniqueidentifier] NOT NULL,
	[KPICompanyConfigurationId] [uniqueidentifier] NOT NULL,
	[KPICompanyRecurrenceAssociationId] [uniqueidentifier] NOT NULL,
	[ClassTypeId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_RM_KPICompanyRecurrenceScenarioAssociation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_KPIIndustryTemplate]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_KPIIndustryTemplate](
	[Id] [uniqueidentifier] NOT NULL,
	[IndustryId] [uniqueidentifier] NOT NULL,
	[IsConfirmed] [bit] NOT NULL,
	[ChangedBy] [nvarchar](50) NULL,
	[ChangedOn] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_RM_KPIIndustryTemplate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_Node]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_Node](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](150) NULL,
	[IsSystemDefined] [bit] NOT NULL,
	[ParentNodeId] [uniqueidentifier] NULL,
	[KPITypeId] [uniqueidentifier] NOT NULL,
	[IsNewNode] [bit] NOT NULL,
	[IndustryId] [uniqueidentifier] NULL,
	[Sequence] [int] NULL,
 CONSTRAINT [PK_RM_Node] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_NodeDataItemAssociation]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_NodeDataItemAssociation](
	[Id] [uniqueidentifier] NOT NULL,
	[DataItemId] [uniqueidentifier] NOT NULL,
	[NodeIndustryAssociationId] [uniqueidentifier] NOT NULL,
	[KPIIndustryTemplateId] [uniqueidentifier] NOT NULL,
	[IsChecked] [bit] NOT NULL,
	[Sequence] [int] NOT NULL,
 CONSTRAINT [PK_RM_NodeDataItemAssociation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_NodeIndustryAssociation]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_NodeIndustryAssociation](
	[Id] [uniqueidentifier] NOT NULL,
	[NodeId] [uniqueidentifier] NOT NULL,
	[KPIIndustryTemplateId] [uniqueidentifier] NOT NULL,
	[IsChecked] [bit] NOT NULL,
	[Description] [nvarchar](500) NULL,
	[NodeAlias] [nvarchar](150) NULL,
	[Weight] [int] NOT NULL,
	[Sequence] [int] NOT NULL,
 CONSTRAINT [PK_RM_NodeIndustryAssociation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_Sec_Fund]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_Sec_Fund](
	[UserId] [int] NOT NULL,
	[FundId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_Sec_Issuer]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_Sec_Issuer](
	[UserId] [int] NOT NULL,
	[IssuerId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_Sec_User]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_Sec_User](
	[UserId] [int] NOT NULL,
	[Email] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_UserEmail]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_UserEmail](
	[Id] [uniqueidentifier] NOT NULL,
	[Email] [nvarchar](200) NOT NULL,
	[InvUserId] [int] NULL,
	[Internal] [bit] NOT NULL,
 CONSTRAINT [PK_RM_UserEmail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_Workflow]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_Workflow](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](150) NULL,
	[CompanyId] [uniqueidentifier] NOT NULL,
	[EffectiveDate] [datetime2](7) NOT NULL,
	[KpiCategoryId] [uniqueidentifier] NOT NULL,
	[WorkflowStatusId] [uniqueidentifier] NOT NULL,
	[StatusDate] [datetime2](7) NOT NULL,
	[ChangedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_RM_Workflow] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_WorkflowClassAssociation]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_WorkflowClassAssociation](
	[Id] [uniqueidentifier] NOT NULL,
	[WorkflowId] [uniqueidentifier] NOT NULL,
	[ClassTypeId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_RM_WorkflowClassAssociation] PRIMARY KEY CLUSTERED 
(
	[ClassTypeId] ASC,
	[WorkflowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_RM_WorkflowClassAssociation_Id] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_WorkflowDocument]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_WorkflowDocument](
	[Id] [uniqueidentifier] NOT NULL,
	[WorkflowId] [uniqueidentifier] NOT NULL,
	[InvDocumentId] [int] NOT NULL,
	[LastUpdatedBy] [nvarchar](50) NULL,
	[IsDataCollectionFile] [bit] NULL,
	[IsSubmitted] [bit] NULL,
	[LastUpdatetedDate] [datetime2](7) NULL,
	[WorkflowStatusId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_RM_WorkflowDocument] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RM_WorkflowStatusHistory]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RM_WorkflowStatusHistory](
	[Id] [uniqueidentifier] NOT NULL,
	[WorkflowId] [uniqueidentifier] NOT NULL,
	[WorkflowStatusId] [uniqueidentifier] NOT NULL,
	[Comments] [nvarchar](500) NULL,
	[CreatedOn] [datetime2](7) NOT NULL,
	[LastUpdatedOn] [datetime2](7) NOT NULL,
	[LastUpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_RM_WorkflowStatusHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RMX_BatchStatus]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RMX_BatchStatus](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_RMX_BatchStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RMX_CollectionPeriod]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RMX_CollectionPeriod](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ShortName] [nvarchar](10) NULL,
 CONSTRAINT [PK_RMX_CollectionPeriod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RMX_CollectionRecurrence]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RMX_CollectionRecurrence](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_RMX_CollectionRecurrence] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RMX_KpiCategory]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RMX_KpiCategory](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_RMX_KpiCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RMX_KpiType]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RMX_KpiType](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[IsFinancial] [bit] NOT NULL,
	[IsTemplate] [bit] NOT NULL,
 CONSTRAINT [PK_RMX_KpiType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RMX_ValueType]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RMX_ValueType](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_RMX_ValueType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RMX_WorkflowStatus]    Script Date: 3/4/2021 6:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RMX_WorkflowStatus](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_RMX_WorkflowStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RM_Attribute] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_AttributeGroup] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_AttributeGroup] ADD  DEFAULT ((0)) FOR [IsSystemDefined]
GO
ALTER TABLE [dbo].[RM_AttributeGroupIndustryAssociation] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_Audit] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_BI_KPI_Batch] ADD  DEFAULT (getdate()) FOR [ProcessedDate]
GO
ALTER TABLE [dbo].[RM_ClassType] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_Company] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_Company] ADD  DEFAULT ((-1)) FOR [InvDomainId]
GO
ALTER TABLE [dbo].[RM_Company] ADD  DEFAULT ((0)) FOR [RM_IsActive]
GO
ALTER TABLE [dbo].[RM_CompanyUserEmail] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_Configuration_Audit] ADD  DEFAULT (suser_sname()) FOR [ChangedBy]
GO
ALTER TABLE [dbo].[RM_Configuration_Audit] ADD  DEFAULT (getdate()) FOR [ChangedDate]
GO
ALTER TABLE [dbo].[RM_DashboardComments] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_DataItem] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_DataItem] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [CreatedOn]
GO
ALTER TABLE [dbo].[RM_DataItem] ADD  DEFAULT ((0)) FOR [IsSystemDefined]
GO
ALTER TABLE [dbo].[RM_DataItem] ADD  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[RM_DataItemAttributeGroupAssociation] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_DataItemAttributeGroupAssociation] ADD  DEFAULT ((0)) FOR [Sequence]
GO
ALTER TABLE [dbo].[RM_Dim_NodeHierarchy] ADD  DEFAULT (getdate()) FOR [ProcessedDate]
GO
ALTER TABLE [dbo].[RM_Dim_TransactionHierarchy] ADD  DEFAULT (getdate()) FOR [ProcessedDate]
GO
ALTER TABLE [dbo].[RM_ETL_Activity] ADD  CONSTRAINT [DF_RM_ETL_Activity_ExecOrder]  DEFAULT ((-1)) FOR [ExecOrder]
GO
ALTER TABLE [dbo].[RM_ETL_Activity] ADD  CONSTRAINT [DF_RM_ETL_Activity_UseDataFlow]  DEFAULT ((0)) FOR [UseDataFlow]
GO
ALTER TABLE [dbo].[RM_Fact_Transaction] ADD  DEFAULT (getdate()) FOR [ProcessedDate]
GO
ALTER TABLE [dbo].[RM_Fund] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_Fund] ADD  DEFAULT ((-1)) FOR [InvDomainId]
GO
ALTER TABLE [dbo].[RM_Fund] ADD  DEFAULT ((0)) FOR [RM_IsActive]
GO
ALTER TABLE [dbo].[RM_FundUserEmail] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_Industry] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_InvestmentCommentary] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_InvestmentCommentary] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [InvestmentCommentaryTypeId]
GO
ALTER TABLE [dbo].[RM_InvestmentCommentaryHistory] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_InvestmentCommentaryType] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch_Dimension] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_DataItem] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_DataItem] ADD  DEFAULT ((0)) FOR [Sequence]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Dimension] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Dimension] ADD  DEFAULT ((0)) FOR [Sequence]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Node] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Node] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [KpiTypeId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Node] ADD  DEFAULT ((0)) FOR [Sequence]
GO
ALTER TABLE [dbo].[RM_KPICommentary] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_KPICommentaryCompanyAssocation] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_KPICommentaryCompanyAssocation] ADD  DEFAULT ((0)) FOR [OrderIndex]
GO
ALTER TABLE [dbo].[RM_KPICommentaryIndustryAssociation] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_KPICommentaryIndustryAssociation] ADD  DEFAULT ((0)) FOR [OrderIndex]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigDataItemAttributeAssociation] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigDataItemAttributeAssociation] ADD  DEFAULT ((0)) FOR [Sequence]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeAssociation] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeAssociation] ADD  DEFAULT ((0)) FOR [IsChecked]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeAssociation] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [KpiTypeId]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeAssociation] ADD  DEFAULT ((0)) FOR [Weight]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeAssociation] ADD  DEFAULT ((0)) FOR [Sequence]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeDataItemAssociation] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeDataItemAssociation] ADD  DEFAULT ((0)) FOR [Sequence]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfiguration] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfiguration] ADD  DEFAULT ((0)) FOR [IsConfirmed]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfiguration] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [CompanyId]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfiguration] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [CollectionRecurrenceId]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfiguration] ADD  DEFAULT ((0)) FOR [NoOfRecurrences]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfiguration] ADD  DEFAULT ('0001-01-01T00:00:00.0000000') FOR [StartDate]
GO
ALTER TABLE [dbo].[RM_KPICompanyRecurrenceAssociation] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_KPICompanyRecurrenceScenarioAssociation] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_KPIIndustryTemplate] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_Node] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_Node] ADD  DEFAULT ((0)) FOR [IsNewNode]
GO
ALTER TABLE [dbo].[RM_NodeDataItemAssociation] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_NodeDataItemAssociation] ADD  DEFAULT ((0)) FOR [Sequence]
GO
ALTER TABLE [dbo].[RM_NodeIndustryAssociation] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_NodeIndustryAssociation] ADD  DEFAULT ((0)) FOR [IsChecked]
GO
ALTER TABLE [dbo].[RM_NodeIndustryAssociation] ADD  DEFAULT ((0)) FOR [Weight]
GO
ALTER TABLE [dbo].[RM_NodeIndustryAssociation] ADD  DEFAULT ((0)) FOR [Sequence]
GO
ALTER TABLE [dbo].[RM_UserEmail] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_UserEmail] ADD  DEFAULT ((0)) FOR [Internal]
GO
ALTER TABLE [dbo].[RM_Workflow] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_WorkflowClassAssociation] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_WorkflowDocument] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_WorkflowDocument] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [WorkflowStatusId]
GO
ALTER TABLE [dbo].[RM_WorkflowStatusHistory] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RMX_BatchStatus] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RMX_CollectionPeriod] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RMX_CollectionRecurrence] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RMX_KpiCategory] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RMX_KpiType] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RMX_KpiType] ADD  DEFAULT ((0)) FOR [IsFinancial]
GO
ALTER TABLE [dbo].[RMX_KpiType] ADD  DEFAULT ((0)) FOR [IsTemplate]
GO
ALTER TABLE [dbo].[RMX_ValueType] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RMX_WorkflowStatus] ADD  DEFAULT (newsequentialid()) FOR [Id]
GO
ALTER TABLE [dbo].[RM_Attribute]  WITH CHECK ADD  CONSTRAINT [FK_RM_Attribute_RM_AttributeGroup_AttributeGroupId] FOREIGN KEY([AttributeGroupId])
REFERENCES [dbo].[RM_AttributeGroup] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_Attribute] CHECK CONSTRAINT [FK_RM_Attribute_RM_AttributeGroup_AttributeGroupId]
GO
ALTER TABLE [dbo].[RM_AttributeGroupIndustryAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_AttributeGroupIndustryAssociation_RM_AttributeGroup_AttributeGroupId] FOREIGN KEY([AttributeGroupId])
REFERENCES [dbo].[RM_AttributeGroup] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_AttributeGroupIndustryAssociation] CHECK CONSTRAINT [FK_RM_AttributeGroupIndustryAssociation_RM_AttributeGroup_AttributeGroupId]
GO
ALTER TABLE [dbo].[RM_CompanyUserEmail]  WITH CHECK ADD  CONSTRAINT [FK_RM_CompanyUserEmail_RM_Company_CompanyId] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[RM_Company] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_CompanyUserEmail] CHECK CONSTRAINT [FK_RM_CompanyUserEmail_RM_Company_CompanyId]
GO
ALTER TABLE [dbo].[RM_CompanyUserEmail]  WITH CHECK ADD  CONSTRAINT [FK_RM_CompanyUserEmail_RM_UserEmail_UserEmailId] FOREIGN KEY([UserEmailId])
REFERENCES [dbo].[RM_UserEmail] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_CompanyUserEmail] CHECK CONSTRAINT [FK_RM_CompanyUserEmail_RM_UserEmail_UserEmailId]
GO
ALTER TABLE [dbo].[RM_DataItem]  WITH CHECK ADD  CONSTRAINT [FK_RM_DataItem_RM_Industry_IndustryId] FOREIGN KEY([IndustryId])
REFERENCES [dbo].[RM_Industry] ([Id])
GO
ALTER TABLE [dbo].[RM_DataItem] CHECK CONSTRAINT [FK_RM_DataItem_RM_Industry_IndustryId]
GO
ALTER TABLE [dbo].[RM_DataItem]  WITH CHECK ADD  CONSTRAINT [FK_RM_DataItem_RMX_KpiType_KPITypeId] FOREIGN KEY([KPITypeId])
REFERENCES [dbo].[RMX_KpiType] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_DataItem] CHECK CONSTRAINT [FK_RM_DataItem_RMX_KpiType_KPITypeId]
GO
ALTER TABLE [dbo].[RM_DataItem]  WITH CHECK ADD  CONSTRAINT [FK_RM_DataItem_RMX_ValueType_ValueTypeId] FOREIGN KEY([ValueTypeId])
REFERENCES [dbo].[RMX_ValueType] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_DataItem] CHECK CONSTRAINT [FK_RM_DataItem_RMX_ValueType_ValueTypeId]
GO
ALTER TABLE [dbo].[RM_DataItemAttributeGroupAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_DataItemAttributeGroupAssociation_RM_AttributeGroup_AttributeGroupId] FOREIGN KEY([AttributeGroupId])
REFERENCES [dbo].[RM_AttributeGroup] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_DataItemAttributeGroupAssociation] CHECK CONSTRAINT [FK_RM_DataItemAttributeGroupAssociation_RM_AttributeGroup_AttributeGroupId]
GO
ALTER TABLE [dbo].[RM_DataItemAttributeGroupAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_DataItemAttributeGroupAssociation_RM_KPIIndustryTemplate_KPIIndustryTemplateId] FOREIGN KEY([KPIIndustryTemplateId])
REFERENCES [dbo].[RM_KPIIndustryTemplate] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_DataItemAttributeGroupAssociation] CHECK CONSTRAINT [FK_RM_DataItemAttributeGroupAssociation_RM_KPIIndustryTemplate_KPIIndustryTemplateId]
GO
ALTER TABLE [dbo].[RM_DataItemAttributeGroupAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_DataItemAttributeGroupAssociation_RM_NodeDataItemAssociation_NodeDataItemAssociationId] FOREIGN KEY([NodeDataItemAssociationId])
REFERENCES [dbo].[RM_NodeDataItemAssociation] ([Id])
GO
ALTER TABLE [dbo].[RM_DataItemAttributeGroupAssociation] CHECK CONSTRAINT [FK_RM_DataItemAttributeGroupAssociation_RM_NodeDataItemAssociation_NodeDataItemAssociationId]
GO
ALTER TABLE [dbo].[RM_DefaultNodeDataItemAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_DefaultNodeDataItemAssociation_RM_DataItem_DataItemId] FOREIGN KEY([DataItemId])
REFERENCES [dbo].[RM_DataItem] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_DefaultNodeDataItemAssociation] CHECK CONSTRAINT [FK_RM_DefaultNodeDataItemAssociation_RM_DataItem_DataItemId]
GO
ALTER TABLE [dbo].[RM_DefaultNodeDataItemAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_DefaultNodeDataItemAssociation_RM_Node_NodeId] FOREIGN KEY([DefaultNodeId])
REFERENCES [dbo].[RM_Node] ([Id])
GO
ALTER TABLE [dbo].[RM_DefaultNodeDataItemAssociation] CHECK CONSTRAINT [FK_RM_DefaultNodeDataItemAssociation_RM_Node_NodeId]
GO
ALTER TABLE [dbo].[RM_DefaultNodeDataItemAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_DefaultNodeDataItemAssociation_RMX_KpiType_KpiTypeId] FOREIGN KEY([KpiTypeId])
REFERENCES [dbo].[RMX_KpiType] ([Id])
GO
ALTER TABLE [dbo].[RM_DefaultNodeDataItemAssociation] CHECK CONSTRAINT [FK_RM_DefaultNodeDataItemAssociation_RMX_KpiType_KpiTypeId]
GO
ALTER TABLE [dbo].[RM_FundUserEmail]  WITH CHECK ADD  CONSTRAINT [FK_RM_FundUserEmail_RM_Fund_FundId] FOREIGN KEY([FundId])
REFERENCES [dbo].[RM_Fund] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_FundUserEmail] CHECK CONSTRAINT [FK_RM_FundUserEmail_RM_Fund_FundId]
GO
ALTER TABLE [dbo].[RM_FundUserEmail]  WITH CHECK ADD  CONSTRAINT [FK_RM_FundUserEmail_RM_UserEmail_UserEmailId] FOREIGN KEY([UserEmailId])
REFERENCES [dbo].[RM_UserEmail] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_FundUserEmail] CHECK CONSTRAINT [FK_RM_FundUserEmail_RM_UserEmail_UserEmailId]
GO
ALTER TABLE [dbo].[RM_InvestmentCommentary]  WITH CHECK ADD  CONSTRAINT [FK_RM_InvestmentCommentary_RM_InvestmentCommentaryType_InvestmentCommentaryTypeId] FOREIGN KEY([InvestmentCommentaryTypeId])
REFERENCES [dbo].[RM_InvestmentCommentaryType] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_InvestmentCommentary] CHECK CONSTRAINT [FK_RM_InvestmentCommentary_RM_InvestmentCommentaryType_InvestmentCommentaryTypeId]
GO
ALTER TABLE [dbo].[RM_InvestmentCommentaryHistory]  WITH CHECK ADD  CONSTRAINT [FK_RM_InvestmentCommentaryHistory_RM_InvestmentCommentary_InvestmentCommentaryId] FOREIGN KEY([InvestmentCommentaryId])
REFERENCES [dbo].[RM_InvestmentCommentary] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_InvestmentCommentaryHistory] CHECK CONSTRAINT [FK_RM_InvestmentCommentaryHistory_RM_InvestmentCommentary_InvestmentCommentaryId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_Batch_RM_ClassType_ScenarioTypeId] FOREIGN KEY([ScenarioTypeId])
REFERENCES [dbo].[RM_ClassType] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch] CHECK CONSTRAINT [FK_RM_KPI_Collection_Batch_RM_ClassType_ScenarioTypeId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_Batch_RM_Company_CompanyId] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[RM_Company] ([Id])
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch] CHECK CONSTRAINT [FK_RM_KPI_Collection_Batch_RM_Company_CompanyId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_Batch_RM_Workflow_WorkflowId] FOREIGN KEY([WorkflowId])
REFERENCES [dbo].[RM_Workflow] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch] CHECK CONSTRAINT [FK_RM_KPI_Collection_Batch_RM_Workflow_WorkflowId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_Batch_RMX_BatchStatus_BatchStatusId] FOREIGN KEY([BatchStatusId])
REFERENCES [dbo].[RMX_BatchStatus] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch] CHECK CONSTRAINT [FK_RM_KPI_Collection_Batch_RMX_BatchStatus_BatchStatusId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_Batch_RMX_CollectionPeriod_CollectionPeriodId] FOREIGN KEY([CollectionPeriodId])
REFERENCES [dbo].[RMX_CollectionPeriod] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch] CHECK CONSTRAINT [FK_RM_KPI_Collection_Batch_RMX_CollectionPeriod_CollectionPeriodId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_Batch_RMX_KpiType_KpiTypeId] FOREIGN KEY([KpiTypeId])
REFERENCES [dbo].[RMX_KpiType] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch] CHECK CONSTRAINT [FK_RM_KPI_Collection_Batch_RMX_KpiType_KpiTypeId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch_Dimension]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_Batch_Dimension_RM_KPI_Collection_Batch_KPICollectionBatchId] FOREIGN KEY([KPICollectionBatchId])
REFERENCES [dbo].[RM_KPI_Collection_Batch] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch_Dimension] CHECK CONSTRAINT [FK_RM_KPI_Collection_Batch_Dimension_RM_KPI_Collection_Batch_KPICollectionBatchId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch_Dimension]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_Batch_Dimension_RM_KPI_Collection_Dimension_KPICollectionDimensionId] FOREIGN KEY([KPICollectionDimensionId])
REFERENCES [dbo].[RM_KPI_Collection_Dimension] ([Id])
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Batch_Dimension] CHECK CONSTRAINT [FK_RM_KPI_Collection_Batch_Dimension_RM_KPI_Collection_Dimension_KPICollectionDimensionId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_DataItem]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_DataItem_RM_DataItem_DataItemId] FOREIGN KEY([DataItemId])
REFERENCES [dbo].[RM_DataItem] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPI_Collection_DataItem] CHECK CONSTRAINT [FK_RM_KPI_Collection_DataItem_RM_DataItem_DataItemId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_DataItem]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_DataItem_RM_KPI_Collection_Node_KPICollectionNodeId] FOREIGN KEY([KPICollectionNodeId])
REFERENCES [dbo].[RM_KPI_Collection_Node] ([Id])
GO
ALTER TABLE [dbo].[RM_KPI_Collection_DataItem] CHECK CONSTRAINT [FK_RM_KPI_Collection_DataItem_RM_KPI_Collection_Node_KPICollectionNodeId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Dimension]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_Dimension_RM_AttributeGroup_AttributeId] FOREIGN KEY([AttributeId])
REFERENCES [dbo].[RM_Attribute] ([Id])
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Dimension] CHECK CONSTRAINT [FK_RM_KPI_Collection_Dimension_RM_AttributeGroup_AttributeId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Dimension]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_Dimension_RM_KPI_Collection_DataItem_KPICollectionDataItemId] FOREIGN KEY([KPICollectionDataItemId])
REFERENCES [dbo].[RM_KPI_Collection_DataItem] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Dimension] CHECK CONSTRAINT [FK_RM_KPI_Collection_Dimension_RM_KPI_Collection_DataItem_KPICollectionDataItemId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Dimension]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_Dimension_RM_KPI_Collection_Dimension_ParentKPICollectionDimensionId] FOREIGN KEY([ParentKPICollectionDimensionId])
REFERENCES [dbo].[RM_KPI_Collection_Dimension] ([Id])
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Dimension] CHECK CONSTRAINT [FK_RM_KPI_Collection_Dimension_RM_KPI_Collection_Dimension_ParentKPICollectionDimensionId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Node]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_Node_RM_KPI_Collection_Node_ParentKPICollectionNodeId] FOREIGN KEY([ParentKPICollectionNodeId])
REFERENCES [dbo].[RM_KPI_Collection_Node] ([Id])
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Node] CHECK CONSTRAINT [FK_RM_KPI_Collection_Node_RM_KPI_Collection_Node_ParentKPICollectionNodeId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Node]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_Node_RM_Node_NodeId] FOREIGN KEY([NodeId])
REFERENCES [dbo].[RM_Node] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Node] CHECK CONSTRAINT [FK_RM_KPI_Collection_Node_RM_Node_NodeId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Node]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_Node_RM_Workflow_WorkflowId] FOREIGN KEY([WorkflowId])
REFERENCES [dbo].[RM_Workflow] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Node] CHECK CONSTRAINT [FK_RM_KPI_Collection_Node_RM_Workflow_WorkflowId]
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Node]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPI_Collection_Node_RMX_KpiType_KpiTypeId] FOREIGN KEY([KpiTypeId])
REFERENCES [dbo].[RMX_KpiType] ([Id])
GO
ALTER TABLE [dbo].[RM_KPI_Collection_Node] CHECK CONSTRAINT [FK_RM_KPI_Collection_Node_RMX_KpiType_KpiTypeId]
GO
ALTER TABLE [dbo].[RM_KPICommentaryCompanyAssocation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICommentaryCompanyAssocation_RM_KPICommentary_KPICommentaryId] FOREIGN KEY([KPICommentaryId])
REFERENCES [dbo].[RM_KPICommentary] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICommentaryCompanyAssocation] CHECK CONSTRAINT [FK_RM_KPICommentaryCompanyAssocation_RM_KPICommentary_KPICommentaryId]
GO
ALTER TABLE [dbo].[RM_KPICommentaryCompanyAssocation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICommentaryCompanyAssocation_RM_KPICompanyConfiguration_KPICompanyConfigTemplateId] FOREIGN KEY([KPICompanyConfigTemplateId])
REFERENCES [dbo].[RM_KPICompanyConfiguration] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICommentaryCompanyAssocation] CHECK CONSTRAINT [FK_RM_KPICommentaryCompanyAssocation_RM_KPICompanyConfiguration_KPICompanyConfigTemplateId]
GO
ALTER TABLE [dbo].[RM_KPICommentaryIndustryAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICommentaryIndustryAssociation_RM_KPICommentary_KPICommentaryId] FOREIGN KEY([KPICommentaryId])
REFERENCES [dbo].[RM_KPICommentary] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICommentaryIndustryAssociation] CHECK CONSTRAINT [FK_RM_KPICommentaryIndustryAssociation_RM_KPICommentary_KPICommentaryId]
GO
ALTER TABLE [dbo].[RM_KPICommentaryIndustryAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICommentaryIndustryAssociation_RM_KPIIndustryTemplate_KPIIndustryTemplateId] FOREIGN KEY([KPIIndustryTemplateId])
REFERENCES [dbo].[RM_KPIIndustryTemplate] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICommentaryIndustryAssociation] CHECK CONSTRAINT [FK_RM_KPICommentaryIndustryAssociation_RM_KPIIndustryTemplate_KPIIndustryTemplateId]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigDataItemAttributeAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICompanyConfigDataItemAttributeAssociation_RM_AttributeGroup_AttributeGroupId] FOREIGN KEY([AttributeGroupId])
REFERENCES [dbo].[RM_AttributeGroup] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigDataItemAttributeAssociation] CHECK CONSTRAINT [FK_RM_KPICompanyConfigDataItemAttributeAssociation_RM_AttributeGroup_AttributeGroupId]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigDataItemAttributeAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICompanyConfigDataItemAttributeAssociation_RM_KPICompanyConfigNodeDataItemAssociation_KPICompanyConfigNodeDataItemAssoc~] FOREIGN KEY([KPICompanyConfigNodeDataItemAssociationId])
REFERENCES [dbo].[RM_KPICompanyConfigNodeDataItemAssociation] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigDataItemAttributeAssociation] CHECK CONSTRAINT [FK_RM_KPICompanyConfigDataItemAttributeAssociation_RM_KPICompanyConfigNodeDataItemAssociation_KPICompanyConfigNodeDataItemAssoc~]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigDataItemAttributeAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICompanyConfigDataItemAttributeAssociation_RM_KPICompanyConfiguration_KPICompanyConfigTemplateId] FOREIGN KEY([KPICompanyConfigTemplateId])
REFERENCES [dbo].[RM_KPICompanyConfiguration] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigDataItemAttributeAssociation] CHECK CONSTRAINT [FK_RM_KPICompanyConfigDataItemAttributeAssociation_RM_KPICompanyConfiguration_KPICompanyConfigTemplateId]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICompanyConfigNodeAssociation_RM_KPICompanyConfiguration_KPICompanyConfigurationId] FOREIGN KEY([KPICompanyConfigurationId])
REFERENCES [dbo].[RM_KPICompanyConfiguration] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeAssociation] CHECK CONSTRAINT [FK_RM_KPICompanyConfigNodeAssociation_RM_KPICompanyConfiguration_KPICompanyConfigurationId]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICompanyConfigNodeAssociation_RMX_KpiType_KpiTypeId] FOREIGN KEY([KpiTypeId])
REFERENCES [dbo].[RMX_KpiType] ([Id])
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeAssociation] CHECK CONSTRAINT [FK_RM_KPICompanyConfigNodeAssociation_RMX_KpiType_KpiTypeId]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeDataItemAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICompanyConfigNodeDataItemAssociation_RM_DataItem_DataItemId] FOREIGN KEY([DataItemId])
REFERENCES [dbo].[RM_DataItem] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeDataItemAssociation] CHECK CONSTRAINT [FK_RM_KPICompanyConfigNodeDataItemAssociation_RM_DataItem_DataItemId]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeDataItemAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICompanyConfigNodeDataItemAssociation_RM_KPICompanyConfigNodeAssociation_KPICompanyConfigNodeAssociationId] FOREIGN KEY([KPICompanyConfigNodeAssociationId])
REFERENCES [dbo].[RM_KPICompanyConfigNodeAssociation] ([Id])
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeDataItemAssociation] CHECK CONSTRAINT [FK_RM_KPICompanyConfigNodeDataItemAssociation_RM_KPICompanyConfigNodeAssociation_KPICompanyConfigNodeAssociationId]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeDataItemAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICompanyConfigNodeDataItemAssociation_RM_KPICompanyConfiguration_KPICompanyConfigurationId] FOREIGN KEY([KPICompanyConfigurationId])
REFERENCES [dbo].[RM_KPICompanyConfiguration] ([Id])
GO
ALTER TABLE [dbo].[RM_KPICompanyConfigNodeDataItemAssociation] CHECK CONSTRAINT [FK_RM_KPICompanyConfigNodeDataItemAssociation_RM_KPICompanyConfiguration_KPICompanyConfigurationId]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICompanyConfiguration_RM_Company_CompanyId] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[RM_Company] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICompanyConfiguration] CHECK CONSTRAINT [FK_RM_KPICompanyConfiguration_RM_Company_CompanyId]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICompanyConfiguration_RM_KPIIndustryTemplate_KPIIndustryTemplateId] FOREIGN KEY([KPIIndustryTemplateId])
REFERENCES [dbo].[RM_KPIIndustryTemplate] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICompanyConfiguration] CHECK CONSTRAINT [FK_RM_KPICompanyConfiguration_RM_KPIIndustryTemplate_KPIIndustryTemplateId]
GO
ALTER TABLE [dbo].[RM_KPICompanyConfiguration]  WITH NOCHECK ADD  CONSTRAINT [FK_RM_KPICompanyConfiguration_RMX_CollectionRecurrence_CollectionRecurrenceId] FOREIGN KEY([CollectionRecurrenceId])
REFERENCES [dbo].[RMX_CollectionRecurrence] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICompanyConfiguration] CHECK CONSTRAINT [FK_RM_KPICompanyConfiguration_RMX_CollectionRecurrence_CollectionRecurrenceId]
GO
ALTER TABLE [dbo].[RM_KPICompanyRecurrenceAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICompanyRecurrenceAssociation_RM_KPICompanyConfiguration_KPICompanyConfigurationId] FOREIGN KEY([KPICompanyConfigurationId])
REFERENCES [dbo].[RM_KPICompanyConfiguration] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICompanyRecurrenceAssociation] CHECK CONSTRAINT [FK_RM_KPICompanyRecurrenceAssociation_RM_KPICompanyConfiguration_KPICompanyConfigurationId]
GO
ALTER TABLE [dbo].[RM_KPICompanyRecurrenceAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICompanyRecurrenceAssociation_RMX_CollectionPeriod_CollectionPeriodId] FOREIGN KEY([CollectionPeriodId])
REFERENCES [dbo].[RMX_CollectionPeriod] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICompanyRecurrenceAssociation] CHECK CONSTRAINT [FK_RM_KPICompanyRecurrenceAssociation_RMX_CollectionPeriod_CollectionPeriodId]
GO
ALTER TABLE [dbo].[RM_KPICompanyRecurrenceAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICompanyRecurrenceAssociation_RMX_KpiCategory_KpiCategoryId] FOREIGN KEY([KpiCategoryId])
REFERENCES [dbo].[RMX_KpiCategory] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICompanyRecurrenceAssociation] CHECK CONSTRAINT [FK_RM_KPICompanyRecurrenceAssociation_RMX_KpiCategory_KpiCategoryId]
GO
ALTER TABLE [dbo].[RM_KPICompanyRecurrenceScenarioAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICompanyRecurrenceScenarioAssociation_RM_ClassType_ClassTypeId] FOREIGN KEY([ClassTypeId])
REFERENCES [dbo].[RM_ClassType] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICompanyRecurrenceScenarioAssociation] CHECK CONSTRAINT [FK_RM_KPICompanyRecurrenceScenarioAssociation_RM_ClassType_ClassTypeId]
GO
ALTER TABLE [dbo].[RM_KPICompanyRecurrenceScenarioAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICompanyRecurrenceScenarioAssociation_RM_KPICompanyConfiguration_KPICompanyConfigurationId] FOREIGN KEY([KPICompanyConfigurationId])
REFERENCES [dbo].[RM_KPICompanyConfiguration] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_KPICompanyRecurrenceScenarioAssociation] CHECK CONSTRAINT [FK_RM_KPICompanyRecurrenceScenarioAssociation_RM_KPICompanyConfiguration_KPICompanyConfigurationId]
GO
ALTER TABLE [dbo].[RM_KPICompanyRecurrenceScenarioAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_KPICompanyRecurrenceScenarioAssociation_RM_KPICompanyRecurrenceAssociation_KPICompanyRecurrenceAssociationId] FOREIGN KEY([KPICompanyRecurrenceAssociationId])
REFERENCES [dbo].[RM_KPICompanyRecurrenceAssociation] ([Id])
GO
ALTER TABLE [dbo].[RM_KPICompanyRecurrenceScenarioAssociation] CHECK CONSTRAINT [FK_RM_KPICompanyRecurrenceScenarioAssociation_RM_KPICompanyRecurrenceAssociation_KPICompanyRecurrenceAssociationId]
GO
ALTER TABLE [dbo].[RM_Node]  WITH CHECK ADD FOREIGN KEY([IndustryId])
REFERENCES [dbo].[RM_Industry] ([Id])
GO
ALTER TABLE [dbo].[RM_Node]  WITH NOCHECK ADD  CONSTRAINT [FK_RM_Node_RM_Industry_IndustryId] FOREIGN KEY([IndustryId])
REFERENCES [dbo].[RM_Industry] ([Id])
GO
ALTER TABLE [dbo].[RM_Node] CHECK CONSTRAINT [FK_RM_Node_RM_Industry_IndustryId]
GO
ALTER TABLE [dbo].[RM_Node]  WITH CHECK ADD  CONSTRAINT [FK_RM_Node_RM_Node_ParentNodeId] FOREIGN KEY([ParentNodeId])
REFERENCES [dbo].[RM_Node] ([Id])
GO
ALTER TABLE [dbo].[RM_Node] CHECK CONSTRAINT [FK_RM_Node_RM_Node_ParentNodeId]
GO
ALTER TABLE [dbo].[RM_Node]  WITH CHECK ADD  CONSTRAINT [FK_RM_Node_RMX_KpiType_KPITypeId] FOREIGN KEY([KPITypeId])
REFERENCES [dbo].[RMX_KpiType] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_Node] CHECK CONSTRAINT [FK_RM_Node_RMX_KpiType_KPITypeId]
GO
ALTER TABLE [dbo].[RM_NodeDataItemAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_NodeDataItemAssociation_RM_DataItem_DataItemId] FOREIGN KEY([DataItemId])
REFERENCES [dbo].[RM_DataItem] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_NodeDataItemAssociation] CHECK CONSTRAINT [FK_RM_NodeDataItemAssociation_RM_DataItem_DataItemId]
GO
ALTER TABLE [dbo].[RM_NodeDataItemAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_NodeDataItemAssociation_RM_KPIIndustryTemplate_KPIIndustryTemplateId] FOREIGN KEY([KPIIndustryTemplateId])
REFERENCES [dbo].[RM_KPIIndustryTemplate] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_NodeDataItemAssociation] CHECK CONSTRAINT [FK_RM_NodeDataItemAssociation_RM_KPIIndustryTemplate_KPIIndustryTemplateId]
GO
ALTER TABLE [dbo].[RM_NodeDataItemAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_NodeDataItemAssociation_RM_NodeIndustryAssociation_NodeIndustryAssociationId] FOREIGN KEY([NodeIndustryAssociationId])
REFERENCES [dbo].[RM_NodeIndustryAssociation] ([Id])
GO
ALTER TABLE [dbo].[RM_NodeDataItemAssociation] CHECK CONSTRAINT [FK_RM_NodeDataItemAssociation_RM_NodeIndustryAssociation_NodeIndustryAssociationId]
GO
ALTER TABLE [dbo].[RM_NodeIndustryAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_NodeIndustryAssociation_RM_KPIIndustryTemplate_KPIIndustryTemplateId] FOREIGN KEY([KPIIndustryTemplateId])
REFERENCES [dbo].[RM_KPIIndustryTemplate] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_NodeIndustryAssociation] CHECK CONSTRAINT [FK_RM_NodeIndustryAssociation_RM_KPIIndustryTemplate_KPIIndustryTemplateId]
GO
ALTER TABLE [dbo].[RM_Workflow]  WITH CHECK ADD  CONSTRAINT [FK_RM_Workflow_RM_Company_CompanyId] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[RM_Company] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_Workflow] CHECK CONSTRAINT [FK_RM_Workflow_RM_Company_CompanyId]
GO
ALTER TABLE [dbo].[RM_Workflow]  WITH CHECK ADD  CONSTRAINT [FK_RM_Workflow_RMX_KpiCategory_KpiCategoryId] FOREIGN KEY([KpiCategoryId])
REFERENCES [dbo].[RMX_KpiCategory] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_Workflow] CHECK CONSTRAINT [FK_RM_Workflow_RMX_KpiCategory_KpiCategoryId]
GO
ALTER TABLE [dbo].[RM_Workflow]  WITH CHECK ADD  CONSTRAINT [FK_RM_Workflow_RMX_WorkflowStatus_WorkflowStatusId] FOREIGN KEY([WorkflowStatusId])
REFERENCES [dbo].[RMX_WorkflowStatus] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_Workflow] CHECK CONSTRAINT [FK_RM_Workflow_RMX_WorkflowStatus_WorkflowStatusId]
GO
ALTER TABLE [dbo].[RM_WorkflowClassAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_WorkflowClassAssociation_RM_ClassType_ClassTypeId] FOREIGN KEY([ClassTypeId])
REFERENCES [dbo].[RM_ClassType] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_WorkflowClassAssociation] CHECK CONSTRAINT [FK_RM_WorkflowClassAssociation_RM_ClassType_ClassTypeId]
GO
ALTER TABLE [dbo].[RM_WorkflowClassAssociation]  WITH CHECK ADD  CONSTRAINT [FK_RM_WorkflowClassAssociation_RM_Workflow_WorkflowId] FOREIGN KEY([WorkflowId])
REFERENCES [dbo].[RM_Workflow] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_WorkflowClassAssociation] CHECK CONSTRAINT [FK_RM_WorkflowClassAssociation_RM_Workflow_WorkflowId]
GO
ALTER TABLE [dbo].[RM_WorkflowDocument]  WITH CHECK ADD  CONSTRAINT [FK_RM_WorkflowDocument_RM_Workflow_WorkflowId] FOREIGN KEY([WorkflowId])
REFERENCES [dbo].[RM_Workflow] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_WorkflowDocument] CHECK CONSTRAINT [FK_RM_WorkflowDocument_RM_Workflow_WorkflowId]
GO
ALTER TABLE [dbo].[RM_WorkflowDocument]  WITH NOCHECK ADD  CONSTRAINT [FK_RM_WorkflowDocument_RMX_WorkflowStatus_WorkflowStatusId] FOREIGN KEY([WorkflowStatusId])
REFERENCES [dbo].[RMX_WorkflowStatus] ([Id])
GO
ALTER TABLE [dbo].[RM_WorkflowDocument] CHECK CONSTRAINT [FK_RM_WorkflowDocument_RMX_WorkflowStatus_WorkflowStatusId]
GO
ALTER TABLE [dbo].[RM_WorkflowStatusHistory]  WITH CHECK ADD  CONSTRAINT [FK_RM_WorkflowStatusHistory_RM_Workflow_WorkflowId] FOREIGN KEY([WorkflowId])
REFERENCES [dbo].[RM_Workflow] ([Id])
GO
ALTER TABLE [dbo].[RM_WorkflowStatusHistory] CHECK CONSTRAINT [FK_RM_WorkflowStatusHistory_RM_Workflow_WorkflowId]
GO
ALTER TABLE [dbo].[RM_WorkflowStatusHistory]  WITH CHECK ADD  CONSTRAINT [FK_RM_WorkflowStatusHistory_RMX_WorkflowStatus_WorkflowStatusId] FOREIGN KEY([WorkflowStatusId])
REFERENCES [dbo].[RMX_WorkflowStatus] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RM_WorkflowStatusHistory] CHECK CONSTRAINT [FK_RM_WorkflowStatusHistory_RMX_WorkflowStatus_WorkflowStatusId]
GO
