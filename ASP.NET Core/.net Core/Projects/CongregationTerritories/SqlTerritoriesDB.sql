USE [master]
GO
/****** Object:  Database [SqlTerritoriesDB]    Script Date: 6/29/2020 12:06:57 AM ******/
CREATE DATABASE [SqlTerritoriesDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SqlTerritoriesDB', FILENAME = N'C:\Users\Brian Wiggins\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\SqlTerritoriesDB_Primary.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SqlTerritoriesDB_log', FILENAME = N'C:\Users\Brian Wiggins\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\SqlTerritoriesDB_Primary.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [SqlTerritoriesDB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SqlTerritoriesDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SqlTerritoriesDB] SET ANSI_NULL_DEFAULT ON 
GO
ALTER DATABASE [SqlTerritoriesDB] SET ANSI_NULLS ON 
GO
ALTER DATABASE [SqlTerritoriesDB] SET ANSI_PADDING ON 
GO
ALTER DATABASE [SqlTerritoriesDB] SET ANSI_WARNINGS ON 
GO
ALTER DATABASE [SqlTerritoriesDB] SET ARITHABORT ON 
GO
ALTER DATABASE [SqlTerritoriesDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SqlTerritoriesDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SqlTerritoriesDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SqlTerritoriesDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SqlTerritoriesDB] SET CURSOR_DEFAULT  LOCAL 
GO
ALTER DATABASE [SqlTerritoriesDB] SET CONCAT_NULL_YIELDS_NULL ON 
GO
ALTER DATABASE [SqlTerritoriesDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SqlTerritoriesDB] SET QUOTED_IDENTIFIER ON 
GO
ALTER DATABASE [SqlTerritoriesDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SqlTerritoriesDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SqlTerritoriesDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SqlTerritoriesDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SqlTerritoriesDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SqlTerritoriesDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SqlTerritoriesDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SqlTerritoriesDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SqlTerritoriesDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SqlTerritoriesDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SqlTerritoriesDB] SET  MULTI_USER 
GO
ALTER DATABASE [SqlTerritoriesDB] SET PAGE_VERIFY NONE  
GO
ALTER DATABASE [SqlTerritoriesDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SqlTerritoriesDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SqlTerritoriesDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SqlTerritoriesDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SqlTerritoriesDB] SET QUERY_STORE = OFF
GO
USE [SqlTerritoriesDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [SqlTerritoriesDB]
GO
/****** Object:  Table [dbo].[tblCampaignSpecialEvents]    Script Date: 6/29/2020 12:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCampaignSpecialEvents](
	[SpecialCampaignId] [int] NOT NULL,
	[SpecialCampaignName] [nchar](30) NOT NULL,
	[SpecialCampaignDescription] [nchar](1000) NULL,
	[SpecialCampaignStartDate] [date] NOT NULL,
	[SpecialCampaignEndDate] [date] NOT NULL,
	[FKCongregationId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SpecialCampaignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [CK_UniqueCampaign] UNIQUE NONCLUSTERED 
(
	[FKCongregationId] ASC,
	[SpecialCampaignName] ASC,
	[SpecialCampaignStartDate] ASC,
	[SpecialCampaignEndDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCongregation]    Script Date: 6/29/2020 12:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCongregation](
	[CongregationId] [int] NOT NULL,
	[CongregationName] [nvarchar](30) NOT NULL,
	[CongregationStreetAddress] [nvarchar](50) NOT NULL,
	[CongregationCity] [nvarchar](30) NOT NULL,
	[CongreagtionState] [nchar](2) NOT NULL,
	[CongregationZIPCode] [nchar](10) NOT NULL,
	[CongregationLanguage] [nchar](30) NOT NULL,
	[CongregationLatiude] [decimal](9, 6) NULL,
	[CongregationLongitude] [decimal](9, 6) NULL,
	[CongregationNumber] [nchar](6) NULL,
PRIMARY KEY CLUSTERED 
(
	[CongregationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [CK_tblNoduplicateCong] UNIQUE NONCLUSTERED 
(
	[CongregationName] ASC,
	[CongregationStreetAddress] ASC,
	[CongregationCity] ASC,
	[CongreagtionState] ASC,
	[CongregationLanguage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCongregationTerritories]    Script Date: 6/29/2020 12:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCongregationTerritories](
	[CongregationTerritoriesId] [int] NOT NULL,
	[TerritoryNumber] [int] NOT NULL,
	[TerritorySpecialNotes] [nchar](200) NULL,
	[TerritoryHiddenNotes] [nchar](200) NULL,
	[TerritoryBoundaries] [geometry] NOT NULL,
	[TerritorySpclTypes] [nchar](50) NULL,
	[FKtblCongregationId] [int] NOT NULL,
	[FKServiceGroup] [int] NULL,
	[LastUpdated] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[CongregationTerritoriesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [CK_tblUniqueTerritories] UNIQUE NONCLUSTERED 
(
	[TerritoryNumber] ASC,
	[FKtblCongregationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblHouseRecords]    Script Date: 6/29/2020 12:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHouseRecords](
	[HouseRecordsId] [bigint] NOT NULL,
	[HouseStreetNumber] [nchar](10) NULL,
	[HouseStreetAddress] [nchar](50) NULL,
	[AptLotNumber] [nchar](10) NULL,
	[City] [nchar](50) NULL,
	[USState] [nchar](2) NULL,
	[ZIPCode] [nchar](10) NULL,
	[HouseNotes] [nchar](255) NULL,
	[HouseVisitSelection] [nchar](20) NULL,
	[HouseLatiude] [decimal](9, 6) NULL,
	[HouseLongitude] [decimal](9, 6) NULL,
	[HouseTypeSelection] [nchar](20) NULL,
	[HouseForeignLanguageSelection] [nchar](30) NOT NULL,
	[FKCongregationId] [int] NOT NULL,
	[FKCongregationTerritoriesId] [int] NULL,
	[HouseLastUpdated] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[HouseRecordsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [CK_tblUniqueHouses] UNIQUE NONCLUSTERED 
(
	[FKCongregationId] ASC,
	[HouseStreetNumber] ASC,
	[HouseStreetAddress] ASC,
	[AptLotNumber] ASC,
	[City] ASC,
	[USState] ASC,
	[ZIPCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPublishers]    Script Date: 6/29/2020 12:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPublishers](
	[PublisherId] [int] NOT NULL,
	[PublisherFirstName] [nvarchar](30) NOT NULL,
	[PublisherLastName] [nvarchar](30) NOT NULL,
	[PublisherAppointment] [nchar](10) NULL,
	[PublisherSex] [bit] NOT NULL,
	[PublisherPrivileges] [nchar](25) NULL,
	[PublisherPhoneNumber] [char](10) NULL,
	[PublisherEmail] [nvarchar](255) NOT NULL,
	[FKPublisherCongregation] [int] NOT NULL,
	[FKFieldServiceGroup] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PublisherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [CK_UniquePublishers] UNIQUE NONCLUSTERED 
(
	[FKPublisherCongregation] ASC,
	[PublisherFirstName] ASC,
	[PublisherLastName] ASC,
	[PublisherSex] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblServiceGroups]    Script Date: 6/29/2020 12:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblServiceGroups](
	[ServiceGroupsId] [int] NOT NULL,
	[FKCongregationId] [int] NOT NULL,
	[ServiceGroupName] [nchar](20) NOT NULL,
	[ServiceGroupNotes] [nchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[ServiceGroupsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTerritoryPeople]    Script Date: 6/29/2020 12:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTerritoryPeople](
	[TerritoryPeopleId] [bigint] NOT NULL,
	[FKHouseRecords] [bigint] NOT NULL,
	[TerritoryPersonFirstName] [nchar](30) NULL,
	[TerritoryPersonLastName] [nchar](50) NULL,
	[TerritoryPersonCellPhone] [nchar](10) NULL,
	[TerritoryPersonHomePhone1] [nchar](10) NULL,
	[TerritoryPersonHomePhone2] [nchar](10) NULL,
	[TerritoryPersonNotes] [nchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[TerritoryPeopleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTerritoryWorkAssignment]    Script Date: 6/29/2020 12:06:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTerritoryWorkAssignment](
	[TerritoryWorkAssignmentId] [bigint] NOT NULL,
	[FKCongregationId] [int] NOT NULL,
	[FKPublisherId] [int] NOT NULL,
	[FKCongregationTerritoryId] [int] NOT NULL,
	[FKCampaignId] [int] NULL,
	[FKFieldServiceGroupId] [int] NULL,
	[TerritoryAssignmentStartDate] [datetime] NOT NULL,
	[TerritoryAssignmentEndDate] [datetime] NULL,
	[UniqueLinkKey] [nchar](50) NOT NULL,
	[TerritoryAssignmentLastUpdated] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[TerritoryWorkAssignmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [CK_UniqueLinkKey] UNIQUE NONCLUSTERED 
(
	[UniqueLinkKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [CK_UniqueTerrAssignment] UNIQUE NONCLUSTERED 
(
	[FKCongregationId] ASC,
	[FKCampaignId] ASC,
	[FKCongregationTerritoryId] ASC,
	[TerritoryAssignmentEndDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblCongregationTerritories] ADD  DEFAULT (getdate()) FOR [LastUpdated]
GO
ALTER TABLE [dbo].[tblHouseRecords] ADD  DEFAULT (getdate()) FOR [HouseLastUpdated]
GO
ALTER TABLE [dbo].[tblTerritoryWorkAssignment] ADD  DEFAULT (getdate()) FOR [TerritoryAssignmentLastUpdated]
GO
ALTER TABLE [dbo].[tblCampaignSpecialEvents]  WITH CHECK ADD  CONSTRAINT [FK_CampaigntoCongId] FOREIGN KEY([FKCongregationId])
REFERENCES [dbo].[tblCongregation] ([CongregationId])
GO
ALTER TABLE [dbo].[tblCampaignSpecialEvents] CHECK CONSTRAINT [FK_CampaigntoCongId]
GO
ALTER TABLE [dbo].[tblCongregationTerritories]  WITH CHECK ADD  CONSTRAINT [FK_tblCongregationTerritories_ToTable] FOREIGN KEY([FKtblCongregationId])
REFERENCES [dbo].[tblCongregation] ([CongregationId])
GO
ALTER TABLE [dbo].[tblCongregationTerritories] CHECK CONSTRAINT [FK_tblCongregationTerritories_ToTable]
GO
ALTER TABLE [dbo].[tblCongregationTerritories]  WITH CHECK ADD  CONSTRAINT [FK_toFieldServiceGroupforTerr] FOREIGN KEY([FKServiceGroup])
REFERENCES [dbo].[tblServiceGroups] ([ServiceGroupsId])
GO
ALTER TABLE [dbo].[tblCongregationTerritories] CHECK CONSTRAINT [FK_toFieldServiceGroupforTerr]
GO
ALTER TABLE [dbo].[tblHouseRecords]  WITH CHECK ADD  CONSTRAINT [FK_toCongTerrtbl] FOREIGN KEY([FKCongregationTerritoriesId])
REFERENCES [dbo].[tblCongregationTerritories] ([CongregationTerritoriesId])
GO
ALTER TABLE [dbo].[tblHouseRecords] CHECK CONSTRAINT [FK_toCongTerrtbl]
GO
ALTER TABLE [dbo].[tblHouseRecords]  WITH CHECK ADD  CONSTRAINT [FK_toCongtoHouseRectbl] FOREIGN KEY([FKCongregationId])
REFERENCES [dbo].[tblCongregation] ([CongregationId])
GO
ALTER TABLE [dbo].[tblHouseRecords] CHECK CONSTRAINT [FK_toCongtoHouseRectbl]
GO
ALTER TABLE [dbo].[tblPublishers]  WITH CHECK ADD  CONSTRAINT [FK_tblPublishers_ToTable] FOREIGN KEY([FKPublisherCongregation])
REFERENCES [dbo].[tblCongregation] ([CongregationId])
GO
ALTER TABLE [dbo].[tblPublishers] CHECK CONSTRAINT [FK_tblPublishers_ToTable]
GO
ALTER TABLE [dbo].[tblPublishers]  WITH CHECK ADD  CONSTRAINT [FK_toFieldServiceGroup] FOREIGN KEY([FKFieldServiceGroup])
REFERENCES [dbo].[tblServiceGroups] ([ServiceGroupsId])
GO
ALTER TABLE [dbo].[tblPublishers] CHECK CONSTRAINT [FK_toFieldServiceGroup]
GO
ALTER TABLE [dbo].[tblServiceGroups]  WITH CHECK ADD  CONSTRAINT [FK_CongtoGroup] FOREIGN KEY([FKCongregationId])
REFERENCES [dbo].[tblCongregation] ([CongregationId])
GO
ALTER TABLE [dbo].[tblServiceGroups] CHECK CONSTRAINT [FK_CongtoGroup]
GO
ALTER TABLE [dbo].[tblTerritoryPeople]  WITH CHECK ADD  CONSTRAINT [FK_tblHouseRecordstoTerrPeople] FOREIGN KEY([FKHouseRecords])
REFERENCES [dbo].[tblHouseRecords] ([HouseRecordsId])
GO
ALTER TABLE [dbo].[tblTerritoryPeople] CHECK CONSTRAINT [FK_tblHouseRecordstoTerrPeople]
GO
ALTER TABLE [dbo].[tblTerritoryWorkAssignment]  WITH CHECK ADD  CONSTRAINT [FK_toCampaigntbl] FOREIGN KEY([FKCampaignId])
REFERENCES [dbo].[tblCampaignSpecialEvents] ([SpecialCampaignId])
GO
ALTER TABLE [dbo].[tblTerritoryWorkAssignment] CHECK CONSTRAINT [FK_toCampaigntbl]
GO
ALTER TABLE [dbo].[tblTerritoryWorkAssignment]  WITH CHECK ADD  CONSTRAINT [FK_toCongtbl] FOREIGN KEY([FKCongregationId])
REFERENCES [dbo].[tblCongregation] ([CongregationId])
GO
ALTER TABLE [dbo].[tblTerritoryWorkAssignment] CHECK CONSTRAINT [FK_toCongtbl]
GO
ALTER TABLE [dbo].[tblTerritoryWorkAssignment]  WITH CHECK ADD  CONSTRAINT [FK_toConTerrtbl] FOREIGN KEY([FKCongregationTerritoryId])
REFERENCES [dbo].[tblCongregationTerritories] ([CongregationTerritoriesId])
GO
ALTER TABLE [dbo].[tblTerritoryWorkAssignment] CHECK CONSTRAINT [FK_toConTerrtbl]
GO
ALTER TABLE [dbo].[tblTerritoryWorkAssignment]  WITH CHECK ADD  CONSTRAINT [FK_toFieldServiceGrouptoWorkAssign] FOREIGN KEY([FKFieldServiceGroupId])
REFERENCES [dbo].[tblServiceGroups] ([ServiceGroupsId])
GO
ALTER TABLE [dbo].[tblTerritoryWorkAssignment] CHECK CONSTRAINT [FK_toFieldServiceGrouptoWorkAssign]
GO
ALTER TABLE [dbo].[tblTerritoryWorkAssignment]  WITH CHECK ADD  CONSTRAINT [FK_toPubltbl] FOREIGN KEY([FKPublisherId])
REFERENCES [dbo].[tblPublishers] ([PublisherId])
GO
ALTER TABLE [dbo].[tblTerritoryWorkAssignment] CHECK CONSTRAINT [FK_toPubltbl]
GO
ALTER TABLE [dbo].[tblCampaignSpecialEvents]  WITH CHECK ADD  CONSTRAINT [CK_Endate>=StartDate] CHECK  (([SpecialCampaignEndDate]>=[SpecialCampaignStartDate]))
GO
ALTER TABLE [dbo].[tblCampaignSpecialEvents] CHECK CONSTRAINT [CK_Endate>=StartDate]
GO
ALTER TABLE [dbo].[tblTerritoryWorkAssignment]  WITH CHECK ADD  CONSTRAINT [CK_TerrAssignEndDate>TerrAssignStartDate] CHECK  (([TerritoryAssignmentEndDate]>[TerritoryAssignmentStartDate]))
GO
ALTER TABLE [dbo].[tblTerritoryWorkAssignment] CHECK CONSTRAINT [CK_TerrAssignEndDate>TerrAssignStartDate]
GO
/****** Object:  StoredProcedure [dbo].[spInsertCampaignSpecialEvents]    Script Date: 6/29/2020 12:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------
-- Object Name: dbo.spInsertCampaignSpecialEvents
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Insert a record into a table
-- Detailed Description: Insert a record into the dbo.CampaignSpecialEvents table
-- Database: SqlTerritoriesDB
-- Dependent Objects: None
-- Called By: Application
-- Upstream Systems: N\A
-- Downstream Systems: N\A
-- 
--------------------------------------------------------------------------------------
-- Rev | CMR | Date Modified | Developer  | Change Summary
--------------------------------------------------------------------------------------
-- 001 | N\A | 06.28.2020 | BWiggins | Original code
--
*/

CREATE PROCEDURE [dbo].[spInsertCampaignSpecialEvents]

	@SpecialCampaignName NCHAR(30), 
    @SpecialCampaignDescription NCHAR(1000), 
    @SpecialCampaignStartDate DATE, 
    @SpecialCampaignEndDate DATE, 
    @FKCongregationId INT

AS
BEGIN 

 SET NOCOUNT ON; 

  BEGIN 
    INSERT INTO [dbo].[tblCampaignSpecialEvents]
        ([SpecialCampaignName], 
    [SpecialCampaignDescription], 
    [SpecialCampaignStartDate], 
    [SpecialCampaignEndDate], 
    [FKCongregationId])
	VALUES
    (@SpecialCampaignName, 
    @SpecialCampaignDescription, 
    @SpecialCampaignStartDate, 
    @SpecialCampaignEndDate, 
    @FKCongregationId)
    END 
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertCongregation]    Script Date: 6/29/2020 12:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------
-- Object Name: dbo.spInsertCongregation
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Insert a record into a table
-- Detailed Description: Insert a record into the dbo.Congregation table
-- Database: SqlTerritoriesDB
-- Dependent Objects: None
-- Called By: Application
-- Upstream Systems: N\A
-- Downstream Systems: N\A
-- 
--------------------------------------------------------------------------------------
-- Rev | CMR | Date Modified | Developer  | Change Summary
--------------------------------------------------------------------------------------
-- 001 | N\A | 06.28.2020 | BWiggins | Original code
--
*/

CREATE PROCEDURE [dbo].[spInsertCongregation]

	@CongregationName NVARCHAR(30),
    @CongregationStreetAddress NVARCHAR(50),
    @CongregationCity NVARCHAR(30),
    @CongreagtionState NCHAR(2),
    @CongregationZIPCode NCHAR(10),
    @CongregationLanguage NCHAR(30),
    @CongregationLatiude DECIMAL(9,6),
    @CongregationLongitude DECIMAL(9,6),
    @CongregationNumber NCHAR(6)

AS
BEGIN 

 SET NOCOUNT ON; 

  BEGIN 
    INSERT INTO [dbo].[tblCongregation]
        ([CongregationName], 
    [CongregationStreetAddress], 
    [CongregationCity], 
    [CongreagtionState], 
    [CongregationZIPCode], 
    [CongregationLanguage], 
    [CongregationLatiude], 
    [CongregationLongitude],
    [CongregationNumber])
	VALUES
    (@CongregationName,
    @CongregationStreetAddress,
    @CongregationCity,
    @CongreagtionState,
    @CongregationZIPCode,
    @CongregationLanguage,
    @CongregationLatiude,
    @CongregationLongitude,
    @CongregationNumber)
    END 

END
GO
/****** Object:  StoredProcedure [dbo].[spInsertCongregationTerritories]    Script Date: 6/29/2020 12:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------
-- Object Name: dbo.spInsertCongregationTerritories
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Insert a record into a table
-- Detailed Description: Insert a record into the dbo.CongregationTerritories table
-- Database: SqlTerritoriesDB
-- Dependent Objects: None
-- Called By: Application
-- Upstream Systems: N\A
-- Downstream Systems: N\A
-- 
--------------------------------------------------------------------------------------
-- Rev | CMR | Date Modified | Developer  | Change Summary
--------------------------------------------------------------------------------------
-- 001 | N\A | 06.28.2020 | BWiggins | Original code
--
*/

CREATE PROCEDURE [dbo].[spInsertCongregationTerritories]

	@TerritoryNumber INT, 
    @TerritorySpecialNotes NCHAR(200), 
    @TerritoryHiddenNotes NCHAR(200), 
    @TerritoryBoundaries [sys].[geometry], 
    @TerritorySpclTypes NCHAR(50), 
    @FKtblCongregationId INT, 
    @FKServiceGroup INT

AS
BEGIN

 SET NOCOUNT ON;

  BEGIN 
    INSERT INTO [dbo].[tblCongregationTerritories]
        ([TerritoryNumber], 
    [TerritorySpecialNotes], 
    [TerritoryHiddenNotes], 
    [TerritoryBoundaries], 
    [TerritorySpclTypes], 
    [FKtblCongregationId], 
    [FKServiceGroup])
	VALUES
    (@TerritoryNumber, 
    @TerritorySpecialNotes, 
    @TerritoryHiddenNotes, 
    @TerritoryBoundaries, 
    @TerritorySpclTypes, 
    @FKtblCongregationId, 
    @FKServiceGroup)
    END 
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertHouseRecords]    Script Date: 6/29/2020 12:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------
-- Object Name: dbo.spInsertHouseRecords
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Insert a record into a table
-- Detailed Description: Insert a record into the dbo.HouseRecords table
-- Database: SqlTerritoriesDB
-- Dependent Objects: None
-- Called By: Application
-- Upstream Systems: N\A
-- Downstream Systems: N\A
-- 
--------------------------------------------------------------------------------------
-- Rev | CMR | Date Modified | Developer  | Change Summary
--------------------------------------------------------------------------------------
-- 001 | N\A | 06.28.2020 | BWiggins | Original code
--
*/

