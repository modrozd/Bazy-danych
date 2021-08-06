--FUNKCJE ZWRACAJACE
CREATE FUNCTION  Zwroc_nr_pracownika (@podany_pesel bigint)
RETURNS int
BEGIN
    RETURN (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = @podany_pesel)
END
GO

CREATE FUNCTION  Zamelduj (@podany_nr int) --niedokonczone
RETURNS int
BEGIN
    RETURN (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = @podany_nr)
END
GO

-- KONIEC FUNKCJI
use Szpital;

INSERT INTO Choroba (ID_choroby)
	VALUES
	(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20); --przykladowe identyfikatory chorob



INSERT INTO Lek (Nazwa_leku)
	VALUES
	('Lek1'), ('Lek2'), ('Lek3'), ('Lek4'), ('Lek5'), ('Lek6'), ('Lek7'), ('Lek8'), ('Lek9'), ('Lek10'), ('Lek11'),
	('Lek12'), ('Lek13'), ('Lek14'), ('Lek15'), ('Lek16'), ('Lek17'), ('Lek18'), ('Lek19'), ('Lek20');


INSERT INTO Lekarze (PESEL, Imie, Nazwisko, Plec, Data_urodzenia, Specjalizacja)
	VALUES
	(59042575916, 'Andrzej', 'Zawada', 'M', '1959-04-25', 'Onkolog kliniczny'),	--szef radioterapii
	(63081956157, 'Marta', 'Koman', 'K', '1963-08-19', 'Patomorfolog'),		--szefowa diagnostyki
	(90031463197, 'Marek', 'Grechuta','M', '1990-03-14', 'Onkolog kliniczny'),	--szef onkologii
	(63042753921, 'Urszula', 'Dudziak', 'K', '1963-04-27', 'Ginekolog'),		--szefowa ginekologii
	(69113067926, 'Marzena', 'Pomorska', 'K', '1969-11-30', 'Radioterapeuta'),	--szefowa chemioterapii
	(88041256296, 'Cezary', 'Pazura', 'M', '1988-04-12', 'Chirurg onkolog'),  	--szef chirurgii
	(61101567346, 'Ryszard', 'Kałużny', 'M', '1961-10-15', 'Reumatolog'),
	(71121232458, 'Barbara', 'Orzechowska', 'K', '1971-12-12', 'Dermatolog'),
	(75031145727, 'Marcin', 'Dulas', 'M', '1975-03-11', 'Ortopeda'),
	(55071551574, 'Edyta', 'Górniak', 'K', '1955-07-15', 'Neurolog'),
	(82121411272, 'Stefan', 'Niemen', 'M', '1982-12-14', 'Radioterapeuta'),
	(84072962052, 'Marika', 'Hak', 'K', '1984-07-29', 'Radiolog'),
	(71102563546, 'Dariusz', 'Bielski', 'M', '1971-10-25', 'Chirurg onkolog');

UPDATE Lekarze
SET		Numer_przelozonego = (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 59042575916)
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 61101567346)
UPDATE Lekarze
SET		Numer_przelozonego = (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 63081956157)
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 71121232458)
UPDATE Lekarze
SET		Numer_przelozonego = (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 88041256296)
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 75031145727)
UPDATE Lekarze
SET		Numer_przelozonego = (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 63081956157)
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 55071551574)
UPDATE Lekarze
SET		Numer_przelozonego = (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 90031463197)
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 82121411272)
UPDATE Lekarze
SET		Numer_przelozonego = (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 63042753921)
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 84072962052)
UPDATE Lekarze
SET		Numer_przelozonego = (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 69113067926)
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 71102563546)

INSERT INTO Oddzialy (Nazwa_oddzialu, Ordynator)
	VALUES
	('Oddział Radioterapii',			  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 59042575916)), --Andrzej Zawada, 5p
	('Oddział Chemioterapii',			  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 69113067926)), --Marzena Pomorska, 5p
	('Oddział Chirurgii Onkologicznej',   (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 88041256296)), --Cezary Pazura, 8p
	('Oddział Ginekologii Onkologicznej', (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 63042753921)), --Urszula Dudziak, 5p
	('Oddział Onkologii Klinicznej',	  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 90031463197)), --Marek Grechuta, 3p
	('Oddział Diagnostyki Obrazowej',	  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 63081956157)); --Marta Koman, 0p

