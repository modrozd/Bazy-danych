DECLARE @NOW DATETIME = '2020-12-21 00:00:00' 
DECLARE @DOB DATETIME = '1986-07-05' 

--SELECT DATEDIFF(YY, @DOB, @NOW) - 
  --CASE WHEN MONTH(@DOB) > MONTH(@NOW) 
    --OR MONTH(@DOB) = MONTH(@NOW) AND DAY(@DOB) > DAY(@NOW) 
  --THEN 1 ELSE 0 END

SELECT * FROM Choroba
SELECT * FROM Lek
SELECT * FROM Oddzialy
SELECT * FROM Lekarze
SELECT * FROM Pacjenci
SELECT * FROM Posiadana_choroba
SELECT * FROM Pokoj_pacjenta
SELECT * FROM Pobyty
SELECT * FROM Zabiegi_i_operacje
SELECT * FROM Badania
SELECT * FROM Przebieg_leczenia
SELECT * FROM Przyjmowane_leki

--SELECT NR 1: Wypisz wszystkich pacjentow, ktorzy zaczeli przyjmowac 'Lek1' w ciagu ostatnich 31 dni od konkretnej daty
SELECT 
	Lek.Nazwa_leku,
	--Przyjmowane_leki.ID_listy_lekow, --zakomentowane by nie wyswietlac listy lekow
	Pacjenci.Nazwisko,
	Pacjenci.Numer_pacjenta,
	Przyjmowane_leki.Data_rozpoczenia_przyjmowania
FROM
	Lek, Przyjmowane_leki, Pacjenci
WHERE
	Przyjmowane_leki.Numer_pacjenta = Pacjenci.Numer_pacjenta
AND
	Lek.Nazwa_leku = 'Lek1'
AND
	DATEDIFF(day, Przyjmowane_leki.Data_rozpoczenia_przyjmowania, '2020-12-24') <= 31


--SELECT NR 2: U ilu osob wykryto choroby (i co to byly za choroby) o stopniu zaawansowania wyzszym 
-- niz 2 i po jakim leczeniu uznano, ze jej rozwoj sie zatrzymal
--Wypisać grupując wg liczby pacjentów malejąco
SELECT 
	COUNT(*) AS 'Liczba pacjentów',
	PCH.ID_choroby,
	PL.Rodzaj_leczenia AS 'Zastosowane leczenie'
FROM
	Choroba as CH
INNER JOIN
	Posiadana_choroba as PCH
ON  
	CH.ID_choroby = PCH.ID_choroby
INNER JOIN
	Przebieg_leczenia as PL
ON  
	PCH.ID_diagnozy = PL.ID_diagnozy
WHERE
	PCH.Stopien_zaawansowania > 2
AND PL.Zatrzymanie_sie_choroby = 1
GROUP BY
	PCH.ID_choroby, PL.Rodzaj_leczenia
ORDER BY 'Liczba pacjentów' DESC


--SELECT NR 3: Zwroc liste pacjentow przyjetych na Oddzial Radioterapii (rosnaco wiekiem)
--miedzy 2018-01-01 a 2021-01-01 oraz informacje jaki lekarz ich prowadzil
SELECT
	PAC.Numer_pacjenta,
	PAC.Nazwisko,
	POB.Data_przyjecia,
	PAC.Numer_pracownika
FROM
	Pobyty as POB
INNER JOIN
	Pacjenci as PAC
ON
	POB.Numer_pacjenta = PAC.Numer_pacjenta
WHERE
	POB.Data_przyjecia BETWEEN '2018-01-01' AND '2021-01-01'
AND
	Nazwa_oddzialu = 'Oddział Radioterapii'
ORDER BY
	PAC.Data_urodzenia ASC

--SELECT NR 4: Wypisz pacjentow prowadzonych przez lekarza X u ktorych wynik CEA jest pomiedzy 0-10
GO 
CREATE VIEW [Nadzor_pacjentow] AS
SELECT 
	Pacjenci.Nazwisko,
	Pacjenci.Numer_pacjenta,
	Pacjenci.Numer_pracownika
FROM 
	Pacjenci, Badania, Lekarze
WHERE
	Pacjenci.Numer_pacjenta = Badania.Numer_pacjenta
AND
	Pacjenci.Numer_pracownika = Lekarze.Numer_pracownika
AND 
	Pacjenci.Numer_pracownika = (SELECT Numer_pracownika FROM Lekarze WHERE PESEL=69113067926) -- nr pracownika 5
AND
	Badania.CEA BETWEEN 0 AND 10

SELECT * FROM Nadzor_pacjentow
DROP VIEW Nadzor_pacjentow


--SELECT NR 5: Kto jest ordynatorem (Imię, nazwisko, numer pracownika) Oddziału Onkologii Klinicznej
GO
CREATE VIEW [Lista_ordynatorow] AS
SELECT
	Lekarze.Imie,
	Lekarze.Nazwisko,
	Lekarze.Numer_pracownika,
	Oddzialy.Nazwa_oddzialu
FROM
	Lekarze, Oddzialy
WHERE
	Lekarze.Numer_pracownika = Oddzialy.Ordynator
AND
	Oddzialy.Nazwa_oddzialu = 'Oddział Onkologii Klinicznej'

SELECT * FROM Lista_ordynatorow
DROP VIEW Lista_ordynatorow

--SELECT NR 6: Na jakim oddziale i w jakim pokoju przebywa pacjent o nazwisku X
SELECT
	POK_PAC.Nazwa_oddzialu,
	POK_PAC.Numer_pokoju,
	POB.Data_przyjecia
FROM
	Pokoj_pacjenta as POK_PAC
INNER JOIN
	Pobyty as POB
ON
	POK_PAC.Nazwa_oddzialu = POB.Nazwa_oddzialu
AND
	POK_PAC.Numer_pokoju = POB.Numer_pokoju
AND
	POB.Numer_pacjenta = (SELECT Numer_pacjenta FROM Pacjenci WHERE Pacjenci.Nazwisko = 'Kot')
	

--SELECT NR 7: Wypisz wszystkich lekarzy o specjalizacji 'Onkolog kliniczny' lub 'Chirurg onkolog' wg ich wieku
SELECT
	Lekarze.Imie,
	Lekarze.Nazwisko,
	Lekarze.Specjalizacja
FROM
	Lekarze
WHERE
	Lekarze.Specjalizacja = 'Onkolog kliniczny' OR Lekarze.Specjalizacja = 'Chirurg onkolog'
ORDER BY
	Lekarze.Data_urodzenia ASC


--SELECT NR 8: Jaki jest średni wiek w którym wykrywano u pacjentów chorobę X
SELECT 
	AVG(DATEDIFF(year, Pacjenci.Data_urodzenia, Posiadana_choroba.Data_rozpoznania)) AS 'Średni wiek',
	Posiadana_choroba.ID_choroby
FROM
	Pacjenci, Posiadana_choroba
WHERE
	Posiadana_choroba.ID_choroby BETWEEN 1 AND 5
GROUP BY
	Posiadana_choroba.ID_choroby
	
