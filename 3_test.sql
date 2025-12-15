USE tifosi;

-- 1. Afficher la liste des noms des focaccias par ordre alphabétique croissant
SELECT nom 
FROM focaccia 
ORDER BY nom ASC;

-- 2. Afficher le nombre total d'ingrédients
SELECT COUNT(*) AS nombre_total_ingredients 
FROM ingredient;

-- 3. Afficher le prix moyen des focaccias
SELECT AVG(prix) AS prix_moyen 
FROM focaccia;

-- 4. Afficher la liste des boissons avec leur marque, triée par nom de boisson
SELECT b.nom AS nom_boisson, m.nom AS nom_marque
FROM boisson b
JOIN marque m ON b.id_marque = m.id_marque
ORDER BY b.nom ASC;

-- 5. Afficher la liste des ingrédients pour une Raclaccia
SELECT i.nom AS nom_ingredient
FROM ingredient i
JOIN comprend c ON i.id_ingredient = c.id_ingredient
JOIN focaccia f ON c.id_focaccia = f.id_focaccia
WHERE f.nom = 'Raclaccia';

-- 6. Afficher le nom et le nombre d'ingrédients pour chaque foccacia
SELECT f.nom AS nom_focaccia, COUNT(c.id_ingredient) AS nombre_ingredients
FROM focaccia f
JOIN comprend c ON f.id_focaccia = c.id_focaccia
GROUP BY f.nom;

-- 7.  Afficher le nom de la focaccia qui a le plus d'ingrédients
SELECT f.nom AS nom_focaccia
FROM focaccia f
JOIN comprend c ON f.id_focaccia = c.id_focaccia
GROUP BY f.nom
ORDER BY COUNT(c.id_ingredient) DESC
LIMIT 1;

-- 8. Afficher la liste des focaccia qui contiennent de l'ail
SELECT f.nom AS nom_focaccia
FROM focaccia f
JOIN comprend c ON f.id_focaccia = c.id_focaccia
JOIN ingredient i ON c.id_ingredient = i.id_ingredient
WHERE i.nom = 'Ail';

-- 9. Afficher la liste des ingrédients inutilisés
SELECT nom AS ingredient_inutilise
FROM ingredient
WHERE id_ingredient NOT IN (SELECT id_ingredient FROM comprend);

-- 10. Afficher la liste des focaccia qui n'ont pas de champignons
-- sous-requête pour exclure les recettes contenant des champignons
SELECT nom AS focaccia_sans_champignon
FROM focaccia
WHERE id_focaccia NOT IN (
    SELECT c.id_focaccia
    FROM comprend c
    JOIN ingredient i ON c.id_ingredient = i.id_ingredient
    WHERE i.nom = 'Champignon'
);