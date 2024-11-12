-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 10, 2024 at 08:08 AM
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
-- Database: `bookhave`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookavailability`
--

CREATE TABLE `bookavailability` (
  `book_id` varchar(50) NOT NULL,
  `available_copies` int(11) NOT NULL,
  `total_copies` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookavailability`
--

INSERT INTO `bookavailability` (`book_id`, `available_copies`, `total_copies`) VALUES
('AAA-0000', 4, 5),
('BBB-0000', 2, 5),
('CCC-0000', 3, 5),
('DDD-0000', 4, 5);

-- --------------------------------------------------------

--
-- Table structure for table `book_details`
--

CREATE TABLE `book_details` (
  `book_id` varchar(50) NOT NULL,
  `book_name` varchar(255) NOT NULL,
  `author_name` varchar(255) NOT NULL,
  `Genre` enum('Fiction','Non-fiction','Thriller','Mystery','Fantasies','Romance','Horror','Comedy','Drama','History') NOT NULL,
  `publisher_name` varchar(255) NOT NULL,
  `publishing_year` int(11) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'Available',
  `Total_copies` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_details`
--

INSERT INTO `book_details` (`book_id`, `book_name`, `author_name`, `Genre`, `publisher_name`, `publishing_year`, `status`, `Total_copies`) VALUES
('AAA-0000', 'book4', 'author4', 'Fiction', 'publish4', 2024, 'Available', 5),
('BBB-0000', 'book2', 'author2', 'Fiction', 'publish2', 2024, 'Available', 5),
('CCC-0000', 'book1', 'author1', 'Fiction', 'publish1', 2024, 'Available', 10),
('DDD-0000', 'book3', 'author3', 'Fiction', 'publish3', 2024, 'Available', 4);

-- --------------------------------------------------------

--
-- Table structure for table `book_records`
--

CREATE TABLE `book_records` (
  `user_id` int(11) NOT NULL,
  `books_issued` int(11) NOT NULL DEFAULT 0,
  `borrow_limit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `borrowedbooks`
--

CREATE TABLE `borrowedbooks` (
  `borrow_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` varchar(50) NOT NULL,
  `borrow_date` date NOT NULL,
  `due_date` date NOT NULL,
  `bookSerial_no` int(11) NOT NULL,
  `description` text NOT NULL,
  `return_book` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `borrowedbooks`
--

INSERT INTO `borrowedbooks` (`borrow_id`, `user_id`, `book_id`, `borrow_date`, `due_date`, `bookSerial_no`, `description`, `return_book`) VALUES
(1, 7, 'AAA-0000', '2024-11-05', '2024-11-16', 98, '', 1),
(2, 6, 'BBB-0000', '2024-11-01', '2024-11-09', 99, '', 0),
(3, 8, 'CCC-0000', '2024-11-02', '2024-11-04', 100, '', 0),
(16, 6, 'AAA-0000', '2024-11-14', '2024-11-29', 111111, '123123131', 1),
(17, 6, 'BBB-0000', '2024-11-14', '2024-11-22', 123456, 'asdassadad', 0),
(18, 6, 'DDD-0000', '2024-11-14', '2024-11-22', 111111, 'asdasdasdas', 0),
(19, 6, 'CCC-0000', '2024-11-14', '2024-11-29', 123456, 'asdasdsadas', 1),
(21, 7, 'BBB-0000', '2024-11-01', '2024-11-13', 123131, 'borrow book', 0);

--
-- Triggers `borrowedbooks`
--
DELIMITER $$
CREATE TRIGGER `decrease_availableCopies` AFTER INSERT ON `borrowedbooks` FOR EACH ROW UPDATE bookavailability
SET available_copies = available_copies - 1
WHERE book_id = NEW.book_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `increase_bookIssued` AFTER INSERT ON `borrowedbooks` FOR EACH ROW UPDATE book_records
SET books_issued = books_issued + 1
WHERE user_id = NEW.user_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `favourite`
--

CREATE TABLE `favourite` (
  `Favourite_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` enum('Save List','Favourite','Borrowed','Return','Pending') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pendingrequest`
--

CREATE TABLE `pendingrequest` (
  `request_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` varchar(50) NOT NULL,
  `request_date` date NOT NULL,
  `status` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `returned_book`
--

CREATE TABLE `returned_book` (
  `return_id` int(11) NOT NULL,
  `borrow_id` int(11) NOT NULL,
  `book_id` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `return_date` datetime NOT NULL,
  `due_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `returned_book`
--

INSERT INTO `returned_book` (`return_id`, `borrow_id`, `book_id`, `user_id`, `return_date`, `due_date`) VALUES
(13, 19, 'CCC-0000', 6, '2024-11-10 05:36:21', '2024-11-10 05:36:21'),
(14, 1, 'AAA-0000', 1, '2024-11-10 06:51:37', '2024-11-10 06:51:37');

--
-- Triggers `returned_book`
--
DELIMITER $$
CREATE TRIGGER `after_returnInsert` AFTER INSERT ON `returned_book` FOR EACH ROW UPDATE borrowedbooks
SET return_book = 1
WHERE borrow_id = NEW.borrow_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `decrease_bookIssued` AFTER INSERT ON `returned_book` FOR EACH ROW UPDATE book_records
SET books_issued = books_issued - 1
WHERE user_id = NEW.user_id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `increase_availableCopies` AFTER INSERT ON `returned_book` FOR EACH ROW UPDATE bookavailability
SET available_copies = available_copies + 1
WHERE book_id = NEW.book_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `save_list`
--

CREATE TABLE `save_list` (
  `save_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` enum('Save List','Favourite','Borrowed','Return','Spending') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `books_issued` int(11) NOT NULL DEFAULT 0,
  `user_role` enum('Reader','Librarian','','') NOT NULL DEFAULT 'Reader',
  `location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `password`, `phone_number`, `books_issued`, `user_role`, `location`) VALUES
(6, 'Name1', 'email1', 'pass1', '123412123', 3, 'Reader', ''),
(7, 'momo', 'momo1@gmail.com', 'pass11', '112312312312', 0, 'Reader', ''),
(8, 'julian', 'julian@gmail.com', 'julian123', '09696966969', 0, 'Reader', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookavailability`
--
ALTER TABLE `bookavailability`
  ADD UNIQUE KEY `book_id` (`book_id`);

--
-- Indexes for table `book_details`
--
ALTER TABLE `book_details`
  ADD PRIMARY KEY (`book_id`);

--
-- Indexes for table `book_records`
--
ALTER TABLE `book_records`
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `borrowedbooks`
--
ALTER TABLE `borrowedbooks`
  ADD PRIMARY KEY (`borrow_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `book_id` (`book_id`);

--
-- Indexes for table `favourite`
--
ALTER TABLE `favourite`
  ADD PRIMARY KEY (`Favourite_id`);

--
-- Indexes for table `pendingrequest`
--
ALTER TABLE `pendingrequest`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `user_id` (`user_id`,`book_id`),
  ADD KEY `book_id` (`book_id`);

--
-- Indexes for table `returned_book`
--
ALTER TABLE `returned_book`
  ADD PRIMARY KEY (`return_id`),
  ADD KEY `borrow_id` (`borrow_id`,`user_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `book_id` (`book_id`);

--
-- Indexes for table `save_list`
--
ALTER TABLE `save_list`
  ADD PRIMARY KEY (`save_id`),
  ADD KEY `book_id` (`book_id`,`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `book_records`
--
ALTER TABLE `book_records`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `borrowedbooks`
--
ALTER TABLE `borrowedbooks`
  MODIFY `borrow_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `favourite`
--
ALTER TABLE `favourite`
  MODIFY `Favourite_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pendingrequest`
--
ALTER TABLE `pendingrequest`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `returned_book`
--
ALTER TABLE `returned_book`
  MODIFY `return_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `save_list`
--
ALTER TABLE `save_list`
  MODIFY `save_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookavailability`
--
ALTER TABLE `bookavailability`
  ADD CONSTRAINT `bookavailability_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `book_details` (`book_id`) ON UPDATE CASCADE;

--
-- Constraints for table `book_records`
--
ALTER TABLE `book_records`
  ADD CONSTRAINT `book_records_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `borrowedbooks` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `borrowedbooks`
--
ALTER TABLE `borrowedbooks`
  ADD CONSTRAINT `borrowedbooks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `borrowedbooks_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book_details` (`book_id`) ON UPDATE CASCADE;

--
-- Constraints for table `pendingrequest`
--
ALTER TABLE `pendingrequest`
  ADD CONSTRAINT `pendingrequest_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pendingrequest_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book_details` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `returned_book`
--
ALTER TABLE `returned_book`
  ADD CONSTRAINT `returned_book_ibfk_2` FOREIGN KEY (`borrow_id`) REFERENCES `borrowedbooks` (`borrow_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `returned_book_ibfk_3` FOREIGN KEY (`book_id`) REFERENCES `borrowedbooks` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */; 
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
