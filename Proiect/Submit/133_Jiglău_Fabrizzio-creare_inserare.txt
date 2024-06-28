-- ###########################################################
-- ////////////////////// CREATE /////////////////////////////
-- ###########################################################

-- /////////////////////////// Tara //////////////////////////
CREATE TABLE Tara (
    id_tara NUMBER(5) PRIMARY KEY,
    nume_tara VARCHAR2(50) NOT NULL UNIQUE,
    salariu_mediu NUMBER(5) NOT NULL CHECK (salariu_mediu >= 0)
);
DESCRIBE Tara;

-- /////////////////////////// Locatie ///////////////////////////
CREATE TABLE Locatie (
    id_locatie NUMBER(5) PRIMARY KEY,
    id_tara NUMBER(5) NOT NULL,
    oras VARCHAR2(25) NOT NULL UNIQUE,
    CONSTRAINT fk_locatie_tara FOREIGN KEY (id_tara) REFERENCES Tara(id_tara)
);
DESCRIBE Locatie;

-- /////////////////////////// Developer ///////////////////////////
CREATE TABLE Developer (
    id_developer NUMBER(5) PRIMARY KEY,
    id_locatie NUMBER(5),
    nume_developer VARCHAR2(50) NOT NULL,
    data_lansare_studio DATE NOT NULL,
    salariu_angajati NUMBER(5) NOT NULL CHECK (salariu_angajati > 0),
    CONSTRAINT fk_developer_locatie FOREIGN KEY (id_locatie) REFERENCES Locatie(id_locatie)
);

DESCRIBE Developer;

-- /////////////////////////// Joc ///////////////////////////
CREATE TABLE Joc (
    id_joc NUMBER(5) PRIMARY KEY,
    id_developer NUMBER(5) NOT NULL,
    nume_joc VARCHAR2(50) NOT NULL UNIQUE,
    pret_joc NUMBER(5) NOT NULL CHECK (pret_joc >= 0),
    data_lansare_joc DATE NOT NULL,
    varsta_recomandata NUMBER(3) CHECK (varsta_recomandata >= 0),
    rating NUMBER(1) CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT fk_joc_developer FOREIGN KEY (id_developer) REFERENCES Developer(id_developer)
);
DESCRIBE Joc;

-- /////////////////////////// Utilizator ///////////////////////////
CREATE TABLE Utilizator (
    id_utilizator NUMBER(5) PRIMARY KEY,
    id_tara NUMBER(5) NOT NULL,
    nume_utilizator VARCHAR2(50) NOT NULL,
    parola VARCHAR2(50) NOT NULL,
    email VARCHAR2(50) NOT NULL UNIQUE,
    varsta NUMBER(3) NOT NULL CHECK (varsta >= 0),
    CONSTRAINT fk_utilizator_tara FOREIGN KEY (id_tara) REFERENCES Tara(id_tara)
);
DESCRIBE Utilizator;

-- /////////////////////////// Notificare ///////////////////////////
CREATE TABLE Notificare (
    id_notificare NUMBER(5) PRIMARY KEY,
    id_utilizator NUMBER(5) NOT NULL,
    text_notificare VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_notificare_utilizator FOREIGN KEY (id_utilizator) REFERENCES Utilizator(id_utilizator)
);
DESCRIBE Notificare;

-- /////////////////////////// Mesaj ///////////////////////////
CREATE TABLE Mesaj (
    id_mesaj NUMBER(5) PRIMARY KEY,
    id_notificare NUMBER(5) NOT NULL,
    text_mesaj VARCHAR2(256) NOT NULL,
    este_citit NUMBER(1) NOT NULL CHECK (este_citit IN (0, 1)),
    CONSTRAINT fk_mesaj_notificare FOREIGN KEY (id_notificare) REFERENCES Notificare(id_notificare)
);
DESCRIBE Mesaj;

-- /////////////////////////// Recenzie ///////////////////////////
CREATE TABLE Recenzie (
    id_recenzie NUMBER(5) PRIMARY KEY,
    id_utilizator NUMBER(5) NOT NULL,
    id_joc NUMBER(5) NOT NULL,
    text_recenzie VARCHAR2(256) NOT NULL,
    data_recenzie DATE NOT NULL,
    CONSTRAINT fk_recenzie_utilizator FOREIGN KEY (id_utilizator) REFERENCES Utilizator(id_utilizator),
    CONSTRAINT fk_recenzie_joc FOREIGN KEY (id_joc) REFERENCES Joc(id_joc)
);
DESCRIBE Recenzie;

