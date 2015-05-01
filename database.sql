-- phpMyAdmin SQL Dump
-- version 4.3.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 01, 2015 at 02:26 PM
-- Server version: 5.5.42
-- PHP Version: 5.4.37

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `it_56070055`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity`
--

CREATE TABLE IF NOT EXISTS `activity` (
  `id` int(11) unsigned NOT NULL COMMENT 'รหัสของกิจกรรม',
  `scenario_id` int(11) unsigned NOT NULL COMMENT 'รหัสของฉากของกิจกรรมนี้',
  `order` int(11) NOT NULL COMMENT 'ลำดับของกิจกรรม',
  `type` int(1) NOT NULL COMMENT 'ประเภทของกิจกรรม',
  `created_at` datetime NOT NULL COMMENT 'เวลาที่ถูกสร้างขึ้น',
  `updated_at` datetime DEFAULT NULL COMMENT 'เวลาที่แก้ไขครั้งล่าสุด'
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `activity`
--

INSERT INTO `activity` (`id`, `scenario_id`, `order`, `type`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 1, '0000-00-00 00:00:00', '2015-04-23 13:50:03'),
(3, 2, 2, 1, '2015-03-30 11:03:24', '2015-04-18 17:03:50'),
(4, 2, 4, 1, '2015-03-30 11:03:40', '2015-04-18 17:03:50'),
(5, 1, 1, 5, '0000-00-00 00:00:00', '2015-04-23 13:50:03'),
(6, 2, 1, 5, '0000-00-00 00:00:00', '2015-04-18 17:03:50'),
(7, 2, 5, 1, '0000-00-00 00:00:00', '2015-04-18 17:03:50'),
(8, 2, 6, 1, '0000-00-00 00:00:00', '2015-04-18 17:03:50'),
(9, 2, 7, 1, '2015-03-30 12:28:13', '2015-04-18 17:03:50'),
(10, 2, 8, 1, '2015-03-30 12:28:13', '2015-04-18 17:03:50'),
(11, 2, 9, 1, '2015-03-30 12:28:27', '2015-04-18 17:03:50'),
(12, 2, 11, 1, '2015-03-30 12:28:27', '2015-04-18 17:03:50'),
(13, 2, 3, 5, '0000-00-00 00:00:00', '2015-04-18 17:03:50'),
(14, 2, 12, 3, '0000-00-00 00:00:00', '2015-04-18 17:03:50'),
(15, 2, 10, 2, '2015-04-12 16:43:51', '2015-04-18 17:03:50'),
(16, 2, 13, 1, '2015-04-12 17:19:50', '2015-04-18 17:03:50'),
(17, 2, 14, 4, '2015-04-12 17:19:50', '2015-04-18 17:03:50'),
(25, 1, 3, 1, '2015-04-14 09:50:08', '2015-04-23 13:50:03'),
(28, 1, 4, 4, '2015-04-14 09:58:45', '2015-04-23 13:50:03'),
(33, 11, 1, 1, '2015-04-14 22:51:25', '2015-04-14 22:52:35'),
(34, 11, 2, 2, '2015-04-14 22:51:25', '2015-04-14 22:52:35'),
(35, 11, 3, 4, '2015-04-14 22:52:35', NULL),
(37, 1, 5, 6, '2015-04-16 19:27:41', '2015-04-23 13:50:04'),
(38, 1, 6, 1, '2015-04-16 21:51:53', '2015-04-23 13:50:04'),
(43, 1, 7, 5, '2015-04-18 01:54:23', '2015-04-23 13:50:04'),
(45, 13, 1, 2, '2015-04-18 13:41:09', NULL),
(47, 19, 1, 5, '2015-04-22 12:48:11', '2015-05-01 18:29:18'),
(48, 19, 4, 1, '2015-04-22 12:48:11', '2015-05-01 18:29:18'),
(49, 19, 5, 1, '2015-04-22 12:48:11', '2015-05-01 18:29:18'),
(50, 19, 6, 1, '2015-04-22 12:48:11', '2015-05-01 18:29:18'),
(51, 19, 7, 1, '2015-04-22 12:48:11', '2015-05-01 18:29:18'),
(52, 19, 3, 1, '2015-04-22 13:04:04', '2015-05-01 18:29:18'),
(53, 19, 8, 4, '2015-04-22 13:10:48', '2015-05-01 18:29:18'),
(54, 20, 1, 5, '2015-04-22 14:16:21', '2015-05-01 18:35:52'),
(55, 20, 4, 1, '2015-04-22 14:16:21', '2015-05-01 18:35:52'),
(56, 20, 5, 5, '2015-04-22 14:16:21', '2015-05-01 18:35:52'),
(57, 20, 6, 1, '2015-04-22 14:16:21', '2015-05-01 18:35:52'),
(58, 20, 7, 1, '2015-04-22 14:16:21', '2015-05-01 18:35:52'),
(59, 20, 8, 1, '2015-04-22 14:16:21', '2015-05-01 18:35:52'),
(60, 20, 9, 5, '2015-04-22 14:24:48', '2015-05-01 18:35:52'),
(61, 20, 10, 1, '2015-04-22 14:24:48', '2015-05-01 18:35:52'),
(62, 20, 11, 1, '2015-04-22 14:24:48', '2015-05-01 18:35:52'),
(63, 20, 12, 1, '2015-04-22 14:24:48', '2015-05-01 18:35:52'),
(64, 20, 13, 1, '2015-04-22 14:24:48', '2015-05-01 18:35:52'),
(65, 21, 1, 5, '2015-04-22 14:29:14', '2015-05-01 18:31:47'),
(67, 21, 3, 1, '2015-04-22 14:29:14', '2015-05-01 18:31:47'),
(68, 21, 4, 5, '2015-04-22 14:31:23', '2015-05-01 18:31:47'),
(69, 21, 5, 1, '2015-04-22 14:37:40', '2015-05-01 18:31:47'),
(70, 21, 6, 5, '2015-04-22 14:37:40', '2015-05-01 18:31:47'),
(71, 21, 7, 1, '2015-04-22 14:37:40', '2015-05-01 18:31:47'),
(72, 21, 8, 1, '2015-04-22 14:37:40', '2015-05-01 18:31:47'),
(74, 20, 14, 4, '2015-04-22 14:40:04', '2015-05-01 18:35:52'),
(75, 22, 1, 5, '2015-04-22 15:58:18', '2015-05-01 18:32:15'),
(76, 22, 3, 1, '2015-04-22 15:58:18', '2015-05-01 18:32:15'),
(77, 22, 4, 5, '2015-04-22 16:08:07', '2015-05-01 18:32:15'),
(78, 22, 5, 1, '2015-04-22 16:08:07', '2015-05-01 18:32:15'),
(79, 22, 6, 1, '2015-04-22 16:08:07', '2015-05-01 18:32:15'),
(80, 22, 7, 5, '2015-04-22 16:08:07', '2015-05-01 18:32:15'),
(81, 22, 8, 1, '2015-04-22 16:08:07', '2015-05-01 18:32:15'),
(82, 22, 9, 1, '2015-04-22 16:08:07', '2015-05-01 18:32:15'),
(83, 23, 1, 5, '2015-04-23 11:30:02', '2015-05-01 18:42:16'),
(84, 23, 3, 1, '2015-04-23 11:34:26', '2015-05-01 18:42:16'),
(85, 23, 4, 5, '2015-04-23 11:34:26', '2015-05-01 18:42:16'),
(86, 23, 5, 1, '2015-04-23 11:34:26', '2015-05-01 18:42:16'),
(92, 23, 6, 5, '2015-04-23 11:50:21', '2015-05-01 18:42:16'),
(93, 23, 7, 2, '2015-04-23 11:50:21', '2015-05-01 18:42:16'),
(94, 23, 8, 5, '2015-04-23 11:50:21', '2015-05-01 18:42:16'),
(95, 23, 9, 1, '2015-04-23 11:50:21', '2015-05-01 18:42:16'),
(96, 23, 10, 5, '2015-04-23 11:50:21', '2015-05-01 18:42:16'),
(97, 23, 11, 1, '2015-04-23 11:50:21', '2015-05-01 18:42:16'),
(98, 23, 12, 1, '2015-04-23 11:50:21', '2015-05-01 18:42:16'),
(99, 23, 13, 1, '2015-04-23 11:50:21', '2015-05-01 18:42:16'),
(100, 23, 14, 1, '2015-04-23 11:50:21', '2015-05-01 18:42:16'),
(101, 23, 15, 4, '2015-04-23 11:50:21', '2015-05-01 18:42:16'),
(102, 23, 16, 5, '2015-04-23 11:50:21', '2015-05-01 18:42:16'),
(103, 23, 17, 1, '2015-04-23 12:01:02', '2015-05-01 18:42:16'),
(104, 23, 18, 5, '2015-04-23 12:01:02', '2015-05-01 18:42:16'),
(105, 23, 19, 1, '2015-04-23 12:01:02', '2015-05-01 18:42:16'),
(106, 23, 20, 1, '2015-04-23 12:01:02', '2015-05-01 18:42:16'),
(107, 23, 21, 1, '2015-04-23 12:01:02', '2015-05-01 18:42:16'),
(108, 23, 22, 5, '2015-04-23 12:01:02', '2015-05-01 18:42:16'),
(109, 23, 23, 1, '2015-04-23 12:07:13', '2015-05-01 18:42:16'),
(110, 23, 24, 2, '2015-04-23 12:07:13', '2015-05-01 18:42:16'),
(111, 23, 25, 5, '2015-04-23 12:07:13', '2015-05-01 18:42:16'),
(112, 23, 26, 1, '2015-04-23 12:07:13', '2015-05-01 18:42:16'),
(113, 23, 27, 4, '2015-04-23 12:07:13', '2015-05-01 18:42:16'),
(114, 24, 1, 1, '2015-04-23 12:08:08', NULL),
(115, 20, 2, 6, '2015-04-28 13:27:17', '2015-05-01 18:35:52'),
(116, 20, 3, 1, '2015-04-28 13:27:17', '2015-05-01 18:35:52'),
(117, 19, 2, 6, '2015-04-28 13:28:21', '2015-05-01 18:29:18'),
(118, 21, 2, 6, '2015-04-28 13:32:16', '2015-05-01 18:31:47'),
(119, 21, 9, 4, '2015-04-28 13:32:16', '2015-05-01 18:31:47'),
(120, 22, 2, 6, '2015-04-28 13:52:33', '2015-05-01 18:32:15'),
(121, 22, 10, 4, '2015-04-28 13:54:21', '2015-05-01 18:32:15'),
(122, 23, 28, 5, '2015-04-28 14:45:24', '2015-05-01 18:42:16'),
(123, 23, 29, 1, '2015-04-28 14:45:24', '2015-05-01 18:42:16'),
(124, 23, 30, 4, '2015-04-28 14:45:42', '2015-05-01 18:42:16'),
(125, 23, 2, 6, '2015-04-28 15:45:35', '2015-05-01 18:42:16');

-- --------------------------------------------------------

--
-- Table structure for table `activity_choice`
--

CREATE TABLE IF NOT EXISTS `activity_choice` (
  `activity_id` int(11) unsigned NOT NULL COMMENT 'รหัสของกิจกรรม',
  `order` int(1) NOT NULL COMMENT 'ลำดับของกิจกรรม',
  `text` text COLLATE utf8_bin COMMENT 'ข้อความที่แสดง',
  `target_id` int(11) unsigned DEFAULT NULL COMMENT 'รหัสกิจกรรมใหม่ที่ต้องการเปลี่ยนไปเมื่อเลือกตัวเลือกนี้'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `activity_choice`
--

INSERT INTO `activity_choice` (`activity_id`, `order`, `text`, `target_id`) VALUES
(15, 1, 'AAAAB', 10),
(15, 2, 'BBBBCC', 12),
(34, 1, '454654', 0),
(34, 2, '4564645', 1),
(34, 3, '86766456', 2),
(93, 1, 'ไปกับ อาซามิ', 7),
(93, 2, 'ไปกับ มิซากิ', 15),
(110, 1, 'ข้าวหน้าแกงกะหรี่', 27),
(110, 2, 'ราเมง', 24);

-- --------------------------------------------------------

--
-- Table structure for table `activity_dialog`
--

CREATE TABLE IF NOT EXISTS `activity_dialog` (
  `activity_id` int(11) unsigned NOT NULL COMMENT 'รหัสกิจกรรม',
  `title` text COLLATE utf8_bin COMMENT 'หัวข้อของกล่องข้อความ',
  `dialog` text COLLATE utf8_bin COMMENT 'ข้อความที่แสดง',
  `music` text COLLATE utf8_bin COMMENT 'เสียงประกอบ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `activity_dialog`
--

INSERT INTO `activity_dialog` (`activity_id`, `title`, `dialog`, `music`) VALUES
(1, 'Intro', 'วันนี้เป็นวันธรรมดาๆในการเรียน ม.ปลาย ที่โรงเรียน(ชื่อโรงเรียน) ', 'Ring03.wav'),
(3, '', '(เดินชนกัน).', ''),
(4, 'MC_NAME', 'โอ้ยยยยย!!', ''),
(7, 'b1', 'ขอโทษค่ะ เป็นอะไรหรือเปล่าคะ', ''),
(8, 'MC_NAME', 'ไม่เป็นไรครับ ว่าแต่ชุดแบบนี้คุณอยู่โรงเรียนเดียวกับผมหรือเปล่าครับ', ''),
(9, 'b1', 'ค่ะ', ''),
(10, 'MC_NAME', 'ผมชื่อ MC_NAME', ''),
(11, 'b1', 'ฉัน(ชื่อ) พอดีฉันไม่รู้ทางไปโรงเรียน อยากให้คุณช่วยพาไปหน่อยได้ไหมค่ะ พอดีพึ่งมาครั้งแรก', ''),
(12, 'MC_NAME', 'ได้เลยครับ งั้นเราเดินไปโรงเรียน ด้วยกันนะ ^^^^', ''),
(16, 'MC_NAME', 'พอดีผมมีธุระที่อื่นก่อนน่ะครับ เดี๋ยวผมบอกทางให้แทนแล้วกันนะครับ', ''),
(25, 'AA', 'BB', ''),
(33, 'dfsdfsdfsdf', 'sdfdsfffdsfdfsfsffsfdsfdsfdsfsdfsdfdsdsffsddsfsdf', ''),
(38, 'sasd', 'dfsdfsdf', '2558-04-16_21-51-36_sound.wav'),
(48, 'MC_NAME', 'วันนี้ก็เป็นวันธรรมดาๆในการเรียน ม.ปลาย ที่โรงเรียน โฮะริโคะชิ\n', ''),
(49, 'MC_NAME', 'โรงเรียนของผมเป็นโรงเรียนที่อยู่ท่ามกลางเมืองที่สงบสุข', ''),
(50, 'MC_NAME', 'ซึ่่งผมคิดว่า ผมโชคดีที่ได้เรียนในโรงเรียนแห่งนี้ ... ละมั้ง ', ''),
(51, 'MC_NAME', 'แต่เดี๋ยวก่อน  ตอนนี้ต้องรีบไปโรงเรียนแล้ว!!', ''),
(52, 'MC_NAME', 'ผมชื่อ ... MC_NAME ... แต่มันก็ไม่ได้สำคัญอะไรหรอก ผมก็เป็นคนธรรมดา กับวันที่แสนจะธรรมดา กับการเป็นเด็กม.ปลายที่แสนจะน่าเบื่อ', ''),
(55, 'MC_NAME', 'โอ้ยยยยย!!!!', ''),
(57, '???', 'ขะ ขะ . . . ขอโทษค่ะ เป็นอะไรหรือเปล่าค่ะ', ''),
(58, 'MC_NAME', 'เอ่ออ. . . ไม่เป็นไรมากครับ แค่ถลอกนิดหน่อย', ''),
(59, 'MC_NAME', 'ว่าแต่ชุดนักเรียนแบบนี้ เธอเรียนอยู่ที่ โรงเรียน โฮะริโคะชิ รึเปล่าครับ', ''),
(61, '???', 'ใช่ค่ะ พอดีเพิ่งย้ายมาจากต่างจังหวัดค่ะ', ''),
(62, 'MC_NAME', 'ผมชื่อ MC_NAME ครับ แล้วคุณชื่อ.  .  .', ''),
(63, 'อาซามิ', 'ฉันชื่อ อาซามิ ค่ะ ยินดีที่ได้รู้จักนะคะ ว่าแต่ คุณช่วยพาไปโรงเรียนได้มั้ยคะ พอดีหลงทางมาซักพักแล้ว', ''),
(64, 'MC_NAME', 'อ๋อ ได้เลยครับ ไปกันเถอะสายแล้วนะ', ''),
(67, 'มิซากิ', 'MC_NAME!!! สายตลอดเลยนะนายเนี้ย แล้วนั้นพาใครมาด้วยละ', ''),
(69, 'อาซามิ', 'สวัสดีค่ะ ชื่อ อาซามิ เป็นเด็กนักเรียนใหม่ที่นี่ค่ะ', ''),
(71, 'มิซากิ', 'ฉันชื่อ มิซากิจ้ะ เป็นเพื่อนของMC_NAMEเค้า ยินดีที่ได้รู้จักจ้า แต่ตอนนี้สายแล้วไปเข้าเรียนกันเถอะ', '2015-04-28_13-50-53_ออดเลิกเรียน.mp3'),
(72, 'MC_NAME', 'ปะ ไปเรียนกัน', ''),
(76, 'อาจารย์', 'เอาหล่ะนักเรียนทุกคน วันนี้พวกเรามีเพื่อนใหม่ เพิ่งย้ายโรงเรียนมาจาก จังหวัดโอกินาว่านะค้าาา', ''),
(78, 'อาซามิ', 'สวัสดีค่ะ ชื่อ นาโอกิ อาซามิค่ะ ฝากเนื้อฝากตัวด้วยนะค่ะ', ''),
(79, 'MC_NAME', '(เอ๋. . .  เรียนห้องเดียวกันเลยแหะ )', ''),
(81, 'อาจารย์', 'โอเคจ้ะ อาซามิจัง เธอไปนั่งตรงนั้นนะ', ''),
(82, 'อาจารย์', 'วันนี้เรามาเริ่มเรียนกันเลย นะจ้ะ', ''),
(84, 'มิซากิ', 'ฮาาาาาาาาาาาาาาาาาาาารุ ไปหาอะไรกินกัน หิวแล้วววว มีเรื่องอยากจะมาเล่าตอนฉันไปเที่ยว ช่วงสุดสัปดาห์ เยอะแยะเลย', ''),
(86, 'อาซามิ', 'นี้ MC_NAMEซัง ไปนั่งกินข้าวด้วยกันได้มั้ย ยังไม่ค่อยรู้จักใครที่นี้เลย ฉันอยากให้MC_NAMEช่วย พาเดินดูรอบๆหน่อยหน่ะ', ''),
(95, 'อาซามิ', 'ขอบคุณมากนะค่ะ ไปซื้อข้าวกันนะคะ', ''),
(97, 'MC_NAME', 'ซื้อข้าวอะไรดี เดี๋ยวผมไปซื้อให้นะครับ', ''),
(98, 'อาซามิ', 'ขอเป็นข้าวแกงกะหรี่ ก็ได้ค่ะ ขอบคุณนะคะ', ''),
(99, 'MC_NAME', 'ไม่เป็นไรครับ แค่นี้เอง เดี๋ยวกินเสร็จผมพาไปเดินดูรอบๆโรงเรียนเลยนะครับ', ''),
(100, 'อาซามิ', 'ได้เลยค่ะ', ''),
(103, 'อาซามิ', 'อ่า.. งั้นไม่เป็นไรค่ะ', ''),
(105, 'มิซากิ', 'นี้นาย ฝากซื้อข้าวทีได้ป่าว เร็วๆด้วยหิวแล้วว', ''),
(106, 'MC_NAME', 'แล้วทำไมเธอไม่ไปซื้อเองเล่าา มาใช้ชั้นทำไม อ่าๆ ก็ได้จะกินอะไร', ''),
(107, 'มิซากิ', 'ลองไปซื้อมาสิ้ อยากรู้ว่าจะจำได้มั้ย ว่าฉันชอบอะไร', ''),
(109, 'แม่ค้า', 'สวัสดีค่ะ วันนี้ รับอะไรดีค่ะ', ''),
(112, 'มิซากิ', 'แอร๊ยยยย.... นายจำได้ด้วยหรอเนี้ยว่าฉันชอบกินอะไร ไม่อยากจะเชื่อเลย แต้งกิ้วจ้ะ', ''),
(114, 'จบแล้วจ้าา', 'จบแล้วจ้าา', ''),
(116, '', '', '2015-04-28_13-27-20_ชนกัน.mp3'),
(123, 'มิซากิ', 'นายซื้ออะไรมาหน่ะ จำไม่ได้หรอว่าชั้นชอบกินอะไร แย่ที่สุด เชอะ!!', '');

-- --------------------------------------------------------

--
-- Table structure for table `activity_goto`
--

CREATE TABLE IF NOT EXISTS `activity_goto` (
  `activity_id` int(11) unsigned NOT NULL COMMENT 'รหัสของกิจกรรม',
  `target_id` int(11) unsigned DEFAULT NULL COMMENT 'รหัสของหน้าใหม่ที่ต้องการเปลี่ยน'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `activity_goto`
--

INSERT INTO `activity_goto` (`activity_id`, `target_id`) VALUES
(14, 13),
(17, 11),
(28, NULL),
(35, 2),
(53, 20),
(74, 21),
(101, 24),
(113, 24),
(119, 22),
(121, 23),
(124, 24);

-- --------------------------------------------------------

--
-- Table structure for table `activity_media`
--

CREATE TABLE IF NOT EXISTS `activity_media` (
  `activity_id` int(11) unsigned NOT NULL COMMENT 'รหัสของกิจกรรม',
  `media` text COLLATE utf8_bin NOT NULL COMMENT 'ลิงค์ของสื่อ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `activity_media`
--

INSERT INTO `activity_media` (`activity_id`, `media`) VALUES
(5, 'bedroom_by_badriel-d61v402.png'),
(6, 'tumblr_static_bg.jpg'),
(13, 'bump1.jpg'),
(37, '2558-04-16_21-28-30_Tell Your World(Seksun feat.).mp3'),
(43, '2015-04-18_01-54-56_1388646127-1388645998-o.jpg'),
(47, '2015-04-28_13-27-58_bedroom_by_badriel-d61v402.png'),
(54, '2015-04-28_13-25-42_tumblr_static_bg.jpg'),
(56, '2015-04-28_13-26-05_bg3.jpg'),
(60, '2015-04-28_13-26-28_bg4.jpg'),
(65, '2015-04-28_13-31-00_bg5.jpg'),
(68, '2015-04-28_13-32-00_bg6.jpg'),
(70, '2015-04-28_13-32-15_bg7.jpg'),
(75, '2015-04-28_13-53-18_bg8.jpg'),
(77, '2015-04-28_13-53-30_bg9.jpg'),
(80, '2015-04-28_13-54-05_bg10.jpg'),
(83, '2015-04-28_13-55-22_bg15_2.jpg'),
(85, '2015-04-28_13-55-57_bg12.jpg'),
(92, '2015-04-28_13-56-25_bg13.jpg'),
(94, '2015-04-28_13-57-04_bg14_1.jpg'),
(96, '2015-04-28_13-57-43_bg14_2.jpg'),
(102, '2015-04-28_13-58-31_bg15_1.jpg'),
(104, '2015-04-28_13-59-05_bg15_2.jpg'),
(108, '2015-04-28_13-59-43_cafeteria-1.jpg'),
(111, '2015-04-28_14-20-01_bg15_2_1.jpg'),
(115, '2015-04-28_13-48-08_bg เดินชน.mp3'),
(117, '2015-04-28_13-48-32_bg ห้องนอน.mp3'),
(118, '2015-04-28_13-49-36_bg หน้า รร..mp3'),
(120, '2015-04-28_13-52-17_bg ห้องเรียน.mp3'),
(122, '2015-04-28_14-45-33_bg15_2_2.jpg'),
(125, '2015-04-28_15-45-08_bg ร้านข้าว.mp3');

-- --------------------------------------------------------

--
-- Table structure for table `credit_log`
--

CREATE TABLE IF NOT EXISTS `credit_log` (
  `id` int(11) unsigned NOT NULL COMMENT 'รหัสของประวัติเครดิต',
  `owner_id` int(11) unsigned NOT NULL COMMENT 'รหัสของสมาชิก',
  `old_credit` double NOT NULL COMMENT 'ยอดเครดิตเก่า',
  `new_credit` double NOT NULL COMMENT 'ยอดเครดิตใหม่',
  `detail` text COLLATE utf8_bin NOT NULL COMMENT 'ข้อความบันทึกประวัติ',
  `change_by` int(11) unsigned NOT NULL COMMENT 'รหัสของสมาชิกที่เป็นผู้เปลี่ยนแปลงเครดิต',
  `created_at` datetime NOT NULL COMMENT 'เวลาที่ถูกสร้างขึ้น'
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `credit_log`
--

INSERT INTO `credit_log` (`id`, `owner_id`, `old_credit`, `new_credit`, `detail`, `change_by`, `created_at`) VALUES
(9, 28, 9999997870, 9999997141, 'Purchased projects ID:5', 28, '2015-04-21 14:09:07'),
(10, 28, 9999997141, 9999997041, 'Purchased projects ID:8', 28, '2015-04-21 14:09:07'),
(11, 28, 9999997041, 9999996941, 'Purchased projects ID:9', 28, '2015-04-21 14:09:07'),
(12, 28, 9999996941, 9999996741, 'Purchased projects ID:2', 28, '2015-04-21 14:09:44'),
(14, 28, 50000000, 5000, 'Changed by admin.', 28, '2015-04-21 14:17:12'),
(15, 48, 0, 8.01, 'Changed by admin.', 28, '2015-04-21 14:24:28'),
(16, 48, 8.01, 2.09, 'Changed by admin.', 28, '2015-04-21 14:25:44'),
(17, 28, 5000, 4500, 'Purchased projects ID:3', 28, '2015-04-21 14:53:55'),
(19, 28, 4500, 500000, 'Changed by admin.', 28, '2015-04-21 22:12:14'),
(20, 1, 5, 542.25, 'Credits from selling projects.', 28, '2015-04-21 23:39:16'),
(21, 28, 500000, 500100, 'Credits from selling projects.', 28, '2015-04-21 23:39:16'),
(22, 1, 542.25, 1079.5, 'Credits from selling projects.', 28, '2015-04-21 23:42:39'),
(23, 28, 500100, 500200, 'Credits from selling projects.', 28, '2015-04-21 23:42:40'),
(24, 28, 500200, 500001, 'Purchased projects ID:38', 28, '2015-04-28 15:50:48'),
(25, 28, 500001, 500100.5, 'Credits from selling projects.', 28, '2015-04-29 22:11:46'),
(26, 28, 500100.5, 500000.5, 'Purchased projects ID:7', 28, '2015-04-30 12:47:04'),
(27, 3, 99998, 123, 'Changed by admin.', 28, '2015-04-30 12:49:55'),
(28, 28, 500000.5, 499900.5, 'Purchased projects ID:10', 28, '2015-04-30 12:51:39'),
(29, 1, 1079.5, 1179.5, 'Credits from selling projects.', 28, '2015-04-30 12:51:54'),
(30, 1, 1179.5, 1334.5, 'Credits from selling projects.', 28, '2015-05-01 15:31:57'),
(31, 28, 499900.5, 500000, 'Credits from selling projects.', 28, '2015-05-01 15:31:58'),
(32, 1, 1334.5, 1489.5, 'Credits from selling projects.', 28, '2015-05-01 15:39:01'),
(33, 1, 1489.5, 1644.5, 'Credits from selling projects.', 28, '2015-05-01 15:40:34'),
(34, 1, 1644.5, 1799.5, 'Credits from selling projects.', 28, '2015-05-01 15:46:50'),
(35, 1, 1799.5, 1954.5, 'Credits from selling projects.', 28, '2015-05-01 15:48:24'),
(36, 1, 1954.5, 2109.5, 'Credits from selling projects.', 28, '2015-05-01 15:51:25'),
(37, 28, 500000, 500099.5, 'Credits from selling projects.', 28, '2015-05-01 15:51:59'),
(38, 1, 2109.5, 2264.5, 'Credits from selling projects.', 28, '2015-05-01 15:52:30'),
(39, 1, 2264.5, 2419.5, 'Credits from selling projects.', 28, '2015-05-01 15:57:31'),
(40, 28, 500099.5, 500199, 'Credits from selling projects.', 28, '2015-05-01 15:57:31'),
(41, 28, 500199, 500199, 'Changed by admin.', 28, '2015-05-01 18:46:58'),
(42, 1, 2419.5, 2574.5, 'Credits from selling projects.', 28, '2015-05-01 18:52:17');

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE IF NOT EXISTS `project` (
  `id` int(11) unsigned NOT NULL COMMENT 'รหัสของโปรเจค',
  `title` text COLLATE utf8_bin COMMENT 'ชื่อของโปรเจค',
  `description` text COLLATE utf8_bin COMMENT 'คำอธิบายของโปรเจค',
  `user_id` int(11) unsigned NOT NULL COMMENT 'รหัสสมาชิกของเจ้าของโปรเจค',
  `price` double NOT NULL DEFAULT '0' COMMENT 'ราคา',
  `dividend` double NOT NULL DEFAULT '50' COMMENT 'ส่วนแบ่งที่ให้กับผู้สร้าง',
  `visible` int(3) NOT NULL DEFAULT '0' COMMENT 'สิทธิ์การเข้าถึง',
  `rate` int(2) unsigned NOT NULL DEFAULT '0' COMMENT 'อายุขั้นต่ำที่สามารถดูได้',
  `cover` text COLLATE utf8_bin COMMENT 'ลิงค์ของภาพหน้าปก',
  `first_scene_id` int(11) unsigned DEFAULT NULL COMMENT 'รหัสของฉากแรก',
  `created_at` datetime NOT NULL COMMENT 'เวลาที่ถูกสร้างขึ้น',
  `updated_at` datetime DEFAULT NULL COMMENT 'เวลาที่ถูกแก้ไขครั้งล่าสุด'
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`id`, `title`, `description`, `user_id`, `price`, `dividend`, `visible`, `rate`, `cover`, `first_scene_id`, `created_at`, `updated_at`) VALUES
(1, 'วันฟ้าใส วัยคว้าฝัน', 'Product Description1\n<p>Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.</p>\nProduct Highlights\n\n<ul>\n	<li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\n	<li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\n	<li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\n	<li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\n	<li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\n	<li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\n</ul>\nUsage Information\n\n<p>Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.</p>\n', 28, 100, 70, 70, 10, 'Supipara_MainVisual_logo (Custom).jpg', 1, '2015-04-01 00:00:00', '2015-05-01 18:50:34'),
(2, 'วันคว้าฝัน วัยฟ้าใส', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\r\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 28, 200, 50, 1, 0, 'y9TLcXs (Custom).jpg', 1, '2015-04-01 00:00:00', NULL),
(3, 'วันคว้าใส วัยคว้าฝัน', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\r\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 1, 500, 50, 1, 10, 'cloverlib (Custom).png', 1, '2015-04-01 00:00:00', NULL),
(4, 'วันฟ้าควัน วัยฟ้าใส', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\r\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 1, 10000, 50, 0, 10, 'Ef-_The_Latter_Tale._visual_novel_cover (Custom).jpg', 1, '2015-04-01 00:00:00', '2015-04-15 19:44:41'),
(5, 'ฝันคว้าหวัน ควันฟ้าใส', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\r\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 1, 729, 50, 1, 10, 'Friends.(Visual.Novel).full.1044325 (Custom).jpg', 1, '2015-04-01 00:00:00', NULL),
(6, 'วันฟ้าใส วัยคว้าฝัน', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\r\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 1, 100, 50, 1, 10, 'heart_had_wings_03 (Custom).jpg', 1, '2015-04-01 00:00:00', NULL),
(7, 'วันฟ้าใส วัยคว้าฝัน', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\r\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 1, 100, 50, 1, 10, 'Hello,_Good-bye_Visual_Novel_Cover_Art (Custom).jpg', 1, '2015-04-01 00:00:00', NULL),
(8, 'วันฟ้าใส วัยคว้าฝัน', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\r\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 1, 100, 50, 1, 10, 'reaching-out-visual-novel (Custom).png', 1, '2015-04-01 00:00:00', NULL),
(9, 'วันฟ้าใส วัยคว้าฝัน', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\r\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 1, 100, 50, 1, 10, 'singan-da-song (Custom).png', 1, '2015-04-01 00:00:00', NULL),
(10, 'วันฟ้าใส วัยคว้าฝัน', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\r\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 1, 100, 50, 1, 10, 'startup (Custom).png', 1, '2015-04-01 00:00:00', NULL),
(11, 'วันฟ้าใส วัยคว้าฝัน', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\r\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 1, 100, 50, 1, 10, 'Supipara_MainVisual_logo (Custom).jpg', 1, '2015-04-01 00:00:00', NULL),
(12, 'วันฟ้าใส วัยคว้าฝัน', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\r\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 1, 100, 50, 1, 10, 'what-is-a-visual-novel-header (Custom).jpg', 1, '2015-04-01 00:00:00', NULL),
(13, 'วันฟ้าใส วัยคว้าฝัน', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\r\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 1, 100, 50, 1, 10, 'Clannad_game_cover (Custom).jpg', 1, '2015-04-01 00:00:00', NULL),
(14, 'วันฟ้าใส วัยคว้าฝัน', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\n\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 1, 100, 50, 1, 10, '230px-Clear_original_cover (Custom).jpg', 1, '2015-04-01 00:00:00', NULL),
(15, 'วันฟ้าใส วัยคว้าฝัน', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\r\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 1, 100, 50, 1, 10, '2dhsif6 (Custom).jpg', 1, '2015-04-01 00:00:00', NULL),
(16, 'วันฟ้าใส วัยคว้าฝัน', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\r\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 1, 100, 50, 1, 10, 'what-is-a-visual-novel-header (Custom).jpg', 1, '2015-04-01 00:00:00', NULL),
(17, 'วันฟ้าใส วัยคว้าฝัน', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\r\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 1, 100, 50, 1, 10, 'singan-da-song (Custom).png', 1, '2015-04-01 00:00:00', NULL),
(19, 'วันฟ้าใส วัยคว้าฝัน', '                            <h4>Product Description</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>\r\n                            <h4>Product Highlights</h4>\r\n                            <ul>\r\n                                <li>Nullam dictum augue nec iaculis rhoncus. Aenean lobortis fringilla orci, vitae varius purus eleifend vitae.</li>\r\n                                <li>Nunc ornare, dolor a ultrices ultricies, magna dolor convallis enim, sed volutpat quam sem sed tellus.</li>\r\n                                <li>Aliquam malesuada cursus urna a rutrum. Ut ultricies facilisis suscipit.</li>\r\n                                <li>Duis a magna iaculis, aliquam metus in, luctus eros.</li>\r\n                                <li>Aenean nisi nibh, imperdiet sit amet eleifend et, gravida vitae sem.</li>\r\n                                <li>Donec quis nisi congue, ultricies massa ut, bibendum velit.</li>\r\n                            </ul>\r\n                            <h4>Usage Information</h4>\r\n                            <p>\r\n                                Donec hendrerit massa metus, a ultrices elit iaculis eu. Pellentesque ullamcorper augue lacus. Phasellus et est quis diam iaculis fringilla id nec sapien. Sed tempor ornare felis, non vulputate dolor. Etiam ornare diam vitae ligula malesuada tempor. Vestibulum nec odio vel libero ullamcorper euismod et in sapien. Suspendisse potenti.\r\n                            </p>', 1, 5000000, 50, 0, 500, 'ดาวน์โหลด (Custom).jpg', 1, '2015-04-01 00:00:00', NULL),
(20, 'booooooat', 'testtest', 34, 1224, 50, 0, 12, '', NULL, '2015-04-18 13:31:18', NULL),
(21, 'booooooat', 'testtest', 34, 1224, 50, 0, 12, '', NULL, '2015-04-18 13:31:22', NULL),
(22, 'test', '<h1><span style="font-size:36px"><span style="font-family:comic sans ms,cursive"><span style="background-color:rgb(255, 255, 0)"><img alt="wink" src="http://tomcat.it.kmitl.ac.th:8055/fine/ckeditor/plugins/smiley/images/wink_smile.png" style="height:23px; width:23px" title="wink" />THIS IS SEA !!<img alt="wink" src="http://tomcat.it.kmitl.ac.th:8055/fine/ckeditor/plugins/smiley/images/wink_smile.png" style="height:23px; width:23px" title="wink" /></span></span></span></h1>\n', 46, 0, 50, 0, 10, '2015-04-18_13-29-04_10877743_835315493194561_1831243224_n.jpg', NULL, '2015-04-18 13:34:16', NULL),
(23, 'test', 'testttstsggjkhkl;;', 47, 12345, 50, 0, 1, '2015-04-18_13-35-16_3_1.png', NULL, '2015-04-18 13:34:54', NULL),
(24, 'ตัวอย่าง', 'ตัวอย่าง', 49, 100, 50, 0, 20, '', NULL, '2015-04-20 10:13:04', NULL),
(38, 'ลุ้นรักตามสายลม', 'เรื่องราวความรักใสๆ ในวัยเรียน', 28, 199, 50, 1, 13, 'bg-ex3 (Custom).jpg', 19, '2015-04-22 12:40:08', '2015-04-28 15:50:31');

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE IF NOT EXISTS `purchase` (
  `id` int(11) unsigned NOT NULL COMMENT 'รหัสคำสั่งซื้อ',
  `user_id` int(11) unsigned NOT NULL COMMENT 'รหัสผู้ใช้งาน',
  `project_id` int(11) unsigned NOT NULL COMMENT 'รหัสโปรเจค',
  `price` double NOT NULL COMMENT 'ราคา',
  `dividend` double NOT NULL DEFAULT '0' COMMENT 'อัตราส่วนแบ่งที่ต้องแบ่งให้ผู้แต่ง',
  `shared` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'สถานะการจ่ายส่วนแบ่ง',
  `created_at` datetime NOT NULL COMMENT 'เวลาที่ถูกสร้างขึ้น'
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`id`, `user_id`, `project_id`, `price`, `dividend`, `shared`, `created_at`) VALUES
(3, 28, 1, 100, 50, 1, '2015-04-05 02:31:32'),
(24, 28, 5, 729, 25, 1, '2015-04-21 14:09:07'),
(25, 28, 8, 100, 30, 1, '2015-04-21 14:09:07'),
(26, 28, 9, 100, 75, 1, '2015-04-21 14:09:07'),
(27, 28, 2, 200, 25, 1, '2015-04-21 14:09:44'),
(28, 28, 3, 500, 50, 1, '2015-04-21 14:53:55'),
(29, 28, 38, 199, 50, 0, '2015-04-28 15:50:46'),
(30, 3, 7, 100, 50, 1, '2015-04-30 12:47:03'),
(31, 3, 10, 100, 50, 1, '2015-04-30 12:51:38');

-- --------------------------------------------------------

--
-- Table structure for table `save`
--

CREATE TABLE IF NOT EXISTS `save` (
  `id` int(11) unsigned NOT NULL COMMENT 'รหัสของการบันทึก',
  `user_id` int(11) unsigned NOT NULL COMMENT 'รหัสผู้ใช้งาน',
  `name` text COLLATE utf8_bin NOT NULL COMMENT 'ชื่อตัวละครของผู้เล่น',
  `memo` text COLLATE utf8_bin COMMENT 'บันทึกเตือนความจำ',
  `last_activity_id` int(11) unsigned NOT NULL COMMENT 'รหัสกิจกรรมที่บันทึก',
  `bg` text COLLATE utf8_bin NOT NULL COMMENT 'รูปภาพที่บันทึก',
  `music` text COLLATE utf8_bin NOT NULL COMMENT 'เสียงที่บันทึก',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'เวลาที่ถูกสร้างขึ้น'
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `save`
--

INSERT INTO `save` (`id`, `user_id`, `name`, `memo`, `last_activity_id`, `bg`, `music`, `created_at`) VALUES
(13, 4, 'ใหญ่', '', 6, 'http://localhost:8084/fine/img/bg/tumblr_static_bg.jpg', '', '2015-04-02 08:39:18'),
(17, 28, 'ทดสอบ', 'โอ้ยยยยย!!', 4, 'http://tomcat.it.kmitl.ac.th:8055/fine/img/bg/bump1.jpg', '', '2015-04-18 10:04:50'),
(18, 28, 'เก่ง', 'สวัสดีค่ะ ชื่อ อาซามิ เป็นเด็กนักเรียนใหม่ที่นี่ค่ะ', 69, 'http://tomcat.it.kmitl.ac.th:8055/fine/img/bg/2015-04-28_13-32-00_bg6.jpg', '/fine/sound/bgm/2015-04-28_13-49-36_bg หน้า รร..mp3', '2015-05-01 11:36:24'),
(19, 28, 'เก่ง', '', 85, 'http://tomcat.it.kmitl.ac.th:8055/fine/img/bg/2015-04-28_13-55-57_bg12.jpg', '/fine/sound/bgm/2015-04-28_15-45-08_bg ร้านข้าว.mp3', '2015-05-01 11:37:42'),
(20, 28, 'เก่ง', '', 92, 'http://tomcat.it.kmitl.ac.th:8055/fine/img/bg/2015-04-28_13-56-25_bg13.jpg', '/fine/sound/bgm/2015-04-28_15-45-08_bg ร้านข้าว.mp3', '2015-05-01 11:40:30');

-- --------------------------------------------------------

--
-- Table structure for table `scenario`
--

CREATE TABLE IF NOT EXISTS `scenario` (
  `id` int(11) unsigned NOT NULL COMMENT 'รหัสฉาก',
  `project_id` int(11) unsigned NOT NULL COMMENT 'รหัสโปรเจค',
  `title` text COLLATE utf8_bin COMMENT 'หัวเรื่องฉาก',
  `description` text COLLATE utf8_bin COMMENT 'คำอธิบายฉาก',
  `created_at` datetime NOT NULL COMMENT 'เวลาที่ถูกสร้างขึ้น',
  `updated_at` datetime DEFAULT NULL COMMENT 'เวลาที่แก้ไขครั้งล่าสุด'
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `scenario`
--

INSERT INTO `scenario` (`id`, `project_id`, `title`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 'Intro1', 'Introduction', '0000-00-00 00:00:00', '2015-04-18 16:54:27'),
(2, 1, 'First Morning', 'วันแรกที่เริ่มเปิดเทอม', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 17, 'test', 'test1', '2015-04-13 15:08:06', '2015-04-13 15:08:06'),
(11, 1, 'Scene Title', 'body body body', '2015-04-14 22:49:52', NULL),
(12, 23, '01', 'qwertt', '2015-04-18 13:35:13', '2015-04-18 13:43:36'),
(13, 22, 'first', 'ฉากแรก', '2015-04-18 13:37:07', '2015-04-18 13:37:50'),
(14, 23, '2', 'qwewqeqrqwrwrqw', '2015-04-18 13:40:39', NULL),
(15, 22, 'second', 'ฉาก2', '2015-04-18 13:40:53', NULL),
(16, 24, 'ฉากแรก', 'ฉากแรก', '2015-04-20 10:14:51', NULL),
(17, 24, 'ฉากสอง', '', '2015-04-20 10:15:08', NULL),
(18, 24, 'ฉากสาม', '', '2015-04-20 10:15:19', NULL),
(19, 38, 'scene1', '', '2015-04-22 12:41:09', '2015-04-22 13:11:44'),
(20, 38, 'scene2', '', '2015-04-22 12:49:14', NULL),
(21, 38, 'scene3', '', '2015-04-22 14:26:22', NULL),
(22, 38, 'scene4', '', '2015-04-22 14:44:40', NULL),
(23, 38, 'scene5', '', '2015-04-22 16:08:56', NULL),
(24, 38, 'จบแล้วจ้าา', '', '2015-04-23 12:07:26', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) unsigned NOT NULL COMMENT 'รหัสผู้ใช้',
  `prefix` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT 'คำนำหน้าชื่อ',
  `firstname` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'ชื่อต้น',
  `lastname` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'นามสกุล',
  `email` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'อีเมล',
  `password` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'รหัสผ่าน',
  `birthday` datetime NOT NULL COMMENT 'วันเกิด',
  `credit` double NOT NULL DEFAULT '0' COMMENT 'เครดิตที่ผู้ใช้มี',
  `role` int(11) NOT NULL DEFAULT '0' COMMENT 'สิทธ์การใช้งาน',
  `image` text COLLATE utf8_bin COMMENT 'รูปภาพประจำตัว',
  `created_at` datetime NOT NULL COMMENT 'เวลาที่ถูกสร้างขึ้น',
  `updated_at` timestamp NULL DEFAULT NULL COMMENT 'เวลาที่แก้ไขครั้งล่าสุด'
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `prefix`, `firstname`, `lastname`, `email`, `password`, `birthday`, `credit`, `role`, `image`, `created_at`, `updated_at`) VALUES
(1, '1', '2', '3', '4', 'SJzV28cIx+VB3k182Rzm0PFhNXO3/FtA05Qsy5VVzzU=', '2015-03-26 00:31:37', 2574.5, 5, NULL, '2015-03-26 00:31:39', '2015-04-15 09:38:52'),
(3, '77', '77', '77', '77', 'SJzV28cIx+VB3k182Rzm0PFhNXO3/FtA05Qsy5VVzzU=', '2015-03-26 00:32:26', 123, 77, NULL, '2015-03-26 00:32:30', '2015-04-30 05:49:55'),
(4, 'qwe', 'asd', 'zxc', 'asd@qwerty.com', 'ZehL4zUy+3hMSBKWdfnv86aCsnFowOp0Syz1juAjN8U=', '2015-03-26 00:32:26', 500, 1, NULL, '2015-03-26 03:41:44', NULL),
(28, 'นาย', 'ทดสอบ', 'เป็นคนสอง', 'second@name.com', 'FjZ6rLZ6SgF8jairlWgsyzkIY3gPcRTdoKDgxVZEx8Q=', '1995-01-01 00:00:00', 500199, 75, NULL, '2015-04-01 04:01:01', '2015-05-01 11:46:58'),
(30, 'นาย', 'ใหญ่', 'ไม่ธรรมดา', 'big@amazing.com', 'KiH+bVkqGbfeiYtQ61PEKWCN4aZvPp9i2hlxSncFU9E=', '2015-04-08 00:00:00', 0, 0, NULL, '2015-04-07 16:23:11', NULL),
(31, 'นาย', 'qwe', 'qwe', 'qwe@qwe.qwe', 'SJzV28cIx+VB3k182Rzm0PFhNXO3/FtA05Qsy5VVzzU=', '2015-04-02 00:00:00', 0, 0, NULL, '2015-04-11 09:47:23', NULL),
(32, 'นาย', 'asd', 'asd', 'asd@asd.asd', 'aIeH2P8UTFAsf1z/qv4sxYjYYHn53ogwTCawy5nOkcY=', '2015-04-01 00:00:00', 0, 0, NULL, '2015-04-11 09:49:29', NULL),
(33, 'นาย', 'zxc', 'zxc', 'zxc@zxc.zxc', 'ZX8YUY6qL0EweJXhjDug0S2XuKI8beOWb1LGujmgfuQ=', '2015-04-06 00:00:00', 0, 0, NULL, '2015-04-11 09:53:27', NULL),
(34, 'นาย', 'test', 'test', 'test@hotmail.com', 'n4bQgYhMfWWaL+qgxVrQFaO/TxsrC4Is0V1sFbDwCgg=', '2015-04-02 00:00:00', 0, 0, NULL, '2015-04-18 11:03:56', NULL),
(45, 'นาย', 'asd', 'asd', 'asd@asd', 'aIeH2P8UTFAsf1z/qv4sxYjYYHn53ogwTCawy5nOkcY=', '2015-04-18 00:00:00', 0, 0, NULL, '2015-04-18 11:22:09', NULL),
(46, 'นาย', 'test01', 'test01', 'test01@hotmail.com', 'Z46C2QfT5ucfgdXPPdrMNnHcYYw4obep+Tk6g9AlspY=', '1990-06-07 00:00:00', 0, 0, NULL, '2015-04-18 11:41:42', NULL),
(47, 'นาย', 'sads', 'qweqwq', 'testestest@hotmail.com', 'n4bQgYhMfWWaL+qgxVrQFaO/TxsrC4Is0V1sFbDwCgg=', '1980-04-18 00:00:00', 0, 0, NULL, '2015-04-18 13:33:16', NULL),
(48, 'นาย', '...', '...', 'testtest@gmail.com', 'Eu9N7XpGSO2ujqTCad1XT9U4qGhfDFNvLz9+53qpSaM=', '1955-01-31 00:00:00', 2.09, 0, NULL, '2015-04-18 13:33:39', '2015-04-21 07:25:44'),
(49, 'นาย', 'xxxxx', 'xxxxx', 'xxxxx@hotmail.com', '6vFrwHlo4BPz+UqxNCRyQ0o5/DR18RzzQabDlll0+Ok=', '2015-08-08 00:00:00', 5355, 0, NULL, '2015-04-20 00:55:02', '2015-04-20 03:44:17'),
(50, 'นาย', 'Tester', 'KMITL', 'test@it.kmitl.ac.th', 'FxjCSxCuuAmeP8RJYKtpSat2omc1JFnyA+oQNr7DgsI=', '2015-04-01 00:00:00', 0, 0, NULL, '2015-04-20 12:16:39', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity`
--
ALTER TABLE `activity`
  ADD PRIMARY KEY (`id`), ADD KEY `scenario_id_idx` (`scenario_id`);

