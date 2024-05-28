Name            Null?    Type         
--------------- -------- ------------ 
ID_UTILIZATOR   NOT NULL NUMBER(5)    
NUME_UTILIZATOR NOT NULL VARCHAR2(50) 
PAROLA          NOT NULL VARCHAR2(25) 
EMAIL           NOT NULL VARCHAR2(25) 
VARSTA          NOT NULL NUMBER(3)    
TARA            NOT NULL VARCHAR2(25) 

SELECT * FROM Utilizator order by tara;

INSERT INTO Utilizator (id_utilizator, nume_utilizator, parola, email, varsta, tara) 
VALUES (1, 'QuantumLeap', 'timeTravel42', 'alex.ramirez@protonmail.com', 18, 'USA');

INSERT INTO Utilizator (id_utilizator, nume_utilizator, parola, email, varsta, tara) 
VALUES (2, 'GlitchWizard', 'codeMancer88', 'nina.schwartz@zoho.com', 19, 'Sweden');

INSERT INTO Utilizator (id_utilizator, nume_utilizator, parola, email, varsta, tara) 
VALUES (3, 'NeonRider', 'speedOfLight77', 'leon.tang@yandex.com', 21, 'Japan');

INSERT INTO Utilizator (id_utilizator, nume_utilizator, parola, email, varsta, tara) 
VALUES (4, 'PixelHunter', 'sharpShooter89', 'marco.valenti@gmail.com', 18, 'USA');

INSERT INTO Utilizator (id_utilizator, nume_utilizator, parola, email, varsta, tara) 
VALUES (5, 'FrostMage', 'chillFactor0', 'sarah.muller@web.de', 23, 'Germany');

INSERT INTO Utilizator (id_utilizator, nume_utilizator, parola, email, varsta, tara) 
VALUES (6, 'StormCaster', 'stormyWeather22', 'emily.dubois@yahoo.fr', 18, 'France');

INSERT INTO Utilizator (id_utilizator, nume_utilizator, parola, email, varsta, tara) 
VALUES (7, 'RaresAndrei07', 'raresica123', 'rares.stanescu@gmail.com', 19, 'Romania');

INSERT INTO Utilizator (id_utilizator, nume_utilizator, parola, email, varsta, tara) 
VALUES (8, 'RigbyJohnny', 'bunaparolaasta00', 'vlad.stefan@gmail.com', 19, 'Romania');

--////////////////////////////////////////////////////

Name          Null?    Type          
------------- -------- ------------- 
ID_RECENZII   NOT NULL NUMBER(5)     
ID_UTILIZATOR NOT NULL NUMBER(5)     
NUME_JOC      NOT NULL VARCHAR2(50)  
TEXT_RECENZII NOT NULL VARCHAR2(256) 
DATA_RECENZII NOT NULL DATE 

