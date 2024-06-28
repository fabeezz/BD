-- ######################### CERINTA 12 ######################################
-- CEREREA 1
-- a) subcereri sincronizate în care intervin cel pu?in 3 tabele
-- b) subcereri nesincronizate în clauza FROM

-- Sa se afiseze numele si tara utilizatorilor cu varsta 
-- pana in 20 de ani care locuiesc in tari cu studio-uri
-- de development.
SELECT u_u20.nume, u_u20.tara tara_utilizator, 
       DECODE((
           SELECT t.nume_tara
           FROM Developer d, Locatie l, Tara t
           WHERE d.id_locatie = l.id_locatie
                AND l.id_tara = t.id_tara
                AND t.nume_tara = u_u20.tara
           GROUP BY t.nume_tara
       ), NULL, 'NU EXISTA', 'EXISTA') tara_studio
FROM (
    SELECT u.nume_utilizator nume, t.nume_tara tara
    FROM utilizator u, tara t
    WHERE u.id_tara = t.id_tara 
    AND u.varsta <= 20
) u_u20;

-- CEREREA 2
-- c) grup?ri de date, func?ii grup, filtrare la nivel de grupuri 
-- cu subcereri nesincronizate (în clauza de HAVING) în care intervin
-- cel pu?in 3 tabele (in cadrul aceleia?i cereri)

-- Sa se afiseze numele si valoarea totala a jocurilor utilizatorilor care
-- au valoarea medie a jocurilor detinute in librarie (reuniunea colectiilor)
-- peste valoarea medie a jocurilor dezvoltate de studio-uri din SUA.
SELECT u.nume_utilizator, SUM(j.pret_joc) AS valoare_jocuri
FROM Utilizator u, Colectie c, Colectie_Joc cj, Joc j
WHERE u.id_utilizator = c.id_utilizator     
    AND c.id_colectie = cj.id_colectie
    AND cj.id_joc = j.id_joc
GROUP BY u.nume_utilizator
HAVING AVG(j.pret_joc) > (
        SELECT AVG(j1.pret_joc)
        FROM Joc j1, Developer d, Locatie l, Tara t
        WHERE j1.id_developer = d.id_developer 
            AND d.id_locatie = l.id_locatie 
            AND l.id_tara = t.id_tara 
            AND t.nume_tara LIKE 'SUA'
)
ORDER BY valoare_jocuri;

-- CEREREA 3
-- d) ordon?ri si utilizarea func?iilor NVL ?i DECODE
-- (în cadrul aceleia?i cereri)

-- Afisati numele utilizatorilor impreuna cu valoarea inventarului lor. 
-- Daca valoarea este sub 500, afisati "INCEPATOR", altfel "BOGAT".
-- Sortati descrescator dupa valoarea inventarului.
SELECT NumeUtiliz, 
        ValoareInv, DECODE(SIGN(500 - ValoareInv), 
                                1, 'INCEPATOR', 
                                'BOGAT') conditie
FROM (
    SELECT u.nume_utilizator AS NumeUtiliz,
           SUM(NVL(i.pret_item, 0)) AS ValoareInv
    FROM Utilizator u, Inventar inv, Inventar_Item ii, Item i
    WHERE u.id_utilizator = inv.id_utilizator 
        AND inv.id_inventar = ii.id_inventar 
        AND ii.id_item = i.id_item
    GROUP BY u.nume_utilizator
)
ORDER BY ValoareInv DESC;

-- CEREREA 4
-- e) utilizarea a cel putin 2 functii pe siruri de caractere, 
-- 2 functii pe date calendaristice, a cel putin unei expresii CASE

-- Sa se afiseze numele utilizatorului, domeniul email-ului (doar pentru
-- utilizatorii care nu folosesc yandex.com) si numele jocurilor din colectii
-- (cu majuscule) pentru utilizatorii care detin jocuri lansate pana acum 3 ani, 
-- cu recenzii date de acestia in ultimii 5 ani. Daca utilizatorul a lasat o
-- recenzie inainte de data lansarii jocului, este "EARLY TESTER", altfel
-- este un "UTILIZATOR OBISNUIT". Sortati dupa numele utilizatorului.
SELECT u.nume_utilizator,
    SUBSTR(u.email, INSTR(u.email, '@') + 1) AS domeniu_mail,
    UPPER(j.nume_joc) AS joc_upper,
    CASE 
        WHEN MONTHS_BETWEEN(r.data_recenzie, j.data_lansare_joc) < 0 
            THEN 'EARLY TESTER'
        ELSE 
            'UTILIZATOR OBISNUIT'
    END AS tip_utilizator
