DROP SCHEMA tp_gite_de_france CASCADE;
CREATE SCHEMA tp_gite_de_france;
SET search_path = tp_gite_de_france, pg_catalog;


CREATE DOMAIN dom_interet AS integer
	CONSTRAINT ck_interet CHECK ( VALUE between 1 AND  5);

CREATE TYPE information AS (
	distance real,
	interet dom_interet
);



CREATE TABLE activites (
    numact serial NOT NULL,
    nomact character varying(45)
);



SELECT pg_catalog.setval('activites_numact_seq', 7, true);

CREATE TABLE chambres (
    numch serial NOT NULL,
    numgite integer NOT NULL,
    nblits integer DEFAULT 1 NOT NULL,
    nblitdo integer,
    superficiech integer
);



SELECT pg_catalog.setval('chambres_numch_seq', 42, true);


CREATE TABLE clients (
    numcli serial NOT NULL,
    nomcli character varying(35) NOT NULL,
    adrcli character varying(50) NOT NULL,
    cpcli numeric(5,0) NOT NULL,
    villecli character varying(35) NOT NULL,
    telcli character varying(20) NOT NULL
);



SELECT pg_catalog.setval('clients_numcli_seq', 51, true);

CREATE TABLE facturer (
    saison character varying(10) NOT NULL,
    numgite integer NOT NULL,
    tarifttc numeric(6,2) NOT NULL
);


CREATE TABLE gites (
    numgite serial NOT NULL,
    nomgite character varying(25) DEFAULT NULL::character varying,
    adrgite character varying(50) DEFAULT NULL::character varying,
    cpgite numeric(5,0) DEFAULT NULL::numeric,
    villegite character varying(35) DEFAULT NULL::character varying,
    telgite character varying(15),
    description character varying(255) NOT NULL,
    numprop integer NOT NULL,
    superficiegit integer,
    nbepis integer DEFAULT 1,
    nbpers integer DEFAULT 2,
    CONSTRAINT ck_tel CHECK (((telgite)::text ~ similar_escape('[0-9][0-9]-[0-9][0-9]-[0-9][0-9]-[0-9][0-9]-[0-9][0-9]'::text, NULL::text)))
);


SELECT pg_catalog.setval('gites_numgite_seq', 17, true);


CREATE TABLE louer (
    numgite integer NOT NULL,
    numcli integer NOT NULL,
    duree integer DEFAULT 1,
    nbper integer DEFAULT 1,
    date_debut date DEFAULT now() NOT NULL
);


CREATE TABLE organisme (
    id_orga serial NOT NULL,
    nom_orga character varying(45) NOT NULL,
    adr_orga character varying(175) NOT NULL,
    ville_orga character varying(75) NOT NULL,
    cp_orga numeric(5,0) NOT NULL
);


SELECT pg_catalog.setval('organisme_id_orga_seq', 2, true);

CREATE TABLE proposer (
    numgite integer NOT NULL,
    numact integer NOT NULL,
    info information
);

CREATE TABLE proposer_par (
    numgite integer NOT NULL,
    numact integer NOT NULL,
    id_orga integer NOT NULL
);


CREATE TABLE proprietaire (
    numprop serial NOT NULL,
    nomprop character varying(35),
    adrprop character varying(50),
    cpprop numeric(5,0),
    villeprop character varying(50),
    telprop character varying(20)
);


SELECT pg_catalog.setval('proprietaire_numprop_seq', 18, true);


CREATE TABLE saison (
    saison character varying(10) NOT NULL
);


ALTER TABLE activites ALTER COLUMN numact SET DEFAULT nextval('activites_numact_seq'::regclass);
ALTER TABLE chambres ALTER COLUMN numch SET DEFAULT nextval('chambres_numch_seq'::regclass);
ALTER TABLE clients ALTER COLUMN numcli SET DEFAULT nextval('clients_numcli_seq'::regclass);
ALTER TABLE gites ALTER COLUMN numgite SET DEFAULT nextval('gites_numgite_seq'::regclass);
ALTER TABLE organisme ALTER COLUMN id_orga SET DEFAULT nextval('organisme_id_orga_seq'::regclass);
ALTER TABLE proprietaire ALTER COLUMN numprop SET DEFAULT nextval('proprietaire_numprop_seq'::regclass);


INSERT INTO activites VALUES (1, 'alpinisme');
INSERT INTO activites VALUES (2, 'Randonnée');
INSERT INTO activites VALUES (3, 'Ski');
INSERT INTO activites VALUES (4, 'Canyoning');
INSERT INTO activites VALUES (5, 'Escalade');
INSERT INTO activites VALUES (6, 'VTT');
INSERT INTO activites VALUES (7, 'Sport Nautique');


-- Data for Name: chambres; Type: TABLE DATA; Schema: tp_gite_de_france; Owner: postgres
--

