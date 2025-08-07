GO
BEGIN TRAN
BEGIN TRY

		if not exists (select * from [tickets].[OrderNos])
        BEGIN
             DECLARE @Min INTEGER
             DECLARE @Max INTEGER
             DECLARE @i INTEGER = 1

             WHILE (@i < 12)
             BEGIN
                 SET    @Min = @i * 1000000 + 1
                 SET @Max = (@i + 1) * 1000000
                 INSERT INTO [tickets].[OrderNos]
                             ([Min]
                             ,[Max]
                             ,[CurrentNo])
                         VALUES
                             (@Min
                             ,@Max
                             ,@Min)
                 SET @i = @i + 1
             END
        END

	COMMIT
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrorMessage;  
	ROLLBACK TRAN
END CATCH