CREATE PROCEDURE [dbo].[spInsertHouseRecords]

	@HouseStreetNumber NCHAR(10), 
    @HouseStreetAddress NCHAR(50), 
    @AptLotNumber NCHAR(10), 
    @City NCHAR(50), 
    @USState NCHAR(2), 
    @ZIPCode NCHAR(10), 
    @HouseNotes NCHAR(255), 
    @HouseVisitSelection NCHAR(20),
    @HouseLatiude DECIMAL(9, 6), 
    @HouseLongitude DECIMAL(9, 6),
    @HouseTypeSelection NCHAR(20),
    @HouseForeignLanguageSelection NCHAR(30) , 
    @FKCongregationId INT ,
    @FKCongregationTerritoriesId INT

AS
BEGIN 

 SET NOCOUNT ON; 

  BEGIN 
    INSERT INTO [dbo].[tblHouseRecords]
        ([HouseStreetNumber], 
        [HouseStreetAddress], 
        [AptLotNumber], 
        [City], 
        [USState], 
        [ZIPCode], 
        [HouseNotes], 
        [HouseVisitSelection],
        [HouseLatiude], 
        [HouseLongitude],
        [HouseTypeSelection],
        [HouseForeignLanguageSelection], 
        [FKCongregationId],
        [FKCongregationTerritoriesId])
	VALUES
    (@HouseStreetNumber, 
    @HouseStreetAddress, 
    @AptLotNumber, 
    @City, 
    @USState, 
    @ZIPCode, 
    @HouseNotes, 
    @HouseVisitSelection,
    @HouseLatiude, 
    @HouseLongitude,
    @HouseTypeSelection,
    @HouseForeignLanguageSelection, 
    @FKCongregationId,
    @FKCongregationTerritoriesId)
    END 
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertPublishers]    Script Date: 6/29/2020 12:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------
-- Object Name: dbo.spInsertPublishers
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Insert a record into a table
-- Detailed Description: Insert a record into the dbo.Publishers table
-- Database: SqlTerritoriesDB
-- Dependent Objects: None
-- Called By: Application
-- Upstream Systems: N\A
-- Downstream Systems: N\A
-- 
--------------------------------------------------------------------------------------
-- Rev | CMR | Date Modified | Developer  | Change Summary
--------------------------------------------------------------------------------------
-- 001 | N\A | 06.28.2020 | BWiggins | Original code
--
*/

