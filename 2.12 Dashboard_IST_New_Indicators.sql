SET ANSI_WARNINGS OFF
SET NOCOUNT ON

-- Refresh updates for [MHDInternal].[DASHBOARD_TTAD_PDT_Inequalities_New_Indicators] ------------------------

DECLARE @Offset AS INT = -14

DECLARE @PeriodStart DATE = (SELECT DATEADD(MONTH,@Offset,MAX([ReportingPeriodStartDate])) FROM [mesh_IAPT].[IsLatest_SubmissionID])
DECLARE @PeriodEnd DATE = (SELECT EOMONTH(DATEADD(MONTH,@Offset,MAX([ReportingPeriodEndDate]))) FROM [mesh_IAPT].[IsLatest_SubmissionID])
DECLARE @MonthYear DATE = (DATENAME(M, @PeriodStart) + ' ' + CAST(DATEPART(YYYY, @PeriodStart) AS VARCHAR))

PRINT CHAR(10) + 'Month: ' + CAST(@MonthYear AS VARCHAR(50)) + CHAR(10)

----------------------------------------------------------------------------------------------------------------------------------------------

--INSERT INTO [MHDInternal].[DASHBOARD_TTAD_PDT_Inequalities_New_Indicators]

SELECT  CAST(DATENAME(m, l.[ReportingPeriodStartDate]) + ' ' + CAST(DATEPART(yyyy, l.[ReportingPeriodStartDate]) AS VARCHAR) AS DATE) AS 'Month'
		,'Refresh' AS 'DataSource'
		,'England' AS 'GroupType'
		,CASE WHEN ch.[Region_Code] IS NOT NULL THEN ch.[Region_Code] ELSE 'Other' END AS 'Region Code'
		,CASE WHEN ch.[Region_Name] IS NOT NULL THEN ch.[Region_Name] ELSE 'Other' END AS 'Region Name'
		,CASE WHEN ch.[Organisation_Code] IS NOT NULL THEN ch.[Organisation_Code] ELSE 'Other' END AS 'CCG Code'
		,CASE WHEN ch.[Organisation_Name] IS NOT NULL THEN ch.Organisation_Name ELSE 'Other' END AS 'CCG Name' 
		,CASE WHEN ph.[Organisation_Code] IS NOT NULL THEN ph.[Organisation_Code] ELSE 'Other' END AS 'Provider Code'
		,CASE WHEN ph.[Organisation_Name] IS NOT NULL THEN ph.[Organisation_Name] ELSE 'Other' END AS 'Provider Name'
		,CASE WHEN ch.[STP_Code] IS NOT NULL THEN ch.[STP_Code] ELSE 'Other' END AS 'STP Code'
		,CASE WHEN ch.[STP_Name] IS NOT NULL THEN ch.[STP_Name] ELSE 'Other' END AS 'STP Name'
		,'Total' AS 'Category'
		,'Total' AS 'Variable'
		,COUNT(DISTINCT CASE WHEN r.[ReferralRequestReceivedDate] BETWEEN l.[ReportingPeriodStartDate] AND l.[ReportingPeriodEndDate] AND [SourceOfReferralMH] = 'B1' THEN r.[PathwayID] ELSE NULL END) AS 'SelfReferral'
		,COUNT(DISTINCT CASE WHEN r.[ServDischDate] BETWEEN l.[ReportingPeriodStartDate] AND l.[ReportingPeriodEndDate] AND [TherapySession_FirstDate] IS NULL THEN r.[PathwayID] ELSE NULL END) AS 'EndedBeforeTreatment'
		,COUNT(DISTINCT CASE WHEN r.[TherapySession_FirstDate] BETWEEN l.[ReportingPeriodStartDate] AND l.[ReportingPeriodEndDate] AND DATEDIFF(DD,[ReferralRequestReceivedDate],[TherapySession_FirstDate]) <=14 THEN r.[PathwayID] ELSE NULL END) AS 'FirstTreatment2Weeks'
		,COUNT(DISTINCT CASE WHEN r.[TherapySession_FirstDate] BETWEEN l.[ReportingPeriodStartDate] AND l.[ReportingPeriodEndDate] AND DATEDIFF(DD,[ReferralRequestReceivedDate],[TherapySession_FirstDate]) <=42 THEN r.[PathwayID] ELSE NULL END) AS 'FirstTreatment6Weeks'
		,COUNT(DISTINCT CASE WHEN r.[TherapySession_FirstDate] BETWEEN l.[ReportingPeriodStartDate] AND l.[ReportingPeriodEndDate] AND DATEDIFF(DD,[ReferralRequestReceivedDate],[TherapySession_FirstDate]) <=84 THEN r.[PathwayID] ELSE NULL END) AS 'FirstTreatment12Weeks'
		,COUNT(DISTINCT CASE WHEN r.[TherapySession_FirstDate] BETWEEN l.[ReportingPeriodStartDate] AND l.[ReportingPeriodEndDate] AND DATEDIFF(DD,[ReferralRequestReceivedDate],[TherapySession_FirstDate]) <=126 THEN r.[PathwayID] ELSE NULL END) AS 'FirstTreatment18Weeks'
		,COUNT(DISTINCT CASE WHEN r.[TherapySession_FirstDate] IS NULL AND r.[ServDischDate] IS NULL THEN r.[PathwayID] ELSE NULL END) AS 'WaitingForTreatment'
		,COUNT(DISTINCT CASE WHEN a.[CareContDate] BETWEEN l.[ReportingPeriodStartDate] AND l.[ReportingPeriodEndDate] THEN [Unique_CareContactID]  ELSE NULL END) AS 'Appointments'
		,COUNT(DISTINCT CASE WHEN a.[CareContDate] BETWEEN l.[ReportingPeriodStartDate] AND l.[ReportingPeriodEndDate] AND [AttendOrDNACode] IN ('3', '03', ' 3', '3 ', ' 03', '03 ') THEN [Unique_CareContactID] ELSE NULL END) AS 'ApptDNA'
		,COUNT(DISTINCT CASE WHEN r.[ServDischDate] BETWEEN l.[ReportingPeriodStartDate] AND l.[ReportingPeriodEndDate] THEN r.[PathwayID] ELSE NULL END) AS 'ReferralsEnded'
		,COUNT(DISTINCT CASE WHEN r.[ServDischDate] BETWEEN l.[ReportingPeriodStartDate] AND l.[ReportingPeriodEndDate] AND [TreatmentCareContact_Count] = 1 THEN r.[PathwayID] ELSE NULL END) AS 'EndedTreatedOnce'
		,COUNT(DISTINCT CASE WHEN r.[TherapySession_FirstDate] IS NULL AND r.[ServDischDate] IS NULL AND DATEDIFF(DD,[ReferralRequestReceivedDate],l.[ReportingPeriodEndDate]) <=14 THEN r.[PathwayID] ELSE NULL END) AS 'Waiting2Weeks'
		,COUNT(DISTINCT CASE WHEN r.[TherapySession_FirstDate] IS NULL AND r.[ServDischDate] IS NULL AND DATEDIFF(DD,[ReferralRequestReceivedDate],l.[ReportingPeriodEndDate]) <=28 THEN r.[PathwayID] ELSE NULL END) AS 'Waiting4Weeks'
		,COUNT(DISTINCT CASE WHEN r.[TherapySession_FirstDate] IS NULL AND r.[ServDischDate] IS NULL AND DATEDIFF(DD,[ReferralRequestReceivedDate],l.[ReportingPeriodEndDate]) <=42 THEN r.[PathwayID] ELSE NULL END) AS 'Waiting6Weeks'
		,COUNT(DISTINCT CASE WHEN r.[TherapySession_FirstDate] IS NULL AND r.[ServDischDate] IS NULL AND DATEDIFF(DD,[ReferralRequestReceivedDate],l.[ReportingPeriodEndDate]) <=84 THEN r.[PathwayID] ELSE NULL END) AS 'Waiting12Weeks'
		,COUNT(DISTINCT CASE WHEN r.[TherapySession_FirstDate] IS NULL AND r.[ServDischDate] IS NULL AND DATEDIFF(DD,[ReferralRequestReceivedDate],l.[ReportingPeriodEndDate]) <=126 THEN r.[PathwayID] ELSE NULL END) AS 'Waiting18Weeks'
		,COUNT(DISTINCT CASE WHEN r.[ServDischDate] BETWEEN l.[ReportingPeriodStartDate] AND l.[ReportingPeriodEndDate] AND CompletedTreatment_Flag = 'True' AND DATEDIFF(dd,[ReferralRequestReceivedDate],[TherapySession_FirstDate]) <=42 THEN r.[PathwayID] ELSE NULL END) AS 'FinishedCourseTreatmentWaited6Weeks'
		,COUNT(DISTINCT CASE WHEN r.[ServDischDate] BETWEEN l.[ReportingPeriodStartDate] AND l.[ReportingPeriodEndDate] AND CompletedTreatment_Flag = 'True' AND DATEDIFF(dd,[ReferralRequestReceivedDate],[TherapySession_FirstDate]) <=126 THEN r.[PathwayID] ELSE NULL END) AS 'FinishedCourseTreatmentWaited18Weeks'
		,COUNT(DISTINCT CASE WHEN r.[TherapySession_SecondDate] BETWEEN l.[ReportingPeriodStartDate] AND l.[ReportingPeriodEndDate] AND DATEDIFF(DD,[TherapySession_FirstDate],[TherapySession_SecondDate]) <=28 THEN r.[PathwayID] ELSE NULL END) AS 'FirstToSecond28Days'
		,COUNT(DISTINCT CASE WHEN r.[TherapySession_SecondDate] BETWEEN l.[ReportingPeriodStartDate] AND l.[ReportingPeriodEndDate] AND DATEDIFF(DD,[TherapySession_FirstDate],[TherapySession_SecondDate]) BETWEEN 29 AND 90 THEN r.[PathwayID] ELSE NULL END) AS 'FirstToSecond28To90Days'
		,COUNT(DISTINCT CASE WHEN r.[TherapySession_SecondDate] BETWEEN l.[ReportingPeriodStartDate] AND l.[ReportingPeriodEndDate] AND DATEDIFF(DD,[TherapySession_FirstDate],[TherapySession_SecondDate]) > 90 THEN r.[PathwayID] ELSE NULL END) AS 'FirstToSecondMoreThan90Days'

