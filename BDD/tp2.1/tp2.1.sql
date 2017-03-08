-- I

-- 1

ALTER TABLE TP2_bd_voyage.planning
ADD COLUMN tarifenf NUMERIC(6,2);

ALTER TABLE TP2_bd_voyage.reservation
ADD COLUMN nbenf NUMERIC(2,0);

-- 2

ALTER TABLE TP2_bd_voyage.optionv
ALTER COLUMN libelle TYPE VARCHAR (30);
