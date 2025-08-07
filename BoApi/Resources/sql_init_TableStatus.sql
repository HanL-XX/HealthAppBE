GO
BEGIN TRAN
BEGIN TRY
IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'UnAssignStatus' and [Group] = 'UnAssignStatus')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'UnAssignStatus', 'UnAssignStatus', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'New' and [Group] = 'TransactionQueue')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'TransactionQueue', 'New', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Error' and [Group] = 'TransactionQueue')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'TransactionQueue', 'Error', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Processed' and [Group] = 'TransactionQueue')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'TransactionQueue', 'Processed', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Booked' and [Group] = 'Ticket')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticket', 'Booked', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Sold' and [Group] = 'Ticket')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticket', 'Sold', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Scanned' and [Group] = 'Ticket')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticket', 'Scanned', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Expired' and [Group] = 'Ticket')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticket', 'Expired', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'All' and [Group] = 'Ticket Scan')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticket Scan', 'All', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Accepted' and [Group] = 'Ticket Scan')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticket Scan', 'Accepted', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Suspect Accepted' and [Group] = 'Ticket Scan')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticket Scan', 'Suspect Accepted', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Suspect Refused' and [Group] = 'Ticket Scan')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticket Scan', 'Suspect Refused', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Sold' and [Group] = 'Ticket Scan')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticket Scan', 'Sold', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Open' and [Group] = 'Cashier Session')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Cashier Session', 'Open', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Close' and [Group] = 'Cashier Session')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Cashier Session', 'Close', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Accepted' and [Group] = 'Cashier Session')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Cashier Session', 'Accepted', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Futher Investigation' and [Group] = 'Cashier Session')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Cashier Session', 'Futher Investigation', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Banked' and [Group] = 'Cashier Session')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Cashier Session', 'Banked', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Available' and [Group] = 'Device')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Device', 'Available', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Stolen' and [Group] = 'Device')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Device', 'Stolen', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Faulty' and [Group] = 'Device')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Device', 'Faulty', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Support' and [Group] = 'Device')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Device', 'Support', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'In Progress' and [Group] = 'Order')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Order', 'In Progress', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Awaiting Approval' and [Group] = 'Order')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Order', 'Awaiting Approval', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Sent To Supplier' and [Group] = 'Order')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Order', 'Sent To Supplier', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Cancelled' and [Group] = 'Order')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Order', 'Cancelled', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Receipted' and [Group] = 'Order')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Order', 'Receipted', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Rejected' and [Group] = 'Order')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Order', 'Rejected', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Not Delivered' and [Group] = 'Order')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Order', 'Not Delivered', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Order Generated' and [Group] = 'Order')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Order', 'Order Generated', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Awaiting Confirmation' and [Group] = 'Order')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Order', 'Awaiting Confirmation', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Hold' and [Group] = 'Order')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Order', 'Hold', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Partial Receipted' and [Group] = 'Order')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Order', 'Partial Receipted', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Draft' and [Group] = 'News')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'News', 'Draft', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Published' and [Group] = 'News')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'News', 'Published', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Transferred Out' and [Group] = 'Transfer')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Transfer', 'Transferred Out', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Draft' and [Group] = 'Transfer')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Transfer', 'Transferred Out', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Transfered' and [Group] = 'Transfer')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Transfer', 'Transfered', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Rejected' and [Group] = 'Transfer')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Transfer', 'Rejected', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Awaiting Confirmation' and [Group] = 'Transfer')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Transfer', 'Awaiting Confirmation', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Open' and [Group] = 'Shopify Order')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Shopify Order', 'Open', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Cancelled' and [Group] = 'Shopify Order')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Shopify Order', 'Cancelled', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Couting' and [Group] = 'Stock Count')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Stock Count', 'Couting', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Awaiting Appoval' and [Group] = 'Stock Count')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Stock Count', 'Awaiting Appoval', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Recount Required' and [Group] = 'Stock Count')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Stock Count', 'Recount Required', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Rejected' and [Group] = 'Stock Count')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Stock Count', 'Rejected', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Confirmed' and [Group] = 'Stock Count')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Stock Count', 'Confirmed', 1, 0, GETDATE(), GETDATE());
END

