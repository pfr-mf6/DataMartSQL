import sys
import dotenv

import pyodbc

import streamlit as st



QUERY = """
    SELECT TOP (1000) [Fact_Incident_PK]
        ,[Incident_Transaction_GUID_Internal]

        ,[Dim_Airway_FK]
        ,[Dim_CardiacArrest_FK]
        ,[Dim_Disposition_FK]
        ,[Dim_Incident_FK]
        ,[Dim_Patient_FK]
        ,[Dim_Response_FK]
        ,[Dim_Scene_FK]
        ,[Dim_Situation_FK]
        ,[Dim_VitalsHighLowInitLast_FK]
        ,[Dim_Outcome_FK]
        ,[Dim_PatientHistory_FK]
        ,[Dim_Payment_FK]
        ,[Dim_InjuryDetails_FK]
        ,[Incident_Validity_Score]


        ,[CreatedOn]
        ,[ModifiedOn]
        ,[Dim_Narrative_FK]
        ,[Dim_Incident_One_To_One_PK]


        ,[CAD_Incident_ID_Internal]
        ,[CAD_ID_FK]

        ,[Patient_Age_In_Years]
        ,[Patient_Age_In_Months]
        ,[Patient_Age_In_Weeks]
        ,[Patient_Age_In_Days]

        ,[Dim_IncidentSupplementalQuestions_FK]
        ,[Dim_IncidentSupplementalQuestions1_FK]
        ,[Dim_IncidentSupplementalQuestions2_FK]

        ,[CAD_ID1_FK]
        ,[CAD_Incident_ID1_Internal]
        ,[Dim_PatientFluids_FK]
        ,[Incident_Agency_Short_Name]
        ,[Incident_Form_Number]

    FROM [Elite_DWPortland].[DwEms].[Fact_Incident]
    ORDER BY
    Fact_Incident_PK DESC
    """




def go():
    assert(0)
    #dotenv.load_env()
    #sys.getenv()???
    #TODO - ensure that all needed environment vars are in place properly

    # Define your connection string
    conn_str = (
        f'DRIVER={};'
        f'SERVER={};'
        f'DATABASE={};'
        f'UID={};'
        f'PWD={}'
    )

    # Establish a connection
    conn = pyodbc.connect(conn_str)

    # Create a cursor object using the cursor() method
    cursor = conn.cursor()

    # Execute a query
    #cursor.execute("SELECT * FROM your_table_name")
    cursor.execute( QUERY )

    # Fetch all rows from the executed query
    rows = cursor.fetchall()

    # Print the rows
    for row in rows:
        print(row)
        st.write(row)

    # Close the cursor and connection
    cursor.close()
    conn.close()

if st.button("go"):
    go()
