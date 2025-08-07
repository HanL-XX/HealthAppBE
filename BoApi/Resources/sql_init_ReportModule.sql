IF EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Supplier Catalogue' AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where [Name] = 'Supplier Catalogue' AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Supplier Catalogue' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Supplier Catalogue', 'Supplier Catalogue', 2, NULL, 
		'
			{
                "type": 1,
                "text": "Supplier Catalogue",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": false,
                "api": "/api/Report/SupplierCatalogue",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branchName"
                            },
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "supplierProductCode"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "productName"
                            },
                            {
                                "uniqueName": "stockItemName"
                            },
                            {
                                "uniqueName": "catalogueStatus"
                            },
                            {
                                "uniqueName": "category"
                            },
                            {
                                "uniqueName": "subCategory"
                            },
                            {
                                "uniqueName": "taxGroup"
                            },
                            {
                                "uniqueName": "tax"
                            },
                            {
                                "uniqueName": "barcode"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "packSize",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "cost",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branchName": {
                            "type": "string",
                            "caption": "Branch Name"
                        },
                        "supplierCode": {
                            "type": "string",
                            "caption": "Supplier Code"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        },
                        "supplierProductCode": {
                            "type": "string",
                            "caption": "Supplier Product Code"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "productName": {
                            "type": "string",
                            "caption": "Product Name"
                        },
                        "stockItemName": {
                            "type": "string",
                            "caption": "Stock Item Name"
                        },
                        "packSize": {
                            "type": "number",
                            "caption": "Pack Size"
                        },
                        "cost": {
                            "type": "number",
                            "caption": "Cost"
                        },
                        "catalogueStatus": {
                            "type": "string",
                            "caption": "Catalogue Status"
                        },
                        "category": {
                            "type": "string",
                            "caption": "Category"
                        },
                        "subCategory": {
                            "type": "string",
                            "caption": "Sub Category"
                        },
                        "taxGroup": {
                            "type": "string",
                            "caption": "Tax Group"
                        },
                        "tax": {
                            "type": "string",
                            "caption": "Tax %"
                        },
                        "barcode": {
                            "type": "string",
                            "caption": "Barcode"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Current Stock Holding' AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where [Name] = 'Current Stock Holding' AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Current Stock Holding' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Current Stock Holding', 'Current Stock Holding', 0, NULL, 
		'
			{
                "type": 1,
                "text": "Current Stock Holding",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": false,
                "api": "/api/Report/CurrentStockHolding",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branch"
                            },
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "orderPO"
                            },
                            {
                                "uniqueName": "ds+OrderDate"
                            },
                            {
                                "uniqueName": "ds+DeliveryDate"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "productName"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "itemCost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "deliveredQTY",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "issuedQTY",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "remainingQTY",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "stockValuation",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branch": {
                            "type": "string",
                            "caption": "Branch"
                        },
                        "supplierCode": {
                            "type": "string",
                            "caption": "Supplier Code"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        },
                        "orderPO": {
                            "type": "string",
                            "caption": "Order PO"
                        },
                        "ds+OrderDate": {
                            "type": "date string",
                            "caption": "Order Date"
                        },
                        "ds+DeliveryDate": {
                            "type": "date string",
                            "caption": "Delivery Date"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "productName": {
                            "type": "string",
                            "caption": "Product Name"
                        },
                        "itemCost": {
                            "type": "number",
                            "caption": "Item Cost"
                        },
                        "deliveredQTY": {
                            "type": "number",
                            "caption": "Delivered QTY"
                        },
                        "issuedQTY": {
                            "type": "number",
                            "caption": "Issued QTY"
                        },
                        "remainingQTY": {
                            "type": "number",
                            "caption": "Remaining QTY"
                        },
                        "stockValuation": {
                            "type": "number",
                            "caption": "stock Valuation"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Products' AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where [Name] = 'Products' AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Products' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Products', 'Products', 5, NULL, 
		'
            {
                "type": 1,
                "text": "Products",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": false,
                "api": "/api/Report/Products",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branchName"
                            },
                            {
                                "uniqueName": "productGroup"
                            },
                            {
                                "uniqueName": "productSubGroup"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "productName"
                            },
                            {
                                "uniqueName": "productBarcode"
                            },
                            {
                                "uniqueName": "ds+OnSaleDate"
                            },
                            {
                                "uniqueName": "ds+OffSaleDate"
                            },
                            {
                                "uniqueName": "ds+ValidFrom"
                            },
                            {
                                "uniqueName": "ds+ValidTo"
                            },
                            {
                                "uniqueName": "ds+LastUpdated"
                            },
                            {
                                "uniqueName": "activeFlag"
                            },
                            {
                                "uniqueName": "taxGroup"
                            },
                            {
                                "uniqueName": "tax"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "commission",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "cost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "price",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "minLevel",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "standardLevel",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "maxLevel",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branchName": {
                            "type": "string",
                            "caption": "Branch Name"
                        },
                        "productGroup": {
                            "type": "string",
                            "caption": "Product Group"
                        },
                        "productSubGroup": {
                            "type": "string",
                            "caption": "Product Subgroup"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "productName": {
                            "type": "string",
                            "caption": "Product Name"
                        },
                        "productBarcode": {
                            "type": "string",
                            "caption": "Product Barcode"
                        },
                        "commission": {
                            "type": "number",
                            "caption": "Commission"
                        },
                        "ds+OnSaleDate": {
                            "type": "date string",
                            "caption": "On Sale Date"
                        },
                        "ds+OffSaleDate": {
                            "type": "date string",
                            "caption": "Off Sale Date"
                        },
                        "cost": {
                            "type": "number",
                            "caption": "Cost"
                        },
                        "price": {
                            "type": "number",
                            "caption": "Price"
                        },
                        "ds+ValidFrom": {
                            "type": "date string",
                            "caption": "Valid From"
                        },
                        "ds+ValidTo": {
                            "type": "date string",
                            "caption": "Valid To"
                        },
                        "ds+LastUpdated": {
                            "type": "date string",
                            "caption": "Last Updated"
                        },
                        "activeFlag": {
                            "type": "string",
                            "caption": "Active Flag"
                        },
                        "taxGroup": {
                            "type": "string",
                            "caption": "Tax Group"
                        },
                        "tax": {
                            "type": "string",
                            "caption": "Tax %"
                        },
                        "minLevel": {
                            "type": "number",
                            "caption": "Min Level"
                        },
                        "standardLevel": {
                            "type": "number",
                            "caption": "Standard Level"
                        },
                        "maxLevel": {
                            "type": "number",
                            "caption": "Max Level"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Goods Receipted' AND [AccountId] IS NULL)
    DELETE FROM [dbo].[Reports] where [Name] = 'Goods Receipted' AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Goods Receipted' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Goods Receipted', 'Goods Receipted', 2, NULL, 
		'
			{
                "type": 1,
                "text": "Goods Receipted",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": true,
                "api": "/api/Report/GoodsReceipted",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "ds+DeliveryDate"
                            },
                            {
                                "uniqueName": "ds+OrderDate"
                            },
                            {
                                "uniqueName": "purchaseOrder"
                            },
                            {
                                "uniqueName": "branch"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "deliveryStatus"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "productName"
                            },
                            {
                                "uniqueName": "uom"
                            },
                            {
                                "uniqueName": "difference"
                            },
                            {
                                "uniqueName": "supplierProductCode"
                            },
                            {
                                "uniqueName": "updatedBy"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "unitCost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "expectedQTY",
                                "aggregation": "sum"
                            },
                            {
                                "uniqueName": "deliveredQTY",
                                "aggregation": "sum"
                            },
                            {
                                "uniqueName": "lineCost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "totalCost",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "ds+DeliveryDate": {
                            "type": "date string",
                            "caption": "Delivery Date"
                        },
                        "ds+OrderDate": {
                            "type": "date string",
                            "caption": "Order Date"
                        },
                        "purchaseOrder": {
                            "type": "number",
                            "caption": "Purchase Order"
                        },
                        "branch": {
                            "type": "string",
                            "caption": "Branch Name"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        },
                        "deliveryStatus": {
                            "type": "string",
                            "caption": "Delivery Status"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "supplierCode": {
                            "type": "string",
                            "caption": "Supplier Code"
                        },
                        "productName": {
                            "type": "string",
                            "caption": "Product Name"
                        },
                        "uom": {
                            "type": "string",
                            "caption": "UOM"
                        },
                        "packSize": {
                            "type": "number",
                            "caption": "Pack Size"
                        },
                        "unitCost": {
                            "type": "number",
                            "caption": "Unit Cost"
                        },
                        "expectedQTY": {
                            "type": "number",
                            "caption": "Expected QTY"
                        },
                        "deliveredQTY": {
                            "type": "number",
                            "caption": "Delivered QTY"
                        },
                        "lineCost": {
                            "type": "number",
                            "caption": "Line Cost"
                        },
                        "totalCost": {
                            "type": "number",
                            "caption": "Total Cost"
                        },
                        "difference": {
                            "type": "number",
                            "caption": "Difference"
                        },
                        "supplierProductCode": {
                            "type": "string",
                            "caption": "Supplier Product Code"
                        },
                        "updatedBy": {
                            "type": "string",
                            "caption": "Updated By"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Order To Supplier' AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where [Name] = 'Order To Supplier' AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Order To Supplier' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Order To Supplier', 'Order To Supplier', 2, NULL, 
		'
            {
                "type": 1,
                "text": "Order To Supplier",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": true,
                "api": "/api/Report/OrderToSupplier",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "ds+OrderDate"
                            },
                            {
                                "uniqueName": "branchName"
                            },
                            {
                                "uniqueName": "purchaseOrder"
                            },
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "orderStatus"
                            },
                            {
                                "uniqueName": "ds+DeliveryDate"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "supplierProductCode"
                            },
                            {
                                "uniqueName": "productName"
                            },
                            {
                                "uniqueName": "unitOfMeasure"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "packSize",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "itemCost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "orderedQuantity",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "lineCost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "totalCost",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "ds+OrderDate": {
                            "type": "date string",
                            "caption": "Order Date"
                        },
                        "branchName": {
                            "type": "string",
                            "caption": "Branch Name"
                        },
                        "purchaseOrder": {
                            "type": "string",
                            "caption": "Purchase Order"
                        },
                        "supplierCode": {
                            "type": "string",
                            "caption": "Supplier Code"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        },
                        "orderStatus": {
                            "type": "string",
                            "caption": "Order Status"
                        },
                        "ds+DeliveryDate": {
                            "type": "date string",
                            "caption": "Delivery Date"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "supplierProductCode": {
                            "type": "string",
                            "caption": "Supplier Product Code"
                        },
                        "productName": {
                            "type": "string",
                            "caption": "Product Name"
                        },
                        "unitOfMeasure": {
                            "type": "string",
                            "caption": "Unit Of Measure"
                        },
                        "packSize": {
                            "type": "number",
                            "caption": "Pack Size"
                        },
                        "itemCost": {
                            "type": "number",
                            "caption": "Item Cost"
                        },
                        "orderedQuantity": {
                            "type": "number",
                            "caption": "Ordered Quantity"
                        },
                        "lineCost": {
                            "type": "number",
                            "caption": "Line Cost"
                        },
                        "totalCost": {
                            "type": "number",
                            "caption": "Total Cost"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Sales Report' AND [AccountId] IS NULL)
    DELETE FROM [dbo].[Reports] where [Name] = 'Sales Report' AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Sales Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
        'Sales Report', 'Sales Report', 1, NULL, 
        '
            {
                "type": 1,
                "text": "Sales Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": true,
                "api": "/api/Report/Sales",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "ds+Date"
                            },
                            {
                                "uniqueName": "time"
                            },
                            {
                                "uniqueName": "branchName"
                            },
                            {
                                "uniqueName": "saleType"
                            },
                            {
                                "uniqueName": "device"
                            },
                            {
                                "uniqueName": "user"
                            },
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "supplierProductCode"
                            },
                            {
                                "uniqueName": "productGroupName"
                            },
                            {
                                "uniqueName": "product"
                            },
                            {
                                "uniqueName": "barcode"
                            },
                            {
                                "uniqueName": "transactionNumber"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "offerName"
                            },
                            {
                                "uniqueName": "discountedFlag"
                            },
                            {
                                "uniqueName": "productSubGroup"
                            },
                            {
                                "uniqueName": "productType"
                            },
                            {
                                "uniqueName": "transactionID"
                            },
                            {
                              "uniqueName": "taxCode"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "taxRate",
                                "aggregation": "average",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "commission",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "quantity",
                                "aggregation": "sum"
                            },
                            {
                                "uniqueName": "total",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "vat",
                                "aggregation": "sum",
                                "format": "amount",
                                "active": false
                            },
                            {
                                "uniqueName": "netPrice",
                                "aggregation": "sum",
                                "format": "amount",
                                "active": false
                            },
                            {
                                "uniqueName": "productCost",
                                "aggregation": "sum",
                                "format": "amount",
                                "active": false
                            },
                            {
                                "uniqueName": "discountAmount",
                                "aggregation": "sum",
                                "format": "amount",
                                "active": false
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "ds+Date": {
                            "type": "date string",
                            "caption": "Date"
                        },
                        "time": {
                            "type": "string",
                            "caption": "Sale Time"
                        },
                        "branchName": {
                            "type": "string",
                            "caption": "Branch Name"
                        },
                        "saleType": {
                            "type": "string",
                            "caption": "Sale Type"
                        },
                        "device": {
                            "type": "string",
                            "caption": "Device"
                        },
                        "user": {
                            "type": "string",
                            "caption": "User"
                        },
                        "supplierCode": {
                            "type": "string",
                            "caption": "Supplier Code"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        },
                        "supplierProductCode": {
                            "type": "string",
                            "caption": "Supplier Product Code"
                        },
                        "productGroupName": {
                            "type": "string",
                            "caption": "Product Group Name"
                        },
                        "product": {
                            "type": "string",
                            "caption": "Product"
                        },
                        "taxRate": {
                            "type": "number",
                            "caption": "TaxRate"
                        },
                        "barcode": {
                            "type": "string",
                            "caption": "Barcode"
                        },
                        "commission": {
                            "type": "number",
                            "caption": "Commission"
                        },
                        "transactionNumber": {
                            "type": "string",
                            "caption": "Transaction Number"
                        },
                        "quantity": {
                            "type": "number",
                            "caption": "Quantity"
                        },
                        "total": {
                            "type": "number",
                            "caption": "Total"
                        },
                        "vat": {
                            "type": "number",
                            "caption": "VAT"
                        },
                        "netPrice": {
                            "type": "number",
                            "caption": "NET Price"
                        },
                        "productCost": {
                            "type": "number",
                            "caption": "Product Cost"
                        },
                        "branchCode": {
                            "type": "string",
                            "caption": "Branch Code"
                        },
                        "discountAmount": {
                            "type": "number",
                            "caption": "Discount Amount"
                        },
                        "discountReason": {
                            "type": "string",
                            "caption": "Discount Reason"
                        },
                        "refundReason": {
                            "type": "string",
                            "caption": "Refund Reason"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "offerName": {
                            "type": "string",
                            "caption": "Offer Name"
                        },
                        "discountedFlag": {
                            "type": "string",
                            "caption": "Discounted Flag"
                        },
                        "productSubGroup": {
                            "type": "string",
                            "caption": "Product Sub Group"
                        },
                        "productType": {
                            "type": "string",
                            "caption": "Product Type"
                        },
                        "transactionID": {
                            "type": "string",
                            "caption": "TransactionID"
                        },
                        "taxCode": {
                            "type": "string",
                            "caption": "TaxCode"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
        '
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Product Export Code' and [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where [Name] = 'Product Export Code' and [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Product Export Code' and [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
	'Product Export Code', 'Product Export Code', 1, NULL, 
	'
		{
            "type": 1,
            "text": "Product Export Code",
            "from": "2021-09-12T00:00:00.000Z",
            "to": "2021-09-12T00:00:00.000Z",
            "needDatepicker": true,
            "api": "/api/Report/ProductExportCode",
            "config": {
                "options": {
                    "viewType": "grid",
                    "grid": {
                        "type": "classic",
                        "showGrandTotals": "off",
                        "showTotals": false
                    },
                    "grouping": false,
                    "showAggregationLabels": false,
                    "datePattern": "dd/MM/yyyy"
                },
                "slice": {
                    "rows": [
                        {
                            "uniqueName": "transactionNumber"
                        },
                        {
                            "uniqueName": "ds+Date"
                        },
                        {
                            "uniqueName": "branch"
                        },
                        {
                            "uniqueName": "branchCode"
                        },
                        {
                            "uniqueName": "productExportCode"
                        },
                        {
                            "uniqueName": "productExportCodeName"
                        },
                        {
                            "uniqueName": "productCode"
                        },
                        {
                            "uniqueName": "transactionID"
                        }
                    ],
                    "measures": [
                        {
                            "uniqueName": "quantity",
                            "aggregation": "sum",
                            "format": "number"
                        },
                        {
                            "uniqueName": "exclVat",
                            "aggregation": "sum",
                            "format": "amount"
                        },
                        {
                            "uniqueName": "vat",
                            "aggregation": "sum",
                            "format": "amount"
                        },
                        {
                            "uniqueName": "total",
                            "aggregation": "sum",
                            "format": "amount"
                        }
                    ],
                    "expandAll": true
                },
                "dataTypes": {
                    "transactionNumber": {
                        "type": "string",
                        "caption": "Transaction Number"
                    },
                    "ds+Date": {
                        "type": "date string",
                        "caption": "Date"
                    },
                    "branch": {
                        "type": "string",
                        "caption": "Branch"
                    },
                    "branchCode": {
                        "type": "string",
                        "caption": "Branch Code"
                    },
                    "productExportCode": {
                        "type": "string",
                        "caption": "Product Export Code"
                    },
                    "productExportCodeName": {
                        "type": "string",
                        "caption": "Product Export Code Name"
                    },
                    "quantity": {
                        "type": "number",
                        "caption": "QTY"
                    },
                    "exclVat": {
                        "type": "number",
                        "caption": "Excl VAT"
                    },
                    "vat": {
                        "type": "number",
                        "caption": "VAT"
                    },
                    "total": {
                        "type": "number",
                        "caption": "TOTAL"
                    },
                    "productCode": {
                        "type": "string",
                        "caption": "Product Code"
                    },
                    "transactionID": {
                        "type": "string",
                        "caption": "TransactionID"
                    }
                },
                "formats": [
                    {
                        "name": "amount",
                        "decimalSeparator": ".",
                        "decimalPlaces": 2
                    },
                    {
                        "name": "rightAlign",
                        "textAlign": "right"
                    }
                ]
            }
        }
	'
    )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Ticketing Commission' and [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where [Name] = 'Ticketing Commission' and [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Ticketing Commission' and [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
	'Ticketing Commission', 'Ticketing Commission', 1, NULL, 
	'
        {
            "type": 1,
            "text": "Ticketing Commission",
            "from": "2021-09-12T00:00:00.000Z",
            "to": "2021-09-12T00:00:00.000Z",
            "needDatepicker": true,
            "api": "/api/Report/TicketingCommission",
            "config": {
                "options": {
                    "viewType": "grid",
                    "grid": {
                        "type": "classic",
                        "showGrandTotals": "off",
                        "showTotals": false
                    },
                    "grouping": false,
                    "showAggregationLabels": false,
                    "datePattern": "dd/MM/yyyy"
                },
                "slice": {
                    "rows": [
                        {
                            "uniqueName": "ds+SaleDate"
                        },
                        {
                            "uniqueName": "branch"
                        },
                        {
                            "uniqueName": "branchCode"
                        },
                        {
                            "uniqueName": "supplierName"
                        },
                        {
                            "uniqueName": "supplierCode"
                        },
                        {
                            "uniqueName": "product"
                        },
                        {
                            "uniqueName": "productCode"
                        },
                        {
                            "uniqueName": "transactionNumber"
                        },
                        {
                            "uniqueName": "saleTime"
                        },
                        {
                            "uniqueName": "transactionDetailUID"
                        },
                        {
                            "uniqueName": "productSubGroup"
                        }
                    ],
                    "measures": [
                        {
                            "uniqueName": "quantity",
                            "aggregation": "sum",
                            "format": "number"
                        },
                        {
                            "uniqueName": "totalSaleValue",
                            "aggregation": "sum",
                            "format": "amount"
                        },
                        {
                            "uniqueName": "commissionRate",
                            "aggregation": "average",
                            "format": "amount"
                        },
                        {
                            "uniqueName": "commissionValue",
                            "aggregation": "sum",
                            "format": "amount"
                        },
                        {
                            "uniqueName": "totalSalesValueLessCommission",
                            "aggregation": "sum",
                            "format": "amount"
                        }
                    ],
                    "expandAll": true
                },
                "dataTypes": {
                    "ds+SaleDate": {
                        "type": "date string",
                        "caption": "Sale Date"
                    },
                    "branch": {
                        "type": "string",
                        "caption": "Branch"
                    },
                    "branchCode": {
                        "type": "string",
                        "caption": "Branch Code"
                    },
                    "supplierName": {
                        "type": "string",
                        "caption": "Supplier Name"
                    },
                    "supplierCode": {
                        "type": "string",
                        "caption": "Supplier Code"
                    },
                    "product": {
                        "type": "string",
                        "caption": "Product"
                    },
                    "productCode": {
                        "type": "string",
                        "caption": "Product Code"
                    },
                    "quantity": {
                        "type": "number",
                        "caption": "QTY"
                    },
                    "totalSaleValue": {
                        "type": "number",
                        "caption": "Total Sale Value"
                    },
                    "commissionRate": {
                        "type": "number",
                        "caption": "Commission Rate"
                    },
                    "commissionValue": {
                        "type": "number",
                        "caption": "Commission Value"
                    },
                    "totalSalesValueLessCommission": {
                        "type": "number",
                        "caption": "Total Sales Value Less Commission"
                    },
                    "transactionNumber": {
                        "type": "string",
                        "caption": "Transaction Number"
                    },
                    "saleTime": {
                        "type": "string",
                        "caption": "Sale Time"
                    },
                    "transactionDetailUID": {
                        "type": "string",
                        "caption": "Transaction Detail UID"
                    },
                    "productSubGroup": {
                        "type": "string",
                        "caption": "Product Sub Group"
                    }
                },
                "formats": [
                    {
                        "name": "amount",
                        "decimalSeparator": ".",
                        "decimalPlaces": 2
                    },
                    {
                        "name": "rightAlign",
                        "textAlign": "right"
                    }
                ]
            }
        }
	'
    )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Tender Export Code' AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where [Name] = 'Tender Export Code' AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Tender Export Code' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
    'Tender Export Code', 'Tender Export Code', 1, NULL,
    '
        {
            "type": 1,
            "text": "Tender Export Code",
            "from": "2021-09-12T00:00:00.000Z",
            "to": "2021-09-12T00:00:00.000Z",
            "needDatepicker": true,
            "api": "/api/Report/TenderExportCode",
            "config" : {
                "options" : {
                    "viewType" : "grid",
                    "grid" : {
                        "type" : "classic",
                        "showGrandTotals" : "off",
                        "showTotals" : false
                    },
                    "grouping" : false,
                    "showAggregationLabels" : false,
                    "datePattern": "dd/MM/yyyy"
                },
                "slice" : {
                    "rows" : [
                        {
                            "uniqueName" : "ds+Date"
                        },
                        {
                            "uniqueName" : "transactionNumber"
                        },
                        {
                            "uniqueName" : "branch"
                        },
                        {
                            "uniqueName" : "branchCode"
                        },
                        {
                            "uniqueName" : "deviceNumber"
                        },
                        {
                            "uniqueName" : "tenderCode"
                        },
                        {
                            "uniqueName" : "tenderName"
                        },
                        {
                            "uniqueName" : "tenderType"
                        },
                        {
                            "uniqueName" : "transactionID"
                        },
                        {
                            "uniqueName": "saleTime"
                        }
                    ],
                    "measures" : [
                        {
                            "uniqueName" : "amount",
                            "aggregation" : "sum",
                            "format" : "amount"
                        }
                    ],
                    "expandAll" : true
                },
                "dataTypes" : {
                    "ds+Date" : {
                        "type" : "date string",
                        "caption": "Date"
                    },
                    "transactionNumber" : {
                        "type" : "string",
                        "caption" : "Transaction Number"
                    },
                    "branch" : {
                        "type" : "string",
                        "caption" : "Branch"
                    },
                    "branchCode" : {
                        "type" : "string",
                        "caption" : "Branch Code"
                    },
                    "deviceNumber" : {
                        "type" : "string",
                        "caption" : "Device number"
                    },
                    "tenderName" : {
                        "type" : "string",
                        "caption" : "Tender Name"
                    },
                    "tenderType" : {
                        "type" : "string",
                        "caption" : "Tender Type"
                    },
                    "tenderCode" : {
                        "type" : "string",
                        "caption" : "Tender Code"
                    },
                    "amount" : {
                        "type" : "number",
                        "caption" : "Amount"
                    },
                    "transactionID" : {
                        "type" : "string",
                        "caption" : "TransactionID"
                    },
                    "saleTime" : {
                        "type" : "string",
                        "caption" : "Sale Time"
                    }
                },
                "formats": [
                    {
                        "name" :  "amount",
                        "decimalSeparator" : ".",
                        "decimalPlaces" : 2
                    },
                    {
                        "name" : "rightAlign",
                        "textAlign" : "right"
                    }
                ]
            }
        }
    '
    )
END

 IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'spRptTransfers' or [Name] = 'Stock Transfer Details') AND [AccountId] IS NULL)
 DELETE FROM [dbo].[Reports] where ([Name] = 'spRptTransfers' or [Name] = 'Stock Transfer Details') AND [AccountId] IS NULL

 IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Stock Transfer Details' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Stock Transfer Details', 'Stock Transfer Details', 2, NULL, 
		'{
    "type": 1,
    "text": "Stock Transfer Details",
    "from": "2021-09-12T00:00:00.000Z",
    "to": "2021-09-12T00:00:00.000Z",
    "needDatepicker": true,
    "api": "/api/Report/spRptTransfers",
    "config": {
        "options": {
            "viewType": "grid",
            "grid": {
                "type": "classic",
                "showGrandTotals": "off",
                "showTotals": false
            },
            "grouping": false,
            "showAggregationLabels": false,
            "datePattern": "dd/MM/yyyy"
        },
        "slice": {
            "rows": [
                {
                    "uniqueName": "transferId"
                },
                {
                    "uniqueName": "ds+TransferDate"
                },
                {
                    "uniqueName": "fromLocation"
                },
                {
                    "uniqueName": "toLocation"
                },
                {
                    "uniqueName": "code"
                },
                {
                    "uniqueName": "productGroup"
                },
                {
                    "uniqueName": "product"
                },
                {
                    "uniqueName": "transferredBy"
                },
                {
                    "uniqueName": "ds+CreatedDate"
                },
                {
                    "uniqueName": "updatedBy"
                },
                {
                    "uniqueName": "ds+UpdatedDate"
                }
            ],
            "measures": [
                {
                    "uniqueName": "cost",
                    "aggregation": "sum",
                    "format": "amount"
                },
                {
                    "uniqueName": "stockLevel",
                    "aggregation": "sum",
                    "format": "amount"
                },
                {
                    "uniqueName": "qty",
                    "aggregation": "sum",
                    "format": "amount"
                },
                {
                    "uniqueName": "issuedqty",
                    "aggregation": "sum",
                    "format": "amount"
                }
            ],
            "expandAll": true
        },
        "dataTypes": {
            "transferId": {
                "type": "string",
                "caption": "Transfer Id"
            },
            "ds+TransferDate": {
                "type": "date string",
                "caption": "Transfer Date"
            },
            "fromLocation": {
                "type": "string",
                "caption": "From Location"
            },
            "toLocation": {
                "type": "string",
                "caption": "To Location"
            },
            "code": {
                "type": "string",
                "caption": "Code"
            },
            "productGroup": {
                "type": "string",
                "caption": "Product Group"
            },
            "product": {
                "type": "string",
                "caption": "Product"
            },
            "cost": {
                "type": "number",
                "caption": "Cost"
            },
            "stockLevel": {
                "type": "number",
                "caption": "Stock Level"
            },
            "qty": {
                "type": "number",
                "caption": "QTY"
            },
            "issuedqty": {
                "type": "number",
                "caption": "Issued QTY"
            },
            "transferredBy": {
                "type": "string",
                "caption": "Transferred By"
            },
            "ds+CreatedDate": {
                "type": "date string",
                "caption": "Created Date"
            },
            "updatedBy": {
                "type": "string",
                "caption": "Updated By"
            },
            "ds+UpdatedDate": {
                "type": "date string",
                "caption": "Updated Date"
            }
        },
        "formats": [
            {
                "name": "amount",
                "decimalSeparator": ".",
                "decimalPlaces": 4
            },
            {
                "name": "rightAlign",
                "textAlign": "right"
            }
        ]
    }
}'
)
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'spRptAdjustments' or [Name] = 'Stock Adjustment Details') AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'spRptAdjustments' or [Name] = 'Stock Adjustment Details') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Stock Adjustment Details' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Stock Adjustment Details', 'Stock Adjustment Details', 2, NULL, 
		'
            {
                "type": 1,
                "text": "Stock Adjustment Details",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": true,
                "api": "/api/Report/spRptAdjustments",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "adjustmentNo"
                            },
                            {
                                "uniqueName": "location"
                            },
                            {
                                "uniqueName": "adjustmentReason"
                            },
                            {
                                "uniqueName": "adjustedBy"
                            },
                            {
                                "uniqueName": "updatedBy"
                            },
                            {
                                "uniqueName": "code"
                            },
                            {
                                "uniqueName": "productGroup"
                            },
                            {
                                "uniqueName": "product"
                            },
                            {
                                "uniqueName": "comments"
                            }
                           
                        ],
                        "measures": [
                            {
                                "uniqueName": "unitCost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "qty",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "totalCost",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "adjustmentNo": {
                            "type": "string",
                            "caption": "Adjustment No"
                        },
                        "location": {
                            "type": "string",
                            "caption": "Location"
                        },
                        "adjustmentReason": {
                            "type": "string",
                            "caption": "Adjustment Reason"
                        },
                        "adjustedBy": {
                            "type": "string",
                            "caption": "Adjusted By"
                        },
                        "updatedBy": {
                            "type": "string",
                            "caption": "Updated By"
                        },
                        "code": {
                            "type": "string",
                            "caption": "Code"
                        },
                        "productGroup": {
                            "type": "string",
                            "caption": "Product Group"
                        },
                        "product": {
                            "type": "string",
                            "caption": "Product"
                        },
                        "unitCost": {
                            "type": "number",
                            "caption": "Unit Cost"
                        },
                        "qty": {
                            "type": "number",
                            "caption": "QTY"
                        },
                        "comments": {
                            "type": "string",
                            "caption": "Comments"
                        },
                        "totalCost": {
                            "type": "number",
                            "caption": "Total Cost"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'spRptOrdersToSuppliers' or [Name] = 'Orders To Suppliers Report') AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'spRptOrdersToSuppliers' or [Name] = 'Orders To Suppliers Report') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Orders To Suppliers Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Orders To Suppliers Report', 'Orders To Suppliers Report',2, NULL, 
		'
            {
                "type": 1,
                "text": "Orders To Suppliers Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": true,
                "api": "/api/Report/spRptOrdersToSuppliers",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                            "uniqueName" : "orderID"
                            },
                            {
                            "uniqueName" : "ds+OrderDate"
                            },
                            {
                            "uniqueName" : "orderStatusParse"
                            },
                            {
                            "uniqueName" : "ds+DeliveryETA"
                            },
                            {
                            "uniqueName" : "comments"
                            },
                            {
                            "uniqueName" : "branch"
                            },
                            {
                            "uniqueName" : "supplierCode"
                            },
                            {
                            "uniqueName" : "supplierName"
                            },
                            {
                            "uniqueName" : "iluNumber"
                            },
                            {
                            "uniqueName" : "product"
                            },
                            {
                            "uniqueName" : "uom"
                            },
                            {
                            "uniqueName" : "orderRaisedBy"
                            },
                            {
                            "uniqueName" : "orderUpdatedBy"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "cost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "qty",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "carriageCharge",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "orderID": {
                            "type": "string",
                            "caption": "Order ID"
                        },
                        "ds+OrderDate" : {
                            "type" : "date string",
                            "caption" : "Order Date"
                        },
                        "orderStatusParse" : {
                            "type" : "string",
                            "caption" : "Order Status"
                        },
                        "ds+DeliveryETA" : {
                            "type" : "date string",
                            "caption" : "Delivery ETA"
                        },
                        "comments" : {
                            "type" : "string",
                            "caption" : "Comments"
                        },
                        "branch" : {
                            "type" : "string",
                            "caption" : "Branch"
                        },
                        "supplierCode" : {
                            "type" : "string",
                            "caption" : "Supplier Code"
                        },
                        "supplierName" : {
                            "type" : "string",
                            "caption" : "Supplier Name"
                        },
                        "iluNumber" : {
                            "type" : "string",
                            "caption" : "ILUNumber"
                        },
                        "product" : {
                            "type" : "string",
                            "caption" : "Product"
                        },
                        "uom" : {
                            "type" : "string",
                            "caption" : "UOM"
                        },
                        "cost" : {
                            "type" : "number",
                            "caption" : "Cost"
                        },
                        "qty" : {
                            "type" : "number",
                            "caption" : "QTY"
                        },
                        "carriageCharge" : {
                            "type" : "number",
                            "caption" : "Carriage Charge"
                        },
                        "orderRaisedBy" : {
                            "type" : "string",
                            "caption" : "Order Raised By"
                        },
                        "orderUpdatedBy" : {
                            "type" : "string",
                            "caption" : "Order Updated By"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'spRptStockHolding' or [Name] = 'Stock Holding Report') AND [AccountId] IS NULL)
    DELETE FROM [dbo].[Reports] where ([Name] = 'spRptStockHolding' or [Name] = 'Stock Holding Report') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Stock Holding Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
        'Stock Holding Report', 'Stock Holding Report', 2, NULL, 
        '
            {
                "type": 1,
                "text": "Stock Holding Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": false,
                "api": "/api/Report/spRptStockHolding",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branch"
                            },
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "product"
                            },
                            {
                                "uniqueName": "branchCode"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "supplierProductCode"
                            },
                            {
                                "uniqueName": "catalogueStatus"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "stockQuantityOnHand",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "stockValuation",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "onOrderQuantity",
                                "aggregation": "sum",
                                "format": "number"
                            },
                            {
                                "uniqueName": "onOrderValue",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "last24HQuantity",
                                "aggregation": "sum",
                                "format": "number"
                            },
                            {
                                "uniqueName": "last7DayQuantity",
                                "aggregation": "sum",
                                "format": "number"
                            },
                            {
                                "uniqueName": "last4WeeksQuantity",
                                "aggregation": "sum",
                                "format": "number"
                            },
                            {
                                "uniqueName": "stockValue",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "cost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "retail",
                                "aggregation": "sum",
                                "format": "number"
                            },
                            {
                                "uniqueName": "minLevel",
                                "aggregation": "sum",
                                "format": "number"
                            },
                            {
                                "uniqueName": "parLevel",
                                "aggregation": "sum",
                                "format": "number"
                            },
                            {
                                "uniqueName": "maxLevel",
                                "aggregation": "sum",
                                "format": "number"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branch": {
                            "type": "string",
                            "caption": "Branch"
                        },
                        "supplierCode": {
                            "type": "string",
                            "caption": "Supplier Code"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        },
                        "product": {
                            "type": "string",
                            "caption": "Product"
                        },
                        "stockQuantityOnHand": {
                            "type": "number",
                            "caption": "Stock Quantity On Hand"
                        },
                        "stockValuation": {
                            "type": "number",
                            "caption": "Stock Valuation"
                        },
                        "onOrderQuantity": {
                            "type": "number",
                            "caption": "On Order Quantity"
                        },
                        "onOrderValue": {
                            "type": "number",
                            "caption": "On Order Value"
                        },
                        "last24HQuantity": {
                            "type": "number",
                            "caption": "Last 24H Quantity"
                        },
                        "last7DayQuantity": {
                            "type": "number",
                            "caption": "Last 7 Day Quantity"
                        },
                        "last4WeeksQuantity": {
                            "type": "number",
                            "caption": "Last 4 Weeks Quantity"
                        },
                        "stockValue": {
                            "type": "number",
                            "caption": "Stock Value"
                        },
                        "cost": {
                            "type": "number",
                            "caption": "Cost"
                        },
                        "retail": {
                            "type": "number",
                            "caption": "Retail"
                        },
                        "branchCode": {
                            "type": "string",
                            "caption": "Branch Code"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "supplierProductCode": {
                            "type": "string",
                            "caption": "Supplier Product Code"
                        },
                        "minLevel": {
                            "type": "number",
                            "caption": "Min Level"
                        },
                        "parLevel": {
                            "type": "number",
                            "caption": "Par Level"
                        },
                        "maxLevel": {
                            "type": "number",
                            "caption": "Max Level"
                        },
                        "catalogueStatus": {
                            "type": "string",
                            "caption": "Catalogue Status"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
        '
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Declaration' AND [AccountId] IS NULL)
    DELETE FROM [dbo].[Reports] where [Name] = 'Declaration' AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Declaration' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Declaration', 'Declaration', 1, NULL, 
		'
            {
                "type": 1,
                "text": "Declaration Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": true,
                "api": "/api/Report/Declaration",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "ds+Date"
                            },
                            {
                                "uniqueName": "till"
                            },
                            {
                                "uniqueName": "user"
                            },
                            {
                                "uniqueName": "userEod"
                            },
                            {
                                "uniqueName": "tender"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "amountDeclared",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "amountCalculated",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "difference",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "ds+Date": {
                            "type": "date string",
                            "caption": "Date"
                        },
                        "till": {
                            "type": "string",
                            "caption": "Till"
                        },
                        "user": {
                            "type": "string",
                            "caption": "User"
                        },
                        "tender": {
                            "type": "string",
                            "caption": "Tender"
                        },
                        "amountDeclared": {
                            "type": "number",
                            "caption": "AmountDeclared"
                        },
                        "amountCalculated": {
                            "type": "number",
                            "caption": "AmountCalculated"
                        },
                        "difference": {
                            "type": "number",
                            "caption": "Difference"
                        },
                        "userEod": {
                            "type": "string",
                            "caption": "User EOD"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 2
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'spRptProductPriceList' or [Name] = 'Product Price List Report') and [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'spRptProductPriceList' or [Name] = 'Product Price List Report') and [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Product Price List Report' and [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Product Price List Report', 'Product Price List Report', 5, NULL, 
		'
            {
                "type": 1,
                "text": "Product Price List Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": true,
                "api": "/api/Report/spRptProductPriceList",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branch"
                            },
                            {
                                "uniqueName": "product"
                            },
                            {
                                "uniqueName": "priceLevel"
                            },
                            {
                                "uniqueName": "ds+FutureStartDate"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                            "uniqueName": "supplierProductCode"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "currentPrice",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "futurePrice",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branch": {
                            "type": "string",
                            "caption": "Branch"
                        },
                        "product": {
                            "type": "string",
                            "caption": "Product"
                        },
                        "priceLevel": {
                            "type": "string",
                            "caption": "Price Level"
                        },
                        "currentPrice": {
                            "type": "number",
                            "caption": "Current Price"
                        },
                        "futurePrice": {
                            "type": "number",
                            "caption": "Future Price"
                        },
                        "ds+FutureStartDate": {
                            "type": "date string",
                            "caption": "Future Start Price"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "supplierProductCode": {
                            "type": "string",
                            "caption": "Supplier Product Code"
                        }


                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 2
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'spRptProductCost' or [Name] = 'Product Cost Report') and [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'spRptProductCost' or [Name] = 'Product Cost Report') and [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Product Cost Report' and [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
        'Product Cost Report', 'Product Cost Report', 5, NULL, 
        '
            {
                "type": 1,
                "text": "Product Cost Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": true,
                "api": "/api/Report/spRptProductCost",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branch"
                            },
                            {
                                "uniqueName": "product"
                            },
                            {
                                "uniqueName": "ds+Date"
                            },
                            {
                                "uniqueName": "cost"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "supplierProductCode"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "quantity",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "totalProductCosts",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "totalSales",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "stockHeld",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "salesQTY",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "retailPrice",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branch": {
                            "type": "string",
                            "caption": "Branch"
                        },
                        "product": {
                            "type": "string",
                            "caption": "Product"
                        },
                        "ds+Date": {
                            "type": "date string",
                            "caption": "Date"
                        },
                        "quantity": {
                            "type": "number",
                            "caption": "Quantity"
                        },
                        "cost": {
                            "type": "number",
                            "caption": "Cost"
                        },
                        "totalProductCosts": {
                            "type": "number",
                            "caption": "Total Product Costs"
                        },
                        "totalSales": {
                            "type": "number",
                            "caption": "Total Sales"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "supplierProductCode": {
                            "type": "string",
                            "caption": "Supplier Product Code"
                        },         
                        "stockHeld": {
                            "type": "number",
                            "caption": "QTY on hand"
                        },
                        "salesQTY": {
                            "type": "number",
                            "caption": "Sales QTY"
                        },
                        "retailPrice": {
                            "type": "number",
                            "caption": "Price"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
        '
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Ticket Data' AND [AccountId] IS NULL)
    DELETE FROM [dbo].[Reports] where [Name] = 'Ticket Data' AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Ticket Data' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Ticket Data', 'Ticket Data', 5, NULL, 
		'
			{
                "type": 1,
                "text": "Ticket Data",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": false,
                "api": "/api/Report/spRptTicketData",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "ds+Date"
                            },
                            {
                                "uniqueName": "branch"
                            },
                            {
                                "uniqueName": "transactionNumber"
                            },
                            {
                                "uniqueName": "operator"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "productName"
                            },
                            {
                                "uniqueName": "preferredSupplierName"
                            },
                            {
                                "uniqueName": "formFieldName"
                            },
                            {
                                "uniqueName": "formFieldPhoneNumber"
                            },
                            {
                                "uniqueName": "ds+FormFieldDateOfEvent"
                            },
                            {
                                "uniqueName": "formFieldDayOfEvent"
                            },
                            {
                                "uniqueName": "formFieldTimeOfEvent"
                            },
                            {
                                "uniqueName": "formFieldLocation"
                            },
                            {
                                "uniqueName": "formFieldGeneralComment"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "formFieldAdultTicket",
                                "aggregation": "sum"
                            },
                            {
                                "uniqueName": "formFieldSeniorCitizenTickets",
                                "aggregation": "sum"
                            },
                            {
                                "uniqueName": "formFieldChildTickets",
                                "aggregation": "sum"
                            },
                            {
                                "uniqueName": "formFieldStudentTickets",
                                "aggregation": "sum"
                            },
                            {
                                "uniqueName": "salesQuantity",
                                "aggregation": "sum"
                            },
                            {
                                "uniqueName": "salesValue",
                                "aggregation": "sum"
                            },
                            {
                                "uniqueName": "formFieldIV",
                                "aggregation": "sum"
                            },
                            {
                                "uniqueName": "formFieldKey",
                                "aggregation": "sum"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "ds+Date": {
                            "type": "date string",
                            "caption": "Date"
                        },
                        "branch": {
                            "type": "string",
                            "caption": "Branch"
                        },                        
                        "transactionNumber": {
                            "type": "string",
                            "caption": "Transaction Number"
                        },
                        "operator": {
                            "type": "string",
                            "caption": "Operator"                        
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "productName": {
                            "type": "string",
                            "caption": "Product Name"
                        },
                        "preferredSupplierName": {
                            "type": "string",
                            "caption": "Preferred Supplier Name"
                        },
                        "salesQuantity": {
                            "type": "number",
                            "caption": "Sales Quantity"
                        },
                        "salesValue": {
                            "type": "number",
                            "caption": "Sales Value"
                        },
                        "formFieldName": {
                            "type": "string",
                            "caption": "Form Field Name"
                        },
                        "formFieldPhoneNumber": {
                            "type": "string",
                            "caption": "Form Field Phone Number"
                        },
                        "ds+FormFieldDateOfEvent": {
                            "type": "date string",
                            "caption": "Form Field Date Of Event"
                        },
                        "formFieldDayOfEvent": {
                            "type": "string",
                            "caption": "Form Field Day Of Event"
                        },
                        "formFieldTimeOfEvent": {
                            "type": "string",
                            "caption": "Form Field Time Of Event"
                        },
                        "formFieldLocation": {
                            "type": "string",
                            "caption": "Form Field Location"
                        },
                        "formFieldAdultTicket": {
                            "type": "number",
                            "caption": "Form Field Adult Ticket"
                        },
                        "formFieldSeniorCitizenTickets": {
                            "type": "number",
                            "caption": "Form Field Senior Citizen Tickets"
                        },
                        "formFieldChildTickets": {
                            "type": "number",
                            "caption": "Form Field Child Tickets"
                        },
                        "formFieldStudentTickets": {
                            "type": "number",
                            "caption": "Form Field Student Tickets"
                        },
                        "formFieldGeneralComment": {
                            "type": "string",
                            "caption": "Form Field General Comment"
                        },
                        "formFieldIV": {
                            "type": "number",
                            "caption": "Form Field IV"
                        },
                        "formFieldKey": {
                            "type": "number",
                            "caption": "Form Field Key"
                        }

                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 2
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'spRptSuppliers' or [Name] = 'Supplier Report') AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'spRptSuppliers' or [Name] = 'Supplier Report') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Supplier Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Supplier Report', 'Supplier Report', 2, NULL, 
		'
            {
                "type": 1,
                "text": "Suppliers Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": true,
                "api": "/api/Report/spRptSuppliers",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "emailAddress"
                            },
                            {
                                "uniqueName": "address"
                            },
                            {
                                "uniqueName": "postCode"
                            },
                            {
                                "uniqueName": "contactName"
                            },
                            {
                                "uniqueName": "phoneNumber"
                            },
                            {
                                "uniqueName": "minimumOrderValue"
                            },
                            {
                                "uniqueName": "maximumOrderValue"
                            },
                            {
                                "uniqueName": "minimumValue"
                            },
                            {
                                "uniqueName": "carriageCharge"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "supplierCode": {
                            "type": "string",
                            "caption": "Supplier Code"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        },
                        "emailAddress": {
                            "type": "string",
                            "caption": "Email Address"
                        },
                        "address": {
                            "type": "string",
                            "caption": "Address"
                        },
                        "postCode": {
                            "type": "string",
                            "caption": "Post Code"
                        },
                        "contactName": {
                            "type": "string",
                            "caption": "Contact Name"
                        },
                        "phoneNumber": {
                            "type": "string",
                            "caption": "Phone Number"
                        },
                        "approveRequired": {
                            "type": "string",
                            "caption": "Approve Required"
                        },
                        "leadDays": {
                            "type": "number",
                            "caption": "Lead Days"
                        },
                        "minimumOrderValue": {
                            "type": "number",
                            "caption": "Minimum Order Value"
                        },
                        "maximumOrderValue": {
                            "type": "number",
                            "caption": "Maximum Order Value"
                        },
                        "minimumValue": {
                            "type": "number",
                            "caption": "Minimum value - carriage paid"
                        },
                        "carriageCharge": {
                            "type": "number",
                            "caption": "Carriage Charge"
                        },
                        "active": {
                            "type": "string",
                            "caption": "Active"
                        },
                        "createdBy": {
                            "type": "string",
                            "caption": "Created By"
                        },
                        "ds+CreatedDate": {
                            "type": "date string",
                            "caption": "Created Date"
                        },
                        "updatedBy": {
                            "type": "string",
                            "caption": "Updated By"
                        },
                        "ds+UpdatedDate": {
                            "type": "date string",
                            "caption": "Updated Date"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 2
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'spRptDeviceSync' or [Name] = 'Sync Report') AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'spRptDeviceSync' or [Name] = 'Sync Report') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Sync Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
        'Sync Report', 'Sync Report', 5, NULL, 
        '
            {
                "type": 1,
                "text": "Device Sync Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": true,
                "api": "/api/Report/spRptDeviceSync",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "dateTimePattern": "dd/MM/yyyy HH:mm:ss"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branch"
                            },
                            {
                                "uniqueName": "deviceName"
                            },
                            {
                                "uniqueName": "serial"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "ds+LastSODTime",
                                "aggregation": "max"
                            },
                            {
                                "uniqueName": "ds+LastEODTime",
                                "aggregation": "max"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branch": {
                            "type": "string",
                            "caption": "Branch"
                        },
                        "deviceName": {
                            "type": "string",
                            "caption": "Device"
                        },
                        "serial": {
                            "type": "string",
                            "caption": "Serial"
                        },
                        "ds+LastSODTime": {
                            "type": "datetime",
                            "caption": "Last SOD Time"
                        },
                        "ds+LastEODTime": {
                            "type": "datetime",
                            "caption": "Last EOD Time"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 2
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
        '
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Item Movement' AND [AccountId] IS NULL)
    DELETE FROM [dbo].[Reports] where [Name] = 'Item Movement' AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Item Movement' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Item Movement', 'Item Movement', 2, NULL, 
		'
			{
                "type": 1,
                "text": "Item Movement",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": false,
                "api": "/api/Report/ItemMovement",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branchCode"
                            },
                            {
                                "uniqueName": "branchName"
                            },
                            {
                                "uniqueName": "transferDestination"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "productName"
                            },
                            {
                                "uniqueName": "movementType"
                            },
                            {
                                "uniqueName": "ds+Date"
                            },
                            {
                                "uniqueName": "createdBy"
                            },
                            {
                                "uniqueName": "time"
                            },
                            {
                                "uniqueName": "ds+LastUpdate"
                            },
                            {
                                "uniqueName": "lastUpdateBy"
                            },
                            {
                                "uniqueName": "movementNo"
                            },
                            {
                                "uniqueName": "supplierName"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "beforeQTY",
                                "aggregation": "sum"
                            },
                            {
                                "uniqueName": "adjustmentQuantity",
                                "aggregation": "sum"
                            },
                            {
                                "uniqueName": "afterQTY",
                                "aggregation": "sum"
                            },
                            {
                                "uniqueName": "unitCost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "lastDeliveryCost",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branchCode": {
                            "type": "string",
                            "caption": "Branch Code"
                        },
                        "branchName": {
                            "type": "string",
                            "caption": "Branch Name"
                        },
                        "transferDestination": {
                            "type": "string",
                            "caption": "Transfer Destination"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "productName": {
                            "type": "string",
                            "caption": "Product Name"
                        },
                        "movementType": {
                            "type": "string",
                            "caption": "Movement Type"
                        },
                        "beforeQTY": {
                            "type": "number",
                            "caption": "Before QTY"
                        },
                        "adjustmentQuantity": {
                            "type": "number",
                            "caption": "Adjustment QTY"
                        },
                        "unitCost": {
                            "type": "number",
                            "caption": "Unit Cost"
                        },
                        "lastDeliveryCost": {
                            "type": "number",
                            "caption": "Last Delivery Cost"
                        },
                        "ds+Date": {
                            "type": "date string",
                            "caption": "Date"
                        },
                        "createdBy": {
                            "type": "string",
                            "caption": "Created By"
                        },
                        "ds+LastUpdate": {
                            "type": "date string",
                            "caption": "Last Update"
                        },
                        "lastUpdateBy": {
                            "type": "string",
                            "caption": "Last Update By"
                        },
                        "time": {
                            "type": "string",
                            "caption": "Time"
                        },
                        "afterQTY": {
                            "type": "number",
                            "caption": "After QTY"
                        },
                        "movementNo": {
                            "type": "string",
                            "caption": "Movement No"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Historical Stock Holding' AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where [Name] = 'Historical Stock Holding' AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Historical Stock Holding' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Historical Stock Holding', 'Historical Stock Holding', 2, NULL, 
		'
			{
                "type": 1,
                "text": "Historical Stock Holding",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": true,
                "api": "/api/Report/HistoricalStockHolding",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branch"
                            },
                            {
                                "uniqueName": "branchCode"
                            },
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "product"
                            },                                                     
                            {
                                "uniqueName": "ds+CreatedDate"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "cost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "stockQuantityOnHand",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "stockValuation",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                           
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branch": {
                            "type": "string",
                            "caption": "Branch"
                        },
                        "branchCode": {
                            "type": "string",
                            "caption": "Branch Code"
                        },
                        "supplierCode": {
                            "type": "string",
                            "caption": "Supplier Code"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "product": {
                            "type": "string",
                            "caption": "Product"
                        },
                        "stockQuantityOnHand": {
                            "type": "number",
                            "caption": "Stock Quantity On Hand"
                        },
                        "stockValuation": {
                            "type": "number",
                            "caption": "Stock Valuation"
                        },
                        "cost": {
                            "type": "number",
                            "caption": "Cost"
                        },
                        
                        "ds+CreatedDate" : {
                            "type" : "date string",
                            "caption": "Created Date"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
        '
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Audit' AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where [Name] = 'Audit' AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Audit' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Audit', 'Audit', 5, NULL, 
		'
			{
                "type": 1,
                "text": "Audit Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": true,
                "api": "/api/Report/Audit",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "flat",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "ds+EditDate"
                            },
                            {
                                "uniqueName": "editTime"
                            },
                            {
                                "uniqueName": "module"
                            },
                            {
                                "uniqueName": "field"
                            },
                            {
                                "uniqueName": "user"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "ds+EditDate": {
                            "type": "date string",
                            "caption": "Edit Date"
                        },
                        "editTime": {
                            "type": "string",
                            "caption": "Edit Time"
                        },
                        "module": {
                            "type": "string",
                            "caption": "Module"
                        },
                        "requestMethod": {
                            "type": "string",
                            "caption": "Request Method"
                        },
                        "requestUrl": {
                            "type": "string",
                            "caption": "Request URL"
                        },
                        "field": {
                            "type": "string",
                            "caption": "Details"
                        },
                        "user": {
                            "type": "string",
                            "caption": "User"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 2
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'NoSaleReason' or [Name] = 'No Sale Report') AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'NoSaleReason' or [Name] = 'No Sale Report') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'No Sale Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'No Sale Report', 'No Sale Report', 1, NULL, 
		'
            {
                "type": 1,
                "text": "No Sale Reason Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": true,
                "api": "/api/Report/NoSaleReason",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "flat",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "ds+Date"
                            },
                            {
                                "uniqueName": "time"
                            },
                            {
                                "uniqueName": "branchName"
                            },
                            {
                                "uniqueName": "deviceSerial"
                            },
                            {
                                "uniqueName": "userName"
                            },
                            {
                                "uniqueName": "noSaleReasonName"
                            },
                            {
                                "uniqueName": "noSaleReasonCode"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "ds+Date": {
                            "type": "date string",
                            "caption": "Date"
                        },
                        "time": {
                            "type": "string",
                            "caption": "Time"
                        },
                        "branchName": {
                            "type": "string",
                            "caption": "Branch"
                        },
                        "deviceSerial": {
                            "type": "string",
                            "caption": "Device"
                        },
                        "userName": {
                            "type": "string",
                            "caption": "User Name"
                        },
                        "noSaleReasonName": {
                            "type": "string",
                            "caption": "No Sale Reason Name"
                        },
                        "noSaleReasonCode": {
                            "type": "string",
                            "caption": "No Sale Reason Code"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 2
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'StockValuationReport' or [Name] = 'Stock Valuation Report') AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'StockValuationReport' or [Name] = 'Stock Valuation Report') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Stock Valuation Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Stock Valuation Report', 'Stock Valuation Report', 2, NULL, 
		'
			{
                "type": 1,
                "text": "Stock Valuation Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": false,
                "api": "/api/Report/StockValuationReport",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branch"
                            },
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "orderPO"
                            },
                            {
                                "uniqueName": "ds+OrderDate"
                            },
                            {
                                "uniqueName": "ds+DeliveryDate"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "productName"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "itemCost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "deliveredQTY",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "issuedQTY",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "remainingQTY",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "stockValuation",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branch": {
                            "type": "string",
                            "caption": "Branch"
                        },
                        "supplierCode": {
                            "type": "string",
                            "caption": "Supplier Code"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        },
                        "orderPO": {
                            "type": "string",
                            "caption": "Order PO"
                        },
                        "ds+OrderDate": {
                            "type": "date string",
                            "caption": "Order Date"
                        },
                        "ds+DeliveryDate": {
                            "type": "date string",
                            "caption": "Delivery Date"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "productName": {
                            "type": "string",
                            "caption": "Product Name"
                        },
                        "itemCost": {
                            "type": "number",
                            "caption": "Item Cost"
                        },
                        "deliveredQTY": {
                            "type": "number",
                            "caption": "Delivered QTY"
                        },
                        "issuedQTY": {
                            "type": "number",
                            "caption": "Issued QTY"
                        },
                        "remainingQTY": {
                            "type": "number",
                            "caption": "Remaining QTY"
                        },
                        "stockValuation": {
                            "type": "number",
                            "caption": "Stock Valuation"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'spRptStockCounts' or [Name] = 'Stock Count Report') AND [AccountId] IS NULL)
    DELETE FROM [dbo].[Reports] where ([Name] = 'spRptStockCounts' or [Name] = 'Stock Count Report') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Stock Count Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Stock Count Report', 'Stock Count Report', 2, NULL, 
		'
            {
                "type": 1,
                "text": "Stock Count Details",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": true,
                "api": "/api/Report/spRptStockCounts",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "ds+DateCounted"
                            },
                            {
                                "uniqueName": "ds+DateApproved"
                            },
                            {
                                "uniqueName": "countNumber"
                            },
                            {
                                "uniqueName": "location"
                            },
                            {
                                "uniqueName": "countStatus"
                            },
                            {
                                "uniqueName": "countType"
                            },
                            {
                                "uniqueName": "countedUser"
                            },
                            {
                                "uniqueName": "approvedUser"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "productGroup"
                            },
                            {
                                "uniqueName": "productName"
                            },
                            {
                                "uniqueName": "comments"
                            }
                           
                        ],
                        "measures": [
                            {
                                "uniqueName": "cost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "expectedQTY",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "countedQTY",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "approvedQTY",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "qtyVariance",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "costVariance",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "ds+DateCounted": {
                            "type": "date string",
                            "caption": "Date Counted"
                        },
                        "ds+DateApproved": {
                            "type": "date string",
                            "caption": "Date Approved"
                        },
                        "countNumber": {
                            "type": "string",
                            "caption": "Count Number"
                        },
                        "location": {
                            "type": "string",
                            "caption": "Location"
                        },
                        "countStatus": {
                            "type": "string",
                            "caption": "Count Status"
                        },
                        "countType": {
                            "type": "string",
                            "caption": "Count Type"
                        },
                        "countedUser": {
                            "type": "string",
                            "caption": "Counted User"
                        },
                        "approvedUser": {
                            "type": "string",
                            "caption": "Approved User"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "supplierCode": {
                            "type": "string",
                            "caption": "Supplier Code"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        },
                        "productGroup": {
                            "type": "string",
                            "caption": "Product Group"
                        },
                        "productName": {
                            "type": "string",
                            "caption": "Product Name"
                        },
                        "cost": {
                            "type": "number",
                            "caption": "Cost"
                        },
                        "expectedQTY": {
                            "type": "number",
                            "caption": "Expected QTY"
                        },
                        "countedQTY": {
                            "type": "number",
                            "caption": "Counted QTY"
                        },
                        "approvedQTY": {
                            "type": "number",
                            "caption": "Approved QTY"
                        },
                        "qtyVariance": {
                            "type": "number",
                            "caption": "QTY Variance"
                        },
                        "costVariance": {
                            "type": "number",
                            "caption": "Cost Variance"
                        },
                        "comments": {
                            "type": "string",
                            "caption": "Comments"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

update reports set type = 1 where name = 'Sales Report' or name = 'Product Export Code' or name = 'No Sale Report'
								or name = 'Tender Export Code' or name = 'Ticketing Commission' or name ='Declaration'

update reports set type = 2 where name = 'Goods Receipted' or name = 'Supplier Catalogue' or name = 'Orders To Suppliers Report'
								or name = 'Stock Adjustment Details' or name = 'Order To Supplier' or name ='Stock Holding Report'
								or name = 'Historical Stock Holding' or name = 'Stock Transfer Details' or name ='Item Movement'
								or name = 'Supplier Report' or name = 'Stock Valuation Report' or name ='Stock Count Report'

update reports set type = 5 where name = 'Products' or name = 'Product Cost Report' or name = 'Product Price List Report'
								or name = 'Sync Report' or name = 'Ticket Data' or name ='Audit'

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'Historical Stock Valuation Report') AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'Historical Stock Valuation Report') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Historical Stock Valuation Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Historical Stock Valuation Report', 'Historical Stock Valuation Report', 2, NULL, 
		'
			{
                "type": 1,
                "text": "Historical Stock Valuation Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": false,
                "api": "/api/Report/HistoricalStockValuationReport",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branch"
                            },
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "orderPO"
                            },
                            {
                                "uniqueName": "ds+OrderDate"
                            },
                            {
                                "uniqueName": "ds+DeliveryDate"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "productName"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "itemCost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "deliveredQTY",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "issuedQTY",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "remainingQTY",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "stockValuation",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branch": {
                            "type": "string",
                            "caption": "Branch"
                        },
                        "supplierCode": {
                            "type": "string",
                            "caption": "Supplier Code"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        },
                        "orderPO": {
                            "type": "string",
                            "caption": "Order PO"
                        },
                        "ds+OrderDate": {
                            "type": "date string",
                            "caption": "Order Date"
                        },
                        "ds+DeliveryDate": {
                            "type": "date string",
                            "caption": "Delivery Date"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "productName": {
                            "type": "string",
                            "caption": "Product Name"
                        },
                        "itemCost": {
                            "type": "number",
                            "caption": "Item Cost"
                        },
                        "deliveredQTY": {
                            "type": "number",
                            "caption": "Delivered QTY"
                        },
                        "issuedQTY": {
                            "type": "number",
                            "caption": "Issued QTY"
                        },
                        "remainingQTY": {
                            "type": "number",
                            "caption": "Remaining QTY"
                        },
                        "stockValuation": {
                            "type": "number",
                            "caption": "Stock Valuation"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'Negative Stock Sales Report') AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'Negative Stock Sales Report') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Negative Stock Sales Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Negative Stock Sales Report', 'Negative Stock Sales Report', 1, NULL, 
		'
			{
                "type": 1,
                "text": "Negative Stock Sales Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": false,
                "api": "/api/Report/spRptNegativeStockSales",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branchCode"
                            },
                            {
                                "uniqueName": "branchName"
                            },
                            {
                                "uniqueName": "device"
                            },
                            {
                                "uniqueName": "user"
                            },
                            {
                                "uniqueName": "ds+Date"
                            },
                            {
                                "uniqueName": "time"
                            },
                            {
                                "uniqueName": "saleType"
                            },
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "reOrderNumber"
                            },
                            {
                                "uniqueName": "productGroupName"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "productName"
                            },
                            {
                                "uniqueName": "barCode"
                            },
                            {
                                "uniqueName": "receiptNo"
                            },
                            {
                                "uniqueName": "discountReason"
                            },
                            {
                                "uniqueName": "refundReason"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "taxRate",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "stockOnHand",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "quantity",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "total",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "vat",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "netPrice",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "productCost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "discountAmount",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "commission",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branchCode": {
                            "type": "string",
                            "caption": "Branch Code"
                        },
                        "branchName": {
                            "type": "string",
                            "caption": "Branch Name"
                        },
                        "device": {
                            "type": "string",
                            "caption": "Device"
                        },
                        "user": {
                            "type": "string",
                            "caption": "User"
                        },
                        "ds+Date": {
                            "type": "date string",
                            "caption": "Date"
                        },
                        "time": {
                            "type": "string",
                            "caption": "Time"
                        },
                        "saleType": {
                            "type": "string",
                            "caption": "SaleType"
                        },
                        "supplierCode": {
                            "type": "string",
                            "caption": "Supplier Code"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        },
                        "reOrderNumber": {
                            "type": "string",
                            "caption": "Re Order Number"
                        },
                        "productGroupName": {
                            "type": "string",
                            "caption": "Product Group Name"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "productName": {
                            "type": "string",
                            "caption": "Product Name"
                        },
                        "barCode": {
                            "type": "string",
                            "caption": "Bar Code"
                        },
                        "receiptNo": {
                            "type": "string",
                            "caption": "Receipt No"
                        },
                        "discountReason": {
                            "type": "string",
                            "caption": "Discount Reason"
                        },
                        "refundReason": {
                            "type": "string",
                            "caption": "Refund Reason"
                        },
                        "stockOnHand": {
                            "type": "number",
                            "caption": "Stock On Hand"
                        },
                        "quantity": {
                            "type": "number",
                            "caption": "Quantity"
                        },
                        "total": {
                            "type": "number",
                            "caption": "Total"
                        },
                        "vat": {
                            "type": "number",
                            "caption": "Vat"
                        },
                        "netPrice": {
                            "type": "number",
                            "caption": "NetPrice"
                        },
                        "productCost": {
                            "type": "number",
                            "caption": "Product Cost"
                        },
                        "discountAmount": {
                            "type": "number",
                            "caption": "Discount Amount"
                        },
                        "commission": {
                            "type": "number",
                            "caption": "Commission"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'Product Profitability Report') AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'Product Profitability Report') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Product Profitability Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Product Profitability Report', 'Product Profitability Report', 1, NULL, 
		'
			{
                "type": 1,
                "text": "Product Profitability Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": false,
                "api": "/api/Report/spRptProductProfitability",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branch"
                            },
                            {
                                "uniqueName": "supplier"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "product"
                            },
                            {
                                "uniqueName": "priceLevel"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "productCost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "taxRate",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "retailPrice",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branch": {
                            "type": "string",
                            "caption": "Branch"
                        },
                        "supplier": {
                            "type": "string",
                            "caption": "Supplier"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "product": {
                            "type": "string",
                            "caption": "Product"
                        },
                        "productCost": {
                            "type": "number",
                            "caption": "Product Cost"
                        },
                        "taxRate": {
                            "type": "number",
                            "caption": "Tax Rate"
                        },
                        "priceLevel": {
                            "type": "number",
                            "caption": "Price Level"
                        },
                        "retailPrice": {
                            "type": "number",
                            "caption": "Retail Price"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'Sales') AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'Sales') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Sales' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Sales', 'Sales', 1, NULL, 
		'
			{
                "type": 1,
                "text": "Sales",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": false,
                "api": "/api/Report/spRptSales",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branchCode"
                            },
                            {
                                "uniqueName": "branchName"
                            },
                            {
                                "uniqueName": "ds+Date"
                            },
                            {
                                "uniqueName": "time"
                            },
                            {
                                "uniqueName": "device"
                            },
                            {
                                "uniqueName": "receiptNo"
                            },
                            {
                                "uniqueName": "saleType"
                            },
                            {
                                "uniqueName": "user"
                            },
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "reOrderNumber"
                            },
                            {
                                "uniqueName": "productGroupName"
                            },
                            {
                                "uniqueName": "productSubGroupName"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "productName"
                            },
                            {
                                "uniqueName": "barCode"
                            },
                            {
                                "uniqueName": "discountReason"
                            },
                            {
                                "uniqueName": "refundReason"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "taxRate",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "quantity",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "total",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "vat",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "netPrice",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "productCost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "discountAmount",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "commission",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branchCode": {
                            "type": "string",
                            "caption": "Branch Code"
                        },
                        "branchName": {
                            "type": "string",
                            "caption": "Branch Name"
                        },
                        "ds+Date": {
                            "type": "date string",
                            "caption": "Date"
                        },
                        "time": {
                            "type": "string",
                            "caption": "Time"
                        },
                        "device": {
                            "type": "string",
                            "caption": "Device"
                        },
                        "receiptNo": {
                            "type": "string",
                            "caption": "Receipt No"
                        },
                        "saleType": {
                            "type": "string",
                            "caption": "Sale Type"
                        },
                        "user": {
                            "type": "string",
                            "caption": "User"
                        },
                        "supplierCode": {
                            "type": "string",
                            "caption": "Supplier Code"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        },
                        "reOrderNumber": {
                            "type": "string",
                            "caption": "Re Order Number"
                        },
                        "productGroupName": {
                            "type": "string",
                            "caption": "Product Group Name"
                        },
                        "productSubGroupName": {
                            "type": "string",
                            "caption": "Product Sub Group Name"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "productName": {
                            "type": "string",
                            "caption": "Product Name"
                        },
                        "barCode": {
                            "type": "string",
                            "caption": "Bar Code"
                        },
                        "discountReason": {
                            "type": "string",
                            "caption": "Discount Reason"
                        },
                        "refundReason": {
                            "type": "string",
                            "caption": "Refund Reason"
                        },
                        "taxRate": {
                            "type": "number",
                            "caption": "Tax Rate"
                        },
                        "quantity": {
                            "type": "number",
                            "caption": "Quantity"
                        },
                        "total": {
                            "type": "number",
                            "caption": "Total"
                        },
                        "vat": {
                            "type": "number",
                            "caption": "Vat"
                        },
                        "netPrice": {
                            "type": "number",
                            "caption": "NetPrice"
                        },
                        "productCost": {
                            "type": "number",
                            "caption": "Product Cost"
                        },
                        "discountAmount": {
                            "type": "number",
                            "caption": "Discount Amount"
                        },
                        "commission": {
                            "type": "number",
                            "caption": "Commission"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'Sales Payment Report') AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'Sales Payment Report') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Sales Payment Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Sales Payment Report', 'Sales Payment Report', 1, NULL, 
		'
			{
                "type": 1,
                "text": "Sales Payment Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": false,
                "api": "/api/Report/spRptSalesPayment",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branchCode"
                            },
                            {
                                "uniqueName": "branch"
                            },
                            {
                                "uniqueName": "deviceNumber"
                            },
                            {
                                "uniqueName": "ds+Date"
                            },
                            {
                                "uniqueName": "operatorCode"
                            },
                            {
                                "uniqueName": "operatorName"
                            },
                            {
                                "uniqueName": "transactionNumber"
                            },
                            {
                                "uniqueName": "tenderCode"
                            },
                            {
                                "uniqueName": "tender"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "amount",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branchCode": {
                            "type": "string",
                            "caption": "Branch Code"
                        },
                        "branch": {
                            "type": "string",
                            "caption": "Branch"
                        },
                        "deviceNumber": {
                            "type": "string",
                            "caption": "Device Number"
                        },
                        "ds+Date": {
                            "type": "date string",
                            "caption": "Date"
                        },
                        "operatorCode": {
                            "type": "string",
                            "caption": "Operator Code"
                        },
                        "operatorName": {
                            "type": "string",
                            "caption": "Operator Name"
                        },
                        "transactionNumber": {
                            "type": "string",
                            "caption": "Transaction Number"
                        },
                        "tenderCode": {
                            "type": "string",
                            "caption": "Tender Code"
                        },
                        "tender": {
                            "type": "string",
                            "caption": "Tender"
                        },
                        "amount": {
                            "type": "number",
                            "caption": "Amount"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'Best Sellers With Profit Report') AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'Best Sellers With Profit Report') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Best Sellers With Profit Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Best Sellers With Profit Report', 'Best Sellers With Profit Report', 1, NULL, 
		'
			{
                "type": 1,
                "text": "Best Sellers With Profit Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": false,
                "api": "/api/Report/spRptBestSellerswithProfit",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branchCode"
                            },
                            {
                                "uniqueName": "branchName"
                            },
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "product"
                            },
                            {
                                "uniqueName": "productGroup"
                            },
                            {
                                "uniqueName": "productSubGroup"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "productCost",
                                "aggregation": "sum",
                                "format": "amount"
                            },  
                            {
                                "uniqueName": "quantity",
                                "aggregation": "sum",
                                "format": "amount"
                            },  
                            {
                                "uniqueName": "total",
                                "aggregation": "sum",
                                "format": "amount"
                            },  
                            {
                                "uniqueName": "vat",
                                "aggregation": "sum",
                                "format": "amount"
                            },  
                            {
                                "uniqueName": "netPrice",
                                "aggregation": "sum",
                                "format": "amount"
                            },  
                            {
                                "uniqueName": "profit",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branchCode": {
                            "type": "string",
                            "caption": "Branch Code"
                        },
                        "branch": {
                            "type": "string",
                            "caption": "Branch"
                        },
                        "deviceNumber": {
                            "type": "string",
                            "caption": "Device Number"
                        },
                        "date": {
                            "type": "string",
                            "caption": "Date"
                        },
                        "operatorCode": {
                            "type": "string",
                            "caption": "Operator Code"
                        },
                        "operatorName": {
                            "type": "string",
                            "caption": "Operator Name"
                        },
                        "transactionNumber": {
                            "type": "string",
                            "caption": "Transaction Number"
                        },
                        "tenderCode": {
                            "type": "string",
                            "caption": "Tender Code"
                        },
                        "tender": {
                            "type": "string",
                            "caption": "Tender"
                        },
                        "amount": {
                            "type": "number",
                            "caption": "Amount"
                        },
                        "productGroup": {
                            "type": "string",
                            "caption": "Product Group"
                        },
                        "productSubGroup": {
                            "type": "string",
                            "caption": "Product Subgroup"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'Stock Replenishment Report') AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'Stock Replenishment Report') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Stock Replenishment Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Stock Replenishment Report', 'Stock Replenishment Report', 2, NULL, 
		'
			{
                "type": 1,
                "text": "Stock Replenishment Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": false,
                "api": "/api/Report/StockReplenishmentReport",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "branchCode"
                            },
                            {
                                "uniqueName": "branchName"
                            },
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "supplierProductCode"
                            },
                            {
                                "uniqueName": "productGroupName"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "product"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "productCost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "stockHeld",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "quantitySold",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "salesTotal",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "branchCode": {
                            "type": "string",
                            "caption": "Branch Code"
                        },
                        "branchName": {
                            "type": "string",
                            "caption": "Branch Name"
                        },
                        "supplierCode": {
                            "type": "string",
                            "caption": "Supplier Code"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        },
                        "supplierProductCode": {
                            "type": "string",
                            "caption": "Supplier Product Code"
                        },
                        "productGroupName": {
                            "type": "string",
                            "caption": "Product Group Name"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "product": {
                            "type": "string",
                            "caption": "Product"
                        },
                        "productCost": {
                            "type": "number",
                            "caption": "Product Cost"
                        },
                        "stockHeld": {
                            "type": "number",
                            "caption": "Stock Held"
                        },
                        "quantitySold": {
                            "type": "number",
                            "caption": "Quantity Sold"
                        },
                        "salesTotal": {
                            "type": "number",
                            "caption": "Sales Total"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'Discount Report' OR [Name] = 'Get Sales And Payments Report') AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'Discount Report' OR [Name] = 'Get Sales And Payments Report') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Discount Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
		'Discount Report', 'Discount Report', 1, NULL, 
		'
			{
                "type": 1,
                "text": "Discount Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": false,
                "api": "/api/Report/DiscountReport",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "ds+Date"
                            },
                            {
                                "uniqueName": "time"
                            },
                            {
                                "uniqueName": "branchName"
                            },
                            {
                                "uniqueName": "saleType"
                            },
                            {
                                "uniqueName": "device"
                            },
                            {
                                "uniqueName": "user"
                            },
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "supplierProductCode"
                            },
                            {
                                "uniqueName": "productGroupName"
                            },
                            {
                                "uniqueName": "product"
                            },
                            {
                                "uniqueName": "barcode"
                            },
                            {
                                "uniqueName": "transactionNumber"
                            },
                            {
                                "uniqueName": "branchCode"
                            },
                            {
                                "uniqueName": "discountReason"
                            },
                            {
                                "uniqueName": "refundReason"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "offerName"
                            },
                            {
                                "uniqueName": "discountedFlag"
                            },
                            {
                                "uniqueName": "productSubGroup"
                            },
                            {
                                "uniqueName": "productType"
                            },
                            {
                                "uniqueName": "transactionID"
                            },
                            {
                                "uniqueName": "payments"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "taxRate",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "productCost",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "commission",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "quantity",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "total",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "vat",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "netPrice",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "discountAmount",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "stockHeld",
                                "aggregation": "sum",
                                "format": "amount"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "ds+Date": {
                            "type": "date string",
                            "caption": "Date"
                        },
                        "time": {
                            "type": "string",
                            "caption": "Time"
                        },
                        "branchName": {
                            "type": "string",
                            "caption": "Branch Name"
                        },
                        "saleType": {
                            "type": "string",
                            "caption": "Sale Type"
                        },
                        "device": {
                            "type": "string",
                            "caption": "Device"
                        },
                        "user": {
                            "type": "string",
                            "caption": "User"
                        },
                        "supplierCode": {
                            "type": "string",
                            "caption": "Supplier Code"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        },
                        "supplierProductCode": {
                            "type": "string",
                            "caption": "Supplier Product Code"
                        },
                        "productGroupName": {
                            "type": "string",
                            "caption": "Product Group Name"
                        },
                        "product": {
                            "type": "string",
                            "caption": "Product"
                        },
                        "taxRate": {
                            "type": "number",
                            "caption": "Tax Rate"
                        },
                        "barcode": {
                            "type": "string",
                            "caption": "Barcode"
                        },
                        "commission": {
                            "type": "number",
                            "caption": "Commission"
                        },
                         "transactionNumber": {
                            "type": "string",
                            "caption": "Transaction Number"
                        },
                        "quantity": {
                            "type": "number",
                            "caption": "Quantity"
                        },
                        "total": {
                            "type": "number",
                            "caption": "Total"
                        },
                        "vat": {
                            "type": "number",
                            "caption": "Vat"
                        },
                        "netPrice": {
                            "type": "number",
                            "caption": "Net Price"
                        },
                        "productCost": {
                            "type": "number",
                            "caption": "Product Cost"
                        },
                        "branchCode": {
                            "type": "string",
                            "caption": "Branch Code"
                        },
                        "discountAmount": {
                            "type": "number",
                            "caption": "Discount Amount"
                        },
                        "discountReason": {
                            "type": "string",
                            "caption": "Discount Reason"
                        },
                        "refundReason": {
                            "type": "string",
                            "caption": "Refund Reason"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "offerName": {
                            "type": "string",
                            "caption": "Offer Name"
                        },
                        "discountedFlag": {
                            "type": "string",
                            "caption": "Discounted Flag"
                        },
                        "productSubGroup": {
                            "type": "string",
                            "caption": "Product Sub Group"
                        },
                        "productType": {
                            "type": "string",
                            "caption": "Product Type"
                        },
                        "transactionID": {
                            "type": "string",
                            "caption": "Transaction ID"
                        },
                        "payments": {
                            "type": "string",
                            "caption": "Payments"
                        },
                        "stockHeld": {
                            "type": "number",
                            "caption": "Stock Held"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
		'
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'Refund Report') AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'Refund Report') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Refund Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
        'Refund Report', 'Refund Report', 1, NULL, 
        '
            {
                "type": 1,
                "text": "Refund Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": true,
                "api": "/api/Report/spRptGetSalesAndPaymentsReport",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "ds+Date"
                            },
                            {
                                "uniqueName": "time"
                            },
                            {
                                "uniqueName": "branchName"
                            },
                            {
                                "uniqueName": "saleType"
                            },
                            {
                                "uniqueName": "device"
                            },
                            {
                                "uniqueName": "user"
                            },
                            {
                                "uniqueName": "supplierCode"
                            },
                            {
                                "uniqueName": "supplierName"
                            },
                            {
                                "uniqueName": "supplierProductCode"
                            },
                            {
                                "uniqueName": "productGroupName"
                            },
                            {
                                "uniqueName": "product"
                            },
                            {
                                "uniqueName": "barcode"
                            },
                            {
                                "uniqueName": "transactionNumber"
                            },
                            {
                                "uniqueName": "productCode"
                            },
                            {
                                "uniqueName": "offerName"
                            },
                            {
                                "uniqueName": "discountedFlag"
                            },
                            {
                                "uniqueName": "productSubGroup"
                            },
                            {
                                "uniqueName": "productType"
                            },
                            {
                                "uniqueName": "transactionID"
                            },
                            {
                                "uniqueName": "payments"
                            },
                            {
                                "uniqueName": "refundReason"
                            },
                            {
                                "uniqueName": "branchCode"
                            },
                            {
                                "uniqueName": "discountReason"
                            },
                            {
                                "uniqueName": "receipt"
                            },
                            {
                                "uniqueName": "operator"
                            },
                            {
                                "uniqueName": "tender"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "taxRate",
                                "aggregation": "average",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "commission",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "quantity",
                                "aggregation": "sum"
                            },
                            {
                                "uniqueName": "total",
                                "aggregation": "sum",
                                "format": "amount"
                            },
                            {
                                "uniqueName": "vat",
                                "aggregation": "sum",
                                "format": "amount",
                                "active": false
                            },
                            {
                                "uniqueName": "netPrice",
                                "aggregation": "sum",
                                "format": "amount",
                                "active": false
                            },
                            {
                                "uniqueName": "productCost",
                                "aggregation": "sum",
                                "format": "amount",
                                "active": false
                            },
                            {
                                "uniqueName": "discountAmount",
                                "aggregation": "sum",
                                "format": "amount",
                                "active": false
                            },
                            {
                                "uniqueName": "stockHeld",
                                "aggregation": "sum",
                                "format": "amount",
                                "active": false
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "ds+Date": {
                            "type": "date string",
                            "caption": "Date"
                        },
                        "time": {
                            "type": "string",
                            "caption": "Sale Time"
                        },
                        "branchName": {
                            "type": "string",
                            "caption": "Branch Name"
                        },
                        "saleType": {
                            "type": "string",
                            "caption": "Sale Type"
                        },
                        "device": {
                            "type": "string",
                            "caption": "Device"
                        },
                        "user": {
                            "type": "string",
                            "caption": "User"
                        },
                        "supplierCode": {
                            "type": "string",
                            "caption": "Supplier Code"
                        },
                        "supplierName": {
                            "type": "string",
                            "caption": "Supplier Name"
                        },
                        "supplierProductCode": {
                            "type": "string",
                            "caption": "Supplier Product Code"
                        },
                        "productGroupName": {
                            "type": "string",
                            "caption": "Product Group Name"
                        },
                        "product": {
                            "type": "string",
                            "caption": "Product"
                        },
                        "taxRate": {
                            "type": "number",
                            "caption": "Tax Rate"
                        },
                        "barcode": {
                            "type": "string",
                            "caption": "Barcode"
                        },
                        "commission": {
                            "type": "number",
                            "caption": "Commission"
                        },
                        "transactionNumber": {
                            "type": "string",
                            "caption": "Transaction Number"
                        },
                        "quantity": {
                            "type": "number",
                            "caption": "Quantity"
                        },
                        "total": {
                            "type": "number",
                            "caption": "Total"
                        },
                        "vat": {
                            "type": "number",
                            "caption": "VAT"
                        },
                        "netPrice": {
                            "type": "number",
                            "caption": "NET Price"
                        },
                        "productCost": {
                            "type": "number",
                            "caption": "Product Cost"
                        },
                        "branchCode": {
                            "type": "string",
                            "caption": "Branch Code"
                        },
                        "discountAmount": {
                            "type": "number",
                            "caption": "Discount Amount"
                        },
                        "discountReason": {
                            "type": "string",
                            "caption": "Discount Reason"
                        },
                        "refundReason": {
                            "type": "string",
                            "caption": "Refund Reason"
                        },
                        "productCode": {
                            "type": "string",
                            "caption": "Product Code"
                        },
                        "offerName": {
                            "type": "string",
                            "caption": "Offer Name"
                        },
                        "discountedFlag": {
                            "type": "string",
                            "caption": "Discounted Flag"
                        },
                        "productSubGroup": {
                            "type": "string",
                            "caption": "Product Sub Group"
                        },
                        "productType": {
                            "type": "string",
                            "caption": "Product Type"
                        },
                        "transactionID": {
                            "type": "string",
                            "caption": "TransactionID"
                        },
                        "payments": {
                            "type": "string",
                            "caption": "Payments"
                        },
                        "stockHeld": {
                            "type": "number",
                            "caption": "Stock Held"
                        },
                        "receipt": {
                            "type": "string",
                            "caption": "Receipt"
                        },
                        "operator": {
                            "type": "string",
                            "caption": "Operator"
                        },
                        "tender": {
                            "type": "string",
                            "caption": "Tender"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
        '
        )
END

IF EXISTS (SELECT * FROM [dbo].[Reports] where ([Name] = 'Daily Visitor Report') AND [AccountId] IS NULL)
DELETE FROM [dbo].[Reports] where ([Name] = 'Daily visitor Report') AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Daily Visitor Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
        'Daily Visitor Report', 'Daily Visitor Report', 1, NULL, 
        '
            {
                "type": 1,
                "text": "Daily Visitor Report",
                "from": "2021-09-12T00:00:00.000Z",
                "to": "2021-09-12T00:00:00.000Z",
                "needDatepicker": true,
                "api": "/api/Report/spRptDailyVisitor",
                "config": {
                    "options": {
                        "viewType": "grid",
                        "grid": {
                            "type": "classic",
                            "showGrandTotals": "off",
                            "showTotals": false
                        },
                        "grouping": false,
                        "showAggregationLabels": false,
                        "datePattern": "dd/MM/yyyy"
                    },
                    "slice": {
                        "rows": [
                            {
                                "uniqueName": "bookingRef"
                            },
                            {
                                "uniqueName": "name"
                            },
                            {
                                "uniqueName": "email"
                            },
                            {
                                "uniqueName": "phone"
                            },
                            {
                                "uniqueName": "timeSlot"
                            },
                            {
                                "uniqueName": "ticket"
                            },
                            {
                                "uniqueName": "bookedOn"
                            },
                            {
                                "uniqueName": "bookingDate"
                            },
                            {
                                "uniqueName": "passengerType"
                            },
                            {
                                "uniqueName": "status"
                            }
                        ],
                        "measures": [
                            {
                                "uniqueName": "count",
                                "aggregation": "sum"
                            }
                        ],
                        "expandAll": true
                    },
                    "dataTypes": {
                        "bookingRef": {
                            "type": "string",
                            "caption": "Booking Ref"
                        },
                        "name": {
                            "type": "string",
                            "caption": "Name"
                        },
                        "email": {
                            "type": "string",
                            "caption": "Email"
                        },
                        "phone": {
                            "type": "string",
                            "caption": "Phone"
                        },
                        "timeSlot": {
                            "type": "string",
                            "caption": "Time Slot"
                        },
                        "ticket": {
                            "type": "string",
                            "caption": "Ticket"
                        },
                        "bookedOn": {
                            "type": "date string",
                            "caption": "Booked On"
                        },
                        "bookedOn": {
                            "type": "date string",
                            "caption": "Booking Date"
                        },
                        "passengerType": {
                            "type": "string",
                            "caption": "Passenger Type"
                        },
                        "count": {
                            "type": "number",
                            "caption": "Count"
                        },
                        "status": {
                            "type": "string",
                            "caption": "Status"
                        }
                    },
                    "formats": [
                        {
                            "name": "amount",
                            "decimalSeparator": ".",
                            "decimalPlaces": 4
                        },
                        {
                            "name": "rightAlign",
                            "textAlign": "right"
                        }
                    ]
                }
            }
        '
        )
END

--
IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Member Activities Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2023-03-23', NULL, '2023-03-23', NULL, NULL, 
		'Member Activities Report', 'Member Activities Report', 5, NULL, 
		'
        {"type":1,"text":"Member Activities Report","from":"2021-09-12T00:00:00.000Z","to":"2021-09-12T00:00:00.000Z","needDatepicker":true,"api":"/api/Report/spRptMemberActivity","config":{"options":{"viewType":"grid","grid":{"type":"classic","showGrandTotals":"off","showTotals":false},"grouping":false,"showAggregationLabels":false,"datePattern":"dd/MM/yyyy"},"slice":{"rows":[{"uniqueName":"memberName"},{"uniqueName":"memberEmail"},{"uniqueName":"memberCode"},{"uniqueName":"cardNumberUsed"},{"uniqueName":"ds+DateOfEntry"},{"uniqueName":"timeOfEntry"},{"uniqueName":"siteEntry"},{"uniqueName":"productPurchased"},{"uniqueName":"accountStatus"}],"measures":[{"uniqueName":"totalValue","aggregation":"sum","format":"amount"},{"uniqueName":"discountApplied","aggregation":"sum","format":"amount"}],"expandAll":true},"dataTypes":{"memberName":{"type":"string","caption":"Member Name"},"memberEmail":{"type":"string","caption":"Member Email"},"memberCode":{"type":"string","caption":"Member Code"},"cardNumberUsed":{"type":"string","caption":"Card Number Used"},"ds+DateOfEntry":{"type":"date string","caption":"DateOfEntry"},"timeOfEntry":{"type":"string","caption":"Time Of Entry"},"siteEntry":{"type":"string","caption":"Site Entry"},"productPurchased":{"type":"string","caption":"Product Purchased"},"accountStatus":{"type":"string","caption":"Account Status"},"totalValue":{"type":"number","caption":"Total Value"},"discountApplied":{"type":"number","caption":"Discount Applied"}},"formats":[{"name":"amount","decimalSeparator":".","decimalPlaces":2}]}}
		'
        )
END
END

--- Voided Transactions Report ---
IF NOT EXISTS (SELECT * FROM [dbo].[Reports] where [Name] = 'Voided Transactions Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [dbo].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
        'Voided Transactions Report', 'Voided Transactions Report', 5, NULL, 
        '
            {"type":5,"text":"Voided Transactions Report","from":"2021-09-12T00:00:00.000Z","to":"2021-09-12T00:00:00.000Z","needDatepicker":true,"api":"/api/Report/SpRptVoidedTransactionReport","config":{"options":{"viewType":"grid","grid":{"type":"classic","showGrandTotals":"off","showTotals":false},"grouping":false,"showAggregationLabels":false,"datePattern":"dd/MM/yyyy"},"slice":{"rows":[{"uniqueName":"ds+Date"},{"uniqueName":"saleTime"},{"uniqueName":"branchCode"},{"uniqueName":"device"},{"uniqueName":"user"},{"uniqueName":"transactionNumber"},{"uniqueName":"product"},{"uniqueName":"productCode"}],"expandAll":true},"dataTypes":{"ds+Date":{"type":"string","caption":"Date"},"saleTime":{"type":"string","caption":"Sale Time"},"branchCode":{"type":"string","caption":"Branch"},"device":{"type":"string","caption":"Device"},"user":{"type":"string","caption":"User"},"transactionNumber":{"type":"string","caption":"Transaction Number"},"product":{"type":"string","caption":"Product"},"productCode":{"type":"string","caption":"Product Code"}},"formats":[{"name":"amount","decimalSeparator":".","decimalPlaces":4},{"name":"rightAlign","textAlign":"right"}]}}
        '
        )
END

---end---