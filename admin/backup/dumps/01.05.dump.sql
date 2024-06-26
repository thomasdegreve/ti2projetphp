PGDMP  :    +                |           projetBD    16.2    16.2 ;    ,           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            -           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            .           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            /           1262    16590    projetBD    DATABASE     ~   CREATE DATABASE "projetBD" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'French_Belgium.1252';
    DROP DATABASE "projetBD";
                anonyme    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            0           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1255    16699 0   ajout_client(text, text, text, text, text, text)    FUNCTION     =  CREATE FUNCTION public.ajout_client(text, text, text, text, text, text) RETURNS integer
    LANGUAGE plpgsql
    AS '
  declare p_nom alias for $1;
  declare p_prenom alias for $2;
  declare p_email alias for $3;
  declare p_adresse alias for $4;
  declare p_tel alias for $5;
  declare p_pwd alias for $6;
  declare id integer;
  declare retour integer;
  
begin
	select into id id from client where emailcl = p_email;
	if not found
	then
	  insert into client (nom,prénom,emailcl,adresse,téléphone,password) values
	    (p_nom,p_prenom,p_email,p_adresse,p_tel,p_pwd);
	  select into id id from client where emailcl = p_email;
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
       public          anonyme    false    4            �            1255    16700 "   update_client(integer, text, text)    FUNCTION     #  CREATE FUNCTION public.update_client(integer, text, text) RETURNS integer
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
 9   DROP FUNCTION public.update_client(integer, text, text);
       public          anonyme    false    4            �            1255    16689    verifier_admin(text, text)    FUNCTION     �  CREATE FUNCTION public.verifier_admin(text, text) RETURNS integer
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
       public          anonyme    false    4            �            1259    16681    admin    TABLE     �   CREATE TABLE public.admin (
    id_admin integer NOT NULL,
    login character varying(100) NOT NULL,
    password character varying(255) NOT NULL
);
    DROP TABLE public.admin;
       public         heap    anonyme    false    4            �            1259    16680    admin_id_seq    SEQUENCE     �   CREATE SEQUENCE public.admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.admin_id_seq;
       public          anonyme    false    226    4            1           0    0    admin_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.admin_id_seq OWNED BY public.admin.id_admin;
          public          anonyme    false    225            �            1259    16606 
   catégorie    TABLE     z   CREATE TABLE public."catégorie" (
    id_cat integer NOT NULL,
    nom_cat name NOT NULL COLLATE pg_catalog."default"
);
     DROP TABLE public."catégorie";
       public         heap    anonyme    false    4            �            1259    16605    catégorie_id_seq    SEQUENCE     �   CREATE SEQUENCE public."catégorie_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."catégorie_id_seq";
       public          anonyme    false    4    216            2           0    0    catégorie_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public."catégorie_id_seq" OWNED BY public."catégorie".id_cat;
          public          anonyme    false    215            �            1259    16625    client    TABLE       CREATE TABLE public.client (
    id integer NOT NULL,
    nom character varying(100) NOT NULL,
    "prénom" character varying(100) NOT NULL,
    adresse character varying(255),
    emailcl character varying(100),
    "téléphone" character varying(20),
    password "char"[]
);
    DROP TABLE public.client;
       public         heap    anonyme    false    4            �            1259    16624    client_id_seq    SEQUENCE     �   CREATE SEQUENCE public.client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.client_id_seq;
       public          anonyme    false    220    4            3           0    0    client_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id;
          public          anonyme    false    219            �            1259    16634    commande    TABLE     �   CREATE TABLE public.commande (
    id integer NOT NULL,
    date date,
    statut character varying(50),
    client_id integer,
    produit_id integer
);
    DROP TABLE public.commande;
       public         heap    anonyme    false    4            �            1259    16633    commande_id_seq    SEQUENCE     �   CREATE SEQUENCE public.commande_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.commande_id_seq;
       public          anonyme    false    222    4            4           0    0    commande_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.commande_id_seq OWNED BY public.commande.id;
          public          anonyme    false    221            �            1259    16646    panier    TABLE     �   CREATE TABLE public.panier (
    id integer NOT NULL,
    client_id integer,
    total numeric(10,2),
    produit_id integer
);
    DROP TABLE public.panier;
       public         heap    anonyme    false    4            �            1259    16645    panier_id_seq    SEQUENCE     �   CREATE SEQUENCE public.panier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.panier_id_seq;
       public          anonyme    false    4    224            5           0    0    panier_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.panier_id_seq OWNED BY public.panier.id;
          public          anonyme    false    223            �            1259    16613    produit    TABLE     �   CREATE TABLE public.produit (
    id integer NOT NULL,
    nom_prod character varying(100) NOT NULL,
    marque character varying(100),
    taille character varying(20),
    prix numeric(10,2),
    stock integer,
    "catégorie_id" integer
);
    DROP TABLE public.produit;
       public         heap    anonyme    false    4            �            1259    16612    produit_id_seq    SEQUENCE     �   CREATE SEQUENCE public.produit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.produit_id_seq;
       public          anonyme    false    4    218            6           0    0    produit_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.produit_id_seq OWNED BY public.produit.id;
          public          anonyme    false    217            �            1259    16694    vue_produits    VIEW     Q  CREATE VIEW public.vue_produits AS
 SELECT p.id AS id_produit,
    p.nom_prod AS nom_produit,
    p.marque AS marque_produit,
    p.taille AS taille_prod,
    p.prix AS prix_produit,
    p.stock AS stock_prod,
    c.nom_cat AS nom_categorie
   FROM (public.produit p
     JOIN public."catégorie" c ON ((p."catégorie_id" = c.id_cat)));
    DROP VIEW public.vue_produits;
       public          anonyme    false    218    218    218    218    218    218    218    216    216    4            �            1259    16701    vueproduitcategorie    VIEW       CREATE VIEW public.vueproduitcategorie AS
 SELECT p.id,
    p.nom_prod,
    p.marque,
    p.taille,
    p.prix,
    p.stock,
    p."catégorie_id",
    c.nom_cat AS nom_categorie
   FROM (public.produit p
     JOIN public."catégorie" c ON ((p."catégorie_id" = c.id_cat)));
 &   DROP VIEW public.vueproduitcategorie;
       public          anonyme    false    218    218    218    218    216    216    218    218    218    4            y           2604    16684    admin id_admin    DEFAULT     j   ALTER TABLE ONLY public.admin ALTER COLUMN id_admin SET DEFAULT nextval('public.admin_id_seq'::regclass);
 =   ALTER TABLE public.admin ALTER COLUMN id_admin DROP DEFAULT;
       public          anonyme    false    225    226    226            t           2604    16609    catégorie id_cat    DEFAULT     v   ALTER TABLE ONLY public."catégorie" ALTER COLUMN id_cat SET DEFAULT nextval('public."catégorie_id_seq"'::regclass);
 B   ALTER TABLE public."catégorie" ALTER COLUMN id_cat DROP DEFAULT;
       public          anonyme    false    216    215    216            v           2604    16628 	   client id    DEFAULT     f   ALTER TABLE ONLY public.client ALTER COLUMN id SET DEFAULT nextval('public.client_id_seq'::regclass);
 8   ALTER TABLE public.client ALTER COLUMN id DROP DEFAULT;
       public          anonyme    false    220    219    220            w           2604    16637    commande id    DEFAULT     j   ALTER TABLE ONLY public.commande ALTER COLUMN id SET DEFAULT nextval('public.commande_id_seq'::regclass);
 :   ALTER TABLE public.commande ALTER COLUMN id DROP DEFAULT;
       public          anonyme    false    221    222    222            x           2604    16649 	   panier id    DEFAULT     f   ALTER TABLE ONLY public.panier ALTER COLUMN id SET DEFAULT nextval('public.panier_id_seq'::regclass);
 8   ALTER TABLE public.panier ALTER COLUMN id DROP DEFAULT;
       public          anonyme    false    224    223    224            u           2604    16616 
   produit id    DEFAULT     h   ALTER TABLE ONLY public.produit ALTER COLUMN id SET DEFAULT nextval('public.produit_id_seq'::regclass);
 9   ALTER TABLE public.produit ALTER COLUMN id DROP DEFAULT;
       public          anonyme    false    218    217    218            )          0    16681    admin 
   TABLE DATA                 public          anonyme    false    226   �F                 0    16606 
   catégorie 
   TABLE DATA                 public          anonyme    false    216   AG       #          0    16625    client 
   TABLE DATA                 public          anonyme    false    220   �G       %          0    16634    commande 
   TABLE DATA                 public          anonyme    false    222   �H       '          0    16646    panier 
   TABLE DATA                 public          anonyme    false    224   iI       !          0    16613    produit 
   TABLE DATA                 public          anonyme    false    218   �I       7           0    0    admin_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.admin_id_seq', 6, true);
          public          anonyme    false    225            8           0    0    catégorie_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."catégorie_id_seq"', 4, true);
          public          anonyme    false    215            9           0    0    client_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.client_id_seq', 2, true);
          public          anonyme    false    219            :           0    0    commande_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.commande_id_seq', 2, true);
          public          anonyme    false    221            ;           0    0    panier_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.panier_id_seq', 2, true);
          public          anonyme    false    223            <           0    0    produit_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.produit_id_seq', 4, true);
          public          anonyme    false    217            �           2606    16688    admin admin_login_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_login_key UNIQUE (login);
 ?   ALTER TABLE ONLY public.admin DROP CONSTRAINT admin_login_key;
       public            anonyme    false    226            �           2606    16686    admin admin_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id_admin);
 :   ALTER TABLE ONLY public.admin DROP CONSTRAINT admin_pkey;
       public            anonyme    false    226            {           2606    16611    catégorie catégorie_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public."catégorie"
    ADD CONSTRAINT "catégorie_pkey" PRIMARY KEY (id_cat);
 H   ALTER TABLE ONLY public."catégorie" DROP CONSTRAINT "catégorie_pkey";
       public            anonyme    false    216                       2606    16632    client client_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.client DROP CONSTRAINT client_pkey;
       public            anonyme    false    220            �           2606    16639    commande commande_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.commande DROP CONSTRAINT commande_pkey;
       public            anonyme    false    222            �           2606    16651    panier panier_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.panier
    ADD CONSTRAINT panier_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.panier DROP CONSTRAINT panier_pkey;
       public            anonyme    false    224            }           2606    16618    produit produit_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.produit
    ADD CONSTRAINT produit_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.produit DROP CONSTRAINT produit_pkey;
       public            anonyme    false    218            �           2606    16640     commande commande_client_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(id);
 J   ALTER TABLE ONLY public.commande DROP CONSTRAINT commande_client_id_fkey;
       public          anonyme    false    222    220    4735            �           2606    16661    commande fk_commande_produit    FK CONSTRAINT     �   ALTER TABLE ONLY public.commande
    ADD CONSTRAINT fk_commande_produit FOREIGN KEY (produit_id) REFERENCES public.produit(id);
 F   ALTER TABLE ONLY public.commande DROP CONSTRAINT fk_commande_produit;
       public          anonyme    false    222    4733    218            �           2606    16671    panier fk_panier_produit    FK CONSTRAINT     |   ALTER TABLE ONLY public.panier
    ADD CONSTRAINT fk_panier_produit FOREIGN KEY (produit_id) REFERENCES public.produit(id);
 B   ALTER TABLE ONLY public.panier DROP CONSTRAINT fk_panier_produit;
       public          anonyme    false    4733    224    218            �           2606    16652    panier panier_client_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.panier
    ADD CONSTRAINT panier_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(id);
 F   ALTER TABLE ONLY public.panier DROP CONSTRAINT panier_client_id_fkey;
       public          anonyme    false    224    4735    220            �           2606    16619 "   produit produit_catégorie_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.produit
    ADD CONSTRAINT "produit_catégorie_id_fkey" FOREIGN KEY ("catégorie_id") REFERENCES public."catégorie"(id_cat);
 N   ALTER TABLE ONLY public.produit DROP CONSTRAINT "produit_catégorie_id_fkey";
       public          anonyme    false    218    216    4731            )   �   x���v
