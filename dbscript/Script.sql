USE master
GO

--DROP DATABASE Promotion

CREATE DATABASE Promotion
ON
	(NAME = 'Promotion',
	FILENAME = 'C:\Program Files (x86)\SQL Express\MSSQL12.SQLEXPRESS\MSSQL\DATA\Promotion.mdf',
	SIZE = 5,
	MAXSIZE = 10,
	FILEGROWTH = 1)
LOG ON
	(NAME = 'Promotion_log',
	FILENAME = 'C:\Program Files (x86)\SQL Express\MSSQL12.SQLEXPRESS\MSSQL\DATA\Promotion_log.ldf',
	SIZE = 2,
	MAXSIZE = 5,
	FILEGROWTH = 1)
GO

USE Promotion
GO


/*ПРАВИЛА, УМОЛЧАНИЯ, ПОЛЬЗОВАТЕЛЬСКИЕ ТИПЫ*/


--Телефон
CREATE RULE R_Phone
	AS
		@x NOT LIKE '%[^0-9+() -]%' 
		AND @x NOT LIKE '+%+%'
		AND @x NOT LIKE '%(%(%'
		AND @x NOT LIKE '%)%[()]%'
		AND @x NOT LIKE '%[^0-9]-%'
		AND @x NOT LIKE '%-[^0-9]%'
		AND @x NOT LIKE '%[^0-9()][ ]%'
		AND @x NOT LIKE '%[ ][^0-9()]%'
GO
CREATE TYPE Phone
FROM varchar(20) not null 
GO
EXEC sp_bindrule 'R_Phone', 'Phone'
GO

--Email
CREATE RULE R_Email
	AS
		@x LIKE '_%@_%._%' 
		AND @x NOT LIKE '%@%@%'
		AND @x NOT LIKE ('%["(),:;<>/\* ]%')
		AND @x NOT LIKE '%[%'
		AND @x NOT LIKE '%]%'
GO
CREATE TYPE Email
FROM varchar(50) not null 
GO
EXEC sp_bindrule 'R_Email', 'Email'
GO

--Статус поединка
CREATE RULE R_FightStatus
	AS
		@x IN ('Ч', 'Н')
GO
CREATE DEFAULT D_FightStatus
	AS
		'Н'
GO
CREATE TYPE FightStatus
FROM char(1) not null
GO
EXEC sp_bindrule 'R_FightStatus', 'FightStatus'
EXEC sp_bindefault 'D_FightStatus', 'FightStatus'
GO

--Больше нуля (в основном для денежных значений)
CREATE RULE R_AboveZero
	AS
		@x > 0 OR @x IS NULL
GO

--Для ФИО и стран
CREATE RULE R_TextValue
	AS
		@x NOT LIKE '%[^А-Яа-я -.]%'
GO

--Вес
CREATE RULE R_Weight
	AS
		@x >= 50 AND @x <= 300
GO

--Рост и размах рук
CREATE RULE R_Height
	AS
		@x >= 150 AND @x <= 240
GO

--Международное название (на латинице)
CREATE RULE R_English
	AS
		@x NOT LIKE '%[^A-Za-z -]%'
GO

--Номер контракта
CREATE RULE R_Contract
	AS
		@x LIKE '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9]'
GO

--Страна и гражданство
CREATE DEFAULT D_Russia
	AS
		'Россия'
GO

--Раунд и время для поединков, дошедших до решения
CREATE DEFAULT D_Round
	AS
		3
GO
CREATE DEFAULT D_Time
	AS
		'00:05:00'
GO


/*СОЗДАНИЕ ТАБЛИЦ*/


CREATE TABLE Арена
(Название varchar(30) not null,
Местоположение varchar(100) not null,
[Вместимость (чел)] int not null,
[Год открытия] smallint null,
Владелец varchar(100) not null)
GO
ALTER TABLE Арена
ADD CONSTRAINT PK_Арена primary key (Название)
GO
ALTER TABLE Арена
ADD CONSTRAINT CHK_Арена check ([Вместимость (чел)] >= 100 AND
[Вместимость (чел)] <= 200000 AND [Год открытия] >= 1800 AND
[Год открытия] <= YEAR(GETDATE()))
GO

CREATE TABLE Турнир
(Название varchar(60) not null,
[Место проведения] varchar(30) not null,
Дата date null,
[Суммарная посещаемость (чел)] int null, 
[Общая выручка (руб)] money null,
[Затраты на организацию (руб)] money null)
GO
ALTER TABLE Турнир
ADD CONSTRAINT PK_Турнир primary key (Название)
GO
ALTER TABLE Турнир
ADD CONSTRAINT FK_Турнир_Арена foreign key ([Место проведения]) references Арена(Название)
	ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE Турнир
ADD CONSTRAINT UC_Турнир_Дата unique (Дата)
GO
EXEC sp_bindrule 'R_AboveZero', 'Турнир.[Затраты на организацию (руб)]'
EXEC sp_bindrule 'R_AboveZero', 'Турнир.[Общая выручка (руб)]'
EXEC sp_bindrule 'R_AboveZero', 'Турнир.[Суммарная посещаемость (чел)]'
GO

CREATE TABLE Билет
([Тип билета] varchar(3) not null,
[Официальное название] varchar(20) null)
GO
ALTER TABLE Билет
ADD CONSTRAINT PK_Билет primary key ([Тип билета])
GO

CREATE TABLE ПродажаБилетов
(Турнир varchar(60) not null,
[Тип билета] varchar(3) not null,
[Стоимость (руб)] money not null,
[Выставлено билетов] smallint null,
[Продано билетов] smallint null)
GO
ALTER TABLE ПродажаБилетов
ADD CONSTRAINT PK_ПродажаБилетов primary key (Турнир, [Тип билета])
GO
ALTER TABLE ПродажаБилетов
ADD CONSTRAINT FK_ПродажаБилетов_Турнир foreign key (Турнир) references Турнир(Название)
	ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE ПродажаБилетов
ADD CONSTRAINT FK_ПродажаБилетов_Билет foreign key ([Тип билета]) references Билет([Тип билета])
	ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE ПродажаБилетов
ADD CONSTRAINT CHK_ПродажаБилетов check ([Продано билетов] <= [Выставлено билетов])
GO
EXEC sp_bindrule 'R_AboveZero', 'ПродажаБилетов.[Стоимость (руб)]'
EXEC sp_bindrule 'R_AboveZero', 'ПродажаБилетов.[Выставлено билетов]'
EXEC sp_bindrule 'R_AboveZero', 'ПродажаБилетов.[Продано билетов]'
GO

CREATE TABLE Стаж
(Стаж tinyint not null,
[Коэффициент увеличения зарплаты] float not null)
GO
ALTER TABLE Стаж
ADD CONSTRAINT PK_Стаж primary key (Стаж)
GO
ALTER TABLE Стаж
ADD CONSTRAINT CHK_Стаж check (Стаж <= 40 AND
[Коэффициент увеличения зарплаты] >= 1)
GO

CREATE TABLE Боец
(Код int not null identity (1, 1),
Стаж tinyint not null,
ФИО varchar(50) not null,
[Дата рождения] date not null,
Страна varchar(30) not null,
[Вес (кг)] float not null,
[Рост (см)] float not null,
[Размах рук (см)] float not null,
Гражданство varchar(30) not null,
[Паспортные данные] varchar(20) not null,
Телефон Phone,
[Электронная почта] Email,
Адрес varchar(MAX) not null)
GO
ALTER TABLE Боец
ADD CONSTRAINT PK_Боец primary key (Код)
GO
ALTER TABLE Боец
ADD CONSTRAINT FK_Боец_Стаж foreign key (Стаж) references Стаж(Стаж)
GO
ALTER TABLE Боец
ADD CONSTRAINT UC_Боец_Паспорт unique ([Паспортные данные])
GO
ALTER TABLE Боец
ADD CONSTRAINT CHK_Боец check (DATEADD(year, 16, [Дата рождения]) <= GETDATE())
GO
EXEC sp_bindrule 'R_TextValue', 'Боец.ФИО'
EXEC sp_bindrule 'R_TextValue', 'Боец.Страна'
EXEC sp_bindrule 'R_TextValue', 'Боец.Гражданство'
EXEC sp_bindrule 'R_Weight', 'Боец.[Вес (кг)]'
EXEC sp_bindrule 'R_Height', 'Боец.[Рост (см)]'
EXEC sp_bindrule 'R_Height', 'Боец.[Размах рук (см)]'
EXEC sp_bindefault 'D_Russia', 'Боец.Страна'
EXEC sp_bindefault 'D_Russia', 'Боец.Гражданство'
GO

CREATE TABLE Контракт
(Номер char(11) not null,
Боец int not null,
[Количество поединков] tinyint not null,
[Гонорар за выступление (руб)] money not null,
[Ежемесячная зарплата (руб)] money not null,
[Ежемесячная компенсация (руб)] money not null,
[Дата подписания договора] date null,
[Дата окончания договора] date not null) 
GO
ALTER TABLE Контракт
ADD CONSTRAINT PK_Контракт primary key (Номер)
GO
ALTER TABLE Контракт
ADD CONSTRAINT FK_Контракт_Боец foreign key (Боец) references Боец(Код)
	ON DELETE CASCADE
GO
ALTER TABLE Контракт
ADD CONSTRAINT CHK_Контракт check ([Количество поединков] <= 20)
GO
EXEC sp_bindrule 'R_Contract', 'Контракт.Номер'
EXEC sp_bindrule 'R_AboveZero', 'Контракт.[Количество поединков]'
EXEC sp_bindrule 'R_AboveZero', 'Контракт.[Гонорар за выступление (руб)]'
EXEC sp_bindrule 'R_AboveZero', 'Контракт.[Ежемесячная зарплата (руб)]'
EXEC sp_bindrule 'R_AboveZero', 'Контракт.[Ежемесячная компенсация (руб)]'
GO

