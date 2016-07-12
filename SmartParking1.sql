SELECT * FROM dbo.Model
SELECT * FROM dbo.Producator

INSERT INTO dbo.Model
VALUES (8, 5, 'C Class', 2015, 1)


DELETE FROM dbo.Model
WHERE ID = 4

UPDATE dbo.Model
SET ProducatorID = 8
WHERE ID = 5

SET IDENTITY_INSERT dbo.Masini ON

INSERT INTO dbo.Masini (ID, ModelID, Numar, Culoare)
VALUES (6, 6, 'B-98-GGG', 'Galben')

INSERT INTO dbo.Masini (ID, ModelID, Numar, Culoare)
VALUES (7, 2, 'TM-78-LaL', 'Gri')


INSERT INTO dbo.Masini (ID, ModelID, Numar, Culoare)
VALUES (8, 3, 'B-08-GGY', 'Mov')

INSERT INTO dbo.Masini (ID, ModelID, Numar, Culoare)
VALUES (10, 7, 'HD-18-TWY', 'Rosu')

SELECT * FROM dbo.Model
SELECT * FROM dbo.Masini

UPDATE dbo.Vizita
SET MasinaID = 2 
WHERE ID = 5

SELECT * FROM dbo.Vizita
SELECT * FROM dbo.Masini

SET IDENTITY_INSERT dbo.Vizita ON

INSERT INTO dbo.Vizita (MasinaID, DurataSosire, DurataPlecare)
VALUES (7, '2015-06-05 09:00:00', '2015-06-05 16:29:00')


--HOMEWORK QUERIES:
---Calcul incasari 
-----a). Pe zi:
SELECT CAST(DurataPlecare AS DATE) AS Zi, SUM(Durata - 120)/60.0*5 AS IncasariZi
FROM dbo.Vizita 
GROUP BY CAST(DurataPlecare AS DATE)
ORDER BY CAST(DurataPlecare AS DATE) ASC;


---b). Pe luna:
SELECT DATEPART(month, DurataPlecare) AS Luna, SUM((Durata - 120)/60.0*5) AS IncasariPeLuna
FROM dbo.Vizita
GROUP BY DATEPART(month, DurataPlecare)
ORDER BY DATEPART(month, DurataPlecare) ASC;

--c). Pe an:
SELECT DATEPART(year, DurataPlecare) AS An, SUM((Durata - 120)/60.0*5) AS IncasariAn
FROM dbo.Vizita 
GROUP BY DATEPART(year, DurataPlecare)
ORDER BY DATEPART(year, DurataPlecare) ASC;


----Care este este intervalul mediu petrecut de clienti in parcare ?

SELECT (AVG(Durata))/60.0 AS 'MedieStationare(ore)'
FROM dbo.Vizita;


----Care este cel mai fidel client (cine utilizeaza cel mai mult parcarea) ?

SELECT m.Numar as ClientFidel, DurataTotala
FROM(
SELECT TOP 1 MasinaID AS MasinaID, SUM(d.Durata) AS DurataTotala
FROM dbo.Vizita AS d
GROUP BY MasinaID
ORDER BY DurataTotala DESC) AS Bilant
INNER JOIN dbo.Masini AS m
ON m.ID = MasinaID
GROUP BY m.Numar, DurataTotala;

---Care este media de utilizare a parcarii pe parcursul anului / zilei / saptamani ?

--a). Media pe zi:
SELECT CAST(d.DurataPlecare AS DATE) AS Zi, AVG(d.Durata)/60.0 AS 'MedieStationareZi(ore)'
FROM dbo.Vizita d
GROUP BY CAST(d.DurataPlecare AS DATE)
ORDER BY CAST(d.DurataPlecare AS DATE) ASC;

--b). Media pe luna:
SELECT DATEPART(month, d.DurataPlecare) AS Luna, AVG(d.Durata)/60.0 AS 'MedieStationareLuna(ore)'
FROM dbo.Vizita d
GROUP BY DATEPART(month, d.DurataPlecare)
ORDER BY DATEPART(month, d.DurataPlecare) ASC;

--c).Media pe an: 
SELECT DATEPART(year, d.DurataPlecare) AS An, AVG(d.Durata)/60.0 AS 'MedieStationareAn(ore)'
FROM dbo.Vizita  AS d
GROUP BY DATEPART(year, d.DurataPlecare)
ORDER BY DATEPART(year, d.DurataPlecare) ASC;

----Care este a fost cea mai aglomerata zi din an in ceea ce priveste parcarea?

SELECT TOP 1 CAST(d.DurataPlecare AS DATE) AS ZiuaAglomerata, COUNT(d.MasinaID) AS NumarMasiniParcate
FROM dbo.Vizita AS d
GROUP BY CAST(d.DurataPlecare AS DATE)
ORDER BY NumarMasiniParcate DESC;

----Care este intervalul orar cu cei mai multi utilizatori ai parcarii (cand sunt cele mai multe masini) ?
SELECT TOP 1 DATEPART(HOUR, DurataPlecare) AS OraAglomerata, COUNT(d.MasinaID) AS NumarMasiniParcate
FROM dbo.Vizita AS d
GROUP BY DATEPART(HOUR, DurataPlecare)
ORDER BY NumarMasiniParcate DESC;

----Cate masini sunt in medie in fiecare ora de pe parcursul unei zile ?
--Solutie:
-----Am creat o noua tabela denumita "OrarPerMasina" pentru a reusi o operatie de JOIN intre aceasta tabela si tabela "HoursADay" care contine coloana ID si coloane Ora cu toate orele dintr-o zi
SELECT DATEPART(HH, DurataSosire) AS OraSosire, DATEPART(HH, DurataPlecare) AS OraPlecare, MasinaID 
INTO OrarPerMasina FROM dbo.Vizita

SELECT * FROM OrarPerMasina	

SELECT COUNT(s.MasinaID) AS NumarMasini, OraSosire, 
FROM dbo.OrarPerMasina AS s
INNER JOIN dbo.HoursADay h 
ON h.ID = s.ID
WHERE s.OraPlecare = h.Ora





	
	
		
