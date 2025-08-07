IF OBJECT_ID('PrintTemplates', 'U') IS NOT NULL
begin

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Revenue'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Revenue', N'<LINE>[Image]Logo.bmp</LINE>\n<LINE>Cashier: <VAR><NAME>Operator.FullName</NAME></VAR><VAR><NAME>General.deviceId<FORMAT>!0000</FORMAT></NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Date:<VAR><NAME>General.currentDate<FORMAT>#dd/MM/yyyy HH:mm</FORMAT></NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Location:<VAR><NAME>SaleLocations.SysID</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE> </LINE>\n<LINE>-------------------------------[Align=Center]</LINE>\n<LINE> </LINE>\n<LINE>Operator:<VAR><NAME>Operator.FullName</NAME></VAR></LINE>\n<LINE> </LINE>\n<LINE>----------- REVENUE -----------[Align=Center]</LINE>\n<LINE>QTY[Align=Right,Length=24]Amt.[Align=Right,Length=8]</LINE>\n<LINE><TABLESTART>RevenueData</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>RevenueData.Label</NAME></TABLEFIELD>[Align=Left,Length=18]<TABLEFIELD><NAME>RevenueData.CalculatedQTY</NAME></TABLEFIELD>[Align=Right,Length=6]<TABLEFIELD><NAME>RevenueData.CalculatedAmount</NAME></TABLEFIELD>[Align=Right,Length=8]</LINE>\n<LINE><TABLEEND>RevenueData</TABLEEND></LINE>\n<LINE> </LINE>\n<LINE>-------------------------------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>\n', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

    IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Optomany Card Sales Receipt'  and [DeviceType] = 0)
        BEGIN
            INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Optomany Card Sales Receipt', '<LINE>[Image]VisitScotlandLogo.bmp</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.merchantName</NAME></VAR>[Align=Left, FontSize=Double, Bold=true]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.merchantLocation</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transDateTime</NAME><FORMAT>#dd/MM/yyyy HH:mm</FORMAT></VAR>[Align=Left]</LINE>\n<LINE>PID: <VAR><NAME>OptomanySaleReceipt.paymentId</NAME></VAR>[Align=Left]</LINE>\n<LINE>MID: <VAR><NAME>OptomanySaleReceipt.merchantId</NAME></VAR>[Align=Left]</LINE>\n<LINE>TID: <VAR><NAME>OptomanySaleReceipt.terminalId</NAME></VAR>[Align=Left]</LINE>\n<LINE>AID: <VAR><NAME>OptomanySaleReceipt.emvAid</NAME></VAR>[Align=Left]</LINE>\n<LINE>RECEIPT NO: <VAR><NAME>OptomanySaleReceipt.receiptNumber</NAME></VAR>[Align=Left]</LINE>\n<LINE>APP SEQ: <VAR><NAME>OptomanySaleReceipt.appSeq</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardType</NAME></VAR>[Align=Right]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardScheme</NAME></VAR>[Align=Right]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardPan</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transType</NAME></VAR>[Align=Left]</LINE>\n<LINE>AMOUNT [Align=Left, Length=7]<VAR><NAME>OptomanySaleReceipt.amountTrans</NAME></VAR>[Align=Right, Length=33]</LINE>\n<LINE>---------------------------------------[Align=Center]</LINE>\n<LINE>TOTAL [Align=Left, Bold=true, FontSize=Double, Length=10]<VAR><NAME>OptomanySaleReceipt.amountTrans</NAME></VAR>[Align=Right, Bold=true, FontSize=Double, Length=30]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transApproved</NAME></VAR>[Align=Center, Bold=true, FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE>RESPONSE CODE: <VAR><NAME>OptomanySaleReceipt.responseCode</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cvmPinVerified</NAME></VAR>[Align=Center]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transApprovedLabel</NAME></VAR>[Align=Center]</LINE>\n<LINE>AUTH CODE: <VAR><NAME>OptomanySaleReceipt.authorisationCode</NAME></VAR>[Align=Center]</LINE>\n\n<LINE>**MERCHANT COPY**[Align=Center, Bold=true, FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>', 1,0,0)
            Insert into PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
            select
                0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
            from
                PrintTemplates t,
                Branches b
            where t.Id  not in (select tm.[PrintTemplateId] from PrintTemplateBranchMaps tm) and b.[Deleted] = 0
        END
    IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Optomany Merchant Copy For Till'  and [DeviceType] = 0)
        BEGIN
            INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Optomany Merchant Copy For Till', '<LINE>[Image]VisitScotlandLogo.bmp</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.merchantName</NAME></VAR>[Align=Left, FontSize=Double, Bold=true]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.merchantLocation</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transDateTime</NAME><FORMAT>#dd/MM/yyyy HH:mm</FORMAT></VAR>[Align=Left]</LINE>\n<LINE>PID: <VAR><NAME>OptomanySaleReceipt.paymentId</NAME></VAR>[Align=Left]</LINE>\n<LINE>MID: <VAR><NAME>OptomanySaleReceipt.merchantId</NAME></VAR>[Align=Left]</LINE>\n<LINE>TID: <VAR><NAME>OptomanySaleReceipt.terminalId</NAME></VAR>[Align=Left]</LINE>\n<LINE>AID: <VAR><NAME>OptomanySaleReceipt.emvAid</NAME></VAR>[Align=Left]</LINE>\n<LINE>RECEIPT NO: <VAR><NAME>OptomanySaleReceipt.receiptNumber</NAME></VAR>[Align=Left]</LINE>\n<LINE>APP SEQ: <VAR><NAME>OptomanySaleReceipt.appSeq</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardType</NAME></VAR>[Align=Right]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardScheme</NAME></VAR>[Align=Right]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardPan</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transType</NAME></VAR>[Align=Left]</LINE>\n<LINE>AMOUNT [Align=Left, Length=7]<VAR><NAME>OptomanySaleReceipt.amountTrans</NAME></VAR>[Align=Right, Length=33]</LINE>\n<LINE>---------------------------------------[Align=Center]</LINE>\n<LINE>TOTAL [Align=Left, Bold=true, FontSize=Double, Length=10]<VAR><NAME>OptomanySaleReceipt.amountTrans</NAME></VAR>[Align=Right, Bold=true, FontSize=Double, Length=30]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transApproved</NAME></VAR>[Align=Center, Bold=true, FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE>RESPONSE CODE: <VAR><NAME>OptomanySaleReceipt.responseCode</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cvmPinVerified</NAME></VAR>[Align=Center]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transApprovedLabel</NAME></VAR>[Align=Center]</LINE>\n<LINE>AUTH CODE: <VAR><NAME>OptomanySaleReceipt.authorisationCode</NAME></VAR>[Align=Center]</LINE>\n\n<LINE>**MERCHANT COPY**[Align=Center, Bold=true, FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>', 1,0,0)
            Insert into PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
            select
                0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
            from
                PrintTemplates t,
                Branches b
            where t.Id  not in (select tm.[PrintTemplateId] from PrintTemplateBranchMaps tm) and b.[Deleted] = 0
        END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Sale Receipt'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Sale Receipt', N'<LINE>[Image]VisitScotlandLogo.bmp</LINE>\n<LINE></LINE>\n<LINE><Branch.Name> iCentre[Align=Center]</LINE>\n<LINE><Branch.AddressLine2>[Align=Center]</LINE>\n<LINE><Branch.AddressLine3>, <Branch.PostCode>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Sales Receipt[Align=Center,FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Transaction #:[Length=20] <VAR><NAME>General.saleNo</NAME></VAR>[Length=20]</LINE>\n<LINE>Date: <VAR><NAME>General.currentDate</NAME><FORMAT>#dd/MM/yyyy</FORMAT></VAR>[Length=20]Time: <VAR><NAME>General.currentDate</NAME><FORMAT>#HH:mm:ss</FORMAT></VAR>[Length=20]</LINE>\n<LINE>Cashier: <VAR><NAME>Operator.Code</NAME></VAR>[Length=20]Register #: <VAR><NAME>General.deviceid</NAME></VAR>[Length=20]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Item[Length=12]Description[Length=20]Amount[Length=8,Align=Right]</LINE>\n<LINE>=====================================</LINE>\n<LINE><TABLESTART>SaleDetails</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>SaleDetails.ProductCode</NAME></TABLEFIELD>[Align=Left,Length=12]<TABLEFIELD><NAME>SaleDetails.ProductPrintName</NAME></TABLEFIELD>[Align=Left,Length=20]<TABLEFIELD><NAME>SaleDetails.SumPrice</NAME></TABLEFIELD>[Align=Right,Length=8]</LINE>\n<LINE><TABLEEND>SaleDetails</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>==========[Align=Right]</LINE>\n<LINE>Sub Total:[Length=30,Align=Right]<VAR><NAME>SaleReceipt.SubTotal</NAME></VAR>[Align=Right]</LINE>\n<LINE>Discount: [Length=30,Align=Right]<VAR><NAME>ticket.discountedPrice</NAME></VAR>[Align=Right]</LINE>\n<LINE>Tax: [Length=30,Align=Right]<VAR><NAME>MerchantCopy.TaxTotal</NAME></VAR>[Align=Right]</LINE>\n<LINE>Total: [Length=30,Align=Right]<VAR><NAME>General.Amount</NAME></VAR>[Align=Right]</LINE>\n<LINE>Paid by: [Length=30,Align=Right]<VAR><NAME>SaleReceipt.PaidBy</NAME></VAR>[Align=Right]</LINE>\n<LINE>Change: [Length=30,Align=Right]<VAR><NAME>SaleReceipt.Change</NAME></VAR>[Align=Right]</LINE>\n<LINE></LINE>\n<LINE>VAT Number: 945652105</LINE>\n<LINE></LINE>\n<LINE>--------------------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE>Thank you for purchasing at[Align=Center]</LINE>\n<LINE><Branch.Name> iCentre[Align=Center]</LINE>\n<LINE>Please call again. For further information & inspiration log on to[Align=Center]</LINE>\n<LINE>www.visitscotland.com[Align=Center]</LINE>\n<LINE>or telephone <Branch.PhoneNumber>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0 
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Print Bill'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Print Bill', N'<LINE>[Image]VisitScotlandLogo.bmp</LINE>\n<LINE></LINE>\n<LINE><Branch.Name> iCentre[Align=Center]</LINE>\n<LINE><Branch.AddressLine2>[Align=Center]</LINE>\n<LINE><Branch.AddressLine3>, <Branch.PostCode>[Align=Center]</LINE>\n<LINE> </LINE>\n<LINE>Date:<VAR><NAME>General.currentDate</NAME><FORMAT>#dd/MM/yyyy HH:mm</FORMAT></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Table: <VAR><NAME>General.tableservice</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Operator: <VAR><NAME>Operator.FirstName</NAME></VAR><VAR><NAME>Operator.LastName</NAME></VAR>/<VAR><NAME>General.deviceId</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE><TABLESTART>Sales</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Sales.DocumentNo</NAME></TABLEFIELD>[Align=Left,Length=40,Emphasize=Emphasized]</LINE>\n<LINE><TABLEEND>Sales</TABLEEND></LINE>\n<LINE> </LINE>\n<LINE> </LINE>\n<LINE> </LINE>\n<LINE>---------- PRINT BILL ---------[Align=Center]</LINE>\n<LINE> </LINE>\n<LINE><TABLESTART>SaleDetails</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>SaleDetails.SumQTY</NAME></TABLEFIELD>[Length=5] x [Length=3]<TABLEFIELD><NAME>SaleDetails.ProductPrintName</NAME></TABLEFIELD>[Align=Left,Length=23]<TABLEFIELD><NAME>SaleDetails.TaxLabel</NAME></TABLEFIELD>[Align=Left,Length=3]<TABLEFIELD><NAME>SaleDetails.SumPrice</NAME><FORMAT>0.00</FORMAT></TABLEFIELD>[Align=Right,Length=6,Format=0.00]</LINE>\n<LINE><TABLEEND>SaleDetails</TABLEEND></LINE>\n<LINE> </LINE>\n<LINE>Total:[Align=Left,Length=16,Width=Double,Emphasize=Emphasized]<VAR><NAME>Currencies.name</NAME></VAR>[Align=Left,Length=9,Width=Double,Emphasize=Emphasized]<VAR><NAME>General.amount</NAME><FORMAT>0.00</FORMAT></VAR>[Align=Right,Length=16,Width=Double,Emphasize=Emphasized]</LINE>\n<LINE>-------------------------------[Align=Center]</LINE>\n<LINE><TABLESTART>Payments</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Payments.DescriptionPOS</NAME></TABLEFIELD>[Align=Left,Length=19]<TABLEFIELD><NAME>Payments.DocCurrencyName</NAME></TABLEFIELD>[Align=Left,Length=9]<TABLEFIELD><NAME>Payments.DocCurrencyAmount</NAME><FORMAT>!00</FORMAT></TABLEFIELD>[Align=Right,Length=12,Format=!00]</LINE>\n<LINE><TABLEEND>Payments</TABLEEND></LINE>\n<LINE> </LINE>\n<LINE> </LINE>\n<LINE>Thank you[Align=Center]</LINE>\n<LINE>Please tell us how we did today[Align=Center,Emphasize=Emphasized]</LINE>\n<LINE>and use our member feedback tablet[Align=Center]</LINE>\n<LINE>on every visit[Align=Center]</LINE>\n<LINE> </LINE>\n<LINE>-------------------------------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Kitchen Print Change Table'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Kitchen Print Change Table', N'<LINE>#TRACE PRINT TEMPLATE VARIABLES#</LINE>\n<LINE> ORDER DETAIL CHANGED[Align=Center]</LINE>\n<LINE>Date: <VAR><NAME>General.currentDate<FORMAT>#dd/MM/yyyy HH:mm</FORMAT></NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Operator: <VAR><NAME>Operator.FirstName</NAME></VAR>/ <VAR><NAME>General.deviceId</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE><VAR><NAME>SaleLocations.SysID</NAME></VAR> -[Align=Left,Width=Double,Emphasize=Emphasized]</LINE>\n<LINE><VAR><NAME>General.tableservice</NAME></VAR>[Align=Left,Width=Double,Emphasize=Emphasized]</LINE>\n<LINE> ORDER DETAIL CHANGED[Align=Center]</LINE>\n<LINE><TABLESTART>KitchenPrints</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>KitchenPrints.QTY</NAME></TABLEFIELD>[Align=Right,Length=7] x [Length=3]<TABLEFIELD><NAME>KitchenPrints.ProductPrintName</NAME></TABLEFIELD>[Align=Left,Length=30,Width=Double,Emphasize=Emphasized]</LINE>\n<LINE><TABLEFIELD><NAME>KitchenPrints.Condiments</NAME></TABLEFIELD>[Length=10]<TABLEFIELD><NAME>KitchenPrints.Note</NAME></TABLEFIELD>[Align=Left,Length=30,Width=Double]</LINE>\n<LINE><TABLEEND>KitchenPrints</TABLEEND></LINE>\n<LINE>.........................[Align=Center]</LINE>\n<LINE>Receipt No: <VAR><NAME>General.saleNo</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE>ORDER DETAIL CHANGED[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>\n', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Merchant Copy - chip and sign'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Merchant Copy - chip and sign', N'MERCHANT COPY  *[Align=Center,Bold=true,Length=40]\n\n<Branch.Name> iCentre[Align=Left,Bold=true,Length=40]\n<Branch.AddressLine2>[Align=Left,Length=40]\n<Branch.AddressLine3>, <Branch.PostCode>[Align=Left,Length=40]\n\nDate:        <general.currentDate|format=dd-MM-yyyy>[Align=Left,Length=40]\nTime:        <general.currentDate|format=HH:mm>[Align=Left,Length=40]\nReceipt no:  <general.saleNo>[Align=Left,Length=40]\n\nMID:         <saleReceipt.mid>[Align=Left,Length=40]\nTID:         <saleReceipt.tid>[Align=Left,Length=40]\nAID:         <saleReceipt.aid>[Align=Left,Length=40]\nPAN Seq No:  <saleReceipt.panSeqNumber|format=00>[Align=Left,Length=40]\n\nPaid by:     <saleReceipt.paidBy>[Align=Left,Length=40]\nCard:        <saleReceipt.cardType>[Align=Left,Length=40]\nCard Number: <saleReceipt.cardNumber>[Align=Left,Length=40]\nExpiry Date: <saleReceipt.cardExpireDate>[Align=Left,Length=40]\nSource:      <saleReceipt.transactionSource>[Align=Left,Length=40]\n\n--------------------------------[Length=40]\n\n<saleReceipt.status>[Align=Center,Bold=true,Length=40,FontSize=Double]\n\nTOTAL[Bold=true,Length=14,FontSize=Double]<SaleReceipt.cardPurchase>[Align=Right,Bold=true,Length=26,FontSize=Double]\n\n\nSign: ..........................[Align=Left,Bold=true,Length=40]\n\n--------------------------------[Length=40]\n\nThe customer''s account has been debited with the total.[Length=40]\n\n*** Please retain a copy for      your records ***[Align=Center,Length=40]\n\n\n--------------------------------[Length=40]\n\n\n\n\n\n#knife#\n', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'End of Shift'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'End of Shift', N'Date:<general.currentDate|format=dd-MM-yyyy><general.currentDate|format=HH:mm>[Length=32]\nDevice ID: <general.deviceId>[Length=32]\nLocation: <general.location>[Length=32]\nUser: <general.user>[Length=32]\n\n\n-----------DECLARATION----------[Align=Center,Length=32]\n<general.deviceId>[Align=Center,Length=32]\nDeclared[Align=Right,Length=32]\n[tablestart]Declaration\n[Length=23,tablename=Declaration,columnname=Label][Align=Right,Length=9,tablename=Declaration,columnname=Declared]\n[tableend]Declaration\n<general.location>[Align=Center,Length=32]\nSign:[Length=32]\n\n\n\n--------------------------------[Length=32]\n\n\n\n\n\n', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Bar Print'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Bar Print', N'<LINE>Date: <VAR><NAME>General.currentDate<FORMAT>#dd/MM/yyyy HH:mm</FORMAT></NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Operator: <VAR><NAME>Operator.FirstName</NAME></VAR>/ <VAR><NAME>General.deviceId</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE><VAR><NAME>SaleLocations.SysID</NAME></VAR> - <VAR><NAME>General.tableservice</NAME></VAR>[Align=Left,Width=Double,Emphasize=Emphasized]</LINE>\n<LINE><TABLESTART>Sales</TABLESTART></LINE>\n<LINE>Covers: [Length=7]<TABLEFIELD><NAME>Sales.Covers</NAME></TABLEFIELD>[Align=Left,Length=33,Emphasize=Emphasized]</LINE>\n<LINE><TABLEFIELD><NAME>Sales.SaleText</NAME></TABLEFIELD>[Length=40]</LINE>\n<LINE><TABLEEND>Sales</TABLEEND></LINE>\n<LINE>...... Bar Printer ......[Align=Center]</LINE>\n<LINE><TABLESTART>KitchenPrints</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>KitchenPrints.QTY</NAME></TABLEFIELD>[Align=Right,Length=7] x [Length=3]<TABLEFIELD><NAME>KitchenPrints.ProductPrintName</NAME></TABLEFIELD>[Align=Left,Length=30,Width=Double,Emphasize=Emphasized]</LINE>\n<LINE><TABLEFIELD><NAME>KitchenPrints.Condiments</NAME></TABLEFIELD>[Length=10]<TABLEFIELD><NAME>KitchenPrints.Note</NAME></TABLEFIELD>[Align=Left,Length=30,Width=Double]</LINE>\n<LINE><TABLEEND>KitchenPrints</TABLEEND></LINE>\n<LINE>.........................[Align=Center]</LINE>\n<LINE>Receipt No: <VAR><NAME>General.saleNo</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>\n', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Bar Print Cancel'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Bar Print Cancel', N'<LINE>#TRACE PRINT TEMPLATE VARIABLES#</LINE>\n<LINE>Date: <VAR><NAME>General.currentDate<FORMAT>#dd/MM/yyyy HH:mm</FORMAT></NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Location: <VAR><NAME>SaleLocations.SysID</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Operator: <VAR><NAME>Operator.FirstName</NAME></VAR><VAR><NAME>Operator.LastName</NAME></VAR> / <VAR><NAME>General.deviceId</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Table: <VAR><NAME>General.tableservice</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>RefNo: <VAR><NAME>General.saleNo</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE>VOID[Align=Center,Length=32,Width=Double,Emphasize=Emphasized]</LINE>\n<LINE>------ Cancel Bar Print ------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>KitchenPrints</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>KitchenPrints.QTY</NAME></TABLEFIELD>[Align=Right,Length=7] x [Length=3]<TABLEFIELD><NAME>KitchenPrints.ProductPrintName</NAME></TABLEFIELD>[Align=Left,Length=30]</LINE>\n<LINE>+[Length=7]<TABLEFIELD><NAME>KitchenPrints.Condiments</NAME></TABLEFIELD>[Align=Left,Length=33]</LINE>\n<LINE>Note: [Length=7]<TABLEFIELD><NAME>KitchenPrints.Note</NAME></TABLEFIELD>[Align=Left,Length=33]</LINE>\n<LINE><TABLEEND>KitchenPrints</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>-------------------------------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>\n', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Bar Print Change Table'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Bar Print Change Table', N'<LINE>#TRACE PRINT TEMPLATE VARIABLES#</LINE>\n<LINE>ORDER DETAIL CHANGED[Align=Center]</LINE>\n<LINE>Date: <VAR><NAME>General.currentDate<FORMAT>#dd/MM/yyyy HH:mm</FORMAT></NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Operator: <VAR><NAME>Operator.FirstName</NAME></VAR>/ <VAR><NAME>General.deviceid</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE><VAR><NAME>SaleLocations.SysID</NAME></VAR> - <VAR><NAME>General.tableservice</NAME></VAR>[Align=Left,Bold=true,Emphasize=Emphasized]</LINE>\n<LINE>ORDER DETAIL CHANGED[Align=Center]</LINE>\n<LINE><TABLESTART>KitchenPrints</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>KitchenPrints.QTY</NAME></TABLEFIELD>[Align=Right,Length=7] x [Length=3]<TABLEFIELD><NAME>KitchenPrints.ProductPrintName</NAME></TABLEFIELD>[Align=Left,Length=30,Width=Double,Emphasize=Emphasized]</LINE>\n<LINE><TABLEFIELD><NAME>KitchenPrints.Condiments</NAME></TABLEFIELD>[Length=10]<TABLEFIELD><NAME>KitchenPrints.Note</NAME></TABLEFIELD>[Align=Left,Length=30,Width=Double]</LINE>\n<LINE><TABLEEND>KitchenPrints</TABLEEND></LINE>\n<LINE>.........................[Align=Center]</LINE>\n<LINE>Receipt No: <VAR><NAME>General.saleNo</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE>ORDER DETAIL CHANGED[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>\n', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Card Sales Receipt'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Card Sales Receipt', N'* CARDHOLDER COPY *[Align=Center,Bold=true,Length=40]\n\n<Branch.Name> iCentre[Align=Left,Bold=true,Length=40]\n<Branch.AddressLine2>[Align=Left,Length=40]\n<Branch.AddressLine3>, <Branch.PostCode>[Align=Left,Length=40]\n\nDate:        <general.currentDate|format=dd-MM-yyyy>[Align=Left,Length=40]\nTime:        <general.currentDate|format=HH:mm>[Align=Left,Length=40]\nReceipt no:  <general.saleNo>[Align=Left,Length=40]\n\nMID:         <saleReceipt.mid>[Align=Left,Length=40]\nTID:         <saleReceipt.tid>[Align=Left,Length=40]\nAID:         <saleReceipt.aid>[Align=Left,Length=40]\nPAN Seq No:  <saleReceipt.panSeqNumber|format=00>[Align=Left,Length=40]\n\nPaid by:     <saleReceipt.paidBy>[Align=Left,Length=40]\nCard:        <saleReceipt.cardType>[Align=Left,Length=40]\nCard Number: <saleReceipt.cardNumber>[Align=Left,Length=40]\nExpiry date: <saleReceipt.expireDate>[Align=Left,Length=40]\nSource:      <saleReceipt.transactionSource>[Align=Left,Length=40]\n\n\n--------------------------------[Align=Left,Length=40]\n\n<saleReceipt.status>[Align=Center,Bold=true,Length=40,FontSize=Double]\n\nTotal[Align=Left,Bold=true,Length=10,FontSize=Double]<SaleReceipt.cardPurchase>[Align=Right,Bold=true,Length=30,FontSize=Double]\n\n--------------------------------[Length=40]\nPlease debit my account with the total.[Align=Left,Length=40]\n--------------------------------[Length=40]\n\nPlease retain for your records.[Align=Left,Length=40]\n\n\n--------------------------------[Length=40]\n\n\n\n\n\n#knife#\n', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Kitchen Print'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Kitchen Print', N'<LINE>#TRACE PRINT TEMPLATE VARIABLES#</LINE>\n<LINE></LINE>\n<LINE>Date: <VAR><NAME>General.currentDate<FORMAT>#dd/MM/yyyy HH:mm</FORMAT></NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Operator: <VAR><NAME>Operator.FirstName</NAME></VAR>/ <VAR><NAME>General.deviceId</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE><VAR><NAME>SaleLocations.SysID</NAME></VAR> - <VAR><NAME>General.tableservice</NAME></VAR>[Align=Left,Bold=true,Emphasize=Emphasized]</LINE>\n<LINE><TABLESTART>Sales</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Sales.SaleNotes</NAME></TABLEFIELD>[Length=40]</LINE>\n<LINE><TABLEEND>Sales</TABLEEND></LINE>\n<LINE>..... Kitchen Print .....[Align=Left]</LINE>\n<LINE><TABLESTART>KitchenPrints</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>KitchenPrints.QTY</NAME></TABLEFIELD>[Align=Right,Length=7] x [Length=3]<TABLEFIELD><NAME>KitchenPrints.ProductPrintName</NAME></TABLEFIELD>[Align=Left,Length=30,Width=Double,Emphasize=Emphasized]</LINE>\n<LINE><TABLEFIELD><NAME>KitchenPrints.Condiments</NAME></TABLEFIELD>[Length=10]<TABLEFIELD><NAME>KitchenPrints.Note</NAME></TABLEFIELD>[Align=Left,Length=30,Width=Double]</LINE>\n<LINE><TABLEEND>KitchenPrints</TABLEEND></LINE>\n<LINE>.........................[Align=Left]</LINE>\n<LINE>Receipt No: <VAR><NAME>General.saleNo</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Customer Copy - chip and sign'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Customer Copy - chip and sign', N'* CARDHOLDER COPY *[Align=Center,Bold=true,Length=40]\n\n<Branch.Name> iCentre[Align=Left,Bold=true,Length=40]\n<Branch.AddressLine2>[Align=Left,Length=40]\n<Branch.AddressLine3>, <Branch.PostCode>[Align=Left,Length=40]\n\nDate:        <general.currentDate|format=dd-MM-yyyy>[Align=Left,Length=40]\nTime:        <general.currentDate|format=HH:mm>[Align=Left,Length=40]\nReceipt no:  <general.saleNo>[Align=Left,Length=40]\n\nMID:         <saleReceipt.mid>[Align=Left,Length=40]\nTID:         <saleReceipt.tid>[Align=Left,Length=40]\nAID:         <saleReceipt.aid>[Align=Left,Length=40]\nPAN seq no:  <saleReceipt.panSeqNumber>[Length=40]\n\nPaid by:     <saleReceipt.paidBy>[Align=Left,Length=40]\nCard:        <saleReceipt.cardType>[Align=Left,Length=40]\nCard Number: <saleReceipt.cardNumber>[Align=Left,Length=40]\nExpiry date: <saleReceipt.cardExpireDate>[Align=Left,Length=40]\nSource:      <saleReceipt.transactionSource>[Length=40]\n\n--------------------------------[Length=40]\n\n<saleReceipt.status>[Align=Center,Bold=true,Length=40,FontSize=Double]\n\nTotal[Bold=true,Length=10,FontSize=Double]<SaleReceipt.cardPurchase>[Align=Right,Bold=true,Length=30,FontSize=Double]\n\nSign: ..........................[Align=Left,Bold=true,Length=40]\n\n--------------------------------[Length=40]\n\nPlease debit my account with the total.[Align=Left,Length=40]\n\nPlease retain for your records.[Align=Left,Length=40]\n\n\n--------------------------------[Length=40]\n\n\n\n\n\n#knife#\n', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'End of day'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'End of day', N'<LINE>#TRACE PRINT TEMPLATE VARIABLES#</LINE>\n<LINE>----- END OF DAY REPORT -------[Align=Center,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE>Branch:<VAR><NAME>Operator.BranchID</NAME></VAR>Terminal:<VAR><NAME>General.deviceid</NAME></VAR></LINE>\n<LINE>===============================</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>Table</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table.QTY</NAME></TABLEFIELD>[Align=Right,Length=7]<TABLEFIELD><NAME>Table.Value</NAME></TABLEFIELD>[Align=Right,Length=8]\n<LINE><TABLEEND>Table</TABLEEND></LINE>\n<LINE></LINE>\n<LINE><TABLESTART>Table1</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table1.Label</NAME></TABLEFIELD>[Align=Right,Length=23]<TABLEFIELD><NAME>Table1.Value</NAME></TABLEFIELD>[Align=Right,Length=8]\n<LINE><TABLEEND>Table1</TABLEEND></LINE>\n<LINE>-------------------------------</LINE>\n<LINE>VAT ANALYSIS</LINE>\n<LINE></LINE>\n<LINE>Details Goods(Ex) Vat</LINE>\n<LINE>-------------------------------</LINE>\n<LINE><TABLESTART>Table2</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table2.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table2.Goods</NAME></TABLEFIELD>[Align=Right,Length=7]<TABLEFIELD><NAME>Table2.Vat</NAME></TABLEFIELD>[Align=Right,Length=8]\n<LINE><TABLEEND>Table2</TABLEEND></LINE>\n<LINE>===============================</LINE>\n<LINE>REFUND REASONS</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>Table3</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table3.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table3.QTY</NAME></TABLEFIELD>[Align=Right,Length=7]<TABLEFIELD><NAME>Table3.Value</NAME></TABLEFIELD>[Align=Right,Length=8]\n<LINE><TABLEEND>Table3</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>-------------------------------</LINE>\n<LINE></LINE>\n<LINE>DISCOUNT REASONS</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>Table4</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table4.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table4.QTY</NAME></TABLEFIELD>[Align=Right,Length=7]<TABLEFIELD><NAME>Table4.Value</NAME></TABLEFIELD>[Align=Right,Length=8]\n<LINE><TABLEEND>Table4</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>===============================</LINE>\n<LINE><TABLESTART>Table5</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table5.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table5.DocumentNo</NAME></TABLEFIELD>[Align=Left,Length=15]\n<LINE><TABLEEND>Table5</TABLEEND></LINE>\n<LINE>-------------------------------</LINE>\n<LINE>Date:<VAR><NAME>General.currentDate</NAME><FORMAT>#dd-MM-yyyy</FORMAT></VAR>Time:<VAR><NAME>General.currentDate</NAME><FORMAT>#HH:mm</FORMAT></VAR></LINE>\n<LINE>Operator:<VAR><NAME>Operator.FullName</NAME></VAR></LINE>\n<LINE>===============================</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>\n', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Ticket Form For Till'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Ticket Form For Till', N'<LINE>[Image]VisitScotlandLogo.bmp</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Sale No: <VAR><NAME>General.saleNo</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>General.currentDate</NAME><FORMAT>#dd-MM-yyyy</FORMAT></VAR>[Align=Center,FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>General.currentDate</NAME><FORMAT>#HH:mm</FORMAT></VAR>[Align=Center,FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE>Operator: <VAR><NAME>Operator.FullName</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>Sale.ProductName</NAME></VAR>[Align=Center,FontSize=Double]</LINE>\n<LINE>Supplier: <VAR><NAME>Customer.Supplier</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>Sale.TotalPrice</NAME></VAR>[Align=Center,FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE>Name: <VAR><NAME>Customer.FullName</NAME></VAR></LINE>\n<LINE>Phone No: <VAR><NAME>Customer.PhoneNo</NAME></VAR></LINE>\n<LINE>Day: <VAR><NAME>Customer.Day</NAME></VAR></LINE>\n<LINE>Date: <VAR><NAME>Customer.Date</NAME><FORMAT>#dd/MM/yyyy</FORMAT></VAR></LINE>\n<LINE>Time: <VAR><NAME>Customer.Time</NAME><FORMAT>#HH:mm</FORMAT></VAR></LINE>\n<LINE>Location: <VAR><NAME>Customer.Location</NAME></VAR></LINE>\n<LINE>Row/Seat: <VAR><NAME>Customer.RowSeat</NAME></VAR></LINE>\n<LINE>Adult: <VAR><NAME>Customer.Adult</NAME></VAR></LINE>\n<LINE>Senior: <VAR><NAME>Customer.Senior</NAME></VAR></LINE>\n<LINE>Child: <VAR><NAME>Customer.Child</NAME></VAR></LINE>\n<LINE>Student: <VAR><NAME>Customer.Student</NAME></VAR></LINE>\n<LINE>Comments: <VAR><NAME>Customer.Comments</NAME></VAR></LINE>\n<LINE></LINE>\n<LINE>VisitScotland acts as agents for the operator named above but solely for the purpose of sale of this ticket. VisitScotland shall not be liable for the operator''s negligance and shall not be liable for any issues whatsoever incurred by the purchaser and/or holder of this ticket, however caused. This ticket is sold subject to the applicable conditions of sale if any a copy of which is available for inspection.</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Merchant Copy For Till'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Merchant Copy For Till', N'*  MERCHANT COPY  *[Align=Center,Bold=true,Length=40]\n\n<Branch.Name> iCentre[Align=Left,Bold=true,Length=40]\n<Branch.AddressLine2>[Align=Left,Length=40]\n<Branch.AddressLine3>, <Branch.PostCode>[Align=Left,Length=40]\n\nDate:        <general.currentDate|format=dd-MM-yyyy>[Align=Left,Length=40]\nTime:        <general.currentDate|format=HH:mm>[Align=Left,Length=40]\nReceipt no:  <general.saleNo>[Align=Left,Length=40]\n\nMID:         <saleReceipt.mid>[Align=Left,Length=40]\nTID:         <saleReceipt.tid>[Align=Left,Length=40]\nAID:         <saleReceipt.aid>[Align=Left,Length=40]\nPAN Seq No:  <saleReceipt.panSeqNumber|format=00>[Align=Left,Length=40]\n\nPaid by:     <saleReceipt.paidBy>[Align=Left,Length=40]\nCard:        <saleReceipt.cardType>[Align=Left,Length=40]\nCard Number: <saleReceipt.cardNumber>[Align=Left,Length=40]\nExpiry Date: <saleReceipt.cardExpireDate>[Align=Left,Length=40]\nSource:      <saleReceipt.transactionSource>[Align=Left,Length=40]\n\n--------------------------------[Length=40]\n\n<saleReceipt.status>[Align=Center,Bold=true,Length=40,FontSize=Double]\n\nTOTAL[Bold=true,Length=14,FontSize=Double]<SaleReceipt.cardPurchase>[Align=Right,Bold=true,Length=26,FontSize=Double]\n\n--------------------------------[Length=40]\nThe customer''s account has been debited with the total.[Align=Left,Length=40]\n\n\nPlease retain a copy for your records[Align=Left,Length=40]\n\n\n--------------------------------[Length=40]\n\n\n\n\n\n#knife#\n', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Declaration Summary For Till'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Declaration Summary For Till', N'Date: <general.currentDate|format=dd-MM-yyyy> <general.currentDate|format=HH:mm>[Length=40]\nDevice: <general.deviceId>[Length=40]\nLocation: <SaleLocations.Name>[Length=40]\nUser: <Operator.FullName>[Length=40]\n\n----------- DECLARATION --------[Length=40]\n\nDec.[Align=Right,Length=24]Amt.[Align=Right,Length=8]Diff[Align=Right,Length=8]\n[tablestart]DeclarationDetails\n[Length=15,tablename=DeclarationDetails,columnname=Label][Align=Right,Length=9,tablename=DeclarationDetails,columnname=Declared][Align=Right,Length=8,tablename=DeclarationDetails,columnname=CalculatedAmount][Align=Right,Length=8,tablename=DeclarationDetails,columnname=Diff]\n[tableend]DeclarationDetails\n\nSign:[Length=40] [Length=40] [Length=40] [Length=40][Length=40]\n\n\n--------------------------------[Length=40]\n\n\n\n\n\n', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Sale Refund'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Sale Refund', N'<LINE>[Image]VisitScotlandLogo.bmp</LINE>\n<LINE></LINE>\n<LINE><Branch.Name> iCentre[Align=Center]</LINE>\n<LINE><Branch.AddressLine2>[Align=Center]</LINE>\n<LINE><Branch.AddressLine3>, <Branch.PostCode>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE>Date:<VAR><NAME>General.currentDate</NAME><FORMAT>#dd/MM/yyyy HH:mm</FORMAT></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Table:<VAR><NAME>General.table</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Operator:<VAR><NAME>Operator.FirstName</NAME></VAR> <VAR><NAME>Operator.LastName</NAME></VAR> / <VAR><NAME>General.deviceid</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE><TABLESTART>Sales</TABLESTART></LINE>\n<LINE>Receipt No:[Length=11]<TABLEFIELD><NAME>Sales.DocumentNo</NAME></TABLEFIELD>[Align=Left,Length=29,Emphasize=Emphasized]</LINE>\n<LINE><TABLEEND>Sales</TABLEEND></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>-------- REFUND RECEIPT -------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>SaleDetails</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>SaleDetails.SumQTY</NAME></TABLEFIELD>[Align=Right,Length=3] x [Align=Center,Length=3]<TABLEFIELD><NAME>SaleDetails.ProductPrintName</NAME></TABLEFIELD>[Align=Left,Length=23]<TABLEFIELD><NAME>SaleDetails.TaxLabel</NAME></TABLEFIELD>[Align=Left,Length=3]<TABLEFIELD><NAME>SaleDetails.SumPrice</NAME><FORMAT>!0.00</FORMAT></TABLEFIELD>[Align=Right,Length=8]</LINE>\n<LINE><TABLEEND>SaleDetails</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>Total:[Align=Left,Length=16,Width=Double,Emphasize=Emphasized]<VAR><NAME>Currencies.name</NAME></VAR>[Align=Left,Length=9,Width=Double,Emphasize=Emphasized]<VAR><NAME>General.amount</NAME><FORMAT>!0.00</FORMAT></VAR>[Align=Right,Length=15,Width=Double]</LINE>\n<LINE>-------------------------------[Align=Center]</LINE>\n<LINE><TABLESTART>Payments</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Payments.DescriptionPOS</NAME></TABLEFIELD>[Align=Left,Length=18]<TABLEFIELD><NAME>Payments.DocCurrencyName</NAME></TABLEFIELD>[Align=Left,Length=9]<TABLEFIELD><NAME>Payments.DocCurrencyAmount</NAME><FORMAT>!0.00</FORMAT></TABLEFIELD>[Align=Right,Length=13]</LINE>\n<LINE><TABLEEND>Payments</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>VAT Code  Rate(%)  Currency Goods  VAT  </LINE>\n<LINE><TABLESTART>Sales.Taxes</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Sales.Taxes.Label</NAME></TABLEFIELD>[Align=Left,Length=10]<TABLEFIELD><NAME>Sales.Taxes.Rate</NAME><FORMAT>!0.00</FORMAT></TABLEFIELD>[Align=Left,Length=9]<VAR><NAME>Currencies.name</NAME></VAR>[Align=Left,Length=9]<TABLEFIELD><NAME>Sales.Taxes.ItemsAmount</NAME><FORMAT>!0.00</FORMAT></TABLEFIELD>[Align=Left,Length=7]<TABLEFIELD><NAME>Sales.Taxes.ItemsTax</NAME><FORMAT>!0.00</FORMAT></TABLEFIELD>[Length=5]</LINE>\n<LINE><TABLEEND>Sales.Taxes</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>Total VAT:[Align=Left,Length=18]<VAR><NAME>Currencies.name</NAME></VAR>[Align=Left,Length=10]<VAR><NAME>MerchantCopy.goodsTotal</NAME></VAR>[Align=Left,Length=7]<VAR><NAME>MerchantCopy.taxTotal</NAME><FORMAT>!0.00</FORMAT></VAR>[Align=Left,Length=5]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Sign:[Emphasize=Emphasized,Length=40]\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Thank you[Align=Center]</LINE>\n<LINE>Please tell us how we did today[Align=Center,Emphasize=Emphasized]</LINE>\n<LINE>and use our member feedback tablet[Align=Center]</LINE>\n<LINE>on every visit[Align=Center]</LINE>\n<LINE></LINE>\n<LINE>-------------------------------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>\n', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Kitchen Print Cancel'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Kitchen Print Cancel', N'<LINE>#TRACE PRINT TEMPLATE VARIABLES#</LINE>\n<LINE>Date: <VAR><NAME>General.currentDate<FORMAT>#dd/MM/yyyy HH:mm</FORMAT></NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Location: <VAR><NAME>SaleLocations.SysID</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Operator: <VAR><NAME>Operator.FirstName</NAME></VAR><VAR><NAME>Operator.LastName</NAME></VAR> / <VAR><NAME>General.deviceId</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Table: <VAR><NAME>General.tableservice</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>RefNo: <VAR><NAME>General.saleNo</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE>VOID[Align=Center,Length=32,Width=Double,Emphasize=Emphasized]</LINE>\n<LINE>------ Cancel Kitchen Print ------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>KitchenPrints</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>KitchenPrints.QTY</NAME></TABLEFIELD>[Align=Right,Length=7] x [Length=3]<TABLEFIELD><NAME>KitchenPrints.ProductPrintName</NAME></TABLEFIELD>[Align=Left,Length=30]</LINE>\n<LINE>+[Length=7]<TABLEFIELD><NAME>KitchenPrints.Condiments</NAME></TABLEFIELD>[Align=Left,Length=33]</LINE>\n<LINE>Note: [Length=7]<TABLEFIELD><NAME>KitchenPrints.Note</NAME></TABLEFIELD>[Align=Left,Length=33]</LINE>\n<LINE><TABLEEND>KitchenPrints</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>-------------------------------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>\n', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

		IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Cash Lift'  and [DeviceType] = 0)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Cash Lift', N'<LINE>[Image]Cash Lift0.bmp</LINE>\n<LINE>Date: <VAR><NAME>General.currentDate</NAME><FORMAT>#dd/MM/yyyy HH:mm</FORMAT></VAR></LINE>\n<LINE>Location: <VAR><NAME>SaleLocations.Name</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Operator: <VAR><NAME>Operator.FirstName</NAME></VAR><VAR><NAME>Operator.LastName</NAME></VAR> / <VAR><NAME>General.deviceId</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE>--------- Money Taken ---------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>CashLift.title</NAME></VAR>[Align=Left,Length=20]<VAR><NAME>CashLift.amount</NAME></VAR>[Align=Right,Length=12]</LINE>\n<LINE></LINE>\n<LINE>Sign:</LINE>\n<LINE></LINE>\n<LINE>-------------------------------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>', 1,0,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Ticket Form'  and [DeviceType] = 1)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version], [DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Ticket Form', N'<LINE>[Image]VisitScotlandLogo.png</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Sale No: <VAR><NAME>General.saleNo</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>General.currentDate</NAME><FORMAT>#dd-MM-yyyy</FORMAT></VAR>[Align=Center,FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>General.currentDate</NAME><FORMAT>#HH:mm</FORMAT></VAR>[Align=Center,FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE>Operator: <VAR><NAME>Operator.FullName</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>Sale.ProductName</NAME></VAR>[Align=Center,FontSize=Double]</LINE>\n<LINE><VAR><NAME>Customer.Supplier</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>Sale.TotalPrice</NAME></VAR>[Align=Center,FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE>Name: <VAR><NAME>Customer.FullName</NAME></VAR></LINE>\n<LINE>Phone No: <VAR><NAME>Customer.PhoneNo</NAME></VAR></LINE>\n<LINE>Day: <VAR><NAME>Customer.Day</NAME></VAR></LINE>\n<LINE>Date: <VAR><NAME>Customer.Date</NAME><FORMAT>#dd/MM/yyyy</FORMAT></VAR></LINE>\n<LINE>Time: <VAR><NAME>Customer.Time</NAME><FORMAT>#HH:mm</FORMAT></VAR></LINE>\n<LINE>Location: <VAR><NAME>Customer.Location</NAME></VAR></LINE>\n<LINE>Row/Seat: <VAR><NAME>Customer.RowSeat</NAME></VAR></LINE>\n<LINE>Adult: <VAR><NAME>Customer.Adult</NAME></VAR></LINE>\n<LINE>Senior: <VAR><NAME>Customer.Senior</NAME></VAR></LINE>\n<LINE>Child: <VAR><NAME>Customer.Child</NAME></VAR></LINE>\n<LINE>Student: <VAR><NAME>Customer.Student</NAME></VAR></LINE>\n<LINE>Comments: <VAR><NAME>Customer.Comments</NAME></VAR></LINE>\n<LINE></LINE>\n<LINE>Visit Scotland acts as agents for the operator named above but solely for the purpose of sale of this ticket. VisitScotland shall not be liable for the operator''s negligance and shall not be liable for any issues whatsoever incurred by the purchaser and/or holder of this ticket, however caused. This ticket is sold subject to the applicable conditions of sale if any a copy of which is available for inspection.</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>', 1,1,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Ticket'  and [DeviceType] = 1)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Ticket', N'<LINE>[Image]VisitScotlandLogo.png</LINE>\n<LINE></LINE>\n<LINE><Branch.Name> iCentre[Align=Center]</LINE>\n<LINE><Branch.AddressLine2>[Align=Center]</LINE>\n<LINE><Branch.AddressLine3>, <Branch.PostCode>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Sales Receipt[Align=Center,FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Transaction #: <VAR><NAME>General.saleNo</NAME></VAR></LINE>\n<LINE>Date: <VAR><NAME>General.currentDate</NAME><FORMAT>#dd/MM/yyyy</FORMAT></VAR></LINE>\n<LINE>Time: <VAR><NAME>General.currentDate</NAME><FORMAT>#HH:mm:ss</FORMAT></VAR></LINE>\n<LINE>Cashier: <VAR><NAME>Operator.Code</NAME></VAR></LINE>\n<LINE>Register #: <VAR><NAME>General.deviceid</NAME></VAR></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Item[Length=10]Description[Length=14]Amount[Length=8,Align=Right]</LINE>\n<LINE>===========================</LINE>\n<LINE><TABLESTART>SaleDetails</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>SaleDetails.ProductCode</NAME></TABLEFIELD>[Align=Left,Length=10]<TABLEFIELD><NAME>SaleDetails.ProductPrintName</NAME></TABLEFIELD>[Align=Left,Length=14]<TABLEFIELD><NAME>SaleDetails.SumPrice</NAME></TABLEFIELD>[Align=Right,Length=8]</LINE>\n<LINE><TABLEEND>SaleDetails</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>==========[Align=Right]</LINE>\n<LINE>Sub Total:[Length=22,Align=Right]<VAR><NAME>SaleReceipt.SubTotal</NAME></VAR>[Align=Right]</LINE>\n<LINE>Tax: [Length=22,Align=Right]<VAR><NAME>MerchantCopy.TaxTotal</NAME></VAR>[Align=Right]</LINE>\n<LINE>Total: [Length=22,Align=Right]<VAR><NAME>General.Amount</NAME></VAR>[Align=Right]</LINE>\n<LINE>Discount:[Length=22,Align=Right]<VAR><NAME>ticket.discountedPrice</NAME></VAR>[Align=Right]</LINE>\n<LINE>Paid by: [Length=22,Align=Right]<VAR><NAME>SaleReceipt.PaidBy</NAME></VAR>[Align=Right]</LINE>\n<LINE>Change: [Length=22,Align=Right]<VAR><NAME>SaleReceipt.Change</NAME></VAR>[Align=Right]</LINE>\n<LINE></LINE>\n<LINE>VAT Number: 945652105</LINE>\n<LINE></LINE>\n<LINE>--------------------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE>Thank you for purchasing at[Align=Center]</LINE>\n<LINE><Branch.Name> iCentre[Align=Center]</LINE>\n<LINE>Please call again. For further information & inspiration log on to[Align=Center]</LINE>\n<LINE>www.visitscotland.com[Align=Center]</LINE>\n<LINE>or telephone <Branch.PhoneNumber>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>', 1,1,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Customer Copy'  and [DeviceType] = 1)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Customer Copy', N'* CARDHOLDER COPY *[Align=Center,Bold=true,Length=32]\n\nVisit Scotland[Align=Left,Bold=true,Length=32]\><Branch.Name> iCentre\n<Branch.AddressLine2>[Align=Left,Length=32]\<Branch.AddressLine3>, <Branch.PostCode>[Align=Left,Length=32]\n\nDate:        <general.currentDate|format=dd-MM-yyyy>[Align=Left,Length=32]\nTime:        <general.currentDate|format=HH:mm>[Align=Left,Length=32]\nReceipt no:  <general.saleNo>[Align=Left,Length=32]\n\nMID:         <saleReceipt.mid>[Align=Left,Length=32]\nTID:         <saleReceipt.tid>[Align=Left,Length=32]\nAID:         <saleReceipt.aid>[Align=Left,Length=32]\nPAN Seq No:  <saleReceipt.panSeqNumber|format=00>[Align=Left,Length=32]\n\nPaid by:     <saleReceipt.paidBy>[Align=Left,Length=32]\nCard:        <saleReceipt.cardType>[Align=Left,Length=32]\nCard Number: <saleReceipt.cardNumber>[Align=Left,Length=32]\nExpiry date: <saleReceipt.expireDate>[Align=Left,Length=32]\nSource:      <saleReceipt.transactionSource>[Align=Left,Length=32]\n\n\n--------------------------------[Align=Left,Length=32]\n\n<saleReceipt.status>[Align=Center,Bold=true,Length=32,FontSize=Double]\n\nTotal[Align=Left,Bold=true,Length=12]<saleReceipt.cardPurchase>[Align=Right,Bold=true,Length=20]\n\n--------------------------------[Length=32]\nPlease debit my account with the total.[Align=Left,Length=32]\n--------------------------------[Length=32]\n\nItems[Align=Left,Bold=true,Length=17]Tax %[Align=Center,Bold=true,Length=6]Total[Align=Center,Bold=true,Length=8]\n[tablestart]Tax Price\n[Length=17,tablename=Tax Price,columnname=item][Align=Center,Length=6,tablename=Tax Price,columnname=taxRate][Align=Center,Length=9,tablename=Tax Price,columnname=value]\n[tableend]Tax Price\n\n\nPlease retain for your records.[Align=Left,Length=28]\n\n\n--------------------------------[Length=32]\n\n\n', 1,1,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Customer Copy Chip And Sign'  and [DeviceType] = 1)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL,  N'Customer Copy Chip And Sign' ,N'* CARDHOLDER COPY *[Align=Center,Bold=true,Length=32]\<Branch.Name> iCentre\nVisit Scotland[Align=Left,Bold=true,Length=32]\n<Branch.AddressLine2>[Align=Left,Length=32]\n<Branch.AddressLine3>, <Branch.PostCode>[Align=Left,Length=32]\n\nDate:        <general.currentDate|format=dd-MM-yyyy>[Align=Left,Length=32]\nTime:        <general.currentDate|format=HH:mm>[Align=Left,Length=32]\nReceipt no:  <general.saleNo>[Align=Left,Length=32]\n\nMID:         <saleReceipt.mid>[Align=Left,Length=32]\nTID:         <saleReceipt.tid>[Align=Left,Length=32]\nAID:         <saleReceipt.aid>[Align=Left,Length=32]\nPAN seq no:  <saleReceipt.panSeqNumber>[Length=32]\n\nPaid by:     <saleReceipt.paidBy>[Align=Left,Length=32]\nCard:        <saleReceipt.cardType>[Align=Left,Length=32]\nCard Number: <saleReceipt.cardNumber>[Align=Left,Length=32]\nExpiry date: <saleReceipt.cardExpireDate>[Align=Left,Length=32]\nSource:      <saleReceipt.transactionSource>[Length=32]\n\n--------------------------------[Length=32]\n\n<saleReceipt.status>[Align=Center,Bold=true,Length=32,FontSize=Double]\n\nTotal[Bold=true,Length=12]<saleReceipt.cardPurchase>[Align=Right,Bold=true,Length=20]\n\nSign: ..........................[Align=Left,Bold=true,Length=32]\n\n--------------------------------[Length=32]\n\nPlease debit my account with the total.[Align=Left,Length=32]\n\nItems[Align=Left,Bold=true,Length=17]Tax %[Align=Center,Bold=true,Length=6]Total[Align=Center,Bold=true,Length=8]\n[tablestart]Tax Price\n[Length=17,tablename=Tax Price,columnname=item][Align=Center,Length=6,tablename=Tax Price,columnname=taxRate][Align=Center,Length=9,tablename=Tax Price,columnname=value]\n[tableend]Tax Price\n\nPlease retain for your records.[Align=Left,Length=28]\n\n\n--------------------------------[Length=32]\n\n\n', 1,1,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Merchant Copy'  and [DeviceType] = 1)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Merchant Copy', N'*  MERCHANT COPY  *[Align=Center,Bold=true,Length=32]\n\nVisit Scotland[Align=Left,Bold=true,Length=32]\n<Branch.Name> iCentre\n<Branch.AddressLine2>[Align=Left,Length=32]\n<Branch.AddressLine3>, <Branch.PostCode>[Align=Left,Length=32]\n\nDate:        <general.currentDate|format=dd-MM-yyyy>[Align=Left,Length=32]\nTime:        <general.currentDate|format=HH:mm>[Align=Left,Length=32]\nReceipt no:  <general.saleNo>[Align=Left,Length=32]\n\nMID:         <saleReceipt.mid>[Align=Left,Length=32]\nTID:         <saleReceipt.tid>[Align=Left,Length=32]\nAID:         <saleReceipt.aid>[Align=Left,Length=32]\nPAN Seq No:  <saleReceipt.panSeqNumber|format=00>[Align=Left,Length=32]\n\nPaid by:     <saleReceipt.paidBy>[Align=Left,Length=32]\nCard:        <saleReceipt.cardType>[Align=Left,Length=32]\nCard Number: <saleReceipt.cardNumber>[Align=Left,Length=32]\nExpiry Date: <saleReceipt.cardExpireDate>[Align=Left,Length=32]\nSource:      <saleReceipt.transactionSource>[Align=Left,Length=32]\n\n--------------------------------[Length=32]\n\n<saleReceipt.status>[Align=Center,Bold=true,Length=32,FontSize=Double]\n\nTOTAL[Bold=true,Length=12]<saleReceipt.cardPurchase>[Align=Right,Bold=true,Length=20]\n\n--------------------------------[Length=32]\nThe customer''s account has been debited with the total.[Align=Left,Length=32]\n\n\nPlease retain a copy for your records[Align=Left,Length=32]\n\n\n--------------------------------[Length=32]\n\n\n', 1,1,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Merchant Copy Chip And Sign'  and [DeviceType] = 1)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Merchant Copy Chip And Sign', N'*  MERCHANT COPY  *[Align=Center,Bold=true,Length=32]\n\nVisit Scotland[Align=Left,Bold=true,Length=32]\n<Branch.Name> iCentre\n<Branch.AddressLine2>[Align=Left,Length=32]\n<Branch.AddressLine3>, <Branch.PostCode>[Align=Left,Length=32]\n\nDate:        <general.currentDate|format=dd-MM-yyyy>[Align=Left,Length=32]\nTime:        <general.currentDate|format=HH:mm>[Align=Left,Length=32]\nReceipt no:  <general.saleNo>[Align=Left,Length=32]\n\nMID:         <saleReceipt.mid>[Align=Left,Length=32]\nTID:         <saleReceipt.tid>[Align=Left,Length=32]\nAID:         <saleReceipt.aid>[Align=Left,Length=32]\nPAN Seq No:  <saleReceipt.panSeqNumber|format=00>[Align=Left,Length=32]\n\nPaid by:     <saleReceipt.paidBy>[Align=Left,Length=32]\nCard:        <saleReceipt.cardType>[Align=Left,Length=32]\nCard Number: <saleReceipt.cardNumber>[Align=Left,Length=32]\nExpiry Date: <saleReceipt.cardExpireDate>[Align=Left,Length=32]\nSource:      <saleReceipt.transactionSource>[Align=Left,Length=32]\n\n--------------------------------[Length=32]\n\n<saleReceipt.status>[Align=Center,Bold=true,Length=32,FontSize=Double]\n\nTOTAL[Bold=true,Length=12]<saleReceipt.cardPurchase>[Align=Right,Bold=true,Length=20]\n\n\nSign: ..........................[Align=Left,Bold=true,Length=32]\n\n--------------------------------[Length=32]\n\nThe customer''s account has been debited with the total.[Length=32]\n\n*** Please retain a copy for      your records ***[Align=Center,Length=32]\n\n\n--------------------------------[Length=32]\n\n\n', 1,1,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'EndOfDay'  and [DeviceType] = 1)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'EndOfDay', N'<LINE>#TRACE PRINT TEMPLATE VARIABLES#</LINE>\n<LINE>----- END OF DAY REPORT -------[Align=Center,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE>Branch:<VAR><NAME>Operator.BranchID</NAME></VAR>Terminal:<VAR><NAME>General.deviceid</NAME></VAR></LINE>\n<LINE>===============================</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>Table</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table.QTY</NAME></TABLEFIELD>[Align=Right,Length=7]<TABLEFIELD><NAME>Table.Value</NAME></TABLEFIELD>[Align=Right,Length=8]\n<LINE><TABLEEND>Table</TABLEEND></LINE>\n<LINE></LINE>\n<LINE><TABLESTART>Table1</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table1.Label</NAME></TABLEFIELD>[Align=Right,Length=23]<TABLEFIELD><NAME>Table1.Value</NAME></TABLEFIELD>[Align=Right,Length=8]\n<LINE><TABLEEND>Table1</TABLEEND></LINE>\n<LINE>-------------------------------</LINE>\n<LINE>VAT ANALYSIS</LINE>\n<LINE></LINE>\n<LINE>Details Goods(Ex) Vat</LINE>\n<LINE>-------------------------------</LINE>\n<LINE><TABLESTART>Table2</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table2.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table2.Goods</NAME></TABLEFIELD>[Align=Right,Length=7]<TABLEFIELD><NAME>Table2.Vat</NAME></TABLEFIELD>[Align=Right,Length=8]\n<LINE><TABLEEND>Table2</TABLEEND></LINE>\n<LINE>===============================</LINE>\n<LINE>REFUND REASONS</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>Table3</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table3.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table3.QTY</NAME></TABLEFIELD>[Align=Right,Length=7]<TABLEFIELD><NAME>Table3.Value</NAME></TABLEFIELD>[Align=Right,Length=8]\n<LINE><TABLEEND>Table3</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>-------------------------------</LINE>\n<LINE></LINE>\n<LINE>DISCOUNT REASONS</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>Table4</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table4.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table4.QTY</NAME></TABLEFIELD>[Align=Right,Length=7]<TABLEFIELD><NAME>Table4.Value</NAME></TABLEFIELD>[Align=Right,Length=8]\n<LINE><TABLEEND>Table4</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>===============================</LINE>\n<LINE><TABLESTART>Table5</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table5.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table5.DocumentNo</NAME></TABLEFIELD>[Align=Left,Length=15]\n<LINE><TABLEEND>Table5</TABLEEND></LINE>\n<LINE>-------------------------------</LINE>\n<LINE>Date:<VAR><NAME>General.currentDate</NAME><FORMAT>#dd-MM-yyyy</FORMAT></VAR>Time:<VAR><NAME>General.currentDate</NAME><FORMAT>#HH:mm</FORMAT></VAR></LINE>\n<LINE>Operator:<VAR><NAME>Operator.FullName</NAME></VAR></LINE>\n<LINE>===============================</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>\n', 1,1,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Declaration Summary'  and [DeviceType] = 1)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Declaration Summary', N'Date: <general.currentDate|format=dd-MM-yyyy> <general.currentDate|format=HH:mm>[Length=32]\nDevice: <general.deviceId>[Length=32]\nLocation: <SaleLocations.Name>[Length=32]\nUser: <Operator.FullName>[Length=32]\n\n----------- DECLARATION --------[Length=32]\n\nDec.[Align=Right,Length=22]QTY[Align=Right,Length=3]Amt.[Align=Right,Length=7]\n[tablestart]DeclarationDetails\n[Length=15,tablename=DeclarationDetails,columnname=Label][Align=Right,Length=7,tablename=DeclarationDetails,columnname=Declared][Align=Right,Length=3,tablename=DeclarationDetails,columnname=CalculatedQTY][Align=Right,Length=7,tablename=DeclarationDetails,columnname=CalculatedAmount]\n[tableend]DeclarationDetails\n\nSign:[Length=32] [Length=32] [Length=32] [Length=32][Length=32]\n\n\n--------------------------------[Length=32]\n\n', 1,1,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Refund'  and [DeviceType] = 1)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Refund', N'<LINE>[Image]VisitScotlandLogo.bmp</LINE>\n<LINE></LINE>\n<LINE><Branch.Name> iCentre[Align=Center]</LINE>\n<LINE><Branch.AddressLine2>[Align=Center]</LINE>\n<LINE><Branch.AddressLine3>, <Branch.PostCode>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE>Date:<VAR><NAME>General.currentDate</NAME><FORMAT>#dd/MM/yyyy HH:mm</FORMAT></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Table:<VAR><NAME>General.table</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Operator:<VAR><NAME>Operator.FirstName</NAME></VAR> <VAR><NAME>Operator.LastName</NAME></VAR> / <VAR><NAME>General.deviceid</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Receipt No:[Length=11]<VAR><NAME>General.SaleNo</NAME></VAR>[Align=Left,Length=21,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>-------- REFUND RECEIPT -------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>SaleDetails</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>SaleDetails.SumQTY</NAME></TABLEFIELD>[Align=Left,Length=3]<TABLEFIELD><NAME>SaleDetails.ProductPrintName</NAME></TABLEFIELD>[Align=Left,Length=20]<TABLEFIELD><NAME>SaleDetails.TaxLabel</NAME></TABLEFIELD>[Align=Left,Length=3]<TABLEFIELD><NAME>SaleDetails.SumPrice</NAME><FORMAT>!0.00</FORMAT></TABLEFIELD>[Align=Right,Length=6]</LINE>\n<LINE><TABLEEND>SaleDetails</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>Total:[Align=Left,Length=8,Emphasize=Emphasized]<VAR><NAME>Currencies.name</NAME></VAR>[Align=Right,Length=9,Emphasize=Emphasized]<VAR><NAME>MerchantCopy.goodsTotal</NAME><FORMAT>!0.00</FORMAT></VAR>[Align=Right,Length=15]</LINE>\n<LINE>-------------------------------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE>VAT Code  Rate(%)  Currency Goods  VAT  </LINE>\n<LINE><TABLESTART>Sales.Taxes</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Sales.Taxes.Label</NAME></TABLEFIELD>[Align=Left,Length=9]<TABLEFIELD><NAME>Sales.Taxes.Rate</NAME><FORMAT>!0.00</FORMAT></TABLEFIELD>[Align=Left,Length=6]<VAR><NAME>Currencies.name</NAME></VAR>[Align=Left,Length=6]<TABLEFIELD><NAME>Sales.Taxes.ItemsAmount</NAME><FORMAT>!0.00</FORMAT></TABLEFIELD>[Align=Left,Length=6]<TABLEFIELD><NAME>Sales.Taxes.ItemsTax</NAME><FORMAT>!0.00</FORMAT></TABLEFIELD>[Length=5]</LINE>\n<LINE><TABLEEND>Sales.Taxes</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>Total VAT:[Align=Left,Length=11]<VAR><NAME>Currencies.name</NAME></VAR>[Align=Left,Length=6]<VAR><NAME>MerchantCopy.goodsTotal</NAME><FORMAT>!0.00</FORMAT></VAR>[Align=Left,Length=6]<VAR><NAME>MerchantCopy.taxTotal</NAME><FORMAT>!0.00</FORMAT></VAR>[Align=Left,Length=9]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Sign:[Emphasize=Emphasized,Length=32]\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Thank you[Align=Center]</LINE>\n<LINE>Please tell us how we did today[Align=Center,Emphasize=Emphasized]</LINE>\n<LINE>and use our member feedback tablet[Align=Center]</LINE>\n<LINE>on every visit[Align=Center]</LINE>\n<LINE></LINE>\n<LINE>-------------------------------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>', 1,1,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'EndOfDay'  and [DeviceType] = 1)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'EndOfDay', N'<LINE>#TRACE PRINT TEMPLATE VARIABLES#</LINE>\\n<LINE>----- END OF DAY REPORT -------[Align=Center,Emphasize=Emphasized]</LINE>\\n<LINE></LINE>\\n<LINE>Branch:<VAR><NAME>Operator.BranchID</NAME></VAR>Terminal:<VAR><NAME>General.deviceid</NAME></VAR></LINE>\\n<LINE>===============================</LINE>\\n<LINE></LINE>\\n<LINE><TABLESTART>Table</TABLESTART></LINE>\\n<LINE><TABLEFIELD><NAME>Table.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table.QTY</NAME></TABLEFIELD>[Align=Right,Length=7]<TABLEFIELD><NAME>Table.Value</NAME></TABLEFIELD>[Align=Right,Length=8]\\n<LINE><TABLEEND>Table</TABLEEND></LINE>\\n<LINE></LINE>\\n<LINE><TABLESTART>Table1</TABLESTART></LINE>\\n<LINE><TABLEFIELD><NAME>Table1.Label</NAME></TABLEFIELD>[Align=Right,Length=23]<TABLEFIELD><NAME>Table1.Value</NAME></TABLEFIELD>[Align=Right,Length=8]\\n<LINE><TABLEEND>Table1</TABLEEND></LINE>\\n<LINE>-------------------------------</LINE>\\n<LINE>VAT ANALYSIS</LINE>\\n<LINE></LINE>\\n<LINE>Details Goods(Ex) Vat</LINE>\\n<LINE>-------------------------------</LINE>\\n<LINE><TABLESTART>Table2</TABLESTART></LINE>\\n<LINE><TABLEFIELD><NAME>Table2.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table2.Goods</NAME></TABLEFIELD>[Align=Right,Length=7]<TABLEFIELD><NAME>Table2.Vat</NAME></TABLEFIELD>[Align=Right,Length=8]\\n<LINE><TABLEEND>Table2</TABLEEND></LINE>\\n<LINE>===============================</LINE>\\n<LINE>REFUND REASONS</LINE>\\n<LINE></LINE>\\n<LINE><TABLESTART>Table3</TABLESTART></LINE>\\n<LINE><TABLEFIELD><NAME>Table3.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table3.QTY</NAME></TABLEFIELD>[Align=Right,Length=7]<TABLEFIELD><NAME>Table3.Value</NAME></TABLEFIELD>[Align=Right,Length=8]\\n<LINE><TABLEEND>Table3</TABLEEND></LINE>\\n<LINE></LINE>\\n<LINE>-------------------------------</LINE>\\n<LINE></LINE>\\n<LINE>DISCOUNT REASONS</LINE>\\n<LINE></LINE>\\n<LINE><TABLESTART>Table4</TABLESTART></LINE>\\n<LINE><TABLEFIELD><NAME>Table4.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table4.QTY</NAME></TABLEFIELD>[Align=Right,Length=7]<TABLEFIELD><NAME>Table4.Value</NAME></TABLEFIELD>[Align=Right,Length=8]\\n<LINE><TABLEEND>Table4</TABLEEND></LINE>\\n<LINE></LINE>\\n<LINE>===============================</LINE>\\n<LINE><TABLESTART>Table5</TABLESTART></LINE>\\n<LINE><TABLEFIELD><NAME>Table5.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table5.DocumentNo</NAME></TABLEFIELD>[Align=Left,Length=15]\\n<LINE><TABLEEND>Table5</TABLEEND></LINE>\\n<LINE>-------------------------------</LINE>\\n<LINE>Date:<VAR><NAME>General.currentDate</NAME><FORMAT>#dd-MM-yyyy</FORMAT></VAR>Time:<VAR><NAME>General.currentDate</NAME><FORMAT>#HH:mm</FORMAT></VAR></LINE>\\n<LINE>Operator:<VAR><NAME>Operator.FullName</NAME></VAR></LINE>\\n<LINE>===============================</LINE>\\n<LINE></LINE>\\n<LINE></LINE>\\n<LINE></LINE>\\n<LINE></LINE>\\n<LINE></LINE>\\n<LINE></LINE>\\n<LINE>#knife#</LINE>\\n', 1,1,0)
	Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			[dbo].PrintTemplates t,
			[dbo].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Optomany Customer Copy'  and [DeviceType] = 1)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Optomany Customer Copy', N'<LINE>[Image]Logo.bmp</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.merchantName</NAME></VAR>[Align=Left, FontSize=Double, Bold=true]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.merchantLocation</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transDateTime</NAME><FORMAT>#dd/MM/yyyy HH:mm</FORMAT></VAR>[Align=Left]</LINE>\n<LINE>PID: <VAR><NAME>OptomanySaleReceipt.paymentId</NAME></VAR>[Align=Left]</LINE>\n<LINE>MID: <VAR><NAME>OptomanySaleReceipt.merchantId</NAME></VAR>[Align=Left]</LINE>\n<LINE>TID: <VAR><NAME>OptomanySaleReceipt.terminalId</NAME></VAR>[Align=Left]</LINE>\n<LINE>AID: <VAR><NAME>OptomanySaleReceipt.emvAid</NAME></VAR>[Align=Left]</LINE>\n<LINE>RECEIPT NO: <VAR><NAME>OptomanySaleReceipt.receiptNumber</NAME></VAR>[Align=Left]</LINE>\n<LINE>APP SEQ: <VAR><NAME>OptomanySaleReceipt.appSeq</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardType</NAME></VAR>[Align=Right]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardScheme</NAME></VAR>[Align=Right]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardPan</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transType</NAME></VAR>[Align=Left]</LINE>\n<LINE>AMOUNT [Align=Left, Length=7]<VAR><NAME>OptomanySaleReceipt.amountTrans</NAME></VAR>[Align=Right, Length=25]</LINE>\n<LINE>--------------------------------[Align=Center]</LINE>\n<LINE>TOTAL [Align=Left, Bold=true, FontSize=Double, Length=10]<VAR><NAME>OptomanySaleReceipt.amountTrans</NAME></VAR>[Align=Right, Bold=true, FontSize=Double, Length=22]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transApproved</NAME></VAR>[Align=Center, Bold=true, FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE>RESPONSE CODE: <VAR><NAME>OptomanySaleReceipt.responseCode</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cvmPinVerified</NAME></VAR>[Align=Center]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transApprovedLabel</NAME></VAR>[Align=Center]</LINE>\n<LINE>AUTH CODE: <VAR><NAME>OptomanySaleReceipt.authorisationCode</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE>**CARDHOLDER COPY**[Align=Center, Bold=true]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>', 1,1,0)
	Insert into PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			PrintTemplates t,
			Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Optomany Merchant Copy'  and [DeviceType] = 1)
	BEGIN
	INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Optomany Merchant Copy', N'<LINE>[Image]Logo.bmp</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.merchantName</NAME></VAR>[Align=Left, FontSize=Double, Bold=true]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.merchantLocation</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transDateTime</NAME><FORMAT>#dd/MM/yyyy HH:mm</FORMAT></VAR>[Align=Left]</LINE>\n<LINE>PID: <VAR><NAME>OptomanySaleReceipt.paymentId</NAME></VAR>[Align=Left]</LINE>\n<LINE>MID: <VAR><NAME>OptomanySaleReceipt.merchantId</NAME></VAR>[Align=Left]</LINE>\n<LINE>TID: <VAR><NAME>OptomanySaleReceipt.terminalId</NAME></VAR>[Align=Left]</LINE>\n<LINE>AID: <VAR><NAME>OptomanySaleReceipt.emvAid</NAME></VAR>[Align=Left]</LINE>\n<LINE>RECEIPT NO: <VAR><NAME>OptomanySaleReceipt.receiptNumber</NAME></VAR>[Align=Left]</LINE>\n<LINE>APP SEQ: <VAR><NAME>OptomanySaleReceipt.appSeq</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardType</NAME></VAR>[Align=Right]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardScheme</NAME></VAR>[Align=Right]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardPan</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transType</NAME></VAR>[Align=Left]</LINE>\n<LINE>AMOUNT [Align=Left, Length=7]<VAR><NAME>OptomanySaleReceipt.amountTrans</NAME></VAR>[Align=Right, Length=25]</LINE>\n<LINE>--------------------------------[Align=Center]</LINE>\n<LINE>TOTAL [Align=Left, Bold=true, FontSize=Double, Length=10]<VAR><NAME>OptomanySaleReceipt.amountTrans</NAME></VAR>[Align=Right, Bold=true, FontSize=Double, Length=22]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transApproved</NAME></VAR>[Align=Center, Bold=true, FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE>RESPONSE CODE: <VAR><NAME>OptomanySaleReceipt.responseCode</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cvmPinVerified</NAME></VAR>[Align=Center]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transApprovedLabel</NAME></VAR>[Align=Center]</LINE>\n<LINE>AUTH CODE: <VAR><NAME>OptomanySaleReceipt.authorisationCode</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE>**MERCHANT COPY**[Align=Center, Bold=true]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>', 1,1,0)
	Insert into PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			PrintTemplates t,
			Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

    IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Gift Receipt For Till'  and [DeviceType] = 0)
        BEGIN
            INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) 
            VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, 
                    N'Gift Receipt For Till', 
                    N'<LINE></LINE>\n<LINE>Castell Coch[Align=Center]</LINE>\n<LINE>[Align=Center]</LINE>\n<LINE>, F15 7JS[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Sales Receipt[Align=Center,FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Transaction #:[Length=20] <VAR><NAME>General.saleNo</NAME></VAR>[Length=20]</LINE>\n<LINE>Date: <VAR><NAME>General.currentDate</NAME><FORMAT>#dd/MM/yyyy</FORMAT></VAR>[Length=20]Time: <VAR><NAME>General.currentDate</NAME><FORMAT>#HH:mm:ss</FORMAT></VAR>[Length=20]</LINE>\n<LINE>Cashier: <VAR><NAME>Operator.Code</NAME></VAR>[Length=20]Register #: <VAR><NAME>General.deviceid</NAME></VAR>[Length=20]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Item[Length=12]Description[Length=28]</LINE>\n<LINE>=====================================</LINE>\n<LINE><TABLESTART>SaleDetails</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>SaleDetails.ProductCode</NAME></TABLEFIELD>[Align=Left,Length=12]<TABLEFIELD><NAME>SaleDetails.ProductPrintName</NAME></TABLEFIELD>[Align=Left,Length=20]</LINE>\n<LINE><TABLEEND>SaleDetails</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>==========[Align=Right]</LINE>\n<LINE></LINE>\n<LINE>VAT Number: 945652105</LINE>\n<LINE></LINE>\n<LINE>--------------------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE>Thank you for purchasing at[Align=Center]</LINE>\n<LINE>Please call again. For further information & inspiration log on to[Align=Center]</LINE>\n<LINE>or telephone [Align=Center]</LINE>\n<LINE></LINE>\n<LINE><BarCode>[BARCODE]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>', 
                    1,0,0)
            Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
            select
                0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
            from
                [dbo].PrintTemplates t,
                [dbo].Branches b
            where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
        END
	
    IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Gift Receipt'  and [DeviceType] = 1)
    BEGIN
        INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies])
        VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL,
                N'Gift Receipt',
                N'<LINE>[Image]VisitScotlandLogo.png</LINE>\n<LINE></LINE>\n<LINE>Head Office iCentre[Align=Center]</LINE>\n<LINE>[Align=Center]</LINE>\n<LINE>, [Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Gift Receipt[Align=Center,FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Transaction #: </LINE>\n<LINE><VAR><NAME>General.saleNo</NAME></VAR></LINE>\n<LINE>Date: <VAR><NAME>General.currentDate</NAME><FORMAT>#dd/MM/yyyy</FORMAT></VAR></LINE>\n<LINE>Time: <VAR><NAME>General.currentDate</NAME><FORMAT>#HH:mm:ss</FORMAT></VAR></LINE>\n<LINE>Cashier: <VAR><NAME>Operator.Code</NAME></VAR></LINE>\n<LINE>Register #: <VAR><NAME>General.deviceid</NAME></VAR></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>Item[Length=10]Description[Length=22]</LINE>\n<LINE>================================</LINE>\n<LINE><TABLESTART>SaleDetails</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>SaleDetails.ProductCode</NAME></TABLEFIELD>[Align=Left,Length=10]<TABLEFIELD><NAME>SaleDetails.ProductPrintName</NAME></TABLEFIELD>[Align=Left,Length=22]</LINE>\n<LINE><TABLEEND>SaleDetails</TABLEEND></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>--------------------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE>Thank you for purchasing at[Align=Center]</LINE>\n<LINE>Head Office iCentre[Align=Center]</LINE>\n<LINE>Please call again. For further information & inspiration log on to[Align=Center]</LINE>\n<LINE>www.visitscotland.com[Align=Center]</LINE>\n<LINE>or telephone [Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>',
                1,1,0)
        Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
        select
            0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
        from
            [dbo].PrintTemplates t,
            [dbo].Branches b
        where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
    END



	Update [dbo].[PrintTemplates] set [Code] = [Code]

	
