-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 17, 2021 at 03:32 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ramalan`
--

-- --------------------------------------------------------

--
-- Table structure for table `data_mentah`
--

CREATE TABLE `data_mentah` (
  `id` int(11) NOT NULL,
  `periode` int(3) DEFAULT NULL,
  `bulan` varchar(20) DEFAULT NULL,
  `tahun` year(4) DEFAULT NULL,
  `permintaan` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `data_mentah`
--

INSERT INTO `data_mentah` (`id`, `periode`, `bulan`, `tahun`, `permintaan`) VALUES
(13, 1, 'Januari', 2020, 38224),
(14, 2, 'Februari', 2020, 26670),
(15, 3, 'Maret', 2020, 35042),
(16, 4, 'April', 2020, 28300),
(17, 5, 'Mei', 2020, 39100),
(18, 6, 'Juni', 2020, 35570),
(19, 7, 'Juli', 2020, 38224),
(20, 8, 'Agustus', 2020, 46973),
(21, 9, 'September', 2020, 41660),
(22, 10, 'Oktober', 2020, 44660),
(23, 11, 'November', 2020, 55805),
(24, 12, 'Desember', 2020, 58521);

-- --------------------------------------------------------

--
-- Table structure for table `data_proses`
--

CREATE TABLE `data_proses` (
  `id` int(11) NOT NULL,
  `bulan` varchar(20) DEFAULT NULL,
  `x` int(3) DEFAULT NULL,
  `y` bigint(20) DEFAULT NULL,
  `x2` int(11) DEFAULT NULL,
  `xy` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `data_proses`
--

INSERT INTO `data_proses` (`id`, `bulan`, `x`, `y`, `x2`, `xy`) VALUES
(1, 'Januari', 1, 38224, 1, 38224),
(2, 'Februari', 2, 26670, 4, 53340);

-- --------------------------------------------------------

--
-- Stand-in structure for view `nilai_intersep`
-- (See below for the actual view)
--
CREATE TABLE `nilai_intersep` (
`nilai_intersep` decimal(65,8)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `nilai_slope`
-- (See below for the actual view)
--
CREATE TABLE `nilai_slope` (
`nilai_slope` decimal(65,4)
);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(15) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`) VALUES
(1, 'admin', 'pass', 'Administrator Tampan');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_proses`
-- (See below for the actual view)
--
CREATE TABLE `view_proses` (
`bulan` varchar(20)
,`x` int(3)
,`y` bigint(20)
,`x2` bigint(21)
,`xy` bigint(30)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_ramalan`
-- (See below for the actual view)
--
CREATE TABLE `view_ramalan` (
`periode` int(3)
,`permintaan` bigint(20)
,`peramalan` decimal(58,0)
,`periode2` bigint(12)
,`peramalan2` decimal(58,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_total_proses`
-- (See below for the actual view)
--
CREATE TABLE `view_total_proses` (
`total` binary(0)
,`x` decimal(32,0)
,`y` decimal(41,0)
,`x2` decimal(42,0)
,`xy` decimal(51,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_total_ramalan`
-- (See below for the actual view)
--
CREATE TABLE `view_total_ramalan` (
`Total` varchar(5)
,`permintaan` decimal(41,0)
,`peramalan` decimal(65,0)
,`Total 13-24` varchar(11)
,`peramalan2` decimal(65,0)
);

-- --------------------------------------------------------

--
-- Structure for view `nilai_intersep`
--
DROP TABLE IF EXISTS `nilai_intersep`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nilai_intersep`  AS SELECT (`vt`.`y` - `ns`.`nilai_slope` * `vt`.`x`) / 12 AS `nilai_intersep` FROM (`view_total_proses` `vt` join `nilai_slope` `ns`) ;

-- --------------------------------------------------------

--
-- Structure for view `nilai_slope`
--
DROP TABLE IF EXISTS `nilai_slope`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nilai_slope`  AS SELECT (12 * `vt`.`xy` - `vt`.`x` * `vt`.`y`) / (12 * `vt`.`x2` - `vt`.`x` * `vt`.`x`) AS `nilai_slope` FROM `view_total_proses` AS `vt` ;

-- --------------------------------------------------------

--
-- Structure for view `view_proses`
--
DROP TABLE IF EXISTS `view_proses`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_proses`  AS SELECT `data_mentah`.`bulan` AS `bulan`, `data_mentah`.`periode` AS `x`, `data_mentah`.`permintaan` AS `y`, `data_mentah`.`periode`* `data_mentah`.`periode` AS `x2`, `data_mentah`.`periode`* `data_mentah`.`permintaan` AS `xy` FROM `data_mentah` ;

-- --------------------------------------------------------

--
-- Structure for view `view_ramalan`
--
DROP TABLE IF EXISTS `view_ramalan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_ramalan`  AS SELECT `dm`.`periode` AS `periode`, `dm`.`permintaan` AS `permintaan`, round(`ni`.`nilai_intersep` + `ns`.`nilai_slope` * `dm`.`periode`,0) AS `peramalan`, `dm`.`periode`+ 12 AS `periode2`, round(`ni`.`nilai_intersep` + `ns`.`nilai_slope` * (`dm`.`periode` + 12),0) AS `peramalan2` FROM ((`data_mentah` `dm` join `nilai_slope` `ns`) join `nilai_intersep` `ni`) ;

-- --------------------------------------------------------

--
-- Structure for view `view_total_proses`
--
DROP TABLE IF EXISTS `view_total_proses`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_total_proses`  AS SELECT NULL AS `total`, sum(`view_proses`.`x`) AS `x`, sum(`view_proses`.`y`) AS `y`, sum(`view_proses`.`x2`) AS `x2`, sum(`view_proses`.`xy`) AS `xy` FROM `view_proses` ;

-- --------------------------------------------------------

--
-- Structure for view `view_total_ramalan`
--
DROP TABLE IF EXISTS `view_total_ramalan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_total_ramalan`  AS SELECT 'Total' AS `Total`, sum(`vr`.`permintaan`) AS `permintaan`, sum(`vr`.`peramalan`) AS `peramalan`, 'Total 13-24' AS `Total 13-24`, sum(`vr`.`peramalan2`) AS `peramalan2` FROM `view_ramalan` AS `vr` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data_mentah`
--
ALTER TABLE `data_mentah`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `periode` (`periode`);

--
-- Indexes for table `data_proses`
--
ALTER TABLE `data_proses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `data_mentah`
--
ALTER TABLE `data_mentah`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `data_proses`
--
ALTER TABLE `data_proses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
