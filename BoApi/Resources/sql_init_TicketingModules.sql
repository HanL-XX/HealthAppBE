BEGIN TRAN
BEGIN TRY
		-- Delete from [tickets].BranchModuleMaps;

		SET IDENTITY_INSERT [tickets].[Modules] ON 

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 1)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, null, '','','ECR-v2','ECR-v2', 1, 1, 1);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 2)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Stock','Stock', 1, 1, 2);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 3)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Ticketing','Ticketing', 1, 1, 3);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 4)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Reports','Reports', 1, 1, 4);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 5)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Customers','Customers', 1, 1, 5);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 6)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Stock Setup','Stock Setup', 1, 1, 6);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 7)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Ticketing Setup','Ticketing Setup', 1, 1, 7);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 8)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Administrator Setup','Administrator Setup', 1, 1, 8);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 9)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 2, '','','Products','Products', 1, 1, 9);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 10)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 2, '','','Logistics','Logistics', 1, 1, 10);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 11)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 2, '','','Warehouse','Warehouse', 1, 1, 11);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 12)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 2, '','','Offer and Discounts','Offer and Discounts', 1, 1, 12);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 13)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 2, '','','Online Orders','Online Orders', 1, 1, 13);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 14)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 9, '','','Products','Products', 1, 0, 14);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 15)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 9, '','','Product Groups','Product Groups', 1, 0, 15);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 16)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 9, '','','Allergens','Allergens', 1, 0, 16);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 17)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 9, '','','Product Questions','Product Questions', 1, 0, 17);
		END		

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 18)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 9, '','','Price Levels','Price Levels', 1, 0, 18);
		END
		
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 19)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 9, '','','Tags','Tags', 1, 0, 19);
		END
		
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 20)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 9, '','','Branch Product Inclusion','Branch Product Inclusion', 1, 0, 20);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 22)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 10, '','','Stock Count','Stock Count', 1, 0, 22);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 23)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 10, '','','Stock Levels','Stock Levels', 1, 0, 23);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 24)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 10, '','','Adjustments','Adjustments', 1, 0, 24);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 25)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 11, '','','Orders','Orders', 1, 0, 25);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 26)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 10, '','','Deliveries','Deliveries', 1, 0, 26);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 27)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 10, '','','Returns','Returns', 1, 0, 27);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 34)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 11, '','','Transfers','Transfers', 1, 0, 34);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 35)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 11, '','','Warehouse Locations','Warehouse Locations', 1, 0, 35);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 36)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 11, '','','Suppliers','Suppliers', 1, 0, 36);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 37)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 11, '','','Catalogue','Catalogue', 1, 0, 37);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 38)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 11, '','','Purchase Orders','Purchase Orders', 1, 0, 38);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 39)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 11, '','','Receipting Goods','Receipting Goods', 1, 0, 39);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 40)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 11, '','','Payment Approval','Payment Approval', 1, 0, 40);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 41)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 13, '','','Online Product Groups','Online Product Groups', 1, 0, 41);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 42)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 13, '','','Online Restrictions','Online Restrictions', 1, 0, 42);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 43)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 13, '','','Dashboard','Dashboard', 1, 0, 43);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 44)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 6, '','','Admin','Admin', 1, 1, 44);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 45)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 6, '','','Transport','Transport', 1, 1, 45);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 46)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 6, '','','Setup','Setup', 1, 1, 46);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 47)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 6, '','','Bookings','Bookings', 1, 1, 47);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 48)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 44, '','','Devices','Devices', 1, 0, 48);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 49)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 44, '','','Device Versions','Device Versions', 1, 0, 49);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 50)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 44, '','','Function Unlock','Function Unlock', 1, 0, 50);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 51)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 44, '','','Screen Layout','Screen Layout', 1, 0, 51);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 52)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 44, '','','Messages','Messages', 1, 0, 52);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 53)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 44, '','','Language','Language', 1, 0, 53);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 54)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 44, '','','Schedules','Schedules', 1, 0, 54);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 55)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 44, '','','Tables','Tables', 1, 0, 55);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 56)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 44, '','','Users','Users', 1, 0, 56);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 57)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 44, '','','User Roles','User Roles', 1, 0, 57);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 58)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 45, '','','Departures','Departures', 1, 0, 58);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 59)
		BEGIN
				Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 45, '','','Coaches','Coaches', 1, 0, 59);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 60)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 45, '','','Timetables','Timetables', 1, 0, 60);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 61)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 45, '','','Routes','Routes', 1, 0, 61);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 62)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 45, '','','Vehicles','Vehicles', 1, 0, 62);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 63)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 46, '','','Branches','Branches', 1, 0, 63);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 64)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 46, '','','Currencies','Currencies', 1, 0, 64);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 65)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 46, '','','Print Templates','Print Templates', 1, 0, 65);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 66)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 46, '','','Tenders','Tenders', 1, 0, 66);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 67)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 46, '','','Reasons','Reasons', 1, 0, 67);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 68)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 46, '','','Sale Locations','Sale Locations', 1, 0, 68);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 69)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 46, '','','Stock Locations','Stock Locations', 1, 0, 69);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 70)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 46, '','','Units Of Measure','Units Of Measure', 1, 0, 70);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 71)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 46, '','','Taxes','Taxes', 1, 0, 71);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 72)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 46, '','','Countries & Locations','Countries & Locations', 1, 0, 72);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 73)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 47, '','','Associate Account','Associate Account', 1, 0, 73);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 74)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 47, '','','Master Account','Master Account', 1, 0, 74);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 75)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 47, '','','Transactions','Transactions', 1, 0, 75);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 77)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 46, '','','DeviceType','DeviceType', 1, 0, 77);
		END
		ELSE
		BEGIN
			Update [tickets].Modules set [Name] = 'Device Type', [Description] = 'Device Type' where [Id] = 77
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 78)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 46, '','','Branch Module Restriction','Branch Module Restriction', 1, 0, 78);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 79)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 44, '','','Export Codes','Export Codes', 1, 0, 79);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 80)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 11, '','','Current Stock Holding','Current Stock Holding', 1, 0, 80);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 82)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 12, '','','Offers & Discounts','Offers & Discounts', 1, 0, 82);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 83)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 46, '','','Declaration Types','Declaration Types', 1, 0, 83);

		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 84)
		BEGIN
						Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 9, '','','Barcodes','Barcodes', 1, 0, 84);
		END

        IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 85)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 46, '','','Settings','Settings', 1, 0, 85);
        END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 86)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 9, '','','Shopify Sync','Shopify Sync', 1, 0, 86);
        END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 87)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 11, '','','Stock Approval','Stock Approval', 1, 0, 87);
        END

		--- Report -------------------------------------------------------------------------------------------------------------------------------------------
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 88) -- parent module for report
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 4, '','','Reports','Reports', 1, 1, 88);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [Name] = 'Reports', [Description] = 'Reports', [IsParent] = 1 where [Id] = 88
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 89)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Product Export Code','Product Export Code', 1, 0, 89);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 89
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 90)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Tender Export Code','Tender Export Code', 1, 0, 90);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 90
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 91)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','',' Commission Report',' Commission Report', 1, 0, 91);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 91
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 92)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Declaration Report','Declaration Report', 1, 0, 92);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 92
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 93)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','No Sale Report','No Sale Report', 1, 0, 93);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 93
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 94)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Good Receipt','Good Receipt', 1, 0, 94);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 94
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 95)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Supplier Catalogue','Supplier Catalogue', 1, 0, 95);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 95
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 96)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Order To Supplier','Order To Supplier', 1, 0, 96);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 96
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 97)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Stock Adjustment Details','Stock Adjustment Details', 1, 0, 97);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 97
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 98)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Orders To Suppliers Report','Orders To Suppliers Report', 1, 0, 98);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 98
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 99)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Stock Holding Report','Stock Holding Report', 1, 0, 99);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 99
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 100)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Historical Stock Holding Report','Historical Stock Holding Report', 1, 0, 100);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 100
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 101)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Stock Transfer Details','Stock Transfer Details', 1, 0, 101);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 101
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 102)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Item Movement Report','Item Movement Report', 1, 0, 102);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 102
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 103)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Supplier Report','Supplier Report', 1, 0, 103);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 103
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 104)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Stock Valuation Report','Stock Valuation Report', 1, 0, 104);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 104
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 105)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Product Report','Product Report', 1, 0, 105);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 105
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 106)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Product Cost Report','Product Cost Report', 1, 0, 106);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 106
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 107)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Product Price List Report','Product Price List Report', 1, 0, 107);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 107
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 108)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Sync Report','Sync Report', 1, 0, 108);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 108
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 109)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Ticket Data Report','Ticket Data Report', 1, 0, 109);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 109
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 110)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Audit Report','Audit Report', 1, 0, 110);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 110
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 111)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Stock Count Report','Stock Count Report', 1, 0, 111);
        END
		ELSE
		BEGIN
			Update [tickets].Modules set [ParentModuleId] = 88 where [Id] = 111
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 112)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 46, '','','Report Configurations','Report Configurations', 1, 0, 112);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 113) 
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Sales Report','Sales Report', 1, 0, 113);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 114)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Historical Stock Valuation Report','Historical Stock Valuation Report', 1, 0, 114);
        END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 115)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 46, '','','Filter setup','Filter setup', 1, 0, 115);
		END

		--- End report --------------------------------------------------------------------------------------------------------------------------------------

		---  Module --------------------------------------------------------------------------------------------------------------------------------

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 116)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 3, '','','Tickets','Tickets', 1, 1, 116);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 117)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 3, '','','Bookings','Bookings', 1, 1, 117);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 118)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 116, '','','Tickets','Tickets', 1, 1, 118);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 119)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 116, '','','Price levels','Price levels', 1, 1, 119);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 120)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 116, '','','Ticket types','Ticket types', 1, 1, 120);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 121)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 116, '','','Passenger types','Passenger types', 1, 0, 121);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 122)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 116, '','','Schedules','Schedules', 1, 0, 122);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 123)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 116, '','','Venues','Venues', 1, 0, 123);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 124)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 116, '','','Promotions','Promotions', 1, 0, 124);
		END		

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 125)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 116, '','','Location restrictions','Location restrictions', 1, 0, 125);
		END
		
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 126)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 117, '','','Booking management','Booking management', 1, 0, 126);
		END
		
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 127)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 117, '','','Create a booking','Create a booking', 1, 0, 127);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 128)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 117, '','','Web booking groups','Web booking groups', 1, 0, 128);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 129)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 7, '','','Admin','Admin', 1, 0, 129);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 130)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 7, '','','Transport','Transport', 1, 0, 130);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 131)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 7, '','','Setup','Setup', 1, 0, 131);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 132)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 129, '','','Devices','Devices', 1, 0, 132);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 133)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 129, '','','Device versions','Device versions', 1, 0, 133);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 134)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 129, '','','Function unlock','Function unlock', 1, 0, 134);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 135)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 129, '','','Screen layout','Screen layout', 1, 0, 135);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 136)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 129, '','','Messages','Messages', 1, 0, 136);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 137)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 129, '','','Language','Language', 1, 0, 137);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 138)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 129, '','','Users','Users', 1, 0, 138);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 139)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 129, '','','User roles','User roles', 1, 0, 139);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 140)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 130, '','','Departures','Departures', 1, 0, 140);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 141)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 130, '','','Coaches','Coaches', 1, 0, 141);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 142)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 130, '','','Timetables','Timetables', 1, 0, 142);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 143)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 130, '','','Routes','Routes', 1, 1, 143);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 144)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 130, '','','Vehicles','Vehicles', 1, 1, 144);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 145)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 130, '','','Locations','Locations', 1, 1, 145);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 146)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 131, '','','Branches','Branches', 1, 0, 146);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 147)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 131, '','','Currencies','Currencies', 1, 0, 147);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 148)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 131, '','','Print templates','Print templates', 1, 0, 148);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 149)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 131, '','','Tenders','Tenders', 1, 0, 149);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 150)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 131, '','','Reasons','Reasons', 1, 0, 150);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 151)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 131, '','','Taxes','Taxes', 1, 0, 151);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 152)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 131, '','','Countries & Locations','Countries & Locations', 1, 0, 152);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 153)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 131, '','','Declaration Types','Declaration Types', 1, 0, 153);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 154)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 131, '','','Branch Module Restriction','Branch Module Restriction', 1, 0, 154);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 155)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 131, '','','Sale Locations','Sale Locations', 1, 0, 155);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 156)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 131, '','','Device Type','Device Type', 1, 0, 156);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 157)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 3, '','','Management','Management', 1, 1, 157);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 158)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 157, '','','Resources','Resources', 1, 0, 158);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 159)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 131, '','','Settings','Settings', 1, 0, 159);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 160)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 131, '','','Report Configurations','Report Configurations', 1, 0, 160);
		END
		BEGIN
			UPDATE [tickets].[Modules] SET [ParentModuleId] = 131 WHERE [Id] = 160
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 161)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 116, '','','Add on''s','Add on''s', 1, 0, 161);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 162)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 117, '','','Dashboard','Dashboard', 1, 0, 162);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 163)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 117, '','','Calendar','Calendar', 1, 0, 163);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 164)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 116, '','','Refunds & Amendments','Refunds & Amendments', 1, 1, 164);
		END
		ELSE
		BEGIN
			Update [tickets].Modules set [Name] = 'Refunds & Amendments', [Description] ='Refunds & Amendments' where [Id] = 164
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 165)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 116, '','','Branch Ticket Inclusion','Branch Ticket Inclusion', 1, 0, 165);
		END
		
		--- Customer -------------------------------------------------------------------------------------------------------------------------------------------
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 166)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 5, '','','General','General', 1, 1, 166);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 167)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 166, '','','Customers','Customers', 1, 1, 167);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 168)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 166, '','','Tags','Tags', 1, 1, 168);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 169)
        BEGIN
            Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Ticket Sales Report','Ticket Sales Report', 1, 0, 169);
        END
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 170)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 166, '','','Invoices','Invoices', 1, 1, 170);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 171)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 116, '','','Ticket Groups','Ticket Groups', 1, 1, 171);
		END

		--- Offer and Discounts------------------------------
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 172)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 3, '','','Offers and Discounts','Offers and Discounts', 1, 1, 172);
		END
		ELSE
			UPDATE [tickets].[Modules] set [Name] = 'Offers and Discounts' where [Id] = 172

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 173)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 172, '','','Promo codes','Promo codes', 1, 1, 173);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 174)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 172, '','','Offers & Discounts','Offers & Discounts', 1, 1, 174);
		END
		ELSE
		BEGIN
			Update [tickets].Modules set [Name] = 'Offers & Discounts', [Description] = 'Offers & Discounts' where [Id] = 174
		END
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 175)
        BEGIN
            Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','SAP Supplier Payment Export','SAP Supplier Payment Export', 1, 0, 175);
        END
		ELSE
		BEGIN
			Update [tickets].[Modules] set [ParentModuleId] = 88 where [Id] = 175
		END
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 176)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Negative Stock Sales Report','Negative Stock Sales Report', 1, 0, 176);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 177)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Product Profitability Report','Product Profitability Report', 1, 0, 177);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 178)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Sales','Sales', 1, 0, 178);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 179)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Sales Payment Report','Sales Payment Report', 1, 0, 179);
		END

				IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 180)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Best Sellers With Profit Report','Best Sellers With Profit Report', 1, 0, 180);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 181)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Stock Replenishment Report','Stock Replenishment Report', 1, 0, 181);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 182)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Discount Report','Discount Report', 1, 0, 182);
		END
		ELSE
		BEGIN
			Update [tickets].[Modules] set [Name] = 'Discount Report',[Description] = 'Discount Report' where [Id] = 182
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 183)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Refund Report','Refund Report', 1, 0, 183);
		END
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 184)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Sales And Payments Report','Sales And Payments Report', 1, 0, 184);
		END
		
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 185)
        BEGIN
            Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Daily Visitor Report','Daily Visitor Report', 1, 0, 185);
        END
		ELSE
		BEGIN
			Update [tickets].[Modules] set [Name] = 'Daily Visitor Report',[Description] = 'Daily Visitor Report', [ParentModuleId] = 88 where [Id] = 185
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 195)
        BEGIN
            Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Daily Booking Report','Daily Booking Report', 1, 0, 195);
        END
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 192)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Screen Icons Setup','Screen Icons Setup', 1, 1, 192);
		END
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 193)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 192, '','','Screen Icons','Screen Icons', 1, 1, 193);
		END
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 194)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 193, '','','Your Stock','Your Stock', 1, 0, 194);
		END
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 197)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 193, '','','Your Ticketing','Your Ticketing', 1, 0, 197);
		END
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 198)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 193, '','','Your Reports','Your Reports', 1, 0, 198);
		END
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 199)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 193, '','','Your Customers','Your Customers', 1, 0, 199);
		END
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 200)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 193, '','','Stock Setup','Stock Setup', 1, 0, 200);
		END
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 201)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 193, '','','Ticketing Setup','Ticketing Setup', 1, 0, 201);
		END
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 202)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 193, '','','Synchronise','Synchronise', 1, 0, 202);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 204)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 193, '','','Change device branch on stock','Change device branch on stock', 1, 0, 204);
		END
		ELSE
		BEGIN
			Update [tickets].Modules set [Name] = 'Change device branch on stock', [Description] = 'Change device branch on stock', ParentModuleId = 193 where [Id] = 204
		END
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 205)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 193, '','','Change device branch on ticketing','Change device branch on ticketing', 1, 0, 205);
		END
		ELSE
		BEGIN
			Update [tickets].Modules set [Name] = 'Change device branch on ticketing', [Description] = 'Change device branch on ticketing', ParentModuleId = 193 where [Id] = 205
		END
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 206)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Voided Transactions Report','Voided Transactions Report', 1, 0, 206);
		END
		    
		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 207)
		BEGIN
		Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id])Values (0, 1, 11, '', '', 'Internal Orders', 'Internal Orders', 1, 0, 207);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 209)
		BEGIN
			Insert into [tickets].[Modules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id])Values (0, 1, 46, '', '', 'Report Setup', 'Report Setup', 1, 0, 209);
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[Modules] where [Id] = 192)
		BEGIN
			Insert into [tickets].Modules([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 88, '','','Member Activities Report','Member Activities Report', 1, 0, 192);
		END

		SET IDENTITY_INSERT [tickets].[Modules] OFF

		--- End report --------------------------------------------------------------------------------------------------------------------------------------
		Insert into [tickets].RoleModuleMap([Deleted], [Active], [RoleId], [ModuleId], [Id], AccessLevel, CreatedDate, UpdatedDate)
		select
			0, 1, r.Id, m.id, NEWID(), 1, GETDATE(), GETDATE()
		from 
			[tickets].AspNetRoles r,
			[tickets].Modules m
		where m.Id  not in (select r.ModuleId from [tickets].RoleModuleMap r)

		Insert into [tickets].BranchModuleMaps([Deleted], [Active], [BranchId], [ModuleId], CreatedDate, UpdatedDate)
		select	
			0, 0, b.Id, m.id, GETDATE(), GETDATE()
		from 
			[tickets].Branches b,
			[tickets].Modules m
		where m.Id  not in (select r.ModuleId from [tickets].BranchModuleMaps r)
		order by m.id

	COMMIT
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrorMessage;  
	ROLLBACK TRAN
END CATCH