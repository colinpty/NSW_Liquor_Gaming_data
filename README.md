# NSW Liquor Gaming Licence Database 2021
The database consists of 6 tables with current information of liquor and gaming licences for all venues within New South Wales (NSW, Australia). 
[Entity Relationship (ER) Diagram](https://github.com/colinpty/NSW_Liquor_Gaming_data/blob/main/NSW_Licence_ERD.jpg)

## How to Install

1. Create a new blank database in Postgres.  
	`CREATE DATABASE nsw_liquor_licences;`

2. Run the code in the **create_nsw_liquor_licences.sql** file to create the table in the database.

3. Run the code in all 6 insert files located in the **Insert_Data** Folder to insert data for each table. *Please note that there are over 100,000 records of data to be inserted which will take time.*



## Case Scenarios

#### Find the council area with the most licence venues.
Sydney city has the most venues. 
| lga			        | total_venues |
|-------------------------------|:------------:|
| Council of the City of Sydney | 2452         |
``` 
SELECT lga, count (lga) total_venues
FROM locations
GROUP BY lga
ORDER BY total_venues desc
LIMIT 1;
``` 
#### Find the council area with the most Gaming Machines.
Sydney city has the most Gaming Machines. 
| lga			        | Total_Gaming_Machine_Entitlements |
|-------------------------------|:---------------------------------:|
| Council of the City of Sydney | 2259                              |
``` 
SELECT lga, count (lga) total_venues
FROM locations
GROUP BY lga
ORDER BY total_venues desc
LIMIT 1;
``` 
#### Did the City of Sydney decrease in new licence applications in 2020 compared to 2019 due to covid?
``` 
WITH cte_1 AS (
SELECT lga, COUNT (lga) AS Twenty_Twenty
FROM licence_details
INNER JOIN locations ON licence_details.licence_number = locations.licence_number
WHERE EXTRACT(YEAR FROM start_date) = 2020
GROUP BY locations.lga
ORDER BY Twenty_Twenty DESC
),
 cte_2 AS (
SELECT lga, COUNT (lga) AS Twenty_Nineteen
FROM licence_details
INNER JOIN locations ON licence_details.licence_number = locations.licence_number
WHERE EXTRACT(YEAR FROM start_date) = 2019
GROUP BY locations.lga
ORDER BY Twenty_Nineteen DESC
)
SELECT cte_1.lga, cte_1.Twenty_Twenty - cte_2.Twenty_Nineteen AS differences
FROM cte_1 INNER JOIN cte_2 ON cte_1.lga = cte_2.lga
WHERE cte_1.lga = cte_2.lga
ORDER BY differences ASC;
``` 
#### List all the restaurants in Byron Bay that hold a current NSW Liquor licence. 
```
SELECT licence_name
FROM licence_details
INNER JOIN locations ON licence_details.licence_number = locations.licence_number
INNER JOIN business_types ON licence_details.licence_number = business_types.licence_number
WHERE lga = 'Byron Shire Council' AND business_type = 'Restaurant'
ORDER BY licence_name;
```

#### List the TOP 10 the LGA with the most unrestrictive trading hour venues outside the Council of the City of Sydney.
Results show that the Northern Beaches Local Government Area had the most unrestrictive trading hour venues.
``` 
select locations.lga, COUNT(trading_hours.unrestricted) as venues
from locations
inner join trading_hours on trading_hours.licence_number = locations.licence_number
where locations.lga != 'Council of the City of Sydney'
GROUP BY locations.lga
ORDER BY hours DESC
limit 10;
``` 
| lga			       | venues |
|------------------------------|:------:|
| Northern Beaches Council     | 642    |
| Inner West Council	       | 627    |
| Central Coast Council	       | 547    |
| Newcastle City Council       | 483    |
| Wollongong City Council      | 430    |
| Cessnock City Council	       | 413    |
| Sutherland Shire Council     | 386    |
| North Sydney Council         | 385    |
| City of Parramatta Counci    | 353    |
| Canterbury-Bankstown Council | 310    |

#### There are too many unknown business types in the database. Find all these unknown businesses.
``` 
select licence_details.licence_number, LICENCE_NAME, address, suburb, postcode
FROM licence_details
INNER JOIN locations ON locations.licence_number = licence_details.licence_number
INNER JOIN business_types ON business_types.licence_number = locations.licence_number
WHERE business_type = 'Unknown';
``` 
#### Find all the Hairdressing salons that have a NSW liquor licence.
``` 
SELECT * FROM licence_details
INNER JOIN business_types ON business_types.licence_number = licence_details.licence_number
WHERE business_type = 'Hairdressing salon'
``` 
#### Find all the different types of businesses that hold a NSW liquor licence.
``` 
SELECT business_type, COUNT(*) AS HOW_MANY
FROM business_types
GROUP BY business_type
ORDER BY HOW_MANY DESC;
``` 
#### We need to find the licensee names for all venues located in Campsie.
``` 
select LICENSEE, LICENCE_NAME, licence_details.licence_number from licence_details
inner join locations on locations.licence_number = licence_details.licence_number
INNER JOIN business_types ON locations.licence_number = business_types.licence_number
where suburb = 'CAMPSIE';
``` 
#### There has been an increase in liquor offenses in the following NSW areas. Government has decided to restrict trading hours for any venues in the area.
``` 
SELECT licence_details.licence_number, LICENCE_NAME, business_type, unrestricted, after12am, after3am, after5am, lga
from licence_details
inner join business_types on licence_details.licence_number = business_types.licence_number
inner join trading_hours on business_types.licence_number = trading_hours.licence_number
inner join locations on trading_hours.licence_number = locations.licence_number
WHERE   
       lga LIKE '%Cobar%' 
    OR lga LIKE '%Lachlan%' 
    OR lga LIKE '%Bland%'  
    OR lga LIKE '%Parkes%'
    OR lga LIKE '%Weddin%'
    OR lga LIKE '%Temora%'
    OR lga LIKE '%Junee%'
    OR lga LIKE '%Narrandera%'
    GROUP BY licence_details.licence_number, business_type, unrestricted, after12am, after3am, after5am, lga
HAVING unrestricted = True OR after12am = True OR after3am = True OR after5am = True;
``` 







***

I thank the State of New South Wales (Department of Customer Service) 2021 for publishing the data and allowing me to distribute, reuse, remix and enhance the data.