end

IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'Kitchen Print For Go2'  and [DeviceType] = 1)
     BEGIN
         INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies])
         VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL,
                 N'Kitchen Print For Go2',
                 N'<LINE>#TRACE PRINT TEMPLATE VARIABLES#</LINE>
<LINE>_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _</LINE>
<LINE></LINE>
<LINE>Date: <VAR><NAME>General.currentDate<FORMAT>#dd/MM/yyyy HH:mm</FORMAT></NAME></VAR>[Align=Left]</LINE>
<LINE></LINE>
<LINE>Operator: <VAR><NAME>Operator.FirstName</NAME></VAR>/<VAR><NAME>General.deviceId</NAME></VAR>[Align=Left]</LINE>
<LINE></LINE>
<LINE><VAR><NAME>TableGroup.Name</NAME></VAR>[Align=Left,Emphasize=Emphasized,FontSize=Double,StrikeThrought=True]</LINE>
<LINE><VAR><NAME>Table.Name</NAME></VAR>[Align=Left,Emphasize=Emphasized,FontSize=Double]</LINE>
<LINE></LINE>
<LINE>. . . . . . Kitchen Print . . . . . .[Align=Left]</LINE>
<LINE></LINE>
<LINE><TABLESTART>KitchenPrints</TABLESTART></LINE>
<LINE><TABLEFIELD><NAME>KitchenPrints.QTY</NAME></TABLEFIELD>[Align=Left,Length=3,Bold=true,FontSize=Double] x [Bold=true,Length=2,FontSize=22]<TABLEFIELD><NAME>KitchenPrints.ProductPrintName</NAME></TABLEFIELD>[Bold=true,FontSize=Double]<TABLEFIELD><NAME>KitchenPrints.Allergens</NAME></TABLEFIELD>[Bold=true]</LINE>
<LINE><TABLEEND>KitchenPrints</TABLEEND></LINE>
<LINE>. . . . . . . . . . . . . . . . . . .[Align=Left]</LINE>
<LINE>Receipt No:   <VAR><NAME>General.saleNo</NAME></VAR>[Length=20]</LINE>',
                 1,1,0)
         Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
         select
             0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
         from
             [dbo].PrintTemplates t,
             [dbo].Branches b
         where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
     END

-- For Till 
-- IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'{CODE}'  and [DeviceType] = 0)
--     BEGIN
--         INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies])
--         VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL,
--                 N'{CODE}',
--                 N'{TEMPLATE}',
--                 1,0,0)
--         Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
--         select
--             0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
--         from
--             [dbo].PrintTemplates t,
--             [dbo].Branches b
--         where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
--     END

-- FOR PAX
-- IF NOT EXISTS (SELECT * FROM [dbo].[PrintTemplates] where [Code] = N'{CODE}'  and [DeviceType] = 1)
--     BEGIN
--         INSERT [dbo].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies])
--         VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL,
--                 N'{CODE}',
--                 N'{TEMPLATE}',
--                 1,1,0)
--         Insert into [dbo].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
--         select
--             0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
--         from
--             [dbo].PrintTemplates t,
--             [dbo].Branches b
--         where t.Id  not in (select tm.[PrintTemplateId] from [dbo].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
--     END