Q���W((M��L�KL���S��L��tr��ATAbqqy~Q��B��O�k�������O~if�:��i��I��F@�2S��R�,J5嚛���)5�h�S~�:���8S�9nE�)�0�R̀�&e�� �� e��*         y   x���v
Q���W((M��L�SJN,9�2=�(3UIA#3%��Q���14�}B]�4u�}3sr�K��5��<�6�hRpF~���q�H,-..-J��,�Y��ɩ����Pø� p�`1      #   �   x���Mj�0��>ŐM&v��!���u!N�W�+�In{%����MK�]��=�}EU��(��;��.x�6���0㌀Ғ��ءۄ e�C()��z1���
��P�>�es��멆YF`����4l�H�8�|	��!
%����kE�ƅ���ޔ��3~Qi�������z����U]�r�������o�zjmZ��&p�@y����qљ�����m7��2�?(I�VO��      %   �   x���v
Q���W((M��L�K���M�KIU��L�QHI,I�Q(.I,)-�QH��L�+�I委f�ؚ
a�>���
�:
�FF&�ƺƆ�@�k�BbI	PO*�����Ѵ�򤪵F�����(8�2%��J��Fpk�� �H�      '   i   x���v
Q���W((M��L�+H��L-R��L�QH��L�+�1K�Kst
��SJ3AB�
a�>���
�:
 db�gi�����i��I��t��� �d.. K�6      !   
  x���Kj�0�O1d�D�����4��:�6(�h�H���J���X����?��a>Pմ��T���pP�/GkD@s��Ӏ���;H��RTG�?�7��������e,�=��>˺۴0O��i�xx1{T2�Y��K�)�bYV��STݘ����h�w �X���� 5u��(���-Ez�edK�`����ȃs�J�Ix5��R�=h>�<�|��R�ew��t��r���#��p��n�Bi�	��MW���dE��tQ����^     