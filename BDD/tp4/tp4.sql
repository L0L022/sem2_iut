-- Q1

-- A

CREATE or REPLACE FUNCTION moySalaire() RETURNS NUMERIC(11, 2) AS $$
  DECLARE
    moyenne NUMERIC(11, 2);
  BEGIN
    SELECT AVG(salaire) INTO moyenne
    FROM TP1_Dep_Emp.employes;

    RETURN moyenne;
  END; $$
LANGUAGE plpgsql;

-- B

SELECT moySalaire();

-- C

SELECT nom, salaire
FROM TP1_Dep_Emp.employes
WHERE salaire > moySalaire();

-- D

SELECT nom, salaire
FROM TP1_Dep_Emp.employes
WHERE salaire BETWEEN moySalaire()*0.9 AND moySalaire()*1.1;

-- Q2

-- A

CREATE or REPLACE FUNCTION departement(NUMERIC(7)) RETURNS VARCHAR(25) AS $$
  DECLARE
    dep VARCHAR(25);
  BEGIN
    SELECT D.nom INTO dep
    FROM TP1_Dep_Emp.departement D
    INNER JOIN TP1_Dep_Emp.employes E ON D.nodept = E.nodept
    WHERE E.noemp = $1;

    RETURN dep;
  END; $$
LANGUAGE plpgsql;

-- Q3

-- A

CREATE or REPLACE FUNCTION collegues(NUMERIC(7)) RETURNS SETOF record AS $$
  DECLARE
    i record;
  BEGIN
    FOR i IN (
      SELECT nom, prenom
      FROM TP1_Dep_Emp.employes
      WHERE noemp != $1 AND departement($1) = departement(noemp)
    ) LOOP RETURN NEXT i;
    END LOOP;
    RETURN;
  END; $$
LANGUAGE plpgsql;

SELECT * FROM collegues(2) AS (nom VARCHAR, prenom VARCHAR);

-- Q4

-- A

SELECT *
FROM TP1_Dep_Emp.employes;

CREATE or REPLACE FUNCTION superieurs(NUMERIC(7)) RETURNS SETOF record AS $$
  DECLARE
    num_emp NUMERIC;
    sup NUMERIC;
    nom_prenom record;
  BEGIN
    num_emp = $1;
    sup = NULL;

    WHILE num_emp IS NOT NULL LOOP

      SELECT nosupr INTO sup
      FROM TP1_Dep_Emp.employes
      WHERE noemp = num_emp;

      IF sup IS NOT NULL THEN

        SELECT nom, prenom INTO nom_prenom
        FROM TP1_Dep_Emp.employes
        WHERE noemp = sup;
        RETURN NEXT nom_prenom;

      END IF;
      num_emp = sup;

    END LOOP;
    RETURN;
  END; $$
LANGUAGE plpgsql;

SELECT * FROM superieurs(25) AS (nom VARCHAR, prenom VARCHAR);