FROM	[mesh_IAPT].[IDS101referral] r
		---------------------------
		INNER JOIN [mesh_IAPT].[IsLatest_SubmissionID] l ON r.[UniqueSubmissionID] = l.[UniqueSubmissionID] AND r.[AuditId] = l.[AuditId]
		---------------------------
		LEFT JOIN [mesh_IAPT].[IDS201carecontact] a ON r.[PathwayID] = a.[PathwayID] AND a.[AuditId] = l.[AuditId]
		---------------------------
		LEFT JOIN [Reporting].[Ref_ODS_Commissioner_Hierarchies_ICB] ch ON r.[OrgIDComm] = ch.[Organisation_Code] AND ch.[Effective_To] IS NULL
		LEFT JOIN [Reporting].[Ref_ODS_Provider_Hierarchies_ICB] ph ON r.[OrgID_Provider] = ph.[Organisation_Code] AND ph.[Effective_To] IS NULL

WHERE	UsePathway_Flag = 'True' AND IsLatest = 1
		AND l.[ReportingPeriodStartDate] BETWEEN @PeriodStart AND @PeriodEnd

GROUP BY CAST(DATENAME(m, l.[ReportingPeriodStartDate]) + ' ' + CAST(DATEPART(yyyy, l.[ReportingPeriodStartDate]) AS VARCHAR) AS DATE)
		,CASE WHEN ch.[Region_Code] IS NOT NULL THEN ch.[Region_Code] ELSE 'Other' END 
		,CASE WHEN ch.[Region_Name] IS NOT NULL THEN ch.[Region_Name] ELSE 'Other' END 
		,CASE WHEN ch.[Organisation_Code] IS NOT NULL THEN ch.[Organisation_Code] ELSE 'Other' END 
		,CASE WHEN ch.[Organisation_Name] IS NOT NULL THEN ch.[Organisation_Name] ELSE 'Other' END 
		,CASE WHEN ph.[Organisation_Code] IS NOT NULL THEN ph.[Organisation_Code] ELSE 'Other' END
		,CASE WHEN ph.[Organisation_Name] IS NOT NULL THEN ph.[Organisation_Name] ELSE 'Other' END
		,CASE WHEN ch.[STP_Code] IS NOT NULL THEN ch.[STP_Code] ELSE 'Other' END 
		,CASE WHEN ch.[STP_Name] IS NOT NULL THEN ch.[STP_Name] ELSE 'Other' END
		,[IntEnabledTherProg]
-----------------------------------------------------------------------------------------------------------------

PRINT 'Updated - [MHDInternal].[DASHBOARD_TTAD_PDT_Inequalities_New_Indicators]'