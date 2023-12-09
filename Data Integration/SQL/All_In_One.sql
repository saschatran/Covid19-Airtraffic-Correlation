
--CREATE THE whole DATABASE with one file
--RUN it in bin directory: psql -h localhost -d NameDB -U postgres -p 5432 -f "path"

--Creates Table to load the Data into the Database.
--From this we create our other Tables that we need in our DB
--These Tables are without Foreign Key Constraints, sometimes without Primary Constrints


--Creates Table for the Corona Data --> Final Table for Relation CoronaData
CREATE TABLE CoronaData (
	Corona_ID INTEGER,
	Date DATE,
	State VARCHAR(255), 
	tot_cases INTEGER,
	conf_cases FLOAT,
	prob_cases FLOAT,
	new_case INTEGER,
	pnew_case FLOAT,
	tot_death INTEGER,
	conf_death FLOAT,
	prob_death FLOAT,
	new_death INTEGER,
	pnew_death FLOAT,
	created_at VARCHAR(255),
	consent_cases VARCHAR(255),
	consent_deaths VARCHAR(255),

	PRIMARY KEY (Corona_ID)
);

--Creates Table for the Vaccination Data --> Final Table
create table CoronaVax (
    CoronaVaxID INTEGER,
    Date DATE,
    Location VARCHAR(255),
    Demographic_Category VARCHAR(255),
    census FLOAT,
    Administered_Dose1 FLOAT,
    Series_Complete_Yes FLOAT,
    Booster_Doses FLOAT,
    Second_Booster FLOAT,
    Administered_Dose1_pct_agegroup FLOAT,
    Series_Complete_Pop_pct_agegroup FLOAT,
    Booster_Doses_Vax_pct_agegroup FLOAT,
    Second_Booster_Vax_pct_agegroup FLOAT,

    PRIMARY KEY(coronaVaxID)
);

--Creates Table for Employment --> Final Table for Relation Employment
CREATE TABLE Employment (
	Employment_ID INTEGER,
	Fulltime INTEGER,
	Parttime INTEGER,
	Grand_Total INTEGER,
	Date DATE,

	PRIMARY KEY (Employment_ID)
);

