DELETE [tickets].BranchDbSyncSettingMaps
DBCC CHECKIDENT ('[tickets].BranchDbSyncSettingMaps', RESEED, 0)
DELETE [tickets].DBSyncSettings
DBCC CHECKIDENT ('[tickets].DBSyncSettings', RESEED, 0)

IF NOT EXISTS (SELECT * FROM [tickets].[DBSyncSettings] where [Name] = N'Venues')
BEGIN
	INSERT INTO [tickets].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Venues', 'Venues, OperationalHours, VenueTypes');
END

IF NOT EXISTS (SELECT * FROM [tickets].[DBSyncSettings] where [Name] = N'TimeSlots')
BEGIN
	INSERT INTO [tickets].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'TimeSlots', 'TimeSlots, PriceLevels');
END

IF NOT EXISTS (SELECT * FROM [tickets].[DBSyncSettings] where [Name] = N'Schedules')
BEGIN
	INSERT INTO [tickets].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Schedules', 'Venues, TimeSlots');
END

IF NOT EXISTS (SELECT * FROM [tickets].[DBSyncSettings] where [Name] = N'Rooms')
BEGIN
	INSERT INTO [tickets].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Rooms', 'Venues, Rooms');
END

IF NOT EXISTS (SELECT * FROM [tickets].[DBSyncSettings] where [Name] = N'Seats')
BEGIN
	INSERT INTO [tickets].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Seats', 'Rooms, Venues, Seats');
END

IF NOT EXISTS (SELECT * FROM [tickets].[DBSyncSettings] where [Name] = N'Blackouts')
BEGIN
	INSERT INTO [tickets].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Blackouts', 'Blackouts');
END

IF NOT EXISTS (SELECT * FROM [tickets].[DBSyncSettings] where [Name] = N'TicketTypes')
BEGIN
	INSERT INTO [tickets].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'TicketTypes', 'ValidationRules, TicketTypes');
END

IF NOT EXISTS (SELECT * FROM [tickets].[DBSyncSettings] where [Name] = N'TicketGroups')
BEGIN
	INSERT INTO [tickets].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'TicketGroups', 'TicketGroups');
END

IF NOT EXISTS (SELECT * FROM [tickets].[DBSyncSettings] where [Name] = N'Tickets')
BEGIN
	INSERT INTO [tickets].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Tickets', 'AvailabilityGroups, PostageCosts, PriceTypes, RedemptionTypes, RefundPolicies, TicketGroups, TicketProperties, TicketTypes, ValidationRules, Tickets');
END

IF NOT EXISTS (SELECT * FROM [tickets].[DBSyncSettings] where [Name] = N'TicketPrices')
BEGIN
	INSERT INTO [tickets].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'TicketPrices', 'Tickets, TicketTypes, SaleChannels, PriceLevels, PriceBands, TicketPrices');
END

IF NOT EXISTS (SELECT * FROM [DBSyncSettings] where [Name] = N'Credit Notes')
BEGIN
	INSERT INTO [tickets].[DBSyncSettings] ([Deleted] ,[Active] ,[Type], [Name] ,[TableNeeds]) VALUES (0, 1, 1, N'Credit Notes', 'CreditNotes');
END

insert into [tickets].[BranchDbSyncSettingMaps](BranchId, DBSyncSettingId, Active, Deleted, CreatedDate, UpdatedDate)
select
	b.Id,
	db.Id,
	1,
	0,
	GETDATE(),
	GETDATE()
from
	tickets.Branches b, tickets.DBSyncSettings db
where
	b.Deleted = 0 
	and
	db.Deleted = 0
	AND NOT EXISTS
	(
		SELECT * FROM [tickets].BranchDbSyncSettingMaps WHERE BranchId = B.Id AND DBSyncSettingId = db.Id
	)