INSERT INTO chambres VALUES (2, 2, 2, 1, 20);
INSERT INTO chambres VALUES (3, 5, 4, 1, 18);
INSERT INTO chambres VALUES (5, 14, 2, 1, 24);
INSERT INTO chambres VALUES (7, 7, 4, 2, 21);
INSERT INTO chambres VALUES (10, 5, 1, 1, 23);
INSERT INTO chambres VALUES (12, 2, 2, 1, 17);
INSERT INTO chambres VALUES (15, 17, 4, 2, 15);
INSERT INTO chambres VALUES (16, 17, 3, 1, 16);
INSERT INTO chambres VALUES (17, 4, 1, 2, 16);
INSERT INTO chambres VALUES (18, 13, 3, 1, 17);
INSERT INTO chambres VALUES (19, 9, 3, 2, 18);
INSERT INTO chambres VALUES (21, 6, 3, 1, 24);
INSERT INTO chambres VALUES (22, 7, 4, 2, 13);
INSERT INTO chambres VALUES (26, 8, 3, 1, 23);
INSERT INTO chambres VALUES (33, 7, 4, 2, 25);
INSERT INTO chambres VALUES (34, 16, 1, 1, 22);
INSERT INTO chambres VALUES (36, 10, 3, 2, 18);
INSERT INTO chambres VALUES (37, 15, 1, 2, 9);
INSERT INTO chambres VALUES (38, 15, 3, 2, 16);
INSERT INTO chambres VALUES (39, 3, 2, 2, 22);
INSERT INTO chambres VALUES (9, 2, 0, 1, 20);
INSERT INTO chambres VALUES (23, 3, 2, 0, 19);
INSERT INTO chambres VALUES (32, 4, 1, 1, 10);
INSERT INTO chambres VALUES (30, 6, 2, 1, 25);
INSERT INTO chambres VALUES (24, 8, 1, 1, 16);
INSERT INTO chambres VALUES (13, 10, 1, 1, 15);
INSERT INTO chambres VALUES (8, 11, 2, 0, 12);
INSERT INTO chambres VALUES (1, 9, 1, 2, 18);
INSERT INTO chambres VALUES (42, 1, 4, 1, 16);
INSERT INTO chambres VALUES (27, 7, 1, 1, 9);
INSERT INTO chambres VALUES (41, 12, 3, 1, 25);
INSERT INTO chambres VALUES (14, 11, 1, 2, 9);


-- Data for Name: clients; Type: TABLE DATA; Schema: tp_gite_de_france; Owner: postgres
--

