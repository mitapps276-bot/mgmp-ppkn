-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: mgmp_bali_db
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activity_logs`
--

DROP TABLE IF EXISTS `activity_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `activity_type` enum('login','upload_material','download_material','create_discussion','comment_discussion') NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_logs`
--

LOCK TABLES `activity_logs` WRITE;
/*!40000 ALTER TABLE `activity_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pesan` text NOT NULL,
  `target_audience` varchar(20) NOT NULL DEFAULT 'all',
  `tanggal` datetime DEFAULT current_timestamp(),
  `file_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badges`
--

DROP TABLE IF EXISTS `badges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `badge_name` varchar(100) NOT NULL,
  `point_required` int(11) DEFAULT 0,
  `badge_icon` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badges`
--

LOCK TABLES `badges` WRITE;
/*!40000 ALTER TABLE `badges` DISABLE KEYS */;
INSERT INTO `badges` VALUES (1,'Guru Aktif',100,NULL),(2,'Kontributor Materi',250,NULL),(3,'Kolaborator Terbaik',500,NULL);
/*!40000 ALTER TABLE `badges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discussion_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `discussion_id` (`discussion_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`discussion_id`) REFERENCES `discussions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discussions`
--

DROP TABLE IF EXISTS `discussions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discussions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `discussions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discussions`
--

LOCK TABLES `discussions` WRITE;
/*!40000 ALTER TABLE `discussions` DISABLE KEYS */;
/*!40000 ALTER TABLE `discussions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `downloads`
--

DROP TABLE IF EXISTS `downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `downloads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `material_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `downloaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `material_id` (`material_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `downloads_ibfk_1` FOREIGN KEY (`material_id`) REFERENCES `materials` (`id`) ON DELETE CASCADE,
  CONSTRAINT `downloads_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `downloads`
--

LOCK TABLES `downloads` WRITE;
/*!40000 ALTER TABLE `downloads` DISABLE KEYS */;
/*!40000 ALTER TABLE `downloads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folders`
--

DROP TABLE IF EXISTS `folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `folders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `folder_name` varchar(255) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folders`
--

LOCK TABLES `folders` WRITE;
/*!40000 ALTER TABLE `folders` DISABLE KEYS */;
INSERT INTO `folders` VALUES (4,'Materi Pembelajaran',0,'2026-05-25 17:30:16'),(5,'Soal Latihan',0,'2026-05-25 17:30:16'),(6,'Perangkat Pembelajaran',0,'2026-05-25 17:30:16');
/*!40000 ALTER TABLE `folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gallery`
--

DROP TABLE IF EXISTS `gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallery`
--

LOCK TABLES `gallery` WRITE;
/*!40000 ALTER TABLE `gallery` DISABLE KEYS */;
INSERT INTO `gallery` VALUES (1,'Pelatihan Kurikulum Mendalam','Kegiatan Pelatihan Kurikulum Mendalam','assets/uploads/gallery/1781584756_edit_WhatsApp_Image_2026-06-16_at_11.58.29.jpeg','2026-06-16 12:21:25'),(2,'Pelatihan Kurikulum Mendalam','Kegiatan Pelatihan Kurikulum Mendalam','assets/uploads/gallery/1781584591_WhatsApp_Image_2026-06-16_at_11.21.01.jpeg','2026-06-16 12:36:31'),(3,'Pelatihan Kurikulum Mendalam','Kegiatan Pelatihan Kurikulum Mendalam','assets/uploads/gallery/1781584746_WhatsApp_Image_2026-06-16_at_12.02.41.jpeg','2026-06-16 12:39:06'),(4,'Pelatihan Kurikulum Mendalam','Kegiatan Pelatihan Kurikulum Mendalam','assets/uploads/gallery/1781584862_edit_WhatsApp_Image_2026-06-16_at_11.55.35.jpeg','2026-06-16 12:40:18'),(5,'Pelatihan Kurikulum Mendalam','Kegiatan Pelatihan Kurikulum Mendalam','assets/uploads/gallery/1781585021_WhatsApp_Image_2026-06-16_at_11.22.22__1_.jpeg','2026-06-16 12:43:41'),(6,'Pelatihan Kurikulum Mendalam','Kegiatan Pelatihan Kurikulum Mendalam','assets/uploads/gallery/1781585083_WhatsApp_Image_2026-06-16_at_11.23.21.jpeg','2026-06-16 12:44:43');
/*!40000 ALTER TABLE `gallery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `guru_aktif`
--

DROP TABLE IF EXISTS `guru_aktif`;
/*!50001 DROP VIEW IF EXISTS `guru_aktif`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `guru_aktif` AS SELECT
 1 AS `full_name`,
  1 AS `school_name`,
  1 AS `total_upload`,
  1 AS `total_download`,
  1 AS `total_discussion`,
  1 AS `total_comment`,
  1 AS `engagement_score` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `landing_settings`
--

DROP TABLE IF EXISTS `landing_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `landing_settings` (
  `id` int(11) NOT NULL,
  `hero_title` text DEFAULT NULL,
  `hero_subtitle` text DEFAULT NULL,
  `hero_image` varchar(255) DEFAULT NULL,
  `about_title` text DEFAULT NULL,
  `about_desc1` text DEFAULT NULL,
  `about_desc2` text DEFAULT NULL,
  `about_image` varchar(255) DEFAULT NULL,
  `analytic_title` text DEFAULT NULL,
  `analytic_subtitle` text DEFAULT NULL,
  `login_title` text DEFAULT NULL,
  `login_desc` text DEFAULT NULL,
  `hero_image_x` varchar(10) DEFAULT '50',
  `hero_image_y` varchar(10) DEFAULT '50',
  `topbar_text` text DEFAULT NULL,
  `navbar_logo_text` text DEFAULT NULL,
  `stat1_number` varchar(50) DEFAULT NULL,
  `stat1_text` varchar(100) DEFAULT NULL,
  `stat2_number` varchar(50) DEFAULT NULL,
  `stat2_text` varchar(100) DEFAULT NULL,
  `stat3_number` varchar(50) DEFAULT NULL,
  `stat3_text` varchar(100) DEFAULT NULL,
  `about_list1` text DEFAULT NULL,
  `about_list2` text DEFAULT NULL,
  `about_list3` text DEFAULT NULL,
  `gallery_title` varchar(255) DEFAULT NULL,
  `gallery_desc` text DEFAULT NULL,
  `feature1_icon` varchar(50) DEFAULT NULL,
  `feature1_title` varchar(255) DEFAULT NULL,
  `feature1_desc` text DEFAULT NULL,
  `feature2_icon` varchar(50) DEFAULT NULL,
  `feature2_title` varchar(255) DEFAULT NULL,
  `feature2_desc` text DEFAULT NULL,
  `feature3_icon` varchar(50) DEFAULT NULL,
  `feature3_title` varchar(255) DEFAULT NULL,
  `feature3_desc` text DEFAULT NULL,
  `footer_title` varchar(255) DEFAULT NULL,
  `footer_desc` text DEFAULT NULL,
  `feature4_icon` varchar(50) DEFAULT NULL,
  `feature4_title` varchar(255) DEFAULT NULL,
  `feature4_desc` text DEFAULT NULL,
  `feature5_icon` varchar(50) DEFAULT NULL,
  `feature5_title` varchar(255) DEFAULT NULL,
  `feature5_desc` text DEFAULT NULL,
  `feature6_icon` varchar(50) DEFAULT NULL,
  `feature6_title` varchar(255) DEFAULT NULL,
  `feature6_desc` text DEFAULT NULL,
  `about_list4` text DEFAULT NULL,
  `about_list5` text DEFAULT NULL,
  `about_list6` text DEFAULT NULL,
  `feature7_icon` varchar(50) DEFAULT NULL,
  `feature7_title` varchar(255) DEFAULT NULL,
  `feature7_desc` text DEFAULT NULL,
  `feature8_icon` varchar(50) DEFAULT NULL,
  `feature8_title` varchar(255) DEFAULT NULL,
  `feature8_desc` text DEFAULT NULL,
  `feature9_icon` varchar(50) DEFAULT NULL,
  `feature9_title` varchar(255) DEFAULT NULL,
  `feature9_desc` text DEFAULT NULL,
  `footer_copyright` varchar(255) DEFAULT NULL,
  `footer_contact_title` varchar(255) DEFAULT NULL,
  `footer_contact_1_text` varchar(255) DEFAULT NULL,
  `footer_contact_1_url` varchar(255) DEFAULT NULL,
  `footer_contact_2_text` varchar(255) DEFAULT NULL,
  `footer_contact_2_url` varchar(255) DEFAULT NULL,
  `footer_contact_3_text` varchar(255) DEFAULT NULL,
  `footer_contact_3_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `landing_settings`
--

LOCK TABLES `landing_settings` WRITE;
/*!40000 ALTER TABLE `landing_settings` DISABLE KEYS */;
INSERT INTO `landing_settings` VALUES (1,'Membangun Sinergi<br><span>Pendidikan Berkualitas</span>','Wadah Kolaborasi Untuk Menciptakan Ekosistem Pembelajaran yang Inovatif, Terstruktur, dan Berbasis Data Learning Analytics Cerdas.','assets/uploads/landing/1782051293_LIAK.jpg','Ekosistem Terpadu Berbasis Kecerdasan Algoritmik','Sistem Informasi Musyawarah Guru Mata Pelajaran (MGMP) hadir sebagai inovasi akademik modern yang memadukan repositori perangkat ajar dengan komputasi cerdas. Platform ini dirancang untuk mendistribusikan materi pembelajaran secara merata, terstruktur, dan terbebas dari duplikasi data berkat fitur pemindaian sidik jari file (Hashing).','Lebih dari sekadar ruang penyimpanan <i>cloud</i>, platform ini dibekali fitur <strong>Smart Matching</strong> yang mampu mendeteksi ketersediaan request materi secara otomatis. Didukung oleh teknologi <strong>Learning Analytics</strong>, platform ini secara <i>real-time</i> menghasilkan evaluasi performa kolektif sekolah (SPI) dan sistem rekomendasi kolaborasi (KSI) guna mendorong interaksi aktif setiap tenaga pendidik.','assets/uploads/landing/1781587412_WhatsApp_Image_2026-06-16_at_11.58.29.jpeg','Infrastruktur Kolaborasi Akademik Digital','Platform Terintegrasi yang Dirancang Secara Spesifik Untuk Mengoptimalkan Produktivitas Pedagogis dan Memfasilitasi Sinergi Strategis Antar Tenaga Pendidik.','','','100','100','Sistem Informasi Learning Integration & Analitik Kinerja (SI-LIAK)','MGMP MUATAN LOKAL KOTA DENPASAR',NULL,NULL,NULL,NULL,NULL,NULL,'Sistem pemenuhan permintaan materi otomatis (Smart Matching) dan anti-duplikasi file','Pengukuran Learning Analytics (SPI & KSI) beserta sistem rekomendasi cerdas','Jalur kontribusi khusus bagi praktisi pendidikan eksternal untuk berkolaborasi','KEGIATAN MGMP MUATAN LOKAL KOTA DENPASAR','','≡ƒôÜ','Repositori Digital Terintegrasi','Fasilitas penyimpanan komprehensif yang dirancang khusus untuk mengarsipkan dan mendistribusikan dokumen pedagogis, modul ajar, serta instrumen evaluasi secara tersentralisasi guna menjamin aksesibilitas dan keamanan data berkelanjutan.','≡ƒôè','Sistem Meritokrasi Digital','Mekanisme terotomatisasi yang mengukur dan memberikan atribusi poin prestasi secara kuantitatif berdasarkan tingkat partisipasi aktif tenaga pendidik dalam berbagi (upload) dan memanfaatkan (download) sumber daya pembelajaran.','≡ƒñ¥','Jalur Kontribusi Akademisi Eksternal','Menyediakan kanal khusus bagi para akademisi, dosen, dan praktisi pendidikan untuk menyumbangkan materi ajar terkurasi guna memperkaya dan meningkatkan mutu referensi pedagogis dalam ekosistem.','Berbasis Data Learning Analytics Cerdas','Sistem Informasi Learning Integration & Analitik Kinerja (SI-LIAK) Musyawarah Guru Mata Pelajaran Muatan Lokal Kota Denpasar. Dedikasi terhadap peningkatan mutu pendidikan melalui digitalisasi pendistribusian materi dan analisis data kinerja yang presisi.','≡ƒæÑ','Jejaring Kolaborasi Referensi','Infrastruktur interaktif yang memungkinkan tenaga pendidik untuk mengajukan permohonan spesifik terkait bahan ajar, memfasilitasi pertukaran materi secara responsif antar institusi.','≡ƒôê','Inovasi & Adaptasi Pedagogis','Mendorong pengembangan kompetensi instruksional melalui metode observasi, adopsi, dan modifikasi terhadap instrumen pembelajaran unggulan lintas institusi guna memperkaya variasi pendekatan edukatif.','≡ƒöÆ','Sistem Proteksi Integritas Data','Infrastruktur penyimpanan berbasis komputasi cerdas (Hashing) yang secara otomatis memindai dan memfilter redundansi file, memastikan efisiensi kapasitas serta validitas repositori.','Akses instan ke koleksi perangkat pembelajaran dan soal latihan yang telah terverifikasi','Fasilitas permintaan materi spesifik untuk saling membantu antar rekan pendidik','Mendapatkan apresiasi dan rekam jejak atas setiap materi bermanfaat yang dibagikan','≡ƒÅå','Leaderboard Kinerja Akademik','Sistem pemeringkatan transparan berbasis data analitik yang dirancang untuk menstimulasi motivasi intrinsik tenaga pendidik dalam mengoptimalkan kontribusi pedagogis di tingkat ekosistem kota.','≡ƒôó','Kanal Diseminasi Informasi','Infrastruktur komunikasi satu arah yang menjamin penyampaian informasi, jadwal, dan edaran resmi dari administrator MGMP secara terstruktur dan terdokumentasi langsung ke dasbor pengguna.','≡ƒÅ½','Indeks Kinerja Institusional','Sistem analitik yang mengagregasi skor partisipasi individual dari setiap tenaga pendidik menjadi sebuah Indeks Kinerja Institusional (SPI) terukur, merepresentasikan kontribusi kolektif dan reputasi akademik sekolah dalam ekosistem.','Sistem Informasi Learning Integration & Analitik Kinerja (SI-LIAK). Hak Cipta Dilindungi Undang-Undang.','Kontak','I Gusti Ayu Ngurah Artini, S.Pd.','mailto:iartini12@guru.smk.belajar.id','Luh Fibriyanthini, S.Pd.','mailto:luhfibriyanthini82@guru.smk.belajar.id','','');
/*!40000 ALTER TABLE `landing_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_activity`
--

DROP TABLE IF EXISTS `login_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `login_date` date NOT NULL,
  `login_time` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_activity`
--

LOCK TABLES `login_activity` WRITE;
/*!40000 ALTER TABLE `login_activity` DISABLE KEYS */;
INSERT INTO `login_activity` VALUES (1,47,'2026-06-27','2026-06-27 07:05:23','2026-06-26 22:45:50'),(2,45,'2026-06-27','2026-06-27 08:14:58','2026-06-26 22:50:59'),(3,46,'2026-06-27','2026-06-27 07:32:50','2026-06-26 23:32:50'),(4,50,'2026-06-27','2026-06-27 08:16:15','2026-06-26 23:34:14'),(5,71,'2026-06-27','2026-06-27 07:53:21','2026-06-26 23:53:21');
/*!40000 ALTER TABLE `login_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_attempts`
--

DROP TABLE IF EXISTS `login_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_attempts` (
  `ip_address` varchar(45) NOT NULL,
  `attempts` int(11) DEFAULT 1,
  `last_attempt` datetime DEFAULT NULL,
  PRIMARY KEY (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_attempts`
--

LOCK TABLES `login_attempts` WRITE;
/*!40000 ALTER TABLE `login_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_attempts_user`
--

DROP TABLE IF EXISTS `login_attempts_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_attempts_user` (
  `username` varchar(100) NOT NULL,
  `attempts` int(11) DEFAULT 1,
  `last_attempt` datetime DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_attempts_user`
--

LOCK TABLES `login_attempts_user` WRITE;
/*!40000 ALTER TABLE `login_attempts_user` DISABLE KEYS */;
INSERT INTO `login_attempts_user` VALUES ('\' OR \'1\'=\'1',1,'2026-06-26 23:31:11'),('efqgqg',1,'2026-06-26 23:18:20'),('wefqwegqgq',1,'2026-06-26 23:18:14'),('wegewgewq',1,'2026-06-26 23:18:10'),('`\' OR \'1\'=\'1`',1,'2026-06-26 23:30:43');
/*!40000 ALTER TABLE `login_attempts_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_logs`
--

DROP TABLE IF EXISTS `login_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `login_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_login` (`user_id`,`login_date`),
  CONSTRAINT `login_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_logs`
--

LOCK TABLES `login_logs` WRITE;
/*!40000 ALTER TABLE `login_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_requests`
--

DROP TABLE IF EXISTS `material_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `material_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `jenis_request` varchar(50) NOT NULL,
  `deskripsi` text NOT NULL,
  `status` enum('pending','diproses','selesai') DEFAULT 'pending',
  `created_at` datetime DEFAULT current_timestamp(),
  `admin_note` text DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `fk_material_requests_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_requests`
--

LOCK TABLES `material_requests` WRITE;
/*!40000 ALTER TABLE `material_requests` DISABLE KEYS */;
INSERT INTO `material_requests` VALUES (1,47,'Soal Latihan','Target Kelas: Kelas 11\nDetail Request: sambrama wacana','pending','2026-06-27 06:46:24',NULL,0),(2,47,'Perangkat Pembelajaran','Target Kelas: Kelas 12\nDetail Request: Aksara bali dalam berbagai media','pending','2026-06-27 07:05:51',NULL,0),(6,50,'Materi Pembelajaran','Target Kelas: Kelas 10\nDetail Request: bali puisi','selesai','2026-06-27 08:17:45','Pencarian Otomatis: Ditemukan materi yang relevan dengan request Anda yaitu \"puisi dalam bahasa bali\". Silakan cek di menu Data Materi, materi berada pada urutan No. 1 di dalam folder \"Materi Pembelajaran\".',0),(7,50,'Materi Pembelajaran','Target Kelas: Kelas 10\nDetail Request: puisi','selesai','2026-06-27 08:18:40','Pencarian Otomatis: Ditemukan materi yang relevan dengan request Anda yaitu \"puisi dalam bahasa bali\". Silakan cek di menu Data Materi, materi berada pada urutan No. 1 di dalam folder \"Materi Pembelajaran\".',0),(8,50,'Materi Pembelajaran','Target Kelas: Kelas 10\nDetail Request: saya request bali puisi','selesai','2026-06-27 08:19:28','Pencarian Otomatis: Ditemukan materi yang relevan dengan request Anda yaitu \"puisi dalam bahasa bali\". Silakan cek di menu Data Materi, materi berada pada urutan No. 1 di dalam folder \"Materi Pembelajaran\".',0);
/*!40000 ALTER TABLE `material_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materials`
--

DROP TABLE IF EXISTS `materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `materials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `category` enum('Materi Pembelajaran','Soal Latihan','Perangkat Pembelajaran') NOT NULL,
  `subcategory` varchar(255) DEFAULT NULL,
  `grade_level` enum('Kelas 7','Kelas 8','Kelas 9','Kelas 10','Kelas 11','Kelas 12') NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `download_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `file_hash` varchar(255) DEFAULT NULL,
  `contributor_name` varchar(100) DEFAULT NULL,
  `contributor_email` varchar(100) DEFAULT NULL,
  `contributor_institution` varchar(150) DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'approved',
  `folder_id` int(11) DEFAULT NULL,
  `reject_reason` text DEFAULT NULL,
  `fulfilled_request_ids` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `materials_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materials`
--

LOCK TABLES `materials` WRITE;
/*!40000 ALTER TABLE `materials` DISABLE KEYS */;
INSERT INTO `materials` VALUES (1,71,'puisi dalam bahasa bali','bahasa bali alus','Materi Pembelajaran',NULL,'Kelas 10','docs/1782518101_Doc1.docx','application/vnd.openxmlformats-officedocument.word',302786,0,'2026-06-26 23:55:01','b978efbf55610e5d20c4555d33ac4136',NULL,NULL,NULL,'approved',4,NULL,NULL,0);
/*!40000 ALTER TABLE `materials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participation_scores`
--

DROP TABLE IF EXISTS `participation_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participation_scores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `total_upload` int(11) DEFAULT 0,
  `total_download` int(11) DEFAULT 0,
  `total_discussion` int(11) DEFAULT 0,
  `total_comment` int(11) DEFAULT 0,
  `engagement_score` decimal(10,2) DEFAULT 0.00,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `participation_scores_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participation_scores`
--

LOCK TABLES `participation_scores` WRITE;
/*!40000 ALTER TABLE `participation_scores` DISABLE KEYS */;
/*!40000 ALTER TABLE `participation_scores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin'),(2,'Guru'),(4,'External Contributor');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_badges`
--

DROP TABLE IF EXISTS `user_badges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_badges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `badge_id` int(11) NOT NULL,
  `achieved_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `badge_id` (`badge_id`),
  CONSTRAINT `user_badges_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_badges_ibfk_2` FOREIGN KEY (`badge_id`) REFERENCES `badges` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_badges`
--

LOCK TABLES `user_badges` WRITE;
/*!40000 ALTER TABLE `user_badges` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_badges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `nip` varchar(30) DEFAULT NULL,
  `school_name` varchar(150) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (45,1,'ADMINISTRATOR','MGMPMulokAdmin',NULL,'SMK Negeri 1 Denpasar','admin@gmail.com','$2y$10$jpF6tFb9n/JTcP4eJI7EveWJop4dzkl.76n6BXokNXygrSw8iFw4.',NULL,'2026-06-07 07:10:22'),(46,2,'I Gusti Lanang Yudiana, S.Pd','lanangyudiana',NULL,'SMK Negeri 1 Denpasar','lanang@gmail.com','$2y$10$jpnoBi/eCm4X2AxNKmyCaOJW.oAa/l82z.JMEktHy7Kq9fdbJI9eC',NULL,'2026-06-07 11:35:42'),(47,2,'Luh Fibriyanthini, S.Pd','fibriyanthini',NULL,'SMK Negeri 1 Denpasar','fibriyanthini@gmail.com','$2y$10$DGxzWvIpFpErlKX4xjHTGelD4LKF15Ssk/13GQ/WT9h0sTgymAofe','uploads/profile_photos/user_47_1780836062.jpeg','2026-06-07 11:46:24'),(48,4,'Ni Komang Sridadi, S.Pd','sridadi',NULL,'SMA Negeri 1 Kintamani','sridadi@gmail.com','$2y$10$MOrgaN/YagysSGfBS0VkkOj4.ySAXBeqrR.WRb.1uLnIgV.UMQLjC','uploads/profile_photos/user_48_1780834671.jpeg','2026-06-07 11:54:18'),(49,2,'I Wayan Nuryana, S.Pd','nuryanawayan',NULL,'SMK Negeri 1 Denpasar','nuryana@gmail.com','$2y$10$yRE5/xHPDlzh4hIcaZyjWu2Rxz65WcCZ5QOZnHAFY4eH3mMXa..U6',NULL,'2026-06-07 15:11:52'),(50,2,'Ni Putu Dian Meidiawati, S.Pd','meidiawati',NULL,'SMK Negeri 2 Denpasar','meidiawati@gmail.com','$2y$10$TCnyoJrWyItics0xhX7lA.2BgsKqeIxoXjrJrFts.Ra/mmAd6rWvu',NULL,'2026-06-08 03:39:33'),(51,4,'I Made Juliadi Supadi, S. Pd','juliadi',NULL,'SMK Negeri 2 Denpasar','juliadi@gmail.com','$2y$10$6WLPn6ca4orUwPJeIwtC4OitOggCZI7uWKjDmvQX4NsoW4eUgm4WO',NULL,'2026-06-08 03:44:09'),(52,2,'Dra. Ni Made Merti, M.Si.','mademerti',NULL,'SMK Negeri 3 Denpasar','mademerti@gmail.com','$2y$10$vLBaVpRHdEB2si/EDV1QheJ.nreabv.z.OxeA7uW4MJ1e16RP1l1a',NULL,'2026-06-08 03:46:05'),(53,2,'Gede Agus Sudiatmika Wijaya, S.H., S.Pd., M.Pd.','sudiatmika',NULL,'SMK Negeri 3 Denpasar','sudiatmika@gmail.com','$2y$10$RSaC4uJGkWd.9uDj.gtfaOlLJnMzZ7kLojZS0ge./jPkISMz/GobS',NULL,'2026-06-08 03:49:27'),(54,2,'Anak Agung Krisnati Dewi, S.Pd.','krisnatidewi',NULL,'SMK Negeri 3 Denpasar','krisnati@gmail.com','$2y$10$ohp3g0ue6wj4xVHXRL66gukKI66BTmGun8.9g37/YcTVPgjZlHQGO',NULL,'2026-06-08 04:04:24'),(55,2,'Dra. Ni Nyoman Suti','nyomansuti',NULL,'SMK Negeri 4 Denpasar','nyomansuti@gmail.com','$2y$10$Ujv/XJ6HJWQCmLTqDu/22OwWmnhlQmxEN4p0Miorp8eT7JbJk6IGK',NULL,'2026-06-08 04:22:45'),(56,2,'Budi Oktafiadi, S.Pd','oktafiadi',NULL,'SMK Negeri 4 Denpasar','oktafiadi@gmail.com','$2y$10$BvEdmI82vAWr68SOjdHmPuESJSZ.sURZ4b02EairiEUKaXPjOd0ua',NULL,'2026-06-08 04:24:20'),(57,2,'Pande Putu Dedik Sukabawa,S. Pd.','sukabawa',NULL,'SMK Negeri 5 Denpasar','sukabawa@gmail.com','$2y$10$3koVGNUQH644o6YfwBji8OEtDO2tMs9zpYY7WjdGEMd153WT9MUgi',NULL,'2026-06-08 04:25:41'),(58,2,'Putu Reland Dafincy Tangkas','reland',NULL,'SMK Negeri 5 Denpasar','reland@gmail.com','$2y$10$IpfdSkhgzQ3Z78eDv4r7s.qe6i1ZpGgYrH3wRq3d0jq8nQswYRtDq',NULL,'2026-06-08 04:27:28'),(59,2,'Dra Ni Luh Aryati','luharyati',NULL,'SMK Kertha Wisata Denpasar','luharyati@gmail.com','$2y$10$4B7zLDiovG193qSmwzrKaubunPpTWT/WTEHo6yqI7pVB8SzAn/ig6',NULL,'2026-06-08 04:28:48'),(60,2,'Ni Ketut Irianti, S.Pd.H','irianti',NULL,'SMK Kertha Wisata Denpasar','irianti@gmail.com','$2y$10$qDa46k5L4Xlo4I34F/YpwOT/qznrHwGkaQ9tHXx2.UF2OvWkX9TuS',NULL,'2026-06-08 04:30:23'),(61,2,'Ni Made Tutik Ariati','tutikariati',NULL,'SMK Pariwisata Harapan','tutikariati@gmail.com','$2y$10$4XYas5jafvPXJ/SUXr/OJu1cbMeGbLysaKVO5TMGCp45/DorT8S1y',NULL,'2026-06-08 04:32:36'),(62,2,'Ni Luh Adi Setyawati,S.Pd.','luhsetyawati',NULL,'SMK Pariwisata Harapan','luhsetyawati@gmail.com','$2y$10$gbrSryJi/gGmgGXaQ2scWex0UkBLPnd6mtHAKGBMevnAWXjL8dsj.',NULL,'2026-06-08 04:33:58'),(63,2,'Kadek Kusumawati, S.Pd','kusumawati',NULL,'SMK PGRI 2 Denpasar','kusumawati@gmail.com','$2y$10$RG6iPNN6/tS392U1yWLpMuus67S.E4qwGmnjOvY07TBqR3p12hCU6',NULL,'2026-06-08 04:35:24'),(64,2,'Ni Putu Eka Yunita Sari,S.Pd.','yunitasari',NULL,'SMK PGRI 3 Denpasar','yunitasari@gmail.com','$2y$10$Bs4FGyegFBtEg6tZCb9hne5fC7Gw1iKIJjUUpnbqDVMjsx2yfguGu',NULL,'2026-06-08 04:39:45'),(65,2,'Ni Wayan Diah Juni Ashari,S.Pd.B','juniashari',NULL,'SMK PGRI 5 Denpasar','juniashari@gmail.com','$2y$10$PNEo/gVYGT80Ez5KSY79Ee8c/ZtGFn0U3ZrBY9PxSC8PF7U9.rEoe',NULL,'2026-06-08 04:41:21'),(66,2,'Aditya Jelantik, S.Pd., M.Pd.','jelantik',NULL,'SMK Rekayasa Denpasar','jelantik@gmail.com','$2y$10$Gqr6TKGHcljRdwENg47GeeMhTM3IIy8bf/vPDDr6gE.yGa3dEjY5q',NULL,'2026-06-08 04:42:31'),(67,2,'Ni Putu Ratnaningsih S.Ag','ratnaningsih',NULL,'SMK Rekayasa Denpasar','ratnaningsih@gmail.com','$2y$10$QaEEYBTZboE999kqfZuH4OVnbrx1qCl.Bi4bX3mcslDb7HjvpUn0y',NULL,'2026-06-08 04:43:43'),(68,2,'I Putu Suwitra,S.Pd.B','suwitra',NULL,'SMK Saraswati 1 Denpasar','suwitra@gmail.com','$2y$10$h7DEendcIpSIHHXf2I5yEepH7TcGBhMgSHSKQSuMrcqqjIOHOmmZ.',NULL,'2026-06-08 04:46:36'),(69,2,'I Made Sartawan, S.Pd','sartawan',NULL,'SMK Wira Bhakti Denpasar','sartawan@gmail.com','$2y$10$KTvPPAWsdmq4HaNiAjFJWujyjIZM4NHg/v07T62h4nspKiCt8WqEG',NULL,'2026-06-08 04:47:53'),(71,2,'I Gusti Ayu Ngurah Artini, S.Pd.','ngurahartini',NULL,'SMK Negeri 1 Denpasar','ngurahartini@gmail.com','$2y$10$NOnu/4ibbnbLIuEeivfNDu3vIQ4sYPImjumFhIaQ2ZPTIDca0NBaW','uploads/profile_photos/user_71_1781756609.jpeg','2026-06-08 15:36:15'),(73,2,'Ni Wayan Mariani','mariani',NULL,'SMK PGRI 1 Denpasar','mariani@gmail.com','$2y$10$bap4Har956gyRwlkiyTPeuP9Au46ECUdGftoKoq4t8CMhRiFc/akG',NULL,'2026-06-24 12:45:13');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `guru_aktif`
--

/*!50001 DROP VIEW IF EXISTS `guru_aktif`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `guru_aktif` AS select `users`.`full_name` AS `full_name`,`users`.`school_name` AS `school_name`,`participation_scores`.`total_upload` AS `total_upload`,`participation_scores`.`total_download` AS `total_download`,`participation_scores`.`total_discussion` AS `total_discussion`,`participation_scores`.`total_comment` AS `total_comment`,`participation_scores`.`engagement_score` AS `engagement_score` from (`participation_scores` join `users` on(`participation_scores`.`user_id` = `users`.`id`)) order by `participation_scores`.`engagement_score` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-27 10:19:32