CREATE TABLE ВесоваяКатегория
([Весовая категория] varchar(20) not null,
[Нижняя граница (кг)] float not null,
[Верхняя граница (кг)] float not null,
[Международное название] varchar(20) null)
GO
ALTER TABLE ВесоваяКатегория
ADD CONSTRAINT PK_ВесоваяКатегория primary key ([Весовая категория])
GO
ALTER TABLE ВесоваяКатегория
ADD CONSTRAINT UC_ВесоваяКатегория_МеждународноеНазвание unique ([Международное название])
GO
EXEC sp_bindrule 'R_TextValue', 'ВесоваяКатегория.[Весовая Категория]'
EXEC sp_bindrule 'R_Weight', 'ВесоваяКатегория.[Нижняя граница (кг)]'
EXEC sp_bindrule 'R_Weight', 'ВесоваяКатегория.[Верхняя граница (кг)]'
EXEC sp_bindrule 'R_English', 'ВесоваяКатегория.[Международное название]'
GO

CREATE TABLE Поединок
(Номер int not null identity (1, 1),
[Боец 1] int not null,
[Боец 2] int not null,
Турнир varchar(60) not null,
[Весовая категория] varchar(20) not null,
[Статус поединка] FightStatus,
[Номер в турнире] tinyint null)
GO
ALTER TABLE Поединок
ADD CONSTRAINT PK_Поединок primary key (Номер)
GO
ALTER TABLE Поединок
ADD CONSTRAINT FK_Поединок_Боец_1 foreign key ([Боец 1]) references Боец(Код)
GO
ALTER TABLE Поединок
ADD CONSTRAINT FK_Поединок_Боец_2 foreign key ([Боец 2]) references Боец(Код)
GO
ALTER TABLE Поединок
ADD CONSTRAINT FK_Поединок_Турнир foreign key (Турнир) references Турнир(Название)
	ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE Поединок
ADD CONSTRAINT FK_Поединок_ВесоваяКатегория foreign key ([Весовая категория]) references ВесоваяКатегория([Весовая категория])
	ON DELETE CASCADE
GO

CREATE TABLE Рефери
(Код int not null identity (1, 1),
ФИО varchar(50) not null,
[Дата рождения] date not null,
Гражданство varchar(30) not null,
[Паспортные данные] varchar(20) not null,
Телефон Phone, 
[Электронная почта] Email,
Адрес varchar(MAX) not null,
[Дата подписания договора] date null)
GO
ALTER TABLE Рефери
ADD CONSTRAINT PK_Рефери primary key (Код)
GO
ALTER TABLE Рефери
ADD CONSTRAINT UC_Рефери_Паспорт unique ([Паспортные данные])
GO
ALTER TABLE Рефери
ADD CONSTRAINT UC_Рефери_Телефон unique (Телефон)
GO
ALTER TABLE Рефери
ADD CONSTRAINT UC_Рефери_Почта unique ([Электронная почта])
GO
ALTER TABLE Рефери
ADD CONSTRAINT CHK_Рефери check (DATEADD(year, 18, [Дата рождения]) <= GETDATE()
	AND [Дата подписания договора] <= GETDATE())
GO
EXEC sp_bindrule 'R_TextValue', 'Рефери.ФИО'
EXEC sp_bindrule 'R_TextValue', 'Рефери.Гражданство'
EXEC sp_bindefault 'D_Russia', 'Рефери.Гражданство'
GO

CREATE TABLE ПроведениеПоединков
(Поединок int not null,
Рефери int not null,
[Гонорар (руб)] money not null)
GO
ALTER TABLE ПроведениеПоединков
ADD CONSTRAINT PK_ПроведениеПоединков primary key (Поединок)
GO
ALTER TABLE ПроведениеПоединков
ADD CONSTRAINT FK_ПроведениеПоединков_Поединок foreign key (Поединок) references Поединок(Номер)
	ON DELETE CASCADE
GO
ALTER TABLE ПроведениеПоединков
ADD CONSTRAINT FK_ПроведениеПоединков_Рефери foreign key (Рефери) references Рефери(Код)
GO
EXEC sp_bindrule 'R_AboveZero', 'ПроведениеПоединков.[Гонорар (руб)]'
GO

CREATE TABLE Результат
(Результат varchar(50) not null,
Описание varchar(MAX) null)
GO
ALTER TABLE Результат
ADD CONSTRAINT PK_Результат primary key (Результат)
GO

CREATE TABLE РезультатыПоединков
(Поединок int not null,
Результат varchar(50) not null,
Победитель bit null,
Раунд tinyint not null,
Время time(0) not null)
GO
ALTER TABLE РезультатыПоединков
ADD CONSTRAINT PK_РезультатыПоединков primary key (Поединок)
GO
ALTER TABLE РезультатыПоединков
ADD CONSTRAINT FK_РезультатыПоединков_Поединок foreign key (Поединок) references Поединок(Номер)
	ON DELETE CASCADE
GO
ALTER TABLE РезультатыПоединков
ADD CONSTRAINT FK_РезультатыПоединков_Результат foreign key (Результат) references Результат(Результат)
	ON UPDATE CASCADE
GO
ALTER TABLE РезультатыПоединков
ADD CONSTRAINT CHK_РезультатыПоединков check (Раунд >= 1 AND Раунд <= 5 
	AND Время >= '00:00:01' AND Время <= '00:05:00')
GO
EXEC sp_bindefault 'D_Round', 'РезультатыПоединков.Раунд'
EXEC sp_bindefault 'D_Time', 'РезультатыПоединков.Время'
GO

CREATE TABLE Награда
(Награда varchar(20) not null,
[Денежный бонус (руб)] money not null,
Описание varchar(MAX) null)
GO
ALTER TABLE Награда
ADD CONSTRAINT PK_Награда primary key (Награда)
GO
EXEC sp_bindrule 'R_AboveZero', 'Награда.[Денежный бонус (руб)]'
GO

CREATE TABLE Награждение
(Поединок int not null,
Награда varchar(20) not null,
[Награжденный боец] bit null)
GO
ALTER TABLE Награждение
ADD CONSTRAINT PK_Награждение primary key (Поединок)
GO
ALTER TABLE Награждение
ADD CONSTRAINT FK_Награждение_Поединок foreign key (Поединок) references Поединок(Номер)
	ON DELETE CASCADE
GO
ALTER TABLE Награждение
ADD CONSTRAINT FK_Награждение_Награда foreign key (Награда) references Награда(Награда)
	ON DELETE CASCADE
GO

CREATE TABLE Судья
(Код int not null identity (1, 1),
ФИО varchar(50) not null,
[Дата рождения] date not null,
Гражданство varchar(30) not null,
[Паспортные данные] varchar(20) not null,
Телефон Phone,
[Электронная почта] Email,
Адрес varchar(MAX) not null,
[Дата подписания договора] date null)
GO
ALTER TABLE Судья
ADD CONSTRAINT PK_Судья primary key (Код)
GO
ALTER TABLE Судья
ADD CONSTRAINT UC_Судья_Паспорт unique ([Паспортные данные])
GO
ALTER TABLE Судья
ADD CONSTRAINT UC_Судья_Телефон unique (Телефон)
GO
ALTER TABLE Судья
ADD CONSTRAINT UC_Судья_Почта unique ([Электронная почта])
GO
ALTER TABLE Судья
ADD CONSTRAINT CHK_Судья check (DATEADD(year, 18, [Дата рождения]) <= GETDATE()
	AND [Дата подписания договора] <= GETDATE())
GO
EXEC sp_bindrule 'R_TextValue', 'Судья.ФИО'
EXEC sp_bindrule 'R_TextValue', 'Судья.Гражданство'
EXEC sp_bindefault 'D_Russia', 'Судья.Гражданство'
GO

CREATE TABLE Судейство
(Поединок int not null,
Судья int not null,
[Гонорар (руб)] money not null)
GO
ALTER TABLE Судейство
ADD CONSTRAINT PK_Судейство primary key (Поединок, Судья)
GO
ALTER TABLE Судейство
ADD CONSTRAINT FK_Судейство_Поединок foreign key (Поединок) references Поединок(Номер)
	ON DELETE CASCADE
GO
ALTER TABLE Судейство
ADD CONSTRAINT FK_Судейство_Судья foreign key (Судья) references Судья(Код)
GO
EXEC sp_bindrule 'R_AboveZero', 'Судейство.[Гонорар (руб)]'
GO


/*ТРИГГЕРЫ*/


--При участии в поединке боец должен иметь действующий контракт
CREATE TRIGGER T_КонтрактПриПоединке ON Поединок
	AFTER INSERT, UPDATE
		AS
			DECLARE @fighter1 int = (SELECT [Боец 1] FROM inserted)
			DECLARE @fighter2 int = (SELECT [Боец 2] FROM inserted)
			DECLARE @maxContractDate1 date = 
			(SELECT [Дата окончания договора] FROM Контракт
				WHERE Боец = @fighter1 AND
					[Дата подписания договора] =
				(SELECT MAX([Дата подписания договора])
					FROM Контракт
					WHERE Боец = @fighter1 AND 
						[Дата подписания договора] <= GETDATE()))
			DECLARE @maxContractDate2 date = 
			(SELECT [Дата окончания договора] FROM Контракт
				WHERE Боец = @fighter2 AND
					[Дата подписания договора] =
				(SELECT MAX([Дата подписания договора])
					FROM Контракт
					WHERE Боец = @fighter2 AND 
						[Дата подписания договора] <= GETDATE()))
			DECLARE @eventDate date = 
				(SELECT Дата FROM Турнир
					WHERE Название = (SELECT Турнир FROM inserted))
			IF @maxContractDate1 < @eventDate OR
				@maxContractDate2 < @eventDate
				ROLLBACK TRAN