-- /////////////////////////// Colectie ///////////////////////////
CREATE TABLE Colectie (
    id_colectie NUMBER(5) PRIMARY KEY,
    id_utilizator NUMBER(5) NOT NULL,
    nume_colectie VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_colectie_utilizator FOREIGN KEY (id_utilizator) REFERENCES Utilizator(id_utilizator)
);
DESCRIBE Colectie;

-- /////////////////////////// Colectie_Joc ///////////////////////////
CREATE TABLE Colectie_Joc (
    id_colectie NUMBER(5) NOT NULL,
    id_joc NUMBER(5) NOT NULL,
    PRIMARY KEY (id_colectie, id_joc),
    CONSTRAINT fk_colectie_joc_colectie FOREIGN KEY (id_colectie) REFERENCES Colectie(id_colectie),
    CONSTRAINT fk_colectie_joc_joc FOREIGN KEY (id_joc) REFERENCES Joc(id_joc)
);
DESCRIBE Colectie_Joc;

-- /////////////////////////// Inventar ///////////////////////////
CREATE TABLE Inventar (
    id_inventar NUMBER(5) PRIMARY KEY,
    id_utilizator NUMBER(5) NOT NULL,
    capacitate NUMBER(2) NOT NULL CHECK (capacitate > 0),
    CONSTRAINT fk_inventar_utilizator FOREIGN KEY (id_utilizator) REFERENCES Utilizator(id_utilizator)
);
DESCRIBE Inventar;

-- /////////////////////////// Item ///////////////////////////
CREATE TABLE Item (
    id_item NUMBER(5) PRIMARY KEY,
    id_joc NUMBER(5) NOT NULL,
    nume_item VARCHAR2(100) NOT NULL,
    pret_item NUMBER(10, 2),
    raritate_item VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_item_joc FOREIGN KEY (id_joc) REFERENCES Joc(id_joc)
);
DESCRIBE Item;

-- /////////////////////////// Inventar_Item ///////////////////////////
CREATE TABLE Inventar_Item (
    id_item NUMBER(5) NOT NULL,
    id_inventar NUMBER(5) NOT NULL,
    PRIMARY KEY (id_item, id_inventar),
    CONSTRAINT fk_inventar_item_item FOREIGN KEY (id_item) REFERENCES Item(id_item),
    CONSTRAINT fk_inventar_item_inventar FOREIGN KEY (id_inventar) REFERENCES Inventar(id_inventar)
);

DESCRIBE Inventar_Item;

-- /////////////////////////// Tranzactie ///////////////////////////
CREATE TABLE Tranzactie (
    id_tranzactie NUMBER(5) PRIMARY KEY,
    id_utilizator NUMBER(5) NOT NULL,
    metoda_tranzactie VARCHAR2(25) NOT NULL,
    suma_tranzactie NUMBER(5) NOT NULL CHECK (suma_tranzactie >= 0),
    data_tranzactie DATE NOT NULL ,
    CONSTRAINT fk_depozit_utilizator FOREIGN KEY (id_utilizator) REFERENCES Utilizator(id_utilizator)
);
DESCRIBE Tranzactie;

-- ###########################################################
-- ////////////////////// INSERT /////////////////////////////
-- ###########################################################

-- /////////////////////////// Tara ///////////////////////////

CREATE SEQUENCE seq_tara
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 12;

SELECT * FROM Tara;
INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (seq_tara.nextval, 'SUA', 55000);
INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (seq_tara.nextval, 'Japonia', 40000);
INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (seq_tara.nextval, 'Canada', 45000);
INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (seq_tara.nextval, 'Franta', 43000);
INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (seq_tara.nextval, 'Romania', 12000);
INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (seq_tara.nextval, 'Polonia', 27000);
INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (seq_tara.nextval, 'Suedia', 42000); 
INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (seq_tara.nextval, 'Rusia', 15000); 
INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (seq_tara.nextval, 'Estonia', 23000); 
INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (seq_tara.nextval, 'Germania', 65000); 
INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (seq_tara.nextval, 'Spania', 27000); 
INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (seq_tara.nextval, 'Austria', 43000); 

