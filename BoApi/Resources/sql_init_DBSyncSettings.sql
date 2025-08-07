DELETE [dbo].BranchDbSyncSettingMaps
DBCC CHECKIDENT ('BranchDbSyncSettingMaps', RESEED, 0)
DELETE [dbo].DBSyncSettings
DBCC CHECKIDENT ('DBSyncSettings', RESEED, 0)

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Upload Sales')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 0, N'Upload Sales', NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Device status')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 0, N'Device status', NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Device Messages')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 0, N'Device Messages', NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Devices')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Devices', 'Branches,PriceLevels,SaleLocations,DeviceTypes,DeviceVersions,Devices');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'DeviceVersions')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'DeviceVersions', 'DeviceTypes,DeviceVersions');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Tenders')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Tenders', 'TenderTypes,Tenders');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Products')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Products', 'ProductGroups,Products,ProductDimensions,TaxGroups,Taxes,ProductDimensionPrices,Tags,ProductTagMaps');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Currencies')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Currencies', 'CurrencySettings,CurrencyRateMaps');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Accounts')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Accounts', 'AspNetUsers');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'ProductQuestions')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'ProductQuestions', 'ProductQuestions,ProductAnswers,ProductQuestionProductMaps');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'ScreenLayouts')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'ScreenLayouts', 'ScreenLayouts,ScreenLayoutFolders');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Reasons')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Reasons', 'Reasons');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Offers And Schedules')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Offers And Schedules', 'Schedules,OfferDiscounts,OfferDiscountProductTagMaps');
END
IF EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Offers And Schedules')
BEGIN
	UPDATE [DBSyncSettings] SET [TableNeeds] = 'Schedules,OfferDiscounts,OfferDiscountProductTagMaps,OfferDiscountBranchMaps' where [Name] = N'Offers And Schedules';
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Vehicles')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Vehicles', 'Vehicles');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Departures')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Departures', 'Departures,DepartureVehicleMaps,DepartureLocationMaps');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Declaration Types')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Declaration Types', 'DeclarationTypes');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'BarCodes')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'BarCodes', N'BarCodes');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Settings')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Settings', 'Settings');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Routes')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Routes', 'Branches,Routes,BranchRouteMaps');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Print Templates')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Print Templates', 'Branches,PrintTemplates,PrintTemplateBranchMaps');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'Credit Notes')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Credit Notes', 'CreditNotes');
END


IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'TenderTypeTagMaps')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'TenderTypeTagMaps', 'TenderTypeTagMaps');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'DeviceMessages')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'DeviceMessages', 'DeviceMessages');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'CurrentStockHoldings')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'CurrentStockHoldings', 'BranchProductMaps');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'StockCounts')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'StockCounts', 'StockCounts');
END

IF NOT EXISTS (SELECT * FROM [dbo].[DBSyncSettings] where [Name] = N'StockProductTags')
BEGIN
	INSERT INTO [dbo].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'StockProductTags', 'StockProductTags, StockProductTagMaps');
END


insert INTO [dbo].[BranchDbSyncSettingMaps](BranchId, DBSyncSettingId, Active, Deleted, CreatedDate, UpdatedDate)
select
	b.Id,
	db.Id,
	1,
	0,
	GETDATE(),
	GETDATE()
from
	dbo.Branches b, dbo.DBSyncSettings db
where
	b.Deleted = 0 
	and
	db.Deleted = 0
	AND NOT EXISTS
	(
		SELECT * FROM [dbo].BranchDbSyncSettingMaps WHERE BranchId = B.Id AND DBSyncSettingId = db.Id
	)