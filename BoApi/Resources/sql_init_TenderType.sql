GO
BEGIN TRAN
BEGIN TRY  
	IF NOT EXISTS ( SELECT * FROM [dbo].[TenderTypes] WHERE [NAME] = N'Cash')
	BEGIN
		INSERT INTO [dbo].[TenderTypes] ([Deleted], [Active], [Code], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, '100', N'Cash', N'Update soon', NEWID(), GETDATE(), GETDATE());
	END
	
	IF NOT EXISTS (SELECT * FROM [dbo].[TenderTypes] WHERE [NAME] = N'Card')
	BEGIN
		INSERT INTO  [dbo].[TenderTypes] ([Deleted], [Active], [Code], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, '101', N'Card', N'Update soon', NEWID(), GETDATE(), GETDATE());
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[TenderTypes] WHERE [NAME] = N'Voucher')
	BEGIN
		INSERT INTO [dbo].[TenderTypes] ([Deleted], [Active], [Code], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, '102', N'Voucher', N'Update soon', NEWID(), GETDATE(), GETDATE());
	END
	
	IF NOT EXISTS (SELECT * FROM [dbo].[TenderTypes] WHERE [NAME] = N'Other')
	BEGIN
		INSERT INTO [dbo].[TenderTypes] ([Deleted], [Active], [Code], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, '103', N'Other', N'Update soon', NEWID(), GETDATE(), GETDATE());
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[TenderTypes] WHERE [NAME] = N'Discount')
	BEGIN
		INSERT INTO [dbo].[TenderTypes] ([Deleted], [Active], [Code], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, '104', N'Discount', N'Update soon', NEWID(), GETDATE(), GETDATE());
	END

	COMMIT
END TRY  
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrorMessage;  
	ROLLBACK TRAN
END CATCH
