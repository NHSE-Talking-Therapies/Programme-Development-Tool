SET ANSI_WARNINGS OFF
SET DATEFIRST 1
SET NOCOUNT ON

-- Rounding scripts (Main table, Primary Loop & New Indicators) -----------------------------------------------------------------------

USE [NHSE_IAPT_v2]

DECLARE @Offset AS INT = -1

DECLARE @PeriodStart AS DATE = (SELECT DATEADD(MONTH,@Offset,MAX([ReportingPeriodStartDate])) FROM [IsLatest_SubmissionID])
DECLARE @PeriodEnd AS DATE = (SELECT EOMONTH(DATEADD(MONTH,@Offset,MAX([ReportingPeriodendDate]))) FROM [IsLatest_SubmissionID])
DECLARE @MonthYear AS VARCHAR(50) = (DATENAME(M, @PeriodStart) + ' ' + CAST(DATEPART(YYYY, @PeriodStart) AS VARCHAR))

PRINT CHAR(10) + 'Month: ' + CAST(@MonthYear AS VARCHAR(50)) + CHAR(10)

--------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Appointment_Types_Totals]

SELECT * FROM

(

SELECT [Month], 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		'National' AS 'Level',
		'All' AS 'Region Code',
		'All' AS 'Region Name',
		'All' AS 'CCG Code',
		'All' AS 'CCG Name',
		'All' AS 'Provider Code',
		'All' AS 'Provider Name',
		'All' AS 'STP Code',
		'All' AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		SUM([GuideSelfHelpBookApts]) AS [GuideSelfHelpBookApts],
		SUM([NonGuideSelfHelpBookApts]) AS [NonGuideSelfHelpBookApts],
		SUM([GuideSelfHelpCompApts]) AS [GuideSelfHelpCompApts],
		SUM([NonGuideSelfHelpCompApts]) AS [NonGuideSelfHelpCompApts],
		SUM([BehavActLIApts]) AS [BehavActLIApts],
		SUM([StructPhysActApts]) AS [StructPhysActApts],
		SUM([AntePostNatalCounselApts]) AS [AntePostNatalCounselApts],
		SUM([PsychoEducPeerSuppApts]) AS [PsychoEducPeerSuppApts],
		SUM([OtherLIApts]) AS [OtherLIApts],
		SUM([EmploySuppLIApts]) AS [EmploySuppLIApts],
		SUM([AppRelaxApts]) AS [AppRelaxApts],
		SUM([BehavActHIApts]) AS [BehavActHIApts],
		SUM([CoupleTherapyDepApts]) AS [CoupleTherapyDepApts],
		SUM([CollabCareApts]) AS [CollabCareApts],
		SUM([CounselDepApts]) AS [CounselDepApts],
		SUM([BPDApts]) AS [BPDApts],
		SUM([EyeMoveDesenReproApts]) AS [EyeMoveDesenReproApts],
		SUM([MindfulApts]) AS [MindfulApts],
		SUM([OtherHIApts]) AS [OtherHIApts],
		SUM([EmploySuppHIApts]) AS [EmploySuppHIApts],
		SUM([CBTApts]) AS [CBTApts],
		SUM([IPTApts]) AS [IPTApts],
		SUM([ESApts]) AS [ESApts],
		SUM([Signposting]) AS [Signposting],

		ROUND(CASE WHEN SUM([GuideSelfHelpBookApts])<5 THEN NULL ELSE CAST(SUM([GuideSelfHelpBookApts])AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS GuideSelfHelpBookAptsPROP,

		ROUND(CASE WHEN SUM([NonGuideSelfHelpBookApts])<5 THEN NULL ELSE CAST(SUM([NonGuideSelfHelpBookApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS NonGuideSelfHelpBookAptsPROP,

		ROUND(CASE WHEN SUM([GuideSelfHelpCompApts])<5 THEN NULL ELSE CAST(SUM([GuideSelfHelpCompApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS GuideSelfHelpCompAptsPROP,

		ROUND(CASE WHEN SUM([NonGuideSelfHelpCompApts])<5 THEN NULL ELSE CAST(SUM([NonGuideSelfHelpCompApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS NonGuideSelfHelpCompAptsPROP,

		ROUND(CASE WHEN SUM([BehavActLIApts])<5 THEN NULL ELSE CAST(SUM([BehavActLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS BehavActLIAptsPROP,

		ROUND(CASE WHEN SUM([StructPhysActApts])<5 THEN NULL ELSE CAST(SUM([StructPhysActApts]) AS FLOAT)/ CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS StructPhysActAptsPROP,

		ROUND(CASE WHEN SUM([AntePostNatalCounselApts])<5 THEN NULL ELSE CAST(SUM([AntePostNatalCounselApts]) AS FLOAT)/CAST ((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS AntePostNatalCounselAptsPROP,

		ROUND(CASE WHEN SUM([PsychoEducPeerSuppApts])<5 THEN NULL ELSE CAST(SUM([PsychoEducPeerSuppApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS PsychoEducPeerSuppAptsPROP,

		ROUND(CASE WHEN SUM([OtherLIApts])<5 THEN NULL ELSE CAST(SUM([OtherLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS OtherLIAptsPROP,

		ROUND(CASE WHEN SUM([EmploySuppLIApts])<5 THEN NULL ELSE CAST(SUM([EmploySuppLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS EmploySuppLIAptsPROP,

		ROUND(CASE WHEN SUM([AppRelaxApts])<5 THEN NULL ELSE CAST(SUM([AppRelaxApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS AppRelaxAptsPROP,

		ROUND(CASE WHEN SUM([BehavActHIApts])<5 THEN NULL ELSE CAST(SUM([BehavActHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS BehavActHIAptsPROP,

		ROUND(CASE WHEN SUM([CoupleTherapyDepApts])<5 THEN NULL ELSE CAST(SUM([CoupleTherapyDepApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS CoupleTherapyDepAptsPROP,

		ROUND(CASE WHEN SUM([CollabCareApts])<5 THEN NULL ELSE CAST(SUM([CollabCareApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS CollabCareAptsPROP,

		ROUND(CASE WHEN SUM([CounselDepApts])<5 THEN NULL ELSE CAST(SUM([CounselDepApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS CounselDepAptsPROP,

		ROUND(CASE WHEN SUM([BPDApts])<5 THEN NULL ELSE CAST(SUM([BPDApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS BPDAptsPROP,

		ROUND(CASE WHEN SUM([EyeMoveDesenReproApts])<5 THEN NULL ELSE CAST(SUM([EyeMoveDesenReproApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT)END, 3) AS EyeMoveDesenReproAptsPROP,

		ROUND(CASE WHEN SUM([MindfulApts])<5 THEN NULL ELSE CAST(SUM([MindfulApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS MindfulAptsPROP,

		ROUND(CASE WHEN SUM([OtherHIApts])<5 THEN NULL ELSE CAST(SUM([OtherHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS OtherHIAptsPROP,

		ROUND(CASE WHEN SUM([EmploySuppHIApts])<5 THEN NULL ELSE CAST(SUM([EmploySuppHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS EmploySuppHIAptsPROP,

		ROUND(CASE WHEN SUM([CBTApts])<5 THEN NULL ELSE CAST(SUM([CBTApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS CBTAptsPROP,

		ROUND(CASE WHEN SUM([IPTApts])<5 THEN NULL ELSE CAST(SUM([IPTApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS IPTAptsPROP,

		ROUND(CASE WHEN SUM([ESApts])<5 THEN NULL ELSE CAST(SUM([ESApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS ESAptsPROP,

		ROUND(CASE WHEN SUM([Signposting])<5 THEN NULL ELSE CAST(SUM([Signposting]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 3) AS SignpostingPROP

FROM [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Apps_Primary_Loop]

WHERE [Category] = 'Total' AND [Month] = @MonthYear

GROUP BY [Month]

UNION

SELECT [Month], 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		'Region' AS 'Level',
		[Region Code] AS 'Region Code',
		[Region Name] AS 'Region Name',
		'All' AS 'CCG Code',
		'All' AS 'CCG Name',
		'All' AS 'Provider Code',
		'All' AS 'Provider Name',
		'All' AS 'STP Code',
		'All' AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		CASE WHEN [GuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END AS [GuideSelfHelpBookApts],
		CASE WHEN [NonGuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END AS [NonGuideSelfHelpBookApts],
		CASE WHEN [GuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END AS [GuideSelfHelpCompApts],
		CASE WHEN [NonGuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END AS [NonGuideSelfHelpCompApts],
		CASE WHEN [BehavActLIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActLIApts]+2) /5,0)*5 AS INT)  END AS [BehavActLIApts],
		CASE WHEN [StructPhysActApts]< 5 THEN NULL ELSE CAST(ROUND(([StructPhysActApts]+2) /5,0)*5 AS INT)  END AS [StructPhysActApts],
		CASE WHEN [AntePostNatalCounselApts]< 5 THEN NULL ELSE CAST(ROUND(([AntePostNatalCounselApts]+2) /5,0)*5 AS INT)  END AS [AntePostNatalCounselApts],
		CASE WHEN [PsychoEducPeerSuppApts]< 5 THEN NULL ELSE CAST(ROUND(([PsychoEducPeerSuppApts]+2) /5,0)*5 AS INT)  END AS [PsychoEducPeerSuppApts],
		CASE WHEN [OtherLIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherLIApts]+2) /5,0)*5 AS INT)  END AS [OtherLIApts],
		CASE WHEN [EmploySuppLIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppLIApts]+2) /5,0)*5 AS INT)  END AS [EmploySuppLIApts],
		CASE WHEN [AppRelaxApts]< 5 THEN NULL ELSE CAST(ROUND(([AppRelaxApts]+2) /5,0)*5 AS INT)  END AS [AppRelaxApts],
		CASE WHEN [BehavActHIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActHIApts]+2) /5,0)*5 AS INT)  END AS [BehavActHIApts],
		CASE WHEN [CoupleTherapyDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CoupleTherapyDepApts]+2) /5,0)*5 AS INT)  END AS [CoupleTherapyDepApts],
		CASE WHEN [CollabCareApts]< 5 THEN NULL ELSE CAST(ROUND(([CollabCareApts]+2) /5,0)*5 AS INT)  END AS [CollabCareApts],
		CASE WHEN [CounselDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CounselDepApts]+2) /5,0)*5 AS INT)  END AS [CounselDepApts],
		CASE WHEN [BPDApts]< 5 THEN NULL ELSE CAST(ROUND(([BPDApts]+2) /5,0)*5 AS INT)  END AS [BPDApts],
		CASE WHEN [EyeMoveDesenReproApts]< 5 THEN NULL ELSE CAST(ROUND(([EyeMoveDesenReproApts]+2) /5,0)*5 AS INT)  END AS [EyeMoveDesenReproApts],
		CASE WHEN [MindfulApts]< 5 THEN NULL ELSE CAST(ROUND(([MindfulApts]+2) /5,0)*5 AS INT)  END AS [MindfulApts],
		CASE WHEN [OtherHIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherHIApts]+2) /5,0)*5 AS INT)  END AS [OtherHIApts],
		CASE WHEN [EmploySuppHIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppHIApts]+2) /5,0)*5 AS INT)  END AS [EmploySuppHIApts],
		CASE WHEN [CBTApts]< 5 THEN NULL ELSE CAST(ROUND(([CBTApts]+2) /5,0)*5 AS INT)  END AS [CBTApts],
		CASE WHEN [IPTApts]< 5 THEN NULL ELSE CAST(ROUND(([IPTApts]+2) /5,0)*5 AS INT)  END AS [IPTApts],
		CASE WHEN [ESApts]< 5 THEN NULL ELSE CAST(ROUND(([ESApts]+2) /5,0)*5 AS INT)  END AS [ESApts],
		CASE WHEN [Signposting]< 5 THEN NULL ELSE CAST(ROUND(([Signposting]+2) /5,0)*5 AS INT)  END AS [Signposting],

		ROUND(CASE WHEN SUM([GuideSelfHelpBookApts])<5 THEN NULL ELSE CAST(SUM([GuideSelfHelpBookApts])AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS GuideSelfHelpBookAptsPROP,

		ROUND(CASE WHEN SUM([NonGuideSelfHelpBookApts])<5 THEN NULL ELSE CAST(SUM([NonGuideSelfHelpBookApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS NonGuideSelfHelpBookAptsPROP,

		ROUND(CASE WHEN SUM([GuideSelfHelpCompApts])<5 THEN NULL ELSE CAST(SUM([GuideSelfHelpCompApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS GuideSelfHelpCompAptsPROP,

		ROUND(CASE WHEN SUM([NonGuideSelfHelpCompApts])<5 THEN NULL ELSE CAST(SUM([NonGuideSelfHelpCompApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS NonGuideSelfHelpCompAptsPROP,

		ROUND(CASE WHEN SUM([BehavActLIApts])<5 THEN NULL ELSE CAST(SUM([BehavActLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS BehavActLIAptsPROP,

		ROUND(CASE WHEN SUM([StructPhysActApts])<5 THEN NULL ELSE CAST(SUM([StructPhysActApts]) AS FLOAT)/ CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS StructPhysActAptsPROP,

		ROUND(CASE WHEN SUM([AntePostNatalCounselApts])<5 THEN NULL ELSE CAST(SUM([AntePostNatalCounselApts]) AS FLOAT)/CAST ((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS AntePostNatalCounselAptsPROP,

		ROUND(CASE WHEN SUM([PsychoEducPeerSuppApts])<5 THEN NULL ELSE CAST(SUM([PsychoEducPeerSuppApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS PsychoEducPeerSuppAptsPROP,

		ROUND(CASE WHEN SUM([OtherLIApts])<5 THEN NULL ELSE CAST(SUM([OtherLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS OtherLIAptsPROP,

		ROUND(CASE WHEN SUM([EmploySuppLIApts])<5 THEN NULL ELSE CAST(SUM([EmploySuppLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS EmploySuppLIAptsPROP,

		ROUND(CASE WHEN SUM([AppRelaxApts])<5 THEN NULL ELSE CAST(SUM([AppRelaxApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS AppRelaxAptsPROP,

		ROUND(CASE WHEN SUM([BehavActHIApts])<5 THEN NULL ELSE CAST(SUM([BehavActHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS BehavActHIAptsPROP,

		ROUND(CASE WHEN SUM([CoupleTherapyDepApts])<5 THEN NULL ELSE CAST(SUM([CoupleTherapyDepApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CoupleTherapyDepAptsPROP,

		ROUND(CASE WHEN SUM([CollabCareApts])<5 THEN NULL ELSE CAST(SUM([CollabCareApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CollabCareAptsPROP,

		ROUND(CASE WHEN SUM([CounselDepApts])<5 THEN NULL ELSE CAST(SUM([CounselDepApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CounselDepAptsPROP,

		ROUND(CASE WHEN SUM([BPDApts])<5 THEN NULL ELSE CAST(SUM([BPDApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS BPDAptsPROP,

		ROUND(CASE WHEN SUM([EyeMoveDesenReproApts])<5 THEN NULL ELSE CAST(SUM([EyeMoveDesenReproApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT)END, 2) AS EyeMoveDesenReproAptsPROP,

		ROUND(CASE WHEN SUM([MindfulApts])<5 THEN NULL ELSE CAST(SUM([MindfulApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS MindfulAptsPROP,

		ROUND(CASE WHEN SUM([OtherHIApts])<5 THEN NULL ELSE CAST(SUM([OtherHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS OtherHIAptsPROP,

		ROUND(CASE WHEN SUM([EmploySuppHIApts])<5 THEN NULL ELSE CAST(SUM([EmploySuppHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS EmploySuppHIAptsPROP,

		ROUND(CASE WHEN SUM([CBTApts])<5 THEN NULL ELSE CAST(SUM([CBTApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CBTAptsPROP,

		ROUND(CASE WHEN SUM([IPTApts])<5 THEN NULL ELSE CAST(SUM([IPTApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS IPTAptsPROP,

		ROUND(CASE WHEN SUM([ESApts])<5 THEN NULL ELSE CAST(SUM([ESApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS ESAptsPROP,

		ROUND(CASE WHEN SUM([Signposting])<5 THEN NULL ELSE CAST(SUM([Signposting]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS SignpostingPROP

FROM	[NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Apps_Primary_Loop]

WHERE	[Category] = 'Total' AND [Month] = @MonthYear

GROUP BY [Month]
		,[Region Code]
		,[Region Name]
		,CASE WHEN [GuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [NonGuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [GuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [NonGuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [BehavActLIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActLIApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [StructPhysActApts]< 5 THEN NULL ELSE CAST(ROUND(([StructPhysActApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [AntePostNatalCounselApts]< 5 THEN NULL ELSE CAST(ROUND(([AntePostNatalCounselApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [PsychoEducPeerSuppApts]< 5 THEN NULL ELSE CAST(ROUND(([PsychoEducPeerSuppApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [OtherLIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherLIApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [EmploySuppLIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppLIApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [AppRelaxApts]< 5 THEN NULL ELSE CAST(ROUND(([AppRelaxApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [BehavActHIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActHIApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [CoupleTherapyDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CoupleTherapyDepApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [CollabCareApts]< 5 THEN NULL ELSE CAST(ROUND(([CollabCareApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [CounselDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CounselDepApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [BPDApts]< 5 THEN NULL ELSE CAST(ROUND(([BPDApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [EyeMoveDesenReproApts]< 5 THEN NULL ELSE CAST(ROUND(([EyeMoveDesenReproApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [MindfulApts]< 5 THEN NULL ELSE CAST(ROUND(([MindfulApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [OtherHIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherHIApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [EmploySuppHIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppHIApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [CBTApts]< 5 THEN NULL ELSE CAST(ROUND(([CBTApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [IPTApts]< 5 THEN NULL ELSE CAST(ROUND(([IPTApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [ESApts]< 5 THEN NULL ELSE CAST(ROUND(([ESApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [Signposting]< 5 THEN NULL ELSE CAST(ROUND(([Signposting]+2) /5,0)*5 AS INT)  END

UNION --------------------------------------------------------------------------------------------------------

SELECT [Month], 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		'STP' AS 'Level',
		'All' AS 'Region Code',
		'All' AS 'Region Name',
		'All' AS 'CCG Code',
		'All' AS 'CCG Name',
		'All' AS 'Provider Code',
		'All' AS 'Provider Name',
		[STP Code] AS 'STP Code',
		[STP Name] AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		CASE WHEN [GuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END AS [GuideSelfHelpBookApts],
		CASE WHEN [NonGuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END AS [NonGuideSelfHelpBookApts],
		CASE WHEN [GuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END AS [GuideSelfHelpCompApts],
		CASE WHEN [NonGuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END AS [NonGuideSelfHelpCompApts],
		CASE WHEN [BehavActLIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActLIApts]+2) /5,0)*5 AS INT)  END AS [BehavActLIApts],
		CASE WHEN [StructPhysActApts]< 5 THEN NULL ELSE CAST(ROUND(([StructPhysActApts]+2) /5,0)*5 AS INT)  END AS [StructPhysActApts],
		CASE WHEN [AntePostNatalCounselApts]< 5 THEN NULL ELSE CAST(ROUND(([AntePostNatalCounselApts]+2) /5,0)*5 AS INT)  END AS [AntePostNatalCounselApts],
		CASE WHEN [PsychoEducPeerSuppApts]< 5 THEN NULL ELSE CAST(ROUND(([PsychoEducPeerSuppApts]+2) /5,0)*5 AS INT)  END AS [PsychoEducPeerSuppApts],
		CASE WHEN [OtherLIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherLIApts]+2) /5,0)*5 AS INT)  END AS [OtherLIApts],
		CASE WHEN [EmploySuppLIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppLIApts]+2) /5,0)*5 AS INT)  END AS [EmploySuppLIApts],
		CASE WHEN [AppRelaxApts]< 5 THEN NULL ELSE CAST(ROUND(([AppRelaxApts]+2) /5,0)*5 AS INT)  END AS [AppRelaxApts],
		CASE WHEN [BehavActHIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActHIApts]+2) /5,0)*5 AS INT)  END AS [BehavActHIApts],
		CASE WHEN [CoupleTherapyDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CoupleTherapyDepApts]+2) /5,0)*5 AS INT)  END AS [CoupleTherapyDepApts],
		CASE WHEN [CollabCareApts]< 5 THEN NULL ELSE CAST(ROUND(([CollabCareApts]+2) /5,0)*5 AS INT)  END AS [CollabCareApts],
		CASE WHEN [CounselDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CounselDepApts]+2) /5,0)*5 AS INT)  END AS [CounselDepApts],
		CASE WHEN [BPDApts]< 5 THEN NULL ELSE CAST(ROUND(([BPDApts]+2) /5,0)*5 AS INT)  END AS [BPDApts],
		CASE WHEN [EyeMoveDesenReproApts]< 5 THEN NULL ELSE CAST(ROUND(([EyeMoveDesenReproApts]+2) /5,0)*5 AS INT)  END AS [EyeMoveDesenReproApts],
		CASE WHEN [MindfulApts]< 5 THEN NULL ELSE CAST(ROUND(([MindfulApts]+2) /5,0)*5 AS INT)  END AS [MindfulApts],
		CASE WHEN [OtherHIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherHIApts]+2) /5,0)*5 AS INT)  END AS [OtherHIApts],
		CASE WHEN [EmploySuppHIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppHIApts]+2) /5,0)*5 AS INT)  END AS [EmploySuppHIApts],
		CASE WHEN [CBTApts]< 5 THEN NULL ELSE CAST(ROUND(([CBTApts]+2) /5,0)*5 AS INT)  END AS [CBTApts],
		CASE WHEN [IPTApts]< 5 THEN NULL ELSE CAST(ROUND(([IPTApts]+2) /5,0)*5 AS INT)  END AS [IPTApts],
		CASE WHEN [ESApts]< 5 THEN NULL ELSE CAST(ROUND(([ESApts]+2) /5,0)*5 AS INT)  END AS [ESApts],
		CASE WHEN [Signposting]< 5 THEN NULL ELSE CAST(ROUND(([Signposting]+2) /5,0)*5 AS INT)  END AS [Signposting],
		ROUND(CASE WHEN SUM([GuideSelfHelpBookApts])<5 THEN NULL ELSE CAST(SUM([GuideSelfHelpBookApts])AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS GuideSelfHelpBookAptsPROP,

		ROUND(CASE WHEN SUM([NonGuideSelfHelpBookApts])<5 THEN NULL ELSE CAST(SUM([NonGuideSelfHelpBookApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS NonGuideSelfHelpBookAptsPROP,

		ROUND(CASE WHEN SUM([GuideSelfHelpCompApts])<5 THEN NULL ELSE CAST(SUM([GuideSelfHelpCompApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS GuideSelfHelpCompAptsPROP,

		ROUND(CASE WHEN SUM([NonGuideSelfHelpCompApts])<5 THEN NULL ELSE CAST(SUM([NonGuideSelfHelpCompApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS NonGuideSelfHelpCompAptsPROP,

		ROUND(CASE WHEN SUM([BehavActLIApts])<5 THEN NULL ELSE CAST(SUM([BehavActLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS BehavActLIAptsPROP,

		ROUND(CASE WHEN SUM([StructPhysActApts])<5 THEN NULL ELSE CAST(SUM([StructPhysActApts]) AS FLOAT)/ CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS StructPhysActAptsPROP,

		ROUND(CASE WHEN SUM([AntePostNatalCounselApts])<5 THEN NULL ELSE CAST(SUM([AntePostNatalCounselApts]) AS FLOAT)/CAST ((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS AntePostNatalCounselAptsPROP,

		ROUND(CASE WHEN SUM([PsychoEducPeerSuppApts])<5 THEN NULL ELSE CAST(SUM([PsychoEducPeerSuppApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS PsychoEducPeerSuppAptsPROP,

		ROUND(CASE WHEN SUM([OtherLIApts])<5 THEN NULL ELSE CAST(SUM([OtherLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS OtherLIAptsPROP,

		ROUND(CASE WHEN SUM([EmploySuppLIApts])<5 THEN NULL ELSE CAST(SUM([EmploySuppLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS EmploySuppLIAptsPROP,

		ROUND(CASE WHEN SUM([AppRelaxApts])<5 THEN NULL ELSE CAST(SUM([AppRelaxApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS AppRelaxAptsPROP,

		ROUND(CASE WHEN SUM([BehavActHIApts])<5 THEN NULL ELSE CAST(SUM([BehavActHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS BehavActHIAptsPROP,

		ROUND(CASE WHEN SUM([CoupleTherapyDepApts])<5 THEN NULL ELSE CAST(SUM([CoupleTherapyDepApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CoupleTherapyDepAptsPROP,

		ROUND(CASE WHEN SUM([CollabCareApts])<5 THEN NULL ELSE CAST(SUM([CollabCareApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CollabCareAptsPROP,

		ROUND(CASE WHEN SUM([CounselDepApts])<5 THEN NULL ELSE CAST(SUM([CounselDepApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CounselDepAptsPROP,

		ROUND(CASE WHEN SUM([BPDApts])<5 THEN NULL ELSE CAST(SUM([BPDApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS BPDAptsPROP,

		ROUND(CASE WHEN SUM([EyeMoveDesenReproApts])<5 THEN NULL ELSE CAST(SUM([EyeMoveDesenReproApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT)END, 2) AS EyeMoveDesenReproAptsPROP,

		ROUND(CASE WHEN SUM([MindfulApts])<5 THEN NULL ELSE CAST(SUM([MindfulApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS MindfulAptsPROP,

		ROUND(CASE WHEN SUM([OtherHIApts])<5 THEN NULL ELSE CAST(SUM([OtherHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS OtherHIAptsPROP,

		ROUND(CASE WHEN SUM([EmploySuppHIApts])<5 THEN NULL ELSE CAST(SUM([EmploySuppHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS EmploySuppHIAptsPROP,

		ROUND(CASE WHEN SUM([CBTApts])<5 THEN NULL ELSE CAST(SUM([CBTApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CBTAptsPROP,

		ROUND(CASE WHEN SUM([IPTApts])<5 THEN NULL ELSE CAST(SUM([IPTApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS IPTAptsPROP,

		ROUND(CASE WHEN SUM([ESApts])<5 THEN NULL ELSE CAST(SUM([ESApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS ESAptsPROP,

		ROUND(CASE WHEN SUM([Signposting])<5 THEN NULL ELSE CAST(SUM([Signposting]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS SignpostingPROP

FROM [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Apps_Primary_Loop]

WHERE [Category] = 'Total' AND [Month] = @MonthYear

GROUP BY [Month]
		,[STP Code]
		,[STP Name]
		,CASE WHEN [GuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [NonGuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [GuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [NonGuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [BehavActLIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActLIApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [StructPhysActApts]< 5 THEN NULL ELSE CAST(ROUND(([StructPhysActApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [AntePostNatalCounselApts]< 5 THEN NULL ELSE CAST(ROUND(([AntePostNatalCounselApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [PsychoEducPeerSuppApts]< 5 THEN NULL ELSE CAST(ROUND(([PsychoEducPeerSuppApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [OtherLIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherLIApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [EmploySuppLIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppLIApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [AppRelaxApts]< 5 THEN NULL ELSE CAST(ROUND(([AppRelaxApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [BehavActHIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActHIApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [CoupleTherapyDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CoupleTherapyDepApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [CollabCareApts]< 5 THEN NULL ELSE CAST(ROUND(([CollabCareApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [CounselDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CounselDepApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [BPDApts]< 5 THEN NULL ELSE CAST(ROUND(([BPDApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [EyeMoveDesenReproApts]< 5 THEN NULL ELSE CAST(ROUND(([EyeMoveDesenReproApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [MindfulApts]< 5 THEN NULL ELSE CAST(ROUND(([MindfulApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [OtherHIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherHIApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [EmploySuppHIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppHIApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [CBTApts]< 5 THEN NULL ELSE CAST(ROUND(([CBTApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [IPTApts]< 5 THEN NULL ELSE CAST(ROUND(([IPTApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [ESApts]< 5 THEN NULL ELSE CAST(ROUND(([ESApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [Signposting]< 5 THEN NULL ELSE CAST(ROUND(([Signposting]+2) /5,0)*5 AS INT)  END

UNION -----------------------------------------------------------------

SELECT	[Month], 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		'CCG' AS 'Level',
		'All' AS 'Region Code',
		'All' AS 'Region Name',
		[CCG Code] AS 'CCG Code',
		[CCG Name] AS 'CCG Name',
		'All' AS 'Provider Code',
		'All' AS 'Provider Name',
		'All' AS 'STP Code',
		'All' AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		CASE WHEN [GuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END AS [GuideSelfHelpBookApts],
		CASE WHEN [NonGuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END AS [NonGuideSelfHelpBookApts],
		CASE WHEN [GuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END AS [GuideSelfHelpCompApts],
		CASE WHEN [NonGuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END AS [NonGuideSelfHelpCompApts],
		CASE WHEN [BehavActLIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActLIApts]+2) /5,0)*5 AS INT)  END AS [BehavActLIApts],
		CASE WHEN [StructPhysActApts]< 5 THEN NULL ELSE CAST(ROUND(([StructPhysActApts]+2) /5,0)*5 AS INT)  END AS [StructPhysActApts],
		CASE WHEN [AntePostNatalCounselApts]< 5 THEN NULL ELSE CAST(ROUND(([AntePostNatalCounselApts]+2) /5,0)*5 AS INT)  END AS [AntePostNatalCounselApts],
		CASE WHEN [PsychoEducPeerSuppApts]< 5 THEN NULL ELSE CAST(ROUND(([PsychoEducPeerSuppApts]+2) /5,0)*5 AS INT)  END AS [PsychoEducPeerSuppApts],
		CASE WHEN [OtherLIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherLIApts]+2) /5,0)*5 AS INT)  END AS [OtherLIApts],
		CASE WHEN [EmploySuppLIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppLIApts]+2) /5,0)*5 AS INT)  END AS [EmploySuppLIApts],
		CASE WHEN [AppRelaxApts]< 5 THEN NULL ELSE CAST(ROUND(([AppRelaxApts]+2) /5,0)*5 AS INT)  END AS [AppRelaxApts],
		CASE WHEN [BehavActHIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActHIApts]+2) /5,0)*5 AS INT)  END AS [BehavActHIApts],
		CASE WHEN [CoupleTherapyDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CoupleTherapyDepApts]+2) /5,0)*5 AS INT)  END AS [CoupleTherapyDepApts],
		CASE WHEN [CollabCareApts]< 5 THEN NULL ELSE CAST(ROUND(([CollabCareApts]+2) /5,0)*5 AS INT)  END AS [CollabCareApts],
		CASE WHEN [CounselDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CounselDepApts]+2) /5,0)*5 AS INT)  END AS [CounselDepApts],
		CASE WHEN [BPDApts]< 5 THEN NULL ELSE CAST(ROUND(([BPDApts]+2) /5,0)*5 AS INT)  END AS [BPDApts],
		CASE WHEN [EyeMoveDesenReproApts]< 5 THEN NULL ELSE CAST(ROUND(([EyeMoveDesenReproApts]+2) /5,0)*5 AS INT)  END AS [EyeMoveDesenReproApts],
		CASE WHEN [MindfulApts]< 5 THEN NULL ELSE CAST(ROUND(([MindfulApts]+2) /5,0)*5 AS INT)  END AS [MindfulApts],
		CASE WHEN [OtherHIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherHIApts]+2) /5,0)*5 AS INT)  END AS [OtherHIApts],
		CASE WHEN [EmploySuppHIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppHIApts]+2) /5,0)*5 AS INT)  END AS [EmploySuppHIApts],
		CASE WHEN [CBTApts]< 5 THEN NULL ELSE CAST(ROUND(([CBTApts]+2) /5,0)*5 AS INT)  END AS [CBTApts],
		CASE WHEN [IPTApts]< 5 THEN NULL ELSE CAST(ROUND(([IPTApts]+2) /5,0)*5 AS INT)  END AS [IPTApts],
		CASE WHEN [ESApts]< 5 THEN NULL ELSE CAST(ROUND(([ESApts]+2) /5,0)*5 AS INT)  END AS [ESApts],
		CASE WHEN [Signposting]< 5 THEN NULL ELSE CAST(ROUND(([Signposting]+2) /5,0)*5 AS INT)  END AS [Signposting],

		ROUND(CASE WHEN SUM([GuideSelfHelpBookApts])<5 THEN NULL ELSE CAST(SUM([GuideSelfHelpBookApts])AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS GuideSelfHelpBookAptsPROP,

		ROUND(CASE WHEN SUM([NonGuideSelfHelpBookApts])<5 THEN NULL ELSE CAST(SUM([NonGuideSelfHelpBookApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS NonGuideSelfHelpBookAptsPROP,

		ROUND(CASE WHEN SUM([GuideSelfHelpCompApts])<5 THEN NULL ELSE CAST(SUM([GuideSelfHelpCompApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS GuideSelfHelpCompAptsPROP,

		ROUND(CASE WHEN SUM([NonGuideSelfHelpCompApts])<5 THEN NULL ELSE CAST(SUM([NonGuideSelfHelpCompApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS NonGuideSelfHelpCompAptsPROP,

		ROUND(CASE WHEN SUM([BehavActLIApts])<5 THEN NULL ELSE CAST(SUM([BehavActLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS BehavActLIAptsPROP,

		ROUND(CASE WHEN SUM([StructPhysActApts])<5 THEN NULL ELSE CAST(SUM([StructPhysActApts]) AS FLOAT)/ CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS StructPhysActAptsPROP,

		ROUND(CASE WHEN SUM([AntePostNatalCounselApts])<5 THEN NULL ELSE CAST(SUM([AntePostNatalCounselApts]) AS FLOAT)/CAST ((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS AntePostNatalCounselAptsPROP,

		ROUND(CASE WHEN SUM([PsychoEducPeerSuppApts])<5 THEN NULL ELSE CAST(SUM([PsychoEducPeerSuppApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS PsychoEducPeerSuppAptsPROP,

		ROUND(CASE WHEN SUM([OtherLIApts])<5 THEN NULL ELSE CAST(SUM([OtherLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS OtherLIAptsPROP,

		ROUND(CASE WHEN SUM([EmploySuppLIApts])<5 THEN NULL ELSE CAST(SUM([EmploySuppLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS EmploySuppLIAptsPROP,

		ROUND(CASE WHEN SUM([AppRelaxApts])<5 THEN NULL ELSE CAST(SUM([AppRelaxApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS AppRelaxAptsPROP,

		ROUND(CASE WHEN SUM([BehavActHIApts])<5 THEN NULL ELSE CAST(SUM([BehavActHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS BehavActHIAptsPROP,

		ROUND(CASE WHEN SUM([CoupleTherapyDepApts])<5 THEN NULL ELSE CAST(SUM([CoupleTherapyDepApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CoupleTherapyDepAptsPROP,

		ROUND(CASE WHEN SUM([CollabCareApts])<5 THEN NULL ELSE CAST(SUM([CollabCareApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CollabCareAptsPROP,

		ROUND(CASE WHEN SUM([CounselDepApts])<5 THEN NULL ELSE CAST(SUM([CounselDepApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CounselDepAptsPROP,

		ROUND(CASE WHEN SUM([BPDApts])<5 THEN NULL ELSE CAST(SUM([BPDApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS BPDAptsPROP,

		ROUND(CASE WHEN SUM([EyeMoveDesenReproApts])<5 THEN NULL ELSE CAST(SUM([EyeMoveDesenReproApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT)END, 2) AS EyeMoveDesenReproAptsPROP,

		ROUND(CASE WHEN SUM([MindfulApts])<5 THEN NULL ELSE CAST(SUM([MindfulApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS MindfulAptsPROP,

		ROUND(CASE WHEN SUM([OtherHIApts])<5 THEN NULL ELSE CAST(SUM([OtherHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS OtherHIAptsPROP,

		ROUND(CASE WHEN SUM([EmploySuppHIApts])<5 THEN NULL ELSE CAST(SUM([EmploySuppHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS EmploySuppHIAptsPROP,

		ROUND(CASE WHEN SUM([CBTApts])<5 THEN NULL ELSE CAST(SUM([CBTApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CBTAptsPROP,

		ROUND(CASE WHEN SUM([IPTApts])<5 THEN NULL ELSE CAST(SUM([IPTApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS IPTAptsPROP,

		ROUND(CASE WHEN SUM([ESApts])<5 THEN NULL ELSE CAST(SUM([ESApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS ESAptsPROP,

		ROUND(CASE WHEN SUM([Signposting])<5 THEN NULL ELSE CAST(SUM([Signposting]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS SignpostingPROP

FROM	[NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Apps_Primary_Loop]

WHERE	[Category] = 'Total' AND [Month] = @MonthYear

GROUP BY [Month]
		,[CCG Code]
		,[CCG Name]
		,CASE WHEN [GuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [NonGuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [GuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [NonGuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [BehavActLIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActLIApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [StructPhysActApts]< 5 THEN NULL ELSE CAST(ROUND(([StructPhysActApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [AntePostNatalCounselApts]< 5 THEN NULL ELSE CAST(ROUND(([AntePostNatalCounselApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [PsychoEducPeerSuppApts]< 5 THEN NULL ELSE CAST(ROUND(([PsychoEducPeerSuppApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [OtherLIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherLIApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [EmploySuppLIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppLIApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [AppRelaxApts]< 5 THEN NULL ELSE CAST(ROUND(([AppRelaxApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [BehavActHIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActHIApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [CoupleTherapyDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CoupleTherapyDepApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [CollabCareApts]< 5 THEN NULL ELSE CAST(ROUND(([CollabCareApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [CounselDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CounselDepApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [BPDApts]< 5 THEN NULL ELSE CAST(ROUND(([BPDApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [EyeMoveDesenReproApts]< 5 THEN NULL ELSE CAST(ROUND(([EyeMoveDesenReproApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [MindfulApts]< 5 THEN NULL ELSE CAST(ROUND(([MindfulApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [OtherHIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherHIApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [EmploySuppHIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppHIApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [CBTApts]< 5 THEN NULL ELSE CAST(ROUND(([CBTApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [IPTApts]< 5 THEN NULL ELSE CAST(ROUND(([IPTApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [ESApts]< 5 THEN NULL ELSE CAST(ROUND(([ESApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [Signposting]< 5 THEN NULL ELSE CAST(ROUND(([Signposting]+2) /5,0)*5 AS INT)  END

UNION ----------------------------------------------------------------------

SELECT [Month], 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		'Provider' AS 'Level',
		'All' AS 'Region Code',
		'All' AS 'Region Name',
		'All' AS 'CCG Code',
		'All' AS 'CCG Name',
		[Provider Code] AS 'Provider Code',
		[Provider Name] AS 'Provider Name',
		'All' AS 'STP Code',
		'All' AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		CASE WHEN [GuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END AS [GuideSelfHelpBookApts],
		CASE WHEN [NonGuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END AS [NonGuideSelfHelpBookApts],
		CASE WHEN [GuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END AS [GuideSelfHelpCompApts],
		CASE WHEN [NonGuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END AS [NonGuideSelfHelpCompApts],
		CASE WHEN [BehavActLIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActLIApts]+2) /5,0)*5 AS INT)  END AS [BehavActLIApts],
		CASE WHEN [StructPhysActApts]< 5 THEN NULL ELSE CAST(ROUND(([StructPhysActApts]+2) /5,0)*5 AS INT)  END AS [StructPhysActApts],
		CASE WHEN [AntePostNatalCounselApts]< 5 THEN NULL ELSE CAST(ROUND(([AntePostNatalCounselApts]+2) /5,0)*5 AS INT)  END AS [AntePostNatalCounselApts],
		CASE WHEN [PsychoEducPeerSuppApts]< 5 THEN NULL ELSE CAST(ROUND(([PsychoEducPeerSuppApts]+2) /5,0)*5 AS INT)  END AS [PsychoEducPeerSuppApts],
		CASE WHEN [OtherLIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherLIApts]+2) /5,0)*5 AS INT)  END AS [OtherLIApts],
		CASE WHEN [EmploySuppLIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppLIApts]+2) /5,0)*5 AS INT)  END AS [EmploySuppLIApts],
		CASE WHEN [AppRelaxApts]< 5 THEN NULL ELSE CAST(ROUND(([AppRelaxApts]+2) /5,0)*5 AS INT)  END AS [AppRelaxApts],
		CASE WHEN [BehavActHIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActHIApts]+2) /5,0)*5 AS INT)  END AS [BehavActHIApts],
		CASE WHEN [CoupleTherapyDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CoupleTherapyDepApts]+2) /5,0)*5 AS INT)  END AS [CoupleTherapyDepApts],
		CASE WHEN [CollabCareApts]< 5 THEN NULL ELSE CAST(ROUND(([CollabCareApts]+2) /5,0)*5 AS INT)  END AS [CollabCareApts],
		CASE WHEN [CounselDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CounselDepApts]+2) /5,0)*5 AS INT)  END AS [CounselDepApts],
		CASE WHEN [BPDApts]< 5 THEN NULL ELSE CAST(ROUND(([BPDApts]+2) /5,0)*5 AS INT)  END AS [BPDApts],
		CASE WHEN [EyeMoveDesenReproApts]< 5 THEN NULL ELSE CAST(ROUND(([EyeMoveDesenReproApts]+2) /5,0)*5 AS INT)  END AS [EyeMoveDesenReproApts],
		CASE WHEN [MindfulApts]< 5 THEN NULL ELSE CAST(ROUND(([MindfulApts]+2) /5,0)*5 AS INT)  END AS [MindfulApts],
		CASE WHEN [OtherHIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherHIApts]+2) /5,0)*5 AS INT)  END AS [OtherHIApts],
		CASE WHEN [EmploySuppHIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppHIApts]+2) /5,0)*5 AS INT)  END AS [EmploySuppHIApts],
		CASE WHEN [CBTApts]< 5 THEN NULL ELSE CAST(ROUND(([CBTApts]+2) /5,0)*5 AS INT)  END AS [CBTApts],
		CASE WHEN [IPTApts]< 5 THEN NULL ELSE CAST(ROUND(([IPTApts]+2) /5,0)*5 AS INT)  END AS [IPTApts],
		CASE WHEN [ESApts]< 5 THEN NULL ELSE CAST(ROUND(([ESApts]+2) /5,0)*5 AS INT)  END AS [ESApts],
		CASE WHEN [Signposting]< 5 THEN NULL ELSE CAST(ROUND(([Signposting]+2) /5,0)*5 AS INT)  END AS [Signposting],

		ROUND(CASE WHEN SUM([GuideSelfHelpBookApts])<5 THEN NULL ELSE CAST(SUM([GuideSelfHelpBookApts])AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS GuideSelfHelpBookAptsPROP,

		ROUND(CASE WHEN SUM([NonGuideSelfHelpBookApts])<5 THEN NULL ELSE CAST(SUM([NonGuideSelfHelpBookApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS NonGuideSelfHelpBookAptsPROP,

		ROUND(CASE WHEN SUM([GuideSelfHelpCompApts])<5 THEN NULL ELSE CAST(SUM([GuideSelfHelpCompApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS GuideSelfHelpCompAptsPROP,

		ROUND(CASE WHEN SUM([NonGuideSelfHelpCompApts])<5 THEN NULL ELSE CAST(SUM([NonGuideSelfHelpCompApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS NonGuideSelfHelpCompAptsPROP,

		ROUND(CASE WHEN SUM([BehavActLIApts])<5 THEN NULL ELSE CAST(SUM([BehavActLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS BehavActLIAptsPROP,

		ROUND(CASE WHEN SUM([StructPhysActApts])<5 THEN NULL ELSE CAST(SUM([StructPhysActApts]) AS FLOAT)/ CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS StructPhysActAptsPROP,

		ROUND(CASE WHEN SUM([AntePostNatalCounselApts])<5 THEN NULL ELSE CAST(SUM([AntePostNatalCounselApts]) AS FLOAT)/CAST ((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS AntePostNatalCounselAptsPROP,

		ROUND(CASE WHEN SUM([PsychoEducPeerSuppApts])<5 THEN NULL ELSE CAST(SUM([PsychoEducPeerSuppApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS PsychoEducPeerSuppAptsPROP,

		ROUND(CASE WHEN SUM([OtherLIApts])<5 THEN NULL ELSE CAST(SUM([OtherLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS OtherLIAptsPROP,

		ROUND(CASE WHEN SUM([EmploySuppLIApts])<5 THEN NULL ELSE CAST(SUM([EmploySuppLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS EmploySuppLIAptsPROP,

		ROUND(CASE WHEN SUM([AppRelaxApts])<5 THEN NULL ELSE CAST(SUM([AppRelaxApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS AppRelaxAptsPROP,

		ROUND(CASE WHEN SUM([BehavActHIApts])<5 THEN NULL ELSE CAST(SUM([BehavActHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS BehavActHIAptsPROP,

		ROUND(CASE WHEN SUM([CoupleTherapyDepApts])<5 THEN NULL ELSE CAST(SUM([CoupleTherapyDepApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CoupleTherapyDepAptsPROP,

		ROUND(CASE WHEN SUM([CollabCareApts])<5 THEN NULL ELSE CAST(SUM([CollabCareApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CollabCareAptsPROP,

		ROUND(CASE WHEN SUM([CounselDepApts])<5 THEN NULL ELSE CAST(SUM([CounselDepApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CounselDepAptsPROP,

		ROUND(CASE WHEN SUM([BPDApts])<5 THEN NULL ELSE CAST(SUM([BPDApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS BPDAptsPROP,

		ROUND(CASE WHEN SUM([EyeMoveDesenReproApts])<5 THEN NULL ELSE CAST(SUM([EyeMoveDesenReproApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT)END, 2) AS EyeMoveDesenReproAptsPROP,

		ROUND(CASE WHEN SUM([MindfulApts])<5 THEN NULL ELSE CAST(SUM([MindfulApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS MindfulAptsPROP,

		ROUND(CASE WHEN SUM([OtherHIApts])<5 THEN NULL ELSE CAST(SUM([OtherHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS OtherHIAptsPROP,

		ROUND(CASE WHEN SUM([EmploySuppHIApts])<5 THEN NULL ELSE CAST(SUM([EmploySuppHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS EmploySuppHIAptsPROP,

		ROUND(CASE WHEN SUM([CBTApts])<5 THEN NULL ELSE CAST(SUM([CBTApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CBTAptsPROP,

		ROUND(CASE WHEN SUM([IPTApts])<5 THEN NULL ELSE CAST(SUM([IPTApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS IPTAptsPROP,

		ROUND(CASE WHEN SUM([ESApts])<5 THEN NULL ELSE CAST(SUM([ESApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS ESAptsPROP,

		ROUND(CASE WHEN SUM([Signposting])<5 THEN NULL ELSE CAST(SUM([Signposting]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS SignpostingPROP

FROM [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Apps_Primary_Loop]

WHERE [Category] = 'Total' AND [Month] = @MonthYear

GROUP BY [Month]
		,[Provider Code]
		,[Provider Name]
		,CASE WHEN [GuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [NonGuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [GuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [NonGuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [BehavActLIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActLIApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [StructPhysActApts]< 5 THEN NULL ELSE CAST(ROUND(([StructPhysActApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [AntePostNatalCounselApts]< 5 THEN NULL ELSE CAST(ROUND(([AntePostNatalCounselApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [PsychoEducPeerSuppApts]< 5 THEN NULL ELSE CAST(ROUND(([PsychoEducPeerSuppApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [OtherLIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherLIApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [EmploySuppLIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppLIApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [AppRelaxApts]< 5 THEN NULL ELSE CAST(ROUND(([AppRelaxApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [BehavActHIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActHIApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [CoupleTherapyDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CoupleTherapyDepApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [CollabCareApts]< 5 THEN NULL ELSE CAST(ROUND(([CollabCareApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [CounselDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CounselDepApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [BPDApts]< 5 THEN NULL ELSE CAST(ROUND(([BPDApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [EyeMoveDesenReproApts]< 5 THEN NULL ELSE CAST(ROUND(([EyeMoveDesenReproApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [MindfulApts]< 5 THEN NULL ELSE CAST(ROUND(([MindfulApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [OtherHIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherHIApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [EmploySuppHIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppHIApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [CBTApts]< 5 THEN NULL ELSE CAST(ROUND(([CBTApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [IPTApts]< 5 THEN NULL ELSE CAST(ROUND(([IPTApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [ESApts]< 5 THEN NULL ELSE CAST(ROUND(([ESApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [Signposting]< 5 THEN NULL ELSE CAST(ROUND(([Signposting]+2) /5,0)*5 AS INT)  END

UNION -------------------------------------------------------------

SELECT [Month], 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		'CCG/ Provider' AS 'Level',
		'All' AS 'Region Code',
		'All' AS 'Region Name',
		[CCG Code] AS 'CCG Code',
		[CCG Name] AS 'CCG Name',
		[Provider Code] AS 'Provider Code',
		[Provider Name] AS 'Provider Name',
		'All' AS 'STP Code',
		'All' AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		CASE WHEN [GuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END AS [GuideSelfHelpBookApts],
		CASE WHEN [NonGuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END AS [NonGuideSelfHelpBookApts],
		CASE WHEN [GuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END AS [GuideSelfHelpCompApts],
		CASE WHEN [NonGuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END AS [NonGuideSelfHelpCompApts],
		CASE WHEN [BehavActLIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActLIApts]+2) /5,0)*5 AS INT)  END AS [BehavActLIApts],
		CASE WHEN [StructPhysActApts]< 5 THEN NULL ELSE CAST(ROUND(([StructPhysActApts]+2) /5,0)*5 AS INT)  END AS [StructPhysActApts],
		CASE WHEN [AntePostNatalCounselApts]< 5 THEN NULL ELSE CAST(ROUND(([AntePostNatalCounselApts]+2) /5,0)*5 AS INT)  END AS [AntePostNatalCounselApts],
		CASE WHEN [PsychoEducPeerSuppApts]< 5 THEN NULL ELSE CAST(ROUND(([PsychoEducPeerSuppApts]+2) /5,0)*5 AS INT)  END AS [PsychoEducPeerSuppApts],
		CASE WHEN [OtherLIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherLIApts]+2) /5,0)*5 AS INT)  END AS [OtherLIApts],
		CASE WHEN [EmploySuppLIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppLIApts]+2) /5,0)*5 AS INT)  END AS [EmploySuppLIApts],
		CASE WHEN [AppRelaxApts]< 5 THEN NULL ELSE CAST(ROUND(([AppRelaxApts]+2) /5,0)*5 AS INT)  END AS [AppRelaxApts],
		CASE WHEN [BehavActHIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActHIApts]+2) /5,0)*5 AS INT)  END AS [BehavActHIApts],
		CASE WHEN [CoupleTherapyDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CoupleTherapyDepApts]+2) /5,0)*5 AS INT)  END AS [CoupleTherapyDepApts],
		CASE WHEN [CollabCareApts]< 5 THEN NULL ELSE CAST(ROUND(([CollabCareApts]+2) /5,0)*5 AS INT)  END AS [CollabCareApts],
		CASE WHEN [CounselDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CounselDepApts]+2) /5,0)*5 AS INT)  END AS [CounselDepApts],
		CASE WHEN [BPDApts]< 5 THEN NULL ELSE CAST(ROUND(([BPDApts]+2) /5,0)*5 AS INT)  END AS [BPDApts],
		CASE WHEN [EyeMoveDesenReproApts]< 5 THEN NULL ELSE CAST(ROUND(([EyeMoveDesenReproApts]+2) /5,0)*5 AS INT)  END AS [EyeMoveDesenReproApts],
		CASE WHEN [MindfulApts]< 5 THEN NULL ELSE CAST(ROUND(([MindfulApts]+2) /5,0)*5 AS INT)  END AS [MindfulApts],
		CASE WHEN [OtherHIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherHIApts]+2) /5,0)*5 AS INT)  END AS [OtherHIApts],
		CASE WHEN [EmploySuppHIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppHIApts]+2) /5,0)*5 AS INT)  END AS [EmploySuppHIApts],
		CASE WHEN [CBTApts]< 5 THEN NULL ELSE CAST(ROUND(([CBTApts]+2) /5,0)*5 AS INT)  END AS [CBTApts],
		CASE WHEN [IPTApts]< 5 THEN NULL ELSE CAST(ROUND(([IPTApts]+2) /5,0)*5 AS INT)  END AS [IPTApts],
		CASE WHEN [ESApts]< 5 THEN NULL ELSE CAST(ROUND(([ESApts]+2) /5,0)*5 AS INT)  END AS [ESApts],
		CASE WHEN [Signposting]< 5 THEN NULL ELSE CAST(ROUND(([Signposting]+2) /5,0)*5 AS INT)  END AS [Signposting],

		ROUND(CASE WHEN SUM([GuideSelfHelpBookApts])<5 THEN NULL ELSE CAST(SUM([GuideSelfHelpBookApts])AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS GuideSelfHelpBookAptsPROP,

		ROUND(CASE WHEN SUM([NonGuideSelfHelpBookApts])<5 THEN NULL ELSE CAST(SUM([NonGuideSelfHelpBookApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS NonGuideSelfHelpBookAptsPROP,

		ROUND(CASE WHEN SUM([GuideSelfHelpCompApts])<5 THEN NULL ELSE CAST(SUM([GuideSelfHelpCompApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS GuideSelfHelpCompAptsPROP,

		ROUND(CASE WHEN SUM([NonGuideSelfHelpCompApts])<5 THEN NULL ELSE CAST(SUM([NonGuideSelfHelpCompApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS NonGuideSelfHelpCompAptsPROP,

		ROUND(CASE WHEN SUM([BehavActLIApts])<5 THEN NULL ELSE CAST(SUM([BehavActLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS BehavActLIAptsPROP,

		ROUND(CASE WHEN SUM([StructPhysActApts])<5 THEN NULL ELSE CAST(SUM([StructPhysActApts]) AS FLOAT)/ CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS StructPhysActAptsPROP,

		ROUND(CASE WHEN SUM([AntePostNatalCounselApts])<5 THEN NULL ELSE CAST(SUM([AntePostNatalCounselApts]) AS FLOAT)/CAST ((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS AntePostNatalCounselAptsPROP,

		ROUND(CASE WHEN SUM([PsychoEducPeerSuppApts])<5 THEN NULL ELSE CAST(SUM([PsychoEducPeerSuppApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS PsychoEducPeerSuppAptsPROP,

		ROUND(CASE WHEN SUM([OtherLIApts])<5 THEN NULL ELSE CAST(SUM([OtherLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS OtherLIAptsPROP,

		ROUND(CASE WHEN SUM([EmploySuppLIApts])<5 THEN NULL ELSE CAST(SUM([EmploySuppLIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS EmploySuppLIAptsPROP,

		ROUND(CASE WHEN SUM([AppRelaxApts])<5 THEN NULL ELSE CAST(SUM([AppRelaxApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS AppRelaxAptsPROP,

		ROUND(CASE WHEN SUM([BehavActHIApts])<5 THEN NULL ELSE CAST(SUM([BehavActHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS BehavActHIAptsPROP,

		ROUND(CASE WHEN SUM([CoupleTherapyDepApts])<5 THEN NULL ELSE CAST(SUM([CoupleTherapyDepApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CoupleTherapyDepAptsPROP,

		ROUND(CASE WHEN SUM([CollabCareApts])<5 THEN NULL ELSE CAST(SUM([CollabCareApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CollabCareAptsPROP,

		ROUND(CASE WHEN SUM([CounselDepApts])<5 THEN NULL ELSE CAST(SUM([CounselDepApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CounselDepAptsPROP,

		ROUND(CASE WHEN SUM([BPDApts])<5 THEN NULL ELSE CAST(SUM([BPDApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS BPDAptsPROP,

		ROUND(CASE WHEN SUM([EyeMoveDesenReproApts])<5 THEN NULL ELSE CAST(SUM([EyeMoveDesenReproApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT)END, 2) AS EyeMoveDesenReproAptsPROP,

		ROUND(CASE WHEN SUM([MindfulApts])<5 THEN NULL ELSE CAST(SUM([MindfulApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS MindfulAptsPROP,

		ROUND(CASE WHEN SUM([OtherHIApts])<5 THEN NULL ELSE CAST(SUM([OtherHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS OtherHIAptsPROP,

		ROUND(CASE WHEN SUM([EmploySuppHIApts])<5 THEN NULL ELSE CAST(SUM([EmploySuppHIApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS EmploySuppHIAptsPROP,

		ROUND(CASE WHEN SUM([CBTApts])<5 THEN NULL ELSE CAST(SUM([CBTApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS CBTAptsPROP,

		ROUND(CASE WHEN SUM([IPTApts])<5 THEN NULL ELSE CAST(SUM([IPTApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS IPTAptsPROP,

		ROUND(CASE WHEN SUM([ESApts])<5 THEN NULL ELSE CAST(SUM([ESApts]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS ESAptsPROP,

		ROUND(CASE WHEN SUM([Signposting])<5 THEN NULL ELSE CAST(SUM([Signposting]) AS FLOAT)/CAST((SUM([GuideSelfHelpBookApts])+SUM([NonGuideSelfHelpBookApts])+SUM([GuideSelfHelpCompApts])
		+SUM([NonGuideSelfHelpCompApts])+SUM([BehavActLIApts])+SUM([StructPhysActApts])+SUM([AntePostNatalCounselApts])+SUM([PsychoEducPeerSuppApts])+
		SUM([OtherLIApts])+SUM([EmploySuppLIApts])+SUM([AppRelaxApts])+SUM([BehavActHIApts])+SUM([CoupleTherapyDepApts])+SUM([CollabCareApts])+SUM([CounselDepApts])+SUM([BPDApts])
		+SUM([EyeMoveDesenReproApts])+SUM([MindfulApts])+SUM([OtherHIApts])+SUM([EmploySuppHIApts])+SUM([CBTApts])+SUM([IPTApts])+SUM([ESApts])+SUM([Signposting])) AS FLOAT) END, 2) AS SignpostingPROP

FROM [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Apps_Primary_Loop]

WHERE [Category] = 'Total' AND [Month] = @MonthYear

GROUP BY [Month]
		,[CCG Code]
		,[CCG Name]
		,[Provider Code]
		,[Provider Name]
		,CASE WHEN [GuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [NonGuideSelfHelpBookApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpBookApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [GuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([GuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [NonGuideSelfHelpCompApts]< 5 THEN NULL ELSE CAST(ROUND(([NonGuideSelfHelpCompApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [BehavActLIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActLIApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [StructPhysActApts]< 5 THEN NULL ELSE CAST(ROUND(([StructPhysActApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [AntePostNatalCounselApts]< 5 THEN NULL ELSE CAST(ROUND(([AntePostNatalCounselApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [PsychoEducPeerSuppApts]< 5 THEN NULL ELSE CAST(ROUND(([PsychoEducPeerSuppApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [OtherLIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherLIApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [EmploySuppLIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppLIApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [AppRelaxApts]< 5 THEN NULL ELSE CAST(ROUND(([AppRelaxApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [BehavActHIApts]< 5 THEN NULL ELSE CAST(ROUND(([BehavActHIApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [CoupleTherapyDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CoupleTherapyDepApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [CollabCareApts]< 5 THEN NULL ELSE CAST(ROUND(([CollabCareApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [CounselDepApts]< 5 THEN NULL ELSE CAST(ROUND(([CounselDepApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [BPDApts]< 5 THEN NULL ELSE CAST(ROUND(([BPDApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [EyeMoveDesenReproApts]< 5 THEN NULL ELSE CAST(ROUND(([EyeMoveDesenReproApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [MindfulApts]< 5 THEN NULL ELSE CAST(ROUND(([MindfulApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [OtherHIApts]< 5 THEN NULL ELSE CAST(ROUND(([OtherHIApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [EmploySuppHIApts]< 5 THEN NULL ELSE CAST(ROUND(([EmploySuppHIApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [CBTApts]< 5 THEN NULL ELSE CAST(ROUND(([CBTApts]+2) /5,0)*5 AS INT)  END ,
		CASE WHEN [IPTApts]< 5 THEN NULL ELSE CAST(ROUND(([IPTApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [ESApts]< 5 THEN NULL ELSE CAST(ROUND(([ESApts]+2) /5,0)*5 AS INT)  END,
		CASE WHEN [Signposting]< 5 THEN NULL ELSE CAST(ROUND(([Signposting]+2) /5,0)*5 AS INT)  END
		
)_

---------------------------------------------------------------------------------------------------------
PRINT 'Updated - [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Appointment_Types_Totals]'

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Region_Monthly_Test_2_Rounded] ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Region_Monthly_Test_2_Rounded]

SELECT	Month, 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		'All' AS 'Region Code',
		'All' AS 'Region Name',
		'All' AS 'CCG Code',
		'All' AS 'CCG Name',
		'All' AS 'Provider Code',
		'All' AS 'Provider Name',
		'All' AS 'STP Code',
		'All' AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		SUM([OpenReferralLessThan61DaysNoContact]) AS 'OpenReferralLessThan61DaysNoContact',
		SUM([OpenReferral61-90DaysNoContact]) AS 'OpenReferral61-90DaysNoContact',
		SUM([OpenReferral91-120DaysNoContact]) AS 'OpenReferral91-120DaysNoContact',
		SUM([OpenReferral]) AS 'OpenReferral',
		SUM([Ended Treatment]) AS 'Ended Treatment',
		SUM([Finished Treatment - 2 or more Apps]) AS 'Finished Treatment - 2 or more Apps',
		SUM([Referrals]) AS 'Referrals',
		SUM([EnteringTreatment]) AS 'EnteringTreatment',
		SUM([Waiting for Assessment]) AS 'Waiting for Assessment',
		SUM([WaitingForAssessmentOver90Days]) AS 'WaitingForAssessmentOver90Days',
		SUM([FirstAssessment28Days]) AS 'FirstAssessment28Days',
		SUM([FirstAssessment29to56Days]) AS 'FirstAssessment29to56Days',
		SUM([FirstAssessment57to90Days]) AS 'FirstAssessment57to90Days',
		SUM([FirstAssessmentOver90Days]) AS 'FirstAssessmentOver90Days',
		SUM([FirstTreatment28days]) AS 'FirstTreatment28days',
		SUM([FirstTreatment29to56days]) AS 'FirstTreatment29to56days',
		SUM([FirstTreatment57to90days]) AS 'FirstTreatment57to90days',
		SUM([FirstTreatmentOver90days]) AS 'FirstTreatmentOver90days',
		SUM([Ended Referral]) AS 'Ended Referral',
		SUM([Ended Not Suitable]) AS 'Ended Not Suitable',
		SUM([Ended Signposted]) AS 'Ended Signposted',
		SUM([Ended Mutual Agreement]) AS 'Ended Mutual Agreement',
		SUM([Ended Referred Elsewhere]) AS 'Ended Referred Elsewhere',
		SUM([Ended Declined]) AS 'Ended Declined',
		SUM([Ended Deceased Assessed Only]) AS 'Ended Deceased Assessed Only',
		SUM([Ended Unknown Assessed Only]) AS 'Ended Unknown Assessed Only',
		SUM([Ended Stepped Up]) AS 'Ended Stepped Up',
		SUM([Ended Stepped Down]) AS 'Ended Stepped Down',
		SUM([Ended Completed]) AS 'Ended Completed',
		SUM([Ended Dropped Out]) AS 'Ended Dropped Out',
		SUM([Ended Referred Non IAPT]) AS 'Ended Referred Non IAPT',
		SUM([Ended Deceased Treated]) AS 'Ended Deceased Treated',
		SUM([Ended Unknown Treated]) AS 'Ended Unknown Treated',
		SUM([Ended Invalid]) AS 'Ended Invalid',
		SUM([Ended No Reason Recorded]) AS 'Ended No Reason Recorded',
		SUM([Ended Seen Not Treated]) AS 'Ended Seen Not Treated',
		SUM([Ended Treated Once]) AS 'Ended Treated Once',
		SUM([Ended Not Seen]) AS 'Ended Not Seen',
		SUM([Recovery]) AS 'Recovery',
		SUM([Reliable Recovery]) AS 'Reliable Recovery',
		SUM([No Change]) AS 'No Change',
		SUM([Reliable Deterioration]) AS 'Reliable Deterioration',
		SUM([Reliable Improvement]) AS 'Reliable Improvement',
		SUM([NotCaseness]) AS 'NotCaseness',
		SUM([ADSMFinishedTreatment]) AS 'ADSMFinishedTreatment',
		SUM([CountAppropriatePairedADSM]) AS 'CountAppropriatePairedADSM',
		SUM([SelfReferral]) AS 'SelfReferral',
		SUM([GPReferral]) AS 'GPReferral',
		SUM([OtherReferral]) AS 'OtherReferral',
		SUM([FirstToSecond28Days]) AS 'FirstToSecond28Days',
		SUM([FirstToSecond28To56Days]) AS 'FirstToSecond28To56Days',
		SUM([FirstToSecond57To90Days]) AS 'FirstToSecond57To90Days',
		SUM([FirstToSecondMoreThan90Days]) AS 'FirstToSecondMoreThan90Days',
		SUM([Ended Not Assessed]) AS 'Ended Not Assessed',
		SUM([Ended Incomplete Assessment]) AS 'Ended Incomplete Assessment',
		SUM([Ended Deceased (Seen but not taken on for a course of treatment)]) AS 'Ended Deceased (Seen but not taken on for a course of treatment)',
		SUM([Ended Not Known (Seen but not taken on for a course of treatment)]) AS 'Ended Not Known (Seen but not taken on for a course of treatment)',
		SUM([Ended Mutually agreed completion of treatment]) AS 'Ended Mutually agreed completion of treatment',
		SUM([Ended Termination of treatment earlier than Care Professional planned]) AS 'Ended Termination of treatment earlier than Care Professional planned',
		SUM([Ended Termination of treatment earlier than patient requested]) AS 'Ended Termination of treatment earlier than patient requested',
		SUM([Ended Deceased (Seen and taken on for a course of treatment)]) AS 'Ended Deceased (Seen and taken on for a course of treatment)',
		SUM([Ended Not Known (Seen and taken on for a course of treatment)]) AS 'Ended Not Known (Seen and taken on for a course of treatment)',
		NULL AS 'RepeatReferrals',
		SUM([RepeatReferrals2]) AS 'RepeatReferrals2',
		'National' AS 'Level'

FROM	[NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_Region_test_2]

WHERE	Category = 'Total' AND Month = @MonthYear

GROUP BY Month

UNION -------------------------------------------------------------------------------------------------

SELECT	Month, 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		[Region Code] AS 'Region Code',
		[Region Name] AS 'Region Name',
		'All' AS 'CCG Code',
		'All' AS 'CCG Name',
		'All' AS 'Provider Code',
		'All' AS 'Provider Name',
		'All' AS 'STP Code',
		'All' AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		CASE WHEN SUM(OpenReferralLessThan61DaysNoContact)< 5 THEN NULL ELSE CAST(ROUND((SUM(OpenReferralLessThan61DaysNoContact)+2) /5,0)*5 AS INT)  END AS OpenReferralLessThan61DaysNoContact,
		CASE WHEN SUM([OpenReferral61-90DaysNoContact])< 5 THEN NULL ELSE CAST(ROUND((SUM([OpenReferral61-90DaysNoContact])+2) /5,0)*5 AS INT)  END AS [OpenReferral61-90DaysNoContact],
		CASE WHEN SUM([OpenReferral91-120DaysNoContact])< 5 THEN NULL ELSE CAST(ROUND((SUM([OpenReferral91-120DaysNoContact])+2) /5,0)*5 AS INT)  END AS [OpenReferral91-120DaysNoContact],
		CASE WHEN SUM([OpenReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([OpenReferral])+2) /5,0)*5 AS INT)  END AS [OpenReferral],
		CASE WHEN SUM([Ended Treatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Treatment])+2) /5,0)*5 AS INT)  END AS [Ended Treatment],
		CASE WHEN SUM([Finished Treatment - 2 or more Apps])< 5 THEN NULL ELSE CAST(ROUND((SUM([Finished Treatment - 2 or more Apps])+2) /5,0)*5 AS INT)  END AS [Finished Treatment - 2 or more Apps],
		CASE WHEN SUM([Referrals])< 5 THEN NULL ELSE CAST(ROUND((SUM([Referrals])+2) /5,0)*5 AS INT)  END AS [Referrals],
		CASE WHEN SUM([EnteringTreatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([EnteringTreatment])+2) /5,0)*5 AS INT)  END AS [EnteringTreatment],
		CASE WHEN SUM([Waiting for Assessment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Waiting for Assessment])+2) /5,0)*5 AS INT)  END AS [Waiting for Assessment],
		CASE WHEN SUM([WaitingForAssessmentOver90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([WaitingForAssessmentOver90days])+2) /5,0)*5 AS INT)  END AS [WaitingForAssessmentOver90Days],
		CASE WHEN SUM(FirstAssessment28days)< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessment28days])+2) /5,0)*5 AS INT)  END AS [FirstAssessment28Days],
		CASE WHEN SUM([FirstAssessment29to56days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessment29to56days])+2) /5,0)*5 AS INT)  END AS [FirstAssessment29to56Days],
		CASE WHEN SUM([FirstAssessment57to90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessment57to90days])+2) /5,0)*5 AS INT)  END AS [FirstAssessment57to90Days],
		CASE WHEN SUM([FirstAssessmentOver90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessmentOver90days])+2) /5,0)*5 AS INT)  END AS [FirstAssessmentOver90Days],
		CASE WHEN SUM([FirstTreatment28days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatment28days])+2) /5,0)*5 AS INT)  END AS [FirstTreatment28days],
		CASE WHEN SUM([FirstTreatment29to56days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatment29to56days])+2) /5,0)*5 AS INT)  END AS [FirstTreatment29to56days],
		CASE WHEN SUM([FirstTreatment57to90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatment57to90days])+2) /5,0)*5 AS INT)  END AS [FirstTreatment57to90days],
		CASE WHEN SUM([FirstTreatmentOver90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatmentOver90days])+2) /5,0)*5 AS INT)  END AS [FirstTreatmentOver90days],
		CASE WHEN SUM([Ended Referral])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Referral])+2) /5,0)*5 AS INT)  END AS [Ended Referral],
		CASE WHEN SUM([Ended Not Suitable])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Suitable])+2) /5,0)*5 AS INT)  END AS [Ended Not Suitable],
		CASE WHEN SUM([Ended Signposted])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Signposted])+2) /5,0)*5 AS INT)  END AS [Ended Signposted],
		CASE WHEN SUM([Ended Mutual Agreement])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Mutual Agreement])+2) /5,0)*5 AS INT)  END AS [Ended Mutual Agreement],
		CASE WHEN SUM([Ended Referred Elsewhere])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Referred Elsewhere])+2) /5,0)*5 AS INT)  END AS [Ended Referred Elsewhere],
		CASE WHEN SUM([Ended Declined])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Declined])+2) /5,0)*5 AS INT)  END AS [Ended Declined],
		CASE WHEN SUM([Ended Deceased Assessed Only])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased Assessed Only])+2) /5,0)*5 AS INT)  END AS [Ended Deceased Assessed Only],
		CASE WHEN SUM([Ended Unknown Assessed Only])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Unknown Assessed Only])+2) /5,0)*5 AS INT)  END AS [Ended Unknown Assessed Only],
		CASE WHEN SUM([Ended Stepped Up])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Stepped Up])+2) /5,0)*5 AS INT)  END AS [Ended Stepped Up],
		CASE WHEN SUM([Ended Stepped Down])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Stepped Down])+2) /5,0)*5 AS INT)  END AS [Ended Stepped Down],
		CASE WHEN SUM([Ended Completed])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Completed])+2) /5,0)*5 AS INT)  END AS [Ended Completed],
		CASE WHEN SUM([Ended Dropped Out])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Dropped Out])+2) /5,0)*5 AS INT)  END AS [Ended Dropped Out],
		CASE WHEN SUM([Ended Referred Non IAPT])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Referred Non IAPT])+2) /5,0)*5 AS INT)  END AS [Ended Referred Non IAPT],
		CASE WHEN SUM([Ended Deceased Treated])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased Treated])+2) /5,0)*5 AS INT)  END AS [Ended Deceased Treated],
		CASE WHEN SUM([Ended Unknown Treated])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Unknown Treated])+2) /5,0)*5 AS INT)  END AS [Ended Unknown Treated],
		CASE WHEN SUM([Ended Invalid])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Invalid])+2) /5,0)*5 AS INT)  END AS [Ended Invalid],
		CASE WHEN SUM([Ended No Reason Recorded])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended No Reason Recorded])+2) /5,0)*5 AS INT)  END AS [Ended No Reason Recorded],
		CASE WHEN SUM([Ended Seen Not Treated])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Seen Not Treated])+2) /5,0)*5 AS INT)  END AS [Ended Seen Not Treated],
		CASE WHEN SUM([Ended Treated Once])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Treated Once])+2) /5,0)*5 AS INT)  END AS [Ended Treated Once],
		CASE WHEN SUM([Ended Not Seen])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Seen])+2) /5,0)*5 AS INT)  END AS [Ended Not Seen],
		CASE WHEN SUM([Recovery])< 5 THEN NULL ELSE CAST(ROUND((SUM([Recovery])+2) /5,0)*5 AS INT)  END AS [Recovery],
		CASE WHEN SUM([Reliable Recovery])< 5 THEN NULL ELSE CAST(ROUND((SUM([Reliable Recovery])+2) /5,0)*5 AS INT)  END AS [Reliable Recovery],
		CASE WHEN SUM([No Change])< 5 THEN NULL ELSE CAST(ROUND((SUM([No Change])+2) /5,0)*5 AS INT)  END AS [No Change],
		CASE WHEN SUM([Reliable Deterioration])< 5 THEN NULL ELSE CAST(ROUND((SUM([Reliable Deterioration])+2) /5,0)*5 AS INT)  END AS [Reliable Deterioration],
		CASE WHEN SUM([Reliable Improvement])< 5 THEN NULL ELSE CAST(ROUND((SUM([Reliable Improvement])+2) /5,0)*5 AS INT)  END AS [Reliable Improvement],
		CASE WHEN SUM([NotCaseness])< 5 THEN NULL ELSE CAST(ROUND((SUM([NotCaseness])+2) /5,0)*5 AS INT)  END AS [NotCaseness],
		CASE WHEN SUM([ADSMFinishedTreatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([ADSMFinishedTreatment])+2) /5,0)*5 AS INT)  END AS [ADSMFinishedTreatment],
		CASE WHEN SUM([CountAppropriatePairedADSM])< 5 THEN NULL ELSE CAST(ROUND((SUM([CountAppropriatePairedADSM])+2) /5,0)*5 AS INT)  END AS [CountAppropriatePairedADSM],
		CASE WHEN SUM([SelfReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([SelfReferral])+2) /5,0)*5 AS INT)  END AS [SelfReferral],
		CASE WHEN SUM([GPReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([GPReferral])+2) /5,0)*5 AS INT)  END AS [GPReferral],
		CASE WHEN SUM([OtherReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([OtherReferral])+2) /5,0)*5 AS INT)  END AS [OtherReferral],
		CASE WHEN SUM([FirstToSecond28Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecond28Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecond28Days],
		CASE WHEN SUM([FirstToSecond28To56Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecond28To56Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecond28To56Days],
		CASE WHEN SUM([FirstToSecond57To90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecond57To90Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecond57To90Days],
		CASE WHEN SUM([FirstToSecondMoreThan90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecondMoreThan90Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecondMoreThan90Days],
		CASE WHEN SUM([Ended Not Assessed])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Assessed])+2) /5,0)*5 AS INT)  END AS [Ended Not Assessed],
		CASE WHEN SUM([Ended Incomplete Assessment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Incomplete Assessment])+2) /5,0)*5 AS INT)  END AS [Ended Incomplete Assessment],
		CASE WHEN SUM([Ended Deceased (Seen but not taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased (Seen but not taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS 'Ended Deceased (Seen but not taken on for a course of treatment)',
		CASE WHEN SUM([Ended Not Known (Seen but not taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Known (Seen but not taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS 'Ended Not Known (Seen but not taken on for a course of treatment)',
		CASE WHEN SUM([Ended Mutually agreed completion of treatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Mutually agreed completion of treatment])+2) /5,0)*5 AS INT)  END AS [Ended Mutually agreed completion of treatment],
		CASE WHEN SUM([Ended Termination of treatment earlier than Care Professional planned])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Termination of treatment earlier than Care Professional planned])+2) /5,0)*5 AS INT)  END AS 'Ended Termination of treatment earlier than Care Professional planned',
		CASE WHEN SUM([Ended Termination of treatment earlier than patient requested])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Termination of treatment earlier than patient requested])+2) /5,0)*5 AS INT)  END AS [Ended Termination of treatment earlier than patient requested],
		CASE WHEN SUM([Ended Deceased (Seen and taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased (Seen and taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS [Ended Deceased (Seen and taken on for a course of treatment)],
		CASE WHEN SUM([Ended Not Known (Seen and taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Known (Seen and taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS [Ended Not Known (Seen and taken on for a course of treatment)],
		NULL AS RepeatReferrals,
		CASE WHEN SUM([RepeatReferrals2])< 5 THEN NULL ELSE CAST(ROUND((SUM([RepeatReferrals2])+2) /5,0)*5 AS INT)  END AS [RepeatReferrals2],
		'Region' AS 'Level'

FROM	[NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_Region_test_2]

WHERE	Category = 'Total' AND Month = @MonthYear

GROUP BY Month, [Region Code], [Region Name]

UNION ----------------------------------------------------------------

SELECT Month, 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		'All' AS 'Region Code',
		'All' AS 'Region Name',
		'All' AS 'CCG Code',
		'All' AS 'CCG Name',
		'All' AS 'Provider Code',
		'All' AS 'Provider Name',
		[STP Code] AS 'STP Code',
		[STP Name] AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		CASE WHEN SUM(OpenReferralLessThan61DaysNoContact)< 5 THEN NULL ELSE CAST(ROUND((SUM(OpenReferralLessThan61DaysNoContact)+2) /5,0)*5 AS INT)  END AS OpenReferralLessThan61DaysNoContact,
		CASE WHEN SUM([OpenReferral61-90DaysNoContact])< 5 THEN NULL ELSE CAST(ROUND((SUM([OpenReferral61-90DaysNoContact])+2) /5,0)*5 AS INT)  END AS [OpenReferral61-90DaysNoContact],
		CASE WHEN SUM([OpenReferral91-120DaysNoContact])< 5 THEN NULL ELSE CAST(ROUND((SUM([OpenReferral91-120DaysNoContact])+2) /5,0)*5 AS INT)  END AS [OpenReferral91-120DaysNoContact],
		CASE WHEN SUM([OpenReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([OpenReferral])+2) /5,0)*5 AS INT)  END AS [OpenReferral],
		CASE WHEN SUM([Ended Treatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Treatment])+2) /5,0)*5 AS INT)  END AS [Ended Treatment],
		CASE WHEN SUM([Finished Treatment - 2 or more Apps])< 5 THEN NULL ELSE CAST(ROUND((SUM([Finished Treatment - 2 or more Apps])+2) /5,0)*5 AS INT)  END AS [Finished Treatment - 2 or more Apps],
		CASE WHEN SUM([Referrals])< 5 THEN NULL ELSE CAST(ROUND((SUM([Referrals])+2) /5,0)*5 AS INT)  END AS [Referrals],
		CASE WHEN SUM([EnteringTreatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([EnteringTreatment])+2) /5,0)*5 AS INT)  END AS [EnteringTreatment],
		CASE WHEN SUM([Waiting for Assessment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Waiting for Assessment])+2) /5,0)*5 AS INT)  END AS [Waiting for Assessment],
		CASE WHEN SUM([WaitingForAssessmentOver90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([WaitingForAssessmentOver90days])+2) /5,0)*5 AS INT)  END AS [WaitingForAssessmentOver90Days],
		CASE WHEN SUM(FirstAssessment28days)< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessment28days])+2) /5,0)*5 AS INT)  END AS [FirstAssessment28Days],
		CASE WHEN SUM([FirstAssessment29to56days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessment29to56days])+2) /5,0)*5 AS INT)  END AS [FirstAssessment29to56Days],
		CASE WHEN SUM([FirstAssessment57to90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessment57to90days])+2) /5,0)*5 AS INT)  END AS [FirstAssessment57to90Days],
		CASE WHEN SUM([FirstAssessmentOver90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessmentOver90days])+2) /5,0)*5 AS INT)  END AS [FirstAssessmentOver90Days],
		CASE WHEN SUM([FirstTreatment28days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatment28days])+2) /5,0)*5 AS INT)  END AS [FirstTreatment28days],
		CASE WHEN SUM([FirstTreatment29to56days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatment29to56days])+2) /5,0)*5 AS INT)  END AS [FirstTreatment29to56days],
		CASE WHEN SUM([FirstTreatment57to90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatment57to90days])+2) /5,0)*5 AS INT)  END AS [FirstTreatment57to90days],
		CASE WHEN SUM([FirstTreatmentOver90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatmentOver90days])+2) /5,0)*5 AS INT)  END AS [FirstTreatmentOver90days],
		CASE WHEN SUM([Ended Referral])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Referral])+2) /5,0)*5 AS INT)  END AS [Ended Referral],
		CASE WHEN SUM([Ended Not Suitable])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Suitable])+2) /5,0)*5 AS INT)  END AS [Ended Not Suitable],
		CASE WHEN SUM([Ended Signposted])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Signposted])+2) /5,0)*5 AS INT)  END AS [Ended Signposted],
		CASE WHEN SUM([Ended Mutual Agreement])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Mutual Agreement])+2) /5,0)*5 AS INT)  END AS [Ended Mutual Agreement],
		CASE WHEN SUM([Ended Referred Elsewhere])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Referred Elsewhere])+2) /5,0)*5 AS INT)  END AS [Ended Referred Elsewhere],
		CASE WHEN SUM([Ended Declined])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Declined])+2) /5,0)*5 AS INT)  END AS [Ended Declined],
		CASE WHEN SUM([Ended Deceased Assessed Only])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased Assessed Only])+2) /5,0)*5 AS INT)  END AS [Ended Deceased Assessed Only],
		CASE WHEN SUM([Ended Unknown Assessed Only])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Unknown Assessed Only])+2) /5,0)*5 AS INT)  END AS [Ended Unknown Assessed Only],
		CASE WHEN SUM([Ended Stepped Up])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Stepped Up])+2) /5,0)*5 AS INT)  END AS [Ended Stepped Up],
		CASE WHEN SUM([Ended Stepped Down])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Stepped Down])+2) /5,0)*5 AS INT)  END AS [Ended Stepped Down],
		CASE WHEN SUM([Ended Completed])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Completed])+2) /5,0)*5 AS INT)  END AS [Ended Completed],
		CASE WHEN SUM([Ended Dropped Out])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Dropped Out])+2) /5,0)*5 AS INT)  END AS [Ended Dropped Out],
		CASE WHEN SUM([Ended Referred Non IAPT])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Referred Non IAPT])+2) /5,0)*5 AS INT)  END AS [Ended Referred Non IAPT],
		CASE WHEN SUM([Ended Deceased Treated])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased Treated])+2) /5,0)*5 AS INT)  END AS [Ended Deceased Treated],
		CASE WHEN SUM([Ended Unknown Treated])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Unknown Treated])+2) /5,0)*5 AS INT)  END AS [Ended Unknown Treated],
		CASE WHEN SUM([Ended Invalid])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Invalid])+2) /5,0)*5 AS INT)  END AS [Ended Invalid],
		CASE WHEN SUM([Ended No Reason Recorded])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended No Reason Recorded])+2) /5,0)*5 AS INT)  END AS [Ended No Reason Recorded],
		CASE WHEN SUM([Ended Seen Not Treated])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Seen Not Treated])+2) /5,0)*5 AS INT)  END AS [Ended Seen Not Treated],
		CASE WHEN SUM([Ended Treated Once])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Treated Once])+2) /5,0)*5 AS INT)  END AS [Ended Treated Once],
		CASE WHEN SUM([Ended Not Seen])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Seen])+2) /5,0)*5 AS INT)  END AS [Ended Not Seen],
		CASE WHEN SUM([Recovery])< 5 THEN NULL ELSE CAST(ROUND((SUM([Recovery])+2) /5,0)*5 AS INT)  END AS [Recovery],
		CASE WHEN SUM([Reliable Recovery])< 5 THEN NULL ELSE CAST(ROUND((SUM([Reliable Recovery])+2) /5,0)*5 AS INT)  END AS [Reliable Recovery],
		CASE WHEN SUM([No Change])< 5 THEN NULL ELSE CAST(ROUND((SUM([No Change])+2) /5,0)*5 AS INT)  END AS [No Change],
		CASE WHEN SUM([Reliable Deterioration])< 5 THEN NULL ELSE CAST(ROUND((SUM([Reliable Deterioration])+2) /5,0)*5 AS INT)  END AS [Reliable Deterioration],
		CASE WHEN SUM([Reliable Improvement])< 5 THEN NULL ELSE CAST(ROUND((SUM([Reliable Improvement])+2) /5,0)*5 AS INT)  END AS [Reliable Improvement],
		CASE WHEN SUM([NotCaseness])< 5 THEN NULL ELSE CAST(ROUND((SUM([NotCaseness])+2) /5,0)*5 AS INT)  END AS [NotCaseness],
		CASE WHEN SUM([ADSMFinishedTreatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([ADSMFinishedTreatment])+2) /5,0)*5 AS INT)  END AS [ADSMFinishedTreatment],
		CASE WHEN SUM([CountAppropriatePairedADSM])< 5 THEN NULL ELSE CAST(ROUND((SUM([CountAppropriatePairedADSM])+2) /5,0)*5 AS INT)  END AS [CountAppropriatePairedADSM],
		CASE WHEN SUM([SelfReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([SelfReferral])+2) /5,0)*5 AS INT)  END AS [SelfReferral],
		CASE WHEN SUM([GPReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([GPReferral])+2) /5,0)*5 AS INT)  END AS [GPReferral],
		CASE WHEN SUM([OtherReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([OtherReferral])+2) /5,0)*5 AS INT)  END AS [OtherReferral],
		CASE WHEN SUM([FirstToSecond28Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecond28Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecond28Days],
		CASE WHEN SUM([FirstToSecond28To56Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecond28To56Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecond28To56Days],
		CASE WHEN SUM([FirstToSecond57To90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecond57To90Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecond57To90Days],
		CASE WHEN SUM([FirstToSecondMoreThan90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecondMoreThan90Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecondMoreThan90Days],
		CASE WHEN SUM([Ended Not Assessed])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Assessed])+2) /5,0)*5 AS INT)  END AS [Ended Not Assessed],
		CASE WHEN SUM([Ended Incomplete Assessment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Incomplete Assessment])+2) /5,0)*5 AS INT)  END AS [Ended Incomplete Assessment],
		CASE WHEN SUM([Ended Deceased (Seen but not taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased (Seen but not taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS 'Ended Deceased (Seen but not taken on for a course of treatment)',
		CASE WHEN SUM([Ended Not Known (Seen but not taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Known (Seen but not taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS 'Ended Not Known (Seen but not taken on for a course of treatment)',
		CASE WHEN SUM([Ended Mutually agreed completion of treatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Mutually agreed completion of treatment])+2) /5,0)*5 AS INT)  END AS [Ended Mutually agreed completion of treatment],
		CASE WHEN SUM([Ended Termination of treatment earlier than Care Professional planned])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Termination of treatment earlier than Care Professional planned])+2) /5,0)*5 AS INT)  END AS 'Ended Termination of treatment earlier than Care Professional planned',
		CASE WHEN SUM([Ended Termination of treatment earlier than patient requested])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Termination of treatment earlier than patient requested])+2) /5,0)*5 AS INT)  END AS [Ended Termination of treatment earlier than patient requested],
		CASE WHEN SUM([Ended Deceased (Seen and taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased (Seen and taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS [Ended Deceased (Seen and taken on for a course of treatment)],
		CASE WHEN SUM([Ended Not Known (Seen and taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Known (Seen and taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS [Ended Not Known (Seen and taken on for a course of treatment)],
		NULL AS RepeatReferrals,
		CASE WHEN SUM([RepeatReferrals2])< 5 THEN NULL ELSE CAST(ROUND((SUM([RepeatReferrals2])+2) /5,0)*5 AS INT)  END AS [RepeatReferrals2],
		'STP' AS 'Level'

FROM	[NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_Region_test_2]

WHERE	Category = 'Total' AND Month = @MonthYear

GROUP BY Month, [STP Code], [STP Name]

UNION -------------------------------------------------------------------------------------------------

SELECT	Month, 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		'All' AS 'Region Code',
		'All' AS 'Region Name',
		[CCG Code] AS 'CCG Code',
		[CCG Name] AS 'CCG Name',
		'All' AS 'Provider Code',
		'All' AS 'Provider Name',
		'All' AS 'STP Code',
		'All' AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		CASE WHEN SUM(OpenReferralLessThan61DaysNoContact)< 5 THEN NULL ELSE CAST(ROUND((SUM(OpenReferralLessThan61DaysNoContact)+2) /5,0)*5 AS INT)  END AS OpenReferralLessThan61DaysNoContact,
		CASE WHEN SUM([OpenReferral61-90DaysNoContact])< 5 THEN NULL ELSE CAST(ROUND((SUM([OpenReferral61-90DaysNoContact])+2) /5,0)*5 AS INT)  END AS [OpenReferral61-90DaysNoContact],
		CASE WHEN SUM([OpenReferral91-120DaysNoContact])< 5 THEN NULL ELSE CAST(ROUND((SUM([OpenReferral91-120DaysNoContact])+2) /5,0)*5 AS INT)  END AS [OpenReferral91-120DaysNoContact],
		CASE WHEN SUM([OpenReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([OpenReferral])+2) /5,0)*5 AS INT)  END AS [OpenReferral],
		CASE WHEN SUM([Ended Treatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Treatment])+2) /5,0)*5 AS INT)  END AS [Ended Treatment],
		CASE WHEN SUM([Finished Treatment - 2 or more Apps])< 5 THEN NULL ELSE CAST(ROUND((SUM([Finished Treatment - 2 or more Apps])+2) /5,0)*5 AS INT)  END AS [Finished Treatment - 2 or more Apps],
		CASE WHEN SUM([Referrals])< 5 THEN NULL ELSE CAST(ROUND((SUM([Referrals])+2) /5,0)*5 AS INT)  END AS [Referrals],
		CASE WHEN SUM([EnteringTreatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([EnteringTreatment])+2) /5,0)*5 AS INT)  END AS [EnteringTreatment],
		CASE WHEN SUM([Waiting for Assessment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Waiting for Assessment])+2) /5,0)*5 AS INT)  END AS [Waiting for Assessment],
		CASE WHEN SUM([WaitingForAssessmentOver90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([WaitingForAssessmentOver90days])+2) /5,0)*5 AS INT)  END AS [WaitingForAssessmentOver90Days],
		CASE WHEN SUM(FirstAssessment28days)< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessment28days])+2) /5,0)*5 AS INT)  END AS [FirstAssessment28Days],
		CASE WHEN SUM([FirstAssessment29to56days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessment29to56days])+2) /5,0)*5 AS INT)  END AS [FirstAssessment29to56Days],
		CASE WHEN SUM([FirstAssessment57to90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessment57to90days])+2) /5,0)*5 AS INT)  END AS [FirstAssessment57to90Days],
		CASE WHEN SUM([FirstAssessmentOver90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessmentOver90days])+2) /5,0)*5 AS INT)  END AS [FirstAssessmentOver90Days],
		CASE WHEN SUM([FirstTreatment28days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatment28days])+2) /5,0)*5 AS INT)  END AS [FirstTreatment28days],
		CASE WHEN SUM([FirstTreatment29to56days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatment29to56days])+2) /5,0)*5 AS INT)  END AS [FirstTreatment29to56days],
		CASE WHEN SUM([FirstTreatment57to90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatment57to90days])+2) /5,0)*5 AS INT)  END AS [FirstTreatment57to90days],
		CASE WHEN SUM([FirstTreatmentOver90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatmentOver90days])+2) /5,0)*5 AS INT)  END AS [FirstTreatmentOver90days],
		CASE WHEN SUM([Ended Referral])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Referral])+2) /5,0)*5 AS INT)  END AS [Ended Referral],
		CASE WHEN SUM([Ended Not Suitable])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Suitable])+2) /5,0)*5 AS INT)  END AS [Ended Not Suitable],
		CASE WHEN SUM([Ended Signposted])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Signposted])+2) /5,0)*5 AS INT)  END AS [Ended Signposted],
		CASE WHEN SUM([Ended Mutual Agreement])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Mutual Agreement])+2) /5,0)*5 AS INT)  END AS [Ended Mutual Agreement],
		CASE WHEN SUM([Ended Referred Elsewhere])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Referred Elsewhere])+2) /5,0)*5 AS INT)  END AS [Ended Referred Elsewhere],
		CASE WHEN SUM([Ended Declined])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Declined])+2) /5,0)*5 AS INT)  END AS [Ended Declined],
		CASE WHEN SUM([Ended Deceased Assessed Only])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased Assessed Only])+2) /5,0)*5 AS INT)  END AS [Ended Deceased Assessed Only],
		CASE WHEN SUM([Ended Unknown Assessed Only])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Unknown Assessed Only])+2) /5,0)*5 AS INT)  END AS [Ended Unknown Assessed Only],
		CASE WHEN SUM([Ended Stepped Up])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Stepped Up])+2) /5,0)*5 AS INT)  END AS [Ended Stepped Up],
		CASE WHEN SUM([Ended Stepped Down])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Stepped Down])+2) /5,0)*5 AS INT)  END AS [Ended Stepped Down],
		CASE WHEN SUM([Ended Completed])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Completed])+2) /5,0)*5 AS INT)  END AS [Ended Completed],
		CASE WHEN SUM([Ended Dropped Out])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Dropped Out])+2) /5,0)*5 AS INT)  END AS [Ended Dropped Out],
		CASE WHEN SUM([Ended Referred Non IAPT])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Referred Non IAPT])+2) /5,0)*5 AS INT)  END AS [Ended Referred Non IAPT],
		CASE WHEN SUM([Ended Deceased Treated])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased Treated])+2) /5,0)*5 AS INT)  END AS [Ended Deceased Treated],
		CASE WHEN SUM([Ended Unknown Treated])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Unknown Treated])+2) /5,0)*5 AS INT)  END AS [Ended Unknown Treated],
		CASE WHEN SUM([Ended Invalid])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Invalid])+2) /5,0)*5 AS INT)  END AS [Ended Invalid],
		CASE WHEN SUM([Ended No Reason Recorded])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended No Reason Recorded])+2) /5,0)*5 AS INT)  END AS [Ended No Reason Recorded],
		CASE WHEN SUM([Ended Seen Not Treated])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Seen Not Treated])+2) /5,0)*5 AS INT)  END AS [Ended Seen Not Treated],
		CASE WHEN SUM([Ended Treated Once])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Treated Once])+2) /5,0)*5 AS INT)  END AS [Ended Treated Once],
		CASE WHEN SUM([Ended Not Seen])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Seen])+2) /5,0)*5 AS INT)  END AS [Ended Not Seen],
		CASE WHEN SUM([Recovery])< 5 THEN NULL ELSE CAST(ROUND((SUM([Recovery])+2) /5,0)*5 AS INT)  END AS [Recovery],
		CASE WHEN SUM([Reliable Recovery])< 5 THEN NULL ELSE CAST(ROUND((SUM([Reliable Recovery])+2) /5,0)*5 AS INT)  END AS [Reliable Recovery],
		CASE WHEN SUM([No Change])< 5 THEN NULL ELSE CAST(ROUND((SUM([No Change])+2) /5,0)*5 AS INT)  END AS [No Change],
		CASE WHEN SUM([Reliable Deterioration])< 5 THEN NULL ELSE CAST(ROUND((SUM([Reliable Deterioration])+2) /5,0)*5 AS INT)  END AS [Reliable Deterioration],
		CASE WHEN SUM([Reliable Improvement])< 5 THEN NULL ELSE CAST(ROUND((SUM([Reliable Improvement])+2) /5,0)*5 AS INT)  END AS [Reliable Improvement],
		CASE WHEN SUM([NotCaseness])< 5 THEN NULL ELSE CAST(ROUND((SUM([NotCaseness])+2) /5,0)*5 AS INT)  END AS [NotCaseness],
		CASE WHEN SUM([ADSMFinishedTreatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([ADSMFinishedTreatment])+2) /5,0)*5 AS INT)  END AS [ADSMFinishedTreatment],
		CASE WHEN SUM([CountAppropriatePairedADSM])< 5 THEN NULL ELSE CAST(ROUND((SUM([CountAppropriatePairedADSM])+2) /5,0)*5 AS INT)  END AS [CountAppropriatePairedADSM],
		CASE WHEN SUM([SelfReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([SelfReferral])+2) /5,0)*5 AS INT)  END AS [SelfReferral],
		CASE WHEN SUM([GPReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([GPReferral])+2) /5,0)*5 AS INT)  END AS [GPReferral],
		CASE WHEN SUM([OtherReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([OtherReferral])+2) /5,0)*5 AS INT)  END AS [OtherReferral],
		CASE WHEN SUM([FirstToSecond28Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecond28Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecond28Days],
		CASE WHEN SUM([FirstToSecond28To56Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecond28To56Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecond28To56Days],
		CASE WHEN SUM([FirstToSecond57To90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecond57To90Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecond57To90Days],
		CASE WHEN SUM([FirstToSecondMoreThan90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecondMoreThan90Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecondMoreThan90Days],
		CASE WHEN SUM([Ended Not Assessed])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Assessed])+2) /5,0)*5 AS INT)  END AS [Ended Not Assessed],
		CASE WHEN SUM([Ended Incomplete Assessment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Incomplete Assessment])+2) /5,0)*5 AS INT)  END AS [Ended Incomplete Assessment],
		CASE WHEN SUM([Ended Deceased (Seen but not taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased (Seen but not taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS 'Ended Deceased (Seen but not taken on for a course of treatment)',
		CASE WHEN SUM([Ended Not Known (Seen but not taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Known (Seen but not taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS 'Ended Not Known (Seen but not taken on for a course of treatment)',
		CASE WHEN SUM([Ended Mutually agreed completion of treatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Mutually agreed completion of treatment])+2) /5,0)*5 AS INT)  END AS [Ended Mutually agreed completion of treatment],
		CASE WHEN SUM([Ended Termination of treatment earlier than Care Professional planned])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Termination of treatment earlier than Care Professional planned])+2) /5,0)*5 AS INT)  END AS 'Ended Termination of treatment earlier than Care Professional planned',
		CASE WHEN SUM([Ended Termination of treatment earlier than patient requested])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Termination of treatment earlier than patient requested])+2) /5,0)*5 AS INT)  END AS [Ended Termination of treatment earlier than patient requested],
		CASE WHEN SUM([Ended Deceased (Seen and taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased (Seen and taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS [Ended Deceased (Seen and taken on for a course of treatment)],
		CASE WHEN SUM([Ended Not Known (Seen and taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Known (Seen and taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS [Ended Not Known (Seen and taken on for a course of treatment)],
		NULL AS RepeatReferrals,
		CASE WHEN SUM([RepeatReferrals2])< 5 THEN NULL ELSE CAST(ROUND((SUM([RepeatReferrals2])+2) /5,0)*5 AS INT)  END AS [RepeatReferrals2],
		'CCG' AS 'Level'

FROM	[NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_Region_test_2]

WHERE	Category = 'Total' AND Month = @MonthYear

GROUP BY Month, [CCG Code], [CCG Name]

UNION -------------------------------------------------------------------------------------------------

SELECT	Month, 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		'All' AS 'Region Code',
		'All' AS 'Region Name',
		'All' AS 'CCG Code',
		'All' AS 'CCG Name',
		[Provider Code] AS 'Provider Code',
		[Provider Name] AS 'Provider Name',
		'All' AS 'STP Code',
		'All' AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		CASE WHEN SUM(OpenReferralLessThan61DaysNoContact)< 5 THEN NULL ELSE CAST(ROUND((SUM(OpenReferralLessThan61DaysNoContact)+2) /5,0)*5 AS INT)  END AS OpenReferralLessThan61DaysNoContact,
		CASE WHEN SUM([OpenReferral61-90DaysNoContact])< 5 THEN NULL ELSE CAST(ROUND((SUM([OpenReferral61-90DaysNoContact])+2) /5,0)*5 AS INT)  END AS [OpenReferral61-90DaysNoContact],
		CASE WHEN SUM([OpenReferral91-120DaysNoContact])< 5 THEN NULL ELSE CAST(ROUND((SUM([OpenReferral91-120DaysNoContact])+2) /5,0)*5 AS INT)  END AS [OpenReferral91-120DaysNoContact],
		CASE WHEN SUM([OpenReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([OpenReferral])+2) /5,0)*5 AS INT)  END AS [OpenReferral],
		CASE WHEN SUM([Ended Treatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Treatment])+2) /5,0)*5 AS INT)  END AS [Ended Treatment],
		CASE WHEN SUM([Finished Treatment - 2 or more Apps])< 5 THEN NULL ELSE CAST(ROUND((SUM([Finished Treatment - 2 or more Apps])+2) /5,0)*5 AS INT)  END AS [Finished Treatment - 2 or more Apps],
		CASE WHEN SUM([Referrals])< 5 THEN NULL ELSE CAST(ROUND((SUM([Referrals])+2) /5,0)*5 AS INT)  END AS [Referrals],
		CASE WHEN SUM([EnteringTreatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([EnteringTreatment])+2) /5,0)*5 AS INT)  END AS [EnteringTreatment],
		CASE WHEN SUM([Waiting for Assessment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Waiting for Assessment])+2) /5,0)*5 AS INT)  END AS [Waiting for Assessment],
		CASE WHEN SUM([WaitingForAssessmentOver90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([WaitingForAssessmentOver90days])+2) /5,0)*5 AS INT)  END AS [WaitingForAssessmentOver90Days],
		CASE WHEN SUM(FirstAssessment28days)< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessment28days])+2) /5,0)*5 AS INT)  END AS [FirstAssessment28Days],
		CASE WHEN SUM([FirstAssessment29to56days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessment29to56days])+2) /5,0)*5 AS INT)  END AS [FirstAssessment29to56Days],
		CASE WHEN SUM([FirstAssessment57to90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessment57to90days])+2) /5,0)*5 AS INT)  END AS [FirstAssessment57to90Days],
		CASE WHEN SUM([FirstAssessmentOver90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessmentOver90days])+2) /5,0)*5 AS INT)  END AS [FirstAssessmentOver90Days],
		CASE WHEN SUM([FirstTreatment28days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatment28days])+2) /5,0)*5 AS INT)  END AS [FirstTreatment28days],
		CASE WHEN SUM([FirstTreatment29to56days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatment29to56days])+2) /5,0)*5 AS INT)  END AS [FirstTreatment29to56days],
		CASE WHEN SUM([FirstTreatment57to90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatment57to90days])+2) /5,0)*5 AS INT)  END AS [FirstTreatment57to90days],
		CASE WHEN SUM([FirstTreatmentOver90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatmentOver90days])+2) /5,0)*5 AS INT)  END AS [FirstTreatmentOver90days],
		CASE WHEN SUM([Ended Referral])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Referral])+2) /5,0)*5 AS INT)  END AS [Ended Referral],
		CASE WHEN SUM([Ended Not Suitable])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Suitable])+2) /5,0)*5 AS INT)  END AS [Ended Not Suitable],
		CASE WHEN SUM([Ended Signposted])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Signposted])+2) /5,0)*5 AS INT)  END AS [Ended Signposted],
		CASE WHEN SUM([Ended Mutual Agreement])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Mutual Agreement])+2) /5,0)*5 AS INT)  END AS [Ended Mutual Agreement],
		CASE WHEN SUM([Ended Referred Elsewhere])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Referred Elsewhere])+2) /5,0)*5 AS INT)  END AS [Ended Referred Elsewhere],
		CASE WHEN SUM([Ended Declined])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Declined])+2) /5,0)*5 AS INT)  END AS [Ended Declined],
		CASE WHEN SUM([Ended Deceased Assessed Only])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased Assessed Only])+2) /5,0)*5 AS INT)  END AS [Ended Deceased Assessed Only],
		CASE WHEN SUM([Ended Unknown Assessed Only])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Unknown Assessed Only])+2) /5,0)*5 AS INT)  END AS [Ended Unknown Assessed Only],
		CASE WHEN SUM([Ended Stepped Up])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Stepped Up])+2) /5,0)*5 AS INT)  END AS [Ended Stepped Up],
		CASE WHEN SUM([Ended Stepped Down])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Stepped Down])+2) /5,0)*5 AS INT)  END AS [Ended Stepped Down],
		CASE WHEN SUM([Ended Completed])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Completed])+2) /5,0)*5 AS INT)  END AS [Ended Completed],
		CASE WHEN SUM([Ended Dropped Out])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Dropped Out])+2) /5,0)*5 AS INT)  END AS [Ended Dropped Out],
		CASE WHEN SUM([Ended Referred Non IAPT])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Referred Non IAPT])+2) /5,0)*5 AS INT)  END AS [Ended Referred Non IAPT],
		CASE WHEN SUM([Ended Deceased Treated])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased Treated])+2) /5,0)*5 AS INT)  END AS [Ended Deceased Treated],
		CASE WHEN SUM([Ended Unknown Treated])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Unknown Treated])+2) /5,0)*5 AS INT)  END AS [Ended Unknown Treated],
		CASE WHEN SUM([Ended Invalid])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Invalid])+2) /5,0)*5 AS INT)  END AS [Ended Invalid],
		CASE WHEN SUM([Ended No Reason Recorded])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended No Reason Recorded])+2) /5,0)*5 AS INT)  END AS [Ended No Reason Recorded],
		CASE WHEN SUM([Ended Seen Not Treated])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Seen Not Treated])+2) /5,0)*5 AS INT)  END AS [Ended Seen Not Treated],
		CASE WHEN SUM([Ended Treated Once])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Treated Once])+2) /5,0)*5 AS INT)  END AS [Ended Treated Once],
		CASE WHEN SUM([Ended Not Seen])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Seen])+2) /5,0)*5 AS INT)  END AS [Ended Not Seen],
		CASE WHEN SUM([Recovery])< 5 THEN NULL ELSE CAST(ROUND((SUM([Recovery])+2) /5,0)*5 AS INT)  END AS [Recovery],
		CASE WHEN SUM([Reliable Recovery])< 5 THEN NULL ELSE CAST(ROUND((SUM([Reliable Recovery])+2) /5,0)*5 AS INT)  END AS [Reliable Recovery],
		CASE WHEN SUM([No Change])< 5 THEN NULL ELSE CAST(ROUND((SUM([No Change])+2) /5,0)*5 AS INT)  END AS [No Change],
		CASE WHEN SUM([Reliable Deterioration])< 5 THEN NULL ELSE CAST(ROUND((SUM([Reliable Deterioration])+2) /5,0)*5 AS INT)  END AS [Reliable Deterioration],
		CASE WHEN SUM([Reliable Improvement])< 5 THEN NULL ELSE CAST(ROUND((SUM([Reliable Improvement])+2) /5,0)*5 AS INT)  END AS [Reliable Improvement],
		CASE WHEN SUM([NotCaseness])< 5 THEN NULL ELSE CAST(ROUND((SUM([NotCaseness])+2) /5,0)*5 AS INT)  END AS [NotCaseness],
		CASE WHEN SUM([ADSMFinishedTreatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([ADSMFinishedTreatment])+2) /5,0)*5 AS INT)  END AS [ADSMFinishedTreatment],
		CASE WHEN SUM([CountAppropriatePairedADSM])< 5 THEN NULL ELSE CAST(ROUND((SUM([CountAppropriatePairedADSM])+2) /5,0)*5 AS INT)  END AS [CountAppropriatePairedADSM],
		CASE WHEN SUM([SelfReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([SelfReferral])+2) /5,0)*5 AS INT)  END AS [SelfReferral],
		CASE WHEN SUM([GPReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([GPReferral])+2) /5,0)*5 AS INT)  END AS [GPReferral],
		CASE WHEN SUM([OtherReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([OtherReferral])+2) /5,0)*5 AS INT)  END AS [OtherReferral],
		CASE WHEN SUM([FirstToSecond28Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecond28Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecond28Days],
		CASE WHEN SUM([FirstToSecond28To56Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecond28To56Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecond28To56Days],
		CASE WHEN SUM([FirstToSecond57To90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecond57To90Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecond57To90Days],
		CASE WHEN SUM([FirstToSecondMoreThan90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecondMoreThan90Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecondMoreThan90Days],
		CASE WHEN SUM([Ended Not Assessed])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Assessed])+2) /5,0)*5 AS INT)  END AS [Ended Not Assessed],
		CASE WHEN SUM([Ended Incomplete Assessment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Incomplete Assessment])+2) /5,0)*5 AS INT)  END AS [Ended Incomplete Assessment],
		CASE WHEN SUM([Ended Deceased (Seen but not taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased (Seen but not taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS 'Ended Deceased (Seen but not taken on for a course of treatment)',
		CASE WHEN SUM([Ended Not Known (Seen but not taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Known (Seen but not taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS 'Ended Not Known (Seen but not taken on for a course of treatment)',
		CASE WHEN SUM([Ended Mutually agreed completion of treatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Mutually agreed completion of treatment])+2) /5,0)*5 AS INT)  END AS [Ended Mutually agreed completion of treatment],
		CASE WHEN SUM([Ended Termination of treatment earlier than Care Professional planned])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Termination of treatment earlier than Care Professional planned])+2) /5,0)*5 AS INT)  END AS 'Ended Termination of treatment earlier than Care Professional planned',
		CASE WHEN SUM([Ended Termination of treatment earlier than patient requested])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Termination of treatment earlier than patient requested])+2) /5,0)*5 AS INT)  END AS [Ended Termination of treatment earlier than patient requested],
		CASE WHEN SUM([Ended Deceased (Seen and taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased (Seen and taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS [Ended Deceased (Seen and taken on for a course of treatment)],
		CASE WHEN SUM([Ended Not Known (Seen and taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Known (Seen and taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS [Ended Not Known (Seen and taken on for a course of treatment)],
		NULL AS RepeatReferrals,
		CASE WHEN SUM([RepeatReferrals2])< 5 THEN NULL ELSE CAST(ROUND((SUM([RepeatReferrals2])+2) /5,0)*5 AS INT)  END AS [RepeatReferrals2],
		'Provider' AS 'Level'

FROM	[NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_Region_test_2]

WHERE	Category = 'Total' AND Month = @MonthYear

GROUP BY Month,  [Provider Code], [Provider Name]

UNION -------------------------------------------------------------------------------------------------

SELECT	Month, 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		'All' AS 'Region Code',
		'All' AS 'Region Name',
		[CCG Code] AS 'CCG Code',
		[CCG Name] AS 'CCG Name',
		[Provider Code] AS 'Provider Code',
		[Provider Name] AS 'Provider Name',
		'All' AS 'STP Code',
		'All' AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		CASE WHEN SUM(OpenReferralLessThan61DaysNoContact)< 5 THEN NULL ELSE CAST(ROUND((SUM(OpenReferralLessThan61DaysNoContact)+2) /5,0)*5 AS INT)  END AS OpenReferralLessThan61DaysNoContact,
		CASE WHEN SUM([OpenReferral61-90DaysNoContact])< 5 THEN NULL ELSE CAST(ROUND((SUM([OpenReferral61-90DaysNoContact])+2) /5,0)*5 AS INT)  END AS [OpenReferral61-90DaysNoContact],
		CASE WHEN SUM([OpenReferral91-120DaysNoContact])< 5 THEN NULL ELSE CAST(ROUND((SUM([OpenReferral91-120DaysNoContact])+2) /5,0)*5 AS INT)  END AS [OpenReferral91-120DaysNoContact],
		CASE WHEN SUM([OpenReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([OpenReferral])+2) /5,0)*5 AS INT)  END AS [OpenReferral],
		CASE WHEN SUM([Ended Treatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Treatment])+2) /5,0)*5 AS INT)  END AS [Ended Treatment],
		CASE WHEN SUM([Finished Treatment - 2 or more Apps])< 5 THEN NULL ELSE CAST(ROUND((SUM([Finished Treatment - 2 or more Apps])+2) /5,0)*5 AS INT)  END AS [Finished Treatment - 2 or more Apps],
		CASE WHEN SUM([Referrals])< 5 THEN NULL ELSE CAST(ROUND((SUM([Referrals])+2) /5,0)*5 AS INT)  END AS [Referrals],
		CASE WHEN SUM([EnteringTreatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([EnteringTreatment])+2) /5,0)*5 AS INT)  END AS [EnteringTreatment],
		CASE WHEN SUM([Waiting for Assessment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Waiting for Assessment])+2) /5,0)*5 AS INT)  END AS [Waiting for Assessment],
		CASE WHEN SUM([WaitingForAssessmentOver90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([WaitingForAssessmentOver90days])+2) /5,0)*5 AS INT)  END AS [WaitingForAssessmentOver90Days],
		CASE WHEN SUM(FirstAssessment28days)< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessment28days])+2) /5,0)*5 AS INT)  END AS [FirstAssessment28Days],
		CASE WHEN SUM([FirstAssessment29to56days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessment29to56days])+2) /5,0)*5 AS INT)  END AS [FirstAssessment29to56Days],
		CASE WHEN SUM([FirstAssessment57to90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessment57to90days])+2) /5,0)*5 AS INT)  END AS [FirstAssessment57to90Days],
		CASE WHEN SUM([FirstAssessmentOver90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstAssessmentOver90days])+2) /5,0)*5 AS INT)  END AS [FirstAssessmentOver90Days],
		CASE WHEN SUM([FirstTreatment28days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatment28days])+2) /5,0)*5 AS INT)  END AS [FirstTreatment28days],
		CASE WHEN SUM([FirstTreatment29to56days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatment29to56days])+2) /5,0)*5 AS INT)  END AS [FirstTreatment29to56days],
		CASE WHEN SUM([FirstTreatment57to90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatment57to90days])+2) /5,0)*5 AS INT)  END AS [FirstTreatment57to90days],
		CASE WHEN SUM([FirstTreatmentOver90days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstTreatmentOver90days])+2) /5,0)*5 AS INT)  END AS [FirstTreatmentOver90days],
		CASE WHEN SUM([Ended Referral])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Referral])+2) /5,0)*5 AS INT)  END AS [Ended Referral],
		CASE WHEN SUM([Ended Not Suitable])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Suitable])+2) /5,0)*5 AS INT)  END AS [Ended Not Suitable],
		CASE WHEN SUM([Ended Signposted])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Signposted])+2) /5,0)*5 AS INT)  END AS [Ended Signposted],
		CASE WHEN SUM([Ended Mutual Agreement])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Mutual Agreement])+2) /5,0)*5 AS INT)  END AS [Ended Mutual Agreement],
		CASE WHEN SUM([Ended Referred Elsewhere])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Referred Elsewhere])+2) /5,0)*5 AS INT)  END AS [Ended Referred Elsewhere],
		CASE WHEN SUM([Ended Declined])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Declined])+2) /5,0)*5 AS INT)  END AS [Ended Declined],
		CASE WHEN SUM([Ended Deceased Assessed Only])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased Assessed Only])+2) /5,0)*5 AS INT)  END AS [Ended Deceased Assessed Only],
		CASE WHEN SUM([Ended Unknown Assessed Only])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Unknown Assessed Only])+2) /5,0)*5 AS INT)  END AS [Ended Unknown Assessed Only],
		CASE WHEN SUM([Ended Stepped Up])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Stepped Up])+2) /5,0)*5 AS INT)  END AS [Ended Stepped Up],
		CASE WHEN SUM([Ended Stepped Down])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Stepped Down])+2) /5,0)*5 AS INT)  END AS [Ended Stepped Down],
		CASE WHEN SUM([Ended Completed])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Completed])+2) /5,0)*5 AS INT)  END AS [Ended Completed],
		CASE WHEN SUM([Ended Dropped Out])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Dropped Out])+2) /5,0)*5 AS INT)  END AS [Ended Dropped Out],
		CASE WHEN SUM([Ended Referred Non IAPT])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Referred Non IAPT])+2) /5,0)*5 AS INT)  END AS [Ended Referred Non IAPT],
		CASE WHEN SUM([Ended Deceased Treated])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased Treated])+2) /5,0)*5 AS INT)  END AS [Ended Deceased Treated],
		CASE WHEN SUM([Ended Unknown Treated])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Unknown Treated])+2) /5,0)*5 AS INT)  END AS [Ended Unknown Treated],
		CASE WHEN SUM([Ended Invalid])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Invalid])+2) /5,0)*5 AS INT)  END AS [Ended Invalid],
		CASE WHEN SUM([Ended No Reason Recorded])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended No Reason Recorded])+2) /5,0)*5 AS INT)  END AS [Ended No Reason Recorded],
		CASE WHEN SUM([Ended Seen Not Treated])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Seen Not Treated])+2) /5,0)*5 AS INT)  END AS [Ended Seen Not Treated],
		CASE WHEN SUM([Ended Treated Once])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Treated Once])+2) /5,0)*5 AS INT)  END AS [Ended Treated Once],
		CASE WHEN SUM([Ended Not Seen])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Seen])+2) /5,0)*5 AS INT)  END AS [Ended Not Seen],
		CASE WHEN SUM([Recovery])< 5 THEN NULL ELSE CAST(ROUND((SUM([Recovery])+2) /5,0)*5 AS INT)  END AS [Recovery],
		CASE WHEN SUM([Reliable Recovery])< 5 THEN NULL ELSE CAST(ROUND((SUM([Reliable Recovery])+2) /5,0)*5 AS INT)  END AS [Reliable Recovery],
		CASE WHEN SUM([No Change])< 5 THEN NULL ELSE CAST(ROUND((SUM([No Change])+2) /5,0)*5 AS INT)  END AS [No Change],
		CASE WHEN SUM([Reliable Deterioration])< 5 THEN NULL ELSE CAST(ROUND((SUM([Reliable Deterioration])+2) /5,0)*5 AS INT)  END AS [Reliable Deterioration],
		CASE WHEN SUM([Reliable Improvement])< 5 THEN NULL ELSE CAST(ROUND((SUM([Reliable Improvement])+2) /5,0)*5 AS INT)  END AS [Reliable Improvement],
		CASE WHEN SUM([NotCaseness])< 5 THEN NULL ELSE CAST(ROUND((SUM([NotCaseness])+2) /5,0)*5 AS INT)  END AS [NotCaseness],
		CASE WHEN SUM([ADSMFinishedTreatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([ADSMFinishedTreatment])+2) /5,0)*5 AS INT)  END AS [ADSMFinishedTreatment],
		CASE WHEN SUM([CountAppropriatePairedADSM])< 5 THEN NULL ELSE CAST(ROUND((SUM([CountAppropriatePairedADSM])+2) /5,0)*5 AS INT)  END AS [CountAppropriatePairedADSM],
		CASE WHEN SUM([SelfReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([SelfReferral])+2) /5,0)*5 AS INT)  END AS [SelfReferral],
		CASE WHEN SUM([GPReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([GPReferral])+2) /5,0)*5 AS INT)  END AS [GPReferral],
		CASE WHEN SUM([OtherReferral])< 5 THEN NULL ELSE CAST(ROUND((SUM([OtherReferral])+2) /5,0)*5 AS INT)  END AS [OtherReferral],
		CASE WHEN SUM([FirstToSecond28Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecond28Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecond28Days],
		CASE WHEN SUM([FirstToSecond28To56Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecond28To56Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecond28To56Days],
		CASE WHEN SUM([FirstToSecond57To90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecond57To90Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecond57To90Days],
		CASE WHEN SUM([FirstToSecondMoreThan90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM([FirstToSecondMoreThan90Days])+2) /5,0)*5 AS INT)  END AS [FirstToSecondMoreThan90Days],
		CASE WHEN SUM([Ended Not Assessed])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Assessed])+2) /5,0)*5 AS INT)  END AS [Ended Not Assessed],
		CASE WHEN SUM([Ended Incomplete Assessment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Incomplete Assessment])+2) /5,0)*5 AS INT)  END AS [Ended Incomplete Assessment],
		CASE WHEN SUM([Ended Deceased (Seen but not taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased (Seen but not taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS 'Ended Deceased (Seen but not taken on for a course of treatment)',
		CASE WHEN SUM([Ended Not Known (Seen but not taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Known (Seen but not taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS 'Ended Not Known (Seen but not taken on for a course of treatment)',
		CASE WHEN SUM([Ended Mutually agreed completion of treatment])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Mutually agreed completion of treatment])+2) /5,0)*5 AS INT)  END AS [Ended Mutually agreed completion of treatment],
		CASE WHEN SUM([Ended Termination of treatment earlier than Care Professional planned])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Termination of treatment earlier than Care Professional planned])+2) /5,0)*5 AS INT)  END AS 'Ended Termination of treatment earlier than Care Professional planned',
		CASE WHEN SUM([Ended Termination of treatment earlier than patient requested])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Termination of treatment earlier than patient requested])+2) /5,0)*5 AS INT)  END AS [Ended Termination of treatment earlier than patient requested],
		CASE WHEN SUM([Ended Deceased (Seen and taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Deceased (Seen and taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS [Ended Deceased (Seen and taken on for a course of treatment)],
		CASE WHEN SUM([Ended Not Known (Seen and taken on for a course of treatment)])< 5 THEN NULL ELSE CAST(ROUND((SUM([Ended Not Known (Seen and taken on for a course of treatment)])+2) /5,0)*5 AS INT)  END AS [Ended Not Known (Seen and taken on for a course of treatment)],
		NULL AS RepeatReferrals,
		CASE WHEN SUM([RepeatReferrals2])< 5 THEN NULL ELSE CAST(ROUND((SUM([RepeatReferrals2])+2) /5,0)*5 AS INT)  END AS [RepeatReferrals2],
		'CCG/ Provider' AS 'Level'

FROM	[NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_Region_test_2]

WHERE	Category = 'Total' AND Month = @MonthYear

GROUP BY Month, [CCG Code], [CCG Name], [Provider Code], [Provider Name]

-------------------------------------------------------------------------------------
PRINT 'Updated - [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Region_Monthly_Test_2_Rounded]'

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Monthly_IST_New_Indicators_Rounded] -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Monthly_IST_New_Indicators_Rounded]

SELECT a.[Month], 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		'All' AS 'Region Code',
		'All' AS 'Region Name',
		'All' AS 'CCG Code',
		'All' AS 'CCG Name',
		'All' AS 'Provider Code',
		'All' AS 'Provider Name',
		'All' AS 'STP Code',
		'All' AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		SUM(a.[SelfReferral]) AS 'SelfReferral',
		SUM([EndedBeforeTreatment]) AS 'EndedBeforeTreatment',
		SUM([FirstTreatment2Weeks]) AS 'FirstTreatment2Weeks',
		SUM([FirstTreatment6Weeks]) AS 'FirstTreatment6Weeks',
		SUM([FirstTreatment12Weeks]) AS 'FirstTreatment12Weeks',
		SUM([FirstTreatment18Weeks]) AS 'FirstTreatment18Weeks',
		SUM([WaitingForTreatment]) AS 'WaitingForTreatment',
		SUM([Appointments]) AS 'Appointments',
		SUM([ApptDNA]) AS 'Appointments DNA',
		SUM([ReferralsEnded]) AS 'ReferralsEnded',
		SUM([EndedTreatedOnce]) AS 'EndedTreatedOnce',
		SUM([Waiting2Weeks]) AS 'Waiting2Weeks',
		SUM([Waiting4Weeks]) AS 'Waiting4Weeks',
		SUM([Waiting6Weeks]) AS 'Waiting6Weeks',
		SUM([Waiting12Weeks]) AS 'Waiting12Weeks',
		SUM([Waiting18Weeks]) AS 'Waiting18Weeks',
		SUM([FinishedCourseTreatmentWaited6Weeks]) AS 'FinishedCourseWait6Weeks',
		SUM([FinishedCourseTreatmentWaited18Weeks]) AS 'FinishedCourseWait18Weeks',
		SUM(a.[FirstToSecond28Days]) AS 'FirstToSecond28Days',
		SUM(b.[FirstToSecond28To90Days]) AS 'FirstToSecond90Days',
		SUM(a.[FirstToSecondMoreThan90Days]) AS 'FirstToSecondOver90Days',
		NULL AS [RightcareSimilarCCG],
		'National' AS 'Level',
		ROUND(CASE WHEN SUM(Recovery) <5 OR (SUM([Finished Treatment - 2 or more Apps])-SUM(NotCaseness)) <5 then NULL ELSE (CAST(SUM(Recovery)AS DECIMAL)/CAST((SUM([Finished Treatment - 2 or more Apps])-SUM(NotCaseness))AS DECIMAL)) END, 3) AS RecoveryRate , 
		ROUND(CASE WHEN SUM([Reliable Improvement]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5 then NULL ELSE (CAST(SUM([Reliable Improvement])AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps])AS DECIMAL)) END, 3) AS ReliableImprovementRate , 
		ROUND(CASE WHEN SUM([Reliable Deterioration]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM([Reliable Deterioration]) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 3) AS DeteriorationRate ,
		ROUND(CASE WHEN SUM([No Change]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM([No Change])AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 3) AS NoChangeRate ,
		ROUND(CASE WHEN SUM([ApptDNA]) <5 OR SUM(Appointments) <5 then NULL ELSE (CAST(SUM([ApptDNA])AS DECIMAL)/CAST(SUM(Appointments)AS DECIMAL)) END, 3) AS DNARate, 
		ROUND(CASE WHEN SUM(NotCaseness) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM(NotCaseness) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 3) AS NotCaseness , 
		ROUND(CASE WHEN SUM(a.SelfReferral) <5 OR SUM(Referrals) <5  then NULL ELSE (CAST(SUM(a.SelfReferral) AS DECIMAL)/CAST(SUM(Referrals)AS DECIMAL)) END, 3) AS SelfReferralRate,
		ROUND(CASE WHEN SUM(EndedBeforeTreatment) <5 OR SUM(Referrals) <5  then NULL ELSE (CAST(SUM(EndedBeforeTreatment) AS DECIMAL)/CAST(SUM(Referrals)AS DECIMAL)) END, 3) AS Attrition , 
		ROUND(CASE WHEN SUM(Waiting6Weeks) <5 OR SUM(WaitingForTreatment) <5  then NULL ELSE (CAST(SUM(Waiting6Weeks) AS DECIMAL)/CAST(SUM(WaitingForTreatment)AS DECIMAL)) END, 3) AS WaitingForTreatment6WeeksRate , 
		ROUND(CASE WHEN SUM(Waiting18Weeks) <5 OR SUM(WaitingForTreatment) <5   then NULL ELSE (CAST(SUM(Waiting18Weeks) AS DECIMAL)/CAST(SUM(WaitingForTreatment)AS DECIMAL)) END, 3) AS WaitingForTreatment18WeeksRate ,
		ROUND(CASE WHEN SUM(FirstTreatment6Weeks) <5 OR SUM(EnteringTreatment) <5   then NULL ELSE (CAST(SUM(FirstTreatment6Weeks)AS DECIMAL)/CAST(SUM(EnteringTreatment)AS DECIMAL)) END, 3) AS  FirstTreatmentWaited6WeeksRate ,
		ROUND(CASE WHEN SUM(FirstTreatment18Weeks) <5 OR SUM(EnteringTreatment) <5   then NULL ELSE(CAST( SUM(FirstTreatment18Weeks)AS DECIMAL)/CAST(SUM(EnteringTreatment)AS DECIMAL)) END, 3) AS FirstTreatmentWaited18WeeksRate , 
		ROUND(CASE WHEN SUM(FinishedCourseTreatmentWaited6Weeks) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5   then NULL ELSE (CAST(SUM(FinishedCourseTreatmentWaited6Weeks)AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 3) AS FinishedCourseTreatment6WeeksRate ,
		ROUND(CASE WHEN SUM(FinishedCourseTreatmentWaited18Weeks) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5   then NULL ELSE (CAST(SUM(FinishedCourseTreatmentWaited18Weeks) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 3) AS FinishedCourseTreatment18WeeksRate ,
		ROUND(CASE WHEN SUM(CountAppropriatePairedADSM) <5 OR SUM(ADSMFinishedTreatment) <5   then NULL ELSE (CAST(SUM(CountAppropriatePairedADSM) AS DECIMAL)/CAST(SUM(ADSMFinishedTreatment)AS DECIMAL)) END, 3) AS ADSMCompletenessRate,
		ROUND(CASE WHEN (SUM([OpenReferral91-120DaysNoContact])+SUM([OpenReferralOver120daysNoContact])) <5 OR SUM(OpenReferral) <5   then NULL ELSE (CAST((SUM([OpenReferral91-120DaysNoContact])+SUM([OpenReferralOver120daysNoContact])) AS DECIMAL)/CAST(SUM(OpenReferral)AS DECIMAL)) END, 3) AS OpenReferral90daysRate,
		ROUND(CASE WHEN SUM(a.[FirstToSecondMoreThan90Days]) <5 OR SUM(a.[FirstToSecond28Days]+[FirstToSecond28To56Days]+[FirstToSecond57To90Days]+a.[FirstToSecondMoreThan90Days]) <5   then NULL ELSE (CAST(SUM(a.[FirstToSecondMoreThan90Days]) AS DECIMAL)/CAST(SUM(a.[FirstToSecond28Days]+[FirstToSecond28To56Days]+[FirstToSecond57To90Days]+a.[FirstToSecondMoreThan90Days])AS DECIMAL)) END, 3) AS FirsttoSecond90daysRate

FROM	[NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_Region_Test_2] a
		------------------------------------------------------------------------------------
		LEFT JOIN [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_IST_New_Indicators_v2] b 
		ON a.[Month] = b.[Month] AND a.[Provider Code]=b.[Provider Code] AND a.[CCG Code] = b.[CCG Code] AND a.[STP Code]=b.[STP Code] AND a.[Region Code] = b.[Region Code] AND a.Variable = b.Variable

WHERE a.Category = 'Total' AND a.[Month] = @MonthYear

GROUP BY a.[Month]

UNION --------------------------------------------------------- ---------------------------------------------------------

SELECT a.[Month], 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		a.[Region Code] AS 'Region Code',
		a.[Region Name] AS 'Region Name',
		'All' AS 'CCG Code',
		'All' AS 'CCG Name',
		'All' AS 'Provider Code',
		'All' AS 'Provider Name',
		'All' AS 'STP Code',
		'All' AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		CASE WHEN SUM(a.SelfReferral)< 5 THEN NULL ELSE CAST(ROUND((SUM(a.SelfReferral)+2) /5,0)*5 AS INT)  END AS SelfReferral,
		CASE WHEN SUM(EndedBeforeTreatment)< 5 THEN NULL ELSE CAST(ROUND((SUM(EndedBeforeTreatment)+2) /5,0)*5 AS INT)  END AS EndedBeforeTreatment,
		CASE WHEN SUM(FirstTreatment2Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment2Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment2Weeks,
		CASE WHEN SUM(FirstTreatment6Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment6Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment6Weeks,
		CASE WHEN SUM(FirstTreatment12Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment12Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment12Weeks,
		CASE WHEN SUM(FirstTreatment18Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment18Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment18Weeks,
		CASE WHEN SUM(WaitingForTreatment)< 5 THEN NULL ELSE CAST(ROUND((SUM(WaitingForTreatment)+2) /5,0)*5 AS INT)  END AS WaitingForTreatment,
		CASE WHEN SUM(Appointments)< 5 THEN NULL ELSE CAST(ROUND((SUM(Appointments)+2) /5,0)*5 AS INT)  END AS Appointments,
		CASE WHEN SUM([ApptDNA])< 5 THEN NULL ELSE CAST(ROUND((SUM([ApptDNA])+2) /5,0)*5 AS INT)  END AS 'Appointments DNA',
		CASE WHEN SUM(ReferralsEnded)< 5 THEN NULL ELSE CAST(ROUND((SUM(ReferralsEnded)+2) /5,0)*5 AS INT)  END AS ReferralsEnded,
		CASE WHEN SUM(EndedTreatedOnce)< 5 THEN NULL ELSE CAST(ROUND((SUM(EndedTreatedOnce)+2) /5,0)*5 AS INT)  END AS EndedTreatedOnce,
		CASE WHEN SUM(Waiting2Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting2Weeks)+2) /5,0)*5 AS INT)  END AS Waiting2Weeks,
		CASE WHEN SUM(Waiting4Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting4Weeks)+2) /5,0)*5 AS INT)  END AS Waiting4Weeks,
		CASE WHEN SUM(Waiting6Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting6Weeks)+2) /5,0)*5 AS INT)  END AS Waiting6Weeks,
		CASE WHEN SUM(Waiting12Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting12Weeks)+2) /5,0)*5 AS INT)  END AS Waiting12Weeks,
		CASE WHEN SUM(Waiting18Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting18Weeks)+2) /5,0)*5 AS INT)  END AS Waiting18Weeks,
		CASE WHEN SUM(FinishedCourseTreatmentWaited6Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FinishedCourseTreatmentWaited6Weeks)+2) /5,0)*5 AS INT)  END AS FinishedCourseTreatmentWaited6Weeks,
		CASE WHEN SUM(FinishedCourseTreatmentWaited18Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FinishedCourseTreatmentWaited18Weeks)+2) /5,0)*5 AS INT)  END AS FinishedCourseTreatmentWaited18Weeks,
		CASE WHEN SUM(a.FirstToSecond28Days)< 5 THEN NULL ELSE CAST(ROUND((SUM(a.FirstToSecond28Days)+2) /5,0)*5 AS INT)  END AS FirstToSecond28Days,
		CASE WHEN SUM(b.[FirstToSecond28To90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM(b.[FirstToSecond28To90Days])+2) /5,0)*5 AS INT)  END AS 'FirstToSecond90Days',
		CASE WHEN SUM(a.[FirstToSecondMoreThan90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM(a.[FirstToSecondMoreThan90Days])+2) /5,0)*5 AS INT)  END AS 'FirstToSecondOver90Days',
		NULL AS 'RightcareSimilarCCG',
		'Region' AS 'Level',
		ROUND(CASE WHEN SUM(Recovery) <5 OR (SUM([Finished Treatment - 2 or more Apps])-SUM(NotCaseness)) <5 then NULL ELSE (CAST(SUM(Recovery)AS DECIMAL)/CAST((SUM([Finished Treatment - 2 or more Apps])-SUM(NotCaseness))AS DECIMAL)) END, 2) AS RecoveryRate , 
		ROUND(CASE WHEN SUM([Reliable Improvement]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5 then NULL ELSE (CAST(SUM([Reliable Improvement])AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps])AS DECIMAL)) END, 2) AS ReliableImprovementRate , 
		ROUND(CASE WHEN SUM([Reliable Deterioration]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM([Reliable Deterioration]) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS DeteriorationRate ,
		ROUND(CASE WHEN SUM([No Change]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM([No Change])AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS NoChangeRate ,
		ROUND(CASE WHEN SUM([ApptDNA]) <5 OR SUM(Appointments) <5 then NULL ELSE (CAST(SUM([ApptDNA])AS DECIMAL)/CAST(SUM(Appointments)AS DECIMAL)) END, 2) AS DNARate, 
		ROUND(CASE WHEN SUM(NotCaseness) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM(NotCaseness) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS NotCaseness , 
		ROUND(CASE WHEN SUM(a.SelfReferral) <5 OR SUM(Referrals) <5  then NULL ELSE (CAST(SUM(a.SelfReferral) AS DECIMAL)/CAST(SUM(Referrals)AS DECIMAL)) END, 2) AS SelfReferralRate,
		ROUND(CASE WHEN SUM(EndedBeforeTreatment) <5 OR SUM(Referrals) <5  then NULL ELSE (CAST(SUM(EndedBeforeTreatment) AS DECIMAL)/CAST(SUM(Referrals)AS DECIMAL)) END, 2) AS Attrition , 
		ROUND(CASE WHEN SUM(Waiting6Weeks) <5 OR SUM(WaitingForTreatment) <5  then NULL ELSE (CAST(SUM(Waiting6Weeks) AS DECIMAL)/CAST(SUM(WaitingForTreatment)AS DECIMAL)) END, 2) AS WaitingForTreatment6WeeksRate , 
		ROUND(CASE WHEN SUM(Waiting18Weeks) <5 OR SUM(WaitingForTreatment) <5   then NULL ELSE (CAST(SUM(Waiting18Weeks) AS DECIMAL)/CAST(SUM(WaitingForTreatment)AS DECIMAL)) END, 2) AS WaitingForTreatment18WeeksRate ,
		ROUND(CASE WHEN SUM(FirstTreatment6Weeks) <5 OR SUM(EnteringTreatment) <5   then NULL ELSE (CAST(SUM(FirstTreatment6Weeks)AS DECIMAL)/CAST(SUM(EnteringTreatment)AS DECIMAL)) END, 2) AS  FirstTreatmentWaited6WeeksRate ,
		ROUND(CASE WHEN SUM(FirstTreatment18Weeks) <5 OR SUM(EnteringTreatment) <5   then NULL ELSE(CAST( SUM(FirstTreatment18Weeks)AS DECIMAL)/CAST(SUM(EnteringTreatment)AS DECIMAL)) END, 2) AS FirstTreatmentWaited18WeeksRate , 
		ROUND(CASE WHEN SUM(FinishedCourseTreatmentWaited6Weeks) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5   then NULL ELSE (CAST(SUM(FinishedCourseTreatmentWaited6Weeks)AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS FinishedCourseTreatment6WeeksRate ,
		ROUND(CASE WHEN SUM(FinishedCourseTreatmentWaited18Weeks) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5   then NULL ELSE (CAST(SUM(FinishedCourseTreatmentWaited18Weeks) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS FinishedCourseTreatment18WeeksRate ,
		ROUND(CASE WHEN SUM(CountAppropriatePairedADSM) <5 OR SUM(ADSMFinishedTreatment) <5   then NULL ELSE (CAST(SUM(CountAppropriatePairedADSM) AS DECIMAL)/CAST(SUM(ADSMFinishedTreatment)AS DECIMAL)) END, 2) AS ADSMCompletenessRate,
		ROUND(CASE WHEN (SUM([OpenReferral91-120DaysNoContact])+SUM([OpenReferralOver120daysNoContact])) <5 OR SUM(OpenReferral) <5   then NULL ELSE (CAST((SUM([OpenReferral91-120DaysNoContact])+SUM([OpenReferralOver120daysNoContact])) AS DECIMAL)/CAST(SUM(OpenReferral)AS DECIMAL)) END, 2) AS OpenReferral90daysRate,
		ROUND(CASE WHEN SUM(a.[FirstToSecondMoreThan90Days]) <5 OR SUM(a.[FirstToSecond28Days]+[FirstToSecond28To56Days]+[FirstToSecond57To90Days]+a.[FirstToSecondMoreThan90Days]) <5   then NULL ELSE (CAST(SUM(a.[FirstToSecondMoreThan90Days]) AS DECIMAL)/CAST(SUM(a.[FirstToSecond28Days]+[FirstToSecond28To56Days]+[FirstToSecond57To90Days]+a.[FirstToSecondMoreThan90Days])AS DECIMAL)) END, 2) AS FirsttoSecond90daysRate

FROM	[NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_Region_Test_2] a
		LEFT JOIN [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_IST_New_Indicators_v2] b 
		ON a.[Month] = b.[Month] AND a.[Provider Code]=b.[Provider Code] AND a.[CCG Code] = b.[CCG Code] AND a.[STP Code]=b.[STP Code] AND a.[Region Code] = b.[Region Code] AND a.Variable = b.Variable

WHERE a.Category = 'Total' AND a.[Month] = @MonthYear

GROUP BY a.[Month], a.[Region Code], a.[Region Name]

UNION ---------------------------------------------------------

SELECT a.[Month], 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		'All' AS 'Region Code',
		'All' AS 'Region Name',
		'All' AS 'CCG Code',
		'All' AS 'CCG Name',
		'All' AS 'Provider Code',
		'All' AS 'Provider Name',
		a.[STP Code] AS 'STP Code',
		a.[STP Name] AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		CASE WHEN SUM(a.SelfReferral)< 5 THEN NULL ELSE CAST(ROUND((SUM(a.SelfReferral)+2) /5,0)*5 AS INT)  END AS SelfReferral,
		CASE WHEN SUM(EndedBeforeTreatment)< 5 THEN NULL ELSE CAST(ROUND((SUM(EndedBeforeTreatment)+2) /5,0)*5 AS INT)  END AS EndedBeforeTreatment,
		CASE WHEN SUM(FirstTreatment2Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment2Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment2Weeks,
		CASE WHEN SUM(FirstTreatment6Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment6Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment6Weeks,
		CASE WHEN SUM(FirstTreatment12Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment12Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment12Weeks,
		CASE WHEN SUM(FirstTreatment18Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment18Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment18Weeks,
		CASE WHEN SUM(WaitingForTreatment)< 5 THEN NULL ELSE CAST(ROUND((SUM(WaitingForTreatment)+2) /5,0)*5 AS INT)  END AS WaitingForTreatment,
		CASE WHEN SUM(Appointments)< 5 THEN NULL ELSE CAST(ROUND((SUM(Appointments)+2) /5,0)*5 AS INT)  END AS Appointments,
		CASE WHEN SUM([ApptDNA])< 5 THEN NULL ELSE CAST(ROUND((SUM([ApptDNA])+2) /5,0)*5 AS INT)  END AS 'Appointments DNA',
		CASE WHEN SUM(ReferralsEnded)< 5 THEN NULL ELSE CAST(ROUND((SUM(ReferralsEnded)+2) /5,0)*5 AS INT)  END AS ReferralsEnded,
		CASE WHEN SUM(EndedTreatedOnce)< 5 THEN NULL ELSE CAST(ROUND((SUM(EndedTreatedOnce)+2) /5,0)*5 AS INT)  END AS EndedTreatedOnce,
		CASE WHEN SUM(Waiting2Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting2Weeks)+2) /5,0)*5 AS INT)  END AS Waiting2Weeks,
		CASE WHEN SUM(Waiting4Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting4Weeks)+2) /5,0)*5 AS INT)  END AS Waiting4Weeks,
		CASE WHEN SUM(Waiting6Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting6Weeks)+2) /5,0)*5 AS INT)  END AS Waiting6Weeks,
		CASE WHEN SUM(Waiting12Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting12Weeks)+2) /5,0)*5 AS INT)  END AS Waiting12Weeks,
		CASE WHEN SUM(Waiting18Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting18Weeks)+2) /5,0)*5 AS INT)  END AS Waiting18Weeks,
		CASE WHEN SUM(FinishedCourseTreatmentWaited6Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FinishedCourseTreatmentWaited6Weeks)+2) /5,0)*5 AS INT)  END AS FinishedCourseTreatmentWaited6Weeks,
		CASE WHEN SUM(FinishedCourseTreatmentWaited18Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FinishedCourseTreatmentWaited18Weeks)+2) /5,0)*5 AS INT)  END AS FinishedCourseTreatmentWaited18Weeks,
		CASE WHEN SUM(a.FirstToSecond28Days)< 5 THEN NULL ELSE CAST(ROUND((SUM(a.FirstToSecond28Days)+2) /5,0)*5 AS INT)  END AS FirstToSecond28Days,
		CASE WHEN SUM(b.[FirstToSecond28To90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM(b.[FirstToSecond28To90Days])+2) /5,0)*5 AS INT)  END AS 'FirstToSecond90Days',
		CASE WHEN SUM(a.[FirstToSecondMoreThan90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM(a.[FirstToSecondMoreThan90Days])+2) /5,0)*5 AS INT)  END AS 'FirstToSecondOver90Days',
		NULL AS 'RightcareSimilarCCG',
		'STP' AS 'Level',
		ROUND(CASE WHEN SUM(Recovery) <5 OR (SUM([Finished Treatment - 2 or more Apps])-SUM(NotCaseness)) <5 then NULL ELSE (CAST(SUM(Recovery)AS DECIMAL)/CAST((SUM([Finished Treatment - 2 or more Apps])-SUM(NotCaseness))AS DECIMAL)) END, 2) AS RecoveryRate , 
		ROUND(CASE WHEN SUM([Reliable Improvement]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5 then NULL ELSE (CAST(SUM([Reliable Improvement])AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps])AS DECIMAL)) END, 2) AS ReliableImprovementRate , 
		ROUND(CASE WHEN SUM([Reliable Deterioration]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM([Reliable Deterioration]) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS DeteriorationRate ,
		ROUND(CASE WHEN SUM([No Change]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM([No Change])AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS NoChangeRate ,
		ROUND(CASE WHEN SUM([ApptDNA]) <5 OR SUM(Appointments) <5 then NULL ELSE (CAST(SUM([ApptDNA])AS DECIMAL)/CAST(SUM(Appointments)AS DECIMAL)) END, 2) AS DNARate, 
		ROUND(CASE WHEN SUM(NotCaseness) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM(NotCaseness) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS NotCaseness , 
		ROUND(CASE WHEN SUM(a.SelfReferral) <5 OR SUM(Referrals) <5  then NULL ELSE (CAST(SUM(a.SelfReferral) AS DECIMAL)/CAST(SUM(Referrals)AS DECIMAL)) END, 2) AS SelfReferralRate,
		ROUND(CASE WHEN SUM(EndedBeforeTreatment) <5 OR SUM(Referrals) <5  then NULL ELSE (CAST(SUM(EndedBeforeTreatment) AS DECIMAL)/CAST(SUM(Referrals)AS DECIMAL)) END, 2) AS Attrition , 
		ROUND(CASE WHEN SUM(Waiting6Weeks) <5 OR SUM(WaitingForTreatment) <5  then NULL ELSE (CAST(SUM(Waiting6Weeks) AS DECIMAL)/CAST(SUM(WaitingForTreatment)AS DECIMAL)) END, 2) AS WaitingForTreatment6WeeksRate , 
		ROUND(CASE WHEN SUM(Waiting18Weeks) <5 OR SUM(WaitingForTreatment) <5   then NULL ELSE (CAST(SUM(Waiting18Weeks) AS DECIMAL)/CAST(SUM(WaitingForTreatment)AS DECIMAL)) END, 2) AS WaitingForTreatment18WeeksRate ,
		ROUND(CASE WHEN SUM(FirstTreatment6Weeks) <5 OR SUM(EnteringTreatment) <5   then NULL ELSE (CAST(SUM(FirstTreatment6Weeks)AS DECIMAL)/CAST(SUM(EnteringTreatment)AS DECIMAL)) END, 2) AS  FirstTreatmentWaited6WeeksRate ,
		ROUND(CASE WHEN SUM(FirstTreatment18Weeks) <5 OR SUM(EnteringTreatment) <5   then NULL ELSE(CAST( SUM(FirstTreatment18Weeks)AS DECIMAL)/CAST(SUM(EnteringTreatment)AS DECIMAL)) END, 2) AS FirstTreatmentWaited18WeeksRate , 
		ROUND(CASE WHEN SUM(FinishedCourseTreatmentWaited6Weeks) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5   then NULL ELSE (CAST(SUM(FinishedCourseTreatmentWaited6Weeks)AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS FinishedCourseTreatment6WeeksRate ,
		ROUND(CASE WHEN SUM(FinishedCourseTreatmentWaited18Weeks) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5   then NULL ELSE (CAST(SUM(FinishedCourseTreatmentWaited18Weeks) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS FinishedCourseTreatment18WeeksRate ,
		ROUND(CASE WHEN SUM(CountAppropriatePairedADSM) <5 OR SUM(ADSMFinishedTreatment) <5   then NULL ELSE (CAST(SUM(CountAppropriatePairedADSM) AS DECIMAL)/CAST(SUM(ADSMFinishedTreatment)AS DECIMAL)) END, 2) AS ADSMCompletenessRate,
		ROUND(CASE WHEN (SUM([OpenReferral91-120DaysNoContact])+SUM([OpenReferralOver120daysNoContact])) <5 OR SUM(OpenReferral) <5   then NULL ELSE (CAST((SUM([OpenReferral91-120DaysNoContact])+SUM([OpenReferralOver120daysNoContact])) AS DECIMAL)/CAST(SUM(OpenReferral)AS DECIMAL)) END, 2) AS OpenReferral90daysRate,
		ROUND(CASE WHEN SUM(a.[FirstToSecondMoreThan90Days]) <5 OR SUM(a.[FirstToSecond28Days]+[FirstToSecond28To56Days]+[FirstToSecond57To90Days]+a.[FirstToSecondMoreThan90Days]) <5   then NULL ELSE (CAST(SUM(a.[FirstToSecondMoreThan90Days]) AS DECIMAL)/CAST(SUM(a.[FirstToSecond28Days]+[FirstToSecond28To56Days]+[FirstToSecond57To90Days]+a.[FirstToSecondMoreThan90Days])AS DECIMAL)) END, 2) AS FirsttoSecond90daysRate

FROM	[NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_Region_Test_2] a
		LEFT JOIN [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_IST_New_Indicators_v2] b 
		ON a.[Month] = b.[Month] AND a.[Provider Code]=b.[Provider Code] AND a.[CCG Code] = b.[CCG Code] AND a.[STP Code]=b.[STP Code] AND a.[Region Code] = b.[Region Code] AND a.Variable = b.Variable

WHERE a.Category = 'Total' AND a.[Month] = @MonthYear

GROUP BY a.[Month], a.[STP Code], a.[STP Name]

UNION ---------------------------------------------------------

SELECT a.[Month], 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		'All' AS 'Region Code',
		'All' AS 'Region Name',
		a.[CCG Code] AS 'CCG Code',
		a.[CCG Name] AS 'CCG Name',
		'All' AS 'Provider Code',
		'All' AS 'Provider Name',
		'All' AS 'STP Code',
		'All' AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		CASE WHEN SUM(a.SelfReferral)< 5 THEN NULL ELSE CAST(ROUND((SUM(a.SelfReferral)+2) /5,0)*5 AS INT)  END AS SelfReferral,
		CASE WHEN SUM(EndedBeforeTreatment)< 5 THEN NULL ELSE CAST(ROUND((SUM(EndedBeforeTreatment)+2) /5,0)*5 AS INT)  END AS EndedBeforeTreatment,
		CASE WHEN SUM(FirstTreatment2Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment2Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment2Weeks,
		CASE WHEN SUM(FirstTreatment6Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment6Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment6Weeks,
		CASE WHEN SUM(FirstTreatment12Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment12Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment12Weeks,
		CASE WHEN SUM(FirstTreatment18Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment18Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment18Weeks,
		CASE WHEN SUM(WaitingForTreatment)< 5 THEN NULL ELSE CAST(ROUND((SUM(WaitingForTreatment)+2) /5,0)*5 AS INT)  END AS WaitingForTreatment,
		CASE WHEN SUM(Appointments)< 5 THEN NULL ELSE CAST(ROUND((SUM(Appointments)+2) /5,0)*5 AS INT)  END AS Appointments,
		CASE WHEN SUM([ApptDNA])< 5 THEN NULL ELSE CAST(ROUND((SUM([ApptDNA])+2) /5,0)*5 AS INT)  END AS 'Appointments DNA',
		CASE WHEN SUM(ReferralsEnded)< 5 THEN NULL ELSE CAST(ROUND((SUM(ReferralsEnded)+2) /5,0)*5 AS INT)  END AS ReferralsEnded,
		CASE WHEN SUM(EndedTreatedOnce)< 5 THEN NULL ELSE CAST(ROUND((SUM(EndedTreatedOnce)+2) /5,0)*5 AS INT)  END AS EndedTreatedOnce,
		CASE WHEN SUM(Waiting2Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting2Weeks)+2) /5,0)*5 AS INT)  END AS Waiting2Weeks,
		CASE WHEN SUM(Waiting4Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting4Weeks)+2) /5,0)*5 AS INT)  END AS Waiting4Weeks,
		CASE WHEN SUM(Waiting6Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting6Weeks)+2) /5,0)*5 AS INT)  END AS Waiting6Weeks,
		CASE WHEN SUM(Waiting12Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting12Weeks)+2) /5,0)*5 AS INT)  END AS Waiting12Weeks,
		CASE WHEN SUM(Waiting18Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting18Weeks)+2) /5,0)*5 AS INT)  END AS Waiting18Weeks,
		CASE WHEN SUM(FinishedCourseTreatmentWaited6Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FinishedCourseTreatmentWaited6Weeks)+2) /5,0)*5 AS INT)  END AS FinishedCourseTreatmentWaited6Weeks,
		CASE WHEN SUM(FinishedCourseTreatmentWaited18Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FinishedCourseTreatmentWaited18Weeks)+2) /5,0)*5 AS INT)  END AS FinishedCourseTreatmentWaited18Weeks,
		CASE WHEN SUM(a.FirstToSecond28Days)< 5 THEN NULL ELSE CAST(ROUND((SUM(a.FirstToSecond28Days)+2) /5,0)*5 AS INT)  END AS FirstToSecond28Days,
		CASE WHEN SUM(b.[FirstToSecond28To90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM(b.[FirstToSecond28To90Days])+2) /5,0)*5 AS INT)  END AS 'FirstToSecond90Days',
		CASE WHEN SUM(a.[FirstToSecondMoreThan90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM(a.[FirstToSecondMoreThan90Days])+2) /5,0)*5 AS INT)  END AS 'FirstToSecondOver90Days',
		NULL AS RightcareSimilarCCG,
		'CCG' AS 'Level',
		ROUND(CASE WHEN SUM(Recovery) <5 OR (SUM([Finished Treatment - 2 or more Apps])-SUM(NotCaseness)) <5 then NULL ELSE (CAST(SUM(Recovery)AS DECIMAL)/CAST((SUM([Finished Treatment - 2 or more Apps])-SUM(NotCaseness))AS DECIMAL)) END, 2) AS RecoveryRate , 
		ROUND(CASE WHEN SUM([Reliable Improvement]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5 then NULL ELSE (CAST(SUM([Reliable Improvement])AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps])AS DECIMAL)) END, 2) AS ReliableImprovementRate , 
		ROUND(CASE WHEN SUM([Reliable Deterioration]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM([Reliable Deterioration]) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS DeteriorationRate ,
		ROUND(CASE WHEN SUM([No Change]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM([No Change])AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS NoChangeRate ,
		ROUND(CASE WHEN SUM([ApptDNA]) <5 OR SUM(Appointments) <5 then NULL ELSE (CAST(SUM([ApptDNA])AS DECIMAL)/CAST(SUM(Appointments)AS DECIMAL)) END, 2) AS DNARate, 
		ROUND(CASE WHEN SUM(NotCaseness) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM(NotCaseness) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS NotCaseness , 
		ROUND(CASE WHEN SUM(a.SelfReferral) <5 OR SUM(Referrals) <5  then NULL ELSE (CAST(SUM(a.SelfReferral) AS DECIMAL)/CAST(SUM(Referrals)AS DECIMAL)) END, 2) AS SelfReferralRate,
		ROUND(CASE WHEN SUM(EndedBeforeTreatment) <5 OR SUM(Referrals) <5  then NULL ELSE (CAST(SUM(EndedBeforeTreatment) AS DECIMAL)/CAST(SUM(Referrals)AS DECIMAL)) END, 2) AS Attrition , 
		ROUND(CASE WHEN SUM(Waiting6Weeks) <5 OR SUM(WaitingForTreatment) <5  then NULL ELSE (CAST(SUM(Waiting6Weeks) AS DECIMAL)/CAST(SUM(WaitingForTreatment)AS DECIMAL)) END, 2) AS WaitingForTreatment6WeeksRate , 
		ROUND(CASE WHEN SUM(Waiting18Weeks) <5 OR SUM(WaitingForTreatment) <5   then NULL ELSE (CAST(SUM(Waiting18Weeks) AS DECIMAL)/CAST(SUM(WaitingForTreatment)AS DECIMAL)) END, 2) AS WaitingForTreatment18WeeksRate ,
		ROUND(CASE WHEN SUM(FirstTreatment6Weeks) <5 OR SUM(EnteringTreatment) <5   then NULL ELSE (CAST(SUM(FirstTreatment6Weeks)AS DECIMAL)/CAST(SUM(EnteringTreatment)AS DECIMAL)) END, 2) AS  FirstTreatmentWaited6WeeksRate ,
		ROUND(CASE WHEN SUM(FirstTreatment18Weeks) <5 OR SUM(EnteringTreatment) <5   then NULL ELSE(CAST( SUM(FirstTreatment18Weeks)AS DECIMAL)/CAST(SUM(EnteringTreatment)AS DECIMAL)) END, 2) AS FirstTreatmentWaited18WeeksRate , 
		ROUND(CASE WHEN SUM(FinishedCourseTreatmentWaited6Weeks) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5   then NULL ELSE (CAST(SUM(FinishedCourseTreatmentWaited6Weeks)AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS FinishedCourseTreatment6WeeksRate ,
		ROUND(CASE WHEN SUM(FinishedCourseTreatmentWaited18Weeks) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5   then NULL ELSE (CAST(SUM(FinishedCourseTreatmentWaited18Weeks) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS FinishedCourseTreatment18WeeksRate ,
		ROUND(CASE WHEN SUM(CountAppropriatePairedADSM) <5 OR SUM(ADSMFinishedTreatment) <5   then NULL ELSE (CAST(SUM(CountAppropriatePairedADSM) AS DECIMAL)/CAST(SUM(ADSMFinishedTreatment)AS DECIMAL)) END, 2) AS ADSMCompletenessRate,
		ROUND(CASE WHEN (SUM([OpenReferral91-120DaysNoContact])+SUM([OpenReferralOver120daysNoContact])) <5 OR SUM(OpenReferral) <5   then NULL ELSE (CAST((SUM([OpenReferral91-120DaysNoContact])+SUM([OpenReferralOver120daysNoContact])) AS DECIMAL)/CAST(SUM(OpenReferral)AS DECIMAL)) END, 2) AS OpenReferral90daysRate,
		ROUND(CASE WHEN SUM(a.[FirstToSecondMoreThan90Days]) <5 OR SUM(a.[FirstToSecond28Days]+[FirstToSecond28To56Days]+[FirstToSecond57To90Days]+a.[FirstToSecondMoreThan90Days]) <5   then NULL ELSE (CAST(SUM(a.[FirstToSecondMoreThan90Days]) AS DECIMAL)/CAST(SUM(a.[FirstToSecond28Days]+[FirstToSecond28To56Days]+[FirstToSecond57To90Days]+a.[FirstToSecondMoreThan90Days])AS DECIMAL)) END, 2) AS FirsttoSecond90daysRate

FROM	[NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_Region_Test_2] a
		LEFT JOIN [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_IST_New_Indicators_v2] b 
		ON a.[Month] = b.[Month] AND a.[Provider Code]=b.[Provider Code] AND a.[CCG Code] = b.[CCG Code] AND a.[STP Code]=b.[STP Code] AND a.[Region Code] = b.[Region Code] AND a.Variable = b.Variable

WHERE a.Category = 'Total' AND a.[Month] = @MonthYear

GROUP BY a.[Month], a.[CCG Code], a.[CCG Name]

UNION ---------------------------------------------------------

SELECT a.[Month], 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		'All' AS 'Region Code',
		'All' AS 'Region Name',
		'All' AS 'CCG Code',
		'All' AS 'CCG Name',
		a.[Provider Code] AS 'Provider Code',
		a.[Provider Name] AS 'Provider Name',
		'All' AS 'STP Code',
		'All' AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		CASE WHEN SUM(a.SelfReferral)< 5 THEN NULL ELSE CAST(ROUND((SUM(a.SelfReferral)+2) /5,0)*5 AS INT)  END AS SelfReferral,
		CASE WHEN SUM(EndedBeforeTreatment)< 5 THEN NULL ELSE CAST(ROUND((SUM(EndedBeforeTreatment)+2) /5,0)*5 AS INT)  END AS EndedBeforeTreatment,
		CASE WHEN SUM(FirstTreatment2Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment2Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment2Weeks,
		CASE WHEN SUM(FirstTreatment6Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment6Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment6Weeks,
		CASE WHEN SUM(FirstTreatment12Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment12Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment12Weeks,
		CASE WHEN SUM(FirstTreatment18Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment18Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment18Weeks,
		CASE WHEN SUM(WaitingForTreatment)< 5 THEN NULL ELSE CAST(ROUND((SUM(WaitingForTreatment)+2) /5,0)*5 AS INT)  END AS WaitingForTreatment,
		CASE WHEN SUM(Appointments)< 5 THEN NULL ELSE CAST(ROUND((SUM(Appointments)+2) /5,0)*5 AS INT)  END AS Appointments,
		CASE WHEN SUM([ApptDNA])< 5 THEN NULL ELSE CAST(ROUND((SUM([ApptDNA])+2) /5,0)*5 AS INT)  END AS 'Appointments DNA',
		CASE WHEN SUM(ReferralsEnded)< 5 THEN NULL ELSE CAST(ROUND((SUM(ReferralsEnded)+2) /5,0)*5 AS INT)  END AS ReferralsEnded,
		CASE WHEN SUM(EndedTreatedOnce)< 5 THEN NULL ELSE CAST(ROUND((SUM(EndedTreatedOnce)+2) /5,0)*5 AS INT)  END AS EndedTreatedOnce,
		CASE WHEN SUM(Waiting2Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting2Weeks)+2) /5,0)*5 AS INT)  END AS Waiting2Weeks,
		CASE WHEN SUM(Waiting4Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting4Weeks)+2) /5,0)*5 AS INT)  END AS Waiting4Weeks,
		CASE WHEN SUM(Waiting6Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting6Weeks)+2) /5,0)*5 AS INT)  END AS Waiting6Weeks,
		CASE WHEN SUM(Waiting12Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting12Weeks)+2) /5,0)*5 AS INT)  END AS Waiting12Weeks,
		CASE WHEN SUM(Waiting18Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting18Weeks)+2) /5,0)*5 AS INT)  END AS Waiting18Weeks,
		CASE WHEN SUM(FinishedCourseTreatmentWaited6Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FinishedCourseTreatmentWaited6Weeks)+2) /5,0)*5 AS INT)  END AS FinishedCourseTreatmentWaited6Weeks,
		CASE WHEN SUM(FinishedCourseTreatmentWaited18Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FinishedCourseTreatmentWaited18Weeks)+2) /5,0)*5 AS INT)  END AS FinishedCourseTreatmentWaited18Weeks,
		CASE WHEN SUM(a.FirstToSecond28Days)< 5 THEN NULL ELSE CAST(ROUND((SUM(a.FirstToSecond28Days)+2) /5,0)*5 AS INT)  END AS FirstToSecond28Days,
		CASE WHEN SUM(b.[FirstToSecond28To90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM(b.[FirstToSecond28To90Days])+2) /5,0)*5 AS INT)  END AS 'FirstToSecond90Days',
		CASE WHEN SUM(a.[FirstToSecondMoreThan90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM(a.[FirstToSecondMoreThan90Days])+2) /5,0)*5 AS INT)  END AS 'FirstToSecondOver90Days',
		NULL AS 'RightcareSimilarCCG',
		'Provider' AS 'Level',
		ROUND(CASE WHEN SUM(Recovery) <5 OR (SUM([Finished Treatment - 2 or more Apps])-SUM(NotCaseness)) <5 then NULL ELSE (CAST(SUM(Recovery)AS DECIMAL)/CAST((SUM([Finished Treatment - 2 or more Apps])-SUM(NotCaseness))AS DECIMAL)) END, 2) AS RecoveryRate , 
		ROUND(CASE WHEN SUM([Reliable Improvement]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5 then NULL ELSE (CAST(SUM([Reliable Improvement])AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps])AS DECIMAL)) END, 2) AS ReliableImprovementRate , 
		ROUND(CASE WHEN SUM([Reliable Deterioration]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM([Reliable Deterioration]) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS DeteriorationRate ,
		ROUND(CASE WHEN SUM([No Change]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM([No Change])AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS NoChangeRate ,
		ROUND(CASE WHEN SUM([ApptDNA]) <5 OR SUM(Appointments) <5 then NULL ELSE (CAST(SUM([ApptDNA])AS DECIMAL)/CAST(SUM(Appointments)AS DECIMAL)) END, 2) AS DNARate, 
		ROUND(CASE WHEN SUM(NotCaseness) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM(NotCaseness) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS NotCaseness , 
		ROUND(CASE WHEN SUM(a.SelfReferral) <5 OR SUM(Referrals) <5  then NULL ELSE (CAST(SUM(a.SelfReferral) AS DECIMAL)/CAST(SUM(Referrals)AS DECIMAL)) END, 2) AS SelfReferralRate,
		ROUND(CASE WHEN SUM(EndedBeforeTreatment) <5 OR SUM(Referrals) <5  then NULL ELSE (CAST(SUM(EndedBeforeTreatment) AS DECIMAL)/CAST(SUM(Referrals)AS DECIMAL)) END, 2) AS Attrition , 
		ROUND(CASE WHEN SUM(Waiting6Weeks) <5 OR SUM(WaitingForTreatment) <5  then NULL ELSE (CAST(SUM(Waiting6Weeks) AS DECIMAL)/CAST(SUM(WaitingForTreatment)AS DECIMAL)) END, 2) AS WaitingForTreatment6WeeksRate , 
		ROUND(CASE WHEN SUM(Waiting18Weeks) <5 OR SUM(WaitingForTreatment) <5   then NULL ELSE (CAST(SUM(Waiting18Weeks) AS DECIMAL)/CAST(SUM(WaitingForTreatment)AS DECIMAL)) END, 2) AS WaitingForTreatment18WeeksRate ,
		ROUND(CASE WHEN SUM(FirstTreatment6Weeks) <5 OR SUM(EnteringTreatment) <5   then NULL ELSE (CAST(SUM(FirstTreatment6Weeks)AS DECIMAL)/CAST(SUM(EnteringTreatment)AS DECIMAL)) END, 2) AS  FirstTreatmentWaited6WeeksRate ,
		ROUND(CASE WHEN SUM(FirstTreatment18Weeks) <5 OR SUM(EnteringTreatment) <5   then NULL ELSE(CAST( SUM(FirstTreatment18Weeks)AS DECIMAL)/CAST(SUM(EnteringTreatment)AS DECIMAL)) END, 2) AS FirstTreatmentWaited18WeeksRate , 
		ROUND(CASE WHEN SUM(FinishedCourseTreatmentWaited6Weeks) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5   then NULL ELSE (CAST(SUM(FinishedCourseTreatmentWaited6Weeks)AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS FinishedCourseTreatment6WeeksRate ,
		ROUND(CASE WHEN SUM(FinishedCourseTreatmentWaited18Weeks) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5   then NULL ELSE (CAST(SUM(FinishedCourseTreatmentWaited18Weeks) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS FinishedCourseTreatment18WeeksRate ,
		ROUND(CASE WHEN SUM(CountAppropriatePairedADSM) <5 OR SUM(ADSMFinishedTreatment) <5   then NULL ELSE (CAST(SUM(CountAppropriatePairedADSM) AS DECIMAL)/CAST(SUM(ADSMFinishedTreatment)AS DECIMAL)) END, 2) AS ADSMCompletenessRate,
		ROUND(CASE WHEN (SUM([OpenReferral91-120DaysNoContact])+SUM([OpenReferralOver120daysNoContact])) <5 OR SUM(OpenReferral) <5   then NULL ELSE (CAST((SUM([OpenReferral91-120DaysNoContact])+SUM([OpenReferralOver120daysNoContact])) AS DECIMAL)/CAST(SUM(OpenReferral)AS DECIMAL)) END, 2) AS OpenReferral90daysRate,
		ROUND(CASE WHEN SUM(a.[FirstToSecondMoreThan90Days]) <5 OR SUM(a.[FirstToSecond28Days]+[FirstToSecond28To56Days]+[FirstToSecond57To90Days]+a.[FirstToSecondMoreThan90Days]) <5   then NULL ELSE (CAST(SUM(a.[FirstToSecondMoreThan90Days]) AS DECIMAL)/CAST(SUM(a.[FirstToSecond28Days]+[FirstToSecond28To56Days]+[FirstToSecond57To90Days]+a.[FirstToSecondMoreThan90Days])AS DECIMAL)) END, 2) AS FirsttoSecond90daysRate

FROM	[NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_Region_Test_2] a
		LEFT JOIN [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_IST_New_Indicators_v2] b 
		ON a.[Month] = b.[Month] AND a.[Provider Code]=b.[Provider Code] AND a.[CCG Code] = b.[CCG Code] AND a.[STP Code]=b.[STP Code] AND a.[Region Code] = b.[Region Code] AND a.Variable = b.Variable

WHERE a.Category = 'Total' AND a.[Month] = @MonthYear

GROUP BY a.[Month],  a.[Provider Code], a.[Provider Name]

UNION ---------------------------------------------------------

SELECT a.[Month], 
		'Refresh' AS DataSource,
		'England' AS GroupType,
		'All' AS 'Region Code',
		'All' AS 'Region Name',
		a.[CCG Code] AS 'CCG Code',
		a.[CCG Name] AS 'CCG Name',
		a.[Provider Code] AS 'Provider Code',
		a.[Provider Name] AS 'Provider Name',
		'All' AS 'STP Code',
		'All' AS 'STP Name',
		'Total' AS Category,
		'Total' AS Variable,
		CASE WHEN SUM(a.SelfReferral)< 5 THEN NULL ELSE CAST(ROUND((SUM(a.SelfReferral)+2) /5,0)*5 AS INT)  END AS SelfReferral,
		CASE WHEN SUM(EndedBeforeTreatment)< 5 THEN NULL ELSE CAST(ROUND((SUM(EndedBeforeTreatment)+2) /5,0)*5 AS INT)  END AS EndedBeforeTreatment,
		CASE WHEN SUM(FirstTreatment2Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment2Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment2Weeks,
		CASE WHEN SUM(FirstTreatment6Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment6Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment6Weeks,
		CASE WHEN SUM(FirstTreatment12Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment12Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment12Weeks,
		CASE WHEN SUM(FirstTreatment18Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FirstTreatment18Weeks)+2) /5,0)*5 AS INT)  END AS FirstTreatment18Weeks,
		CASE WHEN SUM(WaitingForTreatment)< 5 THEN NULL ELSE CAST(ROUND((SUM(WaitingForTreatment)+2) /5,0)*5 AS INT)  END AS WaitingForTreatment,
		CASE WHEN SUM(Appointments)< 5 THEN NULL ELSE CAST(ROUND((SUM(Appointments)+2) /5,0)*5 AS INT)  END AS Appointments,
		CASE WHEN SUM([ApptDNA])< 5 THEN NULL ELSE CAST(ROUND((SUM([ApptDNA])+2) /5,0)*5 AS INT)  END AS 'Appointments DNA',
		CASE WHEN SUM(ReferralsEnded)< 5 THEN NULL ELSE CAST(ROUND((SUM(ReferralsEnded)+2) /5,0)*5 AS INT)  END AS ReferralsEnded,
		CASE WHEN SUM(EndedTreatedOnce)< 5 THEN NULL ELSE CAST(ROUND((SUM(EndedTreatedOnce)+2) /5,0)*5 AS INT)  END AS EndedTreatedOnce,
		CASE WHEN SUM(Waiting2Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting2Weeks)+2) /5,0)*5 AS INT)  END AS Waiting2Weeks,
		CASE WHEN SUM(Waiting4Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting4Weeks)+2) /5,0)*5 AS INT)  END AS Waiting4Weeks,
		CASE WHEN SUM(Waiting6Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting6Weeks)+2) /5,0)*5 AS INT)  END AS Waiting6Weeks,
		CASE WHEN SUM(Waiting12Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting12Weeks)+2) /5,0)*5 AS INT)  END AS Waiting12Weeks,
		CASE WHEN SUM(Waiting18Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(Waiting18Weeks)+2) /5,0)*5 AS INT)  END AS Waiting18Weeks,
		CASE WHEN SUM(FinishedCourseTreatmentWaited6Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FinishedCourseTreatmentWaited6Weeks)+2) /5,0)*5 AS INT)  END AS FinishedCourseTreatmentWaited6Weeks,
		CASE WHEN SUM(FinishedCourseTreatmentWaited18Weeks)< 5 THEN NULL ELSE CAST(ROUND((SUM(FinishedCourseTreatmentWaited18Weeks)+2) /5,0)*5 AS INT)  END AS FinishedCourseTreatmentWaited18Weeks,
		CASE WHEN SUM(a.FirstToSecond28Days)< 5 THEN NULL ELSE CAST(ROUND((SUM(a.FirstToSecond28Days)+2) /5,0)*5 AS INT)  END AS FirstToSecond28Days,
		CASE WHEN SUM(b.[FirstToSecond28To90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM(b.[FirstToSecond28To90Days])+2) /5,0)*5 AS INT)  END AS 'FirstToSecond90Days',
		CASE WHEN SUM(a.[FirstToSecondMoreThan90Days])< 5 THEN NULL ELSE CAST(ROUND((SUM(a.[FirstToSecondMoreThan90Days])+2) /5,0)*5 AS INT)  END AS 'FirstToSecondOver90Days',
		NULL AS 'RightcareSimilarCCG',
		'CCG/ Provider' AS 'Level',
		ROUND(CASE WHEN SUM(Recovery) <5 OR (SUM([Finished Treatment - 2 or more Apps])-SUM(NotCaseness)) <5 then NULL ELSE (CAST(SUM(Recovery)AS DECIMAL)/CAST((SUM([Finished Treatment - 2 or more Apps])-SUM(NotCaseness))AS DECIMAL)) END, 2) AS RecoveryRate , 
		ROUND(CASE WHEN SUM([Reliable Improvement]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5 then NULL ELSE (CAST(SUM([Reliable Improvement])AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps])AS DECIMAL)) END, 2) AS ReliableImprovementRate , 
		ROUND(CASE WHEN SUM([Reliable Deterioration]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM([Reliable Deterioration]) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS DeteriorationRate ,
		ROUND(CASE WHEN SUM([No Change]) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM([No Change])AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS NoChangeRate ,
		ROUND(CASE WHEN SUM([ApptDNA]) <5 OR SUM(Appointments) <5 then NULL ELSE (CAST(SUM([ApptDNA])AS DECIMAL)/CAST(SUM(Appointments)AS DECIMAL)) END, 2) AS DNARate, 
		ROUND(CASE WHEN SUM(NotCaseness) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5  then NULL ELSE (CAST(SUM(NotCaseness) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS NotCaseness , 
		ROUND(CASE WHEN SUM(a.SelfReferral) <5 OR SUM(Referrals) <5  then NULL ELSE (CAST(SUM(a.SelfReferral) AS DECIMAL)/CAST(SUM(Referrals)AS DECIMAL)) END, 2) AS SelfReferralRate,
		ROUND(CASE WHEN SUM(EndedBeforeTreatment) <5 OR SUM(Referrals) <5  then NULL ELSE (CAST(SUM(EndedBeforeTreatment) AS DECIMAL)/CAST(SUM(Referrals)AS DECIMAL)) END, 2) AS Attrition , 
		ROUND(CASE WHEN SUM(Waiting6Weeks) <5 OR SUM(WaitingForTreatment) <5  then NULL ELSE (CAST(SUM(Waiting6Weeks) AS DECIMAL)/CAST(SUM(WaitingForTreatment)AS DECIMAL)) END, 2) AS WaitingForTreatment6WeeksRate , 
		ROUND(CASE WHEN SUM(Waiting18Weeks) <5 OR SUM(WaitingForTreatment) <5   then NULL ELSE (CAST(SUM(Waiting18Weeks) AS DECIMAL)/CAST(SUM(WaitingForTreatment)AS DECIMAL)) END, 2) AS WaitingForTreatment18WeeksRate ,
		ROUND(CASE WHEN SUM(FirstTreatment6Weeks) <5 OR SUM(EnteringTreatment) <5   then NULL ELSE (CAST(SUM(FirstTreatment6Weeks)AS DECIMAL)/CAST(SUM(EnteringTreatment)AS DECIMAL)) END, 2) AS  FirstTreatmentWaited6WeeksRate ,
		ROUND(CASE WHEN SUM(FirstTreatment18Weeks) <5 OR SUM(EnteringTreatment) <5   then NULL ELSE(CAST( SUM(FirstTreatment18Weeks)AS DECIMAL)/CAST(SUM(EnteringTreatment)AS DECIMAL)) END, 2) AS FirstTreatmentWaited18WeeksRate , 
		ROUND(CASE WHEN SUM(FinishedCourseTreatmentWaited6Weeks) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5   then NULL ELSE (CAST(SUM(FinishedCourseTreatmentWaited6Weeks)AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS FinishedCourseTreatment6WeeksRate ,
		ROUND(CASE WHEN SUM(FinishedCourseTreatmentWaited18Weeks) <5 OR SUM([Finished Treatment - 2 or more Apps]) <5   then NULL ELSE (CAST(SUM(FinishedCourseTreatmentWaited18Weeks) AS DECIMAL)/CAST(SUM([Finished Treatment - 2 or more Apps]) AS DECIMAL)) END, 2) AS FinishedCourseTreatment18WeeksRate ,
		ROUND(CASE WHEN SUM(CountAppropriatePairedADSM) <5 OR SUM(ADSMFinishedTreatment) <5   then NULL ELSE (CAST(SUM(CountAppropriatePairedADSM) AS DECIMAL)/CAST(SUM(ADSMFinishedTreatment)AS DECIMAL)) END, 2) AS ADSMCompletenessRate,
		ROUND(CASE WHEN (SUM([OpenReferral91-120DaysNoContact])+SUM([OpenReferralOver120daysNoContact])) <5 OR SUM(OpenReferral) <5   then NULL ELSE (CAST((SUM([OpenReferral91-120DaysNoContact])+SUM([OpenReferralOver120daysNoContact])) AS DECIMAL)/CAST(SUM(OpenReferral)AS DECIMAL)) END, 2) AS OpenReferral90daysRate,
		ROUND(CASE WHEN SUM(a.[FirstToSecondMoreThan90Days]) <5 OR SUM(a.[FirstToSecond28Days]+[FirstToSecond28To56Days]+[FirstToSecond57To90Days]+a.[FirstToSecondMoreThan90Days]) <5   then NULL ELSE (CAST(SUM(a.[FirstToSecondMoreThan90Days]) AS DECIMAL)/CAST(SUM(a.[FirstToSecond28Days]+[FirstToSecond28To56Days]+[FirstToSecond57To90Days]+a.[FirstToSecondMoreThan90Days])AS DECIMAL)) END, 2) AS FirsttoSecond90daysRate

FROM	[NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_Region_Test_2] a
		LEFT JOIN [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Inequalities_Monthly_IST_New_Indicators_v2] b 
		ON a.[Month] = b.[Month] AND a.[Provider Code]=b.[Provider Code] AND a.[CCG Code] = b.[CCG Code] AND a.[STP Code]=b.[STP Code] AND a.[Region Code] = b.[Region Code] AND a.Variable = b.Variable

WHERE a.Category = 'Total' AND a.[Month] = @MonthYear

GROUP BY a.[Month], a.[CCG Code], a.[CCG Name], a.[Provider Code], a.[Provider Name]

-- ALSO ENSURE RIGHTCARE CCGs ARE UPDATED EACH MONTH ---------------------------------------------------------

UPDATE [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Monthly_IST_New_Indicators_Rounded]

SET RightcareSimilarCCG = b.[Similar CCG]

FROM	[NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Monthly_IST_New_Indicators_Rounded] a
		LEFT JOIN NHSE_Sandbox_MentalHealth.[dbo].RightcareSimilar10 b ON a.[CCG Code] = b.[CCG Code] AND a.[CCG Name] = b.[CCG Name]

WHERE [Level] = 'CCG'

------------------------------------------------------------------------------------------------------------
PRINT 'Updated - [NHSE_Sandbox_MentalHealth].[dbo].[IAPT_Dashboard_Monthly_IST_New_Indicators_Rounded]'
