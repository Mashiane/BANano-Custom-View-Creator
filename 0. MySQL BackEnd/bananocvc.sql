-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 14, 2020 at 01:46 AM
-- Server version: 5.7.24
-- PHP Version: 7.2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bananocvc`
--

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

CREATE TABLE `attributes` (
  `attrid` int(11) NOT NULL,
  `attrname` varchar(50) NOT NULL,
  `projectid` int(11) NOT NULL,
  `componentid` int(11) NOT NULL,
  `defaultvalue` varchar(50) NOT NULL,
  `attrtype` varchar(20) NOT NULL,
  `attrdescription` varchar(200) NOT NULL,
  `attrhasset` varchar(5) NOT NULL,
  `attrhasget` varchar(5) NOT NULL,
  `attroptions` varchar(255) NOT NULL,
  `attrmin` varchar(5) NOT NULL,
  `attrmax` varchar(5) NOT NULL,
  `attronsub` varchar(5) NOT NULL,
  `attroninit` varchar(5) NOT NULL,
  `attrdesigner` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `classid` int(11) NOT NULL,
  `classname` varchar(50) NOT NULL,
  `projectid` int(11) NOT NULL,
  `componentid` int(11) NOT NULL,
  `defaultvalue` varchar(50) NOT NULL,
  `classtype` varchar(20) NOT NULL,
  `classdescription` varchar(200) NOT NULL,
  `classhasset` varchar(5) NOT NULL,
  `classhasget` varchar(5) NOT NULL,
  `classoptions` varchar(255) NOT NULL,
  `classmin` varchar(5) NOT NULL,
  `classmax` varchar(5) NOT NULL,
  `classonsub` varchar(5) NOT NULL,
  `classoninit` varchar(5) NOT NULL,
  `classdesigner` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `components`
--

CREATE TABLE `components` (
  `componentid` int(11) NOT NULL,
  `projectid` int(11) NOT NULL,
  `componenttag` varchar(50) NOT NULL,
  `componentdescription` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `eventid` int(11) NOT NULL,
  `eventname` varchar(200) NOT NULL,
  `eventarguments` varchar(255) NOT NULL,
  `eventactive` varchar(10) NOT NULL,
  `projectid` int(11) NOT NULL,
  `componentid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `projectid` int(11) NOT NULL,
  `projectname` varchar(100) NOT NULL,
  `projectauthor` varchar(100) NOT NULL,
  `projectversion` varchar(10) NOT NULL,
  `projectprefix` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `styles`
--

CREATE TABLE `styles` (
  `styleid` int(11) NOT NULL,
  `stylename` varchar(50) NOT NULL,
  `projectid` int(11) NOT NULL,
  `componentid` int(11) NOT NULL,
  `defaultvalue` varchar(50) NOT NULL,
  `styletype` varchar(20) NOT NULL,
  `styledescription` varchar(200) NOT NULL,
  `stylehasset` varchar(5) NOT NULL,
  `stylehasget` varchar(5) NOT NULL,
  `styleoptions` varchar(255) NOT NULL,
  `stylemin` varchar(5) NOT NULL,
  `stylemax` varchar(5) NOT NULL,
  `styleonsub` varchar(5) NOT NULL,
  `styleoninit` varchar(5) NOT NULL,
  `styledesigner` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`attrid`);

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`classid`);

--
-- Indexes for table `components`
--
ALTER TABLE `components`
  ADD PRIMARY KEY (`componentid`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`eventid`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`projectid`);

--
-- Indexes for table `styles`
--
ALTER TABLE `styles`
  ADD PRIMARY KEY (`styleid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `attrid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `classid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `components`
--
ALTER TABLE `components`
  MODIFY `componentid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `eventid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `projectid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `styles`
--
ALTER TABLE `styles`
  MODIFY `styleid` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