UPDATE Lekarze 
SET		Nazwa_oddzialu = 'Oddział Radioterapii'
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 59042575916)
UPDATE Lekarze 
SET		Nazwa_oddzialu = 'Oddział Diagnostyki Obrazowej'
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 63081956157)
UPDATE Lekarze 
SET		Nazwa_oddzialu = 'Oddział Onkologii Klinicznej'
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 90031463197)
UPDATE Lekarze 
SET		Nazwa_oddzialu = 'Oddział Ginekologii Onkologicznej'
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 63042753921)
UPDATE Lekarze 
SET		Nazwa_oddzialu = 'Oddział Chemioterapii'
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 69113067926)
UPDATE Lekarze 
SET		Nazwa_oddzialu = 'Oddział Chirurgii Onkologicznej'
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 88041256296)
UPDATE Lekarze 
SET		Nazwa_oddzialu = 'Oddział Radioterapii'
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 61101567346)
UPDATE Lekarze 
SET		Nazwa_oddzialu = 'Oddział Diagnostyki Obrazowej'
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 71121232458)
UPDATE Lekarze 
SET		Nazwa_oddzialu = 'Oddział Chirurgii Onkologicznej'
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 75031145727)
UPDATE Lekarze 
SET		Nazwa_oddzialu = 'Oddział Diagnostyki Obrazowej'
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 55071551574)
UPDATE Lekarze 
SET		Nazwa_oddzialu = 'Oddział Onkologii Klinicznej'
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 82121411272)
UPDATE Lekarze 
SET		Nazwa_oddzialu = 'Oddział Ginekologii Onkologicznej'
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 84072962052)
UPDATE Lekarze 
SET		Nazwa_oddzialu = 'Oddział Chemioterapii'
WHERE   Numer_pracownika   =  (SELECT Numer_pracownika FROM Lekarze WHERE PESEL = 71102563546)


INSERT INTO Pacjenci (PESEL, Imie, Nazwisko, Plec, Data_urodzenia, Numer_pracownika) -- Numer_pacjenta PK pomijam
	VALUES
	(90121003556, 'Ignacy', 'Kowalski', 'M', '1999-12-21',		(SELECT dbo.Zwroc_nr_pracownika(59042575916))),
	(85041806186, 'Krystian', 'Adamski', 'M', '1985-04-18',		(SELECT dbo.Zwroc_nr_pracownika(63081956157))),
	(66010102741, 'Agata', 'Lipnicka', 'K', '1966-01-01',		(SELECT dbo.Zwroc_nr_pracownika(63081956157))),
	(99122303186, 'Monika', 'Drozd', 'K', '1999-12-23',			(SELECT dbo.Zwroc_nr_pracownika(88041256296))),
	(77101516854, 'Konrad', 'Teper', 'M', '1977-10-15',			(SELECT dbo.Zwroc_nr_pracownika(63081956157))),
	(43060911573, 'Franciszek', 'Liszajn', 'M', '1943-06-09',	(SELECT dbo.Zwroc_nr_pracownika(90031463197))),
	(32102964167, 'Anna', 'Biedrak', 'K', '1932-10-29',			(SELECT dbo.Zwroc_nr_pracownika(63042753921))),
	(59022467963, 'Adam', 'Wicher', 'M', '1959-02-24',			(SELECT dbo.Zwroc_nr_pracownika(63042753921))),
	(88061513797, 'Karolina', 'Zastawna', 'K', '1988-06-15',	(SELECT dbo.Zwroc_nr_pracownika(69113067926))),
	(70090174539, 'Aleksandra', 'Stalmach', 'K', '1970-09-01',  (SELECT dbo.Zwroc_nr_pracownika(61101567346))),
	(69120305256, 'Patryk', 'Nowski', 'M', '1969-12-03',		(SELECT dbo.Zwroc_nr_pracownika(71121232458))),
	(66021058619, 'Renata', 'Przemyk', 'K', '1966-02-10',		(SELECT dbo.Zwroc_nr_pracownika(75031145727))),
	(72050612765, 'Artur', 'Rojek', 'M', '1972-05-06',			(SELECT dbo.Zwroc_nr_pracownika(75031145727))),
	(29022467892, 'Zdzisław', 'Beksiński', 'M', '1929-02-24',	(SELECT dbo.Zwroc_nr_pracownika(55071551574))),
	(81010145617, 'Elwira', 'Litra', 'K', '1981-01-01',			(SELECT dbo.Zwroc_nr_pracownika(69113067926))),
	(44090153734, 'Wanda', 'Piłsudska', 'K', '1944-09-01',		(SELECT dbo.Zwroc_nr_pracownika(82121411272))),
	(49061562671, 'Piotr', 'Stefczyk', 'M', '1949-06-15',		(SELECT dbo.Zwroc_nr_pracownika(82121411272))),
	(53053056828, 'Agata', 'Karp', 'K', '1953-05-30',			(SELECT dbo.Zwroc_nr_pracownika(59042575916))),
	(66011653642, 'Norbert', 'Kot', 'M', '1966-01-16',			(SELECT dbo.Zwroc_nr_pracownika(69113067926))),
	(71041656632, 'Alicja', 'Mrau', 'K', '1971-04-16',			(SELECT dbo.Zwroc_nr_pracownika(69113067926)));

