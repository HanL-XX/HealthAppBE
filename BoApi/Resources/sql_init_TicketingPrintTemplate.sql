IF OBJECT_ID('tickets.PrintTemplates', 'U') IS NOT NULL
begin

	IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Declaration Summary For Till'  and [DeviceType] = 0)
	BEGIN
	INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Declaration Summary For Till', N'Date: <general.currentDate|format=dd-MM-yyyy> <general.currentDate|format=HH:mm>[Length=40]\nDevice: <general.deviceId>[Length=40]\nLocation: <SaleLocations.Name>[Length=40]\nUser: <Operator.FullName>[Length=40]\n\n----------- DECLARATION --------[Length=40]\n\nDec.[Align=Right,Length=24]Amt.[Align=Right,Length=8]Diff[Align=Right,Length=8]\n[tablestart]DeclarationDetails\n[Length=15,tablename=DeclarationDetails,columnname=Label][Align=Right,Length=9,tablename=DeclarationDetails,columnname=Declared][Align=Right,Length=8,tablename=DeclarationDetails,columnname=CalculatedAmount][Align=Right,Length=8,tablename=DeclarationDetails,columnname=Diff]\n[tableend]DeclarationDetails\n\nSign:[Length=40] [Length=40] [Length=40] [Length=40][Length=40]\n\n\n--------------------------------[Length=40]\n\n\n\n\n\n', 1,0,0)
	Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			tickets.PrintTemplates t,
			tickets.Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END
	
	IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'End of Shift'  and [DeviceType] = 0)
	BEGIN
	INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'End of Shift', N'Date:<general.currentDate|format=dd-MM-yyyy><general.currentDate|format=HH:mm>[Length=32]\nDevice ID: <general.deviceId>[Length=32]\nLocation: <general.location>[Length=32]\nUser: <general.user>[Length=32]\n\n\n-----------DECLARATION----------[Align=Center,Length=32]\n<general.deviceId>[Align=Center,Length=32]\nDeclared[Align=Right,Length=32]\n[tablestart]Declaration\n[Length=23,tablename=Declaration,columnname=Label][Align=Right,Length=9,tablename=Declaration,columnname=Declared]\n[tableend]Declaration\n<general.location>[Align=Center,Length=32]\nSign:[Length=32]\n\n\n\n--------------------------------[Length=32]\n\n\n\n\n\n', 1,0,0)
	Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			tickets.PrintTemplates t,
			tickets.Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Revenue'  and [DeviceType] = 0)
	BEGIN
	INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Revenue', N'<LINE>[Image]Logo.bmp</LINE>\n<LINE>Cashier: <VAR><NAME>Operator.FullName</NAME></VAR><VAR><NAME>General.deviceId<FORMAT>!0000</FORMAT></NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Date:<VAR><NAME>General.currentDate<FORMAT>#dd/MM/yyyy HH:mm</FORMAT></NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE>Location:<VAR><NAME>SaleLocations.SysID</NAME></VAR>[Align=Left,Emphasize=Emphasized]</LINE>\n<LINE> </LINE>\n<LINE>-------------------------------[Align=Center]</LINE>\n<LINE> </LINE>\n<LINE>Operator:<VAR><NAME>Operator.FullName</NAME></VAR></LINE>\n<LINE> </LINE>\n<LINE>----------- REVENUE -----------[Align=Center]</LINE>\n<LINE>QTY[Align=Right,Length=24]Amt.[Align=Right,Length=8]</LINE>\n<LINE><TABLESTART>RevenueData</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>RevenueData.Label</NAME></TABLEFIELD>[Align=Left,Length=18]<TABLEFIELD><NAME>RevenueData.CalculatedQTY</NAME></TABLEFIELD>[Align=Right,Length=6]<TABLEFIELD><NAME>RevenueData.CalculatedAmount</NAME></TABLEFIELD>[Align=Right,Length=8]</LINE>\n<LINE><TABLEEND>RevenueData</TABLEEND></LINE>\n<LINE> </LINE>\n<LINE>-------------------------------[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>\n', 1,0,0)
	Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			tickets.PrintTemplates t,
			tickets.Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Merchant Copy For Till'  and [DeviceType] = 0)
	BEGIN
	INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Merchant Copy For Till', N'*  MERCHANT COPY  *[Align=Center,Bold=true,Length=40]\n\nEdinburgh iCentre[Align=Left,Bold=true,Length=40]\nCity Chambers, 249 High Street[Align=Left,Length=40]\nEdinburgh, EH1 1YJ[Align=Left,Length=40]\n\nDate:        <general.currentDate|format=dd-MM-yyyy>[Align=Left,Length=40]\nTime:        <general.currentDate|format=HH:mm>[Align=Left,Length=40]\nReceipt no:  <general.saleNo>[Align=Left,Length=40]\n\nMID:         <saleReceipt.mid>[Align=Left,Length=40]\nTID:         <saleReceipt.tid>[Align=Left,Length=40]\nAID:         <saleReceipt.aid>[Align=Left,Length=40]\nPAN Seq No:  <saleReceipt.panSeqNumber|format=00>[Align=Left,Length=40]\n\nPaid by:     <saleReceipt.paidBy>[Align=Left,Length=40]\nCard:        <saleReceipt.cardType>[Align=Left,Length=40]\nCard Number: <saleReceipt.cardNumber>[Align=Left,Length=40]\nExpiry Date: <saleReceipt.cardExpireDate>[Align=Left,Length=40]\nSource:      <saleReceipt.transactionSource>[Align=Left,Length=40]\n\n--------------------------------[Length=40]\n\n<saleReceipt.status>[Align=Center,Bold=true,Length=40,FontSize=Double]\n\nTOTAL[Bold=true,Length=14,FontSize=Double]<SaleReceipt.cardPurchase>[Align=Right,Bold=true,Length=26,FontSize=Double]\n\n--------------------------------[Length=40]\nThe customer''s account has been debited with the total.[Align=Left,Length=40]\n\n\nPlease retain a copy for your records[Align=Left,Length=40]\n\n\n--------------------------------[Length=40]\n\n\n\n\n\n#knife#\n', 1,0,0)
	Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			tickets.PrintTemplates t,
			tickets.Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END
	    
	IF NOT EXISTS(SELECT *
              FROM [tickets].[PrintTemplates]
              where [Code] = N'Group Tickets'
                and [DeviceType] = 0)
BEGIN
        INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate],
                                           [UpdatedBy], [Code], [Template], [Version], [DeviceType], [Copies])
        VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Group Tickets',
                'Scottish Canals[Align=Center,Bold=true,Length=32]\nThe Falkirk Wheel[Align=Center,Bold=true,Length=32]\nLime Road, Falkirk, FK1 4RS[Align=Center,Bold=true,Length=32]\nSale No: <General.saleNo>[Align=Left,Length=32]\nBooking Ref:  <ticket.bookingRef>[Align=Left,Length=32]\nBooking Date: <General.currentDate|format=dd-MM-yyyy>[Align=Left,Length=32]\nBooking Time: <General.currentDate|format=HH:mm>[Align=Left,Length=32]\n--------------------------[Align=Center]\n\n\n[tablestart]TicketDetails\n[Align=Left,Bold=true,Length=32,tablename=TicketDetails,columnname=ticket.name]\n[Align=Left,Bold=true,Length=32,tablename=TicketDetails,columnname=ticket.dateTime]\n----------------[Align=Center,Length=32]\nBooking Details[Align=Left,Length=32]\n\nPassengerType[Length=22]QTY[Align=Right,Length=3]Amt.[Align=Right,Length=7]\n[Length=22,tablename=TicketDetails,columnname=PassengerTypeName][Align=Right,Length=3,tablename=TicketDetails,columnname=Quantity][Align=Right,Length=7,tablename=TicketDetails,columnname=Price]\n[Align=Left,Length=32,tablename=TicketDetails,columnname=Seat]\n\n--------------------------------[Align=Center,Length=32]\n\n[tableend]\n\n\nTotal:[Align=Left,Bold=true,Length=15,FontSize=Double]<ticket.subtotal>[Align=Right,Length=15,FontSize=Double]\n--------------------------------[Align=Center,Length=32]\n\n\n[QR]<QRCode>\n\nTicket non-transferable. [Align=Center,Length=32]\nSubject to conditions.[Align=Center,Length=32]\n----------------[Align=Center,Length=32]\n\n\n\n\n\n',
                1, 0, 0)
        Insert into [tickets].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id],
                                                      CreatedDate, UpdatedDate)
