USE [master]
GO
/****** Object:  Database [Country]    Script Date: 7/12/2016 5:40:35 PM ******/
CREATE DATABASE [Country]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Country', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.TSQL\MSSQL\DATA\Country.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Country_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.TSQL\MSSQL\DATA\Country_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Country] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Country].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Country] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Country] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Country] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Country] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Country] SET ARITHABORT OFF 
GO
ALTER DATABASE [Country] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Country] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Country] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Country] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Country] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Country] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Country] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Country] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Country] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Country] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Country] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Country] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Country] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Country] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Country] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Country] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Country] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Country] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Country] SET  MULTI_USER 
GO
ALTER DATABASE [Country] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Country] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Country] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Country] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Country] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Country]
GO
/****** Object:  Table [dbo].[Adresa]    Script Date: 7/12/2016 5:40:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Adresa](
	[ID] [int] NOT NULL,
	[Strada] [nvarchar](30) NOT NULL,
	[Numar] [int] NOT NULL,
	[LocalitateID] [int] NOT NULL,
 CONSTRAINT [PK_Adresa] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Judet]    Script Date: 7/12/2016 5:40:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Judet](
	[ID] [int] NOT NULL,
	[Denumire] [nvarchar](25) NOT NULL,
	[Cod] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Judet] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Localitate]    Script Date: 7/12/2016 5:40:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Localitate](
	[ID] [int] NOT NULL,
	[Denumire] [nvarchar](25) NOT NULL,
	[JudetID] [int] NOT NULL,
 CONSTRAINT [PK_Localitate] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Persoana]    Script Date: 7/12/2016 5:40:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Persoana](
	[ID] [int] NOT NULL,
	[Nume] [nvarchar](50) NOT NULL,
	[Prenume] [nvarchar](50) NOT NULL,
	[CNP] [int] NOT NULL,
 CONSTRAINT [PK_Persoana] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TipAdresa]    Script Date: 7/12/2016 5:40:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipAdresa](
	[PersoanaID] [int] NOT NULL,
	[AdresaID] [int] NOT NULL,
	[TipAdresa] [int] NOT NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Adresa]  WITH CHECK ADD  CONSTRAINT [FK_Adresa_Localitate] FOREIGN KEY([LocalitateID])
REFERENCES [dbo].[Localitate] ([ID])
GO
ALTER TABLE [dbo].[Adresa] CHECK CONSTRAINT [FK_Adresa_Localitate]
GO
ALTER TABLE [dbo].[Localitate]  WITH CHECK ADD  CONSTRAINT [FK_Localitate_Judet] FOREIGN KEY([JudetID])
REFERENCES [dbo].[Judet] ([ID])
GO
ALTER TABLE [dbo].[Localitate] CHECK CONSTRAINT [FK_Localitate_Judet]
GO
ALTER TABLE [dbo].[TipAdresa]  WITH CHECK ADD  CONSTRAINT [FK_TipAdresa_Adresa] FOREIGN KEY([AdresaID])
REFERENCES [dbo].[Adresa] ([ID])
GO
ALTER TABLE [dbo].[TipAdresa] CHECK CONSTRAINT [FK_TipAdresa_Adresa]
GO
ALTER TABLE [dbo].[TipAdresa]  WITH CHECK ADD  CONSTRAINT [FK_TipAdresa_Persoana] FOREIGN KEY([PersoanaID])
REFERENCES [dbo].[Persoana] ([ID])
GO
ALTER TABLE [dbo].[TipAdresa] CHECK CONSTRAINT [FK_TipAdresa_Persoana]
GO
USE [master]
GO
ALTER DATABASE [Country] SET  READ_WRITE 
GO
