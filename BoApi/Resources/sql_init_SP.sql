---spCreateStockCount---
GO
IF OBJECT_ID(N'[dbo].[spCreateStockCount]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[spCreateStockCount]
GO

CREATE PROCEDURE [dbo].[spCreateStockCount]
	@BranchId uniqueidentifier,
	@stockCountId int,
	@userId uniqueidentifier,
	@SupplierId uniqueidentifier
AS
BEGIN
  SET NOCOUNT ON
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @branchName nvarchar(50) = Lower((select name from Branches where Deleted = 0 and Id = @BranchId))
	DECLARE @ProductInBranch TABLE(Quantity INT, ProductId uniqueidentifier, ProductCode nvarchar(max), ProductName nvarchar(max), productGroupName nvarchar(max))
	INSERT INTO @ProductInBranch
	SELECT 
	bpm.Quantity as Quantity,
	p.Id as ProductId,
	p.Code as ProductCode,
	p.Name as ProductName,
	pg.Name as ProductGroupName
	from 
	[dbo].BranchProductMaps bpm
	left join [dbo].products p on bpm.ProductId = p.Id
	left join [dbo].ProductGroups pg on p.ProductGroupId = pg.Id
	where bpm.BranchId = @BranchId and p.Deleted = 0 and p.IsStockItem = 1 and bpm.Deleted = 0
	and (@SupplierId is null or exists(select * from [dbo].supplierProductMaps spm where spm.Deleted = 0 and spm.ProductId = p.id and spm.SupplierId = @SupplierId))

	DECLARE @costInBranch TABLE(ProductId uniqueidentifier, Cost decimal(18,4), PackSize float)
	insert into @costInBranch
	EXEC GetListProductSpecificSupplierCostReferInBranch @BranchId, @SupplierId

	DECLARE @SupplierProductMaps TABLE(productId uniqueidentifier, SupplierId uniqueidentifier, SupplierName nvarchar(max), SupplierCode nvarchar(max), Cost decimal(18,4))

	insert into @SupplierProductMaps
	select 
	spm.ProductId as productId, 
	spm.SupplierId as SupplierId, 
	s.Name as SupplierName, 
	s.Code as SupplierCode,
	Cost = iif(spm.PackSize = 0, spm.Cost, spm.Cost / CONVERT(decimal(18,4), spm.PackSize))
	from [dbo].SupplierProductMaps spm
	left join [dbo].Suppliers s on spm.SupplierId = s.Id
	
	DECLARE @CostInStockValuation TABLE(productId uniqueidentifier, Cost float)

	insert into @CostInStockValuation
	select 
	sv.ProductId as productId,
    Cost = IIF(sv.PackSize = 0, CONVERT(decimal(18,4), sv.CostPrice), CONVERT(decimal(18,4), sv.CostPrice / sv.PackSize))
	from [dbo].StockValuations sv
	where sv.Deleted = 0 and sv.InUse = 1 and sv.BranchId = @BranchId

	INSERT INTO [dbo].[StockCountDetails]
           ([Id],
		   [StockCountId]
           ,[ProductCode]
           ,[ProductName]
		   ,[ProductId]
           ,[ProductGroupName]
           ,[Cost]
		   ,[Expected]
		   ,[Quantity]
		   ,[ApprovedQuantity]
           ,[Comment]
           ,[SupplierCode]
           ,[SupplierName]
		   ,[SellingPrice]

           ,[Deleted]
           ,[Active]
		   ,[Edited]
           ,[CreatedDate]
           ,[CreatedBy]
           ,[UpdatedDate]
           ,[UpdatedBy]
           )
	
	select 
	NEWID() as Id,
	@stockCountId as StockCountId,
	pib.ProductCode as ProductCode,
	pib.ProductName as ProductName,
	pib.ProductId as ProductId,
	pib.productGroupName as ProductGroupName,
	(case when exists(select * from @CostInStockValuation sv where sv.ProductId = pib.ProductId) 
	then (case when exists (select * from @costInBranch cib where cib.ProductId = pib.ProductId) then 
	(select top(1) Cost from @CostInStockValuation sv where sv.ProductId = pib.ProductId) else 
	(select top(1) Cost from @CostInStockValuation sv where sv.ProductId = pib.ProductId)end) else 
	(case when exists (select * from @costInBranch cib where cib.ProductId = pib.ProductId) then 
	(select top(1) Cost from @costInBranch cib where cib.ProductId = pib.ProductId) else 0.0 end)end) as Cost,
	pib.Quantity as Expected,
	0 as Quantity,
	null as ApprovedQuantity,
	'' as Comment,
	STUFF((select ', ' + spm.SupplierCode from 
	@SupplierProductMaps spm
	where spm.ProductId = pib.ProductId
	FOR XML PATH('')),1,2,'')
	as SupplierCode,
	STUFF((select ', ' + spm.SupplierName from 
	@SupplierProductMaps spm
	where spm.ProductId = pib.ProductId
	FOR XML PATH, TYPE).value(N'.[1]', N'nvarchar(max)'),1,2,N'')
	as SupplierName,
	(case when exists(select * from [dbo].SaleItems si where si.ProductId = pib.ProductId) then
		(case when exists(select * from [dbo].ProductDimensions pd
		left join [dbo].saleItems si on pd.SaleItemId = si.Id
		left join [dbo].PriceLevels as pl on pl.Id = pd.PriceLevelId
		left join [dbo].PriceLevelBranchMaps as plbm on plbm.PriceLevelId = pd.PriceLevelId
		where si.ProductId = pib.ProductId and pd.Deleted = 0 and pd.Active = 1 and plbm.BranchId = @BranchId and Lower(pl.Name) = @branchName) then
			(case when (select top(1) pdp.PriceValue from [dbo].ProductDimensions pd
			left join [dbo].saleItems si on pd.SaleItemId = si.Id
			left join [dbo].ProductDimensionPrices pdp on pd.Id = pdp.ProductDimensionId
			where si.ProductId = pib.ProductId and pd.Deleted = 0 and pd.Active = 1 and GETDATE() > pdp.ValidFrom and (pdp.ValidTo is null or pdp.ValidTo > GETDATE() ) and pdp.Deleted = 0 and pdp.Active = 1) 
			is not null then  
				(select top(1) pdp.PriceValue from [dbo].ProductDimensions pd
				left join [dbo].saleItems si on pd.SaleItemId = si.Id
				left join [dbo].PriceLevels as pl on pl.Id = pd.PriceLevelId
				left join [dbo].PriceLevelBranchMaps as plbm on plbm.PriceLevelId = pd.PriceLevelId
				left join [dbo].ProductDimensionPrices pdp on pd.Id = pdp.ProductDimensionId
				where si.ProductId = pib.ProductId and pd.Deleted = 0 and pd.Active = 1 and GETDATE() > pdp.ValidFrom and (pdp.ValidTo is null or pdp.ValidTo > GETDATE() ) and pdp.Deleted = 0 and pdp.Active = 1 and plbm.BranchId = @BranchId and Lower(pl.Name) = @branchName)
			else 0.0 end)
		when exists(select * from [dbo].ProductDimensions pd
		left join [dbo].saleItems si on pd.SaleItemId = si.Id
		left join [dbo].PriceLevels as pl on pl.Id = pd.PriceLevelId
		left join [dbo].PriceLevelBranchMaps as plbm on plbm.PriceLevelId = pd.PriceLevelId
		where si.ProductId = pib.ProductId and pd.Deleted = 0 and pd.Active = 1 and plbm.BranchId = @BranchId and Lower(pl.Name) = 'standard') then
			(case when (select top(1) pdp.PriceValue from [dbo].ProductDimensions pd
			left join [dbo].saleItems si on pd.SaleItemId = si.Id
			left join [dbo].ProductDimensionPrices pdp on pd.Id = pdp.ProductDimensionId
			where si.ProductId = pib.ProductId and pd.Deleted = 0 and pd.Active = 1 and GETDATE() > pdp.ValidFrom and (pdp.ValidTo is null or pdp.ValidTo > GETDATE() ) and pdp.Deleted = 0 and pdp.Active = 1) 
			is not null then  
				(select top(1) pdp.PriceValue from [dbo].ProductDimensions pd
				left join [dbo].saleItems si on pd.SaleItemId = si.Id
				left join [dbo].PriceLevels as pl on pl.Id = pd.PriceLevelId
				left join [dbo].PriceLevelBranchMaps as plbm on plbm.PriceLevelId = pd.PriceLevelId
				left join [dbo].ProductDimensionPrices pdp on pd.Id = pdp.ProductDimensionId
				where si.ProductId = pib.ProductId and pd.Deleted = 0 and pd.Active = 1 and GETDATE() > pdp.ValidFrom and (pdp.ValidTo is null or pdp.ValidTo > GETDATE() ) and pdp.Deleted = 0 and pdp.Active = 1 and plbm.BranchId = @BranchId and Lower(pl.Name) = 'standard')
			else 0.0 end)
		when exists(select * from [dbo].ProductDimensions pd
		left join [dbo].saleItems si on pd.SaleItemId = si.Id
		left join [dbo].PriceLevels as pl on pl.Id = pd.PriceLevelId
		left join [dbo].PriceLevelBranchMaps as plbm on plbm.PriceLevelId = pd.PriceLevelId
		where si.ProductId = pib.ProductId and pd.Deleted = 0 and pd.Active = 1 and plbm.BranchId = @BranchId) then
			(case when (select top(1) pdp.PriceValue from [dbo].ProductDimensions pd
			left join [dbo].saleItems si on pd.SaleItemId = si.Id
			left join [dbo].ProductDimensionPrices pdp on pd.Id = pdp.ProductDimensionId
			where si.ProductId = pib.ProductId and pd.Deleted = 0 and pd.Active = 1 and GETDATE() > pdp.ValidFrom and (pdp.ValidTo is null or pdp.ValidTo > GETDATE() ) and pdp.Deleted = 0 and pdp.Active = 1) 
			is not null then  
				(select top(1) pdp.PriceValue from [dbo].ProductDimensions pd
				left join [dbo].saleItems si on pd.SaleItemId = si.Id
				left join [dbo].PriceLevels as pl on pl.Id = pd.PriceLevelId
				left join [dbo].PriceLevelBranchMaps as plbm on plbm.PriceLevelId = pd.PriceLevelId
				left join [dbo].ProductDimensionPrices pdp on pd.Id = pdp.ProductDimensionId
				where si.ProductId = pib.ProductId and pd.Deleted = 0 and pd.Active = 1 and GETDATE() > pdp.ValidFrom and (pdp.ValidTo is null or pdp.ValidTo > GETDATE() ) and pdp.Deleted = 0 and pdp.Active = 1 and plbm.BranchId = @BranchId)
			else 0.0 end)
		else 0.0 end)
	else (0.0)
	end) as SellingPrice,
	0 as deleted,
	0 as active,
	0 as edited,
	getDate() as CreatedDate,
	@userId as CreatedBy,
	getDate() as updatedDate,
	@userId as UpdatedBy
	
	from @ProductInBranch pib
END

---end---


---GetStockLocationGroupProductMapsToOrder---
GO
IF OBJECT_ID(N'[dbo].[GetStockLocationGroupProductMapsToOrder]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetStockLocationGroupProductMapsToOrder]
GO

CREATE PROCEDURE [dbo].[GetStockLocationGroupProductMapsToOrder]
AS
BEGIN
  SET NOCOUNT ON
	SELECT [s].[ProductId], [s1].[BranchId], [s].[Minimum], [s].[Standard]  
		  FROM [dbo].[StockLocationGroupProductMaps] AS [s]
		  LEFT JOIN [dbo].[StockLocationGroups] AS [s0] ON [s].[StockLocationGroupId] = [s0].[Id]
		  INNER JOIN [dbo].[StockLocationGroupBranchMaps] AS [s1] ON [s0].[Id] = [s1].[StockLocationGroupId]
		  WHERE [s].[Deleted] = 0 AND s1.BranchId IS NOT NULL
		  ORDER BY [s].[Id], [s0].[Id], [s1].[Id]
END
---end---

---CopyBranchProductMapsData---
GO
IF OBJECT_ID(N'[dbo].[CopyBranchProductMapData]', N'P')	 IS NOT NULL
	DROP PROCEDURE [dbo].[CopyBranchProductMapData]
GO

CREATE PROCEDURE [dbo].[CopyBranchProductMapData]
AS
BEGIN

	INSERT INTO HistoricalStockHoldings 
				(Id, 
				BranchProductMapId, 
				BranchId, 
				BranchName, 
				ProductName, 
				ProductCode, 
				ProductGroupName ,
				Quantity, 
				Cost,
				LastDelivery,
				LastCount, 
				Deleted, 
				Active, 
				CreatedDate, 
				UpdatedDate,
				ProductId)
	SELECT 
				NewID(), 
				BP.Id, 
				bp.BranchId, 
				B.Name,
				P.Name, 
				P.Code, 
				PG.Name, 
				Quantity,
				Newcost=ISNULL(sv.UnitCost,ISNULL(spm.cost/ISNULL(NULLIF(spm.packsize,0),1),0)),
				LastDelivery, 
				LastCount, 
				BP.Deleted, 
				BP.Active, 
				GETDATE(), 
				GETDATE(), 
				bp.ProductId
	FROM 
				BranchProductMaps AS BP 
				INNER JOIN Branches AS B ON BP.BranchId = B.Id 
				INNER JOIN Products AS P ON BP.ProductId = P.Id 
				INNER JOIN ProductGroups as PG on P.ProductGroupId = PG.Id
				LEFT JOIN StockValuations sv on sv.ProductId = bp.ProductId and sv.BranchId = bp.BranchId and InUse=1
				LEFT JOIN (select SupplierId,ProductId,SupplierProductCode,PackSize,Cost,Active,ROW_NUMBER() OVER (PARTITION BY Productid ORDER BY Productid,spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
				from SupplierProductMaps spm
				where deleted = 0) AS spm ON rn = 1 AND spm.ProductId = bp.ProductId
	WHERE
				P.Deleted = 0
END
---end---

---spGetTransferProductCount---
GO
IF OBJECT_ID(N'[dbo].[spGetTransferProductCount]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[spGetTransferProductCount]
GO

CREATE PROCEDURE [dbo].[spGetTransferProductCount]
	@fromBranchId uniqueidentifier,
	@toBranchId uniqueidentifier,
	@code nvarchar(100),
	@productGroup nvarchar(100),
	@productName nvarchar(100)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select 
	'total' = COUNT(*)
	from [dbo].BranchProductMaps as bp
	inner join [dbo].products as p on bp.ProductId = p.Id
	inner join [dbo].ProductGroups as pg on p.ProductGroupId = pg.Id
	where bp.Deleted = 0 and p.IsStockItem = 1 and p.Deleted = 0
	AND (bp.BranchId = @fromBranchId AND bp.ProductId IN (SELECT ProductId from BranchProductMaps where branchId  = @toBranchId and deleted = 0 ))
	AND (@code is null or p.Code like concat('%',@code,'%')) AND (@productGroup is null or pg.Name like concat('%',@productGroup,'%'))
	AND (@productName is null or p.Name like concat('%',@productName,'%'))

END
---end---

---spGetTransferProduct---
GO
IF OBJECT_ID(N'[dbo].[spGetTransferProduct]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[spGetTransferProduct]
GO

CREATE PROCEDURE [dbo].[spGetTransferProduct]
	-- Add the parameters for the stored procedure here
	@fromBranchId uniqueidentifier,
	@toBranchId uniqueidentifier,
	@pageNumber int, 
	@itemPerPage int,
	@code nvarchar(100),
	@productGroup nvarchar(100),
	@productName nvarchar(100)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select 
	'id' = p.Id,
	'code' = p.code,
	'isStockItem' = p.IsStockItem,
	'name' = p.Name,
	'productGroupName' = pg.Name

	from [dbo].BranchProductMaps as bp
	inner join [dbo].products as p on bp.ProductId = p.Id
	inner join [dbo].ProductGroups as pg on p.ProductGroupId = pg.Id
	where bp.Deleted = 0 and p.IsStockItem = 1 and p.Deleted = 0 and p.Active = 1
	AND bp.Active = 1
	AND (bp.BranchId = @fromBranchId AND bp.ProductId IN (SELECT ProductId from BranchProductMaps where branchId  = @toBranchId and deleted = 0 ))
	AND (@code is null or p.Code like concat('%',@code,'%')) AND (@productGroup is null or pg.Name like concat('%',@productGroup,'%'))
	AND (@productName is null or p.Name like concat('%',@productName,'%'))
	order by bp.Id 
	OFFSET  (@pageNumber - 1) * @itemPerPage rows fetch next @itemPerPage rows only
END
---end---

---GetListProductSupplierCostReferInBranch---
GO
IF OBJECT_ID(N'[dbo].[GetListProductSupplierCostReferInBranch]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetListProductSupplierCostReferInBranch]
GO

CREATE PROCEDURE [dbo].[GetListProductSupplierCostReferInBranch]
	@BranchId uniqueidentifier
AS
BEGIN
	;WITH cte AS
	(
	   SELECT M.ProductId, 
			  Cost = IIF(M.PackSize = 0, M.Cost, M.Cost / CONVERT(decimal(18,4), M.PackSize)),
			  PackSize = IIF(M.PackSize = 0, 1, M.PackSize),
			ROW_NUMBER() OVER (PARTITION BY M.ProductId ORDER BY M.IsPreferredSupplier DESC) AS rn
	   FROM [dbo].SupplierProductMaps AS M
	   INNER JOIN [dbo].SupplierBranchMaps AS M1 ON M.SupplierId = M1.SupplierId AND M1.BranchId = @BranchId
	)
	SELECT ProductId, Cost, PackSize
	FROM cte
	WHERE rn = 1
END
---end---

-----Function Product Group Path-----

GO
DROP FUNCTION IF EXISTS [dbo].[GetProductGroupPath]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[GetProductGroupPath] (
    @string NVARCHAR(MAX),
    @delimiter CHAR(1)
    )
RETURNS  NVARCHAR(MAX)
AS
BEGIN
    DECLARE @value NVARCHAR(MAX),
            @pos INT = 0,
            @len INT = 0,
            @result NVARCHAR(MAX)
        
    IF @string =''
    BEGIN
        SET @result =''
        RETURN @result
    END

    SET @string = CASE 
            WHEN RIGHT(@string, 1) != @delimiter
                THEN @string + @delimiter
            ELSE @string
            END

    WHILE CHARINDEX(@delimiter, @string, @pos + 1) > 0
    BEGIN
        DECLARE @name NVARCHAR(MAX)
        SET @len = CHARINDEX(@delimiter, @string, @pos + 1) - @pos
        SET @value = SUBSTRING(@string, @pos, @len)
        BEGIN
         SELECT TOP 1 @name = [Name] FROM ProductGroups WHERE Id = @value
         SET @name = @name
        END
           
       
       
        SET @result = CONCAT(@result , LTRIM(RTRIM(@name)))
        
 
        SET @pos = CHARINDEX(@delimiter, @string, @pos + @len) + 1
        SET @result = CONCAT(@result,' > ')
    END

    BEGIN
    SET @result = SUBSTRING(@result,1,LEN(@result) - 1)
    END

    RETURN @result
END

-----end-----

---GetListProductExport---
GO
IF OBJECT_ID(N'[dbo].[GetListProductExport]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetListProductExport]
GO

CREATE PROCEDURE [dbo].[GetListProductExport] (
@delimiter char(1)
)
AS
BEGIN
SELECT Code                    = P.Code
     , ProductName             = P.Name
     , PrintText               = P.PrintText
     , ProductGroup            = PG.Name
     , ProductBarcode         = BC.BarCodes
     , ProductType             = IIF(P.IsSaleItem = 1 AND P.IsStockItem = 1, 'All',
                                     IIF(P.IsSaleItem = 1, 'Sale Item', 'Stock Item'))
     , Commission              = IIF(P.Commission IS NOT NULL, P.Commission, 0)
     , ProductActive           = IIF(P.Active = 1, '1', '0')
     , OnSaleDate              = CONVERT(varchar, SaleItem.OnSaleDate, 103)
     , OffSaleDate             = CONVERT(varchar, SaleItem.OffSaleDate, 103)
     , MaximumDiscount         = IIF(SaleItem.MaximumDiscount IS NOT NULL, SaleItem.MaximumDiscount, 0)
     , ReceiptPrinter          = IIF(SaleItem.ReceiptPrinter = 1, '1', '0')
     , KitchenPrinter          = IIF(SaleItem.KitchenPrinter = 1, '1', '0')
     , CoffeePrinter           = IIF(SaleItem.CoffeePrinter = 1, '1', '0')
     , VisibleOnline           = IIF(SaleItem.VisibleOnline = 1, '1', '0')
     , StockItemType           = IIF(SaleItem.StockItemType IS NOT NULL, SaleItem.StockItemType, 1)
     , OnlineProductName       = SaleItem.OnlineName
     , OnlineDescription       = SaleItem.OnlineDescription
     , MaximumPurchaseQuantity = IIF(SaleItem.MaximumPurchaseQuantity IS NOT NULL, SaleItem.MaximumPurchaseQuantity,
                                     0)
     , OrderableOnline         = IIF(SaleItem.OrderableOnline = 1, '1', '0')
     , UnitOfMeasure           = UOM.Name
     , OrderOverPar            = IIF(StockItem.OrderOverPar = 1, '1', '0')
     , Orderable               = IIF(StockItem.Orderable = 1, '1', '0')
     , Countable               = IIF(StockItem.Countable = 1, '1', '0')
     , InFobLob                = IIF(StockItem.InFobLob = 1, '1', '0')
     , Adjustable              = IIF(StockItem.Adjustable = 1, '1', '0')
     , PriceLevel              = PL.Name
     , Price                   = IIF(PDP.PriceValue IS NOT NULL, PDP.PriceValue, 0)
     , Cost                    = IIF(PDP.Cost IS NOT NULL, PDP.Cost, 0)
     , ValidFrom               = CONVERT(varchar, PDP.ValidFrom, 103)
     , ValidTo                 = CONVERT(varchar, PDP.ValidTo, 103)
     , SupplierName            = SP.Name
     , SupplierProductCode     = SPM.SupplierProductCode
     , SupplierProductName     = SPM.SupplierProductName
     , PackSize                = IIF(SPM.PackSize IS NOT NULL, SPM.PackSize, 0)
     , CostPrice               = IIF(SPM.Cost IS NOT NULL, SPM.Cost, 0)
     , SupplierActive          = IIF(SPM.Active = 1, '1', '0')
     , Branch                  =
       (SELECT B.Name + ', ' AS [text()]
FROM (SELECT DISTINCT B.Name
    FROM [dbo].Branches as B
    LEFT JOIN [dbo].BranchProductMaps AS BPM ON BPM.BranchId = B.Id
    WHERE BPM.Id in (SELECT Id FROM [dbo].BranchProductMaps WHERE ProductId = P.Id AND Deleted = 0)
    and B.Deleted = 0) AS B
ORDER BY B.Name
    FOR XML PATH (''))
        , ExportCode              = EC.Code
        , ProductGroupPath        = P.ProductGroupPath
        , ProductDimensionId      = PD.Id
        , SupplierProductMapId    = SPM.Id
        , TaxGroup                =
    (SELECT TG.Name AS [text()]
FROM (SELECT DISTINCT TG.Name
    FROM [dbo].TaxGroups AS TG
    WHERE PDP.TaxGroupId = TG.Id
    AND TG.Deleted = 0) AS TG
ORDER BY TG.Name
    FOR XML PATH (''))
        , StockItemTaxGroup       =
    (SELECT TG.Name AS [text()]
FROM [dbo].TaxGroups AS TG
WHERE StockItem.TaxGroupId = TG.Id
  AND TG.Deleted = 0)
    , Tag                     =
    (SELECT T.Name + ', ' AS [text()]
FROM (SELECT DISTINCT T.Name
    FROM [dbo].Tags as T
    LEFT JOIN [dbo].ProductTagMaps AS PTM ON PTM.TagId = T.Id
    WHERE PTM.Id in (SELECT Id FROM [dbo].ProductTagMaps WHERE ProductId = P.Id AND Deleted = 0)
    and T.Deleted = 0) AS T
ORDER BY T.Name
    FOR XML PATH (''))
        , SupplierStatus          = SPM.Status
        , IsPreferredSupplier     = SPM.IsPreferredSupplier
        , SubstitutesProductName  = P2.Name
FROM [dbo].Products AS P
    INNER JOIN [dbo].ProductGroups AS PG ON P.ProductGroupId = PG.Id AND PG.Deleted = 0
    LEFT JOIN [dbo].SaleItems AS SaleItem ON P.Id = SaleItem.ProductId AND P.IsSaleItem = 1
    LEFT JOIN [dbo].ProductDimensions AS PD ON SaleItem.Id = PD.SaleItemId and PD.Deleted = 0
    JOIN [dbo].ProductDimensionPrices AS PDP ON PD.Id = PDP.ProductDimensionId and PDP.Deleted = 0
    LEFT JOIN [dbo].StockItems AS StockItem ON P.Id = StockItem.ProductId AND P.IsStockItem = 1
    LEFT JOIN [dbo].UnitOfMeasures AS UOM ON UOM.Id = StockItem.UnitOfMeasureId AND UOM.Deleted = 0
    LEFT JOIN [dbo].PriceLevels AS PL ON PL.Id = PD.PriceLevelId AND PL.Deleted = 0
    LEFT JOIN [dbo].SupplierProductMaps AS SPM ON P.Id = SPM.ProductId and SPM.Deleted = 0
    LEFT JOIN [dbo].Suppliers AS SP ON SP.Id = SPM.SupplierId AND SP.Deleted = 0
    LEFT JOIN [dbo].ExportCodeProductMaps AS ECPM
    ON P.Id = ECPM.ProductId and ECPM.Deleted = 0
    LEFT JOIN [dbo].ExportCodes AS EC ON EC.Id = ECPM.ExportCodeId AND EC.Deleted = 0
    LEFT JOIN [dbo].SupplierProductMaps AS SPM2 ON SPM.SubstituteMapId = SPM2.Id
    LEFT JOIN [dbo].Products as P2 ON SPM2.ProductId = P2.Id
    LEFT JOIN (select ProductId,
    stuff((select @delimiter + Code
    from [dbo].BarCodes
    where (BC.ProductId = ProductId and Deleted = 0)
    for xml path(''),TYPE).value('(./text())[1]', 'VARCHAR(MAX)')
    , 1, 1, '') AS BarCodes
    from [dbo].BarCodes BC
    group by ProductId) BC on P.Id = BC.ProductId
WHERE P.Deleted = 0
ORDER BY Code
END
---end---

---SAPSupplierPaymentExport---
GO
IF OBJECT_ID(N'[dbo].[ExportSupplierPaymentToSAP]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[ExportSupplierPaymentToSAP]
GO

CREATE PROCEDURE [dbo].[ExportSupplierPaymentToSAP]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchFilterId uniqueidentifier,
	@SupplierFilterId uniqueidentifier, 
	@OrderStatus int
AS
BEGIN
	begin
		declare @selectedDate DateTime = GETDATE()
	end
	SELECT
		  X = IIF(ROW_NUMBER() OVER (PARTITION BY S.Id  ORDER BY S.Id) = 1, 'X', '')
		, CompanyCode = '1000'
		, DocumentDate = CONVERT(NVARCHAR, @selectedDate, 104)
		, PostingDate = CONVERT(NVARCHAR, @selectedDate, 104)
		, DocumentRef = CAST(S.Id as varchar)
		, HeaderText = ''
		, Currency = 'GBP'
		, VendorNo = S.Code
		, PersonnelNo = ''
		, NetAmount = cast(S.TotalCost AS DECIMAL(16,2))--CAST(IIF(SM.Tax = 'D1', S.TotalCost*100/120, S.TotalCost) AS DECIMAL(16,2))
		, VATAmount = CAST(IIF(SM.Tax = 'D1', S.TotalCost/100*20, 0) AS DECIMAL(16,2))
		, VATCode = IIF(SM.TAX = 'D1', 'W1', 'V0')
		, GLAccount = '508110'
		, CostCentre = IIF(SI.Site IS NULL, s.BranchName, SI.Site)
		, ProfitCentre = IIF(SI.Site IS NULL, '', SI.Site)
		, WBSElement = 'X.C43.RP001'
		, Notes = IIF(SM.TAX IS NULL,'Missing Mapping for site '+ISNULL(SI.Name,'Branch: '+s.BranchName)+' and Type '+ISNULL(DM.SAP_Dept,'Dept: '+s.Type),IIF(SI.Name IS NULL, CAST(S.Id as varchar), CONCAT(S.Id, ' - ', SI.Name))) --IIF(SI.Name IS NULL, CAST(S.Id as varchar), CONCAT(S.Id, ' - ', SI.Name))
		, Assignment = ''
	FROM
		(
			SELECT 
				  P.[Type]
				, BranchName = b.Name
				, O.Id
				, ToTalCost = SUM((smh.Cost * smh.AdjustmentQTY))
				, sup.Code
				--, O.Status
			FROM StockMovementHistories smh
				LEFT JOIN [dbo].Products AS P ON smh.ProductId = P.Id
				INNER JOIN [dbo].Orders AS O ON CASE WHEN len(smh.MovementId) = 36 THEN CAST(o.uId as varchar(36)) ELSE CAST(o.Id as varchar(36)) END = smh.MovementId
				INNER JOIN Branches b on b.id = smh.BranchId
				left join OrderSupplierMaps osm on osm.OrderId = o.Id
				LEFT JOIN [dbo].Suppliers AS sup ON sup.Id = osm.SupplierId
			WHERE smh.MovementTYpe = 6
			AND smh.[CreatedDate] >= @FromDate AND smh.[CreatedDate] < @ToDate
			AND (@BranchFilterId IS NULL OR b.Id = @BranchFilterId)
			AND (@SupplierFilterId IS NULL OR osm.SupplierId = @SupplierFilterId)
			AND (@OrderStatus IS NULL OR O.Status = @OrderStatus)
			GROUP BY b.Name, P.[Type], sup.Code, O.Id--, O.Status
		) AS S
		LEFT JOIN [dbo].Dept_Map AS DM ON DM.SD_Dept = S.[Type]
		LEFT JOIN [dbo].Sites AS SI ON SI.Name = S.BranchName
		LEFT JOIN [dbo].SAP_Mapping AS SM ON SM.MONUMENT = SI.SAP_SiteName AND SM.[TYPE] = DM.SAP_Dept
		WHERE S.ToTalCost <> 0   
		and (S.Code <> 'CADW' or S.Code <> 'ECRVN')
		AND S.BranchName != 'Head Office'
END
---end---
---CopyStockValuationData---
GO
IF OBJECT_ID(N'[dbo].[CopyStockValuationData]', N'P')	 IS NOT NULL
	DROP PROCEDURE [dbo].CopyStockValuationData
GO

CREATE PROCEDURE [dbo].CopyStockValuationData
AS
	INSERT INTO StockValuationsHistorys 
				(Id, 
				StockValuationId, 
				BranchId, 
				ProductId, 
				DeliveryId, 
				DeliveryQuantity, 
				IssuedQuantity ,
				RemainingQuantity, 
				CostPrice,
				InUse,
				BackupDate,
				Deleted, 
				Active, 
				CreatedDate, 
				UpdatedDate,
				UnitCost,
				PackSize)
	SELECT
				NewID(), 
				S.Id, 
				S.BranchId, 
				S.ProductId,
				S.DeliveryId, 
				S.DeliveryQuantity, 
				S.IssuedQuantity, 
				S.RemainingQuantity, 
				S.CostPrice,
				S.InUse,
				GETDATE(),
				S.Deleted, 
				S.Active, 
				S.CreatedDate,
				S.UpdatedDate,
				S.UnitCost,
				S.PackSize

	FROM 
				[dbo].StockValuations AS S
	WHERE
				S.Deleted = 0

---end---

---GetVICData---
GO
IF OBJECT_ID(N'[dbo].[GetVICData]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].GetVICData
GO

CREATE PROCEDURE [dbo].GetVICData
AS
BEGIN
		select --top 5
			vic_ID						= b.Id,
			vic_Code					= b.Code,
			vic_Name					= b.Name,
			vic_Region					= bg.Name,
			vic_VisitorServicesMgr		= b.Manager,
			vic_Address					= b.AddressLine1 + ',' + b.AddressLine2 + ',' +b.AddressLine3,
			vic_Postcode				= b.PostCode,
			vic_Email					= IIF(b.Email like '%@%',b.Email,''),
			vic_TelCustomer				= b.TelNo,
			vic_DateLastModified		= b.UpdatedDate,
			vic_DateCreated				= b.CreatedDate
		from [dbo].Branches b
			inner join [dbo].BranchGroups bg on bg.Id = b.BranchGroupId and bg.Deleted = 0
			WHERE 1=1
			AND b.Active = 1 
			AND b.deleted = 0
			AND b.Code not in ('OB','HO')
END
---end---

---GetSupplierData---
GO
IF OBJECT_ID(N'[dbo].[GetSupplierData]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].GetSupplierData
GO

CREATE PROCEDURE [dbo].GetSupplierData
AS

BEGIN
	SELECT --top 5

	sup_ID				= s.Id,
	sup_Code			= s.Code,
	sup_SupplierName	= s.Name,
	sup_ContactName		= s.ContactName,
	sup_Address			= s.Address, --REVERSE(PARSENAME(REPLACE(REVERSE(s.Address), ' ', '.'), 1)),
	sup_City			= ISNULL(REVERSE(PARSENAME(REPLACE(REVERSE(s.Address), ',', '.'), 3)),ISNULL(REVERSE(PARSENAME(REPLACE(REVERSE(s.Address), ',', '.'), 2)),'')), --REVERSE(PARSENAME(REPLACE(REVERSE(s.Address), ' ', '.'), 3))
	sup_PostCode		= s.PostCode,
	sup_EmailAddress	= IIF(s.EmailAddress like '%@%',s.EmailAddress,''),
	sup_PhoneNumber		= s.PhoneNumber,
	sup_LeadDays		= s.LeadDays,
	sup_Status			= CASE s.Active WHEN 1 THEN 'Active' WHEN 0 THEN 'Inactive' When -1 THEN 'Deleted' ELSE 'Unknown' END,
	sup_MinimumValue	= s.MinValue,
	sup_MaximumValue	= s.MaxValue,
	sup_CarriageMinValue= s.MinimumOrderValue,
	sup_CarriageCharge	= s.CarriageChargeValue,
	sup_Approval		= IIF(s.ApprovalRequired =1, 'Approval Required','Approval Not Required'),
	sup_LastUpdated		= s.UpdatedDate,		
	sup_Created			= s.CreatedDate		

	FROM [dbo].Suppliers s

	where active = 1
END
---end---

---GetStockData---
GO
IF OBJECT_ID(N'[dbo].[GetStockData]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetStockData]
GO

CREATE PROCEDURE [dbo].[GetStockData]
	@BranchId uniqueidentifier,
	@Date DateTime
AS

BEGIN
	select --top 5

	stock_rowID								       = sh.Id,
	stock_DateOfInventory					   = CAST(sh.CreatedDate AS DATE),
	stock_vicID								       = b.Id,
	stock_itemID							       = p.Id, --sv.ProductId,
	stock_itemSalesTaxGroup					 = tg.Name, --tg.Id,
	stock_SnapshotQuantity					 = sh.Quantity,
	stock_SnapShotCost						   = sh.Cost,
	stock_calcStockValue					   = cast((sh.Quantity * sh.Cost ) as decimal(16,4)), -- current remaining cost value
	item_RetailPrice						     = pdp.PriceValue,
	stock_MinLevel							     = slgpm.Minimum,
	stock_StdLevel							     = slgpm.Standard,
	stock_MaxLevel							     = slgpm.Maximum,
	stock_LastReceivedDate					 = CAST(sh.LastDelivery AS DATE),
	stock_calcDaysSinceLastReceived	 = datediff(d,sh.LastDelivery,getdate()),
	stock_LastSoldDate						   = lastsold,
	stock_calcDaysSinceLastSold			 = datediff(d,lastsold,getdate()),
	stock_SupplierID						     = s.Id,
	stock_OnOrder							       = o.Quantity

	from [dbo].HistoricalStockHoldings		sh
	inner join [dbo].SaleItems				si	on si.ProductId = sh.ProductId
	inner join [dbo].ProductDimensions		pd	on pd.SaleItemId = si.Id
	inner join [dbo].ProductDimensionPrices	pdp on pdp.ProductDimensionId = pd.Id
	inner join [dbo].Products					p	ON p.Id = sh.ProductId
	inner join [dbo].StockItems				st	ON st.ProductId = p.Id and st.Deleted = 0
	LEFT JOIN (select branchid,productid,lastsold = CAST(max(date) as date) from [dbo].TransactionDetails td inner join [dbo].transactions t on t.id = td.TransactionId group by branchid,productid) lastsold ON lastsold.productid = p.id and sh.branchid = lastsold.branchid
	LEFT JOIN [dbo].Branches					b	ON b.ID = sh.BranchId
	LEFT JOIN [dbo].BranchGroups				bg	ON bg.Id = b.BranchGroupId
	LEFT join [dbo].TaxGroups					tg	on tg.Id = pdp.TaxGroupId
	LEFT JOIN (select SupplierId,ProductId,SupplierProductCode,PackSize,Cost,Active,ROW_NUMBER() OVER (PARTITION BY Productid ORDER BY Productid,spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
				from [dbo].SupplierProductMaps spm
				where deleted = 0) AS spm ON rn = 1 AND spm.ProductId = sh.ProductId
	LEFT JOIN [dbo].Suppliers					s	on s.Id = spm.SupplierId
	LEFT JOIN [dbo].StockLocationGroupBranchMaps slgbm ON slgbm.BranchId = sh.BranchId
	LEFT JOIN [dbo].StockLocationGroups		slg	ON slg.ID = slgbm.StockLocationGroupId
	LEFT JOIN [dbo].StockLocationGroupProductMaps slgpm on slgpm.ProductId = sh.ProductId and slgpm.StockLocationGroupId = slgbm.StockLocationGroupId
	LEFT JOIN (select Branchid,ProductID,SupplierId, Quantity=sum(od.Quantity) from [dbo].Orders o inner join [dbo].OrderDetails od on o.Id = od.OrderId where o.Status not in (4,5,6) 

	group by BranchId,ProductId,SupplierId) o on o.ProductId = sh.ProductId and o.BranchId = sh.BranchId and o.SupplierId = s.Id

	where (@BranchId IS NULL OR B.Id = @BranchId) 
	AND B.Deleted = 0
	And CAST(sh.CreatedDate as DATE) = CAST(@Date as DATE)
END
---end---

---GetItemData---
GO
IF OBJECT_ID(N'[dbo].[GetItemData]',N'P') IS NOT NULL
	DROP PROCEDURE [dbo].[GetItemData]
GO 

CREATE PROCEDURE [dbo].[GetItemData]
AS
BEGIN
	SELECT --top 5
		DISTINCT
		Item_Id							= p.Id,
		Item_Code						= p.Code,
		Item_Description				= p.name, 
		Item_PrintText					= p.PrintText,
		Item_PriceLevel					= pl.Name,
		Item_Cost						= cast(spm.cost as decimal(10,2)),
		Item_priceType					= pdp.PriceType,
		Item_Price						= pdp.PriceValue,
		Item_PriceValidFrom				= CONVERT(varchar, pdp.ValidFrom,103),
		Item_PriceValidTo				= CONVERT(varchar, pdp.ValidTo,103),
		Item_Type						= IIF(P.IsSaleItem = 1 AND P.IsStockItem = 1, 'All', IIF(P.IsSaleItem = 1, 'Sale Item', 'Stock Item')),
		Item_Status						= IIF(p.Active=1,'Active','Inactive'),
		Item_ExportCode					= EC.Code,  -- Export Code
		Item_PriceMustBeEntered			= IIF(pdp.PriceValue IS NULL,1,0), --- Set as yes if no price has been set
		Item_SaleTaxName				= tg.Name,	
		Item_Orderable					= ski.Orderable,
		Item_Commission					= P.Commission,
		Item_OnSaleDate					= CONVERT(varchar, si.OnSaleDate, 103),
		Item_OffSaleDate				= CONVERT(varchar, si.OffSaleDate, 103),
		Item_MaximumDiscount			= IIF(si.MaximumDiscount IS NOT NULL, si.MaximumDiscount, 0),
		Item_TicketingForm				= IIF(si.UseTicketingForm = 1,'Yes','No'),
		Item_SalesTaxGroup				= tg.Name,
		Item_LastUpdated				= p.UpdatedDate,
		Item_DateCreated				= p.CreatedDate,
		Item_ProductBarcode				= COALESCE(bc.code,''),
		Item_Tag_Id						= COALESCE(tag.Id,null),
		Item_TagCode					= COALESCE(tag.code,''),
		Item_TagName					= COALESCE(tag.name,''),
		Sup_Id							= s.Id,
		Sup_Preferred					= IIF(spm.IspreferredSupplier = 1,'Yes','No'),
		Sup_ProductCode					= spm.SupplierProductCode,
		Sup_ProductName					= spm.SupplierProductName,
		Sup_MPQ							= spm.PackSize,
		Sup_PackCost					= spm.Cost,
		Sup_ItemCost					= spm.Cost/(IIF(spm.PackSize = 0,1,Cast(spm.PackSize as decimal(10,2)))),
		Sup_ItemStatus					= CASE spm.Status
												WHEN 1 THEN 'Active'
												WHEN 2 THEN 'Discontinued'
												WHEN 3 THEN 'Ceased'
												WHEN 4 THEN 'Suspended'
												WHEN NULL THEN ''
												ELSE 'Unknown'
										  END,

		Group_Id						= pg.Id, -- no int Id
		Group_Name						= pg.name, --pg.code,
		Group_Code						= pg.Code,

		SubGroup_ID						= p.ProductGroupPath, -- no int ID
		SubGroup_Code					= d.Code,  --- need to change to list each of the codes comma separated
		SubGroup_Name					= isnull(d.Name,REVERSE(PARSENAME(REPLACE(REVERSE(ProductGroupPath), ',', '.'), 2))), -- need to creqate this based on all subgroups
		Sup_Substituted					= (case	when spm.substituteType is null then 'No'

												when  spm.substituteType  = 0 then 'No'

												when  spm.substituteType  = 1 then 'Yes'

												else '' end)

	FROM [dbo].Products p
		INNER JOIN  [dbo].SaleItems					si	on si.ProductId = p.Id and si.Deleted = 0
		INNER JOIN  [dbo].ProductDimensions			pd	on pd.SaleItemId = si.ID and pd.Deleted = 0
		LEFT JOIN  [dbo].ProductDimensionPrices		pdp on pdp.ProductDimensionId = pd.Id and pdp.Deleted = 0
		LEFT JOIN [dbo].PriceLevels					pl	on pl.Id = pd.PriceLevelId
		INNER JOIN  [dbo].ProductGroups				pg	on pg.Id = REVERSE(PARSENAME(REPLACE(REVERSE(ProductGroupPath), ',', '.'), 1)) -- use first value from Group Path
		LEFT JOIN  [dbo].ProductGroups				d	on d.Id = REVERSE(PARSENAME(REPLACE(REVERSE(ProductGroupPath), ',', '.'), 2))  -- use second value from Group Path
		LEFT JOIN [dbo].StockItems					ski on ski.ProductId = p.Id and ski.Deleted = 0
		LEFT JOIN [dbo].SupplierProductMaps			spm	on spm.ProductId = p.Id and spm.deleted = 0
		LEFT JOIN [dbo].Suppliers						s	on s.Id = spm.SupplierId 
		LEFT JOIN [dbo].TaxGroups						tg	on tg.Id = pdp.TaxGroupId
		LEFT JOIN [dbo].Taxes							t	on t.TaxGroupId = tg.Id
		LEFT JOIN [dbo].ExportCodeProductMaps			ECPM ON ECPM.Id = (SELECT MIN(Id) FROM [dbo].ExportCodeProductMaps WHERE ProductId = P.Id AND Deleted = 0)
		LEFT JOIN [dbo].ExportCodes					EC	ON EC.Id = ECPM.ExportCodeId AND EC.Deleted = 0
	WHERE 1=1
		AND p.active = 1
		AND p.Deleted = 0
	ORDER BY p.Id
END	
---End GetItemData--

---GetSalesData---
GO
IF OBJECT_ID(N'[dbo].[GetSalesData]', N'P') IS NOT NULL
	DROP PROCEDURE [dbo].[GetSalesData]
GO 

CREATE PROCEDURE [dbo].[GetSalesData]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@BranchFilterId uniqueidentifier
AS
BEGIN
	SELECT --top 5
		Sale_rowID							= td.Id,
		Sale_TxnDate						= FORMAT(t.Date,'dd/MM/yyyy'),
		Sale_TxnTime						= FORMAT(t.Date,'HH:mm'),
		Sale_StoreID						= b.Id,
		Sale_StoreCode						= t.BranchCode,
		Sale_CashierNumber					= u.Code,
		Sale_CashierName					= u.FirstName + ' ' + u.LastName,
		Sale_TransactionNumber				= t.SaleNo,
		Sale_AZTransactionNumber			= t.AZTransactionNumber,
		Sale_SupplierID						= s.Id,
		Sale_ItemID							= td.ProductId,
		Sale_ProductExportCode				= EC.Code,
		Sale_ProductExportCodeName			= EC.Name,
		Sale_ItemName						= td.ProductName,
		Sale_Cost							= td.ProductCost,
		Sale_FullPrice						= pdp.PriceValue,
		Sale_Quantity						= td.Quantity,
		Sale_GrossSales						= td.Amount,
		Sale_NetSales						= td.Amount-td.Tax,  --NetPrice column appears to store incorrect value
		Sale_Taxable						= IIF(td.TaxRate = 0,0,1),
		Sale_TaxRate						= td.TaxRate,
		Sale_SalesTax						= td.Tax,
		Sale_Discount						= td.Discount,
		Sale_DiscountReason					= IIF(td.DiscountReasonId IS NULL,'',r.name),
		Sale_OfferName						= ISNULL(td.OfferName,''),
		Sale_ReturnsFlag					= IIF(t.RefundReasonId IS NULL,'No','Yes'),
		Sale_ReturnReason					= IIF(t.RefundReasonId IS NULL,'None',rr.name)

	FROM [dbo].Transactions						t
		INNER JOIN [dbo].TransactionDetails		td	on td.TransactionId = t.Id
		INNER JOIN [dbo].ProductDimensionPrices	pdp	on pdp.Id = td.ProductDimensionPriceId
		INNER JOIN [dbo].Branches					b	on b.Id = BranchId
		INNER JOIN [dbo].Products					p	on p.Id = td.ProductId
		LEFT JOIN (select SupplierId,ProductId,PackSize,Cost,Active,ROW_NUMBER() OVER (PARTITION BY Productid ORDER BY Productid,spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
					from [dbo].SupplierProductMaps spm
					where deleted = 0) AS spm ON rn = 1 AND spm.ProductId = td.ProductId
		LEFT JOIN [dbo].Suppliers					s	on s.Id = spm.SupplierId
		LEFT JOIN [dbo].CashierSessions			cs	on cs.Id = t.CashierId
		LEFT JOIN [dbo].AspNetUsers				u	on u.Id = cs.OperatorId
		LEFT JOIN [dbo].Reasons					r	on r.Id = td.DiscountReasonId
		LEFT JOIN [dbo].Reasons					rr	on rr.Id = t.RefundReasonId
		LEFT JOIN [dbo].ExportCodeProductMaps		ECPM ON ECPM.Id = (SELECT MIN(Id) FROM [dbo].ExportCodeProductMaps WHERE ProductId = td.ProductId AND Deleted = 0)
		LEFT JOIN [dbo].ExportCodes				EC	ON EC.Id = ECPM.ExportCodeId AND EC.Deleted = 0
	WHERE
		(@BranchId IS NULL OR t.BranchId = @BranchId)
		AND b.Deleted = 0
		AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
		AND CAST(t.Date as DATE) >= Cast(@FromDate as DATE) AND Cast(t.Date as DATE) <= Cast(@ToDate as DATE)
END

---End GetSalesData---

---GetListSupplierCatalogue---
GO
IF OBJECT_ID(N'[dbo].[GetListSupplierCatalogue]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetListSupplierCatalogue]
GO

CREATE PROCEDURE [dbo].[GetListSupplierCatalogue]

AS
BEGIN
    SELECT 
		SupplierName = s.Name
		, SupplierProductCode = SPM.SupplierProductCode
		, SupplierProductName = SPM.SupplierProductName
		, Product = P.Code
		, PackSize = SPM.PackSize
		, CostPrice = spm.Cost
		, Status = CASE SPM.Status
						WHEN 1 THEN 'Active'
						WHEN 2 THEN 'Discontinued'
						WHEN 3 THEN 'Ceased'
						WHEN 4 THEN 'Suspended'
						WHEN NULL THEN ''
						ELSE 'Unknown'
					END
		, PreferredSupplier = IIF(SPM.IspreferredSupplier = 1,'1','0')
		, SubsitutesProduct = pro.Code + ' & ' + pro.Name
	FROM
		[dbo].SupplierProductMaps as SPM
		LEFT JOIN [dbo].Suppliers as S on S.Id = SPM.SupplierId and S.Deleted = 0
		LEFT JOIN [dbo].Products as P on P.Id = SPM.ProductId and P.Deleted = 0
		LEFT JOIN [dbo].SupplierProductMaps as map on map.Id = SPM.SubstituteMapId
		LEFT JOIN [dbo].Products as pro on pro.Id = map.ProductId and pro.Deleted = 0
		where SPM.Deleted = 0

END
---end---

---GetListProductSupplierCostReferInBranch---
GO
IF OBJECT_ID(N'[dbo].[GetListProductSpecificSupplierCostReferInBranch]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetListProductSpecificSupplierCostReferInBranch]
GO

CREATE PROCEDURE [dbo].[GetListProductSpecificSupplierCostReferInBranch]
	@BranchId uniqueidentifier,
	@SupplierId uniqueidentifier
AS
BEGIN
	;WITH cte AS
	(
	   SELECT M.ProductId,  
			  Cost = IIF(M.PackSize = 0, M.Cost, M.Cost / CONVERT(decimal(18,4), M.PackSize)),
			  PackSize = IIF(M.PackSize = 0, 1, M.PackSize),
			 ROW_NUMBER() OVER (PARTITION BY M.ProductId ORDER BY M.IsPreferredSupplier DESC) AS rn
	   FROM [dbo].SupplierProductMaps AS M
	   INNER JOIN [dbo].SupplierBranchMaps AS M1 ON M.SupplierId = M1.SupplierId AND M1.BranchId = @BranchId
	   WHERE @SupplierId is null or M.SupplierId = @SupplierId
	)
	SELECT ProductId, Cost, PackSize
	FROM cte
	WHERE rn = 1
END
---end---


---GetStockAdjustments---
GO
IF OBJECT_ID(N'[dbo].[GetStockAdjustments]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetStockAdjustments]
GO

CREATE PROCEDURE [dbo].[GetStockAdjustments]
	@AdjustmentNo bigint,
	@BranchId uniqueidentifier
AS
BEGIN
	SELECT		
		AdjustmentId			= a.Uid, 
		AdjustmentNo			= a.id,
		BranchId				= b.Id,
		Branch					= b.name,
		AdjustmentReason		= r.Name,
		AdjustedBy				= uc.Email,
		UpdatedBy				= uu.Email,
		ProductGroupId			= COALESCE((select productgroupid  from products where id =  ad.ProductId),''),
		ProductGroup			= ad.ProductgroupName,
		ProductCode				= ad.Code,
		ProductId				= ad.ProductId,
		Product					= ad.ProductName,
		Comments				= COALESCE(ad.Comments,''),
		UnitCost				= CAST(ad.Cost as decimal(10,2)),
		QTY						= CAST(CASE WHEN ar.Type > 1 
											THEN -ad.Quantity 
											ELSE ad.Quantity 
										END as FLOAT),  -- change to Negative based on the reason type  0 & 1 are both postitive reasons based on findings
		TotalCost				= CAST(CASE WHEN ar.Type > 1 
											THEN (-ad.Quantity * ad.Cost)
											ELSE (ad.Quantity * ad.Cost) 
										END as decimal(10,2)),
		CreateDate				= CONVERT(varchar,A.CreatedDate,103)
	FROM [dbo].Adjustments as a
	INNER JOIN  (	SELECT		ad.AdjustmentId,ad.ProductgroupName,ad.Code,ad.ProductName,ad.ProductId,ad.Comments,ad.Quantity,Cost = CAST(ISNULL((sum(h.AdjustmentQTY*h.cost))/sum(h.AdjustmentQTY),sum(ad.Cost)) AS decimal(18,4))
					FROM		[dbo].AdjustmentDetails ad
					LEFT JOIN	[dbo].StockMovementHistories h on h.MovementDetailId = ad.Id and h.MovementType = 2
					GROUP BY    ad.AdjustmentId,ad.ProductgroupName,ad.Code,ad.ProductName,ad.ProductId,ad.Comments,ad.Quantity
				)as ad on ad.AdjustmentId = a.ID
	INNER JOIN	[dbo].Reasons as r on r.ID = a.ReasonId
	INNER JOIN	[dbo].Branches as b on b.ID = a.BranchId
	INNER JOIN	[dbo].AspNetUsers as uc on uc.ID = a.CreatedBy
	INNER JOIN	[dbo].AspNetUsers as uu on uu.ID = a.UpdatedBy
	LEFT JOIN	[dbo].Reasons as ar on ar.Id = a.ReasonId
	LEFT JOIN	[dbo].SupplierProductMaps as spm on spm.ProductId = ad.ProductId and spm.Deleted = 0
	LEFT JOIN	[dbo].Suppliers as s on s.Id = spm.SupplierId
	WHERE 		(@BranchId IS NULL OR B.Id = @BranchId)
	AND			(@AdjustmentNo IS NULL OR a.id = @AdjustmentNo)
	ORDER BY	a.CreatedDate DESC
END
---End GetStockAdjustments---

---GetStockTransfers---
GO
IF OBJECT_ID(N'[dbo].[GetStockTransfers]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetStockTransfers]
GO

CREATE PROCEDURE [dbo].[GetStockTransfers]
	@TansferID bigint,
	@BranchFilterId uniqueidentifier,
	@BranchToFilterId uniqueidentifier,
	@TransferStatus int,
	@CreatedDate Datetime,
	@LastUpdate Datetime
AS
BEGIN
	SELECT  	TransferId		= t.ID,
				TransferDate	= CONVERT(varchar, t.Createddate, 103),
				TransferStatus	= (CASE
											WHEN t.Status = 0 THEN 'Transferred Out'
											WHEN t.Status = 1 THEN 'Transferred'
											WHEN t.Status = 2 THEN 'Rejected'
											WHEN t.Status = 3 THEN 'Awaiting Confirmation'
											WHEN t.Status = 4 THEN 'Draft'
											ELSE ''
										END),
				FromBranchID	= bf.Id,
				FromBranch		= bf.name,
				ToBranchID		= bt.Id,
				ToBranch		= bt.name,
				ProductGroupID	= COALESCE((select productgroupid  from products where id =  td.ProductId),''),
				ProductGroup	= td.ProductGroupName,
				ProductID		= td.productId,
				ProductCode		= td.Code,
				Product			= td.ProductName,
				TransferredBy	= anuc.email,
				CreatedDate		= CONVERT(varchar, td.CreatedDate, 103),
				UpdatedBy		= anuu.Email,
				UpdatedDate		= CONVERT(varchar, td.UpdatedDate, 103),
				Cost			= CAST(td.Cost as DECIMAL(10,2)),
				StockLevel		= CAST(td.StockLevel as FLOAT),
				RequestedQTY	= CAST(td.RequestedQTY as FLOAT),
				IssuedQTY		= CAST(td.IssuedQTY as FLOAT),
				ReceivedQTY		= CAST(td.Quantity as FLOAT),
				Out_CreatedDate  = CONVERT(varchar,T.CreatedDate,103),
				Out_UpdatedDate  = CONVERT(varchar,T.UpdatedDate,103)
	FROM		[dbo].Transfers as t
	INNER JOIN 	(	SELECT		td.TransferId,h.Branchid,td.CreatedDate,td.UpdatedDate,td.ProductGroupName,td.Code,td.ProductName,td.ProductId,td.StockLevel,td.IssuedQTY,td.Quantity,td.RequestedQTY,Cost = ISNULL((sum(h.AdjustmentQTY*h.cost))/ISNULL(NULLIF(sum(h.AdjustmentQTY),0),1),SUM(td.cost))
					FROM		[dbo].TransferDetails td
					LEFT JOIN	[dbo].StockMovementHistories h on h.MovementDetailId = td.Id --and h.MovementType in (3,7) --and AdjustmentQTY < 0
					GROUP BY td.TransferId,h.BranchId,td.CreatedDate,td.UpdatedDate,td.ProductGroupName,td.Code,td.ProductName,td.ProductId,td.StockLevel,td.IssuedQTY,td.Quantity, td.RequestedQTY
				)as td on td.TransferId = t.id and (td.Branchid = t.FromBranchId or td.BranchID is null)
	INNER JOIN	[dbo].Branches as bf on bf.id = t.FromBranchId
	INNER JOIN	[dbo].Branches as bt on bt.id = t.ToBranchId
	INNER JOIN	[dbo].AspNetUsers as anuc on anuc.id = t.CreatedBy
	INNER JOIN	[dbo].AspNetUsers as anuu on anuu.id = t.UpdatedBy
	WHERE		(@CreatedDate IS NULL or Datediff(d,T.CreatedDate,@CreatedDate) = 0)
	AND			(@LastUpdate IS NULL OR Datediff(d,T.UpdatedDate,@LastUpdate) = 0)
	AND			(@BranchFilterId IS NULL OR bf.Id = @BranchFilterId)
	AND			(@BranchToFilterId IS NULL OR bt.Id = @BranchToFilterId)
	AND			(@TansferID IS NULL OR t.ID = @TansferID)
	AND			(@TransferStatus IS NULL or t.Status = @TransferStatus)
	ORDER BY T.CreatedDate DESC
END

---End GetStockTransfers---

---GetItemMovementAPI---
GO
IF OBJECT_ID(N'[dbo].[GetItemMovementAPI]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetItemMovementAPI]
GO

CREATE PROCEDURE [dbo].[GetItemMovementAPI]
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
	@FromDate DateTime,
	@ToDate DateTime
AS
BEGIN
	SELECT		BranchID				= B.Id,
				BranchCode				= B.Code,
				BranchName				= B.Name,
				TransferDestinationID	= B1.ID,
				TransferDestination		= IIF(B1.Name IS NULL, '', B1.Name),
				ProductID				= P.ID,
				ProductCode				= P.Code,
				ProductName				= P.Name,
				MovementType			= (	CASE
												WHEN H.MovementType = 1 THEN 'Sale'
												WHEN H.MovementType = 2 THEN 'Adjustment'
												WHEN H.MovementType = 3 THEN 'Transfer Out'
												WHEN H.MovementType = 4 THEN 'StockCount'
												WHEN H.MovementType = 5 THEN 'Refund'
												WHEN H.MovementType = 6 THEN 'Delivery'
												WHEN H.MovementType = 7 THEN 'Transfer In'
											END),
				MovementNo				= (	CASE
												WHEN H.MovementType = 1 THEN cast(TR.SaleNo as varchar(36))
												WHEN H.MovementType = 2 THEN cast(ad.Id as varchar(8))
												WHEN H.MovementType = 3 THEN cast(TD.TransferId as varchar(8))
												WHEN H.MovementType = 4 THEN cast(SC.Id as varchar(8))
												WHEN H.MovementType = 5 THEN cast(TR.SaleNo as varchar(36))
												WHEN H.MovementType = 6 THEN cast(O.Id as varchar(8))
											END),
				SupplierID				= S.id, 
				Suppliername			= IIF(S.Name IS NOT NULL, S.Name, ''),
				BeforeQTY				= ISNULL(NULLIF(H.StockOnHand,0),H.CurrentQTY),--H.CurrentQTY
				AdjustmentQuantity		= H.AdjustmentQTY,
				AfterQTY				= (ISNULL(NULLIF(H.StockOnHand,0),H.CurrentQTY) + H.AdjustmentQTY),
				UnitCost				= cast(H.Cost as decimal(10,2)),
				LastDeliveryCost		= cast(H.LastDeliveryCost as decimal(10,2)),
				Date					= CONVERT(varchar, H.CreatedDate, 103),
				CreatedBy				= H.NameCreate,
				'Time'					= CONVERT(varchar, H.CreatedDate, 108),
				LastUpdate				= CONVERT(varchar, H.UpdatedDate, 103),
				LastUpdateBy			= H.NameCreate
	FROM		[dbo].StockMovementHistories AS H
	LEFT JOIN	[dbo].Adjustments ad on cast(ad.Uid as varchar(36)) = h.MovementId and MovementType = 2
	LEFT JOIN	[dbo].Reasons ar on ar.Id = ad.ReasonId
	LEFT JOIN	[dbo].Branches AS B ON B.Id = H.BranchId
	LEFT JOIN	[dbo].Branches AS B1 ON B1.Id = H.TransferDestination
	LEFT JOIN	[dbo].Products AS P ON P.Id = H.ProductId
	LEFT JOIN	[dbo].Transactions AS TR ON cast(TR.Id as varchar(36)) = h.MovementId and MovementType in (1, 5)
	LEFT JOIN	[dbo].TransferDetails AS TD ON cast(TD.Id as varchar(36)) = h.MovementId and MovementType = 3
	LEFT JOIN	[dbo].StockCounts AS SC ON cast(SC.Uid as varchar(36)) = h.MovementId and MovementType = 4
	LEFT JOIN	[dbo].Orders AS O ON cast(O.Uid as varchar(36)) = h.MovementId and MovementType = 6
	LEFT JOIN	(	select	SupplierId, ProductId, SupplierProductCode,Cost,Active ,ROW_NUMBER() OVER (PARTITION BY Productid ORDER BY Productid,spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
					from	[dbo].SupplierProductMaps spm
					where	deleted = 0) 
				AS spm ON spm.ProductId = P.ID and rn = 1
	LEFT JOIN	[dbo].Suppliers AS S ON S.Id = SPM.SupplierId
	WHERE		(@BranchId IS NULL OR H.BranchId = @BranchId OR H.TransferDestination = @BranchId) AND B.Deleted = 0
	AND			(@ProductFilterId IS NULL OR H.ProductId = @ProductFilterId)
	AND			(H.CreatedDate >= @FromDate AND H.CreatedDate <= @ToDate)
	ORDER BY BranchName, ProductName
END

---End GetItemMovementAPI---

 ---GetStockCounts---
GO
IF OBJECT_ID(N'[dbo].[GetStockCounts]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetStockCounts]
GO

CREATE PROCEDURE [dbo].[GetStockCounts]
	@CountNumber bigint,
	@BranchId uniqueidentifier,
	@FromDate Datetime,
	@ToDate Datetime 
AS

BEGIN
		SELECT		CountNumber			= sc.Id,
					DateCounted			= CONVERT(varchar, CAST(sc.CreatedDate as date), 103),
					DateApproved		= CONVERT(varchar, CAST(sc.UpdatedDate as date), 103),
					BranchId			= b.Id,
					Branch				= b.Name,
					CountStatus			= (	CASE
													WHEN sc.Status = 0 THEN 'Counting'
													WHEN sc.Status = 1 THEN 'Awaiting Appoval'
													WHEN sc.Status = 2 THEN 'Recount Required'
													WHEN sc.Status = 3 THEN 'Rejected'
													WHEN sc.Status = 4 THEN 'Confirmed'
													WHEN sc.Status = 5 THEN 'Canceled'
											END),
					CountType			= (	CASE
													WHEN sc.CountType = 0 THEN 'All Stock Count'
													WHEN sc.CountType = 1 THEN 'Group Count'
													WHEN sc.CountType = 2 THEN 'Individual Item Count'
											END),
					CountedUser			= CONCAT(uc.FirstName, ' ', uc.LastName),
					ApprovedUser		= CONCAT(uu.FirstName, ' ', uu.LastName),
					Comments			= IIF(scd.Comment IS NOT NULL, scd.Comment, ''),
					ProductGroupID		= COALESCE((select productgroupid  from products where id =  scd.ProductId),''),
					ProductGroup		= scd.ProductGroupName,
					ProductID			= scd.Productid,
					ProductCode			= scd.ProductCode,
					ProductName			= scd.ProductName,
					SupplierID			= (select top 1 id from suppliers where name =scd.SupplierName),
					SupplierName		= scd.SupplierName,
					Cost				= cast(scd.Cost as decimal(10,2)),
					ExpectedQTY			= cast(scd.Expected as float),
					CountedQTY			= cast(scd.Quantity as float),
					ApprovedQTY			= cast(scd.ApprovedQuantity as float),
					QTYVariance			= cast(IIF(scd.ApprovedQuantity IS NOT NULL, scd.ApprovedQuantity - scd.Expected, 0 - scd.Expected) as float),
					CostVariance		= CAST(IIF(scd.ApprovedQuantity IS NOT NULL, scd.Cost * (scd.ApprovedQuantity - scd.Expected), scd.Cost * (0 - scd.Expected)) as decimal(10,2)),
					CreatedDate			= CONVERT(varchar, sc.CreatedDate,103),
					StatusCode			= sc.Status
		FROM		[dbo].StockCounts as sc
		INNER JOIN (
						select		scd.StockCountId,scd.Comment,scd.Productid,scd.ProductCode,scd.ProductName,scd.SupplierCode,scd.SupplierName,scd.ProductGroupName,scd.Expected,scd.Quantity,scd.ApprovedQuantity,Cost=cast(ISNULL((sum(h.AdjustmentQTY*h.cost))/sum(h.AdjustmentQTY),sum(scd.Cost)) as float)
						FROM		[dbo].StockCountDetails scd
						LEFT JOIN	[dbo].StockMovementHistories h on h.MovementDetailId = scd.Id and h.MovementType = 4
						WHERE		scd.Edited = 1
						group by	scd.StockCountId,scd.Comment,scd.Productid,scd.ProductCode,scd.ProductName,scd.SupplierCode,scd.SupplierName,scd.ProductGroupName,scd.Expected,scd.Quantity,scd.ApprovedQuantity
					)  as scd on scd.StockCountId = sc.Id
		INNER JOIN	[dbo].Branches as b on b.Id = sc.BranchId
		INNER JOIN	[dbo].AspNetUsers as uc on uc.Id = sc.CreatedBy
		INNER JOIN	[dbo].AspNetUsers as uu on uu.Id = sc.UpdatedBy
		WHERE		(@FromDate IS NULL OR sc.CreatedDate >= @FromDate)
		AND			(@ToDate IS NULL OR sc.CreatedDate <= @ToDate)
		AND			(@CountNumber IS NULL OR sc.Id = @CountNumber)
		AND			(@BranchId IS NULL OR b.Id = @BranchId)
		ORDER BY	sc.CreatedDate DESC
END

---End GetStockCounts---

---GetProductPriceList---
GO
IF OBJECT_ID(N'[dbo].[GetProductPriceList]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetProductPriceList]
GO

CREATE PROCEDURE [dbo].[GetProductPriceList]
AS
BEGIN
	DECLARE @NOW DateTime = GETDATE()-14  -- Use 14 days ago to cater for sites being closed for a while
	SELECT		ProductId,
				PriceLevel		= PriceLevel,
				FromDate		= ISNULL(IIF(Pfrom>@NOW,Pfrom,PFrom),Pfrom),
				ToDate			= ISNULL(Pto,Pto),
				Price			= ISNULL(IIF(pFrom>@NOW,Pprice,Pprice),Pprice)  --- if the from  date of the primary price is older, then use the secondary price
				into #list
	from		(	-- need to generate a union joined list of all prices and then join together for the branch and product for either secondary or primary price
				select		p.Id as productID,
							type		='SecondaryPrice',
							PriceLevel	=SecondaryPrice.Name,
							Pfrom		=SecondaryPrice.ValidFrom,
							Pto			=SecondaryPrice.ValidTo,
							Pprice		=SecondaryPrice.PriceValue
				from		[dbo].Products p
				inner join	[dbo].SaleItems si on si.ProductId = p.Id and si.Deleted = 0
				inner join 	(	select		pd.SaleItemId,
											spl.Name,
											pdp.ValidFrom,
											pdp.ValidTo,
											pdp.PriceValue 
								from		[dbo].ProductDimensions pd
								inner join	[dbo].PriceLevels spl on spl.Id = pd.PriceLevelId and spl.PriceLevelOption = 1 and spl.Deleted = 0
								inner join	[dbo].ProductDimensionPrices pdp on pdp.ProductDimensionId = pd.Id and pdp.Deleted = 0
								WHERE		pd.Deleted = 0
								) SecondaryPrice on SecondaryPrice.SaleItemId = si.Id 
	UNION ALL
	select			P.ID as productID,
					type		='PrimaryPrice',
					PriceLevel	=PrimaryPrice.Name,
					Pfrom		=PrimaryPrice.ValidFrom,
					Pto			=PrimaryPrice.ValidTo,
					Pprice		=PrimaryPrice.PriceValue
	from			[dbo].Products p
	inner join		[dbo].SaleItems si on si.ProductId = p.Id and si.Deleted = 0
	inner join 		(	Select		ppd.SaleItemId,
									ppl.Name,
									fpdp.ValidFrom,
									fpdp.ValidTo,
									fpdp.PriceValue 
						from		[dbo].ProductDimensions ppd 
						inner join	[dbo].ProductDimensionPrices fpdp on fpdp.ProductDimensionId = ppd.Id and fpdp.Deleted = 0
						inner join	[dbo].PriceLevels ppl on ppl.Id = ppd.PriceLevelId and ppl.PriceLevelOption = 0  and ppl.Deleted = 0
						WHERE		ppd.Deleted = 0
						) PrimaryPrice on PrimaryPrice.SaleItemId = si.Id 
	) list
		-- Now select the current and future prices based on the temp table
	SELECT		distinct
				ProductID					= p.id,
				ProductCode					= p.Code,
				ProductName					= p.Name,
				SupplierProductCode			= spm.SupplierProductCode,
				PriceLevel					= Clist.PriceLevel,
				CurrentPrice				= cast(Clist.Price as decimal(10,2)),
				Valid_From					= CONVERT(varchar, clist.FromDate,103),
				Valid_To					= CONVERT(varchar, clist.ToDate,103),
				CreatedDate					= CONVERT(varchar,Clist.FromDate,103) 
	FROM #list as Clist
	left join	#List Flist on Clist.ProductId = Flist.ProductId 
	and			(Flist.FromDate > ISNULL(clist.ToDate,@NOW) or Flist.FromDate > @NOW) 
	and			ISNULL(Flist.ToDate,'01 jan 2099') > @NOW	
	INNER JOIN	[dbo].Products as p on p.ID = Clist.ProductId AND p.deleted = 0
	LEFT JOIN	(	select * ,ROW_NUMBER() OVER (PARTITION BY ProductId ORDER BY spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
					from [dbo].SupplierProductMaps spm
					where deleted = 0
				) AS spm ON spm.ProductId = P.ID and spm.rn = 1
	WHERE		1=1
	DROP TABLE #list
END

---End GetProductPriceList---