CREATE PROCEDURE [dbo].[spInsertPublishers]

	@PublisherFirstName NVARCHAR(30), 
    @PublisherLastName NVARCHAR(30), 
    @PublisherAppointment NCHAR(10), 
    @PublisherSex BIT, 
    @PublisherPrivileges NCHAR(25), 
    @PublisherPhoneNumber CHAR(10),
    @PublisherEmail NVARCHAR(255),
    @FKPublisherCongregation INT, 
    @FKFieldServiceGroup INT

AS
BEGIN 

 SET NOCOUNT ON; 

  BEGIN 
    INSERT INTO [dbo].[tblPublishers]
        ([PublisherFirstName], 
    [PublisherLastName], 
    [PublisherAppointment], 
    [PublisherSex], 
    [PublisherPrivileges], 
    [PublisherPhoneNumber],
    [PublisherEmail],
    [FKPublisherCongregation], 
    [FKFieldServiceGroup])
	VALUES
    (@PublisherFirstName, 
    @PublisherLastName, 
    @PublisherAppointment, 
    @PublisherSex, 
    @PublisherPrivileges, 
    @PublisherPhoneNumber,
    @PublisherEmail,
    @FKPublisherCongregation, 
    @FKFieldServiceGroup)
   END 
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertServiceGroups]    Script Date: 6/29/2020 12:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------
-- Object Name: dbo.spInsertServiceGroups
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Insert a record into a table
-- Detailed Description: Insert a record into the dbo.ServiceGroups table
-- Database: SqlTerritoriesDB
-- Dependent Objects: None
-- Called By: Application
-- Upstream Systems: N\A
-- Downstream Systems: N\A
-- 
--------------------------------------------------------------------------------------
-- Rev | CMR | Date Modified | Developer  | Change Summary
--------------------------------------------------------------------------------------
-- 001 | N\A | 06.28.2020 | BWiggins | Original code
--
*/

