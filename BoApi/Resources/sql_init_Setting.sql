-- Device

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Selecting Journey')
BEGIN
	INSERT INTO [dbo].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'Start Of Day Process', 'Selecting Journey', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Enabled"},{"id":"2","text":"Disabled"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Selecting Train')
BEGIN
	INSERT INTO [dbo].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'Start Of Day Process', 'Selecting Train', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Enabled"},{"id":"2","text":"Disabled"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Master Device')
BEGIN
	INSERT INTO [dbo].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'Start Of Day Process', 'Master Device', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Enabled"},{"id":"2","text":"Disabled"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Device Type')
BEGIN
	INSERT INTO [dbo].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'Start Of Day Process', 'Device Type', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Enabled"},{"id":"2","text":"Disabled"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'FOB Stock Count')
BEGIN
	INSERT INTO [dbo].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'Start Of Day Process', 'FOB Stock Count', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Enabled"},{"id":"2","text":"Disabled"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Stock location group type')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'Start Of Day Process', 'Stock location group type', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"FnB"},{"id":"2","text":"Train"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END
  
IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Retail and Stock')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'Start Of Day Process', 'Retail and Stock', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Retail & Stock"},{"id":"2","text":"Stock"},{"id":"3","text":"Retail"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END


IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Collecting customer data')
BEGIN
	INSERT INTO [dbo].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'General', 'Collecting customer data', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Collect data"},{"id":"2","text":"Do not collect data"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Background sync frequency')
BEGIN
	INSERT INTO [dbo].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'General', 'Background sync frequency', 5, '10', NULL, NULL, NULL, NULL, N'[{"id":"10","text":"10 mins"},{"id":"20","text":"20 mins"},{"id":"30","text":"30 mins"},{"id":"60","text":"1 hour"},{"id":"180","text":"3 hours"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Popup keyboard')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'Popup keyboard', 4, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Logout After Complete Sale')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'Logout After Complete Sale', 4, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Activity Timeout' or [Name] = 'Activity Timeout - mins')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'Activity Timeout', 2, NULL, 5, NULL, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END
IF EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Activity Timeout')
BEGIN
	UPDATE [dbo].[Settings] set [Name] = 'Activity Timeout - mins' where [Name] = 'Activity Timeout' 
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Cash Drawer')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'Cash Drawer', 4, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Collect Customer Data Reminder')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'Collect Customer Data Reminder', 5, '1', NULL, NULL, NULL, NULL,  N'[{"id":"1","text":"Enabled"},{"id":"2","text":"Disabled"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Refund with credit note')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'Refund with credit note', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Issue credit note"},{"id":"2","text":"Do not issue a credit note"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Print Merchant Copy')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'Print Merchant Copy', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Yes - Merchant copy prints every card sale"},{"id":"2","text":"No - Merchant copy never prints"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Advanced Search')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'Advanced Search', 4, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Open price')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'Open price', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Open Price - Asks for a price on selecting the product"},{"id":"2","text":"Zero Price - Adds to the basket at 0.00 without asking for a pop-up price."}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END
IF EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Open price')
BEGIN
	UPDATE [dbo].[Settings] set [Options] = N'[{"id":"1","text":"Open Price"},{"id":"2","text":"Zero Price"}]' where [Name] = 'Open price' 
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'EOD Cash declaration')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'EOD Cash declaration', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Denomination"},{"id":"2","text":"Value"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Keyboard')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'Keyboard', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Normal"},{"id":"2","text":"QWERTY"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Out of stock warning')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'Out of stock warning', 4, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END


IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'E-receipt logo')
BEGIN
	INSERT INTO [dbo].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'E-receipt template', 'E-receipt logo', 6, N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-sale-location-images-bo/Jb889Yi9pUeykN-N5m0kAg.png', NULL, 1, NULL, NULL,  NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'E-receipt footer')
BEGIN
	INSERT INTO [dbo].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'E-receipt template', 'E-receipt footer', 1, N'Cliciwch yma i weld <a href="https://www.aelodaethcadw.gwasanaeth.llyw.cymru/delivery-options/">amodau a thelerau</a> ein siop ar-lein.<br/>Os oedd eich archeb yn cynnwys Tocyn(nau) Dydd a/neu Docyn(nau) Digwyddiad, bydd y rhain yn cael eu hanfon ar wahn; edrychwch yn eich ffolderi blwch derbyn a phost sothach/sbam.<br/>Os oedd eich archeb yn cynnwys eitemau on siop ar-lein, bydd eich eitemau yn eich cyrraedd cyn bo hir.', NULL, 1, NULL, NULL,  NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END
