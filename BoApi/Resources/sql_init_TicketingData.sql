--GO
BEGIN TRAN
BEGIN TRY  
    -- [RoomTypes]
    IF NOT EXISTS (SELECT * FROM [tickets].[RoomTypes] WHERE [CODE] = 'DEF')
    BEGIN
        INSERT INTO [tickets].[RoomTypes] ([Deleted], [Active], [Code], [Name], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, 'DEF', N'Default', NEWID(), GETDATE(), GETDATE());
    END
    
    -- [OperationalHours]
    IF NOT EXISTS (SELECT * FROM [tickets].[OperationalHours] WHERE [FromTime] = '08:00' AND [ToTime] = '20:00')
    BEGIN
        INSERT INTO [tickets].[OperationalHours] ([Deleted], [Active], [FromTime], [ToTime], [Id], [CreatedDate], [UpdatedDate]) 
        VALUES(0, 1, '08:00', '20:00', NEWID(), GETDATE(), GETDATE());
    END
    IF NOT EXISTS (SELECT * FROM [tickets].[OperationalHours] WHERE [FromTime] = '08:30' AND [ToTime] = '20:00')
    BEGIN
        INSERT INTO [tickets].[OperationalHours] ([Deleted], [Active], [FromTime], [ToTime], [Id], [CreatedDate], [UpdatedDate]) 
        VALUES(0, 1, '08:30', '20:00', NEWID(), GETDATE(), GETDATE());
    END
    IF NOT EXISTS (SELECT * FROM [tickets].[OperationalHours] WHERE [FromTime] = '09:00' AND [ToTime] = '20:00')
    BEGIN
        INSERT INTO [tickets].[OperationalHours] ([Deleted], [Active], [FromTime], [ToTime], [Id], [CreatedDate], [UpdatedDate]) 
        VALUES(0, 1, '09:00', '20:00', NEWID(), GETDATE(), GETDATE());
    END
    IF NOT EXISTS (SELECT * FROM [tickets].[OperationalHours] WHERE [FromTime] = '09:30' AND [ToTime] = '20:00')
    BEGIN
        INSERT INTO [tickets].[OperationalHours] ([Deleted], [Active], [FromTime], [ToTime], [Id], [CreatedDate], [UpdatedDate]) 
        VALUES(0, 1, '09:30', '20:00', NEWID(), GETDATE(), GETDATE());
    END
    IF NOT EXISTS (SELECT * FROM [tickets].[OperationalHours] WHERE [FromTime] = '10:00' AND [ToTime] = '20:00')
    BEGIN
        INSERT INTO [tickets].[OperationalHours] ([Deleted], [Active], [FromTime], [ToTime], [Id], [CreatedDate], [UpdatedDate]) 
        VALUES(0, 1, '10:00', '20:00', NEWID(), GETDATE(), GETDATE());
    END
    IF NOT EXISTS (SELECT * FROM [tickets].[OperationalHours] WHERE [FromTime] = '08:00' AND [ToTime] = '21:00')
    BEGIN
        INSERT INTO [tickets].[OperationalHours] ([Deleted], [Active], [FromTime], [ToTime], [Id], [CreatedDate], [UpdatedDate]) 
        VALUES(0, 1, '08:00', '21:00', NEWID(), GETDATE(), GETDATE());
    END
    IF NOT EXISTS (SELECT * FROM [tickets].[OperationalHours] WHERE [FromTime] = '08:30' AND [ToTime] = '21:00')
    BEGIN
        INSERT INTO [tickets].[OperationalHours] ([Deleted], [Active], [FromTime], [ToTime], [Id], [CreatedDate], [UpdatedDate]) 
        VALUES(0, 1, '08:30', '21:00', NEWID(), GETDATE(), GETDATE());
    END
    IF NOT EXISTS (SELECT * FROM [tickets].[OperationalHours] WHERE [FromTime] = '09:00' AND [ToTime] = '21:00')
    BEGIN
        INSERT INTO [tickets].[OperationalHours] ([Deleted], [Active], [FromTime], [ToTime], [Id], [CreatedDate], [UpdatedDate]) 
        VALUES(0, 1, '09:00', '21:00', NEWID(), GETDATE(), GETDATE());
    END
    IF NOT EXISTS (SELECT * FROM [tickets].[OperationalHours] WHERE [FromTime] = '09:30' AND [ToTime] = '21:00')
    BEGIN
        INSERT INTO [tickets].[OperationalHours] ([Deleted], [Active], [FromTime], [ToTime], [Id], [CreatedDate], [UpdatedDate]) 
        VALUES(0, 1, '09:30', '21:00', NEWID(), GETDATE(), GETDATE());
    END
    IF NOT EXISTS (SELECT * FROM [tickets].[OperationalHours] WHERE [FromTime] = '10:00' AND [ToTime] = '21:00')
    BEGIN
        INSERT INTO [tickets].[OperationalHours] ([Deleted], [Active], [FromTime], [ToTime], [Id], [CreatedDate], [UpdatedDate]) 
        VALUES(0, 1, '10:00', '21:00', NEWID(), GETDATE(), GETDATE());
    END
    IF NOT EXISTS (SELECT * FROM [tickets].[OperationalHours] WHERE [FromTime] = '08:00' AND [ToTime] = '21:30')
    BEGIN
        INSERT INTO [tickets].[OperationalHours] ([Deleted], [Active], [FromTime], [ToTime], [Id], [CreatedDate], [UpdatedDate]) 
        VALUES(0, 1, '08:00', '21:30', NEWID(), GETDATE(), GETDATE());
    END
    IF NOT EXISTS (SELECT * FROM [tickets].[OperationalHours] WHERE [FromTime] = '08:30' AND [ToTime] = '21:30')
    BEGIN
        INSERT INTO [tickets].[OperationalHours] ([Deleted], [Active], [FromTime], [ToTime], [Id], [CreatedDate], [UpdatedDate]) 
        VALUES(0, 1, '08:30', '21:30', NEWID(), GETDATE(), GETDATE());
    END
    IF NOT EXISTS (SELECT * FROM [tickets].[OperationalHours] WHERE [FromTime] = '09:00' AND [ToTime] = '21:30')
    BEGIN
        INSERT INTO [tickets].[OperationalHours] ([Deleted], [Active], [FromTime], [ToTime], [Id], [CreatedDate], [UpdatedDate]) 
        VALUES(0, 1, '09:00', '21:30', NEWID(), GETDATE(), GETDATE());
    END
    IF NOT EXISTS (SELECT * FROM [tickets].[OperationalHours] WHERE [FromTime] = '09:30' AND [ToTime] = '21:30')
    BEGIN
        INSERT INTO [tickets].[OperationalHours] ([Deleted], [Active], [FromTime], [ToTime], [Id], [CreatedDate], [UpdatedDate]) 
        VALUES(0, 1, '09:30', '21:30', NEWID(), GETDATE(), GETDATE());
    END
    IF NOT EXISTS (SELECT * FROM [tickets].[OperationalHours] WHERE [FromTime] = '10:00' AND [ToTime] = '21:30')
    BEGIN
        INSERT INTO [tickets].[OperationalHours] ([Deleted], [Active], [FromTime], [ToTime], [Id], [CreatedDate], [UpdatedDate]) 
        VALUES(0, 1, '10:00', '21:30', NEWID(), GETDATE(), GETDATE());
    END

	--- AvailabilityGroups
	IF NOT EXISTS (SELECT * FROM [tickets].[AvailabilityGroups] WHERE [CODE] = N'DEF')
    BEGIN
        INSERT INTO [tickets].[AvailabilityGroups] ([Deleted], [Active], [Code], [Name], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, 'DEF', N'Default', NEWID(), GETDATE(), GETDATE());
    END
	--- End AvailabilityGroups

	--- PostageCosts
	IF NOT EXISTS (SELECT * FROM [tickets].[PostageCosts] WHERE [CODE] = N'DEF')
    BEGIN
        INSERT INTO [tickets].[PostageCosts] ([Deleted], [Active], [Code], [Name], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, 'DEF', N'Default', NEWID(), GETDATE(), GETDATE());
    END
	--- End PostageCosts

	--- RedemptionTypes
	IF NOT EXISTS (SELECT * FROM [tickets].[RedemptionTypes] WHERE [CODE] = N'VON')
    BEGIN
        INSERT INTO [tickets].[RedemptionTypes] ([Deleted], [Active], [Code], [Name], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, 'VON', N'Validate Online', NEWID(), GETDATE(), GETDATE());
    END

	IF NOT EXISTS (SELECT * FROM [tickets].[RedemptionTypes] WHERE [CODE] = N'AON')
    BEGIN
        INSERT INTO [tickets].[RedemptionTypes] ([Deleted], [Active], [Code], [Name], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, 'AON', N'Attempt Online', NEWID(), GETDATE(), GETDATE());
    END

	IF NOT EXISTS (SELECT * FROM [tickets].[RedemptionTypes] WHERE [CODE] = N'VOFF')
    BEGIN
        INSERT INTO [tickets].[RedemptionTypes] ([Deleted], [Active], [Code], [Name], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, 'VOFF', N'Accept Offline', NEWID(), GETDATE(), GETDATE());
    END
	--- End RedemptionTypes

	--- PriceTypes
	IF NOT EXISTS ( SELECT * FROM [tickets].[PriceTypes] WHERE [Code] = N'STD')
	BEGIN
		INSERT INTO [tickets].[PriceTypes] ([Deleted], [Active], [Name], [Code], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Standard', N'STD', NEWID(), GETDATE(), GETDATE());
	END
	--- End PriceTypes

	--- PriceBands
	IF NOT EXISTS ( SELECT * FROM [tickets].[PriceBands] WHERE [Code] = N'GOLD')
	BEGIN
		INSERT INTO [tickets].[PriceBands] ([Deleted], [Active], [Name], [Code], [Id], [CreatedDate], [UpdatedDate], [Default]) VALUES(0, 1, N'Gold', N'GOLD', NEWID(), GETDATE(), GETDATE(), 0);
	END

	IF NOT EXISTS ( SELECT * FROM [tickets].[PriceBands] WHERE [Code] = N'SILVER')
	BEGIN
		INSERT INTO [tickets].[PriceBands] ([Deleted], [Active], [Name], [Code], [Id], [CreatedDate], [UpdatedDate], [Default]) VALUES(0, 1, N'Silver', N'SILVER', NEWID(), GETDATE(), GETDATE(), 1);
	END
	--- End PriceBands

	--- TicketGroups
	IF NOT EXISTS ( SELECT * FROM [tickets].[TicketGroups] WHERE [Code] = N'DEF')
	BEGIN
		INSERT INTO [tickets].[TicketGroups] ([Deleted], [Active], [Name], [Code], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Default', N'DEF', NEWID(), GETDATE(), GETDATE());
	END
	--- End TicketGroups

	--- SaleChannels
	IF NOT EXISTS ( SELECT * FROM [tickets].[SaleChannels] WHERE [Code] = N'WEB')
	BEGIN
		INSERT INTO [tickets].[SaleChannels] ([Deleted], [Active], [Name], [Code], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Web', N'WEB', NEWID(), GETDATE(), GETDATE());
	END

    IF NOT EXISTS ( SELECT * FROM [tickets].[SaleChannels] WHERE [Code] = N'KIOSK')
	BEGIN
		INSERT INTO [tickets].[SaleChannels] ([Deleted], [Active], [Name], [Code], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Kiosk', N'KIOSK', NEWID(), GETDATE(), GETDATE());
	END

    IF NOT EXISTS ( SELECT * FROM [tickets].[SaleChannels] WHERE [Code] = N'MD')
	BEGIN
		INSERT INTO [tickets].[SaleChannels] ([Deleted], [Active], [Name], [Code], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Mobile Device', N'MD', NEWID(), GETDATE(), GETDATE());
	END

    IF NOT EXISTS ( SELECT * FROM [tickets].[SaleChannels] WHERE [Code] = N'BO')
	BEGIN
		INSERT INTO [tickets].[SaleChannels] ([Deleted], [Active], [Name], [Code], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Back Office', N'BO', NEWID(), GETDATE(), GETDATE());
	END
	--- End SaleChannels

	--- RefundPolicies
	IF NOT EXISTS ( SELECT * FROM [tickets].[RefundPolicies] WHERE [Code] = N'DEF')
	BEGIN
		INSERT INTO [tickets].[RefundPolicies] ([Deleted], [Active], [Name], [Code], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Default', N'DEF', NEWID(), GETDATE(), GETDATE());
	END
	--- End RefundPolicies

	--- TicketProperties
	IF NOT EXISTS ( SELECT * FROM [tickets].[TicketProperties] WHERE [Code] = N'STD')
	BEGIN
		INSERT INTO [tickets].[TicketProperties] ([Deleted], [Active], [Name], [Code], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Standard ticket', N'STD', NEWID(), GETDATE(), GETDATE());
	END

	IF NOT EXISTS ( SELECT * FROM [tickets].[TicketProperties] WHERE [Code] = N'SMT')
	BEGIN
		INSERT INTO [tickets].[TicketProperties] ([Deleted], [Active], [Name], [Code], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Smartcard ticket', N'SMT', NEWID(), GETDATE(), GETDATE());
	END
	--- End TicketProperties

	--- TicketingBoNumer
    IF NOT EXISTS (SELECT * FROM [tickets].[BONumber])
	BEGIN
		INSERT INTO [tickets].[BONumber] ([Deleted], [Active], [SequenceNumber], [Id], [CreatedDate], [UpdatedDate]) 
        VALUES(0, 1, 1000000000000000, NEWID(), GETDATE(), GETDATE());
	END
	--- TicketingBoNumer

	COMMIT
END TRY  
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrorMessage;  
	ROLLBACK TRAN
END CATCH