CREATE PROCEDURE [dbo].[spInsertServiceGroups]

	@FKCongregationId INT, 
    @ServiceGroupName NCHAR(20), 
    @ServiceGroupes NCHAR(150) 

AS
BEGIN 

 SET NOCOUNT ON; 

  BEGIN 
    INSERT INTO [dbo].[tblServiceGroups]
        ([FKCongregationId], 
    [ServiceGroupName], 
    [ServiceGroupNotes])
	VALUES
    (@FKCongregationId, 
    @ServiceGroupName, 
    @ServiceGroupes)
    END 
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertTerritoryPeople]    Script Date: 6/29/2020 12:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------
-- Object Name: dbo.spInsertTerritoryPeople
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Insert a record into a table
-- Detailed Description: Insert a record into the dbo.TerritoryPeople table
-- Database: SqlTerritoriesDB
-- Dependent Objects: None
-- Called By: Application
-- Upstream Systems: N\A
-- Downstream Systems: N\A
-- 
--------------------------------------------------------------------------------------
-- Rev | CMR | Date Modified | Developer  | Change Summary
--------------------------------------------------------------------------------------
-- 001 | N\A | 06.28.2020 | BWiggins | Original code
--
*/

CREATE PROCEDURE [dbo].[spInsertTerritoryPeople]

	@FKHouseRecords BIGINT, 
    @TerritoryPersonFirstName NCHAR(30), 
    @TerritoryPersonLastName NCHAR(50), 
    @TerritoryPersonCellPhone NCHAR(10), 
    @TerritoryPersonHomePhone1 NCHAR(10), 
    @TerritoryPersonHomePhone2 NCHAR(10),
    @TerritoryPersones NCHAR(200) 