--
-- Indexes for table `activity_choice`
--
ALTER TABLE `activity_choice`
  ADD PRIMARY KEY (`activity_id`,`order`);

--
-- Indexes for table `activity_dialog`
--
ALTER TABLE `activity_dialog`
  ADD PRIMARY KEY (`activity_id`);

--
-- Indexes for table `activity_goto`
--
ALTER TABLE `activity_goto`
  ADD PRIMARY KEY (`activity_id`);

--
-- Indexes for table `activity_media`
--
ALTER TABLE `activity_media`
  ADD PRIMARY KEY (`activity_id`);

--
-- Indexes for table `credit_log`
--
ALTER TABLE `credit_log`
  ADD PRIMARY KEY (`id`), ADD KEY `owner_id_idx` (`owner_id`), ADD KEY `changer_id_idx` (`change_by`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`id`), ADD KEY `user_id_idx` (`user_id`), ADD KEY `first_scene_idx` (`first_scene_id`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`id`), ADD KEY `user_purchase_idx` (`user_id`), ADD KEY `project_purchase_idx` (`project_id`);

--
-- Indexes for table `save`
--
ALTER TABLE `save`
  ADD PRIMARY KEY (`id`), ADD KEY `save_activity_idx` (`last_activity_id`), ADD KEY `user_save_idx` (`user_id`);