GO

--Один боец не может участвовать в одном турнире дважды
CREATE TRIGGER T_ОдинРазЗаТурнир1 ON Поединок
	AFTER INSERT
		AS
			DECLARE @fighter1 int = (SELECT [Боец 1] FROM inserted)
			DECLARE @fighter2 int = (SELECT [Боец 2] FROM inserted)
			IF @fighter2 = @fighter1 ROLLBACK TRAN
			IF EXISTS(SELECT * FROM Поединок
				WHERE Номер != (SELECT Номер FROM inserted)
				AND Турнир = (SELECT Турнир FROM inserted) AND
					([Боец 1] = @fighter1 OR [Боец 1] = @fighter2 OR
					[Боец 2] = @fighter1 OR [Боец 2] = @fighter2))
						ROLLBACK TRAN
GO
CREATE TRIGGER T_ОдинРазЗаТурнир2 ON Поединок
	AFTER UPDATE
		AS
			DECLARE @fighter1 int = (SELECT [Боец 1] FROM inserted)
			DECLARE @fighter2 int = (SELECT [Боец 2] FROM inserted)
			IF @fighter2 = @fighter1 ROLLBACK TRAN
			IF EXISTS(SELECT * FROM Поединок
				WHERE Номер <> (SELECT Номер FROM inserted)
				AND Номер <> (SELECT Номер FROM deleted)
				AND Турнир = (SELECT Турнир FROM inserted) AND
					([Боец 1] = @fighter1 OR [Боец 1] = @fighter2 OR
					[Боец 2] = @fighter1 OR [Боец 2] = @fighter2))
					ROLLBACK TRAN
GO

--Номера поединков в турнире должны быть в диапазоне [1;18] и не должны повторяться
CREATE TRIGGER T_НомерПоединка ON Поединок
	AFTER INSERT, UPDATE
		AS
			DECLARE @num tinyint = (SELECT [Номер в турнире] FROM inserted)
			IF @num IS NOT NULL AND (@num < 1 OR @num > 18 
				OR EXISTS(SELECT * FROM Поединок
					WHERE Номер != (SELECT Номер FROM inserted) AND
					Турнир = (SELECT Турнир FROM inserted) AND 
					[Номер в турнире] = @num))
					ROLLBACK TRAN
GO

--При российском гражданстве паспортные данные должны соответствовать шаблону
CREATE TRIGGER T_БоецПаспорт ON Боец
	AFTER INSERT, UPDATE
		AS
			DECLARE @pass varchar(20) =
				(SELECT [Паспортные данные] FROM inserted)
			DECLARE @citiz varchar(30) =
				(SELECT Гражданство FROM inserted)
			IF LOWER(@citiz) = 'россия' AND @pass NOT LIKE
	'[0-9][0-9][0-9][0-9][ ][0-9][0-9][0-9][0-9][0-9][0-9]'
				AND @pass NOT LIKE
	'[0-9][0-9][ ][0-9][0-9][ ][0-9][0-9][0-9][0-9][0-9][0-9]'
			AND @pass NOT LIKE
	'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
				ROLLBACK TRAN
GO
CREATE TRIGGER T_РефериПаспорт ON Рефери
	AFTER INSERT, UPDATE
		AS
			DECLARE @pass varchar(20) =
				(SELECT [Паспортные данные] FROM inserted)
			DECLARE @citiz varchar(30) =
				(SELECT Гражданство FROM inserted)
			IF LOWER(@citiz) = 'россия' AND @pass NOT LIKE
	'[0-9][0-9][0-9][0-9][ ][0-9][0-9][0-9][0-9][0-9][0-9]'
				AND @pass NOT LIKE
	'[0-9][0-9][ ][0-9][0-9][ ][0-9][0-9][0-9][0-9][0-9][0-9]'
				AND @pass NOT LIKE
	'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
				ROLLBACK TRAN
GO
CREATE TRIGGER T_СудьяПаспорт ON Судья
	AFTER INSERT, UPDATE
		AS
			DECLARE @pass varchar(20) =
				(SELECT [Паспортные данные] FROM inserted)
			DECLARE @citiz varchar(30) =
				(SELECT Гражданство FROM inserted)
			IF LOWER(@citiz) = 'россия' AND @pass NOT LIKE
	'[0-9][0-9][0-9][0-9][ ][0-9][0-9][0-9][0-9][0-9][0-9]'
				AND @pass NOT LIKE
	'[0-9][0-9][ ][0-9][0-9][ ][0-9][0-9][0-9][0-9][0-9][0-9]'
				AND @pass NOT LIKE
	'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
				ROLLBACK TRAN
GO

--ВЛОЖЕННЫЙ КУРСОР
--Контроль корректности назначения наград
CREATE TRIGGER T_Награждение ON Награждение
	INSTEAD OF INSERT, UPDATE
		AS
			DECLARE @fight int, @award varchar(20), @awarded bit, 
				@date date, @error bit
			DECLARE C2 CURSOR FOR
				SELECT * FROM inserted
			OPEN C2
			FETCH NEXT FROM C2 INTO @fight, @award, @awarded
			WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @error = 0
				--Поединок должен быть состоявшимся
				SET @date = (SELECT Дата FROM Турнир
					WHERE Название = (SELECT Турнир FROM Поединок
						WHERE Номер = @fight))
				IF @date > GETDATE() 
					SET @error = 1
				/*Если награда - "Выступление вечера", должен быть указан 
				победитель, в противном случае - NULL*/
				IF @error = 0 BEGIN
					IF @award = 'Лучший бой вечера' BEGIN
						IF @awarded IS NOT NULL SET @error = 1
						END
					ELSE IF @awarded IS NULL SET @error = 1
				END
				/*Если награда назначается поединку (лучший бой вечера),
				то она должна быть единственной за турнир*/
				IF @error = 0 AND @awarded IS NULL BEGIN
					DECLARE @event varchar(60) = (SELECT Турнир
						FROM Поединок WHERE Номер = @fight)
					DECLARE @aw bit, @ev varchar(60)
					DECLARE C23 CURSOR FOR
						SELECT [Награжденный боец], Турнир 
							FROM Награждение JOIN Поединок
							ON Награждение.Поединок = Поединок.Номер
					OPEN C23
					FETCH NEXT FROM C23 INTO @aw, @ev
					WHILE @@FETCH_STATUS = 0
					BEGIN
						IF @aw IS NULL AND @ev = @event BEGIN
							SET @error = 1
							BREAK
							END
						FETCH NEXT FROM C23 INTO @aw, @ev
					END
					CLOSE C23
					DEALLOCATE C23
				END
				/*Если награда назначается бойцу (выступление вечера),
				то он должен быть победителем поединка*/
				IF @error = 0 AND @awarded IS NOT NULL BEGIN
					IF NOT EXISTS(SELECT * FROM РезультатыПоединков
					WHERE Поединок = @fight AND Победитель = @awarded)
						SET @error = 1
				END

				IF @error = 0
					INSERT INTO Награждение VALUES
					(@fight, @award, @awarded)
				FETCH NEXT FROM C2 INTO @fight, @award, @awarded
			END
			CLOSE C2
			DEALLOCATE C2
GO

--Вес бойцов должен соответствовать весовой категории поединка
CREATE TRIGGER T_ВесБойцов ON Поединок
	AFTER INSERT, UPDATE
		AS
			DECLARE @weight1 float = (SELECT [Вес (кг)] FROM Боец
				WHERE Код = (SELECT [Боец 1] FROM inserted))
			DECLARE @weight2 float = (SELECT [Вес (кг)] FROM Боец
				WHERE Код = (SELECT [Боец 2] FROM inserted))
			DECLARE @vk varchar(20) = 
				(SELECT [Весовая категория] FROM Поединок
				WHERE Номер = (SELECT Номер FROM inserted))
			DECLARE @up float = 
				(SELECT [Верхняя граница (кг)] FROM ВесоваяКатегория
				WHERE [Весовая категория] = @vk)
			DECLARE @down float = 
				(SELECT [Нижняя граница (кг)] FROM ВесоваяКатегория
				WHERE [Весовая категория] = @vk)
			IF @weight1 > @up OR @weight1 < @down OR
				@weight2 > @up OR @weight2 < @down
				ROLLBACK TRAN
GO

--КУРСОР
/*Дата подписания контракта должна быть меньше
даты окончания хотя бы на месяц*/
CREATE TRIGGER T_Контракт ON Контракт
	INSTEAD OF INSERT, UPDATE
		AS
			DECLARE @num varchar(20), @fighter int, @amount int, @money money,
			@month1 money, @month2 money, @sign date, @end date
			DECLARE C1 CURSOR FOR
				SELECT * FROM inserted
			OPEN C1
			FETCH NEXT FROM C1 INTO @num, @fighter, @amount, @money,
			@month1, @month2, @sign, @end
			WHILE @@FETCH_STATUS = 0
			BEGIN
			IF @sign <= DATEADD(MONTH, -1, @end)
				INSERT INTO Контракт VALUES (@num, @fighter, @amount, @money,
				@month1, @month2, @sign, @end)
			FETCH NEXT FROM C1 INTO @num, @fighter, @amount, @money,
				@month1, @month2, @sign, @end
			END
			CLOSE C1
			DEALLOCATE C1
GO