select 0,
       1,
       t.Id,
       b.id,
       NEWID(),
       GETDATE(),
       GETDATE()
from [tickets].PrintTemplates t,
    [tickets].Branches b
where t.Id not in (select tm.[PrintTemplateId] from [tickets].PrintTemplateBranchMaps tm)
  and b.[Deleted] = 0
END
    
    IF NOT EXISTS(SELECT *
              FROM [tickets].[PrintTemplates]
              where [Code] = N'Group Tickets For Till'
                and [DeviceType] = 1)
BEGIN
        INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate],
                                           [UpdatedBy], [Code], [Template], [Version], [DeviceType], [Copies])
        VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Group Tickets For Till',
                'Scottish Canals[Align=Center,Bold=true,Length=40]\nThe Falkirk Wheel[Align=Center,Bold=true,Length=40]\nLime Road, Falkirk, FK1 4RS[Align=Center,Bold=true,Length=40]\nSale No.:     <General.saleNo>[Align=Left,Length=40]\nBooking Ref: <General.bookingRef>[Align=Left,Length=40]\nBooking Date: <General.currentDate|format=dd-MM-yyyy>[Align=Left,Length=40]\nBooking Time: <General.currentDate|format=HH:mm>[Align=Left,Length=40]\n\n--------------------------------[Align=Center,Length=40]\n[tablestart]TicketDetails\n\nTicket:        [Length = 9,Align=][Align=Left,Bold=true,Length=40,tablename=TicketDetails,columnname=TicketName]\nTicket Date:   [Length = 14,Align=][Align=Left,Bold=true,Length=40,tablename=TicketDetails,columnname=TicketDateTime]\nBooking Details[Align=Left,Length=40]\n[Align=Left,Length=40]\nPassengerType[Length=27]QTY[Align=Right,Length=3]Amt.[Align=Right,Length=10]\n[Length=27,tablename=TicketDetails,columnname=PassengerTypeName][Align=Right,Length=3,tablename=TicketDetails,columnname=Quantity][Align=Right,Length=10,tablename=TicketDetails,columnname=Price]\nSeats: [Length = 9,Align=][Align=Left,Length=31,tablename=TicketDetails,columnname=Seat]\n---------------------------------------[Align=Center,Length=40]\n[tableend]TicketDetails\n<ticket.bookingFee>[Align=Left,Length=40]\n\nTotal:[Align=Left,Bold=true,Length=15,FontSize=Double]<ticket.subtotal>[Align=Right,Length=30,FontSize=Double]\n\n[QR]<QRCode>\n---------------------------------------[Align=Center,Length=40]\n\n\n\n\n\n#knife#',
                1, 1, 0)
        Insert into [tickets].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id],
                                                      CreatedDate, UpdatedDate)
select 0,
       1,
       t.Id,
       b.id,
       NEWID(),
       GETDATE(),
       GETDATE()
from [tickets].PrintTemplates t,
    [tickets].Branches b
where t.Id not in (select tm.[PrintTemplateId] from [tickets].PrintTemplateBranchMaps tm)
  and b.[Deleted] = 0
