# NSW Liquor Gaming Licence Database 2021
The database consists of 6 tables with current information of liquor and gaming licences for all venues within New South Wales (NSW, Australia). 
[Entity Relationship (ER) Diagram](https://github.com/colinpty/NSW_Liquor_Gaming_data/blob/main/NSW_Licence_ERD.jpg)

## How to Install

1. Create a new blank database in Postgres.  
	`CREATE DATABASE nsw_liquor_licences;`

2. Run the code in the **create_nsw_liquor_licences.sql** file to create the table in the database.

3. Run the code in all 6 insert files located in the **Insert_Data** Folder to insert data for each table. *Please note that there are over 100,000 records of data to be inserted which will take time.*



## Case Scenarios


#### List the TOP 10 the LGA with the most unrestrictive trading hour venues outside the Council of the City of Sydney.

``` 
select locations.lga, COUNT(trading_hours.unrestricted) as venue
from locations
inner join trading_hours on trading_hours.licence_number = locations.licence_number
where locations.lga != 'Council of the City of Sydney'
GROUP BY locations.lga
ORDER BY hours DESC
limit 10;

``` 











***

I thank the State of New South Wales (Department of Customer Service) 2021 for publishing the data and allowing me to distribute, reuse, remix and enhance the data.
