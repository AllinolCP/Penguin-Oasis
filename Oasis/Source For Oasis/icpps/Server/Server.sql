-- phpMyAdmin SQL Dump
-- version 3.3.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 04, 2011 at 10:51 AM
-- Server version: 5.1.54
-- PHP Version: 5.3.5-1ubuntu7.2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `iCP`
--

-- --------------------------------------------------------

--
-- Table structure for table `accs`
--

CREATE TABLE IF NOT EXISTS `accs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL COMMENT 'Nickname',
  `crumbs` text NOT NULL COMMENT 'User Crumbs',
  `password` varchar(32) NOT NULL COMMENT 'Password MD5',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Accounts' AUTO_INCREMENT=2 ;
INSERT INTO `accs` (`ID`, `name`, `crumbs`, `password`) VALUES
(1, 'Riley', 'a:35:{s:5:"email";s:0:"";s:10:"registerIP";s:0:"";s:12:"registertime";i:1310859774;s:9:"lastLogin";i:1311354024;s:5:"color";i:1;s:4:"head";i:444;s:4:"face";i:0;s:4:"neck";i:0;s:4:"body";i:0;s:5:"hands";i:0;s:4:"feet";i:0;s:3:"pin";i:0;s:5:"photo";i:0;s:5:"items";a:13:{i:0;i:1;i:1;i:444;i:2;s:3:"100";i:3;s:3:"408";i:4;s:3:"111";i:5;s:3:"112";i:6;s:3:"551";i:7;s:3:"403";i:8;s:3:"492";i:9;s:3:"131";i:10;s:5:"14102";i:11;s:5:"11139";i:12;s:5:"10233";}s:5:"coins";i:1083901;s:11:"isModerator";b:1;s:9:"isBanned_";i:0;s:6:"EPF_OP";i:0;s:11:"MedalsTotal";i:0;s:11:"MedalUnused";i:0;s:7:"buddies";a:0:{}s:6:"ignore";a:0:{}s:6:"stamps";a:0:{}s:10:"stampColor";s:1:"6";s:14:"stampHighlight";s:2:"16";s:12:"stampPattern";s:1:"3";s:9:"stampIcon";s:1:"5";s:5:"igloo";i:1;s:6:"igloos";a:1:{i:0;i:1;}s:5:"music";i:0;s:5:"floor";i:0;s:9:"furniture";a:0:{}s:13:"roomFurniture";s:0:"";s:9:"postcards";a:0:{}s:11:"redemptions";a:1:{i:0;s:1:"3";}}', '837FDD644B8B9A1B4D537E9A9EADCDCB');

-- --------------------------------------------------------

--
-- Table structure for table `logins`
--

CREATE TABLE IF NOT EXISTS `logins` (
  `PlayerID` int(11) NOT NULL,
  `Name` text NOT NULL,
  `IP` text NOT NULL,
  `Timestamp` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Account Logins';

-- --------------------------------------------------------

--
-- Table structure for table `redemption`
--

CREATE TABLE IF NOT EXISTS `redemption` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Index',
  `Type` text NOT NULL COMMENT 'Type',
  `Code` text NOT NULL,
  `Items` text NOT NULL,
  `Coins` int(11) NOT NULL DEFAULT '0',
  `Expire` int(11) NOT NULL DEFAULT '0' COMMENT 'Unix expire date',
  `Uses` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Redemption Server Data' AUTO_INCREMENT=9 ;

INSERT INTO `redemption` (`ID`, `Type`, `Code`, `Items`, `Coins`, `Expire`, `Uses`) VALUES
(1, 'BLANKET', 'gbb5dt', '413', 1000000, 0, 1),
(2, 'BLANKET', 'jqoh7g', '413', 1000000, 0, 1),
(3, 'BLANKET', '0y04uw', '413', 1000000, 0, 1),
(4, 'BLANKET', 'osurw7', '413', 1000000, 0, 1),
(5, 'BLANKET', '76x0jp', '413', 1000000, 0, 1),
(6, 'BLANKET', 'mo78', '413', 1000000, 0, 1),
(7, 'BLANKET', 'dg8uqg', '413', 1000000, 0, 1),
(8, 'BLANKET', 'toiggy', '413', 1000000, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `stats`
--

CREATE TABLE IF NOT EXISTS `stats` (
  `ID` int(11) NOT NULL COMMENT 'Server ID',
  `population` int(11) NOT NULL COMMENT 'Population',
  `ts` text NOT NULL COMMENT 'Timestamp',
  UNIQUE KEY `ID` (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Servers';
