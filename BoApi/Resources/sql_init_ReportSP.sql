--Alter--DeclarationReport--
begin tran
GO
/****** Create Synonyms to be used by the SP ******/
IF OBJECT_ID(N'[dbo].[tCashiers]', N'SN') IS NULL CREATE SYNONYM [dbo].[tCashiers] FOR [ECR-v2-NMNI-Ticketing].[tickets].[Cashiers]
IF OBJECT_ID(N'[dbo].[tCashierDetails]', N'SN') IS NULL CREATE SYNONYM [dbo].[tCashierDetails] FOR [ECR-v2-NMNI-Ticketing].[tickets].[CashierDetails]
IF OBJECT_ID(N'[dbo].[tDevices]', N'SN') IS NULL CREATE SYNONYM [dbo].[tDevices] FOR [ECR-v2-NMNI-Ticketing].[tickets].[Devices]
IF OBJECT_ID(N'[dbo].[tAspnetUsers]', N'SN') IS NULL CREATE SYNONYM [dbo].[tAspnetUsers] FOR [ECR-v2-NMNI-Ticketing].[tickets].[AspnetUsers]
IF OBJECT_ID(N'[dbo].[tBranches]', N'SN') IS NULL CREATE SYNONYM [dbo].[tBranches] FOR [ECR-v2-NMNI-Ticketing].[tickets].[Branches]
GO
/****** Object:  StoredProcedure [dbo].[GetDeclarationReport]    Script Date: 20/07/2022 07:06:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetDeclarationReport]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@BranchFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
SELECT
		'Date' = CONVERT(varchar, C.SessionEnd, 103)
	 , Till = D.Name
	 , 'User' = CONCAT(A1.FirstName, ' ', A1.LastName)
	 , 'UserEod' = CONCAT(A2.FirstName, ' ', A2.LastName)
	 , Tender = CD.Tender
	 , AmountDeclared = CD.Declared
	 , AmountCalculated = CD.Calculated
	 , 'Difference' = CD.Calculated - CD.Declared
FROM CashierSessions AS C
		 INNER JOIN CashierDetails AS CD ON C.Id = CD.CashierId
		 LEFT JOIN Devices AS D ON D.Id = C.DeviceId
		 LEFT JOIN AspNetUsers AS A1 ON A1.Id = C.CreatorId
		 LEFT JOIN AspNetUsers AS A2 ON A2.Id = C.EnderId
		 LEFT JOIN Branches AS B ON B.Id = D.BranchId
WHERE C.Deleted = 0
  AND (@BranchId IS NULL OR D.BranchId = @BranchId)
  AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
  AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
  AND (C.SessionEnd >= @FromDate AND C.SessionEnd <= @ToDate)
UNION ALL
SELECT
		'Date' = CONVERT(varchar, C.SessionEnd, 103)
	 , Till = D.Name
	 , 'User' = CONCAT(A1.FirstName, ' ', A1.LastName)
	 , 'UserEod' = CONCAT(A2.FirstName, ' ', A2.LastName)
	 , Tender = CD.Tender
	 , AmountDeclared = CD.Declared
	 , AmountCalculated = CD.Calculated
	 , 'Difference' = CD.Calculated - CD.Declared
FROM tCashiers AS C
		 INNER JOIN tCashierDetails AS CD ON C.Id = CD.CashierId
		 LEFT JOIN tDevices AS D ON D.Id = C.DeviceId
		 LEFT JOIN tAspNetUsers AS A1 ON A1.Id = C.CreatorId
		 LEFT JOIN tAspnetUsers AS A2 ON A2.Id = C.EnderId
		 LEFT JOIN tBranches AS B ON B.Id = D.BranchId
WHERE C.Deleted = 0
  AND (@BranchId IS NULL OR D.BranchId = @BranchId)
  AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
  AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
  AND (C.SessionEnd >= @FromDate AND C.SessionEnd <= @ToDate)
---end---
	GO
commit
--
---SupplierCatalogueReport---
GO
IF OBJECT_ID(N'[dbo].[GetSupplierCatalogueReport]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetSupplierCatalogueReport]
GO

CREATE PROCEDURE [dbo].[GetSupplierCatalogueReport]
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
	@BranchFilterId uniqueidentifier,
	@SupplierFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
BEGIN	
	DECLARE @HOBranch int;		
	SET @HOBranch = (SELECT count(b.id)
	FROM
		[dbo].Branches b
	WHERE b.Id = @BranchId AND b.Code = 'HO')

	SELECT 
		  BranchName = B.Name
		, SupplierCode = S.Code
		, SupplierName = S.Name
		, SupplierProductCode = SPMAP.SupplierProductCode
		, ProductCode = P.Code
		, ProductName = SPMAP.SupplierProductName
		, StockItemName = StItem.Name
		, PackSize = SPMAP.PackSize
		, Cost = SPMAP.Cost
		, CatalogueStatus = IIF(SPMAP.Status IS NOT NULL, (CASE
							WHEN SPMAP.Status = 1 THEN 'Active'
							WHEN SPMAP.Status = 2 THEN 'Discontinued'
							WHEN SPMAP.Status = 3 THEN 'Ceased'
							WHEN SPMAP.Status = 4 THEN 'Suspended'
						END), '')
		, Category = PG.Name
		, SubCategory = IIF(P.ProductGroupPath is not null, [dbo].[GetProductGroupPath] (P.ProductGroupPath,','), '')
		, TaxGroup = 
			(
				SELECT TG.Name + ', ' AS [text()]
				FROM 
				(
					SELECT DISTINCT TG.Name
					FROM
						[dbo].SaleItems AS SaleItem
						LEFT JOIN [dbo].ProductDimensions AS PD ON SaleItem.Id = PD.SaleItemId AND PD.Deleted = 0
						LEFT JOIN [dbo].ProductDimensionPrices AS PDP ON PD.Id = PDP.ProductDimensionId AND PDP.Deleted = 0
						LEFT JOIN [dbo].TaxGroups AS TG ON PDP.TaxGroupId = TG.Id AND TG.Deleted = 0
					WHERE P.IsSaleItem = 1 AND P.Id = SaleItem.ProductId
				) AS TG
				ORDER BY TG.Name
				FOR XML PATH ('')
			)
		, Tax = 
			(
				SELECT CAST(Tax.EatIn as NVARCHAR) + ', ' AS [text()]
				FROM 
				(
					SELECT DISTINCT Tax.EatIn
					FROM
						[dbo].SaleItems AS SaleItem
						LEFT JOIN [dbo].ProductDimensions AS PD ON SaleItem.Id = PD.SaleItemId AND PD.Deleted = 0
						LEFT JOIN [dbo].ProductDimensionPrices AS PDP ON PD.Id = PDP.ProductDimensionId AND PDP.Deleted = 0
						LEFT JOIN [dbo].TaxGroups AS TG ON PDP.TaxGroupId = TG.Id AND TG.Deleted = 0
						LEFT JOIN [dbo].Taxes AS Tax ON TG.Id = Tax.TaxGroupId AND Tax.Deleted = 0
					WHERE P.IsSaleItem = 1 AND P.Id = SaleItem.ProductId
				) AS Tax
				ORDER BY Tax.EatIn
				FOR XML PATH ('')
			)
        , Barcode = isnull(isnull((select top 1 BC.Code from [dbo].BarCodes BC where BC.ProductId = P.Id and BC.Deleted = 0 order by BC.UpdatedDate desc ), p.Barcode), '')

    FROM
		[dbo].Branches AS B
		INNER JOIN [dbo].SupplierBranchMaps AS SBMAP ON B.Id = SBMAP.BranchId
		INNER JOIN [dbo].Suppliers AS S ON S.Id = SBMAP.SupplierId AND S.Deleted = 0
		INNER JOIN [dbo].SupplierProductMaps AS SPMAP ON S.Id = SPMAP.SupplierId
		INNER JOIN [dbo].BranchProductMaps bpm ON bpm.BranchId = b.Id AND bpm.ProductId = SPMAP.ProductId AND bpm.Active = 1
		INNER JOIN [dbo].Products AS P ON P.Id = SPMAP.ProductId AND P.Deleted = 0
		INNER JOIN [dbo].ProductGroups AS PG ON P.ProductGroupId = PG.Id AND PG.Deleted = 0
		INNER JOIN [dbo].StockItems AS StItem ON P.Id = StItem.ProductId
	WHERE (@BranchId IS NULL OR @HOBranch > 0 OR B.Id = @BranchId) AND B.Deleted = 0
		AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
		AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
		AND (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
		AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
	ORDER BY BranchName, SupplierName, ProductName
END
---end---

---CurrentStockHoldingReport---
GO
IF OBJECT_ID(N'[dbo].[CurrentStockHoldingReport]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[CurrentStockHoldingReport]
GO

CREATE PROCEDURE [dbo].[CurrentStockHoldingReport]
	@BranchId uniqueidentifier
AS
BEGIN
	DECLARE @HOBranch int;		
	SET @HOBranch = (SELECT count(b.id)
	FROM
		[dbo].Branches b
	WHERE b.Id = @BranchId AND b.Code = 'HO')

	;WITH cte AS
	(
		SELECT			
			Branch = b.Name, 
			SupplierCode = IIF(S.CODE IS NOT NULL, S.CODE, ''),
			SupplierName = IIF(S.NAME IS NOT NULL, S.NAME, ''),
			OrderPO = IIF(o.Id IS NOT NULL, Cast( o.Id as varchar(20)) , ''),
			OrderDate = IIF( o.CreatedDate IS NOT NULL, CONVERT(varchar, CAST(o.CreatedDate as date), 111), ''),
			DeliveryDate = CONVERT(varchar, CAST(sv.CreatedDate as date), 111),
			ProductCode = p.Code,
			ProductName = p.Name, 
			ItemCost = IIF(sv.PackSize = 0, sv.CostPrice, sv.CostPrice/sv.PackSize),
			DeliveredQTY = sv.DeliveryQuantity,
			IssuedQTY = sv.IssuedQuantity,
			RemainingQTY = sv.RemainingQuantity,			
			StockValuation  = IIF(sv.PackSize = 0, sv.CostPrice, sv.CostPrice/sv.PackSize) * sv.RemainingQuantity,
			ROW_NUMBER() OVER (PARTITION BY B.Name, P.Code, P.Name, bpm.Quantity ORDER BY bpm.UpdatedDate DESC) AS rn
		FROM 
			[dbo].BranchProductMaps AS bpm 
			INNER JOIN [dbo].Branches AS b ON bpm.BranchId = b.Id AND b.Deleted = 0
			INNER JOIN [dbo].Products AS p ON bpm.ProductId = p.Id AND p.Deleted = 0 AND p.IsStockItem = 1
			INNER JOIN [dbo].StockValuations AS sv ON bpm.BranchId = sv.BranchId AND bpm.ProductId = sv.ProductId AND sv.Deleted = 0
			INNER JOIN [dbo].Orders as o ON Cast(O.Id as varchar(20)) = sv.DeliveryId AND o.Deleted = 0
			LEFT JOIN (select SupplierId, ProductId,SupplierProductCode,Cost,Active ,ROW_NUMBER() OVER (PARTITION BY Productid ORDER BY Productid,spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
				from [dbo].SupplierProductMaps spm
				where deleted = 0) AS spm ON spm.ProductId = P.ID and rn = 1
			LEFT JOIN [dbo].Suppliers AS S ON S.ID = spm.SupplierId AND s.Deleted = 0
		WHERE 
			bpm.Deleted = 0 AND (@HOBranch > 0 OR B.Id = @BranchId)
	)
	SELECT *
	FROM cte
	WHERE rn = 1
	ORDER BY Branch, ProductName
END
---end---

---ProductsReport---
GO
IF OBJECT_ID(N'[dbo].[GetProductsReport]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetProductsReport]
GO

CREATE PROCEDURE [dbo].[GetProductsReport]
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
	@BranchFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier,
	@ProductGroupFilterId uniqueidentifier,
	@ProductSubGroupFilterId nvarchar(max)
AS
BEGIN
	select ProductId,
            stuff((select ',' + Code
                    from [dbo].BarCodes
                    where (BC.ProductId = ProductId and Deleted = 0)
                    for xml path(''),TYPE).value('(./text())[1]', 'VARCHAR(MAX)')
                , 1, 1, '') AS BarCodes
	into #Barcodes
    from [dbo].BarCodes BC
	WHERE Deleted = 0
    group by ProductId


	CREATE UNIQUE NONCLUSTERED INDEX [IX_Temp_ProductId] ON #Barcodes
	(
		[ProductId] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]

	SELECT 
		  BranchName = B.Name
		, ProductGroup = PG.Name
		, ProductSubGroup = ISNULL(P.ProductGroupPath,'')
		, ProductCode = P.Code
		, ProductName = P.Name
		, ProductBarcode = ISNULL(p.Barcode,'') + IIF(NULLIF(p.Barcode,'') IS NULL,'',IIF(bc.Barcodes IS NULL,'',',')) + ISNULL(bc.Barcodes,'')
		, Commission = P.Commission
		, OnSaleDate = CONVERT(varchar, SaleItem.OnSaleDate, 111)
		, OffSaleDate = CONVERT(varchar, SaleItem.OffSaleDate, 111)
		, Cost = IIF(PDP.Cost IS NOT NULL, PDP.Cost, 0)
		, Price = IIF(PDP.PriceValue IS NOT NULL, PDP.PriceValue, 0)
		, ValidFrom = CONVERT(varchar, PDP.ValidFrom, 111)
		, ValidTo = CONVERT(varchar, PDP.ValidTo, 111)
		, LastUpdated = CONVERT(varchar, P.UpdatedDate, 111)
		, ActiveFlag = IIF(P.Active = 1, 'Yes', 'No')
		, TaxGroup = 
			(
				SELECT TG.Name + ', ' AS [text()]
				FROM 
				(
					SELECT DISTINCT TG.Name
					FROM
						[dbo].TaxGroups AS TG
					WHERE PDP.TaxGroupId = TG.Id AND TG.Deleted = 0
				) AS TG
				ORDER BY TG.Name
				FOR XML PATH ('')
			)
		, Tax = 
			(
				SELECT CAST(Tax.EatIn as NVARCHAR) + ', ' AS [text()]
				FROM 
				(
					SELECT DISTINCT Tax.EatIn
					FROM
						[dbo].TaxGroups AS TG
						LEFT JOIN [dbo].Taxes AS Tax ON TG.Id = Tax.TaxGroupId AND Tax.Deleted = 0
					WHERE PDP.TaxGroupId = TG.Id AND TG.Deleted = 0
				) AS Tax
				ORDER BY Tax.EatIn
				FOR XML PATH ('')
			)
		, MinLevel = IIF(SLGPMAP.Minimum IS NOT NULL, SLGPMAP.Minimum, 0)
		, StandardLevel = IIF(SLGPMAP.Standard IS NOT NULL, SLGPMAP.Standard, 0)
		, MaxLevel = IIF(SLGPMAP.Maximum IS NOT NULL, SLGPMAP.Maximum, 0),pd.Active
		FROM
			[dbo].Branches AS B
			INNER JOIN [dbo].BranchProductMaps AS BPMAP ON B.Id = BPMAP.BranchId
			INNER JOIN [dbo].Products AS P ON P.Id = BPMAP.ProductId AND P.Deleted = 0
			INNER JOIN [dbo].ProductGroups AS PG ON P.ProductGroupId = PG.Id AND PG.Deleted = 0
			LEFT JOIN [dbo].SaleItems AS SaleItem ON P.Id = SaleItem.ProductId AND P.IsSaleItem = 1
			LEFT JOIN [dbo].ProductDimensions AS PD ON SaleItem.Id = PD.SaleItemId AND PD.Deleted = 0 and pd.active = 1
			LEFT JOIN [dbo].ProductDimensionPrices AS PDP ON PD.Id = PDP.ProductDimensionId AND PDP.Deleted = 0
			LEFT JOIN [dbo].StockLocationGroupProductMaps AS SLGPMAP ON SLGPMAP.ProductId = BPMAP.ProductId AND EXISTS (SELECT * FROM StockLocationGroupBranchMaps WHERE StockLocationGroupId = SLGPMAP.StockLocationGroupId AND BranchId = B.Id)
			LEFT JOIN #Barcodes BC on P.Id = BC.ProductId
		WHERE (@BranchId IS NULL OR B.Id = @BranchId) AND B.Deleted = 0
			  AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
			  AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
			  AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
			  AND (@ProductGroupFilterId IS NULL OR P.ProductGroupId = @ProductGroupFilterId)
			  AND (@ProductSubGroupFilterId IS NULL OR P.ProductGroupPath LIKE '%' + @ProductSubGroupFilterId)
		ORDER BY BranchName, ProductName
		
		drop table #Barcodes
END
---end---

---GoodsReceiptedReport---
GO
IF OBJECT_ID(N'[dbo].[GoodsReceiptedReport]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GoodsReceiptedReport]
GO

CREATE PROCEDURE [dbo].[GoodsReceiptedReport]
	@FromDate DATETIME,
	@ToDate DATETIME,
	@ProductFilterId uniqueidentifier,
	@SupplierFilterId uniqueidentifier,
	@BranchFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
	SELECT 
		DeliveryDate = 
						(CASE
							WHEN O.Status = 5 THEN CONVERT(varchar, O.DeliveryDate, 111)
							ELSE ''
						END),
		OrderDate = CONVERT(varchar, O.CreatedDate, 111),
		PurchaseOrder = O.Id,
		Branch = B.Name,
		SupplierName = S.Name,
		DeliveryStatus = 
						(CASE
							WHEN O.Status = 2 THEN 'Sent To Supplier'
							WHEN O.Status = 5 THEN 'Receipted'
							WHEN O.Status = 7 THEN 'Not Delivered'
						END),
		ProductCode = IIF(P.Code IS NOT NULL, P.Code, ''),
		SupplierCode = S.Code,
		ProductName = IIF(P.Name IS NOT NULL, P.Name, ''),
		SupplierProductCode = IIF(SPM.SupplierProductCode IS NOT NULL, SPM.SupplierProductCode, ''),
		UpdatedBy = CONCAT(U.FirstName, ' ', U.LastName),
		UOM = IIF(OD.UnitOfMeasureName IS NOT NULL, OD.UnitOfMeasureName, ''),
		PackSize = IIF(OD.PackSize IS NOT NULL, OD.PackSize, 0),
		UnitCost = CAST(IIF(OD.Cost IS NOT NULL, IIF(OD.PackSize <> 0, OD.Cost/OD.PackSize, OD.Cost), 0) AS DECIMAL(16,4)),
		ExpectedQTY = IIF(OD.Quantity IS NOT NULL, OD.Quantity, 0),
		DeliveredQTY = IIF(OD.Delivered IS NOT NULL, OD.Delivered, 0),
		LineCost = IIF(OD.Delivered*IIF(OD.Cost IS NOT NULL, IIF(OD.PackSize <> 0, OD.Cost/OD.PackSize, OD.Cost), 0) IS NOT NULL, OD.Delivered*IIF(OD.Cost IS NOT NULL, IIF(OD.PackSize <> 0, OD.Cost/OD.PackSize, OD.Cost), 0), 0),
		TotalCost = IIF((
			SELECT SUM(OD1.Delivered*IIF(OD1.PackSize <> 0, OD1.Cost/OD1.PackSize, OD1.Cost))
			FROM [dbo].OrderDetails AS OD1
			WHERE OD1.OrderId = OD.OrderId AND OD.Deleted = 0
		) IS NOT NULL, (
			SELECT SUM(OD1.Delivered*IIF(OD1.PackSize <> 0, OD1.Cost/OD1.PackSize, OD1.Cost))
			FROM [dbo].OrderDetails AS OD1
			WHERE OD1.OrderId = OD.OrderId AND OD.Deleted = 0
		), 0)
	FROM [dbo].Orders as O
		LEFT JOIN [dbo].OrderBranchMaps AS OBM ON OBM.OrderId = O.Id AND OBM.Deleted = 0
		LEFT JOIN [dbo].Branches AS B ON B.Id = OBM.BranchId AND B.Deleted = 0
		LEFT JOIN [dbo].OrderSupplierMaps AS OSM ON OSM.OrderId = O.Id AND OSM.Deleted = 0 
		LEFT JOIN [dbo].Suppliers AS S ON S.Id = OSM.SupplierId AND S.Deleted = 0
		LEFT JOIN [dbo].OrderDetails AS OD ON OD.OrderId = O.Id AND OD.Deleted = 0	
		LEFT JOIN [dbo].Products AS P ON P.Id = OD.ProductId AND P.Deleted = 0
		LEFT JOIN [dbo].SupplierProductMaps AS SPM ON SPM.SupplierId = S.Id AND SPM.ProductId = P.Id AND SPM.Deleted = 0
		LEFT JOIN [dbo].AspNetUsers AS U ON O.UpdatedBy = U.Id
	WHERE
		O.Deleted = 0 AND (O.CreatedDate >= @FromDate AND O.CreatedDate <= @ToDate) 
		AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
        AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
        AND (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
		AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
		AND (O.Status = 2 
		OR O.Status = 5 
		OR O.Status = 7)
		AND
		((SELECT COUNT(*) FROM OrderBranchMaps WHERE OrderId = O.Id) = 1)
		AND
		((SELECT COUNT(*) FROM OrderSupplierMaps WHERE OrderId = O.Id) = 1)
	ORDER BY OrderDate, ProductName

---end---

---OrderToSupplierReport---
GO
IF OBJECT_ID(N'[dbo].[GetOrderToSupplierReport]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetOrderToSupplierReport]
GO

CREATE PROCEDURE [dbo].[GetOrderToSupplierReport]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
	@SupplierFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
	SELECT
		  OrderDate = CONVERT(varchar, O.CreatedDate, 111)
		, BranchName = B.Name
		, PurchaseOrder = O.Id
		, SupplierCode = S.Code
		, SupplierName  = S.Name
		, OrderStatus = 
			CASE
				WHEN O.Status = 0 THEN 'In Progress'
				WHEN O.Status = 1 THEN 'Awaiting Approval'
				WHEN O.Status = 2 THEN 'Sent To Supplier'
				WHEN O.Status = 3 THEN 'Not Approved'
				WHEN O.Status = 4 THEN 'Cancelled'
				WHEN O.Status = 5 THEN 'Receipted'
				WHEN O.Status = 6 THEN 'Rejected'
				WHEN O.Status = 7 THEN 'Not Delivered'
			END
		, DeliveryDate = 
			CASE
				WHEN O.Status = 5 THEN CONVERT(varchar, O.DeliveryDate, 111)
				ELSE ''
			END
		, ProductCode = IIF(P.Code IS NOT NULL, P.Code, '')
		, SupplierProductCode = SPM.SupplierProductCode
		, ProductName = IIF(OD.ProductName IS NOT NULL, OD.ProductName, '')
		, UnitOfMeasure = IIF(OD.UnitOfMeasureName IS NOT NULL, OD.UnitOfMeasureName, '')
		, PackSize = IIF(OD.PackSize IS NOT NULL, OD.PackSize, 0)
		, ItemCost = CAST(IIF(OD.Cost IS NOT NULL, IIF(OD.PackSize <> 0, OD.Cost / OD.PackSize , OD.Cost), 0) AS DECIMAL(16,4))
		, OrderedQuantity = IIF(OD.Quantity IS NOT NULL, OD.Quantity, 0)
		, LineCost = IIF(OD.Quantity IS NOT NULL, IIF(OD.PackSize <> 0, OD.Quantity * OD.Cost / OD.PackSize, OD.Quantity * OD.Cost), 0)
		, TotalCost = O.GrandTotal
	FROM
		[dbo].Orders AS O
		INNER JOIN [dbo].OrderBranchMaps AS OBMAP ON O.Id = OBMAP.OrderId
		INNER JOIN [dbo].Branches AS B ON OBMAP.BranchId = B.Id
		INNER JOIN [dbo].OrderSupplierMaps AS OSMAP ON O.Id = OSMAP.OrderId
		INNER JOIN [dbo].Suppliers AS S ON OSMAP.SupplierId = S.Id
		LEFT JOIN [dbo].OrderDetails AS OD ON O.Id = OD.OrderId AND OD.Deleted = 0
		LEFT JOIN [dbo].Products AS P ON OD.ProductId = P.Id
		LEFT JOIN [dbo].SupplierProductMaps as SPM ON SPM.ProductId = P.Id AND SPM.SupplierId = S.Id
	WHERE (@BranchId IS NULL OR B.Id = @BranchId) AND B.Deleted = 0
		AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
        AND (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
		AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
		AND (O.CreatedDate >= @FromDate AND O.CreatedDate <= @ToDate)
		AND ((SELECT COUNT(*) FROM OrderBranchMaps WHERE OrderId = O.Id) = 1)
		AND ((SELECT COUNT(*) FROM OrderSupplierMaps WHERE OrderId = O.Id) = 1)
	ORDER BY BranchName, SupplierName, ProductName
---end---

-- Sales Report --
GO
IF OBJECT_ID(N'[dbo].[GetSalesReport]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetSalesReport]
GO

CREATE PROCEDURE [dbo].[GetSalesReport]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
    @BranchFilterId uniqueidentifier,
    @SupplierFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier,
	@ProductGroupFilterId uniqueidentifier,
	@ProductSubGroupFilterId nvarchar(max),
	@ProductTagFilterId uniqueidentifier,
	@ProductType int
AS
BEGIN	
	DECLARE @HOBranch int;		
	SET @HOBranch = (SELECT count(b.id)
	FROM
		[dbo].Branches b
	WHERE b.Id = @BranchId AND b.Code = 'HO')


select SupplierId,ProductId,SupplierProductCode,PackSize,Cost,Active,ROW_NUMBER() OVER (PARTITION BY Productid ORDER BY Productid,spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
					--from SupplierProductMaps
into #tmpA
					from [dbo].SupplierProductMaps spm
					where deleted = 0


	
CREATE NONCLUSTERED INDEX idx_SupplierId
ON #tmpA(SupplierId);				


CREATE NONCLUSTERED INDEX idx_productID
ON #tmpA(productID);	


CREATE NONCLUSTERED INDEX idx_rn
ON #tmpA(rn);


   SELECT
		[Date] = CONVERT(varchar, T.[Date], 111),
		[Time] = CONVERT(varchar, T.[Date], 108),
		BranchName = (SELECT B.[Name]
			FROM [dbo].Branches B
			WHERE B.Id = T.BranchId),
		SaleType = (CASE
							WHEN T.Type = 0 THEN 'Sale'
							WHEN T.Type = 1 THEN 'Refund'
							WHEN T.Type = 2 THEN 'Open Refund'
						END),
		Device = t.DeviceSerial,
		[User] = t.CreatorName,
		SupplierCode = IIF(s.code IS NOT NULL, s.code, ''),
		SupplierName = IIF(s.[Name] IS NOT NULL, s.[Name], ''),
		SupplierProductCode = spm.SupplierProductCode,
		ProductGroupName = td.ProductGroupName,
		Product = TD.ProductName,
		TaxRate = TD.TaxRate,
		TaxCode = Taxes.Code,
		Barcode = (select top 1 BC.Code from [dbo].BarCodes BC where BC.ProductId = P.Id and BC.Deleted = 0 order by BC.UpdatedDate desc ),
		Commission = p.commission,
		TransactionNumber  = T.SaleNo,
		Quantity = TD.Quantity,
		Total = TD.Amount,
		Vat = TD.Tax,
		NetPrice = (td.amount - td.Tax),--temp. fix (TD.NetPrice),
		ProductCost = TD.ProductCost,
		BranchCode = IIF(T.BranchCode IS NOT NULL, T.BranchCode, ''),
		DiscountAmount = TD.Discount,
		DiscountReason = IIF(TD.DiscountReason IS NOT NULL, TD.DiscountReason, ''),
		RefundReason = IIF(T.RefundReason IS NOT NULL, T.RefundReason, ''),
		ProductCode = IIF(p.Code IS NOT NULL, p.Code, ''),
		OfferName = IIF(TD.OfferName IS NOT NULL, TD.OfferName, ''),
		DiscountedFlag = IIF(TD.Discount IS NOT NULL, IIF(TD.Discount > 0, 'True', 'False'), 'False'),
		ProductSubGroup = IIF(p.ProductGroupPath is not null, p.ProductGroupPath, ''),
		ProductType = (CASE 
								WHEN p.IsSaleItem = 1 and p.IsStockItem = 1 THEN 'All'
								WHEN p.IsSaleItem = 1 THEN 'Sale'
								WHEN p.IsStockItem = 1 THEN 'Stock'
						END),
		TransactionID = IIF(T.AZTransactionNumber IS NULL, '', CONVERT(nvarchar(50), T.AZTransactionNumber))
	FROM 
		(
		SELECT td.Id,td.Transactionid,td.ProductGroupName,td.OfferName,td.productName,td.ProductId,td.TaxId,td.taxrate,td.DiscountReason,td.Discount,td.Quantity,td.Amount,td.Tax,ProductCost=cast(ISNULL((sum(h.AdjustmentQTY*h.cost))/sum(h.AdjustmentQTY),td.ProductCost) as decimal(18,2)), td.Voided
		FROM [dbo].TransactionDetails td
			  left JOIN [dbo].StockMovementHistories h on h.MovementDetailId = td.Id and h.MovementType = 1
		WHERE ISNULL(TD.Voided,0) = 0
		GROUP BY td.Id,td.Transactionid,td.ProductGroupName,td.OfferName,td.productName,td.ProductId,td.TaxId,td.taxrate,td.DiscountReason,td.Discount,td.Quantity,td.Amount,td.Tax,td.ProductCost, td.Voided
		)AS TD
			INNER JOIN [dbo].Transactions AS T ON T.Id = TD.TransactionId
			LEFT JOIN [dbo].Taxes AS Taxes ON Taxes.Id = TD.TaxId
			LEFT JOIN [dbo].Branches AS B ON B.Id = T.BranchId
			LEFT JOIN [dbo].Products as p ON p.ID = td.ProductId
			
		/*	
			LEFT JOIN (select SupplierId,ProductId,SupplierProductCode,PackSize,Cost,Active,ROW_NUMBER() OVER (PARTITION BY Productid ORDER BY Productid,spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
					from SupplierProductMaps spm
					where deleted = 0) AS spm ON rn = 1 AND spm.ProductId = td.ProductId
			
		*/
			left join #tmpA as spm ON rn = 1 AND spm.ProductId = td.ProductId
			LEFT JOIN [dbo].Suppliers as s on s.ID = spm.SupplierId

	WHERE T.[Date] >= @FromDate AND T.Date <= @ToDate
		  AND (@BranchId IS NULL OR @HOBranch > 0 OR B.Id = @BranchId)
		  AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
          AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
          AND (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
		  AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
		  AND (@ProductGroupFilterId IS NULL OR P.ProductGroupId = @ProductGroupFilterId)
		  AND (@ProductSubGroupFilterId IS NULL OR P.ProductGroupPath LIKE '%' + @ProductSubGroupFilterId)
		  AND (@ProductType IS NULL OR (@ProductType = 0 AND p.IsSaleItem = 1 AND p.IsStockItem = 1) OR (@ProductType = 1 AND p.IsSaleItem = 1 AND p.IsStockItem = 0) OR (@ProductType = 2 AND p.IsSaleItem = 0 AND p.IsStockItem = 1))
		  AND ISNULL(TD.Voided,0) = 0
	ORDER BY T.SaleNo DESC
END
---end---


---ProductExportCodeReport---
GO
IF OBJECT_ID(N'[dbo].[GetProductExportCodeReport]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetProductExportCodeReport]
GO

CREATE PROCEDURE [dbo].[GetProductExportCodeReport]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
	SELECT
		  Date = CONVERT(varchar, T.Date, 111)
		, Branch = B.Name
		, BranchCode = B.Code
		, ProductExportCode =
			(
				SELECT E.Code + ', ' AS [text()]
				FROM
				(
					SELECT DISTINCT E.Code
					FROM
						[dbo].ExportCodeProductMaps AS EPMAP
						LEFT JOIN [dbo].ExportCodes AS E ON EPMAP.ExportCodeId = E.Id
					WHERE E.Deleted = 0 AND D.ProductId = EPMAP.ProductId
				) AS E
				ORDER BY E.Code
				FOR XML PATH ('')
			)
		, ProductExportCodeName =
			(
				SELECT E.Name + ', ' AS [text()]
				FROM
				(
					SELECT DISTINCT E.Name
					FROM
						[dbo].ExportCodeProductMaps AS EPMAP
						LEFT JOIN [dbo].ExportCodes AS E ON EPMAP.ExportCodeId = E.Id
					WHERE E.Deleted = 0 AND D.ProductId = EPMAP.ProductId
				) AS E
				ORDER BY E.Name
				FOR XML PATH ('')
			)
		, Quantity = D.Quantity
		, ExclVat = (d.amount - d.Tax) -- DB03062021: Temp fix (D.NetPrice)
		, Vat = D.Tax
		, Total = D.Amount --D.Price * D.Quantity * IIF(D.Amount < 0, -1, 1)
		, TransactionNumber = T.SaleNo
		, ProductCode = P.Code
		, TransactionID =  IIF(T.AZTransactionNumber IS NULL, '', CONVERT(nvarchar(50), T.AZTransactionNumber))
	FROM
		[dbo].TransactionDetails AS D
		LEFT JOIN [dbo].Transactions AS T ON D.TransactionId = T.Id
		LEFT JOIN [dbo].Branches AS B ON T.BranchId = B.Id
		LEFT JOIN [dbo].Products AS P ON D.ProductId = P.Id
	WHERE (@BranchId IS NULL OR T.BranchId = @BranchId)
		AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
		AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
		AND (T.Date >= @FromDate AND T.Date <= @ToDate)
		AND ISNULL(D.Voided,0) = 0
	ORDER BY T.Date DESC
---end---



---TicketingCommissionReport---
GO
IF OBJECT_ID(N'[dbo].[GetTicketingCommissionReport]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetTicketingCommissionReport]
GO

CREATE PROCEDURE [dbo].[GetTicketingCommissionReport]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
	@SupplierFilterId nvarchar(50),
	@BranchGroupFilterId uniqueidentifier
AS
SELECT *
	FROM(
	SELECT
	  SaleDate = CONVERT(varchar, T.Date, 111)
	, Branch = T.BranchName
	, BranchCode = B.Code
	, SupplierName = 
		(
			SELECT S.Name + ', ' AS [text()]
			FROM 
			(
				SELECT DISTINCT S.Name
				FROM
					[dbo].SupplierProductMaps AS SPMAP
					LEFT JOIN [dbo].Suppliers AS S ON SPMAP.SupplierId = S.Id
				WHERE S.Deleted = 0 AND D.ProductId = SPMAP.ProductId
			) AS S
			ORDER BY S.Name
			FOR XML PATH ('')
		)
	, SupplierCode = 
		(
			SELECT S.Code + ', ' AS [text()]
			FROM 
			(
				SELECT DISTINCT S.Code
				FROM
					[dbo].SupplierProductMaps AS SPMAP
					LEFT JOIN [dbo].Suppliers AS S ON SPMAP.SupplierId = S.Id
				WHERE S.Deleted = 0 AND D.ProductId = SPMAP.ProductId
			) AS S
			ORDER BY S.Code
			FOR XML PATH ('')
		)
	, SupplierId = 
		(
			SELECT CONVERT(nvarchar(50), S.Id) + ', ' AS [text()]
			FROM 
			(
				SELECT DISTINCT S.Id
				FROM
					[dbo].SupplierProductMaps AS SPMAP
					LEFT JOIN [dbo].Suppliers AS S ON SPMAP.SupplierId = S.Id
				WHERE S.Deleted = 0 AND D.ProductId = SPMAP.ProductId
			) AS S
			FOR XML PATH ('')
		)
	, Product = D.ProductName
	, ProductCode = P.Code
	, Quantity = D.Quantity
	, TotalSaleValue = D.Amount
	, CommissionRate = D.CommissionRate
	, CommissionValue = D.Commission
	, TotalSalesValueLessCommission = D.Amount - D.Commission
	, TransactionNumber = T.SaleNo
	, SaleTime = CONVERT(varchar, T.Date, 108)
	, TransactionDetailUID = CONVERT(nvarchar(50), D.Id)
	, ProductSubGroup = IIF(P.ProductGroupPath is not null, P.ProductGroupPath, '')
	, Date = T.Date
FROM
	[dbo].TransactionDetails AS D
	LEFT JOIN [dbo].Transactions AS T ON D.TransactionId = T.Id
	LEFT JOIN [dbo].Branches AS B ON T.BranchId = B.Id
	LEFT JOIN [dbo].Products AS P ON D.ProductId = P.Id
	INNER JOIN [dbo].ProductGroups AS G ON P.ProductGroupId = G.Id AND G.Deleted = 0 AND (G.Name = 'TI TICKETS')
	WHERE (@BranchId IS NULL OR T.BranchId = @BranchId)
		AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
		AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
		AND (T.Date >= @FromDate AND T.Date <= @ToDate)
		AND ISNULL(D.Voided,0) = 0
	) AS SS
	WHERE @SupplierFilterId IS NULL OR SS.SupplierId LIKE '%' + @SupplierFilterId + '%'
	ORDER BY SS.Date DESC

---TenderExportCodeReport---
GO
IF OBJECT_ID(N'[dbo].[GetTenderExportCodeReport]', N'P') IS NOT NULL
	DROP PROCEDURE [dbo].[GetTenderExportCodeReport]
GO

CREATE PROCEDURE [dbo].[GetTenderExportCodeReport]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
SELECT	
		[Date] = CONVERT(varchar, CAST( Tras.[Date] AS DATE), 111),
		TransactionNumber = Tras.SaleNo,
		Branch = B.[Name],
		BranchCode = B.Code,
		DeviceNumber = D.Serial,
		TenderType = P.[Name],
		TenderName = Te.[Name],
		TenderCode = T.[Code],
		Amount = SUM(P.[Value]),
		TransactionID = IIF(Tras.AZTransactionNumber IS NULL, '', CONVERT(nvarchar(50), Tras.AZTransactionNumber)),
		SaleTime = CONVERT(varchar, CAST( Tras.[Date] AS DATETIME), 108)

FROM 
		[dbo].Transactions AS Tras			 
		INNER JOIN [dbo].PartPayments AS P ON P.TransactionId = Tras.Id
		INNER JOIN [dbo].TenderTypes As T ON T.[Name] = P.[Name]
		INNER JOIN [dbo].Branches AS B ON B.Id = Tras.BranchId
		INNER JOIN [dbo].Devices AS D ON Tras.DeviceId = D.Id
		INNER JOIN [dbo].Tenders AS Te ON P.TenderId = Te.Id
WHERE		
		(@BranchId IS NULL OR Tras.BranchId = @BranchId)
		AND 
		(@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
		AND
		(Tras.[Date] >= @FromDate AND Tras.Date <= @ToDate)
		
GROUP BY 
		P.[Name],
		CONVERT(varchar, CAST( Tras.[Date] AS DATETIME), 108),
		Tras.SaleNo,
		CAST( TRAS.DATE AS DATE),
		B.[Name],
		Te.Name,
		B.Code,
		D.Serial,
		Tras.AZTransactionNumber,
		T.Code
ORDER BY 
		CAST( Tras.[Date] AS DATE) DESC

---end---

---spRptAdjustments---
GO
IF OBJECT_ID(N'[dbo].[spRptAdjustments]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[spRptAdjustments]
GO

CREATE PROCEDURE [dbo].[spRptAdjustments]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
	@SupplierFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS

SELECT 

	'AdjustmentNo'			= a.id,
	'Location'				= b.name,
	'AdjustmentReason'		= r.Name,
	'AdjustedBy'			= uc.Email,
	'UpdatedBy'				= uu.Email,
	'Code'					= ad.Code,
	'ProductGroup'			= ad.ProductgroupName,
	'Product'				= ad.ProductName,
	'UnitCost'				= ad.Cost,
	'QTY'					= CAST(CASE WHEN ar.Type > 1 THEN -ad.Quantity ELSE ad.Quantity END as FLOAT),  -- change to Negative based on the reason type  0 & 1 are both postitive reasons based on findings
	'Comments'				= ad.Comments,
	'TotalCost'				= CAST(CASE WHEN ar.Type > 1 THEN (-ad.Quantity * ad.Cost)
													ELSE (ad.Quantity * ad.Cost) END as FLOAT)
	


  FROM [dbo].Adjustments as a
  INNER JOIN 
  ( SELECT ad.AdjustmentId,ad.ProductgroupName,ad.Code,ad.ProductName,ad.ProductId,ad.Comments,ad.Quantity,Cost = CAST(ISNULL((sum(h.AdjustmentQTY*h.cost))/sum(h.AdjustmentQTY),sum(ad.Cost)) AS decimal(18,4))
	FROM [dbo].AdjustmentDetails ad
	LEFT JOIN [dbo].StockMovementHistories h on h.MovementDetailId = ad.Id and h.MovementType = 2
	GROUP BY  ad.AdjustmentId,ad.ProductgroupName,ad.Code,ad.ProductName,ad.ProductId,ad.Comments,ad.Quantity
  )as ad on ad.AdjustmentId = a.ID
  INNER JOIN [dbo].Reasons as r on r.ID = a.ReasonId
  INNER JOIN [dbo].Branches as b on b.ID = a.BranchId
  INNER JOIN [dbo].AspNetUsers as uc on uc.ID = a.CreatedBy
  INNER JOIN [dbo].AspNetUsers as uu on uu.ID = a.UpdatedBy
  LEFT JOIN [dbo].Reasons as ar on ar.Id = a.ReasonId
  LEFT JOIN [dbo].SupplierProductMaps as spm on spm.ProductId = ad.ProductId and spm.Deleted = 0
  LEFT JOIN [dbo].Suppliers as s on s.Id = spm.SupplierId


  WHERE A.CreatedDate >= @FromDate AND a.CreatedDate <= @ToDate
		AND (@BranchId IS NULL OR B.Id = @BranchId)
		AND (@ProductFilterId IS NULL OR ad.ProductId = @ProductFilterId)
        AND (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
		AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
		ORDER BY a.CreatedDate DESC		
---end---

---spRptOrdersToSuppliers---
GO
IF OBJECT_ID(N'[dbo].[spRptOrdersToSuppliers]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[spRptOrdersToSuppliers]
GO

CREATE PROCEDURE [dbo].[spRptOrdersToSuppliers]
	@FromDate DateTime,
	@ToDate DateTime,
	@ProductFilterId uniqueidentifier,
	@SupplierFilterId uniqueidentifier,
	@BranchFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
   SELECT 

	'OrderID'			= o.ID,
	'OrderDate'		= CONVERT(varchar, o.CreatedDate, 111),
	'OrderStatusParse'	= 	CASE
								WHEN o.Status = 0 THEN 'In Progress'
								WHEN o.Status = 1 THEN 'Awaiting Approval'
								WHEN o.Status = 2 THEN 'Sent To Supplier'
								WHEN o.Status = 3 THEN 'Not Approved'
								WHEN o.Status = 4 THEN 'Cancelled'
								WHEN o.Status = 5 THEN 'Receipted'
								WHEN o.Status = 6 THEN 'Rejected'
								WHEN o.Status = 7 THEN 'Not Delivered'
								WHEN o.Status = 8 THEN 'Order Generated'
								ELSE ''
							END,
	'DeliveryETA'		= CONVERT(varchar, o.DeliveryDate, 111),
	'Comments'			= o.Comments,
	'Branch'			= b.Name,
	'SupplierCode'		= s.Code,
	'SupplierName'		= s.Name,
--	'ReOrderNo.'		= spm.SupplierProductCode,
	'ILUNumber'		= p.code,
	'Product'			= p.Name,
	'UOM'				= od.UnitOfMeasureName,
	'Cost'				= od.cost,
	'QTY'				= od.Quantity,
	'CarriageCharge'	= o.CarriageCharge,
	'OrderRaisedBy'	= uc.Email,
	'OrderUpdatedBy'	= uu.Email


FROM [dbo].Orders as o
INNER JOIN	[dbo].OrderDetails		as od	ON	od.OrderId = o.Id
INNER JOIN	[dbo].Products			as p	ON	p.ID = od.ProductId
LEFT JOIN	[dbo].Suppliers			as s	ON	s.ID = od.SupplierId
LEFT JOIN	[dbo].OrderBranchMaps		as obm	ON	obm.OrderID = o.Id
LEFT JOIN	[dbo].Branches			as b	ON	b.ID = od.BranchId
--LEFT JOIN	SupplierProductMaps as spm	ON	spm.SupplierId = s.Id
LEFT JOIN	[dbo].AspNetUsers			as uc	ON	uc.ID = o.CreatedBy
LEFT JOIN	[dbo].AspNetUsers			as uu	ON	uu.ID = o.UpdatedBy


WHERE o.CreatedDate >= @FromDate AND o.CreatedDate <= @ToDate
		  AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
          AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
          AND (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
		  AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
	--  AND @BranchId IS NULL OR B.Id = @BranchId
---end---

---spRptStockHolding---
GO
IF OBJECT_ID(N'[dbo].[spRptStockHolding]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[spRptStockHolding]
GO

CREATE PROCEDURE [dbo].[spRptStockHolding]
	@FromDate DATETIME,
	@ToDate DATETIME,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
	@ProductGroupFilterId uniqueidentifier,
    @BranchFilterId uniqueidentifier,
	@SupplierFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
BEGIN	
	DECLARE @ListOrderIdInBranch TABLE(OrderId BIGINT)
	INSERT INTO @ListOrderIdInBranch
	SELECT DISTINCT OrderId
	FROM OrderBranchMaps WHERE (BranchId = @BranchFilterId OR @BranchFilterId IS NULL)
	DECLARE @NOW DateTime = GETDATE()
	DECLARE @LAST24H DateTime = DATEADD(day,-1,GETDATE())
	DECLARE @LAST7Day DateTime = DATEADD(day,-7,GETDATE())
	DECLARE @LAST4Weeks DateTime = DATEADD(day,-28,GETDATE())
	DECLARE @ProductTransactions TABLE(ProductId uniqueidentifier, Last24HQuantity float, Last7DayQuantity float, Last4WeeksQuantity float, BranchId uniqueidentifier)
	INSERT INTO @ProductTransactions
	SELECT 
	'ProductId' = p.Id,
	'Last24HQuantity'				= SUM(case when ts.Date > @LAST24H and ts.Date < @NOW then td.Quantity else 0 end),
	'Last7DayQuantity'				= SUM(case when ts.Date > @LAST7Day and ts.Date < @NOW then td.Quantity else 0 end),
	'Last4WeeksQuantity'			= SUM(case when ts.Date > @LAST4Weeks and ts.Date < @NOW then td.Quantity else 0 end),
	'BranchId' = ts.BranchId
	FROM 
	Products as p
	inner join TransactionDetails as td on p.Id = td.ProductId and td.Voided = 0
	left join Transactions as ts on ts.Id = td.TransactionId 
	WHERE p.Id = td.ProductId and td.Deleted = 0
	Group by ts.BranchId, p.Id 
	DECLARE @ProductOderMaps TABLE(BranchId uniqueidentifier, ProductId uniqueidentifier, Quantity int, OrderValue float)
	INSERT INTO @ProductOderMaps
	SELECT 
	'BranchId' = od.branchId,
	'ProductId' = od.ProductId,
	'Quantity' = sum(case when od.Quantity is null then 0.00 else od.Quantity - od.Delivered END),
	'OrderValue' = sum(case when od.Cost is null then 0.00 else (od.Quantity - od.Delivered) * od.Cost end)
	FROM Orderdetails as od 
	INNER JOIN Orders as o on o.ID = od.OrderId --	0  'In Progress' 1 'Awaiting Approval' 2 'Sent To Supplier' 3 'Not Approved' 4 'Cancelled' 5 'Receipted' 6 'Rejected' 7 'Not Delivered'
	WHERE (@BranchId is null or od.branchId = @BranchId) and o.Status < 3  --(o.status != '4' and o.status != '5' and o.status != '6') and only include 'in progress', 'awaiting approval' and 'sent to supplier'
	and (O.Id IS NULL OR EXISTS (SELECT * FROM @ListOrderIdInBranch WHERE OrderId = O.Id))
	Group by od.BranchId, od.ProductId
			--	0 THEN 'In Progress' 1 THEN 'Awaiting Approval' 2 THEN 'Sent To Supplier' 3 THEN 'Not Approved' 4 THEN 'Cancelled' 5 THEN 'Receipted' 6 THEN 'Rejected' 7 THEN 'Not Delivered'
	SELECT
		BranchId,
		ProductId,
		'PriceLevel' =  ISNULL(PrimaryPrice,SecondaryPrice),
		'FromDate' = ISNULL(PPfrom,SPfrom),
		'ToDate' = ISNULL(PPto,SPto),
		'Price' = ISNULL(PPprice,SPprice),
		Cost = ISNULL(ppCost,spCost),
		ROW_NUMBER() OVER (PARTITION BY BranchId,ProductId ORDER BY ISNULL(PPfrom,SPfrom)) AS rn
	into #list
	from
	(
		select bpm.BranchId,bpm.ProductId,SecondaryPrice=SecondaryPrice.Name,SPfrom=SecondaryPrice.ValidFrom,SPto=SecondaryPrice.ValidTo,SPprice=SecondaryPrice.PriceValue,Primaryprice=PrimaryPrice.Name,PPfrom=PrimaryPrice.ValidFrom,PPto=PrimaryPrice.ValidTo,PPprice=PrimaryPrice.PriceValue,spCost=SecondaryPrice.Cost,ppCost=PrimaryPrice.Cost
		from Products p
		inner join SaleItems si on si.ProductId = p.Id and si.Deleted = 0
		inner join BranchProductMaps bpm on bpm.ProductId = p.Id and bpm.Deleted = 0
		inner join Branches b on b.id = bpm.BranchId
		inner join 
		(
		select plbm.BranchId,pd.SaleItemId,spl.Name,pdp.ValidFrom,pdp.ValidTo,pdp.PriceValue,pdp.Cost 
		from  ProductDimensions pd
		inner join PriceLevels spl on spl.Id = pd.PriceLevelId and spl.PriceLevelOption = 1 and spl.Deleted = 0
		inner join ProductDimensionPrices pdp on pdp.ProductDimensionId = pd.Id and pdp.Deleted = 0
		inner join PriceLevelBranchMaps plbm on plbm.PriceLevelId = spl.Id
		WHERE  pd.Deleted = 0
		) SecondaryPrice on SecondaryPrice.SaleItemId = si.Id and SecondaryPrice.BranchId = b.Id
		left join 
		(
		Select pplbm.BranchId,ppd.SaleItemId,ppl.Name,fpdp.ValidFrom,fpdp.ValidTo,fpdp.PriceValue,fpdp.Cost
		from ProductDimensions ppd 
		inner join ProductDimensionPrices fpdp on fpdp.ProductDimensionId = ppd.Id and fpdp.Deleted = 0
		inner join PriceLevels ppl on ppl.Id = ppd.PriceLevelId and ppl.PriceLevelOption = 0  and ppl.Deleted = 0
		inner join PriceLevelBranchMaps pplbm on pplbm.PriceLevelId = ppl.Id and pplbm.Deleted = 0
		WHERE  ppd.Deleted = 0
		) PrimaryPrice on PrimaryPrice.SaleItemId = si.Id and PrimaryPrice.SaleItemId = SecondaryPrice.SaleItemId and PrimaryPrice.BranchId = b.Id
	) list
 	where (SPto is null or SPto >= getdate()-1) and (PPto is null or PPto >= getdate()-1) -- Primary and Secondary current prices which are valid up to yesterday
	SELECT distinct
		'Branch'				= b.Name,
		'BranchCode'			= b.code,
		'SupplierCode'			= IIF(s.code IS NOT NULL, s.code, ''),
		'SupplierName'			= IIF(s.name IS NOT NULL, s.name, ''),
		'ProductCode'			= p.Code,
		'Product'				= p.Name,
		'StockQuantityOnHand'	= SUM(bp.Quantity),
		'StockValuation'		= ISNULL(SUM(bp.Quantity*ISNULL(spm.cost/ISNULL(NULLIF(spm.Packsize,0),1),rp.Cost)),0),
		'OnOrderQuantity'		= SUM(case when (OD.Quantity is null) then 0.00 else OD.Quantity end),
		'OnOrderValue'			= SUM(ISNULL(OD.OrderValue,0.00)),
		'Last24HQuantity'		= IIF(pt.Last24HQuantity is null,0,pt.Last24HQuantity),
		'Last7DayQuantity'		= IIF(pt.Last7DayQuantity is null,0,pt.Last7DayQuantity), 
		'Last4WeeksQuantity'	= IIF(pt.Last4WeeksQuantity is null,0, pt.Last4WeeksQuantity),
		'StockValue'			= ISNULL(SUM(bp.Quantity*ISNULL(spm.cost/ISNULL(NULLIF(spm.Packsize,0),1),rp.Cost))+SUM(case when (OD.OrderValue is null) then 0.00 else OD.OrderValue end),0.00),
		'Cost'					= ISNULL(ISNULL(spm.cost/ISNULL(NULLIF(spm.Packsize,0),1),MIN(rp.Cost)),0),
		'Retail'				= ISNULL(rp.Price,0.00),
		'SupplierProductCode'	= IIF(spm.SupplierProductCode IS NOT NULL, spm.SupplierProductCode, ''),
		'MinLevel'				= IIF(slgpm.Minimum IS NOT NULL, slgpm.Minimum, 0),
		'ParLevel'				= IIF(slgpm.[Standard] IS NOT NULL,  slgpm.Standard, 0),
		'MaxLevel'				= IIF(slgpm.Maximum IS NOT NULL, slgpm.Maximum, 0),
		'ProductGroup'			= IIF(pg.Name IS NOT NULL, pg.Name, ''),
		'ProductSubGroup'		= IIF(p.ProductGroupPath IS NOT NULL,p.ProductGroupPath, ''),
		'CatalogueStatus'		= IIF(spm.Status IS NOT NULL, (CASE
										WHEN spm.Status = 1 THEN 'Active'
										WHEN spm.Status = 2 THEN 'Discontinued'
										WHEN spm.Status = 3 THEN 'Ceased'
										WHEN spm.Status = 4 THEN 'Suspended'
									END), '')
	FROM BranchProductMaps						as bp
	INNER JOIN	Branches						as b on b.ID = bp.BranchId
	INNER JOIN	Products						as p on p.ID = bp.ProductId AND p.deleted = 0
	LEFT JOIN	ProductGroups					as pg on pg.Id = p.ProductGroupId	
	LEFT JOIN	SaleItems as si on si.ProductId = p.id
	LEFT JOIN	#list							AS rp ON rp.ProductId = bp.ProductId and rp.BranchID = bp.BranchId and rn = 1--and FromDate > getdate()-1
	LEFT JOIN	@ProductOderMaps				as od on od.ProductId = bp.ProductId and od.branchId = b.Id
	LEFT JOIN (select SupplierId,ProductId,supplierProductCode,Status,PackSize,Cost,Active ,ROW_NUMBER() OVER (PARTITION BY ProductId ORDER BY spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
			from SupplierProductMaps spm
			where deleted = 0) AS spm ON spm.ProductId = P.ID and spm.rn = 1
	LEFT JOIN	suppliers						as s on s.ID = spm.SupplierId
	LEFT JOIN	@ProductTransactions			as pt on pt.ProductId = p.Id and pt.BranchId = b.id
	LEFT JOIN	(select slgbm.BranchId,slgbm.StockLocationGroupId from StockLocationGroupBranchMaps slgbm inner join StockLocationGroups slg on slg.Id = slgbm.StockLocationGroupId and slg.Deleted = 0) slgbm on slgbm.BranchId = bp.BranchId
	LEFT JOIN	StockLocationGroupProductMaps	as slgpm on slgpm.StockLocationGroupId = slgbm.StockLocationGroupId and slgpm.ProductId = bp.ProductId
	WHERE (B.Id = @BranchId OR @BranchId is null)
	      AND (@ProductFilterId IS NULL OR p.Id = @ProductFilterId)
          AND (@BranchFilterId IS NULL OR b.Id = @BranchFilterId)
          AND (@SupplierFilterId IS NULL OR s.Id = @SupplierFilterId)
          AND (@BranchGroupFilterId IS NULL OR b.BranchGroupId = @BranchGroupFilterId)
          AND (@ProductGroupFilterId IS NULL OR p.ProductGroupId = @ProductGroupFilterId)
		  AND ISNULL(pg.Name,'') NOT IN ('TI TICKETS','SE SERVICES')
	GROUP BY p.ProductGroupPath, pg.Name, b.Name, b.code, s.code, s.name, p.code, p.Name,rp.Price,pt.Last24HQuantity, pt.Last7DayQuantity, pt.Last4WeeksQuantity, spm.SupplierProductCode, slgpm.Minimum, slgpm.Standard, slgpm.Maximum, spm.Status,spm.cost,ISNULL(NULLIF(spm.Packsize,0),1)
END
---end---

---spRptTransfers---
GO
IF OBJECT_ID(N'[dbo].[spRptTransfers]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[spRptTransfers]
GO

CREATE PROCEDURE [dbo].[spRptTransfers]
	@FromDate DateTime,
	@ToDate DateTime,
	@ProductFilterId uniqueidentifier,
	@SupplierFilterId uniqueidentifier,
    @BranchFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier,
	@BranchToFilterId uniqueidentifier
AS
SELECT 

	'TransferId'		= t.ID,
	'TransferDate'		= CONVERT(varchar, t.Createddate, 111),
	'FromLocation'		= bf.name,
	'ToLocation'		= bt.name,
	'Code'				= td.Code,
	'ProductGroup'		= td.ProductGroupName,
	'Product'			= td.ProductName,
	'Cost'				= CAST(td.Cost as DECIMAL(18,4)),
	'StockLevel'		= CAST(td.StockLevel as FLOAT),
	'QTY'				= CAST(td.Quantity as FLOAT),
	'IssuedQTY'			= CAST(td.IssuedQTY as FLOAT),
	'TransferredBy'	= anuc.email,
	'CreatedDate'		= CONVERT(varchar, td.CreatedDate, 111),
	'UpdatedBy'		= anuu.Email,
	'UpdatedDate'		= CONVERT(varchar, td.UpdatedDate, 111)

FROM [dbo].Transfers as t
INNER JOIN 
(SELECT td.TransferId,h.Branchid,td.CreatedDate,td.UpdatedDate,td.ProductGroupName,td.Code,td.ProductName,td.ProductId,td.StockLevel,td.IssuedQTY,td.Quantity,Cost = ISNULL((sum(h.AdjustmentQTY*h.cost))/ISNULL(NULLIF(sum(h.AdjustmentQTY),0),1),SUM(td.cost))
	FROM [dbo].TransferDetails td
	LEFT JOIN [dbo].StockMovementHistories h on h.MovementDetailId = td.Id --and h.MovementType in (3,7) --and AdjustmentQTY < 0
  GROUP BY td.TransferId,h.BranchId,td.CreatedDate,td.UpdatedDate,td.ProductGroupName,td.Code,td.ProductName,td.ProductId,td.StockLevel,td.IssuedQTY,td.Quantity
)as td on td.TransferId = t.id and (td.Branchid = t.FromBranchId or td.BranchID is null)
INNER JOIN [dbo].Branches as bf on bf.id = t.FromBranchId
INNER JOIN [dbo].Branches as bt on bt.id = t.ToBranchId
INNER JOIN [dbo].AspNetUsers as anuc on anuc.id = t.CreatedBy
INNER JOIN [dbo].AspNetUsers as anuu on anuu.id = t.UpdatedBy

WHERE T.CreatedDate >= @FromDate AND T.CreatedDate <= @ToDate
		  AND (@ProductFilterId IS NULL OR td.ProductId = @ProductFilterId)
          AND (@BranchFilterId IS NULL OR bf.Id = @BranchFilterId)
          --AND (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
		  AND (@BranchGroupFilterId IS NULL OR bf.BranchGroupId = @BranchGroupFilterId OR bt.BranchGroupId = @BranchGroupFilterId)
		  AND (@BranchToFilterId IS NULL OR bt.Id = @BranchToFilterId)
	  
ORDER BY T.CreatedDate DESC	
---end---

---DeclarationReport---
GO
IF OBJECT_ID(N'[dbo].[GetDeclarationReport]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetDeclarationReport]
GO

CREATE PROCEDURE [dbo].[GetDeclarationReport]
	@FromDate DateTime,
	@ToDate DateTime,	
	@BranchId uniqueidentifier,
	@BranchFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
	IF EXISTS (SELECT name FROM master.dbo.sysdatabases  WHERE name = N'CADW-STOCK-Ticketing')
	BEGIN
		SELECT
				'Date' = CONVERT(varchar, C.SessionEnd, 111)
			, Till = D.Name
			, 'User' = CONCAT(A1.FirstName, ' ', A1.LastName)
			, 'UserEod' = CONCAT(A2.FirstName, ' ', A2.LastName)
			, Tender = CD.Tender
			, AmountDeclared = CD.Declared
			, AmountCalculated = CD.Calculated
			, 'Difference' = CD.Calculated - CD.Declared
		FROM [dbo].CashierSessions AS C
		INNER JOIN [dbo].CashierDetails AS CD ON C.Id = CD.CashierId
		LEFT JOIN [dbo].Devices AS D ON D.Id = C.DeviceId
		LEFT JOIN [dbo].AspNetUsers AS A1 ON A1.Id = C.CreatorId
		LEFT JOIN [dbo].AspNetUsers AS A2 ON A2.Id = C.EnderId
		LEFT JOIN [dbo].Branches AS B ON B.Id = D.BranchId
		WHERE C.Deleted = 0
			AND (@BranchId IS NULL OR D.BranchId = @BranchId)
			AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
			AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
			AND (C.SessionEnd >= @FromDate AND C.SessionEnd <= @ToDate)
		UNION ALL
		SELECT
				'Date' = CONVERT(varchar, C.SessionEnd, 103)
			, Till = D.Name
			, 'User' = CONCAT(A1.FirstName, ' ', A1.LastName)
			, 'UserEod' = CONCAT(A2.FirstName, ' ', A2.LastName)
			, Tender = CD.Tender
			, AmountDeclared = CD.Declared
			, AmountCalculated = CD.Calculated
			, 'Difference' = CD.Calculated - CD.Declared
		FROM tCashiers AS C
		INNER JOIN tCashierDetails AS CD ON C.Id = CD.CashierId
		LEFT JOIN tDevices AS D ON D.Id = C.DeviceId
		LEFT JOIN tAspNetUsers AS A1 ON A1.Id = C.CreatorId
		LEFT JOIN tAspNetUsers AS A2 ON A2.Id = C.EnderId
		LEFT JOIN tBranches AS B ON B.Id = D.BranchId
		WHERE C.Deleted = 0
			AND (@BranchId IS NULL OR D.BranchId = @BranchId)
			AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
			AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
			AND (C.SessionEnd >= @FromDate AND C.SessionEnd <= @ToDate);
	End 
	else
	Begin
		SELECT
				'Date' = CONVERT(varchar, C.SessionEnd, 111)
			, Till = D.Name
			, 'User' = CONCAT(A1.FirstName, ' ', A1.LastName)
			, 'UserEod' = CONCAT(A2.FirstName, ' ', A2.LastName)
			, Tender = CD.Tender
			, AmountDeclared = CD.Declared
			, AmountCalculated = CD.Calculated
			, 'Difference' = CD.Calculated - CD.Declared
		FROM [dbo].CashierSessions AS C
		INNER JOIN [dbo].CashierDetails AS CD ON C.Id = CD.CashierId
		LEFT JOIN [dbo].Devices AS D ON D.Id = C.DeviceId
		LEFT JOIN [dbo].AspNetUsers AS A1 ON A1.Id = C.CreatorId
		LEFT JOIN [dbo].AspNetUsers AS A2 ON A2.Id = C.EnderId
		LEFT JOIN [dbo].Branches AS B ON B.Id = D.BranchId
		WHERE C.Deleted = 0
			AND (@BranchId IS NULL OR D.BranchId = @BranchId)
			AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
			AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
			AND (C.SessionEnd >= @FromDate AND C.SessionEnd <= @ToDate)
		UNION ALL
		SELECT
				'Date' = CONVERT(varchar, C.SessionEnd, 103)
			, Till = D.Name
			, 'User' = CONCAT(A1.FirstName, ' ', A1.LastName)
			, 'UserEod' = CONCAT(A2.FirstName, ' ', A2.LastName)
			, Tender = CD.Tender
			, AmountDeclared = CD.Declared
			, AmountCalculated = CD.Calculated
			, 'Difference' = CD.Calculated - CD.Declared
		FROM tCashiers AS C
		INNER JOIN tCashierDetails AS CD ON C.Id = CD.CashierId
		LEFT JOIN tDevices AS D ON D.Id = C.DeviceId
		LEFT JOIN tAspNetUsers AS A1 ON A1.Id = C.CreatorId
		LEFT JOIN tAspNetUsers AS A2 ON A2.Id = C.EnderId
		LEFT JOIN tBranches AS B ON B.Id = D.BranchId
		WHERE C.Deleted = 0
			AND (@BranchId IS NULL OR D.BranchId = @BranchId)
			AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
			AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
			AND (C.SessionEnd >= @FromDate AND C.SessionEnd <= @ToDate)
	End

---end---


---ProductPriceListReport---
GO
IF OBJECT_ID(N'[dbo].[spRptProductPriceList]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[spRptProductPriceList]
GO

CREATE PROCEDURE [dbo].[spRptProductPriceList]
	@FromDate DATETIME,
	@ToDate DATETIME,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
	@BranchFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
BEGIN
	DECLARE @NOW DateTime = GETDATE()-14  -- Use 14 days ago to cater for sites being closed for a while

	-- Build temporary table with the Primary and Secondary prices
	SELECT
		BranchId,
		ProductId,
		'PriceLevel' =  PriceLevel,
		'FromDate' = ISNULL(IIF(Pfrom>@NOW,Pfrom,PFrom),Pfrom),
		'ToDate' = ISNULL(Pto,Pto),
		'Price' = ISNULL(IIF(pFrom>@NOW,Pprice,Pprice),Pprice)  --- if the from  date of the primary price is older, then use the secondary price
	into #list
	from
	(  -- need to generate a union joined list of all prices and then join together for the branch and product for either secondary or primary price
		select bpm.BranchId,bpm.ProductId,type='SecondaryPrice',PriceLevel=SecondaryPrice.Name,Pfrom=SecondaryPrice.ValidFrom,Pto=SecondaryPrice.ValidTo,Pprice=SecondaryPrice.PriceValue
		from [dbo].Products p
		inner join [dbo].SaleItems si on si.ProductId = p.Id and si.Deleted = 0
		inner join [dbo].BranchProductMaps bpm on bpm.ProductId = p.Id and bpm.Deleted = 0
		inner join [dbo].Branches b on b.id = bpm.BranchId
		inner join 
		(
		select plbm.BranchId,pd.SaleItemId,spl.Name,pdp.ValidFrom,pdp.ValidTo,pdp.PriceValue 
		from  [dbo].ProductDimensions pd
		inner join [dbo].PriceLevels spl on spl.Id = pd.PriceLevelId and spl.PriceLevelOption = 1 and spl.Deleted = 0
		inner join [dbo].ProductDimensionPrices pdp on pdp.ProductDimensionId = pd.Id and pdp.Deleted = 0
		inner join [dbo].PriceLevelBranchMaps plbm on plbm.PriceLevelId = spl.Id
		WHERE  pd.Deleted = 0
		) SecondaryPrice on SecondaryPrice.SaleItemId = si.Id and SecondaryPrice.BranchId = b.Id
	UNION ALL
		select bpm.BranchId,bpm.ProductId,type='PrimaryPrice',PriceLevel=PrimaryPrice.Name,Pfrom=PrimaryPrice.ValidFrom,Pto=PrimaryPrice.ValidTo,Pprice=PrimaryPrice.PriceValue
		from [dbo].Products p
		inner join [dbo].SaleItems si on si.ProductId = p.Id and si.Deleted = 0
		inner join [dbo].BranchProductMaps bpm on bpm.ProductId = p.Id and bpm.Deleted = 0
		inner join [dbo].Branches b on b.id = bpm.BranchId
		inner join 
		(
		Select pplbm.BranchId,ppd.SaleItemId,ppl.Name,fpdp.ValidFrom,fpdp.ValidTo,fpdp.PriceValue 
		from [dbo].ProductDimensions ppd 
		inner join [dbo].ProductDimensionPrices fpdp on fpdp.ProductDimensionId = ppd.Id and fpdp.Deleted = 0
		inner join [dbo].PriceLevels ppl on ppl.Id = ppd.PriceLevelId and ppl.PriceLevelOption = 0  and ppl.Deleted = 0
		inner join [dbo].PriceLevelBranchMaps pplbm on pplbm.PriceLevelId = ppl.Id and pplbm.Deleted = 0
		WHERE  ppd.Deleted = 0
		) PrimaryPrice on PrimaryPrice.SaleItemId = si.Id and PrimaryPrice.BranchId = b.Id
	
	) list
	where (Pto is null or Pto >= @NOW) and (Pto is null or Pto >= @NOW) -- Primary and Secondary current prices which are valid up to yesterday

	-- Now select the current and future prices based on the temp table
	SELECT
		'Branch'					= b.Name,
		'Product'					= p.Name,
		'ProductCode'				= p.Code,
		'SupplierProductCode'		= spm.SupplierProductCode,
		'PriceLevel'				= Clist.PriceLevel,
		'CurrentPrice'				= Clist.Price,
		'FuturePrice'				= Flist.Price,
		'FutureStartDate'			= FORMAT(Flist.FromDate , 'yyyy/MM/dd')
	FROM #list as Clist
	left join #List Flist on Clist.BranchId = Flist.BranchId and Clist.ProductId = Flist.ProductId and (Flist.FromDate > ISNULL(clist.ToDate,@NOW) or Flist.FromDate > @NOW) and ISNULL(Flist.ToDate,'01 jan 2099') > @NOW	
	INNER JOIN [dbo].Branches as b on b.ID = Clist.BranchId
	INNER JOIN [dbo].Products as p on p.ID = Clist.ProductId AND p.deleted = 0
	LEFT JOIN (select * ,ROW_NUMBER() OVER (PARTITION BY ProductId ORDER BY spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
			from [dbo].SupplierProductMaps spm
			where deleted = 0) AS spm ON spm.ProductId = P.ID and spm.rn = 1
	WHERE 1=1
		and Clist.FromDate <= @NOW --and ISNULL(Clist.ToDate,'01 jan 2099') >= getdate()
--		and p.ID ='F4AEA9A3-7A7C-41FF-58C4-ABD7FA360128'
		AND (B.Id = @BranchId OR @BranchId is null)
		AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
        AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
		AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)

	DROP TABLE #list

END
---end---

---ProductCostReport---
GO
IF OBJECT_ID(N'[dbo].[spRptProductCost]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[spRptProductCost]
GO

CREATE PROCEDURE spRptProductCost
	@FromDate DATETIME,
	@ToDate DATETIME,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
	@BranchFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
BEGIN
	DECLARE @ProductTransactions TABLE(ProductId uniqueidentifier, Date Datetime, BranchId uniqueidentifier, Quantity INT)
	INSERT INTO @ProductTransactions
	SELECT 
	'ProductId' = p.Id,
	'Date' = ts.Date,
	'BranchId' = ts.BranchId,
	'Quantity' = td.Quantity
	FROM 
	[dbo].Products as p
	inner join [dbo].TransactionDetails as td on p.Id = td.ProductId
	left join [dbo].Transactions as ts on ts.Id = td.TransactionId 
	WHERE p.Id = td.ProductId and td.Deleted = 0
	
	
	SELECT
		'Branch'									= b.Name,
		'Product'									= p.Name,
		'Date' =  CONVERT(varchar, CONVERT(date, td.Date), 111),
		'Quantity' = SUM(case when td.Quantity is null then 0 else td.Quantity end), 
		'Cost' = pdp.cost,
		'TotalProductCosts' = SUM(case when td.Quantity * pdp.cost is null then 0.00 else td.Quantity * pdp.cost end),
		'TotalSales' = SUM(case when td.Quantity * pdp.PriceValue is null then 0.00 else td.Quantity * pdp.PriceValue end),
		'ProductCode' = p.Code,
		'SupplierProductCode' =  spm.SupplierProductCode,
		'StockHeld' = bp.Quantity,
		'SalesQTY' = SUM(case when td.Quantity is null then 0 else td.Quantity end), 
		'RetailPrice' = pdp.PriceValue
	FROM [dbo].BranchProductMaps as bp
	INNER JOIN [dbo].Branches as b on b.ID = bp.BranchId
	INNER JOIN [dbo].Products as p on p.ID = bp.ProductId AND p.deleted = 0
	LEFT JOIN [dbo].SaleItems as si on si.ProductId = p.id
	LEFT JOIN [dbo].ProductDimensions as pd on pd.SaleItemId = si.id
	left join [dbo].pricelevels as pl on pd.PriceLevelId = pl.id
	LEFT JOIN [dbo].ProductDimensionPrices as pdp on pdp.ProductDimensionId = pd.id
	LEFT JOIN @ProductTransactions as td on p.ID = td.ProductId and td.BranchId = b.Id
	LEFT JOIN [dbo].SupplierProductMaps as spm on spm.ProductId = p.Id and spm.Deleted = 0
	

	WHERE (B.Id = @BranchId OR @BranchId is null) and not (td.Date is null) and (td.Date >= @FromDate and td.Date <=@ToDate)
		  AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
          AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
		  AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)

	GROUP BY b.Name, p.Name, pl.Name,CONVERT(date, td.Date), pdp.cost, pdp.PriceValue, p.Code, spm.SupplierProductCode, bp.Quantity
END
---end---

---TicketDataReport---
GO
IF OBJECT_ID(N'[dbo].[spRptTicketData]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[spRptTicketData]
GO
CREATE PROCEDURE [dbo].[spRptTicketData] 
	-- Add the parameters for the stored procedure here
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@BranchFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 

	'Date' = CONVERT(varchar, Convert(Date,t.date), 111),
	'Branch' = b.Name,
	'TransactionNumber' = IIF(t.SaleNo is null,'',t.SaleNo),
	 'Operator'= CONCAT(Ut.FirstName, ' ', Ut.LastName), 
	 'ProductCode' = td.ProductCode, 
	 'ProductName' = td.Productname, 
	 'PreferredSupplierName' = s.Name, 
	 'SalesQuantity' = td.Quantity,
	 'SalesValue'	= td.Amount,
	'FormFieldName' = IIF(tf.Name is null, '', tf.Name),
	'FormFieldPhoneNumber' = ISNULL(NULLIF(tf.PhoneNumber,''), tf.Name), --IIF(tf.PhoneNumber is null, '', tf.PhoneNumber),
	'FormFieldDateOfEvent' = CONVERT(varchar, Convert(Date,tf.DateOfEvent), 111),
	'FormFieldDayOfEvent' = IIF(tf.DayOfEvent is null, '', tf.DayOfEvent),
	'FormFieldTimeOfEvent' = convert(VARCHAR(5), tf.TimeOfEvent,108),
	'FormFieldLocation' = IIF(tf.Location is null, '', tf.Location),
	'FormFieldAdultTicket' = IIF(tf.AdultTickets is null,0, tf.AdultTickets),
	'FormFieldSeniorCitizenTickets' = IIF(tf.SeniorCitizenTickets is null, 0, tf.SeniorCitizenTickets),
	'FormFieldChildTickets' = IIF(tf.ChildTickets is null, 0, tf.ChildTickets),
	'FormFieldStudentTickets' = IIF(tf.StudentTickets is null, 0, tf.StudentTickets),
	'FormFieldGeneralComment' = IIF(tf.GeneralComments is null, '', tf.GeneralComments),
	'FormFieldIV' = tf.IV,
	'FormFieldKey' = tf.[Key]
	from 
	[dbo].Branches as b
	INNER JOIN [dbo].transactions as t on b.Id = t.BranchId 
	INNER JOIN [dbo].transactiondetails as td on td.TransactionId = t.Id AND ISNULL(td.Voided,0) = 0
	INNER JOIN [dbo].ticketforms as tf on td.id = tf.transactiondetailId
	LEFT JOIN AspNetUsers as ut ON t.CreatorId = ut.Id
	LEFT JOIN (select * ,ROW_NUMBER() OVER (PARTITION BY ProductId ORDER BY spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
			from [dbo].SupplierProductMaps spm
			where deleted = 0) AS spm ON spm.ProductId = td.ProductId and spm.rn = 1
	LEFT JOIN [dbo].Suppliers s on s.Id = spm.SupplierId
	where (b.id = @BranchId or @BranchId is null)
		AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
		AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
		AND (T.Date >= @FromDate AND T.Date <= @ToDate)
		
END
---end---

---DeviceSyncReport---
GO
IF OBJECT_ID(N'[dbo].[spRptDeviceSync]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[spRptDeviceSync]
GO

CREATE PROCEDURE spRptDeviceSync
	@FromDate DATETIME,
	@ToDate DATETIME,
	@BranchId uniqueidentifier,
	@BranchFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select 
		'Branch' = b.name, 
		'DeviceName' = d.Name, 
		'Serial' = d.Serial,
		'LastSODTime' = CONCAT(CONVERT(VARCHAR, max(case when cd.SessionStart is null then null else cd.SessionStart end), 111), ' ', CONVERT(VARCHAR, max(case when cd.SessionStart is null then null else cd.SessionStart end), 108)),
		'LastEODTime' = CONCAT(CONVERT(VARCHAR, max(case when cd.SessionEnd is null then null else cd.SessionEnd end), 111), ' ', CONVERT(VARCHAR, max(case when cd.SessionEnd is null then null else cd.SessionEnd end), 108))
		from [dbo].devices as d
		left join [dbo].branches as b on b.id = d.BranchId 
		left join [dbo].CashierSessions as cd on cd.DeviceId = d.id
		where ((@BranchId is null) or (@BranchId = b.id)) and d.Deleted = 0
			AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
		    AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
		Group by b.name, d.name, d.Serial
		
END
---end---

---spRptSuppliers---
GO
IF OBJECT_ID(N'[dbo].[spRptSuppliers]', N'P') IS NOT NULL
	DROP PROCEDURE [dbo].[spRptSuppliers]
GO

CREATE PROCEDURE spRptSuppliers
	@SupplierFilterId uniqueidentifier
AS
BEGIN
	SELECT
		'SupplierCode'= s.Code,
		'SupplierName'= s.Name,
		'EmailAddress' = s.EmailAddress,
		'Address' = s.Address,
		'PostCode' = s.PostCode,
		'ContactName' = IIF(s.ContactName is NULL,'',s.ContactName),
		'PhoneNumber' = s.PhoneNumber,
		'ApproveRequired' = IIF(s.ApprovalRequired = 1,'true','false'),
		'LeadDays' = s.LeadDays,
		'MinimumOrderValue' = s.MinimumOrderValue,
		'MaximumOrderValue' = s.MaxValue,
		'MinimumValue' = s.MinValue,
		'CarriageCharge' = s.CarriageChargeValue,
		'Active' = s.Active,
		'CreatedBy' = IIF(cu.Email is NULL,'',cu.Email),
		'CreatedDate' = CONVERT(varchar, s.CreatedDate, 111),
		'UpdatedBy' = IIF(uu.Email is NULL,'',uu.Email),
		'UpdatedDate' = CONVERT(varchar, s.UpdatedDate, 111)

	FROM [dbo].Suppliers as s
	LEFT JOIN [dbo].AspNetUsers as cu on s.CreatedBy = cu.Id
	LEFT JOIN [dbo].AspNetUsers as uu on s.UpdatedBy = uu.Id
	WHERE (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
	
END
---end---

---ItemMovementReport---
GO
IF OBJECT_ID(N'[dbo].[GetItemMovementReport]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetItemMovementReport]
GO

CREATE PROCEDURE [dbo].[GetItemMovementReport]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
	@BranchFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier,
	@SupplierFilterId uniqueidentifier
AS
	SELECT
		  BranchCode = B.Code
		, BranchName = B.Name
		, ProductCode = P.Code
		, ProductName = P.Name
		, MovementType =
			CASE
				WHEN H.MovementType = 1 THEN 'Sale'
				WHEN H.MovementType = 2 THEN 'Adjustment'
				WHEN H.MovementType = 3 THEN 'Transfer Out'
				WHEN H.MovementType = 4 THEN 'StockCount'
				WHEN H.MovementType = 5 THEN 'Refund'
				WHEN H.MovementType = 6 THEN 'Delivery'
				WHEN H.MovementType = 7 THEN 'Transfer In'
			END
		, BeforeQTY = ISNULL(NULLIF(H.StockOnHand,0),H.CurrentQTY)--H.CurrentQTY
		, UnitCost = H.Cost
		, LastDeliveryCost = H.LastDeliveryCost
		, Date = CONVERT(varchar, H.CreatedDate, 111)
		, 'Time' = CONVERT(varchar, H.CreatedDate, 108)
		, CreatedBy = H.NameCreate
		, LastUpdate = CONVERT(varchar, H.UpdatedDate, 111)
		, LastUpdateBy = H.NameCreate
		, AdjustmentQuantity = H.AdjustmentQTY
		, TransferDestination = IIF(B1.Name IS NULL, '', B1.Name)
		, AfterQTY = ISNULL(NULLIF(H.StockOnHand,0),H.CurrentQTY) + H.AdjustmentQTY
		, MovementNo =
			CASE
				WHEN H.MovementType = 1 THEN cast(TR.SaleNo as varchar(36))
				WHEN H.MovementType = 2 THEN cast(ad.Id as varchar(8))
				WHEN H.MovementType = 3 THEN cast(TD.TransferId as varchar(8))
				WHEN H.MovementType = 4 THEN cast(SC.Id as varchar(8))
				WHEN H.MovementType = 5 THEN cast(TR.SaleNo as varchar(36))
				WHEN H.MovementType = 6 THEN cast(O.Id as varchar(8))
			END
		, Suppliername = IIF(S.Name IS NOT NULL, S.Name, '')
	FROM [dbo].StockMovementHistories AS H
	LEFT JOIN [dbo].Adjustments ad on cast(ad.Uid as varchar(36)) = h.MovementId and MovementType = 2
	LEFT JOIN [dbo].Reasons ar on ar.Id = ad.ReasonId
	LEFT JOIN [dbo].Branches AS B ON B.Id = H.BranchId
	LEFT JOIN [dbo].Branches AS B1 ON B1.Id = H.TransferDestination
	LEFT JOIN [dbo].Products AS P ON P.Id = H.ProductId
	LEFT JOIN [dbo].Transactions AS TR ON cast(TR.Id as varchar(36)) = h.MovementId and MovementType in (1, 5)
	LEFT JOIN [dbo].TransferDetails AS TD ON cast(TD.Id as varchar(36)) = h.MovementId and MovementType = 3
	LEFT JOIN [dbo].StockCounts AS SC ON cast(SC.Uid as varchar(36)) = h.MovementId and MovementType = 4
	LEFT JOIN [dbo].Orders AS O ON cast(O.Uid as varchar(36)) = h.MovementId and MovementType = 6
	LEFT JOIN (select SupplierId, ProductId, SupplierProductCode,Cost,Active ,ROW_NUMBER() OVER (PARTITION BY Productid ORDER BY Productid,spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
				from [dbo].SupplierProductMaps spm
				where deleted = 0) AS spm ON spm.ProductId = P.ID and rn = 1
	LEFT JOIN [dbo].Suppliers AS S ON S.Id = SPM.SupplierId
	WHERE (@BranchId IS NULL OR H.BranchId = @BranchId OR H.TransferDestination = @BranchId) AND B.Deleted = 0
		AND (@BranchFilterId IS NULL OR H.BranchId = @BranchFilterId OR H.TransferDestination = @BranchFilterId)
		AND (@ProductFilterId IS NULL OR H.ProductId = @ProductFilterId)
		AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
		AND (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
		AND (H.CreatedDate >= @FromDate AND H.CreatedDate <= @ToDate)
	ORDER BY BranchName, ProductName
---end---

---GetHistoricalStockHoldingReport---
GO
IF OBJECT_ID(N'[dbo].[GetHistoricalStockHoldingReport]', N'P') IS NOT NULL
	DROP PROCEDURE [dbo].[GetHistoricalStockHoldingReport]
GO

CREATE PROCEDURE [dbo].[GetHistoricalStockHoldingReport]
	@FromDate DATE,
	@ToDate DATE,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
    @BranchFilterId uniqueidentifier,
    @SupplierFilterId uniqueidentifier,
    @BranchGroupFilterId uniqueidentifier
AS
BEGIN	

		SELECT

		'Branch'						= b.Name,
		'BranchCode'					= b.code,
		'SupplierCode'					= IIF(s.code IS NOT NULL, s.code, ''),
		'SupplierName'					= IIF(s.name IS NOT NULL, s.name, ''),
		'ProductCode'					= p.Code,
		'Product'						= p.Name,
		'StockQuantityOnHand'			= bp.Quantity ,
		'StockValuation'				= cast(bp.Quantity*ISNULL(spm.cost/ISNULL(NULLIF(spm.Packsize,0),1),min(pdp.Cost)) AS DECIMAL(12,2)),
		'Cost'							= ISNULL(spm.cost/ISNULL(NULLIF(spm.Packsize,0),1),MIN(pdp.Cost)),
		'CreatedDate'					= CONVERT(varchar, CAST(bp.CreatedDate as date), 111)

	FROM [dbo].HistoricalStockHoldings AS bp
		INNER JOIN [dbo].Branches AS b ON b.ID = bp.BranchId
		INNER JOIN [dbo].Products AS p ON p.ID = bp.ProductId AND p.deleted = 0
		INNER JOIN [dbo].StockItems AS st ON st.ProductId = p.Id and st.Deleted = 0
		LEFT JOIN [dbo].SaleItems AS si ON si.ProductId = p.id
		LEFT JOIN [dbo].ProductDimensions AS pd ON pd.SaleItemId = si.id
		LEFT JOIN [dbo].ProductDimensionPrices AS pdp ON pdp.ProductDimensionId = pd.id
		LEFT JOIN (select SupplierId,ProductId,PackSize,Cost,Active,ROW_NUMBER() OVER (PARTITION BY ProductId ORDER BY spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
					from [dbo].SupplierProductMaps spm
					where deleted = 0) AS spm ON spm.ProductId = P.ID AND rn = 1
		LEFT JOIN [dbo].suppliers AS s ON s.ID = spm.SupplierId
	WHERE (
			(B.Id = @BranchId OR @BranchId is null)
			AND 
			(CAST(bp.CreatedDate AS DATE) >= @FromDate AND Cast(bp.CreatedDate AS DATE) <= @ToDate)
		   )
			AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
			AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
			AND (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
			AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)


	GROUP BY b.Name, b.code, s.code, s.name, p.code, p.Name, CAST(bp.CreatedDate AS DATE), bp.Quantity, bp.Cost,spm.Cost,spm.PackSize
	ORDER BY CAST(bp.CreatedDate AS DATE) DESC
END
---end---

-- Audit Report --
GO
IF OBJECT_ID(N'[dbo].[GetAuditReport]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetAuditReport]
GO

CREATE PROCEDURE [dbo].[GetAuditReport]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier
AS
BEGIN
	SELECT
		  EditDate = CONVERT(varchar, L.CreatedDate, 111)
		, EditTime = CONVERT(varchar, L.CreatedDate, 108)
		, Module = CASE 
					WHEN CHARINDEX('/', L.RequestURL, 6) > 6 
						THEN SUBSTRING(L.RequestURL, 6, CHARINDEX('/', L.RequestURL, 6) - 6)
					ELSE SUBSTRING(L.RequestURL, 6, LEN(L.RequestURL) - 5)
				   END
		, RequestMethod = L.RequestMethod
		, RequestUrl = L.RequestURL
		, Field = L.RequestContentBody
		, 'User' = CONCAT(U.FirstName, ' ', U.LastName)
		, IsShow = CAST(0 as bit)
	FROM [dbo].Logs AS L
	LEFT JOIN AspNetUsers AS U ON L.CreatedBy = U.Id
	WHERE (L.ResponseStatusCode = 200 AND L.RequestMethod IN ('POST', 'PUT', 'DELETE'))
		AND (L.CreatedDate >= @FromDate AND L.CreatedDate <= @ToDate)
		AND (@BranchId IS NULL OR L.BranchId = @BranchId)
	ORDER BY L.Id DESC
END
---end---

---NoSaleReasonReport---
GO
IF OBJECT_ID(N'[dbo].[GetNoSaleReport]', N'P') IS NOT NULL
	DROP PROCEDURE [dbo].[GetNoSaleReport]
GO

CREATE PROCEDURE [dbo].[GetNoSaleReport]
	@FromDate DATETIME,
	@ToDate DATETIME,
	@BranchId uniqueidentifier,
	@BranchFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
BEGIN
	SELECT
		'Date' = CONVERT(varchar, NS.Date, 111),
		'Time' = CONVERT(varchar, NS.Date, 108),
		'BranchName' = B.Name,
		'DeviceSerial' = D.Serial,
		'UserName' = NS.UserName,
		'NoSaleReasonName' = NS.NoSaleReasonName,
		'NoSaleReasonCode' = NS.NoSaleReasonCode

	FROM 
		[dbo].NoSaleReasons as NS
		INNER JOIN [dbo].Devices as D on D.Id = NS.DeviceId
		INNER JOIN [dbo].Branches as B on B.Id= D.BranchId

	WHERE ((NS.Date >= @FromDate AND NS.Date <= @ToDate)
			AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
			AND (@BranchId IS NULL OR D.BranchId = @BranchId))
			AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)

	ORDER BY 
		CAST( NS.Date AS DATE) DESC
	
END
---end---

---ExportSalesToSAP---

--USE [CADW-STOCK]

begin tran newrep
GO

/****** Object:  Synonym [dbo].[tTickets]    Script Date: 07/02/2023 16:49:16 ******/
IF OBJECT_ID(N'[dbo].[tTransactions]', N'SN') IS NULL CREATE SYNONYM [dbo].[tTransactions] FOR [CADW-STOCK-Ticketing].[tickets].[Transactions]
GO

/****** Object:  Synonym [dbo].[tTickets]    Script Date: 07/02/2023 16:49:16 ******/
IF OBJECT_ID(N'[dbo].[tTransactionDetails]', N'SN') IS NULL CREATE SYNONYM [dbo].[tTransactionDetails] FOR [CADW-STOCK-Ticketing].[tickets].[TransactionDetails]
GO


-- added rows in SAP_MAPPING and Sites table - need to know which branch should be used and if need to break down between back office and web

insert into SAP_Mapping
values ('WAREHOUSE',	'WAREHOUSE',	'ADMISSIONS',	'30014684',	'402010',	'D1',	'XJ80'	,'X.J44.RETAILVAT')
insert into SAP_Mapping
values ('ONLINEBRANCH',	'ONLINEBRANCH',	'ADMISSIONS',	'30014684',	'402010',	'D1',	'XJ80',	'X.J44.RETAILVAT')
insert into sites
values ('XJ80',	'OnlineBranch',	'ONLINEBRANCH',	'ONLINE')



GO
/****** Object:  StoredProcedure [dbo].[ExportSalesToSAP]    Script Date: 13/02/2023 15:59:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  OR ALTER   PROCEDURE [dbo].[ExportSalesToSAP]
@selectedDate DateTime
AS
BEGIN
    IF (@selectedDate is null or datepart(d,@selectedDate) <7)
begin
            set @selectedDate = GETDATE() -7
end
    DECLARE @FromDate DateTime = DATEADD(DAY, 1, EOMONTH(@selectedDate, -1))
    DECLARE @ToDate DateTime = DATEADD(DAY, 1, EOMONTH(@selectedDate))

SELECT
        X = IIF(ROW_NUMBER() OVER (PARTITION BY CostCentre ORDER BY CustomerNumber ASC) = 1, 'X', '') -- Used to dtermine the first line of each Branch
     , CompanyCode
     , DocType
     , DocumentDate
     , PostingDate
     , ReferenceDocument
     , HeaderText
     , Currency
     , CustomerNumber
     , NetAmount = SUM(NetAmount)
     , TaxAmount = SUM(TaxAmount)
     , TaxCode
     , GLAccount
     , CostCentre
     , ProfitCentre
     , WBSElement
     , NotesLineText
     , Assignment
     , RefKey3
     , Taxdate
FROM
    (
        SELECT
                X = ''
             , CompanyCode = '1000'
             , DocType = 'DR'
             , DocumentDate = CONVERT(NVARCHAR, EOMONTH(@selectedDate), 104)
             , PostingDate = CONVERT(NVARCHAR, EOMONTH(@selectedDate), 104)
             , ReferenceDocument = SUBSTRING(CONCAT('MMR', UPPER(REPLACE(SUBSTRING(CONVERT(NVARCHAR, EOMONTH(@selectedDate), 113), 4, 8), ' ', '')), SI.SAP_Short), 1, 16)
             , HeaderText = SUBSTRING('Cadw Retail:', 0, 25)
             , Currency = 'GBP'
             , CustomerNumber = ISNULL(SM.CUST_NO,'Missing Mapping for site '+ISNULL(NULLIF(SI.SAP_SiteName,''),'Branch: '+ISNULL(s.BranchName,'no branch found'))+' and Type '+ISNULL(DM.SAP_Dept,'Dept: '+ISNULL(s.Type,'no type')))
             , NetAmount = round((-1) * IIF(SM.Tax = 'D1', S.NetAmount, S.NetAmount + S.TaxAmount),2)
             , TaxAmount = round((-1) * IIF(SM.Tax = 'D1', S.NetAmount * 0.2, 0),2)
             , TaxCode = SM.TAX
             , GLAccount = SM.NOMINAL
             , CostCentre = SI.[Site]
             , ProfitCentre = SI.[Site]
             , WBSElement = SM.WBS
             , NotesLineText = SUBSTRING(CONCAT(SI.Name, ' MMR ', SUBSTRING(CONVERT(NVARCHAR, EOMONTH(@selectedDate), 113), 4, 8), ' ', SM.TYPE), 1, 50)
             , Assignment = ''
             , RefKey3 = SUBSTRING(CONCAT('MMR ', SI.[Site], ' ', SUBSTRING(CONVERT(NVARCHAR, EOMONTH(@selectedDate), 113), 4, 8)), 1, 20)
             , Taxdate = CONVERT(NVARCHAR, EOMONTH(@selectedDate), 104)
        FROM
            (
                SELECT
                        Type=ISNULL(NULLIF(P.[Type],''),p.code)
                     , T.BranchName
                     , NetAmount = CAST(SUM(D.Amount-D.Tax) AS float)
                     , TaxAmount = SUM(D.Tax)
                FROM TransactionDetails AS D
                         LEFT JOIN Products AS P ON D.ProductId = P.Id
                         LEFT JOIN Transactions AS T ON T.Id = D.TransactionId
                WHERE T.[Date] >= @FromDate AND T.[Date] < @ToDate AND D.Voided = 0
                GROUP BY T.BranchName, ISNULL(NULLIF(P.[Type],''),p.code)
            ) AS S
                LEFT JOIN Dept_Map AS DM ON DM.SD_Dept = S.[Type]
                LEFT JOIN Sites AS SI ON SI.Name = S.BranchName
                LEFT JOIN SAP_Mapping AS SM ON SM.MONUMENT = SI.SAP_SiteName AND SM.[TYPE] = DM.SAP_Dept
                LEFT JOIN Branches b ON b.Name = s.BranchName
        WHERE (S.NetAmount <> 0 OR S.TaxAmount <> 0)
          AND b.Code !=  'HO'

        UNION ALL

        select
            X				= '', --IIF(ROW_NUMBER() OVER (PARTITION BY SI.[Site] ORDER BY SM.Type ASC) = 1, 'X', ''),
            CompanyCode      = '1000',
            DocType          = 'DR',
            DocumentDate		= CONVERT(NVARCHAR, EOMONTH(@selectedDate), 104),
            PostingDate		= CONVERT(NVARCHAR, EOMONTH(@selectedDate), 104),
            ReferenceDocument = SUBSTRING(CONCAT('MMR', UPPER(REPLACE(SUBSTRING(CONVERT(NVARCHAR, EOMONTH(@selectedDate), 113), 4, 8), ' ', '')), SI.SAP_Short), 1, 16),
            HeaderText        = SUBSTRING('Cadw Retail:', 0, 25),
            Currency          = 'GBP',
            CustomerNumber    = ISNULL(SM.CUST_NO,'Missing Mapping for site '+ISNULL(NULLIF(SI.SAP_SiteName,''),'Branch: '+ISNULL(s.BranchName,'no branch found'))+' and Type '+ISNULL(DM.SAP_Dept,'Dept: '+ISNULL(s.Type,'no type'))),
            NetAmount         = round((-1) * IIF(SM.Tax = 'D1', S.NetAmount, S.NetAmount + S.TaxAmount),2),
            TaxAmount         = round((-1) * IIF(SM.Tax = 'D1', S.NetAmount * 0.2, 0),2),
            TaxCode           = SM.TAX,
            GLAccount         = SM.NOMINAL,
            CostCentre        = SI.[Site],
            ProfitCentre      = SI.[Site],
            WBSElement        = SM.WBS,
            Notes             = SUBSTRING(CONCAT(SI.Name, ' MMR ', SUBSTRING(CONVERT(NVARCHAR, EOMONTH(@selectedDate), 113), 4, 8), ' ', SM.TYPE), 1, 50),
            Assignment        = '',
            RefKey3           = SUBSTRING(CONCAT('MMR ', SI.[Site], ' ', SUBSTRING(CONVERT(NVARCHAR, EOMONTH(@selectedDate), 113), 4, 8)), 1, 20),
            TaxDate           = CONVERT(NVARCHAR, EOMONTH(@selectedDate), 104)
        from (select
            BranchName=ISNULL(NULLIF(T.BranchName,''),'ONLINEBRANCH'),
            [Type]='Admissions',
            NetAmount = SUM(IIF(b.Status=3,0,(TD.Amount-Td.Tax))),
            TaxAmount  = SUM(IIF(B.Status=3,0,Td.Tax))
            from tTransactionDetails TD
            INNER JOIN tTransactions T on TD.TransactionId = T.Id and T.Deleted = 0
            LEFT JOIN tBookingDetails BD on TD.Id = BD.TransactionDetailId and BD.Deleted = 0
            LEFT JOIN tBookings B on BD.BookingId = B.Id and B.Deleted = 0
            where TD.Deleted = 0
            and T.[Date] >= @FromDate AND T.[Date] < @ToDate
            group by T.BranchName
            having (SUM(IIF(b.Status=3,0,(TD.Amount-Td.Tax))) <> 0 and SUM(IIF(B.Status=3,0,Td.Tax)) <> 0)
            ) as S
            left join mSites SI on SI.Name = S.BranchName
            left join mSAP_Mapping SM on SM.MONUMENT = SI.SAP_SiteName AND SM.TYPE = S.Type
            LEFT JOIN Dept_Map AS DM ON DM.SD_Dept = S.[Type]
    ) data
GROUP BY
    X
       , CompanyCode
       , DocType
       , DocumentDate
       , PostingDate
       , ReferenceDocument
       , HeaderText
       , Currency
       , CustomerNumber
       , TaxCode
       , GLAccount
       , CostCentre
       , ProfitCentre
       , WBSElement
       , NotesLineText
       , Assignment
       , RefKey3
       , Taxdate

END
go

exec [dbo].[ExportSalesToSAP]
	@selectedDate = '09 feb 2023'

commit tran newrep

---end---
---StockValuationReport---
CREATE OR ALTER PROCEDURE [dbo].[StockValuationReport]
	@FromDate DATE,
	@ToDate DATE,
	@BranchId uniqueidentifier,
    @BranchFilterId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
    @SupplierFilterId uniqueidentifier,
    @BranchGroupFilterId uniqueidentifier,
    @ProductGroupFilterId uniqueidentifier,
    @ProductSubGroupFilterId uniqueidentifier
AS
BEGIN
	SELECT 
		'Branch' = b.Name, 
		'SupplierCode' = IIF(s.CODE IS NOT NULL, s.CODE, ''),
		'SupplierName' = IIF(s.NAME IS NOT NULL, s.NAME, ''),
		'OrderPO' = IIF(o.Id IS NOT NULL, Cast( o.Id as varchar(20)) , ''),
		'OrderDate' = IIF( o.CreatedDate IS NOT NULL, CONVERT(varchar, CAST(o.CreatedDate as date), 111), ''),
		'DeliveryDate' = CONVERT(varchar, CAST(sv.CreatedDate as date), 111),
		'ProductCode' = p.Code,
		'ProductName' = p.Name, 
		'ItemCost' = sv.Unitcost, --Round(IIF(sv.PackSize = 0, sv.CostPrice, sv.CostPrice/sv.PackSize), 2),
		'DeliveredQTY' = sv.DeliveryQuantity,
		'IssuedQTY' = sv.IssuedQuantity,
		'RemainingQTY' = sv.RemainingQuantity,			
		'StockValuation'  = sv.Unitcost * sv.RemainingQuantity --IIF(sv.PackSize = 0, sv.CostPrice, sv.CostPrice/sv.PackSize) * sv.RemainingQuantity
	FROM
		[dbo].StockValuations AS sv
		INNER JOIN [dbo].Branches AS b ON sv.BranchId = b.Id AND b.Deleted = 0
		INNER JOIN [dbo].Products AS p ON sv.ProductId = p.Id AND p.Deleted = 0 --AND p.IsStockItem = 1
		INNER JOIN [dbo].StockItems si on si.ProductID = p.Id and si.Deleted = 0
		LEFT JOIN [dbo].ProductGroups pg on pg.Id = p.ProductGroupId
		LEFT JOIN [dbo].Orders as o ON Cast(O.Id as varchar(20)) = sv.DeliveryId AND o.Deleted = 0
		LEFT JOIN (select SupplierId,ProductId,PackSize,Cost,Active,ROW_NUMBER() OVER (PARTITION BY Productid ORDER BY Productid,spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
					from [dbo].SupplierProductMaps spm
					where deleted = 0) AS spm ON spm.ProductId = P.ID and rn = 1
		LEFT JOIN [dbo].Suppliers AS S ON S.ID = spm.SupplierId AND s.Deleted = 0
	WHERE 1=1
		AND sv.Deleted = 0
		AND pg.Name NOT IN ('TI TICKETS','SE SERVICES')
		AND (@BranchId IS NULL OR b.Id = @BranchId)
		AND (@BranchFilterId IS NULL OR b.Id = @BranchFilterId)
		-- AND (@FromDate IS NULL OR (Cast(@FromDate as Date) <= Cast(sv.CreatedDate as Date)))
		-- AND (@ToDate IS NULL OR (Cast(@ToDate as date) >= Cast(sv.CreatedDate as Date)))
		AND (@ProductFilterId IS NULL OR p.Id = @ProductFilterId)
		AND (@SupplierFilterId IS NULL OR s.Id = @SupplierFilterId)
		AND (@BranchGroupFilterId IS NULL OR b.BranchGroupId = @BranchGroupFilterId)
        AND (@ProductGroupFilterId IS NULL OR p.ProductGroupId = @ProductGroupFilterId)
        AND (@ProductSubGroupFilterId IS NULL OR p.ProductGroupPath like concat('%', convert(nvarchar(36), @ProductSubGroupFilterId)))
	ORDER BY sv.CreatedDate desc
END
---End StockValuationReport---

---spRptStockCounts---
GO
IF OBJECT_ID(N'[dbo].[spRptStockCounts]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[spRptStockCounts]
GO

CREATE PROCEDURE [dbo].[spRptStockCounts]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
	@SupplierFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS

SELECT 

	'DateCounted'	= CONVERT(varchar, CAST(sc.CreatedDate as date), 111),
	'DateApproved'	= CONVERT(varchar, CAST(sc.UpdatedDate as date), 111),
	'CountNumber'	= sc.Id,
	'Location'		= b.Name,
	'CountStatus'	= 
						CASE
								WHEN sc.Status = 0 THEN 'Counting'
								WHEN sc.Status = 1 THEN 'Awaiting Appoval'
								WHEN sc.Status = 2 THEN 'Recount Required'
								WHEN sc.Status = 3 THEN 'Rejected'
								WHEN sc.Status = 4 THEN 'Confirmed'
								WHEN sc.Status = 5 THEN 'Canceled'
						END,
	'CountType' = 
						CASE
								WHEN sc.CountType = 0 THEN 'All Stock Count'
								WHEN sc.CountType = 1 THEN 'Group Count'
								WHEN sc.CountType = 2 THEN 'Individual Item Count'
						END,
	'CountedUser'	= CONCAT(uc.FirstName, ' ', uc.LastName),
	'ApprovedUser'	= CONCAT(uu.FirstName, ' ', uu.LastName),
	'ProductCode'	= scd.ProductCode,
	'SupplierCode'	= scd.SupplierCode,
	'SupplierName'	= scd.SupplierName,
	'ProductGroup'	= scd.ProductGroupName,
	'ProductName'	= scd.ProductName,
	'Cost'			= cast(scd.Cost as decimal(11,4)),
	'ExpectedQTY'	= cast(scd.Expected as float),
	'CountedQTY'	= cast(scd.Quantity as float),
	'ApprovedQTY'	= cast(scd.ApprovedQuantity as float),
	'QTYVariance'	= cast(IIF(scd.ApprovedQuantity IS NOT NULL, scd.ApprovedQuantity - scd.Expected, 0 - scd.Expected) as float),
	'CostVariance'	= CAST(IIF(scd.ApprovedQuantity IS NOT NULL, scd.Cost * (scd.ApprovedQuantity - scd.Expected), scd.Cost * (0 - scd.Expected)) as float),
	'Comments'		= IIF(scd.Comment IS NOT NULL, scd.Comment, '')

  FROM StockCounts as sc
  INNER JOIN (
			  select scd.StockCountId,scd.Comment,scd.Productid,scd.ProductCode,scd.ProductName,scd.SupplierCode,scd.SupplierName,scd.ProductGroupName,scd.Expected,scd.Quantity,scd.ApprovedQuantity,Cost=cast(ISNULL((sum(h.AdjustmentQTY*h.cost))/sum(h.AdjustmentQTY),sum(scd.Cost)) as float)
			  FROM StockCountDetails scd
			  LEFT JOIN StockMovementHistories h on h.MovementDetailId = scd.Id and h.MovementType = 4
			  WHERE scd.Edited = 1
			  group by scd.StockCountId,scd.Comment,scd.Productid,scd.ProductCode,scd.ProductName,scd.SupplierCode,scd.SupplierName,scd.ProductGroupName,scd.Expected,scd.Quantity,scd.ApprovedQuantity
			)
  as scd on scd.StockCountId = sc.Id
  INNER JOIN Branches as b on b.Id = sc.BranchId
  INNER JOIN AspNetUsers as uc on uc.Id = sc.CreatedBy
  LEFT JOIN AspNetUsers as uu on uu.Id = sc.UpdatedBy

  WHERE sc.CreatedDate >= @FromDate AND sc.CreatedDate <= @ToDate
		AND (@BranchId IS NULL OR b.Id = @BranchId)
		AND (@ProductFilterId IS NULL OR scd.ProductId = @ProductFilterId)
        --AND (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
		AND (@BranchGroupFilterId IS NULL OR b.BranchGroupId = @BranchGroupFilterId)
		ORDER BY sc.CreatedDate DESC	
---end---

---HistoricalStockValuationReport---
GO
IF OBJECT_ID(N'[dbo].[HistoricalStockValuationReport]', N'P') IS NOT NULL
	DROP PROCEDURE [dbo].[HistoricalStockValuationReport]
GO

CREATE PROCEDURE [dbo].[HistoricalStockValuationReport]
	@FromDate DATE,
	@ToDate DATE,
	@BranchId uniqueidentifier,
    @BranchFilterId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
    @SupplierFilterId uniqueidentifier,
    @BranchGroupFilterId uniqueidentifier
AS
BEGIN
	SELECT 
		'Branch' = b.Name, 
		'SupplierCode' = IIF(s.CODE IS NOT NULL, s.CODE, ''),
		'SupplierName' = IIF(s.NAME IS NOT NULL, s.NAME, ''),
		'OrderPO' = IIF(o.Id IS NOT NULL, Cast( o.Id as varchar(20)) , ''),
		'OrderDate' = IIF( o.CreatedDate IS NOT NULL, CONVERT(varchar, CAST(o.CreatedDate as date), 111), ''),
		'DeliveryDate' = CONVERT(varchar, CAST(sv.CreatedDate as date), 111),
		'ProductCode' = p.Code,
		'ProductName' = p.Name, 
		'ItemCost' = IIF(sv.PackSize = 0, sv.CostPrice, sv.CostPrice/sv.PackSize),
		'DeliveredQTY' = sv.DeliveryQuantity,
		'IssuedQTY' = sv.IssuedQuantity,
		'RemainingQTY' = sv.RemainingQuantity,			
		'StockValuation'  = IIF(sv.PackSize = 0, sv.CostPrice, sv.CostPrice/sv.PackSize) * sv.RemainingQuantity
	FROM
		[dbo].BranchProductMaps AS bpm 
		INNER JOIN [dbo].Branches AS b ON bpm.BranchId = b.Id AND b.Deleted = 0
		INNER JOIN [dbo].Products AS p ON bpm.ProductId = p.Id AND p.Deleted = 0
		INNER JOIN [dbo].StockItems si on si.ProductID = p.Id and si.Deleted = 0
		INNER JOIN [dbo].StockValuationsHistorys AS sv ON bpm.BranchId = sv.BranchId AND bpm.ProductId = sv.ProductId AND sv.Deleted = 0
		LEFT JOIN [dbo].Orders as o ON Cast(O.Id as varchar(20)) = sv.DeliveryId AND o.Deleted = 0
		LEFT JOIN (select SupplierId,ProductId,PackSize,Cost,Active,ROW_NUMBER() OVER (PARTITION BY Productid ORDER BY Productid,spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
					from [dbo].SupplierProductMaps spm
					where deleted = 0) AS spm ON spm.ProductId = P.ID and rn = 1
		LEFT JOIN [dbo].Suppliers AS S ON S.ID = spm.SupplierId AND s.Deleted = 0
	WHERE 
		bpm.Deleted = 0
		AND (@BranchId IS NULL OR b.Id = @BranchId)
		AND (@BranchFilterId IS NULL OR b.Id = @BranchFilterId)
		AND (@FromDate IS NULL OR (Cast(@FromDate as Date) <= Cast(sv.BackupDate as Date)))
		AND (@ToDate IS NULL OR (Cast(@ToDate as date) >= Cast(sv.BackupDate as Date)))
		AND (@ProductFilterId IS NULL OR p.Id = @ProductFilterId)
		AND (@SupplierFilterId IS NULL OR s.Id = @SupplierFilterId)
		AND (@BranchGroupFilterId IS NULL OR b.BranchGroupId = @BranchGroupFilterId)
	ORDER BY sv.CreatedDate desc
END
---End HistoricalStockValuationReport---

---spRptNegativeStockSales---
GO
IF OBJECT_ID(N'[dbo].[spRptNegativeStockSales]', N'P') IS NOT NULL
	DROP PROCEDURE [dbo].[spRptNegativeStockSales]
GO

CREATE PROCEDURE [dbo].[spRptNegativeStockSales]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
    @BranchFilterId uniqueidentifier,
    @SupplierFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
BEGIN	
	DECLARE @HOBranch int;		
	SET @HOBranch = (SELECT count(b.id)
	FROM
		[dbo].Branches b
	WHERE b.Id = @BranchId AND b.Code = 'HO')

   SELECT
		BranchCode = IIF(T.BranchCode IS NOT NULL, T.BranchCode, ''),
		BranchName = B.[Name],
		Device = t.DeviceSerial,
		[User] = t.CreatorName,
		[Date] = CONVERT(varchar, T.[Date], 111),
		[Time] = CONVERT(varchar, T.[Date], 108),
		SaleType = (CASE
						WHEN T.Type = 0 THEN 'Sale'
						WHEN T.Type = 1 THEN 'Refund'
						WHEN T.Type = 2 THEN 'Open Refund'
					END),
		SupplierCode = IIF(s.code IS NOT NULL, s.code, ''),
		SupplierName = IIF(s.[Name] IS NOT NULL, s.[Name], ''),
		ReOrderNumber = spm.SupplierProductCode,
		ProductGroupName = td.ProductGroupName,
		ProductCode = p.Code,
		ProductName = TD.ProductName,
		TaxRate = TD.TaxRate,
		Barcode = p.Barcode,
		ReceiptNo = T.SaleNo,
		DiscountReason = IIF(TD.DiscountReason IS NOT NULL, TD.DiscountReason, ''),
		RefundReason = IIF(T.RefundReason IS NOT NULL, T.RefundReason, ''),
		StockOnHand = h.CurrentQty,
		Quantity = TD.Quantity,
		Total = TD.Amount,
		Vat = TD.Tax,
		NetPrice = (td.amount - td.Tax),--temp. fix (TD.NetPrice),
		ProductCost = TD.ProductCost,
		DiscountAmount = TD.Discount,
		Commission = p.commission
	FROM [dbo].StockMovementHistories h 
			INNER JOIN [dbo].Transactions AS T ON cast(t.Id as varchar(36)) = h.MovementId
			INNER JOIN [dbo].TransactionDetails AS TD ON TD.TransactionId = T.Id AND h.ProductId = TD.ProductId
			LEFT JOIN [dbo].Branches AS B ON B.Id = T.BranchId
			LEFT JOIN [dbo].SupplierProductMaps as spm ON spm.ProductId = td.ProductId
			LEFT JOIN [dbo].Suppliers as s on s.ID = spm.SupplierId
			LEFT JOIN [dbo].Products as p ON p.ID = td.ProductId

	WHERE T.[Date] >= @FromDate AND T.Date <= @ToDate
		  AND (@BranchId IS NULL OR @HOBranch > 0 OR B.Id = @BranchId)
		  AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
          AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
          AND (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
		  AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
		  AND h.CurrentQTY <= 0
	ORDER BY T.SaleNo DESC
END
---end---

---spRptProductProfitability---
GO
IF OBJECT_ID(N'[dbo].[spRptProductProfitability]', N'P') IS NOT NULL
	DROP PROCEDURE [dbo].[spRptProductProfitability]
GO

CREATE PROCEDURE [dbo].[spRptProductProfitability]
	@FromDate DATETIME,
	@ToDate DATETIME,
	@BranchId uniqueidentifier,
	@BranchFilterId uniqueidentifier
AS
BEGIN
	DECLARE @NOW DateTime = GETDATE()
	SELECT DISTINCT
		'Branch'				= b.Name,
		'Supplier'				= s.Name,
		'ProductCode'			= p.Code,
		'Product'				= p.Name,
		'ProductCost'			= pdp.Cost,
		'TaxRate'				= t.EatIn,
		'PriceLevel'			= pl.Name,
		'RetailPrice'			= IIF(pdp.ValidFrom < @NOW and pdp.ValidTo > @NOW, pdp.PriceValue, 0.00)
	FROM [dbo].BranchProductMaps as bp
	INNER JOIN [dbo].Branches as b on b.ID = bp.BranchId
	INNER JOIN [dbo].Products as p on p.ID = bp.ProductId AND p.deleted = 0
	LEFT JOIN [dbo].SaleItems as si on si.ProductId = p.id and si.Deleted = 0
	LEFT JOIN [dbo].ProductDimensions as pd on pd.SaleItemId = si.id and pd.Deleted = 0
	left join [dbo].pricelevels as pl on pd.PriceLevelId = pl.id and pl.Deleted = 0
	LEFT JOIN [dbo].ProductDimensionPrices as pdp on pdp.ProductDimensionId = pd.id and pdp.Deleted = 0
	LEFT JOIN [dbo].SupplierProductMaps spm on spm.ProductId = p.Id and spm.Deleted = 0
	LEFT JOIN [dbo].Suppliers s on s.ID = spm.SupplierId and s.Deleted = 0
	LEFT JOIN [dbo].TaxGroups tg on tg.ID = pdp.TaxGroupId
	LEFT JOIN [dbo].Taxes t on t.TaxGroupId = pdp.TaxGroupId

	WHERE (B.Id = @BranchId OR @BranchId is null)
	AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)


END
---end---

---spRptSales---
GO
IF OBJECT_ID(N'[dbo].[spRptSales]', N'P') IS NOT NULL
	DROP PROCEDURE [dbo].[spRptSales]
GO

CREATE PROCEDURE [dbo].[spRptSales]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
    @BranchFilterId uniqueidentifier,
    @SupplierFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
BEGIN	
	DECLARE @HOBranch int;		
	SET @HOBranch = (SELECT count(b.id)
	FROM
		[dbo].Branches b
	WHERE b.Id = @BranchId AND b.Code = 'HO')

   SELECT
		BranchCode = IIF(T.BranchCode IS NOT NULL, T.BranchCode, ''),
		BranchName = B.[Name],
		[Date] = CONVERT(varchar, T.[Date], 111),
		[Time] = CONVERT(varchar, T.[Date], 108),
		Device = t.DeviceSerial,
		ReceiptNo = T.SaleNo,
		SaleType = (CASE
						WHEN T.Type = 0 THEN 'Sale'
						WHEN T.Type = 1 THEN 'Refund'
						WHEN T.Type = 2 THEN 'Open Refund'
					END),
		[User] = t.CreatorName,
		SupplierCode = IIF(s.code IS NOT NULL, s.code, ''),
		SupplierName = IIF(s.[Name] IS NOT NULL, s.[Name], ''),
		ReOrderNumber = spm.SupplierProductCode,
		ProductGroupName = td.ProductGroupName,
		ProductSubGroupName = sg.Name,
		ProductCode = p.Code,
		ProductName = TD.ProductName,
		Barcode = p.Barcode,
		DiscountReason = IIF(TD.DiscountReason IS NOT NULL, TD.DiscountReason, ''),
		RefundReason = IIF(T.RefundReason IS NOT NULL, T.RefundReason, ''),
		TaxRate = TD.TaxRate,
		Quantity = TD.Quantity,
		Total = TD.Amount,
		Vat = TD.Tax,
		NetPrice = (td.amount - td.Tax),--temp. fix (TD.NetPrice),
		DiscountAmount = TD.Discount,
		ProductCost = TD.ProductCost,
		Commission = p.commission
	FROM [dbo].TransactionDetails AS TD
			INNER JOIN [dbo].Transactions AS T ON T.Id = TD.TransactionId
			LEFT JOIN [dbo].Branches AS B ON B.Id = T.BranchId
			LEFT JOIN [dbo].SupplierProductMaps as spm ON spm.ProductId = td.ProductId
			LEFT JOIN [dbo].Suppliers as s on s.ID = spm.SupplierId
			LEFT JOIN [dbo].Products as p ON p.ID = td.ProductId
			LEFT JOIN [dbo].ProductGroups sg ON sg.ID = REVERSE(PARSENAME(REPLACE(REVERSE(ProductGroupPath), ',', '.'), 2))  -- use second value from Group Path
	WHERE T.[Date] >= @FromDate AND T.Date <= @ToDate
		  AND (@BranchId IS NULL OR @HOBranch > 0 OR B.Id = @BranchId)
		  AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
          AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
          AND (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
		  AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
	ORDER BY T.SaleNo DESC
END
---end---

---spRptSales---
GO
IF OBJECT_ID(N'[dbo].[spRptSalesPayment]', N'P') IS NOT NULL
	DROP PROCEDURE [dbo].[spRptSalesPayment]
GO

CREATE PROCEDURE [dbo].[spRptSalesPayment]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier
AS
BEGIN	
	SELECT	
		BranchCode = B.Code,
		Branch = B.[Name],
		DeviceNumber = D.Serial,
		[Date] = CONVERT(varchar, CAST( T.[Date] AS DATE), 111),
		OperatorCode = u.Login,
		OperatorName = u.FirstName + ' ' + u.LastName,
		TransactionNumber = T.SaleNo,
		TenderCode = TT.[Code],
		Tender = P.[Name],
		Amount = SUM(P.[Value])
FROM 
		[dbo].Transactions AS T			 
		INNER JOIN [dbo].PartPayments AS P ON P.TransactionId = T.Id
		INNER JOIN [dbo].TenderTypes As TT ON TT.[Name] = P.[Name]
		INNER JOIN [dbo].Branches AS B ON B.Id = T.BranchId
		INNER JOIN [dbo].Devices AS D ON T.DeviceId = D.Id
		LEFT JOIN  [dbo].AspNetUsers AS u ON u.Id = t.CreatorId
WHERE		
		(@BranchId IS NULL OR T.BranchId = @BranchId)
		AND
		(T.[Date] >= @FromDate AND T.Date <= @ToDate)
		AND
		(P.[Name] = N'Cash' Or P.[Name] = N'Card')
GROUP BY 
		B.[Name],
		B.Code,
		D.Serial,
		u.Login,
		u.FirstName + ' ' + u.LastName,
		CAST( T.DATE AS DATE),
		TT.[Code],
		P.[Name],
		T.SaleNo
ORDER BY 
		CAST( T.[Date] AS DATE) DESC
END
---end---

---spRptBestSellerswithProfit---
GO
IF OBJECT_ID(N'[dbo].[spRptBestSellerswithProfit]', N'P') IS NOT NULL
	DROP PROCEDURE [dbo].[spRptBestSellerswithProfit]
GO

CREATE PROCEDURE [dbo].[spRptBestSellerswithProfit]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
    @BranchFilterId uniqueidentifier,
    @SupplierFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS
BEGIN	
	DECLARE @HOBranch int;		
	SET @HOBranch = (SELECT count(b.id)
	FROM
		[dbo].Branches b
	WHERE b.Id = @BranchId AND b.Code = 'HO')

   SELECT
		BranchCode = IIF(T.BranchCode IS NOT NULL, T.BranchCode, ''),
		BranchName = B.[Name],
		SupplierCode = IIF(s.code IS NOT NULL, s.code, ''),
		SupplierName = IIF(s.[Name] IS NOT NULL, s.[Name], ''),
		ProductGroup = PG.Name,
		ProductSubGroup = IIF(P.ProductGroupPath is not null, [dbo].[GetProductGroupPath] (P.ProductGroupPath,','), ''),
		ProductCode = p.Code,
		Product = TD.ProductName,
		ProductCost = TD.ProductCost,
		Quantity = sum(TD.Quantity),
		Total = sum(TD.Amount),
		Vat = sum(TD.Tax),
		NetPrice = sum(td.amount - td.Tax),--temp. fix (TD.NetPrice),
		Profit = sum(td.amount - td.Tax - (td.Quantity*td.ProductCost))
	FROM [dbo].TransactionDetails AS TD
			INNER JOIN [dbo].Transactions AS T ON T.Id = TD.TransactionId
			LEFT JOIN [dbo].Branches AS B ON B.Id = T.BranchId
			LEFT JOIN [dbo].SupplierProductMaps as spm ON spm.ProductId = td.ProductId
			LEFT JOIN [dbo].Suppliers as s on s.ID = spm.SupplierId
			LEFT JOIN [dbo].Products as p ON p.ID = td.ProductId
			INNER JOIN [dbo].ProductGroups AS PG ON P.ProductGroupId = PG.Id AND PG.Deleted = 0

	WHERE T.[Date] >= @FromDate AND T.Date <= @ToDate
		  AND (@BranchId IS NULL OR @HOBranch > 0 OR B.Id = @BranchId)
		  AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
          AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
          AND (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
		  AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
		  AND ISNULL(TD.Voided,0) = 0
	GROUP BY
		IIF(T.BranchCode IS NOT NULL, T.BranchCode, ''),
		B.[Name],
		IIF(s.code IS NOT NULL, s.code, ''),
		IIF(s.[Name] IS NOT NULL, s.[Name], ''),
		p.Code,
		td.ProductCost,
		TD.ProductName,
		PG.Name,
		P.ProductGroupPath

	ORDER BY b.Name,sum(td.Quantity) DESC
END
---End HistoricalStockValuationReport---

---GetSales&PaymentsReport---
GO
IF OBJECT_ID(N'[dbo].[spRptGetSalesAndPaymentsReport]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[spRptGetSalesAndPaymentsReport]
GO
CREATE OR ALTER PROCEDURE [dbo].[spRptGetSalesAndPaymentsReport]
    @FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
    @BranchFilterId uniqueidentifier,
    @SupplierFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier,
	@ProductGroupFilterId uniqueidentifier,
	@ProductSubGroupFilterId nvarchar(max),
	@ProductTagFilterId uniqueidentifier,
	@ProductType int
AS
BEGIN	
	DECLARE @HOBranch int;		
	SET @HOBranch = (SELECT count(b.id)
	FROM
		Branches b
	WHERE b.Id = @BranchId AND b.Code = 'HO')

	SELECT
		[Date] = CONVERT(varchar, T.[Date], 111),
		[Time] = CONVERT(varchar, T.[Date], 108),
		BranchName = (SELECT B.[Name]
			FROM Branches B
			WHERE B.Id = T.BranchId),
		SaleType = (CASE
							WHEN T.Type = 0 THEN 'Sale'
							WHEN T.Type = 1 THEN 'Refund'
							WHEN T.Type = 2 THEN 'Open Refund'
						END),
		Device = t.DeviceSerial,
		[User] = t.CreatorName,
		SupplierCode = IIF(s.code IS NOT NULL, s.code, ''),
		SupplierName = IIF(s.[Name] IS NOT NULL, s.[Name], ''),
		SupplierProductCode = spm.SupplierProductCode,
		ProductGroupName = td.ProductGroupName,
		Product = TD.ProductName,
		TaxRate = TD.TaxRate,
		Barcode = (select top 1 BC.Code from BarCodes BC where BC.ProductId = P.Id and BC.Deleted = 0 order by BC.UpdatedDate desc ),
		Commission = p.commission,
		TransactionNumber  = T.SaleNo,
		Quantity = TD.Quantity,
		Total = TD.Amount,
		Vat = TD.Tax,
		NetPrice = (td.amount - td.Tax),--temp. fix (TD.NetPrice),
		ProductCost = TD.ProductCost,
		BranchCode = IIF(T.BranchCode IS NOT NULL, T.BranchCode, ''),
		DiscountAmount = TD.Discount,
		DiscountReason = IIF(TD.DiscountReason IS NOT NULL, TD.DiscountReason, ''),
		RefundReason = IIF(T.RefundReason IS NOT NULL, T.RefundReason, ''),
		ProductCode = IIF(p.Code IS NOT NULL, p.Code, ''),
		OfferName = IIF(TD.OfferName IS NOT NULL, TD.OfferName, ''),
		DiscountedFlag = IIF(TD.Discount IS NOT NULL, IIF(TD.Discount > 0, 'True', 'False'), 'False'),
		ProductSubGroup = IIF(p.ProductGroupPath is not null, p.ProductGroupPath, ''),
		ProductType = (CASE 
								WHEN p.IsSaleItem = 1 and p.IsStockItem = 1 THEN 'All'
								WHEN p.IsSaleItem = 1 THEN 'Sale'
								WHEN p.IsStockItem = 1 THEN 'Stock'
						END),
		Tender	=	PT.Name,
		TransactionID = IIF(T.AZTransactionNumber IS NULL, '', CONVERT(nvarchar(50), T.AZTransactionNumber))
		,pay.Payments
		,StockHeld		= sv.Quantity
		,Receipt = SaleNo
		,Operator = CreatorName
		FROM TransactionDetails AS TD
			INNER JOIN Transactions AS T ON T.Id = TD.TransactionId
			LEFT JOIN (
						Select TransactionId,
					    STRING_AGG(Name, '/') WITHIN GROUP (ORDER BY Name desc) As Payments 
					    From PartPayments
						group by TransactionId
					  ) pay on Pay.TransactionId = T.Id
			LEFT JOIN Branches AS B ON B.Id = T.BranchId
			LEFT JOIN Products as p ON p.ID = td.ProductId
			LEFT JOIN (select SupplierId,ProductId,SupplierProductCode,PackSize,Cost,Active,ROW_NUMBER() OVER (PARTITION BY Productid ORDER BY Productid,spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
					from SupplierProductMaps spm
					where deleted = 0) AS spm ON rn = 1 AND spm.ProductId = td.ProductId
			LEFT JOIN (Select BranchID,ProductId, Quantity=SUM(RemainingQuantity) from StockValuations sv WHERE Deleted = 0 GROUP BY BranchId,ProductId ) sv on sv.BranchId = t.BranchId AND sv.ProductId = td.ProductId
			LEFT JOIN Suppliers as s on s.ID = spm.SupplierId
			LEFT JOIN (
						select TenderId, TransactionId, T.Name from PartPayments AS Pay LEFT JOIN Tenders AS T on Pay.TenderId = T.Id
					  ) AS PT ON PT.TransactionId = T.Id

	WHERE T.[Date] >= @FromDate AND T.Date <= @ToDate
		  AND (@BranchId IS NULL OR @HOBranch > 0 OR B.Id = @BranchId)
		  AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
          AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
          AND (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
		  AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
		  AND (@ProductGroupFilterId IS NULL OR P.ProductGroupId = @ProductGroupFilterId)
		  AND (@ProductSubGroupFilterId IS NULL OR P.ProductGroupPath LIKE '%' + @ProductSubGroupFilterId)
		  AND (@ProductType IS NULL OR (@ProductType = 0 AND p.IsSaleItem = 1 AND p.IsStockItem = 1) OR (@ProductType = 1 AND p.IsSaleItem = 1 AND p.IsStockItem = 0) OR (@ProductType = 2 AND p.IsSaleItem = 0 AND p.IsStockItem = 1))
		  AND ISNULL(TD.Voided,0) = 0
		  AND (T.Type = 1 or T.Type = 2)

--	ORDER BY T.SaleNo DESC
END
---End GetSales&PaymentsReport---

---Stock Replenishment Report---
GO
IF OBJECT_ID(N'[dbo].[spRptReplenishment]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[spRptReplenishment]
GO

CREATE PROCEDURE [dbo].[spRptReplenishment]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
    @BranchFilterId uniqueidentifier,
    @SupplierFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier,
	@ProductGroupFilterId uniqueidentifier,
	@ProductSubGroupFilterId nvarchar(max),
	@ProductTagFilterId uniqueidentifier,
	@ProductType int
AS
BEGIN	
	DECLARE @HOBranch int;		
	SET @HOBranch = (SELECT count(b.id)
	FROM
		[dbo].Branches b
	WHERE b.Id = @BranchId AND b.Code = 'HO')

	SELECT t.BranchID,td.Productid, Quantity=SUM(TD.Quantity), Amount=SUM(TD.Amount)
	INTO #sales
	FROM [dbo].Transactions AS T 
	LEFT JOIN [dbo].TransactionDetails AS TD ON T.Id = TD.TransactionId AND ISNULL(TD.Voided,0) = 0
	WHERE T.[Date] >= @FromDate AND T.Date <= @ToDate
	GROUP BY t.BranchID,td.Productid

	SELECT 
		BranchCode			=  b.Code,
		BranchName			=  ISNULL(B.[Name],'No Branch Assigned'),
		SupplierCode		= ISNULL(s.code, ''),
		SupplierName		= ISNULL(s.[Name], ''),
		SupplierProductCode = spm.SupplierProductCode,
		ProductGroupName	= pg.Name,
		ProductCode			= ISNULL(p.Code, ''),
		Product				= p.Name,
		ProductCost			= spm.Cost,
		StockHeld			= bpm.Quantity,
		QuantitySold		= T.Quantity,
		SalesTotal			= T.Amount
	FROM [dbo].Products as p 
			INNER JOIN [dbo].StockItems si on si.ProductId = p.Id AND si.Deleted = 0
			INNER JOIN [dbo].ProductGroups pg on pg.Id = p.ProductGroupId
			LEFT JoIN [dbo].BranchProductMaps bpm on bpm.productid = p.Id
			LEFT JOIN #sales AS T ON T.ProductId = p.Id and t.BranchId = bpm.BranchId
			LEFT JOIN [dbo].Branches AS B ON B.Id = bpm.BranchId
			LEFT JOIN (select * ,ROW_NUMBER() OVER (PARTITION BY ProductId ORDER BY spm.IsPreferredSupplier DESC) AS rn
					from [dbo].SupplierProductMaps spm
					where deleted = 0) AS spm ON spm.ProductId = P.ID and spm.rn = 1
			LEFT JOIN [dbo].Suppliers as s on s.ID = spm.SupplierId

	WHERE 1=1
		  AND p.Deleted = 0 and p.Active = 1
		  AND (@BranchId IS NULL OR @HOBranch > 0 OR B.Id = @BranchId)
		  AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
          AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
          AND (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
		  AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
		  AND (@ProductGroupFilterId IS NULL OR P.ProductGroupId = @ProductGroupFilterId)
		  AND (@ProductSubGroupFilterId IS NULL OR P.ProductGroupPath LIKE '%' + @ProductSubGroupFilterId)
		  AND (@ProductType IS NULL OR (@ProductType = 0 AND p.IsSaleItem = 1 AND p.IsStockItem = 1) OR (@ProductType = 1 AND p.IsSaleItem = 1 AND p.IsStockItem = 0) OR (@ProductType = 2 AND p.IsSaleItem = 0 AND p.IsStockItem = 1))

END
---end---

---Stock Get Sales & Payments Report---
GO
IF OBJECT_ID(N'[dbo].[GetSalesAndPaymentsReport]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[GetSalesAndPaymentsReport]
GO

CREATE PROCEDURE [dbo].[GetSalesAndPaymentsReport]
	@FromDate DateTime,
	@ToDate DateTime,
	@BranchId uniqueidentifier,
	@ProductFilterId uniqueidentifier,
    @BranchFilterId uniqueidentifier,
    @SupplierFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier,
	@ProductGroupFilterId uniqueidentifier,
	@ProductSubGroupFilterId nvarchar(max),
	@ProductTagFilterId uniqueidentifier,
	@ProductType int
AS
BEGIN	
	DECLARE @HOBranch int;		
	SET @HOBranch = (SELECT count(b.id)
	FROM
		[dbo].Branches b
	WHERE b.Id = @BranchId AND b.Code = 'HO')

   SELECT
		[Date] = CONVERT(varchar, T.[Date], 111),
		[Time] = CONVERT(varchar, T.[Date], 108),
		BranchName = (SELECT B.[Name]
			FROM Branches B
			WHERE B.Id = T.BranchId),
		SaleType = (CASE
							WHEN T.Type = 0 THEN 'Sale'
							WHEN T.Type = 1 THEN 'Refund'
							WHEN T.Type = 2 THEN 'Open Refund'
						END),
		Device = t.DeviceSerial,
		[User] = t.CreatorName,
		SupplierCode = IIF(s.code IS NOT NULL, s.code, ''),
		SupplierName = IIF(s.[Name] IS NOT NULL, s.[Name], ''),
		SupplierProductCode = spm.SupplierProductCode,
		ProductGroupName = td.ProductGroupName,
		Product = TD.ProductName,
		TaxRate = TD.TaxRate,
		Barcode = (select top 1 BC.Code from BarCodes BC where BC.ProductId = P.Id and BC.Deleted = 0 order by BC.UpdatedDate desc ),
		Commission = p.commission,
		TransactionNumber  = T.SaleNo,
		Quantity = TD.Quantity,
		Total = TD.Amount,
		Vat = TD.Tax,
		NetPrice = (td.amount - td.Tax),--temp. fix (TD.NetPrice),
		ProductCost = TD.ProductCost,
		BranchCode = IIF(T.BranchCode IS NOT NULL, T.BranchCode, ''),
		DiscountAmount = TD.Discount,
		DiscountReason = IIF(TD.DiscountReason IS NOT NULL, TD.DiscountReason, ''),
		RefundReason = IIF(T.RefundReason IS NOT NULL, T.RefundReason, ''),
		ProductCode = IIF(p.Code IS NOT NULL, p.Code, ''),
		OfferName = IIF(TD.OfferName IS NOT NULL, TD.OfferName, ''),
		DiscountedFlag = IIF(TD.Discount IS NOT NULL, IIF(TD.Discount > 0, 'True', 'False'), 'False'),
		ProductSubGroup = IIF(p.ProductGroupPath is not null, p.ProductGroupPath, ''),
		ProductType = (CASE 
								WHEN p.IsSaleItem = 1 and p.IsStockItem = 1 THEN 'All'
								WHEN p.IsSaleItem = 1 THEN 'Sale'
								WHEN p.IsStockItem = 1 THEN 'Stock'
						END),
		TransactionID = IIF(T.AZTransactionNumber IS NULL, '', CONVERT(nvarchar(50), T.AZTransactionNumber))
		,pay.Payments
		,StockHeld		= sv.Quantity
	FROM [dbo].TransactionDetails AS TD
			INNER JOIN [dbo].Transactions AS T ON T.Id = TD.TransactionId
			LEFT JOIN (
						Select TransactionId,
					    STRING_AGG(Name, '/') WITHIN GROUP (ORDER BY Name desc) As Payments 
					    From [dbo].PartPayments
						group by TransactionId
					  ) pay on Pay.TransactionId = T.Id
			LEFT JOIN [dbo].Branches AS B ON B.Id = T.BranchId
			LEFT JOIN [dbo].Products as p ON p.ID = td.ProductId
			LEFT JOIN (select SupplierId,ProductId,SupplierProductCode,PackSize,Cost,Active,ROW_NUMBER() OVER (PARTITION BY Productid ORDER BY Productid,spm.IsPreferredSupplier DESC,IIF(Active = 1,99,0) DESC) AS rn
					from [dbo].SupplierProductMaps spm
					where deleted = 0) AS spm ON rn = 1 AND spm.ProductId = td.ProductId
			LEFT JOIN (Select BranchID,ProductId, Quantity=SUM(RemainingQuantity) from [dbo].StockValuations sv WHERE Deleted = 0 GROUP BY BranchId,ProductId ) sv on sv.BranchId = t.BranchId AND sv.ProductId = td.ProductId
			LEFT JOIN [dbo].Suppliers as s on s.ID = spm.SupplierId

	WHERE T.[Date] >= @FromDate AND T.Date <= @ToDate
		  AND (@BranchId IS NULL OR @HOBranch > 0 OR B.Id = @BranchId)
		  AND (@ProductFilterId IS NULL OR P.Id = @ProductFilterId)
          AND (@BranchFilterId IS NULL OR B.Id = @BranchFilterId)
          AND (@SupplierFilterId IS NULL OR S.Id = @SupplierFilterId)
		  AND (@BranchGroupFilterId IS NULL OR B.BranchGroupId = @BranchGroupFilterId)
		  AND (@ProductGroupFilterId IS NULL OR P.ProductGroupId = @ProductGroupFilterId)
		  AND (@ProductSubGroupFilterId IS NULL OR P.ProductGroupPath LIKE '%' + @ProductSubGroupFilterId)
		  AND (@ProductType IS NULL OR (@ProductType = 0 AND p.IsSaleItem = 1 AND p.IsStockItem = 1) OR (@ProductType = 1 AND p.IsSaleItem = 1 AND p.IsStockItem = 0) OR (@ProductType = 2 AND p.IsSaleItem = 0 AND p.IsStockItem = 1))
		  AND ISNULL(TD.Voided,0) = 0
--	ORDER BY T.SaleNo DESC
END

GO
IF OBJECT_ID(N'[dbo].[spRptDailyVisitor]', N'P') IS NOT NULL
    DROP PROCEDURE [dbo].[spRptDailyVisitor]
GO

CREATE PROCEDURE [dbo].[spRptDailyVisitor]
	@FromDate DateTime,
	@ToDate DateTime
AS
BEGIN	
  SELECT
		'BookingRef' = b.BookingNo,
		'Name'				= CONCAT(u.FirstName, ' ', u.LastName),
		'Email'				= IIF(u.Email IS NOT NULL, u.Email, ''),
		'Phone'				= IIF(u.PhoneNumber IS NOT NULL, u.PhoneNumber, ''),
		'TimeSlot'			= IIF(tsd.[Time] IS NOT NULL, tsd.[Time], ''),
		'Ticket'			= IIF(t.[Name] IS NOT NULL, t.[Name], ''),
		'BookedOn'			= CONVERT(varchar,b.CreatedDate, 111),
		'BookingDate'		= CONVERT(varchar,tk.BookingDate, 111),
		'PassengerType'		= tk.[name],
		'Count'				= tk.[count],
		'Status'			= 
			CASE
				WHEN b.Status = 0 THEN 'Pending'
				WHEN b.Status = 1 THEN 'Timeout'
				WHEN b.Status = 2 THEN 'Paid'
				WHEN b.Status = 3 THEN 'Cancelled'
				WHEN b.Status = 4 THEN 'Pay Later'
				WHEN b.Status = 5 THEN 'Partial'
				WHEN b.Status = 6 THEN 'Out Standing'
				WHEN b.Status = 7 THEN 'Abandoned'
				WHEN b.Status = 8 THEN 'Refunded'
				WHEN b.Status = 9 THEN 'Refunded Partial'
			END
	FROM tBookings AS b 
		left join (
			select bd.TimeSlotDetailId, bd.TicketId, bd.BookingDate, bd.BookingId, pt.[name],  bd.PassengerTypeId, COUNT(pt.[name]) as [count]
			from tBookingDetails as bd
				inner join tPassengerTypes as pt on pt.Id = bd.PassengerTypeId
				left join tTickets as t on t.Id = bd.TicketId
			group by pt.[name], bd.BookingId, bd.TicketId, bd.TimeSlotDetailId, bd.PassengerTypeId, bd.BookingDate
		) as tk on tk.BookingId = b.Id
		left join cUnregisteredCustomers as u on u.BookingId = b.Id
		left join tTickets as t on t.Id = tk.TicketId
		left join tTimeSlotDetails as tsd on tsd.Id = tk.TimeSlotDetailId
		left join tTimeSlots as ts on ts.Id = tsd.TimeSlotId
		left join tSchedules as s on s.Id = ts.ScheduleId
	where   b.CreatedDate >= @FromDate and b.CreatedDate <= @ToDate
	and tk.BookingId IS NOT NULL
END

---end---

--- Member Activities Report ---
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE or ALTER   proc [dbo].[spRptGetMemberActivity]
as
begin
	select c.FirstName + ' ' + c.LastName as MemberName,
		   c.Email as MemberEmail,
		   c.Code as MemberCode,
		   mc.CardNumber as CardNumberUsed,
		   FORMAT(ma.CreatedDate, 'yyyy/MM/dd') as DateOfEntry,
		   FORMAT(ma.CreatedDate, 'HH:mm:ss:s') as TimeOfEntry,
		   null as SiteEntry,
		   p.PackageName as ProductPurchased,
		   (case 
				when apt.MembershipPaymentTermType = 1 then CAST((pm.Monthly / 30) as decimal(18, 2))
				when apt.MembershipPaymentTermType = 2 then CAST((pm.Monthly / 4) as decimal(18, 2))
				when apt.MembershipPaymentTermType = 3 then CAST((pm.Monthly) as decimal(18, 2))
				when apt.MembershipPaymentTermType = 4 then CAST((pm.Annual) as decimal(18, 2))
			end) as TotalValue,
		   null as DiscountApplied,
		   c.AccountStatus as AccountStatus
	from [Hampshire-ECR-v2-Customer].[customer].[MemberActivites] ma 
		left join [Hampshire-ECR-v2-Customer].[customer].[Members] m on m.Id = ma.MemberId
		left join [Hampshire-ECR-v2-Customer].[customer].[Customers] c on c.MemberId = m.Id
		left join [Hampshire-ECR-v2-Customer].[customer].[MemberCards] mc on mc.MemberId = m.Id
		left join [Hampshire-ECR-v2-Customer].[customer].[MemberCharges] mch on mch.MemberId = m.Id
		left join [Hampshire-ECR-v2-Customer].[customer].[PriceMatrices] pm on pm.Id = mch.PriceMatrixId
		left join [Hampshire-ECR-v2-Customer].[customer].[PackagePriceMatrixMaps] ppmm on ppmm.PriceMatrixId = mch.PriceMatrixId
		left join [Hampshire-ECR-v2-Customer].[customer].[Packages] p on p.Id = ppmm.PackageId
		left join [Hampshire-ECR-v2-Customer].[customer].[PriceMatrixAttributes] pma on pma.PriceMatrixId = pm.Id
		left join [Hampshire-ECR-v2-Customer].[customer].[Attributes] a on a.Id = pma.AttributeId
		inner join [Hampshire-ECR-v2-Customer].[customer].[AttributePaymentTerms] apt on apt.AttributeId = a.Id
end
--- Member Activities Report ---
---End---
---end---

--- Voided Transaction Report ---

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spRptVolidedTransaction]
	@FromDate DATETIME,
	@ToDate DATETIME,
	@BranchId uniqueidentifier	
AS
BEGIN
select 	--Txn_Voided = T.Voided, 
		--TxnDet_Voided = TD.Voided,
		[Date] = CONVERT(varchar, T.[Date], 111),
		[Sale Time] = CONVERT(varchar, T.[Date], 108),
		BranchCode = b.Name, 
		Device = t.DeviceSerial,
		[User] = t.CreatorName,
		TransactionNumber  = T.SaleNo,
		Product = TD.ProductName,
		ProductCode = TD.ProductCode 

FROM [dbo].TransactionDetails AS TD
INNER JOIN [dbo].Transactions AS T ON T.Id = TD.TransactionId
left outer join dbo.branches as b on T.BranchId = b.Id 
where (T.Voided =1 or TD.Voided = 1)
And  T.[Date] >= @FromDate AND T.Date <= @ToDate
AND (@BranchId IS NULL OR B.Id = @BranchId)
order by CONVERT(varchar, T.[Date], 111), CONVERT(varchar, T.[Date], 108),T.SaleNo

end

---end---