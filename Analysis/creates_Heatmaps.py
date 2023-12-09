import psycopg2
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# create Connection with PostgreSQL Database
conn = psycopg2.connect(user='Yannu', password='DB123', host='localhost', database='DB_UniBasel')
cursor = conn.cursor()

###   HeatMap 

# perform SQL Query 
query = """Select to_char(DATE_TRUNC('month', d.date), 'YYYY-MM') "Month", s.State, cast(SUM(d.new_case) as float)/ s.citizens "Number of Corona Cases" From CoronaData d, State s Where s.state = d.state AND s.state <> 'AS' AND s.state <> 'DC' AND s.state <> 'FSM' AND s.state <> 'GU' AND s.state <> 'MP' AND s.state <> 'PW' AND s.state <> 'RMI' Group BY s.State, "Month" Order by State"""
cursor.execute(query)

# save Results in Pandas DataFrame
df = pd.DataFrame(cursor.fetchall())
df.columns = ['Date', 'States', 'Cases']
df_pivot = df.pivot(index='States', columns='Date', values='Cases')


# creates Heatmap
fig, ax = plt.subplots()
sns.heatmap(df_pivot, vmin = 0, vmax = 0.06, linewidths=0, cmap = 'gist_heat_r', ax = ax, yticklabels = False)
for spine in ax.spines.values():
    spine.set_visible(True)
    spine.set_linewidth(0.5)
    spine.set_color('black')

plt.title("New Corona Cases")
plt.xticks([0,6,12,18,24,30,34], ["2020-01","2020-06","2021-01","2021-06","2022-01","2022-06", "2022-10"])
ax.xaxis.set_ticks_position('bottom')
ax.xaxis.set_tick_params(rotation=45)
plt.show()


###   HeatMap Number of Number of flights
query = """Select to_char(DATE_TRUNC('month',f.flightdate),'YYYY-MM') "Month", s.State , COUNT(*) "Number of cancelled Flights" From Flight f, State s, Airport a, City c Where (f.flightdate > '2019-01-01'AND f.OriginAirportID = a.AirportID AND a.CityID = c.CityID AND c.State = s.state AND f.cancelled = 0 AND s.state <> 'AS' AND s.state <> 'DC' AND s.state <> 'FSM' AND s.state <> 'GU' AND s.state <> 'MP' AND s.state <> 'PW' AND s.state <> 'RMI') Group BY s.State, "Month" """

cursor.execute(query)

# save Results in Pandas DataFrame
df = pd.DataFrame(cursor.fetchall())
df.columns = ['Date', 'States', 'Cancelled']
df_pivot = df.pivot(index='States', columns='Date', values='Cancelled')

for index, row in df_pivot.iterrows():
  # Find the maximum value in the row
  max_val = row.max()
  
  # Divide each value in the row by the maximum value
  row = row.apply(lambda x: x / max_val)
  
  # Assign the modified row back to the pivot table
  df_pivot.loc[index] = row

# creates Heatmap
fig, ax = plt.subplots()
sns.heatmap(df_pivot, linewidths=0, cmap = 'Blues')
plt.yticks([])
plt.xticks([0,6,12,18,24,30,36,42], ["2019-01","2019-06","2020-01","2020-06","2021-01","2021-06","2022-01","2022-06"])
ax.xaxis.set_tick_params(rotation=45)
plt.title("Performed Flights")
plt.show()

# Verbindung mit der Datenbank schließen
conn.close()
