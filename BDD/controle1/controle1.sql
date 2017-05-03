-- I.1

UPDATE ctrl1_hotel.couter
SET chb_prix = chb_prix * 1.33;

-- I.2

UPDATE ctrl1_hotel.client
SET nom = UPPER(nom),
    prenom = initcap(prenom);

-- I.3

SELECT tit_code
FROM ctrl1_hotel.client
WHERE nom = 'PHILIPPE' and prenom = 'André';

DELETE FROM ctrl1_hotel.telephone
WHERE cli_id = (
  SELECT cli_id
  FROM ctrl1_hotel.client
  WHERE nom = 'PHILIPPE' and prenom = 'André'
);

DELETE FROM ctrl1_hotel.adresse
WHERE cli_id = (
  SELECT cli_id
  FROM ctrl1_hotel.client
  WHERE nom = 'PHILIPPE' and prenom = 'André'
);

DELETE FROM ctrl1_hotel.email
WHERE cli_id = (
  SELECT cli_id
  FROM ctrl1_hotel.client
  WHERE nom = 'PHILIPPE' and prenom = 'André'
);

DELETE FROM ctrl1_hotel.ligne_facture
WHERE fac_id IN (
  SELECT fac_id
  FROM ctrl1_hotel.facture
  WHERE cli_id = (
    SELECT cli_id
    FROM ctrl1_hotel.client
    WHERE nom = 'PHILIPPE' and prenom = 'André'
  )
);

DELETE FROM ctrl1_hotel.facture
WHERE cli_id = (
  SELECT cli_id
  FROM ctrl1_hotel.client
  WHERE nom = 'PHILIPPE' and prenom = 'André'
);

DELETE FROM ctrl1_hotel.reserver
WHERE cli_id = (
  SELECT cli_id
  FROM ctrl1_hotel.client
  WHERE nom = 'PHILIPPE' and prenom = 'André'
);

DELETE FROM ctrl1_hotel.client
WHERE nom = 'PHILIPPE' and prenom = 'André';

-- I.4

INSERT INTO ctrl1_hotel.client VALUES (DEFAULT, 'm.', 'JENSUIS', 'Pierre', NULL);
INSERT INTO ctrl1_hotel.adresse VALUES (DEFAULT, (
  SELECT cli_id
  FROM ctrl1_hotel.client
  WHERE nom = 'JENSUIS' and prenom = 'Pierre'
), '34 rue noir', '', '', '', '34678', 'busez');
INSERT INTO ctrl1_hotel.email VALUES (DEFAULT, (
  SELECT cli_id
  FROM ctrl1_hotel.client
  WHERE nom = 'JENSUIS' and prenom = 'Pierre'
), 'jensuis.pierre@icemail.fr', '');
INSERT INTO ctrl1_hotel.telephone VALUES (DEFAULT, (
  SELECT cli_id
  FROM ctrl1_hotel.client
  WHERE nom = 'JENSUIS' and prenom = 'Pierre'
), 'tel', '04-45-67-89-32', 'domicile');
INSERT INTO ctrl1_hotel.reserver VALUES ((
  SELECT chb_id
  FROM ctrl1_hotel.chambre
  WHERE numero = 6
), current_timestamp, (
  SELECT cli_id
  FROM ctrl1_hotel.client
  WHERE nom = 'JENSUIS' and prenom = 'Pierre'
), 2, DEFAULT, DEFAULT);

-- II.1

-- prob calcul ?
UPDATE ctrl1_hotel.ligne_facture
SET remise_montant = montant * remise_pourcent
WHERE remise_montant IS NULL;

ALTER TABLE ctrl1_hotel.ligne_facture
DROP COLUMN remise_pourcent;

-- II.2

ALTER TABLE ctrl1_hotel.chambre
ALTER COLUMN couchage TYPE NUMERIC(2, 0);

ALTER TABLE ctrl1_hotel.chambre
RENAME COLUMN couchage TO nb_couchage;

-- II.3

ALTER TABLE ctrl1_hotel.facture
ALTER date_fac SET DEFAULT current_date;

-- II.4

CREATE TABLE ctrl1_hotel.type_tel (
  id_type_tel SERIAL PRIMARY KEY,
  type_code VARCHAR(8),
  descrip_type VARCHAR(50)
);

ALTER TABLE ctrl1_hotel.type_tel
ADD CONSTRAINT C_type_code CHECK (type_code IN ('fax', 'tel', 'gsm'));

INSERT INTO ctrl1_hotel.type_tel (type_code, descrip_type) (
  SELECT DISTINCT typ_code, typ_code || ' ' || localisation
  FROM ctrl1_hotel.telephone
);

ALTER TABLE ctrl1_hotel.telephone
ADD COLUMN id_type_tel INTEGER;

ALTER TABLE ctrl1_hotel.telephone
ADD CONSTRAINT FK_tel_id_type_tel FOREIGN KEY (id_type_tel) REFERENCES ctrl1_hotel.type_tel(id_type_tel);

UPDATE ctrl1_hotel.telephone AS T
SET id_type_tel = (
  SELECT id_type_tel
  FROM ctrl1_hotel.type_tel
  WHERE type_code = T.typ_code || ' ' || T.localisation
);

ALTER TABLE ctrl1_hotel.telephone
DROP COLUMN typ_code;

ALTER TABLE ctrl1_hotel.telephone
DROP COLUMN localisation;
