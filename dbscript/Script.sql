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


/*�������, ���������, ���������������� ����*/


--�������
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

--������ ��������
CREATE RULE R_FightStatus
	AS
		@x IN ('�', '�')
GO
CREATE DEFAULT D_FightStatus
	AS
		'�'
GO
CREATE TYPE FightStatus
FROM char(1) not null
GO
EXEC sp_bindrule 'R_FightStatus', 'FightStatus'
EXEC sp_bindefault 'D_FightStatus', 'FightStatus'
GO

--������ ���� (� �������� ��� �������� ��������)
CREATE RULE R_AboveZero
	AS
		@x > 0 OR @x IS NULL
GO

--��� ��� � �����
CREATE RULE R_TextValue
	AS
		@x NOT LIKE '%[^�-��-� -.]%'
GO

--���
CREATE RULE R_Weight
	AS
		@x >= 50 AND @x <= 300
GO

--���� � ������ ���
CREATE RULE R_Height
	AS
		@x >= 150 AND @x <= 240
GO

--������������� �������� (�� ��������)
CREATE RULE R_English
	AS
		@x NOT LIKE '%[^A-Za-z -]%'
GO

--����� ���������
CREATE RULE R_Contract
	AS
		@x LIKE '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9]'
GO

--������ � �����������
CREATE DEFAULT D_Russia
	AS
		'������'
GO

--����� � ����� ��� ���������, �������� �� �������
CREATE DEFAULT D_Round
	AS
		3
GO
CREATE DEFAULT D_Time
	AS
		'00:05:00'
GO


/*�������� ������*/


CREATE TABLE �����
(�������� varchar(30) not null,
�������������� varchar(100) not null,
[����������� (���)] int not null,
[��� ��������] smallint null,
�������� varchar(100) not null)
GO
ALTER TABLE �����
ADD CONSTRAINT PK_����� primary key (��������)
GO
ALTER TABLE �����
ADD CONSTRAINT CHK_����� check ([����������� (���)] >= 100 AND
[����������� (���)] <= 200000 AND [��� ��������] >= 1800 AND
[��� ��������] <= YEAR(GETDATE()))
GO

CREATE TABLE ������
(�������� varchar(60) not null,
[����� ����������] varchar(30) not null,
���� date null,
[��������� ������������ (���)] int null, 
[����� ������� (���)] money null,
[������� �� ����������� (���)] money null)
GO
ALTER TABLE ������
ADD CONSTRAINT PK_������ primary key (��������)
GO
ALTER TABLE ������
ADD CONSTRAINT FK_������_����� foreign key ([����� ����������]) references �����(��������)
	ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE ������
ADD CONSTRAINT UC_������_���� unique (����)
GO
EXEC sp_bindrule 'R_AboveZero', '������.[������� �� ����������� (���)]'
EXEC sp_bindrule 'R_AboveZero', '������.[����� ������� (���)]'
EXEC sp_bindrule 'R_AboveZero', '������.[��������� ������������ (���)]'
GO

CREATE TABLE �����
([��� ������] varchar(3) not null,
[����������� ��������] varchar(20) null)
GO
ALTER TABLE �����
ADD CONSTRAINT PK_����� primary key ([��� ������])
GO

CREATE TABLE ��������������
(������ varchar(60) not null,
[��� ������] varchar(3) not null,
[��������� (���)] money not null,
[���������� �������] smallint null,
[������� �������] smallint null)
GO
ALTER TABLE ��������������
ADD CONSTRAINT PK_�������������� primary key (������, [��� ������])
GO
ALTER TABLE ��������������
ADD CONSTRAINT FK_��������������_������ foreign key (������) references ������(��������)
	ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE ��������������
ADD CONSTRAINT FK_��������������_����� foreign key ([��� ������]) references �����([��� ������])
	ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE ��������������
ADD CONSTRAINT CHK_�������������� check ([������� �������] <= [���������� �������])
GO
EXEC sp_bindrule 'R_AboveZero', '��������������.[��������� (���)]'
EXEC sp_bindrule 'R_AboveZero', '��������������.[���������� �������]'
EXEC sp_bindrule 'R_AboveZero', '��������������.[������� �������]'
GO

CREATE TABLE ����
(���� tinyint not null,
[����������� ���������� ��������] float not null)
GO
ALTER TABLE ����
ADD CONSTRAINT PK_���� primary key (����)
GO
ALTER TABLE ����
ADD CONSTRAINT CHK_���� check (���� <= 40 AND
[����������� ���������� ��������] >= 1)
GO

CREATE TABLE ����
(��� int not null identity (1, 1),
���� tinyint not null,
��� varchar(50) not null,
[���� ��������] date not null,
������ varchar(30) not null,
[��� (��)] float not null,
[���� (��)] float not null,
[������ ��� (��)] float not null,
����������� varchar(30) not null,
[���������� ������] varchar(20) not null,
������� Phone,
[����������� �����] Email,
����� varchar(MAX) not null)
GO
ALTER TABLE ����
ADD CONSTRAINT PK_���� primary key (���)
GO
ALTER TABLE ����
ADD CONSTRAINT FK_����_���� foreign key (����) references ����(����)
GO
ALTER TABLE ����
ADD CONSTRAINT UC_����_������� unique ([���������� ������])
GO
ALTER TABLE ����
ADD CONSTRAINT CHK_���� check (DATEADD(year, 16, [���� ��������]) <= GETDATE())
GO
EXEC sp_bindrule 'R_TextValue', '����.���'
EXEC sp_bindrule 'R_TextValue', '����.������'
EXEC sp_bindrule 'R_TextValue', '����.�����������'
EXEC sp_bindrule 'R_Weight', '����.[��� (��)]'
EXEC sp_bindrule 'R_Height', '����.[���� (��)]'
EXEC sp_bindrule 'R_Height', '����.[������ ��� (��)]'
EXEC sp_bindefault 'D_Russia', '����.������'
EXEC sp_bindefault 'D_Russia', '����.�����������'
GO

CREATE TABLE ��������
(����� char(11) not null,
���� int not null,
[���������� ���������] tinyint not null,
[������� �� ����������� (���)] money not null,
[����������� �������� (���)] money not null,
[����������� ����������� (���)] money not null,
[���� ���������� ��������] date null,
[���� ��������� ��������] date not null) 
GO
ALTER TABLE ��������
ADD CONSTRAINT PK_�������� primary key (�����)
GO
ALTER TABLE ��������
ADD CONSTRAINT FK_��������_���� foreign key (����) references ����(���)
	ON DELETE CASCADE
GO
ALTER TABLE ��������
ADD CONSTRAINT CHK_�������� check ([���������� ���������] <= 20)
GO
EXEC sp_bindrule 'R_Contract', '��������.�����'
EXEC sp_bindrule 'R_AboveZero', '��������.[���������� ���������]'
EXEC sp_bindrule 'R_AboveZero', '��������.[������� �� ����������� (���)]'
EXEC sp_bindrule 'R_AboveZero', '��������.[����������� �������� (���)]'
EXEC sp_bindrule 'R_AboveZero', '��������.[����������� ����������� (���)]'
GO

CREATE TABLE ����������������
([������� ���������] varchar(20) not null,
[������ ������� (��)] float not null,
[������� ������� (��)] float not null,
[������������� ��������] varchar(20) null)
GO
ALTER TABLE ����������������
ADD CONSTRAINT PK_���������������� primary key ([������� ���������])
GO
ALTER TABLE ����������������
ADD CONSTRAINT UC_����������������_��������������������� unique ([������������� ��������])
GO
EXEC sp_bindrule 'R_TextValue', '����������������.[������� ���������]'
EXEC sp_bindrule 'R_Weight', '����������������.[������ ������� (��)]'
EXEC sp_bindrule 'R_Weight', '����������������.[������� ������� (��)]'
EXEC sp_bindrule 'R_English', '����������������.[������������� ��������]'
GO

