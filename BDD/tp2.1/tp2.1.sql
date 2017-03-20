-- I

-- 1

ALTER TABLE TP2_bd_voyage.planning
ADD COLUMN tarifenf NUMERIC(6,2);

ALTER TABLE TP2_bd_voyage.reservation
ADD COLUMN nbenf NUMERIC(2,0);

-- 2

ALTER TABLE TP2_bd_voyage.optionv
ALTER COLUMN libelle TYPE VARCHAR(30);

-- 3 1

CREATE DOMAIN DOM_cat_cli AS VARCHAR(15)
CONSTRAINT C_cat_cli CHECK (VALUE IN ('PRIVILEGIE', 'BON', 'MAUVAIS'));

ALTER TABLE TP2_bd_voyage.client
ALTER COLUMN categorie TYPE DOM_cat_cli;

-- 3 2

ALTER TABLE TP2_bd_voyage.voyage
ADD CONSTRAINT C_nbetoiles CHECK (nbetoiles BETWEEN 1 AND 5);

-- 4

CREATE TABLE tp2_bd_voyage.hotel (
  id_hotel SERIAL,
  NomHotel VARCHAR(20) NULL,
  NbEtoile NUMERIC(1,0) NULL,
  VilleHotel VARCHAR(20) NULL,
  CONSTRAINT PK_HOTEL PRIMARY KEY(id_hotel),
  CONSTRAINT C_nbetoiles CHECK (NbEtoile BETWEEN 1 AND 5)
);

CREATE TYPE TypeChambre AS ENUM ('Single', 'Double', 'Double luxe', 'Suite', 'Suite junior', 'Suite prestige');

CREATE TABLE tp2_bd_voyage.capacite (
  id_hotel INTEGER,
  typeChambre TypeChambre,
  NbrChambre INTEGER DEFAULT 0,
  CONSTRAINT PK_CAPACITE PRIMARY KEY(id_hotel, typeChambre)
);

INSERT INTO tp2_bd_voyage.hotel(NomHotel, NbEtoile, VilleHotel) (
  SELECT DISTINCT hotel, nbetoiles, villearr
  FROM tp2_bd_voyage.voyage
);

ALTER TABLE tp2_bd_voyage.voyage
ADD COLUMN id_hotel INTEGER;

ALTER TABLE tp2_bd_voyage.voyage
ADD CONSTRAINT C_id_hotel FOREIGN KEY(id_hotel) REFERENCES tp2_bd_voyage.hotel(id_hotel);

UPDATE tp2_bd_voyage.voyage AS V
SET id_hotel = (
  SELECT id_hotel
  FROM tp2_bd_voyage.hotel
  WHERE NomHotel = V.HOTEL AND NbEtoile = V.nbetoiles AND VilleHotel = V.villearr
);

ALTER TABLE tp2_bd_voyage.voyage
DROP COLUMN villearr;

ALTER TABLE tp2_bd_voyage.voyage
DROP COLUMN hotel;

ALTER TABLE tp2_bd_voyage.voyage
DROP COLUMN nbetoiles;

INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'ANTIQUE'), 'Single', 10);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'ANTIQUE'), 'Double', 75);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'ANTIQUE'), 'Suite', 5);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'ATLAS'), 'Double', 83);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'ATLAS'), 'Suite', 27);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'OLD BRIDGE'), 'Single', 25);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'OLD BRIDGE'), 'Double', 75);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'SAFARI JAMBO'), 'Single', 32);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'SAFARI JAMBO'), 'Double', 100);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'TRANSATLANTIQUE'), 'Double', 200);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'BAMBURI'), 'Double', 150);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'BELLERIVE'), 'Double', 56);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'BELLERIVE'), 'Suite', 12);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'DAR AL BAHAR'), 'Single', 10);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'DAR AL BAHAR'), 'Double', 12);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'EL ALMARANTE'), 'Single', 34);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'EL ALMARANTE'), 'Suite', 45);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'EL ANDALOUS'), 'Single', 67);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'EL ANDALOUS'), 'Double', 54);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'ELIAS BEACH'), 'Single', 87);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'ELIAS BEACH'), 'Double', 33);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'ESPADON'), 'Single', 34);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'ESPADON'), 'Double', 45);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'HASNA'), 'Single', 32);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'HASNA'), 'Double', 24);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'MONDIAL'), 'Single', 12);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'MONDIAL'), 'Double', 13);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'KENZI CLUB'), 'Single', 45);
INSERT INTO tp2_bd_voyage.capacite VALUES ((SELECT id_hotel FROM tp2_bd_voyage.hotel WHERE NomHotel = 'KENZI CLUB'), 'Double', 67);

-- II

-- 1

UPDATE tp2_bd_voyage.reservation
SET nbenf = 2
WHERE numcl = 2103;

UPDATE tp2_bd_voyage.reservation
SET nbenf = 1
WHERE numcl = (
  SELECT numcl
  FROM tp2_bd_voyage.client
  WHERE nom = 'JAROLIM' and prenom = 'THOMAS'
);

-- 2

UPDATE tp2_bd_voyage.planning
SET tarifenf = tarif / 2;

-- 3

INSERT INTO tp2_bd_voyage.client VALUES ((SELECT MAX(numcl) + 1 FROM tp2_bd_voyage.client), 'ESCALES', 'LOÏC', NULL, NULL, 'ARLES', 'PRIVILEGIE');
INSERT INTO tp2_bd_voyage.client VALUES ((SELECT MAX(numcl) + 1 FROM tp2_bd_voyage.client), 'DOITEAU', 'LAURENT', NULL, NULL, 'ARLES', 'BON');

INSERT INTO tp2_bd_voyage.reservation VALUES ((
  SELECT numcl
  FROM tp2_bd_voyage.client
  WHERE nom = 'DOITEAU' and prenom = 'LAURENT'
  ),(
    SELECT idv
    FROM tp2_bd_voyage.voyage
    WHERE villedep = 'MARSEILLE' and paysarr = 'MAROC' and duree = 4 and id_hotel = (
      SELECT id_hotel
      FROM tp2_bd_voyage.hotel
      WHERE nomhotel = 'ATLAS' and nbetoile = 4 and villehotel = 'AGADIR'
      )
    ) ,(
      SELECT MAX(datedep)
      FROM tp2_bd_voyage.planning
      WHERE idv = (
        SELECT idv
        FROM tp2_bd_voyage.voyage
        WHERE villedep = 'MARSEILLE' and paysarr = 'MAROC' and duree = 4 and id_hotel = (
          SELECT id_hotel
          FROM tp2_bd_voyage.hotel
          WHERE nomhotel = 'ATLAS' and nbetoile = 4 and villehotel = 'AGADIR'
          )
        )
      ), 1, (
        SELECT MAX(datedep)
        FROM tp2_bd_voyage.planning
        WHERE idv = (
          SELECT idv
          FROM tp2_bd_voyage.voyage
          WHERE villedep = 'MARSEILLE' and paysarr = 'MAROC' and duree = 4 and id_hotel = (
            SELECT id_hotel
            FROM tp2_bd_voyage.hotel
            WHERE nomhotel = 'ATLAS' and nbetoile = 4 and villehotel = 'AGADIR'
          )
        )
        ) - 10, 9);

-- 4

-- IMPOSSIBLE !!!
-- UPDATE tp2_bd_voyage.hotel
-- SET nbetoile = 6
