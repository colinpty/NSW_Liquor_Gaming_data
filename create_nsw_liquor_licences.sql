DROP TABLE IF EXISTS licence_details;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS business_types;
DROP TABLE IF EXISTS authorisations;
DROP TABLE IF EXISTS trading_hours;
DROP TABLE IF EXISTS gaming;

CREATE TABLE licence_details (
Licence_number VARCHAR primary key
,   Licence_type VARCHAR
,   Status VARCHAR
,   Start_date DATE   
,   Trading_Status VARCHAR
,   Licence_name VARCHAR
);

CREATE TABLE locations (
location_ID serial primary key
,   Licence_number VARCHAR 
,   Address VARCHAR
,   Suburb VARCHAR
,   Postcode INTEGER
,   Latitude NUMERIC
,   Longitude NUMERIC
,   LGA VARCHAR
);
ALTER TABLE locations ADD CONSTRAINT Licence_Lication_FK FOREIGN KEY (Licence_number) REFERENCES licence_details(Licence_number);

CREATE TABLE business_types (
Business_types_ID serial primary key
,   Licence_number VARCHAR 
,   Licensee VARCHAR 
,   Business_type VARCHAR
);
ALTER TABLE business_types ADD CONSTRAINT Licence_Types_FK FOREIGN KEY (Licence_number) REFERENCES licence_details(Licence_number);

CREATE TABLE authorisations (
authorisations_ID serial primary key
,   Licence_number VARCHAR 
,   Authorisation_restriction_name VARCHAR 
,   Extended_trading BOOLEAN
,   Reduced_trading BOOLEAN
,   Primary_service BOOLEAN
,   Right_to_keep_gaming BOOLEAN
);
ALTER TABLE authorisations ADD CONSTRAINT Licence_Authorisations_FK FOREIGN KEY (Licence_number) REFERENCES licence_details(Licence_number);

CREATE TABLE trading_hours (
trading_hours_ID serial primary key
,   Licence_number VARCHAR 
,   Unrestricted BOOLEAN
,   After12am BOOLEAN
,   After3am BOOLEAN
,   After5am BOOLEAN
);
ALTER TABLE trading_hours ADD CONSTRAINT Licence_Hours_FK FOREIGN KEY (Licence_number) REFERENCES licence_details(Licence_number);

CREATE TABLE gaming (
gaming_ID serial primary key
,   Licence_number VARCHAR 
,   SA2 VARCHAR
,   Band INTEGER
,   GMEs INTEGER
,   PMPs INTEGER
,   Auth_limit INTEGER
,   Unfulfilled_Quota INTEGER
,   GMT INTEGER
,   EGMs INTEGER
);
ALTER TABLE gaming ADD CONSTRAINT Licence_Gaming_FK FOREIGN KEY (Licence_number) REFERENCES licence_details(Licence_number);


			

