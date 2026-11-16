-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 14, 2026 at 04:23 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `seid_ac_kalibrasi`
--

-- --------------------------------------------------------

--
-- Table structure for table `equipments`
--

CREATE TABLE `equipments` (
  `id` int(11) NOT NULL,
  `control_no` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  `function_desc` varchar(255) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `type_model` varchar(100) DEFAULT NULL,
  `serial_no` varchar(100) DEFAULT NULL,
  `cal_date` date NOT NULL,
  `due_date` date NOT NULL,
  `cal_by` varchar(150) DEFAULT NULL,
  `cal_decision` varchar(50) DEFAULT 'OK',
  `certificate` varchar(100) DEFAULT NULL,
  `loc_cal` varchar(100) DEFAULT NULL,
  `certification_url` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `equipments`
--

INSERT INTO `equipments` (`id`, `control_no`, `name`, `location`, `function_desc`, `brand`, `type_model`, `serial_no`, `cal_date`, `due_date`, `cal_by`, `cal_decision`, `certificate`, `loc_cal`, `certification_url`) VALUES
(1, 'AC-PE-E1', 'Torque Meter 1', 'PE', 'Measure Torque', 'HIOS', 'HDP-100', '922459', '2026-10-06', '2027-10-06', 'YISU', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1cPj7AQhKe6PKBQTOOPSoav9fllB28arY/view?usp=drive_link'),
(2, 'AC-PE-E2', 'Torque Meter 2', 'PE', 'Measure Torque', 'HIOS', 'HP-100', 'Y22503', '2026-10-17', '2027-10-17', 'YISU', 'OK', 'KAN', 'INLAB', 'https://drive.google.com/file/d/1NBNyoBWyFgqenCkG85Ngp-UjfkSyKORf/view?usp=drive_link'),
(3, 'AC-PE-E3', 'Torque Meter 3', 'PE', 'Measure Torque', 'HIOS', 'HIT-500', '32030', '2026-10-06', '2027-10-06', 'YISU', 'OK', 'KAN', 'INLAB', 'https://drive.google.com/file/d/1-EhfvzuVWdk1rxXMK3vb9IbL-LSv8gAJ/view?usp=drive_link'),
(4, 'AC-PE-E4', 'Helium Leak Test 1', 'IDU', 'Leak Tester', 'Inficon', 'P3000', '90001580866', '2026-10-09', '2027-10-09', 'YISU', 'OK', 'NON KAN', 'INLAB', 'https://drive.google.com/file/d/1S0sUG1IiCX_2TtpN4bPEMOSYGLZR2QN8/view?usp=drive_link'),
(5, 'AC-PE-E5', 'Helium Leak Test 2', 'IDU', 'Leak Tester', 'Inficon', 'P3000', '90001578078', '2026-10-15', '2027-10-15', 'YISU', 'OK', 'NON KAN', 'INLAB', 'https://drive.google.com/file/d/15hpsgDwfEKiJ_k_hQp6oLhVOouO4u1Zr/view?usp=drive_link'),
(6, 'AC-PE-E6', 'Helium Leak Test 3', 'PE', 'Leak Tester', 'Inficon', 'P3000', '90001579219', '2026-10-19', '2027-10-19', 'YISU', 'OK', 'NON KAN', 'INLAB', 'https://drive.google.com/file/d/11Yg7sH2-mjMtAdLlRKPqYX4237aYzbok/view?usp=drive_link'),
(7, 'AC-PE-E7', 'Refrigrant Leak Test 1', 'ODU', 'Leak Tester', 'Inficon', 'HLD6000', '90001589307', '2026-10-19', '2027-10-19', 'YISU', 'OK', 'NON KAN', 'INLAB', 'https://drive.google.com/file/d/1b6smt2sBeAYvg7d42XIw_-jGa_ryggaI/view?usp=drive_link'),
(8, 'AC-PE-E8', 'Refrigrant Leak Test 2', 'ODU', 'Leak Tester', 'Inficon', 'HLD6000', '90001589305', '2026-09-28', '2027-09-28', 'YISU', 'OK', 'NON KAN', 'INLAB', 'https://drive.google.com/file/d/1ZZkYVWuLgwz-HQ0oIkSmvsZa8_9xbsEb/view?usp=drive_link'),
(9, 'AC-PE-E9', 'Refrigrant Leak Test 3', 'ODU', 'Leak Tester', 'Inficon', 'HLD6000', '90001589306', '2026-09-28', '2027-09-28', 'YISU', 'OK', 'NON KAN', 'INLAB', 'https://drive.google.com/file/d/1rPd3DfjDq-z588FHX0uGAxJYepieNtaX/view?usp=drive_link'),
(10, 'AC-PE-E10', 'Refrigrant Leak Test 4', 'PE', 'Leak Tester', 'Inficon', 'HLD6000', '90001592729', '2026-10-19', '2027-10-19', 'YISU', 'OK', 'NON KAN', 'INLAB', 'https://drive.google.com/file/d/1wGk65FhwPG_1fq7PSuPw-55AFJnhcywK/view?usp=drive_link'),
(11, 'AC-PE-E11', 'Refrigrant Leak Test 5', 'PE', 'Leak Tester', 'Inficon', 'HLD6000', '90001592730', '2026-10-09', '2027-10-09', 'YISU', 'OK', 'NON KAN', 'INLAB', 'https://drive.google.com/file/d/1VJ6jU8oQ3Bt7FQjGlIJy-beJZKnA3b0d/view?usp=drive_link'),
(12, 'AC-PE-E12', 'Refrigrant Leak Test 6', 'PE', 'Leak Tester', 'Inficon', 'HLD6000', '90001589304', '2026-10-09', '2027-10-09', 'YISU', 'OK', 'NON KAN', 'INLAB', 'https://drive.google.com/file/d/1QO_yuFLWh1cXWbBkGVHSn-2tvSq0RrCI/view?usp=drive_link'),
(13, 'AC-PE-E13', 'Pro Check Helium P3000', 'IDU', 'Internal Gas Calibration', 'Inficon', 'P3000', '90001785602', '2026-10-01', '2027-10-01', 'INFICON', 'OK', 'NON KAN', 'INLAB', 'https://drive.google.com/file/d/1plFu95bTdnNmW1-M19xYJgSPB4pQdasM/view?usp=drive_link'),
(14, 'AC-PE-E14', 'Capillary Leak R32', 'ODU', 'External Gas Calibration', 'Inficon', 'HLD6000', '90001782114', '2026-05-08', '2027-05-08', 'INFICON', 'OK', 'NON KAN', 'INLAB', 'https://drive.google.com/file/d/1fZeAgqmkUJ2weZibUhOeBoJl48PY0MuA/view?usp=drive_link'),
(15, 'AC-PE-E15', 'Capillary Leak R32', 'ODU', 'External Gas Calibration', 'Inficon', 'HLD6000', '90001730254', '2026-10-15', '2027-10-15', 'YISU', 'OK', 'NON KAN', 'INLAB', 'https://drive.google.com/file/d/1SBndvZZX7UjQwWVh2qKE9_sOOATeAX9Q/view?usp=drive_link'),
(16, 'AC-PE-E16', 'Kikushui 1', 'ODU', 'EGWV Test', 'Kikushui', 'TOS9303', 'CS000593', '2026-09-17', '2027-09-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1lg9x1Qgm7SKNvqskL9jgBksFZziz5vWc/view?usp=drive_link'),
(17, 'AC-PE-E17', 'Kikushui 2', 'IDU', 'EGWV Test', 'Kikushui', 'TOS9303', 'CS000594', '2026-09-17', '2027-09-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1jpHyPV-Jpnwh4GH6VebrHhJAi7govl1L/view?usp=drive_link'),
(18, 'AC-PE-E18', 'Kikushui 3', 'PE', 'EGWV Test', 'Kikushui', 'TOS9303', 'CS000595', '2026-09-17', '2027-09-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1P0cGoqDsTDJXEBv3MGGW4QZgU2pSzhCs/view?usp=drive_link'),
(19, 'AC-PE-E19', 'Timbangan', 'IDU', 'Timbangan Unit Indoor', 'JADEVER', 'JWI-700W', 'K1025122N000', '2026-10-16', '2027-10-16', 'YISU', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1vBcukTM9gNoJSNITjzjYvsSidiAfdvT5/view?usp=drive_link'),
(20, 'AC-PE-E20', 'Torque Wrench', 'ODU', 'Torque Wrench Propelar Fan', 'TOHNICHI', 'CEM10N3X8D-G-BTD', '714659N', '2026-09-30', '2027-09-30', 'AEQUUS', 'OK', 'KAN', 'INLAB', 'https://drive.google.com/file/d/1yPCKfVCM3natRpyaHeuRKlLedGy0OsCM/view?usp=drive_link'),
(21, 'AC-PE-E21', 'Torque Wrench', 'ODU', 'Torque Wrench Propelar Fan', 'TOHNICHI', 'CEM10N3X8D-G-BTD', '713248N', '2026-10-14', '2027-10-14', 'AEQUUS', 'OK', 'KAN', 'INLAB', 'https://drive.google.com/file/d/1Lj3jU3bb5tOKHI7BHgqEG06mM3qPa2yK/view?usp=drive_link'),
(22, 'AC-PE-E22', 'Electric Measurement', 'IDU', 'MAX Speed Measurement', 'HIOKI AC/DC Hi Power', '3334', '220751445', '2026-10-16', '2027-10-16', 'YISU', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1nVd7OWU2HcN_UWsL_2DAsxM9hj3qlTk0/view?usp=drive_link'),
(23, 'AC-PE-E23', 'WI Tester', 'IDU', 'WI Tester', 'SUKA SURYA ELEKTRIK', '-', '-', '2026-10-05', '2027-10-05', 'AEQUUS', 'OK', 'KAN', 'INLAB', 'https://drive.google.com/file/d/1lEFYTz1_9xhib7qn_v7JpuZgURDyRnG-/view?usp=drive_link'),
(24, 'AC-PE-E24', 'WI Tester', 'ODU', 'WI Tester', 'SUKA SURYA ELEKTRIK', '-', '-', '2026-10-05', '2027-10-05', 'AEQUUS', 'OK', 'KAN', 'INLAB', 'https://drive.google.com/file/d/1WJ15lEF0QEmuh-LLY7TesCvKHw1crZZm/view?usp=drive_link'),
(25, 'AC-PE-E25', 'Ion Counter', 'IDU', 'Ion Counter', 'HOKUTO', 'NKMH-103', '04394A', '2026-10-19', '2027-10-19', 'YISU', 'OK', 'NON KAN', 'INLAB', 'https://drive.google.com/file/d/11my8hbFcnSf8LFO1DKBfLYttVmRcq05U/view?usp=drive_link'),
(26, 'AC-PE-E26', 'Ion Counter', 'PE', 'Ion Counter', 'HOKUTO', 'NKMH-103', '01352A', '2026-10-15', '2027-10-15', 'YISU', 'OK', 'NON KAN', 'INLAB', 'https://drive.google.com/file/d/1-ivZVL5u51AA9nqf-OBGo7UyTcYOrbuw/view?usp=drive_link'),
(27, 'AC-PE-E27', 'Ion Counter', 'PE', 'Ion Counter', 'HOKUTO', 'NKMH-103', '01252A', '2026-10-19', '2027-10-19', 'YISU', 'OK', 'NON KAN', 'INLAB', 'https://drive.google.com/file/d/1l7HvEN1q0n3HGleGwHSSAe7d82iH21Hs/view?usp=drive_link'),
(28, 'AC-PE-E28', 'Leak Tester', 'PE', 'Leak Tester', 'COSMOWAVE', 'LM-1C', '-', '2026-10-15', '2027-10-15', 'YISU', 'OK', 'KAN', 'INLAB', 'https://drive.google.com/file/d/18hDaB1Oa5z6DX-8zh7HTeN9kcCiMEtMZ/view?usp=drive_link'),
(29, 'AC-PE-E29', 'Drain Hose Leak Test', 'IDU', 'Leak Tester', 'KINTE', 'CEI', 'US381-000002-006BG', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1a8JFwXzNLaBnLTuoeD0GM9sDFl5Z7dnt/view?usp=drive_link'),
(30, 'AC-PE-E30', 'Air Flow Test', 'IDU', 'Leak Tester', 'KINTE', 'CEI', '4915226', '2026-10-18', '2027-10-18', 'YISU', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1_JypLuuvnqivOpXRYM7-sadcZZxPkoTQ/view?usp=drive_link'),
(31, 'AC-PE-E31', 'Air Flow Test', 'PIPING', 'Leak Tester', 'KINTE', 'CEI', '4918226', '2026-10-18', '2027-10-18', 'YISU', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1vrBebaMxNNwZE13tn55rF1NeYX5EYxOa/view?usp=drive_link'),
(32, 'AC-PE-E32', 'Air Flow Test', 'PIPING', 'Leak Tester', 'KINTE', 'CEI', '4914226', '2026-10-18', '2027-10-18', 'YISU', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1UpsTaOyNl7tIRid0AcJFD5nFvlDGtD9t/view?usp=drive_link'),
(33, 'AC-PE-E33', 'Gloss Meter Painting', 'PAINTING', 'Gloss Meter Painting', 'BYK', 'Micro-gloss 60', '2092922', '2026-10-19', '2027-10-19', 'AEQUUS', 'OK', 'KAN', 'INLAB', 'https://drive.google.com/file/d/1eLdCyxSggfJWFecLfEnsHkOZo_qkCHIi/view?usp=drive_link'),
(34, 'AC-PE-E34', 'Thermohygrometer', 'CMC-PWB', 'Thermometer-Humidity', 'HTC-1', 'HTC-1', '-', '2026-10-16', '2027-10-16', 'TUVNORD', 'OK', 'KAN', 'INLAB', 'https://drive.google.com/file/d/1SwcoYbUPUhOAJuI4o-fP2liVhljNlpVP/view?usp=drive_link'),
(35, 'AC-PE-E35', 'Thermohygrometer', 'CMC-PWB', 'Thermometer-Humidity', 'HTC-1', 'HTC-1', '-', '2026-10-16', '2027-10-16', 'TUVNORD', 'OK', 'KAN', 'INLAB', 'https://drive.google.com/file/d/13XvebZrIm4D6uiSub3ZGTYz26qzlzF5k/view?usp=drive_link'),
(36, 'AC-PE-E36', 'Thermohygrometer', 'PAINTING', 'Thermometer-Humidity', 'HTC-1', 'HTC-1', '-', '2026-10-16', '2027-10-16', 'TUVNORD', 'OK', 'KAN', 'INLAB', 'https://drive.google.com/file/d/1ZOOKQpdwUWorQROW_zngJGVK9N0xeGab/view?usp=drive_link'),
(37, 'AC-PE-E37', 'PH Tester', 'PAINTING', 'PH Tester', 'Eutech', 'pH Testr 20', '5046059', '2026-10-12', '2027-10-12', 'TUVNORD', 'OK', 'KAN', 'INLAB', 'https://drive.google.com/file/d/1QM7mXXnHLf71kv60kqrC1Hrp0OWvd4Xu/view?usp=drive_link'),
(38, 'AC-PE-E38', 'Dummy Resistor Box', 'IDU & ODU', 'Custom', 'Custom', 'Custom', '-', '2026-10-09', '2027-10-09', 'YISU', 'OK', 'KAN', 'INLAB', 'https://drive.google.com/file/d/1SIWWFeKpRvfL5sXZrcjsY1cHBnCpmaoy/view?usp=drive_link'),
(39, 'AC-PE-E39', 'Gas Leak Helium', 'IDU', 'External Gas Calibration', 'Inficon', 'P3000', '90001730254', '2026-10-07', '2027-10-07', 'YISU', 'OK', 'KAN', 'INLAB', NULL),
(40, 'AC-PE-E40', 'EC Tester', 'PAINTING', 'Waterproof EC Tester', 'Eutech', 'ECTEST11PLS', '3218755', '2026-10-31', '2027-10-31', 'TUVNORD', '-', 'KAN', 'INLAB', NULL),
(41, 'AC-PE-E41', 'EC Tester', 'BROKEN', 'Waterproof EC Tester', 'Eutech', 'ECTEST11PLS', '3075383', '2026-10-31', '2027-10-31', 'TUVNORD', '-', 'KAN', 'INLAB', NULL),
(42, 'AC-PE-E42', 'Gloss Meter Painting', 'SPARE', 'Gloss Meter Painting', 'BYK', 'Micro-gloss 60', '2007444', '2026-09-30', '2027-09-30', 'AEQUUS', '-', 'KAN', 'INLAB', 'https://drive.google.com/file/d/1epT9WEAjlCGlqaDHXnYJa8AIZLaHhjoq/view?usp=drive_link'),
(43, 'AC-PE-E43', 'Colori Meter', 'PAINTING', 'Colori Meter', 'HACH', 'DR900', '2007444', '2026-10-30', '2027-10-30', NULL, '-', 'KAN', 'ONSITE', NULL),
(44, 'AC-PE-E44', 'Timbangan', 'PAINTING', 'Timbangan', 'KENKO', 'KK-300W', '-', '2026-10-30', '2027-10-30', 'YISU', '-', 'KAN', 'ONSITE', NULL),
(45, 'AC-PE-E45', 'Timbangan', 'INJECTION', 'Timbangan', 'SONIC', 'A12E', 'IMI23028126', '2026-10-30', '2027-10-30', 'YISU', '-', 'KAN', 'ONSITE', NULL),
(46, 'AC-MC-V1', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1stUM4gw55O-SVX9arYeb1UU869uiWdOh/view?usp=drive_link'),
(47, 'AC-MC-V2', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1tpKTrsrRZWfpm3D6TofEoiv3xUlPGKOf/view?usp=drive_link'),
(48, 'AC-MC-V3', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1nM9i26Aj3IM2xVMJ5BPKLlSUpb50pqee/view?usp=drive_link'),
(49, 'AC-MC-V4', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1OueHZOixhhPGZyh_dGvIFVipFIe9RTGv/view?usp=drive_link'),
(50, 'AC-MC-V5', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1KeoWyvI9hTOd1arO1OjGoG97bnNNhZ8k/view?usp=drive_link'),
(51, 'AC-MC-V6', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1He0UWEE9CF8Hay8BBGyc9Vdwg2ZRaPIa/view?usp=drive_link'),
(52, 'AC-MC-V7', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1S-MAF_yZNBNCvj9QSygJSkq-lNivM6LB/view?usp=drive_link'),
(53, 'AC-MC-V8', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1coeY72HefL84yaRukL6SztUsOBrbE3pX/view?usp=drive_link'),
(54, 'AC-MC-V9', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1gWOGNG9spUrSaJPpiQ1IG-Bpt1CT1Z9i/view?usp=drive_link'),
(55, 'AC-MC-V10', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1Z-WRBNXZsyyZw-48BKKspnZKKy5maFpt/view?usp=drive_link'),
(56, 'AC-MC-V11', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1cc0E96jvFnTFmEFHva8KHhNE4LbJmcQl/view?usp=drive_link'),
(57, 'AC-MC-V12', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-17', '2027-10-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1MB8kWvAkfw0g4qVyz2nCnT0DQg60Zx6Y/view?usp=drive_link'),
(58, 'AC-MC-V13', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-17', '2027-10-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1zb08gexB5qCNqDf4GeWgZQPPp17q8NlG/view?usp=drive_link'),
(59, 'AC-MC-V14', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-17', '2027-10-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/112RAFp0ro1GhuAM4SqA4ZlqH9FCOGBQt/view?usp=drive_link'),
(60, 'AC-MC-V15', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-17', '2027-10-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1tJ0nmBH8q2OGFy7MoX-jjy8v7g93GW7X/view?usp=drive_link'),
(61, 'AC-MC-V16', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-17', '2027-10-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1DOkKjr-yHkdUkYuB8XYHIMgSNt45_Fmo/view?usp=drive_link'),
(62, 'AC-MC-V17', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-17', '2027-10-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1u_UGAAYT09pd3ayTxkfWws-SCSmVNUly/view?usp=drive_link'),
(63, 'AC-MC-V18', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1dEdSIkpnsTTak5TW6uQP9a38BAw3YxWu/view?usp=drive_link'),
(64, 'AC-MC-V19', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1uqBlb9t1Le769lVibHQsns-Uot9P7CWM/view?usp=drive_link'),
(65, 'AC-MC-V20', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/12fBbS3gHnnSO4YECRXiLHW5xHf7sRSaA/view?usp=drive_link'),
(66, 'AC-MC-V21', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1bbKs5dUTUl2owVNJ1hLozIlO3hhgFXKB/view?usp=drive_link'),
(67, 'AC-MC-V22', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1DDO6lPQduHPSTZkH4OHbGjCJIFD8qx76/view?usp=drive_link'),
(68, 'AC-MC-V23', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1lw1r7Wi8kGaZWmSuFC-lBTu4Dcr6OZ__/view?usp=drive_link'),
(69, 'AC-MC-V24', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/11-4tcjciFrAKKG5lHrTSjnMpMHOXKogp/view?usp=drive_link'),
(70, 'AC-MC-V25', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1idQpJGHBIHckLS3Z-0dlNHQijai121sx/view?usp=drive_link'),
(71, 'AC-MC-V26', 'Mesin Vacuum', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-18', '2027-10-18', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1ANSsv0K6tT6ikbFkSjdVx1B3KXhW5TOv/view?usp=drive_link'),
(72, 'AC-MC-PG1', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-17', '2027-10-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1UxycHpM4CB695lEYy7QSJs78qLlFaprz/view?usp=drive_link'),
(73, 'AC-MC-PG2', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-17', '2027-10-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1KIXo3XijEPwA1QASVPMPXvA8u8tY2K5N/view?usp=drive_link'),
(74, 'AC-MC-PG3', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-17', '2027-10-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1ffiiZ-2V-JoyP3pPkBdC2g_u-e-hhvAr/view?usp=drive_link'),
(75, 'AC-MC-PG4', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-17', '2027-10-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1DijWU9FnXxX3Ctcp1MuHhZX3SnQfMgZV/view?usp=drive_link'),
(76, 'AC-MC-PG5', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-17', '2027-10-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1ixXld_WA6m8xrmGNQNSEbYoAKm6X9yAW/view?usp=drive_link'),
(77, 'AC-MC-PG6', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-17', '2027-10-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1EQZRIOPACociyiT6cHAr53psOmihyhFR/view?usp=drive_link'),
(78, 'AC-MC-PG7', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1YezU20b0efSrnQWaLl_nn2-mcmmBnK8R/view?usp=drive_link'),
(79, 'AC-MC-PG8', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-03', '2027-10-03', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/10yUn4q-gIsTEF1fsro787SanZ2qGM7qj/view?usp=drive_link'),
(80, 'AC-MC-PG9', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-03', '2027-10-03', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1Rm5cNY8i5xLIsPCRBAru-eZpyjN_2Ytz/view?usp=drive_link'),
(81, 'AC-MC-PG10', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-03', '2027-10-03', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1xAcmhittE6Dr1ZvfJM2oSq-uYwXKi7J3/view?usp=drive_link'),
(82, 'AC-MC-PG11', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-03', '2027-10-03', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1U66oC1lcQLIPYK4CjcxrSMQc_UAihPqv/view?usp=drive_link'),
(83, 'AC-MC-PG12', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-03', '2027-10-03', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/15CktGwvydjISb75-KwcCnzXX4pDKOniP/view?usp=drive_link'),
(84, 'AC-MC-PG13', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-03', '2027-10-03', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1_TnBr5Alxw2t9X7AEV0m0z1gtZmWgCjL/view?usp=drive_link'),
(85, 'AC-MC-PG14', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-03', '2027-10-03', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1uAlwVbGZNuAeeexF-b0tXUBI8xGfWTRt/view?usp=drive_link'),
(86, 'AC-MC-PG15', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-03', '2027-10-03', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1CQZ2WuILf7h0sc_Qphd0GWaFy1-Si9WY/view?usp=drive_link'),
(87, 'AC-MC-PG16', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-03', '2027-10-03', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1DOFz2dMoIboAY8hcrqqNIcYIarzbzRw6/view?usp=drive_link'),
(88, 'AC-MC-PG17', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-03', '2027-10-03', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1nmVhqGxLm8AaW3w5iBnwcWEkY603l5gj/view?usp=drive_link'),
(89, 'AC-MC-PG18', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-03', '2027-10-03', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1hhoOPh_WINW8lntyzRpBG-NIrkq22HIJ/view?usp=drive_link'),
(90, 'AC-MC-PG19', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-03', '2027-10-03', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1ZHaWrXG8gfG-5lgLOkMGXbhCYagaMBqX/view?usp=drive_link'),
(91, 'AC-MC-PG20', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-03', '2027-10-03', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1Gz99HZjXvG65QmXyOXnP5Qnkhx-W4CQV/view?usp=drive_link'),
(92, 'AC-MC-PG21', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-03', '2027-10-03', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/13-wYN56bGG9Q8fs94aklebw2nZBoPneW/view?usp=drive_link'),
(93, 'AC-MC-PG22', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-03', '2027-10-03', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1f-Rikerjs4fW3ZcADVZ2QOOkSDx8pxQa/view?usp=drive_link'),
(94, 'AC-MC-PG23', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1CAaqOsi5H1WUJhquM57hBzJUPK4G5EQX/view?usp=drive_link'),
(95, 'AC-MC-PG24', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1xRIk4j40M-3RTALDsnLRExxBh1naR-RX/view?usp=drive_link'),
(96, 'AC-MC-PG25', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/19wztsDJQ4bby_8COG_fiygItMrdLrU1I/view?usp=drive_link'),
(97, 'AC-MC-PG26', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1WHEL7R77V-CWj4D5DIh95SOOxlYnpu-G/view?usp=drive_link'),
(98, 'AC-MC-PG27', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1lAoCBqlXsZ1FHVeXkn7XHlf1-5JGDoJ_/view?usp=drive_link'),
(99, 'AC-MC-PG28', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1WT8XOaguG1doKCT6TR-1Je5K5DU3jFhE/view?usp=drive_link'),
(100, 'AC-MC-PG29', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1xM6InRZefvwjpj_WnoNgB2eEpm3GTBaj/view?usp=drive_link'),
(101, 'AC-MC-PG30', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1FPYcgPC-gIDuxqlyzwQiL8oAt6kFL4sA/view?usp=drive_link'),
(102, 'AC-MC-PG31', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1QTAK7_SeZZzMN7C3dr4OMg_1NMwVzbKl/view?usp=drive_link'),
(103, 'AC-MC-PG32', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1PQah3ZsRBwkKasyHYWdBC0yFkQIIhriq/view?usp=drive_link'),
(104, 'AC-MC-PG33', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1xC7nhFNeSVxP7AjnEyPv0TgJ5Cssgirx/view?usp=drive_link'),
(105, 'AC-MC-PG34', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1WJJGEs_7YYXsBfRwvWaYNiDTV_7T6lMp/view?usp=drive_link'),
(106, 'AC-MC-PG35', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1cVAK2j0IFJnQuvo7jeM6w6DY5lKiUaRM/view?usp=drive_link'),
(107, 'AC-MC-PG36', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1RWfl7EA7OprmAsgm_iDKIWZmllYoE0dv/view?usp=drive_link'),
(108, 'AC-MC-PG37', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-04', '2027-10-04', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1eNZdQyV7t3IQTktkOUFYkAajtxaXRkP5/view?usp=drive_link'),
(109, 'AC-MC-PG38', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-17', '2027-10-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1wI2SuURQaaXutSdUnSreYMEiBZXWVkAV/view?usp=drive_link'),
(110, 'AC-MC-PG39', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-17', '2027-10-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1wBhgsHh8XnYsznBDwmO3jdWT-2wSlexh/view?usp=drive_link'),
(111, 'AC-MC-PG40', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-17', '2027-10-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1SwOCBSVyQ0_nafcip5KTtMFCUlz3cVm0/view?usp=drive_link'),
(112, 'AC-MC-PG41', 'Mesin Burn In', 'ODU', 'Pressure Gauge', 'KINTE', 'CEI', '-', '2026-10-17', '2027-10-17', 'AEQUUS', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1lOFeh1N4EEo2C2YZh8A2fbbZKd6n7ND9/view?usp=drive_link'),
(113, 'AC-GLD-R32-1', 'Gas Leak Detector R32', 'R32 GAS YARD 1', 'Gas Detector', 'NEW COSMOS', 'P5101NA', '-', '2026-08-09', '2027-08-09', 'WANNA BERNARD', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1oB1kaLiXGyZziUX6PSORCyWmJvD0i3it/view?usp=drive_link'),
(114, 'AC-GLD-R32-2', 'Gas Leak Detector R32', 'R32 GAS YARD 2', 'Gas Detector', 'NEW COSMOS', 'P5101NA', '-', '2026-08-09', '2027-08-09', 'WANNA BERNARD', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1oB1kaLiXGyZziUX6PSORCyWmJvD0i3it/view?usp=drive_link'),
(115, 'AC-GLD-R32-3', 'Gas Leak Detector R32', 'R32 LEAK TEST 1', 'Gas Detector', 'NEW COSMOS', 'P5101NA', '-', '2026-08-09', '2027-08-09', 'WANNA BERNARD', 'ERROR', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1oB1kaLiXGyZziUX6PSORCyWmJvD0i3it/view?usp=drive_link'),
(116, 'AC-GLD-R32-4', 'Gas Leak Detector R32', 'R32 LEAK TEST 2', 'Gas Detector', 'NEW COSMOS', 'P5101NA', '-', '2026-08-09', '2027-08-09', 'WANNA BERNARD', 'ERROR', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1oB1kaLiXGyZziUX6PSORCyWmJvD0i3it/view?usp=drive_link'),
(117, 'AC-GLD-R32-5', 'Gas Leak Detector R32', 'R32 CHARGING-1', 'Gas Detector', 'NEW COSMOS', 'P5101NA', '-', '2026-08-09', '2027-08-09', 'WANNA BERNARD', 'ERROR', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1oB1kaLiXGyZziUX6PSORCyWmJvD0i3it/view?usp=drive_link'),
(118, 'AC-GLD-R32-6', 'Gas Leak Detector R32', 'R32 CHARGING-2', 'Gas Detector', 'NEW COSMOS', 'P5101NA', '-', '2026-08-09', '2027-08-09', 'WANNA BERNARD', 'ERROR', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1oB1kaLiXGyZziUX6PSORCyWmJvD0i3it/view?usp=drive_link'),
(119, 'AC-GLD-LPG-1', 'Gas Leak Detector LPG', 'LPG ROOM', 'Gas Detector', 'NEW COSMOS', 'CMT3102X', '-', '2026-08-09', '2027-08-09', 'WANNA BERNARD', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1tGFPjC6TkrMFeG9F1tddOEaEsJBxlNUb/view?usp=drive_link'),
(120, 'AC-GLD-LPG-2', 'Gas Leak Detector LPG', 'LPG ASSY IDU-1', 'Gas Detector', 'NEW COSMOS', 'CMT3102X', '-', '2026-08-09', '2027-08-09', 'WANNA BERNARD', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1tGFPjC6TkrMFeG9F1tddOEaEsJBxlNUb/view?usp=drive_link'),
(121, 'AC-GLD-LPG-3', 'Gas Leak Detector LPG', 'LPG ASSY IDU-2', 'Gas Detector', 'NEW COSMOS', 'CMT3102X', '-', '2026-08-09', '2027-08-09', 'WANNA BERNARD', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1tGFPjC6TkrMFeG9F1tddOEaEsJBxlNUb/view?usp=drive_link'),
(122, 'AC-GLD-LPG-4', 'Gas Leak Detector LPG', 'LPG ASSY ODU-1', 'Gas Detector', 'NEW COSMOS', 'CMT3102X', '-', '2026-08-09', '2027-08-09', 'WANNA BERNARD', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1tGFPjC6TkrMFeG9F1tddOEaEsJBxlNUb/view?usp=drive_link'),
(123, 'AC-GLD-LPG-5', 'Gas Leak Detector LPG', 'LPG ASSY ODU-2', 'Gas Detector', 'NEW COSMOS', 'CMT3102X', '-', '2026-08-09', '2027-08-09', 'WANNA BERNARD', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1tGFPjC6TkrMFeG9F1tddOEaEsJBxlNUb/view?usp=drive_link'),
(124, 'AC-GLD-LPG-6', 'Gas Leak Detector LPG', 'LPG PIPING', 'Gas Detector', 'NEW COSMOS', 'CMT3102X', '-', '2026-08-09', '2027-08-09', 'WANNA BERNARD', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1tGFPjC6TkrMFeG9F1tddOEaEsJBxlNUb/view?usp=drive_link'),
(125, 'AC-GLD-LPG-7', 'Gas Leak Detector LPG', 'LPG HE-1', 'Gas Detector', 'NEW COSMOS', 'CMT3102X', '-', '2026-08-09', '2027-08-09', 'WANNA BERNARD', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1tGFPjC6TkrMFeG9F1tddOEaEsJBxlNUb/view?usp=drive_link'),
(126, 'AC-GLD-LPG-8', 'Gas Leak Detector LPG', 'LPG HE-2', 'Gas Detector', 'NEW COSMOS', 'CMT3102X', '-', '2026-08-09', '2027-08-09', 'WANNA BERNARD', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1tGFPjC6TkrMFeG9F1tddOEaEsJBxlNUb/view?usp=drive_link'),
(127, 'AC-WGH-TANK-1', 'Timbangan Ton Tank', 'Outdoor', 'Timbangan Ton Tank R32', 'METTLER TOLEDO', 'PFA584', 'C243131741', '2025-11-17', '2026-11-17', 'METTLER TOLEDO', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1ZdVlRdssmZWbf4ez-Pxf3Hy8Cnot6lNI/view?usp=drive_link'),
(128, 'AC-WGH-TANK-2', 'Timbangan Ton Tank', 'Outdoor', 'Timbangan Ton Tank R32', 'METTLER TOLEDO', 'PFA584', 'C243131742', '2025-11-17', '2026-11-17', 'METTLER TOLEDO', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1ZtPozi6h9JxR2j5tNw6Wt5n_9-nUbK4g/view?usp=drive_link'),
(129, 'AC-WGH-TANK-3', 'Timbangan Ton Tank', 'Outdoor', 'Timbangan Ton Tank R32', 'METTLER TOLEDO', 'PFA584', 'C243131743', '2025-11-17', '2026-11-17', 'METTLER TOLEDO', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/1MXqBtt6ChlWME2Fga9dVF22fGPjkbmwe/view?usp=drive_link'),
(130, 'AC-WGH-TANK-4', 'Timbangan Ton Tank', 'Outdoor', 'Timbangan Ton Tank R32', 'METTLER TOLEDO', 'PFA584', 'C243131744', '2025-11-17', '2026-11-17', 'METTLER TOLEDO', 'OK', 'KAN', 'ONSITE', 'https://drive.google.com/file/d/14Z4W7cRhVKp4sVyiEhl9uQUgKV9hgJ6V/view?usp=drive_link');

-- --------------------------------------------------------

--
-- Table structure for table `reminder_logs`
--

CREATE TABLE `reminder_logs` (
  `id` int(11) NOT NULL,
  `equipment_id` int(11) NOT NULL,
  `sent_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `equipments`
--
ALTER TABLE `equipments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reminder_logs`
--
ALTER TABLE `reminder_logs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `equipments`
--
ALTER TABLE `equipments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT for table `reminder_logs`
--
ALTER TABLE `reminder_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