--Kaskadowy UPDATE
UPDATE Pacjenci
SET Numer_pracownika = (SELECT dbo.Zwroc_nr_pracownika(69113067926))
WHERE Numer_pacjenta = (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 77101516854)
UPDATE Pacjenci
SET Numer_pracownika = (SELECT dbo.Zwroc_nr_pracownika(59042575916))
WHERE Numer_pacjenta = (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 85041806186)

--Kaskadowy DELETE
DELETE FROM Pacjenci WHERE Numer_pacjenta = (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 90121003556)
--DELETE FROM Pacjenci WHERE Numer_pacjenta = (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 85041806186)

INSERT INTO Posiadana_choroba (Data_rozpoznania, Stopien_zaawansowania, ID_choroby, Numer_pacjenta)
	VALUES
	('2018-06-12', 1, 1,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 90121003556)),
	('2019-12-05', 2, 2,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 85041806186)),
	('2020-12-12', 3, 3,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66010102741)),
	('2008-01-28', 4, 4,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 99122303186)),
	('2015-02-01', 1, 5,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 77101516854)),
	('2016-03-03', 2, 6,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 43060911573)),
	('2018-04-18', 3, 7,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 32102964167)),
	('2020-07-15', 4, 8,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 59022467963)),
	('2020-06-15', 1, 9,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 88061513797)),
	('2017-11-26', 2, 10,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 70090174539)),
	('2020-05-21', 3, 11,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 69120305256)),
	('2019-12-30', 4, 12,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66021058619)),
	('2020-08-01', 1, 1,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 72050612765)),
	('2020-07-31', 2, 2,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 29022467892)),
	('2007-05-28', 3, 2,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 81010145617)),
	('2016-05-07', 4, 3,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 44090153734)),
	('2020-09-04', 1, 19,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 49061562671)),
	('2020-11-03', 2, 5,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 53053056828)),
	('2019-10-10', 3, 1,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66011653642)),
	('2020-12-18', 3, 1,	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 71041656632));