INSERT INTO clients VALUES (1, 'Pruitt', '950-7917 Auctor, Rd.', 3529, 'Fernie', '06 14 55 30 25');
INSERT INTO clients VALUES (2, 'Anderson', 'CP 999, 9904 Nunc Ave', 48921, 'Heerlen', '07 96 72 87 68');
INSERT INTO clients VALUES (3, 'Perry', 'CP 592, 7135 Sed Impasse', 27217, 'Enterprise', '09 65 35 22 67');
INSERT INTO clients VALUES (4, 'Mcbride', '609-1324 Nonummy. Chemin', 78960, 'Pamel', '06 77 05 10 08');
INSERT INTO clients VALUES (5, 'Anthony', 'CP 534, 1354 Euismod Rd.', 42295, 'Whitburn', '02 09 52 42 51');
INSERT INTO clients VALUES (6, 'Ramirez', 'CP 760, 7579 Nibh Route', 86189, 'Sant''Omero', '07 66 76 83 03');
INSERT INTO clients VALUES (7, 'Huff', 'CP 381, 433 In Route', 61305, 'Pilibhit', '01 13 12 87 43');
INSERT INTO clients VALUES (8, 'Grimes', '5920 Nulla Av.', 73449, 'Sindelfingen', '04 23 33 21 96');
INSERT INTO clients VALUES (9, 'Knapp', 'Appartement 457-9519 Sapien. Avenue', 31518, 'Rotorua', '09 55 02 53 79');
INSERT INTO clients VALUES (10, 'Hamilton', 'Appartement 931-1768 Dolor Chemin', 75836, 'Armadale', '09 94 00 02 99');
INSERT INTO clients VALUES (11, 'Perez', 'Appartement 902-3167 Id, Rd.', 7632, 'Mornimont', '04 65 48 81 30');
INSERT INTO clients VALUES (12, 'Wheeler', 'Appartement 340-6150 Convallis, Ave', 50148, 'Carbonear', '05 09 06 21 80');
INSERT INTO clients VALUES (13, 'Perry', 'Appartement 318-6962 Venenatis Avenue', 85847, 'Cartago', '08 73 32 02 67');
INSERT INTO clients VALUES (14, 'Mathis', '5432 Erat. Ave', 34194, 'Baddeck', '09 33 30 78 31');
INSERT INTO clients VALUES (15, 'Valencia', '635-6795 Elementum Rue', 35292, 'Ingooigem', '01 95 87 15 79');
INSERT INTO clients VALUES (16, 'Daniel', 'CP 603, 7521 Iaculis Route', 19820, 'Oostende', '09 90 92 37 09');
INSERT INTO clients VALUES (17, 'Cain', '2705 Nisi Rue', 6326, 'Forst', '05 12 05 48 59');
INSERT INTO clients VALUES (18, 'Hansen', '403-8236 Luctus Avenue', 70296, 'Mornimont', '04 85 26 72 48');
INSERT INTO clients VALUES (19, 'Bishop', '398-3388 Dui Rd.', 97155, 'Evansville', '03 53 82 34 04');
INSERT INTO clients VALUES (20, 'Mayer', '3224 Nec Rue', 67031, 'Oostmalle', '07 44 77 01 93');
INSERT INTO clients VALUES (21, 'Mosley', '172-4859 Erat Route', 17459, 'New Glasgow', '04 63 93 03 22');
INSERT INTO clients VALUES (22, 'Douglas', '894-9348 Amet Avenue', 71076, 'Caruaru', '06 38 35 72 62');
INSERT INTO clients VALUES (23, 'Grant', '926-1340 Quisque Chemin', 65632, 'Tulsa', '03 65 36 78 35');
INSERT INTO clients VALUES (24, 'Wood', 'Appartement 163-6591 Donec Route', 68434, 'Warwick', '09 49 56 49 16');
INSERT INTO clients VALUES (25, 'Sloan', '9186 Phasellus Avenue', 65701, 'Trazegnies', '06 47 63 71 19');
INSERT INTO clients VALUES (26, 'Stanley', '954-4852 Quis, Rue', 18112, 'Ohain', '08 51 50 28 89');
INSERT INTO clients VALUES (27, 'Daugherty', 'CP 162, 1088 Amet Chemin', 77892, 'Kester', '05 51 11 51 37');
INSERT INTO clients VALUES (28, 'Harding', 'CP 432, 6124 Dolor Route', 14318, 'Lacombe', '04 36 86 44 04');
INSERT INTO clients VALUES (29, 'Cook', 'CP 913, 9068 Dis Ave', 77381, 'Sterling Heights', '05 41 00 23 27');
INSERT INTO clients VALUES (30, 'Shaffer', 'Appartement 164-9796 Turpis. Impasse', 83916, 'Owensboro', '09 28 09 77 87');
INSERT INTO clients VALUES (31, 'Kelly', 'CP 468, 2069 Quisque Rue', 13374, 'Cardiff', '02 86 08 11 06');
INSERT INTO clients VALUES (32, 'Buckley', 'Appartement 165-994 Amet Impasse', 43919, 'Promo-Control', '02 96 83 97 00');
INSERT INTO clients VALUES (33, 'Duffy', 'CP 889, 2918 Aliquam Route', 85093, 'San Lazzaro di Savena', '02 95 55 78 07');
INSERT INTO clients VALUES (34, 'Mcbride', '1667 Elit Avenue', 63568, 'College', '05 99 46 20 95');
INSERT INTO clients VALUES (35, 'Cantrell', 'Appartement 326-6094 Tincidunt Ave', 16919, 'Veldegem', '06 46 85 23 75');
INSERT INTO clients VALUES (36, 'Dominguez', 'CP 849, 6983 Vestibulum. Rd.', 44201, 'Karimnagar', '07 42 52 35 84');
INSERT INTO clients VALUES (37, 'Knowles', 'Appartement 329-4363 Ac Route', 46237, 'Cimitile', '04 25 08 45 23');
INSERT INTO clients VALUES (38, 'Kelly', 'CP 115, 9467 Nunc Av.', 23167, 'Logan City', '01 95 16 50 58');
INSERT INTO clients VALUES (39, 'Hendricks', 'CP 841, 4496 Euismod Rue', 64414, 'Lewiston', '07 88 74 07 97');
INSERT INTO clients VALUES (40, 'Baird', '7363 Sit Avenue', 34718, 'Crecchio', '06 43 03 03 72');
INSERT INTO clients VALUES (41, 'House', '259-1144 Ut, Chemin', 92336, 'IlhÃ©us', '02 98 32 24 72');
INSERT INTO clients VALUES (42, 'Humphrey', '835-4057 Aliquam Av.', 16254, 'Marseille', '07 52 94 91 38');
INSERT INTO clients VALUES (43, 'Hodge', '9918 Phasellus Chemin', 98858, 'Sylvan Lake', '02 22 52 87 05');
INSERT INTO clients VALUES (44, 'Sims', '3505 In Chemin', 89919, 'Moere', '04 26 47 55 48');
INSERT INTO clients VALUES (45, 'Payne', '821-4907 Tincidunt Route', 41919, 'Nethen', '02 61 05 62 94');
INSERT INTO clients VALUES (46, 'Buckley', '189-6682 Sed Rue', 14872, 'Frauenkirchen', '09 29 83 05 79');
INSERT INTO clients VALUES (47, 'Shepherd', '136-1281 Lacus Impasse', 311, 'Rance', '05 46 13 07 55');
INSERT INTO clients VALUES (48, 'Bradshaw', 'Appartement 734-9544 Erat, Av.', 93991, 'Saint-Remy', '01 16 45 41 58');
INSERT INTO clients VALUES (49, 'Burnett', '921-6228 In Av.', 90082, 'Worms', '05 40 15 15 90');
INSERT INTO clients VALUES (50, 'Mitchell', '890-7260 Proin Avenue', 60673, 'Juneau', '09 25 55 48 63');
INSERT INTO clients VALUES (51, 'Copeland', '1304 Praesent Rue', 79705, 'Labrecque', '06 89 04 10 80');

