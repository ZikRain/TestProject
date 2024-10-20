CREATE PROCEDURE prcSearchProduct
(
	 @productName VARCHAR(255) = NULL
	,@productVersionName VARCHAR(255) = NULL
	,@minVolume DECIMAL(16,2) = NULL
	,@maxVolume DECIMAL(16,2) = NULL
)
AS

	If @minVolume IS NULL AND @maxVolume IS NULL AND @productName IS NULL AND @productVersionName IS NULL
	BEGIN

		SELECT 
			 v.ID     AS 'ID версии изделия'
			,p.Name   AS 'Наименование изделия'
			,v.Name   AS 'Наименование версии изделия'
			,v.Width  AS 'Габаритная ширина изделия'
			,v.Length AS 'Габаритная длина изделия'
			,v.Height AS 'Габаритная высота изделия'
		FROM ProductVersion AS v
		INNER JOIN Product AS p
			ON p.ID = v.ProductID

	END
	ELSE
	BEGIN

		DECLARE @productNameSearch VARCHAR(255) = '%' + @productName + '%';
		DECLARE @productVersionNameSearch VARCHAR(255) = '%' + @productVersionName + '%';

		SELECT 
			 v.ID     AS 'ID версии изделия'
			,p.Name   AS 'Наименование изделия'
			,v.Name   AS 'Наименование версии изделия'
			,v.Width  AS 'Габаритная ширина изделия'
			,v.Length AS 'Габаритная длина изделия'
			,v.Height AS 'Габаритная высота изделия'
		FROM ProductVersion AS v
		INNER JOIN Product AS p
			ON p.ID = v.ProductID
		WHERE
			(@minVolume IS NULL OR v.Width * v.Length * v.Height > @minVolume)
			AND
			(@maxVolume IS NULL OR v.Width * v.Length * v.Height < @maxVolume)
			AND
			(@productName IS NULL OR p.Name LIKE @productNameSearch)
			AND
			(@productVersionName IS NULL OR v.Name LIKE @productVersionNameSearch)

	END
	
GO

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = 'Процедура поиска версий изделия',
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'PROCEDURE', @level1name = N'prcSearchProduct';
GO