-- /////////////////////////// Locatie ///////////////////////////
SELECT * FROM Locatie;
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (1, 3, 'Montreal'); -- Canada, Ubisoft Montreal
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (2, 1, 'Redmond'); -- SUA, 343 Industries
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (3, 6, 'Varsovia'); -- Polonia, CD Projekt Red
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (4, 1, 'Santa Monica'); -- SUA, Naughty Dog
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (5, 2, 'Tokyo'); -- Japonia, Kojima Productions
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (6, 1, 'Bellevue'); -- SUA, Valve
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (7, 1, 'New York'); -- SUA, Rockstar Games
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (8, 1, 'Dallas'); -- SUA, id Software
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (9, 1, 'Frisco'); -- SUA, Gearbox Software
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (10, 7, 'Stockholm'); -- Suedia, Mojang Studios
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (11, 3, 'Vancouver'); -- Canada, EA Vancouver, FIFA23
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (12, 5, 'Bucuresti'); -- Romania, EAFC 24
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (13, 8, 'Moscova'); -- Rusia
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (14, 9, 'Tallinn'); -- Estonia
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (15, 10, 'Koln'); -- Germania
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (16, 11, 'Madrid'); -- Spania
INSERT INTO Locatie (id_locatie, id_tara, oras) 
VALUES (17, 12, 'Viena'); -- Austria

-- /////////////////////////// Developer ///////////////////////////
SELECT * FROM Developer;
INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (1, 1, 'Ubisoft Montreal', TO_DATE('1997-01-01', 'YYYY-MM-DD'), 44000); -- Sub medie in Canada
INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (2, 2, '343 Industries', TO_DATE('2007-05-01', 'YYYY-MM-DD'), 53000); -- Sub medie in SUA
INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (3, 3, 'CD Projekt Red', TO_DATE('2002-06-01', 'YYYY-MM-DD'), 26000); -- Sub medie in Polonia
INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (4, 4, 'Naughty Dog', TO_DATE('1984-09-01', 'YYYY-MM-DD'), 60000); -- Peste medie in SUA
INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (5, 5, 'Kojima Productions', TO_DATE('2005-12-01', 'YYYY-MM-DD'), 45000); -- Peste medie in Japonia
INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (6, 6, 'Valve Corporation', TO_DATE('1996-08-01', 'YYYY-MM-DD'), 70000); -- Peste medie in SUA
INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (7, 7, 'Rockstar Games', TO_DATE('1998-12-01', 'YYYY-MM-DD'), 65000); -- Peste medie in SUA
INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (8, 8, 'id Software', TO_DATE('1991-02-01', 'YYYY-MM-DD'), 62000); -- Peste medie in SUA
INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (9, 9, 'Gearbox Software', TO_DATE('1999-02-01', 'YYYY-MM-DD'), 58000); -- Peste medie in SUA
INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (10, 10, 'Mojang Studios', TO_DATE('2009-05-01', 'YYYY-MM-DD'), 50000); -- Peste medie in Suedia
INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (11, 12, 'EA Romania', TO_DATE('2016-03-01', 'YYYY-MM-DD'), 21000); -- Peste medie in Romania
INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (12, 11, 'EA Vancouver', TO_DATE('1983-01-01', 'YYYY-MM-DD'), 46000); -- Peste medie in Canada

