--load all Data into the tables for the Datasheets
--Run these lines of code in the SQL SHELL (psql)

\copy CoronaData from 'D:\corona_dataset.csv' WITH DELIMITER ',' CSV HEADER;

\copy CoronaVax from 'D:\corona_vaccination_dataset.csv' WITH DELIMITER ',' CSV HEADER;

\copy Employment from 'D:\Employment.csv' WITH DELIMITER ',' CSV HEADER;

\copy FlightDataSet from 'D:\flightData.csv' WITH DELIMITER ',' CSV HEADER;