--КУРСОР
--Поединок судят не более 3 судей
CREATE TRIGGER T_Судейство ON Судейство
	INSTEAD OF INSERT, UPDATE
		AS
			DECLARE @fight int, @judge int, @money money,
				@jnum tinyint
			DECLARE C4 CURSOR FOR
				SELECT * FROM inserted
			OPEN C4
			FETCH NEXT FROM C4 INTO @fight, @judge, @money
			WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @jnum = (SELECT COUNT(*) FROM Судейство
								WHERE Поединок = @fight)
				IF @jnum < 3 INSERT INTO Судейство VALUES
					(@fight, @judge, @money)
				FETCH NEXT FROM C4 INTO @fight, @judge, @money
			END
			CLOSE C4
			DEALLOCATE C4
GO

--Если поединок дошел до решения, время и раунд в таблице должны быть максимальными
CREATE TRIGGER T_Результаты ON РезультатыПоединков
	AFTER INSERT, UPDATE
		AS
			DECLARE @res varchar(50) = (SELECT Результат FROM inserted),
			@time time = (SELECT Время FROM inserted),
			@round tinyint = (SELECT Раунд FROM inserted)
			IF (LOWER(@res) LIKE '%решение%' OR LOWER(@res) LIKE '%ничья%')
				AND LOWER(@res) NOT LIKE '%технич%'
				AND (@round NOT IN (3, 5)
				OR @time NOT LIKE '%5:00%')
				ROLLBACK TRAN
GO

--Нечемпионский поединок не может зайти дальше третьего раунда
CREATE TRIGGER T_Чемпионство ON РезультатыПоединков
	AFTER INSERT, UPDATE
		AS
			DECLARE @status char (1) = (SELECT [Статус поединка] FROM Поединок
				WHERE Номер = (SELECT Поединок FROM inserted)),
				@round tinyint = (SELECT Раунд FROM inserted)
			IF @status = 'Н' AND @round > 3
				ROLLBACK TRAN
GO

--При ничьей или "без результата" поединок не должен иметь победителя
CREATE TRIGGER T_Победитель ON РезультатыПоединков
	AFTER INSERT, UPDATE
		AS
			DECLARE @res varchar(50) = (SELECT Результат FROM inserted),
				@winner bit = (SELECT Победитель FROM inserted)
			IF (@res LIKE '%ничья%' OR @res = 'Без результата') BEGIN
				IF @winner IS NOT NULL
					ROLLBACK TRAN
				END
			ELSE IF @winner IS NULL
				ROLLBACK TRAN
GO

--Поединок не может иметь результат, если он еще не состоялся
CREATE TRIGGER T_ВремяРезультата ON РезультатыПоединков
	AFTER INSERT, UPDATE
		AS
			DECLARE @date date = (SELECT Дата FROM Турнир
				WHERE Название = (SELECT Турнир FROM Поединок
				WHERE Номер = (SELECT Поединок FROM inserted)))
			IF @date > GETDATE()
				ROLLBACK TRAN
GO

--Общая выручка не меньше суммы проданных билетов
CREATE TRIGGER T_ОбщаяВыручка ON Турнир
	AFTER UPDATE
		AS
			DECLARE @prof money = (SELECT [Общая выручка (руб)] FROM inserted)
			IF @prof IS NOT NULL BEGIN
				DECLARE @sum money = (SELECT SUM([Стоимость (руб)]*[Продано билетов]) 
					FROM ПродажаБилетов WHERE Турнир = 
						(SELECT Название FROM inserted))
				IF @sum IS NOT NULL
					IF @prof < @sum ROLLBACK TRAN
			END
GO

/*Суммарная посещаемость не меньше количества проданных билетов
и не больше вместимости арены*/
CREATE TRIGGER T_Посещаемость ON Турнир
	AFTER INSERT, UPDATE
		AS
			DECLARE @attend int = (SELECT [Суммарная посещаемость (чел)] FROM inserted)
			IF @attend IS NOT NULL BEGIN
				DECLARE @sum int = (SELECT SUM([Продано билетов]) 
					FROM ПродажаБилетов WHERE Турнир = 
						(SELECT Название FROM inserted))
				DECLARE @vmest int = (SELECT [Вместимость (чел)] FROM Арена
					WHERE Название = (SELECT [Место проведения] FROM inserted))
				IF @attend > @vmest 
					ROLLBACK TRAN
				ELSE IF @sum IS NOT NULL
					IF @attend < @sum
						ROLLBACK TRAN
				END
GO

--Если турнир еще не состоялся, не может существовать информации о его посещаемости
CREATE TRIGGER T_ВремяТурнира ON Турнир
	AFTER INSERT, UPDATE
		AS
			IF (SELECT Дата FROM inserted) > GETDATE()
				AND (SELECT [Суммарная посещаемость (чел)] FROM inserted)
					IS NOT NULL
				ROLLBACK TRAN
GO

--Количество выставленных билетов должно укладываться во вместимость
CREATE TRIGGER T_Билеты ON ПродажаБилетов
	AFTER INSERT, UPDATE
		AS
			DECLARE @sale int = (SELECT SUM([Выставлено билетов]) FROM ПродажаБилетов
				WHERE Турнир = (SELECT Турнир FROM inserted))
			IF @sale IS NULL SET @sale = 0
			SET @sale += (SELECT [Выставлено билетов] FROM inserted)
			DECLARE @vmest int = (SELECT [Вместимость (чел)] FROM Арена
				WHERE Название = (SELECT [Место проведения] FROM Турнир
				WHERE Название = (SELECT Турнир FROM inserted)))
			IF @sale > @vmest
				ROLLBACK TRAN
GO

--Каскадное удаление из таблицы "Боец"
CREATE TRIGGER T_УдалениеБойца ON Боец
	INSTEAD OF DELETE
		AS
			DELETE FROM Поединок
			WHERE [Боец 1] = (SELECT Код FROM deleted)
				OR [Боец 2] = (SELECT Код FROM deleted)
			DELETE FROM Боец
				WHERE Код = (SELECT Код FROM deleted)
GO


/*ЗАПОЛНЕНИЕ ТАБЛИЦ*/


INSERT INTO Арена VALUES
('ЦСКА Арена', 'Россия, Москва, ул. Автозаводская, д. 23А', 16000, 2015, 'Группа "Интер РАО"'),
('СК "Юбилейный"', 'Россия, Санкт-Петербург, просп. Добролюбова, 18', 6381, 1967, 'Правительство Санкт-Петербурга'),
('СК "Олимпийский"', 'Россия, Москва, просп. Олимпийский, 16, стр. 1', 35000, 1980, '"Киевская площадь"'),
('ГЦКЗ "Россия"', 'Россия, Москва, Лужнецкая наб., 24, стр. 1', '7000', 1971, 'Правительство Москвы'),
('ДС "Олимпийский"', 'Россия, Рязань, ул. Зубковой', 2700, 2005, 'Министерство физической культуры и спорта Рязанской области'),
('Ти-Мобайл Арена', 'США, Невада, Парадайс', 20000, 2016, 'Anschutz Entertainment Group, MGM Resorts International, Бил Фоули'),
('Мэдисон-сквер-гарден', 'США, Нью-Йорк, Нью-Йорк', 20789, 1968, 'The Madison Square Garden Company'),
('Хонда-центр', 'США, Калифорния, Анахайм', 18900, 1993, 'Правительство Анахайма'),
('Болл-арена', 'США, Колорадо, Денвер', 21000, 1999, 'Стэн Кронке'),
('Тойота-центр', 'США, Техас, Хьюстон', 19000, NULL, 'Округ Харрис, Houston Sports Authority')
GO

INSERT INTO Турнир VALUES
('RFC 228', 'ДС "Олимпийский"', '11.01.2023', 1000, 600000, 200000)
GO
INSERT INTO Турнир VALUES
('RFC 229', 'СК "Олимпийский"', '11.02.2023', 4000, 180000000, 6000000)
GO
INSERT INTO Турнир VALUES
('RFC 230', 'СК "Юбилейный"', '11.03.2023', 4200, 188000000, 6000000)
GO
INSERT INTO Турнир VALUES
('RFC 231', 'Мэдисон-сквер-гарден', '11.04.2023', 3000, 181500000, 7000000)
GO
INSERT INTO Турнир VALUES
('RFC 232', 'ДС "Олимпийский"', '11.05.2023', 1000, 620000, 200000)
GO
INSERT INTO Турнир VALUES
('RFC 233: Емельяненко vs Леснар', 'СК "Олимпийский"', '11.06.2023', 6000, 222000000, 6000000)
GO
INSERT INTO Турнир VALUES
('RFC 234', 'Тойота-центр', '11.07.2023', NULL, NULL, NULL)
GO
INSERT INTO Турнир VALUES
('RFC 235', 'Хонда-центр', '11.08.2023', NULL, NULL, NULL)
GO
INSERT INTO Турнир VALUES
('RFC 236', 'Хонда-центр', '11.09.2023', NULL, NULL, NULL)
GO
INSERT INTO Турнир VALUES
('RFC 237', 'Тойота-центр', '11.10.2023', NULL, NULL, NULL)
GO

INSERT INTO Билет VALUES
('A', 'VVIP'),
('B', 'VVIP'),
('C', 'VIP'),
('D', 'VIP'),
('106', 'Diamond'),
('111', 'Platinum'),
('112', 'Platinum'),
('113', 'Platinum'),
('110', 'Gold'),
('109', 'Gold'),
('200', 'Silver'),
('315', 'Bronze'),
('314', 'Bronze'),
('313', 'Bronze'),
('312', 'Bronze'),
('A-1', 'VIP'),
('A-2', 'Стандарт'),
('A-3', NULL),
('B-1', 'Эконом'),
('B-2', 'Эконом')
GO