-- Data for Name: facturer; Type: TABLE DATA; Schema: tp_gite_de_france; Owner: postgres
--

INSERT INTO facturer VALUES ('BASSE', 1, 387.00);
INSERT INTO facturer VALUES ('HAUTE', 1, 600.00);
INSERT INTO facturer VALUES ('MOYENNE', 1, 450.00);
INSERT INTO facturer VALUES ('BASSE', 2, 300.00);
INSERT INTO facturer VALUES ('HAUTE', 2, 700.00);
INSERT INTO facturer VALUES ('MOYENNE', 2, 400.00);
INSERT INTO facturer VALUES ('HAUTE', 3, 600.00);
INSERT INTO facturer VALUES ('BASSE', 3, 290.00);
INSERT INTO facturer VALUES ('MOYENNE', 3, 500.00);
INSERT INTO facturer VALUES ('HAUTE', 4, 500.00);
INSERT INTO facturer VALUES ('BASSE', 4, 190.00);
INSERT INTO facturer VALUES ('MOYENNE', 4, 450.00);
INSERT INTO facturer VALUES ('HAUTE', 5, 700.00);
INSERT INTO facturer VALUES ('BASSE', 5, 390.00);
INSERT INTO facturer VALUES ('MOYENNE', 5, 600.00);
INSERT INTO facturer VALUES ('HAUTE', 6, 800.00);
INSERT INTO facturer VALUES ('BASSE', 6, 450.00);
INSERT INTO facturer VALUES ('MOYENNE', 6, 600.00);
INSERT INTO facturer VALUES ('HAUTE', 7, 890.00);
INSERT INTO facturer VALUES ('BASSE', 7, 458.00);
INSERT INTO facturer VALUES ('MOYENNE', 7, 756.00);
INSERT INTO facturer VALUES ('HAUTE', 8, 457.00);
INSERT INTO facturer VALUES ('BASSE', 8, 256.00);
INSERT INTO facturer VALUES ('MOYENNE', 8, 350.00);
INSERT INTO facturer VALUES ('HAUTE', 9, 890.00);
INSERT INTO facturer VALUES ('BASSE', 9, 550.00);
INSERT INTO facturer VALUES ('MOYENNE', 9, 750.00);
INSERT INTO facturer VALUES ('HAUTE', 10, 560.00);
INSERT INTO facturer VALUES ('BASSE', 10, 360.00);
INSERT INTO facturer VALUES ('MOYENNE', 10, 460.00);
INSERT INTO facturer VALUES ('HAUTE', 11, 1355.00);
INSERT INTO facturer VALUES ('BASSE', 11, 850.00);
INSERT INTO facturer VALUES ('MOYENNE', 11, 1050.00);
INSERT INTO facturer VALUES ('HAUTE', 12, 1850.00);
INSERT INTO facturer VALUES ('BASSE', 12, 900.00);
INSERT INTO facturer VALUES ('MOYENNE', 12, 1500.00);
INSERT INTO facturer VALUES ('HAUTE', 13, 2500.00);
INSERT INTO facturer VALUES ('BASSE', 13, 1800.00);
INSERT INTO facturer VALUES ('MOYENNE', 13, 2000.00);
INSERT INTO facturer VALUES ('BASSE', 14, 450.00);
INSERT INTO facturer VALUES ('HAUTE', 14, 650.00);
INSERT INTO facturer VALUES ('MOYENNE', 14, 550.00);
INSERT INTO facturer VALUES ('BASSE', 15, 750.00);
INSERT INTO facturer VALUES ('HAUTE', 15, 350.00);
INSERT INTO facturer VALUES ('MOYENNE', 15, 550.00);
INSERT INTO facturer VALUES ('BASSE', 17, 350.00);
INSERT INTO facturer VALUES ('HAUTE', 17, 750.00);
INSERT INTO facturer VALUES ('MOYENNE', 17, 550.00);
INSERT INTO facturer VALUES ('BASSE', 16, 440.00);
INSERT INTO facturer VALUES ('HAUTE', 16, 650.00);
INSERT INTO facturer VALUES ('MOYENNE', 16, 550.00);


-- Data for Name: gites; Type: TABLE DATA; Schema: tp_gite_de_france; Owner: postgres
--

