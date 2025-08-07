IF OBJECT_ID(N'[tickets].[GetTicketSales]', N'P') IS NOT NULL
    DROP PROCEDURE [tickets].[GetTicketSales]
GO
CREATE PROCEDURE [tickets].[GetTicketSales]
	@FromDate DATETIME,
	@ToDate DATETIME,
	@BranchFilterId uniqueidentifier,
	@BranchGroupFilterId uniqueidentifier
AS

declare @ReservedField_1 nvarchar(4000)
declare @ReservedField_2 nvarchar(4000)
declare @ReservedField_3 nvarchar(4000)

BEGIN
	WITH ctePay as
		   ( 
			SELECT TransactionId,pp.OpayoTransactionId,pp.StripeChargeId,pp.WorldPayTransactionId,pp.Name,Type=1,pp.Value 
			FROM tickets.PartPayments pp 
				INNER JOIN Tickets.Transactions t on t.Id = pp.TransactionID
				LEFT JOIN tickets.Branches br on br.Id = t.BranchId
			WHERE pp.Status = 0 and pp.Type = 0 -- status 0 is normal payment
				AND t.deleted = 0 
				AND (t.CreatedDate >= @FromDate AND t.CreatedDate <= @ToDate)
				AND (@BranchFilterId IS NULL OR br.Id = @BranchFilterId)
				AND (@BranchGroupFilterId IS NULL OR br.BranchGroupId = @BranchGroupFilterId)
			UNION ALL
			select TransactionId,pp.OpayoTransactionId,pp.StripeChargeId,pp.WorldPayTransactionId,pp.Name,Type=-1,pp.Value*-1  
			FROM tickets.PartPayments pp 
				INNER JOIN Tickets.Transactions t on t.Id = pp.TransactionID
				LEFT JOIN tickets.Branches br on br.Id = t.BranchId
			WHERE pp.Status = 1 and pp.Type = 1 -- status 1 is refund ??
				AND t.deleted = 0 
				AND (t.CreatedDate >= @FromDate AND t.CreatedDate <= @ToDate)
				AND (@BranchFilterId IS NULL OR br.Id = @BranchFilterId)
				AND (@BranchGroupFilterId IS NULL OR br.BranchGroupId = @BranchGroupFilterId)
		   )  

	SELECT  SaleNo		= t.SaleNo,
		    BookingRef = isnull(b.bookingNo,'Refund'),
		    DateBooked	= CONVERT(varchar, T.[Date], 111),
		    TimeOfBooking = CONVERT(varchar, T.[Date], 108),
		    Schedule		= sc.name,
		    TicketName	= ti.Name,
		    BookingDate	= CONVERT(varchar, bd.BookingDate, 111),
		    TimeSlot		= CONVERT(varchar, tsd.Time, 108),
			Status		= (CASE 
									WHEN b.Status IS NULL THEN 'Null Status'
									WHEN b.Status = 0 THEN 'Pending'
									WHEN b.Status = 1 THEN 'Timed out'
									WHEN b.Status = 2 THEN 'Paid' +'-'+ isnull(pp.Name,CASE WHEN pp.OpayoTransactionId IS NOT NULL THEN 'Opayo' WHEN pp.WorldPayTransactionId IS NOT NULL THEN 'WorldPay' WHEN pp.StripeChargeId IS NOT NULL THEN 'Stripe' ELSE 'Unknown' END)
									WHEN b.Status = 3 THEN 'Cancelled'
									WHEN b.Status = 4 THEN 'Pay later'
									WHEN b.Status = 5 THEN 'Partial payment'
									WHEN b.Status = 6 THEN 'Outstanding'
									WHEN b.Status = 7 THEN 'Abandoned'
									WHEN b.Status = 8 THEN 'Refunded'
									WHEN b.Status = 9 THEN 'Refund Partial'
									ELSE 'Status ' + ltrim(rtrim(str(b.status)))
							END) + CASE WHEN pp.Type = -1 THEN '-Refund' ELSE '' END,
		    SalesChannel = sc.Name,
		    Till			= ISNULL(de.Serial,ISNULL(t.deviceserial,'No Till')),
		    QTY			= sum(ISNULL(bd.Quantity,0))*IIF(t.refundid IS NULL,1,-1),
		    BookingValue = CAST(IIF(t.refundid IS NULL,sum(IIF(bd.Quantity=td.Quantity,(bd.Quantity*ISNULL(rtd.price,td.Price)),ISNULL(td.Quantity*rtd.Amount,td.Amount))),0) as decimal(18,2)), --sum(IIF(bd.Quantity=ISNULL(rtd.Quantity,td.Quantity),(bd.Quantity*ISNULL(rtd.price,td.Price)),td.amount)),
		    PaxType		= pt.name,
		    PaidValue	= CAST(IIF(pp.Value!=0,sum(IIF(bd.Quantity=td.Amount,(bd.Quantity*td.Price),td.amount)),0) as float) * pp.Type,
		    OpayoRef		= ISNULL(pp.OpayoTransactionId,ISNULL(pp.WorldPayTransactionId,ISNULL(pp.StripeChargeId,''))),--ISNULL(pp.WorldPayTransactionId,ppr.WorldPayTransactionId))
		    b.PromoCode, 
		    COALESCE(b.DiscountByPromoCode,0) as PromoCodeDiscount ,
			Promo_Type= (case	when tpc.PromoType = 0 then 'value' 
								when tpc.PromoType = 1 then 'Percentage' 
								else '' end),
			pp.Value,
			TaxRate = td.TaxRate,
			TaxCode = Taxes.Code,
			Vat = sum(td.Tax)
			--FORMAT(ga.CreatedDate, 'yyyy/MM/dd') as 'DonationDate',
			--CAST (ga.GiftAidTotal as DECIMAL(10, 2)) as 'Gift_Aid_Amount'
			into #TMPB
	FROM tickets.Transactions as t
	INNER JOIN tickets.TransactionDetails as td on td.TransactionId = t.ID and td.Deleted = 0 and td.voided = 0
	--left outer JOIN [ECR-v2-NMNI-1-Customer].[customer].[GiftAids] as ga on ga.TransactionId = t.Id
	LEFT JOIN tickets.Taxes AS Taxes ON Taxes.Id = td.TaxId
	LEFT JOIN tickets.TransactionDetails as rtd on rtd.TransactionId = t.RefundId and td.Deleted = 0 and td.voided = 0 and td.RefundDetailId = rtd.Id -- add original Transactiondetails for the sale refunded
	LEFT JOIN tickets.Bookings as b on b.TransactionId = ISNULL(t.RefundId,t.Id)
	LEFT JOIN tickets.BookingDetails as bd on bd.BookingId = b.ID and bd.TransactionDetailId = ISNULL(rtd.Id,td.Id) -- join to the original transaction details to confuirm booking detail
	INNER JOIN ctePay pp on pp.TransactionId = t.id
	LEFT JOIN tickets.Branches as br on br.ID = t.BranchId
	LEFT JOIN tickets.PriceBands as pb on pb.ID = td.PriceBandId
	LEFT JOIN tickets.TimeSlotDetails as tsd on tsd.ID = bd.TimeSlotDetailId
	LEFT JOIN tickets.timeslots as ts on ts.ID = tsd.TimeSlotId
	LEFT JOIN  tickets.schedules as s on s.ID = ts.ScheduleId
	LEFT JOIN tickets.SaleChannels as sc on sc.ID = b.SaleChannelId
	LEFT JOIN tickets.PassengerTypes as pt on pt.ID = bd.PassengerTypeId
	LEFT JOIN tickets.devices de on de.ID = t.DeviceId
	LEFT JOIN tickets.tickets ti on ti.ID = bd.TicketId
	left outer join tickets.TicketingPromoCodeGeneratedMaps tpcgm (nolock) on b.PromoCode = tpcgm.PromoCodeGenerated
	left outer join tickets.TicketingPromoCodes tpc (nolock) on tpcgm.TicketingPromoCodeId = tpc.Id  
	WHERE 1=1
	AND t.deleted = 0 
	AND (t.CreatedDate >= @FromDate AND t.CreatedDate <= @ToDate)
    AND (@BranchFilterId IS NULL OR br.Id = @BranchFilterId)
    AND (@BranchGroupFilterId IS NULL OR br.BranchGroupId = @BranchGroupFilterId)
	group by	t.refundid,	 
				t.SaleNo,
				b.bookingNo,
				t.date,
				sc.name,
				ti.Name,
				bd.BookingDate,
				tsd.Time,
				b.status,
				sc.Name,
				de.Serial,
				t.DeviceSerial,
				pt.name,
				pp.Name,
				pp.Value,
				pp.OpayoTransactionId,
				pp.StripeChargeId,
				pp.WorldPayTransactionId,
				pp.Type
				,b.PromoCode 
				,COALESCE(b.DiscountByPromoCode,0)
				,(case when tpc.PromoType = 0 then 'value' 
				when tpc.PromoType = 1 then 'Percentage' 
				else '' end)
				,pp.value
				,td.TaxRate
				,Taxes.Code
				--,FORMAT(ga.CreatedDate, 'yyyy/MM/dd')
				--,CAST (ga.GiftAidTotal as DECIMAL(10, 2))

			--ORDER BY 2,t.date desc


			select Saleno,BookingRef,DateBooked,TimeOfBooking,Schedule,TicketName,BookingDate,TimeSlot,
					Status, SalesChannel ,Till,QTY,BookingValue ,PaxType, PaidValue ,OpayoRef 
					,promocode,promo_type,PromoCodeDiscount,[Value]=convert(numeric(18,2),[Value]),
					Total=(select sum(BookingValue) from   #TMPB where BookingRef = a.bookingRef and OpayoRef = a.OpayoRef)*IIF(QTY >=0,1,-1)
					,TaxRate,TaxCode,Vat
					--,DonationDate,Gift_Aid_Amount
					into #TMPC
			from #TMPB a

					select	*,
							Promo_discount_proportion =(case	when promo_type = 'value' 
																		then convert(numeric(18,2),(Coalesce(Promocodediscount,0) * (BookingValue /Total)))
																when promo_type = 'Percentage' 
																		then convert(numeric(18,2),(BookingValue*COALESCE(PromoCodeDiscount/100,0)))
														else '0' end)
						 into #TMPD
					from #TMPC

					select		Saleno
								,BookingRef
								,DateBooked
								,TimeOfBooking
								,Schedule
								,TicketName
								,BookingDate
								,TimeSlot
								,Status
								,SalesChannel
								,Till
								,QTY
								,BookingValue 
								,PaxType
								--,PaidValue 
								,OpayoRef 
								,promocode=(case when (promocode is null) then '' else promocode end)
								,Discount =Promo_discount_proportion
								,Subtotal = Total
								,PaidValue = (case when status like 'Paid-%' then (BookingValue - Promo_discount_proportion) else 0 end)
								,TaxRate
								,TaxCode
								,Vat
								,Gross = BookingValue 
								,Net = BookingValue - Vat
								--,DonationDate
								--,Gift_Aid_Amount
								,ReservedField_1 = @ReservedField_1
								,ReservedField_2 = @ReservedField_2
								,ReservedField_3 = @ReservedField_3
					from #TMPD
					ORDER BY  	DateBooked desc



End

IF OBJECT_ID(N'[tickets].[GetDailyBookingReport]', N'P') IS NOT NULL
    DROP PROCEDURE [tickets].[GetDailyBookingReport]
GO

CREATE PROCEDURE [tickets].[GetDailyBookingReport]
	@FromDate DATETIME,
	@ToDate DATETIME	
AS

declare @ReservedField_1 nvarchar(4000)
declare @ReservedField_2 nvarchar(4000)
declare @ReservedField_3 nvarchar(4000)

BEGIN
	WITH ctePay as
		   ( 
			SELECT pp.TransactionId,pp.OpayoTransactionId,pp.StripeChargeId,pp.WorldPayTransactionId,pp.Name,Type=1,pp.Value 
			FROM tickets.PartPayments pp 
				INNER JOIN Tickets.Transactions t on t.Id = pp.TransactionID
				inner join tickets.Bookings b (nolock) on pp.TransactionId = b.TransactionId 
				inner join tickets.BookingDetails bd (nolock) on b.Id = bd.BookingId 
				LEFT JOIN tickets.Branches br on br.Id = t.BranchId
			WHERE pp.Status = 0 and pp.Type = 0 -- status 0 is normal payment
				AND t.deleted = 0 
				AND (bd.BookingDate >= @FromDate AND bd.BookingDate <= @ToDate)
			UNION ALL
			select pp.TransactionId,pp.OpayoTransactionId,pp.StripeChargeId,pp.WorldPayTransactionId,pp.Name,Type=-1,pp.Value*-1  
			FROM tickets.PartPayments pp 
				INNER JOIN Tickets.Transactions t on t.Id = pp.TransactionID
				inner join tickets.Bookings b (nolock) on pp.TransactionId = b.TransactionId 
				inner join tickets.BookingDetails bd (nolock) on b.Id = bd.BookingId 
				LEFT JOIN tickets.Branches br on br.Id = t.BranchId
			WHERE pp.Status = 1 and pp.Type = 1 -- status 1 is refund ??
				AND t.deleted = 0 
				AND (bd.BookingDate >= @FromDate AND bd.BookingDate <= @ToDate)
		   )  

	SELECT  SaleNo		= t.SaleNo,
		    BookingRef = isnull(b.bookingNo,'Refund'),
		    DateBooked	= CONVERT(varchar, T.[Date], 111),
		    TimeOfBooking = CONVERT(varchar, T.[Date], 108),
		    Schedule		= sc.name,
		    TicketName	= ti.Name,
		    BookingDate	= CONVERT(varchar, bd.BookingDate, 111),
		    TimeSlot		= CONVERT(varchar, tsd.Time, 108),
			Status		= (CASE 
									WHEN b.Status IS NULL THEN 'Null Status'
									WHEN b.Status = 0 THEN 'Pending'
									WHEN b.Status = 1 THEN 'Timed out'
									WHEN b.Status = 2 THEN 'Paid' +'-'+ isnull(pp.Name,CASE WHEN pp.OpayoTransactionId IS NOT NULL THEN 'Opayo' WHEN pp.WorldPayTransactionId IS NOT NULL THEN 'WorldPay' WHEN pp.StripeChargeId IS NOT NULL THEN 'Stripe' ELSE 'Unknown' END)
									WHEN b.Status = 3 THEN 'Cancelled'
									WHEN b.Status = 4 THEN 'Pay later'
									WHEN b.Status = 5 THEN 'Partial payment'
									WHEN b.Status = 6 THEN 'Outstanding'
									WHEN b.Status = 7 THEN 'Abandoned'
									WHEN b.Status = 8 THEN 'Refunded'
									WHEN b.Status = 9 THEN 'Refund Partial'
									ELSE 'Status ' + ltrim(rtrim(str(b.status)))
							END) + CASE WHEN pp.Type = -1 THEN '-Refund' ELSE '' END,
		    SalesChannel = sc.Name,
		    Till			= ISNULL(de.Serial,ISNULL(t.deviceserial,'No Till')),
		    QTY			= sum(ISNULL(bd.Quantity,0))*IIF(t.refundid IS NULL,1,-1),
		    BookingValue = CAST(IIF(t.refundid IS NULL,sum(IIF(bd.Quantity=td.Quantity,(bd.Quantity*ISNULL(rtd.price,td.Price)),ISNULL(td.Quantity*rtd.Amount,td.Amount))),0) as decimal(18,2)), --sum(IIF(bd.Quantity=ISNULL(rtd.Quantity,td.Quantity),(bd.Quantity*ISNULL(rtd.price,td.Price)),td.amount)),
		    PaxType		= pt.name,
		    PaidValue	= CAST(IIF(pp.Value!=0,sum(IIF(bd.Quantity=td.Amount,(bd.Quantity*td.Price),td.amount)),0) as float) * pp.Type,
		    OpayoRef		= ISNULL(pp.OpayoTransactionId,ISNULL(pp.WorldPayTransactionId,ISNULL(pp.StripeChargeId,''))),--ISNULL(pp.WorldPayTransactionId,ppr.WorldPayTransactionId))
		    b.PromoCode, 
		    COALESCE(b.DiscountByPromoCode,0) as PromoCodeDiscount ,
			Promo_Type= (case	when tpc.PromoType = 0 then 'value' 
								when tpc.PromoType = 1 then 'Percentage' 
								else '' end),
			pp.Value,
			TaxRate = td.TaxRate,
			TaxCode = Taxes.Code,
			Vat = sum(td.Tax)
			--FORMAT(ga.CreatedDate, 'yyyy/MM/dd') as 'DonationDate',
			--CAST (ga.GiftAidTotal as DECIMAL(10, 2)) as 'Gift_Aid_Amount'
			into #TMPB
	FROM tickets.Transactions as t
	INNER JOIN tickets.TransactionDetails as td on td.TransactionId = t.ID and td.Deleted = 0 and td.voided = 0
	--left outer JOIN [ECR-v2-NMNI-1-Customer].[customer].[GiftAids] as ga on ga.TransactionId = t.Id
	LEFT JOIN tickets.Taxes AS Taxes ON Taxes.Id = td.TaxId
	LEFT JOIN tickets.TransactionDetails as rtd on rtd.TransactionId = t.RefundId and td.Deleted = 0 and td.voided = 0 and td.RefundDetailId = rtd.Id -- add original Transactiondetails for the sale refunded
	LEFT JOIN tickets.Bookings as b on b.TransactionId = ISNULL(t.RefundId,t.Id)
	LEFT JOIN tickets.BookingDetails as bd on bd.BookingId = b.ID and bd.TransactionDetailId = ISNULL(rtd.Id,td.Id) -- join to the original transaction details to confuirm booking detail
	INNER JOIN ctePay pp on pp.TransactionId = t.id
	LEFT JOIN tickets.Branches as br on br.ID = t.BranchId
	LEFT JOIN tickets.PriceBands as pb on pb.ID = td.PriceBandId
	LEFT JOIN tickets.TimeSlotDetails as tsd on tsd.ID = bd.TimeSlotDetailId
	LEFT JOIN tickets.timeslots as ts on ts.ID = tsd.TimeSlotId
	LEFT JOIN  tickets.schedules as s on s.ID = ts.ScheduleId
	LEFT JOIN tickets.SaleChannels as sc on sc.ID = b.SaleChannelId
	LEFT JOIN tickets.PassengerTypes as pt on pt.ID = bd.PassengerTypeId
	LEFT JOIN tickets.devices de on de.ID = t.DeviceId
	LEFT JOIN tickets.tickets ti on ti.ID = bd.TicketId
	left outer join tickets.TicketingPromoCodeGeneratedMaps tpcgm (nolock) on b.PromoCode = tpcgm.PromoCodeGenerated
	left outer join tickets.TicketingPromoCodes tpc (nolock) on tpcgm.TicketingPromoCodeId = tpc.Id  
	WHERE 1=1
	AND t.deleted = 0 
	AND (bd.BookingDate >= @FromDate AND bd.BookingDate <= @ToDate)
	group by	t.refundid,	 
				t.SaleNo,
				b.bookingNo,
				t.date,
				sc.name,
				ti.Name,
				bd.BookingDate,
				tsd.Time,
				b.status,
				sc.Name,
				de.Serial,
				t.DeviceSerial,
				pt.name,
				pp.Name,
				pp.Value,
				pp.OpayoTransactionId,
				pp.StripeChargeId,
				pp.WorldPayTransactionId,
				pp.Type
				,b.PromoCode 
				,COALESCE(b.DiscountByPromoCode,0)
				,(case when tpc.PromoType = 0 then 'value' 
				when tpc.PromoType = 1 then 'Percentage' 
				else '' end)
				,pp.value
				,td.TaxRate
				,Taxes.Code
				--,FORMAT(ga.CreatedDate, 'yyyy/MM/dd')
				--,CAST (ga.GiftAidTotal as DECIMAL(10, 2))


			select Saleno,BookingRef,DateBooked,TimeOfBooking,Schedule,TicketName,BookingDate,TimeSlot,
					Status, SalesChannel ,Till,QTY,BookingValue ,PaxType, PaidValue ,OpayoRef 
					,promocode,promo_type,PromoCodeDiscount,[Value]=convert(numeric(18,2),[Value]),
					Total=(select sum(BookingValue) from   #TMPB where BookingRef = a.bookingRef)*IIF(QTY >=0,1,-1)
					,TaxRate,TaxCode,Vat
					--,DonationDate,Gift_Aid_Amount
					into #TMPC
			from #TMPB a

					select	*,
							Promo_discount_proportion =(case	when promo_type = 'value' 
																		then convert(numeric(18,2),(Coalesce(Promocodediscount,0) * (BookingValue /Total)))
																when promo_type = 'Percentage' 
																		then convert(numeric(18,2),(BookingValue*COALESCE(PromoCodeDiscount/100,0)))
														else '0' end)
						 into #TMPD
					from #TMPC

					select		SaleNo
								,BookingRef
								,DateBooked
								,TimeOfBooking
								,Schedule
								,TicketName
								,BookingDate
								,TimeSlot
								,Status
								,SalesChannel
								,Till
								,QTY
								,BookingValue 
								,PaxType
								,OpayoRef 
								,PromoCode=(case when (promocode is null) then '' else promocode end)
								,Discount =Promo_discount_proportion
								,Subtotal = Total
								,PaidValue = (case when status like 'Paid-%' then (BookingValue - Promo_discount_proportion) else 0 end)
								,TaxRate
								,TaxCode
								,Vat
								,Gross = BookingValue 
								,Net = BookingValue - Vat
								--,DonationDate
								--,Gift_Aid_Amount
								,ReservedField_1 = @ReservedField_1
								,ReservedField_2 = @ReservedField_2
								,ReservedField_3 = @ReservedField_3
					from #TMPD
					ORDER BY  	BookingDate desc



End


--EXEC tickets.GetDailyBookingReport @FromDate = '3/5/2023', @ToDate = '5/5/2023'