END

    IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Optomany Card Sales Receipt'  and [DeviceType] = 0)
        BEGIN
            INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies])  VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Optomany Card Sales Receipt', '<LINE>[Image]VisitScotlandLogo.bmp</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.merchantName</NAME></VAR>[Align=Left, FontSize=Double, Bold=true]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.merchantLocation</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transDateTime</NAME><FORMAT>#dd/MM/yyyy HH:mm</FORMAT></VAR>[Align=Left]</LINE>\n<LINE>PID: <VAR><NAME>OptomanySaleReceipt.paymentId</NAME></VAR>[Align=Left]</LINE>\n<LINE>MID: <VAR><NAME>OptomanySaleReceipt.merchantId</NAME></VAR>[Align=Left]</LINE>\n<LINE>TID: <VAR><NAME>OptomanySaleReceipt.terminalId</NAME></VAR>[Align=Left]</LINE>\n<LINE>AID: <VAR><NAME>OptomanySaleReceipt.emvAid</NAME></VAR>[Align=Left]</LINE>\n<LINE>RECEIPT NO: <VAR><NAME>OptomanySaleReceipt.receiptNumber</NAME></VAR>[Align=Left]</LINE>\n<LINE>APP SEQ: <VAR><NAME>OptomanySaleReceipt.appSeq</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardType</NAME></VAR>[Align=Right]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardScheme</NAME></VAR>[Align=Right]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardPan</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transType</NAME></VAR>[Align=Left]</LINE>\n<LINE>AMOUNT [Align=Left, Length=7]<VAR><NAME>OptomanySaleReceipt.amountTrans</NAME></VAR>[Align=Right, Length=33]</LINE>\n<LINE>---------------------------------------[Align=Center]</LINE>\n<LINE>TOTAL [Align=Left, Bold=true, FontSize=Double, Length=10]<VAR><NAME>OptomanySaleReceipt.amountTrans</NAME></VAR>[Align=Right, Bold=true, FontSize=Double, Length=30]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transApproved</NAME></VAR>[Align=Center, Bold=true, FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE>RESPONSE CODE: <VAR><NAME>OptomanySaleReceipt.responseCode</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cvmPinVerified</NAME></VAR>[Align=Center]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transApprovedLabel</NAME></VAR>[Align=Center]</LINE>\n<LINE>AUTH CODE: <VAR><NAME>OptomanySaleReceipt.authorisationCode</NAME></VAR>[Align=Center]</LINE>\n\n<LINE>**CARDHORDER COPY**[Align=Center, Bold=true, FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>', 1,0,0)
            Insert into [tickets].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
            select
                0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
            from
                [tickets].PrintTemplates t,
                [tickets].Branches b
            where t.Id  not in (select tm.[PrintTemplateId] from [tickets].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
        END
            
    IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Optomany Merchant Copy For Till'  and [DeviceType] = 0)
        BEGIN
            INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Optomany Merchant Copy For Till', '<LINE>[Image]VisitScotlandLogo.bmp</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.merchantName</NAME></VAR>[Align=Left, FontSize=Double, Bold=true]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.merchantLocation</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transDateTime</NAME><FORMAT>#dd/MM/yyyy HH:mm</FORMAT></VAR>[Align=Left]</LINE>\n<LINE>PID: <VAR><NAME>OptomanySaleReceipt.paymentId</NAME></VAR>[Align=Left]</LINE>\n<LINE>MID: <VAR><NAME>OptomanySaleReceipt.merchantId</NAME></VAR>[Align=Left]</LINE>\n<LINE>TID: <VAR><NAME>OptomanySaleReceipt.terminalId</NAME></VAR>[Align=Left]</LINE>\n<LINE>AID: <VAR><NAME>OptomanySaleReceipt.emvAid</NAME></VAR>[Align=Left]</LINE>\n<LINE>RECEIPT NO: <VAR><NAME>OptomanySaleReceipt.receiptNumber</NAME></VAR>[Align=Left]</LINE>\n<LINE>APP SEQ: <VAR><NAME>OptomanySaleReceipt.appSeq</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardType</NAME></VAR>[Align=Right]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardScheme</NAME></VAR>[Align=Right]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardPan</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transType</NAME></VAR>[Align=Left]</LINE>\n<LINE>AMOUNT [Align=Left, Length=7]<VAR><NAME>OptomanySaleReceipt.amountTrans</NAME></VAR>[Align=Right, Length=33]</LINE>\n<LINE>---------------------------------------[Align=Center]</LINE>\n<LINE>TOTAL [Align=Left, Bold=true, FontSize=Double, Length=10]<VAR><NAME>OptomanySaleReceipt.amountTrans</NAME></VAR>[Align=Right, Bold=true, FontSize=Double, Length=30]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transApproved</NAME></VAR>[Align=Center, Bold=true, FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE>RESPONSE CODE: <VAR><NAME>OptomanySaleReceipt.responseCode</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cvmPinVerified</NAME></VAR>[Align=Center]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transApprovedLabel</NAME></VAR>[Align=Center]</LINE>\n<LINE>AUTH CODE: <VAR><NAME>OptomanySaleReceipt.authorisationCode</NAME></VAR>[Align=Center]</LINE>\n\n<LINE>**MERCHANT COPY**[Align=Center, Bold=true, FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>', 1,0,0)
            Insert into [tickets].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
            select
                0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
            from
                [tickets].PrintTemplates t,
                [tickets].Branches b
            where t.Id  not in (select tm.[PrintTemplateId] from [tickets].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
        END

	IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'End of day'  and [DeviceType] = 0)
	BEGIN
	INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'End of day', N'<LINE>#TRACE PRINT TEMPLATE VARIABLES#</LINE>\n<LINE>----- END OF DAY REPORT -------[Align=Center,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE>Branch:<VAR><NAME>Operator.BranchID</NAME></VAR>Terminal:<VAR><NAME>General.deviceid</NAME></VAR></LINE>\n<LINE>===============================</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>Table</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table.QTY</NAME></TABLEFIELD>[Align=Right,Length=7]<TABLEFIELD><NAME>Table.Value</NAME></TABLEFIELD>[Align=Right,Length=8]\n<LINE><TABLEEND>Table</TABLEEND></LINE>\n<LINE></LINE>\n<LINE><TABLESTART>Table1</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table1.Label</NAME></TABLEFIELD>[Align=Right,Length=23]<TABLEFIELD><NAME>Table1.Value</NAME></TABLEFIELD>[Align=Right,Length=8]\n<LINE><TABLEEND>Table1</TABLEEND></LINE>\n<LINE>-------------------------------</LINE>\n<LINE>VAT ANALYSIS</LINE>\n<LINE></LINE>\n<LINE>Details Goods(Ex) Vat</LINE>\n<LINE>-------------------------------</LINE>\n<LINE><TABLESTART>Table2</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table2.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table2.Goods</NAME></TABLEFIELD>[Align=Right,Length=7]<TABLEFIELD><NAME>Table2.Vat</NAME></TABLEFIELD>[Align=Right,Length=8]\n<LINE><TABLEEND>Table2</TABLEEND></LINE>\n<LINE>===============================</LINE>\n<LINE>REFUND REASONS</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>Table3</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table3.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table3.QTY</NAME></TABLEFIELD>[Align=Right,Length=7]<TABLEFIELD><NAME>Table3.Value</NAME></TABLEFIELD>[Align=Right,Length=8]\n<LINE><TABLEEND>Table3</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>-------------------------------</LINE>\n<LINE></LINE>\n<LINE>DISCOUNT REASONS</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>Table4</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table4.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table4.QTY</NAME></TABLEFIELD>[Align=Right,Length=7]<TABLEFIELD><NAME>Table4.Value</NAME></TABLEFIELD>[Align=Right,Length=8]\n<LINE><TABLEEND>Table4</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>===============================</LINE>\n<LINE><TABLESTART>Table5</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Table5.Label</NAME></TABLEFIELD>[Align=Left,Length=16]<TABLEFIELD><NAME>Table5.DocumentNo</NAME></TABLEFIELD>[Align=Left,Length=15]\n<LINE><TABLEEND>Table5</TABLEEND></LINE>\n<LINE>-------------------------------</LINE>\n<LINE>Date:<VAR><NAME>General.currentDate</NAME><FORMAT>#dd-MM-yyyy</FORMAT></VAR>Time:<VAR><NAME>General.currentDate</NAME><FORMAT>#HH:mm</FORMAT></VAR></LINE>\n<LINE>Operator:<VAR><NAME>Operator.FullName</NAME></VAR></LINE>\n<LINE>===============================</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>\n', 1,0,0)
	Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			tickets.PrintTemplates t,
			tickets.Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END
	
	IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Sale Refund'  and [DeviceType] = 0)
	BEGIN
	INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Sale Refund', N'Scottish Canals[Align=Center,Bold=true,Length=40]\nThe Falkirk Wheel[Align=Center,Bold=true,Length=40]\nLime Road, Falkirk, FK1 4RS[Align=Center,Bold=true,Length=40]\nREFUND[Align=Center,Bold=true,Length=40]\nSale No.:     <generalData.saleNo>[Align=Left,Length=40]\nBooking Ref: <generalData.bookingRef>[Align=Left,Length=40]\nRefund Date:  <generalData.currentDate|format=dd-MM-yyyy>[Align=Left,Length=40]\nRefund Time:  <generalData.currentDate|format=HH:mm>[Align=Left,Length=40]\n-----------------REFUND---------------[Align=Center,Length=40]\nTicket:       <TicketName>[Align=Left,Bold=true]\nTicket Date:  <TicketDateTime>[Align=LEFT,Bold=true]\n---------------------------------------[Align=Center,Length=40]\nBooking Details[Align=Left,Length=40]\n[Align=Left,Length=40]\nPassengerType[Length=27]QTY[Align=Right,Length=3]Amt.[Align=Right,Length=10]\n[tablestart]TicketDetails\n[Length=27,tablename=TicketDetails,columnname=PassengerTypeName][Align=Right,Length=3,tablename=TicketDetails,columnname=Quantity][Align=Right,Length=10,tablename=TicketDetails,columnname=Price]\n   Seats: [Length = 9,Align=][Align=Left,Length=31,tablename=TicketDetails,columnname=Seat]\n[tableend]TicketDetails\n<ticket.bookingFee>[Align=Left,Length=40]\n---------------------------------------[Align=Center,Length=40]\nTotal:[Align=Left,Bold=true,Length=15,FontSize=Double]<ticket.subtotal>[Align=Right,Length=30,FontSize=Double]\n---------------------------------------[Align=Center,Length=40]\n--------------------------------[Align=Center,Length=40]\n\n\n\n\n\n#knife#', 1,0,0)
	Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			tickets.PrintTemplates t,
			tickets.Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Card Sales Receipt'  and [DeviceType] = 0)
	BEGIN
	INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Card Sales Receipt', N'* CARDHOLDER COPY *[Align=Center,Bold=true,Length=40]\n\nEdinburgh iCentre[Align=Left,Bold=true,Length=40]\nCity Chambers, 249 High Street[Align=Left,Length=40]\nEdinburgh, EH1 1YJ[Align=Left,Length=40]\n\nDate:        <general.currentDate|format=dd-MM-yyyy>[Align=Left,Length=40]\nTime:        <general.currentDate|format=HH:mm>[Align=Left,Length=40]\nReceipt no:  <general.saleNo>[Align=Left,Length=40]\n\nMID:         <saleReceipt.mid>[Align=Left,Length=40]\nTID:         <saleReceipt.tid>[Align=Left,Length=40]\nAID:         <saleReceipt.aid>[Align=Left,Length=40]\nPAN Seq No:  <saleReceipt.panSeqNumber|format=00>[Align=Left,Length=40]\n\nPaid by:     <saleReceipt.paidBy>[Align=Left,Length=40]\nCard:        <saleReceipt.cardType>[Align=Left,Length=40]\nCard Number: <saleReceipt.cardNumber>[Align=Left,Length=40]\nExpiry date: <saleReceipt.expireDate>[Align=Left,Length=40]\nSource:      <saleReceipt.transactionSource>[Align=Left,Length=40]\n\n\n--------------------------------[Align=Left,Length=40]\n\n<saleReceipt.status>[Align=Center,Bold=true,Length=40,FontSize=Double]\n\nTotal[Align=Left,Bold=true,Length=10,FontSize=Double]<SaleReceipt.cardPurchase>[Align=Right,Bold=true,Length=30,FontSize=Double]\n\n--------------------------------[Length=40]\nPlease debit my account with the total.[Align=Left,Length=40]\n--------------------------------[Length=40]\n\nPlease retain for your records.[Align=Left,Length=40]\n\n\n--------------------------------[Length=40]\n\n\n\n\n\n#knife#\n', 1,0,0)
	Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			tickets.PrintTemplates t,
			tickets.Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Merchant Copy - chip and sign'  and [DeviceType] = 0)
	BEGIN
	INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Merchant Copy - chip and sign', N'MERCHANT COPY  *[Align=Center,Bold=true,Length=40]\n\nEdinburgh iCentre[Align=Left,Bold=true,Length=40]\nCity Chambers, 249 High Street[Align=Left,Length=40]\nEdinburgh, EH1 1YJ[Align=Left,Length=40]\n\nDate:        <general.currentDate|format=dd-MM-yyyy>[Align=Left,Length=40]\nTime:        <general.currentDate|format=HH:mm>[Align=Left,Length=40]\nReceipt no:  <general.saleNo>[Align=Left,Length=40]\n\nMID:         <saleReceipt.mid>[Align=Left,Length=40]\nTID:         <saleReceipt.tid>[Align=Left,Length=40]\nAID:         <saleReceipt.aid>[Align=Left,Length=40]\nPAN Seq No:  <saleReceipt.panSeqNumber|format=00>[Align=Left,Length=40]\n\nPaid by:     <saleReceipt.paidBy>[Align=Left,Length=40]\nCard:        <saleReceipt.cardType>[Align=Left,Length=40]\nCard Number: <saleReceipt.cardNumber>[Align=Left,Length=40]\nExpiry Date: <saleReceipt.cardExpireDate>[Align=Left,Length=40]\nSource:      <saleReceipt.transactionSource>[Align=Left,Length=40]\n\n--------------------------------[Length=40]\n\n<saleReceipt.status>[Align=Center,Bold=true,Length=40,FontSize=Double]\n\nTOTAL[Bold=true,Length=14,FontSize=Double]<SaleReceipt.cardPurchase>[Align=Right,Bold=true,Length=26,FontSize=Double]\n\n\nSign: ..........................[Align=Left,Bold=true,Length=40]\n\n--------------------------------[Length=40]\n\nThe customer''s account has been debited with the total.[Length=40]\n\n*** Please retain a copy for      your records ***[Align=Center,Length=40]\n\n\n--------------------------------[Length=40]\n\n\n\n\n\n#knife#\n', 1,0,0)
	Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			tickets.PrintTemplates t,
			tickets.Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Customer Copy - chip and sign'  and [DeviceType] = 0)
	BEGIN
	INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Customer Copy - chip and sign', N'* CARDHOLDER COPY *[Align=Center,Bold=true,Length=40]\n\nEdinburgh iCentre[Align=Left,Bold=true,Length=40]\nCity Chambers, 249 High Street[Align=Left,Length=40]\nEdinburgh, EH1 1YJ[Align=Left,Length=40]\n\nDate:        <general.currentDate|format=dd-MM-yyyy>[Align=Left,Length=40]\nTime:        <general.currentDate|format=HH:mm>[Align=Left,Length=40]\nReceipt no:  <general.saleNo>[Align=Left,Length=40]\n\nMID:         <saleReceipt.mid>[Align=Left,Length=40]\nTID:         <saleReceipt.tid>[Align=Left,Length=40]\nAID:         <saleReceipt.aid>[Align=Left,Length=40]\nPAN seq no:  <saleReceipt.panSeqNumber>[Length=40]\n\nPaid by:     <saleReceipt.paidBy>[Align=Left,Length=40]\nCard:        <saleReceipt.cardType>[Align=Left,Length=40]\nCard Number: <saleReceipt.cardNumber>[Align=Left,Length=40]\nExpiry date: <saleReceipt.cardExpireDate>[Align=Left,Length=40]\nSource:      <saleReceipt.transactionSource>[Length=40]\n\n--------------------------------[Length=40]\n\n<saleReceipt.status>[Align=Center,Bold=true,Length=40,FontSize=Double]\n\nTotal[Bold=true,Length=10,FontSize=Double]<SaleReceipt.cardPurchase>[Align=Right,Bold=true,Length=30,FontSize=Double]\n\nSign: ..........................[Align=Left,Bold=true,Length=40]\n\n--------------------------------[Length=40]\n\nPlease debit my account with the total.[Align=Left,Length=40]\n\nPlease retain for your records.[Align=Left,Length=40]\n\n\n--------------------------------[Length=40]\n\n\n\n\n\n#knife#\n', 1,0,0)
	Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			tickets.PrintTemplates t,
			tickets.Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Ticket'  and [DeviceType] = 1)
	BEGIN
	INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Ticket', N'Scottish Canals[Align=Center,Bold=true,Length=40]\nThe Falkirk Wheel[Align=Center,Bold=true,Length=40]\nLime Road, Falkirk, FK1 4RS[Align=Center,Bold=true,Length=40]\nSale No.:     <generalData.saleNo>[Align=Left,Length=40]\nBooking Ref: <generalData.bookingRef>[Align=Left,Length=40]\nBooking Date: <General.currentDate|format=dd-MM-yyyy>[Align=Left,Length=40]\nBooking Time: <General.currentDate|format=HH:mm>[Align=Left,Length=40]\n---------------------------------------[Align=Center,Length=40]\nTicket:       <TicketName>[Align=Left,Bold=true]\nTicket Date:  <TicketDateTime>[Align=LEFT,Bold=true]\n---------------------------------------[Align=Center,Length=40]\nBooking Details[Align=Left,Length=40]\n[Align=Left,Length=40]\nPassengerType[Length=27]QTY[Align=Right,Length=3]Amt.[Align=Right,Length=10]\n[tablestart]TicketDetails\n[Length=27,tablename=TicketDetails,columnname=PassengerTypeName][Align=Right,Length=3,tablename=TicketDetails,columnname=Quantity][Align=Right,Length=10,tablename=TicketDetails,columnname=Price]\n   Seats: [Length = 9,Align=][Align=Left,Length=31,tablename=TicketDetails,columnname=Seat]\n[tableend]TicketDetails\\n<ticket.bookingFee>[Align=Left,Length=40]\n---------------------------------------[Align=Center,Length=40]\nTotal:[Align=Left,Bold=true,Length=15,FontSize=Double]<ticket.subtotal>[Align=Right,Length=30,FontSize=Double]\n---------------------------------------[Align=Center,Length=40]\n<ticket.printText>[Align=Left,Length=40]\n[QR]<QRCode>\nTicket non-transferable. [Align=Center,Length=40]\nSubject to conditions.[Align=Center,Length=40]\n--------------------------------[Align=Center,Length=40]\n\n\n\n\n\n#knife#', 1,1,0)
	Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			tickets.PrintTemplates t,
			tickets.Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Ticket'  and [DeviceType] = 0)
	BEGIN
	INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Ticket', N'Scottish Canals[Align=Center,Bold=true,Length=40]\nThe Falkirk Wheel[Align=Center,Bold=true,Length=40]\nLime Road, Falkirk, FK1 4RS[Align=Center,Bold=true,Length=40]\nSale No.:     <generalData.saleNo>[Align=Left,Length=40]\nBooking Ref: <generalData.bookingRef>[Align=Left,Length=40]\nBooking Date: <General.currentDate|format=dd-MM-yyyy>[Align=Left,Length=40]\nBooking Time: <General.currentDate|format=HH:mm>[Align=Left,Length=40]\n---------------------------------------[Align=Center,Length=40]\nTicket:       <TicketName>[Align=Left,Bold=true]\nTicket Date:  <TicketDateTime>[Align=LEFT,Bold=true]\n---------------------------------------[Align=Center,Length=40]\nBooking Details[Align=Left,Length=40]\n[Align=Left,Length=40]\nPassengerType[Length=27]QTY[Align=Right,Length=3]Amt.[Align=Right,Length=10]\n[tablestart]TicketDetails\n[Length=27,tablename=TicketDetails,columnname=PassengerTypeName][Align=Right,Length=3,tablename=TicketDetails,columnname=Quantity][Align=Right,Length=10,tablename=TicketDetails,columnname=Price]\n   Seats: [Length = 9,Align=][Align=Left,Length=31,tablename=TicketDetails,columnname=Seat]\n[tableend]TicketDetails\\n<ticket.bookingFee>[Align=Left,Length=40]\n---------------------------------------[Align=Center,Length=40]\nTotal:[Align=Left,Bold=true,Length=15,FontSize=Double]<ticket.subtotal>[Align=Right,Length=30,FontSize=Double]\n---------------------------------------[Align=Center,Length=40]\n<ticket.printText>[Align=Left,Length=40]\n[QR]<QRCode>\nTicket non-transferable. [Align=Center,Length=40]\nSubject to conditions.[Align=Center,Length=40]\n--------------------------------[Align=Center,Length=40]\n\n\n\n\n\n#knife#', 1,0,0)
	Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from 
			tickets.PrintTemplates t,
			tickets.Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Optomany Customer Copy'  and [DeviceType] = 1)
	BEGIN
	INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Optomany Customer Copy', N'<LINE>[Image]Logo.bmp</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.merchantName</NAME></VAR>[Align=Left, FontSize=Double, Bold=true]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.merchantLocation</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transDateTime</NAME><FORMAT>#dd/MM/yyyy HH:mm</FORMAT></VAR>[Align=Left]</LINE>\n<LINE>PID: <VAR><NAME>OptomanySaleReceipt.paymentId</NAME></VAR>[Align=Left]</LINE>\n<LINE>MID: <VAR><NAME>OptomanySaleReceipt.merchantId</NAME></VAR>[Align=Left]</LINE>\n<LINE>TID: <VAR><NAME>OptomanySaleReceipt.terminalId</NAME></VAR>[Align=Left]</LINE>\n<LINE>AID: <VAR><NAME>OptomanySaleReceipt.emvAid</NAME></VAR>[Align=Left]</LINE>\n<LINE>RECEIPT NO: <VAR><NAME>OptomanySaleReceipt.receiptNumber</NAME></VAR>[Align=Left]</LINE>\n<LINE>APP SEQ: <VAR><NAME>OptomanySaleReceipt.appSeq</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardType</NAME></VAR>[Align=Right]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardScheme</NAME></VAR>[Align=Right]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardPan</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transType</NAME></VAR>[Align=Left]</LINE>\n<LINE>AMOUNT [Align=Left, Length=7]<VAR><NAME>OptomanySaleReceipt.amountTrans</NAME></VAR>[Align=Right, Length=25]</LINE>\n<LINE>--------------------------------[Align=Center]</LINE>\n<LINE>TOTAL [Align=Left, Bold=true, FontSize=Double, Length=10]<VAR><NAME>OptomanySaleReceipt.amountTrans</NAME></VAR>[Align=Right, Bold=true, FontSize=Double, Length=22]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transApproved</NAME></VAR>[Align=Center, Bold=true, FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE>RESPONSE CODE: <VAR><NAME>OptomanySaleReceipt.responseCode</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cvmPinVerified</NAME></VAR>[Align=Center]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transApprovedLabel</NAME></VAR>[Align=Center]</LINE>\n<LINE>AUTH CODE: <VAR><NAME>OptomanySaleReceipt.authorisationCode</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE>**CARDHOLDER COPY**[Align=Center, Bold=true]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>', 1,1,0)
	Insert into [tickets].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from
            [tickets].PrintTemplates t,
            [tickets].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [tickets].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

	IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Optomany Merchant Copy'  and [DeviceType] = 1)
	BEGIN
	INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, N'Optomany Merchant Copy', N'<LINE>[Image]Logo.bmp</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.merchantName</NAME></VAR>[Align=Left, FontSize=Double, Bold=true]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.merchantLocation</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transDateTime</NAME><FORMAT>#dd/MM/yyyy HH:mm</FORMAT></VAR>[Align=Left]</LINE>\n<LINE>PID: <VAR><NAME>OptomanySaleReceipt.paymentId</NAME></VAR>[Align=Left]</LINE>\n<LINE>MID: <VAR><NAME>OptomanySaleReceipt.merchantId</NAME></VAR>[Align=Left]</LINE>\n<LINE>TID: <VAR><NAME>OptomanySaleReceipt.terminalId</NAME></VAR>[Align=Left]</LINE>\n<LINE>AID: <VAR><NAME>OptomanySaleReceipt.emvAid</NAME></VAR>[Align=Left]</LINE>\n<LINE>RECEIPT NO: <VAR><NAME>OptomanySaleReceipt.receiptNumber</NAME></VAR>[Align=Left]</LINE>\n<LINE>APP SEQ: <VAR><NAME>OptomanySaleReceipt.appSeq</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardType</NAME></VAR>[Align=Right]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardScheme</NAME></VAR>[Align=Right]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cardPan</NAME></VAR>[Align=Left]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transType</NAME></VAR>[Align=Left]</LINE>\n<LINE>AMOUNT [Align=Left, Length=7]<VAR><NAME>OptomanySaleReceipt.amountTrans</NAME></VAR>[Align=Right, Length=25]</LINE>\n<LINE>--------------------------------[Align=Center]</LINE>\n<LINE>TOTAL [Align=Left, Bold=true, FontSize=Double, Length=10]<VAR><NAME>OptomanySaleReceipt.amountTrans</NAME></VAR>[Align=Right, Bold=true, FontSize=Double, Length=22]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transApproved</NAME></VAR>[Align=Center, Bold=true, FontSize=Double]</LINE>\n<LINE></LINE>\n<LINE>RESPONSE CODE: <VAR><NAME>OptomanySaleReceipt.responseCode</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.cvmPinVerified</NAME></VAR>[Align=Center]</LINE>\n<LINE><VAR><NAME>OptomanySaleReceipt.transApprovedLabel</NAME></VAR>[Align=Center]</LINE>\n<LINE>AUTH CODE: <VAR><NAME>OptomanySaleReceipt.authorisationCode</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE>**MERCHANT COPY**[Align=Center, Bold=true]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>', 1,1,0)
	Insert into [tickets].PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
		select
			0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
		from
            [tickets].PrintTemplates t,
            [tickets].Branches b
		where t.Id  not in (select tm.[PrintTemplateId] from [tickets].PrintTemplateBranchMaps tm) and b.[Deleted] = 0
	END

    IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Group Tickets - Gift Receipt For Till'  and [DeviceType] = 0)
        BEGIN
            INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) 
            VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, 
                    N'Group Tickets - Gift Receipt For Till', 
                    N'Scottish Canals[Align=Center,Bold=true,Length=40]\nThe Falkirk Wheel[Align=Center,Bold=true,Length=40]\nLime Road, Falkirk, FK1 4RS[Align=Center,Bold=true,Length=40]\nSale No.:     <General.saleNo>[Align=Left,Length=40]\nBooking Ref: <General.bookingRef>[Align=Left,Length=40]\nBooking Date: <General.currentDate|format=dd-MM-yyyy>[Align=Left,Length=40]\nBooking Time: <General.currentDate|format=HH:mm>[Align=Left,Length=40]\n\n--------------------------------[Align=Center,Length=40]\nGift Receipt[Align=Center,Bold=true,Length=40,FontSize=Double]\n[tablestart]TicketDetails\n\nTicket:        [Length = 9,Align=][Align=Left,Bold=true,Length=40,tablename=TicketDetails,columnname=TicketName]\nTicket Date:   [Length = 14,Align=][Align=Left,Bold=true,Length=40,tablename=TicketDetails,columnname=TicketDateTime]\nBooking Details[Align=Left,Length=40]\n[Align=Left,Length=40]\nPassengerType[Length=27]QTY[Align=Right,Length=3]\n[Length=27,tablename=TicketDetails,columnname=PassengerTypeName][Align=Right,Length=3,tablename=TicketDetails,columnname=Quantity]\nSeats: [Length = 9,Align=][Align=Left,Length=31,tablename=TicketDetails,columnname=Seat]\n---------------------------------------[Align=Center,Length=40]\n[tableend]TicketDetails\n<ticket.bookingFee>[Align=Left,Length=40]\n\nTotal:[Align=Left,Bold=true,Length=15,FontSize=Double]<ticket.subtotal>[Align=Right,Length=30,FontSize=Double]\n\n[QR]<QRCode>\n---------------------------------------[Align=Center,Length=40]\n\n\n\n\n\n#knife#',
                    1,0,0)
            Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
            select
                0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
            from
                tickets.PrintTemplates t,
                tickets.Branches b
            where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
        END

    IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Group Tickets - Gift Receipt'  and [DeviceType] = 1)
        BEGIN
            INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies]) 
            VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL, 
                    N'Group Tickets - Gift Receipt',
                    N'Scottish Canals[Align=Center,Bold=true,Length=32]\nThe Falkirk Wheel[Align=Center,Bold=true,Length=32]\nLime Road, Falkirk, FK1 4RS[Align=Center,Bold=true,Length=32]\nSale No: <General.saleNo>[Align=Left,Length=32]\nBooking Ref:  <ticket.bookingRef>[Align=Left,Length=32]\nBooking Date: <General.currentDate|format=dd-MM-yyyy>[Align=Left,Length=32]\nBooking Time: <General.currentDate|format=HH:mm>[Align=Left,Length=32]\n--------------------------[Align=Center]\n\nGift Receipt[Align=Center,Bold=true,Length=32,FontSize=Double]\n\n\n[tablestart]TicketDetails\n[Align=Left,Bold=true,Length=32,tablename=TicketDetails,columnname=ticket.name]\n[Align=Left,Bold=true,Length=32,tablename=TicketDetails,columnname=ticket.dateTime]\n----------------[Align=Center,Length=32]\nBooking Details[Align=Left,Length=32]\n\nPassengerType[Length=27]QTY[Align=Right,Length=5]\n[Length=27,tablename=TicketDetails,columnname=PassengerTypeName][Align=Right,Length=5,tablename=TicketDetails,columnname=Quantity]\n[Align=Left,Length=32,tablename=TicketDetails,columnname=Seat]\n\n--------------------------------[Align=Center,Length=32]\n\n[tableend]\n\n\n[QR]<QRCode>\n\nTicket non-transferable. [Align=Center,Length=32]\nSubject to conditions.[Align=Center,Length=32]\n----------------[Align=Center,Length=32]\n\n\n\n\n\n',
                    1,1,0)
            Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
            select
                0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
            from
                tickets.PrintTemplates t,
                tickets.Branches b
            where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
        END

    IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Ticket - Gift Receipt For Till'  and [DeviceType] = 0)
        BEGIN
            INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies])
            VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL,
                    N'Ticket - Gift Receipt For Till',
                    N'Scottish Canals[Align=Center,Bold=true,Length=40]\nThe Falkirk Wheel[Align=Center,Bold=true,Length=40]\nLime Road, Falkirk, FK1 4RS[Align=Center,Bold=true,Length=40]\nSale No.:     <General.saleNo>[Align=Left,Length=40]\nBooking Ref: <General.bookingRef>[Align=Left,Length=40]\nBooking Date: <General.currentDate|format=dd-MM-yyyy>[Align=Left,Length=40]\nBooking Time: <General.currentDate|format=HH:mm>[Align=Left,Length=40]\n---------------------------------------[Align=Center,Length=40]\nGift Receipt[Align=Center,Bold=true,Length=40,FontSize=Double]\nTicket:       <ticket.name>[Align=Left,Bold=true]\nTicket Date:  <ticket.dateTime>[Align=LEFT,Bold=true]\n---------------------------------------[Align=Center,Length=40]\nBooking Details[Align=Left,Length=40]\n[Align=Left,Length=40]\nPassengerType[Length=27]QTY[Align=Right,Length=3]\n[tablestart]TicketDetails\n[Length=27,tablename=TicketDetails,columnname=PassengerTypeName][Align=Right,Length=3,tablename=TicketDetails,columnname=Quantity]\n   Seats: [Length = 9,Align=][Align=Left,Length=31,tablename=TicketDetails,columnname=Seat]\n[tableend]TicketDetails\\\n<ticket.bookingFee>[Align=Left,Length=40]\n---------------------------------------[Align=Center,Length=40]\nTotal:[Align=Left,Bold=true,Length=15,FontSize=Double]<ticket.subtotal>[Align=Right,Length=30,FontSize=Double]\n---------------------------------------[Align=Center,Length=40]\n<ticket.printText>[Align=Left,Length=40]\n[QR]<QRCode>\nTicket non-transferable. [Align=Center,Length=40]\nSubject to conditions.[Align=Center,Length=40]\n--------------------------------[Align=Center,Length=40]\n\n\n\n\n\n#knife#"',
                    1,0,0)
            Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
            select
                0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
            from
                tickets.PrintTemplates t,
                tickets.Branches b
            where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
        END

    -- FOR PAX
    IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Ticket - Gift Receipt'  and [DeviceType] = 1)
        BEGIN
            INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies])
            VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL,
                    N'Ticket - Gift Receipt',
                    N'Scottish Canals[Align=Center,Bold=true,Length=32]\nThe Falkirk Wheel[Align=Center,Bold=true,Length=32]\nLime Road, Falkirk, FK1 4RS[Align=Center,Bold=true,Length=32]\nSale No: <General.saleNo>[Align=Left,Length=32]\nBooking Ref:  <ticket.bookingRef>[Align=Left,Length=32]\nBooking Date: <General.currentDate|format=dd-MM-yyyy>[Align=Left,Length=32]\nBooking Time: <General.currentDate|format=HH:mm>[Align=Left,Length=32]\n----------------[Align=Center,Length=32]\nGift Receipt[Align=Center,Bold=true,Length=32]\nTicket:       <ticket.name>[Align=Left,Bold=true]\nTicket Date:  <ticket.dateTime|format=dd-MM-yyyy HH:mm>[Align=LEFT,Bold=true]\n----------------[Align=Center,Length=32]\nBooking Details[Align=Left,Length=32]\n[Align=Left,Length=32]\nPassengerType[Length=27]QTY[Align=Right,Length=5]\n[tablestart]TicketDetails\n[Length=27,tablename=TicketDetails,columnname=PassengerTypeName][Align=Right,Length=5,tablename=TicketDetails,columnname=Quantity]\n[Align=Left,Length=32,tablename=TicketDetails,columnname=Seat]\n[tableend]\n<ticket.bookingFee>[Align=Left,Length=32]\n----------------[Align=Center,Length=32]\n<ticket.printText>[Align=Left,Length=32]\n[QR]<QRCode>\n\nTicket non-transferable. [Align=Center,Length=32]\nSubject to conditions.[Align=Center,Length=32]\n----------------[Align=Center,Length=32]\n\n\n\n\n\n',
                    1,1,0)
            Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
            select
                0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
            from
                tickets.PrintTemplates t,
                tickets.Branches b
            where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
        END
        
        IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Declaration Summary'  and [DeviceType] = 1)