AS
BEGIN 

 SET NOCOUNT ON; 

  BEGIN 
    INSERT INTO [dbo].[tblTerritoryPeople]
        ([FKHouseRecords], 
    [TerritoryPersonFirstName], 
    [TerritoryPersonLastName], 
    [TerritoryPersonCellPhone], 
    [TerritoryPersonHomePhone1], 
    [TerritoryPersonHomePhone2],
    [TerritoryPersonNotes])
	VALUES
    (@FKHouseRecords, 
    @TerritoryPersonFirstName, 
    @TerritoryPersonLastName, 
    @TerritoryPersonCellPhone, 
    @TerritoryPersonHomePhone1, 
    @TerritoryPersonHomePhone2,
    @TerritoryPersones)
    END 
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertTerritoryWorkAssignment]    Script Date: 6/29/2020 12:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------
-- Object Name: dbo.spInsertTerritoryWorkAssignment
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Insert a record into a table
-- Detailed Description: Insert a record into the dbo.TerritoryWorkAssignment table
-- Database: SqlTerritoriesDB
-- Dependent Objects: None
-- Called By: Application
-- Upstream Systems: N\A
-- Downstream Systems: N\A
-- 
--------------------------------------------------------------------------------------
-- Rev | CMR | Date Modified | Developer  | Change Summary
--------------------------------------------------------------------------------------
-- 001 | N\A | 06.28.2020 | BWiggins | Original code
--
*/

