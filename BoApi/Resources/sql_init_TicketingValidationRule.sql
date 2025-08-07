GO
BEGIN TRAN
BEGIN TRY  
	IF NOT EXISTS ( SELECT * FROM [tickets].[ValidationRules] WHERE [NAME] = N'Single use')
	BEGIN
		INSERT INTO [tickets].[ValidationRules] ([Deleted], [Active], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Single use', N'This ticket can only be used once for the specified date', NEWID(), GETDATE(), GETDATE());
	END
	
	IF NOT EXISTS ( SELECT * FROM [tickets].[ValidationRules] WHERE [NAME] = N'Same day return')
	BEGIN
		INSERT INTO [tickets].[ValidationRules] ([Deleted], [Active], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Same day return', N'This ticket can be scanned twice on the same date', NEWID(), GETDATE(), GETDATE());
	END

	IF NOT EXISTS ( SELECT * FROM [tickets].[ValidationRules] WHERE [NAME] = N'Valid for 3 months')
	BEGIN
		INSERT INTO [tickets].[ValidationRules] ([Deleted], [Active], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Valid for 3 months', N'The first use can be scanned on the day of travel, the return is valid for 3 months only. If the ticket has not been scanned on the day of travel then the return is also invalid', NEWID(), GETDATE(), GETDATE());
	END

	IF NOT EXISTS ( SELECT * FROM [tickets].[ValidationRules] WHERE [NAME] = N'Valid for one calendar day')
	BEGIN
		INSERT INTO [tickets].[ValidationRules] ([Deleted], [Active], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Valid for one calendar day', N'This ticket is only valid for multi use on a single calendar day.', NEWID(), GETDATE(), GETDATE());
	END

	IF NOT EXISTS ( SELECT * FROM [tickets].[ValidationRules] WHERE [NAME] = N'No validation')
	BEGIN
		INSERT INTO [tickets].[ValidationRules] ([Deleted], [Active], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'No validation', N'There is no validation.', NEWID(), GETDATE(), GETDATE());
	END

	IF NOT EXISTS ( SELECT * FROM [tickets].[ValidationRules] WHERE [NAME] = N'Day ticket')
	BEGIN
		INSERT INTO [tickets].[ValidationRules] ([Deleted], [Active], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Day ticket', N'All-day ticket. The customer can use this ticket for the entire calendar day.', NEWID(), GETDATE(), GETDATE());
	END

	IF NOT EXISTS ( SELECT * FROM [tickets].[ValidationRules] WHERE [NAME] = N'Explorer pass')
	BEGIN
		INSERT INTO [tickets].[ValidationRules] ([Deleted], [Active], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Explorer pass', N'7 day ticket. Once activated via the first scan, the ticket is only valid for three days only.', NEWID(), GETDATE(), GETDATE());
	END

	IF NOT EXISTS ( SELECT * FROM [tickets].[ValidationRules] WHERE [NAME] = N'Explorer pass 7 in 14 day')
	BEGIN
		INSERT INTO [tickets].[ValidationRules] ([Deleted], [Active], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Explorer pass 7 in 14 day', N'Once first scanned, the customer should have 14 days in which to use the pass, but should only be able to be scanned once (the first scan) and then 6 more days.', NEWID(), GETDATE(), GETDATE());
	END
	
	IF NOT EXISTS ( SELECT * FROM [tickets].[ValidationRules] WHERE [NAME] = N'2 day pass')
    BEGIN
        INSERT INTO [tickets].[ValidationRules] ([Deleted], [Active], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'2 day pass', N'The ticket is valid for 2 days from the booking date. The QR has a max scan of 1 per day.', NEWID(), GETDATE(), GETDATE());
    END

	IF NOT EXISTS ( SELECT * FROM [tickets].[ValidationRules] WHERE [NAME] = N'CADW Joint Ticket')
    BEGIN
        INSERT INTO [tickets].[ValidationRules] ([Deleted], [Active], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'CADW Joint Ticket', N'Multi site purchase ticket to be only used in one day across 2 sites. Single day use, Multi entry on a single day, Conwy Castle entry, Plas Mawr entry, Web ticket only.', NEWID(), GETDATE(), GETDATE());
    END

	IF NOT EXISTS ( SELECT * FROM [tickets].[ValidationRules] WHERE [NAME] = N'Single use any day')
    BEGIN
        INSERT INTO [tickets].[ValidationRules] ([Deleted], [Active], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'Single use any day', N'A ticket with this validation rule can be used ONCE no matter what the BOOKING DATE is.', NEWID(), GETDATE(), GETDATE());
    END

	IF NOT EXISTS ( SELECT * FROM [tickets].[ValidationRules] WHERE [NAME] = N'CADW Joint Validation for Castell Coch and Caerphilly')
    BEGIN
        INSERT INTO [tickets].[ValidationRules] ([Deleted], [Active], [Name], [Description], [Id], [CreatedDate], [UpdatedDate]) VALUES(0, 1, N'CADW Joint Validation for Castell Coch and Caerphilly', N'Multi site purchase ticket to be only used in one day across 2 sites. Single day use, Multi entry on a single day, Castell Coch entry, Caerphilly entry, Web ticket only.', NEWID(), GETDATE(), GETDATE());
    END

COMMIT
END TRY  
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrorMessage;  
	ROLLBACK TRAN
END CATCH