FROM Joc j, Colectie c, Colectie_Joc cj, Utilizator u, Recenzie r
WHERE j.id_joc = cj.id_joc
    AND c.id_colectie = cj.id_colectie 
    AND c.id_utilizator = u.id_utilizator 
    AND r.id_utilizator = u.id_utilizator
    AND r.id_joc = j.id_joc
    AND u.email NOT LIKE '%yandex.com'
    AND j.data_lansare_joc <= ADD_MONTHS(SYSDATE, -36) -- jocuri lansate pana acum 3 ani
    AND r.data_recenzie >= ADD_MONTHS(SYSDATE, -60) -- recenzie din ultimii 4 ani
ORDER BY u.nume_utilizator;

--CEREREA 5
-- f)utilizarea a cel putin 1 bloc de cerere (clauza WITH)

-- Afisati numele, tara si suma totala adunata din tranzactii pentru
-- utilizatorii platformei. Daca suma este mai mica de 75, afisati
-- "Intelept", intre 75 si 200, "Entuziast", altfel "Cheltuitor".
-- Ordonati descrescator dupa suma ceruta.
WITH Suma_Tranzactii AS (
    SELECT id_utilizator, SUM(suma_tranzactie) AS total
    FROM Tranzactie
    GROUP BY id_utilizator
)
SELECT u.nume_utilizator, t.nume_tara, st.total,
    CASE 
        WHEN st.total > 200 THEN 'Cheltuitor'
        WHEN st.total > 75 THEN 'Entuziast'
        ELSE 'Intelept'
    END AS tip_cumparator
FROM Utilizator u, Suma_Tranzactii st, Tara t
WHERE u.id_utilizator = st.id_utilizator
    AND u.id_tara = t.id_tara
ORDER BY st.total DESC;

-- ######################### CERINTA 13 ######################################
-- 1
-- Stergeti din Inventar Si Item itemele care au raritatea "MEH"
-- si apartin jocului "Disliked Game".
DELETE FROM Item i
WHERE i.id_item IN (
        SELECT i1.id_item
        FROM Item i1, Joc j
        WHERE i1.id_joc = j.id_joc
            AND i1.raritate_item LIKE 'MEH'
            AND j.nume_joc LIKE 'Disliked Game');

-- /// insert-urile necesare
INSERT INTO Joc (id_joc, id_developer, nume_joc, pret_joc, data_lansare_joc, varsta_recomandata, rating)
VALUES (17, 11, 'Disliked Game', 5, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 10, 1);
SELECT * FROM Joc;

INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc)
VALUES (27, 'Filler 1', 10, 'MEH', 17);
INSERT INTO Item (id_item, nume_item, pret_item, raritate_item, id_joc)
VALUES (28, 'Filler 2', 1.2, 'MEH', 17);
SELECT * FROM Item;
-- ///      
-- /// delete jocul adaugat
DELETE FROM Joc j
WHERE j.id_joc = 17;
-- ///

-- 2
-- Adaugati cate 10 u.m. la fiecare tranzactie a 
-- utilizatorului cu suma tranzactiilor mai mare de 400 u.m.
UPDATE Tranzactie
SET suma_tranzactie = suma_tranzactie - 10
WHERE id_utilizator IN (
    SELECT id_utilizator
    FROM Tranzactie
    GROUP BY id_utilizator
    HAVING SUM(suma_tranzactie) > 400
);

-- pentru a testa
SELECT id_utilizator, SUM(suma_tranzactie) suma, COUNT(suma_tranzactie) nr_tranzactii
    FROM Tranzactie
    GROUP BY id_utilizator
    HAVING SUM(suma_tranzactie) > 400;
    