CREATE PROCEDURE [dbo].[spInsertTerritoryWorkAssignment]

	@FKCongregationId INT, 
    @FKPublisherId INT, 
    @FKCongregationTerritoryId INT, 
    @FKCampaignId INT, 
    @FKFieldServiceGroupId INT,
    @TerritoryAssignmentStartDate DATETIME, 
    @TerritoryAssignmentEndDate DATETIME,
    @UniqueLinkKey NCHAR(50)

AS
BEGIN 

 SET NOCOUNT ON; 

  BEGIN 
    INSERT INTO [dbo].[tblTerritoryWorkAssignment]
        ([FKCongregationId], 
        [FKPublisherId], 
        [FKCongregationTerritoryId], 
        [FKCampaignId], 
        [FKFieldServiceGroupId],
        [TerritoryAssignmentStartDate], 
        [TerritoryAssignmentEndDate],
        [UniqueLinkKey])
	VALUES
    (@FKCongregationId, 
    @FKPublisherId, 
    @FKCongregationTerritoryId, 
    @FKCampaignId, 
    @FKFieldServiceGroupId,
    @TerritoryAssignmentStartDate, 
    @TerritoryAssignmentEndDate,
    @UniqueLinkKey)
    END 
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCampaignSpecialEvents]    Script Date: 6/29/2020 12:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------
-- Object Name: dbo.spInsertCampaignSpecialEvents
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Update a record into a table
-- Detailed Description: Update a record into the dbo.CampaignSpecialEvents table
-- Database: SqlTerritoriesDB
-- Dependent Objects: None
-- Called By: Application
-- Upstream Systems: N\A
-- Downstream Systems: N\A
-- 
--------------------------------------------------------------------------------------
-- Rev | CMR | Date Modified | Developer  | Change Summary
--------------------------------------------------------------------------------------
-- 001 | N\A | 06.28.2020 | BWiggins | Original code
--
*/

CREATE PROCEDURE [dbo].[spUpdateCampaignSpecialEvents]

	@SpecialCampaignId INT, 
    @SpecialCampaignName NCHAR(30), 
    @SpecialCampaignDescription NCHAR(1000), 
    @SpecialCampaignStartDate DATE, 
    @SpecialCampaignEndDate DATE, 
    @FKCongregationId INT 

    

