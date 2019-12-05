-- MySQL dump 10.13  Distrib 8.0.15, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: tei_xml_db
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

DROP TABLE IF EXISTS `bibliography`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bibliography` (
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
-- Dumping data for table `bibliography`
--

LOCK TABLES `bibliography` WRITE;
/*!40000 ALTER TABLE `bibliography` DISABLE KEYS */;
/*!40000 ALTER TABLE `bibliography` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Citation`
--

DROP TABLE IF EXISTS `citation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `citation` (
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

LOCK TABLES `citation` WRITE;
/*!40000 ALTER TABLE `citation` DISABLE KEYS */;
/*!40000 ALTER TABLE `citation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citation_definition`
--

DROP TABLE IF EXISTS `citation_definition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `citation_definition` (
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
-- Dumping data for table `citation_definition`
--

LOCK TABLES `citation_definition` WRITE;
/*!40000 ALTER TABLE `citation_definition` DISABLE KEYS */;
/*!40000 ALTER TABLE `citation_definition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `definition`
--

DROP TABLE IF EXISTS `definition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `definition` (
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
-- Dumping data for table `definition`
--

LOCK TABLES `definition` WRITE;
/*!40000 ALTER TABLE `definition` DISABLE KEYS */;
/*!40000 ALTER TABLE `definition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entry`
--

DROP TABLE IF EXISTS `entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `entry` (
  `entryId` int(11) NOT NULL AUTO_INCREMENT,
  `id` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `lang` char(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`entryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entry`
--

LOCK TABLES `entry` WRITE;
/*!40000 ALTER TABLE `entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entry_usage`
--

DROP TABLE IF EXISTS `entry_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `entry_usage` (
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

LOCK TABLES `entry_usage` WRITE;
/*!40000 ALTER TABLE `entry_usage` DISABLE KEYS */;
/*!40000 ALTER TABLE `entry_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form`
--

DROP TABLE IF EXISTS `form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `form` (
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
-- Dumping data for table `form`
--

LOCK TABLES `form` WRITE;
/*!40000 ALTER TABLE `form` DISABLE KEYS */;
/*!40000 ALTER TABLE `form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FormGrammarGroup`
--

DROP TABLE IF EXISTS `form_grammar_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `form_grammar_group` (
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

LOCK TABLES `form_grammar_group` WRITE;
/*!40000 ALTER TABLE `form_grammar_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_grammar_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grammar_group`
--

DROP TABLE IF EXISTS `grammar_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `grammar_group` (
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
-- Dumping data for table `grammar_group`
--

LOCK TABLES `grammar_group` WRITE;
/*!40000 ALTER TABLE `grammar_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `grammar_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `note` (
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
-- Dumping data for table `note`
--

LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orth`
--

DROP TABLE IF EXISTS `orth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `orth` (
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
-- Dumping data for table `orth`
--

LOCK TABLES `orth` WRITE;
/*!40000 ALTER TABLE `orth` DISABLE KEYS */;
/*!40000 ALTER TABLE `orth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `place`
--

DROP TABLE IF EXISTS `place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `place` (
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
-- Dumping data for table `place`
--

LOCK TABLES `place` WRITE;
/*!40000 ALTER TABLE `place` DISABLE KEYS */;
/*!40000 ALTER TABLE `place` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pronunciation`
--

DROP TABLE IF EXISTS `pronunciation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `pronunciation` (
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
-- Dumping data for table `pronunciation`
--

LOCK TABLES `pronunciation` WRITE;
/*!40000 ALTER TABLE `pronunciation` DISABLE KEYS */;
/*!40000 ALTER TABLE `pronunciation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quote`
--

DROP TABLE IF EXISTS `quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `quote` (
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
-- Dumping data for table `quote`
--

LOCK TABLES `quote` WRITE;
/*!40000 ALTER TABLE `quote` DISABLE KEYS */;
/*!40000 ALTER TABLE `quote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reference`
--

DROP TABLE IF EXISTS `reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `reference` (
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
-- Dumping data for table `reference`
--

LOCK TABLES `reference` WRITE;
/*!40000 ALTER TABLE `reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sense`
--

DROP TABLE IF EXISTS `sense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sense` (
  `senseId` int(11) NOT NULL AUTO_INCREMENT,
  `corresp` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Entry_entryId` int(11) NOT NULL,
  PRIMARY KEY (`senseId`,`Entry_entryId`),
  KEY `fk_Sense_Entry1_idx` (`Entry_entryId`),
  CONSTRAINT `fk_Sense_Entry1` FOREIGN KEY (`Entry_entryId`) REFERENCES `entry` (`entryId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sense`
--

LOCK TABLES `sense` WRITE;
/*!40000 ALTER TABLE `sense` DISABLE KEYS */;
/*!40000 ALTER TABLE `sense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SenseDefinition`
--

DROP TABLE IF EXISTS `sense_definition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sense_definition` (
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

LOCK TABLES `sense_definition` WRITE;
/*!40000 ALTER TABLE `sense_definition` DISABLE KEYS */;
/*!40000 ALTER TABLE `sense_definition` ENABLE KEYS */;
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
