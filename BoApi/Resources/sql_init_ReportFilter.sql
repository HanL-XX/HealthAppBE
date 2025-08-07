--- Report Setup Init ---
SET IDENTITY_INSERT [dbo].[ReportSetups] ON

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 1)
DELETE FROM [dbo].[ReportSetups] where [Id] = 1

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 1)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Product Export Code', 1);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 2)
DELETE FROM [dbo].[ReportSetups] where [Id] = 2

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 2)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Tender Export Code', 2);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 3)
Update [dbo].[ReportSetups] set [Name] = 'Ticketing Commission Report' where [Id] = 3

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 3)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Ticketing Commission Report', 3);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 4)
DELETE FROM [dbo].[ReportSetups] where [Id] = 4

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 4)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Declaration Report', 4);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 5)
DELETE FROM [dbo].[ReportSetups] where [Id] = 5

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 5)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'No Sale Report', 5);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 6)
DELETE FROM [dbo].[ReportSetups] where [Id] = 6

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 6)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Sales Report', 6);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 7)
DELETE FROM [dbo].[ReportSetups] where [Id] = 7

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 7)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Good Receipt', 7);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 8)
DELETE FROM [dbo].[ReportSetups] where [Id] = 8

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 8)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Supplier Catalogue', 8);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 9)
DELETE FROM [dbo].[ReportSetups] where [Id] = 9

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 9)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Order To Supplier', 9);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 10)
DELETE FROM [dbo].[ReportSetups] where [Id] = 10

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 10)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Stock Adjustment Details', 10);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 11)
DELETE FROM [dbo].[ReportSetups] where [Id] = 11

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 11)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Order To Suppliers Report', 11);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 12)
DELETE FROM [dbo].[ReportSetups] where [Id] = 12

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 12)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Stock Holding Report', 12);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 13)
DELETE FROM [dbo].[ReportSetups] where [Id] = 13

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 13)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Historical Stock Holding Report', 13);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 14)
DELETE FROM [dbo].[ReportSetups] where [Id] = 14

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 14)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Stock Transfer Details', 14);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 15)
DELETE FROM [dbo].[ReportSetups] where [Id] = 15

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 15)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Item Movement Report', 15);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 16)
DELETE FROM [dbo].[ReportSetups] where [Id] = 16

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 16)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Supplier Report', 16);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 17)
DELETE FROM [dbo].[ReportSetups] where [Id] = 17

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 17)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Stock Valuation Report', 17);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 18)
DELETE FROM [dbo].[ReportSetups] where [Id] = 18

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 18)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Stock Count Report', 18);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 19)
DELETE FROM [dbo].[ReportSetups] where [Id] = 19

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 19)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Historical Stock Valuation Report', 19);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 20)
DELETE FROM [dbo].[ReportSetups] where [Id] = 20

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 20)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Product Report', 20);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 21)
DELETE FROM [dbo].[ReportSetups] where [Id] = 21

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 21)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Product Cost Report', 21);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 22)
DELETE FROM [dbo].[ReportSetups] where [Id] = 22

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 22)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Product Price List Report', 22);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 23)
DELETE FROM [dbo].[ReportSetups] where [Id] = 23

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 23)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Sync Report', 23);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 24)
DELETE FROM [dbo].[ReportSetups] where [Id] = 24

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 24)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Ticket Data Report', 24);
END

IF EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 25)
DELETE FROM [dbo].[ReportSetups] where [Id] = 25

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 25)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Audit Report', 25);
END

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 26)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Negative Stock Sales Report', 26);
END

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 27)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Product Profitability Report', 27);
END

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 28)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Sales', 28);
END

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 29)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Sales Payment Report', 29);
END

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 30)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Best Sellers With Profit Report', 30);
END

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 31)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Stock Replenishment Report', 31);
END

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 32)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Discount Report', 32);
END

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 33)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Refund Report', 33);
END

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 34)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Member Activities Report', 34);
END

IF NOT EXISTS (SELECT * FROM [dbo].[ReportSetups] where [Id] = 35)
BEGIN
	Insert into [dbo].ReportSetups([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Voided Transactions Report', 35);
END

SET IDENTITY_INSERT [dbo].[ReportSetups] OFF

--- Report Filter Init ---

SET IDENTITY_INSERT [dbo].[ReportFilters] ON

IF EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 1)
DELETE FROM [dbo].[ReportFilters] where [Id] = 1

IF NOT EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 1)
BEGIN
	Insert into [dbo].ReportFilters([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Branch Group', 1);
END

IF EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 2)
DELETE FROM [dbo].[ReportFilters] where [Id] = 2

IF NOT EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 2)
BEGIN
	Insert into [dbo].ReportFilters([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Branch', 2);
END

IF EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 3)
DELETE FROM [dbo].[ReportFilters] where [Id] = 3

IF NOT EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 3)
BEGIN
	Insert into [dbo].ReportFilters([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Supplier Name', 3);
END

IF EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 4)
DELETE FROM [dbo].[ReportFilters] where [Id] = 4

IF NOT EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 4)
BEGIN
	Insert into [dbo].ReportFilters([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Product Name', 4);
END

IF EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 5)
DELETE FROM [dbo].[ReportFilters] where [Id] = 5

IF NOT EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 5)
BEGIN
	Insert into [dbo].ReportFilters([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Product Code', 5);
END

IF EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 6)
DELETE FROM [dbo].[ReportFilters] where [Id] = 6

IF NOT EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 6)
BEGIN
	Insert into [dbo].ReportFilters([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Product Group', 6);
END

IF EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 7)
DELETE FROM [dbo].[ReportFilters] where [Id] = 7

IF NOT EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 7)
BEGIN
	Insert into [dbo].ReportFilters([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Product Sub Group', 7);
END

IF EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 8)
DELETE FROM [dbo].[ReportFilters] where [Id] = 8

IF NOT EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 8)
BEGIN
	Insert into [dbo].ReportFilters([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Product Tag', 8);
END

IF EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 9)
DELETE FROM [dbo].[ReportFilters] where [Id] = 9

IF NOT EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 9)
BEGIN
	Insert into [dbo].ReportFilters([Deleted], [Active], [Name], [Id]) Values (0, 1, 'Product Type', 9);
END

IF EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 10)
DELETE FROM [dbo].[ReportFilters] where [Id] = 10

IF NOT EXISTS (SELECT * FROM [dbo].[ReportFilters] where [Id] = 10)
BEGIN
	Insert into [dbo].ReportFilters([Deleted], [Active], [Name], [Id]) Values (0, 1, 'To Branch', 10);
END

SET IDENTITY_INSERT [dbo].[ReportFilters] OFF