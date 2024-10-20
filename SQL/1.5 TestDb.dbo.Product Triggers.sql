USE TestDb
GO

CREATE TRIGGER i_tr_Product ON Product
AFTER INSERT
AS

	INSERT INTO EventLog
	(
		 ID
		,Description
	)
	SELECT
		 NEWID()
		,CONCAT_WS(' ', 'I', 'Product' , ID, Name) AS Description
	FROM INSERTED

GO

CREATE TRIGGER d_tr_Product ON Product
AFTER DELETE
AS

	INSERT INTO EventLog
	(
		 ID
		,Description
	)
	SELECT
		 NEWID()
		,CONCAT_WS(' ', 'D', 'Product', ID, Name) AS Description
	FROM DELETED

GO

CREATE TRIGGER u_tr_Product ON Product
AFTER UPDATE
AS
	INSERT INTO EventLog
	(
		 ID
		,Description
	)
	SELECT
		 NEWID()
		,CONCAT_WS(' ','U', 'Product', d.ID
				,IIF(UPDATE(Name),'Name: '+d.Name,''), IIF(UPDATE(Description),'Description: '+ d.Description,'')
				,'->'
				,IIF(UPDATE(Name),'Name: '+i.Name,''), IIF(UPDATE(Description),'Description: '+ i.Description,'')
		) AS Description
	FROM INSERTED AS i
	INNER JOIN DELETED AS d
		ON i.ID = d.ID
	WHERE 
		UPDATE(Name) AND i.Name <> d.Name
		OR
		UPDATE(Description) AND i.Description <> d.Description
GO