BEGIN
        INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies])
        VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL,
                N'Declaration Summary',
                N'Date: <general.currentDate|format=dd-MM-yyyy> <general.currentDate|format=HH:mm>[Length=32]\nDevice: <general.deviceId>[Length=32]\nLocation: <SaleLocations.Name>[Length=32]\nUser: <Operator.FullName>[Length=32]\n\n----------- DECLARATION --------[Length=32]\n\nDec.[Align=Right,Length=22]QTY[Align=Right,Length=3]Amt.[Align=Right,Length=7]\n[tablestart]DeclarationDetails\n[Length=15,tablename=DeclarationDetails,columnname=Label][Align=Right,Length=7,tablename=DeclarationDetails,columnname=Declared][Align=Right,Length=3,tablename=DeclarationDetails,columnname=CalculatedQTY][Align=Right,Length=7,tablename=DeclarationDetails,columnname=CalculatedAmount]\n[tableend]DeclarationDetails\n\nSign:[Length=32] [Length=32] [Length=32] [Length=32][Length=32]\n\n\n--------------------------------[Length=32]',
                1,1,0)
        Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
select
    0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
from
    tickets.PrintTemplates t,
    tickets.Branches b
where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
END
end

-- FOR TILL
IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Single Basket Sale Receipt'  and [DeviceType] = 0)
    BEGIN
        INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies])
        VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL,
                N'Single Basket Sale Receipt',
                N'<LINE>Scottish Canals[Align=center,Emphasize=Emphasized]</LINE>\n<LINE><VAR><NAME>Branch.Name</NAME></VAR>[Align=Center,Emphasize=Emphasized]</LINE>\n<LINE><VAR><NAME>SaleReceipt.merchantAddress</NAME></VAR>[Align=Center,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>----------------------------------------</LINE>\n<LINE></LINE>\n<LINE>SaleNo: <VAR><NAME>General.saleNo</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE>Date: <VAR><NAME>General.currentDate</NAME><FORMAT>#dd/MM/yyyy</FORMAT></VAR> <VAR><NAME>General.currentDate</NAME><FORMAT>#HH:mm:ss</FORMAT></VAR>[Emphasize=Emphasized]</LINE>\n<LINE>Cashier: <VAR><NAME>Operator.Code</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE>Till: <VAR><NAME>General.deviceid</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE>----------------------------------------</LINE>\n<LINE></LINE>\n<LINE>QTY[Length=10,Emphasize=Emphasized]Item[Length=22,Emphasize=Emphasized]Amount[Length=8,Align=Right,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>SaleDetails</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>SaleDetails.SumQTY</NAME></TABLEFIELD>[Align=Right,Length=10]<TABLEFIELD><NAME>SaleDetails.ItemInfo</NAME></TABLEFIELD>[Align=Left,Length=22]<TABLEFIELD><NAME>SaleDetails.SumPrice</NAME></TABLEFIELD>[Align=Right,Length=8]</LINE>\n<LINE><TABLEEND>SaleDetails</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>----------------------------------------</LINE>\n<LINE>Sub-total:[Length=30]<VAR><NAME>SaleReceipt.SubTotal</NAME></VAR>[Align=Right,Emphasize=Emphasized]</LINE>\n<LINE>Discount: [Length=30]<VAR><NAME>ticket.discountedPrice</NAME></VAR>[Align=Right]</LINE>\n<LINE>Tax: [Length=30]<VAR><NAME>MerchantCopy.TaxTotal</NAME></VAR>[Align=Right]</LINE>\n<LINE>----------------------------------------</LINE>\n<LINE>Total: [Length=30]<VAR><NAME>General.Amount</NAME></VAR>[Align=Right,Emphasize=Emphasized]</LINE>\n<LINE>----------------------------------------</LINE>\n<LINE>Payment:</LINE>\n<LINE><TABLESTART>Payments</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Payments.DescriptionPOS</NAME></TABLEFIELD>[Align=Right,Length=10]<TABLEFIELD><NAME>Payments.DocCurrencyAmount</NAME></TABLEFIELD>[Align=Right,Length=30]</LINE>\n<LINE><TABLEEND>Payments</TABLEEND></LINE>\n<LINE>----------------------------------------</LINE>\n<LINE></LINE>\n<DISPLAYWHEN SaleReceipt.HasTickets=true>\n<LINE>Your Booking: <VAR><NAME>General.bookingRef</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>TicketDetails</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>TicketDetails.TicketName</NAME></TABLEFIELD>[Emphasize=Emphasized]</LINE>\n<LINE><TABLEFIELD><NAME>TicketDetails.Quantity</NAME></TABLEFIELD>[Align=Left, Length=4]x[Align=Left, Length=2]<TABLEFIELD><NAME>TicketDetails.PassengerTypeName</NAME></TABLEFIELD>[Align=Left,Length=34]</LINE>\n<LINE><TABLEFIELD><NAME>TicketDetails.TicketDateTime</NAME></TABLEFIELD></LINE>\n<LINE><TABLEFIELD><NAME>TicketDetails.Price</NAME></TABLEFIELD></LINE>\n<LINE>Seats: [Align=Left, Length=7]<TABLEFIELD><NAME>TicketDetails.Seat</NAME></TABLEFIELD>[Align=Left, Length=33]</LINE>\n<LINE></LINE>\n<LINE>[QR]<TABLEFIELD><NAME>TicketDetails.QRCode</NAME></TABLEFIELD></LINE>#Display individual ticket QR Code if exists#\n<LINE></LINE>\n<LINE>----------------------------------------</LINE>\n<LINE><TABLEEND>TicketDetails</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>[QR]<VAR><NAME>QRCode</NAME></VAR></LINE>#Display group ticket QR Code if exists#\n</DISPLAYWHEN>\n<LINE></LINE>\n<LINE>Thank you for purchasing at <VAR><NAME>Branch.Name</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>',
                1,0,0)
        Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
        select
            0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
        from
            tickets.PrintTemplates t,
            tickets.Branches b
        where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
    END

