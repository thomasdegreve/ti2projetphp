$(document).ready(function () {



    $("td[id]").click(function () {
        let valeur1 = $.trim($(this).text());
        let id = $(this).attr('id');
        let name = $(this).attr('name');
        console.log(valeur1 + " id = " + id + " name = " + name);
        $(this).blur(function () {
            let valeur2 = $.trim($(this).text());
            if (valeur1 !== valeur2) {
                let parametre = "id=" + id + "&name=" + name + "&valeur=" + valeur2;
                $.ajax({
                    type: 'get',
                    dataType: 'json',
                    data: parametre,
                    url: './src/php/ajax/ajaxUpdateClient.php',
                    success: function (data) {
                        console.log(data);
                    }
                });
            }
        });
    });

    $('#texte_bouton_submit').text("Ajouter");

    $('#reset').click(function () {
        $('#texte_bouton_submit').text("Ajouter");
    });
    $('#texte_bouton_submit').click(function (e) {
        e.preventDefault();
        let emailcl = $('#email').val();
        let nom = $('#nom').val();
        let prenom = $('#prenom').val(); // Correction ici
        let adresse = $('#adresse').val();
        let telephone = $('#telephone').val(); // Correction ici
        let password = $('#password').val();
        let param = 'emailcl=' + emailcl + '&nom=' + nom + '&prenom=' + prenom + '&adresse=' + adresse + '&telephone=' + telephone + '&password=' + password; // Correction ici
        $.ajax({

            type: 'get',
            dataType: 'json',
            data: param,
            url: './src/php/ajax/ajaxAjoutClient.php',
            success: function (data) {
                console.log(data);
            }
        });
    });
    $('#texte_bouton_prod').text("Ajouter");

    $('#reset_produit').click(function () {
        $('#texte_bouton_prod').text("Ajouter");
    });
    $('#texte_bouton_prod').click(function (e) {
        e.preventDefault();


        let nom_prod = $('#nom_prod').val();
        let marque = $('#marque').val();
        let taille = $('#taille').val();
        let prix = $('#prix').val();
        let stock = $('#stock').val();
        let categorie_id = $('#categorie_id').val();
        let image = $('#image').val();


        let param = 'nom_prod=' + nom_prod + '&marque=' + marque + '&taille=' + taille + '&prix=' + prix + '&stock=' + stock + '&categorie_id=' + categorie_id + '&image=' + image;


        $.ajax({
            type: 'get',
            dataType: 'json',
            data: param,
            url: './src/php/ajax/ajaxAjoutProduit.php',
            success: function (data) {
                console.log(data); // Afficher la réponse de la requête dans la console
                // Réinitialiser les champs du formulaire après l'ajout du produit
                $('#form_ajout_prod')[0].reset();
            }
        });
    });



    $('#email').blur(function () {
        let emailcl = $(this).val();
        console.log("email : " + emailcl);
        let parametre = 'emailcl=' + emailcl;
        $.ajax({
            type: 'get',
            dataType: 'json',
            data: parametre,
            url: './src/php/ajax/ajaxRechercheClient.php',
            success: function (data) {
                console.log(data);
                $('#nom').val(data[0].nom);
                $('#prenom').val(data[0].prenom);
                $('#adresse').val(data[0].adresse);
                $('#telephone').val(data[0].telephone);
                $('#texte_bouton_submit').text("Mettre à jour");
                let nom2 = $('#nom').val();
                if (nom2 === '') {
                    $('#texte_bouton_submit').text("Ajouter");
                }
            }
        });
    });

    $('#vie').hide();
    $('#para1').hide();
    $('#deuxieme').hide();
    $('#troisieme').hide();
    $('#quatrieme').hide();
    $('#cinquieme').hide();
    $('#cacher').hide();
    $('#montrer_image').hide();

    $('h1').click(function () {
        $('#vie').show();
        $(this).css('color', 'red');
    });

    $('#vie').mouseover(function () {
        $(this).css({
            'font-weight': 'bold',
            'font-style': 'italic',
            'color': '#0044AA'
        });
        $(this).mouseout(function () {
            $('#para1').show();
        });
    });

    $('#para1').click(function () {
        $('#deuxieme').slideDown('slow');
    });

    $('#para2').click(function () {
        $('#troisieme').fadeIn('slow');
    });

    $('#para3').click(function () {
        $('#quatrieme').fadeIn('fast');
    });

    $('#quatrieme').click(function () {
        $('#cinquieme').fadeIn(5000);
        $('#cacher').show();
    });

    $('#cacher').click(function () {
        $('#montrer_image').fadeIn(2000);
    });


});
