-- Web
IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Booking Payment')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (2, 'General', 'Booking Payment', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Enabled"},{"id":"2","text":"Disabled"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END
IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Display branch filter')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (2, 'General', 'Display branch filter', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Display"},{"id":"2","text":"Do not display"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Checkout Timeout - mins')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (2, 'General', 'Checkout Timeout - mins', 2, NULL, 60, NULL, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Checkout Timeout - mins' AND [Type] <> 2)
BEGIN
	UPDATE [tickets].[Settings] SET [Type] = 2 Where [Name] = 'Checkout Timeout - mins'
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Pay later')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (2, 'General', 'Pay later', 4, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END 
ELSE 
BEGIN
	UPDATE [tickets].[Settings] SET Options = NULL WHERE [Name] = 'Pay later'
END 

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Pay now')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (2, 'General', 'Pay now', 4, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END 
ELSE 
BEGIN
	UPDATE [tickets].[Settings] SET Options = NULL WHERE [Name] = 'Pay now'
END 

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Pay deposit')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (2, 'General', 'Pay deposit', 4, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END 
ELSE 
BEGIN
	UPDATE [tickets].[Settings] SET Options = NULL WHERE [Name] = 'Pay deposit'
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Payment Gateway')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (2, 'General', 'Payment Gateway', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Stripe"},{"id":"2","text":"OPAYO"},{"id":"3","text":"Worldpay"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END
ELSE
BEGIN
	UPDATE [tickets].[Settings] SET Options = N'[{"id":"1","text":"Stripe"},{"id":"2","text":"OPAYO"},{"id":"3","text":"Worldpay"}]' WHERE [Name] = 'Payment Gateway'
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Booking Cancel Time')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (2, 'Web Settings', 'Booking Cancel Time', 2, NULL, 15, NULL, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Booking Fee')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [DoubleNumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (2, 'General', 'Booking Fee', 7, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Pre-book days')
    BEGIN
        INSERT INTO [tickets].[Settings]
            ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy])
        VALUES (2, 'General', 'Pre-book days', 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
    END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Membership Join')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (2, 'General', 'Membership Join', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Enabled"},{"id":"2","text":"Disabled"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END
--/ Web

-- Device
IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'E-receipt logo')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'E-receipt template', 'E-receipt logo', 6, N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-user-avatar-images-bo/rc7XnG6_IUGzUVfYEtvvUA.png', NULL, 1, NULL, NULL,  NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'E-receipt footer')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'E-receipt template', 'E-receipt footer', 1, N'Thank you for shopping with us', NULL, 1, NULL, NULL,  NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Client name title')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'E-receipt template', 'Client name title', 1, N'Visit Scotland', NULL, 1, NULL, NULL,  NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Client name footer')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'E-receipt template', 'Client name footer', 1, N'Visit Scotland Limited', NULL, 1, NULL, NULL,  NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Open cash drawer in training mode')
BEGIN
    INSERT INTO [tickets].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'Open cash drawer in training mode', 4, 0, NULL, 0, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'EOD Cash declaration')
BEGIN
    INSERT INTO [tickets].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'EOD Cash declaration', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Denomination"},{"id":"2","text":"Value"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Open price')
BEGIN
    INSERT INTO [tickets].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'Open price', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Open Price"},{"id":"2","text":"Zero Price"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Print Merchant Copy')
BEGIN
    INSERT INTO [tickets].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'Print Merchant Copy', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Yes - Merchant copy prints every card sale"},{"id":"2","text":"No - Merchant copy never prints"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Refund with credit note')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'General', 'Refund with credit note', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Issue credit note"},{"id":"2","text":"Do not issue a credit note"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Collect Customer Data Reminder')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'General', 'Collect Customer Data Reminder', 5, '1', NULL, NULL, NULL, NULL,  N'[{"id":"1","text":"Enabled"},{"id":"2","text":"Disabled"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Cash Drawer')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'General', 'Cash Drawer', 4, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Activity Timeout - mins')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'General', 'Activity Timeout - mins', 2, NULL, 5, NULL, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Logout After Complete Sale')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'General', 'Logout After Complete Sale', 4, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Pop-up keyboard')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'General', 'Pop-up keyboard', 4, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Background sync frequency')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'General', 'Background sync frequency', 5, '10', NULL, NULL, NULL, NULL, N'[{"id":"10","text":"10 mins"},{"id":"20","text":"20 mins"},{"id":"30","text":"30 mins"},{"id":"60","text":"1 hour"},{"id":"180","text":"3 hours"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Collecting customer data')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'General', 'Collecting customer data', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Collect data"},{"id":"2","text":"Do not collect data"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END


IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Timeout - mins')
BEGIN
	INSERT INTO [tickets].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'General', 'Timeout - mins', 2, NULL, 15, NULL, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END
    
IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Ticket printing type')
BEGIN
    INSERT INTO [tickets].[Settings]
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy])
    VALUES (1, 'General', 'Ticket printing type', 5, 1, NULL, NULL, NULL, NULL,  N'[{"id":"1","text":"Individual tickets"},{"id":"2","text":"Group tickets"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END
    
IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Float')
BEGIN
INSERT INTO [tickets].[Settings]
([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy])
VALUES (1, 'General', 'Float', 5, 1, NULL, NULL, NULL, NULL,  N'[{"id":"1","text":"Require float"},{"id":"2","text":"Don’t require float"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END
--/ Device


-- Admin
IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'System errors distribution list')
BEGIN
    INSERT INTO [tickets].[Settings]    
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (3, 'General', 'System errors distribution list',  1, '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [tickets].[Settings] where [Name] = 'Cost number')
BEGIN
    INSERT INTO [tickets].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (3, 'General', 'Cost number',  5, '4', NULL, NULL, NULL, NULL, N'[{"id":"2","text":"2 decimal places"},{"id":"4","text":"4 decimal places"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

--/ Admin