-- MySQL dump 10.13  Distrib 8.0.15, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: TEI_XML_db
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Citation`
--

DROP TABLE IF EXISTS `Citation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Citation` (
  `citationId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `n` int(11) DEFAULT NULL,
  PRIMARY KEY (`citationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Citation`
--

LOCK TABLES `Citation` WRITE;
/*!40000 ALTER TABLE `Citation` DISABLE KEYS */;
/*!40000 ALTER TABLE `Citation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CitationDefinition`
--

DROP TABLE IF EXISTS `CitationDefinition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `CitationDefinition` (
  `citationDefinitionId` int(11) NOT NULL AUTO_INCREMENT,
  `citationId` int(11) DEFAULT NULL,
  `definitionId` int(11) DEFAULT NULL,
  PRIMARY KEY (`citationDefinitionId`),
  KEY `CitationId_idx` (`citationId`),
  KEY `DefinitionId_FK_idx` (`definitionId`),
  CONSTRAINT `CitationId_FK` FOREIGN KEY (`citationId`) REFERENCES `citation` (`citationId`),
  CONSTRAINT `DefinitionId_FK` FOREIGN KEY (`definitionId`) REFERENCES `definition` (`DefinitionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CitationDefinition`
--

LOCK TABLES `CitationDefinition` WRITE;
/*!40000 ALTER TABLE `CitationDefinition` DISABLE KEYS */;
/*!40000 ALTER TABLE `CitationDefinition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Definition`
--

DROP TABLE IF EXISTS `Definition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Definition` (
  `definitionId` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(50) DEFAULT NULL,
  `corresp` varchar(50) DEFAULT NULL,
  `definition` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`definitionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Definition`
--

LOCK TABLES `Definition` WRITE;
/*!40000 ALTER TABLE `Definition` DISABLE KEYS */;
/*!40000 ALTER TABLE `Definition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Entry`
--

DROP TABLE IF EXISTS `Entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Entry` (
  `entryId` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(200) NOT NULL,
  `lang` char(50) DEFAULT NULL,
  PRIMARY KEY (`entryId`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Entry`
--

LOCK TABLES `Entry` WRITE;
/*!40000 ALTER TABLE `Entry` DISABLE KEYS */;
INSERT INTO `Entry` VALUES (9,'d175_qdb-d1e2','bar'),(10,'d175_qdb-d1e35','bar');
/*!40000 ALTER TABLE `Entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Form`
--

DROP TABLE IF EXISTS `Form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Form` (
  `formId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `n` int(11) DEFAULT NULL,
  `entryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`formId`),
  KEY `EntryId_idx` (`entryId`),
  CONSTRAINT `FormEntryId` FOREIGN KEY (`entryId`) REFERENCES `entry` (`entryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Form`
--

LOCK TABLES `Form` WRITE;
/*!40000 ALTER TABLE `Form` DISABLE KEYS */;
/*!40000 ALTER TABLE `Form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GrammarGroup`
--

DROP TABLE IF EXISTS `GrammarGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `GrammarGroup` (
  `grammarGroupId` int(11) NOT NULL AUTO_INCREMENT,
  `gram` varchar(50) DEFAULT NULL,
  `pos` varchar(50) DEFAULT NULL,
  `entryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`grammarGroupId`),
  KEY `EntryId_idx` (`entryId`),
  CONSTRAINT `EntryId` FOREIGN KEY (`entryId`) REFERENCES `entry` (`entryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GrammarGroup`
--

LOCK TABLES `GrammarGroup` WRITE;
/*!40000 ALTER TABLE `GrammarGroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `GrammarGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Note`
--

DROP TABLE IF EXISTS `Note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Note` (
  `noteId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `resp` varchar(200) DEFAULT NULL,
  `corresp` varchar(50) DEFAULT NULL,
  `note` varchar(300) DEFAULT NULL,
  `entryid` int(11) DEFAULT NULL,
  PRIMARY KEY (`noteId`),
  KEY `Entry_idx` (`entryid`),
  CONSTRAINT `NoteEntry` FOREIGN KEY (`entryid`) REFERENCES `entry` (`entryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Note`
--

LOCK TABLES `Note` WRITE;
/*!40000 ALTER TABLE `Note` DISABLE KEYS */;
/*!40000 ALTER TABLE `Note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orth`
--

DROP TABLE IF EXISTS `orth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `orth` (
  `orthId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `orth` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`orthId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orth`
--

LOCK TABLES `orth` WRITE;
/*!40000 ALTER TABLE `orth` DISABLE KEYS */;
/*!40000 ALTER TABLE `orth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Place`
--

DROP TABLE IF EXISTS `Place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Place` (
  `placeId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`placeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Place`
--

LOCK TABLES `Place` WRITE;
/*!40000 ALTER TABLE `Place` DISABLE KEYS */;
/*!40000 ALTER TABLE `Place` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pronunciation`
--

DROP TABLE IF EXISTS `pronunciation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `pronunciation` (
  `pronunciationId` int(11) NOT NULL AUTO_INCREMENT,
  `notation` varchar(50) DEFAULT NULL,
  `resp` varchar(50) DEFAULT NULL,
  `change` varchar(50) DEFAULT NULL,
  `pron` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pronunciationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pronunciation`
--

LOCK TABLES `pronunciation` WRITE;
/*!40000 ALTER TABLE `pronunciation` DISABLE KEYS */;
/*!40000 ALTER TABLE `pronunciation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reference`
--

DROP TABLE IF EXISTS `Reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Reference` (
  `referenceId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  `ref` varchar(300) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL COMMENT 'This field needs further treatment as there are dates of various formats in the tei/xml file.',
  PRIMARY KEY (`referenceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reference`
--

LOCK TABLES `Reference` WRITE;
/*!40000 ALTER TABLE `Reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sense`
--

DROP TABLE IF EXISTS `Sense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Sense` (
  `senseId` int(11) NOT NULL AUTO_INCREMENT,
  `corresp` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`senseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sense`
--

LOCK TABLES `Sense` WRITE;
/*!40000 ALTER TABLE `Sense` DISABLE KEYS */;
/*!40000 ALTER TABLE `Sense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SenseDefinition`
--

DROP TABLE IF EXISTS `SenseDefinition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `SenseDefinition` (
  `senseDefinitionId` int(11) NOT NULL AUTO_INCREMENT,
  `senseId` int(11) DEFAULT NULL,
  `definitionId` int(11) DEFAULT NULL,
  PRIMARY KEY (`senseDefinitionId`),
  KEY `SenseId_FK_idx` (`senseId`),
  KEY `DefinitionId_Sense_FK_idx` (`definitionId`),
  CONSTRAINT `DefinitionId_Sense_FK` FOREIGN KEY (`definitionId`) REFERENCES `definition` (`definitionId`),
  CONSTRAINT `SenseId_FK` FOREIGN KEY (`senseId`) REFERENCES `sense` (`senseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SenseDefinition`
--

LOCK TABLES `SenseDefinition` WRITE;
/*!40000 ALTER TABLE `SenseDefinition` DISABLE KEYS */;
/*!40000 ALTER TABLE `SenseDefinition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usage`
--

DROP TABLE IF EXISTS `usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `usage` (
  `usageId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`usageId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usage`
--

LOCK TABLES `usage` WRITE;
/*!40000 ALTER TABLE `usage` DISABLE KEYS */;
/*!40000 ALTER TABLE `usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'TEI_XML_db'
--

--
-- Dumping routines for database 'TEI_XML_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-06 12:31:15
