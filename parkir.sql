-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 25, 2026 at 09:01 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `parkir`
--

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `batch` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `version`, `class`, `group`, `namespace`, `time`, `batch`) VALUES
(1, '2026-02-25-061253', 'App\\Database\\Migrations\\CreateTbUserTable', 'default', 'App', 1771999992, 1),
(2, '2026-02-25-062744', 'App\\Database\\Migrations\\AddNamaLengkapToTbUser', 'default', 'App', 1772000878, 2),
(3, '2026-02-25-064436', 'App\\Database\\Migrations\\CreateTbKendaraanTable', 'default', 'App', 1772001900, 3),
(4, '2026-02-25-065449', 'App\\Database\\Migrations\\CreateTbTransaksiTable', 'default', 'App', 1772002505, 4),
(5, '2026-02-25-065543', 'App\\Database\\Migrations\\CreateTbTarifTable', 'default', 'App', 1772002581, 5),
(6, '2026-02-25-065749', 'App\\Database\\Migrations\\AddForeignKeyTarifToTransaksi', 'default', 'App', 1772002686, 6),
(7, '2026-02-25-065953', 'App\\Database\\Migrations\\CreateTbLogAktivitasTable', 'default', 'App', 1772002821, 7),
(8, '2026-02-25-070225', 'App\\Database\\Migrations\\CreateTbAreaParkirTable', 'default', 'App', 1772002970, 8),
(9, '2026-02-25-070402', 'App\\Database\\Migrations\\AddForeignKeyAreaToTransaksi', 'default', 'App', 1772003062, 9),
(10, '2026-02-25-075749', 'App\\Database\\Migrations\\FixLogAktivitasForeignKey', 'default', 'App', 1772006345, 10);

-- --------------------------------------------------------

--
-- Table structure for table `tb_area_parkir`
--

