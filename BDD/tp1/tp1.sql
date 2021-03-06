-- CORRECTION DE LA DIFFÉRENCE DE JOUR !!!
UPDATE tp1_bdd_formation.plannifier
SET dateform = dateform + 1;

-- 1
UPDATE tp1_bdd_formation.plannifier
SET dateform = dateform + 9
WHERE id_formation = (
  SELECT id_formation
  FROM tp1_bdd_formation.formation
  WHERE intitule_formation = 'Initiation a Linux'
)
RETURNING *;

-- 2
DELETE FROM tp1_bdd_formation.plannifier
WHERE id_formation = (
  SELECT id_formation
  FROM tp1_bdd_formation.formation
  WHERE intitule_formation = 'Bases de donnees (Access)'
)
RETURNING *;

DELETE FROM tp1_bdd_formation.inscrire
WHERE id_formation = (
  SELECT id_formation
  FROM tp1_bdd_formation.formation
  WHERE intitule_formation = 'Bases de donnees (Access)'
)
RETURNING *;

DELETE FROM tp1_bdd_formation.formation
WHERE id_formation = (
  SELECT id_formation
  FROM tp1_bdd_formation.formation
  WHERE intitule_formation = 'Bases de donnees (Access)'
)
RETURNING *;

-- 3

UPDATE tp1_bdd_formation.formateur
SET nom_formateur = LOWER(nom_formateur),
    prenom_formateur = LOWER(nom_formateur)
RETURNING *;

-- 4

UPDATE tp1_bdd_formation.formateur
SET nom_formateur = UPPER(nom_formateur),
    prenom_formateur = initcap(nom_formateur)
RETURNING *;

-- 5

UPDATE tp1_bdd_formation.plannifier
SET numsalle = 'G333'
WHERE dateform BETWEEN '2006-04-08' AND '2006-04-08'::date+30
RETURNING *;

-- 6

UPDATE tp1_bdd_formation.plannifier
SET dateform = dateform + 3
WHERE dateform - '2006-01-01'::date = 139
RETURNING *;

-- 7

-- A

SELECT F2.id_formation, F1.id_formateur, to_char(dateform, 'DD/MM/YYYY'), groupe, duree, numseance, mat_am, numsalle, nom_formateur, prenom_formateur, intitule_formation
FROM tp1_bdd_formation.formateur F1
INNER JOIN tp1_bdd_formation.plannifier P ON F1.id_formateur = P.id_formateur
INNER JOIN tp1_bdd_formation.formation F2 ON P.id_formation = F2.id_formation;

-- B

INSERT INTO tp1_bdd_formation.formateur VALUES (DEFAULT, 'Durant', 'Pierre');

UPDATE tp1_bdd_formation.plannifier
SET id_formateur = (
  SELECT id_formateur
  FROM tp1_bdd_formation.formateur
  WHERE nom_formateur = 'Durant' and prenom_formateur = 'Pierre'
)
WHERE id_formateur = (
  SELECT id_formateur
  FROM tp1_bdd_formation.formateur
  WHERE nom_formateur = 'Cancel' and prenom_formateur = 'Christophe'
);

-- C

SELECT F2.id_formation, F1.id_formateur, to_char(dateform, 'DD/MM/YYYY'), groupe, duree, numseance, mat_am, numsalle, nom_formateur, prenom_formateur, intitule_formation
FROM tp1_bdd_formation.formateur F1
INNER JOIN tp1_bdd_formation.plannifier P ON F1.id_formateur = P.id_formateur
INNER JOIN tp1_bdd_formation.formation F2 ON P.id_formation = F2.id_formation
WHERE nom_formateur = 'Cancel' and prenom_formateur = 'Christophe'
UNION
SELECT F2.id_formation, F1.id_formateur, to_char(dateform, 'DD/MM/YYYY'), groupe, duree, numseance, mat_am, numsalle, nom_formateur, prenom_formateur, intitule_formation
FROM tp1_bdd_formation.formateur F1
INNER JOIN tp1_bdd_formation.plannifier P ON F1.id_formateur = P.id_formateur
INNER JOIN tp1_bdd_formation.formation F2 ON P.id_formation = F2.id_formation
WHERE nom_formateur = 'Durant' and prenom_formateur = 'Pierre';

-- 8

-- A

INSERT INTO tp1_bdd_formation.formation VALUES (DEFAULT, 'Javascript', 12, 'Confirme');

-- B

INSERT INTO tp1_bdd_formation.inscrire (
  SELECT (
      SELECT id_formation
      FROM tp1_bdd_formation.formation
      WHERE intitule_formation = 'Javascript' and nbheures = 12 and niveau = 'Confirme'
    ), S.id_stagiaire, groupe
  FROM tp1_bdd_formation.stagiaires S
  INNER JOIN tp1_bdd_formation.inscrire I ON S.id_stagiaire = I.id_stagiaire
  INNER JOIN tp1_bdd_formation.formation F ON I.id_formation = F.id_formation
  WHERE intitule_formation = 'Formation Excel' and niveau = 'Debutant'
);

SELECT *
FROM tp1_bdd_formation.stagiaires S
INNER JOIN tp1_bdd_formation.inscrire I ON S.id_stagiaire = I.id_stagiaire
INNER JOIN tp1_bdd_formation.formation F ON I.id_formation = F.id_formation
WHERE intitule_formation = 'Formation Excel' and niveau = 'Debutant'
UNION
SELECT *
FROM tp1_bdd_formation.stagiaires S
INNER JOIN tp1_bdd_formation.inscrire I ON S.id_stagiaire = I.id_stagiaire
INNER JOIN tp1_bdd_formation.formation F ON I.id_formation = F.id_formation
WHERE intitule_formation = 'Javascript' and niveau = 'Confirme';

-- 9

-- A

SELECT *
FROM tp1_bdd_formation.formation
WHERE nbheures = 0;

-- B

SELECT *
FROM tp1_bdd_formation.inscrire
WHERE id_formation IN (
  SELECT id_formation
  FROM tp1_bdd_formation.formation
  WHERE nbheures = 0
);

-- C

-- a

CREATE TABLE Formation_Ext AS (
  SELECT *
  FROM tp1_bdd_formation.formation
  WHERE nbheures = 0
);

CREATE TABLE Inscrit_Form_Ext AS (
  SELECT *
  FROM tp1_bdd_formation.inscrire
  WHERE id_formation IN (
    SELECT id_formation
    FROM tp1_bdd_formation.formation
    WHERE nbheures = 0
  )
);

-- b

DELETE FROM tp1_bdd_formation.inscrire
WHERE id_formation IN (
    SELECT id_formation
    FROM tp1_bdd_formation.formation
    WHERE nbheures = 0
);

DELETE FROM tp1_bdd_formation.formation
WHERE nbheures = 0;
