-- 1

CREATE or REPLACE FUNCTION filmsRealisePar(VARCHAR, VARCHAR) RETURNS SETOF TP_bd_film.film AS $$
  DECLARE
    id INTEGER;
  BEGIN
    SELECT idArtiste INTO id
    FROM TP_bd_film.artiste
    WHERE nom = $1 AND prenom = $2;

    IF NOT FOUND THEN
      RAISE EXCEPTION '% % n est pas un artiste', $2, $1;
    END IF;

    RETURN QUERY SELECT *
    FROM TP_bd_film.film
    WHERE idArtiste = id;
  END; $$
LANGUAGE plpgsql;

SELECT * FROM filmsRealisePar('Hitckck', 'Alfred');
SELECT * FROM filmsRealisePar('Hitchcock', 'Alfred');

-- 2

CREATE or REPLACE FUNCTION realisateurDe(VARCHAR) RETURNS SETOF RECORD AS $$
  DECLARE
    nbfilms INTEGER;
  BEGIN
    SELECT COUNT(idFilm) INTO nbfilms
    FROM TP_bd_film.film
    WHERE titre = $1;

    IF nbfilms = 0 THEN
      RAISE EXCEPTION '% n existe pas', $1;
    END IF;
    IF nbfilms > 1 THEN
      RAISE EXCEPTION '% films ont le titre %', nbfilms, $1;
    END IF;

    RETURN QUERY SELECT A.nom, A.prenom
    FROM TP_bd_film.artiste A
    INNER JOIN TP_bd_film.film F ON A.idArtiste = F.idArtiste
    WHERE F.titre = $1;
  END; $$
LANGUAGE plpgsql;

INSERT INTO TP_bd_film.film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (65,'Double',2017,20,'Drame','Le film qui y est deux fois.', 'FR');
INSERT INTO TP_bd_film.film (idFilm, titre, annee, idArtiste, genre, resume, codePays) VALUES (66,'Double',2017,20,'Drame','Le film qui y est deux fois.', 'FR');

SELECT * FROM realisateurDe('Film Introuvable') AS (nom VARCHAR, prenom VARCHAR);
SELECT * FROM realisateurDe('Double') AS (nom VARCHAR, prenom VARCHAR);
SELECT * FROM realisateurDe('Pulp fiction') AS (nom VARCHAR, prenom VARCHAR);

-- 3

CREATE or REPLACE FUNCTION job(INTEGER) RETURNS VARCHAR AS $$
  DECLARE
    estActeur BOOL;
    estRealisateur BOOL;
  BEGIN
    PERFORM A.idArtiste
    FROM TP_bd_film.artiste A
    INNER JOIN TP_bd_film.role R ON A.idArtiste = R.idArtiste
    WHERE A.idArtiste = $1;
    estActeur = FOUND;

    PERFORM A.idArtiste
    FROM TP_bd_film.artiste A
    INNER JOIN TP_bd_film.film F ON A.idArtiste = F.idArtiste
    WHERE A.idArtiste = $1;
    estRealisateur = FOUND;

    IF estActeur AND estRealisateur THEN
      RETURN $1 || ' est un acteur et un réalisateur';
    ELSE
      IF estActeur THEN
        RETURN $1 || ' est un acteur';
      END IF;
      IF estRealisateur THEN
        RETURN $1 || ' est un réalisateur';
      END IF;
    END IF;
    RETURN $1 || ' n est ni acteur, ni réalisateur';
  END; $$
LANGUAGE plpgsql;

SELECT job(idArtiste) FROM tp_bd_film.artiste;
