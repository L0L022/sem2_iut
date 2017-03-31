-- Q1

-- A

CREATE VIEW tp_gite_de_france.view_location
AS (
  SELECT C.numcli AS "numcl", nomcli AS "nom_cl", L.duree AS "duree_loc", L.nbper AS "nbper", L.date_debut AS "date_loc", G.numgite, nomgite
  FROM tp_gite_de_france.clients C
  INNER JOIN tp_gite_de_france.louer L ON C.numcli = L.numcli
  INNER JOIN tp_gite_de_france.gites G ON L.numgite = G.numgite
);

-- B

CREATE VIEW tp_gite_de_france.view_tarif_gite
AS (
  SELECT G.numgite, G.nomgite AS "nom_gite", P.nomprop AS "nom_proprietaire", F.saison, F.tarifttc AS "tarif"
  FROM tp_gite_de_france.proprietaire AS P
  INNER JOIN tp_gite_de_france.gites AS G ON P.numprop = G.numprop
  INNER JOIN tp_gite_de_france.facturer AS F ON G.numgite = F.numgite
);

-- C

CREATE VIEW tp_gite_de_france.view_gite_sans_loc
AS (
  SELECT G.numgite, G.nomgite AS "nom_gite", P.nomprop AS "nom_proprietaire", F.saison, F.tarifttc AS "tarif", G.telgite, G.description, P.numprop, G.superficiegit, G.nbepis, G.nbpers
  FROM tp_gite_de_france.proprietaire AS P
  INNER JOIN tp_gite_de_france.gites AS G ON P.numprop = G.numprop
  INNER JOIN tp_gite_de_france.facturer AS F ON G.numgite = F.numgite
  WHERE G.numgite NOT IN (
    SELECT numgite
    FROM tp_gite_de_france.louer
  )
);

-- or

CREATE VIEW tp_gite_de_france.view_gite_sans_loc
AS (
  SELECT G.numgite, G.nomgite AS "nom_gite", P.nomprop AS "nom_proprietaire", F.saison, F.tarifttc AS "tarif", G.telgite, G.description, P.numprop, G.superficiegit, G.nbepis, G.nbpers
  FROM tp_gite_de_france.proprietaire AS P
  INNER JOIN tp_gite_de_france.gites AS G ON P.numprop = G.numprop
  INNER JOIN tp_gite_de_france.facturer AS F ON G.numgite = F.numgite
  WHERE G.numgite IN (
    SELECT numgite
    FROM tp_gite_de_france.gites
    EXCEPT
    SELECT numgite
    FROM tp_gite_de_france.louer
  )
);

-- D

CREATE VIEW tp_gite_de_france.view_gites_activites
AS (
  SELECT G.numgite, G.nomgite AS "nom_gite", A.nomact AS "activite", (P.info).distance, (P.info).interet
  FROM tp_gite_de_france.gites AS G
  INNER JOIN tp_gite_de_france.proposer AS P ON G.numgite = P.numgite
  INNER JOIN tp_gite_de_france.activites AS A ON P.numact = A.numact
);

-- Q2

-- A
