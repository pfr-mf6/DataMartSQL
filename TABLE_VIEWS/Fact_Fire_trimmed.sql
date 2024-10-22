SELECT TOP (1000) [Fact_Fire_PK]
      ,[Dim_Basic_FK]
      ,[Dim_Fire_FK]
      ,[Dim_StructureFire_FK]
      ,[Dim_Arson_FK]
      ,[Dim_Wildland_FK]

      ,[CreatedOn]
      ,[ModifiedOn]
      ,[Agency_ID_Internal]
      ,[Dim_Agency_FK]
      ,[Dim_Date_Fire_PK]
      ,[Dim_TimeOfDay_Fire_PK]
      ,[CAD_ID_FK]
      ,[CAD_Incident_ID_Internal]


      ,[CAD_ID1_FK]
      ,[CAD_Incident_ID1_Internal]
      ,[Dim_FireSupplementalQuestions_FK]
      ,[Dim_FireSupplementalQuestions1_FK]
      ,[Dim_FireSupplementalQuestions2_FK]

      ,[Agency_shortname]

  FROM [Elite_DWPortland].[DwFire].[Fact_Fire]