SELECT * FROM Recenzii ORDER BY id_utilizator;

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (1, 1, 'Assassin’s Creed Valhalla', 'Explorarea viking? este detaliat? ?i captivant?. POZITIV', TO_DATE('2020-08-10', 'YYYY-MM-DD'));
-- Game's release date: 2020-11-10 (Review 3 months before release)

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (2, 5, 'Halo Infinite', 'Gameplay-ul este robust, dar campania este scurt?. NEGATIV', TO_DATE('2022-01-15', 'YYYY-MM-DD'));
-- Game's release date: 2021-12-08 (Review about 1 month after release)

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (3, 8, 'Cyberpunk 2077', 'Viziunea futurist? este impresionant?, dar plin? de erori. NEGATIV', TO_DATE('2020-09-10', 'YYYY-MM-DD'));
-- Game's release date: 2020-12-10 (Review 3 months before release)

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (4, 3, 'The Last of Us Part II', 'Narrativa este profund? ?i emo?ionant?. POZITIV', TO_DATE('2020-12-20', 'YYYY-MM-DD'));
-- Game's release date: 2020-06-19 (Review 6 months after release)

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (5, 4, 'Death Stranding', 'Jocul redefine?te genul, dar nu este pentru toat? lumea. NEGATIV', TO_DATE('2019-08-08', 'YYYY-MM-DD'));
-- Game's release date: 2019-11-08 (Review 3 months before release)

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (6, 2, 'Ghost of Tsushima', 'Un peisaj deschis superb ?i lupte tactice. POZITIV', TO_DATE('2020-10-17', 'YYYY-MM-DD'));
-- Game's release date: 2020-07-17 (Review 3 months after release)

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (7, 7, 'Monster Hunter World', 'Complex ?i recompensator, dar dificil pentru încep?tori. NEGATIV', TO_DATE('2018-07-26', 'YYYY-MM-DD'));
-- Game's release date: 2018-01-26 (Review 6 months after release)

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (8, 6, 'Red Dead Redemption 2', 'O capodoper? narativ? cu un ritm lent. POZITIV', TO_DATE('2018-04-26', 'YYYY-MM-DD'));
-- Game's release date: 2018-10-26 (Review 6 months before release)

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (9, 1, 'Doom Eternal', 'Ac?iune non-stop ?i grafic? impresionant?. POZITIV', TO_DATE('2020-03-19', 'YYYY-MM-DD'));
-- Game's release date: 2020-03-20 (Review 1 day before release)

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (10, 5, 'Borderlands 3', 'Explorare vast? ?i loot satisf?c?tor. POZITIV', TO_DATE('2019-09-14', 'YYYY-MM-DD'));
-- Game's release date: 2019-09-13 (Review 1 day after release)

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (11, 8, 'Resident Evil 3', 'Remake bine realizat, dar scurt. NEGATIV', TO_DATE('2020-03-20', 'YYYY-MM-DD'));
-- Game's release date: 2020-04-03 (Review 2 weeks before release)

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (12, 1, 'Minecraft', 'Creativitate f?r? limite ?i distrac?ie continu?. POZITIV', TO_DATE('2023-10-01', 'YYYY-MM-DD'));
-- Game's release date: 2011-11-18 (Review long after release)

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (13, 5, 'EAFC 24', 'Evolu?ie impresionant? în simularea fotbalului, gameplay rafinat. POZITIV', TO_DATE('2030-09-29', 'YYYY-MM-DD'));
-- Game's hypothetical release date: 2030-09-30 (Review 1 day before release)

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (14, 8, 'FIFA 23', 'Simulare realist? a fotbalului, dar cu microtranzac?ii excesive. NEGATIV', TO_DATE('2022-10-01', 'YYYY-MM-DD'));
-- Game's release date: 2022-09-30 (Review 1 day after release)

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (15, 1, 'CS:GO', 'Competitiv ?i captivant, un clasic al shooterelor. POZITIV', TO_DATE('2012-09-01', 'YYYY-MM-DD'));
-- Game's release date: 2012-08-21 (Review 11 days after release)

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (16, 8, 'TF2', 'Distractiv ?i strategic, cu o comunitate vibrant?. POZITIV', TO_DATE('2007-09-30', 'YYYY-MM-DD'));
-- Game's release date: 2007-10-10 (Review 10 days before release)

INSERT INTO Recenzii (id_recenzii, id_utilizator, nume_joc, text_recenzii, data_recenzii) 
VALUES (17, 3, 'Portal 2', 'Puzzle-uri ingenioase ?i un umor deosebit. POZITIV', TO_DATE('2011-05-19', 'YYYY-MM-DD'));
-- Game's release date: 2011-04-19 (Review 1 month after release)

--/////////////////////////////////////////////////////////////
Name              Null?    Type         
----------------- -------- ------------ 
ID_TRANZACTIE     NOT NULL NUMBER(5)    
ID_UTILIZATOR     NOT NULL NUMBER(5)    
METODA_TRANZACTIE NOT NULL VARCHAR2(25) 
SUMA_TRANZACTIE   NOT NULL NUMBER(5)    
DATA_TRANZACTIE   NOT NULL DATE  

