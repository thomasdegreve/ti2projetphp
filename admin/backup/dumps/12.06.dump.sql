PGDMP  +    :                |           projetBD    16.2    16.2 ?    :           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ;           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            <           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            =           1262    16590    projetBD    DATABASE     ~   CREATE DATABASE "projetBD" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'French_Belgium.1252';
    DROP DATABASE "projetBD";
                anonyme    false            �            1255    16699 0   ajout_client(text, text, text, text, text, text)    FUNCTION     >  CREATE FUNCTION public.ajout_client(text, text, text, text, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS '
  declare p_nom alias for $1;
  declare p_prenom alias for $2;
  declare p_adresse alias for $3;
  declare p_email alias for $4;
  declare p_tel alias for $5;
  declare p_pwd alias for $6;
  declare id integer;
  declare retour integer;
  
begin
	select into id id_c from client where emailcl = p_email;
	if not found
	then
	  insert into client (nom,prenom,adresse,emailcl,telephone,password) values
	    (p_nom,p_prenom,p_adresse,p_email,p_tel,p_pwd);
	  select into id id_c from client where emailcl = p_email;
	  if not found
	  then	
	    retour = -1;  --échec de la requête
	  else
	    retour = 1;   -- insertion ok
	  end if;
	else
	  retour = 0;      -- déjà en BD
	end if;
 return retour;
 end;
';
 G   DROP FUNCTION public.ajout_client(text, text, text, text, text, text);
       public          anonyme    false            �            1255    16716 @   ajout_produit(text, text, text, numeric, integer, integer, text)    FUNCTION     �  CREATE FUNCTION public.ajout_produit(p_nom_prod text, p_marque text, p_taille text, p_prix numeric, p_stock integer, p_categorie_id integer, p_image text) RETURNS integer
    LANGUAGE plpgsql
    AS '
DECLARE
    id INTEGER;
    retour INTEGER;
BEGIN
    -- Vérifier si le produit existe déjà
    SELECT id_p INTO id FROM produit WHERE nom_prod = p_nom_prod AND marque = p_marque AND taille = p_taille;

    IF NOT FOUND THEN
        -- Si le produit n''existe pas, insérer le nouveau produit dans la table
        INSERT INTO produit (nom_prod, marque, taille, prix, stock, categorie_id, image)
        VALUES (p_nom_prod, p_marque, p_taille, p_prix, p_stock, p_categorie_id, p_image)
        RETURNING id_p INTO id;

        -- Vérifier si l''insertion a réussi
        IF NOT FOUND THEN
            retour := -1; -- échec de la requête
        ELSE
            retour := 1;  -- insertion réussie
        END IF;
    ELSE
        retour := 0;  -- déjà en BD
    END IF;

    RETURN retour;
END;
';
 �   DROP FUNCTION public.ajout_produit(p_nom_prod text, p_marque text, p_taille text, p_prix numeric, p_stock integer, p_categorie_id integer, p_image text);
       public          anonyme    false            �            1255    16747    delete_client(integer)    FUNCTION       CREATE FUNCTION public.delete_client(integer) RETURNS integer
    LANGUAGE plpgsql
    AS '
	declare p_id alias for $1;
	declare retour integer;
	-- declare id integer;

BEGIN
    delete from client where id_client = p_id;
	-- vérifier le delete
    RETURN 1;
END;
';
 -   DROP FUNCTION public.delete_client(integer);
       public          anonyme    false            �            1255    16748    deleteclient(integer)    FUNCTION     �   CREATE FUNCTION public.deleteclient(id integer) RETURNS void
    LANGUAGE plpgsql
    AS '
BEGIN
    DELETE FROM client WHERE id_c = id;
END;
';
 /   DROP FUNCTION public.deleteclient(id integer);
       public          anonyme    false            �            1255    16700 !   updateClient(integer, text, text)    FUNCTION     $  CREATE FUNCTION public."updateClient"(integer, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS '
	declare p_id alias for $1;
	declare p_champ alias for $2;
	declare p_valeur alias for $3;
BEGIN
    EXECUTE format(''UPDATE client SET %I = %L WHERE id = %L'', p_champ, p_valeur, p_id);
    -- execute format : utilisé lorsque les champs sont dynamiques
    -- %I : remplace le champ colonne, de manière sécurisée (échappement pour éviter les injections sql)
    -- %I : remplace la valeur, de manière sécurisée
    RETURN 1;
END;
';
 :   DROP FUNCTION public."updateClient"(integer, text, text);
       public          anonyme    false            �            1255    16744 "   update_client(integer, text, text)    FUNCTION     *  CREATE FUNCTION public.update_client(integer, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS '
	declare p_id alias for $1;
	declare p_champ alias for $2;
	declare p_valeur alias for $3;
BEGIN
    EXECUTE format(''UPDATE client SET %I = %L WHERE id_client = %L'', p_champ, p_valeur, p_id);
    -- execute format : utilisé lorsque les champs sont dynamiques
    -- %I : remplace le champ colonne, de manière sécurisée (échappement pour éviter les injections sql)
    -- %I : remplace la valeur, de manière sécurisée
    RETURN 1;
END;
';
 9   DROP FUNCTION public.update_client(integer, text, text);
       public          anonyme    false            �            1255    16689    verifier_admin(text, text)    FUNCTION     �  CREATE FUNCTION public.verifier_admin(text, text) RETURNS integer
    LANGUAGE plpgsql
    AS '
	declare p_login alias for $1;
	declare p_password alias for $2;
	declare id integer;
	declare retour integer;
	
begin
	select into id id_admin from admin where login=p_login and password = p_password;
	if not found 
	then
	  retour = 0;
	else
	  retour =1;
	end if;  
	return retour;
end;
';
 1   DROP FUNCTION public.verifier_admin(text, text);
       public          anonyme    false            �            1259    16681    admin    TABLE     �   CREATE TABLE public.admin (
    id_admin integer NOT NULL,
    login character varying(100) NOT NULL,
    password character varying(255) NOT NULL
);
    DROP TABLE public.admin;
       public         heap    anonyme    false            �            1259    16680    admin_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.admin_id_seq;
       public          anonyme    false    226            >           0    0    admin_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.admin_id_seq OWNED BY public.admin.id_admin;
          public          anonyme    false    225            �            1259    16606 
   catégorie    TABLE     z   CREATE TABLE public."catégorie" (
    id_cat integer NOT NULL,
    nom_cat name NOT NULL COLLATE pg_catalog."default"
);
     DROP TABLE public."catégorie";
       public         heap    anonyme    false            �            1259    16605    catégorie_id_seq    SEQUENCE     �   CREATE SEQUENCE public."catégorie_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."catégorie_id_seq";
       public          anonyme    false    216            ?           0    0    catégorie_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."catégorie_id_seq" OWNED BY public."catégorie".id_cat;
          public          anonyme    false    215            �            1259    16625    client    TABLE       CREATE TABLE public.client (
    id_c integer NOT NULL,
    nom character varying(100) NOT NULL,
    prenom character varying(100) NOT NULL,
    adresse character varying(255),
    emailcl character varying(100),
    telephone character varying(20),
    password text
);
    DROP TABLE public.client;
       public         heap    anonyme    false            �            1259    16624    client_id_seq    SEQUENCE     �   CREATE SEQUENCE public.client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.client_id_seq;
       public          anonyme    false    220            @           0    0    client_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id_c;
          public          anonyme    false    219            �            1259    16634    commande    TABLE     �   CREATE TABLE public.commande (
    id integer NOT NULL,
    date date,
    statut character varying(50),
    client_id integer,
    produit_id integer
);
    DROP TABLE public.commande;
       public         heap    anonyme    false            �            1259    16633    commande_id_seq    SEQUENCE     �   CREATE SEQUENCE public.commande_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.commande_id_seq;
       public          anonyme    false    222            A           0    0    commande_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.commande_id_seq OWNED BY public.commande.id;
          public          anonyme    false    221            �            1259    16646    panier    TABLE     �   CREATE TABLE public.panier (
    id integer NOT NULL,
    client_id integer,
    total numeric(10,2),
    produit_id integer
);
    DROP TABLE public.panier;
       public         heap    anonyme    false            �            1259    16645    panier_id_seq    SEQUENCE     �   CREATE SEQUENCE public.panier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.panier_id_seq;
       public          anonyme    false    224            B           0    0    panier_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.panier_id_seq OWNED BY public.panier.id;
          public          anonyme    false    223            �            1259    16613    produit    TABLE       CREATE TABLE public.produit (
    id_p integer NOT NULL,
    nom_prod character varying(100) NOT NULL,
    marque character varying(100),
    taille character varying(20),
    prix numeric(10,2),
    stock integer,
    categorie_id integer,
    image text
);
    DROP TABLE public.produit;
       public         heap    anonyme    false            �            1259    16612    produit_id_seq    SEQUENCE     �   CREATE SEQUENCE public.produit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.produit_id_seq;
       public          anonyme    false    218            C           0    0    produit_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.produit_id_seq OWNED BY public.produit.id_p;
          public          anonyme    false    217            �            1259    16712    vue_commande    VIEW       CREATE VIEW public.vue_commande AS
 SELECT c.date,
    c.statut,
    cl.nom AS nom_client,
    p.nom_prod AS nom_produit
   FROM ((public.commande c
     JOIN public.client cl ON ((c.client_id = cl.id_c)))
     JOIN public.produit p ON ((c.produit_id = p.id_p)));
    DROP VIEW public.vue_commande;
       public          anonyme    false    222    222    222    222    220    220    218    218            �            1259    16708    vue_commandes    VIEW       CREATE VIEW public.vue_commandes AS
 SELECT c.date,
    c.statut,
    cl.id_c AS id_client,
    p.id_p AS id_produit
   FROM ((public.commande c
     JOIN public.client cl ON ((c.client_id = cl.id_c)))
     JOIN public.produit p ON ((c.produit_id = p.id_p)));
     DROP VIEW public.vue_commandes;
       public          anonyme    false    222    220    218    222    222    222            �            1259    16694    vue_produits    VIEW     P  CREATE VIEW public.vue_produits AS
 SELECT p.id_p AS id_produit,
    p.nom_prod AS nom_produit,
    p.marque AS marque_produit,
    p.taille AS taille_prod,
    p.prix AS prix_produit,
    p.stock AS stock_prod,
    c.nom_cat AS nom_categorie
   FROM (public.produit p
     JOIN public."catégorie" c ON ((p.categorie_id = c.id_cat)));
    DROP VIEW public.vue_produits;
       public          anonyme    false    218    218    218    218    218    216    216    218    218            �            1259    16717    vueproduitcategorie    VIEW     5  CREATE VIEW public.vueproduitcategorie AS
 SELECT p.id_p AS id,
    p.nom_prod,
    p.marque,
    p.taille,
    p.prix,
    p.stock,
    p.categorie_id AS "catégorie_id",
    p.image,
    c.nom_cat AS nom_categorie
   FROM (public.produit p
     JOIN public."catégorie" c ON ((p.categorie_id = c.id_cat)));
 &   DROP VIEW public.vueproduitcategorie;
       public          anonyme    false    218    216    218    216    218    218    218    218    218    218            �           2604    16684    admin id_admin    DEFAULT     j   ALTER TABLE ONLY public.admin ALTER COLUMN id_admin SET DEFAULT nextval('public.admin_id_seq'::regclass);
 =   ALTER TABLE public.admin ALTER COLUMN id_admin DROP DEFAULT;
       public          anonyme    false    225    226    226            �           2604    16609    catégorie id_cat    DEFAULT     v   ALTER TABLE ONLY public."catégorie" ALTER COLUMN id_cat SET DEFAULT nextval('public."catégorie_id_seq"'::regclass);
 B   ALTER TABLE public."catégorie" ALTER COLUMN id_cat DROP DEFAULT;
       public          anonyme    false    216    215    216            �           2604    16628    client id_c    DEFAULT     h   ALTER TABLE ONLY public.client ALTER COLUMN id_c SET DEFAULT nextval('public.client_id_seq'::regclass);
 :   ALTER TABLE public.client ALTER COLUMN id_c DROP DEFAULT;
       public          anonyme    false    220    219    220            �           2604    16637    commande id    DEFAULT     j   ALTER TABLE ONLY public.commande ALTER COLUMN id SET DEFAULT nextval('public.commande_id_seq'::regclass);
 :   ALTER TABLE public.commande ALTER COLUMN id DROP DEFAULT;
       public          anonyme    false    221    222    222            �           2604    16649 	   panier id    DEFAULT     f   ALTER TABLE ONLY public.panier ALTER COLUMN id SET DEFAULT nextval('public.panier_id_seq'::regclass);
 8   ALTER TABLE public.panier ALTER COLUMN id DROP DEFAULT;
       public          anonyme    false    224    223    224            �           2604    16616    produit id_p    DEFAULT     j   ALTER TABLE ONLY public.produit ALTER COLUMN id_p SET DEFAULT nextval('public.produit_id_seq'::regclass);
 ;   ALTER TABLE public.produit ALTER COLUMN id_p DROP DEFAULT;
       public          anonyme    false    217    218    218            7          0    16681    admin 
   TABLE DATA                 public          anonyme    false    226   @T       -          0    16606 
   catégorie 
   TABLE DATA                 public          anonyme    false    216   �T       1          0    16625    client 
   TABLE DATA                 public          anonyme    false    220   lU       3          0    16634    commande 
   TABLE DATA                 public          anonyme    false    222   �V       5          0    16646    panier 
   TABLE DATA                 public          anonyme    false    224   YW       /          0    16613    produit 
   TABLE DATA                 public          anonyme    false    218   �W       D           0    0    admin_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.admin_id_seq', 6, true);
          public          anonyme    false    225            E           0    0    catégorie_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."catégorie_id_seq"', 4, true);
          public          anonyme    false    215            F           0    0    client_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.client_id_seq', 5, true);
          public          anonyme    false    219            G           0    0    commande_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.commande_id_seq', 2, true);
          public          anonyme    false    221            H           0    0    panier_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.panier_id_seq', 2, true);
          public          anonyme    false    223            I           0    0    produit_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.produit_id_seq', 16, true);
          public          anonyme    false    217            �           2606    16688    admin admin_login_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_login_key UNIQUE (login);
 ?   ALTER TABLE ONLY public.admin DROP CONSTRAINT admin_login_key;
       public            anonyme    false    226            �           2606    16686    admin admin_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id_admin);
 :   ALTER TABLE ONLY public.admin DROP CONSTRAINT admin_pkey;
       public            anonyme    false    226            �           2606    16611    catégorie catégorie_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."catégorie"
    ADD CONSTRAINT "catégorie_pkey" PRIMARY KEY (id_cat);
 H   ALTER TABLE ONLY public."catégorie" DROP CONSTRAINT "catégorie_pkey";
       public            anonyme    false    216            �           2606    16632    client client_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_c);
 <   ALTER TABLE ONLY public.client DROP CONSTRAINT client_pkey;
       public            anonyme    false    220            �           2606    16639    commande commande_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.commande DROP CONSTRAINT commande_pkey;
       public            anonyme    false    222            �           2606    16651    panier panier_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.panier
    ADD CONSTRAINT panier_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.panier DROP CONSTRAINT panier_pkey;
       public            anonyme    false    224            �           2606    16618    produit produit_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.produit
    ADD CONSTRAINT produit_pkey PRIMARY KEY (id_p);
 >   ALTER TABLE ONLY public.produit DROP CONSTRAINT produit_pkey;
       public            anonyme    false    218            �           2606    16640     commande commande_client_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(id_c);
 J   ALTER TABLE ONLY public.commande DROP CONSTRAINT commande_client_id_fkey;
       public          anonyme    false    4747    222    220            �           2606    16661    commande fk_commande_produit    FK CONSTRAINT     �   ALTER TABLE ONLY public.commande
    ADD CONSTRAINT fk_commande_produit FOREIGN KEY (produit_id) REFERENCES public.produit(id_p);
 F   ALTER TABLE ONLY public.commande DROP CONSTRAINT fk_commande_produit;
       public          anonyme    false    222    218    4745            �           2606    16671    panier fk_panier_produit    FK CONSTRAINT     ~   ALTER TABLE ONLY public.panier
    ADD CONSTRAINT fk_panier_produit FOREIGN KEY (produit_id) REFERENCES public.produit(id_p);
 B   ALTER TABLE ONLY public.panier DROP CONSTRAINT fk_panier_produit;
       public          anonyme    false    4745    218    224            �           2606    16652    panier panier_client_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.panier
    ADD CONSTRAINT panier_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(id_c);
 F   ALTER TABLE ONLY public.panier DROP CONSTRAINT panier_client_id_fkey;
       public          anonyme    false    4747    220    224            �           2606    16619 "   produit produit_catégorie_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.produit
    ADD CONSTRAINT "produit_catégorie_id_fkey" FOREIGN KEY (categorie_id) REFERENCES public."catégorie"(id_cat);
 N   ALTER TABLE ONLY public.produit DROP CONSTRAINT "produit_catégorie_id_fkey";
       public          anonyme    false    218    4743    216            7   �   x���v
