-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 02, 2021 at 08:06 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `movies`
--
CREATE DATABASE IF NOT EXISTS `2023-movies` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `2023-movies`;

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE `genre` (
  `id` int(10) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `number_of_movies` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `genre`
--

INSERT INTO `genre` (`id`, `name`, `number_of_movies`) VALUES
(12, 'Adventure', 15),
(14, 'Fantasy', 0),
(16, 'Animation', 1),
(18, 'Drama', 7),
(27, 'Horror', 3),
(28, 'Action', 1),
(35, 'Comedy', 1),
(36, 'History', 0),
(37, 'Western', 0),
(53, 'Thriller', 0),
(80, 'Crime', 0),
(99, 'Documentary', 1),
(878, 'Science Fiction', 0),
(9648, 'Mystery', 1),
(10402, 'Music', 0),
(10749, 'Romance', 0),
(10751, 'Family', 1),
(10752, 'War', 0),
(10769, 'Foreign', 1),
(10770, 'TV Movie', 0);

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `id` int(10) NOT NULL,
  `title` varchar(1000) NOT NULL,
  `overview` varchar(1000) NOT NULL,
  `release_date` date NOT NULL,
  `movie_status` varchar(50) DEFAULT NULL,
  `tagline` varchar(1000) DEFAULT NULL,
  `vote_average` decimal(4,2) DEFAULT NULL,
  `vote_count` int(10) DEFAULT NULL,
  `poster` varchar(255) NOT NULL,
  `genre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `movie`
--

INSERT INTO `movie` (`id`, `title`, `overview`, `release_date`, `movie_status`, `tagline`, `vote_average`, `vote_count`, `poster`, `genre_id`) VALUES
(426067, 'Midnight Cabaret', 'A Broadway producer puts on a play with a Devil character in it. Soon the actors begin having nightmares, and events that are mentioned in the play really start happening.', '1990-01-01', 'Released', 'The hot spot where Satan&#039;s waitin&#039;.', '0.00', 0, 'MV5BYzJiMWM3NWQtOWY3ZC00NDY4LThmODUtN2VkNjZhOWZkYjQ2XkEyXkFq.jpg', 27),
(426469, 'Growing Up Smith', 'In 1979, an Indian family moves to America with hopes of living the American Dream. While their 10-year-old boy Smith falls head-over-heels for the girl next door, his desire to become a \"good old boy\" propels him further away from his family\'s ideals than ever before.', '2017-02-09', 'Released', 'It’s better to stand out than to fit in.', '7.40', 7, 'growingup.jpg', 18),
(459488, 'To Be Frank, Sinatra at 100', '', '2015-12-12', 'Released', NULL, '0.00', 0, '', 99),
(459489, 'Ava', 'A black ops assassin is forced to fight for her own survival after a job goes dangerously wrong.', '2020-09-25', NULL, 'Kill. Or be killed.', NULL, NULL, 'f33d8125166408a0e4baefddcba5b71d.jpg', 28),
(459491, 'Tenet', 'Armed with only one word - Tenet - and fighting for the survival of the entire world, the Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time.', '2020-08-28', NULL, 'Time runs out.', NULL, NULL, 'de4595bb153786acfbe8f19537f34d1f.jpg', 18),
(459492, 'The Owners', 'A group of friends think they found the perfect easy score - an empty house with a safe full of cash. But when the elderly couple that lives there comes home early, the tables are suddenly turned. As a deadly game of cat and mouse ensues, the would-be thieves must fight to save themselves from a nightmare they could never have imagined.', '2020-09-04', NULL, NULL, NULL, NULL, '65fb72349a30fd32fdc5fb58cb110d44.jpg', 18),
(459493, 'Bill & Ted Face the Music', 'Yet to fulfill their rock and roll destiny, the now middle-aged best friends Bill and Ted set out on a new adventure when a visitor from the future warns them that only their song can save life as we know it. Along the way, they are helped by their daughters, a new batch of historical figures and a few music legends—to seek the song that will set their world right and bring harmony to the universe.', '2020-09-16', NULL, 'The future awaits', NULL, NULL, '85747ee711361ce3836bb6cb879d3f2b.jpg', 18),
(459494, 'Hard Kill', 'The work of billionaire tech CEO Donovan Chalmers is so valuable that he hires mercenaries to protect it, and a terrorist group kidnaps his daughter just to get it.', '2020-09-14', NULL, 'Take on a madman. Save the world.', NULL, NULL, '05c1df238b806d3d0efa6f55bdd3b7af.jpg', 18),
(459516, 'The War with Grandpa', '\r\n\r\nPeter is thrilled that his Grandpa is coming to live with his family. That is, until Grandpa moves into Peter&#039;s room, forcing him upstairs into the creepy attic. And though he loves his Grandpa, he wants his room back - so he has no choice but to declare war.\r\n', '2020-11-20', NULL, 'Old school vs new cool', NULL, NULL, 'yUFbPtWeDbVR3zmqshOaL5lScyo.jpg', 35);

-- --------------------------------------------------------

--
-- Table structure for table `partner`
--

CREATE TABLE `partner` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `partner`
--

INSERT INTO `partner` (`id`, `name`, `logo`) VALUES
(1, ' Pizza Hut 2', 'PTN5fd65f53c45b2.png'),
(3, ' Gamecast ', 'PTN5fd65f4abd031.png'),
(4, 'Ingenius', 'PTN5fd65fa0114f6.png'),
(5, 'Microsoft', 'PTN5fd65fa8dc0f1.png'),
(6, 'Cisco', 'PTN5fd65f5a018af.png'),
(7, 'Area jugones', 'PTN5fd65f7edd476.png');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `role` varchar(255) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `role`) VALUES
(1, 'user', '$2y$12$pfMt1K..hd7W/BXk6RN8POOq0hG9z9WYFnyYrCHE9nQ7Usb9kEy1K', 'ROLE_USER'),
(2, 'admin', '$2y$12$PMCMNI7Orf0tgP.XFskEYesCnWYbIMXD.tAL4KSRq2A1D36O9NH.C', 'ROLE_ADMIN');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_genre_id` (`genre_id`);

--
-- Indexes for table `partner`
--
ALTER TABLE `partner`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQUE_USERNAME` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `movie`
--
ALTER TABLE `movie`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=459532;

--
-- AUTO_INCREMENT for table `partner`
--
ALTER TABLE `partner`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `movie`
--
ALTER TABLE `movie`
  ADD CONSTRAINT `fk_genre_id` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
