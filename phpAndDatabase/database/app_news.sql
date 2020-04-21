-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 21, 2020 at 08:14 PM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `app_news`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_news`
--

CREATE TABLE `tbl_news` (
  `id_news` int(11) NOT NULL,
  `image` text NOT NULL,
  `title` text DEFAULT NULL,
  `content` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `date_news` datetime DEFAULT NULL,
  `id_users` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_news`
--

INSERT INTO `tbl_news` (`id_news`, `image`, `title`, `content`, `description`, `date_news`, `id_users`) VALUES
(7, '28032020053105scaled_04c4e3df-614f-4a7f-ad4e-765c5f0e234a_169.jpg', 'Irlandia Terapkan Lockdown Hingga 12 April untuk Kendalikan Virus Corona', 'Dublin - Bertambah lagi negara yang menerapkan lockdown sebagai upaya mengendalikan penyebaran virus corona', 'Dublin - Bertambah lagi negara yang menerapkan lockdown sebagai upaya mengendalikan penyebaran virus corona.Perdana Menteri (PM) Irlandia Leo Varadkar mengumumkan bahwa langkah baru ini akan mulai diberlakukan pada Sabtu (28/3) tengah malam waktu setempat dan akan berlangsung hingga 12 April mendatang.\"Semua orang harus tinggal di rumah, dalam semua keadaan,\" katanya seperti dilansir kantor berita AFP, Sabtu (28/3/2020).', '2020-03-27 15:12:43', 1),
(9, '28032020055054scaled__111126354_antarafoto-pemeriksaan-suhu-tubuh-di-lrt-jakarta-03032020-gp-4.jpg', 'NYALANG: Menjemput Tenang di Tengah Gelombang', 'NYALANG: Menjemput Tenang di Tengah Gelombang', 'David Vazquez, seorang seniman jalanan di Mexico City, berpakaian seperti tokoh komik Joker. Ia menunggu orang-orang yang lalu-lalang mau berfoto dengannya untuk mendapatkan uang di tengah resesi ekonomi yang melanda dunia karena wabah corona.', '2020-03-27 17:19:57', 1),
(16, '28032020065624scaled__111126354_antarafoto-pemeriksaan-suhu-tubuh-di-lrt-jakarta-03032020-gp-4.jpg', 'Cara Unik Desa di Yogyakarta Usir Virus Corona', 'Jakarta, CNN Indonesia -- Wabah virus corona yang tengah merebak mengundang keresahan di masyarakat.', 'Jakarta, CNN Indonesia -- Wabah virus corona yang tengah merebak mengundang keresahan di masyarakat. Tak terkecuali bagi warga masyarakat di Dusun Genitem, Desa Sidoagung, Kecamatan Godean, Sleman, Daerah Istimewa Yogyakarta (DIY).\n\nNamun, mereka punya cara cukup unik untuk mengantisipasi penularan virus corona ini di wilayah tersebut.\n\nSelain pendataan terhadap warga pendatang yang akan masuk ke dusun tersebut, masyarakat juga melakukan upaya swadaya dengan membuat posko di pintu masuk dusun. Poska tersebut disediakan untuk menyemprotkan disinfektan kepada setiap warga maupun kendaraan yang akan masuk ke dusun Genitem.', '2020-03-28 12:34:01', 3),
(17, '28032020064755scaled_wisata-indonesia-1-Sindonews.jpg', 'Wabah Corona, 969 Meninggal dalam Satu Hari di Italia', 'Wabah Corona, 969 Meninggal dalam Satu Hari di Italia', 'Jakarta, CNN Indonesia -- Italia mencatat lonjakan kematian akibat infeksi virus corona dengan 969 orang pada Jumat (27/3). Ini adalah catatan harian terburuk sejak pandemi dimulai sejak Desember 2019.\nJakarta, CNN Indonesia -- Italia mencatat lonjakan kematian akibat infeksi virus corona dengan 969 orang pada Jumat (27/3). Ini adalah catatan harian terburuk sejak pandemi dimulai sejak Desember 2019.', '2020-03-28 12:35:05', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `id_users` int(11) NOT NULL,
  `username` text NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `level` int(11) NOT NULL,
  `register_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`id_users`, `username`, `email`, `password`, `level`, `register_date`) VALUES
(1, 'admin', 'admin@gmail.com', '202cb962ac59075b964b07152d234b70', 1, '2020-03-20 14:06:03'),
(2, 'User', 'user@gmail.com', '202cb962ac59075b964b07152d234b70', 1, '2020-03-20 14:06:35'),
(3, 'Baim', 'Baim@gmail.com', '202cb962ac59075b964b07152d234b70', 1, '2020-03-20 16:05:08'),
(4, 'Master', 'master@gmail.com', '202cb962ac59075b964b07152d234b70', 1, '2020-03-28 13:26:17'),
(5, 'putra', 'putra@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 1, '2020-03-28 13:35:07'),
(6, 'coba', 'coba@gmail.com', 'c4ca4238a0b923820dcc509a6f75849b', 1, '2020-04-21 10:10:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_news`
--
ALTER TABLE `tbl_news`
  ADD PRIMARY KEY (`id_news`) USING BTREE,
  ADD KEY `id_users` (`id_users`) USING BTREE;

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`id_users`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_news`
--
ALTER TABLE `tbl_news`
  MODIFY `id_news` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `id_users` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_news`
--
ALTER TABLE `tbl_news`
  ADD CONSTRAINT `tbl_news_ibfk_1` FOREIGN KEY (`id_users`) REFERENCES `tbl_users` (`id_users`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
