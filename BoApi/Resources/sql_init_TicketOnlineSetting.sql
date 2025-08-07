DELETE TicketOnlineSettings
DBCC CHECKIDENT ('TicketOnlineSettings', RESEED, 0)

INSERT INTO TicketOnlineSettings
VALUES (1, 'Hotline', '0845 859 108', 'ContactInformationHotline', 0, 1, GETDATE(), '', GETDATE(), '');
	--------------------------------

INSERT INTO TicketOnlineSettings
VALUES (1, 'Name company', 'ECR Solutions ©2021', 'TitleFooter', 0, 1, GETDATE(), '', GETDATE(), '');
	--------------------------------

INSERT INTO TicketOnlineSettings
VALUES (1, 'VAT number', '123456789', 'VATNumber', 0, 1, GETDATE(), '', GETDATE(), '');
	--------------------------------
	
INSERT INTO TicketOnlineSettings
VALUES (1, 'Visit Scotland', 'https://dev-ecr-v2.s3.eu-west-2.amazonaws.com/client-user-avatar-images-bo/rc7XnG6_IUGzUVfYEtvvUA.png', 'VisitScotland', 0, 1, GETDATE(), '', GETDATE(), '');
	--------------------------------