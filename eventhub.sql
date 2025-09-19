-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 19 sep. 2025 à 14:07
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
('DoctrineMigrations\\Version20250919122517', '2025-09-19 12:25:23', 112);

-- --------------------------------------------------------

--
-- Structure de la table `events`
--

DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_by_id` int NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `events`
--

INSERT INTO `events` (`id`, `created_by_id`, `title`, `description`, `start_date`, `end_date`, `location`, `image`, `capacity`, `registered_count`, `is_public`) VALUES
(16, 2, 'Première coupe du monde Fortnite', 'pokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpkopokfzekopfkokopzokpfokpko', '2025-10-01 10:45:00', '2025-10-06 10:45:00', 'Arthur Ashe Stadium, New York', '/uploads/events/wc-ftn-68c13aa4139e4.jpg', 3000, 2, 1),
(18, 2, 'Balade au Crêt de Chalam', 'Pour tout le monde, même les débutants !', '2025-10-09 11:17:00', '2025-10-10 11:17:00', 'Crêt de Chalam, Jura', '/uploads/events/chalam-68c14245b0068.jpg', 20, 1, 1),
(19, 2, 'Crêpes party', 'miaaaam', '2025-09-18 11:20:00', '2025-09-18 17:20:00', 'Chez moi, Bellignat', '/uploads/events/crepes-party-68c142e449987.jpg', 6, 1, 1),
(23, 5, 'dfscws', 'ffqfqfqf', '2025-09-06 15:52:00', '2025-09-24 15:52:00', 'ddd', '/uploads/events/jetski-68c81a33d7d1f.jpg', 6, 1, 1),
(34, 8, 'Symfony Meetup Paris', 'Rencontre entre développeurs Symfony pour échanger sur les bonnes pratiques et nouveautés du framework.', '2025-10-12 18:30:00', '2025-10-12 21:30:00', 'Paris, La Défense', '/uploads/events/meetup-symfony-thecamp-68cc023eaac2f.jpg', 50, 0, 1),
(35, 8, 'Hackathon Lyon', '48h pour coder en équipe et créer des projets innovants autour du web et de l’IA.', '2025-11-07 09:00:00', '2025-11-09 18:00:00', 'Lyon, H7', '/uploads/events/1699869231041-68cc02fe1e470.jpg', 120, 0, 1),
(36, 8, 'Soirée Jeux Vidéo', 'Tournoi e-sport avec pizzas, boissons et lots à gagner.', '2025-12-05 20:00:00', '2025-12-06 02:00:00', 'Marseille, Gaming Arena', '/uploads/events/jv-68cc026251724.jpg', 80, 0, 1),
(37, 8, 'Atelier ReactJS', 'Atelier pratique pour découvrir les bases de ReactJS et créer une première application.', '2025-10-20 14:00:00', '2025-10-20 17:00:00', 'Bordeaux, La Halle Digitale', '/uploads/events/js-68cc026cb0c6f.jpg', 40, 0, 1),
(38, 8, 'Conférence Cybersécurité', 'Experts en cybersécurité viennent partager leurs expériences et bonnes pratiques.', '2025-11-15 09:30:00', '2025-11-15 18:00:00', 'Lille Grand Palais', '/uploads/events/Conference-cybersecurite-5-sep-2024-68cc02c88e850.png', 200, 0, 1),
(39, 8, 'Afterwork Networking', 'Événement de networking pour rencontrer d’autres professionnels du numérique.', '2025-09-25 19:00:00', '2025-09-25 23:00:00', 'Toulouse, Le Connecteur', '/uploads/events/lafterwork-la-nouvelle-arme-du-networking-6bf88b966c8e7cc05c5cd9a2895b45de-68cc027b9dee7.jpg', 100, 0, 1),
(40, 8, 'Workshop Data Science', 'Atelier pratique sur Python, Pandas et l’analyse de données réelles.', '2025-10-30 10:00:00', '2025-10-30 16:00:00', 'Nantes, Digital Village', '/uploads/events/datascience-workshop8b9c3ec812414febbd2660dfb43aabc4-tmb-th950x345-68cc02a69baf4.jpg', 60, 0, 1),
(41, 8, 'Salon Startups Tech', 'Un salon pour découvrir les startups innovantes de la French Tech.', '2025-11-22 09:00:00', '2025-11-23 18:00:00', 'Paris Expo Porte de Versailles', '/uploads/events/ces-salon-innovation-technologie-electronique-68cc02b998b15.jpg', 500, 0, 1),
(42, 8, 'Cours Yoga & Tech', 'Session de yoga pour développeurs, suivie d’une conférence sur le bien-être au travail.', '2025-12-12 18:00:00', '2025-12-12 21:00:00', 'Montpellier, Coworking Zen', '/uploads/events/cours-yoga-bordeaux-1-2000-68cc0287d913e.jpg', 30, 1, 1),
(43, 8, 'Festival Numérique', 'Festival avec ateliers, conférences et stands autour du numérique et des nouvelles technologies.', '2025-10-05 10:00:00', '2025-10-07 20:00:00', 'Strasbourg, Parc des Expositions', '/uploads/events/Sans-titre-49-4-68cc0291a4a7a.jpg', 1000, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `likes`
--

DROP TABLE IF EXISTS `likes`;
CREATE TABLE IF NOT EXISTS `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `event_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_49CA4E7DA76ED395` (`user_id`),
  KEY `IDX_49CA4E7D71F7E88B` (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `event_id`) VALUES
