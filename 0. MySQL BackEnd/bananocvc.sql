-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 14, 2020 at 06:34 PM
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
  `attrname` varchar(255) DEFAULT NULL,
  `projectid` int(11) DEFAULT NULL,
  `componentid` int(11) DEFAULT NULL,
  `defaultvalue` varchar(255) DEFAULT NULL,
  `attrtype` varchar(255) DEFAULT NULL,
  `attrdescription` varchar(255) DEFAULT NULL,
  `attrhasset` varchar(255) DEFAULT NULL,
  `attrhasget` varchar(255) DEFAULT NULL,
  `attroptions` varchar(255) DEFAULT NULL,
  `attrmin` varchar(255) DEFAULT NULL,
  `attrmax` varchar(255) DEFAULT NULL,
  `attronsub` varchar(255) DEFAULT NULL,
  `attroninit` varchar(255) DEFAULT NULL,
  `attrdesigner` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attributes`
--

INSERT INTO `attributes` (`attrid`, `attrname`, `projectid`, `componentid`, `defaultvalue`, `attrtype`, `attrdescription`, `attrhasset`, `attrhasget`, `attroptions`, `attrmin`, `attrmax`, `attronsub`, `attroninit`, `attrdesigner`) VALUES
(1, 'role', 1, 1, 'alert', 'String', '', 'No', 'No', '', '', '', 'No', 'No', 'No'),
(2, 'href', 1, 3, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(3, 'type', 1, 8, 'button', 'String', '', 'No', 'No', '', '', '', 'No', 'No', 'No');

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `classid` int(11) NOT NULL,
  `classname` varchar(255) DEFAULT NULL,
  `projectid` int(11) DEFAULT NULL,
  `componentid` int(11) DEFAULT NULL,
  `defaultvalue` varchar(255) DEFAULT NULL,
  `classtype` varchar(255) DEFAULT NULL,
  `classdescription` varchar(255) DEFAULT NULL,
  `classhasset` varchar(255) DEFAULT NULL,
  `classhasget` varchar(255) DEFAULT NULL,
  `classoptions` varchar(255) DEFAULT NULL,
  `classmin` varchar(255) DEFAULT NULL,
  `classmax` varchar(255) DEFAULT NULL,
  `classonsub` varchar(255) DEFAULT NULL,
  `classoninit` varchar(255) DEFAULT NULL,
  `classdesigner` varchar(255) DEFAULT NULL,
  `classaddoncondition` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`classid`, `classname`, `projectid`, `componentid`, `defaultvalue`, `classtype`, `classdescription`, `classhasset`, `classhasget`, `classoptions`, `classmin`, `classmax`, `classonsub`, `classoninit`, `classdesigner`, `classaddoncondition`) VALUES
(1, 'alert', 1, 1, 'alert', 'String', '', 'No', 'No', '', '', '', 'No', 'No', 'No', 'None'),
(2, 'alert-type', 1, 1, '', 'String', '', 'Yes', 'Yes', 'alert-primary|alert-secondary|alert-success|alert-danger|alert-warning|alert-info|alert-light|alert-dark', '', '', 'No', 'No', 'Yes', 'None'),
(3, 'alert-dismissible', 1, 1, '', 'Boolean', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes', 'True'),
(4, 'badge', 1, 2, 'badge', 'String', '', 'No', 'No', '', '', '', 'No', 'No', 'No', 'None'),
(5, 'badge-type', 1, 2, '', 'String', '', 'Yes', 'Yes', 'badge-primary|badge-secondary|badge-success|badge-danger|badge-warning|badge-info|badge-light|badge-dark', '', '', 'No', 'No', 'Yes', 'None'),
(6, 'badge-pill', 1, 2, '', 'Boolean', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes', 'True'),
(7, 'badge', 1, 3, '', 'Boolean', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes', 'True'),
(8, 'badge-type', 1, 3, '', 'String', '', 'Yes', 'Yes', 'badge-primary|badge-secondary|badge-success|badge-danger|badge-warning|badge-info|badge-light|badge-dark|none', '', '', 'No', 'No', 'Yes', 'None'),
(9, 'alert-link', 1, 3, '', 'Boolean', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes', 'True'),
(10, 'btn', 1, 8, 'btn', 'String', '', 'No', 'No', '', '', '', 'No', 'No', 'No', 'None'),
(11, 'btn-link', 1, 8, '', 'Boolean', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes', 'True'),
(12, 'outline', 1, 8, '', 'String', '', 'Yes', 'Yes', 'btn-outline-primary|btn-outline-secondary|btn-outline-success|btn-outline-danger|btn-outline-warning|btn-outline-info|btn-outline-light|btn-outline-dark|none', '', '', 'No', 'No', 'Yes', 'None'),
(13, 'Size', 1, 8, '', 'String', '', 'Yes', 'Yes', 'btn-small|btn-lg|normal', '', '', 'No', 'No', 'Yes', 'None'),
(14, 'btn-block', 1, 8, '', 'Boolean', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes', 'True'),
(15, 'active', 1, 8, '', 'Boolean', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes', 'True'),
(16, 'disabled', 1, 8, '', 'Boolean', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes', 'True'),
(17, 'fore-color', 1, 8, '', 'String', '', 'Yes', 'Yes', 'btn-primary|btn-secondary|btn-success|btn-danger|btn-warning|btn-info|btn-light|btn-dark|none', '', '', 'No', 'No', 'Yes', 'None');

-- --------------------------------------------------------

--
-- Table structure for table `components`
--

CREATE TABLE `components` (
  `componentid` int(11) NOT NULL,
  `projectid` int(11) DEFAULT NULL,
  `componenttag` varchar(255) DEFAULT NULL,
  `componentdescription` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `components`
--

INSERT INTO `components` (`componentid`, `projectid`, `componenttag`, `componentdescription`) VALUES
(1, 1, 'div', 'Alert'),
(2, 1, 'span', 'Badge'),
(3, 1, 'a', 'Anchor'),
(4, 1, 'ol', 'OrderedList'),
(5, 1, 'ul', 'Unordered List'),
(6, 1, 'li', 'List Item'),
(7, 1, 'div', 'Div'),
(8, 1, 'button', 'Button');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `eventid` int(11) NOT NULL,
  `eventname` varchar(255) DEFAULT NULL,
  `eventarguments` varchar(255) DEFAULT NULL,
  `eventactive` varchar(255) DEFAULT NULL,
  `projectid` int(11) DEFAULT NULL,
  `componentid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`eventid`, `eventname`, `eventarguments`, `eventactive`, `projectid`, `componentid`) VALUES
