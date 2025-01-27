USE [master]
GO
/****** Object:  Database [TestMVC]    Script Date: 13-Nov-19 12:45:02 PM ******/
CREATE DATABASE [TestMVC]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestMVC', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\TestMVC.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TestMVC_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\TestMVC_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TestMVC] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestMVC].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestMVC] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestMVC] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestMVC] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestMVC] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestMVC] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestMVC] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestMVC] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestMVC] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestMVC] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestMVC] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestMVC] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestMVC] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestMVC] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestMVC] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestMVC] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestMVC] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestMVC] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestMVC] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestMVC] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestMVC] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestMVC] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestMVC] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestMVC] SET RECOVERY FULL 
GO
ALTER DATABASE [TestMVC] SET  MULTI_USER 
GO
ALTER DATABASE [TestMVC] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestMVC] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestMVC] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestMVC] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [TestMVC] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'TestMVC', N'ON'
GO
USE [TestMVC]
GO
/****** Object:  Table [dbo].[product]    Script Date: 13-Nov-19 12:45:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[product](
	[pid] [int] NOT NULL,
	[pname] [varchar](30) NULL,
	[pprice] [decimal](5, 0) NULL,
	[pimage] [varchar](30) NULL,
	[pisdemand] [bit] NULL,
	[pcname] [varchar](30) NULL,
	[psupply] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[product_category]    Script Date: 13-Nov-19 12:45:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[product_category](
	[pcid] [int] NOT NULL,
	[pcname] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[pcid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[product] ([pid], [pname], [pprice], [pimage], [pisdemand], [pcname], [psupply]) VALUES (12, N'Britania', CAST(45 AS Decimal(5, 0)), N'jords.jpg', 1, N'Food', N'Surat,Ahemdabad')
INSERT [dbo].[product] ([pid], [pname], [pprice], [pimage], [pisdemand], [pcname], [psupply]) VALUES (13, N'Ball', CAST(2002 AS Decimal(5, 0)), N'la.jpg', 1, N'Sports', N'Surat')
INSERT [dbo].[product] ([pid], [pname], [pprice], [pimage], [pisdemand], [pcname], [psupply]) VALUES (15, N'bat', CAST(2300 AS Decimal(5, 0)), N'jords.jpg', 1, N'Sports', N'Surat,Ahemdabad')
INSERT [dbo].[product] ([pid], [pname], [pprice], [pimage], [pisdemand], [pcname], [psupply]) VALUES (16, N'Laptop', CAST(30000 AS Decimal(5, 0)), N'chicago.jpg', 1, N'Electronics', N'Surat,Ahemdabad')
INSERT [dbo].[product_category] ([pcid], [pcname]) VALUES (1, N'Electronics')
INSERT [dbo].[product_category] ([pcid], [pcname]) VALUES (2, N'Food')
INSERT [dbo].[product_category] ([pcid], [pcname]) VALUES (3, N'Sports')
/****** Object:  StoredProcedure [dbo].[InUPProduct]    Script Date: 13-Nov-19 12:45:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[InUPProduct]
	@pid        int,
	@pname      varchar(150),
	@pprice     decimal(6)
	AS
BEGIN


    if exists (Select 1 from product where pid=@pid)
    begin
		update product set pname=@pname,pprice=@pprice where pid=@pid
    End
    Else
    Begin
		       --declare the variable with it's datatype
		set @pid= (select (isnull(MAX(pid),0) +1) from product)  -- set value in variable
		insert into product(pid,pname,pprice)values(@pid,@pname,@pprice)  --fire insert query
End


End
GO
/****** Object:  StoredProcedure [dbo].[InUPProductMain]    Script Date: 13-Nov-19 12:45:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [dbo].[InUPProductMain]
	@pid        int,
	@pname      varchar(150),
	@pprice     decimal(6),
	@pimage varchar(30),
	@pcname varchar(30),
	@pisdemand bit,
	@psupply varchar(50)
	AS
BEGIN


    if exists (Select 1 from product where pid=@pid)
    begin
		update product set pname=@pname,pprice=@pprice,pimage=@pimage,pcname=@pcname,pisdemand=@pisdemand,psupply=@psupply where pid=@pid
    End
    Else
    Begin
		       --declare the variable with it's datatype
		set @pid= (select (isnull(MAX(pid),0) +1) from product)  -- set value in variable
		insert into product(pid,pname,pprice,pimage,pcname,pisdemand,psupply)values(@pid,@pname,@pprice,@pimage,@pcname,@pisdemand,@psupply)  --fire insert query
End


End
GO
USE [master]
GO
ALTER DATABASE [TestMVC] SET  READ_WRITE 
GO