INSERT INTO ПродажаБилетов VALUES
('RFC 229', 'A', 15000, 200, 100)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 229', 'C', 13000, 200, 150)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 229', '111', 10000, 400, 300)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 229', '200', 7000, 500, 500)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 230', 'A', 30000, 200, 150)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 230', 'C', 25000, 300, 299)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 230', '109', 15000, 1000, 1000)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 230', '312', 10000, 1000, 1000)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 231', 'A', 55000, 300, 290)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 231', 'C', 55000, 300, 280)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 232', '111', 1000, 500, 500)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 232', '200', 700, 1000, 1000)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 233: Емельяненко vs Леснар', 'A', 75000, 500, 400)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 233: Емельяненко vs Леснар', 'C', 65000, 600, 450)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 233: Емельяненко vs Леснар', '111', 25000, 2000, 2000)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 234', '200', 15000, 3000, NULL)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 234', 'A', 65000, 500, NULL)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 234', 'C', 55000, 600, NULL)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 234', '111', 25000, 1000, NULL)
GO
INSERT INTO ПродажаБилетов VALUES
('RFC 234', '313', 10000, 1500, NULL)
GO

INSERT INTO Стаж VALUES
(0, 1),
(1, 1.01),
(2, 1.02),
(3, 1.05),
(4, 1.1),
(5, 1.5),
(6, 1.7),
(7, 1.9),
(8, 2.2),
(9, 2.3),
(10, 2.5),
(11, 2.6),
(12, 2.7),
(13, 2.8),
(14, 2.9),
(15, 3),
(16, 3.1),
(17, 3.2),
(18, 3.3),
(19, 3.4),
(20, 3.5),
(21, 3.5),
(22, 3.5),
(23, 3.5),
(24, 3.5),
(25, 3.5),
(26, 3.5),
(27, 3.5),
(28, 3.5),
(29, 3.5),
(30, 3.5),
(31, 3.5),
(32, 3.5),
(33, 3.5),
(34, 3.5),
(35, 3.5),
(36, 3.5),
(37, 3.5),
(38, 3.5),
(39, 3.5),
(40, 3.5)
GO

INSERT INTO Боец VALUES
(10, 'Емельяненко Федор Владимирович', '28.09.1976', DEFAULT, 107.5, 182.88, 189, DEFAULT, '6116 567567', '89109032812', 'fedor@gmail.com', 'Россия, Москва, ул. Пушкина, д.10, кв.1')
GO
INSERT INTO Боец VALUES
(9, 'Емельяненко Александр Владимирович', '02.08.1981', DEFAULT, 114.76, 193.04, 202, DEFAULT, '6116 567568', '89109032813', 'alex@gmail.com', 'Россия, Москва, ул. Пушкина, д.12, кв.1')
GO
INSERT INTO Боец VALUES
(10, 'Харитонов Сергей Валерьевич', '18.08.1980', DEFAULT, 117.03, 193.04, 193, DEFAULT, '6116 567569', '89109032824', 'skh111@yandex.ru', 'Россия, Москва, ул. Некрасова, д.254, кв.4')
GO
INSERT INTO Боец VALUES
(5, 'Ян Петр Евгеньевич', '11.02.1993', DEFAULT, 61.23, 170.18, 170, DEFAULT, '6116 567237', '89109032854', 'aaaa@gmail.com', 'Россия, Омск, ул. Некрасова, д.65, кв. 17')
GO
INSERT INTO Боец VALUES
(2, 'Брок Эдвард Леснар', '12.07.1977', 'США', 119.75, 190.5, 206, 'США', 'USA82568876D3', '+19168258765', 'b323@bk.com', 'США, Южная Дакота, Уэбстер, Индепенденс ст., 45')
GO
INSERT INTO Боец VALUES
(7, 'Марк Хант', '23.03.1974', 'Новая Зеландия', 118.84, 177.8, 182.9, 'Новая Зеландия', '626545ABJ946', '+64 (987) 555-666', 'mark123@gmail.com', 'Австралия, Сидней, Нью ст., 87')
GO
INSERT INTO Боец VALUES
(13, 'Вандерлей Сезар да Силва', '3.7.1976', 'Бразилия', 83.91, 177.8, 188, 'Бразилия', 'B348WA812D65', '+55 (954) 22-234-432', 'wan@bk.com', 'США, Невада, Лас Вегас, Зис ст., 76')
GO
INSERT INTO Боец VALUES
(6, 'Мирко Филипович', '10.09.1974', 'Хорватия', 102.93, 187.96, 185, 'Хорватия', '4566547823', '+385 23 543432', 'crocop@gmail.com', 'Хорватия, Загреб, ул. Магазинска, 777')
GO
INSERT INTO Боец VALUES
(0, 'Мухаммад Мурадович Мокаев', '30.07.2000', 'Великобритания', 56.7, 175.26, 178, DEFAULT, '6116 577567', '89109032893', 'mokaev@yandex.ru', 'Великобритания, Манчестер, Честер ст., 9')
GO
INSERT INTO Боец VALUES
(4, 'Джонатан Дуайт Джонс', '19.07.1987', 'США', 112.49, 193.04, 215, 'США', 'USA82599976D3', '+19163338765', 'bones@gmail.com', 'США, Нью-Мексико, Альбукерке, Канделария Роуд СВ, 111')
GO
INSERT INTO Боец VALUES
(1, 'Сергей Владимирович Павлович', '13.05.1992', DEFAULT, 118.39, 190.5, 213, DEFAULT, '6116 589767', '89109066811', 'spmma@yandex.ru', 'Россия, Москва, ул. Лермонтова, д.3, кв.87')
GO
INSERT INTO Боец VALUES
(3, 'Хамзат Хизарович Чимаев', '01.05.1994', 'Швеция', 81.19, 187.96, 190, DEFAULT, '6116 512567', '+79109652871', 'borz95@gmail.com', 'Svetsarvagen 24, 171 41 Solna, Швеция')
GO
INSERT INTO Боец VALUES
(3, 'Шавкат Бахтибаевич Рахмонов', '23.10.1994', 'Казахстан', 77.11, 185.42, 196, 'Казахстан', '62956295', '+76109032812', 'nomad@gmail.com', 'Казахстан, Кокшетау, ул. Горького, 45')
GO
INSERT INTO Боец VALUES
(12, 'Антонио Родриго Ногейра', '02.06.1976', 'Бразилия', 107.5, 190.5, 198, 'Бразилия', 'B348NO812A66', '+55(954)33-274-433', 'minotauro@bk.com', 'Бразилия, Рио-де-Жанейро, ул. Сан Хосе, 13')
GO
INSERT INTO Боец VALUES
(5, 'Кейн Рамирес Веласкес', '28.07.1982', 'США', 109.32, 185.42, 196, 'США', 'USA82577776D3', '+1(916)8258777', 'vel@gmail.com', 'США, Калифорния, Сан-Хосе, Каррибен Драйв, 13')
GO
INSERT INTO Боец VALUES
(3, 'Эммануэль Ярборо', '05.09.1984', 'США', 272.16, 203.2, 203.2, 'США', 'USA92578876D3', '+1(916)8256547', 'manny@gmail.com', 'США, Вирджиния, Ричмонд, Тредгар ст., 18')
GO
INSERT INTO Боец VALUES
(5, 'Пауло Сезар да Силва', '21.07.1983', 'Бразилия', 174.63, 218.44, 218.44, 'Бразилия', 'B358SI862P66', '+55(954)36-264-633', 'giant@bk.com', 'Бразилия, Сан-Паулу, ул. до Лукас, 23')
GO
INSERT INTO Боец VALUES
(8, 'Вагнер да Консейсан Мартинс', '19.05.1978', 'Бразилия', 176.9, 200.66, 200.66, 'Бразилия', 'B358ZU662L55', '+55(954)36-265-634', 'zulu@bk.com', 'Бразилия, Сан-Луис, ул. до Ранчо, 43')
GO
INSERT INTO Боец VALUES
(0, 'Рауль Росас мл', '08.10.2004', 'США', 61.23, 175.26, 170, 'США', 'USA82588886D3', '+1(916)8252347', 'champ@gmail.com', 'США, Калифорния, Санта-Роза, Клют-ст., 89')
GO
INSERT INTO Боец VALUES
(11, 'Чарльз Оливейра да Силва', '17.10.1989', 'Бразилия', 70.31, 177.8, 188, 'Бразилия', 'B358CH662O77', '+55(954)89-623-633', 'oliv@gmail.com', 'Бразилия, Гуаружа, ул. Монтенегро, 723')
GO

