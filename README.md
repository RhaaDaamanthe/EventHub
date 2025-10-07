# 🎟️ EventHub – Plateforme de gestion d’événements

Une application web moderne développée avec **Symfony 7** permettant de créer, découvrir et gérer des événements facilement.  
EventHub simplifie la mise en relation entre **organisateurs** et **participants** grâce à une interface fluide, responsive et intuitive.

---

## 🎯 À propos du projet

EventHub est une plateforme web qui centralise la création, la gestion et la participation à des événements.  
Elle répond à un besoin fréquent : **simplifier la gestion événementielle** pour les associations, entreprises et particuliers.

### Objectifs du projet
- ✅ Offrir une interface intuitive et responsive
- ✅ Faciliter la création, modification et suppression d’événements
- ✅ Permettre l’inscription et la désinscription aux événements
- ✅ Gérer les utilisateurs et leurs rôles (admin / membre)
- ✅ Sécuriser les données et les interactions

---

## ⚙️ Fonctionnalités principales

### 👥 Utilisateurs
- Création de compte et connexion sécurisée (hashage de mot de passe)
- Gestion de profil
- Liste des événements créés et rejoints
- Système de rôles (`ROLE_USER`, `ROLE_ADMIN`)

### 🎫 Événements
- Création, modification et suppression d’événements
- Téléversement d’images
- Pagination et recherche d’événements publics
- Système de likes ❤️
- Compteur de participants en temps réel

### 🧑‍💼 Administration
- Liste complète des utilisateurs et événements
- Suppression et gestion des comptes
- Visualisation des participants par événement
- Accès réservé aux administrateurs

### 💻 Interface
- Design responsive (mobile, tablette, desktop)
- Menu burger animé pour la navigation mobile
- Page profil dynamique
- Page d’accueil listant les événements à venir

---

## 🛠 Technologies utilisées

| Catégorie | Technologie |
|------------|--------------|
| **Backend** | PHP 8.3 / Symfony 7 |
| **Base de données** | MySQL 9.1 |
| **ORM** | Doctrine |
| **Frontend** | Twig, HTML5, CSS3, JavaScript natif |
| **CSS Framework** | Bootstrap (partiel) |
| **Sécurité** | Symfony Security |
| **Versionnement** | Git / GitHub |
| **Serveur local** | WAMP |

---

## 📋 Prérequis

Avant d’installer EventHub, assurez-vous d’avoir :
- PHP **8.3+**
- Composer
- MySQL **8+** ou MariaDB
- WAMP / XAMPP / Laragon ou le serveur Symfony CLI
- (Optionnel) Node.js et npm pour la gestion d’assets

---

## 🚀 Installation

### 1️⃣ Cloner le dépôt
```bash
git clone https://github.com/ton-pseudo/eventhub.git
cd eventhub
2️⃣ Installer les dépendances
composer install
3️⃣ Configurer l’environnement
Créez un fichier .env.local à la racine :

DATABASE_URL="mysql://app:motdepasse@127.0.0.1:3306/eventhub"
4️⃣ Créer la base de données

php bin/console doctrine:database:create
php bin/console doctrine:migrations:migrate
5️⃣ Lancer le serveur

symfony server:start

➡️ Ouvrez http://localhost:8000

🎮 Utilisation
Inscrivez-vous via la page d’inscription
Connectez-vous à votre compte
Créez un événement ou rejoignez-en un existant
Gérez vos événements depuis votre profil
Si vous êtes admin → accédez à l’espace d’administration

🧱 Structure du projet
csharp
Copier le code
eventhub/
├── src/
│   ├── Controller/        # Contrôleurs Symfony (EventController, ProfileController, AdminController)
│   ├── Entity/            # Entités Doctrine (Users, Events, Registrations)
│   ├── Repository/        # Logique d’accès aux données
│   └── Form/              # Gestion des formulaires
│
├── templates/
│   ├── base.html.twig     # Template principal
│   ├── event/             # Pages liées aux événements
│   ├── profile/           # Page profil utilisateur
│   ├── admin/             # Espace administrateur
│   └── etc/               # Et autres
│
├── public/
│   ├── uploads/events/    # Images des événements
│   ├── Images/            # Autres images
│   └── index/
│
└── config/                # Configuration Symfony

🌐 Déploiement
Installer les dépendances sans celles de dev

bash
Copier le code
composer install --no-dev --optimize-autoloader
Appliquer les migrations

Configurer ton serveur Apache/Nginx

Régler les permissions sur var/cache et var/log


👋 Ton Jérémy Nicollet
Projet réalisé dans le cadre de la formation Développeur Web & Web Mobile (DWWM)
📆 Année : 2024/2025
🔗 https://github.com/RhaaDaamanthe/EventHub