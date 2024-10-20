USE TestDb
GO

INSERT INTO dbo.ProductVersion
    (
		 ID
		,ProductID
		,Name
		,Description
		,Width
		,Height
		,Length
	)
    SELECT
		 NEWID()
		,ID
		,'ВЕРСИЯ ' + Name
		,'ВЕРСИЯ ' + Description
		,LEN(Name)
		,LEN(Description)
		,LEN(Name) + LEN(Description)
	FROM Product
GO