-- /////////////////////////// Joc ///////////////////////////
SELECT * FROM Joc;
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (1, 1, 'Assassins Creed Valhalla', 60, TO_DATE('2020-11-10', 'YYYY-MM-DD'), 18, 4);
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (2, 2, 'Halo Infinite', 60, TO_DATE('2021-12-08', 'YYYY-MM-DD'), 16, 3);
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (3, 3, 'Cyberpunk 2077', 60, TO_DATE('2020-12-10', 'YYYY-MM-DD'), 18, 3);
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (4, 4, 'The Last of Us Part II', 60, TO_DATE('2020-06-19', 'YYYY-MM-DD'), 18, 5);
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (5, 5, 'Death Stranding', 60, TO_DATE('2019-11-08', 'YYYY-MM-DD'), 16, 4);
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (6, 6, 'Ghost of Tsushima', 60, TO_DATE('2020-07-17', 'YYYY-MM-DD'), 18, 4);
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (7, 5, 'Monster Hunter World', 60, TO_DATE('2018-01-26', 'YYYY-MM-DD'), 16, 4);
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (8, 7, 'Red Dead Redemption 2', 60, TO_DATE('2018-10-26', 'YYYY-MM-DD'), 18, 5);
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (9, 8, 'Doom Eternal', 60, TO_DATE('2020-03-20', 'YYYY-MM-DD'), 18, 4);
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (10, 9, 'Borderlands 3', 60, TO_DATE('2019-09-13', 'YYYY-MM-DD'), 18, 4);
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (11, 10, 'Minecraft', 30, TO_DATE('2011-11-18', 'YYYY-MM-DD'), 10, 5);
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (12, 11, 'EAFC 24', 60, TO_DATE('2030-09-30', 'YYYY-MM-DD'), 3, 4);
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (13, 12, 'FIFA 23', 60, TO_DATE('2022-09-30', 'YYYY-MM-DD'), 3, 3);
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (14, 6, 'CS:GO', 0, TO_DATE('2012-08-21', 'YYYY-MM-DD'), 16, 5);
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (15, 6, 'TF2', 0, TO_DATE('2007-10-10', 'YYYY-MM-DD'), 12, 5);
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (16, 6, 'Portal 2', 20, TO_DATE('2011-04-19', 'YYYY-MM-DD'), 10, 5);

-- /////////////////////////// Utilizator ///////////////////////////
SELECT * FROM Utilizator;
INSERT INTO Utilizator (id_utilizator, nume_utilizator, parola, email, varsta, id_tara) 
VALUES (1, 'QuantumLeap', 'timeTravel42', 'alex.ramirez@protonmail.com', 18, 1); -- SUA
INSERT INTO Utilizator (id_utilizator, nume_utilizator, parola, email, varsta, id_tara) 
VALUES (2, 'GlitchWizard', 'codeMancer88', 'nina.schwartz@zoho.com', 19, 7); -- Suedia
INSERT INTO Utilizator (id_utilizator, nume_utilizator, parola, email, varsta, id_tara) 
VALUES (3, 'NeonRider', 'speedOfLight77', 'leon.tang@yandex.com', 21, 2); -- Japonia
INSERT INTO Utilizator (id_utilizator, nume_utilizator, parola, email, varsta, id_tara) 
VALUES (4, 'PixelHunter', 'sharpShooter89', 'marco.valenti@gmail.com', 12, 1); -- SUA
INSERT INTO Utilizator (id_utilizator, nume_utilizator, parola, email, varsta, id_tara) 
VALUES (5, 'FrostMage', 'chillFactor0', 'sarah.muller@web.de', 23, 10); -- Germania
INSERT INTO Utilizator (id_utilizator, nume_utilizator, parola, email, varsta, id_tara) 
VALUES (6, 'StormCaster', 'stormyWeather22', 'emily.dubois@yahoo.fr', 18, 4); -- Franta
INSERT INTO Utilizator (id_utilizator, nume_utilizator, parola, email, varsta, id_tara) 
VALUES (7, 'RaresAndrei07', 'raresica123', 'rares.stanescu@gmail.com', 19, 5); -- Romania
INSERT INTO Utilizator (id_utilizator, nume_utilizator, parola, email, varsta, id_tara) 
VALUES (8, 'RigbyJohnny', 'bunaparolaasta00', 'vlad.stefan@gmail.com', 19, 5); -- Romania

