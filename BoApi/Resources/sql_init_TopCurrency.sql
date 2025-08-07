IF NOT EXISTS (
	select *
	from
		[dbo].Currencies
)
BEGIN

	Delete from [dbo].Currencies;

	BEGIN TRY
		ALTER TABLE [dbo].[Currencies]
		DROP CONSTRAINT IF EXISTS DF_CreatedDate;

		ALTER table [dbo].[Currencies]
		Add CONSTRAINT DF_CreatedDate DEFAULT GETDATE() for [CreatedDate];
	end try 
	begin catch 
	end catch;

	BEGIN TRY
		ALTER TABLE [dbo].[Currencies]
		DROP CONSTRAINT IF EXISTS DF_UpdatedDate;

		ALTER table [dbo].[Currencies]
		Add CONSTRAINT DF_UpdatedDate DEFAULT GETDATE() for [UpdatedDate];
	end try 
	begin catch 
	end catch;

	BEGIN TRY
		ALTER TABLE [dbo].[Currencies]
		DROP CONSTRAINT IF EXISTS DF_Id

		ALTER table [dbo].[Currencies]
		Add CONSTRAINT DF_Id DEFAULT newid() for [Id];
	end try 
	begin catch
	end catch;


	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'AED', N'درهم‎', N'UAE Dirham', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/5vCmSP60kkWAgMi5Rxzj4w.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'AFN', N'؋', N'Afghani', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/03ehXB444Uy17RdiLsucUA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'ALL', N'Lek', N'Lek', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'AMD', N'֏', N'Armenian Dram', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/lj41jSSzuEqUID8xCbEcUQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'ANG', N'ƒ', N'Netherlands Antillian Guilder', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'AOA', N'Kz', N'Kwanza', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'ARS', N'$', N'Argentine Peso', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/3xLd2PCw4UKXpEdanh-QMw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'AUD', N'$', N'Australian Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/cEhtFQ0nNkSnayDzDJdI2w.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'AWG', N'ƒ', N'Aruban Guilder', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/EUKma_mtjk-RtARrcwZlAQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'AZN', N'ман', N'Azerbaijanian Manat', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/RFjj3aI4aUqHXxge6ENd2w.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'BAM', N'KM', N'Convertible Marks', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'BBD', N'$', N'Barbados Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/R_U2nDY-gU2jqg3AnJUxBw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'BDT', N'Tk', N'Taka', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'BGN', N'лв', N'Bulgarian Lev', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/5PsVHn4z1E2j8FQyeY5dSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'BHD', N'دينار', N'Bahraini Dinar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/6OEEkv7kKUym7Uhsozf5SQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'BIF', N'FBu', N'Burundi Franc', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/IojSH8jAs0SfJO2rxjc1Gw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'BMD', N'$', N'Bermudian Dollar (customarily known as Bermuda Dollar)', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'BND', N'$', N'Brunei Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/8rF2H1Yfx0Cl0DqLdU79ow.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'BOB BOV', N'$b', N'Boliviano Mvdol', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/B5XPIT2D2Uqxh6Lchmk7AQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'BRL', N'R$', N'Brazilian Real', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mKqxeHjnLUCV5th8bjAomg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'BSD', N'$', N'Bahamian Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'BWP', N'P', N'Pula', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'BYR', N'p.', N'Belarussian Ruble', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/EIdDzB0JoE6x60UilYvCyg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'BZD', N'BZ$', N'Belize Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/LoVTY3UWi0iJu-9EW38qJQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'CAD', N'$', N'Canadian Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/IwpAu1L44k6GdPDvUAQsfw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'CDF', N'FC', N'Congolese Franc', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/PknXyYc240qPOI_4VAfERg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'CHF', N'CHF', N'Swiss Franc', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/TNdsK5qfqEOOhn7XT_aYVg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'CLP CLF', N'$', N'Chilean Peso Unidades de fomento', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/gSfACz_LyEeaGs4KUE5uPQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'CNY', N'¥', N'Yuan Renminbi', 0, N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/WUrXkficakqUTnPMFQ7QuQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'COP COU', N'$', N'Colombian Peso Unidad de Valor Real', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/4eEZSr03gkmG2-sWlOuwXQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'CRC', N'₡', N'Costa Rican Colon', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/GOXJMeidJkmF1_NMgvLdNA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'CUP CUC', N'₱', N'Cuban Peso Peso Convertible', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/Ts3A9fd2WUSKR2_oVjnRJA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'CVE', N'$', N'Cape Verde Escudo', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/evtC7V-yMESxgKubTIKCDw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'CZK', N'Kč', N'Czech Koruna', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/_2BQQVWPVkm2OzRlSihaYw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'DJF', N'Fdj', N'Djibouti Franc', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/sIXFeATUykORCBGcqJ-nEQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'DKK', N'kr', N'Danish Krone', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/MY39nMIf9UGNW5sGU4hHXA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'DOP', N'RD$', N'Dominican Peso', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/TXnzCH3qDUaF5ob8FrLXzQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'DZD', N'DA', N'Algerian Dinar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/ektWI0MxCUyg1G80QnQHqw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'EEK', N'€', N'Kroon', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'EGP', N'£', N'Egyptian Pound', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/9zpmur2vk0uWJ36LPCx0UA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'ERN', N'Nkf', N'Nakfa', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/jMwrtbAEdk6305E45t_E7Q.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'ETB', N'Birr', N'Ethiopian Birr', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/B1_-mlLA0UCRRqhXYQu-XQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'EUR', N'€', N'Euro', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/SFH0t65GdEqEt6gsN1zOog.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'FJD', N'$', N'Fiji Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/C8hyO9f5ok6MNxdYgvBEBA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'FKP', N'£', N'Falkland Islands Pound', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/shAryxU1B0m2zf9nIJAqWA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'GBP', N'£', N'Pound Sterling', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/86vWDrZ0gky86xMwRw5pgw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'GEL', N'GEL', N'Lari', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'GHS', N'¢', N'Cedi', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/VMvjNciuQk-oMz8qVfXzAg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'GIP', N'£', N'Gibraltar Pound', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/-xstbp70A0GiAEuA8qR8yg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'GMD', N'D', N'Dalasi', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/Yr4LLkziN0GwGiy659jaRw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'GNF', N'FG', N'Guinea Franc', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/0epCqIYybEWHMUwoVdguTg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'GTQ', N'Q', N'Quetzal', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/ThorH5QVhU-etg1RmdYNIw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'GYD', N'$', N'Guyana Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/4EXsLrq7SEegfz6lBP1xPw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'HKD', N'$', N'Hong Kong Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/uO6o5gnXUUaKXAP5yL8PJg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'HNL', N'L', N'Lempira', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'HRK', N'kn', N'Croatian Kuna', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/gHZCfloij0SPty7S44ndQQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'HTG USD', N'G', N'Gourde US Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/iORW5kLLkECfWb7f9nRYgQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'HUF', N'Ft', N'Forint', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/hsJ2BgOEyUWcLNsfYMq6_Q.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'IDR', N'Rp', N'Rupiah', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/jcFWR1WQBUOZA7tcOqJxow.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'ILS', N'₪', N'New Israeli Sheqel', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/Xm5-8TATtE-C-zDE7izOVw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'INR', N'₹', N'Indian Rupee', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/KpOB8iwNDUu7Cudby1h5MA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'INR BTN', N'₹', N'Indian Rupee Ngultrum', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'IQD', N'ع.د', N'Iraqi Dinar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/oH3KQ5u6xkO9r4E2Me4M9g.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'IRR', N'﷼', N'Iranian Rial', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/pHDpKYdXPEuZzRHZdPb53A.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'ISK', N'kr', N'Iceland Krona', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/PiRcbZi1c0a8dPeS2sk-kA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'JMD', N'J$', N'Jamaican Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/Mb9GblYxD0i4ZTrSSFd6xw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'JOD', N'د.ا', N'Jordanian Dinar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/QrdUUsyVdEKZvnrIyKakFA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'JPY', N'¥', N'Yen', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/Tb1baCahxE6pUdxEHksPmg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'KES', N'KSh', N'Kenyan Shilling', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/DE5Gi76mBEyUnHtHY8Q_Gg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'KGS', N'лв', N'Som', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/Ww3FbU7E6U6U4XLsGw6mag.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'KHR', N'៛', N'Riel', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/683itT4jB0WbCWguUG_uJA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'KMF', N'KMF', N'Comoro Franc', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/TPEBuvpnyUOfEA7TVYbfaQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'KPW', N'₩', N'North Korean Won', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/ZRyXWfXXsUiBI0zHrbiEVQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'KRW', N'₩', N'Won', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/r6Tsj-Bk_UGVa0eY__x0OQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'KWD', N'د.ك', N'Kuwaiti Dinar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/6WKRPOZs2Eqq2oycjgBwYg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'KYD', N'$', N'Cayman Islands Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/PKYRVeEdIUSUjnE5rcUvuQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'KZT', N'лв', N'Tenge', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/GWve4f9RZkatmi0amDI9gg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'LAK', N'₭', N'Kip', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/nlbDBAxmWUG3ZrHBLcQqZw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'LBP', N'£', N'Lebanese Pound', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/VZ8oGQnNEEivaudEgHVIbQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'LKR', N'₨', N'Sri Lanka Rupee', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/TW6l9gyugUmcz6JwqkXeeA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'LRD', N'$', N'Liberian Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/qgy9AjwrWkGb-0aGY8GPFA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'LTL', N'Lt', N'Lithuanian Litas', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/qNpm6STPKEihnjaWVgisWQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'LVL', N'Ls', N'Latvian Lats', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/7H2ERWaoa0uwivq4vugOmw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'LYD', N'LD', N'Libyan Dinar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/ny5J0Y9RKkmHVwMdtuwORw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'MAD', N'د.م.', N'Moroccan Dirham', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/e8v8GShvikCpNWId5LbYjA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'MDL', N'MDL', N'Moldovan Leu', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/WsvmavNDiEyJt5lXBAqkTA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'MGA', N'Ar', N'Malagasy Ariary', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/_a1gNndMgU6ymXmcWXyCIw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'MKD', N'ден', N'Denar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/wgIPq7sKc0ylbTumw5v_Ww.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'MMK', N'K', N'Kyat', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/FyaX6WEy2E668s7Meot_xw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'MNT', N'₮', N'Tugrik', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/yLKHpv86sUuufsLG75Jo8Q.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'MOP', N'MOP$', N'Pataca', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/o4Zs4YeVA0ixgw0gC7ej_w.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'MRO', N'UM', N'Ouguiya', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/ly1gt3v_9UeQdhgdHhACMA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'MUR', N'₨', N'Mauritius Rupee', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/pptg1GsXPE2FfG4QVnSeIA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'MVR', N'Rf', N'Rufiyaa', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/2vXfEDnCXkW51G1dnpKx5g.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'MWK', N'MK', N'Kwacha', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/wDGY7BytdkGnNAatioeEkg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'MXN MXV', N'$', N'Mexican Peso Mexican Unidad de Inversion (UDI)', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/9p0UW4tPC0y4uI6U898PFw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'MYR', N'RM', N'Malaysian Ringgit', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/XaK0MnJYoUOyC4yi6gj-dg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'MZN', N'MT', N'Metical', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/TIsgrAq-YU6yJ6QuF6w2Xg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'NGN', N'₦', N'Naira', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/BB1W1SSnMUqMEYhV1s3AeA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'NIO', N'C$', N'Cordoba Oro', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/tGdyp4Zo_EOJAzr2Vv6aOQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'NOK', N'kr', N'Norwegian Krone', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/iQf32_Kb2k-osz-RXRZ8YQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'NPR', N'₨', N'Nepalese Rupee', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/r0jhPTuA202OcCsQqjgbsw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'NZD', N'$', N'New Zealand Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/S1moEx66WUOk1i9J_yIaWQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'OMR', N'﷼', N'Rial Omani', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/u4eqzpke7EilwFI196cX_A.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'PAB USD', N'B/.', N'Balboa US Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/IwjJ0GzBvkSqwBmkmIZi1Q.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'PEN', N'S/.', N'Nuevo Sol', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/iAARSQ9vjkGz0gbrDUbDSA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'PGK', N'K', N'Kina', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/U8U8CPoQrE6gyN8nTT7GmQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'PHP', N'Php', N'Philippine Peso', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/KypMV9VfIECeXXk2PWL3Gw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'PKR', N'₨', N'Pakistan Rupee', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/jAq6nf_GU0G-9o2V0o1xPw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'PLN', N'zł', N'Zloty', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/ziY7p1-18kSHEMQ2v_NdzA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'PYG', N'Gs', N'Guarani', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/fh2etPxVM0S3IxS6CMsuFQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'QAR', N'﷼', N'Qatari Rial', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/9aYWUky5AEugaxHi_PaDJw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'RON', N'lei', N'New Leu', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/7zt_4Xx96kuagjNQKDfScA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'RSD', N'Дин.', N'Serbian Dinar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/AV-TcNJVGEyT8n8Cq0ozmQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'RUB', N'руб', N'Russian Ruble', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/i_-wByMEM0auu1qmqbR_sA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'RWF', N'R₣', N'Rwanda Franc', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/wEBL29QTsUGdEWLb1NIMfw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'SAR', N'﷼', N'Saudi Riyal', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/E96rCT180U6AQnGz8fKbWA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'SBD', N'$', N'Solomon Islands Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/aenCECU9BkSst8mJKZX-tQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'SCR', N'₨', N'Seychelles Rupee', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/5qekne8cEk-zngNbqgmnpQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'SDG', N'junaih', N'Sudanese Pound', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/yhcYFYbUEUGueBDOyqeXuA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'SEK', N'kr', N'Swedish Krona', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/nK0RzWafqUW7TJbKB5FhZA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'SGD', N'$', N'Singapore Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/-JuK36C-HE6V0-rhaVQIkw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'SHP', N'£', N'Saint Helena Pound', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'SLL', N'Le', N'Leone', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/rBsteC1o8EOYVmkUDepvXA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'SOS', N'S', N'Somali Shilling', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/C0rGWLHq3EOPlLP_2dyCDw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'SRD', N'$', N'Surinam Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/yd8aNgLaU06Gp95-0Gw1bQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'STD', N'Db', N'Dobra', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/CPnOrvoquE23G5GF5DhZMw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'SVC USD', N'$', N'El Salvador Colon US Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/DksKMqgi0UWhKzHg5aDPlg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'SYP', N'£', N'Syrian Pound', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/Yx--gZL6pUqn-UDA31thdg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'SZL', N'L', N'Lilangeni', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/khIfXiR2nkSxe3JdpNXrMQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'THB', N'฿', N'Baht', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/A-hIs_akOUy-cVHvVdb9Ag.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'TJS', N'TJS', N'Somoni', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/yGBIa-cQpUuzjtVFG8kaSA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'TMT', N'm', N'Manat', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/pyS3bihJK0GSvGUCDccEHA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'TND', N'DT', N'Tunisian Dinar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/3OisL2sIZkKi1Fi67r85XQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'TOP', N'T$', N'Pa’anga', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/-h5QGxCfNUGBQPN80idKGw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'TRY', N'TL', N'Turkish Lira', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/rfCZDClq70Sh8Goul-4A-w.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'TTD', N'TT$', N'Trinidad and Tobago Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/eN0x6M6Uu0Ki-brrMMfMaA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'TWD', N'NT$', N'New Taiwan Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/JsmbVjkWJU-cR8GafG15-g.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'TZS', N'', N'Tanzanian Shilling', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/dGPa3IRN5k27OeYxQdjnIg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'UAH', N'₴', N'Hryvnia', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/2PKYRO1smU-MFiNhRtKyWw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'UGX', N'USh', N'Uganda Shilling', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/Sjv7Ep5QjEqqTyjwrWA0fw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'USD', N'$', N'US Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/dUKOx22ew0K6Qln0LLC8iQ.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'UYU UYI', N'$U', N'Peso Uruguayo Uruguay Peso en Unidades Indexadas', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/gKrLJu4bc0WGewcpioA0dg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'UZS', N'лв', N'Uzbekistan Sum', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/t--_H2GPxkGj40ApkiDOag.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'VEF', N'Bs', N'Bolivar Fuerte', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/ZNpFM1bls0-XFoaNbOdbvA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'VND', N'₫', N'Dong', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/piqcKi_9qECQHu01-F5RIA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'VUV', N'VT', N'Vatu', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/rtmKPabqRka2oy5UDLp4hw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'WST', N'$', N'Tala', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/Jdz8LYWP20qLAymVInpzqA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'XAF', N'XAF', N'CFA Franc BEAC', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/1rWSQH31ZEuvWabftb4GMg.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'XAG', N'Ag', N'Silver', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'XAU', N'Au', N'Gold', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'XBA', N'XBA', N'Bond Markets Units European Composite Unit (EURCO)', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'XBB', N'XBB', N'European Monetary Unit (E.M.U.-6)', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'XBC', N'XBC', N'European Unit of Account 9(E.U.A.-9)', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'XBD', N'XBD', N'European Unit of Account 17(E.U.A.-17)', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'XCD', N'$', N'East Caribbean Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'XDR', N'XDR', N'SDR', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'XFU', N'XFU', N'UIC-Franc', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'XOF', N'CFA', N'CFA Franc BCEAO', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'XPD', N'Pd', N'Palladium', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'XPF', N'F', N'CFP Franc', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'XPT', N'Pt', N'Platinum', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'XTS', N'XTS', N'Codes specifically reserved for testing purposes', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/mOngAUb_eUS5TwXxU0ZbSw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'YER', N'﷼', N'Yemeni Rial', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/dMuSN6r6o0aAA9nZvapf0g.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'ZAR', N'R', N'Rand', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/dmRIFLEywk2z7lwtL2KC6g.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'ZAR LSL', N'R', N'Rand Loti', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/3G2wUX_ook2mrgab7NMmsA.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'ZAR NAD', N'R', N'Rand Namibia Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/JUgVUkbSZE-2BqzzFMElOw.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'ZMK', N'ZK', N'Zambian Kwacha', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/xUUq3ytf2EO552VLsDju-Q.png');
	Insert into [dbo].[Currencies] ([Deleted], [Active], [Code], [Symbol], [Name], [Top],[Image]) values(0, 1, 'ZWL', N'Z$', N'Zimbabwe Dollar', 0,N'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-files-bo/LNbVOECb6keVOQIxsbguJQ.png');

END