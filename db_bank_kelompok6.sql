-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 15 Mar 2024 pada 17.45
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_bank_kelompok6`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `account`
--

CREATE TABLE `account` (
  `account_number` int(11) NOT NULL,
  `balance` decimal(10,2) DEFAULT NULL,
  `type` enum('saving-account','checking-account') DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `borrower`
--

CREATE TABLE `borrower` (
  `customer_id` int(11) NOT NULL,
  `loan_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `branch`
--

CREATE TABLE `branch` (
  `branc_name` varchar(50) NOT NULL,
  `branch_city` varchar(50) DEFAULT NULL,
  `assets` decimal(10,2) DEFAULT NULL,
  `loan_number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `customer_name` varchar(50) DEFAULT NULL,
  `customer_street` varchar(100) DEFAULT NULL,
  `customer_city` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cust_banker`
--

CREATE TABLE `cust_banker` (
  `customer_id` int(11) NOT NULL,
  `emp_number` int(11) NOT NULL,
  `type` enum('primary','secondary') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `depositor`
--

CREATE TABLE `depositor` (
  `customer_id` int(11) NOT NULL,
  `account_number` int(11) NOT NULL,
  `access_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `employee`
--

CREATE TABLE `employee` (
  `emp_number` int(11) NOT NULL,
  `emp_name` varchar(50) DEFAULT NULL,
  `dependent_name` varchar(50) DEFAULT NULL,
  `telephone_number` varchar(15) DEFAULT NULL,
  `employment_length` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `isa`
--

CREATE TABLE `isa` (
  `account_number` int(11) NOT NULL,
  `sub_account_type` enum('saving-account','checking-account') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `loan`
--

CREATE TABLE `loan` (
  `loan_number` int(11) NOT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `loanpayment`
--

CREATE TABLE `loanpayment` (
  `loan_number` int(11) NOT NULL,
  `payment_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `loan_branch`
--

CREATE TABLE `loan_branch` (
  `loan_number` int(11) NOT NULL,
  `branc_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `loan_payment`
--

CREATE TABLE `loan_payment` (
  `loan_number` int(11) NOT NULL,
  `payment_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `payment`
--

CREATE TABLE `payment` (
  `payment_number` int(11) NOT NULL,
  `loan_number` int(11) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `worksfor`
--

CREATE TABLE `worksfor` (
  `employee_id` int(11) NOT NULL,
  `branch_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`account_number`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indeks untuk tabel `borrower`
--
ALTER TABLE `borrower`
  ADD PRIMARY KEY (`customer_id`,`loan_number`),
  ADD KEY `loan_number` (`loan_number`);

--
-- Indeks untuk tabel `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`branc_name`),
  ADD UNIQUE KEY `loan_number` (`loan_number`);

--
-- Indeks untuk tabel `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indeks untuk tabel `cust_banker`
--
ALTER TABLE `cust_banker`
  ADD PRIMARY KEY (`customer_id`,`emp_number`),
  ADD KEY `emp_number` (`emp_number`);

--
-- Indeks untuk tabel `depositor`
--
ALTER TABLE `depositor`
  ADD PRIMARY KEY (`customer_id`,`account_number`),
  ADD KEY `account_number` (`account_number`);

--
-- Indeks untuk tabel `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_number`);

--
-- Indeks untuk tabel `isa`
--
ALTER TABLE `isa`
  ADD PRIMARY KEY (`account_number`,`sub_account_type`);

--
-- Indeks untuk tabel `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`loan_number`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indeks untuk tabel `loanpayment`
--
ALTER TABLE `loanpayment`
  ADD PRIMARY KEY (`loan_number`,`payment_number`),
  ADD KEY `payment_number` (`payment_number`);

--
-- Indeks untuk tabel `loan_branch`
--
ALTER TABLE `loan_branch`
  ADD PRIMARY KEY (`loan_number`,`branc_name`),
  ADD KEY `branc_name` (`branc_name`);

--
-- Indeks untuk tabel `loan_payment`
--
ALTER TABLE `loan_payment`
  ADD PRIMARY KEY (`loan_number`,`payment_number`),
  ADD KEY `payment_number` (`payment_number`);

--
-- Indeks untuk tabel `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_number`),
  ADD KEY `loan_number` (`loan_number`);

--
-- Indeks untuk tabel `worksfor`
--
ALTER TABLE `worksfor`
  ADD PRIMARY KEY (`employee_id`,`branch_name`),
  ADD KEY `branch_name` (`branch_name`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_number` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `account_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Ketidakleluasaan untuk tabel `borrower`
--
ALTER TABLE `borrower`
  ADD CONSTRAINT `borrower_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `borrower_ibfk_2` FOREIGN KEY (`loan_number`) REFERENCES `loan` (`loan_number`);

--
-- Ketidakleluasaan untuk tabel `branch`
--
ALTER TABLE `branch`
  ADD CONSTRAINT `branch_ibfk_1` FOREIGN KEY (`loan_number`) REFERENCES `loan` (`loan_number`);

--
-- Ketidakleluasaan untuk tabel `cust_banker`
--
ALTER TABLE `cust_banker`
  ADD CONSTRAINT `cust_banker_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `cust_banker_ibfk_2` FOREIGN KEY (`emp_number`) REFERENCES `employee` (`emp_number`);

--
-- Ketidakleluasaan untuk tabel `depositor`
--
ALTER TABLE `depositor`
  ADD CONSTRAINT `depositor_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `depositor_ibfk_2` FOREIGN KEY (`account_number`) REFERENCES `account` (`account_number`);

--
-- Ketidakleluasaan untuk tabel `isa`
--
ALTER TABLE `isa`
  ADD CONSTRAINT `isa_ibfk_1` FOREIGN KEY (`account_number`) REFERENCES `account` (`account_number`);

--
-- Ketidakleluasaan untuk tabel `loan`
--
ALTER TABLE `loan`
  ADD CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Ketidakleluasaan untuk tabel `loanpayment`
--
ALTER TABLE `loanpayment`
  ADD CONSTRAINT `loanpayment_ibfk_1` FOREIGN KEY (`loan_number`) REFERENCES `loan` (`loan_number`),
  ADD CONSTRAINT `loanpayment_ibfk_2` FOREIGN KEY (`payment_number`) REFERENCES `payment` (`payment_number`);

--
-- Ketidakleluasaan untuk tabel `loan_branch`
--
ALTER TABLE `loan_branch`
  ADD CONSTRAINT `loan_branch_ibfk_1` FOREIGN KEY (`loan_number`) REFERENCES `loan` (`loan_number`),
  ADD CONSTRAINT `loan_branch_ibfk_2` FOREIGN KEY (`branc_name`) REFERENCES `branch` (`branc_name`);

--
-- Ketidakleluasaan untuk tabel `loan_payment`
--
ALTER TABLE `loan_payment`
  ADD CONSTRAINT `loan_payment_ibfk_1` FOREIGN KEY (`loan_number`) REFERENCES `loan` (`loan_number`),
  ADD CONSTRAINT `loan_payment_ibfk_2` FOREIGN KEY (`payment_number`) REFERENCES `payment` (`payment_number`);

--
-- Ketidakleluasaan untuk tabel `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`loan_number`) REFERENCES `loan` (`loan_number`);

--
-- Ketidakleluasaan untuk tabel `worksfor`
--
ALTER TABLE `worksfor`
  ADD CONSTRAINT `worksfor_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`emp_number`),
  ADD CONSTRAINT `worksfor_ibfk_2` FOREIGN KEY (`branch_name`) REFERENCES `branch` (`branc_name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
