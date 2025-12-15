-- -------------------------------------------------------------------------
-- Script de peuplement de la base de données 'tifosi'
-- Fichier : 2_data.sql
-- -------------------------------------------------------------------------
USE tifosi;

-- Désactiver temporairement la vérification des clés étrangères pour éviter les erreurs d'ordre
SET FOREIGN_KEY_CHECKS = 0;

-- Vider les tables avant d'insérer (pour éviter les doublons si on relance le script)
TRUNCATE TABLE achete;
TRUNCATE TABLE comprend;
TRUNCATE TABLE menu;
TRUNCATE TABLE boisson;
TRUNCATE TABLE focaccia;
TRUNCATE TABLE ingredient;
TRUNCATE TABLE marque;
TRUNCATE TABLE client;

SET FOREIGN_KEY_CHECKS = 1;

-- -------------------------------------------------------------------------
-- 1. Insertion des Marques
-- -------------------------------------------------------------------------
INSERT INTO marque (id_marque, nom) VALUES 
(1, 'Coca-Cola'), 
(2, 'Cristaline'), 
(3, 'Monster'), 
(4, 'Pepsico');

-- -------------------------------------------------------------------------
-- 2. Insertion des Ingrédients
-- -------------------------------------------------------------------------
INSERT INTO ingredient (id_ingredient, nom) VALUES 
(1, 'Ail'), (2, 'Ananas'), (3, 'Artichaut'), (4, 'Bacon'), (5, 'Base Tomate'), 
(6, 'Base Crème'), (7, 'Champignon'), (8, 'Chevre'), (9, 'Cresson'), (10, 'Emmental'), 
(11, 'Gorgonzola'), (12, 'Jambon cuit'), (13, 'Jambon fumé'), (14, 'Oeuf'), (15, 'Oignon'), 
(16, 'Olive'), (17, 'Parmesan'), (18, 'Piment'), (19, 'Poivron'), (20, 'Pomme de terre'), 
(21, 'Raclette'), (22, 'Salami'), (23, 'Tomate Cerise'), (24, 'Mozzarella'), (25, 'Miel');

-- -------------------------------------------------------------------------
-- 3. Insertion des Focaccias
-- -------------------------------------------------------------------------
INSERT INTO focaccia (id_focaccia, nom, prix) VALUES 
(1, 'Mozzaccia', 9.80), 
(2, 'Gorgonzola', 10.80), 
(3, 'Raclaccia', 8.90), 
(4, 'Emmental', 9.80), 
(5, 'Tradizione', 8.90), 
(6, 'Hawaienne', 11.20), 
(7, 'Américaine', 10.80), 
(8, 'Paysanne', 12.80);

-- -------------------------------------------------------------------------
-- 4. Insertion des Boissons (liées aux Marques)
-- -------------------------------------------------------------------------
INSERT INTO boisson (id_boisson, nom, id_marque) VALUES 
(1, 'Coca-cola zéro', 1), 
(2, 'Coca-cola original', 1), 
(3, 'Fanta citron', 1), 
(4, 'Fanta orange', 1), 
(5, 'Capri-sun', 1), 
(6, 'Pepsi', 4), 
(7, 'Pepsi Max Zéro', 4), 
(8, 'Lipton zéro', 4), 
(9, 'Lipton Peach', 4), 
(10, 'Monster energy ultra gold', 3), 
(11, 'Monster energy ultra blue', 3), 
(12, 'Eau de source', 2);

-- -------------------------------------------------------------------------
-- 5. Insertion des Compositions (Table comprend : Focaccia <-> Ingredient)
-- -------------------------------------------------------------------------
-- Mozzaccia (Base Tomate, Mozzarella, Cresson, Jambon fumé, Ail, Artichaut, Parmesan)
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(1, 5), (1, 24), (1, 9), (1, 13), (1, 1), (1, 3), (1, 17);

-- Gorgonzola (Base Tomate, Gorgonzola, Cresson, Ail, Champignon, Parmesan)
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(2, 5), (2, 11), (2, 9), (2, 1), (2, 7), (2, 17);

-- Raclaccia (Base Tomate, Raclette, Cresson, Ail, Champignon, Parmesan)
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(3, 5), (3, 21), (3, 9), (3, 1), (3, 7), (3, 17);

-- Emmental (Base Crème, Emmental, Cresson, Champignon, Parmesan)
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(4, 6), (4, 10), (4, 9), (4, 7), (4, 17);

-- Tradizione (Base Tomate, Mozzarella, Olive, Jambon cuit, Champignon)
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(5, 5), (5, 24), (5, 16), (5, 12), (5, 7);

-- Hawaienne (Base Tomate, Mozzarella, Ananas, Bacon) - Pas de champignon
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(6, 5), (6, 24), (6, 2), (6, 4);

-- Américaine (Base Tomate, Mozzarella, Bacon, Pomme de terre) - Pas de champignon
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(7, 5), (7, 24), (7, 4), (7, 20);

-- Paysanne (Base Crème, Chevre, Miel, Jambon fumé) - Pas de champignon
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(8, 6), (8, 8), (8, 25), (8, 13);

-- -------------------------------------------------------------------------
-- 6. Insertion des Menus & Clients (Données fictives pour tester)
-- -------------------------------------------------------------------------
INSERT INTO menu (nom, prix, id_focaccia, id_boisson) VALUES 
('Menu Etudiant', 16.00, 3, 1), -- Raclaccia + Coca Zero
('Menu Duo', 20.00, 1, 12);     -- Mozzaccia + Eau

INSERT INTO client (nom, age, email) VALUES 
('Dupont Pierre', 22, 'pierre.dupont@email.fr'),
('Martin Sophie', 30, 'sophie.martin@email.fr');

INSERT INTO achete (id_client, id_menu, jour) VALUES 
(1, 1, '2023-10-01'),
(1, 2, '2023-10-05'),
(2, 1, '2023-10-02');