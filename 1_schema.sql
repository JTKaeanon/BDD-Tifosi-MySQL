-- clean base on each execution
DROP DATABASE IF EXISTS tifosi;
CREATE DATABASE tifosi DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE tifosi;

-- Access management
-- Admin creation
CREATE USER IF NOT EXISTS 'tifosi'@'localhost' IDENTIFIED BY 'tifosi_password';
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
FLUSH PRIVILEGES;

-- Catalog creation 


-- Clients directory
CREATE TABLE client (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(45) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(45) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Available drink brands
CREATE TABLE marque (
    id_marque INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(45) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Ingredient stock
CREATE TABLE ingredient (
    id_ingredient INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(45) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Focaccia menu
CREATE TABLE focaccia (
    id_focaccia INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(45) NOT NULL,
    prix DECIMAL(5, 2) NOT NULL
) ENGINE=InnoDB;

-- Drinks menu
CREATE TABLE boisson (
    id_boisson INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(45) NOT NULL,
    id_marque INT NOT NULL,
    CONSTRAINT fk_boisson_marque FOREIGN KEY (id_marque) REFERENCES marque(id_marque)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Focaccia + Drink combo
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


-- Purchase history 
CREATE TABLE achete (
    id_client INT NOT NULL,
    id_menu INT NOT NULL,
    jour DATE NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT pk_achete PRIMARY KEY (id_client, id_menu, jour),
    CONSTRAINT fk_achete_client FOREIGN KEY (id_client) REFERENCES client(id_client)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_achete_menu FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Recipes 
CREATE TABLE comprend (
    id_focaccia INT NOT NULL,
    id_ingredient INT NOT NULL,
    CONSTRAINT pk_comprend PRIMARY KEY (id_focaccia, id_ingredient),
    CONSTRAINT fk_comprend_focaccia FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_comprend_ingredient FOREIGN KEY (id_ingredient) REFERENCES ingredient(id_ingredient)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;
