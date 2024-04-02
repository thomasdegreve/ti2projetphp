CREATE VIEW Vue_Produits AS
SELECT p.ID, p.Nom AS Nom_Produit, p.Marque, p.Taille, p.Prix, p.Stock, c.Nom AS Catégorie
FROM Produit p
JOIN Catégorie c ON p.Catégorie_ID = c.ID;
