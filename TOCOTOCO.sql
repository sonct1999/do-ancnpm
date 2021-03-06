USE [master]
GO
/****** Object:  Database [QuanLyNhaHang]    Script Date: 1/20/2021 2:38:19 AM ******/
CREATE DATABASE [QuanLyNhaHang]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyNhaHang', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\QuanLyNhaHang.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuanLyNhaHang_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\QuanLyNhaHang_log.ldf' , SIZE = 1088KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuanLyNhaHang] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyNhaHang].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyNhaHang] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyNhaHang] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyNhaHang] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyNhaHang] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyNhaHang] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyNhaHang] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyNhaHang] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyNhaHang] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyNhaHang] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyNhaHang] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyNhaHang] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QuanLyNhaHang] SET DELAYED_DURABILITY = DISABLED 
GO
USE [QuanLyNhaHang]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 1/20/2021 2:38:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END



GO
/****** Object:  Table [dbo].[Account]    Script Date: 1/20/2021 2:38:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL DEFAULT (N'Nhân Viên'),
	[PASSWORD] [nvarchar](100) NOT NULL DEFAULT ((0)),
	[TYPE] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Bill]    Script Date: 1/20/2021 2:38:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DataCheckIn] [date] NOT NULL DEFAULT (getdate()),
	[DataCheckOut] [date] NULL,
	[idTable] [int] NOT NULL,
	[STATUS] [int] NOT NULL,
	[discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 1/20/2021 2:38:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[COUNT] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Food]    Script Date: 1/20/2021 2:38:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](100) NOT NULL DEFAULT (N'Chưa Đặt Tên'),
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 1/20/2021 2:38:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](100) NOT NULL DEFAULT (N'Chưa Đặt Tên'),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 1/20/2021 2:38:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL DEFAULT (N'Chưa Đặt Tên'),
	[status] [nvarchar](100) NOT NULL DEFAULT (N'Trống'),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Account] ([UserName], [DisplayName], [PASSWORD], [TYPE]) VALUES (N'admin', N'Admin', N'1', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PASSWORD], [TYPE]) VALUES (N'minhan', N'Trần Thiện Minh Ân', N'0', 0)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PASSWORD], [TYPE]) VALUES (N'nguyenvanchien', N'Chien', N'200400', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PASSWORD], [TYPE]) VALUES (N'phanminhcuong', N'Minh Cường', N'1', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PASSWORD], [TYPE]) VALUES (N'staff', N'Staff', N'1', 0)
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([id], [DataCheckIn], [DataCheckOut], [idTable], [STATUS], [discount], [totalPrice]) VALUES (1, CAST(N'2021-01-19' AS Date), NULL, 1, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DataCheckIn], [DataCheckOut], [idTable], [STATUS], [discount], [totalPrice]) VALUES (2, CAST(N'2021-01-19' AS Date), NULL, 2, 0, 0, NULL)
INSERT [dbo].[Bill] ([id], [DataCheckIn], [DataCheckOut], [idTable], [STATUS], [discount], [totalPrice]) VALUES (3, CAST(N'2021-01-19' AS Date), CAST(N'2021-01-19' AS Date), 3, 1, 0, NULL)
INSERT [dbo].[Bill] ([id], [DataCheckIn], [DataCheckOut], [idTable], [STATUS], [discount], [totalPrice]) VALUES (4, CAST(N'2021-01-19' AS Date), CAST(N'2021-01-19' AS Date), 6, 1, 15, 165750)
INSERT [dbo].[Bill] ([id], [DataCheckIn], [DataCheckOut], [idTable], [STATUS], [discount], [totalPrice]) VALUES (5, CAST(N'2021-01-19' AS Date), CAST(N'2021-01-19' AS Date), 7, 1, 0, 195000)
INSERT [dbo].[Bill] ([id], [DataCheckIn], [DataCheckOut], [idTable], [STATUS], [discount], [totalPrice]) VALUES (6, CAST(N'2021-01-19' AS Date), CAST(N'2021-01-19' AS Date), 3, 1, 15, 331500)
INSERT [dbo].[Bill] ([id], [DataCheckIn], [DataCheckOut], [idTable], [STATUS], [discount], [totalPrice]) VALUES (7, CAST(N'2021-01-19' AS Date), CAST(N'2021-01-19' AS Date), 8, 1, 0, 75000)
INSERT [dbo].[Bill] ([id], [DataCheckIn], [DataCheckOut], [idTable], [STATUS], [discount], [totalPrice]) VALUES (8, CAST(N'2021-01-19' AS Date), CAST(N'2021-01-19' AS Date), 7, 1, 0, 10000)
INSERT [dbo].[Bill] ([id], [DataCheckIn], [DataCheckOut], [idTable], [STATUS], [discount], [totalPrice]) VALUES (9, CAST(N'2021-01-19' AS Date), CAST(N'2021-01-19' AS Date), 8, 1, 0, 350000)
INSERT [dbo].[Bill] ([id], [DataCheckIn], [DataCheckOut], [idTable], [STATUS], [discount], [totalPrice]) VALUES (10, CAST(N'2021-01-19' AS Date), CAST(N'2021-01-19' AS Date), 5, 1, 0, 600000)
INSERT [dbo].[Bill] ([id], [DataCheckIn], [DataCheckOut], [idTable], [STATUS], [discount], [totalPrice]) VALUES (11, CAST(N'2021-01-19' AS Date), CAST(N'2021-01-19' AS Date), 5, 1, 0, 75000)
INSERT [dbo].[Bill] ([id], [DataCheckIn], [DataCheckOut], [idTable], [STATUS], [discount], [totalPrice]) VALUES (12, CAST(N'2021-01-19' AS Date), CAST(N'2021-01-19' AS Date), 8, 1, 10, 643500)
INSERT [dbo].[Bill] ([id], [DataCheckIn], [DataCheckOut], [idTable], [STATUS], [discount], [totalPrice]) VALUES (13, CAST(N'2021-01-20' AS Date), CAST(N'2021-01-20' AS Date), 4, 1, 0, 75000)
SET IDENTITY_INSERT [dbo].[Bill] OFF
SET IDENTITY_INSERT [dbo].[BillInfo] ON 

INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [COUNT]) VALUES (1, 1, 15, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [COUNT]) VALUES (2, 2, 19, 5)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [COUNT]) VALUES (3, 3, 10, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [COUNT]) VALUES (4, 1, 3, 4)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [COUNT]) VALUES (5, 4, 6, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [COUNT]) VALUES (6, 5, 6, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [COUNT]) VALUES (7, 6, 10, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [COUNT]) VALUES (8, 7, 1, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [COUNT]) VALUES (9, 8, 16, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [COUNT]) VALUES (10, 9, 11, 10)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [COUNT]) VALUES (11, 10, 1, 8)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [COUNT]) VALUES (12, 11, 1, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [COUNT]) VALUES (13, 12, 8, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [COUNT]) VALUES (14, 12, 11, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [COUNT]) VALUES (15, 12, 20, 10)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [COUNT]) VALUES (16, 13, 1, 1)
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (1, N'Ba chỉ Bò', 1, 75000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (2, N'Ba chỉ Heo', 1, 65000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (3, N'Tôm nướng', 1, 79000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (4, N'Sườn non nướng', 1, 65000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (5, N'Bạch tuộc nướng', 1, 69000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (6, N'Lẩu Thái', 2, 195000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (7, N'Lẩu Mắm', 2, 195000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (8, N'Lẩu Hải Sản / Thập Cẩm', 2, 165000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (9, N'Lẩu Vịt Chay Nấu Chao', 2, 165000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (10, N'Lẩu Cá Kèo', 2, 195000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (11, N'Hamberger', 3, 35000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (12, N'Hot Dog', 3, 25000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (13, N'Khoai Tây Chiên', 3, 20000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (14, N'Gà Rán', 3, 28000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (15, N'Bánh Tráng Trộn', 3, 15000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (16, N'Nước ngọt', 4, 10000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (17, N'Cà phê', 4, 15000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (18, N'Trà sữa', 4, 25000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (19, N'Sinh Tố', 4, 35000)
INSERT [dbo].[Food] ([id], [NAME], [idCategory], [price]) VALUES (20, N'Bia', 4, 15000)
SET IDENTITY_INSERT [dbo].[Food] OFF
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 

INSERT [dbo].[FoodCategory] ([id], [NAME]) VALUES (1, N'Món Nướng')
INSERT [dbo].[FoodCategory] ([id], [NAME]) VALUES (2, N'Lẩu')
INSERT [dbo].[FoodCategory] ([id], [NAME]) VALUES (3, N'Fast Food')
INSERT [dbo].[FoodCategory] ([id], [NAME]) VALUES (4, N'Nước uống')
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (1, N'Bàn 1', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (2, N'Bàn 2', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (3, N'Bàn 3', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (4, N'Bàn 4', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (5, N'Bàn 5', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (6, N'Bàn 6', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (7, N'Bàn 7', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (8, N'Bàn 8', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (9, N'Bàn 9', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (10, N'Bàn 10', N'Trống')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 1/20/2021 2:38:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_GetAccountByUserName]
@userName nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END


GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 1/20/2021 2:38:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetListBillByDate]
@checkIn date, @checkOut date
AS
BEGIN
	SELECT t.name AS [Tên bàn]  , b.totalPrice AS [Tổng tiền], b.DataCheckIn AS [Ngày vào], b.DataCheckOut  AS [Ngày rời], discount AS [Giảm giá (%)]
	FROM dbo.Bill AS b , dbo.TableFood AS t
	WHERE b.DataCheckIn >= @checkIn AND b.DataCheckOut <= @checkOut AND b.STATUS = 1 AND t.id = b.idTable
END


GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 1/20/2021 2:38:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetTableList]
AS SELECT * FROM dbo.TableFood


GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 1/20/2021 2:38:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[USP_InsertBillInfo]
@idBill INT, @idFood INT , @count INT
AS
BEGIN
	DECLARE @isExitsBillInfo INT
	DECLARE @foodCount Int = 1

	SELECT @isExitsBillInfo = id ,@foodCount= b.count
	FROM dbo.BillInfo AS b
	WHERE idBill = @idBill AND idFood= @idFood

	IF(@isExitsBillInfo > 0)
	BEGIN
		DECLARE @newCount INT = @foodCount + @count
		IF(@newCount >0)
	    UPDATE dbo.BillInfo SET count = @foodCount + @count WHERE idFood =@idFood
		ELSE
			DELETE dbo.BillInfo WHERE idBill= @idBill AND idFood = @idFood
	END
	ELSE
	BEGIN
			INSERT dbo.BillInfo
    (
        idBill,
        idFood,
        count
    )
    VALUES
    (   @idBill, -- idBill - int
        @idFood, -- idFood - int
        @count  -- COUNT - int
        )
	END
END


GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBilll]    Script Date: 1/20/2021 2:38:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[USP_InsertBilll]
@idTable INT
AS
BEGIN
	INSERT dbo.Bill
	(
	    DataCheckIn,
	    DataCheckOut,
	    idTable,
	    STATUS,
		discount
	)
	VALUES
	(   GETDATE(), -- DataCheckIn - date
	    NULL, -- DataCheckOut - date
	    @idTable,         -- idTable - int
	    0,          -- STATUS - int
		0
	    )
END


GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 1/20/2021 2:38:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_Login]
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
END


GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 1/20/2021 2:38:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[USP_UpdateAccount]
@userName NVARCHAR(100), @displayName NVARCHAR(100), @password NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
    
	DECLARE @isRightPass INT
	SELECT @isRightPass = COUNT(*) FROM dbo.Account WHERE @userName =UserName AND @password = PASSWORD
	IF(@isRightPass = 1)
	BEGIN
		IF(@newPassword = NULL OR @newPassword = '')
		BEGIN
			UPDATE dbo.Account SET DisplayName =@displayName WHERE UserName =@userName
		END
		ELSE
			UPDATE dbo.Account SET DisplayName =@displayName, PASSWORD = @newPassword WHERE UserName =@userName
	END
END

CREATE TRIGGER UTG_UpdateBillInfo
ON dbo.BillInfo FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @idBill INT
	
	SELECT @idBill = idBill FROM Inserted
	
	DECLARE @idTable INT
	
	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill AND status = 0	
	
	DECLARE @count INT
	SELECT @count = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idBill
	
	IF (@count > 0)
	BEGIN
	
		PRINT @idTable
		PRINT @idBill
		PRINT @count
		
		UPDATE dbo.TableFood SET status = N'Có khách' WHERE id = @idTable		
		
	END		
	ELSE
	BEGIN
	PRINT @idTable
		PRINT @idBill
		PRINT @count
	UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable	
	end
	
END
GO


CREATE TRIGGER UTG_UpdateBill
ON dbo.Bill FOR UPDATE
AS
BEGIN
	DECLARE @idBill INT
	
	SELECT @idBill = id FROM Inserted	
	
	DECLARE @idTable INT
	
	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill
	
	DECLARE @count int = 0
	
	SELECT @count = COUNT(*) FROM dbo.Bill WHERE idTable = @idTable AND status = 0
	
	IF (@count = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable
END
GO

GO
USE [master]
GO
ALTER DATABASE [QuanLyNhaHang] SET  READ_WRITE 
GO