Q���W((M��L�KL���S��L��tr��ATAbqqy~Q��B��O�k�������O~if�:��i��I��F@�2S��R�,J5嚛���)5�h�S~�:���8S�9nE�)�0�R̀�&e�� �� e��*      -   y   x���v
Q���W((M��L�SJN,9�2=�(3UIA#3%��Q���14�}B]�4u�}3sr�K��5��<�6�hRpF~���q�H,-..-J��,�Y��ɩ����Pø� p�`1      1   ?  x����n�0��<�o����/��8�:&�u�Bc�Ti5���{�%b�;;�q��{����[X��o�O)��������E��t�!2ޠ1�L�B�`Q�.I��f�|R�;����ڽ���&e#�-�){i�'� �����0+HŰR��TN���:�/Vk�IA����l0�'���y穵x���}e��~C���A��*X1�\:Ls��eR��{��h8��i��O.����T+��	'�g�9�����;�j���M��q?<r[R͌τR��"��85����l�f|�U��J�V�g���      3   �   x���v
Q���W((M��L�K���M�KIU��L�QHI,I�Q(.I,)-�QH��L�+�I委f�ؚ
a�>���
�:
�FF&�ƺƆ�@�k�BbI	PO*��6״�򤪝F�v���(8�2%��J��@iK��\\ T~F�      5   i   x���v
Q���W((M��L�+H��L-R��L�QH��L�+�1K�Kst
��SJ3AB�
a�>���
�:
 db�gi�����i��I��t��� �d.. K�6      /   �  x����n�0E�|�� )���Ă*�U�F&v�@�ԎQ��'����*��ce���x�YN�0/��՞ǭL
�yN�̂T$�Y� !�S3r��{3ɿ,P��w�$gk!9�8���fMx��i�����9�	�fu\�tB�8��x-ϳ���`�5B��KC�BL��R �F������SmV������ic{D9%��|v	0|��
���]�&:-��R&a$���1�NA�=@�5:�b8hi,�RDR�����M�`��Hq9R���Q-�Oj�u�.�!s�>�gE��L0S�,��4�;4�E�@��?Js������Mz�R��S�hi�!Z)-�:�|W��F��qx$q�I|��RL�ƹs9U���b��1 syWd���\��=]bz8��[�����2��V���@R     