-- /////////////////////////// Notificare ///////////////////////////
SELECT * FROM Notificare;
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (1, 1, 'Noutati in cont. VERDE');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (2, 1, 'Actualizare importanta. PORTOCALIU');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (3, 2, 'Alerta de securitate. ROSU');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (4, 2, 'Promotii noi. VERDE');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (5, 3, 'Feedback procesat. VERDE');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (6, 4, 'Termeni actualizati. PORTOCALIU');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (7, 5, 'Cont expira curand. PORTOCALIU');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (8, 6, 'Eligibil pentru upgrade. VERDE');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (9, 7, 'Oferta speciala expira. PORTOCALIU');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (10, 8, 'Suspiciune de frauda. ROSU');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (11, 3, 'Joc preferat actualizat. VERDE');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (12, 3, 'Reduceri de weekend. PORTOCALIU');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (13, 4, 'Alerta securitate. ROSU');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (14, 4, 'Invitatie beta test. VERDE');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (15, 5, 'Abonament expira curand. PORTOCALIU');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (16, 6, 'Cadou in inventar. VERDE');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (17, 7, 'Sondaj comunitate. VERDE');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (18, 7, 'Update joc efectuat. VERDE');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (19, 8, 'Functie noua disponibila. VERDE');
INSERT INTO  Notificare (id_notificare, id_utilizator, text_notificare) 
VALUES (20, 8, 'Update securitate. ROSU');

-- /////////////////////////// Mesaj ///////////////////////////
SELECT * FROM Mesaj;
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (1, 1, 'Ai noutati in contul tau. Verifica-le acum!', 0);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (2, 2, 'O actualizare importanta este disponibila pentru tine.', 1);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (3, 3, 'Alerta de securitate! Verifica activitatea recenta.', 0);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (4, 4, 'Profita de promotiile noi adaugate recent.', 1);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (5, 5, 'Feedback-ul tau a fost procesat cu succes.', 0);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (6, 6, 'Termenii si conditiile au fost actualizati.', 1);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (7, 7, 'Atentie, contul tau va expira in curand.', 0);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (8, 8, 'Esti eligibil pentru un upgrade. Detalii in cont.', 1);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (9, 9, 'Ultima sansa sa profiti de oferta speciala.', 0);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (10, 10, 'Suspiciune de frauda detectata. Actioneaza imediat!', 1);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (11, 11, 'Jocul tau preferat a fost actualizat recent.', 0);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (12, 12, 'Reduceri de weekend disponibile acum.', 1);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (13, 13, 'Alerta de securitate majora! Verifica imediat.', 0);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (14, 14, 'Ai fost invitat la un beta test. Inscrie-te acum.', 1);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (15, 15, 'Abonamentul tau este pe cale sa expire. Reinnoieste-l.', 0);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (16, 16, 'Verifica inventarul tau pentru un cadou surpriza.', 1);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (17, 17, 'Participa la sondajul nostru si castiga puncte.', 0);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (18, 18, 'Update-ul jocului tau a fost efectuat cu succes.', 1);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (19, 19, 'O noua functie este acum disponibila in contul tau.', 1);
INSERT INTO Mesaj (id_mesaj, id_notificare, text_mesaj, este_citit) 
VALUES (20, 20, 'Este disponibil un update important de securitate.', 1);

