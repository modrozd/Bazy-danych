CREATE TABLE Choroba 
(
	ID_choroby int PRIMARY KEY CHECK(ID_choroby 
		IN(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20))
);

CREATE TABLE Lek
(
	Nazwa_leku varchar(10) PRIMARY KEY CHECK( Nazwa_leku IN ('Lek1', 'Lek2', 'Lek3', 'Lek4', 'Lek5', 'Lek6', 'Lek7', 'Lek8', 'Lek9', 'Lek10', 'Lek11',
															 'Lek12', 'Lek13', 'Lek14', 'Lek15', 'Lek16', 'Lek17', 'Lek18', 'Lek19', 'Lek20'))
); 

CREATE TABLE Oddzialy
(
	Nazwa_oddzialu varchar(50) PRIMARY KEY CHECK (Nazwa_oddzialu IN('Oddzia³ Radioterapii', 'Oddzia³ Chemioterapii', 'Oddzia³ Chirurgii Onkologicznej',
																	'Oddzia³ Ginekologii Onkologicznej', 'Oddzia³ Onkologii Klinicznej','Oddzia³ Diagnostyki Obrazowej')),
	Ordynator int not null
);

CREATE TABLE Lekarze
(
	Numer_pracownika int IDENTITY(1,1) PRIMARY KEY,
	PESEL bigint CHECK(PESEL >= 10000000000 and PESEL < 100000000000) UNIQUE not null,
	Imie varchar(30) not null,
	Nazwisko varchar(30) not null,
	Plec char(1) CHECK(Plec IN('M','K')) not null,
	Data_urodzenia date not null,
	Specjalizacja varchar(50) not null,
	Numer_przelozonego int REFERENCES Lekarze(Numer_pracownika),
	Nazwa_oddzialu varchar(50) FOREIGN KEY REFERENCES Oddzialy(Nazwa_oddzialu)
);

CREATE TABLE Pacjenci
(
	Numer_pacjenta int IDENTITY(1,1) PRIMARY KEY,
	PESEL bigint CHECK(PESEL >= 10000000000 and PESEL < 100000000000) UNIQUE not null,
	Imie varchar(30) not null,
	Nazwisko varchar(30) not null,
	Plec char(1) CHECK(Plec IN('M','K')) not null,
	Data_urodzenia date not null,
	Numer_pracownika int FOREIGN KEY REFERENCES Lekarze(Numer_pracownika) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Posiadana_choroba
(
	ID_diagnozy int IDENTITY(1,1) PRIMARY KEY,
	Data_rozpoznania date not null,
	Stopien_zaawansowania int CHECK (Stopien_zaawansowania > 0 AND Stopien_zaawansowania < 5),
	ID_choroby int FOREIGN KEY REFERENCES Choroba(ID_choroby),
	Numer_pacjenta int FOREIGN KEY REFERENCES Pacjenci(Numer_pacjenta) ON DELETE CASCADE
);


CREATE TABLE Pokoj_pacjenta
(
	Numer_pokoju char(2) PRIMARY KEY,
	Ilosc_lozek int not null,
	Lazienka int CHECK( Lazienka IN(0,1)) DEFAULT 0,
	Nazwa_oddzialu varchar(50) FOREIGN KEY REFERENCES Oddzialy(Nazwa_oddzialu)
);

CREATE TABLE Pobyty
(
	ID_pobytu int IDENTITY(1,1) PRIMARY KEY,
	Data_przyjecia date not null,
	Data_wypisania date,
	Numer_pacjenta int FOREIGN KEY REFERENCES Pacjenci(Numer_pacjenta) ON DELETE CASCADE,
	Nazwa_oddzialu varchar(50) FOREIGN KEY REFERENCES Oddzialy(Nazwa_oddzialu),
	Numer_pokoju char(2) FOREIGN KEY REFERENCES Pokoj_pacjenta(Numer_pokoju)
);

CREATE TABLE Zabiegi_i_operacje
(
	ID_dzialania int IDENTITY(1,1) PRIMARY KEY,
	Nazwa varchar(50) 
		CHECK(Nazwa IN('Gastroskopia', 'Kolonoskopia', 'Biopsja prostaty','Usuniêcie guza CUN', 
					   'Termoablacja', 'Appendektomia', 'Cholecystektomia', 'Histerektomia z przydatkami',
					   'Craniotomia')) not null,
	Zalecenia varchar(100),
	ID_pobytu int FOREIGN KEY REFERENCES Pobyty(ID_pobytu) ON DELETE CASCADE,
	Numer_pacjenta int FOREIGN KEY REFERENCES Pacjenci(Numer_pacjenta)
);

CREATE TABLE Badania
(
	ID_listy_badan int IDENTITY(1,1) PRIMARY KEY,
	Rezonans varchar(100),
	Biopsja varchar(100),
	CA_125 float,
	CEA float,
	Numer_pacjenta int FOREIGN KEY REFERENCES Pacjenci(Numer_pacjenta)
);

CREATE TABLE Przebieg_leczenia
(
	ID_leczenia int IDENTITY(1,1) PRIMARY KEY,
	Rodzaj_leczenia varchar(50) CHECK(Rodzaj_leczenia IN('Chemioterapia','Radioterapia','Leczenie chirurgiczne', 
														 'Medycyna nuklearna', 'HIPEC')),
	Zatrzymanie_sie_choroby int CHECK(Zatrzymanie_sie_choroby IN(0,1)),
	Remisja int CHECK(Remisja IN(0,1)),
	Informacje_od_lekarza varchar(150) DEFAULT 'Jest ok!',
	Data_zgonu date, 
	Numer_pracownika int FOREIGN KEY REFERENCES Lekarze(Numer_pracownika),
	ID_pobytu int FOREIGN KEY REFERENCES Pobyty(ID_pobytu),
	ID_diagnozy int FOREIGN KEY REFERENCES Posiadana_choroba(ID_diagnozy) ON DELETE CASCADE
);

CREATE TABLE Przyjmowane_leki
(
	ID_listy_lekow int IDENTITY(1,1) PRIMARY KEY,
	Data_rozpoczenia_przyjmowania date not null,
	Data_zakonczenia_przyjmowania date,
	Dawkowanie varchar(50) DEFAULT 'Wg ulotki.',
	Numer_pacjenta int FOREIGN KEY REFERENCES Pacjenci(Numer_pacjenta),
	Nazwa_leku varchar(10) FOREIGN KEY REFERENCES Lek(Nazwa_leku),
	ID_leczenia int FOREIGN KEY REFERENCES Przebieg_leczenia(ID_leczenia)
);
