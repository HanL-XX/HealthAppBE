--Generate TicketingOrderNo
GO
IF OBJECT_ID(N'[tickets].[GenOrderNo]', N'P') IS NOT NULL
    DROP PROCEDURE [tickets].[GenOrderNo]
GO

CREATE PROCEDURE [tickets].[GenOrderNo]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE	@OrderId INTEGER
	DECLARE	@CurrentNo INTEGER
    -- Insert statements for procedure here
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
	BEGIN TRANSACTION;
		SELECT TOP (1) 
			@OrderId = [Id],
			@CurrentNo = [CurrentNo]
			FROM [tickets].[OrderNos]
			WHERE [CurrentNo] <= [Max]
			ORDER BY NEWID()

		SELECT TOP (1) 
			[Id],
			[Min],
			[Max],
			[CurrentNo]
			FROM [tickets].[OrderNos]
		WHERE [Id] = @OrderId

		SET @CurrentNo = @CurrentNo + 1
		UPDATE [tickets].[OrderNos]
		SET [CurrentNo] = @CurrentNo
		WHERE [Id] = @OrderId
	COMMIT TRANSACTION;
END
--/Generate TicketingOrderNo


GO
IF OBJECT_ID(N'[tickets].[ExportCTOSToSAP]', N'P') IS NOT NULL
    DROP PROCEDURE [tickets].[ExportCTOSToSAP]
GO

create procedure [tickets].[ExportCTOSToSAP]
@selectedDate DateTime
as
begin
    IF (@selectedDate is null or datepart(d,@selectedDate) <7)
begin
            set @selectedDate = GETDATE() -7
end
    DECLARE @FromDate DateTime = DATEADD(DAY, 1, EOMONTH(@selectedDate, -1))
    DECLARE @ToDate DateTime = DATEADD(DAY, 1, EOMONTH(@selectedDate))

select distinct X                 = 'X',
       CompanyCode       = '1000',
       DocType           = 'DR',
       DocumentDate      = CONVERT(NVARCHAR, @selectedDate, 104),
       PostingDate       = CONVERT(NVARCHAR, @selectedDate, 104),
       ReferenceDocument = S.BookingNo,
       HeaderText        = '',
       Currency          = 'GBP',
       CustomerNumber    = '',
       NetAmount         = -TotalCost,
       TaxAmount         = -TotalTax,
       TaxCode           = 'D1',
       GLAccount         = '402120',
       CostCentre        = '',
       ProfitCentre      = SI.Name,
       WBSElement        = 'X.J23.PROMOTION',
       Notes             = SUBSTRING(
               concat(S.BranchName, ';', CONVERT(NVARCHAR, @selectedDate, 104), ';', S.PassengerType, ';', S.BookingNo), 1, 50),
       Assignment        = S.BookingNo,
       RefKey3           = S.BookingNo,
       TaxDate           = CONVERT(NVARCHAR, @selectedDate, 104)
from (select B.Id,
             B.BookingNo,
             TD.Amount,
             TD.Tax,
             T.BranchName,
             BD.PassengerTypeId,
             G.PassengerType,
             TotalCost = SUM(TD.Amount),
             TotalTax  = SUM(Td.Tax)
      from [tickets].TransactionDetails TD
          left join [tickets].Transactions T on TD.TransactionId = T.Id
          left join [tickets].BookingDetails BD on TD.Id = BD.TransactionDetailId
          left join [tickets].Bookings B on BD.BookingId = B.Id
          left join (select BO.Id,
          stuff((select ' ' + PT.Name + '-' + cast(count(*) as varchar)
          from [tickets].Bookings B
          left join [tickets].BookingDetails BD
          on B.Id = BD.BookingId
          left join [tickets].PassengerTypes PT
          on BD.PassengerTypeId = PT.Id
          where (B.Deleted = 0 and BD.Deleted = 0 and PT.Deleted = 0 and BO.Id = B.Id)
          group by B.Id, PT.name
          for xml path(''),TYPE).value('(./text())[1]', 'VARCHAR(MAX)')
          , 1, 1, '') AS PassengerType
          from [tickets].Bookings BO
          left join [tickets].BookingDetails BD
          on BO.Id = BD.BookingId
          left join [tickets].PassengerTypes PT
          on BD.PassengerTypeId = PT.Id
          where (BO.Deleted = 0 and BD.Deleted = 0 and PT.Deleted = 0)
          group by BO.Id, PT.Name) AS G on B.Id = G.Id
      where TD.Deleted = 0
        and T.Deleted = 0
        and BD.Deleted = 0
        and B.Deleted = 0
        and T.[Date] >= @FromDate AND T.[Date] < @ToDate
      group by B.Id, B.BookingNo, TD.Amount, TD.Tax, T.BranchName, BD.PassengerTypeId, G.PassengerType) as S
         left join mSites SI on SI.Name = S.BranchName
    left join mSAP_Mapping SM on SM.MONUMENT = SI.SAP_SiteName
end
