USE TestDb
GO

CREATE TABLE Product
(
	 ID            UNIQUEIDENTIFIER   NOT NULL CONSTRAINT pk_Product PRIMARY KEY 
	,Name          VARCHAR(255)       NOT NULL CONSTRAINT uq_Product_Name UNIQUE(Name)
	,Description   VARCHAR(MAX)           NULL
)

CREATE UNIQUE NONCLUSTERED INDEX uq_nc_idx_Product_Name ON Product
(
	Name
) WITH (ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
    @value = N'Изделия',
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'Product';

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = 'GUID',
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'Product',
    @level2type = 'COLUMN', @level2name = N'ID';

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = 'Наименование изделия',
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'Product',
    @level2type = 'COLUMN', @level2name = N'Name';

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = 'Описание изделия',
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'Product',
    @level2type = 'COLUMN', @level2name = N'Description';