INSERT INTO Pokoj_pacjenta (Numer_pokoju, Ilosc_lozek, Lazienka, Nazwa_oddzialu)
	VALUES
	('R1', 1, 0, 'Oddział Radioterapii'),
	('R2', 2, 1, 'Oddział Radioterapii'),
	('R3', 3, 0, 'Oddział Radioterapii'),
	('R4', 1, 1, 'Oddział Radioterapii'),
	('R5', 2, 0, 'Oddział Radioterapii'), --5 pokojow
	('C1', 2, 1, 'Oddział Chemioterapii'),
	('C2', 2, 0, 'Oddział Chemioterapii'),
	('C3', 4, 1, 'Oddział Chemioterapii'),
	('C4', 2, 1, 'Oddział Chemioterapii'),
	('C5', 1, 0, 'Oddział Chemioterapii'), --5 pokojow
	('O1', 4, 1, 'Oddział Chirurgii Onkologicznej'),
	('O2', 2, 1, 'Oddział Chirurgii Onkologicznej'),
	('O3', 2, 1, 'Oddział Chirurgii Onkologicznej'),
	('O4', 2, 1, 'Oddział Chirurgii Onkologicznej'),
	('O5', 1, 0, 'Oddział Chirurgii Onkologicznej'),
	('O6', 1, 0, 'Oddział Chirurgii Onkologicznej'),
	('O7', 3, 1, 'Oddział Chirurgii Onkologicznej'),
	('O8', 2, 0, 'Oddział Chirurgii Onkologicznej'), --8 pokojow
	('G1', 1, 0, 'Oddział Ginekologii Onkologicznej'),
	('G2', 2, 1, 'Oddział Ginekologii Onkologicznej'),
	('G3', 2, 1, 'Oddział Ginekologii Onkologicznej'),
	('G4', 3, 1, 'Oddział Ginekologii Onkologicznej'),
	('G5', 2, 0, 'Oddział Ginekologii Onkologicznej'), --5 pokojow
	('K1', 2, 1, 'Oddział Onkologii Klinicznej'),
	('K2', 2, 1, 'Oddział Onkologii Klinicznej'),
	('K3', 1, 1, 'Oddział Onkologii Klinicznej'); --3 pokoje,		lacznie szpital posiada 26 pokojow z 52 lozkami w sumie



INSERT INTO Pobyty (Data_przyjecia, Data_wypisania, Numer_pacjenta, Nazwa_oddzialu, Numer_pokoju)
	VALUES
	('2018-06-05', '2018-06-28', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 90121003556), 'Oddział Radioterapii', 'R1'), 
	('2019-12-05', '2019-12-12', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 85041806186), 'Oddział Radioterapii', 'R2'),
	('2020-12-12', null,		 (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66010102741), 'Oddział Radioterapii', 'R2'),
	('2008-01-28', '2008-02-05', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 99122303186), 'Oddział Chemioterapii', 'C1'),
	('2015-02-01', '2015-02-18', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 77101516854), 'Oddział Chemioterapii', 'C1'),
	('2016-03-03', '2016-03-04', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 43060911573), 'Oddział Chemioterapii', 'C2'),
	('2018-04-18', '2018-04-21', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 32102964167), 'Oddział Chemioterapii', 'C3'),
	('2020-07-15', '2020-07-23', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 59022467963), 'Oddział Chirurgii Onkologicznej', 'O1'),
	('2020-06-15', '2020-06-30', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 88061513797), 'Oddział Chirurgii Onkologicznej', 'O1'),
	('2017-11-26', '2017-12-01', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 70090174539), 'Oddział Chirurgii Onkologicznej', 'O1'),
	('2020-05-21', '2020-05-24', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 69120305256), 'Oddział Chirurgii Onkologicznej', 'O5'),
	('2019-12-30', '2020-01-07', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66021058619), 'Oddział Chirurgii Onkologicznej', 'O6'),
	('2020-08-01', '2020-08-03', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 72050612765), 'Oddział Ginekologii Onkologicznej', 'G1'),
	('2020-07-31', '2020-08-04', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 29022467892), 'Oddział Ginekologii Onkologicznej', 'G2'),
	('2007-05-28', '2007-06-03', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 81010145617), 'Oddział Ginekologii Onkologicznej', 'G2'),
	('2016-05-07', '2016-05-12', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 44090153734), 'Oddział Ginekologii Onkologicznej', 'G3'),
	('2020-09-04', '2020-09-10', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 49061562671), 'Oddział Onkologii Klinicznej', 'K1'),
	('2020-11-03', '2020-11-09', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 53053056828), 'Oddział Onkologii Klinicznej', 'K2'),
	('2019-10-10', '2019-10-17', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66011653642), 'Oddział Onkologii Klinicznej', 'K3'),
	('2020-12-17', '2021-01-07', (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 71041656632), 'Oddział Onkologii Klinicznej', 'K2');