-- FOR TILL
IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Single Basket Gift Receipt'  and [DeviceType] = 0)
    BEGIN
        INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies])
        VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL,
                N'Single Basket Gift Receipt',
                N'<LINE>Scottish Canals[Align=center,Emphasize=Emphasized]</LINE>\n<LINE><VAR><NAME>Branch.Name</NAME></VAR>[Align=Center,Emphasize=Emphasized]</LINE>\n<LINE><VAR><NAME>SaleReceipt.merchantAddress</NAME></VAR>[Align=Center,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>----------------------------------------</LINE>\n<LINE></LINE>\n<LINE>SaleNo: <VAR><NAME>General.saleNo</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE>Date: <VAR><NAME>General.currentDate</NAME><FORMAT>#dd/MM/yyyy</FORMAT></VAR> <VAR><NAME>General.currentDate</NAME><FORMAT>#HH:mm:ss</FORMAT></VAR>[Emphasize=Emphasized]</LINE>\n<LINE>Cashier: <VAR><NAME>Operator.Code</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE>Till: <VAR><NAME>General.deviceid</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE>----------------------------------------</LINE>\n<LINE></LINE>\n<LINE>QTY[Length=10,Emphasize=Emphasized]Item[Length=30,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>SaleDetails</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>SaleDetails.SumQTY</NAME></TABLEFIELD>[Align=Right,Length=10]<TABLEFIELD><NAME>SaleDetails.ItemInfo</NAME></TABLEFIELD>[Align=Left,Length=30]</LINE>\n<LINE><TABLEEND>SaleDetails</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>----------------------------------------</LINE>\n<LINE></LINE>\n<DISPLAYWHEN SaleReceipt.HasTickets=true>\n<LINE>Your Booking: <VAR><NAME>General.bookingRef</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>TicketDetails</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>TicketDetails.TicketName</NAME></TABLEFIELD>[Emphasize=Emphasized]</LINE>\n<LINE><TABLEFIELD><NAME>TicketDetails.Quantity</NAME></TABLEFIELD>[Align=Left, Length=4]x[Align=Left, Length=2]<TABLEFIELD><NAME>TicketDetails.PassengerTypeName</NAME></TABLEFIELD>[Align=Left,Length=34]</LINE>\n<LINE><TABLEFIELD><NAME>TicketDetails.TicketDateTime</NAME></TABLEFIELD></LINE>\n<LINE>Seats: [Align=Left, Length=7]<TABLEFIELD><NAME>TicketDetails.Seat</NAME></TABLEFIELD>[Align=Left, Length=33]</LINE>\n<LINE></LINE>\n<LINE>[QR]<TABLEFIELD><NAME>TicketDetails.QRCode</NAME></TABLEFIELD></LINE>#Display individual ticket QR Code if exists#\n<LINE></LINE>\n<LINE>----------------------------------------</LINE>\n<LINE><TABLEEND>TicketDetails</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>[QR]<VAR><NAME>QRCode</NAME></VAR></LINE>#Display group ticket QR Code if exists#\n</DISPLAYWHEN>\n<LINE></LINE>\n<LINE>Thank you for purchasing at <VAR><NAME>Branch.Name</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>',
                1,0,0)
        Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
        select
            0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
        from
            tickets.PrintTemplates t,
            tickets.Branches b
        where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
    END

