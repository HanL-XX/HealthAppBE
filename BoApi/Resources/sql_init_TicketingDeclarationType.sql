GO
BEGIN TRAN
BEGIN TRY

    IF NOT EXISTS (SELECT * FROM [tickets].[DeclarationTypes] WHERE [NAME] = N'Cash')
    BEGIN
        DELETE FROM [tickets].[DeclarationTypes] WHERE [CODE] = '001'
        INSERT INTO [tickets].[DeclarationTypes] ([Deleted], [Active], [Code], [Name], [Tolerance], [Type], [TypeOfDeclaration], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, '001', N'Cash', 0, 1, 1, NEWID(), GETDATE(), GETDATE());
    END

    IF NOT EXISTS (SELECT * FROM [tickets].[DeclarationTypes] WHERE [NAME] = N'Card')
    BEGIN
        DELETE FROM [tickets].[DeclarationTypes] WHERE [CODE] = '002'
        INSERT INTO [tickets].[DeclarationTypes] ([Deleted], [Active], [Code], [Name], [Tolerance], [Type], [TypeOfDeclaration], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, '002', N'Card', 0, 1, 1, NEWID(), GETDATE(), GETDATE());
    END

    IF NOT EXISTS (SELECT * FROM [tickets].[DeclarationTypes] WHERE [NAME] = N'Refunds')
    BEGIN
        DELETE FROM [tickets].[DeclarationTypes] WHERE [CODE] = '003'
        INSERT INTO [tickets].[DeclarationTypes] ([Deleted], [Active], [Code], [Name], [Tolerance], [Type], [TypeOfDeclaration], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, '003', N'Refunds', 0, 1, 1, NEWID(), GETDATE(), GETDATE());
    END

    IF NOT EXISTS (SELECT * FROM [tickets].[DeclarationTypes] WHERE [NAME] = N'Float')
    BEGIN
        DELETE FROM [tickets].[DeclarationTypes] WHERE [CODE] = '004'
        INSERT INTO [tickets].[DeclarationTypes] ([Deleted], [Active], [Code], [Name], [Tolerance], [Type], [TypeOfDeclaration], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, '004', N'Float', 0, 1, 1, NEWID(), GETDATE(), GETDATE());
    END

    IF NOT EXISTS (SELECT * FROM [tickets].[DeclarationTypes] WHERE [NAME] = N'Account')
    BEGIN
        DELETE FROM [tickets].[DeclarationTypes] WHERE [CODE] = '005'
        INSERT INTO [tickets].[DeclarationTypes] ([Deleted], [Active], [Code], [Name], [Tolerance], [Type], [TypeOfDeclaration], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, '005', N'Account', 0, 1, 1, NEWID(), GETDATE(), GETDATE());
    END

    IF NOT EXISTS (SELECT * FROM [tickets].[DeclarationTypes] WHERE [NAME] = N'Voucher')
    BEGIN
        DELETE FROM [tickets].[DeclarationTypes] WHERE [CODE] = '006'
        INSERT INTO [tickets].[DeclarationTypes] ([Deleted], [Active], [Code], [Name], [Tolerance], [Type], [TypeOfDeclaration], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, '006', N'Voucher', 0, 1, 1, NEWID(), GETDATE(), GETDATE());
    END

    IF NOT EXISTS (SELECT * FROM [tickets].[DeclarationTypes] WHERE [NAME] = N'Credit Note')
    BEGIN
        DELETE FROM [tickets].[DeclarationTypes] WHERE [CODE] = '007'
        INSERT INTO [tickets].[DeclarationTypes] ([Deleted], [Active], [Code], [Name], [Tolerance], [Type], [TypeOfDeclaration], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, '007', N'Credit Note', 0, 1, 1, NEWID(), GETDATE(), GETDATE());
    END

    COMMIT
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS ErrorMeasage;
    ROLLBACK
END CATCH