CREATE TABLE `tb_area_parkir` (
  `id_area` int(11) UNSIGNED NOT NULL,
  `nama_area` varchar(100) NOT NULL,
  `kapasitas` int(11) NOT NULL DEFAULT 0,
  `terisi` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_area_parkir`
--

INSERT INTO `tb_area_parkir` (`id_area`, `nama_area`, `kapasitas`, `terisi`, `created_at`, `updated_at`) VALUES
(1, 'Area A - Mobil', 50, 0, '2026-02-25 07:29:49', '2026-02-25 07:29:49'),
(2, 'Area B - Motor', 100, 0, '2026-02-25 07:29:49', '2026-02-25 07:29:49'),
(3, 'Area C - Bus/Truk', 20, 0, '2026-02-25 07:29:49', '2026-02-25 07:29:49'),
(4, 'Area D - VIP', 10, 0, '2026-02-25 07:29:49', '2026-02-25 07:29:49'),
(5, 'hwa', 10, 0, '2026-02-25 07:36:03', '2026-02-25 07:36:03');

-- --------------------------------------------------------

--
-- Table structure for table `tb_kendaraan`
--

CREATE TABLE `tb_kendaraan` (
  `id_kendaraan` int(11) UNSIGNED NOT NULL,
  `plat_nomor` varchar(20) NOT NULL,
  `jenis_kendaraan` enum('mobil','motor','truk','bus','lainnya') NOT NULL,
  `warna` varchar(50) DEFAULT NULL,
  `pemilik` varchar(100) DEFAULT NULL,
  `id_user` int(11) UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_kendaraan`
--

INSERT INTO `tb_kendaraan` (`id_kendaraan`, `plat_nomor`, `jenis_kendaraan`, `warna`, `pemilik`, `id_user`, `created_at`, `updated_at`) VALUES
(1, 'b1233w', 'motor', 'merah', 'budi', 4, '2026-02-25 07:12:52', '2026-02-25 07:14:21');

-- --------------------------------------------------------

--
-- Table structure for table `tb_log_aktivitas`
--

CREATE TABLE `tb_log_aktivitas` (
  `id_log` int(11) UNSIGNED NOT NULL,
  `id_user` int(11) UNSIGNED DEFAULT NULL,
  `aktivitas` varchar(255) NOT NULL,
  `waktu_aktivitas` datetime NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_log_aktivitas`
--

INSERT INTO `tb_log_aktivitas` (`id_log`, `id_user`, `aktivitas`, `waktu_aktivitas`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 1, 'Test login admin', '2026-02-25 07:56:27', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0 Safari/537.36', NULL),
(2, 2, 'Test login superadmin', '2026-02-25 07:56:27', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0 Safari/537.36', NULL),
(4, 1, 'Test login user', '2026-02-25 07:57:40', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0 Safari/537.36', NULL),
(6, 1, 'Test login user', '2026-02-25 07:59:09', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0 Safari/537.36', NULL),
(8, 1, 'Test login user', '2026-02-25 07:59:39', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0 Safari/537.36', NULL),
(9, 2, 'Test login user kedua', '2026-02-25 07:59:39', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0 Safari/537.36', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tb_tarif`
--

CREATE TABLE `tb_tarif` (
  `id_tarif` int(11) UNSIGNED NOT NULL,
  `jenis_kendaraan` enum('mobil','motor','truk','bus','lainnya') NOT NULL,
  `tarif_per_jam` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_tarif`
--

INSERT INTO `tb_tarif` (`id_tarif`, `jenis_kendaraan`, `tarif_per_jam`, `created_at`, `updated_at`) VALUES
(2, 'motor', 2000.00, '2026-02-25 07:29:49', '2026-02-25 07:29:49'),
(3, 'mobil', 5000.00, '2026-02-25 07:29:49', '2026-02-25 07:29:49'),
(4, 'truk', 10000.00, '2026-02-25 07:29:49', '2026-02-25 07:29:49'),
(5, 'bus', 15000.00, '2026-02-25 07:29:49', '2026-02-25 07:29:49'),
(6, 'lainnya', 3000.00, '2026-02-25 07:29:49', '2026-02-25 07:29:49');

-- --------------------------------------------------------

--
-- Table structure for table `tb_transaksi`
--

CREATE TABLE `tb_transaksi` (
  `id_parkir` int(11) UNSIGNED NOT NULL,
  `id_kendaraan` int(11) UNSIGNED NOT NULL,
  `waktu_masuk` datetime NOT NULL,
  `waktu_keluar` datetime DEFAULT NULL,
  `id_tarif` int(11) UNSIGNED DEFAULT NULL,
  `durasi_jam` decimal(10,2) DEFAULT 0.00,
  `biaya_total` decimal(10,2) DEFAULT 0.00,
  `status` enum('masuk','keluar','selesai') NOT NULL DEFAULT 'masuk',
  `id_user` int(11) UNSIGNED NOT NULL,
  `id_area` int(11) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `id_user` int(11) UNSIGNED NOT NULL,
  `username` varchar(100) NOT NULL,
  `nama_lengkap` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('superadmin','admin','owner','petugas') NOT NULL DEFAULT 'petugas',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`id_user`, `username`, `nama_lengkap`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'testuser3s', '', '$2y$10$x7f5WFyo2jDXssoQScaS6eay0FMedC2mnerP/5DSUVe.mAxS2.n0u', 'petugas', '2026-02-25 13:20:42', '2026-02-25 07:19:45'),
(2, 'webtest4', NULL, '$2y$10$FZP3GHG57GuVilBRqQTwOe6aP9z3.E4l0QjxY7blAfE6UFWeZ0DXy', 'petugas', '2026-02-25 13:26:21', '2026-02-25 13:26:21'),
(3, 'dewasa', NULL, '$2y$10$LHa./seCJ2dah8C4lHZGyeUj.C2eaiRt4fnHl7psj38xlidif4Qr.', 'petugas', '2026-02-25 06:27:01', '2026-02-25 06:27:01'),
(4, 'dewasa1', 'dewasa', '$2y$10$WeJJXFU.i8qaWOFEyljcY.5rwFa9rXaxWRbb5eqJdHsDPvJ8/jyIe', 'admin', '2026-02-25 06:29:46', '2026-02-25 06:29:46');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_area_parkir`
--
ALTER TABLE `tb_area_parkir`
  ADD PRIMARY KEY (`id_area`);

--
-- Indexes for table `tb_kendaraan`
--
ALTER TABLE `tb_kendaraan`
  ADD PRIMARY KEY (`id_kendaraan`),
  ADD KEY `tb_kendaraan_id_user_foreign` (`id_user`);

--
-- Indexes for table `tb_log_aktivitas`
--
ALTER TABLE `tb_log_aktivitas`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `waktu_aktivitas` (`waktu_aktivitas`),
  ADD KEY `tb_log_aktivitas_id_user_foreign` (`id_user`);

--
-- Indexes for table `tb_tarif`
--
ALTER TABLE `tb_tarif`
  ADD PRIMARY KEY (`id_tarif`),
  ADD UNIQUE KEY `unique_jenis_kendaraan` (`jenis_kendaraan`);

--
-- Indexes for table `tb_transaksi`
--
ALTER TABLE `tb_transaksi`
  ADD PRIMARY KEY (`id_parkir`),
  ADD KEY `tb_transaksi_id_kendaraan_foreign` (`id_kendaraan`),
  ADD KEY `tb_transaksi_id_user_foreign` (`id_user`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tb_area_parkir`
--
ALTER TABLE `tb_area_parkir`
  MODIFY `id_area` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tb_kendaraan`
--
ALTER TABLE `tb_kendaraan`
  MODIFY `id_kendaraan` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_log_aktivitas`
--
ALTER TABLE `tb_log_aktivitas`
  MODIFY `id_log` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tb_tarif`
--
ALTER TABLE `tb_tarif`
  MODIFY `id_tarif` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tb_transaksi`
--
ALTER TABLE `tb_transaksi`
  MODIFY `id_parkir` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `id_user` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tb_kendaraan`
--
ALTER TABLE `tb_kendaraan`
  ADD CONSTRAINT `tb_kendaraan_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `tb_user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tb_log_aktivitas`
--
ALTER TABLE `tb_log_aktivitas`
  ADD CONSTRAINT `tb_log_aktivitas_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `tb_user` (`id_user`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `tb_transaksi`
--
ALTER TABLE `tb_transaksi`
  ADD CONSTRAINT `tb_transaksi_id_kendaraan_foreign` FOREIGN KEY (`id_kendaraan`) REFERENCES `tb_kendaraan` (`id_kendaraan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_transaksi_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `tb_user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
