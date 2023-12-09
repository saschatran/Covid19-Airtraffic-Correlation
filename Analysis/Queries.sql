--## Queries for the analysis ##--

--Number of Cancelled Flights per Month and State
Select DATE_TRUNC('month',f.flightdate) "Month", s.State , COUNT(*) "Number of cancelled Flights"
From Flight f, State s, Airport a, City c
Where (f.OriginAirportID = a.AirportID AND a.CityID = c.CityID AND c.State = s.state
	  AND f.cancelled = 1)
Group BY s.State, "Month"

--Number of Performed Flight Per Month and State
Select DATE_TRUNC('month',f.flightdate) "Month", s.State , COUNT(*) "Number of Performed Flights"
From Flight f, State s, Airport a, City c
Where (f.OriginAirportID = a.AirportID AND a.CityID = c.CityID AND c.State = s.state
	  AND f.cancelled = 0)
Group BY s.State, "Month"

--Number of CoronaCases per Month and State
Select DATE_TRUNC('month',Coronadata.date) "Month", State, SUM(Coronadata.new_case) "Number of Corona Cases"
From CoronaData
Group BY State, "Month"

--Number of Corona Cases per Month and State normalized by the citizen in a state
Select DATE_TRUNC('month', d.date) "Month", s.State, cast(SUM(d.new_case) as decimal)/ s.citizens "Number of Corona Cases"
From CoronaData d, State s
Where s.state = d.state 
Group BY s.State, "Month"

--Number Flights cancelled for a specific State
Select DATE_TRUNC('month',f.flightdate) "Month", s.State , COUNT(*) "Number of cancelled Flights"
From Flight f, State s, Airport a, City c
Where (f.OriginAirportID = a.AirportID AND a.CityID = c.CityID AND c.State = s.state
	  AND f.cancelled = 1 AND s.state = 'NY')
Group BY s.State, "Month"

--Number of Flights and Number of Vax per month for a specific state
Select DATE_TRUNC('month',f.flightdate) "Month", s.State , COUNT(*) "Number of Performed Flights"
From Flight f, State s, Airport a, City c
Where (f.OriginAirportID = a.AirportID AND a.CityID = c.CityID AND c.State = s.state
	  AND f.cancelled = 0)
Group BY s.State, "Month"

--Number of Corona Cases for a specific State
Select DATE_TRUNC('month',Coronadata.date) "Month", State, SUM(Coronadata.new_case) "Number of Corona Cases"
From CoronaData
Where State = 'NY'
Group BY State, "Month"
Order by "Month" Asc

--Number of non weather delayed flights per month
Select DATE_TRUNC('month', d.date) "Month", COUNT(*) "Number of Delayed Flights"
From delayed_Flight df, Flight f, Date d
Where(df.flight_id = f.flight_id AND df.weatherdelay = 0)
Group BY "Month";	

--Number of Vax per month for a specific state
Select cv.date, SUM(cv.series_complete_yes) "Number of Covid Vaxxed", SUM(cv.booster_doses) "Number of Booster", Sum(cv.second_booster) "Number of second Booster"
From CoronaVax cv
Where (cv.Location = 'NY')
Group BY cv.date;

--Number of Empployees per month
Select fulltime, parttime, grand_total, date 
from Employment
where date >= '2017-07-01' AND date <= '2022-07-01'