--
-- Indexes for table `scenario`
--
ALTER TABLE `scenario`
  ADD PRIMARY KEY (`id`), ADD KEY `project_id_idx` (`project_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity`
--
ALTER TABLE `activity`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'รหัสของกิจกรรม',AUTO_INCREMENT=126;
--
-- AUTO_INCREMENT for table `credit_log`
--
ALTER TABLE `credit_log`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'รหัสของประวัติเครดิต',AUTO_INCREMENT=43;
--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'รหัสของโปรเจค',AUTO_INCREMENT=39;
--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'รหัสคำสั่งซื้อ',AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT for table `save`
--
ALTER TABLE `save`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'รหัสของการบันทึก',AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `scenario`
--
ALTER TABLE `scenario`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'รหัสฉาก',AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'รหัสผู้ใช้',AUTO_INCREMENT=51;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity`
--
ALTER TABLE `activity`
ADD CONSTRAINT `scenario_id` FOREIGN KEY (`scenario_id`) REFERENCES `scenario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `activity_choice`
--
ALTER TABLE `activity_choice`
ADD CONSTRAINT `activity_choice_id` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `activity_dialog`
--
ALTER TABLE `activity_dialog`
ADD CONSTRAINT `activity_dialog_id` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `activity_goto`
--
ALTER TABLE `activity_goto`
ADD CONSTRAINT `activity_goto_id` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `activity_media`
--
ALTER TABLE `activity_media`
ADD CONSTRAINT `activity_media_id` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `credit_log`
--
ALTER TABLE `credit_log`
ADD CONSTRAINT `changer_id` FOREIGN KEY (`change_by`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `owner_id` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `project`
--
ALTER TABLE `project`
ADD CONSTRAINT `first_scene` FOREIGN KEY (`first_scene_id`) REFERENCES `scenario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `user_project` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `purchase`
--
ALTER TABLE `purchase`
ADD CONSTRAINT `project_purchase` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `user_purchase` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `save`
--
ALTER TABLE `save`
ADD CONSTRAINT `save_activity` FOREIGN KEY (`last_activity_id`) REFERENCES `activity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `user_save` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `scenario`
--
ALTER TABLE `scenario`
ADD CONSTRAINT `project_scene` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
