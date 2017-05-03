-- ESCALES Loïc

-- 1 1

CREATE OR REPLACE VIEW CTRL2_formule1.nb_Course_Pilote AS (
  SELECT prenomPilote AS "prenom", nomPilote AS "nom", COUNT(G.idgp) AS "nombre_gp"
  FROM CTRL2_formule1.pilote P
  INNER JOIN CTRL2_formule1.courir C ON P.idPilote = C.idPilote
  INNER JOIN CTRL2_formule1.grandprix G ON C.idgp = G.idgp
  WHERE C.positiongrille > 0
  GROUP BY P.idpilote
  ORDER BY nombre_gp DESC
);

-- 1 2

CREATE OR REPLACE VIEW CTRL2_formule1.nb_km_GP AS (
  SELECT nomgp, SUM(longpiste*nbtour) AS "longueurgp"
  FROM CTRL2_formule1.grandprix G
  INNER JOIN CTRL2_formule1.circuit C ON G.id_circuit = C.id_circuit
  GROUP BY G.idgp
);

-- 2 1

SELECT *
FROM CTRL2_formule1.view_position_arr_pilote;

CREATE OR REPLACE RULE regle_update_view_position_arr_pilote
AS ON UPDATE TO CTRL2_formule1.view_position_arr_pilote
DO INSTEAD (
  UPDATE CTRL2_formule1.pilote
  SET (nompilote, prenompilote) = (NEW.nom, NEW.prenom)
  WHERE idpilote = NEW.id_pilote;

  UPDATE CTRL2_formule1.courir
  SET positionarrivee = NEW.position
  WHERE idpilote = NEW.id_pilote AND idgp = NEW.id_gp;
);

UPDATE CTRL2_formule1.view_position_arr_pilote
SET (nom, prenom, position) = ('DURAND', 'Carlos', 20)
WHERE id_pilote = 18 AND id_gp = 19;

UPDATE CTRL2_formule1.view_position_arr_pilote
SET position = 1
WHERE id_pilote = 18 AND id_gp = 19;

-- 2 2

CREATE OR REPLACE RULE regle_insert_circuit
AS ON INSERT TO CTRL2_formule1.circuit
WHERE NEW.id_circuit IN (
  SELECT id_circuit
  FROM CTRL2_formule1.circuit
)
DO INSTEAD (
  UPDATE CTRL2_formule1.circuit
  SET (nomcircuit, payscircuit, longpiste, nbspectateur) = (NEW.nomcircuit, NEW.payscircuit, NEW.longpiste, NEW.nbspectateur)
  WHERE id_circuit = NEW.id_circuit;
);

INSERT INTO CTRL2_formule1.circuit VALUES(DEFAULT,'Circuit de loïc','France',5,99999);
INSERT INTO CTRL2_formule1.circuit VALUES((
  SELECT id_circuit
  FROM CTRL2_formule1.circuit
  WHERE nomcircuit = 'Circuit de loïc'
), 'Super circuit de loïc !', 'France Arles', 10, 100000);

-- 3 1

CREATE or REPLACE FUNCTION tour_Effectue(INTEGER) RETURNS BOOL AS $$
  DECLARE
    res BOOL;
  BEGIN
    SELECT nbtourseffectue >= nbtour/2 INTO res
    FROM CTRL2_formule1.grandprix
    WHERE idgp = $1;
    RETURN res;
  END; $$
LANGUAGE plpgsql;

SELECT * FROM tour_Effectue(1);
SELECT * FROM tour_Effectue(14);

-- 3 2

SELECT *
FROM CTRL2_formule1.bareme

CREATE or REPLACE FUNCTION point_acquis(DATE, INTEGER) RETURNS INT AS $$
  DECLARE
    i INTEGER;
    total INTEGER := 0;
  BEGIN
    SELECT idpilote INTO i FROM CTRL2_formule1.pilote WHERE idpilote = $2;
    IF NOT found THEN
      RAISE EXCEPTION '% n est pas un idpilote valide', $2;
    END IF;

    FOR I IN (
      SELECT
        COALESCE ((
          SELECT CASE WHEN G.nbtourseffectue >= 2 AND G.nbtourseffectue/G.nbtour::real < 0.5
                    THEN points/2.0
                    ELSE points
                  END
          FROM CTRL2_formule1.bareme
          WHERE C.positionarrivee != 'A' AND place = C.positionarrivee::integer
        ), 0)
      FROM CTRL2_formule1.grandprix G
      INNER JOIN CTRL2_formule1.courir C ON G.idgp = C.idgp
      WHERE idpilote = $2 AND dategp <= $1
    ) LOOP total = total + i;
    END LOOP;

    RETURN total;
  END; $$
LANGUAGE plpgsql;

SELECT * FROM point_acquis('2017-01-30', 1);
SELECT * FROM point_acquis('2016-12-15', 2);