INSERT INTO Контракт VALUES
('11111-11111', 1, 3, 500000, 100000, 100000, '11.01.2023', '11.01.2025')
GO
INSERT INTO Контракт VALUES
('11111-11112', 2, 1, 400000, 100000, 100000, '10.01.2023', '10.01.2024')
GO
INSERT INTO Контракт VALUES
('11111-11113', 3, 5, 300000, 100000, 100000, '11.01.2023', '11.01.2025')
GO
INSERT INTO Контракт VALUES
('11111-11114', 4, 5, 500000, 100000, 90000, '11.01.2023', '11.01.2025')
GO
INSERT INTO Контракт VALUES
('11111-11115', 5, 1, 700000, 100000, 100000, '9.01.2023', '9.01.2024')
GO
INSERT INTO Контракт VALUES
('11111-11116', 6, 2, 500000, 100000, 100000, '5.01.2023', '5.01.2024')
GO
INSERT INTO Контракт VALUES
('11111-11117', 7, 5, 500000, 100000, 100000, '5.01.2023', '5.01.2024')
GO
INSERT INTO Контракт VALUES
('11111-11118', 8, 2, 520000, 100000, 120000, '2.01.2023', '2.01.2025')
GO
INSERT INTO Контракт VALUES
('11111-11119', 9, 7, 400000, 100000, 70000, '24.01.2023', '24.01.2026')
GO
INSERT INTO Контракт VALUES
('11111-11121', 10, 5, 1000000, 150000, 150000, '11.01.2023', '11.01.2026')
GO
INSERT INTO Контракт VALUES
('11111-11131', 11, 5, 500000, 100000, 100000, '10.01.2023', '10.01.2025')
GO
INSERT INTO Контракт VALUES
('11111-11141', 12, 5, 700000, 100000, 100000, '11.01.2023', '11.01.2025')
GO
INSERT INTO Контракт VALUES
('11111-11151', 13, 5, 600000, 100000, 100000, '7.01.2023', '7.01.2024')
GO
INSERT INTO Контракт VALUES
('11111-11161', 14, 1, 700000, 100000, 100000, '2.01.2023', '2.01.2024')
GO
INSERT INTO Контракт VALUES
('11111-11171', 15, 1, 700000, 100000, 100000, '11.01.2023', '11.01.2024')
GO
INSERT INTO Контракт VALUES
('11111-11181', 16, 1, 500000, 100000, 100000, '11.01.2023', '11.01.2024')
GO
INSERT INTO Контракт VALUES
('11111-11191', 17, 1, 500000, 100000, 100000, '11.01.2023', '11.01.2024')
GO
INSERT INTO Контракт VALUES
('11111-11122', 18, 1, 500000, 100000, 100000, '11.01.2023', '11.01.2024')
GO
INSERT INTO Контракт VALUES
('11111-11123', 19, 5, 500000, 100000, 100000, '11.01.2023', '11.01.2024')
GO
INSERT INTO Контракт VALUES
('11111-11124', 1, 3, 700000, 100000, 100000, '9.01.2022', '9.01.2023')
GO

INSERT INTO ВесоваяКатегория VALUES
('Супертяжелый вес', 120, 300, 'Super heavyweight'),
('Тяжелый вес', 93, 119.99, 'Heavyweight'),
('Полутяжелый вес', 84, 92.99, 'Light heavyweight'),
('Средний вес', 77, 83.99, 'Middleweight'),
('Полусредний вес', 70, 76.99, 'Welterweight'),
('Легкий вес', 66, 69.99, 'Lightweight'),
('Полулегкий вес', 61, 65.99, 'Featherweight'),
('Легчайший вес', 57, 60.99, 'Bantamweight'),
('Наилегчайший вес', 50, 56.99, 'Flyweight')
GO

INSERT INTO Поединок VALUES
(1, 5, 'RFC 233: Емельяненко vs Леснар', 'Тяжелый вес', 'Ч', 12)
GO
INSERT INTO Поединок VALUES
(1, 15, 'RFC 231', 'Тяжелый вес', 'Н', 13)
GO
INSERT INTO Поединок VALUES
(1, 10, 'RFC 236', 'Тяжелый вес', 'Ч', 12)
GO
INSERT INTO Поединок VALUES
(4, 19, 'RFC 231', 'Полулегкий вес', 'Ч', 12)
GO
INSERT INTO Поединок VALUES
(10, 11, 'RFC 229', 'Тяжелый вес', 'Н', 10)
GO
INSERT INTO Поединок VALUES
(12, 13, 'RFC 229', 'Средний вес', 'Н', 11)
GO
INSERT INTO Поединок VALUES
(1, 8, 'RFC 229', 'Тяжелый вес', 'Ч', 12)
GO
INSERT INTO Поединок VALUES
(7, 12, 'RFC 231', 'Средний вес', 'Н', 14)
GO
INSERT INTO Поединок VALUES
(16, 18, 'RFC 236', 'Супертяжелый вес', 'Ч', 11)
GO
INSERT INTO Поединок VALUES
(17, 18, 'RFC 233: Емельяненко vs Леснар', 'Супертяжелый вес', 'Н', 11)
GO
INSERT INTO Поединок VALUES
(3, 6, 'RFC 233: Емельяненко vs Леснар', 'Тяжелый вес', 'Н', 10)
GO
INSERT INTO Поединок VALUES
(3, 2, 'RFC 232', 'Тяжелый вес', 'Н', 15)
GO
INSERT INTO Поединок VALUES
(16, 17, 'RFC 232', 'Супертяжелый вес', 'Н', 13)
GO
INSERT INTO Поединок VALUES
(14, 8, 'RFC 232', 'Тяжелый вес', 'Н', 14)
GO
INSERT INTO Поединок VALUES
(7, 13, 'RFC 228', 'Средний вес', 'Ч', 12)
GO
INSERT INTO Поединок VALUES
(5, 15, 'RFC 228', 'Тяжелый вес', 'Н', 10)
GO
INSERT INTO Поединок VALUES
(4, 19, 'RFC 228', 'Полулегкий вес', 'Ч', 11)
GO
INSERT INTO Поединок VALUES
(17, 16, 'RFC 237', 'Супертяжелый вес', 'Н', 10)
GO
INSERT INTO Поединок VALUES
(3, 11, 'RFC 237', 'Тяжелый вес', 'Н', 11)
GO
INSERT INTO Поединок VALUES
(10, 2, 'RFC 237', 'Тяжелый вес', 'Н', 12)
GO

INSERT INTO Рефери VALUES
('Иванов Иван Иванович', '1.01.1970', DEFAULT, '6114 228221', '+79109032801', 'ref1@yandex.ru', 'Россия, Москва, ул. Пушкина, д. 221, кв. 1', '1.01.2018')
GO
INSERT INTO Рефери VALUES
('Сидоров Иван Иванович', '2.01.1970', DEFAULT, '6114 228222', '+79109032802', 'ref2@yandex.ru', 'Россия, Москва, ул. Пушкина, д. 222, кв. 1', '2.01.2018')
GO
INSERT INTO Рефери VALUES
('Петров Иван Иванович', '3.01.1970', DEFAULT, '6114 228223', '+79109032803', 'ref3@yandex.ru', 'Россия, Москва, ул. Пушкина, д. 223, кв. 1', '3.01.2018')
GO
INSERT INTO Рефери VALUES
('Иванов Петр Иванович', '4.01.1970', DEFAULT, '6114 228224', '+79109032804', 'ref4@yandex.ru', 'Россия, Москва, ул. Пушкина, д. 224, кв. 1', '4.01.2018')
GO
INSERT INTO Рефери VALUES
('Сидоров Петр Иванович', '5.01.1970', DEFAULT, '6114 228225', '+79109032805', 'ref5@yandex.ru', 'Россия, Москва, ул. Пушкина, д. 225, кв. 1', '5.01.2018')
GO
INSERT INTO Рефери VALUES
('Петров Петр Иванович', '6.01.1970', DEFAULT, '6114 228226', '+79109032806', 'ref6@yandex.ru', 'Россия, Москва, ул. Пушкина, д. 226, кв. 1', '4.01.2018')
GO
INSERT INTO Рефери VALUES
('Иванов Сидор Иванович', '7.01.1970', DEFAULT, '6114 228227', '+79109032807', 'ref7@yandex.ru', 'Россия, Москва, ул. Пушкина, д. 227, кв. 1', '3.01.2018')
GO
INSERT INTO Рефери VALUES
('Сидоров Сидор Иванович', '8.01.1970', DEFAULT, '6114 228228', '+79109032808', 'ref8@yandex.ru', 'Россия, Москва, ул. Пушкина, д. 228, кв. 1', '2.01.2018')
GO
INSERT INTO Рефери VALUES
('Петров Сидор Иванович', '8.01.1970', DEFAULT, '6114 228229', '+79109032809', 'ref9@yandex.ru', 'Россия, Москва, ул. Пушкина, д. 229, кв. 1', '1.01.2018')
GO
INSERT INTO Рефери VALUES
('Херб Дин', '30.09.1970', 'США', 'USA82551206D3', '+1(916)7563290', 'herb@gmail.com', 'США, Калифорния, Пасадина, Уолнат ст., 54', '19.09.2021')
GO

INSERT INTO ПроведениеПоединков VALUES
(1, 10, 2000000),
(3, 10, 2000000),
(2, 1, 50000),
(4, 5, 100000),
(5, 6, 80000),
(6, 4, 200000),
(7, 10, 1800000),
(8, 3, 100000),
(9, 8, 70000),
(10, 2, 70000),
(11, 1, 100000),
(12, 2, 100000),
(13, 7, 70000),
(14, 7, 100000),
(15, 5, 120000),
(16, 3, 80000),
(17, 4, 100000),
(18, 6, 70000),
(19, 7, 100000)
GO

