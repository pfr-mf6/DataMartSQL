SELECT 
    fq.[Responding Units],
    fq.alarm_time as time,
    fq.RP,
    unit_split.unit AS unit 

FROM (

    -- Second part of the union (NFIRS) - this is all you need now
    SELECT 
        'NFIRS' AS report,
        Fact_Fire.CreatedOn AS created_on,
        Fact_Fire.Agency_Shortname as agency,
        Fact_Fire.Basic_Incident_Validity_Score AS score,
        CASE 
            WHEN Dim_Basic.Basic_Incident_Status = 'Crew Documentation Finished' THEN 'Finished'
            WHEN Dim_Basic.Basic_Incident_Status = 'Exported To State' THEN 'Finished'
            WHEN Dim_Basic.Basic_Incident_Status = 'Crew Edits Complete' THEN 'Finished'
            ELSE Dim_Basic.Basic_Incident_Status 
        END AS status,
        'Exposure ' + CONVERT(VARCHAR(255), Dim_Basic.Basic_Exposure) AS unique_record_id,
        Dim_Basic.Basic_Incident_Alarm_Time AS alarm_time,
        Dim_Basic.Basic_Incident_Number as RP,
        Dim_Fire.Fire_Initial_CAD_Incident_Type_Description as 'EMD - desc',
        Dim_Basic.Basic_Apparatus_Call_Sign_List as 'Responding Units',
        Dim_Basic.Basic_Shift_Or_Platoon as shift,
        CASE
            WHEN COALESCE(Dim_Basic.Basic_Primary_Station_Name, '') = '' THEN '?'
            ELSE Dim_Basic.Basic_Primary_Station_Name
        END as FMA,
        Dim_Basic.Basic_Incident_Full_Address as address,
        Dim_Basic.Basic_Authorization_Member_Making_Report_Name as 'author',
        Dim_Basic.Basic_Primary_Action_Taken as 'disposition',
        Fact_Fire.Basic_Incident_Form_Number AS form_number,
        Fact_Fire.Incident_ID_Internal AS url_incident,
        'https://portland.imagetrendelite.com/Elite/Organizationportland/Agencyportlandfi/FireRunForm#/Incident' 
        + CONVERT(VARCHAR(255), Fact_Fire.Incident_ID_Internal) 
        + '/Form' 
        + CONVERT(VARCHAR(255), Fact_Fire.Basic_Incident_Form_Number) AS link

    FROM [Elite_DWPortland].[DwFire].[Fact_Fire]
    INNER JOIN [Elite_DWPortland].[DwFire].[Dim_Basic] 
        ON Fact_Fire.Dim_Basic_FK = Dim_Basic.Dim_Basic_PK
    INNER JOIN [Elite_DWPortland].[DwFire].[Dim_Fire] 
        ON Fact_Fire.Dim_Fire_FK = Dim_Fire.Dim_Fire_PK
    WHERE Fact_Fire.CreatedOn >= '2024-08-19'
    AND Fact_Fire.Agency_shortname = 'portlandfi'

) fq

CROSS APPLY (
    SELECT 
        LTRIM(RTRIM(value)) AS unit 
    FROM STRING_SPLIT(fq.[Responding Units], ',')
) unit_split