-- FOR TILL
IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Single Basket Sale Refund'  and [DeviceType] = 0)
    BEGIN
        INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies])
        VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL,
                N'Single Basket Sale Refund',
                N'<LINE>Scottish Canals[Align=center,Emphasize=Emphasized]</LINE>\n<LINE><VAR><NAME>Branch.Name</NAME></VAR>[Align=Center,Emphasize=Emphasized]</LINE>\n<LINE><VAR><NAME>SaleReceipt.merchantAddress</NAME></VAR>[Align=Center,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>----------------------------------------</LINE>\n<LINE></LINE>\n<LINE>SaleNo: <VAR><NAME>General.saleNo</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE>Date: <VAR><NAME>General.currentDate</NAME><FORMAT>#dd/MM/yyyy</FORMAT></VAR> <VAR><NAME>General.currentDate</NAME><FORMAT>#HH:mm:ss</FORMAT></VAR>[Emphasize=Emphasized]</LINE>\n<LINE>Cashier: <VAR><NAME>Operator.Code</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE>Till: <VAR><NAME>General.deviceid</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE>-----------------REFUND-----------------</LINE>\n<LINE></LINE>\n<LINE>QTY[Length=10,Emphasize=Emphasized]Item[Length=22,Emphasize=Emphasized]Amount[Length=8,Align=Right,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>SaleDetails</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>SaleDetails.SumQTY</NAME></TABLEFIELD>[Align=Right,Length=10]<TABLEFIELD><NAME>SaleDetails.ItemInfo</NAME></TABLEFIELD>[Align=Left,Length=22]<TABLEFIELD><NAME>SaleDetails.SumPrice</NAME></TABLEFIELD>[Align=Right,Length=8]</LINE>\n<LINE><TABLEEND>SaleDetails</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>----------------------------------------</LINE>\n<LINE>Sub-total:[Length=30]<VAR><NAME>SaleReceipt.SubTotal</NAME></VAR>[Align=Right,Emphasize=Emphasized]</LINE>\n<LINE>Discount: [Length=30]<VAR><NAME>ticket.discountedPrice</NAME></VAR>[Align=Right]</LINE>\n<LINE>Tax: [Length=30]<VAR><NAME>MerchantCopy.TaxTotal</NAME></VAR>[Align=Right]</LINE>\n<LINE>----------------------------------------</LINE>\n<LINE>Total: [Length=30]<VAR><NAME>General.Amount</NAME></VAR>[Align=Right,Emphasize=Emphasized]</LINE>\n<LINE>----------------------------------------</LINE>\n<LINE>Payment:</LINE>\n<LINE><TABLESTART>Payments</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Payments.DescriptionPOS</NAME></TABLEFIELD>[Align=Right,Length=10]<TABLEFIELD><NAME>Payments.DocCurrencyAmount</NAME></TABLEFIELD>[Align=Right,Length=30]</LINE>\n<LINE><TABLEEND>Payments</TABLEEND></LINE>\n<LINE>----------------------------------------</LINE>\n<LINE></LINE>\n<DISPLAYWHEN SaleReceipt.HasTickets=true>\n<LINE>Your Booking: <VAR><NAME>General.bookingRef</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>TicketDetails</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>TicketDetails.TicketName</NAME></TABLEFIELD>[Emphasize=Emphasized]</LINE>\n<LINE><TABLEFIELD><NAME>TicketDetails.Quantity</NAME></TABLEFIELD>[Align=Left, Length=4]x[Align=Left, Length=2]<TABLEFIELD><NAME>TicketDetails.PassengerTypeName</NAME></TABLEFIELD>[Align=Left,Length=34]</LINE>\n<LINE><TABLEFIELD><NAME>TicketDetails.TicketDateTime</NAME></TABLEFIELD></LINE>\n<LINE><TABLEFIELD><NAME>TicketDetails.Price</NAME></TABLEFIELD></LINE>\n<LINE>Seats: [Align=Left, Length=7]<TABLEFIELD><NAME>TicketDetails.Seat</NAME></TABLEFIELD>[Align=Left, Length=33]</LINE>\n<LINE></LINE>\n<LINE>----------------------------------------</LINE>\n<LINE><TABLEEND>TicketDetails</TABLEEND></LINE>\n<LINE></LINE>\n</DISPLAYWHEN>\n<LINE></LINE>\n<LINE>Thank you for purchasing at <VAR><NAME>Branch.Name</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>',
                1,0,0)
        Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
        select
            0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
        from
            tickets.PrintTemplates t,
            tickets.Branches b
        where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
    END