(1, 'click', 'event As BANanoEvent', 'Yes', 1, 1),
(2, 'click', 'event as BANanoEvent', 'Yes', 1, 2),
(3, 'click', 'event As BANanoEvent', 'Yes', 1, 8);

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `projectid` int(11) NOT NULL,
  `projectname` varchar(255) DEFAULT NULL,
  `projectauthor` varchar(255) DEFAULT NULL,
  `projectversion` varchar(255) DEFAULT NULL,
  `projectprefix` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`projectid`, `projectname`, `projectauthor`, `projectversion`, `projectprefix`) VALUES
(1, 'BANanoBootstrap', 'Anele Mashy Mbanga', '1.00', 'TB');

-- --------------------------------------------------------

--
-- Table structure for table `styles`
--

CREATE TABLE `styles` (
  `styleid` int(11) NOT NULL,
  `stylename` varchar(255) DEFAULT NULL,
  `projectid` int(11) DEFAULT NULL,
  `componentid` int(11) DEFAULT NULL,
  `defaultvalue` varchar(255) DEFAULT NULL,
  `styletype` varchar(255) DEFAULT NULL,
  `styledescription` varchar(255) DEFAULT NULL,
  `stylehasset` varchar(255) DEFAULT NULL,
  `stylehasget` varchar(255) DEFAULT NULL,
  `styleoptions` varchar(255) DEFAULT NULL,
  `stylemin` varchar(255) DEFAULT NULL,
  `stylemax` varchar(255) DEFAULT NULL,
  `styleonsub` varchar(255) DEFAULT NULL,
  `styleoninit` varchar(255) DEFAULT NULL,
  `styledesigner` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `styles`
--

INSERT INTO `styles` (`styleid`, `stylename`, `projectid`, `componentid`, `defaultvalue`, `styletype`, `styledescription`, `stylehasset`, `stylehasget`, `styleoptions`, `stylemin`, `stylemax`, `styleonsub`, `styleoninit`, `styledesigner`) VALUES
(1, 'margin-top', 1, 1, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(2, 'margin-bottom', 1, 1, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(3, 'margin-left', 1, 1, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(4, 'margin-right', 1, 1, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(5, 'padding-top', 1, 1, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(6, 'padding-left', 1, 1, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(7, 'padding-bottom', 1, 1, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(8, 'padding-right', 1, 1, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(17, 'margin-top', 1, 2, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(18, 'margin-bottom', 1, 2, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(19, 'margin-left', 1, 2, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(20, 'margin-right', 1, 2, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(21, 'padding-top', 1, 2, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(22, 'padding-bottom', 1, 2, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(23, 'padding-left', 1, 2, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(24, 'padding-right', 1, 2, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(25, 'margin-top', 1, 3, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(26, 'margin-bottom', 1, 3, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(27, 'margin-left', 1, 3, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(28, 'margin-right', 1, 3, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(29, 'padding-top', 1, 3, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(30, 'padding-bottom', 1, 3, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(31, 'padding-left', 1, 3, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(32, 'padding-right', 1, 3, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(33, 'margin-top', 1, 4, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(34, 'margin-bottom', 1, 4, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(35, 'margin-left', 1, 4, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(36, 'margin-right', 1, 4, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(37, 'padding-top', 1, 4, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(38, 'padding-bottom', 1, 4, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(39, 'padding-left', 1, 4, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(40, 'padding-right', 1, 4, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(41, 'margin-top', 1, 8, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(42, 'margin-bottom', 1, 8, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(43, 'margin-left', 1, 8, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(44, 'margin-right', 1, 8, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(45, 'padding-top', 1, 8, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(46, 'padding-bottom', 1, 8, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(47, 'padding-left', 1, 8, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes'),
(48, 'padding-right', 1, 8, '', 'String', '', 'Yes', 'Yes', '', '', '', 'No', 'No', 'Yes');

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
  MODIFY `attrid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `classid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `components`
--
ALTER TABLE `components`
  MODIFY `componentid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `eventid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `projectid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `styles`
--
ALTER TABLE `styles`
  MODIFY `styleid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
