USE TestDb
GO

CREATE TABLE ProductVersion
(
	 ID            UNIQUEIDENTIFIER   NOT NULL CONSTRAINT pk_ProductVersion PRIMARY KEY 
	,ProductID     UNIQUEIDENTIFIER   NOT NULL CONSTRAINT fk_ProductVersion_Product FOREIGN KEY (ProductID) REFERENCES Product (ID) ON DELETE CASCADE ON UPDATE CASCADE
	,Name          VARCHAR(255)       NOT NULL 
	,Description   VARCHAR(MAX)           NULL
	,CreatingDate  DATETIME2(2)       NOT NULL CONSTRAINT def_ProductVersion_CreatingDate DEFAULT GETDATE()
	,Width         DECIMAL(16,2)      NOT NULL CONSTRAINT ch_ProductVersion_Width  CHECK (Width > 0)
	,Height        DECIMAL(16,2)      NOT NULL CONSTRAINT ch_ProductVersion_Height CHECK (Height > 0)
	,Length        DECIMAL(16,2)      NOT NULL CONSTRAINT ch_ProductVersion_Length CHECK (Length > 0)
)

CREATE NONCLUSTERED INDEX nc_idx_ProductVersion_Name ON ProductVersion
(
	Name
) WITH (ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

CREATE NONCLUSTERED INDEX nc_idx_ProductVersion_CreatingDate ON ProductVersion
(
	CreatingDate
) WITH (ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

CREATE NONCLUSTERED INDEX nc_idx_ProductVersion_Width ON ProductVersion
(
	Width
) WITH (ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

CREATE NONCLUSTERED INDEX nc_idx_ProductVersion_Height ON ProductVersion
(
	Height
) WITH (ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

CREATE NONCLUSTERED INDEX nc_idx_ProductVersion_Length ON ProductVersion
(
	Length
) WITH (ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


EXEC sys.sp_addextendedproperty @name = N'MS_Description',
    @value = N'Версия изделия', 
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'ProductVersion';

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = 'GUID',
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'ProductVersion',
    @level2type = 'COLUMN', @level2name = N'ID';

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = 'GUID изделия (таблица Product)',
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'ProductVersion',
    @level2type = 'COLUMN', @level2name = N'ProductID';

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = 'Наименование версии изделия',
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'ProductVersion',
    @level2type = 'COLUMN', @level2name = N'Name';

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = 'Описание версии изделия',
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'ProductVersion',
    @level2type = 'COLUMN', @level2name = N'Description';

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = 'Дата создания версии изделия',
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'ProductVersion',
    @level2type = 'COLUMN', @level2name = N'CreatingDate';

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = 'Габаритная ширина версии изделия',
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'ProductVersion',
    @level2type = 'COLUMN', @level2name = N'Width';

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = 'Габаритная высота версии изделия',
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'ProductVersion',
    @level2type = 'COLUMN', @level2name = N'Height';

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = 'Габаритная длина версии изделия',
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'ProductVersion',
    @level2type = 'COLUMN', @level2name = N'Length';