CREATE TABLE ��������
(����� int not null identity (1, 1),
[���� 1] int not null,
[���� 2] int not null,
������ varchar(60) not null,
[������� ���������] varchar(20) not null,
[������ ��������] FightStatus,
[����� � �������] tinyint null)
GO
ALTER TABLE ��������
ADD CONSTRAINT PK_�������� primary key (�����)
GO
ALTER TABLE ��������
ADD CONSTRAINT FK_��������_����_1 foreign key ([���� 1]) references ����(���)
GO
ALTER TABLE ��������
ADD CONSTRAINT FK_��������_����_2 foreign key ([���� 2]) references ����(���)
GO
ALTER TABLE ��������
ADD CONSTRAINT FK_��������_������ foreign key (������) references ������(��������)
	ON DELETE CASCADE ON UPDATE CASCADE
GO
ALTER TABLE ��������
ADD CONSTRAINT FK_��������_���������������� foreign key ([������� ���������]) references ����������������([������� ���������])
	ON DELETE CASCADE
GO

CREATE TABLE ������
(��� int not null identity (1, 1),
��� varchar(50) not null,
[���� ��������] date not null,
����������� varchar(30) not null,
[���������� ������] varchar(20) not null,
������� Phone, 
[����������� �����] Email,
����� varchar(MAX) not null,
[���� ���������� ��������] date null)
GO
ALTER TABLE ������
ADD CONSTRAINT PK_������ primary key (���)
GO
ALTER TABLE ������
ADD CONSTRAINT UC_������_������� unique ([���������� ������])
GO
ALTER TABLE ������
ADD CONSTRAINT UC_������_������� unique (�������)
GO
ALTER TABLE ������
ADD CONSTRAINT UC_������_����� unique ([����������� �����])
GO
ALTER TABLE ������
ADD CONSTRAINT CHK_������ check (DATEADD(year, 18, [���� ��������]) <= GETDATE()
	AND [���� ���������� ��������] <= GETDATE())
GO
EXEC sp_bindrule 'R_TextValue', '������.���'
EXEC sp_bindrule 'R_TextValue', '������.�����������'
EXEC sp_bindefault 'D_Russia', '������.�����������'
GO

CREATE TABLE �������������������
(�������� int not null,
������ int not null,
[������� (���)] money not null)
GO
ALTER TABLE �������������������
ADD CONSTRAINT PK_������������������� primary key (��������)
GO
ALTER TABLE �������������������
ADD CONSTRAINT FK_�������������������_�������� foreign key (��������) references ��������(�����)
	ON DELETE CASCADE
GO
ALTER TABLE �������������������
ADD CONSTRAINT FK_�������������������_������ foreign key (������) references ������(���)
GO
EXEC sp_bindrule 'R_AboveZero', '�������������������.[������� (���)]'
GO

CREATE TABLE ���������
(��������� varchar(50) not null,
�������� varchar(MAX) null)
GO
ALTER TABLE ���������
ADD CONSTRAINT PK_��������� primary key (���������)
GO

CREATE TABLE �������������������
(�������� int not null,
��������� varchar(50) not null,
���������� bit null,
����� tinyint not null,
����� time(0) not null)
GO
ALTER TABLE �������������������
ADD CONSTRAINT PK_������������������� primary key (��������)
GO
ALTER TABLE �������������������
ADD CONSTRAINT FK_�������������������_�������� foreign key (��������) references ��������(�����)
	ON DELETE CASCADE
GO
ALTER TABLE �������������������
ADD CONSTRAINT FK_�������������������_��������� foreign key (���������) references ���������(���������)
	ON UPDATE CASCADE
GO
ALTER TABLE �������������������
ADD CONSTRAINT CHK_������������������� check (����� >= 1 AND ����� <= 5 
	AND ����� >= '00:00:01' AND ����� <= '00:05:00')
GO
EXEC sp_bindefault 'D_Round', '�������������������.�����'
EXEC sp_bindefault 'D_Time', '�������������������.�����'
GO

CREATE TABLE �������
(������� varchar(20) not null,
[�������� ����� (���)] money not null,
�������� varchar(MAX) null)
GO
ALTER TABLE �������
ADD CONSTRAINT PK_������� primary key (�������)
GO
EXEC sp_bindrule 'R_AboveZero', '�������.[�������� ����� (���)]'
GO

CREATE TABLE �����������
(�������� int not null,
������� varchar(20) not null,
[������������ ����] bit null)
GO
ALTER TABLE �����������
ADD CONSTRAINT PK_����������� primary key (��������)
GO
ALTER TABLE �����������
ADD CONSTRAINT FK_�����������_�������� foreign key (��������) references ��������(�����)
	ON DELETE CASCADE
GO
ALTER TABLE �����������
ADD CONSTRAINT FK_�����������_������� foreign key (�������) references �������(�������)
	ON DELETE CASCADE
GO

CREATE TABLE �����
(��� int not null identity (1, 1),
��� varchar(50) not null,
[���� ��������] date not null,
����������� varchar(30) not null,
[���������� ������] varchar(20) not null,
������� Phone,
[����������� �����] Email,
����� varchar(MAX) not null,
[���� ���������� ��������] date null)
GO
ALTER TABLE �����
ADD CONSTRAINT PK_����� primary key (���)
GO
ALTER TABLE �����
ADD CONSTRAINT UC_�����_������� unique ([���������� ������])
GO
ALTER TABLE �����
ADD CONSTRAINT UC_�����_������� unique (�������)
GO
ALTER TABLE �����
ADD CONSTRAINT UC_�����_����� unique ([����������� �����])
GO
ALTER TABLE �����
ADD CONSTRAINT CHK_����� check (DATEADD(year, 18, [���� ��������]) <= GETDATE()
	AND [���� ���������� ��������] <= GETDATE())
GO
EXEC sp_bindrule 'R_TextValue', '�����.���'
EXEC sp_bindrule 'R_TextValue', '�����.�����������'
EXEC sp_bindefault 'D_Russia', '�����.�����������'
GO

CREATE TABLE ���������
(�������� int not null,
����� int not null,
[������� (���)] money not null)
GO
ALTER TABLE ���������
ADD CONSTRAINT PK_��������� primary key (��������, �����)
GO
ALTER TABLE ���������
ADD CONSTRAINT FK_���������_�������� foreign key (��������) references ��������(�����)
	ON DELETE CASCADE
GO
ALTER TABLE ���������
ADD CONSTRAINT FK_���������_����� foreign key (�����) references �����(���)
GO
EXEC sp_bindrule 'R_AboveZero', '���������.[������� (���)]'
GO


/*��������*/


--��� ������� � �������� ���� ������ ����� ����������� ��������
CREATE TRIGGER T_������������������� ON ��������
	AFTER INSERT, UPDATE
		AS
			DECLARE @fighter1 int = (SELECT [���� 1] FROM inserted)
			DECLARE @fighter2 int = (SELECT [���� 2] FROM inserted)
			DECLARE @maxContractDate1 date = 
			(SELECT [���� ��������� ��������] FROM ��������
				WHERE ���� = @fighter1 AND
					[���� ���������� ��������] =
				(SELECT MAX([���� ���������� ��������])
					FROM ��������
					WHERE ���� = @fighter1 AND 
						[���� ���������� ��������] <= GETDATE()))
			DECLARE @maxContractDate2 date = 
			(SELECT [���� ��������� ��������] FROM ��������
				WHERE ���� = @fighter2 AND
					[���� ���������� ��������] =
				(SELECT MAX([���� ���������� ��������])
					FROM ��������
					WHERE ���� = @fighter2 AND 
						[���� ���������� ��������] <= GETDATE()))
			DECLARE @eventDate date = 
				(SELECT ���� FROM ������
					WHERE �������� = (SELECT ������ FROM inserted))
			IF @maxContractDate1 < @eventDate OR
				@maxContractDate2 < @eventDate
				ROLLBACK TRAN
GO

--���� ���� �� ����� ����������� � ����� ������� ������
CREATE TRIGGER T_���������������1 ON ��������
	AFTER INSERT
		AS
			DECLARE @fighter1 int = (SELECT [���� 1] FROM inserted)
			DECLARE @fighter2 int = (SELECT [���� 2] FROM inserted)
			IF @fighter2 = @fighter1 ROLLBACK TRAN
			IF EXISTS(SELECT * FROM ��������
				WHERE ����� != (SELECT ����� FROM inserted)
				AND ������ = (SELECT ������ FROM inserted) AND
					([���� 1] = @fighter1 OR [���� 1] = @fighter2 OR
					[���� 2] = @fighter1 OR [���� 2] = @fighter2))
						ROLLBACK TRAN
