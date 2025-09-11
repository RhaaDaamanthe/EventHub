-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 11 sep. 2025 à 09:51
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `eventhub`
--

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20250904092844', '2025-09-04 09:29:36', 3701);

-- --------------------------------------------------------

--
-- Structure de la table `events`
--

DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_by_id` int DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `end_date` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `location` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacity` int NOT NULL,
  `registered_count` int DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5387574AB03A8386` (`created_by_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `events`
--

INSERT INTO `events` (`id`, `created_by_id`, `title`, `description`, `start_date`, `end_date`, `location`, `image`, `capacity`, `registered_count`, `is_public`) VALUES
(13, 2, 'dfesgdsq', 'sdfdsqsd', '2025-09-20 09:01:00', '2025-09-20 09:01:00', 'sdfgh', '/uploads/events/crepes-party-68c273d11873b.jpg', 45, 2, 1),
(14, 2, 'lspalspalpsa', 'kjhgghj', '2025-10-01 09:07:00', '2025-09-25 13:02:00', 'dddddddd', '/uploads/events/jetski-68c2740204fa7.jpg', 47, 0, 1),
(15, 2, 'Balade', 'zertfyghjuytrezqazertyuyhtrfdesertytrtr\'ertefred', '2025-09-25 14:18:00', '2025-10-09 15:18:00', 'Chez', '/uploads/events/chalam-68c285de8e567.jpg', 7987, 0, 1);

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `registrations`
--

DROP TABLE IF EXISTS `registrations`;
CREATE TABLE IF NOT EXISTS `registrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id_id` int DEFAULT NULL,
  `event_id_id` int DEFAULT NULL,
  `registered_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_53DE51E79D86650F` (`user_id_id`),
  KEY `IDX_53DE51E73E5F2F7B` (`event_id_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `registrations`
--

INSERT INTO `registrations` (`id`, `user_id_id`, `event_id_id`, `registered_at`) VALUES
(2, 5, 13, '2025-09-11 07:32:51'),
(8, 2, 13, '2025-09-11 09:09:08');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `roles`, `password`, `username`, `is_active`, `created_at`) VALUES
(2, 'test@gmail.com', '[]', '$2y$13$FJ1EKpA9vTc4INZENAwLQuSSUQWYzMgsWi2haVWWZUudAtDeXiXRi', 'test', 0, '2025-09-05 09:28:36'),
(3, 'oui@gmail.com', '[]', '$2y$13$myjGJ2MG6Yw6nxg/oFLHTu95KcbZPIiaHM0LUIKfaKGKNnSUjDP2C', 'oui', 0, '2025-09-05 09:53:27'),
(4, 'non@gmail.com', '[]', '$2y$13$tXF59co5/zieidH59fJeO.A8GPdskrkGIIMVyX0jGfgrYvVHIA/tO', 'non', 0, '2025-09-05 10:01:03'),
(5, 'toto@gmail.com', '[]', '$2y$13$BsvtdIITp0YhM3oFBoQxIeJAzzBlEcow3GHixdn1FNP5kc5CJ3YcW', 'toto', 0, '2025-09-05 11:31:51'),
(6, 'bob@gmail.com', '[]', '$2y$13$C.MBWAVj6NpdUq/RGsvJROI0krQQEGO8WXdVMEqW.z287gPyLIUk2', 'Bob', 0, '2025-09-05 13:03:36'),
(7, 'admin@eventhub.com', '[\"ROLE_ADMIN\"]', '$2y$13$N9qo8uLOickgx2ZMRZo5i.ejvY9rEYprQxC.fqgIJ5MfEyu/2h1K.', 'admin', 1, '2025-09-09 09:06:20'),
(8, 'alice@example.com', '[\"ROLE_USER\"]', '$2y$13$N9qo8uLOickgx2ZMRZo5i.ejvY9rEYprQxC.fqgIJ5MfEyu/2h1K.', 'alice', 1, '2025-09-09 09:06:20'),
(9, 'bob@example.com', '[\"ROLE_USER\"]', '$2y$13$N9qo8uLOickgx2ZMRZo5i.ejvY9rEYprQxC.fqgIJ5MfEyu/2h1K.', 'bob', 1, '2025-09-09 09:06:20'),
(13, 'youpi@gmail.com', '[]', '$2y$13$zmZbSXCvdGDJdiofS9glTulOT0be5.cn7QLWrCV.9JimkQclB7yva', 'youpioeoe', 0, '2025-09-09 12:11:47');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `FK_5387574AB03A8386` FOREIGN KEY (`created_by_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `registrations`
--
ALTER TABLE `registrations`
  ADD CONSTRAINT `FK_53DE51E73E5F2F7B` FOREIGN KEY (`event_id_id`) REFERENCES `events` (`id`),
  ADD CONSTRAINT `FK_53DE51E79D86650F` FOREIGN KEY (`user_id_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