INSERT INTO Zabiegi_i_operacje (Nazwa, Zalecenia, ID_pobytu, Numer_pacjenta)
	VALUES
	('Kolonoskopia', 'Test', 
				(SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta from Pacjenci where PESEL = 90121003556)), (SELECT Numer_pacjenta from Pacjenci where PESEL = 90121003556)),
	('Gastroskopia', 'Nie palić przez tydzień.',
				(SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta from Pacjenci where PESEL = 90121003556)), (SELECT Numer_pacjenta from Pacjenci where PESEL = 90121003556)),
	('Biopsja prostaty', 'Kontrolować stan zdrowia, w razie potrzeby kontaktować się z lekarzem rodzinnym.', 
				(SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta from Pacjenci where PESEL = 85041806186)), (SELECT Numer_pacjenta from Pacjenci where PESEL = 85041806186)),
	('Kolonoskopia', 'Stosować się do zaleconej diety.', 
				(SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta from Pacjenci where PESEL = 66010102741)), (SELECT Numer_pacjenta from Pacjenci where PESEL = 66010102741)),
	('Usunięcie guza CUN', 'Przyjmować zalecone leki.', 
				(SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta from Pacjenci where PESEL = 99122303186)), (SELECT Numer_pacjenta from Pacjenci where PESEL = 99122303186)),
	('Termoablacja', 'Nie palić przez tydzień i przyjmować zalecone leki.', 
				(SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta from Pacjenci where PESEL = 77101516854)), (SELECT Numer_pacjenta from Pacjenci where PESEL = 77101516854)),
	('Appendektomia', 'Przyjmować zalecone leki.', 
				(SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta from Pacjenci where PESEL = 43060911573)), (SELECT Numer_pacjenta from Pacjenci where PESEL = 43060911573)),
	('Cholecystektomia', 'Skontaktować się z lekarzem rodzinnym po wypisaniu ze szpitala, nie stosować używek.', 
				(SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta from Pacjenci where PESEL = 32102964167)), (SELECT Numer_pacjenta from Pacjenci where PESEL = 32102964167)),
	('Histerektomia z przydatkami', 'Przyjmować zalecone leki. W razie niepokoju kontaktować się z lekarzem rodzinnym.', 
				(SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta from Pacjenci where PESEL = 59022467963)), (SELECT Numer_pacjenta from Pacjenci where PESEL = 59022467963)),
	('Gastroskopia', 'Przyjmować zalecone leki.', 
				(SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta from Pacjenci where PESEL = 88061513797)), (SELECT Numer_pacjenta from Pacjenci where PESEL = 88061513797)),
	('Craniotomia', 'Przyjmować zalecone leki.', 
				(SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta from Pacjenci where PESEL = 70090174539)), (SELECT Numer_pacjenta from Pacjenci where PESEL = 70090174539)),
	('Termoablacja', 'Przyjmować zalecone leki.', 
				(SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta from Pacjenci where PESEL = 69120305256)), (SELECT Numer_pacjenta from Pacjenci where PESEL = 69120305256)),
	('Termoablacja', 'Przyjmować zalecone leki.', 
				(SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta from Pacjenci where PESEL = 66021058619)), (SELECT Numer_pacjenta from Pacjenci where PESEL = 66021058619)),
	('Termoablacja', 'Kontakt z lekarzem rodzinnym i następna wizyta do ustalenia w rejestracji.', 
				(SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta from Pacjenci where PESEL = 71041656632)), (SELECT Numer_pacjenta from Pacjenci where PESEL = 71041656632));