SELECT * FROM Tranzactii ORDER BY id_utilizator;

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (1, 1, 'Card de credit', 100, TO_DATE('2023-09-15', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (2, 1, 'PayPal', 50, TO_DATE('2023-08-21', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (3, 2, 'Card de debit', 25, TO_DATE('2023-07-30', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (4, 2, 'Transfer bancar', 200, TO_DATE('2023-09-05', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (5, 3, 'Card de credit', 45, TO_DATE('2023-10-11', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (6, 4, 'Card de debit', 150, TO_DATE('2023-08-25', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (7, 5, 'PayPal', 30, TO_DATE('2023-09-20', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (8, 6, 'Transfer bancar', 75, TO_DATE('2023-10-02', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (9, 1, 'Card de credit', 120, TO_DATE('2023-11-01', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (10, 1, 'PayPal', 60, TO_DATE('2023-11-15', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (11, 2, 'Card de debit', 35, TO_DATE('2023-12-05', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (12, 2, 'Transfer bancar', 210, TO_DATE('2023-12-20', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (13, 3, 'Card de credit', 50, TO_DATE('2023-11-10', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (14, 4, 'Card de debit', 160, TO_DATE('2023-11-25', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (15, 5, 'PayPal', 40, TO_DATE('2023-12-01', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (16, 6, 'Transfer bancar', 80, TO_DATE('2023-11-20', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (17, 7, 'Card de credit', 95, TO_DATE('2023-12-15', 'YYYY-MM-DD'));

INSERT INTO Tranzactii (id_tranzactie, id_utilizator, metoda_tranzactie, suma_tranzactie, data_tranzactie) 
VALUES (18, 8, 'PayPal', 55, TO_DATE('2023-11-30', 'YYYY-MM-DD'));

--///////////////////////////////////////////////
Name            Null?    Type         
--------------- -------- ------------ 
ID_NOTIFICARE   NOT NULL NUMBER(5)    
ID_UTILIZATOR   NOT NULL NUMBER(5)    
TEXT_NOTIFICARE NOT NULL VARCHAR2(50) 

SELECT * FROM Notificari;

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (1, 1, 'Nout??i în cont. GREEN');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (2, 1, 'Actualizare important?. ORANGE');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (3, 2, 'Alert? de securitate. RED');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (4, 2, 'Promo?ii noi. GREEN');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (5, 3, 'Feedback procesat. GREEN');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (6, 4, 'Termeni actualiza?i. ORANGE');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (7, 5, 'Cont expir? curând. ORANGE');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (8, 6, 'Eligibil pentru upgrade. GREEN');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (9, 7, 'Ofert? special? expir?. ORANGE');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (10, 8, 'Suspiciune de fraud?. RED');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (11, 3, 'Joc preferat actualizat. GREEN');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (12, 3, 'Reduceri de weekend. ORANGE');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (13, 4, 'Alert? securitate. RED');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (14, 4, 'Invita?ie beta test. GREEN');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (15, 5, 'Abonament expir? curând. ORANGE');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (16, 6, 'Cadou în inventar. GREEN');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (17, 7, 'Sondaj comunitate. GREEN');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (18, 7, 'Update joc efectuat. GREEN');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (19, 8, 'Func?ie nou? disponibil?. GREEN');

INSERT INTO Notificari (id_notificare, id_utilizator, text_notificare) 
VALUES (20, 8, 'Update securitate. RED');

--///////////////////////////////////////////////////////
Name          Null?    Type          
------------- -------- ------------- 
ID_MESAJ      NOT NULL NUMBER(5)     
ID_NOTIFICARI NOT NULL NUMBER(5)     
TEXT_MESAJ    NOT NULL VARCHAR2(256) 
ESTE_CITIT    NOT NULL NUMBER(1)

SELECT * FROM Mesaj;

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (1, 1, 'Ai nout??i în contul t?u. Verific?-le acum!', 0);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (2, 2, 'O actualizare important? este disponibil? pentru tine.', 1);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (3, 3, 'Alert? de securitate! Verific? activitatea recent?.', 0);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (4, 4, 'Profit? de promo?iile noi ad?ugate recent.', 1);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (5, 5, 'Feedback-ul t?u a fost procesat cu succes.', 0);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (6, 6, 'Termenii ?i condi?iile au fost actualiza?i.', 1);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (7, 7, 'Aten?ie, contul t?u va expira în curând.', 0);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (8, 8, 'E?ti eligibil pentru un upgrade. Detalii în cont.', 1);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (9, 9, 'Ultima ?ans? s? profi?i de oferta special?.', 0);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (10, 10, 'Suspiciune de fraud? detectat?. Ac?ioneaz? imediat!', 1);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (11, 11, 'Jocul t?u preferat a fost actualizat recent.', 0);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (12, 12, 'Reduceri de weekend disponibile acum.', 1);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (13, 13, 'Alert? de securitate major?! Verific? imediat.', 0);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (14, 14, 'Ai fost invitat la un beta test. Înscrie-te acum.', 1);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (15, 15, 'Abonamentul t?u este pe cale s? expire. Reînnoie?te-l.', 0);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (16, 16, 'Verific? inventarul t?u pentru un cadou surpriz?.', 1);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (17, 17, 'Particip? la sondajul nostru ?i câ?tig? puncte.', 0);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (18, 18, 'Update-ul jocului t?u a fost efectuat cu succes.', 1);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (19, 19, 'O nou? func?ie este acum disponibil? în contul t?u.', 1);

INSERT INTO Mesaj (id_mesaj, id_notificari, text_mesaj, este_citit) 
VALUES (20, 20, 'Este disponibil un update important de securitate.', 1);

--//////////////////////////////////
Name          Null?    Type         
------------- -------- ------------ 
ID_TARA       NOT NULL NUMBER(5)    
NUME_TARA     NOT NULL VARCHAR2(50) 
SALARIU_MEDIU NOT NULL NUMBER(5)

SELECT * FROM Tara;

INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (1, 'Statele Unite ale Americii', 55000);

INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (2, 'Japonia', 40000);

INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (3, 'Canada', 45000);

INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (4, 'Regatul Unit', 43000);

INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (5, 'România', 12000);

INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (6, 'Polonia', 27000);

INSERT INTO Tara (id_tara, nume_tara, salariu_mediu) 
VALUES (7, 'Suedia', 42000); 

--///////////////////////////////////////////////
Name       Null?    Type         
---------- -------- ------------ 
ID_LOCATIE NOT NULL NUMBER(5)    
ID_TARA    NOT NULL NUMBER(5)    
ORAS       NOT NULL VARCHAR2(25) 

SELECT * FROM Locatie;

INSERT INTO Locatie (id_locatie, id_tara, oras) VALUES (1, 3, 'Montreal'); -- Canada, Ubisoft Montreal
INSERT INTO Locatie (id_locatie, id_tara, oras) VALUES (2, 1, 'Redmond'); -- USA, 343 Industries
INSERT INTO Locatie (id_locatie, id_tara, oras) VALUES (3, 6, 'Var?ovia'); -- Poland, CD Projekt Red
INSERT INTO Locatie (id_locatie, id_tara, oras) VALUES (4, 1, 'Santa Monica'); -- USA, Naughty Dog
INSERT INTO Locatie (id_locatie, id_tara, oras) VALUES (5, 2, 'Tokyo'); -- Japan, Kojima Productions
INSERT INTO Locatie (id_locatie, id_tara, oras) VALUES (6, 1, 'Bellevue'); -- USA, Valve
INSERT INTO Locatie (id_locatie, id_tara, oras) VALUES (7, 1, 'New York'); -- USA, Rockstar Games
INSERT INTO Locatie (id_locatie, id_tara, oras) VALUES (8, 1, 'Dallas'); -- USA, id Software
INSERT INTO Locatie (id_locatie, id_tara, oras) VALUES (9, 1, 'Frisco'); -- USA, Gearbox Software
INSERT INTO Locatie (id_locatie, id_tara, oras) VALUES (10, 7, 'Stockholm'); -- Sweden, Mojang Studios
INSERT INTO Locatie (id_locatie, id_tara, oras) VALUES (11, 3, 'Vancouver'); -- Canada, EA Vancouver, FIFA23
INSERT INTO Locatie (id_locatie, id_tara, oras) VALUES (12, 5, 'Bucure?ti'); -- Romania, EAFC 24

--/////////////////////////////////////
Name                Null?    Type         
------------------- -------- ------------ 
ID_DEVELOPER        NOT NULL NUMBER(5)    
ID_LOCATIE          NOT NULL NUMBER(5)    
NUME_DEVELOPER      NOT NULL VARCHAR2(50) 
DATA_LANSARE_STUDIO NOT NULL DATE         
SALARIU_ANGAJATI    NOT NULL NUMBER(5)

SELECT * FROM Developer ORDER BY SALARIU_ANGAJATI;

INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (1, 1, 'Ubisoft Montreal', TO_DATE('1997-01-01', 'YYYY-MM-DD'), 44000); -- Below average in Canada

INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (2, 2, '343 Industries', TO_DATE('2007-05-01', 'YYYY-MM-DD'), 53000); -- Below average in USA

INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (3, 3, 'CD Projekt Red', TO_DATE('2002-06-01', 'YYYY-MM-DD'), 26000); -- Below average in Poland

INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (4, 4, 'Naughty Dog', TO_DATE('1984-09-01', 'YYYY-MM-DD'), 60000); -- Above average in USA

INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (5, 5, 'Kojima Productions', TO_DATE('2005-12-01', 'YYYY-MM-DD'), 45000); -- Above average in Japan

INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (6, 6, 'Valve Corporation', TO_DATE('1996-08-01', 'YYYY-MM-DD'), 70000); -- Above average in USA

INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (7, 7, 'Rockstar Games', TO_DATE('1998-12-01', 'YYYY-MM-DD'), 65000); -- Above average in USA

INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (8, 8, 'id Software', TO_DATE('1991-02-01', 'YYYY-MM-DD'), 62000); -- Above average in USA

INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (9, 9, 'Gearbox Software', TO_DATE('1999-02-01', 'YYYY-MM-DD'), 58000); -- Above average in USA

INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (10, 10, 'Mojang Studios', TO_DATE('2009-05-01', 'YYYY-MM-DD'), 50000); -- Above average in Sweden

INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (11, 12, 'EA Romania', TO_DATE('2016-03-01', 'YYYY-MM-DD'), 21000); -- Above average in Romania

INSERT INTO Developer (id_developer, id_locatie, nume_developer, data_lansare_studio, salariu_angajati)
VALUES (12, 11, 'EA Vancouver', TO_DATE('1983-01-01', 'YYYY-MM-DD'), 46000); -- Above average in Canada

COMMIT;