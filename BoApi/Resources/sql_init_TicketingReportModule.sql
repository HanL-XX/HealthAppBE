IF NOT EXISTS (SELECT * FROM [tickets].[Reports] where [Name] = 'Sales Report')
BEGIN
	INSERT INTO [tickets].[Reports] ([AccountId], [Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Name], [Code], [Type], [ConfigName], [Config], [IsPublic]) 
		SELECT id, 0, 1, '2021-09-12', NULL, '2021-09-12', NULL,
        'Sales Report', 'Sales Report', 1, NULL, '', 0 FROM [tickets].AspNetUsers WHERE email like'%administrator@gmail.com%'
END


IF EXISTS (SELECT * FROM [tickets].[Reports] where [Name] = 'Ticket Sales Report' AND [AccountId] IS NULL)
DELETE FROM [tickets].[Reports] where [Name] = 'Ticket Sales Report' AND [AccountId] IS NULL

IF NOT EXISTS (SELECT * FROM [tickets].[Reports] where [Name] = 'Ticket Sales Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [tickets].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
    'Ticket Sales Report', 'Ticket Sales Report', 1, NULL,
    '
        {
            "type": 1,
            "text": "Ticket Sales Report",
            "from": "2021-09-12T00:00:00.000Z",
            "to": "2021-09-12T00:00:00.000Z",
            "needDatepicker": true,
            "api": "/api/TicketingReport/TicketSalesReport",
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
                            "uniqueName" : "saleNo"
                        },
                        {
                            "uniqueName" : "bookingRef"
                        },
                        {
                            "uniqueName" : "ds+DateBooked"
                        },
                        {
                            "uniqueName" : "timeOfBooking"
                        },
                        {
                            "uniqueName" : "schedule"
                        },
                        {
                            "uniqueName" : "ticketName"
                        },
                        {
                            "uniqueName" : "ds+BookingDate"
                        },
                        {
                            "uniqueName" : "timeSlot"
                        },
                        {
                            "uniqueName" : "status"
                        },
                        {
                            "uniqueName" : "salesChannel"
                        },
                        {
                            "uniqueName" : "till"
                        },
                        {
                            "uniqueName" : "paxType"
                        },
                        {
                            "uniqueName" : "opayoRef"
                        },
                        {
                            "uniqueName" : "promoCode"
                        },
                        {
                            "uniqueName" : "taxCode"
                        },
                        {
                            "uniqueName" : "reservedField_1"
                        },
                        {
                            "uniqueName" : "reservedField_2"
                        },
                        {
                            "uniqueName" : "reservedField_3"
                        }
                    ],
                    "measures" : [
                        {
                            "uniqueName" : "qty",
                            "aggregation" : "sum",
                            "format" : "amount"
                        },
                        {
                            "uniqueName" : "bookingValue",
                            "aggregation" : "sum",
                            "format" : "amount"
                        },
                        {
                            "uniqueName" : "paidValue",
                            "aggregation" : "sum",
                            "format" : "amount"
                        },
                        {
                            "uniqueName" : "discount",
                            "aggregation" : "sum",
                            "format" : "amount"
                        },
                        {
                            "uniqueName" : "subtotal",
                            "aggregation" : "sum",
                            "format" : "amount"
                        },
                        {
                            "uniqueName" : "taxRate",
                            "aggregation" : "sum",
                            "format" : "amount"
                        },
                        {
                            "uniqueName" : "Vat",
                            "aggregation" : "sum",
                            "format" : "amount"
                        },
                        {
                            "uniqueName" : "Gross",
                            "aggregation" : "sum",
                            "format" : "amount"
                        },
                        {
                            "uniqueName" : "Net",
                            "aggregation" : "sum",
                            "format" : "amount"
                        }
                    ],
                    "expandAll" : true
                },
                "dataTypes" : {
                    "saleNo" : {
                        "type" : "string",
                        "caption": "Sale No"
                    },
                    "bookingRef" : {
                        "type" : "string",
                        "caption" : "Booking Ref"
                    },
                    "ds+DateBooked" : {
                        "type" : "date string",
                        "caption" : "Date Booked"
                    },
                    "timeOfBooking" : {
                        "type" : "string",
                        "caption" : "Time Of Booking"
                    },
                    "schedule" : {
                        "type" : "string",
                        "caption" : "Schedule"
                    },
                    "ticketName" : {
                        "type" : "string",
                        "caption" : "Ticket Name"
                    },
                    "ds+BookingDate" : {
                        "type" : "date string",
                        "caption" : "Booking Date"
                    },
                    "timeSlot" : {
                        "type" : "string",
                        "caption" : "Time Slot"
                    },
                    "status" : {
                        "type" : "string",
                        "caption" : "Status"
                    },
                    "salesChannel" : {
                        "type" : "string",
                        "caption" : "Sales Channel"
                    },
                    "till" : {
                        "type" : "string",
                        "caption" : "Till"
                    },
                    "qty" : {
                        "type" : "number",
                        "caption" : "QTY"
                    },
                    "bookingValue" : {
                        "type" : "number",
                        "caption" : "Booking Value"
                    },
                    "paidValue" : {
                        "type" : "number",
                        "caption" : "Paid Value"
                    },
                    "paxType" : {
                        "type" : "string",
                        "caption" : "Pax Type"
                    },
                    "opayoRef" : {
                        "type" : "string",
                        "caption" : "Opayo Ref"
                    },
                    "promoCode" : {
                        "type" : "string",
                        "caption" : "Promo Code"
                    },
                    "discount" : {
                        "type" : "number",
                        "caption" : "Discount"
                    },
                    "subtotal" : {
                        "type" : "number",
                        "caption" : "Subtotal"
                    },
                    "paidValue" : {
                        "type" : "number",
                        "caption" : "PaidValue"
                    },
                    "taxRate" : {
                        "type" : "number",
                        "caption" : "TaxRate"
                    },
                    "taxCode" : {
                        "type" : "string",
                        "caption" : "TaxCode"
                    },
                    "vat" : {
                        "type" : "number",
                        "caption" : "Vat"
                    },
                    "gross" : {
                        "type" : "number",
                        "caption" : "Gross"
                    },
                    "net" : {
                        "type" : "number",
                        "caption" : "Net"
                    },
                    "reservedField_1" : {
                        "type" : "string",
                        "caption" : "ReservedField_1"
                    },
                    "reservedField_2" : {
                        "type" : "string",
                        "caption" : "ReservedField_2"
                    },
                    "reservedField_3" : {
                        "type" : "string",
                        "caption" : "ReservedField_3"
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


IF NOT EXISTS (SELECT * FROM [tickets].[Reports] where [Name] = 'Daily Booking Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [tickets].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
    'Daily Booking Report', 'Daily Booking Report', 1, NULL,
    '
        {
            "type": 1,
            "text": "Daily Booking Report",
            "from": "2021-09-12T00:00:00.000Z",
            "to": "2021-09-12T00:00:00.000Z",
            "needDatepicker": true,
            "api": "/api/TicketingReport/DailyBookingReport",
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
                            "uniqueName" : "saleNo"
                        },
                        {
                            "uniqueName" : "bookingRef"
                        },
                        {
                            "uniqueName" : "ds+DateBooked"
                        },
                        {
                            "uniqueName" : "timeOfBooking"
                        },
                        {
                            "uniqueName" : "schedule"
                        },
                        {
                            "uniqueName" : "ticketName"
                        },
                        {
                            "uniqueName" : "ds+BookingDate"
                        },
                        {
                            "uniqueName" : "timeSlot"
                        },
                        {
                            "uniqueName" : "status"
                        },
                        {
                            "uniqueName" : "salesChannel"
                        },
                        {
                            "uniqueName" : "till"
                        },
                        {
                            "uniqueName" : "paxType"
                        },
                        {
                            "uniqueName" : "opayoRef"
                        },
                        {
                            "uniqueName" : "promoCode"
                        },
                        {
                            "uniqueName" : "taxCode"
                        },
                        {
                            "uniqueName" : "reservedField_1"
                        },
                        {
                            "uniqueName" : "reservedField_2"
                        },
                        {
                            "uniqueName" : "reservedField_3"
                        }
                    ],
                    "measures" : [
                        {
                            "uniqueName" : "qty",
                            "aggregation" : "sum",
                            "format" : "amount"
                        },
                        {
                            "uniqueName" : "bookingValue",
                            "aggregation" : "sum",
                            "format" : "amount"
                        },
                        {
                            "uniqueName" : "discount",
                            "aggregation" : "sum",
                            "format" : "amount"
                        },
                        {
                            "uniqueName" : "subtotal",
                            "aggregation" : "sum",
                            "format" : "amount"
                        },
                        {
                            "uniqueName" : "paidValue",
                            "aggregation" : "sum",
                            "format" : "amount"
                        },
                        {
                            "uniqueName" : "taxRate",
                            "aggregation" : "sum",
                            "format" : "amount"
                        },
                        {
                            "uniqueName" : "vat",
                            "aggregation" : "sum",
                            "format" : "amount"
                        },
                        {
                            "uniqueName" : "gross",
                            "aggregation" : "sum",
                            "format" : "amount"
                        },
                        {
                            "uniqueName" : "net",
                            "aggregation" : "sum",
                            "format" : "amount"
                        }
                    ],
                    "expandAll" : true
                },
                "dataTypes" : {
                    "saleNo" : {
                        "type" : "string",
                        "caption": "Sale No"
                    },
                    "bookingRef" : {
                        "type" : "string",
                        "caption" : "Booking Ref"
                    },
                    "ds+DateBooked" : {
                        "type" : "date string",
                        "caption" : "Date Booked"
                    },
                    "timeOfBooking" : {
                        "type" : "string",
                        "caption" : "Time Of Booking"
                    },
                    "schedule" : {
                        "type" : "string",
                        "caption" : "Schedule"
                    },
                    "ticketName" : {
                        "type" : "string",
                        "caption" : "Ticket Name"
                    },
                    "ds+BookingDate" : {
                        "type" : "date string",
                        "caption" : "Booking Date"
                    },
                    "timeSlot" : {
                        "type" : "string",
                        "caption" : "Time Slot"
                    },
                    "status" : {
                        "type" : "string",
                        "caption" : "Status"
                    },
                    "salesChannel" : {
                        "type" : "string",
                        "caption" : "Sales Channel"
                    },
                    "till" : {
                        "type" : "string",
                        "caption" : "Till"
                    },
                    "qty" : {
                        "type" : "number",
                        "caption" : "QTY"
                    },
                    "bookingValue" : {
                        "type" : "number",
                        "caption" : "Booking Value"
                    },
                    "paxType" : {
                        "type" : "string",
                        "caption" : "Pax Type"
                    },
                    "opayoRef" : {
                        "type" : "string",
                        "caption" : "Opayo Ref"
                    },
                    "promoCode" : {
                        "type" : "string",
                        "caption" : "Promo Code"
                    },
                    "discount" : {
                        "type" : "number",
                        "caption" : "Discount"
                    },
                    "subtotal" : {
                        "type" : "number",
                        "caption" : "Subtotal"
                    },
                    "paidValue" : {
                        "type" : "number",
                        "caption" : "paidValue"
                    },
                    "taxRate" : {
                        "type" : "number",
                        "caption" : "Tax Rate"
                    },
                    "taxCode" : {
                        "type" : "string",
                        "caption" : "Tax Code"
                    },
                    "vat" : {
                        "type" : "number",
                        "caption" : "vat"
                    },
                    "gross" : {
                        "type" : "number",
                        "caption" : "Gross"
                    },
                    "net" : {
                        "type" : "number",
                        "caption" : "Net"
                    },
                    "reservedField_1" : {
                        "type" : "string",
                        "caption" : "ReservedField_1"
                    },
                    "reservedField_2" : {
                        "type" : "string",
                        "caption" : "ReservedField_2"
                    },
                    "reservedField_3" : {
                        "type" : "string",
                        "caption" : "ReservedField_3"
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

--- Voided Transactions Report ---
IF NOT EXISTS (SELECT * FROM [tickets].[Reports] where [Name] = 'Voided Transactions Report' AND [AccountId] IS NULL)
BEGIN
	INSERT INTO [tickets].[Reports] ([Deleted], [Active], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [AccountId], [Name], [Code], [Type], [ConfigName], [Config]) 
		VALUES (0, 1, '2021-09-12', NULL, '2021-09-12', NULL, NULL, 
        'Voided Transactions Report', 'Voided Transactions Report', 5, NULL, 
        '
            {"type":5,"text":"Voided Transactions Report","from":"2021-09-12T00:00:00.000Z","to":"2021-09-12T00:00:00.000Z","needDatepicker":true,"api":"/api/Report/SpRptVoidedTransactionReport","config":{"options":{"viewType":"grid","grid":{"type":"classic","showGrandTotals":"off","showTotals":false},"grouping":false,"showAggregationLabels":false,"datePattern":"dd/MM/yyyy"},"slice":{"rows":[{"uniqueName":"ds+Date"},{"uniqueName":"saleTime"},{"uniqueName":"branch"},{"uniqueName":"device"},{"uniqueName":"user"},{"uniqueName":"transactionNumber"},{"uniqueName":"product"},{"uniqueName":"productCode"}],"expandAll":true},"dataTypes":{"ds+Date":{"type":"string","caption":"Date"},"saleTime":{"type":"string","caption":"Sale Time"},"branch":{"type":"string","caption":"Branch"},"device":{"type":"string","caption":"Device"},"user":{"type":"string","caption":"User"},"transactionNumber":{"type":"string","caption":"Transaction Number"},"product":{"type":"string","caption":"Product"},"productCode":{"type":"string","caption":"Product Code"}},"formats":[{"name":"amount","decimalSeparator":".","decimalPlaces":4},{"name":"rightAlign","textAlign":"right"}]}}
        '
        )
END

---end---