INSERT INTO Badania (Rezonans, Biopsja, CA_125, CEA, Numer_pacjenta)
	VALUES
		('Nie wykryto zmian szczególnych.', null, 17.0, 3.0, 
				(SELECT Numer_pacjenta from Pacjenci where PESEL = 66021058619)),
		('Punkt charakterystyczny do biopsji.', 'Wykryto komórki guzowe w prawej nerce.', null, null, 
				(SELECT Numer_pacjenta from Pacjenci where PESEL = 69120305256)),
		(null, 'Nie wykryto guzków tarczycy.', null, null, 
				(SELECT Numer_pacjenta from Pacjenci where PESEL = 99122303186)),
		(null, null, null, 4.5, 
				(SELECT Numer_pacjenta from Pacjenci where PESEL = 72050612765)),
		(null, null, 24.0, 2.7, 
				(SELECT Numer_pacjenta from Pacjenci where PESEL = 29022467892)),
		(null, 'Nie wykryto zmian nowotworowych w wštrobie, zalecane przeprowadzenie biopsji trzustki.', null, null, 
				(SELECT Numer_pacjenta from Pacjenci where PESEL = 81010145617)),
		('Poszerzony układ komorowy w rezonansie magnetycznym głowy.', null, null, 5.4,
				(SELECT Numer_pacjenta from Pacjenci where PESEL = 44090153734)),
		('Torbiel w rezonansie magnetycznym głowy.', null, 14.0, 1.6,
				(SELECT Numer_pacjenta from Pacjenci where PESEL = 49061562671)),
		('Kręgosłup w stanie fatalnym...', null, null, 43.0,
				(SELECT Numer_pacjenta from Pacjenci where PESEL = 53053056828)),
		(null, 'Wykonana biopsja wskazanego obszaru płuc, ladowe iloci komórek guzowych.', 59.0, 7.5,
				(SELECT Numer_pacjenta from Pacjenci where PESEL = 66011653642)),
		('Brak zmian', 'Wykryto zmianę nowotworowš o rozmiarze 3x2x1', 57.0, 6,
				(SELECT Numer_pacjenta from Pacjenci where PESEL = 71041656632));

INSERT INTO Przebieg_leczenia (Rodzaj_leczenia, Zatrzymanie_sie_choroby, Remisja, Informacje_od_lekarza, Data_zgonu, Numer_pracownika, ID_pobytu, ID_diagnozy)
	VALUES
	('Chemioterapia', 1, 0, null, null,			(SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 90121003556), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 90121003556)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 90121003556))),
	('Radioterapia', 0, 0, null, null,			(SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 85041806186), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 85041806186)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 90121003556))),
	('Leczenie chirurgiczne', 1, 0, null, null, (SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 66010102741), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66010102741)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66010102741))),
	('Medycyna nuklearna', 1, 0, null, null,	(SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 99122303186), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 99122303186)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 99122303186))),
	('HIPEC', 1, 1, null, null,					(SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 77101516854), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 77101516854)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 77101516854))),
	('Chemioterapia', 0, 1, null, '2016-03-04', (SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 43060911573), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 43060911573)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 43060911573))),
	('Chemioterapia', 0, 0, null, null,			(SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 32102964167), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 32102964167)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 32102964167))),
	('Chemioterapia', 1, 0, null, null,			(SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 59022467963), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 59022467963)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 59022467963))),
	('HIPEC', 1, 1, null, '2020-06-30',			(SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 88061513797), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 88061513797)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 88061513797))),
	('Leczenie chirurgiczne', 1, 0, null, null, (SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 70090174539), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 70090174539)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 70090174539))),
	('Chemioterapia', 1, 0, null, null,			(SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 69120305256), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 69120305256)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 69120305256))),
	('Radioterapia', 0, 0, null, null,			(SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 66021058619), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66021058619)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66021058619))),
	('Radioterapia', 1, 0, null, null,		    (SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 72050612765), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 72050612765)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 72050612765))),
	('Chemioterapia', 1, 0, null, null,			(SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 29022467892), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 29022467892)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 29022467892))),
	('Medycyna nuklearna', 1, 1, null, null,	(SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 81010145617), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 81010145617)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 81010145617))),
	('HIPEC', 1, 0, null, null,					(SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 44090153734), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 44090153734)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 44090153734))),
	('Chemioterapia', 1, 0, null, null,			(SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 49061562671), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 49061562671)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 49061562671))),
	('Leczenie chirurgiczne', 0, 1, 'Pacjent zmarł w wyniku powikłań po operacji chirurgicznej.', '2020-11-09', (SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 53053056828), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 53053056828)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 53053056828))),
	('Leczenie chirurgiczne', 1, 0, 'Stosowane leczenie nie przyniosło efektów.', '2019-10-17',					(SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 66011653642), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66011653642)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66011653642))),
	('Leczenie chirurgiczne', 1, 0, 'Zabieg wykonany z powodzeniem.', null,										(SELECT Numer_pracownika FROM Pacjenci WHERE PESEL = 71041656632), (SELECT ID_pobytu FROM Pobyty WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 71041656632)), (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 71041656632)));