IF EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Canceled' and [Group] = 'Stock Count')
BEGIN
    delete from [dbo].TableStatuses where Name = 'Canceled' and [Group] = 'Stock Count';
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where (Name = 'InProgress' or Name = 'In Progress') and [Group] = 'Adjustment')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Adjustment', 'In Progress', 1, 0, GETDATE(), GETDATE());
END
ELSE
    BEGIN
        update [dbo].TableStatuses set Name = 'In Progress' where Name = 'InProgress' and [Group] = 'Adjustment';
    END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Watting Approval' and [Group] = 'Adjustment')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Adjustment', 'Watting Approval', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Approved' and [Group] = 'Adjustment')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Adjustment', 'Approved', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Cancel' and [Group] = 'Adjustment')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Adjustment', 'Cancel', 1, 0, GETDATE(), GETDATE());
END

IF EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'In Progress' and [Group] = 'Supplier Catalouge')
BEGIN
    delete from [dbo].TableStatuses where Name = 'In Progress' and [Group] = 'Supplier Catalouge';
END

IF EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Watting Approval' and [Group] = 'Supplier Catalouge')
BEGIN
    delete from [dbo].TableStatuses where Name = 'Watting Approval' and [Group] = 'Supplier Catalouge';
END

IF EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Approved' and [Group] = 'Supplier Catalouge')
BEGIN
    delete from [dbo].TableStatuses where Name = 'Approved' and [Group] = 'Supplier Catalouge';
END

IF EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Cancel' and [Group] = 'Supplier Catalouge')
BEGIN
    delete from [dbo].TableStatuses where Name = 'Cancel' and [Group] = 'Supplier Catalouge';
END

IF EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Active' and [Group] = 'Supplier Catalouge')
    BEGIN
        update [dbo].TableStatuses set [Group] = 'Supplier Catalogue' where Name = 'Active' and [Group] = 'Supplier Catalouge';
    END
IF NOT EXISTS (SELECT * FROM [dbo].TableStatuses where Name = 'Active' and [Group] = 'Supplier Catalogue')
    BEGIN
        insert into [dbo].TableStatuses (Id, [Group], Name, Deleted, Active, CreatedDate, UpdatedDate)
        values (newid(), 'Supplier Catalogue', 'Active', 0, 1, GETDATE(), GETDATE());
    END


IF EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Discontinued' and [Group] = 'Supplier Catalouge')
    BEGIN
        update [dbo].TableStatuses set [Group] = 'Supplier Catalogue' where Name = 'Discontinued' and [Group] = 'Supplier Catalouge';
    END
IF NOT EXISTS (SELECT * FROM [dbo].TableStatuses where Name = 'Discontinued' and [Group] = 'Supplier Catalogue')
    BEGIN
        insert into [dbo].TableStatuses (Id, [Group], Name, Deleted, Active, CreatedDate, UpdatedDate)
        values (newid(), 'Supplier Catalogue', 'Discontinued', 0, 1, GETDATE(), GETDATE());
    END

IF EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Ceased' and [Group] = 'Supplier Catalouge')
    BEGIN
        update [dbo].TableStatuses set [Group] = 'Supplier Catalogue' where Name = 'Ceased' and [Group] = 'Supplier Catalouge';
    END
IF NOT EXISTS (SELECT * FROM [dbo].TableStatuses where Name = 'Ceased' and [Group] = 'Supplier Catalogue')
    BEGIN
        insert into [dbo].TableStatuses (Id, [Group], Name, Deleted, Active, CreatedDate, UpdatedDate)
        values (newid(), 'Supplier Catalogue', 'Ceased', 0, 1, GETDATE(), GETDATE());
    END

IF EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Suspended' and [Group] = 'Supplier Catalouge')
    BEGIN
        update [dbo].TableStatuses set [Group] = 'Supplier Catalogue' where Name = 'Suspended' and [Group] = 'Supplier Catalouge';
    END