GO
CREATE TRIGGER T_���������������2 ON ��������
	AFTER UPDATE
		AS
			DECLARE @fighter1 int = (SELECT [���� 1] FROM inserted)
			DECLARE @fighter2 int = (SELECT [���� 2] FROM inserted)
			IF @fighter2 = @fighter1 ROLLBACK TRAN
			IF EXISTS(SELECT * FROM ��������
				WHERE ����� <> (SELECT ����� FROM inserted)
				AND ����� <> (SELECT ����� FROM deleted)
				AND ������ = (SELECT ������ FROM inserted) AND
					([���� 1] = @fighter1 OR [���� 1] = @fighter2 OR
					[���� 2] = @fighter1 OR [���� 2] = @fighter2))
					ROLLBACK TRAN
GO

--������ ��������� � ������� ������ ���� � ��������� [1;18] � �� ������ �����������
CREATE TRIGGER T_������������� ON ��������
	AFTER INSERT, UPDATE
		AS
			DECLARE @num tinyint = (SELECT [����� � �������] FROM inserted)
			IF @num IS NOT NULL AND (@num < 1 OR @num > 18 
				OR EXISTS(SELECT * FROM ��������
					WHERE ����� != (SELECT ����� FROM inserted) AND
					������ = (SELECT ������ FROM inserted) AND 
					[����� � �������] = @num))
					ROLLBACK TRAN
GO

--��� ���������� ����������� ���������� ������ ������ ��������������� �������
CREATE TRIGGER T_����������� ON ����
	AFTER INSERT, UPDATE
		AS
			DECLARE @pass varchar(20) =
				(SELECT [���������� ������] FROM inserted)
			DECLARE @citiz varchar(30) =
				(SELECT ����������� FROM inserted)
			IF LOWER(@citiz) = '������' AND @pass NOT LIKE
	'[0-9][0-9][0-9][0-9][ ][0-9][0-9][0-9][0-9][0-9][0-9]'
				AND @pass NOT LIKE
	'[0-9][0-9][ ][0-9][0-9][ ][0-9][0-9][0-9][0-9][0-9][0-9]'
			AND @pass NOT LIKE
	'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
				ROLLBACK TRAN
GO
CREATE TRIGGER T_������������� ON ������
	AFTER INSERT, UPDATE
		AS
			DECLARE @pass varchar(20) =
				(SELECT [���������� ������] FROM inserted)
			DECLARE @citiz varchar(30) =
				(SELECT ����������� FROM inserted)
			IF LOWER(@citiz) = '������' AND @pass NOT LIKE
	'[0-9][0-9][0-9][0-9][ ][0-9][0-9][0-9][0-9][0-9][0-9]'
				AND @pass NOT LIKE
	'[0-9][0-9][ ][0-9][0-9][ ][0-9][0-9][0-9][0-9][0-9][0-9]'
				AND @pass NOT LIKE
	'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
				ROLLBACK TRAN
GO
CREATE TRIGGER T_������������ ON �����
	AFTER INSERT, UPDATE
		AS
			DECLARE @pass varchar(20) =
				(SELECT [���������� ������] FROM inserted)
			DECLARE @citiz varchar(30) =
				(SELECT ����������� FROM inserted)
			IF LOWER(@citiz) = '������' AND @pass NOT LIKE
	'[0-9][0-9][0-9][0-9][ ][0-9][0-9][0-9][0-9][0-9][0-9]'
				AND @pass NOT LIKE
	'[0-9][0-9][ ][0-9][0-9][ ][0-9][0-9][0-9][0-9][0-9][0-9]'
				AND @pass NOT LIKE
	'[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
				ROLLBACK TRAN
GO

--��������� ������
--�������� ������������ ���������� ������
CREATE TRIGGER T_����������� ON �����������
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
				--�������� ������ ���� ������������
				SET @date = (SELECT ���� FROM ������
					WHERE �������� = (SELECT ������ FROM ��������
						WHERE ����� = @fight))
				IF @date > GETDATE() 
					SET @error = 1
				/*���� ������� - "����������� ������", ������ ���� ������ 
				����������, � ��������� ������ - NULL*/
				IF @error = 0 BEGIN
					IF @award = '������ ��� ������' BEGIN
						IF @awarded IS NOT NULL SET @error = 1
						END
					ELSE IF @awarded IS NULL SET @error = 1
				END
				/*���� ������� ����������� �������� (������ ��� ������),
				�� ��� ������ ���� ������������ �� ������*/
				IF @error = 0 AND @awarded IS NULL BEGIN
					DECLARE @event varchar(60) = (SELECT ������
						FROM �������� WHERE ����� = @fight)
					DECLARE @aw bit, @ev varchar(60)
					DECLARE C23 CURSOR FOR
						SELECT [������������ ����], ������ 
							FROM ����������� JOIN ��������
							ON �����������.�������� = ��������.�����
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
				/*���� ������� ����������� ����� (����������� ������),
				�� �� ������ ���� ����������� ��������*/
				IF @error = 0 AND @awarded IS NOT NULL BEGIN
					IF NOT EXISTS(SELECT * FROM �������������������
					WHERE �������� = @fight AND ���������� = @awarded)
						SET @error = 1
				END

				IF @error = 0
					INSERT INTO ����������� VALUES
					(@fight, @award, @awarded)
				FETCH NEXT FROM C2 INTO @fight, @award, @awarded
			END
			CLOSE C2
			DEALLOCATE C2
GO

--��� ������ ������ ��������������� ������� ��������� ��������
CREATE TRIGGER T_��������� ON ��������
	AFTER INSERT, UPDATE
		AS
			DECLARE @weight1 float = (SELECT [��� (��)] FROM ����
				WHERE ��� = (SELECT [���� 1] FROM inserted))
			DECLARE @weight2 float = (SELECT [��� (��)] FROM ����
				WHERE ��� = (SELECT [���� 2] FROM inserted))
			DECLARE @vk varchar(20) = 
				(SELECT [������� ���������] FROM ��������
				WHERE ����� = (SELECT ����� FROM inserted))
			DECLARE @up float = 
				(SELECT [������� ������� (��)] FROM ����������������
				WHERE [������� ���������] = @vk)
			DECLARE @down float = 
				(SELECT [������ ������� (��)] FROM ����������������
				WHERE [������� ���������] = @vk)
			IF @weight1 > @up OR @weight1 < @down OR
				@weight2 > @up OR @weight2 < @down
				ROLLBACK TRAN
GO

--������
/*���� ���������� ��������� ������ ���� ������
���� ��������� ���� �� �� �����*/
CREATE TRIGGER T_�������� ON ��������
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
				INSERT INTO �������� VALUES (@num, @fighter, @amount, @money,
				@month1, @month2, @sign, @end)
			FETCH NEXT FROM C1 INTO @num, @fighter, @amount, @money,
				@month1, @month2, @sign, @end
			END
			CLOSE C1
			DEALLOCATE C1
GO

--������
--�������� ����� �� ����� 3 �����
CREATE TRIGGER T_��������� ON ���������
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
				SET @jnum = (SELECT COUNT(*) FROM ���������
								WHERE �������� = @fight)
				IF @jnum < 3 INSERT INTO ��������� VALUES
					(@fight, @judge, @money)
				FETCH NEXT FROM C4 INTO @fight, @judge, @money
			END
			CLOSE C4
			DEALLOCATE C4
GO

--���� �������� ����� �� �������, ����� � ����� � ������� ������ ���� �������������
CREATE TRIGGER T_���������� ON �������������������
	AFTER INSERT, UPDATE
		AS
			DECLARE @res varchar(50) = (SELECT ��������� FROM inserted),
			@time time = (SELECT ����� FROM inserted),
			@round tinyint = (SELECT ����� FROM inserted)
			IF (LOWER(@res) LIKE '%�������%' OR LOWER(@res) LIKE '%�����%')
				AND LOWER(@res) NOT LIKE '%������%'
				AND (@round NOT IN (3, 5)
				OR @time NOT LIKE '%5:00%')
				ROLLBACK TRAN