-- /////////////////////////// Recenzie ///////////////////////////
SELECT * FROM Recenzie;
INSERT INTO Recenzie (id_recenzie, id_utilizator, id_joc, text_recenzie, data_recenzie) 
VALUES (1, 1, 1, 'Explorarea in stil viking este detaliata si captivanta. POZITIV', TO_DATE('2020-08-10', 'YYYY-MM-DD'));
INSERT INTO Recenzie (id_recenzie, id_utilizator, id_joc, text_recenzie, data_recenzie) 
VALUES (2, 5, 2, 'Gameplay-ul este robust, dar campania este scurta. NEGATIV', TO_DATE('2022-01-15', 'YYYY-MM-DD'));
INSERT INTO Recenzie (id_recenzie, id_utilizator, id_joc, text_recenzie, data_recenzie) 
VALUES (3, 8, 3, 'Viziunea futurista este impresionanta, dar plina de bug-uri. NEGATIV', TO_DATE('2020-09-10', 'YYYY-MM-DD'));
INSERT INTO Recenzie (id_recenzie, id_utilizator, id_joc, text_recenzie, data_recenzie) 
VALUES (4, 3, 4, 'Poveste profunda si emotionanta. POZITIV', TO_DATE('2020-12-20', 'YYYY-MM-DD'));
INSERT INTO Recenzie (id_recenzie, id_utilizator, id_joc, text_recenzie, data_recenzie) 
VALUES (5, 4, 5, 'Jocul redefineste genul, dar nu este pentru toata lumea. NEGATIV', TO_DATE('2019-08-08', 'YYYY-MM-DD'));
INSERT INTO Recenzie (id_recenzie, id_utilizator, id_joc, text_recenzie, data_recenzie) 
VALUES (6, 2, 6, 'Un peisaj deschis superb si lupte detaliate. POZITIV', TO_DATE('2020-10-17', 'YYYY-MM-DD'));
INSERT INTO Recenzie (id_recenzie, id_utilizator, id_joc, text_recenzie, data_recenzie) 
VALUES (7, 7, 7, 'Complex si detaliat, dar dificil pentru incepatori. NEGATIV', TO_DATE('2018-07-26', 'YYYY-MM-DD'));
INSERT INTO Recenzie (id_recenzie, id_utilizator, id_joc, text_recenzie, data_recenzie) 
VALUES (8, 6, 8, 'O capodopera narativa cu un ritm lent. POZITIV', TO_DATE('2018-04-26', 'YYYY-MM-DD'));
INSERT INTO Recenzie (id_recenzie, id_utilizator, id_joc, text_recenzie, data_recenzie) 
VALUES (9, 1, 9, 'Actiune non-stop si grafica impresionanta. POZITIV', TO_DATE('2020-03-19', 'YYYY-MM-DD'));
INSERT INTO Recenzie (id_recenzie, id_utilizator, id_joc, text_recenzie, data_recenzie) 
VALUES (10, 5, 10, 'Lume uriasa ce asteapta sa fie explorata. POZITIV', TO_DATE('2019-09-14', 'YYYY-MM-DD'));
INSERT INTO Recenzie (id_recenzie, id_utilizator, id_joc, text_recenzie, data_recenzie) 
VALUES (11, 1, 11, 'Creativitate fara limite si distractie continua. POZITIV', TO_DATE('2023-10-01', 'YYYY-MM-DD'));
INSERT INTO Recenzie (id_recenzie, id_utilizator, id_joc, text_recenzie, data_recenzie) 
VALUES (12, 5, 12, 'Evolutie impresionanta in simularea fotbalului, gameplay rafinat. POZITIV', TO_DATE('2030-09-29', 'YYYY-MM-DD'));
INSERT INTO Recenzie (id_recenzie, id_utilizator, id_joc, text_recenzie, data_recenzie) 
VALUES (13, 8, 13, 'Simulare realista a fotbalului, dar cu microtranzactii excesive. NEGATIV', TO_DATE('2022-10-01', 'YYYY-MM-DD'));
INSERT INTO Recenzie (id_recenzie, id_utilizator, id_joc, text_recenzie, data_recenzie) 
VALUES (14, 1, 14, 'Competitiv si captivant, un clasic al shooterelor. POZITIV', TO_DATE('2012-09-01', 'YYYY-MM-DD'));
INSERT INTO Recenzie (id_recenzie, id_utilizator, id_joc, text_recenzie, data_recenzie) 
VALUES (15, 8, 15, 'Distractiv si strategic, cu o comunitate vibranta. POZITIV', TO_DATE('2007-09-30', 'YYYY-MM-DD'));
INSERT INTO Recenzie (id_recenzie, id_utilizator, id_joc, text_recenzie, data_recenzie) 
VALUES (16, 3, 16, 'Puzzle-uri ingenioase si un umor deosebit. POZITIV', TO_DATE('2011-05-19', 'YYYY-MM-DD'));

