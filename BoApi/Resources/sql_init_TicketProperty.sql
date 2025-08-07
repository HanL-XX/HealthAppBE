GO
BEGIN TRAN
BEGIN TRY

    IF NOT EXISTS (SELECT * FROM [tickets].[TicketProperties] where Name = 'Smartcard ticket' and Code = 'SMT')
        begin
            insert into [tickets].TicketProperties (Id, Name, Code, Deleted, Active, CreatedDate,
                                                    UpdatedDate, TicketPropertyType)
            values (newid(), 'Smartcard ticket', 'SMT', 0, 1, getdate(), getdate(), 0);
        end
    ELSE 
        begin
            update [tickets].TicketProperties set TicketPropertyType = 0 where Name = 'Smartcard ticket' and Code = 'SMT';
        end

    IF NOT EXISTS (SELECT * FROM [tickets].[TicketProperties] where Name = 'Standard ticket' and Code = 'STD')
        begin
            insert into [tickets].TicketProperties (Id, Name, Code, Deleted, Active, CreatedDate,
                                                    UpdatedDate, TicketPropertyType)
            values (newid(), 'Standard ticket', 'STD', 0, 1, getdate(), getdate(), 0);
        end
    ELSE
        begin
            update [tickets].TicketProperties set TicketPropertyType = 0 where Name = 'Standard ticket' and Code = 'STD';
        end

    IF NOT EXISTS (SELECT * FROM [tickets].[TicketProperties] where BoolValue = 0 and TicketPropertyType = 1)
        begin
            insert into [tickets].TicketProperties (Id, Deleted, Active, CreatedDate,
                                                    UpdatedDate, BoolValue, TicketPropertyType)
            values (newid(), 0, 1, getdate(), getdate(), 0, 1);
        end

    IF NOT EXISTS (SELECT * FROM [tickets].[TicketProperties] where BoolValue = 1 and TicketPropertyType = 1)
        begin
            insert into [tickets].TicketProperties (Id, Deleted, Active, CreatedDate,
                                                    UpdatedDate, BoolValue, TicketPropertyType)
            values (newid(), 0, 1, getdate(), getdate(), 1, 1);
        end
    COMMIT
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS ErrorMessage;
    ROLLBACK TRAN
END CATCH