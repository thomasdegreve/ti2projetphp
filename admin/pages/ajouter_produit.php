<h2>Ajouter un Produit</h2>
<div class="container">
    <form id="form_ajout_prod" method="post" action="">
        <div class="mb-3">
            <label for="nom_prod" class="form-label">Nom du Produit</label>
            <input type="text" class="form-control" id="nom_prod" name="nom_prod">
        </div>
        <div class="mb-3">
            <label for="marque" class="form-label">Marque</label>
            <input type="text" class="form-control" id="marque" name="marque">
        </div>
        <div class="mb-3">
            <label for="taille" class="form-label">Taille</label>
            <input type="text" class="form-control" id="taille" name="taille">
        </div>
        <div class="mb-3">
            <label for="prix" class="form-label">Prix</label>
            <input type="text" class="form-control" id="prix" name="prix">
        </div>
        <div class="mb-3">
            <label for="stock" class="form-label">Stock</label>
            <input type="text" class="form-control" id="stock" name="stock">
        </div>
        <div class="mb-3">
            <label for="categorie_id" class="form-label">ID de Catégorie</label>
            <input type="text" class="form-control" id="categorie_id" name="categorie_id">
        </div>
        <div class="mb-3">
            <label for="image" class="form-label">URL de l'image</label>
            <input type="text" class="form-control" id="image" name="image">
        </div>
        <button type="submit" id="texte_bouton_prod" class="btn btn-primary">
            Ajouter Produit
        </button>
        <button class="btn btn-primary" type="reset" id="reset_produit">Annuler</button>
    </form>
</div>
