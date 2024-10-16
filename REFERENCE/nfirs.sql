SELECT TOP 100 
		basic.Basic_Incident_Number as "RP Number",
		cad.CAD_CAD_ID as "CAD table RP",
		fire.Fire_Initial_CAD_Incident_Type_Description as "Call type",

		basic.Basic_Apparatus_Call_Sign_List as "Units on this call",
		basic.Basic_Primary_Station_Name as "FMA",
		cad.CAD_Basic_Primary_Station as "CAD FMA",
		cad.CAD_Basic_Incident_District as "CAD district",
		basic.Basic_Incident_Zone_Number as "Battalion",

		Basic_Incident_Form_Number as "form used",
		Basic_Incident_Validity_Score as "report score",
		Basic_Incident_Status as "report status",
		basic.Basic_Incident_User_Updated as "officer??",
		basic.Basic_Authorization_Member_Making_Report_License_Number as "member making this report #",
		basic.Basic_Authorization_Member_Making_Report_Name as "member making this report",


		-- LOCATION
		--basic.Basic_Incident_Geocoded_Latitude as "geo-lat",
		--basic.Basic_Incident_Geocoded_Longitude as "geo-long",
		basic.Basic_Incident_Location_Type as "location type",
		basic.Basic_Incident_Street_Number as "street number",
		basic.Basic_Incident_Street_Prefix as "street prefix",
		basic.Basic_Incident_Street_Name as "street name",
		basic.Basic_Incident_Street_Type as "street type",
		basic.Basic_Incident_Full_Address as "full address",
		basic.Basic_Incident_Cross_Street as "cross street",
		basic.Basic_Incident_County_Name as "county",
		basic.Basic_Incident_Latitude as "lat",
		basic.Basic_Incident_Longitude as "lon",


		-- TIMES
		basic.Basic_Incident_Alarm_Time as "alarm time",
		basic.Basic_Incident_In_Service_Date_Time as "back in service:",
		basic.Basic_Incident_Alarm_To_Arrival_In_HHMMSS as "time to arrival",
		--basic.Basic_Incident_Arrival_To_Last_Unit_Cleared_HHMMSS as "total incident time",
		basic.Basic_Incident_Alarm_To_In_Service_HHMMSS as "total time on incident",


		-- CALL TYPE
		basic.Basic_Incident_Type_Code as "Type Code",
		basic.Basic_Incident_Type_Code_And_Description as "code and desc",
		basic.Basic_Incident_Type_Category as "type category",
		basic.Basic_Incident_Type_Subcategory as "subcategory",

		--[Dim_Fire_FK]
		--[Dim_StructureFire_FK]
		--[Dim_Arson_FK]
		--[Dim_Wildland_FK]
		--[Dim_Agency_FK]
		--[Dim_Date_Fire_PK]
		--[Dim_TimeOfDay_Fire_PK]
		[CAD_ID_FK]
		,[CAD_ID1_FK]
		,[CAD_Incident_ID1_Internal]
		,[Dim_FireSupplementalQuestions_FK]
		,[Dim_FireSupplementalQuestions1_FK]
		,[Dim_FireSupplementalQuestions2_FK]
		--,[Agency_shortname] AS "AGENCY"
		,FirstApparatusArrived_Dim_ApparatusResources_FK

FROM
	-- DwFire.Fact_Fire ff
	Elite_DWPortland.DwFire.Fact_Fire ff

JOIN Elite_DWPortland.DwFire.Dim_Basic basic ON ff.Dim_Basic_FK = basic.Dim_Basic_PK
JOIN Elite_DWPortland.DwFire.Dim_Fire fire ON ff.Dim_Fire_FK = fire.Dim_Fire_PK -- NEARLY FUCKING USELESS UNLESS IT'S A FIRE...
JOIN Elite_DWPortland.DwFire.Dim_Fire_CAD cad ON ff.CAD_ID_FK = cad.Dim_Fire_CAD_PK

WHERE
	ff.Agency_shortname = 'portlandfi'
	--AND basic.Basic_Incident_Alarm_Time >= '2024.05.20'
	--AND Basic_Incident_Status = 'Crew Documentation Finished'
	--AND (basic.Basic_Primary_Station_Name IN ('Station 8', 'Station 9', 'Station 3', 'Station 31'))

ORDER BY
	basic.Basic_Incident_Alarm_Time DESC