GO

--������������� �������� �� ����� ����� ������ �������� ������
CREATE TRIGGER T_����������� ON �������������������
	AFTER INSERT, UPDATE
		AS
			DECLARE @status char (1) = (SELECT [������ ��������] FROM ��������
				WHERE ����� = (SELECT �������� FROM inserted)),
				@round tinyint = (SELECT ����� FROM inserted)
			IF @status = '�' AND @round > 3
				ROLLBACK TRAN
GO

--��� ������ ��� "��� ����������" �������� �� ������ ����� ����������
CREATE TRIGGER T_���������� ON �������������������
	AFTER INSERT, UPDATE
		AS
			DECLARE @res varchar(50) = (SELECT ��������� FROM inserted),
				@winner bit = (SELECT ���������� FROM inserted)
			IF (@res LIKE '%�����%' OR @res = '��� ����������') BEGIN
				IF @winner IS NOT NULL
					ROLLBACK TRAN
				END
			ELSE IF @winner IS NULL
				ROLLBACK TRAN
GO

--�������� �� ����� ����� ���������, ���� �� ��� �� ���������
CREATE TRIGGER T_��������������� ON �������������������
	AFTER INSERT, UPDATE
		AS
			DECLARE @date date = (SELECT ���� FROM ������
				WHERE �������� = (SELECT ������ FROM ��������
				WHERE ����� = (SELECT �������� FROM inserted)))
			IF @date > GETDATE()
				ROLLBACK TRAN
GO

--����� ������� �� ������ ����� ��������� �������
CREATE TRIGGER T_������������ ON ������
	AFTER UPDATE
		AS
			DECLARE @prof money = (SELECT [����� ������� (���)] FROM inserted)
			IF @prof IS NOT NULL BEGIN
				DECLARE @sum money = (SELECT SUM([��������� (���)]*[������� �������]) 
					FROM �������������� WHERE ������ = 
						(SELECT �������� FROM inserted))
				IF @sum IS NOT NULL
					IF @prof < @sum ROLLBACK TRAN
			END
GO

/*��������� ������������ �� ������ ���������� ��������� �������
� �� ������ ����������� �����*/
CREATE TRIGGER T_������������ ON ������
	AFTER INSERT, UPDATE
		AS
			DECLARE @attend int = (SELECT [��������� ������������ (���)] FROM inserted)
			IF @attend IS NOT NULL BEGIN
				DECLARE @sum int = (SELECT SUM([������� �������]) 
					FROM �������������� WHERE ������ = 
						(SELECT �������� FROM inserted))
				DECLARE @vmest int = (SELECT [����������� (���)] FROM �����
					WHERE �������� = (SELECT [����� ����������] FROM inserted))
				IF @attend > @vmest 
					ROLLBACK TRAN
				ELSE IF @sum IS NOT NULL
					IF @attend < @sum
						ROLLBACK TRAN
				END
GO

--���� ������ ��� �� ���������, �� ����� ������������ ���������� � ��� ������������
CREATE TRIGGER T_������������ ON ������
	AFTER INSERT, UPDATE
		AS
			IF (SELECT ���� FROM inserted) > GETDATE()
				AND (SELECT [��������� ������������ (���)] FROM inserted)
					IS NOT NULL
				ROLLBACK TRAN
GO

--���������� ������������ ������� ������ ������������ �� �����������
CREATE TRIGGER T_������ ON ��������������
	AFTER INSERT, UPDATE
		AS
			DECLARE @sale int = (SELECT SUM([���������� �������]) FROM ��������������
				WHERE ������ = (SELECT ������ FROM inserted))
			IF @sale IS NULL SET @sale = 0
			SET @sale += (SELECT [���������� �������] FROM inserted)
			DECLARE @vmest int = (SELECT [����������� (���)] FROM �����
				WHERE �������� = (SELECT [����� ����������] FROM ������
				WHERE �������� = (SELECT ������ FROM inserted)))
			IF @sale > @vmest
				ROLLBACK TRAN
GO

--��������� �������� �� ������� "����"
CREATE TRIGGER T_������������� ON ����
	INSTEAD OF DELETE
		AS
			DELETE FROM ��������
			WHERE [���� 1] = (SELECT ��� FROM deleted)
				OR [���� 2] = (SELECT ��� FROM deleted)
			DELETE FROM ����
				WHERE ��� = (SELECT ��� FROM deleted)
GO


/*���������� ������*/


INSERT INTO ����� VALUES
('���� �����', '������, ������, ��. �������������, �. 23�', 16000, 2015, '������ "����� ���"'),
('�� "���������"', '������, �����-���������, �����. �����������, 18', 6381, 1967, '������������� �����-����������'),
('�� "�����������"', '������, ������, �����. �����������, 16, ���. 1', 35000, 1980, '"�������� �������"'),
('���� "������"', '������, ������, ��������� ���., 24, ���. 1', '7000', 1971, '������������� ������'),
('�� "�����������"', '������, ������, ��. ��������', 2700, 2005, '������������ ���������� �������� � ������ ��������� �������'),
('��-������ �����', '���, ������, ��������', 20000, 2016, 'Anschutz Entertainment Group, MGM Resorts International, ��� �����'),
('�������-�����-������', '���, ���-����, ���-����', 20789, 1968, 'The Madison Square Garden Company'),
('�����-�����', '���, ����������, �������', 18900, 1993, '������������� ��������'),
('����-�����', '���, ��������, ������', 21000, 1999, '���� ������'),
('������-�����', '���, �����, �������', 19000, NULL, '����� ������, Houston Sports Authority')
GO

INSERT INTO ������ VALUES
('RFC 228', '�� "�����������"', '11.01.2023', 1000, 600000, 200000)
GO
INSERT INTO ������ VALUES
('RFC 229', '�� "�����������"', '11.02.2023', 4000, 180000000, 6000000)
GO
INSERT INTO ������ VALUES
('RFC 230', '�� "���������"', '11.03.2023', 4200, 188000000, 6000000)
GO
INSERT INTO ������ VALUES
('RFC 231', '�������-�����-������', '11.04.2023', 3000, 181500000, 7000000)
GO
INSERT INTO ������ VALUES
('RFC 232', '�� "�����������"', '11.05.2023', 1000, 620000, 200000)
GO
INSERT INTO ������ VALUES
('RFC 233: ����������� vs ������', '�� "�����������"', '11.06.2023', 6000, 222000000, 6000000)
GO
INSERT INTO ������ VALUES
('RFC 234', '������-�����', '11.07.2023', NULL, NULL, NULL)
GO
INSERT INTO ������ VALUES
('RFC 235', '�����-�����', '11.08.2023', NULL, NULL, NULL)
GO
INSERT INTO ������ VALUES
('RFC 236', '�����-�����', '11.09.2023', NULL, NULL, NULL)
GO
INSERT INTO ������ VALUES
('RFC 237', '������-�����', '11.10.2023', NULL, NULL, NULL)
GO

INSERT INTO ����� VALUES
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
('A-2', '��������'),
('A-3', NULL),
('B-1', '������'),
('B-2', '������')
GO

INSERT INTO �������������� VALUES
('RFC 229', 'A', 15000, 200, 100)
GO
INSERT INTO �������������� VALUES
('RFC 229', 'C', 13000, 200, 150)
GO
INSERT INTO �������������� VALUES
('RFC 229', '111', 10000, 400, 300)
GO
INSERT INTO �������������� VALUES
('RFC 229', '200', 7000, 500, 500)
GO
INSERT INTO �������������� VALUES
('RFC 230', 'A', 30000, 200, 150)
GO
INSERT INTO �������������� VALUES
('RFC 230', 'C', 25000, 300, 299)
GO
INSERT INTO �������������� VALUES
('RFC 230', '109', 15000, 1000, 1000)
GO
INSERT INTO �������������� VALUES
('RFC 230', '312', 10000, 1000, 1000)
GO
INSERT INTO �������������� VALUES
('RFC 231', 'A', 55000, 300, 290)
GO
INSERT INTO �������������� VALUES
('RFC 231', 'C', 55000, 300, 280)
GO
INSERT INTO �������������� VALUES
('RFC 232', '111', 1000, 500, 500)
GO
INSERT INTO �������������� VALUES
('RFC 232', '200', 700, 1000, 1000)
GO
INSERT INTO �������������� VALUES
('RFC 233: ����������� vs ������', 'A', 75000, 500, 400)
GO
INSERT INTO �������������� VALUES
('RFC 233: ����������� vs ������', 'C', 65000, 600, 450)
GO
INSERT INTO �������������� VALUES
('RFC 233: ����������� vs ������', '111', 25000, 2000, 2000)
GO
INSERT INTO �������������� VALUES
('RFC 234', '200', 15000, 3000, NULL)
GO
INSERT INTO �������������� VALUES
('RFC 234', 'A', 65000, 500, NULL)
GO
INSERT INTO �������������� VALUES
('RFC 234', 'C', 55000, 600, NULL)
GO
INSERT INTO �������������� VALUES
('RFC 234', '111', 25000, 1000, NULL)
GO
INSERT INTO �������������� VALUES
('RFC 234', '313', 10000, 1500, NULL)
GO

