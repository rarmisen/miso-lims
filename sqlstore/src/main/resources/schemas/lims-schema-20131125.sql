/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table _Group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_Group`;

CREATE TABLE `_Group` (
  `groupId` bigint(20) NOT NULL auto_increment,
  `description` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`groupId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table _Partition
# ------------------------------------------------------------

DROP TABLE IF EXISTS `_Partition`;

CREATE TABLE `_Partition` (
  `partitionId` bigint(20) NOT NULL auto_increment,
  `partitionNumber` tinyint(4) NOT NULL,
  `pool_poolId` bigint(20) default NULL,
  `securityProfile_profileId` bigint(20) default NULL,
  PRIMARY KEY  (`partitionId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Dump of table Alert
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Alert`;

CREATE TABLE `Alert` (
  `alertId` bigint(20) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `text` text NOT NULL,
  `userId` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `isRead` bit(1) NOT NULL default b'0',
  `level` varchar(8) NOT NULL default 'INFO',
  PRIMARY KEY  (`alertId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Chamber
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Chamber`;

CREATE TABLE `Chamber` (
  `chamberId` bigint(20) NOT NULL auto_increment,
  `chamberNumber` tinyint(4) NOT NULL,
  `pool_poolId` bigint(20) default NULL,
  `securityProfile_profileId` bigint(20) default NULL,
  PRIMARY KEY  (`chamberId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table DATABASECHANGELOG
# ------------------------------------------------------------

DROP TABLE IF EXISTS `DATABASECHANGELOG`;

CREATE TABLE `DATABASECHANGELOG` (
  `ID` varchar(63) NOT NULL,
  `AUTHOR` varchar(63) NOT NULL,
  `FILENAME` varchar(200) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) default NULL,
  `DESCRIPTION` varchar(255) default NULL,
  `COMMENTS` varchar(255) default NULL,
  `TAG` varchar(255) default NULL,
  `LIQUIBASE` varchar(20) default NULL,
  PRIMARY KEY  (`ID`,`AUTHOR`,`FILENAME`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table DATABASECHANGELOGLOCK
# ------------------------------------------------------------

DROP TABLE IF EXISTS `DATABASECHANGELOGLOCK`;

CREATE TABLE `DATABASECHANGELOGLOCK` (
  `ID` int(11) NOT NULL,
  `LOCKED` tinyint(1) NOT NULL,
  `LOCKGRANTED` datetime default NULL,
  `LOCKEDBY` varchar(255) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table emPCR
# ------------------------------------------------------------

DROP TABLE IF EXISTS `emPCR`;

CREATE TABLE `emPCR` (
  `pcrId` bigint(20) NOT NULL auto_increment,
  `concentration` double NOT NULL,
  `dilution_dilutionId` bigint(20) NOT NULL,
  `creationDate` date NOT NULL,
  `pcrUserName` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `securityProfile_profileId` bigint(20) default NULL,
  PRIMARY KEY  (`pcrId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Dump of table emPCRDilution
# ------------------------------------------------------------

DROP TABLE IF EXISTS `emPCRDilution`;

CREATE TABLE `emPCRDilution` (
  `dilutionId` bigint(20) NOT NULL auto_increment,
  `concentration` double NOT NULL,
  `emPCR_pcrId` bigint(20) NOT NULL,
  `identificationBarcode` varchar(13) default NULL,
  `creationDate` date NOT NULL,
  `dilutionUserName` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `securityProfile_profileId` bigint(20) default NULL,
  PRIMARY KEY  (`dilutionId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Dump of table Experiment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Experiment`;

CREATE TABLE `Experiment` (
  `experimentId` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `accession` varchar(30) default NULL,
  `title` varchar(255) NOT NULL,
  `securityProfile_profileId` bigint(20) default NULL,
  `study_studyId` bigint(20) default NULL,
  `alias` varchar(100) default NULL,
  `platform_platformId` bigint(20) NOT NULL,
  PRIMARY KEY  (`experimentId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Dump of table Experiment_Kit
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Experiment_Kit`;

CREATE TABLE `Experiment_Kit` (
  `experiments_experimentId` bigint(20) NOT NULL,
  `kits_kitId` bigint(20) NOT NULL,
  PRIMARY KEY  (`experiments_experimentId`,`kits_kitId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Experiment_Run
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Experiment_Run`;

CREATE TABLE `Experiment_Run` (
  `Experiment_experimentId` bigint(20) NOT NULL,
  `runs_runId` bigint(20) NOT NULL,
  PRIMARY KEY  (`Experiment_experimentId`,`runs_runId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Flowcell
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Flowcell`;

CREATE TABLE `Flowcell` (
  `flowcellId` bigint(20) NOT NULL auto_increment,
  `reservoirType` varchar(10) NOT NULL,
  `securityProfile_profileId` bigint(20) default NULL,
  `identificationBarcode` varchar(255) default NULL,
  `locationBarcode` varchar(255) default NULL,
  `paired` bit(1) NOT NULL default b'0',
  `platformType` varchar(50) default NULL,
  `validationBarcode` varchar(255) default NULL,
  PRIMARY KEY  (`flowcellId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Flowcell_Chamber
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Flowcell_Chamber`;

CREATE TABLE `Flowcell_Chamber` (
  `Flowcell_flowcellId` bigint(20) NOT NULL,
  `chambers_chamberId` bigint(20) NOT NULL,
  PRIMARY KEY  (`Flowcell_flowcellId`,`chambers_chamberId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Flowcell_Lane
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Flowcell_Lane`;

CREATE TABLE `Flowcell_Lane` (
  `Flowcell_flowcellId` bigint(20) NOT NULL,
  `lanes_laneId` bigint(20) NOT NULL,
  PRIMARY KEY  (`Flowcell_flowcellId`,`lanes_laneId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Kit
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Kit`;

CREATE TABLE `Kit` (
  `kitId` bigint(20) NOT NULL auto_increment,
  `identificationBarcode` varchar(255) default NULL,
  `locationBarcode` varchar(255) default NULL,
  `lotNumber` varchar(30) NOT NULL,
  `kitDate` date NOT NULL,
  `kitDescriptorId` bigint(20) NOT NULL,
  PRIMARY KEY  (`kitId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Kit_Note
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Kit_Note`;

CREATE TABLE `Kit_Note` (
  `kit_kitId` bigint(20) NOT NULL,
  `notes_noteId` bigint(20) NOT NULL,
  PRIMARY KEY  (`kit_kitId`,`notes_noteId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table KitDescriptor
# ------------------------------------------------------------

DROP TABLE IF EXISTS `KitDescriptor`;

CREATE TABLE `KitDescriptor` (
  `kitDescriptorId` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `version` int(3) default NULL,
  `manufacturer` varchar(100) NOT NULL,
  `partNumber` varchar(50) NOT NULL,
  `stockLevel` int(10) NOT NULL default '0',
  `kitType` varchar(30) NOT NULL,
  `platformType` varchar(20) NOT NULL,
  PRIMARY KEY  (`kitDescriptorId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Lane
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Lane`;

CREATE TABLE `Lane` (
  `laneId` bigint(20) NOT NULL auto_increment,
  `laneNumber` tinyint(4) NOT NULL,
  `pool_poolId` bigint(20) default NULL,
  `securityProfile_profileId` bigint(20) default NULL,
  PRIMARY KEY  (`laneId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Dump of table Library
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Library`;

CREATE TABLE `Library` (
  `libraryId` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `accession` varchar(30) default NULL,
  `securityProfile_profileId` bigint(20) default NULL,
  `sample_sampleId` bigint(20) NOT NULL,
  `identificationBarcode` varchar(255) default NULL,
  `locationBarcode` varchar(255) default NULL,
  `libraryType` bigint(20) default NULL,
  `concentration` double default NULL,
  `creationDate` date NOT NULL,
  `platformName` varchar(255) default NULL,
  `alias` varchar(100) default NULL,
  `paired` bit(1) NOT NULL default b'0',
  `librarySelectionType` bigint(20) default NULL,
  `libraryStrategyType` bigint(20) default NULL,
  `qcPassed` varchar(5) default NULL,
  PRIMARY KEY  (`libraryId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Library_Note
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Library_Note`;

CREATE TABLE `Library_Note` (
  `library_libraryId` bigint(20) NOT NULL,
  `notes_noteId` bigint(20) NOT NULL,
  PRIMARY KEY  (`library_libraryId`,`notes_noteId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Library_TagBarcode
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Library_TagBarcode`;

CREATE TABLE `Library_TagBarcode` (
  `library_libraryId` bigint(20) NOT NULL,
  `barcode_barcodeId` bigint(20) NOT NULL,
  PRIMARY KEY  (`library_libraryId`,`barcode_barcodeId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table LibraryDilution
# ------------------------------------------------------------

DROP TABLE IF EXISTS `LibraryDilution`;

CREATE TABLE `LibraryDilution` (
  `dilutionId` bigint(20) NOT NULL auto_increment,
  `concentration` double NOT NULL,
  `library_libraryId` bigint(20) NOT NULL,
  `identificationBarcode` varchar(255) default NULL,
  `creationDate` date NOT NULL,
  `dilutionUserName` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `securityProfile_profileId` bigint(20) default NULL,
  PRIMARY KEY  (`dilutionId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Dump of table LibraryQC
# ------------------------------------------------------------

DROP TABLE IF EXISTS `LibraryQC`;

CREATE TABLE `LibraryQC` (
  `qcId` bigint(20) NOT NULL auto_increment,
  `library_libraryId` bigint(20) NOT NULL,
  `qcUserName` varchar(255) NOT NULL,
  `qcDate` date NOT NULL,
  `qcMethod` bigint(20) default NULL,
  `results` double default NULL,
  `insertSize` int(11) NOT NULL,
  PRIMARY KEY  (`qcId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table LibrarySelectionType
# ------------------------------------------------------------

DROP TABLE IF EXISTS `LibrarySelectionType`;

CREATE TABLE `LibrarySelectionType` (
  `librarySelectionTypeId` bigint(20) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY  (`librarySelectionTypeId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table LibraryStrategyType
# ------------------------------------------------------------

DROP TABLE IF EXISTS `LibraryStrategyType`;

CREATE TABLE `LibraryStrategyType` (
  `libraryStrategyTypeId` bigint(20) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY  (`libraryStrategyTypeId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table LibraryType
# ------------------------------------------------------------

DROP TABLE IF EXISTS `LibraryType`;

CREATE TABLE `LibraryType` (
  `libraryTypeId` bigint(20) NOT NULL auto_increment,
  `description` varchar(255) NOT NULL,
  `platformType` varchar(50) NOT NULL,
  PRIMARY KEY  (`libraryTypeId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Note
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Note`;

CREATE TABLE `Note` (
  `noteId` bigint(20) NOT NULL auto_increment,
  `creationDate` date NOT NULL,
  `internalOnly` bit(1) NOT NULL default b'1',
  `text` varchar(255) NOT NULL,
  `owner_userId` bigint(20) default NULL,
  PRIMARY KEY  (`noteId`),
  KEY `FK2524124140968C` (`owner_userId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table persistent_logins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `persistent_logins`;

CREATE TABLE `persistent_logins` (
  `username` varchar(64) NOT NULL,
  `series` varchar(64) NOT NULL,
  `token` varchar(64) NOT NULL,
  `last_used` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`series`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Plate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Plate`;

CREATE TABLE `Plate` (
  `plateId` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `creationDate` date NOT NULL,
  `plateMaterialType` varchar(20) NOT NULL,
  `identificationBarcode` varchar(255) default NULL,
  `locationBarcode` varchar(255) default NULL,
  `size` int(11) NOT NULL default '96',
  `tagBarcodeId` bigint(20) default NULL,
  `securityProfile_profileId` bigint(20) default NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY  (`plateId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Plate_Elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Plate_Elements`;

CREATE TABLE `Plate_Elements` (
  `plate_plateId` bigint(20) NOT NULL,
  `elementType` varchar(255) NOT NULL,
  `elementPosition` int(11) NOT NULL,
  `elementId` bigint(20) NOT NULL,
  PRIMARY KEY  (`plate_plateId`,`elementId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Plate_Library
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Plate_Library`;

CREATE TABLE `Plate_Library` (
  `plate_plateId` bigint(20) NOT NULL,
  `library_libraryId` bigint(20) NOT NULL,
  PRIMARY KEY  (`plate_plateId`,`library_libraryId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Platform
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Platform`;

CREATE TABLE `Platform` (
  `platformId` bigint(20) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `instrumentModel` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL,
  `numContainers` tinyint(4) NOT NULL,
  PRIMARY KEY  (`platformId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Pool
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Pool`;

CREATE TABLE `Pool` (
  `poolId` bigint(20) NOT NULL auto_increment,
  `concentration` double NOT NULL,
  `identificationBarcode` varchar(255) default NULL,
  `name` varchar(255) NOT NULL,
  `creationDate` date NOT NULL,
  `securityProfile_profileId` bigint(20) default NULL,
  `experiment_experimentId` bigint(20) default NULL,
  `platformType` varchar(50) NOT NULL,
  `ready` tinyint(1) NOT NULL default '0',
  `alias` varchar(50) default NULL,
  `qcPassed` varchar(5) default NULL,
  PRIMARY KEY  (`poolId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Dump of table Pool_Elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Pool_Elements`;

CREATE TABLE `Pool_Elements` (
  `pool_poolId` bigint(20) NOT NULL,
  `elementType` varchar(255) NOT NULL,
  `elementId` bigint(20) NOT NULL,
  PRIMARY KEY  (`pool_poolId`,`elementId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Pool_emPCRDilution
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Pool_emPCRDilution`;

CREATE TABLE `Pool_emPCRDilution` (
  `pool_poolId` bigint(20) NOT NULL,
  `dilutions_dilutionId` bigint(20) NOT NULL,
  PRIMARY KEY  (`pool_poolId`,`dilutions_dilutionId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Pool_Experiment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Pool_Experiment`;

CREATE TABLE `Pool_Experiment` (
  `pool_poolId` bigint(20) NOT NULL,
  `experiments_experimentId` bigint(20) NOT NULL,
  PRIMARY KEY  (`pool_poolId`,`experiments_experimentId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Pool_LibraryDilution
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Pool_LibraryDilution`;

CREATE TABLE `Pool_LibraryDilution` (
  `pool_poolId` bigint(20) NOT NULL,
  `dilutions_dilutionId` bigint(20) NOT NULL,
  PRIMARY KEY  (`pool_poolId`,`dilutions_dilutionId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table PoolQC
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PoolQC`;

CREATE TABLE `PoolQC` (
  `qcId` bigint(20) NOT NULL auto_increment,
  `pool_poolId` bigint(20) NOT NULL,
  `qcUserName` varchar(255) NOT NULL,
  `qcDate` date NOT NULL,
  `qcMethod` bigint(20) default NULL,
  `results` double default NULL,
  PRIMARY KEY  (`qcId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table PrintJob
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PrintJob`;

CREATE TABLE `PrintJob` (
  `jobId` bigint(20) NOT NULL auto_increment,
  `printServiceName` varchar(100) NOT NULL,
  `printDate` date NOT NULL,
  `jobCreator_userId` bigint(20) NOT NULL,
  `printedElements` blob NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY  (`jobId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table PrintService
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PrintService`;

CREATE TABLE `PrintService` (
  `serviceId` bigint(20) NOT NULL auto_increment,
  `serviceName` varchar(100) NOT NULL,
  `contextName` varchar(100) NOT NULL,
  `contextFields` text,
  `enabled` bit(1) NOT NULL default b'1',
  `printServiceFor` varchar(255) NOT NULL,
  `printSchema` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`serviceId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Project
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Project`;

CREATE TABLE `Project` (
  `projectId` bigint(20) NOT NULL auto_increment,
  `creationDate` datetime default NULL,
  `description` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `securityProfile_profileId` bigint(20) default NULL,
  `progress` varchar(20) NOT NULL,
  `alias` varchar(100) default NULL,
  `lastUpdated` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`projectId`),
  KEY `FK50C8E2F960F9CBA8` (`securityProfile_profileId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Project_Issues
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Project_Issues`;

CREATE TABLE `Project_Issues` (
  `project_projectId` bigint(20) NOT NULL,
  `issueKey` varchar(255) NOT NULL,
  PRIMARY KEY  (`project_projectId`,`issueKey`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Project_Note
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Project_Note`;

CREATE TABLE `Project_Note` (
  `project_projectId` bigint(20) NOT NULL,
  `notes_noteId` bigint(20) NOT NULL,
  PRIMARY KEY  (`project_projectId`,`notes_noteId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Project_ProjectOverview
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Project_ProjectOverview`;

CREATE TABLE `Project_ProjectOverview` (
  `project_projectId` bigint(20) NOT NULL,
  `overviews_overviewId` bigint(20) NOT NULL,
  PRIMARY KEY  (`project_projectId`,`overviews_overviewId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED;



# Dump of table Project_Request
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Project_Request`;

CREATE TABLE `Project_Request` (
  `Project_projectId` bigint(20) NOT NULL,
  `requests_requestId` bigint(20) NOT NULL,
  UNIQUE KEY `requests_requestId` (`requests_requestId`),
  KEY `FKDA6E0B2925FFBF98` (`Project_projectId`),
  KEY `FKDA6E0B29B36A83EF` (`requests_requestId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Project_Study
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Project_Study`;

CREATE TABLE `Project_Study` (
  `Project_projectId` bigint(20) NOT NULL,
  `studies_studyId` bigint(20) NOT NULL,
  KEY `studyId` USING BTREE (`studies_studyId`),
  KEY `projectId` USING BTREE (`Project_projectId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table ProjectOverview
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ProjectOverview`;

CREATE TABLE `ProjectOverview` (
  `overviewId` bigint(20) NOT NULL auto_increment,
  `principalInvestigator` varchar(255) NOT NULL,
  `startDate` date default NULL,
  `endDate` date default NULL,
  `numProposedSamples` int(10) default NULL,
  `locked` bit(1) NOT NULL default b'0',
  `allSampleQcPassed` bit(1) default b'0',
  `libraryPreparationComplete` bit(1) default b'0',
  `allLibraryQcPassed` bit(1) default b'0',
  `allPoolsConstructed` bit(1) default b'0',
  `lastUpdated` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `allRunsCompleted` bit(1) default b'0',
  `primaryAnalysisCompleted` bit(1) default b'0',
  PRIMARY KEY  (`overviewId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Information about a project proposal';



# Dump of table ProjectOverview_Note
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ProjectOverview_Note`;

CREATE TABLE `ProjectOverview_Note` (
  `overview_overviewId` bigint(20) NOT NULL,
  `notes_noteId` bigint(20) NOT NULL,
  PRIMARY KEY  (`overview_overviewId`,`notes_noteId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table QCType
# ------------------------------------------------------------

DROP TABLE IF EXISTS `QCType`;

CREATE TABLE `QCType` (
  `qcTypeId` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `qcTarget` varchar(50) NOT NULL,
  `units` varchar(20) NOT NULL,
  PRIMARY KEY  (`qcTypeId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Request
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Request`;

CREATE TABLE `Request` (
  `requestId` bigint(20) NOT NULL auto_increment,
  `creationDate` datetime default NULL,
  `description` varchar(255) default NULL,
  `executionCount` int(11) NOT NULL,
  `lastExecutionDate` datetime default NULL,
  `name` varchar(255) default NULL,
  `protocolUniqueIdentifier` varchar(255) default NULL,
  `project_projectId` bigint(20) default NULL,
  `securityProfile_profileId` bigint(20) default NULL,
  PRIMARY KEY  (`requestId`),
  KEY `FKA4878A6F60F9CBA8` (`securityProfile_profileId`),
  KEY `FKA4878A6F25FFBF98` (`project_projectId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Request_Note
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Request_Note`;

CREATE TABLE `Request_Note` (
  `Request_requestId` bigint(20) NOT NULL,
  `notes_noteId` bigint(20) NOT NULL,
  UNIQUE KEY `notes_noteId` (`notes_noteId`),
  KEY `FK57687FE2A7DC4D2C` (`notes_noteId`),
  KEY `FK57687FE2E8B554FA` (`Request_requestId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Run
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Run`;

CREATE TABLE `Run` (
  `runId` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `accession` varchar(50) default NULL,
  `platformRunId` int(11) default NULL,
  `pairedEnd` tinyint(1) NOT NULL default '0',
  `cycles` smallint(6) default NULL,
  `filePath` varchar(255) default NULL,
  `securityProfile_profileId` bigint(20) default NULL,
  `platformType` varchar(50) NOT NULL,
  `status_statusId` bigint(20) default NULL,
  `alias` varchar(255) default NULL,
  `sequencerReference_sequencerReferenceId` bigint(20) NOT NULL,
  PRIMARY KEY  (`runId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Dump of table Run_Flowcell
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Run_Flowcell`;

CREATE TABLE `Run_Flowcell` (
  `Run_runId` bigint(20) NOT NULL,
  `flowcells_flowcellId` bigint(20) NOT NULL,
  PRIMARY KEY  (`Run_runId`,`flowcells_flowcellId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Run_Note
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Run_Note`;

CREATE TABLE `Run_Note` (
  `run_runId` bigint(20) NOT NULL,
  `notes_noteId` bigint(20) NOT NULL,
  PRIMARY KEY  (`run_runId`,`notes_noteId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Run_SequencerPartitionContainer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Run_SequencerPartitionContainer`;

CREATE TABLE `Run_SequencerPartitionContainer` (
  `Run_runId` bigint(20) NOT NULL,
  `containers_containerId` bigint(20) NOT NULL,
  PRIMARY KEY  (`Run_runId`,`containers_containerId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table RunQC
# ------------------------------------------------------------

DROP TABLE IF EXISTS `RunQC`;

CREATE TABLE `RunQC` (
  `qcId` bigint(20) NOT NULL auto_increment,
  `run_runId` bigint(20) NOT NULL,
  `qcUserName` varchar(255) NOT NULL,
  `qcDate` date NOT NULL,
  `qcMethod` bigint(20) NOT NULL,
  `information` text,
  `doNotProcess` bit(1) NOT NULL default b'0',
  PRIMARY KEY  (`qcId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table RunQC_Partition
# ------------------------------------------------------------

DROP TABLE IF EXISTS `RunQC_Partition`;

CREATE TABLE `RunQC_Partition` (
  `runQc_runQcId` bigint(20) NOT NULL,
  `containers_containerId` bigint(20) NOT NULL default '0',
  `partitionNumber` tinyint(2) NOT NULL,
  PRIMARY KEY  (`runQc_runQcId`,`containers_containerId`,`partitionNumber`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Sample
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Sample`;

CREATE TABLE `Sample` (
  `sampleId` bigint(20) NOT NULL auto_increment,
  `accession` varchar(50) default NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `securityProfile_profileId` bigint(20) default NULL,
  `identificationBarcode` varchar(255) default NULL,
  `locationBarcode` varchar(255) default NULL,
  `sampleType` varchar(50) NOT NULL,
  `receivedDate` date default NULL,
  `qcPassed` varchar(5) default NULL,
  `alias` varchar(100) default NULL,
  `project_projectId` bigint(20) NOT NULL,
  `scientificName` varchar(255) NOT NULL,
  `taxonIdentifier` varchar(255) default NULL,
  PRIMARY KEY  (`sampleId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Dump of table Sample_Note
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Sample_Note`;

CREATE TABLE `Sample_Note` (
  `sample_sampleId` bigint(20) NOT NULL,
  `notes_noteId` bigint(20) NOT NULL,
  PRIMARY KEY  (`sample_sampleId`,`notes_noteId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table SampleQC
# ------------------------------------------------------------

DROP TABLE IF EXISTS `SampleQC`;

CREATE TABLE `SampleQC` (
  `qcId` bigint(20) NOT NULL auto_increment,
  `sample_sampleId` bigint(20) NOT NULL,
  `qcUserName` varchar(255) NOT NULL,
  `qcDate` date NOT NULL,
  `qcMethod` bigint(20) default NULL,
  `results` double default NULL,
  PRIMARY KEY  (`qcId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table SampleType
# ------------------------------------------------------------

DROP TABLE IF EXISTS `SampleType`;

CREATE TABLE `SampleType` (
  `typeId` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`typeId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table SecurityProfile
# ------------------------------------------------------------

DROP TABLE IF EXISTS `SecurityProfile`;

CREATE TABLE `SecurityProfile` (
  `profileId` bigint(20) NOT NULL auto_increment,
  `allowAllInternal` bit(1) NOT NULL,
  `owner_userId` bigint(20) default NULL,
  PRIMARY KEY  (`profileId`),
  KEY `FK18AEBA294140968C` (`owner_userId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table SecurityProfile_ReadGroup
# ------------------------------------------------------------

DROP TABLE IF EXISTS `SecurityProfile_ReadGroup`;

CREATE TABLE `SecurityProfile_ReadGroup` (
  `SecurityProfile_profileId` bigint(20) NOT NULL,
  `readGroup_groupId` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Dump of table SecurityProfile_ReadUser
# ------------------------------------------------------------

DROP TABLE IF EXISTS `SecurityProfile_ReadUser`;

CREATE TABLE `SecurityProfile_ReadUser` (
  `SecurityProfile_profileId` bigint(20) NOT NULL,
  `readUser_userId` bigint(20) NOT NULL,
  KEY `FKD4CF504160F9CBA8` (`SecurityProfile_profileId`),
  KEY `FKD4CF504125267E4D` (`readUser_userId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table SecurityProfile_WriteGroup
# ------------------------------------------------------------

DROP TABLE IF EXISTS `SecurityProfile_WriteGroup`;

CREATE TABLE `SecurityProfile_WriteGroup` (
  `SecurityProfile_profileId` bigint(20) NOT NULL,
  `writeGroup_groupId` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table SecurityProfile_WriteUser
# ------------------------------------------------------------

DROP TABLE IF EXISTS `SecurityProfile_WriteUser`;

CREATE TABLE `SecurityProfile_WriteUser` (
  `SecurityProfile_profileId` bigint(20) NOT NULL,
  `writeUser_userId` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Dump of table SequencerPartitionContainer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `SequencerPartitionContainer`;

CREATE TABLE `SequencerPartitionContainer` (
  `containerId` bigint(20) NOT NULL auto_increment,
  `securityProfile_profileId` bigint(20) default NULL,
  `identificationBarcode` varchar(255) default NULL,
  `locationBarcode` varchar(255) default NULL,
  `platformType` varchar(50) default NULL,
  `validationBarcode` varchar(255) default NULL,
  PRIMARY KEY  (`containerId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Dump of table SequencerPartitionContainer_Partition
# ------------------------------------------------------------

DROP TABLE IF EXISTS `SequencerPartitionContainer_Partition`;

CREATE TABLE `SequencerPartitionContainer_Partition` (
  `container_containerId` bigint(20) NOT NULL,
  `partitions_partitionId` bigint(20) NOT NULL,
  PRIMARY KEY  (`container_containerId`,`partitions_partitionId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table SequencerReference
# ------------------------------------------------------------

DROP TABLE IF EXISTS `SequencerReference`;

CREATE TABLE `SequencerReference` (
  `referenceId` bigint(20) NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `ipAddress` blob NOT NULL,
  `platformId` bigint(20) NOT NULL,
  `available` bit(1) NOT NULL default b'0',
  PRIMARY KEY  (`referenceId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Status
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Status`;

CREATE TABLE `Status` (
  `statusId` bigint(20) NOT NULL auto_increment,
  `health` varchar(50) NOT NULL default 'Unknown',
  `completionDate` date default NULL,
  `startDate` date default NULL,
  `instrumentName` varchar(255) NOT NULL,
  `lastUpdated` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `runName` varchar(255) NOT NULL,
  `xml` longblob,
  PRIMARY KEY  (`statusId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Dump of table Study
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Study`;

CREATE TABLE `Study` (
  `studyId` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `accession` varchar(30) default NULL,
  `securityProfile_profileId` bigint(20) default NULL,
  `project_projectId` bigint(20) NOT NULL,
  `studyType` varchar(255) default NULL,
  `alias` varchar(100) default NULL,
  PRIMARY KEY  (`studyId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;



# Dump of table Study_Experiment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Study_Experiment`;

CREATE TABLE `Study_Experiment` (
  `Study_studyId` bigint(20) NOT NULL,
  `experiments_experimentId` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table StudyType
# ------------------------------------------------------------

DROP TABLE IF EXISTS `StudyType`;

CREATE TABLE `StudyType` (
  `typeId` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY  (`typeId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Submission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Submission`;

CREATE TABLE `Submission` (
  `submissionId` bigint(20) NOT NULL auto_increment,
  `creationDate` date NOT NULL,
  `submittedDate` date default NULL,
  `verified` bit(1) default b'0',
  `description` varchar(255) default NULL,
  `name` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  `accession` varchar(50) default NULL,
  `alias` varchar(100) default NULL,
  `completed` bit(1) default b'0',
  PRIMARY KEY  (`submissionId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Submission_Chamber
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Submission_Chamber`;

CREATE TABLE `Submission_Chamber` (
  `submission_submissionId` bigint(20) NOT NULL,
  `chambers_chamberId` bigint(20) NOT NULL,
  PRIMARY KEY  (`submission_submissionId`,`chambers_chamberId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Submission_Experiment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Submission_Experiment`;

CREATE TABLE `Submission_Experiment` (
  `submission_submissionId` bigint(20) NOT NULL,
  `experiments_experimentId` bigint(20) NOT NULL,
  PRIMARY KEY  (`submission_submissionId`,`experiments_experimentId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Submission_Lane
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Submission_Lane`;

CREATE TABLE `Submission_Lane` (
  `submission_submissionId` bigint(20) NOT NULL,
  `lanes_laneId` bigint(20) NOT NULL,
  PRIMARY KEY  (`submission_submissionId`,`lanes_laneId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Submission_Partition
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Submission_Partition`;

CREATE TABLE `Submission_Partition` (
  `submission_submissionId` bigint(20) NOT NULL,
  `partitions_partitionId` bigint(20) NOT NULL,
  PRIMARY KEY  (`submission_submissionId`,`partitions_partitionId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Submission_Partition_Dilution
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Submission_Partition_Dilution`;

CREATE TABLE `Submission_Partition_Dilution` (
  `submission_submissionId` bigint(20) NOT NULL,
  `partition_partitionId` bigint(20) NOT NULL,
  `dilution_dilutionId` bigint(20) NOT NULL,
  PRIMARY KEY  (`submission_submissionId`,`partition_partitionId`,`dilution_dilutionId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Submission_Sample
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Submission_Sample`;

CREATE TABLE `Submission_Sample` (
  `submission_submissionId` bigint(20) NOT NULL,
  `samples_sampleId` bigint(20) NOT NULL,
  PRIMARY KEY  (`submission_submissionId`,`samples_sampleId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Submission_Study
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Submission_Study`;

CREATE TABLE `Submission_Study` (
  `submission_submissionId` bigint(20) NOT NULL,
  `studies_studyId` bigint(20) NOT NULL,
  PRIMARY KEY  (`submission_submissionId`,`studies_studyId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table TagBarcodes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `TagBarcodes`;

CREATE TABLE `TagBarcodes` (
  `tagId` bigint(20) NOT NULL auto_increment,
  `name` varchar(10) NOT NULL,
  `sequence` varchar(20) NOT NULL,
  `platformName` varchar(20) NOT NULL,
  `strategyName` varchar(100) NOT NULL,
  PRIMARY KEY  (`tagId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table User
# ------------------------------------------------------------

DROP TABLE IF EXISTS `User`;

CREATE TABLE `User` (
  `userId` bigint(20) NOT NULL auto_increment,
  `active` bit(1) NOT NULL,
  `admin` bit(1) NOT NULL,
  `external` bit(1) NOT NULL,
  `fullName` varchar(255) default NULL,
  `internal` bit(1) NOT NULL,
  `loginName` varchar(255) default NULL,
  `roles` blob,
  `password` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  PRIMARY KEY  (`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table User_Group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `User_Group`;

CREATE TABLE `User_Group` (
  `users_userId` bigint(20) NOT NULL,
  `groups_groupId` bigint(20) NOT NULL,
  KEY `FKE7B7ED0B94349B7F` (`groups_groupId`),
  KEY `FKE7B7ED0B749D8197` (`users_userId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table Watcher
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Watcher`;

CREATE TABLE `Watcher` (
  `entityName` varchar(12) NOT NULL,
  `userId` bigint(20) NOT NULL,
  PRIMARY KEY  (`entityName`,`userId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