--Creates Table for FlightDataSet -> From this create FlighDataSet related Tables
CREATE TABLE FlightDataSet (
	Year                            INTEGER,
    Quarter                         INTEGER,
    Month                           INTEGER,
    DayofMonth                      INTEGER,
    DayOfWeek                       INTEGER,
    FlightDate                      DATE,
    Reporting_Airline               VARCHAR(255),
    DOT_ID_Reporting_Airline        INTEGER,
    IATA_CODE_Reporting_Airline     VARCHAR(255),
    Tail_Number                     VARCHAR(255),
    Flight_Number_Reporting_Airline INTEGER,
    OriginAirportID                 INTEGER,
    OriginAirportSeqID              INTEGER,
    OriginCityMarketID              INTEGER,
    Origin                          VARCHAR(255),
    OriginCityName                  VARCHAR(255),
    OriginState                     VARCHAR(255),
    OriginStateFips                 INTEGER,
    OriginStateName                 VARCHAR(255),
    OriginWac                       INTEGER,
    DestAirportID                   INTEGER,
    DestAirportSeqID                INTEGER,
    DestCityMarketID                INTEGER,
    Dest                            VARCHAR(255),
    DestCityName                    VARCHAR(255),
    DestState                       VARCHAR(255),
    DestStateFips                   INTEGER,
    DestStateName                   VARCHAR(255),
    DestWac                         FLOAT,
    CRSDepTime                      FLOAT,
    DepTime                         FLOAT,
    DepDelay                       	FLOAT,
    DepDelayMinutes                	FLOAT,
    DepDel15                       	FLOAT,
    DepartureDelayGroups            FLOAT,
    DepTimeBlk                      VARCHAR(255),
    TaxiOut                        	FLOAT,
    WheelsOff                       FLOAT,
    WheelsOn                        FLOAT,
    TaxiIn                         	FLOAT,
    CRSArrTime                      FLOAT,
    ArrTime                         FLOAT,
    ArrDelay                       	FLOAT,
    ArrDelayMinutes                	FLOAT,
    ArrDel15                       	FLOAT,
    ArrivalDelayGroups              FLOAT,
    ArrTimeBlk                      VARCHAR(255),
    Cancelled                      	FLOAT,
    CancellationCode                VARCHAR(255),
    Diverted                       	FLOAT,
    CRSElapsedTime                 	FLOAT,
    ActualElapsedTime              	FLOAT,
    AirTime                        	FLOAT,
    Flights                        	FLOAT,
    Distance                       	FLOAT,
    DistanceGroup                   FLOAT,
    CarrierDelay                   	FLOAT,
    WeatherDelay                   	FLOAT,
    NASDelay                       	FLOAT,
    SecurityDelay                  	FLOAT,
    LateAircraftDelay              	FLOAT,
    FirstDepTime                    VARCHAR(255),
    TotalAddGTime                   VARCHAR(255),
    LongestAddGTime                 VARCHAR(255),
    DivAirportLandings              FLOAT,
    DivReachedDest                  VARCHAR(255),
    DivActualElapsedTime            VARCHAR(255),
    DivArrDelay                     VARCHAR(255),
    DivDistance                     VARCHAR(255),
    Div1Airport                     VARCHAR(255),
    Div1AirportID                   VARCHAR(255),
    Div1AirportSeqID                VARCHAR(255),
    Div1WheelsOn                    VARCHAR(255),
    Div1TotalGTime                  VARCHAR(255),
    Div1LongestGTime                VARCHAR(255),
    Div1WheelsOff                   VARCHAR(255),
    Div1TailNum                     VARCHAR(255),
    Div2Airport                     VARCHAR(255),
    Div2AirportID                   VARCHAR(255),
    Div2AirportSeqID                VARCHAR(255),
    Div2WheelsOn                    VARCHAR(255),
    Div2TotalGTime                  VARCHAR(255),
    Div2LongestGTime                VARCHAR(255),
    Div2WheelsOff                   VARCHAR(255),
    Div2TailNum                     VARCHAR(255),
    Div3Airport                     VARCHAR(255),
    Div3AirportID                   VARCHAR(255),
    Div3AirportSeqID                VARCHAR(255),
    Div3WheelsOn                    VARCHAR(255),
    Div3TotalGTime                  VARCHAR(255),
    Div3LongestGTime                VARCHAR(255),
    Div3WheelsOff                   VARCHAR(255),
    Div3TailNum                     VARCHAR(255),
    Div4Airport                     VARCHAR(255),
    Div4AirportID                   VARCHAR(255),
    Div4AirportSeqID                VARCHAR(255),
    Div4WheelsOn                    VARCHAR(255),
    Div4TotalGTime                  VARCHAR(255),
    Div4LongestGTime                VARCHAR(255),
    Div4WheelsOff                   VARCHAR(255),
    Div4TailNum                     VARCHAR(255),
    Div5Airport                     VARCHAR(255),
    Div5AirportID                   VARCHAR(255),
    Div5AirportSeqID                VARCHAR(255),
    Div5WheelsOn                    VARCHAR(255),
    Div5TotalGTime                  VARCHAR(255),
    Div5LongestGTime                VARCHAR(255),
    Div5WheelsOff                   VARCHAR(255),
    Div5TailNum                     VARCHAR(255),
    NullV                           VARCHAR(255)
);

--load all Data into the tables for the Datasheets
--Run these lines of code in the SQL SHELL (psql)

\copy CoronaData from 'D:\corona_dataset.csv' WITH DELIMITER ',' CSV HEADER;

\copy CoronaVax from 'D:\corona_vaccination_dataset.csv' WITH DELIMITER ',' CSV HEADER;

\copy Employment from 'D:\Employment.csv' WITH DELIMITER ',' CSV HEADER;

\copy FlightDataSet from 'D:\flightData.csv' WITH DELIMITER ',' CSV HEADER;

--DESCRIPTION: Creating all other TABLEs FROM the existing TABLEs in the Database

--creating TABLE Date
CREATE TABLE Date AS
    SELECT Date :: date FROM generate_series(
    (date '1990-01-01' :: date),
    (date '2022-11-28':: date),
    interval '1 month'
    )Date
    UNION
    SELECT Date :: date FROM generate_series(
    (date '2017-01-01' :: date),
    (date '2022-11-28':: date),
    interval '1 day'
    )Date;

ALTER TABLE Date
ADD Column Weekday integer,
ADD PRIMARY KEY(date);

Update Date Set weekday = extract(isodow FROM date);


--Adding Flight_ID to Flight TABLE
ALTER TABLE FlightDataSet ADD COLUMN Flight_ID SERIAL PRIMARY KEY;