--3
-- Adaugati un nou atribut tabelei Developer numit "salariu_bun",
-- unde acesta are valoarea “DA” daca angajatii au salariul mai mare decat
-- media salariilor tarii in care lucreaza, si "NU" in caz contrar.
ALTER TABLE Developer
ADD (salariu_bun VARCHAR2(25));

UPDATE Developer d
SET d.salariu_bun = (
    CASE 
        WHEN d.salariu_angajati > (
            SELECT t.salariu_mediu
            FROM Locatie l, Tara t
            WHERE l.id_locatie = d.id_locatie
                AND l.id_tara = t.id_tara
        ) THEN 'DA'
        ELSE 'NU'
    END
);

-- /// verificari
describe developer;
select * from developer;
-- ///

-- /// stergerea atributului
ALTER TABLE Developer
DROP COLUMN salariu_bun;
-- ///

-- ######################### CERINTA 14 ######################################

-- Vizualizare complexa care cuprinde id-ul si numele utilizatorilor,
-- notificarile si mesajele primite, precum si daca mesajul este citit.
CREATE VIEW Util_Notif_Mesaj AS
SELECT u.id_utilizator, u.nume_utilizator, n.text_notificare,
    m.este_citit, m.text_mesaj
FROM Mesaj m, Notificare n, Utilizator u
WHERE m.id_notificare = n.id_notificare 
    AND u.id_utilizator = n.id_utilizator;
    
SELECT * FROM util_notif_mesaj order by 1;
    
-- Operatie permisa
-- Afisati utilizatorii care au toate mesajele citite. Adaugati si
-- numarul de mesaje primite.
SELECT id_utilizator, nume_utilizator, COUNT(text_mesaj) nr_mesaje
FROM Util_Notif_Mesaj
GROUP BY id_utilizator, nume_utilizator
HAVING MIN(este_citit) = 1;

-- Operatie nepermisa
INSERT INTO Util_Notif_Mesaj
VALUES (90, 'hACKed', 'CONT SPART! ROSU', 0, 'ITI VEI PIERDE TOT!');

-- ######################### CERINTA 15 ######################################
-- CEREREA 1
-- o cerere ce utilizeaza operatia outer-join pe minimum 4 tabele
-- (LEFT OUTER JOIN)

-- Afisati numele utilizatorilor, id-ul recenziilor date,
-- jocurile evaluate si colectiile utilizatorului, indiferent daca detine colectii.
SELECT u.nume_utilizator, r.id_recenzie, j.nume_joc, c.nume_colectie
FROM utilizator u
LEFT OUTER JOIN recenzie r ON u.id_utilizator = r.id_utilizator
LEFT OUTER JOIN joc j ON r.id_joc = j.id_joc
LEFT OUTER JOIN colectie c ON u.id_utilizator = c.id_utilizator;

-- CEREREA 2
-- o cerere ce utilizeaza operatia division
-- Afisati toate tarile cu numar par de litere
-- in care nu exista studio-uri de jocuri.
SELECT t.nume_tara
FROM Tara t
WHERE MOD(LENGTH(t.nume_tara), 2) = 0
    AND NOT EXISTS (
        SELECT l.id_locatie
        FROM Locatie l, Developer d
        WHERE l.id_locatie = d.id_locatie 
    AND l.id_tara = t.id_tara
);

-- CEREREA 3
-- o cerere care implementeaza analiza top-n.

-- Afisati top 3 utilizatori cu cel mai mare numar de iteme.
-- Afisati si id-ul utilizatorului si numarul de iteme.
SELECT id_utilizator, nume_utilizator, numar_iteme
FROM (
    SELECT u.id_utilizator, u.nume_utilizator, 
    COUNT(ii.id_item) AS numar_iteme
    FROM Utilizator u, Inventar i, Inventar_Item ii
    WHERE u.id_utilizator = i.id_utilizator 
        AND i.id_inventar = ii.id_inventar
    GROUP BY u.id_utilizator, u.nume_utilizator
    ORDER BY COUNT(ii.id_item) DESC
)
WHERE ROWNUM <= 3;