USE tifosi;

SET FOREIGN_KEY_CHECKS = 0;

-- Reset
TRUNCATE TABLE achete;
TRUNCATE TABLE comprend;
TRUNCATE TABLE menu;
TRUNCATE TABLE boisson;
TRUNCATE TABLE focaccia;
TRUNCATE TABLE ingredient;
TRUNCATE TABLE marque;
TRUNCATE TABLE client;

SET FOREIGN_KEY_CHECKS = 1;

-- Brands

INSERT INTO marque (id_marque, nom) VALUES 
(1, 'Coca-cola'), (2, 'Cristalline'), (3, 'Monster'), (4, 'Pepsico');


-- Ingredients

INSERT INTO ingredient (id_ingredient, nom) VALUES 
(1, 'Ail'), (2, 'Ananas'), (3, 'Artichaut'), (4, 'Bacon'), (5, 'Base Tomate'), 
(6, 'Base crème'), (7, 'Champignon'), (8, 'Chevre'), (9, 'Cresson'), (10, 'Emmental'), 
(11, 'Gorgonzola'), (12, 'Jambon cuit'), (13, 'Jambon fumé'), (14, 'Oeuf'), (15, 'Oignon'), 
(16, 'Olive noire'), (17, 'Olive verte'), (18, 'Parmesan'), (19, 'Piment'), (20, 'Poivre'), 
(21, 'Pomme de terre'), (22, 'Raclette'), (23, 'Salami'), (24, 'Tomate cerise'), (25, 'Mozarella');


-- Focaccias

INSERT INTO focaccia (id_focaccia, nom, prix) VALUES 
(1, 'Mozaccia', 9.80), (2, 'Gorgonzollaccia', 10.80), (3, 'Raclaccia', 8.90), (4, 'Emmentalaccia', 9.80), 
(5, 'Tradizione', 8.90), (6, 'Hawaienne', 11.20), (7, 'Américaine', 10.80), (8, 'Paysanne', 12.80);


-- Drinks

INSERT INTO boisson (id_boisson, nom, id_marque) VALUES 
(1, 'Coca-cola zéro', 1), (2, 'Coca-cola original', 1), (3, 'Fanta citron', 1), (4, 'Fanta orange', 1), 
(5, 'Capri-sun', 1), (6, 'Pepsi', 4), (7, 'Pepsi Max Zéro', 4), (8, 'Lipton zéro citron', 4), 
(9, 'Lipton Peach', 4), (10, 'Monster energy ultra gold', 3), (11, 'Monster energy ultra blue', 3), 
(12, 'Eau de source ', 2);


-- Recipe details (Focaccia - Ingredients)


-- Mozaccia (Tomato base, Mozzarella, Smoked ham, etc.)
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(1, 5), (1, 25), (1, 9), (1, 13), (1, 1), (1, 3), (1, 7), (1, 18), (1, 20), (1, 16);

-- Gorgonzollaccia
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(2, 5), (2, 11), (2, 9), (2, 1), (2, 7), (2, 18), (2, 20), (2, 16);

-- Raclaccia
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(3, 5), (3, 22), (3, 9), (3, 1), (3, 7), (3, 18), (3, 20);

-- Emmentalaccia
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(4, 6), (4, 10), (4, 9), (4, 7), (4, 18), (4, 20), (4, 15);

-- Tradizione
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(5, 5), (5, 25), (5, 9), (5, 12), (5, 7), (5, 18), (5, 20), (5, 16), (5, 17);

-- Hawaienne
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(6, 5), (6, 25), (6, 9), (6, 4), (6, 2), (6, 19), (6, 18), (6, 20), (6, 16);

-- Américaine
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(7, 5), (7, 25), (7, 9), (7, 4), (7, 21), (7, 18), (7, 20), (7, 16);

-- Paysanne
INSERT INTO comprend (id_focaccia, id_ingredient) VALUES 
(8, 6), (8, 8), (8, 9), (8, 21), (8, 13), (8, 1), (8, 3), (8, 7), (8, 18), (8, 20), (8, 16), (8, 14);