INSERT INTO ���� VALUES
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

INSERT INTO ���� VALUES
(10, '����������� ����� ������������', '28.09.1976', DEFAULT, 107.5, 182.88, 189, DEFAULT, '6116 567567', '89109032812', 'fedor@gmail.com', '������, ������, ��. �������, �.10, ��.1')
GO
INSERT INTO ���� VALUES
(9, '����������� ��������� ������������', '02.08.1981', DEFAULT, 114.76, 193.04, 202, DEFAULT, '6116 567568', '89109032813', 'alex@gmail.com', '������, ������, ��. �������, �.12, ��.1')
GO
INSERT INTO ���� VALUES
(10, '��������� ������ ����������', '18.08.1980', DEFAULT, 117.03, 193.04, 193, DEFAULT, '6116 567569', '89109032824', 'skh111@yandex.ru', '������, ������, ��. ���������, �.254, ��.4')
GO
INSERT INTO ���� VALUES
(5, '�� ���� ����������', '11.02.1993', DEFAULT, 61.23, 170.18, 170, DEFAULT, '6116 567237', '89109032854', 'aaaa@gmail.com', '������, ����, ��. ���������, �.65, ��. 17')
GO
INSERT INTO ���� VALUES
(2, '���� ������ ������', '12.07.1977', '���', 119.75, 190.5, 206, '���', 'USA82568876D3', '+19168258765', 'b323@bk.com', '���, ����� ������, �������, ����������� ��., 45')
GO
INSERT INTO ���� VALUES
(7, '���� ����', '23.03.1974', '����� ��������', 118.84, 177.8, 182.9, '����� ��������', '626545ABJ946', '+64 (987) 555-666', 'mark123@gmail.com', '���������, ������, ��� ��., 87')
GO
INSERT INTO ���� VALUES
(13, '��������� ����� �� �����', '3.7.1976', '��������', 83.91, 177.8, 188, '��������', 'B348WA812D65', '+55 (954) 22-234-432', 'wan@bk.com', '���, ������, ��� �����, ��� ��., 76')
GO
INSERT INTO ���� VALUES
(6, '����� ���������', '10.09.1974', '��������', 102.93, 187.96, 185, '��������', '4566547823', '+385 23 543432', 'crocop@gmail.com', '��������, ������, ��. ����������, 777')
GO
INSERT INTO ���� VALUES
(0, '�������� ��������� ������', '30.07.2000', '��������������', 56.7, 175.26, 178, DEFAULT, '6116 577567', '89109032893', 'mokaev@yandex.ru', '��������������, ���������, ������ ��., 9')
GO
INSERT INTO ���� VALUES
(4, '�������� ����� �����', '19.07.1987', '���', 112.49, 193.04, 215, '���', 'USA82599976D3', '+19163338765', 'bones@gmail.com', '���, ���-�������, ����������, ���������� ���� ��, 111')
GO
INSERT INTO ���� VALUES
(1, '������ ������������ ��������', '13.05.1992', DEFAULT, 118.39, 190.5, 213, DEFAULT, '6116 589767', '89109066811', 'spmma@yandex.ru', '������, ������, ��. ����������, �.3, ��.87')
GO
INSERT INTO ���� VALUES
(3, '������ ��������� ������', '01.05.1994', '������', 81.19, 187.96, 190, DEFAULT, '6116 512567', '+79109652871', 'borz95@gmail.com', 'Svetsarvagen 24, 171 41 Solna, ������')
GO
INSERT INTO ���� VALUES
(3, '������ ����������� ��������', '23.10.1994', '���������', 77.11, 185.42, 196, '���������', '62956295', '+76109032812', 'nomad@gmail.com', '���������, ��������, ��. ��������, 45')
GO
INSERT INTO ���� VALUES
(12, '������� ������� �������', '02.06.1976', '��������', 107.5, 190.5, 198, '��������', 'B348NO812A66', '+55(954)33-274-433', 'minotauro@bk.com', '��������, ���-��-�������, ��. ��� ����, 13')
GO
INSERT INTO ���� VALUES
(5, '���� ������� ��������', '28.07.1982', '���', 109.32, 185.42, 196, '���', 'USA82577776D3', '+1(916)8258777', 'vel@gmail.com', '���, ����������, ���-����, �������� �����, 13')
GO
INSERT INTO ���� VALUES
(3, '��������� ������', '05.09.1984', '���', 272.16, 203.2, 203.2, '���', 'USA92578876D3', '+1(916)8256547', 'manny@gmail.com', '���, ���������, �������, ������� ��., 18')
GO
INSERT INTO ���� VALUES
(5, '����� ����� �� �����', '21.07.1983', '��������', 174.63, 218.44, 218.44, '��������', 'B358SI862P66', '+55(954)36-264-633', 'giant@bk.com', '��������, ���-�����, ��. �� �����, 23')
GO
INSERT INTO ���� VALUES
(8, '������ �� ��������� �������', '19.05.1978', '��������', 176.9, 200.66, 200.66, '��������', 'B358ZU662L55', '+55(954)36-265-634', 'zulu@bk.com', '��������, ���-����, ��. �� �����, 43')
GO
INSERT INTO ���� VALUES
(0, '����� ����� ��', '08.10.2004', '���', 61.23, 175.26, 170, '���', 'USA82588886D3', '+1(916)8252347', 'champ@gmail.com', '���, ����������, �����-����, ����-��., 89')
GO
INSERT INTO ���� VALUES
(11, '������ �������� �� �����', '17.10.1989', '��������', 70.31, 177.8, 188, '��������', 'B358CH662O77', '+55(954)89-623-633', 'oliv@gmail.com', '��������, �������, ��. ����������, 723')
GO

INSERT INTO �������� VALUES
('11111-11111', 1, 3, 500000, 100000, 100000, '11.01.2023', '11.01.2025')
GO
INSERT INTO �������� VALUES
('11111-11112', 2, 1, 400000, 100000, 100000, '10.01.2023', '10.01.2024')
GO
INSERT INTO �������� VALUES
('11111-11113', 3, 5, 300000, 100000, 100000, '11.01.2023', '11.01.2025')
GO
INSERT INTO �������� VALUES
('11111-11114', 4, 5, 500000, 100000, 90000, '11.01.2023', '11.01.2025')
GO
INSERT INTO �������� VALUES
('11111-11115', 5, 1, 700000, 100000, 100000, '9.01.2023', '9.01.2024')
GO
INSERT INTO �������� VALUES
('11111-11116', 6, 2, 500000, 100000, 100000, '5.01.2023', '5.01.2024')
GO
INSERT INTO �������� VALUES
('11111-11117', 7, 5, 500000, 100000, 100000, '5.01.2023', '5.01.2024')
GO
INSERT INTO �������� VALUES
('11111-11118', 8, 2, 520000, 100000, 120000, '2.01.2023', '2.01.2025')
GO
INSERT INTO �������� VALUES
('11111-11119', 9, 7, 400000, 100000, 70000, '24.01.2023', '24.01.2026')
GO
INSERT INTO �������� VALUES
('11111-11121', 10, 5, 1000000, 150000, 150000, '11.01.2023', '11.01.2026')
GO
INSERT INTO �������� VALUES
('11111-11131', 11, 5, 500000, 100000, 100000, '10.01.2023', '10.01.2025')
GO
INSERT INTO �������� VALUES
('11111-11141', 12, 5, 700000, 100000, 100000, '11.01.2023', '11.01.2025')
GO
INSERT INTO �������� VALUES
('11111-11151', 13, 5, 600000, 100000, 100000, '7.01.2023', '7.01.2024')
GO
INSERT INTO �������� VALUES
('11111-11161', 14, 1, 700000, 100000, 100000, '2.01.2023', '2.01.2024')
GO
INSERT INTO �������� VALUES
('11111-11171', 15, 1, 700000, 100000, 100000, '11.01.2023', '11.01.2024')
GO
INSERT INTO �������� VALUES
('11111-11181', 16, 1, 500000, 100000, 100000, '11.01.2023', '11.01.2024')
GO
INSERT INTO �������� VALUES
('11111-11191', 17, 1, 500000, 100000, 100000, '11.01.2023', '11.01.2024')
GO
INSERT INTO �������� VALUES
('11111-11122', 18, 1, 500000, 100000, 100000, '11.01.2023', '11.01.2024')
GO
INSERT INTO �������� VALUES
('11111-11123', 19, 5, 500000, 100000, 100000, '11.01.2023', '11.01.2024')
GO
INSERT INTO �������� VALUES
('11111-11124', 1, 3, 700000, 100000, 100000, '9.01.2022', '9.01.2023')
GO

