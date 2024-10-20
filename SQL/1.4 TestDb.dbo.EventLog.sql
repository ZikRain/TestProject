USE TestDb
GO

CREATE TABLE EventLog
(
	 ID            UNIQUEIDENTIFIER   NOT NULL CONSTRAINT pk_EventLog PRIMARY KEY
	,EventDate     DATETIME2(2)       NOT NULL CONSTRAINT def_EventLog_EventDate DEFAULT GETDATE()
	,Description   VARCHAR(MAX)           NULL
)

CREATE NONCLUSTERED INDEX nc_idx_EventLog_EventDate ON EventLog
(
	EventDate
) WITH (ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

EXEC sys.sp_addextendedproperty @name = N'MS_Description',
    @value = N'Журнал событий', 
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'EventLog';

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = 'GUID',
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'EventLog',
    @level2type = 'COLUMN', @level2name = N'ID';

EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = 'Дата совершения события',
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'EventLog',
    @level2type = 'COLUMN', @level2name = N'EventDate';


EXEC sp_addextendedproperty @name = N'MS_Description',
    @value = 'Описание события',
    @level0type = 'SCHEMA', @level0name = N'dbo',
    @level1type = 'TABLE', @level1name = N'EventLog',
    @level2type = 'COLUMN', @level2name = N'Description';
