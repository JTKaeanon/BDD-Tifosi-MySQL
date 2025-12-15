-- -------------------------------------------------------------------------
-- Script de création de la base de données 'tifosi'
-- Auteur : [Ton Nom]
-- Date : [Date du jour]
-- -------------------------------------------------------------------------

-- 1. Création de la base de données
-- On supprime la base si elle existe déjà pour repartir sur des bases saines
DROP DATABASE IF EXISTS tifosi;
CREATE DATABASE tifosi DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- Sélection de la base
USE tifosi;

-- 2. Création de l'utilisateur administrateur
-- On crée l'utilisateur 'tifosi' avec le mot de passe (à changer en prod)
CREATE USER IF NOT EXISTS 'tifosi'@'localhost' IDENTIFIED BY 'tifosi_password';
-- On lui donne tous les droits sur la base tifosi
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
-- On applique les changements de droits
FLUSH PRIVILEGES;

-- -------------------------------------------------------------------------
-- 3. Création des tables
-- -------------------------------------------------------------------------

-- Table : client
CREATE TABLE client (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(45) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(45) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Table : marque
CREATE TABLE marque (
    id_marque INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(45) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Table : ingredient
CREATE TABLE ingredient (
    id_ingredient INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(45) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Table : focaccia
-- Le prix est en DECIMAL pour éviter les erreurs d'arrondi des FLOAT
CREATE TABLE focaccia (
    id_focaccia INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(45) NOT NULL,
    prix DECIMAL(5, 2) NOT NULL
) ENGINE=InnoDB;

-- Table : boisson
-- Relation (1,1) avec marque : une boisson appartient à une marque
CREATE TABLE boisson (
    id_boisson INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(45) NOT NULL,
    id_marque INT NOT NULL,
    CONSTRAINT fk_boisson_marque FOREIGN KEY (id_marque) REFERENCES marque(id_marque)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Table : menu
-- Relation (1,1) avec focaccia et boisson
CREATE TABLE menu (
    id_menu INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(45) NOT NULL,
    prix DECIMAL(5, 2) NOT NULL,
    id_focaccia INT NOT NULL,
    id_boisson INT NOT NULL,
    CONSTRAINT fk_menu_focaccia FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_menu_boisson FOREIGN KEY (id_boisson) REFERENCES boisson(id_boisson)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- -------------------------------------------------------------------------
-- 4. Création des tables d'association (Relations N,N)
-- -------------------------------------------------------------------------

-- Table : paye (Relation 'achete' entre Client et Menu)
-- Note : J'utilise 'paye' car 'achete' est un verbe, souvent on nomme la table 'vente' ou 'ticket'
-- La consigne demande de respecter le modèle, donc on suit la logique "Client achete Menu"
CREATE TABLE achete (
    id_client INT NOT NULL,
    id_menu INT NOT NULL,
    jour DATE NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT pk_achete PRIMARY KEY (id_client, id_menu, jour), -- Clé primaire composite
    CONSTRAINT fk_achete_client FOREIGN KEY (id_client) REFERENCES client(id_client)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_achete_menu FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Table : comprend (Relation entre Focaccia et Ingredient)
-- Gère la composition des focaccias. Un ingrédient peut être dans plusieurs focaccias.
CREATE TABLE comprend (
    id_focaccia INT NOT NULL,
    id_ingredient INT NOT NULL,
    CONSTRAINT pk_comprend PRIMARY KEY (id_focaccia, id_ingredient),
    CONSTRAINT fk_comprend_focaccia FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_comprend_ingredient FOREIGN KEY (id_ingredient) REFERENCES ingredient(id_ingredient)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;