INSERT INTO ���������������� VALUES
('������������ ���', 120, 300, 'Super heavyweight'),
('������� ���', 93, 119.99, 'Heavyweight'),
('����������� ���', 84, 92.99, 'Light heavyweight'),
('������� ���', 77, 83.99, 'Middleweight'),
('����������� ���', 70, 76.99, 'Welterweight'),
('������ ���', 66, 69.99, 'Lightweight'),
('���������� ���', 61, 65.99, 'Featherweight'),
('��������� ���', 57, 60.99, 'Bantamweight'),
('������������ ���', 50, 56.99, 'Flyweight')
GO

INSERT INTO �������� VALUES
(1, 5, 'RFC 233: ����������� vs ������', '������� ���', '�', 12)
GO
INSERT INTO �������� VALUES
(1, 15, 'RFC 231', '������� ���', '�', 13)
GO
INSERT INTO �������� VALUES
(1, 10, 'RFC 236', '������� ���', '�', 12)
GO
INSERT INTO �������� VALUES
(4, 19, 'RFC 231', '���������� ���', '�', 12)
GO
INSERT INTO �������� VALUES
(10, 11, 'RFC 229', '������� ���', '�', 10)
GO
INSERT INTO �������� VALUES
(12, 13, 'RFC 229', '������� ���', '�', 11)
GO
INSERT INTO �������� VALUES
(1, 8, 'RFC 229', '������� ���', '�', 12)
GO
INSERT INTO �������� VALUES
(7, 12, 'RFC 231', '������� ���', '�', 14)
GO
INSERT INTO �������� VALUES
(16, 18, 'RFC 236', '������������ ���', '�', 11)
GO
INSERT INTO �������� VALUES
(17, 18, 'RFC 233: ����������� vs ������', '������������ ���', '�', 11)
GO
INSERT INTO �������� VALUES
(3, 6, 'RFC 233: ����������� vs ������', '������� ���', '�', 10)
GO
INSERT INTO �������� VALUES
(3, 2, 'RFC 232', '������� ���', '�', 15)
GO
INSERT INTO �������� VALUES
(16, 17, 'RFC 232', '������������ ���', '�', 13)
GO
INSERT INTO �������� VALUES
(14, 8, 'RFC 232', '������� ���', '�', 14)
GO
INSERT INTO �������� VALUES
(7, 13, 'RFC 228', '������� ���', '�', 12)
GO
INSERT INTO �������� VALUES
(5, 15, 'RFC 228', '������� ���', '�', 10)
GO
INSERT INTO �������� VALUES
(4, 19, 'RFC 228', '���������� ���', '�', 11)
GO
INSERT INTO �������� VALUES
(17, 16, 'RFC 237', '������������ ���', '�', 10)
GO
INSERT INTO �������� VALUES
(3, 11, 'RFC 237', '������� ���', '�', 11)
GO
INSERT INTO �������� VALUES
(10, 2, 'RFC 237', '������� ���', '�', 12)
GO

INSERT INTO ������ VALUES
('������ ���� ��������', '1.01.1970', DEFAULT, '6114 228221', '+79109032801', 'ref1@yandex.ru', '������, ������, ��. �������, �. 221, ��. 1', '1.01.2018')
GO
INSERT INTO ������ VALUES
('������� ���� ��������', '2.01.1970', DEFAULT, '6114 228222', '+79109032802', 'ref2@yandex.ru', '������, ������, ��. �������, �. 222, ��. 1', '2.01.2018')
GO
INSERT INTO ������ VALUES
('������ ���� ��������', '3.01.1970', DEFAULT, '6114 228223', '+79109032803', 'ref3@yandex.ru', '������, ������, ��. �������, �. 223, ��. 1', '3.01.2018')
GO
INSERT INTO ������ VALUES
('������ ���� ��������', '4.01.1970', DEFAULT, '6114 228224', '+79109032804', 'ref4@yandex.ru', '������, ������, ��. �������, �. 224, ��. 1', '4.01.2018')
GO
INSERT INTO ������ VALUES
('������� ���� ��������', '5.01.1970', DEFAULT, '6114 228225', '+79109032805', 'ref5@yandex.ru', '������, ������, ��. �������, �. 225, ��. 1', '5.01.2018')
GO
INSERT INTO ������ VALUES
('������ ���� ��������', '6.01.1970', DEFAULT, '6114 228226', '+79109032806', 'ref6@yandex.ru', '������, ������, ��. �������, �. 226, ��. 1', '4.01.2018')
GO
INSERT INTO ������ VALUES
('������ ����� ��������', '7.01.1970', DEFAULT, '6114 228227', '+79109032807', 'ref7@yandex.ru', '������, ������, ��. �������, �. 227, ��. 1', '3.01.2018')
GO
INSERT INTO ������ VALUES
('������� ����� ��������', '8.01.1970', DEFAULT, '6114 228228', '+79109032808', 'ref8@yandex.ru', '������, ������, ��. �������, �. 228, ��. 1', '2.01.2018')
GO
INSERT INTO ������ VALUES
('������ ����� ��������', '8.01.1970', DEFAULT, '6114 228229', '+79109032809', 'ref9@yandex.ru', '������, ������, ��. �������, �. 229, ��. 1', '1.01.2018')
GO
INSERT INTO ������ VALUES
('���� ���', '30.09.1970', '���', 'USA82551206D3', '+1(916)7563290', 'herb@gmail.com', '���, ����������, ��������, ������ ��., 54', '19.09.2021')
GO

INSERT INTO ������������������� VALUES
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