-- FOR TILL
IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'Single Basket - Staff Discount For Till'  and [DeviceType] = 0)
    BEGIN
        INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies])
        VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL,
                N'Single Basket - Staff Discount For Till',
                N'<LINE>Scottish Canals[Align=center,Emphasize=Emphasized]</LINE>\n<LINE><VAR><NAME>Branch.Name</NAME></VAR>[Align=Center,Emphasize=Emphasized]</LINE>\n<LINE><VAR><NAME>SaleReceipt.merchantAddress</NAME></VAR>[Align=Center,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>----------------------------------------</LINE>\n<LINE></LINE>\n<LINE>SaleNo: <VAR><NAME>General.saleNo</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE>Date: <VAR><NAME>General.currentDate</NAME><FORMAT>#dd/MM/yyyy</FORMAT></VAR> <VAR><NAME>General.currentDate</NAME><FORMAT>#HH:mm:ss</FORMAT></VAR>[Emphasize=Emphasized]</LINE>\n<LINE>Cashier: <VAR><NAME>Operator.Code</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE>User Id: <VAR><NAME>User.code</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE>Username: <VAR><NAME>User.firstName</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE>Till: <VAR><NAME>General.deviceid</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE>STAFF DISCOUNT[FontSize=Double,Align=Center]</LINE>\n<LINE></LINE>\n<LINE>QTY[Length=10,Emphasize=Emphasized]Item[Length=22,Emphasize=Emphasized]Amount[Length=8,Align=Right,Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>SaleDetails</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>SaleDetails.SumQTY</NAME></TABLEFIELD>[Align=Right,Length=10]<TABLEFIELD><NAME>SaleDetails.ItemInfo</NAME></TABLEFIELD>[Align=Left,Length=22]<TABLEFIELD><NAME>SaleDetails.SumPrice</NAME></TABLEFIELD>[Align=Right,Length=8]</LINE>\n<LINE><TABLEEND>SaleDetails</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>----------------------------------------</LINE>\n<LINE>Sub-total:[Length=30]<VAR><NAME>SaleReceipt.SubTotal</NAME></VAR>[Align=Right,Emphasize=Emphasized]</LINE>\n<LINE>Discount: [Length=30]<VAR><NAME>ticket.discountedPrice</NAME></VAR>[Align=Right]</LINE>\n<LINE>Tax: [Length=30]<VAR><NAME>MerchantCopy.TaxTotal</NAME></VAR>[Align=Right]</LINE>\n<LINE>----------------------------------------</LINE>\n<LINE>Total: [Length=30]<VAR><NAME>General.Amount</NAME></VAR>[Align=Right,Emphasize=Emphasized]</LINE>\n<LINE>----------------------------------------</LINE>\n<LINE>Payment:</LINE>\n<LINE><TABLESTART>Payments</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>Payments.DescriptionPOS</NAME></TABLEFIELD>[Align=Right,Length=10]<TABLEFIELD><NAME>Payments.DocCurrencyAmount</NAME></TABLEFIELD>[Align=Right,Length=30]</LINE>\n<LINE><TABLEEND>Payments</TABLEEND></LINE>\n<LINE>----------------------------------------</LINE>\n<LINE></LINE>\n<DISPLAYWHEN SaleReceipt.HasTickets=true>\n<LINE>Your Booking: <VAR><NAME>General.bookingRef</NAME></VAR>[Emphasize=Emphasized]</LINE>\n<LINE></LINE>\n<LINE><TABLESTART>TicketDetails</TABLESTART></LINE>\n<LINE><TABLEFIELD><NAME>TicketDetails.TicketName</NAME></TABLEFIELD>[Emphasize=Emphasized]</LINE>\n<LINE><TABLEFIELD><NAME>TicketDetails.Quantity</NAME></TABLEFIELD>[Align=Left, Length=4]x[Align=Left, Length=2]<TABLEFIELD><NAME>TicketDetails.PassengerTypeName</NAME></TABLEFIELD>[Align=Left,Length=34]</LINE>\n<LINE><TABLEFIELD><NAME>TicketDetails.TicketDateTime</NAME></TABLEFIELD></LINE>\n<LINE><TABLEFIELD><NAME>TicketDetails.Price</NAME></TABLEFIELD></LINE>\n<LINE>Seats: [Align=Left, Length=7]<TABLEFIELD><NAME>TicketDetails.Seat</NAME></TABLEFIELD>[Align=Left, Length=33]</LINE>\n<LINE></LINE>\n<LINE>[QR]<TABLEFIELD><NAME>TicketDetails.QRCode</NAME></TABLEFIELD></LINE>#Display individual ticket QR Code if exists#\n<LINE></LINE>\n<LINE>----------------------------------------</LINE>\n<LINE><TABLEEND>TicketDetails</TABLEEND></LINE>\n<LINE></LINE>\n<LINE>[QR]<VAR><NAME>QRCode</NAME></VAR></LINE>#Display group ticket QR Code if exists#\n</DISPLAYWHEN>\n<LINE></LINE>\n<LINE>Signature:</LINE>\n<LINE></LINE>\n<LINE>----------------------------------------</LINE>\n<LINE></LINE>\n<LINE>Thank you for purchasing at <VAR><NAME>Branch.Name</NAME></VAR>[Align=Center]</LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE></LINE>\n<LINE>#knife#</LINE>',
                1,0,0)
        Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
        select
            0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
        from
            tickets.PrintTemplates t,
            tickets.Branches b
        where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
    END

