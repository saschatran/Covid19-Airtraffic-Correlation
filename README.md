# Impact of Covid-19 on air traffic in the U.S.

This repository is about a Database Project from the lecture _Databases_ of the _University of Basel_ in the year 2022.

## About the Database Project

During the years 2020, 2021 and also the beginning of the year 2022, the Corona pandemic had a major impact on our daily lives. 

Therefore this Database Project is about the analysis of the impact of the Corona pandemic on the U.S. air traffic.
More precisely, the following three main analysis questions were made:

- Can we see a direct comparison, between the cancelled flights and the Corona numbers in the different US states?
- Have there been more non-weather related delays since the start of the pandemic, for example due to vaccination certificate checks or staff shortages at airports?
- Can you see a correlation with the number of flights and Corona vaccination per state?

## Folder structure

Currently, the repository is structured as followed: <!-- In Linux: tree -d -->

```bash
├── Analysis
│   └── html
└── Data Integration
    ├── Python
    └── SQL

```
### Analysis
This folder contains the queries and scripts required to create plots for the analysis. All plots can be seen in the file html/AllPlots.html.
Note: The coding required relative paths which were not adjusted on other OS, only for Windows.

### Data Integration
This folder consists of all the scripts needed to integrate the schema. (P1)

### Presentation
This folder mainly consists of the presentation slides.

### WorkingStation
This folder consists of any drafts, code-snippets and so on that occured during the process of a milestone.
(One could call it a junk folder, but who knows...)

## Guide

1. You first need to download all the necessary datasets (total size ~14 GB). All necessary links can be found in the chapter **Dataset sources**.
2. Run code/Python/flightDataMerge.ipynb. Make sure that the path name is set correctly. (~1h)
3. The "Employee"-dataset is most likely in a format of .xls. Make sure to first change this format to .xlsx and remove the title.
4. Run code/Python/adjustDataset.py.
5. Create a database and connect to it (this is not described any further).
6. Run code/SQL/1_creates_Table_for_Datasheets.sql
7. Run code/SQL/2_load_Data_into_Tables.sql
8. Run code/SQL/3_creates_Tables_with_Data.sql
9. Run code/SQL/4_create_foreignkey_constraint.sql
10. Run code/SQL/5_add_population_for_state.sql

## Dataset sources

- Carrier On-Time Performance Dataset: https://transtats.bts.gov/DL_SelectFields.aspx?gnoyr_VQ=FGJ&QO_fu146_anzr=b0-gvzr}{https://transtats.bts.gov/DL\_SelectFields.aspx?gnoyr\_VQ=FG

- Airline Employment Data: https://www.transtats.bts.gov/Employment/}{https://www.transtats.bts.gov/Employment/

- Coronavirus (Covid-19) Case Surveillance Data in the United States: https://data.cdc.gov/Case-Surveillance/United-States-COVID-19-Cases-and-Deaths-by-State-o/9mfq-cb36}{https://data.cdc.gov/Case-Surveillance/United-States-COVID-19-Cases-and-Deaths-by-State-o/9mfq-cb36

- COVID-19 Vaccination Trends in the United States: https://data.cdc.gov/Vaccinations/COVID-19-Vaccination-Age-and-Sex-Trends-in-the-Uni/5i5k-6cmh}{https://data.cdc.gov/Vaccinations/COVID-19-Vaccination-Age-and-Sex-Trends-in-the-Uni/5i5k-6cmh


<!-- Use this repository for your integration code and any source code created while working on your project (ad-hoc code,
SQL queries, project files needed by external tools, etc.).

- Merge your code into the main branch on the due date. 
- Do not commit datasets!
- Any other document (except for the dump in the final hand-in) should be handed-in via ADAM.

If you have any questions regarding the project, please do not hesitate to ask during the exercise lessons or via mail
to [raphael.waltenspuel@unibas.ch](mailto:raphael.waltenspuel@unibas.ch)!

It is recommended that you first create a ```.gitignore``` file. (And exclude the "datasets" folder, for example). A useful tool for creating ```.gitignore``` files is www.gitignore.io.

Feel free to update or replace this readme with a brief description of your project and goals. -->
