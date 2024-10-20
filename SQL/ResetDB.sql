USE master
GO

IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = N'TestDb'
)
DROP DATABASE TestDb
GO

CREATE DATABASE TestDb
GO

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

INSERT INTO Product
(
	 ID
	,Name
	,Description
)
VALUES
 (NEWID(), 'Apple iPhone 13', 'Смартфон с 6,1-дюймовым дисплеем, улучшенной камерой и высокой производительностью.')
,(NEWID(), 'Samsung Galaxy S21', 'Флагманский смартфон с потрясающим AMOLED дисплеем и тройной камерой.')
,(NEWID(), 'Sony WH-1000XM4', 'Беспроводные наушники с активным шумоподавлением и великолепным качеством звука.')
,(NEWID(), 'Dell XPS 13', 'Ультратонкий ноутбук с высоким разрешением и мощным процессором.')
,(NEWID(), 'Fitbit Versa 3', 'Умные часы, способные отслеживать фитнес-показатели и уведомления со смартфона.')
,(NEWID(), 'Canon EOS Rebel T7', 'Цифровая зеркальная камера для начинающих с высоким качеством снимков.')
,(NEWID(), 'Nike Air Zoom Pegasus 38', 'Легкие и комфортные кроссовки для бега с отличной амортизацией.')
,(NEWID(), 'Instant Pot Duo', 'Многофункциональный мультиварка для быстрого и удобного приготовления пищи.')
,(NEWID(), 'Vitamix E310', 'Профессиональный блендер для приготовления смузи, супов и соусов.')
,(NEWID(), 'LG OLED55CXPUA', '55-дюймовый OLED телевизор с потрясающим качеством изображения и поддержкой HDR.')
,(NEWID(), 'Bose SoundLink Color II', 'Портативная Bluetooth колонка с мощным звуком и защитой от влаги.')
,(NEWID(), 'JBL Charge 4', 'Портативная колонка с глубокими басами и длительным временем работы от батареи.')
,(NEWID(), 'Samsung Galaxy Tab S7', 'Премиум планшет с большим экраном и возможностью использования стилуса.')
,(NEWID(), 'Apple MacBook Air M1', 'Легкий и мощный ноутбук с чипом M1, который обеспечивает фантастическую производительность.')
,(NEWID(), 'Google Nest Hub', 'Умный дисплей с голосовым управлением, который помогает в повседневных задачах.')
,(NEWID(), 'TP-Link Archer AX50', 'Маршрутизатор с поддержкой Wi-Fi 6 для высокой скорости интернета.')
,(NEWID(), 'Anker PowerCore 10000', 'Компактная портативная зарядка с большой емкостью.')
,(NEWID(), 'Nintendo Switch', 'Гибридная игровая консоль, которую можно использовать как в портативном, так и стационарном режиме.')
,(NEWID(), 'Philips Hue White and Color', 'Умные лампочки с возможностью управления через приложение и настройкой цветовой гаммы.')
,(NEWID(), 'Razor Hovertrax 2.0', 'Электрический самокат для удобного передвижения по городу.')
,(NEWID(), 'KitchenAid Artisan Stand Mixer', 'Многофункциональный кухонный комбайн для смешивания, замешивания и взбивания.')
,(NEWID(), 'Fire TV Stick 4K', 'Мультимедийный потоковый плеер с поддержкой 4K-video и голосовым управлением.')
,(NEWID(), 'Amazon Echo Dot', 'Компактная колонка с голосовым управлением и интеграцией с Alexa.')
,(NEWID(), 'Sony PlayStation 5', 'Игровая консоль нового поколения с высокой производительностью и великолепной графикой.')
,(NEWID(), 'Microsoft Surface Pro 7', 'Универсальный 2-в-1 планшет с клавиатурой и мощными функциями для работы и развлечений.')
,(NEWID(), 'Garmin Fenix 6', 'Многофункциональные спортивные часы с GPS и функциями для отслеживания активных тренировок.')
,(NEWID(), 'Lenovo IdeaPad 3', 'Доступный ноутбук для учебы и работы с хорошей производительностью.')
,(NEWID(), 'iRobot Roomba 675', 'Умный робот-пылесос для автоматической уборки.')
,(NEWID(), 'Sennheiser HD 560S', 'Наушники с открытым дизайном и превосходным качеством аудиовоспроизводства.')
,(NEWID(), 'Razer BlackWidow V3', 'Механическая игровая клавиатура с RGB подсветкой и удобным дизайном.')
,(NEWID(), 'Corsair K55 RGB', 'Доступная игровая клавиатура с подсветкой и программируемыми клавишами.')
,(NEWID(), 'Logitech MX Master 3', 'Беспроводная мышь с высокой точностью и продолжительным временем работы от аккумулятора.')
,(NEWID(), 'MSI GF65 Thin', 'Игровой ноутбук со сдвоенной графикой и высоким качеством сборки.')
,(NEWID(), 'OnePlus 9', 'Смартфон с быстрой зарядкой и отличным качеством камер.')
,(NEWID(), 'ASUS ROG Strix G15', 'Игровой ноутбук с высокой производительностью и качественным дисплеем.')
,(NEWID(), 'Sony A7 III', 'Полнокадровая беззеркальная камера с высокой чувствительностью и быстрой фокусировкой.')
,(NEWID(), 'Dell UltraSharp U2720Q', '27-дюймовый 4K монитор с отличной цветопередачей и широкими углами обзора.')
,(NEWID(), 'Apple Watch Series 7', 'Умные часы с фитнес-отслеживанием и службой уведомлений.')
,(NEWID(), 'Google Pixel 6', 'Смартфон с отличной камерой и возможностью редактирования фото.')
,(NEWID(), 'Corsair Vengeance LPX 16GB', 'Оперативная память для стабильной работы и высоких показателей в играх.')
,(NEWID(), 'AOC CQ27G1', '27-дюймовый изогнутый монитор с высокой частотой обновления для геймеров.')
,(NEWID(), 'Westinghouse 32-Inch', 'HDTV с возможностью подключения HDMI и USB.')
,(NEWID(), 'Apple AirPods Pro', 'Беспроводные наушники с активным шумоподавлением и качественным звуком.')
,(NEWID(), 'Withings Body+', 'Умные весы с анализом состава тела и Bluetooth-соединением.')
,(NEWID(), 'Wacom Intuos Pro', 'Графический планшет для художников и дизайнеров с чувствительным стилусом.')
,(NEWID(), 'HyperX Cloud II', 'Игровые наушники с качественным звуком и комфортной посадкой.')
,(NEWID(), 'LG Gram 17', 'Легкий и мощный ноутбук с большим экраном для работы и развлечений.')
,(NEWID(), 'Amazon Basics Office Chair', 'Комфортабельное офисное кресло с регулировкой высоты.')
,(NEWID(), 'Breville BES870XL', 'Эспрессо-машина с возможностью молочной пены для приготовления кофе.')
,(NEWID(), 'TCL 6-Series', '4K HDR телевизор с поддержкой Dolby Vision и умными функциями.')
,(NEWID(), 'Razer Kraken', 'Игровая гарнитура с качественным звуком и удобством для длительных игровых сессий.')
,(NEWID(), 'Fitbit Inspire 2', 'Фитнес-браслет с функцией отслеживания активности и мониторинга сна.')
,(NEWID(), 'Belkin Wireless Charger', 'Беспроводная зарядка для смартфонов с быстрой зарядкой.')
,(NEWID(), 'Amazon Kindle Paperwhite', 'Электронная книга с подсветкой и защитой от влаги.')
,(NEWID(), 'SteelSeries Rival 600', 'Игровая мышь с настраиваемой подсветкой и высокой чувствительностью.')
,(NEWID(), 'Samsung SmartThings Hub', 'Умный хаб для управления устройствами умного дома.')
,(NEWID(), 'HP Envy 6055', 'Многофункциональное устройство для печати, сканирования и копирования.')
,(NEWID(), 'NETGEAR Nighthawk X6', 'Высокоскоростной маршрутизатор с технологией MIMO для стабильного подключения.')
,(NEWID(), 'Jabra Elite 75t', 'Компактные беспроводные наушники с отличным качеством звука и длительным временем работы.')
,(NEWID(), 'Philips Series 3000', 'Электробритва с технологией защиты кожи и установкой для сухого и влажного бритья.')
,(NEWID(), 'Logitech C920', 'HD веб-камера с отличным качеством изображения для стриминга и видеозвонков.')
,(NEWID(), 'T-fal E93808', 'Неокрашенная сковорода с антипригарным покрытием для удобного приготовления пищи.')
,(NEWID(), 'Mophie wireless charging pad', 'Беспроводная зарядка для смартфонов и других устройств.')
,(NEWID(), 'Harman Kardon Onyx Studio 5', 'Премиум портативная Bluetooth колонка с чистым звуком.')
,(NEWID(), 'Rdefault Goldie', 'Удобная и стильная сумка для ноутбука.')
,(NEWID(), 'KitchenAid Classic', 'Настольный планетарный миксер для выпечки и приготовления блюд.')
,(NEWID(), 'ASICS Gel-Kayano 27', 'Кроссовки для бега с отличной амортизацией и поддержкой.')
,(NEWID(), 'Toshiba Canvio Basics', 'Внешний жесткий диск для сохранения информации и резервного копирования.')
,(NEWID(), 'Withings ScanWatch', 'Смарт-часы с функцией мониторинга здоровья и активностью с долгим временем работы от батареи.')
,(NEWID(), 'OnePlus Nord', 'Стильный смартфон среднего класса с хорошими характеристиками.')
,(NEWID(), 'SanDisk Ultra Flair', 'USB флешка с высокой скоростью передачи данных и стильным дизайном.')
,(NEWID(), 'Fitbit Luxe', 'Элегантный фитнес-браслет с функцией мониторинга за состоянием здоровья и уровня стресса.')
,(NEWID(), 'Roku Streaming Stick+', 'Компактный медиаплеер для потоковой передачи контента в разрешении 4K.')
,(NEWID(), 'Marshall Major III', 'Наушники с беспроводной связью и классическим дизайном.')
,(NEWID(), 'Huawei MateBook D', 'Ноутбук с тонким корпусом и хорошей производительностью для работы и учебы.')
,(NEWID(), 'Oontz Angle 3', 'Портативная Bluetooth колонка с четким звуком и длительным временем работы от батареи.')
,(NEWID(), 'NutriBullet Pro', 'Блендер для смузи и коктейлей с высокой мощностью для быстрого приготовления.')
,(NEWID(), 'Apple Pencil (2nd Generation)', 'Стилус для iPad с поддержкой беспроводной зарядки.')
,(NEWID(), 'Zagg Rugged Book', 'Устойчивый к ударам чехол-клавиатура для iPad.')
,(NEWID(), 'Razer BlackWidow Lite', 'Игровая клавиатура с белой подсветкой и удобными механическими ключами.')
,(NEWID(), 'LG 27UK850-W', '27-дюймовый 4K монитор с поддержкой HDR и USB-C.')
,(NEWID(), 'Nest Learning Thermostat', 'Умный термостат, который учится и подстраивается под ваши привычки.')
,(NEWID(), 'Ultimate Ears BOOM 3', 'Портативная колонка с водонепроницаемым корпусом и 360-градусным звуком.')
,(NEWID(), 'Netgear Orbi', 'Mesh-система Wi-Fi для обеспечения стабильного интернета во всем доме.')
,(NEWID(), 'Canon PIXMA TR150', 'Портативный принтер для печати документов и фотографии в дороге.')
,(NEWID(), 'LG TONE Free HBS-FN6', 'Беспроводные наушники с качественным звуком и мощным аккумулятором.')
,(NEWID(), 'Samsung Galaxy Buds Live', 'Беспроводные наушники с уникальным дизайном и активным шумоподавлением.')
,(NEWID(), 'Sony ZV-1', 'Компактная камера, разработанная специально для vlogging.')
,(NEWID(), 'iRobot Braava Jet 240', 'Робот-пылесос для влажной уборки пола.')
,(NEWID(), 'Anker PowerPort III Nano', 'Компактное зарядное устройство с быстрой зарядкой для смартфонов.')
,(NEWID(), 'Microsoft Xbox Series X', 'Игровая консоль нового поколения с непревзойденным качеством графики.')
,(NEWID(), 'Eufy Security Cam 2', 'Умная камера безопасности с высоким разрешением и ночным видением.')
,(NEWID(), 'Logitech StreamCam', 'Веб-камера для стриминга и записи видео в высоком разрешении.')
,(NEWID(), 'Nest Protect', 'Умный детектор дыма и угарного газа с уведомлениями на телефон.')
,(NEWID(), 'Samsung Galaxy A52', 'Доступный смартфон с хорошими характеристиками и отличной камерой.')
,(NEWID(), 'Seagate Expansion Portable', 'Внешний жесткий диск для легкого хранения и перемещения данных.')
,(NEWID(), 'Ring Video Doorbell', 'Умный дверной звонок с видеозаписью и функцией ночного видения.')
,(NEWID(), 'Corsair H100i RGB Platinum', 'Система водяного охлаждения для повышения производительности компьютера.')
,(NEWID(), 'HyperX Alloy FPS Pro', 'Компактная механическая игровая клавиатура для удобства во время игры.')
,(NEWID(), 'Oura Ring', 'Умное кольцо для мониторинга здоровья и активности.')
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