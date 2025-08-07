GO
BEGIN TRAN
BEGIN TRY

		SET IDENTITY_INSERT [tickets].[DeviceModules] ON

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 1)
		BEGIN
			Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, null, '','','General','General', 1, 1, 1)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 2)
		BEGIN
			Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Login','Login', 1, 0, 2)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 3)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Message','Message', 1, 0, 3)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 4)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Sync','Sync', 1, 0, 4)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 12)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Session staff','Session staff', 1, 0, 12)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 13)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Revenue','Revenue', 1, 0, 13)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 14)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Lock','Lock', 1, 0, 14)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 15)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','End of day','End of day', 1, 0, 15)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 16)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Exit','Exit', 1, 0, 16)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 17)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Synchronise','Synchronise', 1, 0, 17)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 18)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Transactions','Transactions', 1, 0, 18)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 19)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 1, '','','Alerts','Alerts', 1, 0, 19)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] =5)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, null, '','','Stock','Stock', 1, 1, 5)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 6)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 5, '','','Stock Adjustment','Stock Adjustment', 1, 0, 6)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 7)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 5, '','','Stock Count','Stock Count', 1, 0, 7)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 8)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 5, '','','Change Stock Location','Change Stock Location', 1, 0 ,8)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 20)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 5, '','','Stock orders','Stock orders', 1, 0 ,20)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 21)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 5, '','','Stock deliveries','Stock deliveries', 1, 0 ,21)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 22)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 5, '','','Current stock holding','Current stock holding', 1, 0 ,22)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 9)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, null, '','','Sale','Sale', 1, 1, 9)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 10)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 9, '','','Products','Products', 1, 0, 10)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 11)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 9, '','','Sale Location','Sale Location', 1, 0, 11)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 23)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 9, '','','Online orders','Online orders', 1, 0, 23)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 24)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 9, '','','Refund','Refund', 1, 0, 24)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 25)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 9, '','','Open refund','Open refund', 1, 0, 25)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 26)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 9, '','','Print bill','Print bill', 1, 0, 26)
		END

		IF NOT EXISTS (SELECT * FROM [tickets].[DeviceModules] where [Id] = 27)
		BEGIN
		Insert into [tickets].[DeviceModules]([Deleted], [Active], [ParentModuleId], [Icon], [URL], [Name], [Description], [HeadMenu], [IsParent], [Id]) Values (0, 1, 9, '','','No sale','No sale', 1, 0, 27)
		END

		SET IDENTITY_INSERT [tickets].[DeviceModules] OFF

		DECLARE @deviceUserRoleId uniqueidentifier
		SET @deviceUserRoleId = (SELECT Id FROM [tickets].[DeviceUserRoles] WHERE [Name] = 'ECR Device Admin')

		IF (SELECT COUNT(DeviceUserRoleId) FROM [tickets].DeviceUserRoleModuleMaps r WHERE r.DeviceUserRoleId = @deviceUserRoleId) = 0
		BEGIN 
		INSERT INTO [tickets].DeviceUserRoleModuleMaps([Id],[DeviceUserRoleId],[ModuleId],[AccessLevel],[Authorisation],[Deleted],[Active],[CreatedDate],[UpdatedDate])
		SELECT
			NEWID(), r.Id, m.Id, 1, 1, 0, 1, GETDATE(), GETDATE()
		FROM 
			[tickets].DeviceUserRoles r,
			[tickets].DeviceModules m
			WHERE r.Id = @deviceuserroleId AND m.id IN (SELECT r.ModuleId FROM [tickets].DeviceUserRoleModuleMaps r)
		END

		INSERT INTO [tickets].[DeviceUserRoleModuleMaps] ([Id],[DeviceUserRoleId],[ModuleId],[AccessLevel],[Authorisation],[Deleted],[Active],[CreatedDate],[UpdatedDate])
		SELECT
			NEWID(), r.Id, m.Id, 1, 1, 0, 1, GETDATE(), GETDATE()
		FROM 
			[tickets].DeviceUserRoles r,
			[tickets].DeviceModules m
		WHERE m.Id  NOT IN (SELECT r.ModuleId FROM [tickets].DeviceUserRoleModuleMaps r)

	COMMIT
END TRY  
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrorMessage;  
	ROLLBACK TRAN
END CATCH
