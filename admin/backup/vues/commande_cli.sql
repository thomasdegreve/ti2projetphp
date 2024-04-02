CREATE VIEW Vue_Commandes_Client AS
SELECT Commande.ID AS ID_Commande, Commande.Date, Commande.Statut, Produit.Nom AS Nom_Produit, Produit.Prix, Client.Nom AS Nom_Client, Client.Prénom AS Prénom_Client
FROM Commande
JOIN Produit ON Commande.Produit_ID = Produit.ID
JOIN Client ON Commande.Client_ID = Client.ID;
