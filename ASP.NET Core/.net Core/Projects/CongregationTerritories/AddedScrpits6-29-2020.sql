/*
----------------------------------------------------------------------------
-- Object Name: dbo.spUTerritoryWorkAssignment
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Update a record into a table
-- Detailed Description: Update a record into the dbo.TerritoryWorkAssignment table
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

CREATE PROCEDURE [dbo].[spUpdateTerritoryWorkAssignment]

	@TerritoryWorkAssignmentId BIGINT,
	@FKCongregationId INT,
	@FKPublisherId INT,
	@FKCongregationTerritoryId INT,
	@FKCampaignId INT,
	@FKFieldServiceGroupId INT,
	@TerritoryAssignmentStartDate DATETIME,
	@TerritoryAssignmentEndDate DATETIME,
	@UniqueLinkKey NCHAR(50),
	@TerritoryAssignmentLastUpdated DATETIME2(7) NULL

AS
BEGIN 

 SET NOCOUNT ON; 

  BEGIN 
    UPDATE [dbo].[tblTerritoryWorkAssignment]
    SET [FKCongregationId]=ISNULL(@FKCongregationId,[FKCongregationId]),
		[FKPublisherId]=ISNULL(@FKPublisherId,[FKPublisherId]),
		[FKCongregationTerritoryId]=ISNULL(@FKCongregationTerritoryId,[FKCongregationTerritoryId]),
		[FKCampaignId]=ISNULL(@FKCampaignId,[FKCampaignId]),
		[FKFieldServiceGroupId]=ISNULL(@FKFieldServiceGroupId,[FKFieldServiceGroupId]),
		[TerritoryAssignmentStartDate]=ISNULL(@TerritoryAssignmentStartDate,[TerritoryAssignmentStartDate]),
		[TerritoryAssignmentEndDate]=ISNULL(@TerritoryAssignmentEndDate,[TerritoryAssignmentEndDate]),
		[UniqueLinkKey]=ISNULL(@UniqueLinkKey,[UniqueLinkKey]),
		[TerritoryAssignmentLastUpdated]=ISNULL(@TerritoryAssignmentLastUpdated,[TerritoryAssignmentLastUpdated])
	WHERE TerritoryWorkAssignmentId=@TerritoryWorkAssignmentId
    END 
END
GO

/*
----------------------------------------------------------------------------
-- Object Name: dbo.spUpdateTerritoryPeople
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Update a record into a table
-- Detailed Description: Update a record into the dbo.TerritoryPeople table
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

CREATE PROCEDURE [dbo].[spUpdateTerritoryPeople]

	@TerritoryPeopleId BIGINT,
	@FKHouseRecords BIGINT,
	@TerritoryPersonFirstName NCHAR(30),
	@TerritoryPersonLastName NCHAR(50),
	@TerritoryPersonCellPhone NCHAR(10),
	@TerritoryPersonHomePhone1 NCHAR(10),
	@TerritoryPersonHomePhone2 NCHAR(10),
	@TerritoryPersonNotes NCHAR(200)

AS
BEGIN 

 SET NOCOUNT ON; 

  BEGIN 
    UPDATE [dbo].[tblTerritoryPeople]
    SET [FKHouseRecords]=ISNULL(@FKHouseRecords,[FKHouseRecords]),
		[TerritoryPersonFirstName]=ISNULL(@TerritoryPersonFirstName,[TerritoryPersonFirstName]),
		[TerritoryPersonLastName]=ISNULL(@TerritoryPersonLastName,[TerritoryPersonLastName]),
		[TerritoryPersonCellPhone]=ISNULL(@TerritoryPersonCellPhone,[TerritoryPersonCellPhone]),
		[TerritoryPersonHomePhone1]=ISNULL(@TerritoryPersonHomePhone1,[TerritoryPersonHomePhone1]),
		[TerritoryPersonHomePhone2]=ISNULL(@TerritoryPersonHomePhone2,[TerritoryPersonHomePhone2]),
		[TerritoryPersonNotes]=ISNULL(@TerritoryPersonNotes,[TerritoryPersonNotes])
	WHERE [TerritoryPeopleId]=@TerritoryPeopleId
    END 
END
GO

/*
----------------------------------------------------------------------------
-- Object Name: dbo.spUpdateServiceGroups
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Update a record into a table
-- Detailed Description: Update a record into the dbo.ServiceGroups table
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

CREATE PROCEDURE [dbo].[spUpdateServiceGroups]

	@ServiceGroupsId INT,
	@FKCongregationId INT,
	@ServiceGroupName NCHAR(20),
	@ServiceGroupNotes NCHAR(150)

AS
BEGIN 

 SET NOCOUNT ON; 

  BEGIN 
    UPDATE [dbo].[tblServiceGroups]
    SET	[FKCongregationId]=ISNULL(@FKCongregationId,[FKCongregationId])
		[ServiceGroupName]=ISNULL(@ServiceGroupName,[ServiceGroupName])
		[ServiceGroupNotes]=ISNULL(@ServiceGroupNotes,[ServiceGroupNotes])
	
	WHERE [ServiceGroupsId]=@ServiceGroupsId
    END 
END
GO

/*
----------------------------------------------------------------------------
-- Object Name: dbo.spUpdatePublishers
-- Project: SqlTerritories
-- Business Process: Sample code
-- Purpose: Update a record into a table
-- Detailed Description: Update a record into the dbo.Publishers table
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

CREATE PROCEDURE [dbo].[spUpdatePublishers]

	@PublisherId INT,
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
    UPDATE [dbo].[tblPublishers]
    SET	[PublisherFirstName]=ISNULL(PublisherFirstName,[PublisherFirstName]),
		[PublisherLastName]=ISNULL(PublisherLastName,[PublisherLastName]),
		[PublisherAppointment]=ISNULL(PublisherAppointment,[PublisherAppointment]),
		[PublisherSex]=ISNULL(PublisherSex,[PublisherSex]),
		[PublisherPrivileges]=ISNULL(PublisherPrivileges,[PublisherPrivileges]),
		[PublisherPhoneNumber]=ISNULL(PublisherPhoneNumber,[PublisherPhoneNumber]),
		[PublisherEmail]=ISNULL(PublisherEmail,[PublisherEmail]),
		[FKPublisherCongregation]=ISNULL(FKPublisherCongregation,[FKPublisherCongregation]),
		[FKFieldServiceGroup]=ISNULL(FKFieldServiceGroup,[FKFieldServiceGroup])
	WHERE [PublisherId]=@PublisherId
    END 
END
GO


	 	
	
	
	