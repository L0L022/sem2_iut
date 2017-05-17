/*
   Commandes de cration de la base Films,  test avec MySQL et PostgreSQL.
*/

/* Creation des tables                           */
DROP SCHEMA TP_bd_film CASCADE;
create schema TP_bd_film;
set search_path= TP_bd_film;

CREATE TABLE Internaute (email VARCHAR (70) NOT NULL,
                         nom VARCHAR (30) NOT NULL ,
                         prenom VARCHAR (30) NOT NULL,
                         region VARCHAR (30),
                         CONSTRAINT PKInternaute PRIMARY KEY (email)
                         );

CREATE TABLE Pays (codepays    VARCHAR(4) NOT NULL,
                   nom  VARCHAR (30) DEFAULT 'Inconnu' NOT NULL,
                   langue VARCHAR (30) NOT NULL,
                   CONSTRAINT PKPays PRIMARY KEY (codepays)
                   );

CREATE TABLE Artiste  (idArtiste INTEGER NOT NULL,
                       nom VARCHAR (30) NOT NULL,
                       prenom VARCHAR (30) NOT NULL,
                       anneeNaiss INTEGER,
                       CONSTRAINT PKArtiste PRIMARY KEY (idArtiste),
                       CONSTRAINT UniqueNomArtiste UNIQUE (nom, prenom)
                       );

CREATE TABLE Film  (idFilm INTEGER NOT NULL,
                    titre    VARCHAR (50) NOT NULL,
                    annee    INTEGER NOT NULL,
                    idArtiste    INTEGER,
                    genre VARCHAR (20) NOT NULL,
                    resume      TEXT,
                    codePays    VARCHAR (4),
                    CONSTRAINT PKFilm PRIMARY KEY (idFilm),
                    CONSTRAINT FK_Film_Artiste FOREIGN KEY (idArtiste) REFERENCES Artiste(idArtiste),
                    CONSTRAINT FK_Film_Pays FOREIGN KEY (codePays) REFERENCES Pays(codepays)
                    );

CREATE TABLE Notation (idFilm INTEGER NOT NULL,
                       email  VARCHAR (40) NOT NULL,
                       note  INTEGER NOT NULL,
                       CONSTRAINT PKNotation PRIMARY KEY (idFilm, email),
                       CONSTRAINT FK_Notation_Film FOREIGN KEY (idFilm) REFERENCES Film(idFilm),
                       CONSTRAINT FK_Notation_Internaute FOREIGN KEY (email) REFERENCES Internaute(email)
                       );


CREATE TABLE Role (idFilm  INTEGER NOT NULL,
                   idArtiste INTEGER NOT NULL,
                   nomRole  VARCHAR(60),
                   CONSTRAINT PKRole PRIMARY KEY (idArtiste,idFilm),
                   CONSTRAINT PK_Role_Film FOREIGN KEY (idFilm) REFERENCES Film(idFilm),
                   CONSTRAINT PK_Role_Artiste FOREIGN KEY (idArtiste) REFERENCES Artiste(idArtiste)
                   );

INSERT INTO Pays (codepays, nom, langue) VALUES ('FR', 'France', 'Fran�ais');
INSERT INTO Pays (codepays, nom, langue) VALUES ('USA', 'Etats Unis', 'Anglais');
INSERT INTO Pays (codepays, nom, langue) VALUES ('IT', 'Italie', 'Italien');
INSERT INTO Pays (codepays, nom, langue) VALUES ('GB', 'Royaume-Uni', 'Anglais');
INSERT INTO Pays (codepays, nom, langue) VALUES ('DE', 'Allemagne', 'Allemand');
INSERT INTO Pays (codepays, nom, langue) VALUES ('JP', 'Japon', 'Japonais');

INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (6,'Cameron','James',1954);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (3,'Hitchcock','Alfred',1899);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (4,'Scott','Ridley',1937);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (5,'Weaver','Sigourney',1949);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (9,'Tarkovski','Andrei',1932);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (10,'Woo','John',1946);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (11,'Travolta','John',1954);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (12,'Cage','Nicolas',1964);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (13,'Burton','Tim',1958);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (14,'Depp','Johnny',1964);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (15,'Stewart','James',1908);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (16,'Novak','Kim',1925);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (17,'Mendes','Sam',1965);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (18,'Spacey','Kevin',1959);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (19,'Bening','Anette',1958);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (20,'Eastwood','Clint',1930);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (21,'Hackman','Gene',1930);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (22,'Freeman','Morgan',1937);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (23,'Crowe','Russell',1964);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (24,'Ford','Harrison',1942);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (25,'Hauer','Rutger',1944);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (26,'McTierman','John',1951);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (27,'Willis','Bruce',1955);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (28,'Harlin','Renny',1959);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (29,'Pialat','Maurice',1925);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (30,'Dutronc','Jacques',1943);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (31,'Fincher','David',1962);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (32,'Pitt','Brad',1963);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (33,'Gilliam','Terry',1940);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (34,'Annaud','Jean-Jacques',1943);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (35,'Connery','Sean',1930);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (36,'Slater','Christian',1969);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (37,'Tarantino','Quentin',1963);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (38,'Jackson','Samuel L.',1948);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (39,'Arquette','Rosanna',1959);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (40,'Thurman','Uma',1970);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (41,'Farrelly','Bobby',1958);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (42,'Diaz','Cameron',1972);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (43,'Dillon','Mat',1964);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (44,'Schwartzenegger','Arnold',1947);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (45,'Spielberg','Steven',1946);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (46,'Scheider','Roy',1932);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (47,'Shaw','Robert',1927);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (48,'Dreyfus','Richard',1947);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (49,'Demme','Jonathan',1944);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (50,'Hopkins','Anthony',1937);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (51,'Foster','Jodie',1962);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (53,'Kilmer','Val',1959);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (54,'Fiennes','Ralph',1962);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (55,'Pfeiffer','Michelle',1957);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (56,'Bullock','Sandra',1964);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (57,'Goldblum','Jeff',1952);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (58,'Emmerich','Roland',1955);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (59,'Broderick','Matthew',1962);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (60,'Reno','Jean',1948);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (61,'Wachowski','Andy',1967);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (62,'Reeves','Keanu',1964);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (63,'Fishburne','Laurence',1961);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (64,'De Palma','Brian',1940);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (65,'Cruise','Tom',1962);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (66,'Voight','John',1938);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (67,'Bart','Emmanuelle',1965);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (68,'Kurozawa','Akira',1910);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (69,'Harris','Ed',1950);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (70,'Linney','Laura',1964);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (71,'Girault','Jean',1924);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (72,'De Funs','Louis',1914);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (73,'Galabru','Michel',1922);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (224,'Swank','Hillary',1974);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (75,'Balasko','Josiane',1950);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (76,'Lavanant','Dominique',1944);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (77,'Lanvin','Grard',1950);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (78,'Villeret','Jacques',1951);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (79,'Levinson','Barry',1942);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (80,'Hoffman','Dustin',1937);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (81,'Scott','Tony',1944);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (82,'McGillis','Kelly',1957);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (83,'Leconte','Patrice',1947);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (84,'Blanc','Michel',1952);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (85,'Clavier','Christian',1952);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (86,'Lhermite','Thierry',1952);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (88,'Perkins','Anthony',1932);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (89,'Miles','Vera',1929);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (90,'Leigh','Janet',1927);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (91,'Marquand','Richard',1938);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (92,'Hamill','Mark',1951);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (93,'Fisher','Carrie',1956);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (94,'Taylor','Rod',1930);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (95,'Hedren','Tippi',1931);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (96,'Ricci','Christina',1980);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (97,'Walken','Christopher',1943);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (98,'Keitel','Harvey',1939);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (99,'Roth','Tim',1961);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (100,'Penn','Chris',1966);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (101,'Kubrick','Stanley',1928);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (102,'Kidman','Nicole',1967);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (103,'Nicholson','Jack',1937);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (104,'Kelly','Grace',1929);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (105,'Grant','Cary',1904);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (106,'Saint','Eva Marie',1924);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (107,'Mason','James',1909);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (110,'DiCaprio','Leonardo',1974);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (109,'Winslet','Kate',1975);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (111,'Besson','Luc',1959);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (112,'Jovovich','Milla',1975);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (113,'Dunaway','Fane',1941);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (114,'Malkovitch','John',1953);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (115,'Karyo','Tchky',1953);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (116,'Oldman','Gary',1958);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (117,'Holm','Ian',1931);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (118,'Portman','Natalie',1981);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (119,'Parillaud','Anne',1960);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (120,'Anglade','Jean-Hughes',1955);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (121,'Barr','Jean-Marc',1960);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (122,'Ferrara','Abel',1951);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (123,'Caruso','David',1956);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (124,'Snipes','Wesley',1962);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (125,'Sciora','Annabella',1964);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (126,'Rosselini','Isabella',1952);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (127,'Gallo','Vincent',1961);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (128,'von Trier','Lars',1956);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (129,'Gudmundsdottir','Bjork',1965);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (130,'Deneuve','Catherine',1943);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (131,'Kassowitz','Matthieu',1967);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (132,'Cassel','Vincent',1966);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (133,'Gray','James',1969);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (134,'Wahlberg','Mark',1971);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (135,'Phoenix','Joaquin',1974);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (136,'Theron','Charlize',1975);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (137,'Caan','James',1940);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (138,'Chabrol','Claude',1930);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (139,'Huppert','Isabelle',1953);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (140,'Mouglalis','Anna',1978);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (141,'Costner','Kevin',1955);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (142,'Dern','Laura',1967);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (143,'Hanks','Tom',1956);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (144,'Sizemore','Tom',1964);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (145,'Damon','Matt',1970);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (146,'Modine','Matthew',1959);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (147,'Baldwin','Adam',1962);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (148,'O''Neal','Ryan',1941);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (149,'Berenson','Marisa',1946);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (150,'McDowell','Macolm',1943);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (151,'Dullea','Keir',1936);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (152,'Lockwood','Gary',1937);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (153,'Sellers','Peter',1925);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (154,'Scott','George',1927);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (155,'Hayden','Sterling',1916);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (156,'Douglas','Kirk',1916);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (157,'Donat','Robert',1905);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (158,'Caroll','Madeleine',1906);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (159,'Olivier','Laurence',1907);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (160,'Fontaine','Joan',1917);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (161,'Sanders','George',1906);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (162,'Bergman','Ingrid',1915);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (163,'Rains','Claude',1889);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (164,'Milland','Ray',1907);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (166,'Day','Doris',1924);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (167,'De Niro','Robert',1943);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (168,'Grier','Pam',1949);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (169,'Fonda','Bridget',1964);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (170,'Keaton','Michael',1951);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (171,'Shyamalan','M. Night',1970);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (172,'Osment','Haley Joel',1988);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (173,'Collette','Tony',1972);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (174,'Leighton','Eric',1962);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (175,'Mann','Michael',1943);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (176,'Pacino','Al',1940);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (177,'Crowe','Russel',1964);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (178,'Plummer','Christopher',1927);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (179,'Furlong','Edward',1977);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (180,'Redgrave','Vanessa',1937);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (181,'Coppola','Francis Ford',1939);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (182,'Brando','Marlon',1924);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (183,'Keaton','Diane',1946);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (184,'Duvall','Robert',1931);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (185,'Caan','Jamees',1939);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (186,'Garcia','Andy',1956);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (187,'Raimi','Sam',1959);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (188,'Maguire','Tobey',1975);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (210,'Moss','Carrie-Anne',1967);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (211,'Weaving','Hugo',1960);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (212,'Jackson','Samuel',1948);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (213,'Liu','Lucy',1968);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (214,'Carradine','David',1936);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (215,'Madsen','Michael',1958);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (216,'Hannah','Daryl',1960);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (217,'Buscemi','Steve',1957);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (218,'Bunker','Edward',1933);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (221,'Volonte','Gian Maria',NULL);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (220,'Van Cleef','Lee',NULL);
INSERT INTO Artiste (idArtiste, nom, prenom, anneeNaiss) VALUES (219,'Leone','Sergio',1929);

--
-- Dumping data for table `Internaute`
--

INSERT INTO Internaute (email, nom, prenom, region) VALUES ('rigaux@cnam.fr','Rigaux','Philippe','Auvergne');
INSERT INTO Internaute (email, nom, prenom, region) VALUES ('davy@bnf.fr','Davy','C�cile','Basse-Normandie');
INSERT INTO Internaute (email, nom, prenom, region) VALUES ('waller@lri.fr','Waller','Emmanuel','Aquitaine');

--
-- Dumping data for table `Film`
--

INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (1,'Vertigo',1958,3,'Drame','Scottie Ferguson, ancien inspecteur de police, est sujet au vertige depuis qu''il a vu mourir son\r\n coll�gue. Elster, son ami, le charge de surveiller sa femme, Madeleine, ayant des tendances\r\n suicidaires. Amoureux de la jeune femme Scottie ne remarque pas le pi�ge qui se trame autour\r\n de lui et dont il va �tre la victime... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (2,'Alien',1979,4,'Science-fiction','Pr�s d''un vaisseau spatial �chou� sur une lointaine plan�te, des Terriens en mission d�couvrent\r\n de bien �tranges \"oeufs\". Ils en ram�nent un � bord, ignorant qu''ils viennent d''introduire parmi\r\n eux un huiti�me passager particuli�rement f�roce et meurtrier. ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (3,'Titanic',1997,6,'Drame','Conduite par Brock Lovett, une exp�dition am�ricaine fouillant l''�pave du Titanic remonte � la\r\n surface le croquis d''une femme nue. Alert�e par les m�dias la dame en question, Rose DeWitt\r\n Bukater, aujourd''hui centenaire, rejoint les lieux du naufrage, d''o� elle entreprend de conter le\r\n r�cit de son fascinant, �trange et tragique voyage... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (4,'Sacrifice',1986,9,'Drame','','FR');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (5,'Volte/Face',1997,10,'Action','Directeur d''une unit� anti-terroriste, Sean Archer recherche Castor Troy, un criminel responsable de la\r\n mort de son fils six ans plus t�t. Il parvient � l''arr�ter mais apprend que Troy a cach� une bombe au Palais\r\n des Congr�s de Los Angeles. Seul le fr�re de Troy peut la d�samorcer et, pour l''approcher, Archer se fait\r\n greffer le visage de Troy. ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (6,'Sleepy Hollow',1999,13,'Fantastique','Nouvelle Angleterre, 1799. A Sleepy Hollow, plusieurs cadavres sont retrouv�s d�capit�s. La\r\n                                      rumeur attribue ces meurtres � un cavalier lui-m�me sans t�te. Mais le fin limier\r\n                                      new-yorkais Ichabod Crane ne croit pas en ses aberrations. Tomb� sous le charme de la\r\n                                      v�n�neuse Katrina, il m�ne son enqu�te au coeur des sortil�ges de Sleepy Hollow.. ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (7,'American Beauty',1999,17,'Com�die','Lester Burnham, sa femme Carolyn et leur fille Jane m�nent apparemment une vie des plus\r\n heureuses dans leur belle banlieue. Mais derri�re cette respectable fa�ade se tisse une �trange\r\n et grin�ante tragi-com�die familiale o� d�sirs inavou�s, frustrations et violences refoul�es\r\n conduiront inexorablement un homme vers la mort. ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (8,'Impitoyable',1992,20,'Western','L�gendaire hors-la-loi, William Munny s''est reconverti depuis onze ans en paisible fermier. Il\r\n reprend n�anmoins les armes pour traquer deux tueurs en compagnie de son vieil ami Ned\r\n Logan. Mais ce dernier est captur�, puis �x�cute. L''honneur et l''amiti� imposent d�s lors �\r\n Munny de redevenir une derni�re fois le h�ros qu''il fut jadis... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (9,'Gladiator',2000,4,'Drame','Le g�n�ral romain Maximus est le plus fid�le\r\n                    soutien de l''empereur Marc Aur�le, qu''il a\r\n                    conduit de victoire en victoire avec une\r\n                    bravoure et un d�vouement exemplaires.\r\n                    Jaloux du prestige de Maximus, et plus\r\n                    encore de l''amour que lui voue l''empereur,\r\n                    le fils de Marc-Aur�le, Commode, s''arroge\r\n                    brutalement le pouvoir, puis ordonne\r\n                    l''arrestation du g�n�ral et son ex�cution.\r\n                    Maximus �chappe � ses assassins mais ne peut\r\n                    emp�cher le massacre de sa famille. Captur�\r\n                    par un marchand d''esclaves, il devient\r\n                    gladiateur et pr�pare sa vengeance.','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (10,'Blade Runner',1982,4,'Action','En 2019, lors de la d�cadence de Los Angeles, des �tres synth�tiques, sans pens�e, sans\r\n �motions, suffisent aux diff�rents travaux d''entretien. Leur dur�e de vie n''exc�de pas 4 ann�es.\r\n Un jour, ces ombres humaines se r�voltent et on charge les tueurs, appel�s Blade Runner, de\r\n les abattre... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (11,'Pi�ge de cristal',1988,26,'Action','John Mc Clane, policier new-yorkais, vient passer Noel a Los Angeles aupres de sa femme.\r\n Dans le building ou elle travaille, il se retrouve temoin de la prise en otage de tout le personnel\r\n par 12 terroristes. Objectif de ces derniers, vider les coffres de la societe. Cache mais isole, il\r\n entreprend de prevenir l''exterieur...','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (12,'58 minutes pour vivre',1990,28,'Action','\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n Venu attendre sa femme a l''a�roport, le policier John McClane remarque la pr�sence de\r\n terroristes qui ont pris le contr�le des pistes, emp�chant tout avion d''atterrir et mena�ant de\r\n laisser les appareils en vol tourner jusqu''� �puisement de leur k�ros�ne. John n''a devant lui que\r\n 58 minutes pour �viter la catastrophe... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (13,'Van Gogh',1990,29,'Drame','Les derniers jours de la vie de Vincent Van Gogh, r�fugi� � Auvers-sur-Oise, pr�s de chez son\r\n ami et protecteur le docteur Gachet, un ami de son fr�re Th�o. Ce peintre maudit, que les\r\n villageois surnommaient \"le fou\", n''avait alors plus que deux mois � vivre, qu''il passa en\r\n peignant un tableau par jour. ','FR');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (14,'Seven',1995,31,'Policier','A New York, un criminel anonyme a d�cid� de commettre 7 meurtres bas�s sur les 7 p�ch�s\r\n capitaux �nonc�s dans la Bible : gourmandise, avarice, paresse, orgueil, luxure, envie et col�re.\r\n Vieux flic blas� � 7 jours de la retraite, l''inspecteur Somerset m�ne l''enqu�te tout en formant\r\n son rempla�ant, l''ambitieux inspecteur David Mills... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (15,'L''arm�e des douze singes',1995,33,'Science-fiction','','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (16,'Le nom de la rose',1986,34,'Policier','En l''an 1327, dans une abbaye b�n�dictine, le moine franciscain Guillaume de Baskerville,\r\n accompagn� de son jeune novice Adso, enqu�te sur de myst�rieuses morts qui frappent la\r\n confr�rie. Le secret semble r�sider dans la biblioth�que, o� le vieux Jorge garde jalousement un\r\n livre jug� maudit. ','FR');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (17,'Pulp fiction',1994,37,'Action','Pulp Fiction d�crit l''odyss�e sanglante et burlesque de petits malfrats dans la jungle de\r\n Hollywood, ou s''entrecroisent les destins de deux petits tueurs, d''un dangereux gangster mari�\r\n � une cam�e, d''un boxeur roublard, de pr�teurs sur gages sadiques, d''un ca�d �l�gant et\r\n d�vou�, d''un dealer bon mari et de deux tourtereaux � la gachette facile... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (18,'Mary � tout prix',1998,41,'Com�die','Pour retrouver l''amour de sa jeunesse, la belle Mary, Ted-le-looser engage Pat Healy, un\r\n priv�. Subjug� par la jeune femme, ce dernier tente de la s�duire en se faisant passer pour un\r\n architecte. Il cache la v�rit� � Ted et fait cause commune avec Tucker, un autre pr�tendant,\r\n pour se d�barrasser de l''encombrant Ted... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (19,'Terminator',1984,6,'Science-fiction','Deux creatures venues du futur debarquent sur terre. L''une d''entre elles, le Terminator, doit\r\n eliminer une certaine Sarah Connor, qui doit enfanter celui qui sera le chef d''un groupe de\r\n resistants. L''autre, Kyle Reese, est charge par les rebelles de defendre Sarah... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (20,'Les dents de la mer',1975,45,'Horreur','Dans la station baln�aire d''Amityville, un requin g�ant frappe � plusieurs reprises. Soucieux\r\n d''une bonne saison touristique, le maire interdit au sherif Brody de fermer les plages. Une prime\r\n est offerte et le c�l�bre chasseur de requin Quint se lance avec Brody et l''ichtyologue Hooper �\r\n la poursuite du monstre... ','FR');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (21,'Le silence des agneaux',1990,49,'Policier','Afin de retrouver la piste d''un tueur surnomm� Buffalo Bill car il scalpe les femmes qu''il\r\n assassine, la jeune stagiaire du FBI Clarice Starling est d�p�ch�e aupr�s d''Hannibal Lecter,\r\n prisonnier pour avoir d�vor� ses victimes. La coop�ration de ce dernier devrait permettre �\r\n Clarice de saisir et d''anticiper le comportement de Buffalo... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (22,'Godzilla',1998,58,'Action','Issu des radiations atomiques engendr�es par les essais nucl�aires en Polyn�sie, un monstre\r\n gigantesque, aussi haut qu''un building, se dirige vers New York, semant le chaos sur son\r\n passage. Pour tenter de stopper cette cr�ature destructrice, l''arm�e s''associe � une �quipe de\r\n scientifiques am�ricains et � un �nigmatique enqu�teur fran�ais... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (23,'Matrix',1999,61,'Science-fiction','Dans un monde o� tout ce qui semble r�el est en fait �labor� par l''univers �lectronique baptis�\r\n la Matrice, N�o, un programmeur, est contact� par un certain Morpheus. D''apr�s lui, N�o\r\n serait le Lib�rateur tant attendu, le seul capable de mettre en �chec l''omnipotence de la\r\n Matrice et rendre ses droits � la r�alit�... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (24,'Mission: Impossible',1996,64,'Action','Charg� d''une nouvelle mission, l''agent du contre espionnage Ethan Hunt tombe avec son\r\n �quipe dans un pi�ge sanglant. Seul survivant avec Claire, la jeune �pouse de son regrett� chef\r\n Jim Phelps, Ethan se retrouve accus� de trahison. En fuite, il pr�pare sa contre-attaque,\r\n recrutant l''homme de main Krieger et le pirate informatique Luther... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (25,'Kagemusha',1980,68,'Guerre','Au XVIe siecle, Takeda, grand seigneur trouble par les guerres civiles de son pays, fait appel a\r\n un Kagemusha pour l''aider dans ses batailles. Takeda est blesse et avant de mourir, il exige que\r\n sa mort soit tenue secrete pendant trois ans afin d''eviter un eclatement du clan. Le Kagemusha\r\n devra le remplacer... ','JP');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (26,'Les pleins pouvoirs',1997,20,'Policier','Luther Whitney est l''as des cambrioleurs. Occup� � vider le coffre de l''influent Walter Sullivan,\r\n il est t�moin d''un meurtre sadique impliquant le Pr�sident des Etats-Unis et les services\r\n secrets. Soup�onn� par la police d''en �tre l''auteur, il se retrouve �galement traqu� par les\r\n tueurs, qui ont compris qu''ils ont �t� observ�s.','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (27,'Le gendarme et les extra-terrestres',1978,71,'Com�die','En anglais: Gendarme and the Creatures from Outer Space !\r\n','FR');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (28,'Le monde perdu',1997,45,'Horreur','','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (29,'Rain Man',1988,79,'Drame','A la mort de son p�re, Charlie se voit d�poss�der de son h�ritage par un fr�re dont il ignorait\r\n l''existence, Raymond. Celui-ci est autiste et vit dans un h�pital psychiatrique. Charlie enl�ve\r\n Raymond afin de prouver qu''il est capable de s''en occuper et de toucher l''h�ritage. ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (30,'Top Gun',1986,81,'Action','\r\n Pilote de chasse �m�rite mais casse-cou Maverick Mitchell est admis � Top Gun, l''�cole de\r\n l''�lite de l''a�ronavale. Son manque de prudence lui attire les foudres de ses sup�rieurs et la\r\n haine de certains co�quipiers. Il perd subitement la foi et confiance en lui quand son ami de\r\n toujours meurt en vol et qu''il s''en croit responsable... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (31,'Les bronz�s font du ski',1979,83,'Com�die','Apres avoir passe des vacances d''ete ensemble, Bernard, Nathalie, Gigi, Jerome, Popeye,\r\n Jean-Claude et Christiane se retrouvent aux sports d''hiver. Tous ont leurs problemes de coeur\r\n ou d''argent, mais il faut bien vivre avec. Avant de se separer, se perdre dans la montagne leur\r\n permet de gouter aux joies de la \"vraie vie\" paysanne... ','FR');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (32,'Le bon, la brute et le truand',1966,219,'Western','Pendant la Guerre de S�cession, trois hommes, pr�f�rant s''int�resser � leur profit personnel, se lancent � la recherche d''un coffre contenant 200 000 dollars en pi�ces d''or vol�s � l''arm�e sudiste. Tuco sait que le tr�sor se trouve dans un cimeti�re, tandis que Joe conna�t le nom inscrit sur la pierre tombale qui sert de cache. Chacun a besoin de l''autre. Mais un troisi�me homme entre dans la course : Setenza, une brute qui n''h�site pas � massacrer femmes et enfants pour parvenir � ses fins.','IT');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (33,'Psychose',1960,3,'Thriller','Apr�s avoir vol� 40 000 dollars, Marion Crane se rend dans un motel tenu par Norman Bates. Elle est\r\n poignard�e sous sa douche par une femme. Norman fait disparaitre le corps et les affaires de la jeune\r\n femme. Mais Sam, le fianc� de Marion, inquiet de ne pas avoir de nouvelles, engage un d�tective pour la\r\n retrouver... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (34,'Le retour du Jedi',1983,91,'Science-fiction','Luke Skywalker s''introduit chez Jabba pour delivrer Han Solo et la princesse Leia, tandis que l''Empire\r\n reconstruit une deuxieme \"Etoile de la Mort\". Luke se rend ensuite au chevet de Yoda qui est mourant. Il lui\r\n apprend que Leia est sa soeur. Luke forme un commando pour attaquer l''Etoile, tandis qu''il affronte son\r\n pere, Darth Vador... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (35,'Les oiseaux',1963,3,'Horreur','Melanie Daniels se rend � Bodega Bay pour offrir deux perruches en cage � Cathy, la soeur de l''avocat\r\n Mitch Brenner. Attaqu�e par une mouette, Melanie reste chez les Brenner pour la nuit. Mais d''autres\r\n �v�nements �tranges se produisent: des enfants sont bless�s par des corbeaux et la maison de Mitch est\r\n envahie par des milliers d''oiseaux. ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (36,'Reservoir dogs',1992,37,'Policier','Apr�s un hold-up manqu�, des cambrioleurs de haut vol font leurs comptes dans une confrontation violente, pour d�couvrir lequel d''entre eux les a trahis.\r\n\r\n\r\n\r\n\r\n Voleurs de profession, Joe Cabot et son fils Eddie engagent un groupe de six criminels pour le cambriolage\r\n d''un diamantaire. Malgr� toutes les pr�cautions prises, la police est sur place le jour J, et l''op�ration se\r\n solde par un massacre. Les survivants du gang se r�unissent pour r�gler leurs comptes, chacun\r\n soup�onnant l''autre d''avoir trahi. ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (37,'Eyes Wide Shut',1999,101,'Thriller','Un couple de bourgeois, c�dant � la jalousie et � l''obsession sexuelle, entreprend un voyage psychologique\r\n � la recherche de son identit�. Le mari, au bout de son p�riple nocturne, revenu de ses d�sirs, ne trouvera\r\n finalement aupr�s de son �pouse qu''un compromis banal mais complice, les yeux ouverts � tout jamais sur\r\n un r�ve impossible. ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (38,'Shining',1980,101,'Horreur','Jack Torrance s''installe avec sa femme et son fils Danny dans un h�tel ferm� � la morte saison afin d''�crire\r\n un roman. Il apprend que le gardien pr�c�dent a tu� sa femme et ses deux filles avant de se suicider. Tr�s\r\n vite, Jack va s''apercevoir que des choses �tranges se passent autour de lui et que son fils a des pouvoirs\r\n extrasensoriels... ','FR');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (39,'Pas de printemps pour Marnie',1964,3,'Thriller','Marnie est engag�e comme secr�taire chez un editeur, Mark Rutland. Celui-ci amoureux d''elle, d�couvre\r\n qu''elle est kleptomane et l''oblige � l''�pouser en la mena�ant de la d�noncer. En s''apercevant que Marnie a\r\n la phobie de la cou leur rouge, Mark tente de remonter dans le pass� de la jeune femme afin de comprendre\r\n les raisons de sa n�vrose. ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (40,'Fen�tre sur cour',1954,3,'Suspense','En repos forc� � cause d''une jambe pl�tr�e, le reporter L.B. Jefferies observe au t�l�objectif les voisins de\r\n l''immeuble d''en face. C''est ainsi qu''il remarque le curieux man�ge d''un repr�sentant de commerce, M.\r\n Thorwald, qu''il soupconne tr�s vite d''avoir assassin� sa femme... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (41,'La mort aux trousses',1959,3,'Suspense','Roger Thornhill, publiciste, est pris dans le hall de son h�tel pour un certain Kaplan, un espion. Deux\r\n hommes tentent de le tuer et quand il retrouve l''un de ses agresseurs, celui-ci est assassin� devant ses\r\n yeux. Pris pour un meurtrier, il est oblig� de fuir vers Chicago... ','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (42,'Jeanne d''Arc',1999,111,'Guerre','','FR');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (43,'Le cinqui�me �l�ment',1997,111,'Science-fiction','Au XXIII�me si�cle, dans un univers �trange et color�, o� tout espoir de survie est impossible sans la\r\n d�couverte du Cinqui�me El�ment, un h�ros peu ordinaire affronte le mal pour sauver l''humanit�. ','FR');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (44,'L�on',1994,111,'Action','\"L�on est un tueur. Un de la pire esp�ce. Il est introuvable, ind�tectable, pire qu''un sous-marin. Son ombre\r\n est comme une menace de danger permanent sur New York. Indestructible L�on ? Oui, jusqu''� ce qu''une\r\n petite souris p�n�tre son univers. Une toute petite souris aux yeux immenses...\" ','FR');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (45,'Nikita',1990,111,'Thriller','Nikita, drogu�e et violente, est prise en mains par des psychiatres qui la r��duquent, la conditionnent, afin\r\n d''en faire une tueuse � la botte des Services Secrets. Plus tard, r�alisant ce qu''elle est devenue, un pion\r\n sans vie priv�e que l''on manipule, elle tente d''�chapper � ses commanditaires. ','FR');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (46,'Le grand bleu',1988,111,'Drame','Jacques Mayol et Enzo Molinari se connaissent depuis l''enfance. Tous deux experts en apn�e, s''affrontent\r\n continuellement pour obtenir le record du monde de plong�e. Toujours en rivalit�, les deux hommes\r\n descendent de plus en plus profond, au risque de leurs vies. Le film est ressorti en janvier 89 en version\r\n longue d''une dur�e de 2h40. ','FR');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (47,'Spider-Man',2002,123,'Action','Orphelin, Peter Parker est �lev� par sa tante May et son oncle Ben dans le quartier Queens de New York. Tout en poursuivant ses �tudes � l''universit�, il trouve un emploi de photographe au journal Daily Bugle. Il partage son appartement avec Harry Osborn, son meilleur ami, et r�ve de s�duire la belle Mary Jane.\r\nCependant, apr�s avoir �t� mordu par une araign�e g�n�tiquement modifi�e, Peter voit son agilit� et sa force s''accro�tre et se d�couvre des pouvoirs surnaturels. Devenu Spider-Man, il d�cide d''utiliser ses nouvelles capacit�s au service du bien.\r\nAu m�me moment, le p�re de Harry, le richissime industriel Norman Osborn, est victime d''un accident chimique qui a d�mesur�ment augment� ses facult�s intellectuelles et sa force, mais l''a rendu fou. Il est devenu le Bouffon Vert, une cr�ature d�moniaque qui menace la ville. Entre lui et Spider-Man, une lutte sans merci s''engage.','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (48,'King of New York',1990,122,'Drame','L''histoire d''un gangster au grand coeur mais aux m�thodes d�finitives, surnomm� par le presse The King of New York et qui r�ve de fonder un h�pital, confront� a des policiers opini�tres qui ont jur� de l''abattre...','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (49,'The Matrix reloaded',2003,61,'Science-fiction','Neo apprend � mieux contr�ler ses dons naturels, alors m�me que Sion s''appr�te � tomber sous l''assaut de l''Arm�e des Machines. D''ici quelques heures, 250 000 Sentinelles programm�es pour an�antir notre esp�ce envahiront la derni�re enclave humaine de la Terre.\r\nMais Morpheus galvanise les citoyens de Sion en leur rappelant la Parole de l''Oracle : il est encore temps pour l''Elu d''arr�ter la guerre contre les Machines. Tous les espoirs se reportent d�s lors sur Neo. Au long de sa p�rilleuse plong�e au sein de la Matrix et de sa propre destin�e, ce dernier sera confront� � une r�sistance croissante, une v�rit� encore plus aveuglante, un choix encore plus douloureux que tout ce qu''il avait jamais imagin�.','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (50,'The Matrix Revolutions',2003,135,'Science-fiction','La longue qu�te de libert� des rebelles culmine en une bataille finale explosive. Tandis que l''arm�e des Machines s�me la d�solation sur Zion, ses citoyens organisent une d�fense acharn�e. Mais pourront-ils retenir les nu�es implacables des Sentinelles en attendant que Neo s''approprie l''ensemble de ses pouvoirs et mette fin � la guerre ?\r\nL''agent Smith est quant � lui parvenu � prendre possession de l''esprit de Bane, l''un des membres de l''�quipage de l''a�roglisseur. De plus en plus puissant, il est d�sormais incontr�lable et n''ob�it plus aux Machines : il menace de d�truire leur empire ainsi que le monde r�el et la Matrice...\r\n\r\n	','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (51,'De bruit et de fureur',1988,138,'Drame','L''histoire de Bruno, enfant attard� des banlieues et des H.L.M., plong� dans la violence de son milieu, et dont la vie va se consumer comme une �toile filante.','FR');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (52,'Usual suspects',1995,142,'Thriller','Une l�gende du crime contraint cinq malfrats � aller s''aquitter d''une t�che tr�s p�rilleuse. Ceux qui survivent pourront se partager un butin de 90 millions de dollars.','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (53,'Bad Lieutenant',1992,122,'Drame','La descente aux enfers d''un flic pourri qui enquete sur le viol d''une jolie religieuse.','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (54,'Le parrain',1972,64,'Drame','En 1945, � New York, les Corleone sont une des cinq familles de la mafia. Don Vito Corleone, \" parrain \" de cette famille, marie sa fille � un bookmaker. Sollozzo, \" parrain \" de la famille Tattaglia, propose � Don Vito une association dans le trafic de drogue, mais celui-ci refuse. Sonny, un de ses fils, y est quant � lui favorable.\r\nAfin de traiter avec Sonny, Sollozzo tente de faire tuer Don Vito, mais celui-ci en r�chappe. Michael, le fr�re cadet de Sonny, recherche alors les commanditaires de l''attentat et tue Sollozzo et le chef de la police, en repr�sailles.\r\nMichael part alors en Sicile, o� il �pouse Apollonia, mais celle-ci est assassin�e � sa place. De retour � New York, Michael �pouse Kay Adams et se pr�pare � devenir le successeur de son p�re...','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (55,'Le parrain II',1974,64,'Drame','A la mort de Vito Corleone, dit \"le Parrain\", c''est son fils, Michael, qui reprend les affaires familiales. Tr�s vite, son ascension dans le milieu mafiosi est fulgurante.\r\n\r\nDepuis la mort De Don Vito Corleone, son fils, Michael, r�gne sur la famille. Amen� � n�gocier avec la mafia juive, il perd alors le soutien d''un de ses lieutenants, Frankie Pentageli. Echappant de justesse � un attentat, Michael tente de retrouver le coupable, soup�onnant Hyman Roth, le chef de la mafia juive.\r\nVito Corleone, immigrant italien, arrive � New York au d�but du si�cle ; tr�s vite, il devient un des ca�ds du quartier, utilisant la violence comme moyen de r�gler toutes les affaires. Seul au d�part, il b�tit peu � peu un v�ritable empire, origine de la fortune de la famille des Corleone.\r\n	','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (56,'Le parrain III',1990,64,'Drame','Atteignant la soixantaine, Michael Corleone d�sire � la fois renouer avec les siens et se r�habiliter aux yeux de la soci�t�, surtout de l''Eglise. Il arrivera presque a ses fins, mais sa vie pass�e et ses anciens ennemis le rattraperont plus vite.\r\n\r\nMichael Corleone est fatigu�. Il veut prendre ses distances avec les activit�s mafieuses de sa famille. Il veut convertir ces activit�s en affaires l�gales. Kay, son ex-femme, lui fait m�me accepter que leur fils devienne un chanteur d''op�ra et ne reprenne pas les activit�s familiales.\r\nPendant ce temps, la fille de Michael, Mary, et son neveu, le fils de Sonny, Vincent, nouent une idylle qui n''est pas la bienvenue dans la famille.\r\nIl d�cide d''aider le Vatican � renflouer ses caisses et re�oit en �change le contr�le d''une entreprise immobili�re leur appartenant. Attisant la jalousie de ses pairs, Michael �chappe de justesse � un attentat commis par l''un d''eux. Vincent se propose alors pour reprendre les affaires de la famille en main.','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (57,'Jackie Brown',1997,37,'Policier','Jackie Brown, h�tesse de l''air, arrondit ses fins de mois en convoyant de l''argent liquide pour le compte d''un trafiquant d''armes, Ordell Robbie. Un jour, un agent federal et un policier de Los Angeles la cueillent � l''a�roport. Ils comptent sur elle pour faire tomber le trafiquant. Jackie �chafaude alors un plan audacieux pour doubler tout le monde lors d''un prochain transfert qui porte sur la modeste somme de cinq cent mille dollars. Mais il lui faudra compter avec les complices d''Ordell, qui ont des m�thodes plut�t exp�ditives.','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (58,'Une journ�e en enfer',1995,168,'Action','John McClane est cette fois-ci aux prises avec un ma�tre chanteur, fac�tieux et dangereux, qui d�pose des bombes dans New York.','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (59,'Sixi�me sens',1999,170,'Fantastique','Cole Sear, garconnet de huit ans est hant� par un terrible secret. Son imaginaire est visit� par des esprits menacants. Trop jeune pour comprendre le pourquoi de ces apparitions et traumatis� par ces pouvoirs paranormaux, Cole s''enferme dans une peur maladive et ne veut reveler � personne la cause de son enfermement, � l''exception d''un psychologue pour enfants. La recherche d''une explication rationnelle guidera l''enfant et le th�rapeute vers une v�rit� foudroyante et inexplicable.','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (60,'Lost in Translation',2003,172,'Com�die sentimentale','Bob Harris, acteur sur le d�clin, se rend � Tokyo pour touner un spot publicitaire. Il a conscience qu''il se trompe - il devrait �tre chez lui avec sa famille, jouer au th��tre ou encore chercher un r�le dans un film -, mais il a besoin d''argent.\r\nDu haut de son h�tel de luxe, il contemple la ville, mais ne voit rien. Il est ailleurs, d�tach� de tout, incapable de s''int�grer � la r�alit� qui l''entoure, incapable �galement de dormir � cause du d�calage horaire.\r\nDans ce m�me �tablissement, Charlotte, une jeune Am�ricaine fra�chement dipl�m�e, accompagne son mari, photographe de mode. Ce dernier semble s''int�resser davantage � son travail qu''� sa femme. Se sentant d�laiss�e, Charlotte cherche un peu d''attention. Elle va en trouver aupr�s de Bob...','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (61,'Kill Bill',2003,37,'Drame','Au cours d''une c�r�monie de mariage en plein d�sert, un commando fait irruption dans la chapelle et tire sur les convives. Laiss�e pour morte, la Mari�e enceinte retrouve ses esprits apr�s un coma de quatre ans.\r\nCelle qui a auparavant exerc� les fonctions de tueuse � gages au sein du D�tachement International des Vip�res Assassines n''a alors plus qu''une seule id�e en t�te : venger la mort de ses proches en �liminant tous les membres de l''organisation criminelle, dont leur chef Bill qu''elle se r�serve pour la fin.','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (62,'Stalingrad',2001,34,'Drame','','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (63,'Million Dollar Baby',2005,20,'Drame','Une histoire d''amour tragique et platonique entre une boxeuse et un vieil entra�neur de trente ans son a�n�.','USA');
INSERT INTO Film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (64,'Pour quelques dollars de plus',1965,219,'Western','Le colonel Douglas Mortimer collabore avec un chasseur de primes surnomm� L''\"Etranger\". Tous les deux souhaitent capturer Indio, un tueur fou, qui s�me la terreur autour de lui. Ce dernier et ses hommes sont sur le point de piller la banque d''El Paso.','IT');

--
-- Dumping data for table `Notation`
--

INSERT INTO Notation (idFilm, email, note) VALUES (1,'davy@bnf.fr',2);
INSERT INTO Notation (idFilm, email, note) VALUES (2,'rigaux@cnam.fr',5);
INSERT INTO Notation (idFilm, email, note) VALUES (3,'rigaux@cnam.fr',5);
INSERT INTO Notation (idFilm, email, note) VALUES (4,'davy@bnf.fr',1);
INSERT INTO Notation (idFilm, email, note) VALUES (5,'davy@bnf.fr',4);
INSERT INTO Notation (idFilm, email, note) VALUES (5,'waller@lri.fr',2);
INSERT INTO Notation (idFilm, email, note) VALUES (6,'davy@bnf.fr',4);
INSERT INTO Notation (idFilm, email, note) VALUES (7,'davy@bnf.fr',4);
INSERT INTO Notation (idFilm, email, note) VALUES (7,'waller@lri.fr',5);
INSERT INTO Notation (idFilm, email, note) VALUES (10,'davy@bnf.fr',4);
INSERT INTO Notation (idFilm, email, note) VALUES (10,'waller@lri.fr',3);
INSERT INTO Notation (idFilm, email, note) VALUES (11,'waller@lri.fr',5);
INSERT INTO Notation (idFilm, email, note) VALUES (12,'waller@lri.fr',3);
INSERT INTO Notation (idFilm, email, note) VALUES (13,'rigaux@cnam.fr',4);
INSERT INTO Notation (idFilm, email, note) VALUES (14,'davy@bnf.fr',2);
INSERT INTO Notation (idFilm, email, note) VALUES (14,'rigaux@cnam.fr',3);
INSERT INTO Notation (idFilm, email, note) VALUES (17,'waller@lri.fr',1);
INSERT INTO Notation (idFilm, email, note) VALUES (18,'waller@lri.fr',3);
INSERT INTO Notation (idFilm, email, note) VALUES (19,'davy@bnf.fr',3);
INSERT INTO Notation (idFilm, email, note) VALUES (19,'rigaux@cnam.fr',2);
INSERT INTO Notation (idFilm, email, note) VALUES (20,'davy@bnf.fr',4);
INSERT INTO Notation (idFilm, email, note) VALUES (20,'rigaux@cnam.fr',4);
INSERT INTO Notation (idFilm, email, note) VALUES (22,'davy@bnf.fr',4);
INSERT INTO Notation (idFilm, email, note) VALUES (22,'waller@lri.fr',5);
INSERT INTO Notation (idFilm, email, note) VALUES (24,'rigaux@cnam.fr',3);
INSERT INTO Notation (idFilm, email, note) VALUES (24,'waller@lri.fr',2);
INSERT INTO Notation (idFilm, email, note) VALUES (25,'davy@bnf.fr',5);
INSERT INTO Notation (idFilm, email, note) VALUES (27,'waller@lri.fr',4);
INSERT INTO Notation (idFilm, email, note) VALUES (28,'davy@bnf.fr',2);
INSERT INTO Notation (idFilm, email, note) VALUES (30,'waller@lri.fr',3);
INSERT INTO Notation (idFilm, email, note) VALUES (31,'waller@lri.fr',3);
INSERT INTO Notation (idFilm, email, note) VALUES (33,'davy@bnf.fr',5);
INSERT INTO Notation (idFilm, email, note) VALUES (37,'davy@bnf.fr',3);
INSERT INTO Notation (idFilm, email, note) VALUES (38,'davy@bnf.fr',3);
INSERT INTO Notation (idFilm, email, note) VALUES (40,'davy@bnf.fr',2);
INSERT INTO Notation (idFilm, email, note) VALUES (41,'davy@bnf.fr',3);
INSERT INTO Notation (idFilm, email, note) VALUES (41,'rigaux@cnam.fr',5);
INSERT INTO Notation (idFilm, email, note) VALUES (43,'rigaux@cnam.fr',2);
INSERT INTO Notation (idFilm, email, note) VALUES (44,'davy@bnf.fr',1);
INSERT INTO Notation (idFilm, email, note) VALUES (44,'waller@lri.fr',4);
INSERT INTO Notation (idFilm, email, note) VALUES (45,'davy@bnf.fr',3);
INSERT INTO Notation (idFilm, email, note) VALUES (45,'rigaux@cnam.fr',3);
INSERT INTO Notation (idFilm, email, note) VALUES (47,'waller@lri.fr',2);
INSERT INTO Notation (idFilm, email, note) VALUES (51,'davy@bnf.fr',5);
INSERT INTO Notation (idFilm, email, note) VALUES (52,'davy@bnf.fr',5);
INSERT INTO Notation (idFilm, email, note) VALUES (53,'davy@bnf.fr',2);
INSERT INTO Notation (idFilm, email, note) VALUES (54,'rigaux@cnam.fr',5);
INSERT INTO Notation (idFilm, email, note) VALUES (58,'davy@bnf.fr',3);
INSERT INTO Notation (idFilm, email, note) VALUES (58,'waller@lri.fr',2);
INSERT INTO Notation (idFilm, email, note) VALUES (61,'davy@bnf.fr',3);
INSERT INTO Notation (idFilm, email, note) VALUES (61,'rigaux@cnam.fr',4);

--
-- Dumping data for table `Role`
--

INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (1,15,'John Ferguson');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (1,16,'Madeleine Elster');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (2,5,'Ripley');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (3,109,'Rose DeWitt Bukater');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (3,110,'Jack Dawson');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (5,11,'Sean Archer/Castor Troy');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (5,12,'Castor Troy/Sean Archer');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (6,14,'Constable Ichabod Crane');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (6,96,'Katrina Anne Van Tassel');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (6,97,'Le cavalier');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (7,18,'Lester Burnham');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (7,19,'Carolyn Burnham');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (8,20,'William Munny');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (8,21,'Little Bill Dagget');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (8,22,'Ned Logan');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (9,23,'Maximus');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (9,147,'Commode');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (9,148,'Lucilla');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (9,149,'Marc Aurele');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (10,24,'Deckard');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (10,25,'Batty');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (11,27,'McClane');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (12,27,'McClane');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (13,30,'Van Gogh');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (14,18,'Doe');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (14,22,'Somerset');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (14,32,'Mills');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (15,27,'Cole');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (16,35,'Baskerville');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (16,36,'de Melk');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (17,11,'Vincent Vega');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (17,27,'Butch Coolidge');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (17,37,'Jimmy Dimmick');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (17,38,'Jules Winnfield');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (17,39,'Jody');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (17,40,'Mia Wallace');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (17,97,'Capt. Koons');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (17,98,'Winston \"The Wolf\" Wolfe');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (17,99,'Pumpkin (Ringo)');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (18,42,'Mary Jensen Matthews');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (18,43,'Pat Healy');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (19,44,'Terminator');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (20,46,'Martin Brody');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (20,47,'Quint');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (20,48,'Matt Hooper');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (21,50,'Dr. Hannibal Lecter');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (21,51,'Clarice Starling');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (22,59,'Dr. Nikos Tatopoulos');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (22,60,'Philippe Roach�');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (23,62,'Neo');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (23,63,'Morpheus');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (24,60,'Franz Krieger');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (24,65,'Ethan Hunt');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (24,66,'Jim Phelps');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (24,67,'Claire Phelps');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (26,20,'Luther Whitney');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (26,21,'Le pr�sident Richmond');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (26,69,'Seth Frank');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (27,72,'Inspecteur Cruchot');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (27,73,'Adjudant Gerber');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (28,57,'Dr. Ian Malcolm');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (29,65,'Charlie Babbitt');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (29,80,'Raymond Babbitt');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (30,53,'Iceman');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (30,65,'Lt. Pete ''Maverick'' Mitchell');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (30,82,'Charlotte Blackwood');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (31,75,'Nathalie Morin');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (31,76,'Christiane');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (31,84,'Jean-Claude Dus');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (31,85,'J�r�me');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (31,86,'Popeye');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (32,20,'');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (33,88,'Bates');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (33,89,'Lila Crane');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (33,90,'Marion Crane');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (34,24,'Han Solo');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (34,92,'Luke Skywalker');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (34,93,'Princesse Leia');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (35,94,'Mitch Brenner');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (35,95,'Melanie Daniels');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (36,37,'Mr. Brown');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (36,98,'Mr. White/Larry');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (36,99,'Freddy Newendyke/Mr. Orange');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (36,100,'Nice Guy Eddie');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (36,215,'Mr Blonde');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (36,217,'Mr Pink');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (36,218,'Mr Blue');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (37,65,'Docteur William \"Bill\" Harford');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (37,102,'Alice Harford');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (38,103,'Jack Torrance');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (39,35,'Mark R');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (39,95,'Marnie Edgar');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (41,105,'Roger O. Thornhill');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (41,106,'Eve Kendall');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (41,107,'Philipp Vandamm');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (42,80,'');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (42,112,'Jeanne d''Arc');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (42,113,'Yolande d''Aragon');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (42,114,'Charles VII');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (42,115,'Dunois');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (43,27,'Major Korben Dalla');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (43,112,'Leeloo');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (43,116,'Jean-Baptiste Emmanuel Zorg');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (43,117,'Vito Cornelius');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (44,60,'L�on');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (44,116,'Norman Stansfield');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (44,118,'Mathilda');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (45,115,'Bob');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (45,119,'Nikita');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (45,120,'Marco');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (46,39,'Johanna');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (46,60,'Enzo Molinari');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (46,121,'Jacques Mayol');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (47,124,'Spider-Man');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (47,125,'Norman Osborn');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (47,126,'Mary Jane Watson');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (47,127,'Oncle Ben');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (47,128,'Tante May');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (48,63,'Jimmy Jump');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (48,97,'Frank White');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (48,124,'Thomas Flanigan');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (48,131,'Dennis Gilley');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (48,132,'Thomas Flanigan');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (48,217,'Test tube');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (49,62,'Neo');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (49,63,'Morpheus');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (49,210,'Trinity');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (49,211,'Agent Smith');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (50,62,'Neo');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (50,63,'Morpheus');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (50,134,'Agent Smith');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (50,136,'Trinity');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (50,137,'L''Oracle');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (51,139,'Marcel');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (51,140,'Enseignante');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (51,141,'Bruno');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (52,18,'Roger \"Verbal\" Kint');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (52,143,'Micheal McManus');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (52,144,'Dean Keaton');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (52,145,'Fred Fenster');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (52,146,'Todd Hockney');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (53,98,'Le lieutenant');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (54,151,'Don Vito Corleone');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (54,152,'Micheal');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (54,153,'Sonny');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (54,154,'Tom Hagen');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (54,155,'Kay Adams');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (57,167,'Luis Gara');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (57,168,'Jackie Brown');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (57,169,'Melanie');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (57,170,'Ray Nicolette');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (57,212,'Ordell Robbie');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (58,27,'McClane');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (58,38,'Zeus Carver');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (58,169,'Simon Gruber');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (59,27,'Malcom Crowe');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (59,171,'Cole Sear');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (60,173,'Bob Harris');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (60,174,'Charlotte');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (60,175,'John');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (60,176,'Kelly');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (60,177,'Patron Nightclub');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (61,40,'La mari�e, alias \"Black Mamba\"');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (61,213,'O-Ren Ishii');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (61,214,'Bill');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (61,215,'Budd / Sidewinder');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (61,216,'Elle Driver');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (62,182,'Vassili Za�tzev');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (62,183,'major K�nig');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (63,20,'Frankie Dunn');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (63,22,'Eddie Scrap-Iron Dupris');
INSERT INTO Role (idFilm, idArtiste, nomRole) VALUES (63,224,'Maggie Fitzerald');
