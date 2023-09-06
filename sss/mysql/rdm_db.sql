-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 06, 2023 at 02:39 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rdm_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `banned`
--

CREATE TABLE `banned` (
  `username` varchar(24) NOT NULL,
  `admin` varchar(24) NOT NULL,
  `user_ip` varchar(24) NOT NULL,
  `reason` varchar(128) NOT NULL,
  `date` varchar(27) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `Username` varchar(26) NOT NULL DEFAULT 'NONE',
  `Password` int(11) NOT NULL DEFAULT -1,
  `Email` varchar(35) NOT NULL,
  `Cash` int(11) NOT NULL DEFAULT -1,
  `Hours` float NOT NULL DEFAULT 0,
  `Admin` int(11) NOT NULL DEFAULT 0,
  `Premium` int(1) NOT NULL DEFAULT 0,
  `Deaths` int(11) NOT NULL DEFAULT 0,
  `Kills` int(11) NOT NULL DEFAULT 0,
  `Skin` int(11) NOT NULL DEFAULT 0,
  `Muted` int(11) NOT NULL DEFAULT 0,
  `Jailed` int(11) NOT NULL DEFAULT 0,
  `Rank` int(11) NOT NULL DEFAULT 0,
  `DutyTime` float NOT NULL DEFAULT 0,
  `Kicks` int(11) NOT NULL DEFAULT 0,
  `Bans` int(11) NOT NULL DEFAULT 0,
  `Jails` int(11) NOT NULL DEFAULT 0,
  `Mutes` int(11) NOT NULL DEFAULT 0,
  `Lang` int(2) NOT NULL DEFAULT 0,
  `InClan` int(1) NOT NULL DEFAULT 0,
  `ACode` int(11) NOT NULL DEFAULT 0,
  `Color` int(2) NOT NULL DEFAULT 0,
  `RegistrationDate` varchar(26) NOT NULL,
  `user_ip` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `Username`, `Password`, `Email`, `Cash`, `Hours`, `Admin`, `Premium`, `Deaths`, `Kills`, `Skin`, `Muted`, `Jailed`, `Rank`, `DutyTime`, `Kicks`, `Bans`, `Jails`, `Mutes`, `Lang`, `InClan`, `ACode`, `Color`, `RegistrationDate`, `user_ip`) VALUES
(3, 'Trifun', 70123830, 'trifuntata@gmail.com', 7100, 0.699998, 4, 0, 75, 88, 177, 0, 0, 0, 0.1, 0, 0, 3, 0, 2, 0, -1, 1, '05/11/2021 at 17:41:26', '127.0.0.1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `banned`
--
ALTER TABLE `banned`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
