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
