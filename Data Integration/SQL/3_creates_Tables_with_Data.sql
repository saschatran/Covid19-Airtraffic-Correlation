--DESCRIPTION: Creating all other TABLEs FROM the existing TABLEs in the Database


--creating TABLE Date witch functions
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

--Clean Flightdataset
UPDATE FlightDataSet
SET OriginCityName = REPLACE (OriginCityName, 'CONCORD', 'Concord');
UPDATE FlightDataSet
SET DestCityName = REPLACE (DestCityName, 'CONCORD', 'Concord');

--clean CoronaDataset
UPDATE CoronaData
SET state = REPLACE (state, 'NYC', 'NY');

-- Creating TABLE State 
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