(5, 2, 19),
(6, 2, 16),
(12, 2, 42),
(13, 5, 42),
(14, 5, 38);

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `registrations`
--

INSERT INTO `registrations` (`id`, `user_id_id`, `event_id_id`, `registered_at`) VALUES
(10, 2, 16, '2025-09-15 06:59:15'),
(12, 5, 23, '2025-09-15 13:52:56'),
(13, 2, 42, '2025-09-19 07:28:34'),
(14, 15, 18, '2025-09-19 09:32:35'),
(15, 15, 43, '2025-09-19 09:32:40'),
(16, 15, 19, '2025-09-19 09:32:44'),
(17, 15, 16, '2025-09-19 09:32:53');

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `roles`, `password`, `username`, `is_active`, `created_at`) VALUES
(2, 'test@gmail.com', '[\"ROLE_ADMIN\"]', '$2y$13$FJ1EKpA9vTc4INZENAwLQuSSUQWYzMgsWi2haVWWZUudAtDeXiXRi', 'test', 0, '2025-09-05 09:28:36'),
(3, 'oui@gmail.com', '[]', '$2y$13$myjGJ2MG6Yw6nxg/oFLHTu95KcbZPIiaHM0LUIKfaKGKNnSUjDP2C', 'oui', 0, '2025-09-05 09:53:27'),
(4, 'non@gmail.com', '[]', '$2y$13$tXF59co5/zieidH59fJeO.A8GPdskrkGIIMVyX0jGfgrYvVHIA/tO', 'non', 0, '2025-09-05 10:01:03'),
(5, 'toto@gmail.com', '[]', '$2y$13$BsvtdIITp0YhM3oFBoQxIeJAzzBlEcow3GHixdn1FNP5kc5CJ3YcW', 'toto', 0, '2025-09-05 11:31:51'),
(6, 'bob@gmail.com', '[]', '$2y$13$C.MBWAVj6NpdUq/RGsvJROI0krQQEGO8WXdVMEqW.z287gPyLIUk2', 'Bob', 0, '2025-09-05 13:03:36'),
(7, 'admin@eventhub.com', '[\"ROLE_ADMIN\"]', '$2y$13$N9qo8uLOickgx2ZMRZo5i.ejvY9rEYprQxC.fqgIJ5MfEyu/2h1K.', 'admin', 1, '2025-09-09 09:06:20'),
(8, 'alice@example.com', '[\"ROLE_USER\"]', '$2y$13$N9qo8uLOickgx2ZMRZo5i.ejvY9rEYprQxC.fqgIJ5MfEyu/2h1K.', 'alice', 1, '2025-09-09 09:06:20'),
(9, 'bob@example.com', '[\"ROLE_USER\"]', '$2y$13$N9qo8uLOickgx2ZMRZo5i.ejvY9rEYprQxC.fqgIJ5MfEyu/2h1K.', 'bob', 1, '2025-09-09 09:06:20'),
(13, 'youpi@gmail.com', '[]', '$2y$13$zmZbSXCvdGDJdiofS9glTulOT0be5.cn7QLWrCV.9JimkQclB7yva', 'youpioeoe', 0, '2025-09-09 12:11:47'),
(14, 'ijfojiodfezjizjioze@gmail.com', '[]', '$2y$13$b3tH7k5PZlNL2ukjLpWJEuYyGf1tR9ybXvM.prDWWskJo4syQ2Q.y', 'qsdfghgfdsdfgfds', 0, '2025-09-19 09:29:32'),
(15, 'poipoi@aol.fr', '[]', '$2y$13$WPhZqBN1ghTrYxn0Zs7TUeUvpBb8isjjzc.CZYEUlesQi8uvvIsb.', 'opipoi', 0, '2025-09-19 09:32:12'),
(16, 'dfdfgsd@gmail.com', '[]', '$2y$13$9hBWaHqkZpzcReHHfN8jo.JLmV2Shy4aQHkZaa1bC7ge2cyjIdZti', 'fdesdfg', 0, '2025-09-19 12:57:36'),
(17, 'edfvdfdsv@gmail.komed', '[]', '$2y$13$yjRGhXmpY0nUbaYD/LmTIOY8ChFti0WljfKPBfg.aX6VE8N45Fu3O', 'zawardo', 0, '2025-09-19 13:02:35');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `FK_5387574AB03A8386` FOREIGN KEY (`created_by_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `FK_49CA4E7D71F7E88B` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  ADD CONSTRAINT `FK_49CA4E7DA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

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