-- FOR TILL
-- IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'{CODE}'  and [DeviceType] = 0)
--     BEGIN
--         INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies])
--         VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL,
--                 N'{CODE}',
--                 N'{TEMPLATE}',
--                 1,0,0)
--         Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
--         select
--             0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
--         from
--             tickets.PrintTemplates t,
--             tickets.Branches b
--         where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
--     END

-- FOR PAX
-- IF NOT EXISTS (SELECT * FROM [tickets].[PrintTemplates] where [Code] = N'{CODE}'  and [DeviceType] = 1)
--     BEGIN
--         INSERT [tickets].[PrintTemplates] ([Deleted], [Active], [Id], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Code], [Template], [Version],[DeviceType], [Copies])
--         VALUES (0, 1, NEWID(), getdate(), NULL, getdate(), NULL,
--                 N'{CODE}',
--                 N'{TEMPLATE}',
--                 1,1,0)
--         Insert into tickets.PrintTemplateBranchMaps([Deleted], [Active], [PrintTemplateId], [BranchId], [Id], CreatedDate, UpdatedDate)
--         select
--             0, 1, t.Id, b.id, NEWID(), GETDATE(), GETDATE()
--         from
--             tickets.PrintTemplates t,
--             tickets.Branches b
--         where t.Id  not in (select tm.[PrintTemplateId] from tickets.PrintTemplateBranchMaps tm) and b.[Deleted] = 0
--     END