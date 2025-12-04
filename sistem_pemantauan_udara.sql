-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 04, 2025 at 03:52 AM
-- Server version: 8.4.3
-- PHP Version: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sistem_pemantauan_udara`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_10_21_041402_create_sensors_table', 1),
(5, '2025_10_21_041403_create_sensor_data_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sensors`
--

CREATE TABLE `sensors` (
  `id` bigint UNSIGNED NOT NULL,
  `kode_sensor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lokasi` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Aktif','Offline') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Aktif',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sensors`
--

INSERT INTO `sensors` (`id`, `kode_sensor`, `lokasi`, `status`, `created_at`, `updated_at`) VALUES
(1, 'SEN001\r\n', 'Laboratorium Siskom B', 'Aktif', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sensor_data`
--

CREATE TABLE `sensor_data` (
  `id` bigint UNSIGNED NOT NULL,
  `sensor_id` bigint UNSIGNED NOT NULL,
  `suhu` double NOT NULL,
  `kelembaban` double NOT NULL,
  `pm10` double NOT NULL,
  `aqi` int NOT NULL,
  `kategori` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `waktu` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sensor_data`
--

INSERT INTO `sensor_data` (`id`, `sensor_id`, `suhu`, `kelembaban`, `pm10`, `aqi`, `kategori`, `waktu`, `created_at`, `updated_at`) VALUES
(4, 1, 28.5, 70, 25, 35, 'Baik', '2025-01-26 08:00:00', NULL, NULL),
(5, 1, 28.7, 69, 26, 36, 'Baik', '2025-01-26 08:02:00', NULL, NULL),
(6, 1, 28.9, 69, 27, 38, 'Baik', '2025-01-26 08:04:00', NULL, NULL),
(7, 1, 29, 68, 28, 40, 'Baik', '2025-01-26 08:06:00', NULL, NULL),
(8, 1, 29.1, 68, 30, 42, 'Baik', '2025-01-26 08:08:00', NULL, NULL),
(9, 1, 29.3, 67, 32, 45, 'Baik', '2025-01-26 08:10:00', NULL, NULL),
(10, 1, 29.4, 67, 33, 47, 'Baik', '2025-01-26 08:12:00', NULL, NULL),
(11, 1, 29.6, 66, 35, 50, 'Baik', '2025-01-26 08:14:00', NULL, NULL),
(12, 1, 29.7, 66, 36, 52, 'Baik', '2025-01-26 08:16:00', NULL, NULL),
(13, 1, 29.9, 65, 38, 55, 'Sedang', '2025-01-26 08:18:00', NULL, NULL),
(14, 1, 30, 65, 40, 58, 'Sedang', '2025-01-26 08:20:00', NULL, NULL),
(15, 1, 30.1, 64, 42, 60, 'Sedang', '2025-01-26 08:22:00', NULL, NULL),
(16, 1, 30.3, 64, 44, 63, 'Sedang', '2025-01-26 08:24:00', NULL, NULL),
(17, 1, 30.5, 63, 46, 66, 'Sedang', '2025-01-26 08:26:00', NULL, NULL),
(18, 1, 30.7, 63, 48, 69, 'Sedang', '2025-01-26 08:28:00', NULL, NULL),
(19, 1, 30.9, 62, 50, 72, 'Sedang', '2025-01-26 08:30:00', NULL, NULL),
(20, 1, 31.1, 62, 52, 75, 'Sedang', '2025-01-26 08:32:00', NULL, NULL),
(21, 1, 31.3, 61, 54, 78, 'Sedang', '2025-01-26 08:34:00', NULL, NULL),
(22, 1, 31.4, 61, 56, 81, 'Tidak Sehat', '2025-01-26 08:36:00', NULL, NULL),
(23, 1, 31.6, 60, 58, 84, 'Tidak Sehat', '2025-01-26 08:38:00', NULL, NULL),
(24, 1, 31.8, 60, 59, 87, 'Tidak Sehat', '2025-01-26 08:40:00', NULL, NULL),
(25, 1, 32, 59, 60, 90, 'Tidak Sehat', '2025-01-26 08:42:00', NULL, NULL),
(26, 1, 32.2, 59, 62, 92, 'Tidak Sehat', '2025-01-26 08:44:00', NULL, NULL),
(27, 1, 32.3, 58, 64, 95, 'Tidak Sehat', '2025-01-26 08:46:00', NULL, NULL),
(28, 1, 32.5, 58, 66, 98, 'Tidak Sehat', '2025-01-26 08:48:00', NULL, NULL),
(29, 1, 32.6, 57, 68, 101, 'Tidak Sehat', '2025-01-26 08:50:00', NULL, NULL),
(30, 1, 32.8, 57, 70, 104, 'Tidak Sehat', '2025-01-26 08:52:00', NULL, NULL),
(31, 1, 33, 56, 72, 108, 'Sangat Tidak Sehat', '2025-01-26 08:54:00', NULL, NULL),
(32, 1, 33.1, 56, 74, 112, 'Sangat Tidak Sehat', '2025-01-26 08:56:00', NULL, NULL),
(33, 1, 33.3, 55, 76, 115, 'Sangat Tidak Sehat', '2025-01-26 08:58:00', NULL, NULL),
(34, 1, 33.5, 55, 78, 118, 'Sangat Tidak Sehat', '2025-01-26 09:00:00', NULL, NULL),
(35, 1, 33.6, 54, 80, 122, 'Berbahaya', '2025-01-26 09:02:00', NULL, NULL),
(36, 1, 33.7, 54, 82, 126, 'Berbahaya', '2025-01-26 09:04:00', NULL, NULL),
(37, 1, 33.9, 53, 83, 129, 'Berbahaya', '2025-01-26 09:06:00', NULL, NULL),
(38, 1, 34, 53, 84, 132, 'Berbahaya', '2025-01-26 09:08:00', NULL, NULL),
(39, 1, 34.1, 52, 85, 135, 'Berbahaya', '2025-01-26 09:10:00', NULL, NULL),
(40, 1, 34.2, 52, 86, 138, 'Berbahaya', '2025-01-26 09:12:00', NULL, NULL),
(41, 1, 34.3, 51, 87, 141, 'Berbahaya', '2025-01-26 09:14:00', NULL, NULL),
(42, 1, 34.4, 50, 88, 144, 'Berbahaya', '2025-01-26 09:16:00', NULL, NULL),
(43, 1, 34.5, 50, 89, 147, 'Berbahaya', '2025-01-26 09:18:00', NULL, NULL),
(44, 1, 34.4, 50, 88, 143, 'Berbahaya', '2025-01-26 09:20:00', NULL, NULL),
(45, 1, 34.3, 51, 86, 138, 'Berbahaya', '2025-01-26 09:22:00', NULL, NULL),
(46, 1, 34, 52, 83, 130, 'Berbahaya', '2025-01-26 09:24:00', NULL, NULL),
(47, 1, 33.8, 52, 80, 125, 'Berbahaya', '2025-01-26 09:26:00', NULL, NULL),
(48, 1, 33.7, 53, 77, 120, 'Sangat Tidak Sehat', '2025-01-26 09:28:00', NULL, NULL),
(49, 1, 33.5, 54, 75, 115, 'Sangat Tidak Sehat', '2025-01-26 09:30:00', NULL, NULL),
(50, 1, 33.3, 54, 73, 110, 'Sangat Tidak Sehat', '2025-01-26 09:32:00', NULL, NULL),
(51, 1, 33, 55, 70, 105, 'Tidak Sehat', '2025-01-26 09:34:00', NULL, NULL),
(52, 1, 32.9, 55, 68, 100, 'Sedang', '2025-01-26 09:36:00', NULL, NULL),
(53, 1, 32.7, 56, 65, 95, 'Sedang', '2025-01-26 09:38:00', NULL, NULL),
(54, 1, 32.5, 57, 63, 92, 'Sedang', '2025-01-26 09:40:00', NULL, NULL),
(55, 1, 32.3, 57, 60, 88, 'Tidak Sehat', '2025-01-26 09:42:00', NULL, NULL),
(56, 1, 32.1, 58, 58, 85, 'Tidak Sehat', '2025-01-26 09:44:00', NULL, NULL),
(57, 1, 31.9, 58, 55, 80, 'Sedang', '2025-01-26 09:46:00', NULL, NULL),
(58, 1, 31.7, 59, 53, 77, 'Sedang', '2025-01-26 09:48:00', NULL, NULL),
(59, 1, 31.5, 59, 50, 72, 'Sedang', '2025-01-26 09:50:00', NULL, NULL),
(60, 1, 31.3, 60, 48, 69, 'Sedang', '2025-01-26 09:52:00', NULL, NULL),
(61, 1, 31.1, 60, 46, 65, 'Sedang', '2025-01-26 09:54:00', NULL, NULL),
(62, 1, 30.9, 61, 44, 62, 'Sedang', '2025-01-26 09:56:00', NULL, NULL),
(63, 1, 30.7, 61, 42, 59, 'Sedang', '2025-01-26 09:58:00', NULL, NULL),
(64, 1, 30.5, 62, 40, 56, 'Sedang', '2025-01-26 10:00:00', NULL, NULL),
(65, 1, 30.3, 62, 39, 53, 'Baik', '2025-01-26 10:02:00', NULL, NULL),
(66, 1, 30.1, 63, 38, 51, 'Baik', '2025-01-26 10:04:00', NULL, NULL),
(67, 1, 29.9, 63, 37, 49, 'Baik', '2025-01-26 10:06:00', NULL, NULL),
(68, 1, 29.7, 64, 36, 47, 'Baik', '2025-01-26 10:08:00', NULL, NULL),
(69, 1, 29.5, 64, 35, 45, 'Baik', '2025-01-26 10:10:00', NULL, NULL),
(70, 1, 29.4, 65, 34, 44, 'Baik', '2025-01-26 10:12:00', NULL, NULL),
(71, 1, 29.2, 65, 33, 42, 'Baik', '2025-01-26 10:14:00', NULL, NULL),
(72, 1, 29, 66, 32, 40, 'Baik', '2025-01-26 10:16:00', NULL, NULL),
(73, 1, 28.8, 66, 31, 38, 'Baik', '2025-01-26 10:18:00', NULL, NULL),
(74, 1, 28.7, 67, 30, 37, 'Baik', '2025-01-26 10:20:00', NULL, NULL),
(75, 1, 28.6, 67, 29, 36, 'Baik', '2025-01-26 10:22:00', NULL, NULL),
(76, 1, 28.5, 68, 28, 35, 'Baik', '2025-01-26 10:24:00', NULL, NULL),
(77, 1, 28.4, 68, 27, 34, 'Baik', '2025-01-26 10:26:00', NULL, NULL),
(78, 1, 28.3, 69, 27, 33, 'Baik', '2025-01-26 10:28:00', NULL, NULL),
(79, 1, 28.2, 69, 26, 32, 'Baik', '2025-01-26 10:30:00', NULL, NULL),
(80, 1, 28.1, 70, 25, 31, 'Baik', '2025-01-26 10:32:00', NULL, NULL),
(81, 1, 28, 70, 25, 30, 'Baik', '2025-01-26 10:34:00', NULL, NULL),
(82, 1, 27.9, 70, 25, 30, 'Baik', '2025-01-26 10:36:00', NULL, NULL),
(83, 1, 27.8, 71, 24, 29, 'Baik', '2025-01-26 10:38:00', NULL, NULL),
(84, 1, 28.4, 70, 22, 45, 'Baik', '2025-01-10 08:00:00', NULL, NULL),
(85, 1, 28.6, 69, 24, 48, 'Baik', '2025-01-10 08:02:00', NULL, NULL),
(86, 1, 28.7, 68, 26, 52, 'Baik', '2025-01-10 08:04:00', NULL, NULL),
(87, 1, 28.9, 67, 28, 55, 'Baik', '2025-01-10 08:06:00', NULL, NULL),
(88, 1, 29, 66, 30, 58, 'Baik', '2025-01-10 08:08:00', NULL, NULL),
(89, 1, 29.1, 65, 32, 60, 'Sedang', '2025-01-10 08:10:00', NULL, NULL),
(90, 1, 29.2, 65, 34, 63, 'Sedang', '2025-01-10 08:12:00', NULL, NULL),
(91, 1, 29.3, 64, 36, 65, 'Sedang', '2025-01-10 08:14:00', NULL, NULL),
(92, 1, 29.1, 64, 35, 64, 'Sedang', '2025-01-10 08:16:00', NULL, NULL),
(93, 1, 29, 65, 33, 61, 'Sedang', '2025-01-10 08:18:00', NULL, NULL),
(94, 1, 28.8, 66, 28, 55, 'Baik', '2025-01-10 08:20:00', NULL, NULL),
(95, 1, 28.7, 67, 26, 53, 'Baik', '2025-01-10 08:22:00', NULL, NULL),
(96, 1, 28.6, 68, 25, 49, 'Baik', '2025-01-10 08:24:00', NULL, NULL),
(97, 1, 28.5, 69, 23, 47, 'Baik', '2025-01-10 08:26:00', NULL, NULL),
(98, 1, 28.4, 70, 22, 45, 'Baik', '2025-01-10 08:28:00', NULL, NULL),
(99, 1, 28.6, 70, 27, 54, 'Baik', '2025-01-10 08:30:00', NULL, NULL),
(100, 1, 28.8, 69, 31, 59, 'Sedang', '2025-01-10 08:32:00', NULL, NULL),
(101, 1, 29, 69, 33, 62, 'Sedang', '2025-01-10 08:34:00', NULL, NULL),
(102, 1, 29.2, 68, 35, 66, 'Sedang', '2025-01-10 08:36:00', NULL, NULL),
(103, 1, 29.3, 68, 37, 70, 'Sedang', '2025-01-10 08:38:00', NULL, NULL),
(104, 1, 29.4, 67, 38, 72, 'Sedang', '2025-01-10 08:40:00', NULL, NULL),
(105, 1, 29.3, 67, 36, 69, 'Sedang', '2025-01-10 08:42:00', NULL, NULL),
(106, 1, 29.1, 68, 32, 61, 'Sedang', '2025-01-10 08:44:00', NULL, NULL),
(107, 1, 28.9, 69, 30, 58, 'Baik', '2025-01-10 08:46:00', NULL, NULL),
(108, 1, 28.7, 70, 27, 53, 'Baik', '2025-01-10 08:48:00', NULL, NULL),
(109, 1, 28.6, 70, 26, 51, 'Baik', '2025-01-10 08:50:00', NULL, NULL),
(110, 1, 28.5, 71, 24, 49, 'Baik', '2025-01-10 08:52:00', NULL, NULL),
(111, 1, 28.4, 71, 23, 47, 'Baik', '2025-01-10 08:54:00', NULL, NULL),
(112, 1, 28.6, 70, 28, 55, 'Baik', '2025-01-10 08:56:00', NULL, NULL),
(113, 1, 28.9, 69, 34, 65, 'Sedang', '2025-01-10 08:58:00', NULL, NULL),
(114, 1, 29, 68, 36, 68, 'Sedang', '2025-01-10 09:00:00', NULL, NULL),
(115, 1, 29.2, 68, 37, 70, 'Sedang', '2025-01-10 09:02:00', NULL, NULL),
(116, 1, 29.3, 67, 39, 74, 'Sedang', '2025-01-10 09:04:00', NULL, NULL),
(117, 1, 29.4, 66, 40, 76, 'Sedang', '2025-01-10 09:06:00', NULL, NULL),
(118, 1, 29.6, 65, 55, 112, 'Tidak Sehat', '2025-01-10 09:08:00', NULL, NULL),
(119, 1, 29.7, 64, 53, 108, 'Tidak Sehat', '2025-01-10 09:10:00', NULL, NULL),
(120, 1, 29.5, 65, 51, 101, 'Tidak Sehat', '2025-01-10 09:12:00', NULL, NULL),
(121, 1, 29.2, 66, 45, 85, 'Sedang', '2025-01-10 09:14:00', NULL, NULL),
(122, 1, 29.1, 67, 42, 78, 'Sedang', '2025-01-10 09:16:00', NULL, NULL),
(123, 1, 28.9, 67, 38, 70, 'Sedang', '2025-01-10 09:18:00', NULL, NULL),
(124, 1, 28.8, 68, 35, 65, 'Sedang', '2025-01-10 09:20:00', NULL, NULL),
(125, 1, 28.7, 68, 33, 60, 'Sedang', '2025-01-10 09:22:00', NULL, NULL),
(126, 1, 28.6, 69, 29, 55, 'Baik', '2025-01-10 09:24:00', NULL, NULL),
(127, 1, 28.4, 70, 25, 49, 'Baik', '2025-01-10 09:26:00', NULL, NULL),
(128, 1, 28.3, 70, 23, 46, 'Baik', '2025-01-10 09:28:00', NULL, NULL),
(129, 1, 28.2, 71, 22, 44, 'Baik', '2025-01-10 09:30:00', NULL, NULL),
(130, 1, 28.4, 70, 28, 55, 'Baik', '2025-01-10 09:32:00', NULL, NULL),
(131, 1, 28.7, 69, 32, 60, 'Sedang', '2025-01-10 09:34:00', NULL, NULL),
(132, 1, 28.9, 68, 35, 65, 'Sedang', '2025-01-10 09:36:00', NULL, NULL),
(133, 1, 29, 67, 38, 70, 'Sedang', '2025-01-10 09:38:00', NULL, NULL),
(134, 1, 29.1, 67, 39, 73, 'Sedang', '2025-01-10 09:40:00', NULL, NULL),
(135, 1, 29.2, 66, 41, 75, 'Sedang', '2025-01-10 09:42:00', NULL, NULL),
(136, 1, 29.1, 66, 39, 71, 'Sedang', '2025-01-10 09:44:00', NULL, NULL),
(137, 1, 28.9, 67, 36, 66, 'Sedang', '2025-01-10 09:46:00', NULL, NULL),
(138, 1, 28.8, 67, 34, 62, 'Sedang', '2025-01-10 09:48:00', NULL, NULL),
(139, 1, 28.6, 68, 29, 55, 'Baik', '2025-01-10 09:50:00', NULL, NULL),
(140, 1, 28.4, 69, 25, 48, 'Baik', '2025-01-10 09:52:00', NULL, NULL),
(141, 1, 28.3, 69, 23, 46, 'Baik', '2025-01-10 09:54:00', NULL, NULL),
(142, 1, 28.5, 69, 28, 54, 'Baik', '2025-01-10 09:56:00', NULL, NULL),
(143, 1, 28.6, 68, 30, 57, 'Baik', '2025-01-10 09:58:00', NULL, NULL),
(144, 1, 28.8, 68, 33, 62, 'Sedang', '2025-01-10 10:00:00', NULL, NULL),
(145, 1, 29, 67, 36, 67, 'Sedang', '2025-01-10 10:02:00', NULL, NULL),
(146, 1, 29.2, 67, 38, 70, 'Sedang', '2025-01-10 10:04:00', NULL, NULL),
(147, 1, 29.3, 66, 39, 73, 'Sedang', '2025-01-10 10:06:00', NULL, NULL),
(148, 1, 29.1, 67, 36, 66, 'Sedang', '2025-01-10 10:08:00', NULL, NULL),
(149, 1, 28.9, 67, 33, 61, 'Sedang', '2025-01-10 10:10:00', NULL, NULL),
(150, 1, 28.8, 68, 31, 58, 'Baik', '2025-01-10 10:12:00', NULL, NULL),
(151, 1, 28.6, 69, 29, 55, 'Baik', '2025-01-10 10:14:00', NULL, NULL),
(152, 1, 28.5, 69, 27, 52, 'Baik', '2025-01-10 10:16:00', NULL, NULL),
(153, 1, 28.4, 70, 25, 49, 'Baik', '2025-01-10 10:18:00', NULL, NULL),
(154, 1, 28.6, 70, 30, 57, 'Baik', '2025-01-10 10:20:00', NULL, NULL),
(155, 1, 28.8, 69, 33, 63, 'Sedang', '2025-01-10 10:22:00', NULL, NULL),
(156, 1, 29, 68, 36, 68, 'Sedang', '2025-01-10 10:24:00', NULL, NULL),
(157, 1, 29.1, 68, 37, 71, 'Sedang', '2025-01-10 10:26:00', NULL, NULL),
(158, 1, 29, 68, 35, 67, 'Sedang', '2025-01-10 10:28:00', NULL, NULL),
(159, 1, 28.8, 69, 32, 61, 'Sedang', '2025-01-10 10:30:00', NULL, NULL),
(160, 1, 28.7, 69, 30, 57, 'Baik', '2025-01-10 10:32:00', NULL, NULL),
(161, 1, 28.5, 70, 27, 52, 'Baik', '2025-01-10 10:34:00', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('MRgUkfq739mq44NAiPN1nItrEbR0bOhECkNdGDgM', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTo2OntzOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozNjoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL2FwaS9jaGFydC1kYXRhIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo2OiJfdG9rZW4iO3M6NDA6Im8yMmhUTExpVzVEbkRXZEJnQXRxUTRPbEw1UkVpZGhhcjI0bG95bjQiO3M6OToibG9nZ2VkX2luIjtiOjE7czo0OiJyb2xlIjtzOjU6ImFkbWluIjtzOjU6ImVtYWlsIjtzOjIwOiJhZG1pbm5hbmRhQGdtYWlsLmNvbSI7fQ==', 1764747988);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `sensors`
--
ALTER TABLE `sensors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sensors_kode_sensor_unique` (`kode_sensor`);

--
-- Indexes for table `sensor_data`
--
ALTER TABLE `sensor_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sensor_data_sensor_id_foreign` (`sensor_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sensors`
--
ALTER TABLE `sensors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sensor_data`
--
ALTER TABLE `sensor_data`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=162;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `sensor_data`
--
ALTER TABLE `sensor_data`
  ADD CONSTRAINT `sensor_data_sensor_id_foreign` FOREIGN KEY (`sensor_id`) REFERENCES `sensors` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