INSERT INTO gites VALUES (13, 'Germaine', 'CP 344, 5737 Scelerisque Avenue', 73607, 'Cairo Montenotte', '04-66-88-83-44', 'Lorem', 1, NULL, 2, 5);
INSERT INTO gites VALUES (15, 'Fletcher', '541 Convallis Rue', 73907, 'Rae-Edzo', '07-05-87-45-25', 'Lorem', 3, NULL, 3, 12);
INSERT INTO gites VALUES (16, 'le hors piste', 'CP 479, 6110 Conubia Impasse', 73987, 'Vrasene', '08-52-41-83-30', 'Lorem ipsum dolor sit', 16, NULL, 2, 3);
INSERT INTO gites VALUES (17, 'la camelle', '717-8703 Elit Route', 73420, 'Siliguri', '06-83-42-07-43', 'Lorem ipsum dolor sit amet, consectetuer', 17, NULL, 1, 13);
INSERT INTO gites VALUES (6, 'Nevada', 'CP 180, 6587 Elit Rd.', 74007, 'Leuze', '07-47-05-64-09', 'Lorem ipsum dolor sit amet, consectetuer adipiscing', 11, NULL, 1, 9);
INSERT INTO gites VALUES (9, 'Maris', 'CP 444, 5496 Tristique Chemin', 74373, 'Lowestoft', '01-77-51-12-79', 'Lorem ipsum', 18, NULL, 3, 10);
INSERT INTO gites VALUES (11, 'Basil', '8625 Nunc Ave', 74718, 'Ramskapelle', '05-74-51-48-45', 'Lorem ipsum dolor', 7, NULL, 1, 5);
INSERT INTO gites VALUES (14, 'Nash', 'Appartement 725-4686 Donec Ave', 74923, 'Sint-Pieters-Woluwe', '04-94-42-07-07', 'Lorem ipsum dolor sit amet,', 9, NULL, 2, 4);
INSERT INTO gites VALUES (1, 'Le Castor', '409-310 Et Route', 74499, 'Gibbons', '06-71-12-90-30', 'Lorem ipsum dolor sit amet, consectetuer adipiscing', 4, NULL, 2, 4);
INSERT INTO gites VALUES (2, 'Le col blanc', 'CP 167, 7492 Velit Chemin', 73812, 'Polpenazze del Garda', '07-84-59-55-17', 'Lorem ipsum dolor', 14, NULL, 2, 10);
INSERT INTO gites VALUES (3, 'Belle pente', '126-6647 Lorem Av.', 73079, 'Buti', '05-66-76-26-13', 'Lorem ipsum dolor sit amet,', 7, NULL, 3, 8);
INSERT INTO gites VALUES (4, 'La belle bosse', 'Appartement 116-8374 Ut Ave', 74034, 'Opgrimbie', '01-47-61-71-54', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 7, NULL, 2, 8);
INSERT INTO gites VALUES (12, 'le half-pipe', 'Appartement 148-252 Eget Chemin', 74520, 'Potenza', '01-86-53-06-29', 'Lorem ipsum dolor sit amet, consectetuer', 17, NULL, 1, 2);
INSERT INTO gites VALUES (5, 'l''Edelweiss', 'CP 532, 8052 Vitae Rd.', 73809, 'Pali', '09-18-48-18-34', 'Lorem ipsum', 5, NULL, 2, 9);
INSERT INTO gites VALUES (7, 'le chamoix', '573 Dolor Route', 73688, 'Etawah', '09-01-99-91-92', 'Lorem ipsum dolor', 11, NULL, 1, 28);
INSERT INTO gites VALUES (8, 'Margaret', 'Appartement 239-5172 Pede. Rue', 73730, 'Wangaratta', '06-16-12-41-08', 'Lorem ipsum dolor sit amet,', 3, NULL, 2, 8);
INSERT INTO gites VALUES (10, 'Chez mimil', 'Appartement 274-9067 Tellus Ave', 74652, 'Arles', '08-86-96-56-71', 'Lorem ipsum dolor sit amet, consectetuer adipiscing', 7, NULL, 3, 10);

-- Data for Name: louer; Type: TABLE DATA; Schema: tp_gite_de_france; Owner: postgres
--