UPDATE FlightDataSet
SET OriginCityName = REPLACE (OriginCityName, 'CONCORD', 'Concord');
UPDATE FlightDataSet
SET DestCityName = REPLACE (DestCityName, 'CONCORD', 'Concord');

UPDATE CoronaData
SET state = REPLACE (state, 'NYC', 'NY');

-- Creating TABLE State --
CREATE TABLE state (
    state CHAR(3),
    state_name VARCHAR(255),
    state_fips INTEGER,
    PRIMARY KEY (state)
);
--Adding data from Flight TABLE
INSERT INTO state (state, state_name, state_fips)
    (SELECT OriginState, OriginStateName, OriginStateFips
     FROM FlightDataSet)
    UNION
    (SELECT DestState, DestStateName, DestStateFips
     FROM FlightDataSet);

--Adding data from corona dataset
INSERT INTO state(state)
    (SELECT cd.state
    FROM CoronaData cd
    WHERE (cd.state NOT IN (SELECT state FROM state)))
    UNION
    (SELECT Location
     FROM CoronaVax
     WHERE Location NOT IN (SELECT state FROM state));

--
--Creating TABLE City
CREATE TABLE city (
    cityID serial,
    cityName VARCHAR(255),
    state VARCHAR(255),
    fullCityName VARCHAR(255), -- will be deleted after creating airport table
    PRIMARY KEY (cityID)
);

INSERT INTO city (cityName, state, fullCityName)
(SELECT LEFT(OriginCityName, POSITION(',' IN OriginCityName) - 1), OriginState, OriginCityName
 FROM flightDataset)
UNION
(SELECT LEFT(DestCityName, POSITION(',' IN DestCityName) - 1), DestState, DestCityName
 FROM flightDataset);

-- For some reason Origin-/DestCityName consist of a 'Washington, DC' with DC not being a state
UPDATE city SET cityName = 'Washington DC' WHERE cityName = 'Washington';

--Creating TABLE Airport
-- AirportName = Origin/Dest
CREATE TABLE airport (
    airportID INTEGER,
    airportName VARCHAR(255),
    wac INTEGER,
    cityMarketID INTEGER,
    cityID INTEGER,
    PRIMARY KEY (airportID)
);

INSERT INTO airport (airportID, airportName, wac, cityMarketID, cityID)
    (SELECT OriginAirportID, Origin, OriginWac, OriginCityMarketID, cityID
    FROM flightDataset, city
    WHERE OriginCityName = fullcityname)
    UNION
    (SELECT DestAirportID, Dest, DestWac, DestCityMarketID, cityID
    FROM flightDataset, city
    WHERE DestCityName = fullcityname);

ALTER TABLE city DROP COLUMN fullcityname; -- this column was only needed for comparison


--Creating TABLE Airline
CREATE TABLE Airline AS
(SELECT DISTINCT Reporting_Airline, DOT_ID_Reporting_Airline, IATA_Code_Reporting_Airline
FROM FlightDataSet);

ALTER TABLE Airline
ADD PRIMARY KEY(Reporting_Airline);

--Creating TABLE Flight
CREATE TABLE Flight AS
SELECT Flight_ID,Flight_Number_Reporting_Airline,FlightDate,Reporting_Airline,DestAirportID,DestAirportSeqID,OriginAirportID,OriginAirportSeqID,Tail_Number,
CRSDepTime,DepTimeBlk,CRSArrTime,ArrTimeBlk,Cancelled,CancellationCode,CRSElapsedTime,Flights,Distance,DistanceGroup,
FirstDepTime,TotalAddGTime,LongestAddGTime
FROM FlightDataSet;

ALTER TABLE Flight
ADD PRIMARY KEY(Flight_ID);


--Creating TABLE Performed_Flight
CREATE TABLE Performed_Flight (
    Flight_ID INTEGER,
    Diverted INTEGER,
    Delayed INTEGER,
    DepTime INTEGER,
    DepDelay INTEGER,
    DepDelayMinutes INTEGER,
    DepDel15 INTEGER,
    DepartureDelayGroups INTEGER,
    TaxiOut INTEGER,
    WheelsOff INTEGER,
    WheelsOn INTEGER,
    TaxiIn INTEGER,
    ArrTime INTEGER,
    ArrDelay INTEGER,
    ArrDelayMinutes INTEGER,
    ArrDel15 INTEGER,
    ArrivalDelayGroups INTEGER,
    ActualElapsedTime INTEGER,
    AirTime INTEGER,

    PRIMARY KEY (Flight_ID)
);

