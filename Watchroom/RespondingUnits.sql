-- SELECT 
--     'NFIRS' AS report,
--     fq.created_on,
--     fq.agency,
--     fq.score,
--     fq.status,
--     fq.unique_record_id,
--     fq.alarm_time as time,
--     fq.RP,
--     dar.Apparatus_Resource_Vehicle_Call_Sign AS unit

-- FROM (

--     SELECT 
--         Fact_Fire.CreatedOn AS created_on,
--         Fact_Fire.Agency_Shortname as agency,
--         Fact_Fire.Basic_Incident_Validity_Score AS score,
--         CASE 
--             WHEN Dim_Basic.Basic_Incident_Status = 'Crew Documentation Finished' THEN 'Finished'
--             WHEN Dim_Basic.Basic_Incident_Status = 'Exported To State' THEN 'Finished'
--             WHEN Dim_Basic.Basic_Incident_Status = 'Crew Edits Complete' THEN 'Finished'
--             ELSE Dim_Basic.Basic_Incident_Status 
--         END AS status,
--         'Exposure ' + CONVERT(VARCHAR(255), Dim_Basic.Basic_Exposure) AS unique_record_id,
--         Dim_Basic.Basic_Incident_Alarm_Time AS alarm_time,
--         Dim_Basic.Basic_Incident_Number as RP

--     FROM [Elite_DWPortland].[DwFire].[Fact_Fire]
--     INNER JOIN [Elite_DWPortland].[DwFire].[Dim_Basic] 
--         ON Fact_Fire.Dim_Basic_FK = Dim_Basic.Dim_Basic_PK
-- ) fq -- Alias for the subquery

-- INNER JOIN [Elite_DWPortland].[DwFire].[Bridge_Fire_ApparatusResources] bfar ON fq.created_on = bfar.CreatedOn 
-- INNER JOIN [Elite_DWPortland].[DwFire].[Dim_ApparatusResources] dar ON bfar.Dim_ApparatusResources_PK = dar.Dim_ApparatusResources_PK

-- ;

-- -- WHERE Fact_Fire.CreatedOn >= '2024-08-19'
-- -- AND Fact_Fire.Agency_shortname = 'portlandfi';


SELECT
    f.Agency_Shortname as agency,


    dar.Apparatus_Resource_Vehicle_Call_Sign as unit


FROM [Elite_DWPortland].[DwFire].[Fact_Fire] f

JOIN [Elite_DWPortland].[DwFire].[Bridge_Fire_ApparatusResources] bfar ON f.Fact_Fire_PK = bfar.Fact_Fire_PK
JOIN [Elite_DWPortland].[DwFire].[Dim_ApparatusResources] dar ON bfar.Dim_ApparatusResources_PK = dar.Dim_ApparatusResources_PK;
