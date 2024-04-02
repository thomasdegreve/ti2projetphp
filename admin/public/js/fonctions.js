$(document).ready(function(){
    $('#texte_bouton_submit').text("Ajouter");

    $('#texte_bouton_submit').click(function(e){ //e = formulaire
        e.preventDefault(); //empêcher l'attribut action de form
        let email = $('#email').val();
        let nom = $('#nom').val();
        let prenom = $('#prenom').val();
        let adresse = $('#adresse').val();
        let numero = $('#numero').val();
        let param = 'email='+email+'&nom='+nom+'&prenom='+prenom+'&adresse='+adresse+'&numero='+numero;
        let retour = $.ajax({
            type: 'get',
            dataType: 'json',
            data: param,
            url: './src/php/ajax/ajaxAjoutClient.php',
            success: function(data){//data = retour du # php
                console.log(data);
            }
        })
    })

    $('#email').blur(function(){
        let email = $(this).val();
        console.log("email : "+email);
        let parametre = 'email='+email;
        let retour = $.ajax({
            type: 'get',
            dataType: 'json',
            data: parametre,
            url: './src/php/ajax/ajaxRechercheClient.php',
            success: function(data){//data = retour du # php
                console.log(data);
                $('#nom').val(data[0].nom_client);
                $('#prenom').val(data[0].prenom_client);
                $('#adresse').val(data[0].adresse);
                $('#numero').val(data[0].numero);
                $('#texte_bouton_submit').text("Modifier");
            }
        })
    })
























    $('#vie').hide();
    $('#para1').hide();
    $('#deuxieme').hide();
    $('#troisieme').hide();
    $('#quatrieme').hide();
    $('#cinquieme').hide();
    $('#cacher').hide();
    $('#montrer_image').hide();

    $('h1').click(function(){
        $('#vie').show();
        $(this).css('color','red');
    })

    $('#vie').mouseover(function(){
        $(this).css({
            'font-weight' : 'bold',
            'font-style' : 'italic',
            'color' : '#0044AA'
        });
        $(this).mouseout(function(){
            $('#para1').show();
        })
    })

    $('#para1').click(function(){
        $('#deuxieme').slideDown('slow');
    })

    $('#para2').click(function(){
        $('#troisieme').fadeIn('slow');
    })

    $('#para3').click(function(){
        $('#quatrieme').fadeIn('fast');
    })

    $('#quatrieme').click(function(){
        $('#cinquieme').fadeIn(5000);
        $('#cacher').show();
    })

    $('#cacher').click(function(){
        $('#montrer_image').fadeIn(2000);
    })

});