INSERT INTO Performed_Flight (Flight_ID, Diverted, DepTime, DepDelay, DepDelayMinutes, DepDel15, DepartureDelayGroups, TaxiOut, WheelsOff, WheelsOn, TaxiIn, ArrTime, ArrDelay, ArrDelayMinutes, ArrDel15, ArrivalDelayGroups, ActualElapsedTime, AirTime, Delayed)
SELECT Flight_Id, Diverted, DepTime, DepDelay, DepDelayMinutes, DepDel15, DepartureDelayGroups, TaxiOut, WheelsOff, WheelsOn, TaxiIn, ArrTime, ArrDelay, ArrDelayMinutes, ArrDel15, ArrivalDelayGroups, ActualElapsedTime, AirTime,
       (CASE WHEN (CarrierDelay IS NULL
                        AND WeatherDelay IS NULL
                    AND NASDelay IS NULL
                    AND SecurityDelay IS NULL
                    AND LateAircraftDelay IS NULL)
                THEN 0
                ELSE 1
         END)
FROM flightDataset
WHERE Cancelled = 0;


--Creating TABLE Delayed_Flight
CREATE TABLE Delayed_Flight AS
SELECT flight.Flight_ID,
       flight.CarrierDelay,
       flight.WeatherDelay,
       flight.NASDelay,
       flight.SecurityDelay,
       flight.LateAircraftDelay
FROM flightDataset flight, performed_Flight performedFlight
WHERE performedFlight.delayed = 1
AND flight.Flight_ID = performedFlight.Flight_ID;

ALTER TABLE Delayed_Flight
ADD PRIMARY KEY(Flight_ID);


--Creating TABLE Diverted_Flight
CREATE TABLE Diverted_Flight AS
SELECT Flight_ID, DivAirportLandings, DivReachedDest,DivActualElapsedTime,DivArrDelay,DivDistance,
Div1Airport,Div1AirportID,Div1AirportSeqID,Div1WheelsOn ,Div1TotalGTime,Div1LongestGTime,Div1WheelsOff,
Div1TailNum,Div2Airport,Div2AirportID,Div2AirportSeqID,Div2WheelsOn ,Div2TotalGTime,Div2LongestGTime,Div2WheelsOff,
Div2TailNum,Div3Airport,Div3AirportID,Div3AirportSeqID,Div3WheelsOn ,Div3TotalGTime,Div3LongestGTime,Div3WheelsOff,
Div3TailNum,Div4Airport,Div4AirportID,Div4AirportSeqID,Div4WheelsOn ,Div4TotalGTime,Div4LongestGTime,Div4WheelsOff,
Div4TailNum,Div5Airport,Div5AirportID,Div5AirportSeqID,Div5WheelsOn ,Div5TotalGTime,Div5LongestGTime,Div5WheelsOff,
Div5TailNum
FROM FlightDataSet
WHERE Diverted = 1;

ALTER TABLE Diverted_Flight
ADD PRIMARY KEY(Flight_ID);

--create foreign key constraints for the tables

ALTER TABLE CoronaData
ADD FOREIGN KEY (Date) REFERENCES Date(Date),
ADD FOREIGN KEY (State) REFERENCES State(State);

ALTER TABLE CoronaVax
ADD FOREIGN KEY (Date) REFERENCES Date(Date),
ADD FOREIGN KEY (Location) REFERENCES State(State);

ALTER TABLE Employment
ADD FOREIGN KEY (Date) REFERENCES Date(Date);

ALTER TABLE City
ADD FOREIGN KEY (State) REFERENCES State(State);

ALTER TABLE Airport
ADD FOREIGN KEY (CityID) REFERENCES City(CityID);

ALTER TABLE Flight
ADD FOREIGN KEY (FlightDate) REFERENCES Date(Date),
ADD FOREIGN KEY (Reporting_Airline) REFERENCES Airline(Reporting_Airline),
ADD FOREIGN KEY (DestAirportID) REFERENCES Airport(AirportID),
ADD FOREIGN KEY (OriginAirportID) REFERENCES Airport(AirportID);

ALTER TABLE Performed_Flight
ADD FOREIGN KEY (Flight_ID) REFERENCES Flight(Flight_ID);

ALTER TABLE Delayed_Flight
ADD FOREIGN KEY (Flight_ID) REFERENCES Flight(Flight_ID);

ALTER TABLE Diverted_Flight
ADD FOREIGN KEY (Flight_ID) REFERENCES Flight(Flight_ID);

--At the end drop the flightdataset
Drop Table flightdataset;