ELSE
BEGIN
    UPDATE [dbo].[Settings] set [Value] = N'Peidiwch ag ymateb i''r e-bost hwn gan nad ywr blwch post yn cael ei fonitro. Os oes cwestiwn gyda chi ynglyn ach<br/>archeb, yna cysylltwch ar safle.<br/>Please do not reply to this email as this mailbox is not monitored. If you have a question regarding your purchase, <br/>please contact the site directly.<br/><br/>Cadw  er lles pawb.<br/>For us all, to keep.<br/><br/>Dewch yn Geidwad  Ymunwch  Cadw<br/>Be a Keeper - Join Cadw<br/><br/><a href="https://cadw.llyw.cymru/">cadw.llyw.cymru</a><br/><a href="https://cadw.gov.wales/">cadw.gov.wales</a>' where [Name] = 'E-receipt footer'
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Client name title')
BEGIN
	INSERT INTO [dbo].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'E-receipt template', 'Client name title', 1, N'Cadw', NULL, 1, NULL, NULL,  NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Client name footer')
BEGIN
	INSERT INTO [dbo].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (1, 'E-receipt template', 'Client name footer', 1, N'Cadw', NULL, 1, NULL, NULL,  NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Open cash drawer in training mode')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (1, 'General', 'Open cash drawer in training mode', 4, 0, NULL, 0, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END
    
IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Float')
BEGIN
INSERT INTO [dbo].[Settings]
([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy])
VALUES (1, 'General', 'Float', 5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Require float"},{"id":"2","text":"Don’t require float"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Reason required?')
    DELETE [dbo].[Settings] where [Name] = 'Reason required?'
--/ Devices

-- Admin

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Shopify Functions')
BEGIN
	INSERT INTO [dbo].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (3, 'Shopify', 'Shopify Functions', 4, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Time push product daily - hours')
BEGIN
	INSERT INTO [dbo].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (3, 'Shopify', 'Time push product daily - hours', 2, NULL, '24', NULL, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Requency to update current stock holding - mins')
BEGIN
	INSERT INTO [dbo].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (3, 'Shopify', 'Requency to update current stock holding - mins', 2, NULL, '60', NULL, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Requency to synchronize orders and transaction from shopify - mins')
BEGIN
	INSERT INTO [dbo].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (3, 'Shopify', 'Requency to synchronize orders and transaction from shopify - mins', 2, NULL, '60', NULL, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Shopify Vendor Name')
BEGIN
	INSERT INTO [dbo].[Settings] 
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
	VALUES (3, 'Shopify', 'Shopify Vendor Name', 1, N'ECR Retail System', NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END


IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Edit cost price on order')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (3, 'General', 'Edit cost price on order',  5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Enabled"},{"id":"2","text":"Disabled"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END
    
if exists (SELECT * FROM [dbo].Settings where [Name] = 'Supplier order review')
begin
    delete from [dbo].Settings where [Name] = 'Supplier order review';
end

IF EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Received summary email address')
BEGIN
    DELETE FROM [dbo].[Settings] WHERE [Name] = 'Received summary email address'
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'System errors distribution list')
BEGIN
    INSERT INTO [dbo].[Settings]
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy])
    VALUES (3, 'General', 'System errors distribution list',  1, '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Adjustment permissions')
BEGIN
    INSERT INTO [dbo].[Settings]    
	([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (3, 'General', 'Adjustment permissions',  5, '1', NULL, NULL, NULL, NULL, N'[{"id":"1","text":"Approval required"},{"id":"2","text":"Approval not required"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END

IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Cost number')
BEGIN
    INSERT INTO [dbo].[Settings] 
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy]) 
    VALUES (3, 'General', 'Cost number',  5, '4', NULL, NULL, NULL, NULL, N'[{"id":"2","text":"2 decimal places"},{"id":"4","text":"4 decimal places"}]', NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END
    
IF NOT EXISTS (SELECT * FROM [dbo].[Settings] where [Name] = 'Out of stock warning')
BEGIN
    INSERT INTO [dbo].[Settings]
    ([Enviroment], [GroupName], [Name], [Type], [Value], [NumberValue], [BoolValue], [DateTimeValue], [TimeSpanValue], [Options], [BranchId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy])
    VALUES (1, 'General', 'Out of stock warning', 4, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, 1, GETDATE(), NULL, GETDATE(), NULL);
END
--/ Admin	
