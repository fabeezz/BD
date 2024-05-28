--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE TABLE Utilizator (
    id_utilizator NUMBER(5) PRIMARY KEY,
    nume_utilizator VARCHAR2(50) NOT NULL,
    parola VARCHAR2(25) NOT NULL,
    email VARCHAR2(50) NOT NULL UNIQUE,
    varsta NUMBER(3) NOT NULL CHECK (varsta >= 0),
    tara VARCHAR2(25) NOT NULL
);
ALTER TABLE Utilizator
MODIFY email VARCHAR2(50);
DESCRIBE Utilizator;

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE TABLE Recenzii (
    id_recenzii NUMBER(5) PRIMARY KEY,
    id_utilizator NUMBER(5) NOT NULL,
    nume_joc VARCHAR2(50) NOT NULL,
    text_recenzii VARCHAR2(256) NOT NULL,
    data_recenzii DATE NOT NULL,
    CONSTRAINT fk_utilizator_recenzii FOREIGN KEY (id_utilizator) REFERENCES Utilizator(id_utilizator)
);
DESCRIBE Recenzii;

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE TABLE Tranzactii (
    id_tranzactie NUMBER(5) PRIMARY KEY,
    id_utilizator NUMBER(5) NOT NULL,
    metoda_tranzactie VARCHAR2(25) NOT NULL,
    suma_tranzactie NUMBER(5) NOT NULL CHECK (suma_tranzactie >= 0),
    data_tranzactie DATE NOT NULL,
    CONSTRAINT fk_utilizator_tranzactii FOREIGN KEY (id_utilizator) REFERENCES Utilizator(id_utilizator)
);
DESCRIBE Tranzactii;

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE TABLE Notificari (
    id_notificare NUMBER(5) PRIMARY KEY,
    id_utilizator NUMBER(5) NOT NULL,
    text_notificare VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_utilizator_notificari FOREIGN KEY (id_utilizator) REFERENCES Utilizator(id_utilizator)
);
DESCRIBE Notificari;

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE TABLE Mesaj (
    id_mesaj NUMBER(5) PRIMARY KEY,
    id_notificari NUMBER(5) NOT NULL,
    text_mesaj VARCHAR2(256) NOT NULL,
    este_citit NUMBER(1) NOT NULL CHECK (este_citit IN (0, 1)),
    CONSTRAINT fk_notificari FOREIGN KEY (id_notificari) REFERENCES Notificari(id_notificare)
);
DESCRIBE Mesaj;

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE TABLE Tara (
    id_tara NUMBER(5) PRIMARY KEY,
    nume_tara VARCHAR2(50) NOT NULL UNIQUE,
    salariu_mediu NUMBER(5) NOT NULL CHECK (salariu_mediu >= 0)
);
DESCRIBE Tara;

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE TABLE Locatie (
    id_locatie NUMBER(5) PRIMARY KEY,
    id_tara NUMBER(5) NOT NULL,
    oras VARCHAR2(25) NOT NULL,
    CONSTRAINT fk_tara FOREIGN KEY (id_tara) REFERENCES Tara(id_tara)
);
DESCRIBE Locatie;

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE TABLE Developer (
    id_developer NUMBER(5) PRIMARY KEY,
    id_locatie NUMBER(5) NOT NULL,
    nume_developer VARCHAR2(50) NOT NULL UNIQUE,
    data_lansare_studio DATE NOT NULL,
    salariu_angajati NUMBER(5) NOT NULL CHECK (salariu_angajati >= 0),
    CONSTRAINT fk_locatie FOREIGN KEY (id_locatie) REFERENCES Locatie(id_locatie)
);
DESCRIBE Developer;

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE TABLE Colectie (
    id_colectie NUMBER(5) PRIMARY KEY,
    id_utilizator NUMBER(5) NOT NULL,
    nume_colectie VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_utilizator FOREIGN KEY (id_utilizator) REFERENCES Utilizator(id_utilizator)
);
DESCRIBE Colectie;

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE TABLE Joc (
    id_joc NUMBER(5) PRIMARY KEY,
    id_developer NUMBER(5) NOT NULL,
    nume_joc VARCHAR2(50) NOT NULL UNIQUE,
    pret_joc NUMBER(5) NOT NULL CHECK (pret_joc >= 0),
    data_lansare_joc DATE NOT NULL,
    varsta_recomandata NUMBER(3) NOT NULL CHECK (varsta_recomandata >= 0),
    rating NUMBER(1) CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT fk_developer FOREIGN KEY (id_developer) REFERENCES Developer(id_developer)
);
DESCRIBE Joc;

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CREATE TABLE Colectie_Joc (
    id_colectie NUMBER(5) NOT NULL,
    id_joc NUMBER(5) NOT NULL,
    PRIMARY KEY (id_colectie, id_joc),
    CONSTRAINT fk_colectie FOREIGN KEY (id_colectie) REFERENCES Colectie(id_colectie),
    CONSTRAINT fk_joc FOREIGN KEY (id_joc) REFERENCES Joc(id_joc)
);
DESCRIBE Colectie_Joc;

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////
COMMIT;