INSERT INTO Przyjmowane_leki (Data_rozpoczenia_przyjmowania, Data_zakonczenia_przyjmowania, Dawkowanie, Numer_pacjenta, Nazwa_leku, ID_leczenia)
	VALUES
	('2018-06-15', '2018-08-15', default,					(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 90121003556), 'Lek1', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 90121003556)))),
	('2019-12-10', '2019-12-25', null,						(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 85041806186), 'Lek2', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 85041806186)))),
	('2020-12-12', null, 'Stosować do odwolania.',			(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66010102741), 'Lek3', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66010102741)))),
	('2008-02-18', '2008-03-13', default,				    (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 99122303186), 'Lek1', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 99122303186)))),
	('2015-02-03', null, null,								(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 77101516854), 'Lek3', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 77101516854)))),
	('2016-03-03', '2016-03-05', 'Przeciwko zakrzepicy.',	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 43060911573), 'Lek4', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 43060911573)))),
	('2018-04-18', '2018-04-26', default,					(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 32102964167), 'Lek2', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 32102964167)))),
	('2020-07-30', null, null,								(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 59022467963), 'Lek3', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 59022467963)))),
	('2020-06-15', '2020-06-17', default,					(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 88061513797), 'Lek4', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 88061513797)))),
	('2017-11-30', null, default,							(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 70090174539), 'Lek5', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 70090174539)))),
	('2020-05-21', null, default,							(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 69120305256), 'Lek1', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 69120305256)))),
	('2020-01-03', '2020-05-25', 'Kontrola!',				(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66021058619), 'Lek2', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66021058619)))),
	('2020-08-06', '2020-08-30', default,					(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 72050612765), 'Lek1', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 72050612765)))),
	('2019-02-16', null, 'Jak przestanie dzialac to trudno',(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 29022467892), 'Lek8', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 29022467892)))),
	('2007-04-29', null, default,							(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 81010145617), 'Lek2', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 81010145617)))),
	('2016-05-10', '2016-10-05', default,					(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 44090153734), 'Lek5', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 44090153734)))),
	('2020-09-04', null, default,							(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 49061562671), 'Lek8', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 49061562671)))),
	('2020-11-03', '2020-11-09', default,					(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 53053056828), 'Lek2', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 53053056828)))),
	('2019-10-10', '2019-10-17', 'W razie zmian kontakt.',	(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66011653642), 'Lek3', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 66011653642)))),
	('2020-12-20', null, 'W razie zmian kontakt.',			(SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 71041656632), 'Lek1', (SELECT ID_leczenia FROM Przebieg_leczenia WHERE ID_diagnozy IN (SELECT ID_diagnozy FROM Posiadana_choroba WHERE Numer_pacjenta IN (SELECT Numer_pacjenta FROM Pacjenci WHERE PESEL = 71041656632))));

		 