-- /////////////////////////// Colectie ///////////////////////////
SELECT * FROM Colectie;
INSERT INTO Colectie (id_colectie, id_utilizator, nume_colectie) 
VALUES (1, 1, 'Calatorii in Timp');
INSERT INTO Colectie (id_colectie, id_utilizator, nume_colectie) 
VALUES (2, 1, 'Exploarea spatiului');
INSERT INTO Colectie (id_colectie, id_utilizator, nume_colectie) 
VALUES (3, 2, 'Cosmar');
INSERT INTO Colectie (id_colectie, id_utilizator, nume_colectie) 
VALUES (4, 2, 'Lumi Deschise');
INSERT INTO Colectie (id_colectie, id_utilizator, nume_colectie) 
VALUES (5, 3, 'Actiune Intensa');
INSERT INTO Colectie (id_colectie, id_utilizator, nume_colectie) 
VALUES (6, 3, 'Cupe Mondiale');
INSERT INTO Colectie (id_colectie, id_utilizator, nume_colectie) 
VALUES (7, 4, 'RPG-uri Epice');
INSERT INTO Colectie (id_colectie, id_utilizator, nume_colectie) 
VALUES (8, 4, 'Shootere Tactice');
INSERT INTO Colectie (id_colectie, id_utilizator, nume_colectie) 
VALUES (9, 5, 'Paranormal');
INSERT INTO Colectie (id_colectie, id_utilizator, nume_colectie) 
VALUES (10, 5, 'Adrenalina la Maxim');
INSERT INTO Colectie (id_colectie, id_utilizator, nume_colectie) 
VALUES (11, 7, 'Povesti Epice');
INSERT INTO Colectie (id_colectie, id_utilizator, nume_colectie) 
VALUES (12, 7, 'Strategie si Tactici');
INSERT INTO Colectie (id_colectie, id_utilizator, nume_colectie) 
VALUES (13, 8, 'Sci-Fi si Fantezie');
INSERT INTO Colectie (id_colectie, id_utilizator, nume_colectie) 
VALUES (14, 8, 'Arena Sportiva');

-- /////////////////////////// Colectie_Joc ///////////////////////////
SELECT * FROM Colectie_Joc;
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (1, 1);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (2, 2);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (3, 9);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (4, 8);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (5, 4);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (6, 13);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (7, 3);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (8, 14);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (9, 16);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (10, 5);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (11, 11);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (12, 11);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (13, 4);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (14, 2);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (1, 3);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (14, 13);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (4, 6);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (7, 7);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (10, 9);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (5, 10);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (8, 15);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (12, 16);
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (10, 14); 
INSERT INTO Colectie_Joc (id_colectie, id_joc) VALUES (14, 12);

-- /////////////////////////// Inventar ///////////////////////////
SELECT * FROM Inventar;
INSERT INTO Inventar (id_inventar, id_utilizator, capacitate) VALUES (1, 1, 10);
INSERT INTO Inventar (id_inventar, id_utilizator, capacitate) VALUES (2, 2, 3);
INSERT INTO Inventar (id_inventar, id_utilizator, capacitate) VALUES (3, 3, 5);
INSERT INTO Inventar (id_inventar, id_utilizator, capacitate) VALUES (4, 4, 6);
INSERT INTO Inventar (id_inventar, id_utilizator, capacitate) VALUES (5, 5, 2);
INSERT INTO Inventar (id_inventar, id_utilizator, capacitate) VALUES (6, 6, 3);
INSERT INTO Inventar (id_inventar, id_utilizator, capacitate) VALUES (7, 7, 4);
INSERT INTO Inventar (id_inventar, id_utilizator, capacitate) VALUES (8, 8, 3);

