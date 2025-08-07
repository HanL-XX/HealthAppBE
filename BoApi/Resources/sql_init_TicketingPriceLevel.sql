GO
BEGIN TRAN
BEGIN TRY

		IF NOT EXISTS (SELECT * FROM [tickets].[PriceLevels] where Code = 'EB')
		BEGIN
			Insert into [tickets].PriceLevels([Deleted], [Active], [Code], [Name], [PriceLevelOption], [CreatedDate], [UpdatedDate], [Id]) Values (0, 1, 'EB', 'Early bird', 0, GETDATE(), GETDATE(), NEWID());
		END

		Insert into [tickets].PriceLevelBranchMaps([Deleted], [Active], [BranchId], [PriceLevelId], [CreatedDate], [UpdatedDate], [Id])
		select	
			0, 0, b.Id, m.id, GETDATE(), GETDATE(), NEWID()
		from 
			[tickets].Branches b,
			[tickets].PriceLevels m
		where m.Code = 'EB' and b.Id  not in (select r.BranchId from [tickets].PriceLevelBranchMaps r where r.PriceLevelId in (select p.Id from [tickets].PriceLevels p where p.Code = 'EB'))

	COMMIT
END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ErrorMessage;  
	ROLLBACK TRAN
END CATCH