AS
BEGIN 

 SET NOCOUNT ON; 

  BEGIN 
    UPDATE [dbo].[tblCampaignSpecialEvents]
    SET [SpecialCampaignName]=ISNULL(@SpecialCampaignName,[SpecialCampaignName]),
        [SpecialCampaignDescription]=ISNULL(@SpecialCampaignDescription,[SpecialCampaignDescription]),
        [SpecialCampaignStartDate]=ISNULL(@SpecialCampaignStartDate,[SpecialCampaignStartDate]),
        [SpecialCampaignEndDate]=ISNULL(@SpecialCampaignEndDate,[SpecialCampaignEndDate]), 
        [FKCongregationId]=ISNULL(@FKCongregationId,[FKCongregationId])
	WHERE [SpecialCampaignId]=@SpecialCampaignId
    END 
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCongregation]    Script Date: 6/29/2020 12:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------
-- Object Name: dbo.spInsertCongregation
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Update a record into a table
-- Detailed Description: Update a record into the dbo.Congregation table
-- Database: SqlTerritoriesDB
-- Dependent Objects: None
-- Called By: Application
-- Upstream Systems: N\A
-- Downstream Systems: N\A
-- 
--------------------------------------------------------------------------------------
-- Rev | CMR | Date Modified | Developer  | Change Summary
--------------------------------------------------------------------------------------
-- 001 | N\A | 06.28.2020 | BWiggins | Original code
--
*/

CREATE PROCEDURE [dbo].[spUpdateCongregation]

	@CongregationId INT, 
    @CongregationName NVARCHAR(30), 
    @CongregationStreetAddress NVARCHAR(50), 
    @CongregationCity NVARCHAR(30), 
    @CongreagtionState NCHAR(2), 
    @CongregationZIPCode NCHAR(10), 
    @CongregationLanguage NCHAR(30), 
    @CongregationLatiude DECIMAL(9, 6), 
    @CongregationLongitude DECIMAL(9, 6), 
    @CongregationNumber NCHAR(6)
   
AS
BEGIN 

 SET NOCOUNT ON; 

  BEGIN 
    UPDATE [dbo].[tblCongregation]
    SET CongregationName=ISNULL(@CongregationName,CongregationName),
        CongregationStreetAddress=ISNULL(@CongregationStreetAddress,CongregationStreetAddress),
        CongregationCity=ISNULL(@CongregationCity,CongregationCity),
        CongreagtionState=ISNULL(@CongreagtionState,CongreagtionState),  
        CongregationZIPCode=ISNULL(@CongregationZIPCode,CongregationZIPCode), 
        CongregationLanguage=ISNULL(@CongregationLanguage,CongregationLanguage), 
        CongregationLatiude=ISNULL(@CongregationLatiude,CongregationLatiude), 
        CongregationLongitude=ISNULL(@CongregationLongitude,CongregationLongitude), 
        CongregationNumber=ISNULL(@CongregationNumber,CongregationNumber) 
	WHERE CongregationId=@CongregationId
    END 
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCongregationTerritories]    Script Date: 6/29/2020 12:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------
-- Object Name: dbo.spUpdateCongregationTerritories
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Update a record into a table
-- Detailed Description: Update a record into the dbo.CongregationTerritories table
-- Database: SqlTerritoriesDB
-- Dependent Objects: None
-- Called By: Application
-- Upstream Systems: N\A
-- Downstream Systems: N\A
-- 
--------------------------------------------------------------------------------------
-- Rev | CMR | Date Modified | Developer  | Change Summary
--------------------------------------------------------------------------------------
-- 001 | N\A | 06.28.2020 | BWiggins | Original code
--
*/

CREATE PROCEDURE [dbo].[spUpdateCongregationTerritories]

    @CongregationTerritoriesId INT,
    @TerritoryNumber INT, 
    @TerritorySpecialNotes NCHAR(200), 
    @TerritoryHiddenNotes NCHAR(200), 
    @TerritoryBoundaries sys.geometry, 
    @TerritorySpclTypes NCHAR(50), 
    @FKtblCongregationId INT, 
    @FKServiceGroup INT

AS
BEGIN 

 SET NOCOUNT ON; 

  BEGIN 
    UPDATE [dbo].[tblCongregationTerritories]
    SET TerritoryNumber=ISNULL(@TerritoryNumber,TerritoryNumber), 
        TerritorySpecialNotes=ISNULL(@TerritorySpecialNotes,TerritorySpecialNotes), 
        TerritoryHiddenNotes=ISNULL(@TerritoryHiddenNotes,TerritoryHiddenNotes), 
        TerritoryBoundaries=ISNULL(@TerritoryBoundaries,TerritoryBoundaries), 
        TerritorySpclTypes=ISNULL(@TerritorySpclTypes,TerritorySpclTypes), 
        FKtblCongregationId=ISNULL(@FKtblCongregationId,FKtblCongregationId), 
        FKServiceGroup=ISNULL(@FKServiceGroup,FKServiceGroup)
	WHERE [CongregationTerritoriesId]=@CongregationTerritoriesId
    END 
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateHouseRecords]    Script Date: 6/29/2020 12:06:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------
-- Object Name: dbo.spUpdateHouseRecords
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Update a record into a table
-- Detailed Description: Update a record into the dbo.HouseRecords table
-- Database: SqlTerritoriesDB
-- Dependent Objects: None
-- Called By: Application
-- Upstream Systems: N\A
-- Downstream Systems: N\A
-- 
--------------------------------------------------------------------------------------
-- Rev | CMR | Date Modified | Developer  | Change Summary
--------------------------------------------------------------------------------------
-- 001 | N\A | 06.28.2020 | BWiggins | Original code
--
*/

