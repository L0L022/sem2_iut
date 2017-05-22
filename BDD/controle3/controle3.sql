-- ESCALES Loïc

-- 1 1

CREATE OR REPLACE FUNCTION CTRL3_cooperative.stock_cereale(refCereale CHAR(5)) RETURNS INTEGER AS $$
  DECLARE
    qte INTEGER;
  BEGIN
    PERFORM *
    FROM CTRL3_cooperative.cereale
    WHERE codecereale = refCereale;

    IF NOT FOUND THEN
      RAISE EXCEPTION 'cereale % n existe pas', refCereale;
    END IF;

    SELECT SUM(qtestock) INTO qte
    FROM CTRL3_cooperative.silo
    WHERE codecereale = refCereale;

    RETURN qte;
  END; $$
LANGUAGE plpgsql;

SELECT * FROM CTRL3_cooperative.stock_cereale('MS440');
SELECT * FROM CTRL3_cooperative.stock_cereale('CZ120');
SELECT * FROM CTRL3_cooperative.stock_cereale('BL500');
--SELECT * FROM CTRL3_cooperative.stock_cereale('BE500');

-- 1 2

CREATE OR REPLACE FUNCTION CTRL3_cooperative.verif_contrat(refCereale CHAR(5), qte INTEGER) RETURNS BOOL AS $$
  DECLARE
    qteReel INTEGER;
  BEGIN
    PERFORM *
    FROM CTRL3_cooperative.cereale
    WHERE codecereale = refCereale;

    IF NOT FOUND THEN
      RAISE EXCEPTION 'cereale % n existe pas', refCereale;
    END IF;

    SELECT SUM(qtestock) INTO qteReel
    FROM CTRL3_cooperative.silo
    WHERE codecereale = refCereale;

    RETURN qteReel >= qte;
  END; $$
LANGUAGE plpgsql;

SELECT * FROM CTRL3_cooperative.verif_contrat('MS440', 700);
SELECT * FROM CTRL3_cooperative.verif_contrat('BL500', 45);
--SELECT * FROM CTRL3_cooperative.verif_contrat('BE500', 980);

-- 1 3

CREATE OR REPLACE FUNCTION CTRL3_cooperative.ajoute_cereale(refCereale CHAR(5), qte INTEGER) RETURNS INTEGER AS $$
  DECLARE
    qteRestante INTEGER := qte;
    qteAjoute INTEGER := 0;
    silo CTRL3_cooperative.silo%ROWTYPE;
  BEGIN
    PERFORM *
    FROM CTRL3_cooperative.cereale
    WHERE codecereale = refCereale;

    IF NOT FOUND THEN
      RAISE EXCEPTION 'cereale % n existe pas', refCereale;
    END IF;

    FOR silo IN (
      SELECT *
      FROM CTRL3_cooperative.silo
      WHERE codecereale = refCereale AND qtestock < qtemax
    )
    LOOP
      qteAjoute = silo.qtemax - silo.qtestock;
      IF qteAjoute > qteRestante THEN
        qteAjoute = qteRestante;
      END IF;
      qteRestante = qteRestante - qteAjoute;

      UPDATE CTRL3_cooperative.silo S
      SET qtestock = qtestock + qteAjoute
      WHERE S.codesilo = silo.codesilo;
    END LOOP;

    RETURN qteRestante;
  END; $$
LANGUAGE plpgsql;

SELECT * FROM CTRL3_cooperative.ajoute_cereale('MS440', 92);
SELECT * FROM CTRL3_cooperative.ajoute_cereale('MS440', 300);
SELECT * FROM CTRL3_cooperative.ajoute_cereale('MS440', 200);
SELECT * FROM CTRL3_cooperative.ajoute_cereale('MS440', 200);
SELECT * FROM CTRL3_cooperative.ajoute_cereale('MS440', 200);

-- 2 1

CREATE OR REPLACE FUNCTION CTRL3_cooperative.check_insert_contrat() RETURNS TRIGGER AS $$
BEGIN
  PERFORM *
  FROM CTRL3_cooperative.cereale
  WHERE codecereale = NEW.codecereale;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'cereale % n existe pas', NEW.codecereale;
  END IF;

  PERFORM *
  FROM CTRL3_cooperative.negociant
  WHERE no_negociant = NEW.no_negociant;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'negociant % n existe pas', NEW.no_negociant;
  END IF;

  IF NEW.qtecde <= 0 THEN
    RAISE EXCEPTION 'la quantité de céréales doit être suppérieure à zéro';
  END IF;

  IF NOT CTRL3_cooperative.verif_contrat(NEW.codecereale, NEW.qtecde) THEN
    RAISE EXCEPTION 'la quantité de céréales est trop importante pour les stocks';
  END IF;

  NEW.datecontrat = current_timestamp;

  SELECT MAX(nocontrat)+1 INTO NEW.nocontrat
  FROM CTRL3_cooperative.contrat;

  RETURN NEW;
END; $$
LANGUAGE plpgsql;

CREATE TRIGGER trig_insert_contart BEFORE INSERT ON CTRL3_cooperative.contrat FOR EACH
ROW EXECUTE PROCEDURE CTRL3_cooperative.check_insert_contrat();

--INSERT INTO ctrl3_cooperative.contrat (codecereale, no_negociant, qtecde) VALUES('CA120', 48, 400);
--INSERT INTO ctrl3_cooperative.contrat (codecereale, no_negociant, qtecde) VALUES('CZ120', 80, 400);
--INSERT INTO ctrl3_cooperative.contrat (codecereale, no_negociant, qtecde) VALUES('CZ120', 48, 800);
INSERT INTO ctrl3_cooperative.contrat (codecereale, no_negociant, qtecde) VALUES('CZ120', 48, 400);
