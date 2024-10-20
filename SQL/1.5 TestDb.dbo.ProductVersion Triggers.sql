USE TestDb
GO

CREATE TRIGGER i_tr_ProductVersion ON ProductVersion
AFTER INSERT
AS

	INSERT INTO EventLog
	(
		 ID
		,Description
	)
	SELECT
		 NEWID()
		,CONCAT_WS(' ', 'I', 'ProductVersion', ID, Name) AS Description
	FROM INSERTED

GO

CREATE TRIGGER d_tr_ProductVersion ON ProductVersion
AFTER DELETE
AS

	INSERT INTO EventLog
	(
		 ID
		,Description
	)
	SELECT
		 NEWID()
		,CONCAT_WS(' ', 'D', 'ProductVersion', ID, Name) AS Description
	FROM DELETED

GO

CREATE TRIGGER u_tr_ProductVersion ON ProductVersion
AFTER UPDATE
AS
	INSERT INTO EventLog
	(
		 ID
		,Description
	)
	SELECT
		 NEWID()
		,CONCAT_WS(' ','U', 'ProductVersion', d.ID
				,IIF(UPDATE(Name),'Name: '+d.Name,''), IIF(UPDATE(Description),'Description: '+ d.Description,''), IIF(UPDATE(CreatingDate),'CreatingDate: '+ CONVERT(VARCHAR(25),d.CreatingDate,120),'')
				,IIF(UPDATE(Width),'Width: '+ CONVERT(VARCHAR(255), d.Width),''), IIF(UPDATE(Height),'Height: '+ CONVERT(VARCHAR(255), d.Height),''), IIF(UPDATE(Length),'Length: '+ CONVERT(VARCHAR(255), d.Length),'')
				,'->'
				,IIF(UPDATE(Name),'Name: '+i.Name,''), IIF(UPDATE(Description),'Description: '+ i.Description,''), IIF(UPDATE(CreatingDate),'CreatingDate: '+ CONVERT(VARCHAR(25),i.CreatingDate,120),'')
				,IIF(UPDATE(Width),'Width: '+ CONVERT(VARCHAR(255), i.Width),''), IIF(UPDATE(Height),'Height: '+ CONVERT(VARCHAR(255), i.Height),''), IIF(UPDATE(Length),'Length: '+ CONVERT(VARCHAR(255), i.Length),'')
		) AS Description
	FROM INSERTED AS i
	INNER JOIN DELETED AS d
		ON i.ID = d.ID
	WHERE 
		UPDATE(Name) AND i.Name <> d.Name
		OR
		UPDATE(Description) AND i.Description <> d.Description
		OR
		UPDATE(CreatingDate) AND i.CreatingDate <> d.CreatingDate
		OR
		UPDATE(Width) AND i.Width <> d.Width
		OR
		UPDATE(Height) AND i.Height <> d.Height
		OR
		UPDATE(Length) AND i.Length <> d.Length
GO