INSERT INTO Результат VALUES
('Нокаут', 'Боец не может продолжать поединок вследствие полученного разрешенного удара'),
('Технический нокаут', 'Рефери останавливает поединок вследствие невозможности одного из бойцов продолжать бой'),
('Технический нокаут (остановка врачом)', 'Врач заключает, что дальнейшее продолжение поединка опасно для жизни или здоровья одного из бойцов'),
('Технический нокаут (остановка углом)', 'Угловой секундант бойца сигнализирует об остановке боя'),
('Сдача', 'Добровольный отказ бойца продолжать поединок'),
('Техническая сдача', 'Рефери останавливает поединок вследствие проведения болевого или удушающего приема'),
('Сдача (удушение сзади)', 'Удушающий прием сзади'),
('Сдача (гильотина)', 'Удушающий прием "гильотина"'),
('Сдача (треугольник)', 'Удушающий прием "треугольник"'),
('Сдача (ручной треугольник)', 'Удушающий прием "ручной треугольник"'),
('Сдача (кимура)', 'Болевой прием "кимура"'),
('Сдача (рычаг локтя)', 'Болевой прием "рычаг локтя"'),
('Сдача (рычаг локтя в треугольнике)', 'Удушающе-болевой прием "рычаг локтя в треугольнике"'),
('Сдача (американа)', 'Болевой прием "американа"'),
('Сдача (анаконда)', 'Удушающий прием "анаконда"'),
('Сдача (север-юг)', 'Удушающий прием "север-юг"'),
('Сдача (залом шеи)', 'Болевой прием "залом шеи"'),
('Сдача (ущемление диафрагмы)', 'Удушающе-болевой прием "ущемление диафрагмы"'),
('Сдача (удушение брабо)', 'Удушающий прием "брабо"'),
('Сдача (удушение Иезекииля)', 'Удушающий прием "Иезекииль"'),
('Сдача (рычаг колена)', 'Болевой прием "рычаг колена"'),
('Сдача (скручивание пятки)', 'Болевой прием "скручивание пятки"'),
('Единогласное решение', 'Все три судьи отдают предпочтение бойцу А'),
('Раздельное решение', 'Двое судей присуждают победу бойцу А, один судья присуждает победу бойцу Б'),
('Решение большинства', 'Двое судей присуждают победу бойцу А, один судья присуждает ничью'),
('Единогласная ничья', 'Трое судей присуждают ничью'),
('Раздельная ничья', 'Один судья присуждает победу бойцу А, один судья присуждает победу бойцу Б, один судья присуждает ничью'),
('Ничья решением большинства', 'Двое судей присуждают ничью, один — победу'),
('Техническое решение', 'Судьи выносят решение при условии, что оба бойца не могут продолжать бой'),
('Техническая ничья', 'Судьи присуждают ничью при условии, что оба бойца не могут продолжать бой'),
('Дисквалификация', 'Победа присуждается бойцу А ввиду нарушения правил бойцом Б'),
('Без результата', 'Результат поединка отменяется ввиду непредвиденных обстоятельств')
GO

INSERT INTO РезультатыПоединков VALUES
(1, 'Технический нокаут', 0, 4, '00:04:37')
GO
INSERT INTO РезультатыПоединков VALUES
(2, 'Технический нокаут', 0, 3, '00:02:21')
GO
INSERT INTO РезультатыПоединков VALUES
(4, 'Дисквалификация', 1, 1, '00:01:28')
GO
INSERT INTO РезультатыПоединков VALUES
(5, 'Раздельное решение', 1, DEFAULT, DEFAULT)
GO
INSERT INTO РезультатыПоединков VALUES
(6, 'Сдача (удушение брабо)', 1, 2, '00:03:59')
GO
INSERT INTO РезультатыПоединков VALUES
(7, 'Единогласное решение', 0, 5, DEFAULT)
GO
INSERT INTO РезультатыПоединков VALUES
(8, 'Раздельная ничья', NULL, DEFAULT, DEFAULT)
GO
INSERT INTO РезультатыПоединков VALUES
(10, 'Сдача (кимура)', 0, 1, '00:02:29')
GO
INSERT INTO РезультатыПоединков VALUES
(11, 'Решение большинства', 1, DEFAULT, DEFAULT)
GO
INSERT INTO РезультатыПоединков VALUES
(12, 'Нокаут', 0, 1, '00:00:14')
GO
INSERT INTO РезультатыПоединков VALUES
(13, 'Сдача', 0, 2, '00:04:49')
GO
INSERT INTO РезультатыПоединков VALUES
(14, 'Сдача (анаконда)', 0, 3, '00:02:13')
GO
INSERT INTO РезультатыПоединков VALUES
(15, 'Технический нокаут', 0, 3, '00:03:48')
GO
INSERT INTO РезультатыПоединков VALUES
(16, 'Технический нокаут', 1, 2, '00:01:21')
GO

INSERT INTO Награда VALUES
('Лучший бой вечера', 300000, 'Награда присуждается обоим участникам поединка, признанного лучшим боем турнира'),
('Выступление вечера', 200000, 'Награда присуждается бойцу за особенно зрелищную победу в поединке')
GO

INSERT INTO Награждение VALUES
(6, 'Лучший бой вечера', NULL),
(1, 'Лучший бой вечера', NULL),
(8, 'Лучший бой вечера', NULL),
(14, 'Лучший бой вечера', NULL),
(15, 'Лучший бой вечера', NULL),
(10, 'Выступление вечера', 0),
(2, 'Выступление вечера', 0),
(5, 'Выступление вечера', 1),
(7, 'Выступление вечера', 0),
(16, 'Выступление вечера', 1)
GO

INSERT INTO Судья VALUES
('Смирнов Иван Петрович', '01.01.1980', DEFAULT, '6113 567900', '+7(910)9023401', 'male01@gmail.com', 'Россия, Москва, ул. Некрасова, д. 11, кв. 99', '09.07.2022')
GO
INSERT INTO Судья VALUES
('Смирнов Петр Иванович', '01.01.1981', DEFAULT, '6113 567911', '+7(910)9023402', 'male02@gmail.com', 'Россия, Москва, ул. Некрасова, д. 12, кв. 99', '09.07.2022')
GO
INSERT INTO Судья VALUES
('Смирнов Алексей Александрович', '01.01.1982', DEFAULT, '6113 567922', '+7(910)9023403', 'male03@gmail.com', 'Россия, Москва, ул. Некрасова, д. 13, кв. 99', '09.07.2022')
GO
INSERT INTO Судья VALUES
('Смирнов Александр Алексеевич', '01.01.1983', DEFAULT, '6113 567933', '+7(910)9023404', 'male04@gmail.com', 'Россия, Москва, ул. Некрасова, д. 14, кв. 99', '09.07.2022')
GO
INSERT INTO Судья VALUES
('Алексеев Александр Алексеевич', '01.01.1984', DEFAULT, '6113 567944', '+7(910)9023405', 'male05@gmail.com', 'Россия, Москва, ул. Некрасова, д. 15, кв. 99', '09.07.2022')
GO
INSERT INTO Судья VALUES
('Алексеев Алексей Александрович', '01.01.1985', DEFAULT, '6113 567955', '+7(910)9023406', 'male06@gmail.com', 'Россия, Москва, ул. Некрасова, д. 16, кв. 99', '09.07.2022')
GO
INSERT INTO Судья VALUES
('Александров Иван Петрович', '01.01.1986', DEFAULT, '6113 567966', '+7(910)9023407', 'male07@gmail.com', 'Россия, Москва, ул. Некрасова, д. 17, кв. 99', '09.07.2022')
GO
INSERT INTO Судья VALUES
('Александров Петр Иванович', '01.01.1987', DEFAULT, '6113 567977', '+7(910)9023408', 'male08@gmail.com', 'Россия, Москва, ул. Некрасова, д. 18, кв. 99', '09.07.2022')
GO
INSERT INTO Судья VALUES
('Неронский Соломон Израилевич', '01.01.1988', DEFAULT, '6113 567988', '+7(910)9023409', 'male09@gmail.com', 'Россия, Москва, ул. Некрасова, д. 19, кв. 99', '09.07.2022')
GO
INSERT INTO Судья VALUES
('Майкл Бэлл', '1.01.1979', 'США', 'USA82555246D3', '+1(916)4351245', 'bellmma@gmail.com', 'США, Калифорния, Сакраменто, 40-я ст., 41', '22.02.2022')
GO

INSERT INTO Судейство VALUES
(1, 5, 80000),
(1, 6, 80000),
(1, 7, 80000),
(2, 1, 70000),
(2, 10, 70000),
(5, 5, 90000),
(5, 3, 90000),
(5, 8, 90000),
(6, 7, 80000),
(6, 2, 80000),
(6, 9, 80000),
(11, 8, 70000),
(15, 5, 70000),
(15, 9, 70000),
(15, 1, 70000),
(17, 4, 80000),
(17, 7, 80000),
(17, 3, 80000),
(10, 3, 90000),
(10, 7, 90000)
GO


/*ПРЕДСТАВЛЕНИЯ*/


--Текущие чемпионы организации
CREATE VIEW V_Champs
AS
	WITH КрайняяДата AS (
		SELECT [Весовая категория], MAX(Дата) AS Дата
			FROM Поединок JOIN Турнир ON Поединок.Турнир = Турнир.Название
				LEFT JOIN РезультатыПоединков ON Поединок.Номер = РезультатыПоединков.Поединок
			WHERE Дата <= GETDATE() AND [Статус поединка] = 'Ч'
				AND Победитель IS NOT NULL
			GROUP BY [Весовая категория])
	SELECT A.[Код чемпиона], Боец.ФИО AS Чемпион,
		A.[Весовая категория], A.[Дата завоевания/последней защиты] FROM
	(SELECT (CASE WHEN (SELECT Победитель FROM РезультатыПоединков
		WHERE Поединок = Номер) = 0 THEN [Боец 1] 
			WHEN (SELECT Победитель FROM РезультатыПоединков
			WHERE Поединок = Номер) = 1 THEN [Боец 2] ELSE NULL END) AS [Код чемпиона],
		[Весовая категория], Дата AS [Дата завоевания/последней защиты] 
		FROM Поединок JOIN Турнир ON Поединок.Турнир = Турнир.Название
			LEFT JOIN РезультатыПоединков ON Поединок.Номер = РезультатыПоединков.Поединок
		WHERE Дата = (SELECT Дата FROM КрайняяДата 
			WHERE КрайняяДата.[Весовая категория] = Поединок.[Весовая категория])
			AND [Статус поединка] = 'Ч') AS A
			JOIN Боец ON A.[Код чемпиона] = Боец.Код
