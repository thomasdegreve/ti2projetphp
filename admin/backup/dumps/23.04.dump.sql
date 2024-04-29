--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-04-23 12:20:44

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 230 (class 1255 OID 16699)
-- Name: ajout_client(text, text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ajout_client(text, text, text, text, text, text) RETURNS integer
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


--
-- TOC entry 231 (class 1255 OID 16700)
-- Name: update_client(integer, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_client(integer, text, text) RETURNS integer
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
-- TOC entry 229 (class 1255 OID 16689)
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
-- TOC entry 4912 (class 0 OID 0)
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
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 215
-- Name: catégorie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."catégorie_id_seq" OWNED BY public."catégorie".id_cat;


--
-- TOC entry 220 (class 1259 OID 16625)
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id integer NOT NULL,
    nom character varying(100) NOT NULL,
    "prénom" character varying(100) NOT NULL,
    adresse character varying(255),
    emailcl character varying(100),
    "téléphone" character varying(20),
    password "char"[]
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
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 219
-- Name: client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id;


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
-- TOC entry 4915 (class 0 OID 0)
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
-- TOC entry 4916 (class 0 OID 0)
-- Dependencies: 223
-- Name: panier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.panier_id_seq OWNED BY public.panier.id;


--
-- TOC entry 218 (class 1259 OID 16613)
-- Name: produit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.produit (
    id integer NOT NULL,
    nom_prod character varying(100) NOT NULL,
    marque character varying(100),
    taille character varying(20),
    prix numeric(10,2),
    stock integer,
    "catégorie_id" integer
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
-- TOC entry 4917 (class 0 OID 0)
-- Dependencies: 217
-- Name: produit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.produit_id_seq OWNED BY public.produit.id;


--
-- TOC entry 227 (class 1259 OID 16694)
-- Name: vue_produits; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vue_produits AS
 SELECT p.id AS id_produit,
    p.nom_prod AS nom_produit,
    p.marque AS marque_produit,
    p.taille AS taille_prod,
    p.prix AS prix_produit,
    p.stock AS stock_prod,
    c.nom_cat AS nom_categorie
   FROM (public.produit p
     JOIN public."catégorie" c ON ((p."catégorie_id" = c.id_cat)));


--
-- TOC entry 228 (class 1259 OID 16701)
-- Name: vueproduitcategorie; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vueproduitcategorie AS
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


--
-- TOC entry 4729 (class 2604 OID 16684)
-- Name: admin id_admin; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin ALTER COLUMN id_admin SET DEFAULT nextval('public.admin_id_seq'::regclass);


--
-- TOC entry 4724 (class 2604 OID 16609)
-- Name: catégorie id_cat; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."catégorie" ALTER COLUMN id_cat SET DEFAULT nextval('public."catégorie_id_seq"'::regclass);


--
-- TOC entry 4726 (class 2604 OID 16628)
-- Name: client id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client ALTER COLUMN id SET DEFAULT nextval('public.client_id_seq'::regclass);


--
-- TOC entry 4727 (class 2604 OID 16637)
-- Name: commande id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commande ALTER COLUMN id SET DEFAULT nextval('public.commande_id_seq'::regclass);


--
-- TOC entry 4728 (class 2604 OID 16649)
-- Name: panier id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.panier ALTER COLUMN id SET DEFAULT nextval('public.panier_id_seq'::regclass);


--
-- TOC entry 4725 (class 2604 OID 16616)
-- Name: produit id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produit ALTER COLUMN id SET DEFAULT nextval('public.produit_id_seq'::regclass);


--
-- TOC entry 4905 (class 0 OID 16681)
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
-- TOC entry 4895 (class 0 OID 16606)
-- Dependencies: 216
-- Data for Name: catégorie; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."catégorie" (id_cat, nom_cat) VALUES (1, 'Maillots');
INSERT INTO public."catégorie" (id_cat, nom_cat) VALUES (2, 'Shorts');
INSERT INTO public."catégorie" (id_cat, nom_cat) VALUES (3, 'Chaussures');
INSERT INTO public."catégorie" (id_cat, nom_cat) VALUES (4, 'Accessoires');


--
-- TOC entry 4899 (class 0 OID 16625)
-- Dependencies: 220
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client (id, nom, "prénom", adresse, emailcl, "téléphone", password) VALUES (1, 'Dupont', 'Jean', '123 Rue de la Libération, Ville', 'jean.dupont@example.com', '0123456789', NULL);
INSERT INTO public.client (id, nom, "prénom", adresse, emailcl, "téléphone", password) VALUES (2, 'Martin', 'Sophie', '456 Avenue des Champs, Ville', 'sophie.martin@example.com', '9876543210', NULL);


--
-- TOC entry 4901 (class 0 OID 16634)
-- Dependencies: 222
-- Data for Name: commande; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.commande (id, date, statut, client_id, produit_id) VALUES (1, '2024-03-31', 'En attente', 1, NULL);
INSERT INTO public.commande (id, date, statut, client_id, produit_id) VALUES (2, '2024-03-30', 'Expédiée', 2, NULL);


--
-- TOC entry 4903 (class 0 OID 16646)
-- Dependencies: 224
-- Data for Name: panier; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.panier (id, client_id, total, produit_id) VALUES (1, 1, 149.97, NULL);
INSERT INTO public.panier (id, client_id, total, produit_id) VALUES (2, 2, 109.97, NULL);


--
-- TOC entry 4897 (class 0 OID 16613)
-- Dependencies: 218
-- Data for Name: produit; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.produit (id, nom_prod, marque, taille, prix, stock, "catégorie_id") VALUES (1, 'Maillot Domicile', 'Nike', 'L', 49.99, 50, 1);
INSERT INTO public.produit (id, nom_prod, marque, taille, prix, stock, "catégorie_id") VALUES (2, 'Shorts d''entraînement', 'Adidas', 'M', 29.99, 30, 2);
INSERT INTO public.produit (id, nom_prod, marque, taille, prix, stock, "catégorie_id") VALUES (3, 'Chaussures de Football', 'Puma', '42', 79.99, 20, 3);
INSERT INTO public.produit (id, nom_prod, marque, taille, prix, stock, "catégorie_id") VALUES (4, 'Brassard Capitaine', 'Under Armour', NULL, 9.99, 100, 4);


--
-- TOC entry 4918 (class 0 OID 0)
-- Dependencies: 225
-- Name: admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_id_seq', 6, true);


--
-- TOC entry 4919 (class 0 OID 0)
-- Dependencies: 215
-- Name: catégorie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."catégorie_id_seq"', 4, true);


--
-- TOC entry 4920 (class 0 OID 0)
-- Dependencies: 219
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.client_id_seq', 2, true);


--
-- TOC entry 4921 (class 0 OID 0)
-- Dependencies: 221
-- Name: commande_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.commande_id_seq', 2, true);


--
-- TOC entry 4922 (class 0 OID 0)
-- Dependencies: 223
-- Name: panier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.panier_id_seq', 2, true);


--
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 217
-- Name: produit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.produit_id_seq', 4, true);


--
-- TOC entry 4741 (class 2606 OID 16688)
-- Name: admin admin_login_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_login_key UNIQUE (login);


--
-- TOC entry 4743 (class 2606 OID 16686)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id_admin);


--
-- TOC entry 4731 (class 2606 OID 16611)
-- Name: catégorie catégorie_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."catégorie"
    ADD CONSTRAINT "catégorie_pkey" PRIMARY KEY (id_cat);


--
-- TOC entry 4735 (class 2606 OID 16632)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- TOC entry 4737 (class 2606 OID 16639)
-- Name: commande commande_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_pkey PRIMARY KEY (id);


--
-- TOC entry 4739 (class 2606 OID 16651)
-- Name: panier panier_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.panier
    ADD CONSTRAINT panier_pkey PRIMARY KEY (id);


--
-- TOC entry 4733 (class 2606 OID 16618)
-- Name: produit produit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produit
    ADD CONSTRAINT produit_pkey PRIMARY KEY (id);


--
-- TOC entry 4745 (class 2606 OID 16640)
-- Name: commande commande_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 4746 (class 2606 OID 16661)
-- Name: commande fk_commande_produit; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT fk_commande_produit FOREIGN KEY (produit_id) REFERENCES public.produit(id);


--
-- TOC entry 4747 (class 2606 OID 16671)
-- Name: panier fk_panier_produit; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.panier
    ADD CONSTRAINT fk_panier_produit FOREIGN KEY (produit_id) REFERENCES public.produit(id);


--
-- TOC entry 4748 (class 2606 OID 16652)
-- Name: panier panier_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.panier
    ADD CONSTRAINT panier_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 4744 (class 2606 OID 16619)
-- Name: produit produit_catégorie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produit
    ADD CONSTRAINT "produit_catégorie_id_fkey" FOREIGN KEY ("catégorie_id") REFERENCES public."catégorie"(id_cat);


-- Completed on 2024-04-23 12:20:45

--
-- PostgreSQL database dump complete
--

