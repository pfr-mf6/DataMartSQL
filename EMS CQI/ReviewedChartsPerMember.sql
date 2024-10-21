SELECT
    i.[Incident_Crew_Member_Name_Completing_This_Report], -- Crew Member ID
    -- COUNT(CASE WHEN i.[Incident_Status] = 'CQI Reviewed' THEN 1 END) AS "CQI Reviewed",
    -- COUNT(CASE WHEN i.[Incident_Status] = 'Exported To State' THEN 1 END) AS Finished,
    -- COUNT(CASE WHEN i.[Incident_Status] = 'Flag For CQI' THEN 1 END) AS "pending CQI review",
    -- COUNT(CASE WHEN i.[Incident_Status] = 'In Progress' THEN 1 END) AS "in progress",
    -- COUNT(CASE WHEN i.[Incident_Status] = 'Auto Posted' THEN 1 END) AS "auto posted",
    -- COUNT(CASE WHEN i.[Incident_Status] = 'Needs Crew Attention' THEN 1 END) AS "needs edits",
    -- COUNT(CASE WHEN i.[Incident_Status] = 'Crew Documentation Finished' THEN 1 END) AS "Failed",

    COUNT(CASE WHEN i.[Incident_Status] = 'CQI Reviewed' THEN 1 END) AS CQI_Reviewed_Count,
    COUNT(*) - COUNT(CASE WHEN i.[Incident_Status] = 'CQI Reviewed' THEN 1 END) AS Other_Status_Count

    -- Add more CASE statements for other Incident_Status values if needed
    --COUNT(*) AS TotalIncidents -- Total incidents for each crew member
FROM
    [Elite_DWPortland].[DwEms].[Dim_Incident] i  -- Assuming your table is named Dim_Incident

WHERE
    i.[CreatedOn] >= '2024-01-01'

GROUP BY 
    i.[Incident_Crew_Member_Name_Completing_This_Report]

ORDER BY
    i.[Incident_Crew_Member_Name_Completing_This_Report];