GO

--Активные контракты
CREATE VIEW V_Contracts
AS
	SELECT Номер, Боец AS [Код бойца], ФИО, Стаж, [Количество поединков] AS Поединки,
		[Гонорар за выступление (руб)] AS [Гонорар (руб)], [Ежемесячная зарплата (руб)] AS [Зарплата (руб)], 
		[Ежемесячная компенсация (руб)] AS [Компенсация (руб)], ([Гонорар за выступление (руб)] * 
			[Количество поединков] +  DATEDIFF(MONTH, [Дата подписания договора], [Дата окончания договора]) *
			[Ежемесячная зарплата (руб)] * (SELECT [Коэффициент увеличения зарплаты] FROM Стаж 
			WHERE Стаж = Боец.Стаж)) AS [Минимальные выплаты (руб)],
		[Дата подписания договора], [Дата окончания договора]
		FROM Контракт JOIN Боец 
			ON Контракт.Боец = Боец.Код
		WHERE [Дата подписания договора] <= GETDATE()
			AND [Дата окончания договора] >= GETDATE()
GO

--Награды
CREATE VIEW V_Awards
AS
	SELECT Поединок AS [Код поединка], (SELECT ФИО FROM Боец WHERE Код = [Боец 1])
		AS [Боец 1], (SELECT ФИО FROM Боец WHERE Код = [Боец 2]) AS [Боец 2], 
		Турнир, (SELECT Дата FROM Турнир WHERE Название = Турнир) AS Дата,
		Награда.Награда AS Награда, (CASE WHEN [Награжденный боец] = 0 THEN 
		(SELECT ФИО FROM Боец WHERE Код = [Боец 1])	WHEN [Награжденный боец] = 1 THEN 
		(SELECT ФИО FROM Боец WHERE Код = [Боец 2]) ELSE NULL END) AS [Награжденный боец],
			[Денежный бонус (руб)]
		FROM Награждение JOIN Награда ON Награждение.Награда = Награда.Награда
			JOIN Поединок ON Награждение.Поединок = Поединок.Номер
GO


/*ХРАНИМЫЕ ПРОЦЕДУРЫ*/


--Вывод информации о бойцах
CREATE PROC FightersInfo
AS
	SELECT Код, ФИО, [Дата рождения], Страна, Гражданство, Стаж,
		(SELECT MIN([Дата подписания договора]) FROM Контракт
			WHERE Боец = Код) AS [Дата подписания в организацию],
		(SELECT MAX([Дата окончания договора]) FROM Контракт
			WHERE [Дата подписания договора] < GETDATE()
			AND Боец = Код) AS [Дата окончания контракта],
		Телефон, [Электронная почта], [Паспортные данные], Адрес,
		(SELECT COUNT(*) FROM Поединок JOIN РезультатыПоединков
			ON Поединок.Номер = РезультатыПоединков.Поединок
			WHERE ([Боец 1] = Код AND Победитель = 0) OR
				([Боец 2] = Код AND Победитель = 1)) AS Побед,
		(SELECT COUNT(*) FROM Поединок JOIN РезультатыПоединков
			ON Поединок.Номер = РезультатыПоединков.Поединок
			WHERE ([Боец 1] = Код AND Победитель = 1) OR
				([Боец 2] = Код AND Победитель = 0)) AS Поражений,
		[Вес (кг)], [Рост (см)], [Размах рук (см)]
		FROM Боец
GO

--Вставка информации о бойце
CREATE PROC FightersInsert (@seniority tinyint,	@fio varchar(50), 
	@bdate varchar(100), @country varchar(30),	@weight float, 
	@height float, @reach float, @citizen varchar(30), @pass varchar(20),
	@phone varchar(30), @email varchar(100), @address varchar(MAX))
	AS
		INSERT INTO Боец VALUES
		(@seniority, @fio, @bdate, @country, @weight, @height, @reach,
		@citizen, @pass, @phone, @email, @address)
GO

--Обновление информации о бойце
CREATE PROC FightersUpdate (@code int, @seniority tinyint,	@fio varchar(50), 
	@bdate varchar(100), @country varchar(30),	@weight float, 
	@height float, @reach float, @citizen varchar(30), @pass varchar(20),
	@phone varchar(30), @email varchar(100), @address varchar(MAX))
	AS
		UPDATE Боец
		SET Стаж = @seniority, ФИО = @fio, [Дата рождения] = @bdate, 
			Страна = @country, [Вес (кг)] = @weight, [Рост (см)] = @height, 
			[Размах рук (см)] = @reach, Гражданство = @citizen, 
			[Паспортные данные] = @pass, Телефон = @phone,
			[Электронная почта] = @email, Адрес = @address
			WHERE Код = @code
GO

--Удаление информации о бойце
CREATE PROC FightersDelete (@code int)
AS
	DELETE FROM Боец
		WHERE Код = @code
GO

--Поединок
CREATE PROC FightsInfo
AS
	SELECT Номер, (SELECT ФИО FROM Боец WHERE Код = [Боец 1]) AS [Боец 1], 
		(SELECT ФИО FROM Боец WHERE Код = [Боец 2]) AS [Боец 2], Турнир, 
		(SELECT Дата FROM Турнир WHERE Название = Турнир) AS Дата, [Весовая категория],
		(SELECT ФИО FROM Боец WHERE Код = (CASE WHEN (SELECT Победитель FROM РезультатыПоединков
		WHERE Поединок = Номер) = 0 THEN [Боец 1] WHEN (SELECT Победитель FROM РезультатыПоединков
		WHERE Поединок = Номер) = 1 THEN [Боец 2] ELSE NULL END)) AS Победитель,
		Результат, Раунд, Время, [Статус поединка], [Номер в турнире]
		FROM Поединок LEFT JOIN РезультатыПоединков ON
			Поединок.Номер = РезультатыПоединков.Поединок
GO
CREATE PROC FightsInsert (@fio1 varchar(50), @fio2 varchar(50), @event varchar(60),
@weight varchar(20), @winner bit, @result varchar(50), @round tinyint,
@time time, @status char(1), @number tinyint)
AS
	INSERT INTO Поединок VALUES
	((SELECT Код FROM Боец WHERE ФИО = @fio1), (SELECT Код FROM Боец WHERE ФИО = @fio2),
	@event, @weight, @status, @number)
	DECLARE @code int = (SELECT Номер FROM Поединок WHERE [Боец 1] = (SELECT Код
		FROM Боец WHERE ФИО = @fio1) AND Турнир = @event)
	IF @result IS NOT NULL AND @round IS NOT NULL AND @time IS NOT NULL
		INSERT INTO РезультатыПоединков VALUES
		(@code, @result, @winner, @round, @time)
GO
CREATE PROC FightsUpdate (@code int, @fio1 varchar(50), @fio2 varchar(50), @event varchar(60),
@weight varchar(20), @winner bit, @result varchar(50), @round tinyint,
@time time, @status char(1), @number tinyint)
AS
	IF @round > 3 
		SET @status = 'Ч'
	UPDATE Поединок
		SET [Боец 1] = (SELECT Код FROM Боец WHERE ФИО = @fio1), 
		[Боец 2] = (SELECT Код FROM Боец WHERE ФИО = @fio2),
		Турнир = @event, [Весовая категория] = @weight, [Статус поединка] = @status,
		[Номер в турнире] = @number
		WHERE Номер = @code
	IF @result IS NOT NULL AND @round IS NOT NULL AND @time IS NOT NULL BEGIN
		IF EXISTS(SELECT * FROM РезультатыПоединков
			WHERE Поединок = @code) BEGIN
			UPDATE РезультатыПоединков
				SET Результат = @result, Победитель = @winner, 
					Раунд = @round, Время = @time
				WHERE Поединок = @code
			END
		ELSE
			INSERT INTO РезультатыПоединков VALUES
			(@code, @result, @winner, @round, @time)
	END
GO
CREATE PROC FightsDelete (@code int)
AS
	DELETE FROM РезультатыПоединков
		WHERE Поединок = @code
	DELETE FROM Поединок
		WHERE Номер = @code
GO

--Турнир
CREATE PROC EventsInfo
AS
	SELECT Название, [Место проведения], Дата, [Суммарная посещаемость (чел)],
		(SELECT SUM([Продано билетов]) FROM ПродажаБилетов
		WHERE Турнир = Название) AS [Продано билетов], [Общая выручка (руб)], 
		(SELECT SUM([Продано билетов] * [Стоимость (руб)]) FROM ПродажаБилетов
		WHERE Турнир = Название) AS [Кассовые сборы (руб)], [Затраты на организацию (руб)],
		([Общая выручка (руб)] - [Затраты на организацию (руб)]) AS Профициты
		FROM Турнир
GO
CREATE PROC EventsInsert (@name varchar(60), @place varchar(30), @date date, 
	@attend int, @revenue money, @costs money)
AS
	INSERT INTO Турнир VALUES
	(@name, @place, @date, @attend, @revenue, @costs)
GO
CREATE PROC EventsUpdate (@name varchar(60), @place varchar(30), @date date, 
	@attend int, @revenue money, @costs money)
AS
	UPDATE Турнир
		SET [Место проведения] = @place, Дата = @date, 
			[Суммарная посещаемость (чел)] = @attend, 
			[Общая выручка (руб)] = @revenue, 
			[Затраты на организацию (руб)] = @costs
		WHERE Название = @name
GO
CREATE PROC EventsDelete (@name varchar(60))
AS
	DELETE FROM Турнир
		WHERE Название = @name
GO