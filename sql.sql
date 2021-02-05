-- 1.	Išrinkite visus duomenis iš lentelės “IMONES”.
SELECT * FROM `IMONES`;
-- 2.	Išveskite, kiek iš viso mokinių mokinasi akademijoje.
SELECT COUNT(*) FROM `MOKINIAI`;
-- 3.	Išrinkite duomenis (vardas, pavardė, gimimo data) apie visas mokines moteris.
SELECT `VARDAS`, `PAVARDE`, `GIMIMO_DATA` FROM `MOKINIAI` WHERE CAST(`ASMENS_KODAS` AS CHAR) LIKE '4%';
-- 4.	Išrinkite duomenis (asmens kodas, vardas ir pavardė) apie mokinius, kurių įmonės kodas yra 1 ir 3 (panaudokite operatorių IN.)
SELECT `ASMENS_KODAS`, `VARDAS`, `PAVARDE` FROM `MOKINIAI` WHERE `IMONES_KODAS` IN (1, 3);
-- 5.	Išrinkite visus mokinius (ID, vardas, įmonės kodas), kurie yra priskirti įmonėms ir jų ID yra nuo 4 iki 7.
SELECT `ID`, `VARDAS`, `IMONES_KODAS` FROM `MOKINIAI` WHERE `IMONES_KODAS` IS NOT NULL AND `ID` BETWEEN 4 AND 7;
-- 6.	Išrinkite visus duomenis apie mokinius, kurių pavardėje ketvirta nuo priekio raidė yra “a”.
SELECT * FROM `MOKINIAI` WHERE `PAVARDE` LIKE '___a%';
-- 7.	Išrinkite visus duomenis apie mokinius ir išrikiuokite juos pagal įmonės kodą nuo didžiausio iki mažiausio.
SELECT * FROM `MOKINIAI` ORDER BY `IMONES_KODAS` DESC;
-- 8.	Išrinkite iš lentelės “PAZYMIAI” mažiausią ir didžiausią pažymius.
SELECT MIN(`PAZYMYS`), MAX(`PAZYMYS`) FROM `PAZYMIAI`; 
-- 9.	Išrinkite duomenis (vardas, pavardė, kiekis), kiek iš viso pažymių turi kiekvienas mokinys.
SELECT `MOKINIAI`.`VARDAS`, `MOKINIAI`.`PAVARDE`, COUNT(`PAZYMIAI`.`PAZYMYS`) 
FROM `MOKINIAI` 
LEFT JOIN `PAZYMIAI` 
ON `MOKINIAI`.`ID`=`PAZYMIAI`.`MOKINIO_ID` 
GROUP BY `VARDAS`; 
-- 10.	Išrinkite duomenis (pavadinimas, įmonės kodas, adresas), kiek kiekvienai įmonei yra priskirta mokinių.
SELECT `PAVADINIMAS`, `IMONES_KODAS`, `ADRESAS`, COUNT(`MOKINIAI`.`ID`)
FROM `IMONES`
LEFT JOIN `MOKINIAI`
ON `IMONES`.`ID`=`MOKINIAI`.`IMONES_KODAS`
GROUP BY `PAVADINIMAS`;
-- 11.	#9 užklausą pataisykite taip, kad rodytų tik tuos mokinius, kurie turi bent 2 pažymius.
SELECT `MOKINIAI`.`VARDAS`, `MOKINIAI`.`PAVARDE`, COUNT(`PAZYMIAI`.`PAZYMYS`) 
FROM `MOKINIAI` 
LEFT JOIN `PAZYMIAI` 
ON `MOKINIAI`.`ID`=`PAZYMIAI`.`MOKINIO_ID` 
GROUP BY `VARDAS`
HAVING COUNT(`PAZYMIAI`.`PAZYMYS`)=2; 
-- 12.	Išveskite duomenis (mokinio vardas, pavardė, asmenskodas, modulio pavadinimas) kurie neišlaikė bent vieno kontrolinio arba nelaikė kontrolinio iš viso. (Pastaba: modulis laikomas neišlaikytu, jei pažymys<7.)
SELECT `VARDAS`, `PAVARDE`, `ASMENS_KODAS`, `PAVADINIMAS` AS 'MODULIO PAVADINIMAS' 
FROM `MOKINIAI`
LEFT JOIN `PAZYMIAI`
ON `MOKINIO_ID`=`MOKINIAI`.`ID` 
LEFT JOIN `MODULIAI`
ON `MODULIO_ID`=`MODULIO_KODAS`
WHERE `PAZYMYS`>7;
-- 13.	Įterpkite į lentelę “MOKINIAI“ naują įrašą, užpildydami visus laukus bei priskirdami jam “Tieto” įmonės kodą. 
INSERT INTO `MOKINIAI` (
    `ID`,
    `ASMENS_KODAS`,
    `VARDAS`,
    `PAVARDE`,
    `GIMIMO_DATA`,
    `SPECIALYBE`,
    `IMONES_KODAS`) 
VALUES (
    100,
    123456789,
    'Justinas',
    'Goberis',
    '1900-01-01',
    'Programuotojas',
    (SELECT `ID` FROM `IMONES` WHERE `PAVADINIMAS`='Tieto')
);
-- 14.	Atnaujinkite duomenis apie mokinį, kurio ID yra 7, priskirdami jam “EisGroup Lietuva” įmonės kodą.
UPDATE `MOKINIAI`
SET `IMONES_KODAS`=(SELECT `ID` FROM `IMONES` WHERE `PAVADINIMAS`='EisGroup Lietuva')
WHERE `ID`=7;
-- 15.	Ištrinkite iš lentelės “MOKINIAI“ įrašą, kurį sukūrėte #13 užklausoje.
SELECT * FROM `MOKINIAI` ORDER BY `ID` DESC LIMIT 1;
