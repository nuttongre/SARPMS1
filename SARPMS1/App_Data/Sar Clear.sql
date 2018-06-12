Select * From Projects Where DelFlag Is Not Null
Select * From Activity
Select * From ActivityCostsDetail Where ActivityCode In (Select ActivityCode From Activity Where StudyYear = 2555)
Select * From ActivityDetail Where ActivityCode In (Select ActivityCode From Activity Where StudyYear = 2555)
Select * From Indicators2 Where ActivityCode In (Select ActivityCode From Activity Where StudyYear = 2555)
Select * From Evaluation
Select * From AttachFile Where ActivityCode In (Select ActivityCode From Activity Where StudyYear = 2555)
Select * From CostsDetail Where ActivityCode In (Select ActivityCode From Activity Where StudyYear = 2555)
Select * From dtAcDept Where ActivityCode In (Select ActivityCode From Activity Where StudyYear = 2555)
Select * From dtAcEmp Where ActivityCode In (Select ActivityCode From Activity Where StudyYear = 2555)
Select * From dtAcSubDept Where ActivityCode In (Select ActivityCode From Activity Where StudyYear = 2555)
Select * From dtEditBudgetAc Where ActivityCode In (Select ActivityCode From Activity Where StudyYear = 2555)
Select * From dtEditDateAc Where ActivityCode In (Select ActivityCode From Activity Where StudyYear = 2555)
Select * From dtStandardMinistry Where ProjectsCode In (Select ProjectsCode From Projects Where StudyYear = 2555)
Select * From dtStandardNation Where ProjectsCode In (Select ProjectsCode From Projects Where StudyYear = 2555)
Select * From dtStandardSPM Where ProjectsCode In (Select ProjectsCode From Projects Where StudyYear = 2555)
Select * From dtStrategySPM Where ProjectsCode In (Select ProjectsCode From Projects Where StudyYear = 2555)
Select * From dtStrategySPT Where ProjectsCode In (Select ProjectsCode From Projects Where StudyYear = 2555)
Select * From ProjectOperation2 Where ProjectsCode In (Select ProjectsCode From Projects Where StudyYear = 2555)
Select * From ActivityOperation2 Where ActivityCode In (Select ActivityCode From Activity Where StudyYear = 2555)
Select * From Income
Select * From IncomeDetail
Select * From SarAttach
Select * From Strategies
Select * From StrategiesIndicators
Select * From IndicatorsQuality
Select * From AttachFile2
Select * From Expenses
Select * From dtAcCostsCenter Where ActivityCode In (Select ActivityCode From Activity Where StudyYear = 2555)
Select * From dtFactor Where ActivityCode In (Select ActivityCode From Activity Where StudyYear = 2555)
Select * From Strategic
Select * From dtStrategic Where ProjectsCode In (Select ProjectsCode From Projects Where StudyYear = 2555)
Select * From ProjectsMoneyDetail Where ProjectsCode In (Select ProjectsCode From Projects Where StudyYear = 2555)
Select * From ProjectsQuarterDetail Where ProjectsCode In (Select ProjectsCode From Projects Where StudyYear = 2555)
Select * From Multimedia
Select * From dtPolicy Where ProjectsCode In (Select ProjectsCode From Projects Where StudyYear = 2555)

--
--Delete Projects
--Delete Activity
--Delete ActivityCostsDetail
--Delete ActivityDetail
--Delete Indicators2
--Delete Evaluation
--Delete AttachFile
--Delete CostsDetail
--Delete dtAcDept
--Delete dtAcEmp
--Delete dtAcSubDept
--Delete dtEditBudgetAc
--Delete dtEditDateAc
--Delete dtStandardMinistry
--Delete dtStandardNation
--Delete dtStandardSPM
--Delete dtStrategySPM
--Delete dtStrategySPT
--Delete ProjectOperation2
--Delete ActivityOperation2
--Delete Income
--Delete IncomeDetail
--Delete SarAttach
--Delete Strategies
--Delete StrategiesIndicators
--Delete IndicatorsQuality
--Delete AttachFile2
--Delete Expenses
--Delete dtFactor
--Delete Strategic
--Delete dtStrategic
--Delete ProjectsMoneyDetail
--Delete ProjectsQuarterDetail
--Delete Multimedia




