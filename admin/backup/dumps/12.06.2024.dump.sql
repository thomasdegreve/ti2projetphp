--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-06-12 18:20:44

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 239 (class 1255 OID 16699)
-- Name: ajout_client(text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ajout_client(text, text, text, text, text, text) RETURNS integer
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


--
-- TOC entry 247 (class 1255 OID 16716)
-- Name: ajout_produit(text, text, text, numeric, integer, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ajout_produit(p_nom_prod text, p_marque text, p_taille text, p_prix numeric, p_stock integer, p_categorie_id integer, p_image text) RETURNS integer
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


--
-- TOC entry 232 (class 1255 OID 16747)
-- Name: delete_client(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.delete_client(integer) RETURNS integer
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


--
-- TOC entry 233 (class 1255 OID 16748)
-- Name: deleteclient(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.deleteclient(id integer) RETURNS void
    LANGUAGE plpgsql
    AS '
BEGIN
    DELETE FROM client WHERE id_c = id;
END;
';


--
-- TOC entry 234 (class 1255 OID 16700)
-- Name: updateClient(integer, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public."updateClient"(integer, text, text) RETURNS integer
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


--
-- TOC entry 248 (class 1255 OID 16744)
-- Name: update_client(integer, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_client(integer, text, text) RETURNS integer
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


--
-- TOC entry 231 (class 1255 OID 16689)
-- Name: verifier_admin(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.verifier_admin(text, text) RETURNS integer
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


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 16681)
-- Name: admin; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin (
    id_admin integer NOT NULL,
    login character varying(100) NOT NULL,
    password character varying(255) NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 16680)
-- Name: admin_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 225
-- Name: admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_id_seq OWNED BY public.admin.id_admin;


--
-- TOC entry 216 (class 1259 OID 16606)
-- Name: catégorie; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."catégorie" (
    id_cat integer NOT NULL,
    nom_cat name NOT NULL COLLATE pg_catalog."default"
);


--
-- TOC entry 215 (class 1259 OID 16605)
-- Name: catégorie_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."catégorie_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 215
-- Name: catégorie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."catégorie_id_seq" OWNED BY public."catégorie".id_cat;


--
-- TOC entry 220 (class 1259 OID 16625)
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id_c integer NOT NULL,
    nom character varying(100) NOT NULL,
    prenom character varying(100) NOT NULL,
    adresse character varying(255),
    emailcl character varying(100),
    telephone character varying(20),
    password text
);


--
-- TOC entry 219 (class 1259 OID 16624)
-- Name: client_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 219
-- Name: client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id_c;


--
-- TOC entry 222 (class 1259 OID 16634)
-- Name: commande; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commande (
    id integer NOT NULL,
    date date,
    statut character varying(50),
    client_id integer,
    produit_id integer
);


--
-- TOC entry 221 (class 1259 OID 16633)
-- Name: commande_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.commande_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 221
-- Name: commande_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.commande_id_seq OWNED BY public.commande.id;


--
-- TOC entry 224 (class 1259 OID 16646)
-- Name: panier; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.panier (
    id integer NOT NULL,
    client_id integer,
    total numeric(10,2),
    produit_id integer
);


--
-- TOC entry 223 (class 1259 OID 16645)
-- Name: panier_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.panier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4929 (class 0 OID 0)
-- Dependencies: 223
-- Name: panier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.panier_id_seq OWNED BY public.panier.id;


--
-- TOC entry 218 (class 1259 OID 16613)
-- Name: produit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.produit (
    id_p integer NOT NULL,
    nom_prod character varying(100) NOT NULL,
    marque character varying(100),
    taille character varying(20),
    prix numeric(10,2),
    stock integer,
    categorie_id integer,
    image text
);


--
-- TOC entry 217 (class 1259 OID 16612)
-- Name: produit_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.produit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4930 (class 0 OID 0)
-- Dependencies: 217
-- Name: produit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.produit_id_seq OWNED BY public.produit.id_p;


--
-- TOC entry 229 (class 1259 OID 16712)
-- Name: vue_commande; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vue_commande AS
 SELECT c.date,
    c.statut,
    cl.nom AS nom_client,
    p.nom_prod AS nom_produit
   FROM ((public.commande c
     JOIN public.client cl ON ((c.client_id = cl.id_c)))
     JOIN public.produit p ON ((c.produit_id = p.id_p)));


--
-- TOC entry 228 (class 1259 OID 16708)
-- Name: vue_commandes; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vue_commandes AS
 SELECT c.date,
    c.statut,
    cl.id_c AS id_client,
    p.id_p AS id_produit
   FROM ((public.commande c
     JOIN public.client cl ON ((c.client_id = cl.id_c)))
     JOIN public.produit p ON ((c.produit_id = p.id_p)));


--
-- TOC entry 227 (class 1259 OID 16694)
-- Name: vue_produits; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vue_produits AS
 SELECT p.id_p AS id_produit,
    p.nom_prod AS nom_produit,
    p.marque AS marque_produit,
    p.taille AS taille_prod,
    p.prix AS prix_produit,
    p.stock AS stock_prod,
    c.nom_cat AS nom_categorie
   FROM (public.produit p
     JOIN public."catégorie" c ON ((p.categorie_id = c.id_cat)));


--
-- TOC entry 230 (class 1259 OID 16717)
-- Name: vueproduitcategorie; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vueproduitcategorie AS
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


--
-- TOC entry 4741 (class 2604 OID 16684)
-- Name: admin id_admin; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin ALTER COLUMN id_admin SET DEFAULT nextval('public.admin_id_seq'::regclass);


--
-- TOC entry 4736 (class 2604 OID 16609)
-- Name: catégorie id_cat; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."catégorie" ALTER COLUMN id_cat SET DEFAULT nextval('public."catégorie_id_seq"'::regclass);


--
-- TOC entry 4738 (class 2604 OID 16628)
-- Name: client id_c; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client ALTER COLUMN id_c SET DEFAULT nextval('public.client_id_seq'::regclass);


--
-- TOC entry 4739 (class 2604 OID 16637)
-- Name: commande id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commande ALTER COLUMN id SET DEFAULT nextval('public.commande_id_seq'::regclass);


--
-- TOC entry 4740 (class 2604 OID 16649)
-- Name: panier id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.panier ALTER COLUMN id SET DEFAULT nextval('public.panier_id_seq'::regclass);


--
-- TOC entry 4737 (class 2604 OID 16616)
-- Name: produit id_p; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produit ALTER COLUMN id_p SET DEFAULT nextval('public.produit_id_seq'::regclass);


--
-- TOC entry 4919 (class 0 OID 16681)
-- Dependencies: 226
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.admin (id_admin, login, password) VALUES (1, 'Louis', 'Louis');
INSERT INTO public.admin (id_admin, login, password) VALUES (2, 'Pierre', 'Pierre');
INSERT INTO public.admin (id_admin, login, password) VALUES (3, 'Emma', 'Emma');
INSERT INTO public.admin (id_admin, login, password) VALUES (4, 'Bob', 'Bob');
INSERT INTO public.admin (id_admin, login, password) VALUES (5, 'Fred', 'Fred');
INSERT INTO public.admin (id_admin, login, password) VALUES (6, 'Marie', 'Marie');


--
-- TOC entry 4909 (class 0 OID 16606)
-- Dependencies: 216
-- Data for Name: catégorie; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."catégorie" (id_cat, nom_cat) VALUES (1, 'Maillots');
INSERT INTO public."catégorie" (id_cat, nom_cat) VALUES (2, 'Shorts');
INSERT INTO public."catégorie" (id_cat, nom_cat) VALUES (3, 'Chaussures');
INSERT INTO public."catégorie" (id_cat, nom_cat) VALUES (4, 'Accessoires');


--
-- TOC entry 4913 (class 0 OID 16625)
-- Dependencies: 220
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client (id_c, nom, prenom, adresse, emailcl, telephone, password) VALUES (1, 'Dupont', 'Jean', '123 Rue de la Libération, Ville', 'jean.dupont@example.com', '0123456789', NULL);
INSERT INTO public.client (id_c, nom, prenom, adresse, emailcl, telephone, password) VALUES (2, 'Martin', 'Sophie', '456 Avenue des Champs, Ville', 'sophie.martin@example.com', '9876543210', NULL);
INSERT INTO public.client (id_c, nom, prenom, adresse, emailcl, telephone, password) VALUES (3, 'Doe', 'John', 'john.doe@example.com', '123 Rue de Test', '123456789', 'motdepasse');
INSERT INTO public.client (id_c, nom, prenom, adresse, emailcl, telephone, password) VALUES (4, 'degreve', 'thomas', 'inn', 'thomas.degreve@condorcet.be', '0492445680', 'fnjefjne');


--
-- TOC entry 4915 (class 0 OID 16634)
-- Dependencies: 222
-- Data for Name: commande; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.commande (id, date, statut, client_id, produit_id) VALUES (1, '2024-03-31', 'En attente', 1, 7);
INSERT INTO public.commande (id, date, statut, client_id, produit_id) VALUES (2, '2024-03-30', 'Expédiée', 2, 9);


--
-- TOC entry 4917 (class 0 OID 16646)
-- Dependencies: 224
-- Data for Name: panier; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.panier (id, client_id, total, produit_id) VALUES (1, 1, 149.97, NULL);
INSERT INTO public.panier (id, client_id, total, produit_id) VALUES (2, 2, 109.97, NULL);


--
-- TOC entry 4911 (class 0 OID 16613)
-- Dependencies: 218
-- Data for Name: produit; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.produit (id_p, nom_prod, marque, taille, prix, stock, categorie_id, image) VALUES (6, 'Maillot Rouge', 'puma', 'M', 49.99, 100, 1, 'admin/public/images/maillot_rouge.jpg');
INSERT INTO public.produit (id_p, nom_prod, marque, taille, prix, stock, categorie_id, image) VALUES (7, 'Maillot Bleu', 'Adidas', 'L', 39.99, 80, 1, 'admin/public/images/maillot_bleu.jpg');
INSERT INTO public.produit (id_p, nom_prod, marque, taille, prix, stock, categorie_id, image) VALUES (9, 'Maillot Jaune', 'Under Armour', 'S', 54.99, 90, 1, 'admin/public/images/maillot_jaune.jpg');
INSERT INTO public.produit (id_p, nom_prod, marque, taille, prix, stock, categorie_id, image) VALUES (4, 'Brassard Capitaine', 'Under Armour', NULL, 9.99, 100, 4, 'admin/public/images/brassard_capitaine.jpg');
INSERT INTO public.produit (id_p, nom_prod, marque, taille, prix, stock, categorie_id, image) VALUES (11, 'Short de foot bayern', 'Adidas', 'S', 34.99, 30, 2, 'admin/public/images/short_bayern.jpg');
INSERT INTO public.produit (id_p, nom_prod, marque, taille, prix, stock, categorie_id, image) VALUES (12, 'Short de foot suisse', 'Puma', 'L', 39.99, 20, 2, 'admin/public/images/short_suisse.jpg');
INSERT INTO public.produit (id_p, nom_prod, marque, taille, prix, stock, categorie_id, image) VALUES (13, 'Chaussures de foot Nike', 'Nike', '42', 89.99, 25, 3, 'admin/public/images/chaussures_nike.jpg');
INSERT INTO public.produit (id_p, nom_prod, marque, taille, prix, stock, categorie_id, image) VALUES (14, 'Chaussures de foot Adidas', 'Adidas', '45', 79.99, 15, 3, 'admin/public/images/chaussures_puma.jpg');
INSERT INTO public.produit (id_p, nom_prod, marque, taille, prix, stock, categorie_id, image) VALUES (16, 'carton jaune', 'vdv', NULL, 5.99, 6, 4, 'admin/public/images/carton.jpg');


--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 225
-- Name: admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_id_seq', 6, true);


--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 215
-- Name: catégorie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."catégorie_id_seq"', 4, true);


--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 219
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.client_id_seq', 5, true);


--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 221
-- Name: commande_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.commande_id_seq', 2, true);


--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 223
-- Name: panier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.panier_id_seq', 2, true);


--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 217
-- Name: produit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.produit_id_seq', 16, true);


--
-- TOC entry 4753 (class 2606 OID 16688)
-- Name: admin admin_login_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_login_key UNIQUE (login);


--
-- TOC entry 4755 (class 2606 OID 16686)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id_admin);


--
-- TOC entry 4743 (class 2606 OID 16611)
-- Name: catégorie catégorie_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."catégorie"
    ADD CONSTRAINT "catégorie_pkey" PRIMARY KEY (id_cat);


--
-- TOC entry 4747 (class 2606 OID 16632)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_c);


--
-- TOC entry 4749 (class 2606 OID 16639)
-- Name: commande commande_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_pkey PRIMARY KEY (id);


--
-- TOC entry 4751 (class 2606 OID 16651)
-- Name: panier panier_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.panier
    ADD CONSTRAINT panier_pkey PRIMARY KEY (id);


--
-- TOC entry 4745 (class 2606 OID 16618)
-- Name: produit produit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produit
    ADD CONSTRAINT produit_pkey PRIMARY KEY (id_p);


--
-- TOC entry 4757 (class 2606 OID 16640)
-- Name: commande commande_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(id_c);


--
-- TOC entry 4758 (class 2606 OID 16661)
-- Name: commande fk_commande_produit; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT fk_commande_produit FOREIGN KEY (produit_id) REFERENCES public.produit(id_p);


--
-- TOC entry 4759 (class 2606 OID 16671)
-- Name: panier fk_panier_produit; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.panier
    ADD CONSTRAINT fk_panier_produit FOREIGN KEY (produit_id) REFERENCES public.produit(id_p);


--
-- TOC entry 4760 (class 2606 OID 16652)
-- Name: panier panier_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.panier
    ADD CONSTRAINT panier_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(id_c);


--
-- TOC entry 4756 (class 2606 OID 16619)
-- Name: produit produit_catégorie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produit
    ADD CONSTRAINT "produit_catégorie_id_fkey" FOREIGN KEY (categorie_id) REFERENCES public."catégorie"(id_cat);


-- Completed on 2024-06-12 18:20:44

--
-- PostgreSQL database dump complete
--

