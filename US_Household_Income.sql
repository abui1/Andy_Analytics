#US Household Data Cleaning 
SELECT * 
FROM us_household_income;

SELECT * 
FROM us_household_income_statistics;

#Renaming column id in statistics table

ALTER TABLE household_income.us_household_income_statistics RENAME COLUMN `ï»¿id` TO `Id`;

SELECT COUNT(ID)
FROM us_household_income;
SELECT COUNT(ID)
FROM us_household_income_statistics;

SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1;

#CHEcking for duplicates
SELECT *
			FROM(
				SELECT row_id,
						id,
						ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
				FROM us_household_income) duplicates 
				WHERE row_num > 1;



# Removing Duplicates 
DELETE FROM us_household_income
WHERE row_id IN(
		SELECT row_id
			FROM(
				SELECT row_id,
						id,
						ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
				FROM us_household_income) duplicates 
				WHERE row_num > 1)
;
#Checking fo duplicates for statistics table
SELECT id, COUNT(id)
FROM us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1;

SELECT State_Name, COUNT(State_Name)
FROM us_household_income
GROUP BY State_Name;

# Fixing spelling errors
UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';

#Cleaning spelling errors and blanks
SELECT *
FROM us_household_income
WHERE Place = '';

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County  = 'Autauga County' AND City = 'Vinemont';

SELECT Type, COUNT(Type)
FROM us_household_income
GROUP BY Type;

UPDATE us_household_income
SET Type = 'Borough'
WHERE Type ='Boroughs';

SELECT DISTINCT AWater
FROM us_household_income
WHERE AWater ='' OR AWater= 0 OR AWater IS NULL;





