IF NOT EXISTS (SELECT * FROM [dbo].TableStatuses where Name = 'Suspended' and [Group] = 'Supplier Catalogue')
    BEGIN
        insert into [dbo].TableStatuses (Id, [Group], Name, Deleted, Active, CreatedDate, UpdatedDate)
        values (newid(), 'Supplier Catalogue', 'Suspended', 0, 1, GETDATE(), GETDATE());
    END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Available' and [Group] = 'Ticketing Device')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Device', 'Available', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Stolen' and [Group] = 'Ticketing Device')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Device', 'Stolen', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Faulty' and [Group] = 'Ticketing Device')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Device', 'Faulty', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Support' and [Group] = 'Ticketing Device')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Device', 'Support', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Pending' and [Group] = 'Ticketing Booking')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Booking', 'Pending', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Timeout' and [Group] = 'Ticketing Booking')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Booking', 'Timeout', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Paid' and [Group] = 'Ticketing Booking')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Booking', 'Paid', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Cancelled' and [Group] = 'Ticketing Booking')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Booking', 'Cancelled', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'PayLater' and [Group] = 'Ticketing Booking')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Booking', 'PayLater', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Partial' and [Group] = 'Ticketing Booking')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Booking', 'Partial', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Out Standing' and [Group] = 'Ticketing Booking')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Booking', 'Out Standing', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Abandoned' and [Group] = 'Ticketing Booking')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Booking', 'Abandoned', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Refunded' and [Group] = 'Ticketing Booking')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Booking', 'Refunded', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Refunded Partial' and [Group] = 'Ticketing Booking')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Booking', 'Refunded Partial', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Un Refund' and [Group] = 'Ticketing Refund After Use')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Refund After Use', 'Un Refund', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Refunded Partial' and [Group] = 'Ticketing Refund After Use')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Refund After Use', 'Refunded Partial', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Refunded' and [Group] = 'Ticketing Refund After Use')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Refund After Use', 'Refunded', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Paid' and [Group] = 'Ticketing Transaction')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Transaction', 'Paid', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Draft' and [Group] = 'Ticketing Transaction')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Transaction', 'Draft', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Un Paid' and [Group] = 'Ticketing Transaction')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Transaction', 'Un Paid', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Issue' and [Group] = 'Ticketing Qr Code')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Qr Code', 'Issue', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Partially Redeemed' and [Group] = 'Ticketing Qr Code')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Qr Code', 'Partially Redeemed', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Redeemed' and [Group] = 'Ticketing Qr Code')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Qr Code', 'Redeemed', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'No Show' and [Group] = 'Ticketing Qr Code')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Qr Code', 'No Show', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Refunded' and [Group] = 'Ticketing Qr Code')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Qr Code', 'Refunded', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Cancelled' and [Group] = 'Ticketing Qr Code')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Qr Code', 'Cancelled', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Outstanding Balance' and [Group] = 'Ticketing Qr Code')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Qr Code', 'Outstanding Balance', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Available' and [Group] = 'Ticketing Ticket')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Ticket', 'Available', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Limit Availability' and [Group] = 'Ticketing Ticket')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Ticket', 'Limit Availability', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Sold Out' and [Group] = 'Ticketing Ticket')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Ticket', 'Sold Out', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Un Available' and [Group] = 'Ticketing Ticket')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Ticket', 'Un Available', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Settled' and [Group] = 'Ticketing Payment')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'Ticketing Payment', 'Settled', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Valid' and [Group] = 'List Promo Code')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'List Promo Code', 'Valid', 1, 0, GETDATE(), GETDATE());
END

IF NOT EXISTS (SELECT * FROM [dbo].[TableStatuses] where Name = 'Used' and [Group] = 'List Promo Code')
BEGIN
insert into [dbo].[TableStatuses] (Id, [Group], [Name], Active, Deleted, CreatedDate, UpdatedDate) values (newid(), 'List Promo Code', 'Used', 1, 0, GETDATE(), GETDATE());
END


COMMIT
END TRY
BEGIN CATCH
SELECT ERROR_MESSAGE() AS ErrorMessage;
ROLLBACK TRAN
END CATCH