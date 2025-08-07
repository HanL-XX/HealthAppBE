---GetCustomers---
IF OBJECT_ID(N'[dbo].[GetCustomers]', N'P') IS NOT NULL
	DROP PROCEDURE [dbo].[GetCustomers]
GO 

IF OBJECT_ID(N'[customer].[GetCustomers]', N'P') IS NOT NULL
	DROP PROCEDURE [customer].[GetCustomers]
GO 

CREATE PROCEDURE [customer].[GetCustomers]
	@SearchText NVARCHAR(200),
	@PaymentOwner bit
AS
BEGIN
	SELECT  *
	FROM [customer].UnregisteredCustomers					
	WHERE
		(IsNull(@SearchText, '') = '' or UPPER(FirstName + ' ' + LastName) like '%'+@SearchText +'%') and PaymentOwner = @PaymentOwner
END

GO
---End GetCustomers---

---GetCustomersWithEmail---
IF OBJECT_ID(N'[dbo].[GetCustomersWithEmail]', N'P') IS NOT NULL
	DROP PROCEDURE [dbo].[GetCustomersWithEmail]
GO 
IF OBJECT_ID(N'[customer].[GetCustomersWithEmail]', N'P') IS NOT NULL
	DROP PROCEDURE [customer].[GetCustomersWithEmail]
GO 

CREATE PROCEDURE [customer].[GetCustomersWithEmail]
	@SearchText NVARCHAR(200),
	@PaymentOwner bit
AS
BEGIN
	SELECT  *
	FROM [customer].UnregisteredCustomers						
	WHERE (IsNull(@SearchText, '') = '' or UPPER(FirstName + ' ' + LastName) like '%'+UPPER(@SearchText) +'%' or UPPER(Email) like '%' + UPPER(@SearchText) +'%') 
											and PaymentOwner = @PaymentOwner
END

---End GetCustomersWithEmail---