-- /////////////////////////// Item ///////////////////////////
SELECT * FROM Item;
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc) 
VALUES (1, 'AK-47 | Redline', 25.00, 'CLASSIFIED', 14);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc) 
VALUES (2, 'AWP | Dragon Lore', 1500.00, 'COVERT', 14);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc) 
VALUES (3, 'Mann Co. Supply Crate Key', 2.50, 'COMMON', 15);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc)
VALUES (4, 'Unusual Hat', 200.00, 'UNUSUAL', 15);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc)
VALUES (5, 'Glock-18 | Fade', 300.00, 'COVERT', 14);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc)
VALUES (6, 'Strange Rocket Launcher', 50.00, 'STRANGE', 15);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc) 
VALUES (7, 'M4A4 | Howl', 1800.00, 'CONTRABAND', 14);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc) 
VALUES (8, 'Strange Professional Killstreak Scattergun', 100.00, 'STRANGE', 15);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc) 
VALUES (9, 'Desert Eagle | Blaze', 600.00, 'COVERT', 14);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc) 
VALUES (10, 'Unusual Taunt', 150.00, 'UNUSUAL', 15);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc) 
VALUES (11, 'Karambit | Doppler', 1200.00, 'COVERT', 14);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc)
VALUES (12, 'Australium Wrench', 100.00, 'AUSTRALIUM', 15);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc)
VALUES (13, 'P90 | Asiimov', 50.00, 'CLASSIFIED', 14);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc)
VALUES (14, 'Strange Professional Killstreak Minigun', 200.00, 'STRANGE', 15);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc)
VALUES (15, 'USP-S | Kill Confirmed', 100.00, 'COVERT', 14);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc)
VALUES (16, 'Unusual Rocket Launcher', 300.00, 'UNUSUAL', 15);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc) 
VALUES (17, 'AK-47 | Elite Build', 1.50, 'MIL-SPEC', 14);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc)
VALUES (18, 'AWP | Worm God', 2.00, 'MIL-SPEC', 14);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc) 
VALUES (19, 'FAMAS | Pulse', 0.75, 'RESTRICTED', 14);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc) 
VALUES (20, 'Galil AR | Chatterbox', 3.00, 'RESTRICTED', 14);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc) 
VALUES (21, 'UMP-45 | Primal Saber', 1.20, 'RESTRICTED', 14);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc) 
VALUES (22, 'CZ75-Auto | The Fuschia Is Now', 0.90, 'RESTRICTED', 14);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc) 
VALUES (23, 'MP7 | Bloodsport', 1.50, 'RESTRICTED', 14);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc)
VALUES (24, 'SG 553 | Pulse', 0.70, 'MIL-SPEC', 14);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc)
VALUES (25, 'P250 | Supernova', 0.65, 'MIL-SPEC', 14);
INSERT INTO Item (id_item, nume_item, raritate_item, id_joc) 
VALUES (26, 'Useless Item', 'MIL-SPEC', 14);

-- /////////////////////////// Inventar_Item ///////////////////////////
SELECT * FROM Inventar_Item;
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (5, 1);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (12, 1);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (7, 1);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (19, 1);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (3, 1);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (26, 1);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (9, 2);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (15, 2);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (22, 2);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (1, 2);  -- Ex
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (14, 3);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (6, 3);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (17, 3);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (20, 4);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (21, 4);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (24, 4);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (2, 5);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (11, 5);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (18, 5);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (25, 5);  -- Ex
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (4, 6);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (8, 6);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (10, 7);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (13, 7);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (16, 7);
INSERT INTO Inventar_Item (id_item, id_inventar) VALUES (23, 8);

-- /////////////////////////// Tranzactie ///////////////////////////
SELECT * FROM Tranzactie;
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (1, 1, 'Card de credit', 100, TO_DATE('2023-09-15', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (2, 1, 'PayPal', 50, TO_DATE('2023-08-21', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (3, 2, 'Card de debit', 25, TO_DATE('2023-07-30', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (4, 2, 'Transfer bancar', 200, TO_DATE('2023-09-05', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (5, 3, 'Card de credit', 45, TO_DATE('2023-10-11', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (6, 4, 'Card de debit', 150, TO_DATE('2023-08-25', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (7, 5, 'PayPal', 30, TO_DATE('2023-09-20', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (8, 6, 'Transfer bancar', 75, TO_DATE('2023-10-02', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (9, 1, 'Card de credit', 120, TO_DATE('2023-11-01', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (10, 1, 'PayPal', 60, TO_DATE('2023-11-15', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (11, 2, 'Card de debit', 35, TO_DATE('2023-12-05', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (12, 2, 'Transfer bancar', 210, TO_DATE('2023-12-20', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (13, 3, 'Card de credit', 50, TO_DATE('2023-11-10', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (14, 4, 'Card de debit', 160, TO_DATE('2023-11-25', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (15, 5, 'PayPal', 40, TO_DATE('2023-12-01', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (16, 6, 'Transfer bancar', 80, TO_DATE('2023-11-20', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (17, 7, 'Card de credit', 95, TO_DATE('2023-12-15', 'YYYY-MM-DD'));
INSERT INTO Tranzactie (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (18, 8, 'PayPal', 55, TO_DATE('2023-11-30', 'YYYY-MM-DD'));