CREATE PROCEDURE [dbo].[spUpdateHouseRecords]

    @HouseRecordsId BIGINT, 
    @HouseStreetNumber NCHAR(10), 
    @HouseStreetAddress NCHAR(50), 
    @AptLotNumber NCHAR(10), 
    @City NCHAR(50), 
    @USState NCHAR(2), 
    @ZIPCode NCHAR(10), 
    @HouseNotes NCHAR(255), 
    @HouseVisitSelection NCHAR(20),
    @HouseLatiude DECIMAL(9, 6), 
    @HouseLongitude DECIMAL(9, 6),
    @HouseTypeSelection NCHAR(20),
    @HouseForeignLanguageSelection NCHAR(30), 
    @FKCongregationId INT,
    @FKCongregationTerritoriesId INT

AS
BEGIN 

 SET NOCOUNT ON; 

  BEGIN 
    UPDATE [dbo].[tblHouseRecords]
    SET [HouseStreetNumber]=ISNULL(@HouseStreetNumber,[HouseStreetNumber]), 
        [HouseStreetAddress]=ISNULL(@HouseStreetAddress,[HouseStreetAddress]), 
        [AptLotNumber]=ISNULL(@AptLotNumber,[AptLotNumber]), 
        [City]=ISNULL(@City,[City]), 
        [USState]=ISNULL(@USState,[USState]), 
        [ZIPCode]=ISNULL(@ZIPCode,[ZIPCode]), 
        [HouseNotes]=ISNULL(@HouseNotes,[HouseNotes]), 
        [HouseVisitSelection]=ISNULL(@HouseVisitSelection,[HouseVisitSelection]),
        [HouseLatiude]=ISNULL(@HouseLatiude,[HouseLatiude]), 
        [HouseLongitude]=ISNULL(@HouseLongitude,[HouseLongitude]),
        [HouseTypeSelection]=ISNULL(@HouseLongitude,[HouseTypeSelection]),
        [HouseForeignLanguageSelection]=ISNULL(@HouseForeignLanguageSelection,[HouseForeignLanguageSelection]), 
        [FKCongregationId]=ISNULL(@FKCongregationId,[FKCongregationId]),
        [FKCongregationTerritoriesId]=ISNULL(@FKCongregationTerritoriesId,[FKCongregationTerritoriesId])
	WHERE [HouseRecordsId]=@HouseRecordsId
    END 
END
GO
USE [master]
GO
ALTER DATABASE [SqlTerritoriesDB] SET  READ_WRITE 
GO
/*
----------------------------------------------------------------------------
-- Object Name: dbo.spUpdateHouseRecords
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Update a record into a table
-- Detailed Description: Update a record into the dbo.HouseRecords table
-- Database: SqlTerritoriesDB
-- Dependent Objects: None
-- Called By: Application
-- Upstream Systems: N\A
-- Downstream Systems: N\A
-- 
--------------------------------------------------------------------------------------
-- Rev | CMR | Date Modified | Developer  | Change Summary
--------------------------------------------------------------------------------------
-- 001 | N\A | 06.28.2020 | BWiggins | Original code
--
*/

CREATE PROCEDURE [dbo].[spUpdateHouseRecords]

    @HouseRecordsId BIGINT, 
    @HouseStreetNumber NCHAR(10), 
    @HouseStreetAddress NCHAR(50), 
    @AptLotNumber NCHAR(10), 
    @City NCHAR(50), 
    @USState NCHAR(2), 
    @ZIPCode NCHAR(10), 
    @HouseNotes NCHAR(255), 
    @HouseVisitSelection NCHAR(20),
    @HouseLatiude DECIMAL(9, 6), 
    @HouseLongitude DECIMAL(9, 6),
    @HouseTypeSelection NCHAR(20),
    @HouseForeignLanguageSelection NCHAR(30), 
    @FKCongregationId INT,
    @FKCongregationTerritoriesId INT

AS
BEGIN 

 SET NOCOUNT ON; 

  BEGIN 
    UPDATE [dbo].[tblHouseRecords]
    SET [HouseStreetNumber]=ISNULL(@HouseStreetNumber,[HouseStreetNumber]), 
        [HouseStreetAddress]=ISNULL(@HouseStreetAddress,[HouseStreetAddress]), 
        [AptLotNumber]=ISNULL(@AptLotNumber,[AptLotNumber]), 
        [City]=ISNULL(@City,[City]), 
        [USState]=ISNULL(@USState,[USState]), 
        [ZIPCode]=ISNULL(@ZIPCode,[ZIPCode]), 
        [HouseNotes]=ISNULL(@HouseNotes,[HouseNotes]), 
        [HouseVisitSelection]=ISNULL(@HouseVisitSelection,[HouseVisitSelection]),
        [HouseLatiude]=ISNULL(@HouseLatiude,[HouseLatiude]), 
        [HouseLongitude]=ISNULL(@HouseLongitude,[HouseLongitude]),
        [HouseTypeSelection]=ISNULL(@HouseLongitude,[HouseTypeSelection]),
        [HouseForeignLanguageSelection]=ISNULL(@HouseForeignLanguageSelection,[HouseForeignLanguageSelection]), 
        [FKCongregationId]=ISNULL(@FKCongregationId,[FKCongregationId]),
        [FKCongregationTerritoriesId]=ISNULL(@FKCongregationTerritoriesId,[FKCongregationTerritoriesId])
	WHERE [HouseRecordsId]=@HouseRecordsId
    END 
END
GO
USE [master]
GO
ALTER DATABASE [SqlTerritoriesDB] SET  READ_WRITE 
GO