INSERT INTO ��������� VALUES
('������', '���� �� ����� ���������� �������� ���������� ����������� ������������ �����'),
('����������� ������', '������ ������������� �������� ���������� ������������� ������ �� ������ ���������� ���'),
('����������� ������ (��������� ������)', '���� ���������, ��� ���������� ����������� �������� ������ ��� ����� ��� �������� ������ �� ������'),
('����������� ������ (��������� �����)', '������� ��������� ����� ������������� �� ��������� ���'),
('�����', '������������ ����� ����� ���������� ��������'),
('����������� �����', '������ ������������� �������� ���������� ���������� �������� ��� ���������� ������'),
('����� (�������� �����)', '��������� ����� �����'),
('����� (���������)', '��������� ����� "���������"'),
('����� (�����������)', '��������� ����� "�����������"'),
('����� (������ �����������)', '��������� ����� "������ �����������"'),
('����� (������)', '������� ����� "������"'),
('����� (����� �����)', '������� ����� "����� �����"'),
('����� (����� ����� � ������������)', '��������-������� ����� "����� ����� � ������������"'),
('����� (���������)', '������� ����� "���������"'),
('����� (��������)', '��������� ����� "��������"'),
('����� (�����-��)', '��������� ����� "�����-��"'),
('����� (����� ���)', '������� ����� "����� ���"'),
('����� (��������� ���������)', '��������-������� ����� "��������� ���������"'),
('����� (�������� �����)', '��������� ����� "�����"'),
('����� (�������� ���������)', '��������� ����� "���������"'),
('����� (����� ������)', '������� ����� "����� ������"'),
('����� (����������� �����)', '������� ����� "����������� �����"'),
('������������ �������', '��� ��� ����� ������ ������������ ����� �'),
('���������� �������', '���� ����� ���������� ������ ����� �, ���� ����� ���������� ������ ����� �'),
('������� �����������', '���� ����� ���������� ������ ����� �, ���� ����� ���������� �����'),
('������������ �����', '���� ����� ���������� �����'),
('���������� �����', '���� ����� ���������� ������ ����� �, ���� ����� ���������� ������ ����� �, ���� ����� ���������� �����'),
('����� �������� �����������', '���� ����� ���������� �����, ���� � ������'),
('����������� �������', '����� ������� ������� ��� �������, ��� ��� ����� �� ����� ���������� ���'),
('����������� �����', '����� ���������� ����� ��� �������, ��� ��� ����� �� ����� ���������� ���'),
('���������������', '������ ������������ ����� � ����� ��������� ������ ������ �'),
('��� ����������', '��������� �������� ���������� ����� �������������� �������������')
GO

INSERT INTO ������������������� VALUES
(1, '����������� ������', 0, 4, '00:04:37')
GO
INSERT INTO ������������������� VALUES
(2, '����������� ������', 0, 3, '00:02:21')
GO
INSERT INTO ������������������� VALUES
(4, '���������������', 1, 1, '00:01:28')
GO
INSERT INTO ������������������� VALUES
(5, '���������� �������', 1, DEFAULT, DEFAULT)
GO
INSERT INTO ������������������� VALUES
(6, '����� (�������� �����)', 1, 2, '00:03:59')
GO
INSERT INTO ������������������� VALUES
(7, '������������ �������', 0, 5, DEFAULT)
GO
INSERT INTO ������������������� VALUES
(8, '���������� �����', NULL, DEFAULT, DEFAULT)
GO
INSERT INTO ������������������� VALUES
(10, '����� (������)', 0, 1, '00:02:29')
GO
INSERT INTO ������������������� VALUES
(11, '������� �����������', 1, DEFAULT, DEFAULT)
GO
INSERT INTO ������������������� VALUES
(12, '������', 0, 1, '00:00:14')
GO
INSERT INTO ������������������� VALUES
(13, '�����', 0, 2, '00:04:49')
GO
INSERT INTO ������������������� VALUES
(14, '����� (��������)', 0, 3, '00:02:13')
GO
INSERT INTO ������������������� VALUES
(15, '����������� ������', 0, 3, '00:03:48')
GO
INSERT INTO ������������������� VALUES
(16, '����������� ������', 1, 2, '00:01:21')
GO

INSERT INTO ������� VALUES
('������ ��� ������', 300000, '������� ������������ ����� ���������� ��������, ����������� ������ ���� �������'),
('����������� ������', 200000, '������� ������������ ����� �� �������� ��������� ������ � ��������')
GO

INSERT INTO ����������� VALUES
(6, '������ ��� ������', NULL),
(1, '������ ��� ������', NULL),
(8, '������ ��� ������', NULL),
(14, '������ ��� ������', NULL),
(15, '������ ��� ������', NULL),
(10, '����������� ������', 0),
(2, '����������� ������', 0),
(5, '����������� ������', 1),
(7, '����������� ������', 0),
(16, '����������� ������', 1)
GO

INSERT INTO ����� VALUES
('������� ���� ��������', '01.01.1980', DEFAULT, '6113 567900', '+7(910)9023401', 'male01@gmail.com', '������, ������, ��. ���������, �. 11, ��. 99', '09.07.2022')
GO
INSERT INTO ����� VALUES
('������� ���� ��������', '01.01.1981', DEFAULT, '6113 567911', '+7(910)9023402', 'male02@gmail.com', '������, ������, ��. ���������, �. 12, ��. 99', '09.07.2022')
GO
INSERT INTO ����� VALUES
('������� ������� �������������', '01.01.1982', DEFAULT, '6113 567922', '+7(910)9023403', 'male03@gmail.com', '������, ������, ��. ���������, �. 13, ��. 99', '09.07.2022')
GO
INSERT INTO ����� VALUES
('������� ��������� ����������', '01.01.1983', DEFAULT, '6113 567933', '+7(910)9023404', 'male04@gmail.com', '������, ������, ��. ���������, �. 14, ��. 99', '09.07.2022')
GO
INSERT INTO ����� VALUES
('�������� ��������� ����������', '01.01.1984', DEFAULT, '6113 567944', '+7(910)9023405', 'male05@gmail.com', '������, ������, ��. ���������, �. 15, ��. 99', '09.07.2022')
GO
INSERT INTO ����� VALUES
('�������� ������� �������������', '01.01.1985', DEFAULT, '6113 567955', '+7(910)9023406', 'male06@gmail.com', '������, ������, ��. ���������, �. 16, ��. 99', '09.07.2022')
GO
INSERT INTO ����� VALUES
('����������� ���� ��������', '01.01.1986', DEFAULT, '6113 567966', '+7(910)9023407', 'male07@gmail.com', '������, ������, ��. ���������, �. 17, ��. 99', '09.07.2022')
GO
INSERT INTO ����� VALUES
('����������� ���� ��������', '01.01.1987', DEFAULT, '6113 567977', '+7(910)9023408', 'male08@gmail.com', '������, ������, ��. ���������, �. 18, ��. 99', '09.07.2022')
GO
INSERT INTO ����� VALUES
('��������� ������� ����������', '01.01.1988', DEFAULT, '6113 567988', '+7(910)9023409', 'male09@gmail.com', '������, ������, ��. ���������, �. 19, ��. 99', '09.07.2022')
GO
INSERT INTO ����� VALUES
('����� ����', '1.01.1979', '���', 'USA82555246D3', '+1(916)4351245', 'bellmma@gmail.com', '���, ����������, ����������, 40-� ��., 41', '22.02.2022')
GO

INSERT INTO ��������� VALUES
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


/*�������������*/


--������� �������� �����������
CREATE VIEW V_Champs
AS
	WITH ����������� AS (
		SELECT [������� ���������], MAX(����) AS ����
			FROM �������� JOIN ������ ON ��������.������ = ������.��������
				LEFT JOIN ������������������� ON ��������.����� = �������������������.��������
			WHERE ���� <= GETDATE() AND [������ ��������] = '�'
				AND ���������� IS NOT NULL
			GROUP BY [������� ���������])
	SELECT A.[��� ��������], ����.��� AS �������,
		A.[������� ���������], A.[���� ����������/��������� ������] FROM
	(SELECT (CASE WHEN (SELECT ���������� FROM �������������������
		WHERE �������� = �����) = 0 THEN [���� 1] 
			WHEN (SELECT ���������� FROM �������������������
			WHERE �������� = �����) = 1 THEN [���� 2] ELSE NULL END) AS [��� ��������],
		[������� ���������], ���� AS [���� ����������/��������� ������] 
		FROM �������� JOIN ������ ON ��������.������ = ������.��������
			LEFT JOIN ������������������� ON ��������.����� = �������������������.��������
		WHERE ���� = (SELECT ���� FROM ����������� 
			WHERE �����������.[������� ���������] = ��������.[������� ���������])
			AND [������ ��������] = '�') AS A
			JOIN ���� ON A.[��� ��������] = ����.���
GO

--�������� ���������
CREATE VIEW V_Contracts
AS
	SELECT �����, ���� AS [��� �����], ���, ����, [���������� ���������] AS ��������,
		[������� �� ����������� (���)] AS [������� (���)], [����������� �������� (���)] AS [�������� (���)], 
		[����������� ����������� (���)] AS [����������� (���)], ([������� �� ����������� (���)] * 
			[���������� ���������] +  DATEDIFF(MONTH, [���� ���������� ��������], [���� ��������� ��������]) *
			[����������� �������� (���)] * (SELECT [����������� ���������� ��������] FROM ���� 
			WHERE ���� = ����.����)) AS [����������� ������� (���)],
		[���� ���������� ��������], [���� ��������� ��������]
		FROM �������� JOIN ���� 
			ON ��������.���� = ����.���
		WHERE [���� ���������� ��������] <= GETDATE()
			AND [���� ��������� ��������] >= GETDATE()
