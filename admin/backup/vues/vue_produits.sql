CREATE VIEW vue_produits AS
SELECT 
    p.id AS id_produit,
    p.nom_prod AS nom_produit,
    p.marque AS marque_produit,
	p.taille AS taille_prod,
    p.prix AS prix_produit,
	p.stock AS stock_prod,
    c.nom_cat AS nom_categorie
FROM 
    produit p
JOIN 
    catégorie c ON p.catégorie_id = c.id_cat;
 
