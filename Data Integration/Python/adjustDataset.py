import pandas as pd
import numpy as np

def addArtificialID(datasetPath, outputPath, IDcolumnName):
    """
    Adds a column at the beginning of the csv-dataset consisting of the enumeration of each row.
    These numbers are the artificial IDs.
    
    @param datasetPath: Path of the given csv dataset (relative suffice)
    @param outputPath: Path of the csv file including the new column
    @param IDcolumnName: Name of the new column
    """
    
    #check that given path consists of .csv
    if (".csv" not in datasetPath):
        print("datasetPath needs to consist of .csv")
        return False
    if (".csv" not in outputPath):
        print("outputPath needs to consist of .csv")
        return False
    
    #add column to dataset and write to new csv-file
    dfDataset = pd.read_csv(datasetPath, low_memory=False)
    nums = np.arange(1, len(dfDataset) + 1)
    dfDataset.insert(loc=0, column=IDcolumnName, value=nums)
    dfDataset.to_csv(outputPath, index=False)
    
def changeDateFormat(datasetPath, outputPath, dateColumnName):
    """
    Adjust the date column of a dataset to yyyy-mm-dd.
    
    @param datasetPath: Path of the given csv dataset (relative suffice)
    @param outputPath: Path of the csv file including the formatted date column
    @param dateColumnName: Name of the date column
    """
    
    #check that given path consists of .csv
    if (".csv" not in datasetPath):
        print("datasetPath needs to consist of .csv")
        return
    if (".csv" not in outputPath):
        print("outputPath needs to consist of .csv")
        return
    
    #adjust dataformat and write given csv-outputfile
    dfDataset = pd.read_csv(datasetPath, low_memory=False)
    dfDataset[dateColumnName] = pd.to_datetime(dfDataset[dateColumnName])
    dfDataset.to_csv(outputPath, index=False)

def changeFormat(inputPath, outputPath):
    """
    Converts the Employee-Excel file to CSV
    and replaces all ',' with '.' in the CSV file.
    ONLY NEEDED FOR EMPLOYEE DATASET.
    
    @param datasetPath: Path of the given csv dataset (relative suffice)
    @param outputPath: Path of the csv file including the formatted date column
    """
    
    inputfile = pd.read_excel(inputPath)
    inputfile = inputfile.replace('.','', regex=True)
    
    inputfile.to_csv(outputPath, index=False)
    
def adjustDate(inputPath, outputPath):
    """
    Adjusts the date format in the CSV file
    Given Month and Year, the date is set to the 1st of the month.
    ONLY needed for EMPLOYEE DATASET.
    
    @param datasetPath: Path of the given csv dataset (relative suffice)
    @param outputPath: Path of the csv file including the formatted date column
    """
    inputfile = pd.read_csv(inputPath)
    
    inputfile['Date'] = inputfile['Year'].map(str) + '-' + inputfile['Month'].map(str) + '-01'
    inputfile.drop('Month', inplace=True, axis=1)
    inputfile.drop('Year', inplace=True, axis=1)
    
    inputfile.to_csv(outputPath, index=False)
    
    
def main():
    datasetPath = ["United_States_COVID-19_Cases_and_Deaths_by_State_over_Time_-_ARCHIVED.csv",
                   "COVID-19_Vaccination_Age_and_Sex_Trends_in_the_United_States__National_and_Jurisdictional.csv", "Employment.csv"]
    outputPath = ["corona_dataset.csv", "coronaVax_dataset.csv", "Employment.csv"]
    IDcolumnName = ["Corona_ID", "Vaccination_ID", "Employee_ID"]
    dateColumnName = ["submission_date", "Date", "Date"]
    
    # adjust EMPLOYEE dataset
    # NOTE: EMPLOYEEE dataset needs to be in the format .xlsx (do this with excel)
    changeFormat("EmployeeExcel.xlsx", "Employment.csv")
    adjustDate("Employment.csv", "Employment.csv")
    
    # adjust CORONA and EMPLOYEE dataset
    for i in range(len(datasetPath)):
        addArtificialID(datasetPath[i], outputPath[i], IDcolumnName[i])
        changeDateFormat(outputPath[i], outputPath[i], dateColumnName[i])
     
main()