INSERT INTO louer VALUES (3, 24, 9, 5, '2013-04-15');
INSERT INTO louer VALUES (5, 45, 6, 3, '2012-07-28');
INSERT INTO louer VALUES (7, 51, 4, 8, '2010-11-10');
INSERT INTO louer VALUES (3, 26, 8, 11, '2014-04-08');
INSERT INTO louer VALUES (4, 7, 12, 7, '2014-03-06');
INSERT INTO louer VALUES (13, 27, 3, 4, '2014-03-04');
INSERT INTO louer VALUES (12, 27, 11, 12, '2011-10-30');
INSERT INTO louer VALUES (14, 8, 3, 2, '2013-08-04');
INSERT INTO louer VALUES (14, 31, 7, 9, '2013-04-21');
INSERT INTO louer VALUES (7, 38, 11, 12, '2010-06-22');
INSERT INTO louer VALUES (12, 44, 13, 7, '2014-06-12');
INSERT INTO louer VALUES (9, 47, 13, 2, '2011-10-13');
INSERT INTO louer VALUES (15, 12, 10, 8, '2011-09-29');
INSERT INTO louer VALUES (5, 6, 7, 7, '2011-05-29');
INSERT INTO louer VALUES (8, 36, 10, 7, '2013-02-25');
INSERT INTO louer VALUES (4, 29, 8, 8, '2010-01-04');
INSERT INTO louer VALUES (8, 13, 7, 5, '2012-11-24');
INSERT INTO louer VALUES (5, 27, 12, 5, '2014-06-09');
INSERT INTO louer VALUES (4, 34, 13, 7, '2010-12-09');
INSERT INTO louer VALUES (14, 31, 5, 12, '2011-06-02');
INSERT INTO louer VALUES (16, 39, 3, 9, '2010-08-18');
INSERT INTO louer VALUES (12, 26, 9, 3, '2010-03-09');
INSERT INTO louer VALUES (9, 33, 5, 4, '2010-09-27');
INSERT INTO louer VALUES (16, 21, 14, 5, '2014-02-17');
INSERT INTO louer VALUES (16, 15, 10, 7, '2011-01-30');
INSERT INTO louer VALUES (4, 7, 6, 12, '2014-09-15');
INSERT INTO louer VALUES (12, 14, 5, 2, '2014-12-27');
INSERT INTO louer VALUES (5, 22, 13, 12, '2012-06-04');
INSERT INTO louer VALUES (4, 3, 11, 2, '2011-09-15');
INSERT INTO louer VALUES (15, 16, 6, 10, '2012-06-19');
INSERT INTO louer VALUES (3, 2, 8, 4, '2013-06-27');
INSERT INTO louer VALUES (13, 43, 3, 11, '2012-10-03');
INSERT INTO louer VALUES (14, 34, 3, 12, '2011-06-23');
INSERT INTO louer VALUES (14, 31, 12, 5, '2012-04-19');
INSERT INTO louer VALUES (3, 2, 13, 11, '2011-09-27');
INSERT INTO louer VALUES (12, 18, 10, 7, '2013-06-30');
INSERT INTO louer VALUES (10, 12, 3, 6, '2012-07-26');
INSERT INTO louer VALUES (10, 9, 8, 3, '2013-05-26');
INSERT INTO louer VALUES (3, 10, 5, 5, '2012-10-30');
INSERT INTO louer VALUES (10, 44, 9, 4, '2015-02-21');
INSERT INTO louer VALUES (1, 1, 7, 2, '2011-01-19');
INSERT INTO louer VALUES (1, 11, 13, 2, '2013-07-23');
INSERT INTO louer VALUES (1, 33, 14, 2, '2010-05-28');
INSERT INTO louer VALUES (1, 38, 13, 2, '2011-09-20');

-- Data for Name: organisme; Type: TABLE DATA; Schema: tp_gite_de_france; Owner: postgres
--

INSERT INTO organisme VALUES (1, 'Bureau des guides de Chamonix', '190 Place de l''Église', 'Chamonix-Mont-Blanc', 74400);
INSERT INTO organisme VALUES (2, 'Les Guides Indépendants de Chamonix', '45 rue blanche', 'Chamonix-Mont-Blanc', 74400);
INSERT INTO organisme VALUES (3, 'Office de tourisme', 'P.O. Box 805, 6679 Hendrerit St.', 'Annemasse', 73350);
INSERT INTO organisme VALUES (4, 'Bureau des guides', '3280 Et Av.', 'Annecy', 73223);
INSERT INTO organisme VALUES (5, 'Office de tourisme', '5760 Risus St.', 'La Ravoire', 73302);
INSERT INTO organisme VALUES (6, 'Bureau des guides', '462-6765 Ac Ave', 'Cluses', 73118);
INSERT INTO organisme VALUES (7, 'Maison de la montagne', '648-4678 Lorem St.', 'Thonon-les-Bains', 73325);
INSERT INTO organisme VALUES (8, 'Office de tourisme', 'P.O. Box 655, 4047 Sodales. Avenue', 'Bourg-Saint-Maurice', 73209);
INSERT INTO organisme VALUES (9, 'Office de tourisme', 'P.O. Box 648, 8252 Volutpat Ave', 'Cluses', 74452);
INSERT INTO organisme VALUES (10, 'Office de tourisme', '121 Feugiat. Road', 'Bourg-Saint-Maurice', 73326);

-- Data for Name: proposer; Type: TABLE DATA; Schema: tp_gite_de_france; Owner: postgres
--

