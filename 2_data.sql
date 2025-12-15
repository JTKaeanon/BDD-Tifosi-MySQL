-- -------------------------------------------------------------------------
-- Script de peuplement de la base de données 'tifosi'
-- Fichier : 2_data.sql
-- -------------------------------------------------------------------------
USE tifosi;

-- Désactiver temporairement la vérification des clés étrangères
SET FOREIGN_KEY_CHECKS = 0;

-- Vider les tables pour repartir à zéro
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
-- 1. Insertion des Marques (Source : marque.csv)
-- -------------------------------------------------------------------------
INSERT INTO marque (id_marque, nom) VALUES 
(1, 'Coca-cola'), 
(2, 'Cristalline'), 
(3, 'Monster'), 
(4, 'Pepsico');

-- -------------------------------------------------------------------------
-- 2. Insertion des Ingrédients (Source : ingredient.csv)
-- -------------------------------------------------------------------------
INSERT INTO ingredient (id_ingredient, nom) VALUES 
(1, 'Ail'), (2, 'Ananas'), (3, 'Artichaut'), (4, 'Bacon'), (5, 'Base Tomate'), 
(6, 'Base crème'), (7, 'Champignon'), (8, 'Chevre'), (9, 'Cresson'), (10, 'Emmental'), 
(11, 'Gorgonzola'), (12, 'Jambon cuit'), (13, 'Jambon fumé'), (14, 'Oeuf'), (15, 'Oignon'), 
(16, 'Olive noire'), (17, 'Olive verte'), (18, 'Parmesan'), (19, 'Piment'), (20, 'Poivre'), 
(21, 'Pomme de terre'), (22, 'Raclette'), (23, 'Salami'), (24, 'Tomate cerise'), (25, 'Mozarella');

-- -------------------------------------------------------------------------
-- 3. Insertion des Focaccias (Source : focaccia.csv)
-- -------------------------------------------------------------------------
INSERT INTO focaccia (id_focaccia, nom, prix) VALUES 
(1, 'Mozaccia', 9.80), 
(2, 'Gorgonzollaccia', 10.80), 
(3, 'Raclaccia', 8.90), 
(4, 'Emmentalaccia', 9.80), 
(5, 'Tradizione', 8.90), 
(6, 'Hawaienne', 11.20), 
(7, 'Américaine', 10.80), 
(8, 'Paysanne', 12.80);

-- -------------------------------------------------------------------------
-- 4. Insertion des Boissons (Source : boisson.csv)
-- -------------------------------------------------------------------------
INSERT INTO boisson (id_boisson, nom, id_marque) VALUES 
(1, 'Coca-cola zéro', 1), 
(2, 'Coca-cola original', 1), 
(3, 'Fanta citron', 1), 
(4, 'Fanta orange', 1), 
(5, 'Capri-sun', 1), 
(6, 'Pepsi', 4), 
(7, 'Pepsi Max Zéro', 4), 
(8, 'Lipton zéro citron', 4), 
(9, 'Lipton Peach', 4), 
(10, 'Monster energy ultra gold', 3), 
(11, 'Monster energy ultra blue', 3), 
(12, 'Eau de source ', 2);

-- -------------------------------------------------------------------------
-- 5. Insertion des Compositions (Table comprend)
-- Reconstitué d'après focaccia.csv (colonne ingrédients)
-- -------------------------------------------------------------------------

-- 1. Mozaccia : Base tomate, Mozarella, cresson, jambon fumé, ail, artichaut, champignon, parmesan, poivre, olive noire
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(1, 5), (1, 25), (1, 9), (1, 13), (1, 1), (1, 3), (1, 7), (1, 18), (1, 20), (1, 16);

-- 2. Gorgonzollaccia : Base tomate, Gorgonzola, cresson, ail, champignon, parmesan, poivre, olive noire
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(2, 5), (2, 11), (2, 9), (2, 1), (2, 7), (2, 18), (2, 20), (2, 16);

-- 3. Raclaccia : Base tomate, raclette, cresson, ail, champignon, parmesan, poivre
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(3, 5), (3, 22), (3, 9), (3, 1), (3, 7), (3, 18), (3, 20);

-- 4. Emmentalaccia : Base crème, Emmental, cresson, champignon, parmesan, poivre, oignon
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(4, 6), (4, 10), (4, 9), (4, 7), (4, 18), (4, 20), (4, 15);

-- 5. Tradizione : Base tomate, Mozarella, cresson, jambon cuit, champignon, parmesan, poivre, olive noire, olive verte
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(5, 5), (5, 25), (5, 9), (5, 12), (5, 7), (5, 18), (5, 20), (5, 16), (5, 17);

-- 6. Hawaienne : Base tomate, Mozarella, cresson, bacon, ananas, piment, parmesan, poivre, olive noire
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(6, 5), (6, 25), (6, 9), (6, 4), (6, 2), (6, 19), (6, 18), (6, 20), (6, 16);

-- 7. Américaine : Base tomate, Mozarella, cresson, bacon, pomme de terre, parmesan, poivre, olive noire
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(7, 5), (7, 25), (7, 9), (7, 4), (7, 21), (7, 18), (7, 20), (7, 16);

-- 8. Paysanne : Base crème, Chèvre, cresson, pomme de terre, jambon fumé, ail, artichaut, champignon, parmesan, poivre, olive noire, œuf
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(8, 6), (8, 8), (8, 9), (8, 21), (8, 13), (8, 1), (8, 3), (8, 7), (8, 18), (8, 20), (8, 16), (8, 14);

-- -------------------------------------------------------------------------
-- 6. Données de test supplémentaires (Menus & Clients)
-- -------------------------------------------------------------------------
INSERT INTO menu (nom, prix, id_focaccia, id_boisson) VALUES 
('Menu Etudiant', 16.00, 3, 1), 
('Menu Duo', 20.00, 1, 12);

INSERT INTO client (nom, age, email) VALUES 
('Dupont Pierre', 22, 'pierre.dupont@email.fr'),
('Martin Sophie', 30, 'sophie.martin@email.fr');

INSERT INTO achete (id_client, id_menu, jour) VALUES 
(1, 1, '2023-10-01'),
(1, 2, '2023-10-05'),
(2, 1, '2023-10-02');