GO

--�������
CREATE VIEW V_Awards
AS
	SELECT �������� AS [��� ��������], (SELECT ��� FROM ���� WHERE ��� = [���� 1])
		AS [���� 1], (SELECT ��� FROM ���� WHERE ��� = [���� 2]) AS [���� 2], 
		������, (SELECT ���� FROM ������ WHERE �������� = ������) AS ����,
		�������.������� AS �������, (CASE WHEN [������������ ����] = 0 THEN 
		(SELECT ��� FROM ���� WHERE ��� = [���� 1])	WHEN [������������ ����] = 1 THEN 
		(SELECT ��� FROM ���� WHERE ��� = [���� 2]) ELSE NULL END) AS [������������ ����],
			[�������� ����� (���)]
		FROM ����������� JOIN ������� ON �����������.������� = �������.�������
			JOIN �������� ON �����������.�������� = ��������.�����
GO


/*�������� ���������*/


--����� ���������� � ������
CREATE PROC FightersInfo
AS
	SELECT ���, ���, [���� ��������], ������, �����������, ����,
		(SELECT MIN([���� ���������� ��������]) FROM ��������
			WHERE ���� = ���) AS [���� ���������� � �����������],
		(SELECT MAX([���� ��������� ��������]) FROM ��������
			WHERE [���� ���������� ��������] < GETDATE()
			AND ���� = ���) AS [���� ��������� ���������],
		�������, [����������� �����], [���������� ������], �����,
		(SELECT COUNT(*) FROM �������� JOIN �������������������
			ON ��������.����� = �������������������.��������
			WHERE ([���� 1] = ��� AND ���������� = 0) OR
				([���� 2] = ��� AND ���������� = 1)) AS �����,
		(SELECT COUNT(*) FROM �������� JOIN �������������������
			ON ��������.����� = �������������������.��������
			WHERE ([���� 1] = ��� AND ���������� = 1) OR
				([���� 2] = ��� AND ���������� = 0)) AS ���������,
		[��� (��)], [���� (��)], [������ ��� (��)]
		FROM ����
GO

--������� ���������� � �����
CREATE PROC FightersInsert (@seniority tinyint,	@fio varchar(50), 
	@bdate varchar(100), @country varchar(30),	@weight float, 
	@height float, @reach float, @citizen varchar(30), @pass varchar(20),
	@phone varchar(30), @email varchar(100), @address varchar(MAX))
	AS
		INSERT INTO ���� VALUES
		(@seniority, @fio, @bdate, @country, @weight, @height, @reach,
		@citizen, @pass, @phone, @email, @address)
GO

--���������� ���������� � �����
CREATE PROC FightersUpdate (@code int, @seniority tinyint,	@fio varchar(50), 
	@bdate varchar(100), @country varchar(30),	@weight float, 
	@height float, @reach float, @citizen varchar(30), @pass varchar(20),
	@phone varchar(30), @email varchar(100), @address varchar(MAX))
	AS
		UPDATE ����
		SET ���� = @seniority, ��� = @fio, [���� ��������] = @bdate, 
			������ = @country, [��� (��)] = @weight, [���� (��)] = @height, 
			[������ ��� (��)] = @reach, ����������� = @citizen, 
			[���������� ������] = @pass, ������� = @phone,
			[����������� �����] = @email, ����� = @address
			WHERE ��� = @code
GO

--�������� ���������� � �����
CREATE PROC FightersDelete (@code int)
AS
	DELETE FROM ����
		WHERE ��� = @code
GO

--��������
CREATE PROC FightsInfo
AS
	SELECT �����, (SELECT ��� FROM ���� WHERE ��� = [���� 1]) AS [���� 1], 
		(SELECT ��� FROM ���� WHERE ��� = [���� 2]) AS [���� 2], ������, 
		(SELECT ���� FROM ������ WHERE �������� = ������) AS ����, [������� ���������],
		(SELECT ��� FROM ���� WHERE ��� = (CASE WHEN (SELECT ���������� FROM �������������������
		WHERE �������� = �����) = 0 THEN [���� 1] WHEN (SELECT ���������� FROM �������������������
		WHERE �������� = �����) = 1 THEN [���� 2] ELSE NULL END)) AS ����������,
		���������, �����, �����, [������ ��������], [����� � �������]
		FROM �������� LEFT JOIN ������������������� ON
			��������.����� = �������������������.��������
GO
CREATE PROC FightsInsert (@fio1 varchar(50), @fio2 varchar(50), @event varchar(60),
@weight varchar(20), @winner bit, @result varchar(50), @round tinyint,
@time time, @status char(1), @number tinyint)
AS
	INSERT INTO �������� VALUES
	((SELECT ��� FROM ���� WHERE ��� = @fio1), (SELECT ��� FROM ���� WHERE ��� = @fio2),
	@event, @weight, @status, @number)
	DECLARE @code int = (SELECT ����� FROM �������� WHERE [���� 1] = (SELECT ���
		FROM ���� WHERE ��� = @fio1) AND ������ = @event)
	IF @result IS NOT NULL AND @round IS NOT NULL AND @time IS NOT NULL
		INSERT INTO ������������������� VALUES
		(@code, @result, @winner, @round, @time)
GO
CREATE PROC FightsUpdate (@code int, @fio1 varchar(50), @fio2 varchar(50), @event varchar(60),
@weight varchar(20), @winner bit, @result varchar(50), @round tinyint,
@time time, @status char(1), @number tinyint)
AS
	IF @round > 3 
		SET @status = '�'
	UPDATE ��������
		SET [���� 1] = (SELECT ��� FROM ���� WHERE ��� = @fio1), 
		[���� 2] = (SELECT ��� FROM ���� WHERE ��� = @fio2),
		������ = @event, [������� ���������] = @weight, [������ ��������] = @status,
		[����� � �������] = @number
		WHERE ����� = @code
	IF @result IS NOT NULL AND @round IS NOT NULL AND @time IS NOT NULL BEGIN
		IF EXISTS(SELECT * FROM �������������������
			WHERE �������� = @code) BEGIN
			UPDATE �������������������
				SET ��������� = @result, ���������� = @winner, 
					����� = @round, ����� = @time
				WHERE �������� = @code
			END
		ELSE
			INSERT INTO ������������������� VALUES
			(@code, @result, @winner, @round, @time)
	END
GO
CREATE PROC FightsDelete (@code int)
AS
	DELETE FROM �������������������
		WHERE �������� = @code
	DELETE FROM ��������
		WHERE ����� = @code
GO

--������
CREATE PROC EventsInfo
AS
	SELECT ��������, [����� ����������], ����, [��������� ������������ (���)],
		(SELECT SUM([������� �������]) FROM ��������������
		WHERE ������ = ��������) AS [������� �������], [����� ������� (���)], 
		(SELECT SUM([������� �������] * [��������� (���)]) FROM ��������������
		WHERE ������ = ��������) AS [�������� ����� (���)], [������� �� ����������� (���)],
		([����� ������� (���)] - [������� �� ����������� (���)]) AS ���������
		FROM ������
GO
CREATE PROC EventsInsert (@name varchar(60), @place varchar(30), @date date, 
	@attend int, @revenue money, @costs money)
AS
	INSERT INTO ������ VALUES
	(@name, @place, @date, @attend, @revenue, @costs)
GO
CREATE PROC EventsUpdate (@name varchar(60), @place varchar(30), @date date, 
	@attend int, @revenue money, @costs money)
AS
	UPDATE ������
		SET [����� ����������] = @place, ���� = @date, 
			[��������� ������������ (���)] = @attend, 
			[����� ������� (���)] = @revenue, 
			[������� �� ����������� (���)] = @costs
		WHERE �������� = @name
GO
CREATE PROC EventsDelete (@name varchar(60))
AS
	DELETE FROM ������
		WHERE �������� = @name
GO