INSERT INTO proposer VALUES (13, 5, '(13,5)');
INSERT INTO proposer VALUES (9, 1, '(9,1)');
INSERT INTO proposer VALUES (13, 2, '(13,2)');
INSERT INTO proposer VALUES (12, 3, '(12,3)');
INSERT INTO proposer VALUES (9, 4, '(9,4)');
INSERT INTO proposer VALUES (11, 2, '(11,2)');
INSERT INTO proposer VALUES (4, 1, '(4,1)');
INSERT INTO proposer VALUES (10, 5, '(10,5)');
INSERT INTO proposer VALUES (8, 5, '(8,5)');
INSERT INTO proposer VALUES (17, 4, '(17,4)');
INSERT INTO proposer VALUES (8, 1, '(8,1)');
INSERT INTO proposer VALUES (1, 4, '(1,4)');
INSERT INTO proposer VALUES (10, 3, '(10,3)');
INSERT INTO proposer VALUES (9, 6, '(9,3)');
INSERT INTO proposer VALUES (10, 2, '(10,2)');
INSERT INTO proposer VALUES (15, 3, '(15,3)');
INSERT INTO proposer VALUES (15, 6, '(15,2)');
INSERT INTO proposer VALUES (5, 7, '(5,3)');
INSERT INTO proposer VALUES (4, 6, '(4,1)');
INSERT INTO proposer VALUES (14, 5, '(14,5)');
INSERT INTO proposer VALUES (3, 4, '(3,4)');
INSERT INTO proposer VALUES (3, 5, '(3,5)');
INSERT INTO proposer VALUES (17, 7, '(17,3)');
INSERT INTO proposer VALUES (8, 4, '(8,4)');
INSERT INTO proposer VALUES (13, 1, '(13,1)');
INSERT INTO proposer VALUES (13, 3, '(13,3)');
INSERT INTO proposer VALUES (12, 4, '(12,4)');
INSERT INTO proposer VALUES (4, 7, '(4,3)');
INSERT INTO proposer VALUES (15, 1, '(15,1)');

-- Data for Name: proposer_par; Type: TABLE DATA; Schema: tp_gite_de_france; Owner: postgres
--

INSERT INTO proposer_par VALUES (13, 5, 3);
INSERT INTO proposer_par VALUES (9, 1, 6);
INSERT INTO proposer_par VALUES (13, 2, 4);
INSERT INTO proposer_par VALUES (12, 3, 2);
INSERT INTO proposer_par VALUES (9, 4, 2);
INSERT INTO proposer_par VALUES (11, 2, 3);
INSERT INTO proposer_par VALUES (4, 1, 6);
INSERT INTO proposer_par VALUES (10, 5, 6);
INSERT INTO proposer_par VALUES (8, 5, 6);
INSERT INTO proposer_par VALUES (17, 4, 8);
INSERT INTO proposer_par VALUES (8, 1, 3);
INSERT INTO proposer_par VALUES (1, 4, 8);
INSERT INTO proposer_par VALUES (10, 2, 8);
INSERT INTO proposer_par VALUES (15, 3, 5);
INSERT INTO proposer_par VALUES (15, 6, 2);
INSERT INTO proposer_par VALUES (4, 6, 3);
INSERT INTO proposer_par VALUES (14, 5, 9);
INSERT INTO proposer_par VALUES (3, 4, 10);
INSERT INTO proposer_par VALUES (3, 5, 9);
INSERT INTO proposer_par VALUES (17, 7, 7);
INSERT INTO proposer_par VALUES (8, 4, 4);
INSERT INTO proposer_par VALUES (13, 1, 2);
INSERT INTO proposer_par VALUES (12, 4, 3);
INSERT INTO proposer_par VALUES (4, 7, 4);

-- Data for Name: proprietaire; Type: TABLE DATA; Schema: tp_gite_de_france; Owner: postgres
--

INSERT INTO proprietaire VALUES (1, 'Stone', '2259 Tellus Chemin', 96032, 'Lissewege', '06 44 31 57 52');
INSERT INTO proprietaire VALUES (2, 'Kasper', 'CP 688, 5211 Molestie Ave', 6388, 'Kanpur Cantonment', '09 75 12 64 52');
INSERT INTO proprietaire VALUES (3, 'Dale', 'CP 922, 607 In Ave', 33799, 'Casperia', '04 98 33 35 88');
INSERT INTO proprietaire VALUES (4, 'Finn', '194-9789 Fringilla Av.', 99595, 'Kirkcaldy', '06 94 10 84 16');
INSERT INTO proprietaire VALUES (5, 'Roth', '843-3696 Curae; Rd.', 57238, 'Renfrew', '06 68 75 00 92');
INSERT INTO proprietaire VALUES (6, 'Dillon', 'Appartement 807-9789 Dui Avenue', 565, 'Smetlede', '07 83 42 22 11');
INSERT INTO proprietaire VALUES (7, 'Carly', '8110 Elit. Avenue', 41007, 'Missoula', '06 60 06 80 77');
INSERT INTO proprietaire VALUES (8, 'Bianca', 'CP 415, 616 Et Rue', 7214, 'Campofelice di Fitalia', '09 65 31 65 11');
INSERT INTO proprietaire VALUES (9, 'Jonah', '6889 Mi. Avenue', 63544, 'San Polo d''Enza', '04 38 60 80 34');
INSERT INTO proprietaire VALUES (10, 'David', '2690 Donec Chemin', 31703, 'Anchorage', '04 53 93 93 35');
INSERT INTO proprietaire VALUES (11, 'Quamar', '6312 Penatibus Avenue', 36050, 'New Radnor', '04 27 90 89 22');
INSERT INTO proprietaire VALUES (12, 'Dakota', 'CP 429, 6322 Dapibus Rue', 56097, 'Krefeld', '01 88 83 15 31');
INSERT INTO proprietaire VALUES (13, 'Hector', 'Appartement 593-3782 Pellentesque, Rd.', 60618, 'Terragnolo', '06 52 57 00 24');
INSERT INTO proprietaire VALUES (14, 'Clinton', 'Appartement 540-8818 Orci Ave', 36116, 'Wilhelmshaven', '03 66 58 05 59');
INSERT INTO proprietaire VALUES (15, 'Ashton', 'CP 699, 3463 Semper Chemin', 52484, 'Nakusp', '06 32 03 84 25');
INSERT INTO proprietaire VALUES (16, 'Joseph', 'CP 120, 8862 Morbi Impasse', 91381, 'San Damiano al Colle', '08 47 37 84 00');
INSERT INTO proprietaire VALUES (17, 'Chancellor', 'Appartement 128-4096 Orci. Route', 91261, 'Birkenhead', '05 08 55 98 18');
INSERT INTO proprietaire VALUES (18, 'Minerva', '950-1660 Est Rue', 71920, 'Santa Coloma de Gramenet', '05 42 07 64 49');

