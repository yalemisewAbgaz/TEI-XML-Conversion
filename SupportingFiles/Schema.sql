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
-- Table structure for table `Bibliography`
--

DROP TABLE IF EXISTS `Bibliography`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Bibliography` (
  `bibliographyId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bibl` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Reference_referenceId` int(11) NOT NULL,
  `Reference_Entry_entryId` int(11) NOT NULL,
  PRIMARY KEY (`bibliographyId`,`Reference_referenceId`,`Reference_Entry_entryId`),
  KEY `fk_Bibliography_Reference1_idx` (`Reference_referenceId`,`Reference_Entry_entryId`),
  CONSTRAINT `fk_Bibliography_Reference1` FOREIGN KEY (`Reference_referenceId`, `Reference_Entry_entryId`) REFERENCES `reference` (`referenceId`, `Entry_entryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bibliography`
--

LOCK TABLES `Bibliography` WRITE;
/*!40000 ALTER TABLE `Bibliography` DISABLE KEYS */;
/*!40000 ALTER TABLE `Bibliography` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Citation`
--

DROP TABLE IF EXISTS `Citation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Citation` (
  `citationId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `n` int(11) DEFAULT NULL,
  `Entry_entryId` int(11) NOT NULL,
  PRIMARY KEY (`citationId`,`Entry_entryId`),
  KEY `fk_Citation_Entry1_idx` (`Entry_entryId`),
  CONSTRAINT `fk_Citation_Entry1` FOREIGN KEY (`Entry_entryId`) REFERENCES `entry` (`entryId`)
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
  `citationDefLang` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `citationDefCorresp` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `citationDefinition` varchar(300) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Citation_citationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`citationDefinitionId`),
  KEY `Citation_citationId` (`Citation_citationId`),
  CONSTRAINT `citationdefinition_ibfk_1` FOREIGN KEY (`Citation_citationId`) REFERENCES `citation` (`citationId`)
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
  `lang` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `corresp` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `definition` varchar(300) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Entry_entryId` int(11) NOT NULL,
  PRIMARY KEY (`definitionId`,`Entry_entryId`),
  KEY `fk_Definition_Entry1_idx` (`Entry_entryId`),
  CONSTRAINT `fk_Definition_Entry1` FOREIGN KEY (`Entry_entryId`) REFERENCES `entry` (`entryId`)
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
  `id` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `lang` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`entryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Entry`
--

LOCK TABLES `Entry` WRITE;
/*!40000 ALTER TABLE `Entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `Entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EntryUsage`
--

DROP TABLE IF EXISTS `EntryUsage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `EntryUsage` (
  `usageId` int(11) NOT NULL AUTO_INCREMENT,
  `usageType` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Entry_entryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`usageId`),
  KEY `Entry_entryId` (`Entry_entryId`),
  CONSTRAINT `entryusage_ibfk_1` FOREIGN KEY (`Entry_entryId`) REFERENCES `entry` (`entryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EntryUsage`
--

LOCK TABLES `EntryUsage` WRITE;
/*!40000 ALTER TABLE `EntryUsage` DISABLE KEYS */;
/*!40000 ALTER TABLE `EntryUsage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Form`
--

DROP TABLE IF EXISTS `Form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Form` (
  `formId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `n` int(11) DEFAULT NULL,
  `Entry_entryId` int(11) NOT NULL,
  PRIMARY KEY (`formId`,`Entry_entryId`),
  KEY `fk_Form_Entry1_idx` (`Entry_entryId`),
  CONSTRAINT `fk_Form_Entry1` FOREIGN KEY (`Entry_entryId`) REFERENCES `entry` (`entryId`)
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
-- Table structure for table `FormGrammarGroup`
--

DROP TABLE IF EXISTS `FormGrammarGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `FormGrammarGroup` (
  `formGramGroupId` int(11) NOT NULL AUTO_INCREMENT,
  `gram` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Form_formId` int(11) DEFAULT NULL,
  PRIMARY KEY (`formGramGroupId`),
  KEY `Form_formId` (`Form_formId`),
  CONSTRAINT `formgrammargroup_ibfk_1` FOREIGN KEY (`Form_formId`) REFERENCES `form` (`formId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FormGrammarGroup`
--

LOCK TABLES `FormGrammarGroup` WRITE;
/*!40000 ALTER TABLE `FormGrammarGroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `FormGrammarGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GrammarGroup`
--

DROP TABLE IF EXISTS `GrammarGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `GrammarGroup` (
  `grammarGroupId` int(11) NOT NULL AUTO_INCREMENT,
  `gram` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pos` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Entry_entryId` int(11) NOT NULL,
  PRIMARY KEY (`grammarGroupId`,`Entry_entryId`),
  KEY `fk_GrammarGroup_Entry1_idx` (`Entry_entryId`),
  CONSTRAINT `fk_GrammarGroup_Entry1` FOREIGN KEY (`Entry_entryId`) REFERENCES `entry` (`entryId`)
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
  `type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `resp` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `corresp` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `note` varchar(300) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `entryid` int(11) DEFAULT NULL,
  `Entry_entryId` int(11) NOT NULL,
  PRIMARY KEY (`noteId`,`Entry_entryId`),
  KEY `Entry_idx` (`entryid`),
  KEY `fk_Note_Entry1_idx` (`Entry_entryId`),
  CONSTRAINT `NoteEntry` FOREIGN KEY (`entryid`) REFERENCES `entry` (`entryId`),
  CONSTRAINT `fk_Note_Entry1` FOREIGN KEY (`Entry_entryId`) REFERENCES `entry` (`entryId`)
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
-- Table structure for table `Orth`
--

DROP TABLE IF EXISTS `Orth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Orth` (
  `orthId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `orth` varchar(300) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Form_formId` int(11) NOT NULL,
  PRIMARY KEY (`orthId`,`Form_formId`),
  KEY `fk_orth_Entry1_idx` (`Form_formId`),
  CONSTRAINT `fk_orth_Entry1` FOREIGN KEY (`Form_formId`) REFERENCES `form` (`formId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orth`
--

LOCK TABLES `Orth` WRITE;
/*!40000 ALTER TABLE `Orth` DISABLE KEYS */;
/*!40000 ALTER TABLE `Orth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Place`
--

DROP TABLE IF EXISTS `Place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Place` (
  `placeId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Entry_entryId` int(11) NOT NULL,
  PRIMARY KEY (`placeId`,`Entry_entryId`),
  KEY `fk_Place_Entry1_idx` (`Entry_entryId`),
  CONSTRAINT `fk_Place_Entry1` FOREIGN KEY (`Entry_entryId`) REFERENCES `entry` (`entryId`)
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
-- Table structure for table `Pronunciation`
--

DROP TABLE IF EXISTS `Pronunciation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Pronunciation` (
  `pronunciationId` int(11) NOT NULL AUTO_INCREMENT,
  `notation` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `resp` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `changes` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pron` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Form_formId` int(11) DEFAULT NULL,
  PRIMARY KEY (`pronunciationId`),
  KEY `Form_formId_idx` (`Form_formId`),
  CONSTRAINT `Form_formId` FOREIGN KEY (`Form_formId`) REFERENCES `form` (`formId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pronunciation`
--

LOCK TABLES `Pronunciation` WRITE;
/*!40000 ALTER TABLE `Pronunciation` DISABLE KEYS */;
/*!40000 ALTER TABLE `Pronunciation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Quote`
--

DROP TABLE IF EXISTS `Quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Quote` (
  `quoteId` int(11) NOT NULL,
  `resp` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `changes` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `quote` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Citation_citationId` int(11) NOT NULL,
  `Citation_Entry_entryId` int(11) NOT NULL,
  PRIMARY KEY (`quoteId`,`Citation_citationId`,`Citation_Entry_entryId`),
  KEY `fk_Quote_Citation1_idx` (`Citation_citationId`,`Citation_Entry_entryId`),
  CONSTRAINT `fk_Quote_Citation1` FOREIGN KEY (`Citation_citationId`, `Citation_Entry_entryId`) REFERENCES `citation` (`citationId`, `Entry_entryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Quote`
--

LOCK TABLES `Quote` WRITE;
/*!40000 ALTER TABLE `Quote` DISABLE KEYS */;
/*!40000 ALTER TABLE `Quote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reference`
--

DROP TABLE IF EXISTS `Reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Reference` (
  `referenceId` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ref` varchar(300) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `refDate` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'This field needs further treatment as there are dates of various formats in the tei/xml file.',
  `Entry_entryId` int(11) NOT NULL,
  PRIMARY KEY (`referenceId`,`Entry_entryId`),
  KEY `fk_Reference_Entry1_idx` (`Entry_entryId`),
  CONSTRAINT `fk_Reference_Entry1` FOREIGN KEY (`Entry_entryId`) REFERENCES `entry` (`entryId`)
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
  `corresp` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Entry_entryId` int(11) NOT NULL,
  PRIMARY KEY (`senseId`,`Entry_entryId`),
  KEY `fk_Sense_Entry1_idx` (`Entry_entryId`),
  CONSTRAINT `fk_Sense_Entry1` FOREIGN KEY (`Entry_entryId`) REFERENCES `entry` (`entryId`)
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
  `senseDefLang` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `senseDefCorresp` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `senseDefinition` varchar(300) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Sense_senseId` int(11) DEFAULT NULL,
  PRIMARY KEY (`senseDefinitionId`),
  KEY `Sense_senseId` (`Sense_senseId`),
  CONSTRAINT `sensedefinition_ibfk_1` FOREIGN KEY (`Sense_senseId`) REFERENCES `sense` (`senseId`)
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

-- Dump completed on 2019-11-29 13:20:13