-- Data for Name: saison; Type: TABLE DATA; Schema: tp_gite_de_france; Owner: postgres
--

INSERT INTO saison VALUES ('BASSE');
INSERT INTO saison VALUES ('MOYENNE');
INSERT INTO saison VALUES ('HAUTE');



ALTER TABLE ONLY chambres
    ADD CONSTRAINT chambres_pkey PRIMARY KEY (numch);

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (numcli);

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_tel_key UNIQUE (telcli);

ALTER TABLE ONLY gites
    ADD CONSTRAINT gites_pkey PRIMARY KEY (numgite);

ALTER TABLE ONLY gites
    ADD CONSTRAINT gites_telgite_key UNIQUE (telgite);

ALTER TABLE ONLY louer
    ADD CONSTRAINT louer_pkey PRIMARY KEY (numgite, numcli, date_debut);

ALTER TABLE ONLY activites
    ADD CONSTRAINT pk_activites PRIMARY KEY (numact);

ALTER TABLE ONLY facturer
    ADD CONSTRAINT pk_facturer PRIMARY KEY (saison, numgite);

ALTER TABLE ONLY organisme
    ADD CONSTRAINT pk_organisme PRIMARY KEY (id_orga);

ALTER TABLE ONLY proposer
    ADD CONSTRAINT pk_proposer PRIMARY KEY (numgite, numact);

ALTER TABLE ONLY proposer_par
    ADD CONSTRAINT pk_proposer_par PRIMARY KEY (numgite, numact, id_orga);

ALTER TABLE ONLY proprietaire
    ADD CONSTRAINT proprietaire_pkey PRIMARY KEY (numprop);

ALTER TABLE ONLY saison
    ADD CONSTRAINT saison_pkey PRIMARY KEY (saison);

ALTER TABLE ONLY chambres
    ADD CONSTRAINT chambres_ibfk_1 FOREIGN KEY (numgite) REFERENCES gites(numgite) ON UPDATE CASCADE;

ALTER TABLE ONLY facturer
    ADD CONSTRAINT facturer_ibfk_1 FOREIGN KEY (saison) REFERENCES saison(saison) ON UPDATE CASCADE;

ALTER TABLE ONLY facturer
    ADD CONSTRAINT facturer_ibfk_2 FOREIGN KEY (numgite) REFERENCES gites(numgite) ON UPDATE CASCADE;

ALTER TABLE ONLY proposer_par
    ADD CONSTRAINT fk_pr FOREIGN KEY (numgite, numact) REFERENCES proposer(numgite, numact) ON UPDATE CASCADE;

ALTER TABLE ONLY proposer_par
    ADD CONSTRAINT fk_pro_org FOREIGN KEY (id_orga) REFERENCES organisme(id_orga) ON UPDATE CASCADE;

ALTER TABLE ONLY proposer
    ADD CONSTRAINT fk_proposer_activite FOREIGN KEY (numact) REFERENCES activites(numact) ON UPDATE CASCADE;

ALTER TABLE ONLY proposer
    ADD CONSTRAINT fk_proposer_gite FOREIGN KEY (numgite) REFERENCES gites(numgite) ON UPDATE CASCADE;

ALTER TABLE ONLY gites
    ADD CONSTRAINT gites_numprop_fkey FOREIGN KEY (numprop) REFERENCES proprietaire(numprop) ON UPDATE CASCADE;

ALTER TABLE ONLY louer
    ADD CONSTRAINT louer_ibfk_1 FOREIGN KEY (numgite) REFERENCES gites(numgite) ON UPDATE CASCADE;

ALTER TABLE ONLY louer
    ADD CONSTRAINT louer_ibfk_2 FOREIGN KEY (numcli) REFERENCES clients(numcli) ON UPDATE CASCADE;
