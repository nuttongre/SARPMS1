bn
--------///////-----------------Ver 11.0.0.0-------------------////////--------------

--ขยายขนาด Column
Go
alter table MR_School alter column ckRate int

--เพิ่มฟิวส์ span หน้าชื่อผู้เซ็น
Go
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'spnResponsibleName')
Begin
	alter table MR_School add spnResponsibleName nVarchar(200)
End
Go
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'spnProposeName')
Begin
	alter table MR_School add spnProposeName nVarchar(200)
End
Go
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'spnApprovalName')
Begin
	alter table MR_School add spnApprovalName nVarchar(200)
End
Go
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'spnApprovalName2')
Begin
	alter table MR_School add spnApprovalName2 nVarchar(200)
End


Go
----------เพิ่มข้อมูลกลุ่มคะแนนใน Table----------------------------------
--เพิ่มกลุ่มคะแนน 5 (3)
If Not Exists(Select * From ScoreGroup Where ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0')
Begin
	INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort, WeightScore, CreateUser, CreateDate, UpdateUser, UpdateDate, DelFlag)
	VALUES ('4BD33310-AE51-4E69-9D84-A4A8173D81F0', 'หมวดคะแนนเต็ม 5.0 (3)', 10, 5, '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A', '2015-12-18 10:28:53.067', '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A', '2015-12-18 10:28:53.067', 0)
End
Go
--เพิ่มกลุ่มคะแนน 15 (1)
If Not Exists(Select * From ScoreGroup Where ScoreGroupID = 'D7A04A29-300F-4E0F-B100-8026FF7D66D6')
Begin
	INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort, WeightScore, CreateUser, CreateDate, UpdateUser, UpdateDate, DelFlag)
	VALUES ('D7A04A29-300F-4E0F-B100-8026FF7D66D6', 'หมวดคะแนนเต็ม 15', 12, 15, '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A', '2015-12-18 10:28:53.067', '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A', '2015-12-18 10:28:53.067', 0)
End
Go
--เพิ่มกลุ่มคะแนน 25 (1)
If Not Exists(Select * From ScoreGroup Where ScoreGroupID = 'C40FC9F0-2645-4651-9FEC-D3AC1C345F96')
Begin
	INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort, WeightScore, CreateUser, CreateDate, UpdateUser, UpdateDate, DelFlag)
	VALUES ('C40FC9F0-2645-4651-9FEC-D3AC1C345F96', 'หมวดคะแนนเต็ม 25', 13, 25, '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A', '2015-12-18 10:28:53.067', '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A', '2015-12-18 10:28:53.067', 0)
End

Go
---------5.0 (N3)
--เพิ่มเกณฑ์คะแนน  5.0 (N3)
If Not Exists(Select * From TCriteria Where TcriteriaID = '46B231DE-9A6D-4956-AC87-B8242A98D6BD')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('46B231DE-9A6D-4956-AC87-B8242A98D6BD', 5, '๐.๐๐ - ๒.๙๙', 1, 'ปรับปรุง', 0, 2.99, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', '4BD33310-AE51-4E69-9D84-A4A8173D81F0')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = 'DB952F97-A4D9-49A8-9DAB-C27AC1C8BA55')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('DB952F97-A4D9-49A8-9DAB-C27AC1C8BA55', 5, '๓.๐๐ - ๓.๗๔', 2, 'พอใช้', 3, 3.74, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', '4BD33310-AE51-4E69-9D84-A4A8173D81F0')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = 'A5F23083-6E20-44CA-AFE4-D9D43B6DB9C3')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('A5F23083-6E20-44CA-AFE4-D9D43B6DB9C3', 5, '๓.๗๕ - ๔.๔๙', 3, 'ดี', 3.75, 4.49, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', '4BD33310-AE51-4E69-9D84-A4A8173D81F0')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = '3BFA05CF-BF7F-4F1E-BF4C-075CCCE0F1B8')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('3BFA05CF-BF7F-4F1E-BF4C-075CCCE0F1B8', 5, '๔.๕๐ - ๔.๗๔', 4, 'ดีมาก', 4.5, 4.74, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', '4BD33310-AE51-4E69-9D84-A4A8173D81F0')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = 'C07C5DE3-CB74-496A-8817-E95F4B6A53B2')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('C07C5DE3-CB74-496A-8817-E95F4B6A53B2', 5, '๔.๗๕ - ๕.๐๐', 5, 'ดีเยี่ยม', 4.75, 5, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', '4BD33310-AE51-4E69-9D84-A4A8173D81F0')
End

Go
---------15.0 (N)
--เพิ่มเกณฑ์คะแนน  15.0 (N)
If Not Exists(Select * From TCriteria Where TcriteriaID = '4D0B0449-3E92-4436-A94D-E5089F5B1AA2')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('4D0B0449-3E92-4436-A94D-E5089F5B1AA2', 15, '๐.๐๐ - ๘.๙๙', 1, 'ปรับปรุง', 0, 8.99, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'D7A04A29-300F-4E0F-B100-8026FF7D66D6')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = '9FD64FAE-5EB8-4229-913F-D75607E03661')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('9FD64FAE-5EB8-4229-913F-D75607E03661', 15, '๙.๐๐ - ๑๑.๒๔', 2, 'พอใช้', 9, 11.24, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'D7A04A29-300F-4E0F-B100-8026FF7D66D6')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = '418C006A-D21A-45E5-9223-0ED2CC2ED7FC')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('418C006A-D21A-45E5-9223-0ED2CC2ED7FC', 15, '๑๑.๒๕ - ๑๓.๔๙', 3, 'ดี', 11.25, 13.49, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'D7A04A29-300F-4E0F-B100-8026FF7D66D6')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = '04210C89-18A2-4BCE-9B64-E2A98CF08C0C')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('04210C89-18A2-4BCE-9B64-E2A98CF08C0C', 15, '๑๓.๕๐ - ๑๔.๒๔', 4, 'ดีมาก', 13.5, 14.24, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'D7A04A29-300F-4E0F-B100-8026FF7D66D6')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = '55413B24-E6AA-4761-B9BD-CFC79E73AAEA')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('55413B24-E6AA-4761-B9BD-CFC79E73AAEA', 15, '๑๔.๒๕ - ๑๕.๐๐', 5, 'ดีเยี่ยม', 14.25, 15, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'D7A04A29-300F-4E0F-B100-8026FF7D66D6')
End

Go
---------25.0 (N)
--เพิ่มเกณฑ์คะแนน  25.0 (N)
If Not Exists(Select * From TCriteria Where TcriteriaID = '85DE2963-45FC-4A88-93DB-0EBD805557B4')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('85DE2963-45FC-4A88-93DB-0EBD805557B4', 25, '๐.๐๐ - ๑๔.๙๙', 1, 'ปรับปรุง', 0, 14.99, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'C40FC9F0-2645-4651-9FEC-D3AC1C345F96')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = '6A64E4A7-9E8E-4B5A-BAE2-ADA8FA12253C')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('6A64E4A7-9E8E-4B5A-BAE2-ADA8FA12253C', 25, '๑๕.๐๐ - ๑๘.๗๔', 2, 'พอใช้', 15, 18.74, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'C40FC9F0-2645-4651-9FEC-D3AC1C345F96')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = 'D18283A0-9ACB-4DBD-89A6-6A0D52CFB05A')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('D18283A0-9ACB-4DBD-89A6-6A0D52CFB05A', 25, '๑๘.๗๕ - ๒๒.๔๙', 3, 'ดี', 18.75, 22.49, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'C40FC9F0-2645-4651-9FEC-D3AC1C345F96')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = 'ECA60F6C-8734-4353-A778-16A2A0FDC2F5')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('ECA60F6C-8734-4353-A778-16A2A0FDC2F5', 25, '๒๒.๕๐ - ๒๓.๗๔', 4, 'ดีมาก', 22.5, 23.74, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'C40FC9F0-2645-4651-9FEC-D3AC1C345F96')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = 'B5327681-3496-484F-9E26-01F44F543F7F')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('B5327681-3496-484F-9E26-01F44F543F7F', 25, '๒๓.๗๕ - ๒๕.๐๐', 5, 'ดีเยี่ยม', 23.75, 25, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'C40FC9F0-2645-4651-9FEC-D3AC1C345F96')
End

Go
----------ลบ StoreProcedure GenNewDataStandard59
If Exists(Select * From Sys.Procedures Where Name = 'GenNewDataStandard59')
Begin
	DROP PROCEDURE GenNewDataStandard59
End

Go
--เพิ่ม Store GenNewDataStandard59
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
	
Create PROCEDURE GenNewDataStandard59
		@StudyYear int
	AS
	BEGIN
		SET NOCOUNT ON;

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'764B9A9B-6F56-41AB-B91D-7677D0F326B3', N'997ADC5E-C0D0-4051-ACB5-4F83B200193B', N'จัดระบบบริหารและสารสนเทศ', N'สถานศึกษาจัดกิจกรรมพัฒนาผู้เรียนครบถ้วนตามโครงสร้างหลักสูตร กิจกรรมที่จัดเพื่อตอบสนองความสามารถ ความถนัด ความสนใจของผูเรียน(กิจกรรม ชุมชน ชมรม)มีหลากหลาย และผู้เรียนทุกคนมีโอกาสเลือกเรียนได้อย่างเท่าเทียมกัน มีการจัดกิจกรรมที่ส่งเริมความรักชาติ ศาสน์ กษัตริย์ รักความเป็นไทย และอยู่อย่างพอเพียงและจัดให้ผู้เรียนทุกคนร่วมกิจกรรมบำเพ็ญประโยชน์ต่อท้องถิ่น ชุมชนและสังคม', N'๑)การจัดกิจกรรมพัฒนาผู้เรียนมีสัดส่วนเวลาเรียน และจำนวนกิจกรรมครบถ้วนตามโครงสร้างหลักสูตร
๒)มีการสำรวจข้อมูลผู้เรียน วางแผนการจัดกิจกรรมพัฒนาผู้เรียน กิจกรรมที่จัดส่งเสริมให้ผู้เรียนทำกิจกรรมด้วยตัวเอง โดยมีครูเป็นผู้ให้คำปรึกษา รวมทั้งมีการติดตามตรวจสอบและสรุปรายงานผลการจัดกิจกรรมทุกภาคเรียน
๓)กิจกรรมชุมชน/ชมรมต่างๆ มีหลากหลาย สามารถตอบสนองความต้องการความถนัดและความสนใจของผู้เรียนได้อย่างทั่วถึง
๔)ผู้เรียนทุกคนได้เข้าร่วมกิจกรรมที่ส่งเสริมความรักชาติ ศาสนา พระมหากษัตริย์ รักความเป็นไทย และอยู่อย่างพอเพียง อย่างน้อยภาคเรียนละ ๑
๕)ผู้เรียนทุกคนได้เข้าร่วมกิจกรรมที่ทำประโยชน์เพื่อท้องถิ่นของตน เพื่อชุมชนหรือชุมชนหรือสังคมอย่างน้อยภาคเรียนละ ๑ ครั้ง', 0.5, N'ผู้บริหารสถานศึกษา คณะกรรมการสถานศึกษา ครู ผู้ปกครอง ผู้แทนชุมชนและผู้ที่เกี่ยวข้อง', N'หลักสูตรสถานศึกษา
คู่มือดำเนินการจัดกิจกรรมพัฒนาผู้เรียน
แผนงาน/โครงการ/กิจกรรมที่ส่งเสริมการพัฒนาผู้เรียน
ผลการจัดกิจกรรมพัฒนาผู้เรียนตามแผนงาน/โครงการ/กิจกรรม
ฯลฯ', 3, 0, CAST(0x0000A35D00E692F8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565009C36C8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'422A806A-D3F6-41B0-BBAA-C40CEB3E23B8')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'8F780B6C-5DD1-4AFC-9922-013ED1CC5920', N'BAD80DDF-B469-417A-A78A-3592A1783291', N'มีความสามารถในการคิดสร้างสรรค์', N'ผู้เรียนสามารถกำหนดเป้าหมายอนาคตและริเริ่มสร้างสรรค์ ผลิตผลงาน/การประดิษฐ์ การออกแบบผลงานทางวิชาการหรือวิชาชีพด้วยองค์ความรู้และก่อให้เกิดประโยชน์ต่อตนเองหรือสังคม สามารถสร้างสรรค์และพัฒนาผลงาน และมีการนำเสนอหรือเผยแพร่ผลงานด้วยความภาคภูมใจ', N'ร้อยละของผู้เรียนที่มีความสามารถในการคิดสร้างสรรค์', 2, N'การสังเกตพฤติกรรมการเรียนของผู้เรียนและการพูดคุยซักถามนักเรียนและครู', N'1. การทดสอบความสามารถในการคิดสร้างสรรค์
2. รายงานผลการประเมินสมรรถนะด้านความสามารถในการคิด
3. รายงานผลการทดสอบความสามารถในการคิดสร้างสรรค์', 3, 0, CAST(0x0000A35D00E692CE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500DE20EF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'1975724E-949A-4C54-9219-8516B2696F9A', N'BAD80DDF-B469-417A-A78A-3592A1783291', N'มีความสามารถในการคิดวิเคราะห์และสังเคราะห์', N'ผู้เรียนมีความสามารถจำแนกแยกแยะข้อเท็จจริง และรวบรวมจัดหมวดหมู่ หรือจับประเด็นเชื่อมโยงความสัมพันธ์ของข้อมูลและสรุปเรื่องราวที่อ่าน ฟัง ดู และสามารถสื่อสารโดยการพูดหรือเขียนตามความคิดของตนเองโดยมีเหตุผลประกอบ', N'ร้อยละของผู้เรียนที่มีความสามารถในการคิดวิเคราะห์และสังเคราะห์', 2, N'่การสังเกตพฤติกรรมของผู้เรียนและการพูดคุยซักถามนักเรียน ครู', N'1. การประเมิน/ทดดสอบความสามารถในการคิดวิเคราะห์และสังเคราะห์ของผู้เรียน
2. รายงานผลการประเมินการอ่าน คิด วิเคราะห์และเขียน
3. รายงานผลการทดสอบความสามารถในการคิดวิเคราะห์และสังเคราะห์', 1, 0, CAST(0x0000A35D00E692CE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500DBFD94 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'0BA5B9C4-C3A8-44EB-ACCE-7C4B8759CA7A', N'997ADC5E-C0D0-4051-ACB5-4F83B200193B', N'จัดให้มีการติดตามตรวจสอบคุณภาพการศึกษา', N'สถานศึกษามีการนิเทศติดตามกำกับการใช้หลักสูตร โดยใช้วิธีการที่หลากหลายมีแผนการนิเทศติดตามกำกับอย่างเป็นระบบต่อเนื่อง นำผลการนิเทศมาใช้ในการปรับปรุงและพัฒนาคุณภาพการจัดการเรียนการสอน', N'๑)แผนการนิเทศที่มุ่งส่งเสริมการพัฒนาการจัดการเรียนการสอน(ระบุประเด็น จุดเน้น รูปแบบ ปฏิทินและทีมนิเทศที่ชัดเจน)
๒)การดำเนินการติดตามการใช้หลักสูตรเป็นไปตามเกณฑ์
๓)มีการประเมินสรุปผลและรายงานผลการนิเทศทุกภาคเรียน
๔)มีการใช้ผลการนิเทศ การติดตามตรวจสอบมาปรับปรุงการจัดการเรียนรู้ของครูทุกกลุ่มสาระ
๕)ผู้เรียนพึงพอใจในการจัดการเรียนรู้ของครูอันเป็นผลมาจากการนิเทศ', 0.5, N'ผู้บริหารสถานศึกษา ครูและบุคลากรผู้มีส่วนเกี่ยวข้อง', N'แผนงาน/โครงการ/กิจกรรม
คำสั่ง
ปฏิทินการนิเทศ
บันทึกการประชุม
เครื่องมือสำหรับการนิเทศภายใน
บันทึกผลการนิเทศและการนำผลไปปรับปรุงพัฒนาการจัดการเรียนการสอน
ฯลฯ', 5, 0, CAST(0x0000A35D00E692F8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565009C8EF7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'422A806A-D3F6-41B0-BBAA-C40CEB3E23B8')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'48652404-11D2-4537-94F6-A132D84824DC', N'B08979BE-4D91-43B4-A076-2DE3DE250334', N'ครูมีคุณลักษณะที่ดี', N'ครูมีคุณลักษณะที่ดี โดยมีบุคลิกภาพที่ดี มีมารยาทที่ดี แต่งกายสะอาดเรียบร้อย มีความรักและศรัทธาในวิชาชีพครู มีความรัก ความเมตตากรุณาต่อศิษย์ และมีความยุติธรรม มีมนุษยสัมพันธ์ที่ดีกับบุคคลอื่น ยึดมั่นในคุณธรรม จริยธรรมและปฏิบัติตนตามหลักศาสนา ประพฤติปฏิบัติตนและปฏิบัติงานด้วยความซื้อสัตย์สุจริต มีความมุ่งมั่นตั้งใจ เสียสละ รับผิดชอบในหน้าที่เป็นแบบอย่างที่ดีและมีความรู้ตามมาตรฐานความรู้และจรรยาบรรณาของวิชาชีพครู รวมทั้งการรักษาระเบียบวินัยของราชการและสถานศึกษา ตลอดจนชื่อเสียงเกียรติยศของข้าราชการ', N'ครูมีคุณลักษณะที่ดี พิจารณาร้อยละของครูที่ผ่านเกณฑ์การพิจารณาระดับดีขึ้นไปครบทุกข้อดังนี้
1. การมีบุคลิกภาพที่ดี มีมารยาทที่ดี มีความสุภาพอ่อนโยน แต่งกายสะอาดเรียบร้อยเหมาะสมกับความเป็นครู
2. การมีความรักและศรัทธาในวิชาชีพครู เป็นสมาชิกที่ดีของสถานศึกษา
3. การมีความรัก ความเมตตากรุณาต่อศิษย์ และมีความยุติธรรมอย่างเสมอภาค
4. การมีมนุษยสัมพันธ์ที่ดีกับนักเรียน เพื่อนครู ผู้บริหารสถานศึกษา ผู้ปกครองและผู้เกี่ยวข้อง
5. การมีคุณธรรมจริยธรรมและปฏิบัติตนตามหลักศาสนาที่ตนนับถือ
6. การประพฤติปฏิบัติตนและปฏิบัติงานด้วยความซื้อสัตย์สุจริต มีความมุ่งมั่นตั้งใจเสียสละและรับผิดชอบในหน้าที่
7. การประพฤติปฏิบัติตนเป็นแบบอย่างที่ดี
8. การมีความรู้ตามมาตรฐานความรู้ของมาตรฐานวิชาชีพ พ.ศ.2556
9. การมีจรรยาบรรณของวิชาชีพครู พ.ศ. 2556 ทั้งจรรยาบรรณต่อตนเอง จรรยาบรรณต่อวิชาชีพ จรรยาบรรณต่อผู้รับการบริการ จรรยาบรรณต่อผู้ร่วมประกอบวิชาชีพ และจรรยาบรรณต่อสังคม
10. การรักษาระเบียบวินัยของราชการและสถานศึกษาาตลอดจนชื่อเสียงเกียรติยศของข้าราชการ', 5, N'การสังเกตพฤติกรรมของครู และการสอบถามสัมภาษณ์ครู ผู้บริหารสถานศึกษา นักเรียนผู้ปกครองและชุมชน', N'1. สรุปผลการประเมินและการพัฒนาครูตามมาตรฐานความรู้ของมาตรฐานวิชาชีพ พ.ศ. 2556 และจรรยาบรรณของวิชาชีพครู พ.ศ. 2556
2. การตรวจสอบเอกสาร หลักฐาน ร่องรอยการพัฒนาตนเองของครู รายงานผลการปฏิบัติงานของครูรายบุคคล เป็นต้น', 1, 0, CAST(0x0000A35D00E692DC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56501010F68 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'6D9248A7-1369-4B1C-80D5-2CFEDE417EC5', N'FDF64CA5-FF66-49A6-905C-AC89DC6AD938', N'ผู้บริหารสถานศึกษามีความรู้ ความสามารถในการบริหารจัดการสถานศึกษา และเป็นผู้นำการเปลี่ยนแปลงสู่สถานศึกษา', N'ผู้บริหารสถานศึกษามีความรู้ ความสามารถในการบริหารจัดการสถานศึกษา สามารถปฏิบัติงานตามบทบาทหน้าที่อย่างมีประสิทธิภาพและประสิทธิผลใช้หลักความเป็นผู้นำในการบริหารแบบมีส่วนร่วมและใช้สถานศึกษาเป็นฐาน มีการบริหารความเสี่ยง มีการส่งเสริมและพัฒนาศักยภาพและบุคลากรของสถานศึกษาให้มีความพร้อมในการปฏิบัติหน้าที่อย่างมืออาชีพ ส่งเสริการปฏิบัติงานของคณะกรรมการสถานศึกษาให้มีประสิทธิภาพและมีการบริหารจัดการแบบบูรณาการรองรับมาตรฐานการศึกษาจนสามารถนำการเปลี่ยนแปลงสู่สถานศึกษา', N'', 5, N'การสอบสัมภาษณ์ คณะกรรมการสถานศึกษาขั้นพื้นฐาน ผู้บริหารสถานศึกษา ครู นักเรียน และผู้ปกครอง', N'1. การตรวจสอบเอกสาร หลักฐาน ร่องรอย การบริหารจัดการสถานศึกษา เช่น แผนพัฒนาการจัดการศึกษา แผนปฏิบัติการ รายงานประจำปี หลักสูตรสถานศึกษา แผนการจัดการเรียนรู้ การรายงานผลความสำเร็จของการบริหารจัดการของผู้บริหารสถานศึกษาผลการประเมินความพึ่งพอใจของคณะกรรมการสถานศึกษา ครู บุคลากรผู้เกี่ยวข้องเป็นต้น

2. การสังเกต อาคารสถานที่ สภาพแวดล้อม ห้องเรียน ห้องปฏิบัติการห้องสมุด แหล่องเรียนรู้และห้องพิเศษต่าง ๆ ของสถานศึกษา', 2, 0, CAST(0x0000A35D00E692EA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565010DDE67 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'3F24F0A2-A7DC-415A-A7D1-47F8D9DCDB0C', N'AC932F39-6D8D-46BF-A947-204963E23229', N'มีความเป็นลูกที่ดีของพ่อแม่ เป็นศิษย์ที่ดีของครู และเป็นสมาชิกที่ดีของสังคม', N'ผู้เรียนตระหนักในคุณค่าของตนเอง มีความรักเคราพกตัญญกตเวทีต่อพ่อแม่ ครูอาจารย์ และถิ่นฐานบ้านเมือง สามารถปฏิบัติตนตามบทบาทหน้าที่ในการเป็นลูกที่ดีของพ่อแม่ เป็นศิษย์ที่ดีของครูและเป็นสมาชิกที่ดีของสังคม ด้วยการตั้งใจศึกษาเล่าเรียน การเอาใจใส่ช่วยเหลือการทำงาน และความรับผิดชอบต่อส่วนรวมและสังคมในฐานะที่เป็นสมาชิกที่ดีของสังคมทั้งที่บ้าน สถานศึกษา ชุมชนและสังคมประเทศชาติ', N'ร้อยละของผู้เรียนที่มีความสามารถเป็นลูกที่ดีของพ่อแม่ เป็นศิษย์ที่ดีของครู และเป็นสมาชิกที่ดีของสังคม', 2, N'1. การสังเกตพฤติกรรมของผู้เรียนและการพูดคุยซักถามนักเรียนครู และผู้ปกครอง', N'1. การตรวจสอบโครงการ/กิจกรรมที่เกี่ยวข้อง
2. รายงานผลการพัฒนาผู้เรียนด้านกิจกรรมการพัฒนาผู้เรียน', 1, 0, CAST(0x0000A35D00E692C0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500CEF4F5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'1A46F45E-EBA9-4580-9D32-41F4CCB14420', N'11BE78C4-1F5D-44BF-9DDB-2AEE2F71108D', N'มีสุนทรียภาพที่ดี', N'ผู้เรียนมีความรู้สึกที่ดีงาม ชื่นชอบและเห็นคุณค่าของศิลปะ ดนตรี/นาฏศิลป์ กีฬา/นันทนาการ และเข้าร่วมกิจกรรมต่าง ๆ อย่างมีความสุข และมีทักษะหรือมีผลงานหรือความสามารถด้านใดด้านหนึ่งด้วยความภาคภูมิใจ', N'ร้อยละของผู้เรียนที่มีสุนทรีย์ภาพที่ดี', 2, N'1. การแสดงทักษะความสามารถของผู้เรียนในด้านศิลปะ ดนตรี/นาฏศิลป์ กีฬา/นันทนาการ
2. โครงการ/กิจกรรมเกี่ยวกับการพัฒนาผู้เรียนด้านศิลปะ ดนตรี/นาฏศิลป์ กีฬา/นันทนาการ', N'1. รายงานผลการดำเนินงานโครงการ/กิจกรรมด้านศิลปะ ดนตรี/นาฏศิลป์ กีฬา/นันทนาการ
2. ผลงานของนักเรียน/โรงเรียนที่เกี่ยวข้อง เช่น วุฒิบัตร เกี่ยรติบัตร โล่ เหรียญรางวัล เป็นต้น', 5, 0, CAST(0x0000A35D00E692BB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500CC3D5E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'92D49B3E-AACF-4287-BD3F-3D2A27AF237A', N'A71DC241-C269-44C5-B69C-CEFA99F73C73', N'มีความสามารถในการวางแผนทำงานและดำเนินการจนสำเร็จ', N'ผู้เรียนมีความสามารถในการทำงานอย่างเป็นระบบ โดยมีทักษะในการวางแผน ดำเนินการตรวจสอบประเมินมุ่งมั่นดำเนินการจนบรรลุผลสำเร็จเป้าหมายและมีความสขุ ความภูมิใจในผลสำเร็จของงานที่ทำ', N'ร้อยละของผู้เรียนที่มีความสามารถในการทำงานอย่างเป็นระบบ', 2, N'การสังเกตพฤติกรรมของผู้เรียนและการพูดคุยซักถามนักเรียนครูและผู้ปกครอง', N'1. การสัมภาษณ์ผู้บริหารสถานศึกษา ครู และผู้เกี่ยวข้อง
2. การตรวจสอบผลงานของนักเรียน', 1, 0, CAST(0x0000A35D00E692D8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500E7231F AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'F6302717-E24A-41AF-9776-05575983F7BC', N'969E8C75-C110-4C22-BEC3-AD66F9A8AF08', N'มีความสามารถในการเรียนรู้', N'ผู้เรียนมีทักษะในการแสวงหาความรู้ด้วยตนเองจากแหล่งเรียนรู้ต่าง ๆ มีทักษะในการอ่าน ฟัง ดู พูด เขียนและตั้งคำถามเพื่อการศึกษาค้นคว้าหาความรู้ สามารถเรียนรู้ร่วมกันและแลกเปลี่ยนเรียนรู้และสามารถใช้เทโนโลยีสารสนเทศและการสื่อสาร (ICT) อินเตอร์เน็ต (Internet) และสื่อสังคม (Social Media) ในการเรียนรู้ และการนำเสนอผลงานอย่างสร้างสรรค์', N'ร้อยละของผู้เรียนที่มีความสามารถในการเรียนรู้', 2, N'การสังเกตพฤติกรรมการเรียนรู้ของผู้เรียนและสอบถาม สัมภาษณ์ครู และนักเรียน', N'1. การตรวจสอบทักษะความสามารถในการเรียนรู้ของผู้เรียน
2. ข้อมูลสารสนเทศที่เกี่ยวกับการเรียนรู้ของผู้เรียน เช่น สถิติการสืบค้นข้อมูล
3. ผลงานที่เกิดจากกระบวนการเรียนรู้ของผู้เรียน', 2, 0, CAST(0x0000A35D00E692CA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500D880FE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'C40C2ABC-C30C-4BE7-A506-B3BCCCE1DD2A', N'2C75D0A1-6E02-4D4B-8964-4F910D347EFD', N'ผลสัมฤทธิ์ทางการเรียนของแต่ละกลุ่มสาระการเรียนรู้', N'ผลสัมฤทธิ์ทางการเรียนของผู้เรียนในปีการศึกษา เฉลี่ยนตั้งแต่ 3.00 ขึ้นไป', N'ร้อยละของผู้เรียนที่มีผลสัมฤทธิ์ทางการเรียนนเฉลี่ยทั้ง 8 กลุ่มสาระการเรียนรู้ตั้งแต่ 3.00 ขึ้นไป', 4, N'-', N'รายงานสรุปผลสัมฤทธิ์ทางการเรียนของสถานศึกษาในปีการศึกษาที่สถานศึกษารับประเมิน', 1, 0, CAST(0x0000A35D00E692D3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500DFE950 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'AA41533E-12C7-4D29-8320-3CCB797A550A')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'2B8FEDA5-2F09-4EB8-BD20-9FA36C2E65F2', N'FDF64CA5-FF66-49A6-905C-AC89DC6AD938', N'ผู้บริหารสถานศึกษามีคุณลักษณะที่ดี', N'ผู้บริหารสถานศึกษามีคุณลักษณะที่ดี โดยมีบุคลิกภาพที่ดีมีมนุษยสัมพันธ์ ยึดมั่นในคุณธรรมจริยธรรม และปฏิบัติตนตามหลักศาสนา มีวิสัยทัศน์ ภาวะผู้นำและความคิดริเริ่มสร้างสรรค์ในการพัฒนาคุณภาพผู้เรียน มีความซื้อสัตย์สุจริตในการปฏิบัติหน้าที่ มีความมุ่งมั่นตั้งใจและเอาใจใส่ในการจัดการศึกษาของสถานศึกษาให้มีคุณภาพมาตรฐาน ประพฤติและปฏิบัติตนเป็นแบบอย่างที่ดีเป็นที่ยอมรับของคณะกรรมการสถานศึกษาขั้นพื้นฐาน ผู้ปกครอง ชุมชนและสังคม และมีความรู้ความสามารถในการบริหารจัดการสถานศึกษาสามารถนำการเปลี่ยนแปลงสู่สถานศึกษาอย่างต่อเนื่อง', N'ผู้บริหารสถานศึกษามีคุณลักษณะที่ดี พิจารณาจาก
1. การมีบุคลิกภาพที่ดี มีมารยาทที่ดี มีความสุภาพอ่อนโยน แต่งภายสะอาดเรียบร้อยเหมาะสมกับความเป็นผู้บริหารสถานศึกษา
2. การมีมนุษย์สัมพันธ์ที่ดี มีความเคราพให้เกียรติผู้เกี่ยวข้องทุกคน
3. การมีคุณธรรม จริยธรรมและปฏิบัติตนตามหลักศาสนาที่ตนนับถื
4. การมีวิสัยทัศน์ ภาวะผู้นำและความคิดริเริ่มสร้างสรรค์ในการพัฒนาคุณภาพผู้เรียน
5. การะประพฤติปฏิบัติตนและปฏิบัติงานด้วยความซื่อสัตย์สุจริตไม่มุ่งหวังและแสวงหาผลประโยชน์อันมีควร
6. การมีความมุ่งมั่นตั้งใจและเอาใจใส่ในการจัดการศึกษาให้มีคุณภาพและมาตรฐานให้เป็นที่เชื่อถือ ศรัทธาของผู้ปกครอง ชุมชน และสังคม
7. การประพฤติและปฏิบัติตนเป็นแบบอย่างที่ดี
8. การมีความรู้ตามมาตรฐานความรู้และประสบการณ์วิชาชีพของผู้บริหารสถานศึกษา พ.ศ. 2556
9. การรักษาระเบียบวินัยของราชการและสถานศึกษา และการรักษาส่งเสริมเกียรติยศของข้าราชการ
10. การเป็นที่ยอมรับ และศรัทธาของคณะกรรมการสถานศึกาษาขั้นพี้นฐาน ผู้ปกครอง ชุมชน และสังคม', 5, N'การสอบถามและสัมภาษณ์ ผู้บริหารสถานศึกษาและผู้ที่เกี่ยวข้อง', N'การตรวจสอบเอกสาร หลักฐาน ร่องรอยการปฏิบัติงาน เช่น ผลการประเมินคุณลักษณะของผู้บริหารสถานศึกษา รางวัล/เกียรติบัตร ที่ได้รับการยกย่องเชิดชูเกียรติจากหน่วยงานต่าง ๆ', 1, 0, CAST(0x0000A35D00E692EA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565010B1B22 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1, N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'5FBC2BE1-4B48-42EF-B54D-9B10E674BEF5', N'ECD9FDA1-0B7E-454B-B80A-D933FB4350B8', N'พัฒนาความร่วมมือกับผู้ปกครอง ชุมชนและสังคม', N'', N'', 2, N'', N'', 3, 0, CAST(0x0000A35D00E692F4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565010EF560 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'5907D5FA-7A95-4F35-89C7-3C59CCAE8C2E', N'AC932F39-6D8D-46BF-A947-204963E23229', N'ยอมรับความคิดเห็นและวัฒนธรรมที่แตกต่างและสามารถปรับตัวได้', N'ผู้เรียนตระหนักรู้ในภาวการณ์ของโลกที่มีความหลากหลายทางเชื่อชาติ วัฒนธรรม ขนบธรรมเนียมประเพณี ค่านิยม และวิธีชีวิต ผู้เรียนมีทักษะชีวิต มีความสามารถในการสื่อสารอย่างสร้างสรรค์ และมีความสัมพันธ์ที่ดีระหว่างบุคคล สามารถแสดงความคิดเห็นและรับฟังความคิดเห็นของผู้อื่นด้วยความเข้าใจที่ดี รู้จักให้เกียรติผู้อื่น เข้าใจและเห็นคุณค่าในวัฒนธรรมที่แตกต่างมีความยืดหยุ่นและมีความสามารถในการปรับตัวและสามารถเข้าร่วมกิจกรรมที่มีความแตกต่างทางวัฒนธรรมที่สถานศึกษาจัดขึ้นด้วยความเต็มใจในฐานะที่เป็นพลเมืองไทย และเป็นพลเมืองโดลที่มีอยู่ร่วมกันในสังคมอย่างมีสันติสุข', N'ร้อยละของผู้เรียนที่ยอมรับความคิดเห็นและวัฒนธรรมที่แตกต่างและสามารถปรับตัวได้', 2, N'การพูดคุยซักถามนักเรียน', N'1. สรุปรายงานผลโครงการ/กิจกรรมที่เกี่ยวข้อง
2. การตรวจสอบหลักฐานการเข้าร่วมกิจกรรม/โครงการ', 4, 0, CAST(0x0000A35D00E692C5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500D33EEA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'25E636C7-D7B4-42CF-804E-1050FB3740CC', N'2336a4b9-3679-4477-918c-20a1426c0bc3', N'มีการสร้างและพัฒนาแหล่งเรียนรู้ภายในสถานศึกษาและใช้ประโยชน์จากแหล่งเรียนรู้  ทั้งภายในและภายนอกสถานศึกษา  เพื่อพัฒนาการเรียนรู้ของผู้เรียนและบุคลากรของสถานศึกษา  รวมทั้งผู้ที่เกี่ยวข้อง', N'สถานศึกษามีการกำหนดวิธีการหรือขั้นตอนการดำเนินงานการพัฒนาแหล่งเรียนรู้ภายในสถานศึกษาโดยให้การสนับสนุนส่งเสริมให้ผู้เรียนใฝ่เรียนใฝ่รู้ แสวงหาความรู้และเรียนรู้ด้วยตนเองตามอัธยาศัย สามารถนำความรู้ไปใช้ประโยชน์ได้อย่างเหมาะสม สนับสนุนใหผู้เรียนบุคลากรภายในสถานศึกษาและผู้มีส่วนเกี่ยวข้องเกิดกระบวนการเรียนรู้จากแหล่งเรียนรู้ทั้งภายในและภายนอก เช่น อ่านหนังสือหรือวารสารที่มีประโยชน์ในห้องสมุดโรงเรียน ดูรายการโทรทัศน์หรือฟังวิทยุที่มีสาระ ค้นคว้าหาความรู้โดยผ่านเครือข่ายคอมพิวเตอร์ ซักถามข้อมูลจากผู้รู้หรือผู้มีประสบการณ์ ศึกษาหาข้อมูลห้องสมุดประชาชน พิพิธภัณฑ์ หอศิลป์ สวนสัตว์ ศูนย์การศึกษา สถานประกอบการณ์ องค์กรภาครัฐ เอกชน หรือแหล่งเรียนรู้อื่นๆ เป็นต้น', N'๑)การมีขั้นตอนการดำเนินงานในการพัฒนาแล่งเรียนรู้ภายในสถานศึกษา โดยศึกษา วิเคราะห์ข้อมูลสารสนเทศแหล่งเรียนรู้ภายในสถานศึกษา จัดทำแผนพัฒนาและดำเนิการตามจั้นตอนตามที่กำหนด (Plan ,Do)', 5, N'ผู้บริหารสถานศึกษา คณะกรรมการสถานศึกษา ครู นักเรียน ผู้ปกครองและผู้มีส่วนเกี่ยวข้อง', N'แผนพัฒนาคุณภาพสถานศึกษา
แผนปฏิบัติการประจำปี โครงการ/กิจกรรม
ผลการวิเคราะห์ข้อมูลสารสนเทศ
เอกสารรายงานการนิเทศติดตามผลการดำเนินงาน บันทึกรายงานการประชุม
รายงานสรุปผลการประเมินโครงการหรือรายงานผลการปฏิบัติ เอกสารแสดงขั้นตอนการดำเนินงานพัฒนาแหล่งเรียนรู้
รายงานผลกาประเมินกิจกรรมฐานข้อมูลแหล่งเรียนรู้ทะเบียนการใช้แหล่งเรียนรู้
เอกสารหลักฐานอื่นๆ เช่น ภาพถ่าย แผ่นผับ แถบวิดีทัศน์
ป้าย/บอร์ดกิจกรรมต่างๆ ที่เกี่ยวข้อง เช่น ป้าย/บอร์ดการจัดกิจกรรม บอร์ดแสดงแหล่งเรียนรู้ต่างๆ ในแต่ละนอกสถานศึกษา
ฯลฯ', 1, 1, CAST(0x0000A35D00E69310 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565009670BF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'3C189296-D5EC-4EC2-8C75-0793F37724F1', N'BA0DCE8A-BED3-4CB5-9A4D-2761551EA885', N'โครงการพิเศษเพื่อยกระดับคุณภาพการศึกษาตามแนวปฏิรูปการศึกษา/สร้างความโดดเด่นให้สถานศึกษา', N'สถานศึกษาจัดให้มีโครงการพิเศษที่สะท้อนศักยภาพของสถานศึกษาในการปฏิรูปการศึกษาเพื่อยกระดับคุณภาพการศึกษา/สร้างความโดดเด่นของสถานศึกษา ทำให้สถานศึกษามีชื่อเสียงเป็นที่ยอมรับ ศรัทธาของผู้ปกครอง ชุมชน และสังคม', N'1. โครงการพิเศษอย่างน้อย 1 โครงการที่ตอบสนองนโยบาย จุดเน้นตามแนวปฏิรูปการศึกษาหรือการนำผลการประเมินคุณภาพภายใน โดยหน่วยงานต้นสังกัด/ผลการประเมินคุณภาพภายนอกมาใช้ในการจัดทำโครงการพิเศษของสถานศึกษา
2. โครงการพิเศษนั้นมีบุคลากรของสถานศึกษามีส่วนร่วมไม่น้อยกว่าร้อยละ 80.00
3. การดำเนินงานโครงการพิเศษเป็นไปตามวงจร P D C A
4. ผลการดำเนินงานบรรลุเป้าหมายไม่น้อยกว่าร้อย 80.00
5. ผู้เกี่ยวข้อง/ผู้มีส่วนร่วมมีความพึ่งพอใจไม่น้อยกว่าร้อยละ 80.00', 2, N'ผู้บริหารสถานศึกษา ครู บุคลากร และผู้ที่เกี่ยวข้อง', N'หลักฐานร่องรอย เช่น โครงการพิเศษ แฟ้มกิจกรรม การสอบถามผู้ปกครอง ชุมชนบริเวณใกล้เคียงสถานศึกษา', 2, 0, CAST(0x0000A35D00E69302 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500A122CB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'24E84165-0E0F-45DF-B9BC-54D3F5A64633', N'BAD80DDF-B469-417A-A78A-3592A1783291', N'มีความสามารถในการคิดแก้ปัญหา', N'ผู้เรียนสามารถนำเสนอวิธีคิดแก้ปัญหาด้วยภาษาและวิธีการของตนเอง สามารถตัดสินใจแก้ปัญหาโดยมีเหตุผลประกอบ และสามารถนำไปประยุกต์ใช้ในสถานการณ์ใกล้เคียง หรือในชีวิตประจำวัน', N'ร้อยละของผู้เรียนที่มีความสามารถในการคิดแก้ปัญหา', 1, N'การสังเกตพฤติกรรมของผู้เรียนและการพูดคุยซักถามนักเรียนและครู', N'1. การทดสอบความสามารถในการคิดแก้ปัญหา
2. รายงานผลการประเมินสมรรถนะด้านความสามารถในการแก้ปัญหา
3. รายงานผลการทดสอบความสามารถในการคิดแก้ปัญหา', 2, 0, CAST(0x0000A35D00E692CE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500DD1759 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'A40A8304-6BEA-4F2D-8371-B5C765089997', N'997ADC5E-C0D0-4051-ACB5-4F83B200193B', N'จัดให้มีการพัฒนาคุณภาพการศึกษาอย่างต่อเนื่อง', N'', N'', 0.5, N'', N'', 8, 0, CAST(0x0000A565009D1CC0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565009D1CC0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'422A806A-D3F6-41B0-BBAA-C40CEB3E23B8')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'99480C16-B9A0-47E7-BB3E-31675011A2C8', N'63be60f1-3756-4f0c-a0d0-b025c7db5395', N'จัดโครงการ  กิจกรรมที่ส่งเสริมให้ผู้เรียนบรรลุตามเป้าหมายวิสัยทัศน์  ปรัชญา  และจุดเน้นของสถานศึกษา', N'สถานศึกษามีกระบวนการบริหารจัดการของสถานศึกษาที่มุ่งพัฒนาคุณภาพการจัดการศึกษา โดยการดำเนินงานกิจกรรม โครงการที่สถานศึกษากำหนดขึ้น เพื่อส่งเสริมผู้เรียนให้บรรลุผลตามวิสัยทัศน์ ปรัช
ญา จุดเน้น เป้าหมาย กลยุทธ์', N'๑)การจัดกิจกรรม โครงการในแผนพัฒนาการจัดการศึกษา แผนปฏิบัติการประจำปีของสถานศึกษาที่จัดทำขึ้นจากการมีส่วนร่วมของผู้บริหาร ครู บุคลากร ชุมชนและองค์กรภายนอก
๒)โครงการ/กิจกรรมสอดคล้องกับวิสัยทัศน์ ปรัชญา จุดเน้น เป้าหมาย กลยุทธ์ ของสถานศึกษา และได้รับการเห็นชอบของคณะกรรมการสถานศึกษา
๓)บุคลากร ผู้เกี่ยวข้องและผู้เรียนได้ปฏิบัติตามกลยุทธ์ กิจกรรมหรือโครงการที่สถานศึกษากำหนดอย่างครบถ้วน
๔)การดำเนินงานตามกลยุทธ์ กิจกรรม โครงการและจุดเน้น ได้รับการกำกับ ติดตามและนิเทศอย่างสม่ำเสมอ
๕)สถานศึกษามีรายงาน สรุปผลการดำเนินงานกิจกรรม โครงการที่สนับสนุนส่งเสริมผู้เรียนที่บรรลุตามเป้าหมาย วิสัยทัศน์ ปรัชญา และจุดเน้นของสถานศึกษา', 3, N'ผู้บริหารสถานศึกษา ครู กรรมการสถานศึกษา นักเรียน ผู้ปกครองนักเรียน ผู้เกี่ยวข้อง', N'แผนพัฒนาคุณภาพการจัดการศึกษาของสถานศึกษา
แผนปฏิบัติการประจำปี โครงการ/กิจกรรม
ร่องรอยการวิเคราะห์ข้อมูลสารสนเทศ ทะเบียนแหล่งเรียนรู้
สรุปผลการนิเทศติดตามผลการดำเนินงาน
รายงานผลการปฏิบัติงานและรายงานสรุปการประเมินโครงการ
ฯลฯ', 1, 1, CAST(0x0000A35D00E69314 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500966054 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'8203609C-DC86-4409-9CC8-89A8AC90674A')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'AC05AA35-D097-47EC-8953-7A08B671767D', N'94d3eb04-c953-4b06-8192-68c0e6ed1e95', N'จัดโครงการ  กิจกรรมพิเศษเพื่อตอบสนองนโยบาย  จุดเน้น  ตามแนวทางการปฏิรูปการศึกษา', N'จัดโครงการ กิจกรรมเพื่อตอบสนองนโยบาย จุดเน้น ตามแนวทางการปฏิรูปการศึกษา หมายถึง สถานศึกษามีการกำหนดมาตรการที่นำมาปรับปรุง พัฒนา และดำเนินโครงการกิจกรรมพิเศษอย่างเป็นระบบ และมุ่งมั่น โดยนำข้อเสนอแนะการประเมินภายนอกของ สมศ.รอบสอง มากำหนดมาตรการ นโยบาย โครงการกิจกรรมพิเศษ เพื่อขับเคลื่อนสถานศึกษาให้เข้าสู่มาตรฐาน(ไม่ได้รับการรับรอง)ยกระดับมาตรฐาน(ได้รับการรับรองและมีผลการประเมินในระดับดี)และรักษามาตรฐาน(ได้รับการรับรองและมีผลการประเมินในระดับดีมาก)ตอบสนองนโยบาย จุดเน้นตามแนวทางปฏิรูปการศึกษา ซึ่งอาจเป็นข้อตกลงร่วมกันระหว่างสถานศึกษา หน่วยงานต้นสังกัด หรือ หน่วยงานสนับสนุนอื่นๆ', N'๑)การศึกษา วิเคราะห์ และใช้ข้อมูลสารสนเทศด้านนโยบายของต้นสังกัด จุดเน้นตามแนวทางปฏิรูปการศึกษาในการจัดทำแผนงาน/โครงการ  
๒)การมีข้อตกลงร่วมกันระหว่างสถานศึกษาและหน่วยงานต้นสังกัด หรือหน่วยงานอื่นๆ    
๓)โครงการ/กิจกรรมพิเศษเด่นชัดตอบสนองนโยบาย จุดเน้นตามแนวทางปฏิรูปการศึกษา อย่างน้อย ๒ โครงการ/กิจกรรมพิเศษต่อปีการศึกษา  
๔)การดำเนินงานโครงการ กิจกรรมพิเศษ เป็นระบบตามวงจรคุณภาพ(PDCA)ย้อนหลัง ๓ ปี
๕)การมีส่วนร่วมของผู้บริหารสถานศึกษา ครู ผู้เรียน ผู้ปกครอง และผู้เกี่ยวข้องต่อการดำเนินงานตามโครงการ/กิจกรรมพิเศษ
๖)การนิเทศ ติดตามการดำเนินงานตามโครงการ/กิจกรรมพิเศษอย่างต่อเนื่อง
๗)การสรุปโครงการ กิจกรรมพิเศษที่แสดงให้เห็นถึงสัมฤทธิ์ผลโครงการ กิจกรรมพิเศษตอบสนองนโยบาย จุดเน้นตามแนวทางปฏิรูปการศึกษา', 3, N'ผู้บริหารสถานศึกษา ครู กรรมการสถานศึกษา นักเรียน ผู้ปกครองนักเรียน ผู้เกี่ยวข้อง', N'หลักฐาน ร่องรอยการวิเคราะห์นโยบายของต้นสังกัดจุดเน้นตามแนวทางปฏิรูปการศึกษาเพื่อการจัดทำแผนงาน โครงการพิเศษ
เอกสารแผนพัฒนาคุณภาพการจัดการศึกษาแผนปฏิบัติการประจำปี โครงการ กิจกรรมพิเศษข้อมูลจากการนิเทศติดตามผลการดำเนินงาน
รายงานสรุปการประเมินโครงการหรือรายงานผลการปฏิบัติงาน
ฯลฯ', 1, 1, CAST(0x0000A35D00E69319 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500964DD1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'8203609C-DC86-4409-9CC8-89A8AC90674A')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'044DE392-A4D7-44A4-9AB6-78A63AD1A841', N'2C75D0A1-6E02-4D4B-8964-4F910D347EFD', N'ผลการประเมินการอ่าน คิดวิเคราะห์และเขียน', N'ผลการประเมินการอ่านคิดวิเคราะห์และเขียนของผู้เรียน', N'ร้อยละของผู้เรียนที่มีผลการประเมินการอ่าน คิดวิเคราะห์และเขียน', 2, N'สรุปผลการประเมินการอ่าน คิดวิเคราะห์ และเขียน', N'การตรวจสอบหลักฐาน โครงการ/กิจกรรมที่เกี่ยวข้อง', 4, 0, CAST(0x0000A35D00E692D3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500E49D6A AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'9E1C8AC8-66A9-4FD3-AB25-4F95A0D85F2E', N'11BE78C4-1F5D-44BF-9DDB-2AEE2F71108D', N'ป้องกันตนเองจากสิ่งเสพติดให้โทษและหลีกเลี่ยงตนเองจากสภาวะที่เสี่ยง', N'ผู้เรียนรู้เท่าทันและปฏิบัติตนให้พ้นจากสิ่งเสพติดและอบายมุขต่าง ๆ รู้จักวิธีดูแลตนเองให้ปลอดภัยจากโรคภัยไข้เจ็บ อุบัติเหตุ การทะเลาะวิวาทและปัญหาทางเพศ รู้จักหลีกเลี่ยงพฤติกรรมเสี่ยงหรือไม่พึ่งประสงค์ที่จะส่งผลกระทบต่อตนเอง และผู้อื่น มีสำนักต่อส่วนร่วมและมีส่วนร่วมในการเผยแพร่และรณรงค์ในกิจกรรมต่อต้านอบายมุข สิ่งมอมเมา ความรุนแรง และปัญหาทางเพศภายในสถานศึกษา หรือร่วมกับหน่วยงานภายนอกอย่างน้อยปีละ 1 ครั้ง', N'ร้อยละของผู้เรียนที่ปลอดจากสิ่งเสพติดอบายมุขและปัญหาต่าง ๆ', 2, N'การพูดคุยซักถามผู้เรียน ครู ผู้ปกครอง และผ้เกี่ยวข้อง', N'รายงานผลการดำเนินงานระบบดูแลช่วยเหลือนักเรียน

รายงานผลการดำเนินงานของฝ่ายกิจการนักเรียนและข้อมูลสานสนเทศนักเรียนรายบุคคล', 4, 0, CAST(0x0000A35D00E692B7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500CA4C73 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'96E6DF62-DBD1-4CBC-AB4F-F62DC4C790B5', N'997ADC5E-C0D0-4051-ACB5-4F83B200193B', N'จัดทำรายงานประจำปีที่เป็นรายงานประเมินคุณภาพภายใน', N'', N'', 1, N'', N'', 7, 0, CAST(0x0000A565009CF7B0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565009CF7B0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'CEE23550-23B1-4887-9522-42DFE5D5F25A', N'ECD9FDA1-0B7E-454B-B80A-D933FB4350B8', N'พัฒนาสถานศึกษาให้บรรลุเป้าหมายตามวิสัยทัศน์ ปรัชญา นโยบายและจุเน้น', N'', N'', 5, N'', N'', 2, 0, CAST(0x0000A35D00E692EF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565010EBB45 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1, N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'6D5C1667-4C1C-477C-904E-B57B3DC5E43A', N'2C75D0A1-6E02-4D4B-8964-4F910D347EFD', N'ผลการทดสอบทางการศึกษาระดับชาติขั้นพื้นฐาน (O-net)', N'ผลการทดสอบทางการศึกษาระดับชาติขั้นพื้นฐาน (O-net) ของผู้เรียนชั้นมัธยมศึกษาปีที่ 3 และมัธยมศึกษาปีที่ 6 ใน 5 หรือ 8 กลุ่มสาระการเรียนรู้โดยีค่า T-Score มากกว่า 40.00 ขึ้นไปในแต่ละกลุ่มสาระการเรียนรู้', N'ร้อยละของผู้เรียนชั้นมัธยมศึกษาปีที่ 3 และมัธยมศึกษาปีที่ 6 ที่มีผลการทดสอบทางการศึกษาระดับชาติขั้นพื้นฐาน (O-Net) ทีมีค่า T-Score ตั้งแต่/มากกว่า 40.00 ขึ้นไป ในแต่ละกลุ่มสาระการเรียนรู้', 4, N'-', N'รายงานสรุปผลการทดสอบทางการศึกษาระดับชาติขั้นพื้นฐาน (O-Net) ของสถานศึกษาในปีการศึกษาที่ประเมิน', 2, 0, CAST(0x0000A35D00E692D3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500E14C31 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'AA41533E-12C7-4D29-8320-3CCB797A550A')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'521A45E1-3574-41F4-B9BC-545CB5094822', N'969E8C75-C110-4C22-BEC3-AD66F9A8AF08', N'มีการพัฒนาตนเองอย่างต่อเนื่อง', N'ผู้เรียนมีความมุ่งมั่นในการเรียนรู้เพื่อพัฒนาตนเองอย่างต่อเนื่องมีผลงานที่เกิดจากการเรียนรู้เป็นของตนเอง มีเจตคติที่ดีต่อการเรียนรู้และเป็นบุคคลแห่งการเรียนรู้', N'ร้อยละของผู้เรียนที่มีการพัฒนาตนเองอย่างต่อเนื่อง', 1, N'การสังเกตพฤติกรรมการเรียนรู้ของผู้เรียนและการสอบถาม สัมภาษณ์ครู', N'1. การตรวจสอบทักษะความสามารถในการเรียนรู้ของผู้เรียน
2. การตรวจสอบผลงานที่เกิดจากการเรียนรู้ของผู้เรียน
3. สรุปรายงานผลการอ่าน คิด วิเคราะห์และการเขียนของผู้เรียน
4. รายงานผลการรประเมินบุคคลแห่งการเรียนรู้', 3, 0, CAST(0x0000A35D00E692CA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500D9E719 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'196D2A1E-019F-412A-A833-E230381EEBA3', N'B08979BE-4D91-43B4-A076-2DE3DE250334', N'ครูมีความรู้ความสามารถในการจัดการเรียนการสอนที่เน้นผุ้เรียนเป็นสำคัญ และเป็นผู้นำการเปลี่ยนแปลงสู่สถานศึกษา', N'ครูมีความรู้ ความสามารถในการจัดการเรียนการสอนที่เน้นผู้เรียนเป็นสำคัญ โดยมีความสามารถในการออกแบบการเรียนรู้ ใช้กิจกรรมการเรียนรู้ที่หลากหลาย สามารถบริหารจัดการชั้นเรียนใช้แหล่งเรียนรู้ที่มีประสิทธิภาพ มีการวิจัยและสร้างสรรค์นวัตกรรมเพื่อยกระดับคุณภาพการศึกษาและเป็นผู้นำการเปลี่ยนแปลงสู่สถานศึกษา', N'ครูมีความรู้ ความสามารถในการจัดการเรียนการสอนที่เน้นผู้เรียนเป็นสำคัญ และเป็นผู้นำการเปลี่ยนแปลงสู่สถานศึกษา พิจารณาจากร้อยละของครูที่ผ่านเกณฑ์การพิจารณาระดับดีขึ้นไปครบทุกข้อ
1. การวิเคราะห์หลักสูตรเพื่อการจัดการเรียนการสอนที่มีประสิทธิภาพ
2. การวิเคราะห์ผู้เรียนเป็นรายบุคคลและนำข้อมูลมาใช้ในการวางแผนและการจัดการเรียนรู้เพื่อพัฒนาผู้เรียนให้สอดคล้องกับความแตกต่างระหว่างบุคคล
3. การกำหนดเป้าหมายคุณภาพผู้เรียนทั้งด้านความรู้ ทักษะ เจตคติ สมรรถนะสำคัญและคุณลักษณะอันพึ่งประสงค์ตามหลักสูตรและออกแบบจัดการเรียนรู้ได้สอดคล้องมาตรฐานการเรียนรู้ตัวชี้วัดและความแตกต่างของผู้เรียน
4. การออกแบบแผนการจัดการเรียนรู้และการจัดการเรียนรู้ที่เน้นผู้เรียนเป็นสำคัญด้วยกระบวนการเรียนรู้ที่หลากหลายโดยคำนึงถึงความแตกต่างระหว่างบุคคลและพัฒนาการทางสติปัญญาของผู้เรียน
5. การบริหารจัดการชั้นเรียนและจัดบรรยากาศการเรียนรู้เพื่อให้การเรียนการสอนมีประสิทธิภาพผู้เรียนเกิดการเรียนรู้อย่างมีความสุข
6. การใช้สื่อนวัตกรรมและเทคโนโลยี ภูมิปัญญาท้องถิ่น และแหล่งเรียนรู้ ทั้งภายในและภายนอกสถานศึกาา
7. การวัดและประเมินผลที่หลากหลายเน้นการพัฒนาการเรียนรู้ ของผู้เรียนอย่างต่อเนื่องเพื่อให้ได้ข้อมูลสารสนเทศที่แสดงถึงพัฒนาการความก้าวหน้าและความสำเร็จในการเรียนรู้ของผู้เรียน
8. การนำผลการประเมินมาใช้ปรับปรุงพัฒนาหรือซ่อมแซมเสริมให้ผู้เรียนบรรลุตามเป้าหมายของหลักสูตร รวมทั้งการปรับปรุงพัฒนาการจัดการเรียนการสอน
9. การให้คำแนะนำ ปรึกษาหรือแก้ปัญหาให้ผู้เรียนทั้งด้านการเรียนและคุณภาพชีวิตด้วยความเสมอภาค
10. การศึกษา ค้นคว้า วิจัยเพื่อพัฒนาสื่อการเรียนการสอน และกระบวนการเรียนรู้ที่เน้นผู้เรียนเป็นสำคัญโดยมีงานวิจัยหรือผลงาน หรือสื่อ/นวัตกรรมอย่างน้อยปีละ 1 ชิ้น
11. การสร้างสรรค์ห้องเรียน/แหล่งเรียนรู้ที่มีคุณภาพและร่วมกิจกรรมการแลกเปลี่ยนเรียนรู้เพื่อสร้างชุมชนแห่งการเรียนรู้ในสถานศึกษา
12. การเป็นผู้นำการเปลียนแปลงสู่สถานศึกษา สามารถพัฒนาผลสัมฤทธิ์ทางการเรียน/ศักยภาพของผู้เรียนในด้านต่าง ๆ ปรากฏผลงานเป็นที่ประจักษ์', 10, N'1. การสังเกตการจัดการเรียนการสอนของครู
2. การสอบถามและสัมภาษณ์ครู นักเรียน ผู้บริหารสถานศึกษา และผู้เกี่ยวข้อง', N'การตรวจสอบเอกสารหลักฐานร่องรอยการปฏิบัติงานของครู เช่น รายงานผลการนิเทศภายในรายงานผลการปฏิบัติงานของครูรายบุคคลและแฟ้มสะสมงานครู ฯลฯ', 2, 0, CAST(0x0000A35D00E692E1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5650105BBE1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'3D9F922B-77D7-410E-8CC1-9BEA731E4F61')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'9F00E6FE-8848-4E7A-A9F2-EEE42EAD341D', N'969E8C75-C110-4C22-BEC3-AD66F9A8AF08', N'มีนิสัยรักการอ่าน', N'ผู้เรียนมีทักษะในการอ่าน สามารถอ่านจับใจความสำคัญ หรืออ่านเชิงวิเคราะห์ สังเคราะห์ได้และมีนิสัยรักการอ่านโดยอ่านหนังสืออื่นนอกจากหนังสือแบบเรียน ตามเกณฑ์การอ่านของสำนักงานคณะกรรมการศึกษาขั้นพื้นฐาน อย่างน้อยวันละ 60 นาที และมีผลงานการอ่านระดับมัธยมศึกษาตอนต้น อย่างน้อย 15 เล่ม/ปี และระดับมัธยมศึกษาตอนปลาย อย่างน้อย 20 เล่ม/ปี (สำนักงานคณะกรรมการการศึกษาขั้นพื้นฐาน, 2556)', N'ร้อยละของผู้เรียนที่มีนิสัยรักการอ่าน', 2, N'การพูดคุยซักถามผู้เรียน ครู ผู้ปกครอง และผู้ที่เกี่ยวข้อง', N'1. การประเมินทักษะ/ความสามารถในการอ่านของผู้เรียน
2. การตรวจสอบผลงานการอ่านของนักเรียน
3. สรุปรายงานผลโครงการ/กิจกรรมเกี่ยวกับรักการอ่านของสถานศึกษา', 1, 0, CAST(0x0000A35D00E692CA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500D6D7B2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'59ECA87C-53A4-49F8-BDCA-DA3F33514411', N'BA0DCE8A-BED3-4CB5-9A4D-2761551EA885', N'พัฒนาช่วยเหลือสถานศึกษาอื่นหรือชุมชน สังคม', N'สถานศึกษามีศักยภาพในการพัฒนาช่วยเหลือหรือร่วมมือกับสถานศึกษาอื่นให้มีความเข้มแข็งทางด้านวิชาการ หรือการร่วมมือกับชุมชนสังคมของสถานศึกษาในการชี้แนะ ป้องกันหรือแก้ปัญหาที่สอดคล้องกับนโยบายของรัฐ/หน่วยงานต้นสังกัด', N'1.การมีข้อตกลงความร่วมมือกับสถานศึกษาอื่น หรือกิจกรรมความร่วมมือกับชุมชน สังคมในการชี้แนะ ป้องกันหรือแก้ปัญหาทางสังคม
2. การกำหนดตัวชี้วัดและระดับความสำเร็จไม่น้อยกว่าร้อยละ 80.00
3. การมีแนบปฏิบัติและรายงานผลการดำเนินงานที่ชัดเจนและต่อเนื่อง
4. การมีส่วนร่วมของผู้ที่เกี่ยวข้องจากทั้งสองฝ่ายเป็นอย่างดี
5. ผลการประเมินความเร็จบรรลุเป้าหมาย', 1, N'การสอบถาม สัมภาษณ์ผู้บริหารสถานศึกษา ครูและผู้เกี่ยวข้อง', N'หลักฐาน ร่องรอย และข้อมูลเชิงประจักษ์ เช่น บันทึกข้อตกลง/ความร่วมมือระหว่างสถานศึกษาหรือสถานศึกษากับชุมชน สังคม โครงการ/กิจกรรมความร่วมมือ และรายงานผลการดำเนินงานโครงการ/กิจกรรมความร่วมมือ เป็นต้น', 3, 0, CAST(0x0000A5650097DCAA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565009F38D4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'87F2769C-7B58-4231-A48C-936702FE513E', N'11BE78C4-1F5D-44BF-9DDB-2AEE2F71108D', N'มีสุขภาพกายที่ดี', N'ผู้เรียนมีพัฒนาการทางร่างกาย เจริญเติบโตตามวัย มีน้ำหนักส่วนสูงตามเกษฑ์มาตรฐานการเจริญเติบโตตามวัยของกรมอนามัย กระทรวงสาธารณสุข และมีผลการทดสอบสมรรถภาพทางร่างกายตามเกณฑ์มาตรฐานของกรมพลศึกษาหรือตามเกณฑ์มาตรฐานอื่น ๆ', N'ร้อยละของผู้เรียนที่มีน้ำหนักส่วนสูงและสมรรถภาพทางกายตามเกณฑ์มาตรฐาน', 2, N'การพูดคุยซักถามนักเรียนครู และผู้ปกครอง

สรุปผลการบันทึกน้ำหนัก ส่วนสูง/แบบบันทึกสุขภาพประจำตัวของนักเรียน', N'สรุผลการทดสอบสมรรถภาพทางกายของนักเรียน', 1, 0, CAST(0x0000A35D00E692B7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500A98FAD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'5A7DADE3-9D06-4B66-BE0F-E6F530351086', N'05AE9218-7C3F-4B0B-BE5F-B9BD1C9CADA5', N'เอกลักษณ์ของสถานศึกษา', N'สถานศึกษามีการจัดทำรายงานผลการประเมินคุณภาพภายในของสถานศึกษาที่เป็นรายงานประจำปี หลังจากสถานศึกษาดำเนินการจัดการศึกษาเสร็จสิ้นในแต่ละปีการศึกษานำเสนอต่อคณะกรรมสถานศึกษาให้ความเห็นชอบและนำเสนอหน่วยงานต้นสังกัด หน่วยงานที่เกี่ยวข้อง และรายงานสู่สาธารณชน โดยสถานศึกษานำเสนอข้อมูลเชิงปริมาณและคุณภาพที่มีสาระสำคัญ', N'๑)การสรุปและจัดทำรายงานประจำปีที่เป็นรายงานประเมินคุณภาพภายในของสถานศึกษา
๒)การนำเสนอรายงานต่อคณะกรรมการสถานศึกษาขั้นพื้นฐาน และคณะกรรมการสถานศึกษา และหรือคณะกรรมการบริหารสถานศึกษาให้ความเห็นชอบ
๓)การเผยแพร่รายงานต่อสาธารณชน หน่วยงานต้นสังกัดและหน่วยงานที่เกี่ยวข้อง', 2, N'ผู้บริหารสถานศึกษา ครู บุคลากรและผู้ที่เกี่ยวข้องกับการจัดทำรายงานประจำปีเป็นรายงานประเมินคุณภาพภายในของสถานศึกษา
ผู้เกี่ยวข้องในการนำผลการประเมินไปใช้ในการพัฒนาคุณภาพของสถานศึกษา', N'แผนพัฒนาการจัดการศึกษาและแผนปฏิบัติการประจำปีของสถานศึกษา
สรุปรายงานประจำปีเป็นรายงานประเมินคุณภาพภายในของสถานศึกษา
หลักสูตรการเผยแพร่รายงาน
ฯลฯ', 2, 0, CAST(0x0000A35D00E692FD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565009B11D7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'41E650DC-B798-4C38-AA21-44668A461173', N'2C75D0A1-6E02-4D4B-8964-4F910D347EFD', N'ผลการประเมินสมรรถนะสำคัญตามหลักสูตร', N'ผลการประเมินผู้เรียนตามสมรรถนะสำคัญตามหลักสูตร 5 ด้าน คือ
1. ความสามารถในการสื่อสาร
2. ความสามารถในการคิด
3. ความสามารถในการแก้ปัญหา
4. ความสามารถในการใช้ทักษะชีวิต
5. ความสามารถในการใช้เทคโนโลยี', N'ร้อยละของผู้เรียนที่มีผลการประเมินสมรรถนะสำคัญตามหลักสูตร', 2, N'สรุปผลการประเมินสมรรถนะสำคัญตามหลักสูตร 5 ด้าน', N'1. การตรวจสอบหลักฐาน โครงการ/กิจกรรมที่เกี่ยวข้อง
2. การสังเกตสภาพบรรยากาศในการเรียนรู้', 3, 0, CAST(0x0000A35D00E692D3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500E3EB83 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'CF975CED-E611-4E0F-8E12-7BD3876791C1', N'AC932F39-6D8D-46BF-A947-204963E23229', N'เป็นคนดีและปฏิบัติตนหลักธรรมทางศาสนา', N'ผู้เรียนดำรงตนอย่างมีคุณค่า มีความเอื้ออาทรและน้ำใจไมตรี มีความเมตตากรุณา มีความรับผิดชอบ ตรงต่อเวลา ประหยัด ขยันอดทน มีความสามัคคีและเห็นแก่ประโยชน์ส่วนร่วม ประพฤติปฏิบัติตนตามหลักธรรมทางศาสนาที่ตนนับถือ และผ่านการทำงาน/ทำกิจกรรมเพื่อบำเพ็ญประโยชน์(จิตอาสา(อย่างน้อย 1 ครั้ง/ปี/คน', N'ร้อยละของผู้เรียนที่เป็นคนดีและปฏิบัติตนตามหลักะรรมทางศาสนา', 2, N'การพูดคุยซักถามผู้เรียน ครู ผู้ปกครอง และผู้ที่เกี่ยวข้อง', N'1. สรุปรายงานผลโครงการ/กิจกรรมที่เกี่ยวข้อง
2. การตรวจสอบหลักฐานการทำงาน กิจกรรมเพื่อบำเพ็ญประโยชน์(จิตอาสา) ของนักเรียน', 3, 0, CAST(0x0000A35D00E692C5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500D18AD1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'0D577958-DAE3-4810-A611-55250EB62F46', N'A71DC241-C269-44C5-B69C-CEFA99F73C73', N'มีความรู้ความสามารถและเจตคติที่ดีต่อาชีพสุจริต', N'ผู้เรียนมีความรู้ความสนใจและมีเจตคติที่ดีต่ออาชีพสุจริต สามารถบอกหรือทำกิจกรรมเกี่ยวกับอาชีพที่ตนเองสนใจได้อย่างน้อย 1 อาชีพ', N'ร้อยละของผู้เรียนที่มีความรู้ความสามารถและเจตคติที่ดีต่ออาชีพสุจริต', 1, N'การสังเกตพฤติกรรมของผู้เรียนและการพูดคุยซักถามนักเรียน ครู และผู้ปกครอง', N'1. การตรวจสอบหลักฐาน โครงการ/กิจกรรมเกี่ยวกับอาชีพของนักเรียน
2. รายงานผลการพัฒนาผูเรียนในด้านอาชีพต่าง ๆ', 3, 0, CAST(0x0000A35D00E692D8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500E8C970 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'6675030A-7436-4DAE-A889-62D2F8011BA0', N'AC932F39-6D8D-46BF-A947-204963E23229', N'มีคุณลักษณะอันพึ่งประสงค์ตามหลักสูตร', N'ผู้เรียนมีคุณลักษณะพึ่งประสงค์ตามหลักสูตรแกนแกลางการศึกษาขั้นพื้นฐาน พุทธศักราช 2552 ครบทั้ง 8 คุณลักษณะ คือ
1. รักชาติ ศาสน์ กษัตริย์
2. ซื้อสัตย์สุจริต
3. มีวินัย
4. ใฝ่เรียนรู้
5. อยู่อย่างพอเพียง
6. มุ่งมั่นในการทำงาน
7. รักความเป็นไทย
8. มีจิตสาธารณะ', N'ร้อยละของผู้เรียนที่มีคุณลักษณะอันพึ่งประสงค์ตามหลักสูตร', 2, N'การพูดคุยซักถามนักเรียน ครู ผู้บริหารสถานศึกษาและผู้ปกครอง/ชุมชน', N'1. รายงานผลการประเมินคุณลักษณะอันพึ่งประสงค์ตามหลักสูตรฯ
2. ตรวจสอบแผนพัฒนาการจัดการศึกษา แผนปฏิบัติการประจำปี สรุปงาน/กิจกรรม/โครงการ ที่เกี่ยวข้อง โล่ เกียรติบัตร รางวัลของนักเรียน/สถานศึกษา', 2, 0, CAST(0x0000A35D00E692C5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500D05501 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'70CC4B19-1971-49F2-9C83-2FE8FFCA5433', N'997ADC5E-C0D0-4051-ACB5-4F83B200193B', N'กำหนดมาตรฐานการศึกษาของสถานศึกษา', N'สถานศึกษามีการพัฒนาหลักสูตรสถานศึกษาที่นำเป้าหมาย จุดเน้นการพัฒนาผู้เรียนในระดับท้องถิ่น สาระการเรียนรู้ท้องถิ่นมาจัดการเรียนรู้เกี่ยวกับท้องถิ่นในด้านต่างๆ เช่น เศรษฐกิจ สังคม วัฒนธรรม ฯลฯ เพื่อให้ผู้เรียนมีโอกาสเรียนรู้เรื่องราวของชุมชน ท้องถิ่น ซึ่งเป็นสภาพแวดล้อมในชีวิต ทำให้เกิดความรัก ความผูกพันความภาคภูมิใจ ปฏิบัติเป็นแบบอย่างที่ดีของชุมชนมีส่วนร่วมในการดูแล แก้ไขปัญหาและพัฒนาท้องถิ่นของตนเอง', N'๑)คณะกรรมการจัดทำหลักสูตรสถานศึกษา ประกอบด้วยผู้มีส่วนเกี่ยวข้องทุกฝ่าย(คณะครู ผู้บริหาร กรรมการศึกษา ผู้แทนชุมชน/ผู้ทรงคุณวุฒิ)และหลักสูตรผ่านความเห็นชอบจากคณะกรรมการสถานศึกษา
๒)โครงสร้างหลักสูตรสถานศึกษามีองค์ประกอบครบถ้วนและสอดคล้องหลักสูตรแกนกลางฯ ตอบสนองเป้าหมายวิสัยทัศน์หรือจุดเน้นของสถานศึกษา และมีการกำหนดเวลาเรียนเหมาะสมกับระดับชั้น
๓)รายวิชาพื้นฐานและรายวิชาเพิ่มเติมที่วัดได้ในหลักสูตรมีการจัดลำดับเนื้อหาสาระ ความยากง่าย ความซับซ้อน และมีการบูรณาการสภาพปัญหาและความต้องการของท้องถิ่นสอดแทรกในรายวิชาอย่างเหมาะสม
๔)มีการติดตามการใช้หลักสูตรทุกกลุ่มสาระการเรียนรู้และสรุปผลทุกภาคเรียน
๕)มีการทบทวนหลักสูตรสถานศึกษาทุกปีการศึกษาโดยใช้สรุปผลการติดตามการใชหลักสูตร ผลการวิจัยชั้นเรียนของครูหรือผลงานวิจัยอื่นๆ ที่เกี่ยวข้อง', 0.5, N'ผู้บริหาร ครู คณะกรรมการสถานศึกษา ผู้ปกครอง ผู้แทนชุมชนและผู้ที่เกี่ยวข้อง', N'หลักสูตรการจัดการศึกษาของสถานศึกษา
ขั้นตอนการจัดทำหลักสูตร
การใชหลักสูตรสถานศึกษา
การวิจัยและติดตามผลการใช้หลักสูตร
การปรับปรุงและพัฒนาหลักสูตรสถานศึกษา
บันทึกการประชุม/คำสั่ง/หลักฐานอื่นที่เกี่ยวข้อง
ป้ายกิจกรรมต่างๆ ที่เกี่ยวข้อง เช่น ป้าย/บอร์ดการจัดกิจกรรมการมีส่วนร่วมของผู้ปกครองชุมชน
ฯลฯ', 1, 0, CAST(0x0000A35D00E692F4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565009BCDE9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1, N'422A806A-D3F6-41B0-BBAA-C40CEB3E23B8')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'B4EF8C49-9F9D-4CD2-AEFD-40674820D45E', N'997ADC5E-C0D0-4051-ACB5-4F83B200193B', N'จัดทำแผนพัฒนาการจัดการศึกษาของสถานศึกษาที่มุ่งเน้นพัฒนาคุณภาพตามมาตรฐาน', N'สถานศึกษาจัดรายวิชาเพิ่มเติมได้อย่างหลากหลายภายใต้สัดส่วนเวลาเรียนตามโครงสร้างหลักสูตร รายวิชาเพิ่มเติมมีเนื้อหาสาระเหมาะสมตามโครงสร้างที่จัดให้ผู้เรียนผู้เรียนมีโอกาสเลือกเรียนตามความสนใจหรือความต้องการ ตัวชี้วัด/ผลการเรียนรู้ที่คาดหวังของรายวิชาเพิ่มเติ่มตอบสนองจุดเน้นของสถานศึกษา  และมีรายวิชาเพิ่มเติมอย่างน้อย ๒ รายวิชาที่บูรณาการข้ามกลุ่มสาระเรียนรู้', N'๑)มีรายวิชาเพิ่มเติมหลากหลายเพียงพอให้ผู้เรียนมีโอกาสเลือกเรียนตามความถนัดและความสนใจ
๒)รายวิชาเพิ่มเติมมีเนื้อหา/สาระการเรียนรู้เหมาะสมตามโครงสร้างที่จัดให้ผู้เรียนเรียน
๓)ผู้เรียนสามารถเลือกเรียนรายวิชาเพิ่มเติมได้ตามความต้องการ
๔)ตัวชี้วัด/ผลการเรียนรู้ที่คาดหวังของรายวิชาเพิ่มเติมตอบสนองจุดเน้นของสถานศึกษา
๕)มีรายวิชาเพิ่มเติมที่มีการบูรณาการข้ามกลุ่มสาระอย่างน้อย ๒ รายวิชา', 0.5, N'ผู้บริหารสถานศึกษา คณะกรรมการสถานศึกษาครู ผู้ปกครอง ผู้แทนชุมชนและผู้มีส่วนร่วม', N'หลักสูตรสถานศึกษา
การจัดทำโครงสร้างรายวิชาเพิ่มเติม
การลงทะเบียนเรียนรายวิชาเพิ่มเติม
แนวทางการบริหารจัดการหลักสูตรสถานศึกษา
ป้ายกิจกรรมต่างๆ ที่เกี่ยวข้อง เช่น ป้าย/บอร์ดการจัดกิจกรรมการมีส่วนร่วมของผู้ปกครอง ชุมชน
ฯลฯ', 2, 0, CAST(0x0000A35D00E692F8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565009C1527 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'422A806A-D3F6-41B0-BBAA-C40CEB3E23B8')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'8CC34F5A-A091-4059-B302-D16E39E8DB72', N'11BE78C4-1F5D-44BF-9DDB-2AEE2F71108D', N'มีสุขนิสัยที่ดี', N'ผู้เรียนมีสุขภาพร่างกายแข็งแรง แต่งกายสะอาดเรียบร้อยปฏิบัติตนตามสุขบัญญติ 10 ประการดังนี้ (สำนักงานปลัดกระทรวงสาธารณสุข. 2542)
1. ดูแลรักษาร่างกายและของใช้ให้สะอาด
2. รักษาฟันให้แข็งแรงและแปรงฟันทุกวันอย่างถูกต้อง
3. ล้างมือให้สะอาดก่อนกินอาหารและหลังการขับถ่าย
4. กินอาหารสุก สะอาด ปราศจากสารอันตราย และหลีกเลี่ยงอาหารรสจัด สีฉูดฉาด
5. งดบุหรี่ สุรา สารเสพติด การพนัน และการสำส่อนทางเพศ
6. สร้างความสัมพันธ์ในครอบครัวให้อบอุ่น
7. ป้องกันอุบัติภัยด้วยการไม่ประมาท
8. ออกกำลังกายสม่ำเสมอและตรวจสุขภาพประจำปี
9. ทำจิตใจให้ร่าเริงแจ่มใสอยู่เสมอ
10. มีสำนึกต่อส่วนรวมร่วมสร้างสรรค์สังคม', N'ร้อยละของผู้เรียนที่มีสุขนิสัยที่ดี', 2, N'การพูดคุยซักถามนักเรียนครู และผู้ปกครอง', N'สรุปผลการประเมินสุขบัญญติ 10 ประการของผู้เรียน

ข้อมูลสารสนเทศของสถานศึกษาเกี่ยวกับการมีสุขนิสัยที่ดีของนักเรียน เช่น สถิติการใช้ห้องพยาบาล สถิติการมาเรียน ข้อมูลด้านสุขภาพของนักเรียนรายบุคคล', 3, 0, CAST(0x0000A35D00E692B7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500C832D8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'D730AB5E-F755-4906-8E79-42858D44D843', N'A71DC241-C269-44C5-B69C-CEFA99F73C73', N'มีความสามารถทำงานเป็นทีม', N'ผู้เรียนมีความสามารถในการทำงานร่วมกับผู้อื่นมีภาวะผู้นำและผู้ตามที่ดี มีความรับผิดชอบและสามารถปฏิบัติงานตามบทบาทหน้าที่จนบรรลุผลสำเร็จตามเป้าหมายของทืม', N'ร้อยละของผู้เรียนที่มีความสามารถในการทำงานเป็นทีม', 2, N'การสังเกตพฤติกรรมของผู้เรียนและการพูดคุยซักถามนักเรียนและครู', N'1. การตรวจสอบผลงานของนักเรียน
2. รายงานผลการพัฒนาผู้เรียนด้านการทำงานเป็นทีม', 2, 0, CAST(0x0000A35D00E692D8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500E7E78D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'EC52D157-B407-4435-9F40-8CED77C69B3F', N'63be60f1-3756-4f0c-a0d0-b025c7db5395', N'ผลการดำเนินงานส่งเสริมให้ผู้เรียนบรรลุตามเป้าหมาย  วิสัยทัศน์  ปรัชญา  และจุดเน้นของสถานศึกษา', N'สถานศึกษามีผลการดำเนินงานกลยุทธ์ กิจกรรม โครงการ ที่สถานศึกษากำหนดที่เป็นคำตอบของผลลัพธ์การดำเนินงานที่สนองเป้าหมายวิสัยทัศน์ ปรัชญาและจุดเน้นของสถานศึกษา และสะท้อนเป็นเอกลักษณ์ของสถานศึกษา เป็นที่ยอมรับของชุมชนและท้องถิ่น เช่น โรงเรียนสองภาษา โรงเรียนแกนนำด้านวิทยาศาสตร์ เป็นต้น', N'๑)ผลการดำเนินงานบรรลุตามเป้าหมาย วิสัยทัศน์ ปรัชญา และจุดเน้นของสถานศึกษา', 2, N'ผู้บริหารสถานศึกษา ครู กรรมการสถานศึกษา นักเรียน ผู้ปกครองนักเรียน ผู้เกี่ยวข้อง', N'เป้าหมาย วิสัยทัศน์ ปรัชญา จุดเน้น เป้าหมาย กลยุทธ์ กิจกรรมหรือโครงการ และวัตถุประสงค์ของการจัดตั้งสถานศึกษา', 2, 1, CAST(0x0000A35D00E69314 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500965CAF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'72050225-8D36-4DD7-951C-16065B9FD9FD', N'11BE78C4-1F5D-44BF-9DDB-2AEE2F71108D', N'มีสุภาพจิตที่ดี', N'ผู้เรียนมีคุณลักษณะและพฤติกรรมการแสดงออกที่ดีมีความยิ่มแย้มแจ่มใส มองโลกในแง่ดี เข้าใจและภูมิใจในตนเอง มีความสามารถในการสื่อสาร และสร้างความสัมพันธ์ที่ดีกับผู้อื่น กล้าแสดงออกอย่างถูกต้องเหมาะสมกับเพศและวัย และบทบาทหน้าที่ มีทักษะชีวิตสามารถดำรงชีวิตได้อย่างมีคุษภาพและมีคุณค่าในสังคม', N'ร้อยละของผู้เรียนที่มีสุขภาพจิตที่ดี', 2, N'การพูดคุยซักถามนักเรียนครู และผู้ปกครอง', N'รายงานการประเมินสุขภาพจิตของนักเรียน/หลักฐานการเมินตนเองของนักเรียน

รายงานผลการดำเนินงานระบบดูแลช่วยเหลือนักเรียน', 2, 0, CAST(0x0000A35D00E692B7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500AAECE3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'3E3974B8-E05C-4117-85E4-14E4536BF17C', N'AC932F39-6D8D-46BF-A947-204963E23229', N'รู้คุณค่าร่วมอนุรักษ์และพัฒนาทรัพยากรธรรมชาติพลังงาน และสิ่งแวดล้อม', N'ผู้เรียนมีความตระหนักและรู้คุณค่าของทรัพยากรธรรมชาติพลังงานและสิ่งแวดล้อม เห็นประโยชน์และผลกระทบต่อตนเองและสังคมส่วนรวม และร่วมทำกิจกรรมในโครงการอนุรักษ์และพัฒนาทรัพยากรธรรมชาติพลังงานและสิ่งแวดล้อมทั้งที่สถานศึกษาและหน่วยงานอื่นจัดขึ้น', N'ร้อยละของผู้เรียนที่รู้คุณค่า ร่วมอนุรักษ์และพัฒนาทรัพยากรธรรมชาติ พลังงานและสิ่งแวดล้อม', 2, N'การพูดคุยซักถามนักเรียน ครู แะผู้บริหารสถานศึกษา', N'1. สรุปรายงานผลโครงการ/กิจกรรมที่เกี่ยวข้อง
2. การตรวจสอบหลักฐานการเข้าร่วมกิจกรรม/โครงการร่วมอนุรักษ์และพัฒนาทรัพยากรธรรมชาติพลังงาน และสิ่งแวดล้อมของนักเรียน', 5, 0, CAST(0x0000A56500D48AF2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500D48AF2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'AC975F48-220F-45A1-AE39-125A05374DBB', N'05AE9218-7C3F-4B0B-BE5F-B9BD1C9CADA5', N'ส่งเสริมเอกลักษณ์ของสำนักงานเขตพื้นที่การศึกษามัธยมศึกษาเขต 1 (รักความเป็นไทย ก้าวไกลสู่สากล)', N'สถานศึกษาจัดห้องสมุดให้มีระบบบริหารจัดการทรัพยากรสารสนเทศที่ทันสมัยสอดคล้องกับความต้องการของผู้เรียน เพื่อสร้างสังคมแห่งการเรียนรู้และสร้างนิสัยรักการอ่านอย่างยั่งยืน ผู้เรียนสามารถเข้าถึงสารสนเทศได้อย่างรวดเร็ว เอื้อให้ผู้เรียนรู้ด้วยตนเองและหรือเรียนรู้แบบมีส่วนร่วม', N'๑)การจัดห้องสมุดให้มีระบบบริหารจัดการทรัพยากรสารสนเทศที่ทันสมัย
๒)ให้บริการสื่อและเทคโนโลยีสารสนเทศที่เอื้อให้ผู้เรียนเรียนรู้ด้วยตนเองและเรียนรู้แบบมีส่วนร่วม
๓)ความพึงพอใจของผู้เรียน', 1, N'ผู้บริหาร ครู ผู้เรียน คณะกรรมการสถานศึกษา ผู้ปกครอง ผู้แทนชุมชน', N'แผนพัฒนาคุณภาพการศึกษา
แผนปฏิบัติการประจำปี โครงการ/กิจกรรม
รายงานโครงการฯรายงานประจำปีของโรงเรียน
สมุดคำสั่ง
บันทึกการประชุมของโรงเรียน
หลักสูตรสถานศึกษา แผนการจัดการเรียนรู้ สถิติการใช้ห้องสมุด
สถิติการใช้สื่อสารสนเทศเพื่อการเรียนรู้ของผู้เรียน
ชิ้นงานของผู้เรียนที่เกิดจากการใช้บริการห้องสมุด
สภาพและบรรยากาศของห้องสมุด สื่อและเทคโนโลยีสารสนเทศในห้องสมุด
ฯลฯ', 3, 0, CAST(0x0000A35D00E692FD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565009B5836 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'1C8CFC81-D0CB-40AC-9E8F-D5BE3686499F', N'BA0DCE8A-BED3-4CB5-9A4D-2761551EA885', N'พัฒนาผู้เรียนให้มีความสามารถและทักษะที่จำเป็นต่อการดำรงชีวิต ในศตวรรณที่ 21', N'สถานศึกษามีการดำเนินการส่งเสริมและพัฒนาผู้เรียนให้มีความสามารถและทักษะที่จำเป็นต่อการดำรงชีวิตในศตวรรษที่ 21 เช่น 1)ทักษะการเรียนรู้และนวัตกรรม (Learning and Innovation Skills) ได้แก่ (1) นวัตกรรมและการสร้างสรรค์ (Creativityand Innovation) ประกอบด้วย การคิดอย่างสร้างสรรค์ การทำงานร่วมกับผู้อื่นอย่างสร้างสรรค์และการนำนวัตกรรมไปใช้ (2) การคิดเชิงวิพากษ์และการแก้ปัญหา (Critical Thinkingand Problem Solving) ประกอบ การมีเหตุผลการคิดอย่างเป็นระบบ การตัดสินใจและการแก้ปัญหา (3) การสื่อสารและการร่วมมือ (Communication and Collaboration) ประกอบด้วย การสื่อสารที่ชัดเจนและการร่วมมือกับผู้อื่น 2) ทักษะด้านสารสนเทศสื่อและเทคโนโลยี (Information Media and Technology Skills) และ 3) ทักษะชีวิตและการประกอบอาชีพ (Life and Career Skills) ประกอบด้วย ความยืดหยุ่นและความสามารถปรับตัวได้ การริเริ่มและเรียนรู้ได้ด้วยตนเอง การมีทักษะทางสังคมและก้าวข้ามวัฒนธรรม ผลิตสร้างสรรค์ผลงานได้ตลอดจนเป็นผู้นำและรับผิดชอบต่อสังคม', N'1. ความมีเหตุผลในการกำหนดทักษะที่เหมาะสมและจำเป็นสำหรับผู้เรียนของสถานศึกษา
2. การกำหนดตัวชี้วัดและระดับความสำเร็จไม่น้อยกว่าร้อยละ 90.00
3. การมีระบบกลไกขับเคลื่อนสู่การปฏิบัติที่ชัดเชนและต่อเนื่อง
4. การมีส่วนร่วมของผู้เรียน ครู ผู้บริหารสถานศึกษา ผู้ปกครอง และผู้เกี่ยวข้อง
5. การประเมินผลความสำเร็จบรรลุเป้าหมาย', 2, N'ผู้บริหารสถานศึกษา ครู นักเรียน ผู้ปกครอง และผู้เกี่ยวข้อง', N'เช่น โครงการ/กิจกรรมการพัฒนาความสามารถและทักษะที่จำเป็นในศตวรรณที่ 21 รายงานผลการพัฒนาผู้เรียนให้มีทักษะที่จำเป็นในศตวรรษที่ 21 เป็น

การตรวจสอบ ประเมินผลทักษณะ/ความสามารถของผู้เรียนตามที่สถานศึกษาดำเนินการพัฒนา', 1, 0, CAST(0x0000A35D00E69302 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500A5060A AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'C41A9549-3960-4E03-BEC1-FB41BB74C1E9', N'2C75D0A1-6E02-4D4B-8964-4F910D347EFD', N'ผลการทดสอบความสามารถด้านภาษาการคิดคำนวณและควาสามารถในการใช้เหตุผล', N'ผู้เรียนมีความสามารถด้านภาษาหรือการรู้หนังสือ (Literacy) การคิดคำนวณ (Numeracy) และความสามารถในการใช้เหตุผล (Reasoning Ability)', N'ร้อยละของผู้เรียนที่มีความสามารถในด้านภาษา หรือการรู้หนังสือ การคิดคำนวณและความสามารถในการใช้เหตุผล', 3, N'การสังเกตพฤติกรรมของผู้เรียนและการพูดคุยซักถามนักเรียนและครู', N'1. การทดสอบความสามารถด้านภาษา และการคิดคำนวณ และความสามารถในการใช้เหตุผล
2. การสังเกตการเรียนการสอนในห้องเรียน', 5, 0, CAST(0x0000A56500E5A6EC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500E5A6EC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'8203609C-DC86-4409-9CC8-89A8AC90674A')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'F5D46DC0-6ADA-47CE-8E3C-A66F9A82776B', N'2336a4b9-3679-4477-918c-20a1426c0bc3', N'มีการแลกเปลี่ยนเรียนรู้ระหว่างบุคลากรภายในสถานศึกษา  ระหว่างสถานศึกษากับครอบครัว  ชุมชน  และองค์กรที่เกี่ยวข้อง', N'ผู้บริหารสถานศึกษา ครู นักเรียน ผู้ปกครอง ชุมชน ผู้ทีเกี่ยวข้องและองค์กรที่มีส่วนเกี่ยวข้องกับสถานศึกษา มีการแลกเปลี่ยนเรียนรู้ผ่านกิจกรรม สื่อเทคโนโลยีสารสนเทศแหล่งเรียนรู้ องค์ความรู้ต่างๆ จนสามารถสร้างความรู่ ทักษะ มีระบบการจัดการความรู้มีการถ่ายทอดความรู้ แลกเปลี่ยนเรียนรู้ร่วมกันทั้งบุคลากรภายในสถานศึกษา ระหว่างสถานศึกษากับครอบครัว ระหว่างสถานศึกษากับชุมชนและองค์การที่เกี่ยวข้อง', N'๑)มีการกำหนดแนวทางการส่งเสริม สนับสนุนให้มีการแลกเปลี่ยนเรียนรู้ระหว่างบุคลากรภายในสถานศึกษาผ่านกิจกรรม สื่อเทคโนโลยีสารสนเทศหรือแหล่งเรียนรู้ต่างๆ ภายในสถานศึกษาและดำเนินการตามแนวทางที่กำหนด(Plan, Do)
๒)มีการระบุความรู้ที่จำเป็น (Knowledge Mapping)กลั่นกรองความรู้ที่ได้จากการแลกเปลี่ยนเรียนรู้ในข้อ ๑ มาแบ่งปันความรู้ให้กับบุคลากรภายในสถานศึกษา (Check, Act)
๓)มีการกำหนดแนวทางการส่งเสริม สนับสนุนให้มีการแลกเปลี่ยนเรียนรู้ระหว่างบุคลากรสถานศึกษากับครอบครัว ชุมชน และองค์กรที่เกี่ยวข้องผ่านกิจกรรม สื่อเทคโนโลยีสารสนเทศหรือแหล่งเรียนรู้ต่างๆ ทั้งภายในและภายนอกสถานศึกษา และดำเนินการตามแนวทางที่กำหนด(Plan ,Do)
๔)มีการระบุความรู้ที่จำเป็น(Knowledge Mapping)กลั้นกรองความรู้ที่ได้จาการแลกเปลี่ยนเรียนรู้ในข้อ ๓ มาแบ่งปันความรู้ให้กับครอบครัว ชุมชนและองค์การที่เกี่ยวข้อง (Check ,Act)
๕)สร้างเครือข่ายการเรียนรู้ทั้งภายในและภายนอกสถานศึกษา มีการเผยแพร่ความรู้และนำความรู้ไปใช้ประโยชน์', 5, N'ผู้บริหารสถานศึกษา คณะกรรมการสถานศึกษา ครู ผู้เรียน ผู้ปกครองและผู้ที่มีส่วนเกี่ยวข้อง', N'แผนพัฒนาคุณภาพการจัดการศึกษาของสถานศึกษา
แผนปฏิบัติการประจำปี โครงการ/กิจกรรม
ผลการวิเคราะห์ข้อมูลสารสนเทศ
เอกสารรายงานการนิเทศติดตามผลการดำเนินงาน
บันทึกรายงานการประชุม
รายงานสรุปผลการประเมินโครงการหรือรายงานผลการปฏิบัติงาน หนังสือเชิญบุคคลหรือหน่วยงานภายนอก
ภาพถ่ายกิจกรรมต่างๆ ที่เกี่ยวกับการแลกเปลี่ยนเรียนรู้
เอกสารการเผยแพร่ความรู้ เช่น แผ่นพับ แผ่นปลิว วารสาร แถบวิดีทัศน์
ป้าย/บอร์ดกิจกรรมต่างๆ ที่เกี่ยวข้อง เช่น ป้าย/บอร์ดการจัดกิจกรรม บอร์ดแสดงแหล่งเรียรู้ต่างๆ ในและนอกสถานศึกษา
ฯลฯ', 2, 1, CAST(0x0000A35D00E69310 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500966C78 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'48A323CC-2FD0-49C3-AD18-4AD1A164EECB', N'05AE9218-7C3F-4B0B-BE5F-B9BD1C9CADA5', N'อัตลักษณ์ของผู้เรียน', N'สถานศึกษามีห้องเรียน ห้องปฏิบัติการ ห้องน้ำ โรงอาหาร หอประชุม ที่สะอาดถูกสุขลักษณะ มีความมั่นคงแข็งแรงปลอดภัย มีสิ่งอำนวยความสะดวกในการเรียนรู้ ได้แก่ สื่อวัสดุอุปกรณ์ต่างๆพอเพียรกับผู้เรียนและอยู่ในสภาพใช้การได้ดี มีสภาพแวดล้อมที่สวยงามร่มรื่นและมีแหล่งเรียนรู้ในโรงเรียนสำหรับผู้เรียน', N'๑)ห้องเรียน ห้องปฏิบัติการ ห้องน้ำ โรงอาหาร หอประชุม
๒)สิ่งอำนวยความสะดวกในการเรียนรู้
๓)สภาพแวดล้อมและแหล่งเรียนรู้ในโรงเรียนสำหรับผู้เรียน', 2, N'ผู้บริหาร ครู ผู้เรียน คณะกรรมการสถานศึกษา ผู้ปกครองผู้แทนชุมชน', N'แฟ้มเอกสาร แผนปฏิบัติการประจำปี โครงการ/กิจกรรม
แบบบันทึกการกำกับติดตามงานอาคารสถานที่
บันทึกการประชุม คำสั่งการปฏิบัติงานของโรงเรียน
รายงานประจำปีของโรงเรียน
แบบสำรวจและสรุปความพึงพอใจ
อาคาร ห้องเรียน ห้องปฏิบัติการ สื่อ/วัสดุอุปกรณ์สภาพแวดล้อม แหล่งเรียรู้
ฯลฯ', 1, 0, CAST(0x0000A35D00E692FD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565009AEC80 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'4A12BACC-726D-4B5D-8820-8CB37D1A41B8', N'997ADC5E-C0D0-4051-ACB5-4F83B200193B', N'ดำเนินงานตามแผนพัฒนาการจัดการศึกษาของสถานศึกษา', N'สถานศึกษาบริหารจัดการหักสูตรสถานศึกษาสู่การปฏิบัติ โดยสร้างความเข้าใจเกี่ยวกับหลักสูตร การออกแบบและจัดการเรียนรู้ การวัดและประเมินผลการเรียน เพื่อให้ครูจัดการเรียนการสอนให้บรรลุถึงมาตรฐานการเรียนรู้และตัวชี้วัด ให้ผู้เรียนอธิบายกระบวนการคิดการลงมือทำงานในสถานการณ์จริงหรือใกล้เคียงความเป็นจริงให้ผู้เรียนได้ใช้การวิจัยในการเรียนรู้และการแก้ปัญหาจนผู้เรียนสามารถสรุปความรู้ด้วยตนเองได้จริง', N'๑)มีการอบรมและพัฒนาครูเพื่อทบทวนความเข้าใจเกี่ยวกับหลักสูตรอิงมาตรฐานและการจัดการเรียนรู้ที่เน้นผู้เรียนเป็นสำคัญอย่างน้อยภาคละ ๑ ครั้ง
๒)การจัดกิจกรรมการเรียนรู้ที่ระบุในแผนการสอน/หน่วยการเรียนรู้ของครูทุกกลุ่มสาระสะท้อนว่าผู้เรียนสามารถบรรลุตามมาตรฐานและตัวชี้วัดได้
๓)ผู้เรียนได้มีโอกาสลงมือปฏิบัติในสถานการณ์จริงหรือใกล้เคียงสถานการณ์จริงอย่างน้อย ๑ ครั้ง ในทุกกลุ่มสาระการเรียนรู้
๔)มีผลงานที่แสดงการให้ผู้เรียนอธิบายวิธีคิดและการสรุปความคิดของตนเองทุกกลุมสาระ
๕)มีผลงาน/โครงการที่ใช้การวิจัยเป็นส่วนหนึ่งในการเรียนรู้อย่างน้อย ๓ กลุ่มสาระ', 0.5, N'ผู้บริหาร ครู คณะกรรมการสถานศึกษา ผู้ปกครอง ผู้แทนชุมชน และผู้มีส่วนเกี่ยวข้อง', N'แผนงาน/โครงการ/กิจกรรมที่ส่งเสริมและสนับสนุนให้ครูจัดการเรียนรู้ของครูที่เน้นผู้เรียนเป็นสำคัญ
แผนการจัดการเรียนรู้ของครู
ผลงานของนักเรียน สื่อ นวัตกรรมเกี่ยวกับการจัดการเรียนการสอน
ภาพถ่ายในกิจกรรมการเรียนการสอน
ฯลฯ', 4, 0, CAST(0x0000A35D00E692F8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565009C6089 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'422A806A-D3F6-41B0-BBAA-C40CEB3E23B8')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'158D47EC-7863-40AD-93AA-19F66BA70507', N'997ADC5E-C0D0-4051-ACB5-4F83B200193B', N'จัดให้มีการประเมินคุณภาพภายในตามมาตรฐานการศึกษาของสถานศึกษา', N'สถานศึกษาจัดระบบดูแลช่วยเหลือนักเรียนทุกคนด้วยความเสมอภาคอย่างทั่วถึงและต่อเนื่อง นำข้อมูลผลการวิเคราะห์ผู้เรียนเป็นรายบุคคลมาวางแผนการปรับปรุงส่งเสริมและพัฒจกนา ผู้เรียนตามความแตกต่างระหว่างบุคคล ความถนัด ความสนใจ ความพร้อม เพื่อให้ผู้เรียนมีภูมิคุ้มกัน สามารถเรียนรู้พัฒนาตนเองได้และอยู่ร่วมกับผู้อื่นอย่างมีความสุข', N'๑)แผนงาน/โครงการ/กิจกรรมเกี่ยวกับระบบดูแลช่วยเหลือนักเรียน
๒)การมอบหมายความรับผิดชอบนักเรียนเป็นรายบุคคล
๓)การสำรวจข้อมูลนักเรียนเป็นรายบุคคลด้วยวิธีการที่หลากหลาย
๔)การคัดกรองและจำแนกนักเรียนเป็นรายกลุ่มตามสภาพ
๕)การจัดกิจกรรมป้องกัน แก้ไขและพัฒนานักเรียนตามสภาพอย่างเหมาะสม
๖)การประเมินผลการจัดกิจกรรมป้องกัน แก้ไขและพัฒนานักเรียน
๗)การประสานและส่งต่อการแก้ไขและพัฒนานักเรียนแก่ผู้ที่เกี่ยวข้องทั้งภายในและภายนอกสถานศึกษา
๘)ผลการดำเนินงานของสถานศึกษา', 1, N'ผู้บริหาร ครู ผู้เรียน และบุคลากรผุ้มีส่วนเกี่ยวข้อง', N'แผนงาน/โครงการ/กิจกรรม
คำสั่ง เอกสารข้อมูลสารสนเทศนักเรียนเป็นรายบุคคล
การคัดกรองและจำแนกนักเรียนเป็นรายกลุ่มตามสภาพ
บันทึกผลการจัดกิจกรรมป้องกัน แก้ไข และพัฒนานักเรียนตามสภาพอย่างเหมาะสม
สถิติผลการป้องกัน แก้ไขและพัฒนานักเรียน
บันทึกผลการประสานและส่งต่อการแก้ไขและพัฒนานักเรียนแก่ผู้ที่เกี่ยวข้อง
ฯลฯ', 6, 0, CAST(0x0000A35D00E692F8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565009CCA83 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'15E51A5A-735B-4CBA-A33C-951816FEA5E4', N'ECD9FDA1-0B7E-454B-B80A-D933FB4350B8', N'คณะกรรมการสถานศึกษาขั้นพื้นฐานสามารถปฏิบัติหน้าที่ได้อย่างมีประสิทธิภาพ', N'', N'', 3, N'', N'', 1, 0, CAST(0x0000A35D00E692EF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565010E75A3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1, N'8203609C-DC86-4409-9CC8-89A8AC90674A')

INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) 
VALUES (N'2CDD1A6F-6311-4B65-B407-88B340F903D7', N'94d3eb04-c953-4b06-8192-68c0e6ed1e95', N'ผลการดำเนินงานบรรลุตามเป้าหมาย', N'ผลการดำเนินงานบรรลุเป้าหมาย หมายถึง สถานศึกษากำหนดเป้าหมายของการดำเนินงานโครงการ กิจกรรมพิเศษที่ตอบสนองนโยบาย จุดเน้นตามแนวทางปฏิรูปการศึกษาและมีผลสัมฤทธิ์ของโครงการ/กิจกรรมพิเศษ บรรลุเป้าหมาย โดยนักเรียน ครู ผู้ปกครอง และผู้ที่เกี่ยวข้อง มีส่วนร่วมและพอใจในการดำเนินการ', N'๑)ผมสัมฤทธิ์ของโครงการ กิจกรรมพิเศษบรรลุตามเป้าหมาย 
๒)บุคลากรในสถานศึกษามีส่วนร่วมและมีความพึงพอใจต่อผลการดำเนินงานโครงการ/กิจกรรมพิเศษ      
๓)ผลกระทบจากการดำเนินงานโครงการ/กิจกรรมพิเศษเกิดประโยชน์เป็นแบบอย่างและสร้างคุณค่าแก่สถานศึกษาและชุมชนรอบสถานศึกษา', 2, N'ผู้บริหาร ครู นักเรียน ผู้ปกครองนักเรียน หรือผู้เกี่ยวข้องกับการดำเนินงาน', N'หลักฐาน ร่องรอยการวิเคราะห์นโยบายของต้นสังกัดจุดเน้นตามแนวทางปฏิรูปการศึกษาเพื่อการจัดทำแผนโครงการพิเศษ
แผนพัฒนาคุณภาพการจัดการศึกษาของสถานศึกษา
แผนปฏิบัติการประจำปี โครงการ กิจกรรมพิเศษ
เอกสารแผนงาน โครงการ กิจกรรม
สรุปผลการประเมินโครงการหรือรายงานผลการปฏิบัติงาน
รายงานสรุปการประเมินโครงการหรือรายงานผลการปฏิบัติงาน
ข้อมูลการสอบถามความพึงพอใจครู ผู้บริหาร นักเรียน หรือผู้เกี่ยวข้องกับการดำเนินงาน', 2, 1, CAST(0x0000A35D00E69319 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565009653B2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')


INSERT [dbo].[Side] ([SideCode], [StudyYear], [SideName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID]) 
VALUES (N'B530DE97-A199-4592-B164-A9BC8FE6F55A', @StudyYear, N'ด้านมาตรการส่งเสริม', 5, 0, CAST(0x0000A35D00E69319 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A35D00E69319 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'4BD33310-AE51-4E69-9D84-A4A8173D81F0')

INSERT [dbo].[Side] ([SideCode], [StudyYear], [SideName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID]) 
VALUES (N'E2A40C79-A98D-436C-8F68-D3F2490E490F', @StudyYear, N'ด้านอัตลักษณ์และเอกลักษณ์', 4, 0, CAST(0x0000A35D00E69310 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565008DC164 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'4BD33310-AE51-4E69-9D84-A4A8173D81F0')

INSERT [dbo].[Side] ([SideCode], [StudyYear], [SideName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID]) 
VALUES (N'9F05D19B-92BD-44FB-A44E-563966093E3A', @StudyYear, N'ด้านคุณภาพผู้เรียน', 1, 0, CAST(0x0000A35D00E692AD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565008C27E0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'5D9C042C-A0AC-42DC-9DC6-20C4B601D127')

INSERT [dbo].[Side] ([SideCode], [StudyYear], [SideName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID]) 
VALUES (N'C8399C32-FB02-418C-AD44-D248E0273F46', @StudyYear, N'ด้านครู', 2, 0, CAST(0x0000A35D00E692DC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565008D8303 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'D7A04A29-300F-4E0F-B100-8026FF7D66D6')

INSERT [dbo].[Side] ([SideCode], [StudyYear], [SideName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID]) 
VALUES (N'A6D1D88B-2C7A-4C77-98DB-791E1372B032', @StudyYear, N'ด้านผู้บริหารสถานศึกษา', 3, 0, CAST(0x0000A35D00E6930B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565008DA70C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'C40FC9F0-2645-4651-9FEC-D3AC1C345F96')



INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) 
VALUES (N'A71DC241-C269-44C5-B69C-CEFA99F73C73', N'ผู้เรียนมีทักษะในการทำงาน  สามารถทำงานร่วมกับผู้อื่นได้  และมีเจตคติที่ดีต่ออาชีพสุจริต', N'9F05D19B-92BD-44FB-A44E-563966093E3A', @StudyYear, N'ผู้เรียนมีทักษะในการทำงาน สามารถทำงานอย่างเป็นระบบ ตั้งแต่การวางแผนและมุ่งมั่นดำเนินการสำเร็จ สามารถทำงานเป็นทีมได้เป็นอย่างดี และมีความรู้ความสนใจ ตลอดจนเจตคติที่ดีต่อาชีพสุจริต', 6, 0, CAST(0x0000A35D00E692D8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500E639C8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'4BD33310-AE51-4E69-9D84-A4A8173D81F0', NULL, NULL, NULL)

INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) 
VALUES (N'05AE9218-7C3F-4B0B-BE5F-B9BD1C9CADA5', N'สถานศึกษามีอัตลักษณ์และเอกลักษณ์ รวมทั้งการส่งเสิรมเอกลักษณ์ของสำนักงานเขตพื้นที่การศึกษา เขต 1', N'E2A40C79-A98D-436C-8F68-D3F2490E490F', @StudyYear, N'', 11, 0, CAST(0x0000A35D00E692FD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5650095CB73 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'4BD33310-AE51-4E69-9D84-A4A8173D81F0', NULL, NULL, NULL)

INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) 
VALUES (N'997ADC5E-C0D0-4051-ACB5-4F83B200193B', N'การพัฒนาระบบการประกันคุณภาพภายในสถานศึกษาที่กำหนดในกฏกระทรวง', N'A6D1D88B-2C7A-4C77-98DB-791E1372B032', @StudyYear, N'', 10, 0, CAST(0x0000A35D00E692F4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A565009545BE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'4BD33310-AE51-4E69-9D84-A4A8173D81F0', NULL, NULL, NULL)

INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) 
VALUES (N'969E8C75-C110-4C22-BEC3-AD66F9A8AF08', N'ผู้เรียนมีความสามารถในการเรียนรู้และพัฒนาตนเองอย่างต่อเนื่อง', N'9F05D19B-92BD-44FB-A44E-563966093E3A', @StudyYear, N'ผู้เรียนมีนิสัยรักการทำงาน และแสวงหาความรู้ด้วยตนเองจากแหล่งเรียนรู้ต่าง ๆ มีทักษะในการศึกษาค้นคว้าหาความรู้ มีการแลกเปลี่่ยนเรียนรู้และเรียนรู้ร่วมกันและสามารถใช้เทโนโลยีสารสนเทศและการสื่อสาร (ICT) อินเตอร์เน็ต (Internet) และสื่อสังคม (Social Media) ในการเรียนรู้และการนำเสนอผลงานอย่างสร้างสรรค์ ตลอดจนมีการพัฒนาตนเองอย่างต่อเนื่อง สามารถเป็นบุคคลแห่งการเรียนรู้', 3, 0, CAST(0x0000A35D00E692C5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500D536C2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'4BD33310-AE51-4E69-9D84-A4A8173D81F0', NULL, NULL, NULL)

INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) 
VALUES (N'BA0DCE8A-BED3-4CB5-9A4D-2761551EA885', N'สถานศึกษามีศักยภาพในการพัฒนาผู้เรียนในโลกยุคปัจจุบัน และการพัฒนาช่วยเหลือสถานศึกษาอื่น หรือชุมชน สังคม', N'B530DE97-A199-4592-B164-A9BC8FE6F55A', @StudyYear, N'สถานศึกษามีศักยภาพในการพัฒนาผู้เรียนให้มีความสามารถและทักษะที่จำเป็นต่อการดำรงชีวิตในศตวรรษที่ 21 และมีโครงการพิเศษเพื่อยกระดับคุณภาพการศึกษาของสถานศึกษา/สร้างความโดดเด่นของสถานศึกษาให้เป็นที่เชื่อมั่น ยอมรับ และศรัทธาของผู้ปกครอง ชุมชนและสังคมและการพัฒนาช่วยเหลือสถานศึกษาอื่นให้มีควมเข้มแข็งทางวิชาการ หรือการร่วมมือกับชุมชน สังคมของสถานศึกษาในการชี้แนะ ป้องกันหรือแก้ปัญหาที่สอดคล้องกับนโยบายของรัฐ/หน่วยงานต้นสังกัด', 12, 0, CAST(0x0000A35D00E69302 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500A61413 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'4BD33310-AE51-4E69-9D84-A4A8173D81F0', NULL, NULL, NULL)

INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) 
VALUES (N'ECD9FDA1-0B7E-454B-B80A-D933FB4350B8', N'การพัฒนาคุณภาพสถานศึกษา', N'A6D1D88B-2C7A-4C77-98DB-791E1372B032', @StudyYear, N'', 9, 0, CAST(0x0000A35D00E692EF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5650094D51C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'3D9F922B-77D7-410E-8CC1-9BEA731E4F61', NULL, NULL, NULL)

INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) 
VALUES (N'BAD80DDF-B469-417A-A78A-3592A1783291', N'ผู้เรียนมีความสามารถในการคิด', N'9F05D19B-92BD-44FB-A44E-563966093E3A', @StudyYear, N'ผู้เรียนมีความสามารถในการคิดอย่างเป็นระบบ โดยสามารถคิดวิเคราะห์และสังเคราะห์การคิดแก้ปัญหาและคิดสร้างสรรค์ โดยการพูดหรือเขียนตามความคิดของตนเอง และมีเหตุผลประกอบสามารถสร้างสรรค์ผลงานผ่านกระบวนการคิดด้วยความภาคภูมิใจ', 4, 0, CAST(0x0000A35D00E692CA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500DAA378 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'4BD33310-AE51-4E69-9D84-A4A8173D81F0', NULL, NULL, NULL)

INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) 
VALUES (N'2C75D0A1-6E02-4D4B-8964-4F910D347EFD', N'ผู้เรียนมีความรู้ ความสามารถตามหลักสูตร', N'9F05D19B-92BD-44FB-A44E-563966093E3A', @StudyYear, N'ผู้เรียนมีความรู้ความสามารถตามหลักสูตรสถานศึกษาโดยมีผลสัมฤทธิ์ทางการเรียนเฉลี่ย 8 กลุ่มสาระการเรียนรู้ ผลการทดสอบระดับชาติขั้นพื้นฐาน (O-Net) ผลการประเมินผู้เรียนตามสมรรถนะสำคัญตามหลักสูตร ผลการประเมินการอ่าน คิดวิเคราะห์และเขียน และผลการทดสอบความสามารถด้านภาษา การคิดคำนวณ และความสามารถในการใช้เหตุผลเป็นไปตามเกณฑ์ที่กำหนด', 5, 0, CAST(0x0000A35D00E692D3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500DED2AF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'D7A04A29-300F-4E0F-B100-8026FF7D66D6', NULL, NULL, NULL)

INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) 
VALUES (N'FDF64CA5-FF66-49A6-905C-AC89DC6AD938', N'ผู้บริหารมีคุณลักษณะที่ดีและมีความรู้ ความสามารถในการบริหารจัดการสถานศึกษา', N'A6D1D88B-2C7A-4C77-98DB-791E1372B032', @StudyYear, N'ผู้บริหารสถานศึกษามีคุณลักษณะที่ดี มีความรู้ตามมาตรฐานความรู้และประสบการณ์วิชาชีพของผู้บริหารสถานศึกษา มีวิสัยทัศน์ ภาวะผู้นำ ความคิดริเริ่มสร้างสรรค์ และประพฤติและปฏบัติตนเป็นแบบอย่างที่ดี และมีความรู้ความสามารถในการบริหารจัดการสถานศึกษาและสามารถนำการเปลี่ยนแปลงสู่สถานศึกษาได้บรรลุผลสำเร็จตามเป้าหมายอย่างมีคุณภาพ', 8, 0, CAST(0x0000A35D00E692E6 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56501066DE0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'3D9F922B-77D7-410E-8CC1-9BEA731E4F61', NULL, NULL, NULL)

INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) 
VALUES (N'B08979BE-4D91-43B4-A076-2DE3DE250334', N'ครูมีคุณลักษณะที่ดีและมีความรู้ความสามารถในการจัดการเรียนการสอน', N'C8399C32-FB02-418C-AD44-D248E0273F46', @StudyYear, N'ครุมีคุณลักษณะที่ดีประพฤติปฏิบัติตนเป็นแบบอย่างที่ดี มีจรรยบรรณของวิชาชีพครู พ.ศ. 2556 มีความรู้ตามมาตรฐานความรู้ของมาตรฐานวิชาชีพ พ.ศ. 2556 และปฏิบัติหน้าที่ตามมาตรฐานตำแหน่งและมาตรฐานวิทยฐานะ มีความรู้ความสามารถในการจัดการเรียนการสอนที่เน้นผู้เรียนเป็นสำคัญ และเป็นผู้นำการเปลี่ยนแปลงสู่สถานศึกษา', 7, 0, CAST(0x0000A35D00E692DC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500E98204 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'D7A04A29-300F-4E0F-B100-8026FF7D66D6', NULL, NULL, NULL)

INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) 
VALUES (N'AC932F39-6D8D-46BF-A947-204963E23229', N'ผู้เรียนมีคุณธรรม  จริยธรรม  และค่านิยมที่พึงประสงค์', N'9F05D19B-92BD-44FB-A44E-563966093E3A', @StudyYear, N'ผู้เรียนตระหนักในคุณค่าของตนเอง มีความรักและเคราพต่อพ่อแม่ ครูอาจารย์ และถิ่นฐานบ้านเมือง สามารถปฏิบัติตนตามบทบาทหน้าที่ในการเป็นลูกที่ดีของพ่อแม่ การเป็นศิษย์ที่ดีของครูและการเป็นสมาชิกที่ดีของสังคม และมีคุณลักษณพอันพึ่งประสงค์ตามหลักสูตรแกนกลางการศึกษาขั้นพื้นฐาน พุทธศักราช 2551 เป็นคนดีและปฏิบัติตนตามหลักธรรมทางศาสนา ยอมรับความคิดเห็นและวัฒนธรรมที่แตกต่างในฐานะที่เป็นพลเมืองไทยและพลเมืองโลก รวมทั้งรู้คุณค่า ร่วมอนุรักษ์และพัฒนาทรัพยากรธรรมชาติ พลังงาน และสิ่งแวดล้อม', 2, 0, CAST(0x0000A35D00E692C0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500CD640C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'3D9F922B-77D7-410E-8CC1-9BEA731E4F61', NULL, NULL, NULL)

INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) 
VALUES (N'11BE78C4-1F5D-44BF-9DDB-2AEE2F71108D', N'ผู้เรียนมีสุขภาวะที่ดีและมีสุนทรียภาพ', N'9F05D19B-92BD-44FB-A44E-563966093E3A', @StudyYear, N'ผู้เรียนมีสุขภาพร่างการแข็งแรง มีน้ำหนักส่วนสูงและสมรรถภาพทางกายตามเกณฑ์มาตรฐานมีสุขภาพจิตที่ดี มีสุขนิสัยในการดูแลสุขภาพที่ดี สามารถปฏิบัติตนตามสุขบัญญติ 10 ประการ และรู้จักป้องกันตนเองจากสิ่งเสพติดให้โทษและหลีกเลี่ยงต้นเองจากสภาวะเสี่ยงได้ และมีสุนทรียภาพที่ดี', 1, 0, CAST(0x0000A35D00E692AD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A56500A6E546 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', N'3D9F922B-77D7-410E-8CC1-9BEA731E4F61', NULL, NULL, NULL)

End


Go
----------ลบ StoreProcedure GenScoreGroupSideAndStandard
If Exists(Select * From Sys.Procedures Where Name = 'GenScoreGroupSideAndStandard')
Begin
	DROP PROCEDURE GenScoreGroupSideAndStandard
End

Go
--เพิ่ม Store GenScoreGroupSideAndStandard
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO

	Create PROCEDURE GenScoreGroupSideAndStandard
		@RateType int,
		@StudyYear int
	AS
	BEGIN
		SET NOCOUNT ON;
		IF @RateType = 2  
		Begin
			-- เกณฑ์ใหม่ปี 59 12 มาตรฐาน
			---/////////// ด้านที่ 1 ////////////  50
			Update Side Set ScoreGroupID = '5D9C042C-A0AC-42DC-9DC6-20C4B601D127' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 1 

			---/////////// ด้านที่ 2 ////////////  15
			Update Side Set ScoreGroupID = 'D7A04A29-300F-4E0F-B100-8026FF7D66D6' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 2

			---/////////// ด้านที่ 3 ////////////  25
			Update Side Set ScoreGroupID = 'C40FC9F0-2645-4651-9FEC-D3AC1C345F96' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 3

			---/////////// ด้านที่ 4 ////////////  5
			Update Side Set ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 4

			---/////////// ด้านที่ 5 ////////////  5
			Update Side Set ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 5


			---/////////// มาตรฐานที่ 1 ////////////  10
			Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 1

			---/////////// มาตรฐานที่ 2 ////////////  10
			Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 2

			---/////////// มาตรฐานที่ 3 ////////////  5
			Update Standard Set ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 3

			---/////////// มาตรฐานที่ 4 ////////////  5
			Update Standard Set ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 4

			---/////////// มาตรฐานที่ 5 ////////////  15
			Update Standard Set ScoreGroupID = 'D7A04A29-300F-4E0F-B100-8026FF7D66D6' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 5

			---/////////// มาตรฐานที่ 6 ////////////  5
			Update Standard Set ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 6

			---/////////// มาตรฐานที่ 7 ////////////  15
			Update Standard Set ScoreGroupID = 'D7A04A29-300F-4E0F-B100-8026FF7D66D6' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 7

			---/////////// มาตรฐานที่ 8 ////////////  10
			Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 8

			---/////////// มาตรฐานที่ 9 ////////////  10
			Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 9

			---/////////// มาตรฐานที่ 10 ////////////  5
			Update Standard Set ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 10

			---/////////// มาตรฐานที่ 11 ////////////  5
			Update Standard Set ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 11

			---/////////// มาตรฐานที่ 12 ////////////  5
			Update Standard Set ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 12

		End
		Else
		Begin
			-- เกณฑ์เดิม 15 มาตรฐาน
			---/////////// ด้านที่ 1 ////////////  30
			Update Side Set ScoreGroupID = '950E2A3C-5B5B-4A51-8613-4EC393A1F495' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 1 

			---/////////// ด้านที่ 2 ////////////  50
			Update Side Set ScoreGroupID = '5D9C042C-A0AC-42DC-9DC6-20C4B601D127' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 2

			---/////////// ด้านที่ 3 ////////////  10
			Update Side Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 3

			---/////////// ด้านที่ 4 ////////////  5
			Update Side Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 4

			---/////////// ด้านที่ 5 ////////////  5
			Update Side Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 5



			---/////////// มาตรฐานที่ 1 ////////////  5
			Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 1

			---/////////// มาตรฐานที่ 2 ////////////  5
			Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 2

			---/////////// มาตรฐานที่ 3 ////////////  5
			Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 3

			---/////////// มาตรฐานที่ 4 ////////////  5
			Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 4

			---/////////// มาตรฐานที่ 5 ////////////  5
			Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 5

			---/////////// มาตรฐานที่ 6 ////////////  5
			Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 6

			---/////////// มาตรฐานที่ 7 ////////////  10
			Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 7

			---/////////// มาตรฐานที่ 8 ////////////  10
			Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 8

			---/////////// มาตรฐานที่ 9 ////////////  5
			Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 9

			---/////////// มาตรฐานที่ 10 ////////////  10
			Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 10

			---/////////// มาตรฐานที่ 11 ////////////  10
			Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 11

			---/////////// มาตรฐานที่ 12 ////////////  5
			Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 12

			---/////////// มาตรฐานที่ 13 ////////////  10
			Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 13

			---/////////// มาตรฐานที่ 14 ////////////  5
			Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 14

			---/////////// มาตรฐานที่ 15 ////////////  5
			Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 15
		End
	End


Go
----------ลบ StoreProcedure GenRate
If Exists(Select * From Sys.Procedures Where Name = 'GenRate')
Begin
	DROP PROCEDURE GenRate
End

Go
--เพิ่ม Store GenRate
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO

	Create PROCEDURE GenRate
		@RateType int
	AS
	BEGIN
		SET NOCOUNT ON;
		IF @RateType = 0
		Begin
			----------------เก่า---------------------
			-----------0.5
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๒๔', TMin = 0, TMax = 0.24 Where TcriteriaID = '990f80da-c07c-41b5-ac1f-5e8a45e5bb0e'
			Update TCriteria Set Detail = '๐.๒๕ - ๐.๒๙', TMin = 0.25, TMax = 0.29 Where TcriteriaID = '50a812bd-f27e-4259-8946-004c1044fabf'
			Update TCriteria Set Detail = '๐.๓๐ - ๐.๓๔', TMin = 0.3, TMax = 0.34 Where TcriteriaID = '573fcdb2-0f1d-42d4-95a9-2ce3b2dd5fd4'
			Update TCriteria Set Detail = '๐.๓๕ - ๐.๓๙', TMin = 0.35, TMax = 0.39 Where TcriteriaID = 'de5b6ed8-a080-468d-8cca-a302d0f5e73b'
			Update TCriteria Set Detail = '๐.๔๐ - ๐.๕๐', TMin = 0.4, TMax = 0.5 Where TcriteriaID = 'db2bedf7-9cf8-4495-a3b8-9ca572bd1f55'

			-----------1.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๔๙', TMin = 0, TMax = 0.49 Where TcriteriaID = '523325f5-5610-4074-8788-eeedf6b35e6c'
			Update TCriteria Set Detail = '๐.๕๐ - ๐.๕๙', TMin = 0.5, TMax = 0.59 Where TcriteriaID = '9a340d20-7c31-4955-a3c7-7fe5eb0a6be3'
			Update TCriteria Set Detail = '๐.๖๐ - ๐.๖๙', TMin = 0.6, TMax = 0.69 Where TcriteriaID = '6344b6e3-cfa7-4fdd-8b71-34470dd661ab'
			Update TCriteria Set Detail = '๐.๗๐ - ๐.๗๙', TMin = 0.7, TMax = 0.79 Where TcriteriaID = '98d32855-a9ac-444e-a3f2-558961400149'
			Update TCriteria Set Detail = '๐.๘๐ - ๑.๐๐', TMin = 0.8, TMax = 1 Where TcriteriaID = '138fb5bd-2a19-4a09-855e-43205d18ca7b'

			-----------2.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๙๙', TMin = 0, TMax = 0.99 Where TcriteriaID = '944cee00-2cea-400a-b5dc-081cf16e83a6'
			Update TCriteria Set Detail = '๑.๐๐ - ๑.๑๙', TMin = 1.0, TMax = 1.19 Where TcriteriaID = '6469c8d5-6542-471e-a31a-9c1b1681110b'
			Update TCriteria Set Detail = '๑.๒๐ - ๑.๓๙', TMin = 1.2, TMax = 1.39 Where TcriteriaID = 'fb08528d-fb28-4382-931d-cbbf28cf6b14'
			Update TCriteria Set Detail = '๑.๔๐ - ๑.๕๙', TMin = 1.4, TMax = 1.59 Where TcriteriaID = '970f9571-a05c-4a6e-9270-e3b8b6346832'
			Update TCriteria Set Detail = '๑.๖๐ - ๒.๐๐', TMin = 1.6, TMax = 2 Where TcriteriaID = 'e1923d69-300a-49e8-b2dd-558a1c9778a0'

			-----------3.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๔๙', TMin = 0, TMax = 1.49 Where TcriteriaID = 'e68d09a7-053d-4812-a5e2-5019600fc59a'
			Update TCriteria Set Detail = '๑.๕๐ - ๑.๗๙', TMin = 1.5, TMax = 1.79 Where TcriteriaID = 'c40a7ddb-5bf7-45f1-8339-bf23765d686d'
			Update TCriteria Set Detail = '๑.๘๐ - ๒.๐๙', TMin = 1.8, TMax = 2.09 Where TcriteriaID = 'a1c46154-02c8-47da-9c07-26d2fdd36eee'
			Update TCriteria Set Detail = '๒.๑๐ - ๒.๓๙', TMin = 2.1, TMax = 2.39 Where TcriteriaID = '948736f6-16c6-4e50-96dd-f038ff34ff83'
			Update TCriteria Set Detail = '๒.๔๐ - ๓.๐๐', TMin = 2.4, TMax = 3 Where TcriteriaID = '8b7b8f2e-cad2-4b76-b18b-d0066192b40a'

			-----------4.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๙๙', TMin = 0, TMax = 1.99 Where TcriteriaID = 'cfe6e7f9-d797-45d3-97bf-384a7ea2288d'
			Update TCriteria Set Detail = '๒.๐๐ - ๒.๓๙', TMin = 2, TMax = 2.39 Where TcriteriaID = '8c907257-17c1-45ed-a605-34721f5d1c5e'
			Update TCriteria Set Detail = '๒.๔๐ - ๒.๗๙', TMin = 2.4, TMax = 2.79 Where TcriteriaID = '5319e303-bff3-4ae9-9b2d-5138a43aa3bd'
			Update TCriteria Set Detail = '๒.๘๐ - ๓.๑๙', TMin = 2.8, TMax = 3.19 Where TcriteriaID = '05a882f1-b133-4131-ad72-43cbc4d932cb'
			Update TCriteria Set Detail = '๓.๒๐ - ๔.๐๐', TMin = 3.2, TMax = 4 Where TcriteriaID = 'fee73c78-23c3-4590-9fe4-08c98f72d1cd'

			-----------5.0
			Update TCriteria Set Detail = '๐.๐๐ - ๒.๔๙', TMin = 0, TMax = 2.49 Where TcriteriaID = 'a810252f-9bb6-48a7-b610-dc7a86996451'
			Update TCriteria Set Detail = '๒.๕๐ - ๒.๙๙', TMin = 2.5, TMax = 2.99 Where TcriteriaID = 'ecb48ab5-37ad-4ad0-b8ff-0fffefa8a3b3'
			Update TCriteria Set Detail = '๓.๐๐ - ๓.๔๙', TMin = 3, TMax = 3.49 Where TcriteriaID = 'af07711a-3896-4e93-9794-4c27b670acbf'
			Update TCriteria Set Detail = '๓.๕๐ - ๓.๙๙', TMin = 3.5, TMax = 3.99 Where TcriteriaID = 'f4a8dcb9-7687-4f2c-9741-f2f8f1da694b'
			Update TCriteria Set Detail = '๔.๐๐ - ๕.๐๐', TMin = 4, TMax = 5 Where TcriteriaID = 'aeb0b92f-8949-47d0-99cd-af3980734f21'

			-----------10.0
			Update TCriteria Set Detail = '๐.๐๐ - ๔.๙๙', TMin = 0, TMax = 4.99 Where TcriteriaID = 'c2c6d92d-e887-4bf0-885c-ca8bee4e807f'
			Update TCriteria Set Detail = '๕.๐๐ - ๕.๙๙', TMin = 5, TMax = 5.99 Where TcriteriaID = 'e0424d8a-e013-4482-895b-f0e8f4c52b12'
			Update TCriteria Set Detail = '๖.๐๐ - ๖.๙๙', TMin = 6, TMax = 6.99 Where TcriteriaID = 'b3f28c05-5d4d-43fb-9284-a84117a4c566'
			Update TCriteria Set Detail = '๗.๐๐ - ๗.๙๙', TMin = 7, TMax = 7.99 Where TcriteriaID = '5f4e7061-4705-42b4-be20-01f144f08d5e'
			Update TCriteria Set Detail = '๘.๐๐ - ๑๐.๐๐', TMin = 8, TMax = 10 Where TcriteriaID = '16b3f3e2-b8a1-481e-9661-5177aad558d3'

			-----------30.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑๔.๙๙', TMin = 0, TMax = 14.99 Where TcriteriaID = 'b930e376-717b-4f50-bc69-803f88ff6402'
			Update TCriteria Set Detail = '๑๕.๐๐ - ๑๗.๙๙', TMin = 15, TMax = 17.99 Where TcriteriaID = '90983ed4-0799-4ca1-8145-a3b007a53a69'
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๐.๙๙', TMin = 18, TMax = 20.99 Where TcriteriaID = 'f497f305-8316-4d54-bcc8-2da0dc4fd9be'
			Update TCriteria Set Detail = '๒๑.๐๐ - ๒๓.๙๙', TMin = 21, TMax = 23.99 Where TcriteriaID = '6c3191d9-13ab-4bfb-bddb-dc50623b4c3a'
			Update TCriteria Set Detail = '๒๔.๐๐ - ๓๐.๐๐', TMin = 24, TMax = 30 Where TcriteriaID = 'f7818b1f-6b6b-46fc-9611-169c481e2c4d'

			-----------50.0
			Update TCriteria Set Detail = '๐.๐๐ - ๒๔.๙๙', TMin = 0, TMax = 24.99 Where TcriteriaID = '0e4d3521-401d-408f-8f2f-d69a509a2117'
			Update TCriteria Set Detail = '๒๕.๐๐ - ๒๙.๙๙', TMin = 25, TMax = 29.99 Where TcriteriaID = '32d76bf4-7e87-4575-910c-92761b2da74d'
			Update TCriteria Set Detail = '๓๐.๐๐ - ๓๔.๙๙', TMin = 30, TMax = 34.99 Where TcriteriaID = '7722765c-3e54-42a4-b209-5cafe57cc7b2'
			Update TCriteria Set Detail = '๓๕.๐๐ - ๓๙.๙๙', TMin = 35, TMax = 39.99 Where TcriteriaID = 'bcc684de-202a-44ae-948e-d7dbb78f572e'
			Update TCriteria Set Detail = '๔๐.๐๐ - ๕๐.๐๐', TMin = 40, TMax = 50 Where TcriteriaID = '48c0564e-b8d8-4963-8ab1-4910057944a6'

			-----------100.0
			Update TCriteria Set Detail = '๐.๐๐ - ๔๙.๙๙', TMin = 0, TMax = 49.99 Where TcriteriaID = '69c5bc62-b443-48c5-9a46-cd1e4df27003'
			Update TCriteria Set Detail = '๕๐.๐๐ - ๕๙.๙๙', TMin = 50, TMax = 59.99 Where TcriteriaID = '59291c4d-2eec-4ea2-8a2d-922b6a34fa4c'
			Update TCriteria Set Detail = '๖๐.๐๐ - ๖๙.๙๙', TMin = 60, TMax = 69.99 Where TcriteriaID = 'e277de33-3d86-4f09-b7b8-f3c97d585cb5'
			Update TCriteria Set Detail = '๗๐.๐๐ - ๗๙.๙๙', TMin = 70, TMax = 79.99 Where TcriteriaID = 'facf0afb-b6f4-4675-9c47-774eb1d1b8af'
			Update TCriteria Set Detail = '๘๐.๐๐ - ๑๐๐.๐๐', TMin = 80, TMax = 100 Where TcriteriaID = '6ecc7610-19d8-47cc-b728-15efd128fe21'
		End
		
		IF @RateType = 1
		Begin
			----------------ใหม่------------------
			---------0.5 (1)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๒๔', TMin = 0, TMax = 0.24 Where TcriteriaID = '990f80da-c07c-41b5-ac1f-5e8a45e5bb0e'
			Update TCriteria Set Detail = '๐.๒๕ - ๐.๒๙', TMin = 0.25, TMax = 0.29 Where TcriteriaID = '50a812bd-f27e-4259-8946-004c1044fabf'
			Update TCriteria Set Detail = '๐.๓๐ - ๐.๓๗', TMin = 0.3, TMax = 0.37 Where TcriteriaID = '573fcdb2-0f1d-42d4-95a9-2ce3b2dd5fd4'
			Update TCriteria Set Detail = '๐.๓๘ - ๐.๔๔', TMin = 0.38, TMax = 0.44 Where TcriteriaID = 'de5b6ed8-a080-468d-8cca-a302d0f5e73b'
			Update TCriteria Set Detail = '๐.๔๕ - ๐.๕๐', TMin = 0.45, TMax = 0.50 Where TcriteriaID = 'db2bedf7-9cf8-4495-a3b8-9ca572bd1f55'

			-----------1.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๔๙', TMin = 0, TMax = 0.49 Where TcriteriaID = '523325f5-5610-4074-8788-eeedf6b35e6c'
			Update TCriteria Set Detail = '๐.๕๐ - ๐.๕๙', TMin = 0.5, TMax = 0.59 Where TcriteriaID = '9a340d20-7c31-4955-a3c7-7fe5eb0a6be3'
			Update TCriteria Set Detail = '๐.๖๐ - ๐.๗๔', TMin = 0.6, TMax = 0.74 Where TcriteriaID = '6344b6e3-cfa7-4fdd-8b71-34470dd661ab'
			Update TCriteria Set Detail = '๐.๗๕ - ๐.๘๙', TMin = 0.75, TMax = 0.89 Where TcriteriaID = '98d32855-a9ac-444e-a3f2-558961400149'
			Update TCriteria Set Detail = '๐.๙๐ - ๑.๐๐', TMin = 0.9, TMax = 1 Where TcriteriaID = '138fb5bd-2a19-4a09-855e-43205d18ca7b'

			-----------1.0 (2)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๒๐', TMin = 0, TMax = 0.2 Where TcriteriaID = '223EFC01-5C93-46CD-B3F5-8EA36DCF8FDC'
			Update TCriteria Set Detail = '๐.๒๑ - ๐.๔๐', TMin = 0.21, TMax = 0.4 Where TcriteriaID = '36365A43-EBA9-478F-B337-98F3C0D12ACF'
			Update TCriteria Set Detail = '๐.๔๑ - ๐.๖๐', TMin = 0.41, TMax = 0.6 Where TcriteriaID = '0633B326-32A3-4018-A6E4-071CCA336DF9'
			Update TCriteria Set Detail = '๐.๖๑ - ๐.๘๐', TMin = 0.61, TMax = 0.8 Where TcriteriaID = 'A6411A5F-B47D-4578-A7FC-6B4924AC42BB'
			Update TCriteria Set Detail = '๐.๘๑ - ๑.๐๐', TMin = 0.81, TMax = 1 Where TcriteriaID = 'AB835423-2FDA-4348-B3EC-7AB735C3E4CC'

			-----------2.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๙๙', TMin = 0, TMax = 0.99 Where TcriteriaID = '944cee00-2cea-400a-b5dc-081cf16e83a6'
			Update TCriteria Set Detail = '๑.๐๐ - ๑.๑๙', TMin = 1.0, TMax = 1.19 Where TcriteriaID = '6469c8d5-6542-471e-a31a-9c1b1681110b'
			Update TCriteria Set Detail = '๑.๒๐ - ๑.๔๙', TMin = 1.2, TMax = 1.49 Where TcriteriaID = 'fb08528d-fb28-4382-931d-cbbf28cf6b14'
			Update TCriteria Set Detail = '๑.๕๐ - ๑.๗๙', TMin = 1.5, TMax = 1.79 Where TcriteriaID = '970f9571-a05c-4a6e-9270-e3b8b6346832'
			Update TCriteria Set Detail = '๑.๘๐ - ๒.๐๐', TMin = 1.8, TMax = 2 Where TcriteriaID = 'e1923d69-300a-49e8-b2dd-558a1c9778a0'

			-----------2.0 (2)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๔๐', TMin = 0, TMax = 0.4 Where TcriteriaID = '22656210-A80D-4BA6-88D7-0D18235CAE6B'
			Update TCriteria Set Detail = '๐.๔๑ - ๐.๘๐', TMin = 0.41, TMax = 0.8 Where TcriteriaID = 'A6680FCD-11E8-46B3-A447-F9ACBAC8A627'
			Update TCriteria Set Detail = '๐.๘๑ - ๑.๒๐', TMin = 0.81, TMax = 1.2 Where TcriteriaID = '76CCC37D-CA07-458F-83DC-C32FA1E8D1D6'
			Update TCriteria Set Detail = '๑.๒๑ - ๑.๖๐', TMin = 1.21, TMax = 1.6 Where TcriteriaID = '943675D4-E2CD-4EEA-8AB0-BA5D743A90C9'
			Update TCriteria Set Detail = '๑.๖๑ - ๒.๐๐', TMin = 1.61, TMax = 2 Where TcriteriaID = 'B72385BA-FAC6-4EC9-AC62-F3594CCB5753'

			-----------3.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๖๐', TMin = 0, TMax = 0.6 Where TcriteriaID = 'e68d09a7-053d-4812-a5e2-5019600fc59a'
			Update TCriteria Set Detail = '๐.๖๑ - ๑.๒๐', TMin = 0.61, TMax = 1.20 Where TcriteriaID = 'c40a7ddb-5bf7-45f1-8339-bf23765d686d'
			Update TCriteria Set Detail = '๑.๒๑ - ๑.๘๐', TMin = 1.21, TMax = 1.8 Where TcriteriaID = 'a1c46154-02c8-47da-9c07-26d2fdd36eee'
			Update TCriteria Set Detail = '๑.๘๑ - ๒.๔๐', TMin = 1.81, TMax = 2.4 Where TcriteriaID = '948736f6-16c6-4e50-96dd-f038ff34ff83'
			Update TCriteria Set Detail = '๒.๔๑ - ๓.๐๐', TMin = 2.41, TMax = 3 Where TcriteriaID = '8b7b8f2e-cad2-4b76-b18b-d0066192b40a'

			-----------4.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๘๐', TMin = 0, TMax = 0.8 Where TcriteriaID = 'cfe6e7f9-d797-45d3-97bf-384a7ea2288d'
			Update TCriteria Set Detail = '๐.๘๑ - ๑.๖๐', TMin = 0.81, TMax = 1.6 Where TcriteriaID = '8c907257-17c1-45ed-a605-34721f5d1c5e'
			Update TCriteria Set Detail = '๑.๖๑ - ๒.๔๐', TMin = 1.61, TMax = 2.4 Where TcriteriaID = '5319e303-bff3-4ae9-9b2d-5138a43aa3bd'
			Update TCriteria Set Detail = '๒.๔๑ - ๓.๒๐', TMin = 2.41, TMax = 3.2 Where TcriteriaID = '05a882f1-b133-4131-ad72-43cbc4d932cb'
			Update TCriteria Set Detail = '๓.๒๑ - ๔.๐๐', TMin = 3.21, TMax = 4 Where TcriteriaID = 'fee73c78-23c3-4590-9fe4-08c98f72d1cd'

			-----------5.0
			Update TCriteria Set Detail = '๐.๐๐ - ๒.๔๙', TMin = 0, TMax = 2.49 Where TcriteriaID = 'a810252f-9bb6-48a7-b610-dc7a86996451'
			Update TCriteria Set Detail = '๒.๕๐ - ๒.๙๙', TMin = 2.5, TMax = 2.99 Where TcriteriaID = 'ecb48ab5-37ad-4ad0-b8ff-0fffefa8a3b3'
			Update TCriteria Set Detail = '๓.๐๐ - ๓.๗๔', TMin = 3, TMax = 3.74 Where TcriteriaID = 'af07711a-3896-4e93-9794-4c27b670acbf'
			Update TCriteria Set Detail = '๓.๗๕ - ๔.๔๙', TMin = 3.75, TMax = 4.49 Where TcriteriaID = 'f4a8dcb9-7687-4f2c-9741-f2f8f1da694b'
			Update TCriteria Set Detail = '๔.๕๐ - ๕.๐๐', TMin = 4.5, TMax = 5 Where TcriteriaID = 'aeb0b92f-8949-47d0-99cd-af3980734f21'

			-----------5.0 (2)
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๐๐', TMin = 0, TMax = 1 Where TcriteriaID = '9A480D12-7160-4E72-B8AE-C9E9A663EBD4'
			Update TCriteria Set Detail = '๑.๐๑ - ๒.๐๐', TMin = 1.01, TMax = 2 Where TcriteriaID = 'E855AD6C-F412-4796-8C22-CF0587501079'
			Update TCriteria Set Detail = '๒.๐๑ - ๓.๐๐', TMin = 2.01, TMax = 3 Where TcriteriaID = '6163F6D7-70E3-4CAD-9DA6-77B7C9ABB5D5'
			Update TCriteria Set Detail = '๓.๐๑ - ๔.๐๐', TMin = 3.01, TMax = 4 Where TcriteriaID = '98C64437-9C98-44C8-A25F-880D62937C97'
			Update TCriteria Set Detail = '๔.๐๑ - ๕.๐๐', TMin = 4.01, TMax = 5 Where TcriteriaID = '5062F4F5-AE1E-4570-918A-A78C1F21E10E'

			-----------10.0
			Update TCriteria Set Detail = '๐.๐๐ - ๔.๙๙', TMin = 0, TMax = 4.99 Where TcriteriaID = 'c2c6d92d-e887-4bf0-885c-ca8bee4e807f'
			Update TCriteria Set Detail = '๕.๐๐ - ๕.๙๙', TMin = 5, TMax = 5.99 Where TcriteriaID = 'e0424d8a-e013-4482-895b-f0e8f4c52b12'
			Update TCriteria Set Detail = '๖.๐๐ - ๗.๔๙', TMin = 6, TMax = 7.49 Where TcriteriaID = 'b3f28c05-5d4d-43fb-9284-a84117a4c566'
			Update TCriteria Set Detail = '๗.๕๐ - ๘.๙๙', TMin = 7.5, TMax = 8.99 Where TcriteriaID = '5f4e7061-4705-42b4-be20-01f144f08d5e'
			Update TCriteria Set Detail = '๙.๐๐ - ๑๐.๐๐', TMin = 9, TMax = 10 Where TcriteriaID = '16b3f3e2-b8a1-481e-9661-5177aad558d3'

			-----------30.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑๔.๙๙', TMin = 0, TMax = 14.99 Where TcriteriaID = 'b930e376-717b-4f50-bc69-803f88ff6402'
			Update TCriteria Set Detail = '๑๕.๐๐ - ๑๗.๙๙', TMin = 15, TMax = 17.99 Where TcriteriaID = '90983ed4-0799-4ca1-8145-a3b007a53a69'
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๒.๔๙', TMin = 18, TMax = 22.49 Where TcriteriaID = 'f497f305-8316-4d54-bcc8-2da0dc4fd9be'
			Update TCriteria Set Detail = '๒๒.๕๐ - ๒๖.๙๙', TMin = 22.5, TMax = 26.99 Where TcriteriaID = '6c3191d9-13ab-4bfb-bddb-dc50623b4c3a'
			Update TCriteria Set Detail = '๒๗.๐๐ - ๓๐.๐๐', TMin = 27, TMax = 30 Where TcriteriaID = 'f7818b1f-6b6b-46fc-9611-169c481e2c4d'

			-----------50.0
			Update TCriteria Set Detail = '๐.๐๐ - ๒๔.๙๙', TMin = 0, TMax = 24.99 Where TcriteriaID = '0e4d3521-401d-408f-8f2f-d69a509a2117'
			Update TCriteria Set Detail = '๒๕.๐๐ - ๒๙.๙๙', TMin = 25, TMax = 29.99 Where TcriteriaID = '32d76bf4-7e87-4575-910c-92761b2da74d'
			Update TCriteria Set Detail = '๓๐.๐๐ - ๓๗.๔๙', TMin = 30, TMax = 37.49 Where TcriteriaID = '7722765c-3e54-42a4-b209-5cafe57cc7b2'
			Update TCriteria Set Detail = '๓๗.๕๐ - ๔๔.๙๙', TMin = 37.5, TMax = 44.99 Where TcriteriaID = 'bcc684de-202a-44ae-948e-d7dbb78f572e'
			Update TCriteria Set Detail = '๔๕.๐๐ - ๕๐.๐๐', TMin = 45, TMax = 50 Where TcriteriaID = '48c0564e-b8d8-4963-8ab1-4910057944a6'

			-----------100.0
			Update TCriteria Set Detail = '๐.๐๐ - ๔๙.๙๙', TMin = 0, TMax = 49.99 Where TcriteriaID = '69c5bc62-b443-48c5-9a46-cd1e4df27003'
			Update TCriteria Set Detail = '๕๐.๐๐ - ๕๙.๙๙', TMin = 50, TMax = 59.99 Where TcriteriaID = '59291c4d-2eec-4ea2-8a2d-922b6a34fa4c'
			Update TCriteria Set Detail = '๖๐.๐๐ - ๗๔.๙๙', TMin = 60, TMax = 74.99 Where TcriteriaID = 'e277de33-3d86-4f09-b7b8-f3c97d585cb5'
			Update TCriteria Set Detail = '๗๕.๐๐ - ๘๙.๙๙', TMin = 75, TMax = 89.99 Where TcriteriaID = 'facf0afb-b6f4-4675-9c47-774eb1d1b8af'
			Update TCriteria Set Detail = '๙๐.๐๐ - ๑๐๐.๐๐', TMin = 90, TMax = 100 Where TcriteriaID = '6ecc7610-19d8-47cc-b728-15efd128fe21'
		End

		IF @RateType = 2
		Begin
			--------เกณฑ์ใหม่ 12 มาตรฐาน (2)-------------
			---------0.5 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๑๕', TMin = 0, TMax = 0.15 Where TcriteriaID = '990f80da-c07c-41b5-ac1f-5e8a45e5bb0e'
			Update TCriteria Set Detail = '๐.๑๖ - ๐.๓๐', TMin = 0.16, TMax = 0.30 Where TcriteriaID = '50a812bd-f27e-4259-8946-004c1044fabf'
			Update TCriteria Set Detail = '๐.๓๑ - ๐.๔๐', TMin = 0.31, TMax = 0.40 Where TcriteriaID = '573fcdb2-0f1d-42d4-95a9-2ce3b2dd5fd4'
			Update TCriteria Set Detail = '๐.๔๑ - ๐.๔๕', TMin = 0.41, TMax = 0.45 Where TcriteriaID = 'de5b6ed8-a080-468d-8cca-a302d0f5e73b'
			Update TCriteria Set Detail = '๐.๔๖ - ๐.๕๐', TMin = 0.46, TMax = 0.50 Where TcriteriaID = 'db2bedf7-9cf8-4495-a3b8-9ca572bd1f55'

			-----------1.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๕๙', TMin = 0, TMax = 0.59 Where TcriteriaID = '523325f5-5610-4074-8788-eeedf6b35e6c'
			Update TCriteria Set Detail = '๐.๖๐ - ๐.๗๔', TMin = 0.6, TMax = 0.74 Where TcriteriaID = '9a340d20-7c31-4955-a3c7-7fe5eb0a6be3'
			Update TCriteria Set Detail = '๐.๗๕ - ๐.๘๙', TMin = 0.75, TMax = 0.89 Where TcriteriaID = '6344b6e3-cfa7-4fdd-8b71-34470dd661ab'
			Update TCriteria Set Detail = '๐.๙๐ - ๐.๙๔', TMin = 0.9, TMax = 0.94 Where TcriteriaID = '98d32855-a9ac-444e-a3f2-558961400149'
			Update TCriteria Set Detail = '๐.๙๕ - ๑.๐๐', TMin = 0.95, TMax = 1 Where TcriteriaID = '138fb5bd-2a19-4a09-855e-43205d18ca7b'

			-----------1.0 (N2)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๓๐', TMin = 0, TMax = 0.3 Where TcriteriaID = '223EFC01-5C93-46CD-B3F5-8EA36DCF8FDC'
			Update TCriteria Set Detail = '๐.๓๑ - ๐.๖๐', TMin = 0.31, TMax = 0.6 Where TcriteriaID = '36365A43-EBA9-478F-B337-98F3C0D12ACF'
			Update TCriteria Set Detail = '๐.๖๑ - ๐.๘๐', TMin = 0.61, TMax = 0.8 Where TcriteriaID = '0633B326-32A3-4018-A6E4-071CCA336DF9'
			Update TCriteria Set Detail = '๐.๘๑ - ๐.๙๐', TMin = 0.81, TMax = 0.9 Where TcriteriaID = 'A6411A5F-B47D-4578-A7FC-6B4924AC42BB'
			Update TCriteria Set Detail = '๐.๙๑ - ๑.๐๐', TMin = 0.91, TMax = 1 Where TcriteriaID = 'AB835423-2FDA-4348-B3EC-7AB735C3E4CC'

			-----------2.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๑๙', TMin = 0, TMax = 1.19 Where TcriteriaID = '944cee00-2cea-400a-b5dc-081cf16e83a6'
			Update TCriteria Set Detail = '๑.๒๐ - ๑.๔๙', TMin = 1.2, TMax = 1.49 Where TcriteriaID = '6469c8d5-6542-471e-a31a-9c1b1681110b'
			Update TCriteria Set Detail = '๑.๕๐ - ๑.๗๙', TMin = 1.5, TMax = 1.79 Where TcriteriaID = 'fb08528d-fb28-4382-931d-cbbf28cf6b14'
			Update TCriteria Set Detail = '๑.๘๐ - ๑.๘๙', TMin = 1.8, TMax = 1.89 Where TcriteriaID = '970f9571-a05c-4a6e-9270-e3b8b6346832'
			Update TCriteria Set Detail = '๑.๙๐ - ๒.๐๐', TMin = 1.9, TMax = 2 Where TcriteriaID = 'e1923d69-300a-49e8-b2dd-558a1c9778a0'

			-----------2.0 (N2)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๖๐', TMin = 0, TMax = 0.6 Where TcriteriaID = '22656210-A80D-4BA6-88D7-0D18235CAE6B'
			Update TCriteria Set Detail = '๐.๖๑ - ๑.๒๐', TMin = 0.61, TMax = 1.2 Where TcriteriaID = 'A6680FCD-11E8-46B3-A447-F9ACBAC8A627'
			Update TCriteria Set Detail = '๐.๒๑ - ๑.๖๐', TMin = 1.21, TMax = 1.6 Where TcriteriaID = '76CCC37D-CA07-458F-83DC-C32FA1E8D1D6'
			Update TCriteria Set Detail = '๑.๖๑ - ๑.๘๐', TMin = 1.61, TMax = 1.8 Where TcriteriaID = '943675D4-E2CD-4EEA-8AB0-BA5D743A90C9'
			Update TCriteria Set Detail = '๑.๘๑ - ๒.๐๐', TMin = 1.81, TMax = 2 Where TcriteriaID = 'B72385BA-FAC6-4EC9-AC62-F3594CCB5753'

			-----------3.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๙๐', TMin = 0, TMax = 0.9 Where TcriteriaID = 'e68d09a7-053d-4812-a5e2-5019600fc59a'
			Update TCriteria Set Detail = '๐.๙๑ - ๑.๘๐', TMin = 0.91, TMax = 1.8 Where TcriteriaID = 'c40a7ddb-5bf7-45f1-8339-bf23765d686d'
			Update TCriteria Set Detail = '๑.๘๑ - ๒.๔๐', TMin = 1.81, TMax = 2.4 Where TcriteriaID = 'a1c46154-02c8-47da-9c07-26d2fdd36eee'
			Update TCriteria Set Detail = '๑.๔๑ - ๒.๗๐', TMin = 2.41, TMax = 2.7 Where TcriteriaID = '948736f6-16c6-4e50-96dd-f038ff34ff83'
			Update TCriteria Set Detail = '๒.๗๑ - ๓.๐๐', TMin = 2.71, TMax = 3 Where TcriteriaID = '8b7b8f2e-cad2-4b76-b18b-d0066192b40a'

			-----------4.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๒.๓๙', TMin = 0, TMax = 2.39 Where TcriteriaID = 'cfe6e7f9-d797-45d3-97bf-384a7ea2288d'
			Update TCriteria Set Detail = '๒.๔๐ - ๒.๙๙', TMin = 2.4, TMax = 2.99 Where TcriteriaID = '8c907257-17c1-45ed-a605-34721f5d1c5e'
			Update TCriteria Set Detail = '๓.๐๐ - ๓.๕๙', TMin = 3, TMax = 3.59 Where TcriteriaID = '5319e303-bff3-4ae9-9b2d-5138a43aa3bd'
			Update TCriteria Set Detail = '๓.๖๐ - ๓.๗๙', TMin = 3.6, TMax = 3.79 Where TcriteriaID = '05a882f1-b133-4131-ad72-43cbc4d932cb'
			Update TCriteria Set Detail = '๓.๘๐ - ๔.๐๐', TMin = 3.8, TMax = 4 Where TcriteriaID = 'fee73c78-23c3-4590-9fe4-08c98f72d1cd'

			-----------5.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๒.๐๐', TMin = 0, TMax = 2 Where TcriteriaID = 'a810252f-9bb6-48a7-b610-dc7a86996451'
			Update TCriteria Set Detail = '๒.๐๑ - ๓.๐๐', TMin = 2.01, TMax = 3 Where TcriteriaID = 'ecb48ab5-37ad-4ad0-b8ff-0fffefa8a3b3'
			Update TCriteria Set Detail = '๓.๐๑ - ๔.๐๐', TMin = 3.01, TMax = 4 Where TcriteriaID = 'af07711a-3896-4e93-9794-4c27b670acbf'
			Update TCriteria Set Detail = '๔.๐๑ - ๔.๕๐', TMin = 4.01, TMax = 4.5 Where TcriteriaID = 'f4a8dcb9-7687-4f2c-9741-f2f8f1da694b'
			Update TCriteria Set Detail = '๔.๕๑ - ๕.๐๐', TMin = 4.51, TMax = 5 Where TcriteriaID = 'aeb0b92f-8949-47d0-99cd-af3980734f21'

			-----------5.0 (N2)
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๐๐', TMin = 0, TMax = 1 Where TcriteriaID = '9A480D12-7160-4E72-B8AE-C9E9A663EBD4'
			Update TCriteria Set Detail = '๑.๐๑ - ๒.๐๐', TMin = 1.01, TMax = 2 Where TcriteriaID = 'E855AD6C-F412-4796-8C22-CF0587501079'
			Update TCriteria Set Detail = '๒.๐๑ - ๓.๐๐', TMin = 2.01, TMax = 3 Where TcriteriaID = '6163F6D7-70E3-4CAD-9DA6-77B7C9ABB5D5'
			Update TCriteria Set Detail = '๓.๐๑ - ๔.๐๐', TMin = 3.01, TMax = 4 Where TcriteriaID = '98C64437-9C98-44C8-A25F-880D62937C97'
			Update TCriteria Set Detail = '๔.๐๑ - ๕.๐๐', TMin = 4.01, TMax = 5 Where TcriteriaID = '5062F4F5-AE1E-4570-918A-A78C1F21E10E'

			-----------10.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๕.๙๙', TMin = 0, TMax = 5.99 Where TcriteriaID = 'c2c6d92d-e887-4bf0-885c-ca8bee4e807f'
			Update TCriteria Set Detail = '๖.๐๐ - ๗.๔๙', TMin = 6, TMax = 7.49 Where TcriteriaID = 'e0424d8a-e013-4482-895b-f0e8f4c52b12'
			Update TCriteria Set Detail = '๗.๕๐ - ๘.๙๙', TMin = 7.5, TMax = 8.99 Where TcriteriaID = 'b3f28c05-5d4d-43fb-9284-a84117a4c566'
			Update TCriteria Set Detail = '๙.๐๐ - ๙.๔๙', TMin = 9, TMax = 9.49 Where TcriteriaID = '5f4e7061-4705-42b4-be20-01f144f08d5e'
			Update TCriteria Set Detail = '๙.๕๐ - ๑๐.๐๐', TMin = 9.5, TMax = 10 Where TcriteriaID = '16b3f3e2-b8a1-481e-9661-5177aad558d3'

			-----------50.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๒๙.๙๙', TMin = 0, TMax = 29.99 Where TcriteriaID = '0e4d3521-401d-408f-8f2f-d69a509a2117'
			Update TCriteria Set Detail = '๓๐.๐๐ - ๓๗.๔๙', TMin = 30, TMax = 37.49 Where TcriteriaID = '32d76bf4-7e87-4575-910c-92761b2da74d'
			Update TCriteria Set Detail = '๓๗.๕๐ - ๔๔.๙๙', TMin = 37.5, TMax = 44.99 Where TcriteriaID = '7722765c-3e54-42a4-b209-5cafe57cc7b2'
			Update TCriteria Set Detail = '๔๕.๐๐ - ๔๗.๔๙', TMin = 45, TMax = 47.49 Where TcriteriaID = 'bcc684de-202a-44ae-948e-d7dbb78f572e'
			Update TCriteria Set Detail = '๔๗.๕๐ - ๕๐.๐๐', TMin = 47.5, TMax = 50 Where TcriteriaID = '48c0564e-b8d8-4963-8ab1-4910057944a6'

			-----------100.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๕๙.๙๙', TMin = 0, TMax = 59.99 Where TcriteriaID = '69c5bc62-b443-48c5-9a46-cd1e4df27003'
			Update TCriteria Set Detail = '๖๐.๐๐ - ๗๔.๙๙', TMin = 60, TMax = 74.99 Where TcriteriaID = '59291c4d-2eec-4ea2-8a2d-922b6a34fa4c'
			Update TCriteria Set Detail = '๗๕.๐๐ - ๘๙.๙๙', TMin = 75, TMax = 89.99 Where TcriteriaID = 'e277de33-3d86-4f09-b7b8-f3c97d585cb5'
			Update TCriteria Set Detail = '๙๐.๐๐ - ๙๔.๙๙', TMin = 90, TMax = 94.99 Where TcriteriaID = 'facf0afb-b6f4-4675-9c47-774eb1d1b8af'
			Update TCriteria Set Detail = '๙๕.๐๐ - ๑๐๐.๐๐', TMin = 95, TMax = 100 Where TcriteriaID = '6ecc7610-19d8-47cc-b728-15efd128fe21'
		End
	END


	Go
----------ลบ StoreProcedure GenIndRate
If Exists(Select * From Sys.Procedures Where Name = 'GenIndRate')
Begin
	DROP PROCEDURE GenIndRate
End

Go
--เพิ่ม Store GenIndRate
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO

Create PROCEDURE [dbo].[GenIndRate]
		@RateType int,
		@StudyYear int
	AS
	BEGIN
		SET NOCOUNT ON;
		IF @RateType = 0
		Begin
			------------เกณฑ์เก่า

			---/////////// มาตรฐานที่ 1 ////////////

			---ตัวบ่งชี้ที่  1.1  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 1

			---ตัวบ่งชี้ที่  1.2  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 2

			---ตัวบ่งชี้ที่  1.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 3

			---ตัวบ่งชี้ที่  1.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 4

			---ตัวบ่งชี้ที่  1.5  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 5

			---ตัวบ่งชี้ที่  1.6  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 6


			---/////////// มาตรฐานที่ 2 ////////////

			---ตัวบ่งชี้ที่  2.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 1

			---ตัวบ่งชี้ที่  2.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 2

			---ตัวบ่งชี้ที่  2.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 3

			---ตัวบ่งชี้ที่  2.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 4


			---/////////// มาตรฐานที่ 3 ////////////

			---ตัวบ่งชี้ที่  3.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 1

			---ตัวบ่งชี้ที่  3.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 2

			---ตัวบ่งชี้ที่  3.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 3

			---ตัวบ่งชี้ที่  3.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 4


			---/////////// มาตรฐานที่ 4 ////////////

			---ตัวบ่งชี้ที่  4.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 1

			---ตัวบ่งชี้ที่  4.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 2

			---ตัวบ่งชี้ที่  4.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 3

			---ตัวบ่งชี้ที่  4.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 4


			---/////////// มาตรฐานที่ 5 ////////////

			---ตัวบ่งชี้ที่  5.1  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 1

			---ตัวบ่งชี้ที่  5.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 2

			---ตัวบ่งชี้ที่  5.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 3

			---ตัวบ่งชี้ที่  5.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 4


			---/////////// มาตรฐานที่ 6 ////////////

			---ตัวบ่งชี้ที่  6.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 1

			---ตัวบ่งชี้ที่  6.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 2

			---ตัวบ่งชี้ที่  6.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 3

			---ตัวบ่งชี้ที่  6.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 4


			---/////////// มาตรฐานที่ 7 ////////////

			---ตัวบ่งชี้ที่  7.1  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 1

			---ตัวบ่งชี้ที่  7.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 2

			---ตัวบ่งชี้ที่  7.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 3

			---ตัวบ่งชี้ที่  7.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 4

			---ตัวบ่งชี้ที่  7.5  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 5

			---ตัวบ่งชี้ที่  7.6  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 6

			---ตัวบ่งชี้ที่  7.7  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 7

			---ตัวบ่งชี้ที่  7.8  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 8

			---ตัวบ่งชี้ที่  7.9  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 9


			---/////////// มาตรฐานที่ 8 ////////////

			---ตัวบ่งชี้ที่  8.1  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 1

			---ตัวบ่งชี้ที่  8.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 2

			---ตัวบ่งชี้ที่  8.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 3

			---ตัวบ่งชี้ที่  8.4  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 4

			---ตัวบ่งชี้ที่  8.5  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 5

			---ตัวบ่งชี้ที่  8.6  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 6


			---/////////// มาตรฐานที่ 9 ////////////

			---ตัวบ่งชี้ที่  9.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 1

			---ตัวบ่งชี้ที่  9.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 2

			---ตัวบ่งชี้ที่  9.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 3

			
			---/////////// มาตรฐานที่ 10 ////////////

			---ตัวบ่งชี้ที่  10.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 1

			---ตัวบ่งชี้ที่  10.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 2

			---ตัวบ่งชี้ที่  10.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 3

			---ตัวบ่งชี้ที่  10.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 4

			---ตัวบ่งชี้ที่  10.5  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 5

			---ตัวบ่งชี้ที่  10.6  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 6

			
			---/////////// มาตรฐานที่ 11 ////////////

			---ตัวบ่งชี้ที่  11.1  คะแนนเต็ม  4.0
			Update Indicators Set ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 1

			---ตัวบ่งชี้ที่  11.2  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 2

			---ตัวบ่งชี้ที่  11.3  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 3


			---/////////// มาตรฐานที่ 12 ////////////

			---ตัวบ่งชี้ที่  12.1  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 1

			---ตัวบ่งชี้ที่  12.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 2

			---ตัวบ่งชี้ที่  12.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 3

			---ตัวบ่งชี้ที่  12.4  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 4

			---ตัวบ่งชี้ที่  12.5  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 5

			---ตัวบ่งชี้ที่  12.6  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 6


			---/////////// มาตรฐานที่ 13 ////////////

			---ตัวบ่งชี้ที่  13.1  คะแนนเต็ม  5.0
			Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 13 And b.Sort = 1

			---ตัวบ่งชี้ที่  13.2  คะแนนเต็ม  5.0
			Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 13 And b.Sort = 2


			---/////////// มาตรฐานที่ 14 ////////////

			---ตัวบ่งชี้ที่  14.1  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 14 And b.Sort = 1

			---ตัวบ่งชี้ที่  14.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 14 And b.Sort = 2


			---/////////// มาตรฐานที่ 15 ////////////

			---ตัวบ่งชี้ที่  15.1  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 15 And b.Sort = 1

			---ตัวบ่งชี้ที่  15.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 15 And b.Sort = 2		
			
			
			--0.5--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'

			--1.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'

			--2.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'

			--3.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'

			--4.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'

			--5.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'	
		End

		IF @RateType = 1
		Begin
			------------เกณฑ์ใหม่

			---/////////// มาตรฐานที่ 1 ////////////

			---ตัวบ่งชี้ที่  1.1  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 1

			---ตัวบ่งชี้ที่  1.2  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 2

			---ตัวบ่งชี้ที่  1.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 3

			---ตัวบ่งชี้ที่  1.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 4

			---ตัวบ่งชี้ที่  1.5  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 5

			---ตัวบ่งชี้ที่  1.6  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 6


			---/////////// มาตรฐานที่ 2 ////////////

			---ตัวบ่งชี้ที่  2.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 1

			---ตัวบ่งชี้ที่  2.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 2

			---ตัวบ่งชี้ที่  2.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 3

			---ตัวบ่งชี้ที่  2.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 4


			---/////////// มาตรฐานที่ 3 ////////////

			---ตัวบ่งชี้ที่  3.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 1

			---ตัวบ่งชี้ที่  3.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 2

			---ตัวบ่งชี้ที่  3.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 3

			---ตัวบ่งชี้ที่  3.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 4


			---/////////// มาตรฐานที่ 4 ////////////

			---ตัวบ่งชี้ที่  4.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 1

			---ตัวบ่งชี้ที่  4.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 2

			---ตัวบ่งชี้ที่  4.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 3

			---ตัวบ่งชี้ที่  4.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 4


			---/////////// มาตรฐานที่ 5 ////////////

			---ตัวบ่งชี้ที่  5.1  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 1

			---ตัวบ่งชี้ที่  5.2  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 2

			---ตัวบ่งชี้ที่  5.3  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 3

			---ตัวบ่งชี้ที่  5.4  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 4


			---/////////// มาตรฐานที่ 6 ////////////

			---ตัวบ่งชี้ที่  6.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 1

			---ตัวบ่งชี้ที่  6.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 2

			---ตัวบ่งชี้ที่  6.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 3

			---ตัวบ่งชี้ที่  6.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 4


			---/////////// มาตรฐานที่ 7 ////////////

			---ตัวบ่งชี้ที่  7.1  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 1

			---ตัวบ่งชี้ที่  7.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 2

			---ตัวบ่งชี้ที่  7.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 3

			---ตัวบ่งชี้ที่  7.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 4

			---ตัวบ่งชี้ที่  7.5  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 5

			---ตัวบ่งชี้ที่  7.6  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 6

			---ตัวบ่งชี้ที่  7.7  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 7

			---ตัวบ่งชี้ที่  7.8  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 8

			---ตัวบ่งชี้ที่  7.9  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 9
			

			---/////////// มาตรฐานที่ 8 ////////////

			---ตัวบ่งชี้ที่  8.1  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 1

			---ตัวบ่งชี้ที่  8.2  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 2

			---ตัวบ่งชี้ที่  8.3  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 3

			---ตัวบ่งชี้ที่  8.4  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 4

			---ตัวบ่งชี้ที่  8.5  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 5

			---ตัวบ่งชี้ที่  8.6  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 6


			---/////////// มาตรฐานที่ 9 ////////////

			---ตัวบ่งชี้ที่  9.1  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 1

			---ตัวบ่งชี้ที่  9.2  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 2

			---ตัวบ่งชี้ที่  9.3  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 3

			
			---/////////// มาตรฐานที่ 10 ////////////

			---ตัวบ่งชี้ที่  10.1  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 1

			---ตัวบ่งชี้ที่  10.2  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 2

			---ตัวบ่งชี้ที่  10.3  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 3

			---ตัวบ่งชี้ที่  10.4  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 4

			---ตัวบ่งชี้ที่  10.5  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 5

			---ตัวบ่งชี้ที่  10.6  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 6

			
			---/////////// มาตรฐานที่ 11 ////////////

			---ตัวบ่งชี้ที่  11.1  คะแนนเต็ม  4.0
			Update Indicators Set ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 1

			---ตัวบ่งชี้ที่  11.2  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 2

			---ตัวบ่งชี้ที่  11.3  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 3

				
			---/////////// มาตรฐานที่ 12 ////////////

			---ตัวบ่งชี้ที่  12.1  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 1

			---ตัวบ่งชี้ที่  12.2  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 2

			---ตัวบ่งชี้ที่  12.3  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 3

			---ตัวบ่งชี้ที่  12.4  คะแนนเต็ม  0.5 (2)
			Update Indicators Set ScoreGroupID = 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 4

			---ตัวบ่งชี้ที่  12.5  คะแนนเต็ม  0.5 (2)
			Update Indicators Set ScoreGroupID = 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 5			

			---ตัวบ่งชี้ที่  12.6  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 6

			
			---/////////// มาตรฐานที่ 13 ////////////

			---ตัวบ่งชี้ที่  13.1  คะแนนเต็ม  5.0 (2)
			Update Indicators Set ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 13 And b.Sort = 1

			---ตัวบ่งชี้ที่  13.2  คะแนนเต็ม  5.0 (2)
			Update Indicators Set ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 13 And b.Sort = 2


			---/////////// มาตรฐานที่ 14 ////////////

			---ตัวบ่งชี้ที่  14.1  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 14 And b.Sort = 1

			---ตัวบ่งชี้ที่  14.2  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 14 And b.Sort = 2


			---/////////// มาตรฐานที่ 15 ////////////

			---ตัวบ่งชี้ที่  15.1  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 15 And b.Sort = 1

			---ตัวบ่งชี้ที่  15.2  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 15 And b.Sort = 2		


			--0.5--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'

			--0.5-- (2)
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35'

			--1.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'

			--1.0-- (2)
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'

			--2.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'

			--2.0-- (2)
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'

			--3.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'

			--4.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'

			--5.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'

			--5.0-- (2)
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
		End

		IF @RateType = 2
		Begin
			------------เกณฑ์ใหม่ 12 มาตรฐาน ปี 59

			---/////////// มาตรฐานที่ 1 ////////////

			---ตัวบ่งชี้ที่  1.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 1

			---ตัวบ่งชี้ที่  1.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 2

			---ตัวบ่งชี้ที่  1.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 3

			---ตัวบ่งชี้ที่  1.4  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 4

			---ตัวบ่งชี้ที่  1.5  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 5


			---/////////// มาตรฐานที่ 2 ////////////

			---ตัวบ่งชี้ที่  2.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 1

			---ตัวบ่งชี้ที่  2.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 2

			---ตัวบ่งชี้ที่  2.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 3

			---ตัวบ่งชี้ที่  2.4  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 4

			---ตัวบ่งชี้ที่  2.5  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 5


			---/////////// มาตรฐานที่ 3 ////////////

			---ตัวบ่งชี้ที่  3.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 1

			---ตัวบ่งชี้ที่  3.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 2

			---ตัวบ่งชี้ที่  3.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 3


			---/////////// มาตรฐานที่ 4 ////////////

			---ตัวบ่งชี้ที่  4.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 1

			---ตัวบ่งชี้ที่  4.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 2

			---ตัวบ่งชี้ที่  4.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 3


			---/////////// มาตรฐานที่ 5 ////////////

			---ตัวบ่งชี้ที่  5.1  คะแนนเต็ม  4.0
			Update Indicators Set ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 1

			---ตัวบ่งชี้ที่  5.2  คะแนนเต็ม  4.0
			Update Indicators Set ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 2

			---ตัวบ่งชี้ที่  5.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 3

			---ตัวบ่งชี้ที่  5.4  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 4

			---ตัวบ่งชี้ที่  5.5  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 5


			---/////////// มาตรฐานที่ 6 ////////////

			---ตัวบ่งชี้ที่  6.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 1

			---ตัวบ่งชี้ที่  6.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 2

			---ตัวบ่งชี้ที่  6.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 3


			---/////////// มาตรฐานที่ 7 ////////////

			---ตัวบ่งชี้ที่  7.1  คะแนนเต็ม  5.0
			Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 1

			---ตัวบ่งชี้ที่  7.2  คะแนนเต็ม  10.0
			Update Indicators Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 2


			---/////////// มาตรฐานที่ 8 ////////////

			---ตัวบ่งชี้ที่  8.1  คะแนนเต็ม  5.0 (2)
			Update Indicators Set ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 1

			---ตัวบ่งชี้ที่  8.2  คะแนนเต็ม  5.0 (2)
			Update Indicators Set ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 2

			
			---/////////// มาตรฐานที่ 9 ////////////
			
			---ตัวบ่งชี้ที่  9.1  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 1

			---ตัวบ่งชี้ที่  9.2  คะแนนเต็ม  5.0 (2)
			Update Indicators Set ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 2

			---ตัวบ่งชี้ที่  9.3  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 3


			---/////////// มาตรฐานที่ 10 ////////////

			---ตัวบ่งชี้ที่  10.1  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 1

			---ตัวบ่งชี้ที่  10.2  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 2

			---ตัวบ่งชี้ที่  10.3  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 3

			---ตัวบ่งชี้ที่  10.4  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 4

			---ตัวบ่งชี้ที่  10.5  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 5

			---ตัวบ่งชี้ที่  10.6  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 6

			---ตัวบ่งชี้ที่  10.7  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 7

			---ตัวบ่งชี้ที่  10.8  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 8

			
			---/////////// มาตรฐานที่ 11 ////////////

			---ตัวบ่งชี้ที่  11.1  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 1

			---ตัวบ่งชี้ที่  11.2  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 2

			---ตัวบ่งชี้ที่  11.3  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 3


			---/////////// มาตรฐานที่ 12 ////////////

			---ตัวบ่งชี้ที่  12.1  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 1

			---ตัวบ่งชี้ที่  12.2  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 2

			---ตัวบ่งชี้ที่  12.3  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 3


			--0.5--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'

			--1.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'

			--1.0-- (2)
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'

			--2.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'

			--2.0-- (2)
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'

			--3.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'

			--4.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'

			--5.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'

			--5.0-- (2)
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'

			--10.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61'
		End
	End


Go
Update MR_School Set spnResponsibleName = 'ผู้รับผิดชอบโครงการ' Where spnResponsibleName Is Null
Go
Update MR_School Set spnProposeName = 'ผู้เสนอโครงการ' Where spnProposeName Is Null
Go
Update MR_School Set spnApprovalName = 'ผู้เห็นชอบโครงการ' Where spnApprovalName Is Null
Go
Update MR_School Set spnApprovalName2 = 'ผู้เห็นชอบโครงการที่ 2' Where spnApprovalName2 Is Null


----------///// V 11.0.0.2 ///////-----------
--------------------------ExpDate---------------------------
Go
--เพิ่มฟิวตัวเช็คตัว ckExpDate
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckExpDate')
Begin
	alter table MR_School add ckExpDate bit
End

Go
--เพิ่มฟิววันหมดอายุ ExpDate
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ExpDate')
Begin
	alter table MR_School add ExpDate datetime
End

Go
----------Update ค่าตัวเช็ค
Update MR_School Set ckExpDate = 1 Where ckExpDate Is Null


--------------สำหรับ 122.155.0.135 เท่านั้น ------------------------------------------
Go
--เพิ่มฟิวตัวเช็คตัว ckExpDate
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('LogSchoolSar') And Name = 'ckExpDate')
Begin
	alter table LogSchoolSar add ckExpDate bit
End
Go
Update LogSchoolSar Set ckExpDate = 1 Where ckExpDate Is Null

Go
--เพิ่มฟิวค่าเช่า
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('LogSchoolSar') And Name = 'rent')
Begin
	alter table LogSchoolSar add rent int
End
Go
Update LogSchoolSar Set rent = 0 Where rent Is Null

--------------------------------------------------------------------------------------

----------------------------------- Ver 11.1.0.0 -------------------------------------
Go
--เพิ่มฟิวตัวเช็คการจัดการศึกษาใน ศต.21
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckEducation21')
Begin
	alter table MR_School add ckEducation21 bit
End

Go
----------- เพิ่ม Table Education21Side  ด้านการพัฒนาการจัดการศึกษา ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('Education21Side'))
Begin
	CREATE TABLE [dbo].[Education21Side](
		[Education21SideID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[Education21SideName] [nvarchar](300) NULL,
		[Detail] [nvarchar](2000) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_Education21Side] PRIMARY KEY CLUSTERED 
	(
		[Education21SideID] ASC
	)) ON [PRIMARY]
End

Go
--เพิ่มข้อมูลด้านการพัฒนาการจัดการศึกษา
If Not Exists(Select * From Education21Side)                                                                                                                      
Begin
	INSERT [dbo].[Education21Side] ([Education21SideID], [StudyYear], [Education21SideName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'0A337EE3-DA13-4398-AF45-C42B8C591672', '2558', N'ด้านการบริหารจัดการหลักสูตรสถานศึกษา ที่เน้นสมรรถนะทางสาขาวิชาชีพและทักษะการเรียนรู้ในศตวรรษที่ ๒๑', N'', 1, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Side] ([Education21SideID], [StudyYear], [Education21SideName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'1CBC37A6-BE0B-4D9A-87A7-6E07E73F26FE', '2558', N'ด้านการจัดกระบวนการเรียนรู้รูปแบบบูรณาการข้ามกลุ่มสาระวิชาของคณะครูผู้สอน', N'', 2, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Side] ([Education21SideID], [StudyYear], [Education21SideName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'DEDDE3C1-6C8C-4B2C-A7A7-833DA9A82F69', '2558', N'ด้านคุณภาพผู้เรียนและผลงาน', N'', 3, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
End

Go
----------- เพิ่ม Table Education21Standard  มาตรฐานคุณภาพการพัฒนา ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('Education21Standard'))
Begin
	CREATE TABLE [dbo].[Education21Standard](
		[Education21StandardID] [nvarchar](50) NOT NULL,
		[Education21SideID] [nvarchar](50) NOT NULL,
		[Education21StandardName] [nvarchar](300) NULL,
		[Detail] [nvarchar](2000) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_Education21Standard] PRIMARY KEY CLUSTERED 
	(
		[Education21StandardID] ASC
	)) ON [PRIMARY]
End
                                                                                                                                                                                                                                                                            
Go
--เพิ่มข้อมูลมาตรฐานคุณภาพการพัฒนา
If Not Exists(Select * From Education21Standard)                                                                                                                                                                  
Begin
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'9253EE4B-9BC1-42D8-81FC-2422F802E0E6', '0A337EE3-DA13-4398-AF45-C42B8C591672', N'จัดทำคลังทะเบียนอาชีพ', N'', 1, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'89F43BEF-32D2-4C84-887D-F35047C2159D', '0A337EE3-DA13-4398-AF45-C42B8C591672', N'จัดทำคลังทะเบียนแหล่งเรียนรู้', N'', 2, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'0A03DCE8-AB48-4220-9A54-46991F277ACE', '0A337EE3-DA13-4398-AF45-C42B8C591672', N'จัดทำโปรแกรมการเรียนตามสมรรถนะสาขาวิชาชีพ', N'', 3, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'0381100E-D30D-4698-8F42-C20A4525F20A', '0A337EE3-DA13-4398-AF45-C42B8C591672', N'จัดรูปแบบการพัฒนาสมรรถนะทางสาขาวิชาชีพเข้าเป็นหลักสูตรสถานศึกษา', N'', 4, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'B578BB08-7D88-4AE6-BE30-E7593F15751B', '0A337EE3-DA13-4398-AF45-C42B8C591672', N'จัดทำ Career Path นักเรียนรายบุคคล', N'', 5, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'0862A735-0EFD-47A4-BBC3-2D8DB0EDA76A', '0A337EE3-DA13-4398-AF45-C42B8C591672', N'ประเมินสมรรถนะตามสาขาอาชีพของ นักเรียนรายบุคคล', N'', 6, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'CE6984E7-28F8-443D-A5A8-AFD0FB9ED4E4', '0A337EE3-DA13-4398-AF45-C42B8C591672', N'จัดระบบการใช้เทคโนโลยีเพื่อการบริหารจัดการ การจัดกระบวนการเรียนรู้ และการเรียนรู้ของนักเรียน', N'', 7, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'5212325D-A9B9-49CA-92D4-8E1FA6ACDD3A', '1CBC37A6-BE0B-4D9A-87A7-6E07E73F26FE', N'จัดทำหน่วยเรียนรู้บูรณาการระดับชั้นแบบคณะผู้สอนและข้ามรายวิชา', N'', 1, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'92E3EF1C-2BBF-41F2-A1D3-7F8E2B36E26E', '1CBC37A6-BE0B-4D9A-87A7-6E07E73F26FE', N'กำหนดช่วงลำดับเวลากิจกรรมหน่วยเรียนรู้บูรณาการตามกระบวนการบันได ๕ ขั้น ในตารางสอน ตลอดภาคเรียน และตารางการเรียนรู้แบบฝึกและทอดประสบการณ์ตามสมรรถนะงานอาชีพ', N'', 2, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'BCA8BF4F-CC7C-4AB4-B0AB-610A951B6DCF', '1CBC37A6-BE0B-4D9A-87A7-6E07E73F26FE', N'จัดกิจกรรมการเรียนรู้หน่วยเรียนรู้บูรณาระดับชั้น ตามกระบวนการ Problem-Based ของคณะครูระดับชั้น ในรายวิชาพื้นฐาน ผ่านกระบวนการเรียนรู้แบบชุมชนแห่งการเรียนรู้วิชาชีพ (Professional Learning Community: PLC)', N'', 3, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'44E5EE48-D2A1-4042-BB86-A8D5D62FF9F2', '1CBC37A6-BE0B-4D9A-87A7-6E07E73F26FE', N'จัดกิจกรรมการเรียนรู้แบบฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะวิชาชีพ ของคณะครูในรายวิชาเพิ่มเติม ผ่านกระบวนการเรียนรู้แบบชุมชนแห่งการเรียนรู้วิชาชีพ (Professional Learning Community: PLC)', N'', 4, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'0B11DA4D-367A-41E1-8885-C1A94CE97D7C', '1CBC37A6-BE0B-4D9A-87A7-6E07E73F26FE', N'จัดกิจกรรมการสร้างแรงบันดานใจพัฒนาต่อยอดเทคโนโลยี หรือสร้างนวัตกรรม ตามกระบวนการ Project-Based Learning', N'', 5, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'CDE93640-2923-4FC2-A65E-C0ED309ADA33', '1CBC37A6-BE0B-4D9A-87A7-6E07E73F26FE', N'จัดกิจกรรมการเรียนรู้การเป็นผู้ประกอบการในวิชาชุมนุม หรือกิจกรรมพัฒนาผู้เรียน', N'', 6, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'8B72F43A-DBE9-446B-B132-1631A5B69B08', '1CBC37A6-BE0B-4D9A-87A7-6E07E73F26FE', N'จัดกิจกรรมการวัดผลที่มีคุณภาพสูง และประเมินผลอย่างสมดุลเชิงคุณภาพ', N'', 7, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'497398F8-D74B-4A53-A4AB-20028D3ADDEF', 'DEDDE3C1-6C8C-4B2C-A7A7-833DA9A82F69', N'คุณภาพผู้เรียนมีความสมดุลเชิงคุณภาพระดับดี', N'', 1, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'D081A4FB-2269-4D70-B6BB-33A730B11585', 'DEDDE3C1-6C8C-4B2C-A7A7-833DA9A82F69', N'การแสดงแรงบันดานใจพัฒนาคุณภาพการดำเนินชีวิต โดยการพัฒนาต่อยอดผลงาน (ต่อยอดเทคโนโลยีเดิม) หรือพัฒนานวัตกรรมขึ้นใช้', N'', 2, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'C37D56F0-0AEB-4D31-AD21-C9A98CC497FC', 'DEDDE3C1-6C8C-4B2C-A7A7-833DA9A82F69', N'การแสดงหลักความรู้และทฤษฎีความรู้ที่เกี่ยวข้องสัมพันธ์เชื่อมโยงกับประเด็นปัญหาหรือประเด็นสนใจ', N'', 3, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'3CC36E1B-C572-48EE-9051-418158A056DE', 'DEDDE3C1-6C8C-4B2C-A7A7-833DA9A82F69', N'การออกแบบนวัตกรรมจัดทำโครงร่าง Project-Based แสดงกระบวนการและขั้นตอนการทำให้เกิดสมมติฐาน', N'', 4, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'74AEDB5D-6A25-41A3-BAB9-59811FF961EB', 'DEDDE3C1-6C8C-4B2C-A7A7-833DA9A82F69', N'การปฏิบัติตรวจสอบ หรือสำรวจ หรือทดลองกระบวนการและขั้นตอนการเกิดสมมติฐาน', N'', 5, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'38FCB207-9232-467E-862F-AF71ED3D83CF', 'DEDDE3C1-6C8C-4B2C-A7A7-833DA9A82F69', N'ความโดดเด่นของผลงานหรือนวัตกรรมและประโยชน์ใช้งาน', N'', 6, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
End

Go
----------- เพิ่ม Table Education21Indicator  ตัวชี้วัดคุณภาพการพัฒนา ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('Education21Indicator'))
Begin
	CREATE TABLE [dbo].[Education21Indicator](
		[Education21IndicatorID] [nvarchar](50) NOT NULL,
		[Education21StandardID] [nvarchar](50) NOT NULL,
		[Education21IndicatorName] [nvarchar](500) NULL,
		[Detail] [nvarchar](2000) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_Education21Indicator] PRIMARY KEY CLUSTERED 
	(
		[Education21IndicatorID] ASC
	)) ON [PRIMARY]
End

Go
----------- เพิ่ม Table Education21Criterion  ระดับเกณฑ์คุณภาพ ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('Education21Criterion'))
Begin
	CREATE TABLE [dbo].[Education21Criterion](
		[Education21CriterionID] [nvarchar](50) NOT NULL,
		[Education21IndicatorID] [nvarchar](50) NOT NULL,
		[Detail] [nvarchar](2000) NULL,
		[Score] [int] NULL,
		[Sort] [int] NULL,
		[RecNum] [tinyint] NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_Education21Criterion] PRIMARY KEY CLUSTERED 
	(
		[Education21CriterionID] ASC
	)) ON [PRIMARY]
End

Go
----------- เพิ่ม Table Education21Evaluate  ประเมินตามตัวบ่งชี้ ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('Education21Evaluate'))
Begin
	CREATE TABLE [dbo].[Education21Evaluate](
		[Education21EvaluateID] [nvarchar](50) NOT NULL,
		[Education21IndicatorID] [nvarchar](50) NULL,
		[Sort] [int] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_Education21Evaluate] PRIMARY KEY CLUSTERED 
	(
		[Education21EvaluateID] ASC
	)) ON [PRIMARY]
End


Go
--เพิ่มเมนูด้านการพัฒนาการจัดการศึกษา
If Not Exists(Select * From MySubMenu Where MySubMenuID = '4D632222-8330-4BC4-BF0D-87A050C4470B')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('4D632222-8330-4BC4-BF0D-87A050C4470B', 'ด้านการพัฒนาการจัดการศึกษา', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 37, 'MasterData/Education21Side.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S21.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('4D632222-8330-4BC4-BF0D-87A050C4470B', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('4D632222-8330-4BC4-BF0D-87A050C4470B', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('4D632222-8330-4BC4-BF0D-87A050C4470B', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('4D632222-8330-4BC4-BF0D-87A050C4470B', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มเมนูมาตรฐานคุณภาพการพัฒนา
If Not Exists(Select * From MySubMenu Where MySubMenuID = '8D24AA30-4229-4399-AE52-41603EE8C2A6')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('8D24AA30-4229-4399-AE52-41603EE8C2A6', 'มาตรฐานคุณภาพการพัฒนา', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 38, 'MasterData/Education21Standard.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S22.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('8D24AA30-4229-4399-AE52-41603EE8C2A6', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('8D24AA30-4229-4399-AE52-41603EE8C2A6', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('8D24AA30-4229-4399-AE52-41603EE8C2A6', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('8D24AA30-4229-4399-AE52-41603EE8C2A6', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มเมนูตัวชี้วัดคุณภาพการพัฒนา
If Not Exists(Select * From MySubMenu Where MySubMenuID = '9828F90E-E47F-4EBA-85D2-7BD46BD350D0')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('9828F90E-E47F-4EBA-85D2-7BD46BD350D0', 'ตัวชี้วัดคุณภาพการพัฒนา', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 39, 'MasterData/Education21Indicator.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S23.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('9828F90E-E47F-4EBA-85D2-7BD46BD350D0', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('9828F90E-E47F-4EBA-85D2-7BD46BD350D0', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('9828F90E-E47F-4EBA-85D2-7BD46BD350D0', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('9828F90E-E47F-4EBA-85D2-7BD46BD350D0', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มเมนูคัดลอกด้าน/มาตรฐาน/ตัวชี้วัดการจัดการศึกษา ศต.21
If Not Exists(Select * From MySubMenu Where MySubMenuID = '034D7EB1-4A1E-4018-8204-A530597BA43E')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('034D7EB1-4A1E-4018-8204-A530597BA43E', 'คัดลอกด้าน/มาตรฐาน/ตัวชี้วัด ศต.21', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 40, 'MasterData/CopyEducation21.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S24.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('034D7EB1-4A1E-4018-8204-A530597BA43E', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('034D7EB1-4A1E-4018-8204-A530597BA43E', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('034D7EB1-4A1E-4018-8204-A530597BA43E', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('034D7EB1-4A1E-4018-8204-A530597BA43E', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มเมนูประเมินการจัดการศึกษา ศต.21
If Not Exists(Select * From MySubMenu Where MySubMenuID = '5BCAD7D9-C1F1-4F36-BF1A-B00946EDD298')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('5BCAD7D9-C1F1-4F36-BF1A-B00946EDD298', 'ประเมินการจัดการศึกษา ศต.21', 'dd43213f-becd-4d63-85a3-f2d6936aa982', 6, 'MasterData/Education21Evaluate.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S7.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('5BCAD7D9-C1F1-4F36-BF1A-B00946EDD298', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('5BCAD7D9-C1F1-4F36-BF1A-B00946EDD298', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('5BCAD7D9-C1F1-4F36-BF1A-B00946EDD298', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('5BCAD7D9-C1F1-4F36-BF1A-B00946EDD298', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มเมนูผลการประเมินการจัดการศึกษา ศต.21
If Not Exists(Select * From MySubMenu Where MySubMenuID = '9AC39EBD-6DE2-4330-B0A3-35E95A347E80')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('9AC39EBD-6DE2-4330-B0A3-35E95A347E80', 'ผลการประเมินการจัดการศึกษา ศต.21', '8de87893-6cd6-4900-968a-db0e8832d043', 14, 'MasterData/Education21EvaluateView.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S09.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('9AC39EBD-6DE2-4330-B0A3-35E95A347E80', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('9AC39EBD-6DE2-4330-B0A3-35E95A347E80', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('9AC39EBD-6DE2-4330-B0A3-35E95A347E80', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('9AC39EBD-6DE2-4330-B0A3-35E95A347E80', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
----------ลบ StoreProcedure เมนู Education21
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuEducation21')
Begin
	DROP PROCEDURE ckMenuEducation21
End

Go
--เพิ่ม Store เมนู Education21
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuEducation21
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '4D632222-8330-4BC4-BF0D-87A050C4470B'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '8D24AA30-4229-4399-AE52-41603EE8C2A6'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '9828F90E-E47F-4EBA-85D2-7BD46BD350D0'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '034D7EB1-4A1E-4018-8204-A530597BA43E'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '5BCAD7D9-C1F1-4F36-BF1A-B00946EDD298'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '9AC39EBD-6DE2-4330-B0A3-35E95A347E80'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '4D632222-8330-4BC4-BF0D-87A050C4470B'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '8D24AA30-4229-4399-AE52-41603EE8C2A6'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '9828F90E-E47F-4EBA-85D2-7BD46BD350D0'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '034D7EB1-4A1E-4018-8204-A530597BA43E'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '5BCAD7D9-C1F1-4F36-BF1A-B00946EDD298'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '9AC39EBD-6DE2-4330-B0A3-35E95A347E80'
	End
END
Go

Go
----------Update ค่าตัวเช็ค
Update MR_School Set ckEducation21 = 0 Where ckEducation21 Is Null


-------------V 11.1.0.1 -----------------------------
Go
----------- เพิ่ม Table Education21Evaluate  ประเมินตามตัวบ่งชี้ ------------
If Exists(Select * From Sys.Tables Where Object_ID = Object_ID('Education21Evaluate'))
Begin
	Drop Table Education21Evaluate

	CREATE TABLE [dbo].[Education21Evaluate](
		[Education21EvaluateID] [nvarchar](50) NOT NULL,
		[Education21StandardID] [nvarchar](50) NULL,
		[Education21IndicatorID] [nvarchar](50) NULL,
		[Sort] [int] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_Education21Evaluate] PRIMARY KEY CLUSTERED 
	(
		[Education21EvaluateID] ASC
	)) ON [PRIMARY]
End

Go
--ขยายขนาด Column
alter table Education21Indicator alter column Education21IndicatorName nvarchar(1000)

Go
--เพิ่มฟิว ประเภทการประเมินใน ด้าน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Education21Side') And Name = 'EvaluateType')
Begin
	alter table Education21Side add EvaluateType tinyint
End

Go
--เพิ่มฟิว เช็คการประเมินที่มาตรฐาน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Education21Standard') And Name = 'ckEvaluate')
Begin
	alter table Education21Standard add ckEvaluate bit
End

--ปรับปรุงข้อมูลการประเมินในมาตรฐาน
Go
Update Education21Standard Set ckEvaluate = 1
Go
Update Education21Standard Set ckEvaluate = 0 Where Education21StandardID = '38FCB207-9232-467E-862F-AF71ED3D83CF'

Go
--แก้ไขข้อมูลด้านการพัฒนาการจัดการศึกษา
If Exists(Select * From Education21Side)                                                                                                                      
Begin
	Update Education21Side Set EvaluateType = 0 Where Education21SideID = '0A337EE3-DA13-4398-AF45-C42B8C591672'
	Update Education21Side Set EvaluateType = 0 Where Education21SideID = '1CBC37A6-BE0B-4D9A-87A7-6E07E73F26FE'
	Update Education21Side Set EvaluateType = 0 Where Education21SideID = 'DEDDE3C1-6C8C-4B2C-A7A7-833DA9A82F69'

	--(ด้านผลงาน)
	INSERT [dbo].[Education21Side] ([Education21SideID], [StudyYear], [Education21SideName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [EvaluateType]) VALUES (N'FE7F00D4-F063-4329-B5DE-DB01C767D783', '2558', N'ด้านการบริหารจัดการหลักสูตรสถานศึกษา ที่เน้นสมรรถนะทางสาขาวิชาชีพและทักษะการเรียนรู้ในศตวรรษที่ ๒๑', N'', 1, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)
	INSERT [dbo].[Education21Side] ([Education21SideID], [StudyYear], [Education21SideName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [EvaluateType]) VALUES (N'C60336CD-84EE-4629-BEAB-0E4818A88F2B', '2558', N'ด้านการจัดกระบวนการเรียนรู้รูปแบบบูรณาการข้ามกลุ่มสาระวิชาของคณะครูผู้สอน', N'', 2, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)
	INSERT [dbo].[Education21Side] ([Education21SideID], [StudyYear], [Education21SideName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [EvaluateType]) VALUES (N'231B5F5D-A066-4BD7-8D6B-172B832D2C55', '2558', N'ด้านคุณภาพผู้เรียนและผลงาน', N'', 3, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)
End

Go
--เพิ่มข้อมูลมาตรฐานคุณภาพการพัฒนา (ด้านผลงาน)
If Exists(Select * From Education21Standard)                                                                                                                                                                                                                                                                                                                                                                                    
Begin
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ckEvaluate]) VALUES (N'A6D0C997-FB04-4C84-9388-32443F283538', 'FE7F00D4-F063-4329-B5DE-DB01C767D783', N'การนำเสนอผลงานการจัดทำและบริหารจัดการหลักสูตรสถานศึกษา', N'', 1, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ckEvaluate]) VALUES (N'B3F118F3-98DE-434D-A2F7-C3C27E5D7ABE', 'FE7F00D4-F063-4329-B5DE-DB01C767D783', N'การตอบคำถาม', N'', 2, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ckEvaluate]) VALUES (N'9203415F-EF59-4019-A1B3-A98735494164', 'C60336CD-84EE-4629-BEAB-0E4818A88F2B', N'การนำเสนอผลงานการจัดกระบวนการเรียนรู้รูปแบบบูรณาการข้ามกลุ่มสาระวิชาของคณะครูผู้สอน', N'', 1, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ckEvaluate]) VALUES (N'EADA18F4-4FA4-4C1E-8342-BAF97FCE8A5B', 'C60336CD-84EE-4629-BEAB-0E4818A88F2B', N'การตอบคำถาม', N'', 2, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ckEvaluate]) VALUES (N'5866D846-1F01-443B-B1F5-5B30C5FB3E86', '231B5F5D-A066-4BD7-8D6B-172B832D2C55', N'การนำเสนอผลงานหรือนวัตกรรม', N'', 1, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)
	INSERT [dbo].[Education21Standard] ([Education21StandardID], [Education21SideID], [Education21StandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ckEvaluate]) VALUES (N'F8B16B74-FE8C-445C-9DD4-129565554132', '231B5F5D-A066-4BD7-8D6B-172B832D2C55', N'การตอบคำถาม', N'', 2, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)
End

Go
If Not Exists(Select * From Education21Indicator)
Begin
	INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'006609bb-3776-4b82-812a-797775df6722', N'5866D846-1F01-443B-B1F5-5B30C5FB3E86', N'ภาพลักษณ์ของผลงาน หรือนวัตกรรม มีการออกแบบเหมาะการใช้งานโดดเด่นสวยงาม ใช้วัสดุอุปกรณ์ และวิธีการผลิตที่เหมาะสมและเป็นมิตรกับธรรมชาติและสิ่งแวดล้อม', N'', 3, 0, CAST(0x0000A5A700E6B0DC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E6B0DC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'0811dab9-ef23-4d7f-97da-bd273830636f', N'c4db88f5-cc75-4b2d-94e0-699cce37d181', N'กระบวนการและขั้นตอนการผลิตมีการบูรณาการสร้างเครือข่ายความร่วมมือกันทุกภาคส่วน สร้างกระบวนการให้เกิดสมรรถนะทางสาขาวิชาชีพ กระบวนการเรียนรู้แหล่งเรียนรู้ในชุมชนได้อย่างเชื่อมโยงและเหมาะสม', N'', 2, 0, CAST(0x0000A5A300F44F81 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300F44F81 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'0ebed82d-8c45-45bb-8145-7723a7ba254f', N'5212325D-A9B9-49CA-92D4-8E1FA6ACDD3A', N'มีผังมโนทัศน์แสดงชื่อหน่วยเรียนรู้บูรณาการ แสดงการแตกประเด็นความรู้เป็นชื่อเรื่องหลัก ชื่อเรื่องรอง ชื่อเรื่องย่อย และมีคำสำคัญของมาตรฐานการเรียนรู้และตัวชี้วัดเขียนกำกับ โดยมีแบบบรรณานุกรมเขียนกำกับแทนหลักความรู้ นำไปบูรณาการตามประเด็นชื่อเรื่องแบบคณะบุคคลข้ามรายวิชา', N'', 1, 0, CAST(0x0000A5A20113B1F6 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A20113B1F6 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'156ff13a-bb20-4f7f-97d0-cec604b4b8e9', N'CDE93640-2923-4FC2-A65E-C0ED309ADA33', N'๒. มีการจัดกิจกรรมของคณะครูในรายวิชากิจกรรม หรือกิจกรรมพัฒนาผู้เรียนผ่านกระบวนการเรียนรู้แบบชุมชนแห่งการเรียนรู้วิชาชีพ (PLC) ร่วมกันจัดทำคู่มือการเรียนรู้การเป็นผู้ประกอบการในแบบต่าง ๆ  โดยความร่วมมือของสถานประกอบการ มีกิจกรรมให้นักเรียนเลือกเข้าเป็นสมาชิกผู้ประกอบการแบบต่าง ๆ ตามความสมัครใจ มีการจัดกิจกรรมจำลองการจดทะเบียนบริษัทจำลอง มีกิจกรรมการจัดหาวัตถุดิบ การผลิตและแปรรูป การจัดทำบรรจุภัณฑ์ มีกิจกรรมการสร้างกลยุทธ์การขายและจัดจำหน่าย การจัดทำบัญชีรายรับรายจ่ายและรายงานผลการประกอบการ', N'', 2, 0, CAST(0x0000A5A3008E87C0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A3008E87C0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'1a307ad6-1b9a-4ce4-bd44-ddd17d42f9c4', N'CDE93640-2923-4FC2-A65E-C0ED309ADA33', N'มีเอกสารคู่มือการเรียนรู้การเป็นผู้ประกอบการ หรือมีใบกิจกรรม ใบความรู้ มีเอกสารแสดงร่องรอยการจัดกิจกรรมการจดทะเบียนบริษัทจำลอง กิจกรรมการนำเข้าวัตถุดิบ การผลิต แปรรูป บรรจุภัณฑื จัดจำหน่าย และบัญชีรายรับรายจ่าย', N'', 3, 0, CAST(0x0000A5A3008ED237 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A3008ED237 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'1b9a6618-ece6-4134-9b64-4b7af263ebd0', N'C37D56F0-0AEB-4D31-AD21-C9A98CC497FC', N'มีผังมโนทัศน์ หรือการเรียบเรียงหลักความรู้และทฤษฎีความรู้ที่เกี่ยวข้องมากเพียงพอและแสดงความสัมพันธ์เชื่อมโยงกับประเด็นปัญหาหรือประเด็นสนใจ ที่แสดงที่มาของแหล่งความรู้ในรูปบรรณานุกรม หรืออย่างอื่นที่เป็นที่ยอมรับเป็นสากลและเชื่อถือได้', N'', 1, 0, CAST(0x0000A5A300970DB8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300970DB8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'203a364c-98d6-42db-a21f-f58cd3569cba', N'44E5EE48-D2A1-4042-BB86-A8D5D62FF9F2', N'มีเอกสารแผนการเรียนรู้ หรือคู่มือการเรียนรู้แบบฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะสาขาวิชาชีพ แบบหลักสูตรระยะสั้น หรือหลักสูตรเรียนสะสมหน่วยกิจเพื่อเตรียม ปวช. หรือหลักสูตรทวิศึกษา หรือหลักสูตรการเตรียมพื้นฐานการเรียนตามสมรรถนะสาขาวิชาชีพในการศึกษาต่อระดับอุดมศึกษา มีเอกสารใบกิจกรรม ใบความรู้ สื่อ มีเอกสารแสดงร่องรอยการบันทึกสรุปผลการฝึกและถอดประสบการของนักเรียน', N'', 3, 0, CAST(0x0000A5A2011BEBC0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A2011BEBC0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'282b01c9-9ac6-4923-b94b-3f4cee8f8dd7', N'CE6984E7-28F8-443D-A5A8-AFD0FB9ED4E4', N'มีเอกสารตารางการเข้าใช้ระบบเทคโนโลยี มีเอกสารปริมาณการเข้าใช้ มีการกำหนดกิจกรรมให้มีการใช้ระบบเทคโนโลยี มีเอกสารระเบียบการใช้เทคโนโลยีของโรงเรียน', N'', 3, 0, CAST(0x0000A5A20113240E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A20113240E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'2a4c794b-cce5-4e31-9483-e30dd78dc8e7', N'BCA8BF4F-CC7C-4AB4-B0AB-610A951B6DCF', N'มีเอกสารใบกิจกรรม และใบความรู้แนบด้วยบรรณานุกรมแทนหลักความรู้ของตัวชี้วัดรายวิชาทุกกิจกรรมตามกรอบบันได ๕ ขั้น แบบ Problem-Based Learning มีเอกสารแสดงการบันทึกผล หรือรายงานผลสรุปจากกระบวนการเรียนรู้แบบชุมชนแห่งการเรียนรู้วิชาชีพ (Professional Learning Community: PLC) ของครูระดับชั้นที่แสดงรูปแบบการจัดกิจกรรม การพัฒนาการความก้าวหน้าของนักเรียนและแก้ไขปัญหา ในแต่ละกิจกรรม มีเอกสารแสดงร่องรอยการทำกิจกรรมของนักเรียนทุกกิจกรรม', N'', 3, 0, CAST(0x0000A5A20118438E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A20118438E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'2a726295-1717-4e2e-b6c9-c8f691a25d4d', N'9253EE4B-9BC1-42D8-81FC-2422F802E0E6', N'มีบันทึกความร่วมมือ หรือหนังสืออนุเคราะห์การได้มาซึ่งข้อมูลคลังทะเบียนอาชีพในท้องถิ่น หรือหลักฐานอื่นที่แสดงแสดงกิจกรรมความร่วมมือ', N'', 3, 0, CAST(0x0000A5A200BC2775 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300C04CE8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'2fc2d6af-4bea-4552-a7c8-179a9c2fd911', N'92E3EF1C-2BBF-41F2-A1D3-7F8E2B36E26E', N'มีตารางสอนที่รองรับการจัดกิจกรรมตามกระบวนการเรียนรู้ โดยกำหนดช่วงลำดับเวลาของกิจกรรมหน่วยเรียนรู้บูรณาการตามกระบวนการบันได ๕ ขั้น กำหนดช่วงเวลาการจัดกระบวนการเรียนรู้แบบชุมชนแห่งการเรียนรู้วิชาชีพ (Professional Learning Community: PLC) ของครูระดับชั้น กำหนดช่วงเวลาของการเรียนแบบฝึกประสบการณ์ตามสมรรถนะงานอาชีพ กำหนดช่วงเวลาของวิชาที่ไม่นำตัวชี้วัดรายวิชามาบูรณาการ และกำหนดช่วงเวลาการฝึกการเรียนรู้การเป็นผู้ประกอบการในวิชากิจกรรมชุมนุม', N'', 1, 0, CAST(0x0000A5A201154F68 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A201154F68 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'2fef51c1-988d-4b6d-9ee4-af5e408bdcc2', N'A6D0C997-FB04-4C84-9388-32443F283538', N'มีการนำเสนอเผยแพร่การใช้งานด้วยวิธีการเหมาะสมน่าสนใจ ตรงประเด็น และรักษาเวลา นำไปสู่ช่องทางการใช้ประโยชน์ต่อการสร้างงานและพัฒนางานอาชีพของชุมชน สังคม และประเทศชาติ', N'', 4, 0, CAST(0x0000A5A700E44A66 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E44A66 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'3973e3b2-08c7-4c10-bbed-11ef2c22f3c7', N'9203415F-EF59-4019-A1B3-A98735494164', N'มีการนำเสนอเผยแพร่การใช้งานด้วยวิธีการเหมาะสมน่าสนใจ ตรงประเด็น และรักษาเวลา นำไปสู่ช่องทางการใช้ประโยชน์ต่อการสร้างงานและพัฒนางานอาชีพของชุมชน สังคม และประเทศชาติ', N'', 4, 0, CAST(0x0000A5A700E567F4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E567F4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'4241621c-34b3-4ac5-8e6c-7a7c91384b1b', N'9203415F-EF59-4019-A1B3-A98735494164', N'กระบวนการและขั้นตอนการผลิตมีการบูรณาการระดับชั้นลดความซ้ำซ้อนของสาระเนื้อหาและการบ้านข้ามรายวิชา ลดเวลาเรียนเพิ่มกิจกรรมการเรียนรู้ มีความร่วมมือกับสถานประกอบการ หรือกลุ่มอาชีพอิสระจัดกระบวนการเรียนรู้แบบฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะสาขาวิชาชีพในรายวิชาเพิ่มเติม และจัดกิจกรรมการเรียนรู้การเป็นผู้ประกอบการในวิชาชุมนุมหรือกิจกรรมพัฒนาผู้เรียน ที่มีการใช้แหล่งเรียนรู้ในชุมชนเป็นสถานการณ์กระตุ้นได้อย่างเชื่อมโยงและเหมาะสม', N'', 2, 0, CAST(0x0000A5A700E51821 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E51821 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'48038dcf-9986-4adc-a99e-8d9236d82ea1', N'497398F8-D74B-4A53-A4AB-20028D3ADDEF', N'มีการเรียนรู้ในรูปแบบ Problem-Based Learning และ Problem-Based Learning ตามกระบวนการบันได ๕ ขั้น และมีการเรียนรู้ในรูปแบบการเรียนฝึกและถอดประสบการณ์ตามสมรรถนะสาขาวิชาชีพ และมีการเรียนรู้การเป็นผู้ประกอบการลักษณะใดลักษณะหนึ่ง', N'', 2, 0, CAST(0x0000A5A3009462B8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A3009462B8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'4bc80c63-0c83-4e68-91b6-c9d9f09abb9e', N'0862A735-0EFD-47A4-BBC3-2D8DB0EDA76A', N'มีเอกสารแสดงความร่วมมือการจัดทำหลักสูตรรายวิชาเพิ่มเติม และเอกสารการประสานงาน คู่มือการฝึกและถอดประสบการณ์ตามสมรรถนะสาขาวิชาชีพ และมีเอกสารแสดงการออกหลักฐานการประเมินสมรรถนะตามสาขาวิชาชีพ', N'', 3, 0, CAST(0x0000A5A20111C349 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A20111C349 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'4d6bcb37-1a96-4a90-9b54-09e3782a97d6', N'CE6984E7-28F8-443D-A5A8-AFD0FB9ED4E4', N'ดำเนินการสำรวจนำเทคโนโลยีที่มีอยู่โรงเรียนมาใช้และพัฒนาต่อยอดใช้สนับสนุนการบริหารจัดการโรงเรียน กระบวนการเรียนรู้ และการสร้างองค์ความรู้ให้กับนักเรียน ดำเนินการประเมินสมรรถนะของเครื่องมือและโปรแกรมสนับสนุนใช้ให้เกิดประโยชน์อย่างเต็มที่และต่อเนื่อง มีการจัดกิจกรรมสร้างจริยธรรมในการใช้เทคโนโลยีในห้องเรียน และในชีวิตประจำวัน มีการให้ความรู้กฎหมาย พ.ร.บ. ICT', N'', 2, 0, CAST(0x0000A5A201128D89 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A201128D89 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'4e0ce081-d759-4113-882e-71f1d241ee12', N'D081A4FB-2269-4D70-B6BB-33A730B11585', N'มีการเขียนที่มาของปัญหาหรือประเด็นสนใจที่แสดงถึงข้อจำกัดของการดำเนินชีวิตของผู้คนในชุมชน สังคม และประเทศชาติ ที่ต้องการหาเครื่องมือสิ่งอำนวยความสะดวกในการพัฒนาคุณภาพชีวิตให้ดีขึ้น และเขียนผลที่จะเกิดประโยชน์ในด้านการใช้งาน การพัฒนาคุณภาพชีวิต หรือการต่อยอดการสร้างงานสร้างรายได้ ไปสู่ภาคธุรกิจการค้า และเศรษฐกิจของประเทศ', N'', 1, 0, CAST(0x0000A5A30095913A AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A30095913A AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'53dfd0b2-7aa4-41c6-9878-fd12ef69cb2f', N'497398F8-D74B-4A53-A4AB-20028D3ADDEF', N'มีระดับผลการเรียนเฉลี่ยในปีการศึกษาดีและมีความสมดุลเชิงคุณภาพของด้านความรู้ ด้านทักษะ และด้าน เจตนคติ มีระดับผลการการเรียนเฉลี่ยในรายวิชาเพิ่มเติมตามหลักสูตรสมรรถนะสาขาวิชาชีพระดับดี และผ่านการเข้าร่วมกิจกรรมการเรียนรู้การเป็นผู้ประกอบการ', N'', 1, 0, CAST(0x0000A5A30093E6D0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A30093E6D5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'5865fd39-f2f9-43b8-ad41-2b1d01441565', N'9203415F-EF59-4019-A1B3-A98735494164', N'เป็นผลงานหรือนวัตกรรมที่สามารถแก้ปัญหาตามวัตถุประสงค์ตอบประโยชน์กระบวนการของ Problem-Based Learning และ Project-Based Learning ตามกรอบบันได ๕ ขั้น  ที่ทำงานร่วมกันของคณะครูผู้สอนระดับชั้นแบบชุมชนแห่งการเรียนรู้วิชาชีพ (Professional Learning Community: PLC) ตรงความต้องการของนักเรียนอยากเรียนรู้และใช้งานได้จริง มีความแปลกใหม่ ทันสมัยและสร้างสรรค์', N'', 1, 0, CAST(0x0000A5A700E4F710 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E4F710 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'5ab2630b-47ec-453a-8777-ef94a4bd6f21', N'0B11DA4D-367A-41E1-8885-C1A94CE97D7C', N'มีเอกสารใบกิจกรรม ใบความรู้ และสื่อใช้เป็นเครื่องมือจัดการเรียนรู้ มีแผนและบันทึกผลการให้คำปรึกษาการทำผลงาน มีเอกสารร่องรอยการจัดกิจกรรมการสืบค้นแลกเปลี่ยนเรียนรู้ กิจกรรมสร้างแรงบันดานใจตั้งประเด็นสนใจพัฒนานวัตกรรม กิจกรรมการปฏิบัติตามกระบวนการละขั้นตอน และอธิบายผลปรากฎการณ์กับทฤษฎีความรู้ กิจกรรมการสรุปผล สื่อสาร นำเสนอด้วยวิธีที่หลากหลาย และกิจกรรมการคัดเลือกหรือประกวดผลงานนักเรียนที่ผ่านเกณฑ์คุณภาพ', N'', 3, 0, CAST(0x0000A5A2011E4CEA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A2011E4CEA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'5afffb67-0284-4190-b6e4-fd448078b3de', N'9253EE4B-9BC1-42D8-81FC-2422F802E0E6', N'มีคลังทะเบียนสถานประกอบการและอาชีพตามบริบทและสภาพแวดล้อมของท้องถิ่น มีสื่อแนะนำรายละเอียดลักษณะงานอาชีพ และสมรรถนะตามสาขาวิชาชีพ ที่มีข้อมูลครบถ้วน ถูกต้องเป็นปัจจุบัน และมีแผนแสดงปริมาณความต้องการสาขาวิชาชีพรองรับการศึกษาต่อสาขาอาชีพ', N'', 1, 1, CAST(0x0000A5A200BC4FAA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A200BC5F2D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'5f6ee31e-6f4b-41e1-bfdd-e9a4f760dfcf', N'38FCB207-9232-467E-862F-AF71ED3D83CF', N'เป็นผลงานหรือนวัตกรรมที่สามารถแก้ปัญหาตามวัตถุประสงค์ตอบประโยชน์เพื่อสังคมและใช้งานได้จริง มีความแปลกใหม่ ทันสมัยและสร้างสรรค์', N'', 1, 0, CAST(0x0000A5A3009B34D1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A3009B34D1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'6076e517-5ab2-403c-85eb-aa3ac42940cc', N'8B72F43A-DBE9-446B-B132-1631A5B69B08', N'จัดกิจกรรมวิเคราะห์มาตรฐานการเรียนรู้และตัวชี้วัดรายวิชาเพื่อกำหนดสัดสวนเวลาและน้ำหนักคะแนนของตัวชี้วัดรายวิชา และกำหนดประเภท (K, P, A) และระดับขั้นพฤติกรรมของตัวชี้วัดรายวิชา ตลอดจนคำสำคัญที่แสดงหลักความรู้ของตัวชี้วัดรายวิชา นำไปเป็นกรอบการสร้างเครื่องมือและวัดผลที่มีคุณภาพสูงสำหรับคะแนนเก็บได้ครบทุกตัวชี้วัดรายวิชา และคะแนนสอบกลางภาคและปลายภาคตามแผนการเลือกตัวชี้วัดรายวิชาที่สำคัญที่เป็นตัวแทน จัดกิจกรรมการแปลและแสดงผลการประเมินความสมดุลเชิงคุณภาพของนักเรียนรายบุคคลด้านความรู้ ด้านทักษะ และด้านเจตนคติ และมีการซ่อมเสริมนักเรียนกรณีที่ยังไม่สมดุลเชิงคุณภาพ จัดกิจกรรมสร้างและใช้เครื่องมือประเมินระดับคุณภาพการพัฒนาทักษะ สมรรถนะและคุณลักษณะตามหลักสูตร ตลอดจนค่านิยม ๑๒ ประการ มีการนำเครื่องมือประเมินบุคลิกภาพความเหมาะสมต่อการประกอบอาชีพมาประเมินนักเรียนเพื่อคัดเลือกเข้าสู่โปรแกรมการเรียน', N'', 2, 0, CAST(0x0000A5A30092824D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A30092824D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'60c83e52-8b84-445f-9063-09f4bb98b57b', N'F8B16B74-FE8C-445C-9DD4-129565554132', N'ด้านการออกแบบและการใช้เทคโนโลยี', N'', 3, 0, CAST(0x0000A5A700E758D3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E758D3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'665a4b09-091a-4412-b687-60e635f52923', N'9253EE4B-9BC1-42D8-81FC-2422F802E0E6', N'จัดกิจกรรมระดมความคิดเห็นจากสถานประกอบการ กลุ่มอาชีพอิสระทุกภาคส่วน ในท้องถิ่น แสดงความต้องปริมาณการอัตรากำลังแรงงาน ที่มีสมรรถนะ คุณลักษณะในแต่ละสาขาอาชีพ', N'', 2, 0, CAST(0x0000A5A200BADC12 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A200BB2FAE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'66ea0dab-63b6-420a-aaac-43adf1044fae', N'5866D846-1F01-443B-B1F5-5B30C5FB3E86', N'กระบวนการและขั้นตอนการผลิตมีการ บูรณาการทฤษฎีความรู้จาก ๘ กลุ่มสาระการเรียนรู้ และความรู้เชิงบูรณาการในศตวรรษที่ ๒๑ ได้อย่างเชื่อมโยงและเหมาะสม', N'', 2, 0, CAST(0x0000A5A700E64263 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E64263 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'6a821855-e867-4b9b-bba4-e2390103066b', N'0B11DA4D-367A-41E1-8885-C1A94CE97D7C', N'มีใบกิจกรรม ใบความรู้ และสื่อเป็นเครื่องมือการจัดการเรียนรู้ นำไปสู่กระบวนการสร้างองค์ความรู้เรื่องกระบวนการและขั้นตอนการทำโครงงาน (Project-Based) ด้วยตนเองของนักเรียน มีแผนการให้คำปรึกษาและบันทึกผลการเรียนรู้ของการพัฒนาผลงานของนักเรียน', N'', 1, 0, CAST(0x0000A5A2011C788C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A2011C788C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'70285852-13af-4d35-9b00-5b6bfbf4f6ef', N'A6D0C997-FB04-4C84-9388-32443F283538', N'ภาพลักษณ์ของผลงาน รูปแบบหรือนวัตกรรม มีการออกแบบ นำเทคโนโลยีมาจัดการประสิทธิภาพอย่างเหมาะสมและใช้งานได้โดดเด่น เป็นวิธีการที่กลมกลืนเหมาะสมและเป็นมิตรกับธรรมชาติและสิ่งแวดล้อม', N'', 3, 0, CAST(0x0000A5A700E41B25 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E41B25 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'712a9a61-f2be-434a-8b24-e5451133347e', N'89F43BEF-32D2-4C84-887D-F35047C2159D', N'มีคลังทะเบียนแหล่งเรียนรู้ตามบริบทและสภาพแวดล้อมของท้องถิ่น และมีสื่อแนะนำรายละเอียดลักษณะแหล่งเรียนรู้ ด้านกายภาพ ชีวภาพ หรือวิถีชุมชน และมีข้อมูลถูกต้องเป็นปัจจุบัน', N'', 1, 0, CAST(0x0000A5A200BCD1B0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A200BD883B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'76388d62-cb26-421c-a473-8ca9ea949d9d', N'38FCB207-9232-467E-862F-AF71ED3D83CF', N'ภาพลักษณ์ของผลงาน หรือนวัตกรรม มีการออกแบบเหมาะการใช้งานโดดเด่นสวยงาม ใช้วัสดุอุปกรณ์ และวิธีการผลิตที่เหมาะสมและเป็นมิตรกับธรรมชาติและสิ่งแวดล้อม', N'', 3, 0, CAST(0x0000A5A300B3DBFD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300B3DBFD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'797e3d48-fdba-4509-9695-f3639f3f1eda', N'0862A735-0EFD-47A4-BBC3-2D8DB0EDA76A', N'จัดกิจกรรมความร่วมมือกับศูนย์พัฒนาฝีมือแรงงานจังหวัด วิทยาลัยสารพัดช่าง หรือหน่วยงานอื่นที่เกี่ยวข้องบรรจุหลักสูตรวิชาชีพระยะสั้น หรือหลักสูตร ทวิศึกษาในรายวิชาเพิ่มเติม มีกิจกรรมความร่วมมือกับสถานประกอบการใช้เป็นที่ฝึกและถอดประสบการณ์ตามทักษะและสมรรถนะทางสาขาอาชีพ และจัดกิจกรรมการประเมินสมรรถนะตามสาขาอาชีพ โดยความร่วมมือกับศูนย์พัฒนาฝีมือแรงงานจังหวัด', N'', 2, 0, CAST(0x0000A5A201116CD7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A201116CD7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'79aa2bfa-0f3d-457a-ba4b-e683e67d37ff', N'C37D56F0-0AEB-4D31-AD21-C9A98CC497FC', N'มีเอกสารการเรียบเรียงหลักความรู้และทฤษฎีความรู้ หรือผังมโนทัศน์ มีบรรณานุกรมความรู้แสดงความเชื่อถือได้และเป็นสากลของทฤษฎีความรู้ และมีแผนการสืบค้นความรู้หรือร่องรอยหลักฐานอื่น ที่แสดงถึงการทำงานให้ได้กรอบทฤษฎีความรู้ของคณะผู้ทำผลงาน', N'', 3, 0, CAST(0x0000A5A30097CD23 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A30097CD23 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'83525fa0-28e5-40b6-b0e1-3e20511f089c', N'89F43BEF-32D2-4C84-887D-F35047C2159D', N'จัดกิจกรรมความร่วมของคณะครูและนักเรียนในระดับชั้น ทำการสำรวจความต้องการที่จะเรียนรู้เรื่องอะไรบ้าง จากแหล่งเรียนรู้ หรือสถานประกอบการ     ในท้องถิ่น', N'', 2, 0, CAST(0x0000A5A200BCF89D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A200BDF4B4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'84360abb-dcc7-4ebe-9dbc-652e3ef0ae2c', N'B3F118F3-98DE-434D-A2F7-C3C27E5D7ABE', N'ด้านความร่วมมือเข้ามาจัดและช่วยจัดการศึกษา', N'', 2, 0, CAST(0x0000A5A700E4A5A1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E4A5A1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'85cf52b4-0e46-499b-96e9-e20f2402b044', N'D081A4FB-2269-4D70-B6BB-33A730B11585', N'มีเอกสารแสดงที่มาของปัญหาหรือประเด็นสนใจและประโยชน์ที่จะเกิดขึ้น และมีร่องรอยหลักฐานต่าง ๆ ที่แสดงถึงความต้องการต่อยอดพัฒนากระบวนการผลิต หรือพัฒนาผลิตภัณฑ์ หรือพัฒนานวัตกรรม และมีเอกสารของบุคคลในคณะทำผลงานที่แสดงปัญหาและประเด็นสนใจที่เป็นเรื่องเดียวกัน', N'', 3, 0, CAST(0x0000A5A300966915 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A30096691A AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'8685b987-3452-4ce9-9f09-61bb584618ab', N'92E3EF1C-2BBF-41F2-A1D3-7F8E2B36E26E', N'จัดกิจกรรม  PLC ของคณะผู้สอนระดับชั้นตามตารางเพื่อร่วมกันออกแบบกิจกรรมการเรียนรู้ สรุปและติดตามความก้าวหน้าการเรียนรู้ของนักเรียน และร่วมกันแก้ไขปัญหา มีกิจกรรมการออกแบบและกำหนดเวลาของกระบวนการของหน่วยเรียนรู้บูรณาการในรายวิชาพื้นฐาน และกำหนดเวลาของการเรียนรู้แบบฝึกและถอดประสบการณ์ในวิชาเพิ่มเติม มีกิจกรรมความร่วมมือกับสถานประกอบการ หน่วยงานที่รับผิดชอบจัดทำคู่มือการเรียนรู้และนิเทศการฝึกและถอดประสบการณ์ และมีรูปแบบการจัดกิจกรรมการเรียนรู้การเป็นผู้ประกอบการ', N'', 2, 0, CAST(0x0000A5A20115E376 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A20115E376 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'86b37ec9-2e4c-4877-8f9b-04be13e14cc0', N'F8B16B74-FE8C-445C-9DD4-129565554132', N'ด้านกระบวนการจัดทำ และการให้แหล่งเรียนรู้', N'', 2, 0, CAST(0x0000A5A700E73297 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E73297 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'8757752d-a1b3-41f8-9873-356facf5d219', N'9203415F-EF59-4019-A1B3-A98735494164', N'ภาพลักษณ์ของผลงาน รูปแบบหรือนวัตกรรม มีการออกแบบ นำเทคโนโลยีมาจัดการประสิทธิภาพอย่างเหมาะสมและใช้งานได้โดดเด่น เป็นวิธีการที่กลมกลืนเหมาะสมและเป็นมิตรกับธรรมชาติและสิ่งแวดล้อม', N'', 3, 0, CAST(0x0000A5A700E54386 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E54386 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'87662abe-a397-42e8-8595-03a3730d7e87', N'74AEDB5D-6A25-41A3-BAB9-59811FF961EB', N'มีกิจกรรมปฎิบัติจริงตามแผนการทำงาน มีการตรวจสอบ หรือสำรวจ หรือทดลองตามกระบวนการและขั้นตอนเพื่อยืนยันพิสูจน์ความเป็นไปได้ตามหลักความรู้และทฤษฎีความรู้ที่ใช้อธิบายในแต่ละกระบวนการและขั้นตอน หรือบันทึกการแก้ปัญหาที่เปลี่ยนไปจากเดิม และทำการตรวจสอบ หรือทดลองซ้ำหลายครั้งจนเกิดความมั่นใจ มีกิจกรรมการสรุปผลหลักการทำงานของนวัตกรรมได้อย่างครบถ้วนสมบูรณ์ เชื่อมโยงความสัมพันธ์ในเชิงวิชาการและอธิบายการนำไปประยุกต์ใช้ได้ มีกิจกรรมสื่อสาร นำเสนอด้วยวิธีการที่หลากหลาย', N'', 2, 0, CAST(0x0000A5A30099C8CB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A30099C8CB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'89ffbdf9-73f6-464c-a82e-69efdc5fb8c4', N'EADA18F4-4FA4-4C1E-8342-BAF97FCE8A5B', N'ด้านกระบวนการจัดทำ และการให้แหล่งเรียนรู้', N'', 2, 0, CAST(0x0000A5A700E5BC23 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E5BC23 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'8afc3073-833c-407c-af41-69ddcf11f307', N'8B72F43A-DBE9-446B-B132-1631A5B69B08', N'มีเอกสารเครื่องมือและผลการวัดผลการพัฒนาของนักเรียนตามประเภท (K, P, A) และระดับขั้นพฤติกรรม และหลักความรู้ ตรงกับที่ระบุในมาตรฐานการเรียนรู้และตัวชี้วัดรายวิชา มีเอกสารแผนการเลือกตัวชี้วัดรายวิชาที่สำคัญที่เป็นตัวแทน มีเอกสารแสดงรูปแบบการแปลและแสดงผลการประเมินความสมดุลเชิงคุณภาพของนักเรียนรายบุคคล มีเอกสารเครื่องมือและผลการประเมินระดับคุณภาพการเกิดสมรรถนะ และคุณลักษณะ ตลอดจนค่านิยม ๑๒ ประการ และมีเอกสารแสดงการใช้และผลการประเมินบุคลิกภาพของนักเรียนรายบุคคลใช้เป็นข้อมูลเลือกโปรแกรมการเรียน', N'', 3, 0, CAST(0x0000A5A300933A68 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300933A68 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'8c597661-1934-4b3b-9e35-743b9dc3be05', N'BCA8BF4F-CC7C-4AB4-B0AB-610A951B6DCF', N'มีการจัดกิจกรรมการเรียนรู้ร่วมกันของคณะครูระดับชั้นในรายวิชาพื้นฐานตามกรอบบันได ๕ ขั้น แบบ Problem-Based Learning ของคณะครูระดับชั้น และจัดกิจกรรมการฝึกทักษะการสังเกต และตั้งคำถาม คาดเดาคำตอบ จัดกิจกรรมการวิเคราะห์เหตุการณ์การดำเนินชีวิตเพื่อสืบค้นหลักความรู้และหลักธรรมใช้ยึดเป็นหลักการปฏิบัติฝึกการสร้างพัฒนาการด้านคุณลักษณะและค่านิยม ๑๒ ประการ จัดกิจกรรมการสำรวจแหล่งเรียนรู้จริงเพื่อใช้ทักษะการสังเกตสร้างแรงบันดานใจและตั้งคำถามตามประเด็นที่อยากรู้ จัดกิจกรรมอภิปรายแลกเปลี่ยนประเด็นคำถามสื่อสารนำเสนอ จัดกิจกรรมอภิปรายเชื่อมโยงคำถามกับสาระการเรียนรายวิชาสื่อสารนำเสนอ จัดกิจกรรมกำหนดบรรณานุกรมใช้สืบค้นรวบรวมความรู้นำมาแลกเปลี่ยนเรียนรู้และสรุปเป็นองค์ความรู้นำเสนอ และจัดทำผังมโนทัศน์ความรู้', N'', 2, 0, CAST(0x0000A5A20117E303 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A20117E303 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'8f06b0bb-e1ae-4cd0-af99-fdb768c47de8', N'B578BB08-7D88-4AE6-BE30-E7593F15751B', N'มี Portfolios ของนักเรียนรายบุคคล มีเครื่องมือและมีผลการประเมินบุคลิกภาพเหมาะกับกลุ่มอาชีพต่างๆ ของนักเรียนรายบุคคล มีเครื่องมือและมีผลการวัดความถนัดของนักเรียนตามสมรรถนะสาขาอาชีพ มีผลประเมินความถนัดตามสาขาวิชาความถนัดด้านอาชีพ มีการบันทึกผลงานนักเรียนรายบุคคล มีการบันทึกผลทักษะ คุณลักษณะ และความรู้ จากการฝึกและถอดประสบการณ์ของนักเรียนรายบุคคล', N'', 1, 0, CAST(0x0000A5A2010AA662 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300C67383 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'8f3f87e4-1809-43dd-b6ed-799e00a74546', N'0A03DCE8-AB48-4220-9A54-46991F277ACE', N'จัดกิจกรรมการสำรวจความต้องการที่ตรงและสอดคล้องกัน ของสถานประกอบการและกลุ่มอาชีพอิสระ กับนักเรียนและผู้ปกครอง และสถาบันการศึกษาต่อ ที่ดำเนินการร่วมกันจัดทำโครงสร้างเวลาเรียนรายวิชา กำหนดสมรรถนะ คุณลักษณะ และเนื้อหาสาระที่เป็นพื้นฐานด้านสมรรถนะและพื้นฐานทางการศึกษาต่อ หรือพื้นฐานการทำงาน', N'', 2, 0, CAST(0x0000A5A20107053D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A20107053D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'927bf4bd-a9a2-40a8-a2d2-3d4cf45a1cdf', N'74AEDB5D-6A25-41A3-BAB9-59811FF961EB', N'มีเอกสารแผนการทำงาน มีเอกสารการบันทึกผลและอธิบายความเป็นไปได้ทุกกระบวนการและขั้นตอน และมีรูปถ่าย วิดีโอ หรือเอกสารร่องรอยอื่นที่แสดงกิจกรรมการทำงาน การสรุป นำเสนอด้วยวิธีที่หลากหลาย', N'', 3, 0, CAST(0x0000A5A3009A1958 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A3009A195D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'939424e4-f6d8-47de-ba06-1f33461791ff', N'B3F118F3-98DE-434D-A2F7-C3C27E5D7ABE', N'ด้านการออกแบบและการใช้เทคโนโลยี', N'', 3, 0, CAST(0x0000A5A700E4CA90 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E4CA90 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'93a56cea-b6c6-4420-8f09-8f7fc68828f9', N'38FCB207-9232-467E-862F-AF71ED3D83CF', N'กระบวนการและขั้นตอนการผลิตมีการ บูรณาการทฤษฎีความรู้จาก ๘ กลุ่มสาระการเรียนรู้ และความรู้เชิงบูรณาการในศตวรรษที่ ๒๑ ได้อย่างเชื่อมโยงและเหมาะสม', N'', 2, 0, CAST(0x0000A5A3009BF32B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300B20BB7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'96948f03-0fb5-419d-9bd1-d678f97051e9', N'BCA8BF4F-CC7C-4AB4-B0AB-610A951B6DCF', N'มีใบกิจกรรม ใบความรู้ และสื่อเป็นเครื่องมือการจัดการเรียนรู้ ทำให้เกิดกระบวนการสร้างองค์ความรู้ด้วยตนเองของนักเรียน มีแผนการเรียนรู้กำกับช่วงลำดับการจัดกิจกรรมการเรียนรู้แบบ Problem-Based Learning ของคณะครูระดับชั้นตามกรอบบันได ๕ ขั้น มีบันทึก หรือรายงานผลสรุปจากกระบวนการเรียนรู้แบบชุมชนแห่งการเรียนรู้วิชาชีพ (Professional Learning Community: PLC) ของครูระดับชั้น', N'', 1, 0, CAST(0x0000A5A20117036F AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A20117036F AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'993fc983-87e0-4d21-b062-023e6238a3ed', N'8B72F43A-DBE9-446B-B132-1631A5B69B08', N'มีเครื่องมือวัดผลการพัฒนาของนักเรียนตามประเภท (K, P, A) และระดับขั้นพฤติกรรม และหลักความรู้ ตรงกับที่ระบุในมาตรฐานการเรียนรู้และตัวชี้วัดรายวิชา ใช้เป็นคะแนนเก็บครบทุกตัวชี้วัดรายวิชา และมีแผนการเลือกตัวชี้วัดรายวิชาที่สำคัญที่เป็นตัวแทนสร้างเครื่องมือวัดความรู้ที่ตรงกับประเภทและระดับขั้นพฤติกรรมในการวัดผลความรู้กลางภาคเรียน และปลายภาคเรียน มีรูปแบบการแปลและแสดงผลการประเมินความสมดุลเชิงคุณภาพของนักเรียนรายบุคคลด้านความรู้ ด้านทักษะ และด้านเจตนคติ มีเครื่องมือประเมินระดับคุณภาพการเกิดสมรรถนะ และคุณลักษณะตามหลักสูตร ตลอดจนค่านิยม ๑๒ ประการ ในการจัดกิจกรรมทุกกิจกรรมตามกระบวนการ Problem-Based Learning และ Project-Based Learning ตามกรอบบันได ๕ ขั้น มีแบบเครื่องมือประเมินบุคลิกภาพความเหมาะสมต่อลักษณะการประกอบอาชีพของนักเรียน', N'', 1, 0, CAST(0x0000A5A30090AF3B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A30090AF3B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'9af1f6ba-9b23-42e0-80e5-b945ed5c45ff', N'38FCB207-9232-467E-862F-AF71ED3D83CF', N'มีการนำเสนอเผยแพร่การใช้งานนำไปสู่ช่องทางการใช้ประโยชน์ การสร้างงานและพัฒนางานอาชีพของชุมชน สังคม และประเทศชาติ', N'', 4, 0, CAST(0x0000A5A300B4BE39 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300B4BE39 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'9ce80ffd-3506-4c3f-acb9-14ae52d76cd8', N'F8B16B74-FE8C-445C-9DD4-129565554132', N'ด้านการแก้ปัญหาและประโยชน์ใช้', N'', 1, 0, CAST(0x0000A5A700E7103C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E7103C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'9dac559a-7585-47ee-b545-4af71cd1b1fc', N'0381100E-D30D-4698-8F42-C20A4525F20A', N'มีเอกสารหนังสือแสดงการประสานงาน มีเอกสารแสดงผลการเรียนรู้และคำอธิบายรายวิชาที่เป็นไปตามหลักสูตรวิชาชีระยะสั้น หรือหลักสูตรทวิศึกษา หรือหลักสูตรพื้นฐานการศึกษาต่อในสาขาระดับอุดมศึกษา และมีเอกสารคู่มือการเรียนแบบฝึกและถอดประสบการณ์', N'', 3, 0, CAST(0x0000A5A20109EBD3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A20109EBD3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'a416e5de-9ee0-4bc8-a303-fd14b53fb693', N'9253EE4B-9BC1-42D8-81FC-2422F802E0E6', N'มีคลังทะเบียนสถานประกอบการและอาชีพตามบริบทและสภาพแวดล้อมของท้องถิ่น มีสื่อแนะนำรายละเอียดลักษณะงานอาชีพและสมรรถนะตามสาขาวิชาชีพที่มีข้อมูลครบถ้วน ถูกต้อง เป็นปัจจุบันและมีแผนแสดงปริมาณความต้องการสาขาวิชาชีพรองรับการศึกษาต่อสาขาอาชีพ', N'', 1, 0, CAST(0x0000A5A200B9B2A7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300BC5916 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'a422fdb1-cf28-43cb-bdec-66122809c5f3', N'0B11DA4D-367A-41E1-8885-C1A94CE97D7C', N'มีการจัดกิจกรรมสืบค้นแลกเปลี่ยนเรียนรู้เรื่องกระบวนการและขั้นตอนการทำโครงงาน (Project-Based) มีกิจกรรมสร้างแรงบันดานใจตั้งประเด็นสนใจที่จะนำไปสู่การพัฒนาต่อยอดเทคโนโลยี หรือสร้างนวัตกรรม มีกิจกรรมสืบค้น รวบรวมความรู้ที่จะนำมาใช้สร้างกระบวนการและขั้นตอนการพิสูจน์สมมติฐานในประเด็นสนใจ และจัดทำโครงร่าง Project-Based มีกิจกรรมทดสอบ หรือปฏิบัติตามกระบวนการละขั้นตอน และอธิบายผลปรากฎการณ์กับทฤษฎีความรู้ของทุกกระบวนการและขั้นตอน มีกิจกรรมการสรุปผล สื่อสาร นำเสนอด้วยวิธีที่หลากหลาย มีกิจกรรมการกำหนดเกณฑ์คุณภาพของผลงานนักเรียน โดยคณะครูตามกระบวนการ PLC และมีกิจกรรมคัดเลือก หรือประกวดผลงานนักเรียนที่เข้าเกณฑ์คุณภาพ โดยมีการใช้เทคโนโลยีเครือข่ายช่วยนำเสนอและกระจายผลงาน ตลอดจนใช้แลกเปลี่ยนเรียนรู้ร่วมกันอย่างกว้างขวาง', N'', 2, 0, CAST(0x0000A5A2011D4501 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A2011D4501 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'a6e8e6c8-d98c-4166-b52d-a0005ec29ca6', N'EADA18F4-4FA4-4C1E-8342-BAF97FCE8A5B', N'ด้านการแก้ปัญหาและประโยชน์ใช้', N'', 1, 0, CAST(0x0000A5A700E591D9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E591D9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'a7d1ab3f-ec96-4170-9072-2dc7d3edf61b', N'89F43BEF-32D2-4C84-887D-F35047C2159D', N'มีเอกสารคำสั่ง หรือเอกสารอื่นที่แสดงการมอบหมายงาน และเอกสารความต้องการร่วมกัน ที่แสดงถึงประเด็นชื่อเรื่องและรายการข้อมูลในท้องถิ่นที่จะเรียนรู้ร่วมกัน โดยการจัดกิจกรรมความร่วมมือสำรวจความต้องการเรียนรู้แหล่งเรียนรู้ หรือสถานประกอบการในท้องถิ่น', N'', 3, 0, CAST(0x0000A5A200BD14C6 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A200BE37BE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'a9aff62e-9315-4fe7-87eb-ff9508d83a2c', N'5866D846-1F01-443B-B1F5-5B30C5FB3E86', N'ผลงานหรือนวัตกรรมที่สามารถแก้ปัญหาตามวัตถุประสงค์ตอบประโยชน์เพื่อสังคมและใช้งานได้จริง มีความแปลกใหม่ทันสมัยและสร้างสรรค์', N'', 1, 0, CAST(0x0000A5A700E62030 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E62030 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'ae9bdc9a-4154-49aa-ae0e-36d51230f07b', N'0A03DCE8-AB48-4220-9A54-46991F277ACE', N'มีโปรแกรมการเรียนรองรับความต้องการอัตรากำลังแรงงานของสถานประกอบการ และกลุ่มอาชีพอิสระในท้องถิ่น ตรงความต้องการของนักเรียนและผู้ปกครอง', N'', 1, 0, CAST(0x0000A5A200FBCA0D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A200FBCA0D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'b07adf50-c9c1-4107-8888-2701e656ff49', N'497398F8-D74B-4A53-A4AB-20028D3ADDEF', N'มีเอกสาร รูปถ่าย วิดีโอ หรือสิ่งอื่นที่แสดงร่องรอยการเข้าสู่กระบวนการเรียนรู้ในรูปแบบ Problem-Based Learning และ Problem-Based Learning ตามกระบวนการบันได ๕ ขั้น การเรียนรู้ในรูปแบบการเรียนฝึกและถอดประสบการณ์ตามสมรรถนะสาขาวิชาชีพ และมีการเรียนรู้การเป็นผู้ประกอบการ มีเอกสาร Portfolios ที่แสดงระดับผลการเรียนเฉลี่ยในปีการศึกษาดีและมีความสมดุลเชิงคุณภาพ แสดงผลการการเรียนในรายวิชาเพิ่มเติมตามหลักสูตรสมรรถนะสาขาวิชาชีพ และแสดงประสบการณ์การเรียนรู้การเป็นผู้ประกอบการ', N'', 3, 0, CAST(0x0000A5A30094BB66 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A30094BB66 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'b088599b-7cb8-45e1-924f-43738ece3e77', N'44E5EE48-D2A1-4042-BB86-A8D5D62FF9F2', N'มีแผนการเรียนรู้ หรือคู่มือการฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะสาขาวิชาชีพ มีใบกิจกรรม ใบความรู้ และสื่อเป็นเครื่องมือ ทำให้เกิดกระบวนการสร้างองค์ความรู้ด้วยตนเองของนักเรียน', N'', 1, 0, CAST(0x0000A5A2011AD63B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A2011AD63B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'b4e5c60b-8e8c-4921-8f51-d26a204f95ea', N'CE6984E7-28F8-443D-A5A8-AFD0FB9ED4E4', N'มีระบบเทคโนโลยีช่วยการบริหารจัดการสถานศึกษา บริหารงานวิชาการ และจัดทำสารสนเทศคุณภาพผู้เรียน มีระบบเทคโนโลยีสนับสนุนทักษะการเรียนรู้ในศตวรรษที่ ๒๑ เพื่อให้ครูและนักเรียนเข้าถึงองค์ความรู้อย่างรวดเร็วและกว้างขวาง ใช้สืบค้น บันทึกการเรียนการสอน และบันทึกผลงาน เพื่อการแลกเปลี่ยนเรียนรู้ร่วมกัน มีระบบการเรียนรู้ผ่านระบบทางไกลที่โต้ตอบกันได้ มีการจัดระบบเทคโนโลยีจัดทำคลังข้อสอบและการวัดผล ประมวลผลความสมดุลเชิงคุณภาพของผู้เรียนรายบุคคล และเก็บ Portfolios สร้างเส้นทางการศึกษาต่อสู่การประกอบอาชีพของนักเรียนรายบุคคล มีระเบียบการใช้เทคโนโลยี', N'', 1, 0, CAST(0x0000A5A2011231C1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A2011231C1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'b7891545-8301-4b61-8624-2c12417490d5', N'92E3EF1C-2BBF-41F2-A1D3-7F8E2B36E26E', N'มีเอกสารตารางสอนแสดงช่วงเวลาการจัดกิจกรรมบูรณาการ การเรียนแบบฝึกและถอดประสบการ และเอกสารการบันทึกผลการจัดกิจกรรม PLC ของคณะผู้สอนระดับชั้น', N'', 3, 0, CAST(0x0000A5A2011652B7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A2011652B7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'b9c01335-c8d8-49d8-b69b-747a5ff2812b', N'c4db88f5-cc75-4b2d-94e0-699cce37d181', N'เป็นผลงานหรือนวัตกรรมที่สามารถแก้ปัญหาตามวัตถุประสงค์ตอบประโยชน์ความต้องการอัตรากำลังแรงงานในชุมชน ท้องถิ่น และตรงความต้องการของนักเรียนและใช้งานได้จริง มีความแปลกใหม่ ทันสมัยและสร้างสรรค์', N'', 1, 0, CAST(0x0000A5A300F3FE25 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300F3FE25 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'ba44b17b-3f0e-4a9b-9485-920b3a093895', N'0381100E-D30D-4698-8F42-C20A4525F20A', N'มีรายวิชาเพิ่มเติมของโปรแกรมการเรียนจัดสนองความต้องการพัฒนาสมรรถนะของนักเรียนในรูปแบบหลักสูตรวิชาชีพระยะสั้น รูปแบบทวิศึกษา และรูปแบบวิชาชีพตามสมรรถนะสาขาวิชาชีพตามสาขาการศึกษาต่อในระดับอุดมศึกษา และมีผังมโนทัศน์หน่วยเรียนรู้บูรณาการแสดงรูปแบบการจัดพื้นฐานทักษะการเรียนรู้ในศตวรรษที่ ๒๑ ในรายวิชาพื้นฐาน', N'', 1, 0, CAST(0x0000A5A20108B805 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A20108B80A AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'bcc8193b-da4a-42be-9999-501e0bafcba4', N'5866D846-1F01-443B-B1F5-5B30C5FB3E86', N'การนำเสนอเผยแพร่การใช้งานนำไปสู่ช่องทางการใช้ประโยชน์ การสร้างงานและพัฒนางานอาชีพของชุมชน สังคม และประเทศชาติ', N'', 4, 0, CAST(0x0000A5A700E6D778 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E6D779 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'c193aa26-c5db-42f2-95c9-41187e7ef891', N'0862A735-0EFD-47A4-BBC3-2D8DB0EDA76A', N'มีใบรับรองสมรรถนะตามสาขาวิชาชีพ หรือหลักฐานอื่นที่แสดงการฝึกตามเกณฑ์การผ่านหลักสูตรตามสมรรถนะทางสาขาอาชีพ', N'', 1, 0, CAST(0x0000A5A20110ED71 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A20110ED71 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'c4a3beb3-423b-4c57-9b63-49589b495c21', N'3CC36E1B-C572-48EE-9051-418158A056DE', N'มีโครงร่าง Project-Based มีทฤษฎีความรู้หลัก ทฤษฎีความรู้รอง ทฤษฎีความรู้ที่เกี่ยวข้องเขียนอธิบายทุกกระบวนการและขั้นตอนการเกิดสมมติฐาน', N'', 1, 0, CAST(0x0000A5A300983FB5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300983FB5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'c532dfcc-781a-478f-98c3-4b7c834b2b0e', N'B578BB08-7D88-4AE6-BE30-E7593F15751B', N'จัดกิจกรรมการประเมินบุคลิกภาพความเหมาะสมกับกลุ่มอาชีพต่าง ๆ ของนักเรียนมัธยมศึกษาปีที่ ๑ ปีที่ ๓ และปีที่ ๖ จัดกิจกรรมวัดความถนัดตามสมรรถนะสาขาอาชีพ มีการรายงานผลการประเมินบุคลิกภาพ ความถนัด ผลงานนักเรียน ผลการพัฒนาทักษะ คุณลักษณะนักเรียนรายบุคคลอย่างน้อยภาคเรียนละ ๑ ครั้ง มีกระบวนการสร้างความเข้าใจให้กับนักเรียนและผู้ปกครองใช้ผลจากรายงานตัดสินใจเลือกโปรแกรมการเรียนวางเส้นทางการศึกษาต่อและประกอบอาชีพ มีกิจกรรมความร่วมมือกับหน่วยงานของกรมการจัดหางาน หรืหอการค้าจังหวัดจัดกิจกรรมแนะแนวอาชีพตามความต้องการอัตรากำลังแรงงานของจังหวัด', N'', 2, 0, CAST(0x0000A5A2010F41DF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A2010F41DF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'c6250de7-a538-4ed9-94e9-ca830de04920', N'44E5EE48-D2A1-4042-BB86-A8D5D62FF9F2', N'มีการจัดกิจกรรมของคณะครูในรายวิชาเพิ่มเติม ผ่านกระบวนการเรียนรู้แบบชุมชนแห่งการเรียนรู้วิชาชีพ (PLC) จัดทำแผนการเรียนรู้ หรือคู่มือการเรียนรู้แบบฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะสาขาวิชาชีพ หรือการเรียนแบบสะสมหน่วยกิตเพื่อการเรียนเตรียมหลักสูตร ปวช. ในมัธยมศึกษาตอนต้น หรือการเรียนหลักสูตร ปวช.ในชั้นมัธยมศึกษาตอนปลาย หรือหลักสูตรการเตรียมพื้นฐานการเรียนตามสมรรถนะสาขาวิชาชีพในการศึกษาต่อระดับอุดมศึกษา โดยความร่วมมือของสถานประกอบการ ตลอดจนสถาบันการศึกษาต่อ และจัดกิจกรรมการสำรวจสถานประกอบการหรือกลุ่มอาชีพอิสระใช้ทักษะการสังเกตสร้างแรงบันดานใจตั้งประเด็นคำถามและคาดเดาคำตอบนำมาแลกเปลี่ยนเรียนรู้ร่วมกัน จัดกิจกรรมสืบค้นความรู้ตามกระบวนการและขั้นตอนที่คู่มือการเรียนฝึกและถอดประสบการณ์กำหนดไว้ในรูปบรรณานุกรม นำมาแลกเปลี่ยนเรียนรู้และนำเสนอ ใช้เป็นหลักทฤษฎีความรู้นำไปใช้ในขั้นปฏิบัติจริง จัดกิจกรรมฝึกและถอดประสบการณ์เชื่อมโยง กระบวนการและชั้นตอนการปฏิบัติกับการใช้เหตุผลหลัก', N'', 2, 0, CAST(0x0000A5A2011B6E3D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A2011B6E3D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'c792c70e-80d3-44c0-813a-d4da7c471a05', N'B3F118F3-98DE-434D-A2F7-C3C27E5D7ABE', N'ด้านการแก้ปัญหาและประโยชน์ใช้', N'', 1, 0, CAST(0x0000A5A700E47B04 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E47B04 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'c9599360-0962-4654-b86c-d6dc29bc1cac', N'0A03DCE8-AB48-4220-9A54-46991F277ACE', N'มีบันทึกความร่วมมือ หรือเอกสารแสดงการจัดกิจกรรมความต้องการ มีโปรแกรมการเรียนจำแนกตามสมรรถนะสาขาวิชาชีพ และมีหนังสือประสานความร่วมมือจัดทำหลักสูตรรายวิชาในวิชาเพิ่มเติม', N'', 3, 0, CAST(0x0000A5A20107E0CB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A20107E0CB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'c962d40c-cbba-4cfd-8a71-8b202ef9e506', N'A6D0C997-FB04-4C84-9388-32443F283538', N'เป็นผลงานหรือนวัตกรรมที่สามารถแก้ปัญหาตามวัตถุประสงค์ตอบประโยชน์กระบวนการของ Problem-Based Learning และ Project-Based Learning ตามกรอบบันได ๕ ขั้น  ที่ทำงานร่วมกันของคณะครูผู้สอนระดับชั้นแบบชุมชนแห่งการเรียนรู้วิชาชีพ (Professional Learning Community: PLC) ตรงความต้องการของนักเรียนอยากเรียนรู้และใช้งานได้จริง มีความแปลกใหม่ ทันสมัยและสร้างสรรค์', N'', 1, 0, CAST(0x0000A5A700E3848C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E3848D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'd703eaf3-6258-4333-9db7-126a24e20267', N'3CC36E1B-C572-48EE-9051-418158A056DE', N'มีเอกสารโครงร่าง Project-Based มีเอกสารทฤษฎีความรู้เขียนอธิบายทุกกระบวนการและขั้นตอนการเกิดสมมติฐานสอดคล้องกับการแก้ปัญหา สามารถนำไปใช้ได้จริง และมีร่องรอยหลักฐานที่แสดงการทำงานร่วมกันในการออกแบบนวัตกรรม', N'', 3, 0, CAST(0x0000A5A30098BAED AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A30098BAED AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'd75eac0b-3571-4fb3-b36b-9c0cac4bfd56', N'5212325D-A9B9-49CA-92D4-8E1FA6ACDD3A', N'จัดกิจกรรมการสำรวจสำรวจความต้องการที่จะเรียนรู้จากแหล่งเรียนรู้ในท้องถิ่นที่ใช้เป็นสถานการณ์กระตุ้นเพื่อกำหนดประเด็นชื่อเรื่องร่วมกันของคณะผู้สอนระดับชั้นและนักเรียน มีกิจกรรมการวิเคราะห์สัดส่วนเวลาและน้ำหนักคะแนนของมาตรฐานการเรียนรู้และตัวชี้วัดรายวิชา กำหนดเป็นด้านการวัดความรู้ ทักษะ และเจตนคติ และระบุคำสำคัญที่เป็นหลักความรู้ เพื่อนำไปเทียบและบูรณาการตามประเด็นชื่อเรื่องหลัก ชื่อเรื่องรอง และชื่อเรื่องย่อย แบบคณะผู้สอนและข้ามรายวิชา', N'', 2, 0, CAST(0x0000A5A201142706 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A201142706 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'dadcbc2f-7d26-4063-996f-b3ce788bbb0a', N'5212325D-A9B9-49CA-92D4-8E1FA6ACDD3A', N'มีเอกสารผังมโนทัศน์หน่วยเรียนรู้บูรณาการ เอกสารตารางการวิเคราะห์ตัวชีวัดรายวิชา รูปถ่าย หรือหลักฐานอื่นที่แสดงร่องรอยการปฏิบัติการสำรวจจริง', N'', 3, 0, CAST(0x0000A5A201147E47 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A201147E47 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'e6625304-5dec-4bc1-8c00-3c0f9d8c939e', N'3CC36E1B-C572-48EE-9051-418158A056DE', N'มีกิจกรรมร่วมกันออกแบบนวัตกรรม โดยการอภิปรายแลกเปลี่ยนประเด็นความรู้และร่วมกันสร้างกระบวนการและขั้นตอนที่มีการเขียนกำกับด้วยคำอธิบายของทฤษฎีความรู้ที่เกี่ยวข้องทุกกระบวนการและขั้นตอนการเกิดสมมติฐานสอดคล้องกับการแก้ปัญหา สามารถนำไปใช้ได้จริง', N'', 2, 0, CAST(0x0000A5A300988538 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300988538 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'e6eabdaa-d838-450b-bc30-3e2784e0a3c4', N'C37D56F0-0AEB-4D31-AD21-C9A98CC497FC', N'หลักความรู้และทฤษฎีความรู้ได้มาจากการสืบค้น รวบรวมความรู้ด้วยวิธีที่หลากหลาย มีการแลกเปลี่ยนประเด็นความรู้และกำหนดวิธีการให้เหตุผลเชื่อมโยงเกี่ยวข้องกันของประเด็นปัญหาหรือประเด็นสนใจกับทฤษฎีความรู้หลัก ทฤษฎีความรู้รอง และทฤษฎีความรู้ที่เกี่ยวข้องของคณะผู้ทำผลงาน', N'', 2, 0, CAST(0x0000A5A300978E5E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300978E5E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'ea9ee2c6-3050-4c85-bc5a-41309ad02ce0', N'74AEDB5D-6A25-41A3-BAB9-59811FF961EB', N'มีแผนการทำงานกำหนดช่วงเวลาการปฎิบัติ กำหนดสถานที่ วัสดุอุปกรณ์การทำงานให้สอดคล้องกับกระบวนการและขั้นตอนการปฏิบัติ และมีบันทึกผลและอธิบายผลการตรวจสอบ หรือสำรวจ หรือทดลองตามกระบวนการและขั้นตอนการเกิดสมมติฐาน', N'', 1, 0, CAST(0x0000A5A3009905B5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A3009905B5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'eac852f1-5422-4d6f-a652-2112c7cc76e4', N'CDE93640-2923-4FC2-A65E-C0ED309ADA33', N'มีคู่มือการเรียนรู้การเป็นผู้ประกอบการ หรือมีใบกิจกรรม ใบความรู้ เป็นเครื่องมือประกอบการจัดการเรียนรู้นำไปสู่การเกิดกระบวนการสร้างองค์ความรู้และเรียนรู้การเป็นผู้ประกอบการของคณะนักเรียนที่มีความสนใจเหมือนกัน', N'', 1, 0, CAST(0x0000A5A3008E334B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A3008E334F AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'f540dd7b-f71a-4102-9467-47f9cdd0fa27', N'D081A4FB-2269-4D70-B6BB-33A730B11585', N'ประเด็นปัญหาหรือประเด็นสนใจเกิดจากความต้องการต่อยอดพัฒนากระบวนการผลิต หรือพัฒนาผลิตภัณฑ์จากการเรียนรู้แบบฝึกและถอดประสบการณ์ตามสมรรถนะสาขาวิชาชีพของนักเรียน หรือเกิดจากประเด็นความต้องการพัฒนานวัตกรรมขึ้นใช้งานในวิถีการดำเนินชีวิต และคณะผู้ทำผลงานเกิดจากปัญหาและประเด็นสนใจที่เป็นเรื่องเดียวกัน', N'', 2, 0, CAST(0x0000A5A30095FDA2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A30095FDA2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'f5ce8f0f-fe12-48ec-a50f-ffd8dc78a527', N'B578BB08-7D88-4AE6-BE30-E7593F15751B', N'มีเอกสาร Portfolios ของนักเรียนรายบุคคล และแสดงผลบุคลิกภาพ ความถนัด ทักษะ คุณลักษณะ และผลงาน มีเอกสารความร่วมมือและประสานงานการแนะแนวอาชีพ', N'', 3, 0, CAST(0x0000A5A201100564 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A201100564 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'f9a4e08a-c292-493b-9299-f9c64cbb8086', N'EADA18F4-4FA4-4C1E-8342-BAF97FCE8A5B', N'ด้านการออกแบบและการใช้เทคโนโลยี', N'', 3, 0, CAST(0x0000A5A700E5E2C5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E5E2C5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'fba49914-1fa6-4ca5-a2bf-bc9a6164003b', N'A6D0C997-FB04-4C84-9388-32443F283538', N'กระบวนการและขั้นตอนการผลิตมีการบูรณาการสร้างเครือข่ายความร่วมมือกันทุกภาคส่วน สร้างกระบวนการให้เกิดสมรรถนะทางสาขาวิชาชีพ กระบวนการเรียนรู้แหล่งเรียนรู้ในชุมชนได้อย่างเชื่อมโยงและเหมาะสม', N'', 2, 0, CAST(0x0000A5A700E3D057 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A700E3D057 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

INSERT [dbo].[Education21Indicator] ([Education21IndicatorID], [Education21StandardID], [Education21IndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'ffb04e0e-5ae2-4865-906e-dafb30c32c18', N'0381100E-D30D-4698-8F42-C20A4525F20A', N'จัดกิจกรรมการสำรวจความต้องการเข้าสู่สาขาวิชาชีพของนักเรียนรายบุคคลในการจำแนกนักเรียนที่ไม่ต้องการศึกษาต่อ นักเรียนที่ต้องการได้วุฒิประกาศนียบัตรวิชาชีพ และนักเรียนที่ต้องการศึกษาต่อในสาขาวิชาชีพระดับอุดมศึกษา ที่มีกิจกรรมความร่วมมือกับศูนย์พัฒนาฝีมือแรงงาน หรือวิทยาลัยสังกัดสำนักงานคณะกรรมการการอาชีวศึกษา สถาบันอุดมศึกษา สถานประกอบการ หรือหน่วยงานที่เกี่ยวข้อง จัดทำหลักสูตรในรายวิชาเพิ่มเติม และใช้สถานประกอบการเป็นทีฝึกและถอดประสบการณ์ให้กับนักเรียน', N'', 2, 0, CAST(0x0000A5A201096126 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A201096126 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

End
Go
If Not Exists(Select * From Education21Criterion)
Begin
	INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'0280db82-3e1d-47cd-92ca-144f81f3fdd8', N'8afc3073-833c-407c-af41-69ddcf11f307', N'มีเอกสารเครื่องมือและผลการวัดผลการพัฒนาของนักเรียนตามประเภท (K, P, A) และระดับขั้นพฤติกรรม และหลักความรู้ ตรงกับที่ระบุในมาตรฐานการเรียนรู้และตัวชี้วัดรายวิชา มีร่องรอยหลักฐานแสดงการวิเคราะห์มาตรฐานการเรียนรู้และตัวชี้วัดรายวิชา  มีเอกสารแผนการเลือกตัวชี้วัดรายวิชาที่สำคัญที่เป็นตัวแทน มีเอกสารแสดงรูปแบบการแปลและแสดงผลการประเมินความสมดุลเชิงคุณภาพของนักเรียนรายบุคคล มีเอกสารเครื่องมือและผลการประเมินระดับคุณภาพการเกิดสมรรถนะ และคุณลักษณะ ตลอดจนค่านิยม ๑๒ ประการ และมีเอกสารแสดงการใช้และผลการประเมินบุคลิกภาพของนักเรียน', 10, 3, CAST(0x0000A5A3009339D8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'02cadefc-80f8-47fd-8e1b-67f6f81cdbdd', N'96948f03-0fb5-419d-9bd1-d678f97051e9', N'มีใบกิจกรรม ใบความรู้ของกิจกรรมตามกรอบบันได ๕ ขั้น แบบ Problem-Based Learning ของคณะครูระดับชั้น มีเอกสารแสดงการบันทึกผลสรุปจากกระบวนการเรียนรู้แบบชุมชนแห่งการเรียนรู้วิชาชีพ (Professional Learning Community: PLC) ของครูระดับชั้นที่แสดงรูปแบบการจัดกิจกรรม การพัฒนาการความก้าวหน้าของนักเรียนและแก้ไขปัญหา ไม่ครบทุกกิจกรรม มีเอกสารแสดงร่องรอยการทำกิจกรรมของนักเรียนไม่ครบทุกกิจกรรม', 10, 2, CAST(0x0000A5A2011702F4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'037873ce-493c-48c9-a30d-9c209b96c0cf', N'e6eabdaa-d838-450b-bc30-3e2784e0a3c4', N'มีเอกสารการเรียบเรียงหลักความรู้และทฤษฎีความรู้ หรือผังมโนทัศน์ ยังขาดบรรณานุกรมความรู้บางส่วนที่แสดงความเชื่อถือได้ของทฤษฎีความรู้', 6, 2, CAST(0x0000A5A300978D44 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'03836da7-f9be-4304-a156-490be9d5d6e0', N'60c83e52-8b84-445f-9063-09f4bb98b57b', N'-', 0, 1, CAST(0x0000A5A700E75838 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'04fa8b2c-e82c-4c76-89e0-56e0d78506c4', N'0ebed82d-8c45-45bb-8145-7723a7ba254f', N'มีผังมโนทัศน์แสดงหน่วยเรียนรู้บูรณาการ  มีกิจกรรมการสำรวจแหล่งเรียนรู้ร่วมกันระหว่างครูกับนักเรียน มีกิจกรรมการจัดทำหน่วยเรียนรู้บูรณาการระดับชั้น มีจำนวนน้อยกว่า ๕ วิชา และมีเอกสารตารางวิเคราะห์มาตรฐานการเรียนรู้และตัวชี้วัด รูปถ่าย หรือหลักฐานอื่นที่แสดงร่องรอยการปฏิบัติการสำรวจจริงเป็นหลักฐาน', 5, 2, CAST(0x0000A5A20113B158 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'059e32d3-221a-48dd-9c65-c637fc12d74a', N'd703eaf3-6258-4333-9db7-126a24e20267', N'มีเอกสารโครงร่าง Project-Based มีเอกสารทฤษฎีความรู้เขียนอธิบายทุกกระบวนการและขั้นตอนการเกิดสมมติฐานสอดคล้องกับการแก้ปัญหา สามารถนำไปใช้ได้จริง และมีร่องรอยหลักฐานที่แสดงการทำงานร่วมกันในการออกแบบนวัตกรรม', 10, 3, CAST(0x0000A5A30098BA70 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'066cc878-0da6-47e2-90d5-d0ac0a958ee7', N'8f3f87e4-1809-43dd-b6ed-799e00a74546', N'มีโปรแกรมการเรียนและโครงสร้างหลักสูตรตามสมรรถนะทางสาขาวิชาชีพ ตรงความต้องการอัตรากำลังแรงงาน และตรงกับความต้องการของนักเรียน ที่มีการจัดกิจกรรมสำรวจความต้องการ กิจกรรมความร่วมมือการจัดทำหลักสูตร และมีบันทึกความร่วมมือ หรือเอกสารแสดงการจัดกิจกรรมความต้องการ มีหนังสือการประสานงานเป็นหลักฐาน', 20, 3, CAST(0x0000A5A20107046C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'068e14cc-70c9-4492-affa-9dfc2f232ff3', N'8757752d-a1b3-41f8-9873-356facf5d219', N'-', 2, 2, CAST(0x0000A5A700E54304 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'086e27f1-2288-4277-baf9-409a72d441f5', N'48038dcf-9986-4adc-a99e-8d9236d82ea1', N'มีระดับผลการเรียนเฉลี่ยน้อยกว่า ๒.๕๐ ในรายวิชาเพิ่มเติมเฉลี่ยน้อยกว่า ๓.๐๐ มีเอกสารการเข้าร่วมการเรียนรู้การเป็นผู้ประกอบการไม่ชัดเจน', 5, 1, CAST(0x0000A5A300946254 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'08947bc7-102a-4ca3-af95-911f6702e725', N'0811dab9-ef23-4d7f-97da-bd273830636f', N'มี', 3, 2, CAST(0x0000A5A300F44EF8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'08f32431-7f6b-4e55-a74b-98248bf1e8a6', N'85cf52b4-0e46-499b-96e9-e20f2402b044', N'มีเอกสารแต่การแสดงที่มาของปัญหาหรือประเด็นสนใจและประโยชน์ที่จะเกิดขึ้นยังไม่ชัดเจน และมีร่องรอยหลักฐานต่าง ๆ ไม่ครบสมบูรณ์ที่แสดงถึงความต้องการต่อยอดพัฒนากระบวนการผลิต หรือพัฒนาผลิตภัณฑ์ หรือพัฒนานวัตกรรม', 6, 2, CAST(0x0000A5A30096684C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'0d17a2d8-11da-4300-b19d-ac0f362d376b', N'2fc2d6af-4bea-4552-a7c8-179a9c2fd911', N'มีตารางสอนแสดงช่วงเวลาของกิจกรรมตามกระบวนการของหน่วยเรียนรู้บูรณาการ การทำกิจกรรม PLC กระบวนการเรียนแบบฝึกและถอดประสบการณ์ และกระบวนการเรียนรู้รูปแบบการเรียนรู้เป็นผู้ประกอบการ และมีเอกสารตารางสอน', 3, 2, CAST(0x0000A5A201154F04 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'0f249578-fd9c-4eeb-b0e1-bb399af0d36d', N'282b01c9-9ac6-4923-b94b-3f4cee8f8dd7', N'มีระบบเทคโนโลยีช่วยการสนับสนุนการบริหารจัดการ การจัดกระบวนการเรียนรู้ และการเรียนรู้ของนักเรียน ที่มีการกำหนดในรูปกิจกรรมการเข้าไปใช้งานบางระยะเวลา ขาดเอกสารตารางการใช้และจำนวนปริมาณผู้ใช้ต่อเนื่องทุกวันทำการ    มีเอกสารระเบียบการใช้เทคโนโลยีของโรงเรียน', 8, 2, CAST(0x0000A5A20113238C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'0f91ae66-cf42-4899-9490-c8f4cf6bc04b', N'b9c01335-c8d8-49d8-b69b-747a5ff2812b', N'ไม่มี', 0, 1, CAST(0x0000A5A300F3FE1C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'0fc80104-a09e-4464-a66d-22c64e86a67e', N'4d6bcb37-1a96-4a90-9b54-09e3782a97d6', N'มีระบบเทคโนโลยีช่วยการสนับสนุนการบริหารจัดการ การจัดกระบวนการเรียนรู้ และการเรียนรู้ของนักเรียน ที่มีการกำหนดในรูปกิจกรรมการเข้าไปใช้งานตลอดทั้งปีการศึกษา และมีเอกสารตารางการใช้และจำนวนปริมาณผู้ใช้ต่อเนื่องทุกวันทำการ    มีเอกสารระเบียบการใช้เทคโนโลยีของโรงเรียนและมีกิจกรรมการพัฒนาจริยธรรมการใช้ ICT ตามแนวทางของระเบียบ', 15, 3, CAST(0x0000A5A201128D8C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'0fcffeb9-a77e-4783-aeaf-6b9ca5ff0312', N'ae9bdc9a-4154-49aa-ae0e-36d51230f07b', N'มีโปรแกรมการเรียนและโครงสร้างหลักสูตรตามสมรรถนะทางสาขาวิชาชีพ ตรงความต้องการอัตรากำลังแรงงาน และตรงกับความต้องการของนักเรียน ที่มีการจัดกิจกรรมสำรวจความต้องการ กิจกรรมความร่วมมือการจัดทำหลักสูตร แต่ยังขาดเอกสารความร่วมมือเป็นหลักฐาน', 15, 2, CAST(0x0000A5A200FBC9D0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'11da63e1-b5ff-44c7-850c-463a1712ad80', N'5865fd39-f2f9-43b8-ad41-2b1d01441565', N'-', 0, 1, CAST(0x0000A5A700E4F6D8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'13c905bd-3e99-4170-b77f-3fd6d0f42447', N'c792c70e-80d3-44c0-813a-d4da7c471a05', N'-', 0, 1, CAST(0x0000A5A700E47AA0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'14f317ba-e5f0-4a2c-b397-414bd8deb25f', N'76388d62-cb26-421c-a473-8ca9ea949d9d', N'มีการออกแบบใช้งานได้ ใช้วัสดุอุปกรณ์ และวิธีการผลิตยังต้องมีการปรับแก้ไขบางส่วน', 3, 1, CAST(0x0000A5A300B3DAF8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'1531701d-d396-4fa9-98e5-8d561ea98bed', N'939424e4-f6d8-47de-ba06-1f33461791ff', N'-', 0, 1, CAST(0x0000A5A700E4CA50 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'166ccf30-5fb1-46ab-8096-81b7afd76ea9', N'c6250de7-a538-4ed9-94e9-ca830de04920', N'ยังไม่ได้จัดกิจกรรมการเรียนรู้แบบฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะวิชาชีพ ของคณะครูในรายวิชาเพิ่มเติม ผ่านกระบวนการเรียนรู้แบบชุมชนแห่งการเรียนรู้วิชาชีพ (Professional Learning Community: PLC)', 5, 1, CAST(0x0000A5A2011B6DD0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'17cbebcd-7af0-4f0c-872a-2022c786db5e', N'79aa2bfa-0f3d-457a-ba4b-e683e67d37ff', N'มีเอกสารการเรียบเรียงหลักความรู้และทฤษฎีความรู้ หรือผังมโนทัศน์ ยังขาดบรรณานุกรมความรู้ที่แสดงความเชื่อถือได้ของทฤษฎีความรู้', 3, 1, CAST(0x0000A5A30097CC8C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'19eb8533-8e45-4eac-81bc-b6b198e8a4ed', N'a6e8e6c8-d98c-4166-b52d-a0005ec29ca6', N'-', 3, 2, CAST(0x0000A5A700E59188 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'1a93b2ed-9fbd-4c82-8237-7b5fae24c406', N'0ebed82d-8c45-45bb-8145-7723a7ba254f', N'ยังไม่ได้จัดทำผังมโนทัศน์แสดงหน่วยเรียนรู้บูรณาการ ยังไม่มีกระบวนการจัดทำ', 3, 1, CAST(0x0000A5A20113B158 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'1c20bc09-dc30-4b89-a0ae-2d5b296c669f', N'ffb04e0e-5ae2-4865-906e-dafb30c32c18', N'มีการจัดรูปแบบการพัฒนาสมรรถนะทางสาขาวิชาชีพให้กับนักเรียนในวิชาเพิ่มเติมยังไม่ชัดเจน ไม่เป็นรูปธรรม', 10, 1, CAST(0x0000A5A20109611C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'1c33a9e5-b101-4003-9c53-6d1632008735', N'f540dd7b-f71a-4102-9467-47f9cdd0fa27', N'มีเอกสารแสดงที่มาของปัญหาหรือประเด็นสนใจและประโยชน์ที่จะเกิดขึ้น และมีร่องรอยหลักฐานต่าง ๆ ที่แสดงถึงความต้องการต่อยอดพัฒนากระบวนการผลิต หรือพัฒนาผลิตภัณฑ์ หรือพัฒนานวัตกรรม', 10, 3, CAST(0x0000A5A30095FC7C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'1f372c7b-7f32-4d36-98d0-2e5e643c7935', N'4e0ce081-d759-4113-882e-71f1d241ee12', N'มีเอกสารแสดงที่มาของปัญหาหรือประเด็นสนใจและประโยชน์ที่จะเกิดขึ้น และมีร่องรอยหลักฐานต่าง ๆ ที่แสดงถึงความต้องการต่อยอดพัฒนากระบวนการผลิต หรือพัฒนาผลิตภัณฑ์ หรือพัฒนานวัตกรรม', 10, 3, CAST(0x0000A5A3009590AC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'20825421-ba18-4884-899a-ce409e0fe43b', N'eac852f1-5422-4d6f-a652-2112c7cc76e4', N'มีคู่มือ หรือใบกิจกรรม ใบความรู้ เป็นเครื่องมือประกอบการจัดการเรียนรู้ มีเอกสารแสดงร่องรอยการจัดกิจกรรมการจดทะเบียนบริษัทจำลอง กิจกรรมการนำเข้าวัตถุดิบ การผลิต แปรรูป บรรจุภัณฑ์ จัดจำหน่าย และบัญชีรายรับรายจ่าย ครบและชัดเจน', 10, 3, CAST(0x0000A5A3008E3320 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'22dcda0f-0f87-44d5-bde8-d9472e8b4373', N'b4e5c60b-8e8c-4921-8f51-d26a204f95ea', N'การจัดระบบกานำเทคโนโลยียังไม่ต่อเชื่อมเป็นระบบ ไม่มีการพัฒนาต่อยอดให้เป็นรูปธรรม', 8, 1, CAST(0x0000A5A2011230F8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'236cb68f-8a65-4bf8-b061-465543f8aca7', N'2fc2d6af-4bea-4552-a7c8-179a9c2fd911', N'มีตารางสอนแสดงช่วงเวลาของกิจกรรมตามกระบวนการของหน่วยเรียนรู้บูรณาการ การทำกิจกรรม PLC กระบวนการเรียนแบบฝึกและถอดประสบการณ์ และกระบวนการเรียนรู้รูปแบบการเรียนรู้เป็นผู้ประกอบการ ที่มีกิจกรรมการออกแบบและกำหนดเวลาตามกระบวนการในรายวิชาพื้นฐาน รายวิชาเพิ่มเติม และรายวิชากิจกรรมชุมชุม และมีเอกสารตารางสอน เอกสารบันทึกผลหารจัดกิจกรรม PLC เป็นหลักฐาน', 5, 3, CAST(0x0000A5A201154F04 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'252ce7b7-b669-4215-9749-f432bed97b71', N'93a56cea-b6c6-4420-8f09-8f7fc68828f9', N'มีการบูรณาการทฤษฎีความรู้จาก ๘ กลุ่มสาระการเรียนรู้ และความรู้เชิงบูรณาการในศตวรรษที่ ๒๑ ได้อย่างเชื่อมโยงและเหมาะสม', 5, 3, CAST(0x0000A5A300B20AE8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'26e758bd-d33d-4335-9666-e0deb2b19b60', N'6a821855-e867-4b9b-bba4-e2390103066b', N'มีเอกสารใบกิจกรรม ใบความรู้ และสื่อใช้เป็นเครื่องมือจัดการเรียนรู้ มีแผนและบันทึกผลการให้คำปรึกษาการทำผลงาน มีเอกสารร่องรอยการจัดกิจกรรมการคัดเลือกหรือประกวดผลงานนักเรียนที่ผ่านเกณฑ์คุณภาพ', 10, 2, CAST(0x0000A5A2011C77D4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'27980ac6-b6e4-48c0-ba05-f1cbc52b4395', N'dadcbc2f-7d26-4063-996f-b3ce788bbb0a', N'มีผังมโนทัศน์แสดงหน่วยเรียนรู้บูรณาการ  มีกิจกรรมการสำรวจแหล่งเรียนรู้ร่วมกันระหว่างครูกับนักเรียน มีกิจกรรมการจัดทำหน่วยเรียนรู้บูรณาการระดับชั้นแบบไม่แยกส่วนมีจำนวนมากกว่า ๕ วิชา และมีเอกสารตารางวิเคราะห์มาตรฐานการเรียนรู้และตัวชี้วัด  รูปถ่าย หรือหลักฐานอื่นที่แสดงร่องรอยการปฏิบัติการสำรวจจริงเป็นหลักฐาน', 10, 3, CAST(0x0000A5A201147D40 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'2a7f2e08-dd70-4a16-a883-2f851ebf6ec7', N'1b9a6618-ece6-4134-9b64-4b7af263ebd0', N'มีเอกสารการเรียบเรียงหลักความรู้และทฤษฎีความรู้ หรือผังมโนทัศน์ มีบรรณานุกรมความรู้แสดงความเชื่อถือได้และเป็นสากลของทฤษฎีความรู้ และมีแผนการสืบค้นความรู้หรือร่องรอยหลักฐานอื่น ที่แสดงถึงการทำงานให้ได้กรอบทฤษฎีความรู้ของคณะผู้ทำผลงาน', 10, 3, CAST(0x0000A5A300970D88 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'2beb749b-885f-4a4c-974f-2923e8edc803', N'a422fdb1-cf28-43cb-bdec-66122809c5f3', N'มีเอกสารใบกิจกรรม ใบความรู้ และสื่อใช้เป็นเครื่องมือจัดการเรียนรู้ มีแผนและบันทึกผลการให้คำปรึกษาการทำผลงาน มีเอกสารร่องรอยการจัดกิจกรรมการสืบค้นแลกเปลี่ยนเรียนรู้ กิจกรรมสร้างแรงบันดานใจตั้งประเด็นสนใจพัฒนานวัตกรรม กิจกรรมการปฏิบัติตามกระบวนการละขั้นตอน และอธิบายผลปรากฎการณ์กับทฤษฎีความรู้ กิจกรรมการสรุปผล สื่อสาร นำเสนอด้วยวิธีที่หลากหลาย และกิจกรรมการคัดเลือกหรือประกวดผลงานนักเรียนที่ผ่านเกณฑ์คุณภาพ', 15, 3, CAST(0x0000A5A2011D44E8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'2ce98707-bb71-4799-a9d6-e0db7e2ad81e', N'ea9ee2c6-3050-4c85-bc5a-41309ad02ce0', N'มีเอกสารแผนการทำงานขาดความสมบูรณ์ มีเอกสารการบันทึกผลและอธิบายความเป็นไปได้ไม่ครบทุกกระบวนการและขั้นตอน ขาดร่องรอยหลักฐานมีที่แสดงกิจกรรมการทำงาน การสรุป และการนำเสนอด้วยวิธีที่หลากหลาย', 3, 1, CAST(0x0000A5A300990570 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'2cfc0da1-582a-4946-b45c-17fd3e791a0b', N'53dfd0b2-7aa4-41c6-9878-fd12ef69cb2f', N'มีระดับผลการเรียนเฉลี่ยตั้งแต่ ๒.๕๐ ขึ้นไป และมีกราฟหรือเอกสารอื่นที่แสดงทิศทางระดับผลการเรียนด้านความรู้ ด้านทักษะ และด้านเจตนคติที่สอดคล้องดีขึ้นทิศทางเดียวกัน มีระดับผลการการเรียนเฉลี่ยในรายวิชาเพิ่มเติมตามหลักสูตรสมรรถนะสาขาวิชาชีพตั้งแต่ ๓.๐๐ ขึ้นไป', 7, 2, CAST(0x0000A5A30093E61C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'2d908741-f8da-4b88-a340-3fca2c2ecd05', N'2a726295-1717-4e2e-b6c9-c8f691a25d4d', N'มีคลังทะเบียน มีสื่อแนะนำรายละเอียด และมีแผนความต้องการ ที่มีข้อมูลถูกต้อง และจัดทำขึ้นโดยความร่วมมือจากทุกภาคส่วน', 3, 2, CAST(0x0000A5A300C04C20 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'2e4c7549-a64b-498d-9802-b0da191bf09a', N'e6eabdaa-d838-450b-bc30-3e2784e0a3c4', N'มีเอกสารการเรียบเรียงหลักความรู้และทฤษฎีความรู้ หรือผังมโนทัศน์ ยังขาดบรรณานุกรมความรู้ที่แสดงความเชื่อถือได้ของทฤษฎีความรู้', 3, 1, CAST(0x0000A5A300978D44 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'2e8907de-1740-4d01-981f-24096aedecb2', N'5ab2630b-47ec-453a-8777-ef94a4bd6f21', N'มีเอกสารใบกิจกรรม ใบความรู้ และสื่อใช้เป็นเครื่องมือจัดการเรียนรู้ มีแผนและบันทึกผลการให้คำปรึกษาการทำผลงาน มีเอกสารร่องรอยการจัดกิจกรรมการสืบค้นแลกเปลี่ยนเรียนรู้ กิจกรรมสร้างแรงบันดานใจตั้งประเด็นสนใจพัฒนานวัตกรรม กิจกรรมการปฏิบัติตามกระบวนการละขั้นตอน และอธิบายผลปรากฎการณ์กับทฤษฎีความรู้ กิจกรรมการสรุปผล สื่อสาร นำเสนอด้วยวิธีที่หลากหลาย และกิจกรรมการคัดเลือกหรือประกวดผลงานนักเรียนที่ผ่านเกณฑ์คุณภาพ', 15, 3, CAST(0x0000A5A2011E4C94 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'300696e4-4e7e-4d20-b2ea-0298782c9b46', N'712a9a61-f2be-434a-8b24-e5451133347e', N'มีคลังทะเบียนแหล่งเรียนรู้ และมีการจัดกิจกรรม ยังไม่ชัดเจน ไม่เป็นรูปธรรม', 1, 1, CAST(0x0000A5A200BD8724 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'30c8255c-a5b9-45d6-85a0-50228a4fb86e', N'f540dd7b-f71a-4102-9467-47f9cdd0fa27', N'มีเอกสารแต่การแสดงที่มาของปัญหาหรือประเด็นสนใจและประโยชน์ที่จะเกิดขึ้นยังไม่ชัดเจน และมีร่องรอยหลักฐานต่าง ๆ ไม่ครบสมบูรณ์ที่แสดงถึงความต้องการต่อยอดพัฒนากระบวนการผลิต หรือพัฒนาผลิตภัณฑ์ หรือพัฒนานวัตกรรม', 6, 2, CAST(0x0000A5A30095FC7C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'30e84d79-6278-460d-948b-7dfeca5c607b', N'8f06b0bb-e1ae-4cd0-af99-fdb768c47de8', N'มี Portfolios มีเครื่องมือและผลการวัดและประเมินบุคลิกภาพ ความถนัด ทักษะ คุณลักษณะ และผลงานของนักเรียนรายบุคคล มีการจัดกิจกรรมสร้างความเข้าใจใช้รายงานผลจาก Portfolios ให้นักเรียนและผู้ปกครองเลือกโปรแกรมการเรียน มีกิจกรรมความร่วมมือกับหน่วยงานที่เกี่ยวข้องแนะแนวอาชีพตามความต้องการอัตรากำลังแรงงานของจังหวัด และมีเอกสาร Portfolios เอกสารรายงานผลบุคลิกภาพ ความถนัด ทักษะ คุณลักษณะ และผลงานเป็นหลักฐาน', 5, 3, CAST(0x0000A5A300C67320 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'31ae6b8e-3324-4275-892f-d930cb4a3b0d', N'5f6ee31e-6f4b-41e1-bfdd-e9a4f760dfcf', N'สามารถแก้ปัญหาตามวัตถุประสงค์ตอบประโยชน์เพื่อสังคมได้น้อยและใช้งานได้', 6, 2, CAST(0x0000A5A3009B346C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'32d7dba4-8436-4248-b6e3-6ea09d12b45f', N'dadcbc2f-7d26-4063-996f-b3ce788bbb0a', N'มีผังมโนทัศน์แสดงหน่วยเรียนรู้บูรณาการ  มีกิจกรรมการสำรวจแหล่งเรียนรู้ร่วมกันระหว่างครูกับนักเรียน มีกิจกรรมการจัดทำหน่วยเรียนรู้บูรณาการระดับชั้น มีจำนวนน้อยกว่า ๕ วิชา และมีเอกสารตารางวิเคราะห์มาตรฐานการเรียนรู้และตัวชี้วัด รูปถ่าย หรือหลักฐานอื่นที่แสดงร่องรอยการปฏิบัติการสำรวจจริงเป็นหลักฐาน', 5, 2, CAST(0x0000A5A201147D40 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'32db8e78-c56b-42ba-84b3-54e1b11bb59a', N'b07adf50-c9c1-4107-8888-2701e656ff49', N'มีระดับผลการเรียนเฉลี่ยน้อยกว่า ๒.๕๐ ในรายวิชาเพิ่มเติมเฉลี่ยน้อยกว่า ๓.๐๐ มีเอกสารการเข้าร่วมการเรียนรู้การเป็นผู้ประกอบการไม่ชัดเจน', 5, 1, CAST(0x0000A5A30094BB64 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'346991f3-dba2-46c3-ac86-7dfd6116f0a9', N'fba49914-1fa6-4ca5-a2bf-bc9a6164003b', N'-', 0, 1, CAST(0x0000A5A700E3CF88 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'35f6af79-18ea-41d6-8ae5-2cb3e73d7d9f', N'bcc8193b-da4a-42be-9999-501e0bafcba4', N'-', 2, 2, CAST(0x0000A5A700E6D750 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'36c4f488-5d47-4d1b-a01e-746aaa762fea', N'2a4c794b-cce5-4e31-9483-e30dd78dc8e7', N'มีใบกิจกรรม ใบความรู้ของกิจกรรมตามกรอบบันได ๕ ขั้น แบบ Problem-Based Learning ของคณะครูระดับชั้น มีเอกสารแสดงการบันทึกผลสรุปจากกระบวนการเรียนรู้แบบชุมชนแห่งการเรียนรู้วิชาชีพ (Professional Learning Community: PLC) ของครูระดับชั้นที่แสดงรูปแบบการจัดกิจกรรม การพัฒนาการความก้าวหน้าของนักเรียนและแก้ไขปัญหา ไม่ครบทุกกิจกรรม มีเอกสารแสดงร่องรอยการทำกิจกรรมของนักเรียนไม่ครบทุกกิจกรรม', 10, 2, CAST(0x0000A5A2011842E0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'381788f0-9548-4988-b7af-8ac822563174', N'4bc80c63-0c83-4e68-91b6-c9d9f09abb9e', N'มีการออกใบรับรองตามเกณฑ์การผ่านสมรรถนะตามสาขาอาชีพ มีความร่วมมือจัดทำหลักสูตรตามสมรรถนะสาขาอาชีพแบบต่าง ๆ ตามความต้องการของนักเรียน  และมีเอกสารความร่วมมือ หรือเอกสารการประสานงาน และเอกสารการออกหลักฐานการประเมินสมรรถนะตามสาขาวิชาชีพเป็นหลักฐาน', 5, 3, CAST(0x0000A5A20111C2D0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'3b5ccd24-6cba-41e7-9061-f84a390a8873', N'2a726295-1717-4e2e-b6c9-c8f691a25d4d', N'มีการจัดทำคลังทะเบียน สื่อแนะนำรายละเอียด และแผนความต้องการ ยังไม่ชัดเจน ไม่เป็นรูปธรรม', 1, 1, CAST(0x0000A5A300C04C20 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'3e44bc3a-eeda-4ae3-8c6c-3d97c199f464', N'712a9a61-f2be-434a-8b24-e5451133347e', N'มีคลังทะเบียนแหล่งเรียนรู้ มีสื่อแนะนำรายละเอียด และมีการจัดกิจกรรมความร่วมมือและสำรวจความต้องการที่จะเรียนรู้ และมีเอกสารความต้องการที่จะเรียนรู้ร่วมกันเป็นหลักฐาน', 3, 2, CAST(0x0000A5A200BD8724 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'3eb953cb-e4c4-4022-ad42-273180b8d94f', N'89ffbdf9-73f6-464c-a82e-69efdc5fb8c4', N'-', 0, 1, CAST(0x0000A5A700E5BBB8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'3faee176-9a46-474c-8b40-adfcec851d15', N'c4a3beb3-423b-4c57-9b63-49589b495c21', N'มีเอกสารโครงร่าง Project-Based ขาดเอกสารทฤษฎีความรู้ที่เขียนอธิบายกระบวนการและขั้นตอนการเกิดสมมติฐาน', 3, 1, CAST(0x0000A5A300983F64 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'41cfacf9-bcee-485d-b17d-9f936d7961c5', N'0811dab9-ef23-4d7f-97da-bd273830636f', N'ไม่มี', 0, 1, CAST(0x0000A5A300F44EF8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'439d7beb-efb6-4191-aa33-d148a3533304', N'4bc80c63-0c83-4e68-91b6-c9d9f09abb9e', N'มีการออกใบรับรองตามเกณฑ์การผ่านสมรรถนะตามสาขาอาชีพ มีความร่วมมือจัดทำหลักสูตรตามสมรรถนะสาขาอาชีพแบบต่าง ๆ ตามความต้องการของนักเรียน', 3, 2, CAST(0x0000A5A20111C2D0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'46f58f49-623a-46ee-9d84-0ec05df95a01', N'f540dd7b-f71a-4102-9467-47f9cdd0fa27', N'มีเอกสารแต่ไม่ได้แสดงที่มาของปัญหาหรือประเด็นสนใจและประโยชน์ที่จะเกิดขึ้น และขาดร่องรอยหลักฐานต่าง ๆ ที่แสดงถึงความต้องการต่อยอดพัฒนากระบวนการผลิต หรือพัฒนาผลิตภัณฑ์ หรือพัฒนานวัตกรรม', 3, 1, CAST(0x0000A5A30095FC7C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'49cb6d18-6c42-4320-9d8d-c750cb1f41e4', N'b9c01335-c8d8-49d8-b69b-747a5ff2812b', N'มี', 3, 2, CAST(0x0000A5A300F3FE1C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'49e05522-6f9e-462c-af51-919434da78f9', N'8685b987-3452-4ce9-9f09-61bb584618ab', N'มีตารางสอนแสดงช่วงเวลาของกิจกรรมตามกระบวนการของหน่วยเรียนรู้บูรณาการ การทำกิจกรรม PLC กระบวนการเรียนแบบฝึกและถอดประสบการณ์ และกระบวนการเรียนรู้รูปแบบการเรียนรู้เป็นผู้ประกอบการ และมีเอกสารตารางสอน', 3, 2, CAST(0x0000A5A20115E2AC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'4bc06a82-a633-4fdf-99e2-667adfc4f6a9', N'd75eac0b-3571-4fb3-b36b-9c0cac4bfd56', N'ยังไม่ได้จัดทำผังมโนทัศน์แสดงหน่วยเรียนรู้บูรณาการ ยังไม่มีกระบวนการจัดทำ', 3, 1, CAST(0x0000A5A201142688 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'4cc457ac-196d-42d3-8333-3ba4080ed582', N'ea9ee2c6-3050-4c85-bc5a-41309ad02ce0', N'มีเอกสารแผนการทำงาน มีเอกสารการบันทึกผลและอธิบายความเป็นไปได้ทุกกระบวนการและขั้นตอน ขาดร่องรอยหลักฐานมีที่แสดงกิจกรรมการทำงาน การสรุป และการนำเสนอด้วยวิธีที่หลากหลาย', 6, 2, CAST(0x0000A5A300990570 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'4cebdd2d-2517-4577-9e65-3c9cab9bb795', N'89ffbdf9-73f6-464c-a82e-69efdc5fb8c4', N'-', 4, 2, CAST(0x0000A5A700E5BBB8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'4ddf7c59-eed0-4e0b-a594-3ec13f885272', N'c4a3beb3-423b-4c57-9b63-49589b495c21', N'มีเอกสารโครงร่าง Project-Based มีเอกสารทฤษฎีความรู้เขียนอธิบายทุกกระบวนการและขั้นตอนการเกิดสมมติฐานสอดคล้องกับการแก้ปัญหา สามารถนำไปใช้ได้จริง', 6, 2, CAST(0x0000A5A300983F64 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'4e09f2e5-824e-4535-9574-b990d9965383', N'e6625304-5dec-4bc1-8c00-3c0f9d8c939e', N'มีเอกสารโครงร่าง Project-Based มีเอกสารทฤษฎีความรู้เขียนอธิบายทุกกระบวนการและขั้นตอนการเกิดสมมติฐานสอดคล้องกับการแก้ปัญหา สามารถนำไปใช้ได้จริง', 6, 2, CAST(0x0000A5A300988488 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'4f880ba5-418b-48b4-844b-9ffb978d7a83', N'b7891545-8301-4b61-8624-2c12417490d5', N'มีตารางสอนแสดงช่วงเวลาของกิจกรรมตามกระบวนการของหน่วยเรียนรู้บูรณาการ การทำกิจกรรม PLC กระบวนการเรียนแบบฝึกและถอดประสบการณ์ และกระบวนการเรียนรู้รูปแบบการเรียนรู้เป็นผู้ประกอบการ และมีเอกสารตารางสอน', 3, 2, CAST(0x0000A5A201165200 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'51b6b7c4-9e53-42e2-b8db-6f571a09c3d2', N'a7d1ab3f-ec96-4170-9072-2dc7d3edf61b', N'มีคลังทะเบียนแหล่งเรียนรู้ มีสื่อแนะนำรายละเอียด และมีการจัดกิจกรรมความร่วมมือและสำรวจความต้องการที่จะเรียนรู้ และมีเอกสารความต้องการที่จะเรียนรู้ร่วมกันเป็นหลักฐาน', 3, 2, CAST(0x0000A5A200BE36EC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'51e0b456-e05c-4076-b3da-7152f38c8279', N'c532dfcc-781a-478f-98c3-4b7c834b2b0e', N'มี Portfolios มีเครื่องมือและผลการวัดและประเมินบุคลิกภาพ ความถนัด ทักษะ คุณลักษณะ และผลงานของนักเรียนรายบุคคล มีกิจกรรมแนะแนวอาชีพ และมีเอกสาร Portfolios เอกสารรายงานผลบุคลิกภาพ ความถนัด ทักษะ คุณลักษณะ และผลงานเป็นหลักฐาน', 3, 2, CAST(0x0000A5A2010F41CC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'5265fbef-536f-453b-8d41-dd2f1b02427a', N'b07adf50-c9c1-4107-8888-2701e656ff49', N'มีระดับผลการเรียนเฉลี่ยตั้งแต่ ๒.๗๕ ขึ้นไป และมีกราฟหรือเอกสารอื่นที่แสดงทิศทางระดับผลการเรียนด้านความรู้ ด้านทักษะ และด้านเจตนคติที่สอดคล้องดีขึ้นทิศทางเดียวกัน มีระดับผลการการเรียนเฉลี่ยในรายวิชาเพิ่มเติมตามหลักสูตรสมรรถนะสาขาวิชาชีพตั้งแต่ ๓.๐๐ ขึ้นไป มีเอกสารแสดงการผ่านการเข้าร่วมกิจกรรมการเรียนรู้เป็นผู้ประกอบการ และมีเอกสารที่แสดงการเข้าร่วมตามกระบวนการบันได ๕ ขั้น', 10, 3, CAST(0x0000A5A30094BB64 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'52f52bd6-beed-4f07-8cfb-5eb7c0769de1', N'2fef51c1-988d-4b6d-9ee4-af5e408bdcc2', N'-', 2, 2, CAST(0x0000A5A700E44968 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'5372ac61-8bc8-4f49-8134-9337024c668c', N'87662abe-a397-42e8-8595-03a3730d7e87', N'มีเอกสารแผนการทำงานขาดความสมบูรณ์ มีเอกสารการบันทึกผลและอธิบายความเป็นไปได้ไม่ครบทุกกระบวนการและขั้นตอน ขาดร่องรอยหลักฐานมีที่แสดงกิจกรรมการทำงาน การสรุป และการนำเสนอด้วยวิธีที่หลากหลาย', 3, 1, CAST(0x0000A5A30099C7F8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'53998128-f4fb-45a0-9cee-bf85a288553c', N'b088599b-7cb8-45e1-924f-43738ece3e77', N'ยังไม่ได้จัดกิจกรรมการเรียนรู้แบบฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะวิชาชีพ ของคณะครูในรายวิชาเพิ่มเติม ผ่านกระบวนการเรียนรู้แบบชุมชนแห่งการเรียนรู้วิชาชีพ (Professional Learning Community: PLC)', 5, 1, CAST(0x0000A5A2011AD578 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'54609957-1290-4bc1-ac51-294fb303ff88', N'b4e5c60b-8e8c-4921-8f51-d26a204f95ea', N'มีระบบเทคโนโลยีช่วยการสนับสนุนการบริหารจัดการ การจัดกระบวนการเรียนรู้ และการเรียนรู้ของนักเรียน ที่มีการกำหนดในรูปกิจกรรมการเข้าไปใช้งานตลอดทั้งปีการศึกษา และมีเอกสารตารางการใช้และจำนวนปริมาณผู้ใช้ต่อเนื่องทุกวันทำการ    มีเอกสารระเบียบการใช้เทคโนโลยีของโรงเรียนและมีกิจกรรมการพัฒนาจริยธรรมการใช้ ICT ตามแนวทางของระเบียบ', 15, 3, CAST(0x0000A5A2011230F8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'546ba617-799c-497a-b2fc-0a19898f65f8', N'c962d40c-cbba-4cfd-8a71-8b202ef9e506', N'-', 3, 2, CAST(0x0000A5A700E38488 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'547cb4b2-d869-42a0-a36e-057dba747528', N'2fef51c1-988d-4b6d-9ee4-af5e408bdcc2', N'-', 0, 1, CAST(0x0000A5A700E44968 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'54adfac3-796f-4808-9c4a-acda91e76c3a', N'9ce80ffd-3506-4c3f-acb9-14ae52d76cd8', N'-', 0, 1, CAST(0x0000A5A700E70F90 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'54ae1773-5ff1-490d-8d02-29a50412062a', N'a416e5de-9ee0-4bc8-a303-fd14b53fb693', N'มีการจัดทำคลังทะเบียน สื่อแนะนำรายละเอียด และแผนความต้องการยังไม่ชัดเจน ไม่เป็นรูปธรรม', 1, 1, CAST(0x0000A5A300BC58CC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'54bc7b12-174d-434b-b12b-186236765ba2', N'927bf4bd-a9a2-40a8-a2d2-3d4cf45a1cdf', N'มีเอกสารแผนการทำงานขาดความสมบูรณ์ มีเอกสารการบันทึกผลและอธิบายความเป็นไปได้ไม่ครบทุกกระบวนการและขั้นตอน ขาดร่องรอยหลักฐานมีที่แสดงกิจกรรมการทำงาน การสรุป และการนำเสนอด้วยวิธีที่หลากหลาย', 3, 1, CAST(0x0000A5A3009A18D4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'54f70208-08fa-4a54-bed8-aeb888898f51', N'ba44b17b-3f0e-4a9b-9485-920b3a093895', N'มีการจัดรูปแบบการพัฒนาสมรรถนะทางสาขาวิชาชีพให้กับนักเรียนในวิชาเพิ่มเติมยังไม่ชัดเจน ไม่เป็นรูปธรรม', 10, 1, CAST(0x0000A5A20108B730 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'56c598ee-8f86-40a6-be14-388702fa68f2', N'a422fdb1-cf28-43cb-bdec-66122809c5f3', N'มีเอกสารใบกิจกรรม ใบความรู้ และสื่อใช้เป็นเครื่องมือจัดการเรียนรู้ มีแผนและบันทึกผลการให้คำปรึกษาการทำผลงาน มีเอกสารร่องรอยการจัดกิจกรรมการคัดเลือกหรือประกวดผลงานนักเรียนที่ผ่านเกณฑ์คุณภาพ', 10, 2, CAST(0x0000A5A2011D44E8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'57299725-367e-4dd5-b0e8-db76dd112537', N'8c597661-1934-4b3b-9e35-743b9dc3be05', N'มีใบกิจกรรม ใบความรู้ของกิจกรรมตามกรอบบันได ๕ ขั้น แบบ Problem-Based Learning ของคณะครูระดับชั้น มีเอกสารแสดงการบันทึกผลสรุปจากกระบวนการเรียนรู้แบบชุมชนแห่งการเรียนรู้วิชาชีพ (Professional Learning Community: PLC) ของครูระดับชั้นที่แสดงรูปแบบการจัดกิจกรรม การพัฒนาการความก้าวหน้าของนักเรียนและแก้ไขปัญหา ในแต่ละกิจกรรม มีเอกสารแสดงร่องรอยการทำกิจกรรมของนักเรียนทุกกิจกรรม', 15, 3, CAST(0x0000A5A20117E2C8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'57915cd3-e155-4223-a5a5-ace0761133b6', N'93a56cea-b6c6-4420-8f09-8f7fc68828f9', N'มีการบูรณาการทฤษฎีความรู้ที่เชื่อมโยงกันได้น้อย', 1, 1, CAST(0x0000A5A300B20AE8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'58ca11de-428f-468c-9ad4-6340fcca32fe', N'712a9a61-f2be-434a-8b24-e5451133347e', N'มีคลังทะเบียนแหล่งเรียนรู้ มีสื่อแนะนำรายละเอียด และมีการจัดกิจกรรมความร่วมมือและสำรวจความต้องการที่จะเรียนรู้ ที่มีข้อมูลถูกต้องเป็นปัจจุบัน และมีคำสั่ง หรือเอกสารการมอบหมายงาน และเอกสารความต้องการที่จะเรียนรู้ร่วมกันเป็นหลักฐาน', 5, 3, CAST(0x0000A5A200BD8724 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'5ab242d2-a438-4b9a-8c05-cbd0bcf6bafc', N'ffb04e0e-5ae2-4865-906e-dafb30c32c18', N'มีรายวิชาเพิ่มเติมแสดงรูปแบบการจัดหลักสูตรวิชาชีพระยะสั้น ทวิศึกษา และสมรรถนะสาขาวิชาชีพตามสาขาการศึกษาต่อในระดับอุดมศึกษา และมีผังมโนทัศน์หน่วยเรียนรู้บูรณาการแสดงรูปแบบการจัดพื้นฐานทักษะการเรียนรู้ในศตวรรษที่ ๒๑ และจัดกิจกกรมการสำรวจความต้องการ จัดกิจกรรมความร่วมมือการจัดทำคู่มือการเรียนแบบฝึกและถอดประสบการณ์ และมีเอกสารประสานงาน เอกสารแสดงผลการเรียนรู้ และเอกสารคู่มือเป็นหลักฐาน', 25, 3, CAST(0x0000A5A20109611C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'5b3edcfd-95e3-4d88-a54a-2ebca14f3d9e', N'b7891545-8301-4b61-8624-2c12417490d5', N'มีตารางสอนแสดงช่วงเวลาของกิจกรรมตามกระบวนการของหน่วยเรียนรู้บูรณาการ การทำกิจกรรม PLC กระบวนการเรียนแบบฝึกและถอดประสบการณ์ และกระบวนการเรียนรู้รูปแบบการเรียนรู้เป็นผู้ประกอบการ ที่มีกิจกรรมการออกแบบและกำหนดเวลาตามกระบวนการในรายวิชาพื้นฐาน รายวิชาเพิ่มเติม และรายวิชากิจกรรมชุมชุม และมีเอกสารตารางสอน เอกสารบันทึกผลหารจัดกิจกรรม PLC เป็นหลักฐาน', 5, 3, CAST(0x0000A5A201165200 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'5b474e9f-1765-4e72-b0ed-e270d4fea82f', N'665a4b09-091a-4412-b687-60e635f52923', N'มีการจัดทำคลังทะเบียน สื่อแนะนำรายละเอียด และแผนความต้องการ ยังไม่ชัดเจน ไม่เป็นรูปธรรม', 1, 1, CAST(0x0000A5A200BB2F24 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'5c13fc38-04d4-45bf-b8cc-5836c1f84fa2', N'8f06b0bb-e1ae-4cd0-af99-fdb768c47de8', N'การจัดกิจกรรมสร้างเส้นทางการศึกษาต่อและประกอบอาชีพไม่ชัดเจน', 1, 1, CAST(0x0000A5A300C67320 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'5d24a39b-e479-4793-9a4f-9cc349605e9e', N'79aa2bfa-0f3d-457a-ba4b-e683e67d37ff', N'มีเอกสารการเรียบเรียงหลักความรู้และทฤษฎีความรู้ หรือผังมโนทัศน์ มีบรรณานุกรมความรู้แสดงความเชื่อถือได้และเป็นสากลของทฤษฎีความรู้ และมีแผนการสืบค้นความรู้หรือร่องรอยหลักฐานอื่น ที่แสดงถึงการทำงานให้ได้กรอบทฤษฎีความรู้ของคณะผู้ทำผลงาน', 10, 3, CAST(0x0000A5A30097CC8C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'5ebf0f79-9359-426a-9723-6d0d4d2b07dc', N'86b37ec9-2e4c-4877-8f9b-04be13e14cc0', N'-', 0, 1, CAST(0x0000A5A700E7318C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'5ff3344d-e516-4821-8a0c-fe417fb8dc79', N'2a4c794b-cce5-4e31-9483-e30dd78dc8e7', N'จัดทำใบกิจกรรม ใบความรู้ ยังไม่เป็นไปตามกรอบบันได ๕ ขั้น ของกิจกรรมแบบ Problem-Based Learning', 5, 1, CAST(0x0000A5A2011842E0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'6093005b-c08a-4adb-bcc1-504cfe5aee7c', N'87662abe-a397-42e8-8595-03a3730d7e87', N'มีเอกสารแผนการทำงาน มีเอกสารการบันทึกผลและอธิบายความเป็นไปได้ทุกกระบวนการและขั้นตอน ขาดร่องรอยหลักฐานมีที่แสดงกิจกรรมการทำงาน การสรุป และการนำเสนอด้วยวิธีที่หลากหลาย', 6, 2, CAST(0x0000A5A30099C7F8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'64d5f8d7-65e7-4940-834b-f50f7bf4e536', N'48038dcf-9986-4adc-a99e-8d9236d82ea1', N'มีระดับผลการเรียนเฉลี่ยตั้งแต่ ๒.๗๕ ขึ้นไป และมีกราฟหรือเอกสารอื่นที่แสดงทิศทางระดับผลการเรียนด้านความรู้ ด้านทักษะ และด้านเจตนคติที่สอดคล้องดีขึ้นทิศทางเดียวกัน มีระดับผลการการเรียนเฉลี่ยในรายวิชาเพิ่มเติมตามหลักสูตรสมรรถนะสาขาวิชาชีพตั้งแต่ ๓.๐๐ ขึ้นไป มีเอกสารแสดงการผ่านการเข้าร่วมกิจกรรมการเรียนรู้เป็นผู้ประกอบการ และมีเอกสารที่แสดงการเข้าร่วมตามกระบวนการบันได ๕ ขั้น', 10, 3, CAST(0x0000A5A300946254 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'658b0b08-f0f6-4c53-bef9-0434e2611394', N'96948f03-0fb5-419d-9bd1-d678f97051e9', N'จัดทำใบกิจกรรม ใบความรู้ ยังไม่เป็นไปตามกรอบบันได ๕ ขั้น ของกิจกรรมแบบ Problem-Based Learning', 5, 1, CAST(0x0000A5A2011702F4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'65a83ce1-d92f-4884-9e75-9c5c6625aec9', N'c6250de7-a538-4ed9-94e9-ca830de04920', N'มีแผนการเรียนรู้ หรือคู่มือการฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะสาขาวิชาชีพ มีใบกิจกรรม ใบความรู้ และสื่อเป็นเครื่องมือ มีกิจกรรมของคณะครูในรายวิชาเพิ่มเติม ผ่าน PLC จัดทำแผนการเรียนรู้ หรือคู่มือการเรียนรู้รองรับหลักสูตรต่าง ๆ ตามความต้องการของนักเรียน มีกิจกรรมตามกระบวนการของการเรียนรู้แบบฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะวิชาชีพครบทุกกระบวนการ และมีเอกสารแผนการเรียนรู้ หรือคู่มือครบตามแผนการเปิดหลักสูตร มีเอกสารแสดงร่องรอยการบันทึกสรุปผลการฝึกและถอดประสบการของนักเรียน', 15, 3, CAST(0x0000A5A2011B6DD0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'65ae9606-ef02-4b46-9377-339e9cec2b4e', N'2a726295-1717-4e2e-b6c9-c8f691a25d4d', N'มีคลังทะเบียน มีสื่อแนะนำรายละเอียด และมีแผนความต้องการ ที่มีข้อมูลถูกต้องเป็นปัจจุบัน และจัดทำขึ้นโดยความร่วมมือจากทุกภาคส่วน ที่มีบันทึกความร่วมมือ เอกสารหนังสือการประสานงานเป็นหลักฐาน', 5, 3, CAST(0x0000A5A300C04C20 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'67674be4-405b-48e4-b8f0-c3d1516f40c7', N'e6eabdaa-d838-450b-bc30-3e2784e0a3c4', N'มีเอกสารการเรียบเรียงหลักความรู้และทฤษฎีความรู้ หรือผังมโนทัศน์ มีบรรณานุกรมความรู้แสดงความเชื่อถือได้และเป็นสากลของทฤษฎีความรู้ และมีแผนการสืบค้นความรู้หรือร่องรอยหลักฐานอื่น ที่แสดงถึงการทำงานให้ได้กรอบทฤษฎีความรู้ของคณะผู้ทำผลงาน', 10, 3, CAST(0x0000A5A300978D44 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'6895d19d-2d2f-4925-9c19-b7512670bd1e', N'66ea0dab-63b6-420a-aaac-43adf1044fae', N'-', 3, 2, CAST(0x0000A5A700E64150 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'68bd3ea0-20e1-4426-a854-e18c70ab0c13', N'4d6bcb37-1a96-4a90-9b54-09e3782a97d6', N'มีระบบเทคโนโลยีช่วยการสนับสนุนการบริหารจัดการ การจัดกระบวนการเรียนรู้ และการเรียนรู้ของนักเรียน ที่มีการกำหนดในรูปกิจกรรมการเข้าไปใช้งานบางระยะเวลา ขาดเอกสารตารางการใช้และจำนวนปริมาณผู้ใช้ต่อเนื่องทุกวันทำการ    มีเอกสารระเบียบการใช้เทคโนโลยีของโรงเรียน', 8, 2, CAST(0x0000A5A201128D8C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'69137683-6853-487a-a5f3-3904f2553d26', N'9dac559a-7585-47ee-b545-4af71cd1b1fc', N'มีรายวิชาเพิ่มเติมแสดงรูปแบบการจัดหลักสูตรวิชาชีพระยะสั้น ทวิศึกษา และสมรรถนะสาขาวิชาชีพตามสาขาการศึกษาต่อในระดับอุดมศึกษา และมีผังมโนทัศน์หน่วยเรียนรู้บูรณาการแสดงรูปแบบการจัดพื้นฐานทักษะการเรียนรู้ในศตวรรษที่ ๒๑ และจัดกิจกกรมการสำรวจความต้องการ จัดกิจกรรมความร่วมมือการจัดทำคู่มือการเรียนแบบฝึกและถอดประสบการณ์ และมีเอกสารประสานงาน เอกสารแสดงผลการเรียนรู้ และเอกสารคู่มือเป็นหลักฐาน', 25, 3, CAST(0x0000A5A20109EB64 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'69532a9f-0869-4855-bf7e-d1d16f610c32', N'5ab2630b-47ec-453a-8777-ef94a4bd6f21', N'ไม่มีคู่มือ หรือใบกิจกรรม ใบความรู้ เป็นเครื่องมือการเรียนรู้ มีการจัดกิจกรรม Project-Based ที่ยังไม่ชัดเจนไม่เป็นไปตามกระบวนการ', 5, 1, CAST(0x0000A5A2011E4C94 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'6975dc97-3dd2-429a-8281-640c00aa5012', N'8f3f87e4-1809-43dd-b6ed-799e00a74546', N'มีโปรแกรมการเรียนที่มีโครงสร้างหลักสูตรยังไม่สอดคล้องความต้องการ และยังขาดร่องรอยหลักฐาน', 10, 1, CAST(0x0000A5A20107046C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'6995deb1-716e-4001-b28c-99f374e74979', N'f5ce8f0f-fe12-48ec-a50f-ffd8dc78a527', N'การจัดกิจกรรมสร้างเส้นทางการศึกษาต่อและประกอบอาชีพไม่ชัดเจน', 1, 1, CAST(0x0000A5A201100454 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'6a63bb07-5d80-4260-8e02-b512d1c62a69', N'156ff13a-bb20-4f7f-97d0-cec604b4b8e9', N'ไม่มีคู่มือ หรือใบกิจกรรม ใบความรู้ เป็นเครื่องมือประกอบการจัดการเรียนรู้ และไม่มีมีเอกสารแสดงร่องรอยการจัดกิจกรรม', 3, 1, CAST(0x0000A5A3008E8780 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'6ca8aa8d-35c0-4f91-9dfb-87752b974cf6', N'e6625304-5dec-4bc1-8c00-3c0f9d8c939e', N'มีเอกสารโครงร่าง Project-Based มีเอกสารทฤษฎีความรู้เขียนอธิบายทุกกระบวนการและขั้นตอนการเกิดสมมติฐานสอดคล้องกับการแก้ปัญหา สามารถนำไปใช้ได้จริง และมีร่องรอยหลักฐานที่แสดงการทำงานร่วมกันในการออกแบบนวัตกรรม', 10, 3, CAST(0x0000A5A300988488 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'6dc6a68d-9a6c-4f8e-abb2-37780e485e8e', N'6076e517-5ab2-403c-85eb-aa3ac42940cc', N'มีเอกสารเครื่องมือและผลการวัดผลการพัฒนาของนักเรียนตามประเภท (K, P, A) และระดับขั้นพฤติกรรม และหลักความรู้ และตรงกับที่ระบุในมาตรฐานการเรียนรู้และตัวชี้วัดรายวิชา มีร่องรอยหลักฐานแสดงการวิเคราะห์มาตรฐานการเรียนรู้และตัวชี้วัดรายวิชายังไม่ถูกต้องชัดเจน  มีเอกสารแผนการเลือกตัวชี้วัดรายวิชาที่สำคัญที่เป็นตัวแทน และมีเอกสารแสดงการใช้และผลการประเมินบุคลิกภาพของนักเรียนรายบุคคลใช้เป็นข้อมูลเลือกโปรแกรมการเรียน', 5, 2, CAST(0x0000A5A3009281DC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'730e31ba-e6bf-4c35-8b1a-4f59b2c1c84f', N'f5ce8f0f-fe12-48ec-a50f-ffd8dc78a527', N'มี Portfolios มีเครื่องมือและผลการวัดและประเมินบุคลิกภาพ ความถนัด ทักษะ คุณลักษณะ และผลงานของนักเรียนรายบุคคล มีกิจกรรมแนะแนวอาชีพ และมีเอกสาร Portfolios เอกสารรายงานผลบุคลิกภาพ ความถนัด ทักษะ คุณลักษณะ และผลงานเป็นหลักฐาน', 3, 2, CAST(0x0000A5A201100454 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'746bd5e6-ca0c-47d0-8ec8-61977279bee5', N'd703eaf3-6258-4333-9db7-126a24e20267', N'มีเอกสารโครงร่าง Project-Based ขาดเอกสารทฤษฎีความรู้ที่เขียนอธิบายกระบวนการและขั้นตอนการเกิดสมมติฐาน', 3, 1, CAST(0x0000A5A30098BA70 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'7a3ffa4d-a1e3-426b-b4fd-388025ec5af6', N'eac852f1-5422-4d6f-a652-2112c7cc76e4', N'มีคู่มือ หรือใบกิจกรรม ใบความรู้ เป็นเครื่องมือประกอบการจัดการเรียนรู้ มีเอกสารแสดงร่องรอยการจัดกิจกรรมการ จดทะเบียนบริษัทจำลอง กิจกรรมการนำเข้าวัตถุดิบ การผลิต แปรรูป บรรจุภัณฑ์ จัดจำหน่าย และบัญชีรายรับรายจ่าย แสดงได้บางส่วน', 5, 2, CAST(0x0000A5A3008E3320 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'7b860712-e593-41d3-994c-5188751827bb', N'8757752d-a1b3-41f8-9873-356facf5d219', N'-', 0, 1, CAST(0x0000A5A700E54304 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'7c6704f1-ac94-4c87-b931-d652f0f0937f', N'f5ce8f0f-fe12-48ec-a50f-ffd8dc78a527', N'มี Portfolios มีเครื่องมือและผลการวัดและประเมินบุคลิกภาพ ความถนัด ทักษะ คุณลักษณะ และผลงานของนักเรียนรายบุคคล มีการจัดกิจกรรมสร้างความเข้าใจใช้รายงานผลจาก Portfolios ให้นักเรียนและผู้ปกครองเลือกโปรแกรมการเรียน มีกิจกรรมความร่วมมือกับหน่วยงานที่เกี่ยวข้องแนะแนวอาชีพตามความต้องการอัตรากำลังแรงงานของจังหวัด และมีเอกสาร Portfolios เอกสารรายงานผลบุคลิกภาพ ความถนัด ทักษะ คุณลักษณะ และผลงานเป็นหลักฐาน', 5, 3, CAST(0x0000A5A201100454 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'7eecdbed-215a-4ec4-a6bf-c9290ff1d55f', N'9af1f6ba-9b23-42e0-80e5-b945ed5c45ff', N'การเผยแพร่นำไปสู่การใช้งานยังไม่กว้างขวางหลากหลาย', 1, 1, CAST(0x0000A5A300B4BD24 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'7eed65ea-85b4-44ae-ad58-5998b964cead', N'fba49914-1fa6-4ca5-a2bf-bc9a6164003b', N'-', 3, 2, CAST(0x0000A5A700E3CF88 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'83301646-e589-4fd3-b870-a3d4f99a41a4', N'c9599360-0962-4654-b86c-d6dc29bc1cac', N'มีโปรแกรมการเรียนและโครงสร้างหลักสูตรตามสมรรถนะทางสาขาวิชาชีพ ตรงความต้องการอัตรากำลังแรงงาน และตรงกับความต้องการของนักเรียน ที่มีการจัดกิจกรรมสำรวจความต้องการ กิจกรรมความร่วมมือการจัดทำหลักสูตร แต่ยังขาดเอกสารความร่วมมือเป็นหลักฐาน', 15, 2, CAST(0x0000A5A20107E0BC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'84813bcd-bccf-4792-944c-1af0fbe2169b', N'f9a4e08a-c292-493b-9299-f9c64cbb8086', N'-', 3, 2, CAST(0x0000A5A700E5E264 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'854929b1-e1f2-4756-8b0e-9f68b8c3555f', N'006609bb-3776-4b82-812a-797775df6722', N'-', 2, 2, CAST(0x0000A5A700E6B0A4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'858059f7-19fa-4093-b49d-cd3a6a723719', N'5f6ee31e-6f4b-41e1-bfdd-e9a4f760dfcf', N'สามารถแก้ปัญหาตามวัตถุประสงค์ตอบประโยชน์เพื่อสังคมและใช้งานได้จริง มีความแปลกใหม่ ทันสมัยและสร้างสรรค์', 10, 3, CAST(0x0000A5A3009B346C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'85fbe614-37a5-4b9f-b87a-f75b32bef2ca', N'4d6bcb37-1a96-4a90-9b54-09e3782a97d6', N'การจัดระบบกานำเทคโนโลยียังไม่ต่อเชื่อมเป็นระบบ ไม่มีการพัฒนาต่อยอดให้เป็นรูปธรรม', 8, 1, CAST(0x0000A5A201128D8C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'865c2a1b-7288-4873-be6a-8f3d1fec3f70', N'c193aa26-c5db-42f2-95c9-41187e7ef891', N'มีการออกใบรับรองตามเกณฑ์การผ่านสมรรถนะตามสาขาอาชีพ มีความร่วมมือจัดทำหลักสูตรตามสมรรถนะสาขาอาชีพแบบต่าง ๆ ตามความต้องการของนักเรียน', 3, 2, CAST(0x0000A5A20110EC5C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'86cab734-7aec-4525-b852-44a02b0fe3eb', N'797e3d48-fdba-4509-9695-f3639f3f1eda', N'ยังไม่มีหลักสูตรตามสมรรถนะสาขาวิชาชีพ', 1, 1, CAST(0x0000A5A201116C18 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'87dd2708-eca3-475d-acfb-61032e0d410d', N'ae9bdc9a-4154-49aa-ae0e-36d51230f07b', N'มีโปรแกรมการเรียนและโครงสร้างหลักสูตรตามสมรรถนะทางสาขาวิชาชีพ ตรงความต้องการอัตรากำลังแรงงาน และตรงกับความต้องการของนักเรียน ที่มีการจัดกิจกรรมสำรวจความต้องการ กิจกรรมความร่วมมือการจัดทำหลักสูตร และมีบันทึกความร่วมมือ หรือเอกสารแสดงการจัดกิจกรรมความต้องการ มีหนังสือการประสานงานเป็นหลักฐาน', 20, 3, CAST(0x0000A5A200FBC9D0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'88abb5a2-18a2-4b6d-9ad6-79fb3f43acb8', N'c193aa26-c5db-42f2-95c9-41187e7ef891', N'ยังไม่มีหลักสูตรตามสมรรถนะสาขาวิชาชีพ', 1, 1, CAST(0x0000A5A20110EC5C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'88cba8f2-f697-4b02-ac37-9380b5d0729a', N'8c597661-1934-4b3b-9e35-743b9dc3be05', N'มีใบกิจกรรม ใบความรู้ของกิจกรรมตามกรอบบันได ๕ ขั้น แบบ Problem-Based Learning ของคณะครูระดับชั้น มีเอกสารแสดงการบันทึกผลสรุปจากกระบวนการเรียนรู้แบบชุมชนแห่งการเรียนรู้วิชาชีพ (Professional Learning Community: PLC) ของครูระดับชั้นที่แสดงรูปแบบการจัดกิจกรรม การพัฒนาการความก้าวหน้าของนักเรียนและแก้ไขปัญหา ไม่ครบทุกกิจกรรม มีเอกสารแสดงร่องรอยการทำกิจกรรมของนักเรียนไม่ครบทุกกิจกรรม', 10, 2, CAST(0x0000A5A20117E2C8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'89b8412f-4351-4996-9a3e-47287d894414', N'b7891545-8301-4b61-8624-2c12417490d5', N'ยังไม่ได้จัดทำตารางสอนหน่วยเรียนรู้   บูรณาการ และตารางการฝึกและถอดประสบการณ์', 1, 1, CAST(0x0000A5A201165200 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'8aa89efb-67c8-431f-9664-809181bc431d', N'c6250de7-a538-4ed9-94e9-ca830de04920', N'มีแผนการเรียนรู้ หรือคู่มือการฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะสาขาวิชาชีพ มีใบกิจกรรม ใบความรู้ และสื่อเป็นเครื่องมือ มีกิจกรรมของคณะครูในรายวิชาเพิ่มเติม ผ่าน PLC จัดทำแผนการเรียนรู้ หรือคู่มือการเรียนรู้รองรับหลักสูตรต่าง ๆ ตามความต้องการของนักเรียน มีกิจกรรมตามกระบวนการของการเรียนรู้แบบฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะวิชาชีพครบยังไม่ครบทุกกระบวนการ และมีเอกสารแผนการเรียนรู้ หรือคู่มือไม่ครบตามแผนการเปิดหลักสูตร และยังขาดหรือมีเอกสารไม่สมบูรณ์แสดงร่องรอยการบันทึกสรุปผลการฝึกและถอดประสบการของนักเรียน', 10, 2, CAST(0x0000A5A2011B6DD0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'8ab4e495-aaab-41e6-bf8b-80c51bdd1d40', N'c532dfcc-781a-478f-98c3-4b7c834b2b0e', N'การจัดกิจกรรมสร้างเส้นทางการศึกษาต่อและประกอบอาชีพไม่ชัดเจน', 1, 1, CAST(0x0000A5A2010F41CC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'8adbe7bd-7234-4f0a-9f3d-81cadeff4a2d', N'006609bb-3776-4b82-812a-797775df6722', N'-', 0, 1, CAST(0x0000A5A700E6B0A4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'8b9c746c-37d5-49f7-b06a-5f518824bf9b', N'ea9ee2c6-3050-4c85-bc5a-41309ad02ce0', N'มีเอกสารแผนการทำงาน มีเอกสารการบันทึกผลและอธิบายความเป็นไปได้ทุกกระบวนการและขั้นตอน และมีรูปถ่าย วิดีโอ หรือเอกสารร่องรอยอื่นที่แสดงกิจกรรมการทำงาน การสรุป นำเสนอด้วยวิธีที่หลากหลาย', 10, 3, CAST(0x0000A5A300990570 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'8c3895ef-6b20-4ee0-b3dc-1e64d59e6255', N'203a364c-98d6-42db-a21f-f58cd3569cba', N'ยังไม่ได้จัดกิจกรรมการเรียนรู้แบบฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะวิชาชีพ ของคณะครูในรายวิชาเพิ่มเติม ผ่านกระบวนการเรียนรู้แบบชุมชนแห่งการเรียนรู้วิชาชีพ (Professional Learning Community: PLC)', 5, 1, CAST(0x0000A5A2011BEB34 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'8c8d4b21-80ce-4b25-9a3a-8dbc104e532d', N'eac852f1-5422-4d6f-a652-2112c7cc76e4', N'ไม่มีคู่มือ หรือใบกิจกรรม ใบความรู้ เป็นเครื่องมือประกอบการจัดการเรียนรู้ และไม่มีมีเอกสารแสดงร่องรอยการจัดกิจกรรม', 3, 1, CAST(0x0000A5A3008E3320 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'8d446f84-f26f-43ff-bf60-e33421775176', N'4241621c-34b3-4ac5-8e6c-7a7c91384b1b', N'-', 3, 2, CAST(0x0000A5A700E517A8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'8e1b0506-4347-47d5-9824-bfb1f6a1500f', N'9af1f6ba-9b23-42e0-80e5-b945ed5c45ff', N'มีการนำเสนอเผยแพร่การใช้งานนำไปสู่ช่องทางการใช้ประโยชน์', 3, 2, CAST(0x0000A5A300B4BD24 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'8e2fb6d5-a1b2-4a76-ae21-cb2165b97080', N'9dac559a-7585-47ee-b545-4af71cd1b1fc', N'มีรายวิชาเพิ่มเติมแสดงรูปแบบการจัดหลักสูตรวิชาชีพระยะสั้น ทวิศึกษา และสมรรถนะสาขาวิชาชีพตามสาขาการศึกษาต่อในระดับอุดมศึกษา และมีผังมโนทัศน์หน่วยเรียนรู้บูรณาการแสดงรูปแบบการจัดพื้นฐานทักษะการเรียนรู้ในศตวรรษที่ ๒๑ และมีแสดงผลการเรียนรู้ เป็นหลักฐาน', 20, 2, CAST(0x0000A5A20109EB64 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'8f09a51a-ec1c-4b63-9a2a-1e75cebf4cd9', N'85cf52b4-0e46-499b-96e9-e20f2402b044', N'มีเอกสารแสดงที่มาของปัญหาหรือประเด็นสนใจและประโยชน์ที่จะเกิดขึ้น และมีร่องรอยหลักฐานต่าง ๆ ที่แสดงถึงความต้องการต่อยอดพัฒนากระบวนการผลิต หรือพัฒนาผลิตภัณฑ์ หรือพัฒนานวัตกรรม', 10, 3, CAST(0x0000A5A30096684C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'90d1561b-9512-45e7-b25f-3602b0876ff6', N'a7d1ab3f-ec96-4170-9072-2dc7d3edf61b', N'มีคลังทะเบียนแหล่งเรียนรู้ และมีการจัดกิจกรรม ยังไม่ชัดเจน ไม่เป็นรูปธรรม', 1, 1, CAST(0x0000A5A200BE36EC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'91108a0e-cc6c-4c06-bd60-c91796a8dc7c', N'6076e517-5ab2-403c-85eb-aa3ac42940cc', N'มีเอกสารเครื่องมือและผลการวัดผลการพัฒนาของนักเรียนตามประเภท (K, P, A) และระดับขั้นพฤติกรรม และหลักความรู้ ตรงกับที่ระบุในมาตรฐานการเรียนรู้และตัวชี้วัดรายวิชา มีร่องรอยหลักฐานแสดงการวิเคราะห์มาตรฐานการเรียนรู้และตัวชี้วัดรายวิชา  มีเอกสารแผนการเลือกตัวชี้วัดรายวิชาที่สำคัญที่เป็นตัวแทน มีเอกสารแสดงรูปแบบการแปลและแสดงผลการประเมินความสมดุลเชิงคุณภาพของนักเรียนรายบุคคล มีเอกสารเครื่องมือและผลการประเมินระดับคุณภาพการเกิดสมรรถนะ และคุณลักษณะ ตลอดจนค่านิยม ๑๒ ประการ และมีเอกสารแสดงการใช้และผลการประเมินบุคลิกภาพของนักเรียนรายบุคคลใช้เป็นข้อมูลเลือกโปรแกรมการเรียน', 10, 3, CAST(0x0000A5A3009281DC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'9437b881-7bbd-4817-8c8f-bb62e6129577', N'939424e4-f6d8-47de-ba06-1f33461791ff', N'-', 3, 2, CAST(0x0000A5A700E4CA50 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'95c0b891-9005-4595-9faa-dd2a85f66222', N'b4e5c60b-8e8c-4921-8f51-d26a204f95ea', N'มีระบบเทคโนโลยีช่วยการสนับสนุนการบริหารจัดการ การจัดกระบวนการเรียนรู้ และการเรียนรู้ของนักเรียน ที่มีการกำหนดในรูปกิจกรรมการเข้าไปใช้งานบางระยะเวลา ขาดเอกสารตารางการใช้และจำนวนปริมาณผู้ใช้ต่อเนื่องทุกวันทำการ    มีเอกสารระเบียบการใช้เทคโนโลยีของโรงเรียน', 8, 2, CAST(0x0000A5A2011230F8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'9672f100-49b0-4309-ab58-64967efa6338', N'8685b987-3452-4ce9-9f09-61bb584618ab', N'มีตารางสอนแสดงช่วงเวลาของกิจกรรมตามกระบวนการของหน่วยเรียนรู้บูรณาการ การทำกิจกรรม PLC กระบวนการเรียนแบบฝึกและถอดประสบการณ์ และกระบวนการเรียนรู้รูปแบบการเรียนรู้เป็นผู้ประกอบการ ที่มีกิจกรรมการออกแบบและกำหนดเวลาตามกระบวนการในรายวิชาพื้นฐาน รายวิชาเพิ่มเติม และรายวิชากิจกรรมชุมชุม และมีเอกสารตารางสอน เอกสารบันทึกผลหารจัดกิจกรรม PLC เป็นหลักฐาน', 5, 3, CAST(0x0000A5A20115E2AC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'96a0ff69-93f6-4331-b282-5c047366b155', N'84360abb-dcc7-4ebe-9dbc-652e3ef0ae2c', N'-', 0, 1, CAST(0x0000A5A700E4A4D0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'97b6869a-a960-48c3-a69f-b8128e9fdf80', N'f9a4e08a-c292-493b-9299-f9c64cbb8086', N'-', 0, 1, CAST(0x0000A5A700E5E264 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'98c7fa60-a5f4-4feb-b505-887f271dd56d', N'c4a3beb3-423b-4c57-9b63-49589b495c21', N'มีเอกสารโครงร่าง Project-Based มีเอกสารทฤษฎีความรู้เขียนอธิบายทุกกระบวนการและขั้นตอนการเกิดสมมติฐานสอดคล้องกับการแก้ปัญหา สามารถนำไปใช้ได้จริง และมีร่องรอยหลักฐานที่แสดงการทำงานร่วมกันในการออกแบบนวัตกรรม', 10, 3, CAST(0x0000A5A300983F64 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'9ae12377-b3f7-4b74-bd86-9c81b9b80ef4', N'1a307ad6-1b9a-4ce4-bd44-ddd17d42f9c4', N'มีคู่มือ หรือใบกิจกรรม ใบความรู้ เป็นเครื่องมือประกอบการจัดการเรียนรู้ มีเอกสารแสดงร่องรอยการจัดกิจกรรมการจดทะเบียนบริษัทจำลอง กิจกรรมการนำเข้าวัตถุดิบ การผลิต แปรรูป บรรจุภัณฑ์ จัดจำหน่าย และบัญชีรายรับรายจ่าย ครบและชัดเจน', 10, 3, CAST(0x0000A5A3008ED154 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'9bc8803a-1397-4d9b-bec9-c53186c5371a', N'797e3d48-fdba-4509-9695-f3639f3f1eda', N'มีการออกใบรับรองตามเกณฑ์การผ่านสมรรถนะตามสาขาอาชีพ มีความร่วมมือจัดทำหลักสูตรตามสมรรถนะสาขาอาชีพแบบต่าง ๆ ตามความต้องการของนักเรียน', 3, 2, CAST(0x0000A5A201116C18 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'9e2feb15-bc9e-4ed8-9ad8-843b4539bdf3', N'b07adf50-c9c1-4107-8888-2701e656ff49', N'มีระดับผลการเรียนเฉลี่ยตั้งแต่ ๒.๕๐ ขึ้นไป และมีกราฟหรือเอกสารอื่นที่แสดงทิศทางระดับผลการเรียนด้านความรู้ ด้านทักษะ และด้านเจตนคติที่สอดคล้องดีขึ้นทิศทางเดียวกัน มีระดับผลการการเรียนเฉลี่ยในรายวิชาเพิ่มเติมตามหลักสูตรสมรรถนะสาขาวิชาชีพตั้งแต่ ๓.๐๐ ขึ้นไป', 7, 2, CAST(0x0000A5A30094BB64 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'a0006adc-5ec0-4356-9135-1ea46100cdfc', N'66ea0dab-63b6-420a-aaac-43adf1044fae', N'-', 0, 1, CAST(0x0000A5A700E64150 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'a05602f4-8e58-4e43-a823-e89b075148f8', N'd75eac0b-3571-4fb3-b36b-9c0cac4bfd56', N'มีผังมโนทัศน์แสดงหน่วยเรียนรู้บูรณาการ  มีกิจกรรมการสำรวจแหล่งเรียนรู้ร่วมกันระหว่างครูกับนักเรียน มีกิจกรรมการจัดทำหน่วยเรียนรู้บูรณาการระดับชั้นแบบไม่แยกส่วนมีจำนวนมากกว่า ๕ วิชา และมีเอกสารตารางวิเคราะห์มาตรฐานการเรียนรู้และตัวชี้วัด  รูปถ่าย หรือหลักฐานอื่นที่แสดงร่องรอยการปฏิบัติการสำรวจจริงเป็นหลักฐาน', 10, 3, CAST(0x0000A5A201142688 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'a306767d-2394-4975-9bd0-a9385df52a95', N'76388d62-cb26-421c-a473-8ca9ea949d9d', N'มีการออกแบบเหมาะการใช้งานโดดเด่นสวยงาม ใช้วัสดุอุปกรณ์ และวิธีการผลิตที่เหมาะสมและเป็นมิตรกับธรรมชาติและสิ่งแวดล้อม', 10, 3, CAST(0x0000A5A300B3DAF8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'a394108d-4514-4c60-ada3-38b9cdce08bc', N'85cf52b4-0e46-499b-96e9-e20f2402b044', N'มีเอกสารแต่ไม่ได้แสดงที่มาของปัญหาหรือประเด็นสนใจและประโยชน์ที่จะเกิดขึ้น และขาดร่องรอยหลักฐานต่าง ๆ ที่แสดงถึงความต้องการต่อยอดพัฒนากระบวนการผลิต หรือพัฒนาผลิตภัณฑ์ หรือพัฒนานวัตกรรม', 3, 1, CAST(0x0000A5A30096684C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'a49ff35f-a08d-4897-917a-e1a061053e9e', N'c9599360-0962-4654-b86c-d6dc29bc1cac', N'มีโปรแกรมการเรียนและโครงสร้างหลักสูตรตามสมรรถนะทางสาขาวิชาชีพ ตรงความต้องการอัตรากำลังแรงงาน และตรงกับความต้องการของนักเรียน ที่มีการจัดกิจกรรมสำรวจความต้องการ กิจกรรมความร่วมมือการจัดทำหลักสูตร และมีบันทึกความร่วมมือ หรือเอกสารแสดงการจัดกิจกรรมความต้องการ มีหนังสือการประสานงานเป็นหลักฐาน', 20, 3, CAST(0x0000A5A20107E0BC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'a59dfe4e-6886-490a-b2f8-75f078525eda', N'4bc80c63-0c83-4e68-91b6-c9d9f09abb9e', N'ยังไม่มีหลักสูตรตามสมรรถนะสาขาวิชาชีพ', 1, 1, CAST(0x0000A5A20111C2D0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'a5dda475-d61e-4947-a266-24f3c2b0f4c3', N'79aa2bfa-0f3d-457a-ba4b-e683e67d37ff', N'มีเอกสารการเรียบเรียงหลักความรู้และทฤษฎีความรู้ หรือผังมโนทัศน์ ยังขาดบรรณานุกรมความรู้บางส่วนที่แสดงความเชื่อถือได้ของทฤษฎีความรู้', 6, 2, CAST(0x0000A5A30097CC8C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'a61babed-b908-4db5-ae89-50759bc96d34', N'a416e5de-9ee0-4bc8-a303-fd14b53fb693', N'มีคลังทะเบียน มีสื่อแนะนำรายละเอียด และมีแผนความต้องการ ที่มีข้อมูลถูกต้อง และจัดทำขึ้นโดยความร่วมมือจากทุกภาคส่วน', 3, 2, CAST(0x0000A5A300BC58CC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'a7467d85-2ccc-478c-850d-c1c80119001f', N'6a821855-e867-4b9b-bba4-e2390103066b', N'ไม่มีคู่มือ หรือใบกิจกรรม ใบความรู้ เป็นเครื่องมือการเรียนรู้ มีการจัดกิจกรรม Project-Based ที่ยังไม่ชัดเจนไม่เป็นไปตามกระบวนการ', 5, 1, CAST(0x0000A5A2011C77D4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'a8475b02-cf9e-4391-9128-01fab08320c7', N'3973e3b2-08c7-4c10-bbed-11ef2c22f3c7', N'-', 2, 2, CAST(0x0000A5A700E56758 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'a865b2d0-99fd-4027-9b17-5036e288441a', N'8685b987-3452-4ce9-9f09-61bb584618ab', N'ยังไม่ได้จัดทำตารางสอนหน่วยเรียนรู้   บูรณาการ และตารางการฝึกและถอดประสบการณ์', 1, 1, CAST(0x0000A5A20115E2AC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'a96c6e40-a686-4f26-b51a-cd6be8655c73', N'a6e8e6c8-d98c-4166-b52d-a0005ec29ca6', N'-', 0, 1, CAST(0x0000A5A700E59188 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'a98d19ba-a1b2-4ec1-a0e8-da932cff2a7b', N'70285852-13af-4d35-9b00-5b6bfbf4f6ef', N'-', 0, 1, CAST(0x0000A5A700E41A88 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'a9c5a77b-f13b-47ed-84e0-7e510916ad30', N'83525fa0-28e5-40b6-b0e1-3e20511f089c', N'มีคลังทะเบียนแหล่งเรียนรู้ และมีการจัดกิจกรรม ยังไม่ชัดเจน ไม่เป็นรูปธรรม', 1, 1, CAST(0x0000A5A200BDF420 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'aa36f9da-3662-4fa9-a51d-8c3f0a41d9a1', N'87662abe-a397-42e8-8595-03a3730d7e87', N'มีเอกสารแผนการทำงาน มีเอกสารการบันทึกผลและอธิบายความเป็นไปได้ทุกกระบวนการและขั้นตอน และมีรูปถ่าย วิดีโอ หรือเอกสารร่องรอยอื่นที่แสดงกิจกรรมการทำงาน การสรุป นำเสนอด้วยวิธีที่หลากหลาย', 10, 3, CAST(0x0000A5A30099C7F8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'aa5ac9ab-c131-46a7-b6d6-877d5d864b65', N'4241621c-34b3-4ac5-8e6c-7a7c91384b1b', N'-', 0, 1, CAST(0x0000A5A700E517A8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'aab03fb5-64f5-4c72-a919-02873fbf302f', N'2a4c794b-cce5-4e31-9483-e30dd78dc8e7', N'มีใบกิจกรรม ใบความรู้ของกิจกรรมตามกรอบบันได ๕ ขั้น แบบ Problem-Based Learning ของคณะครูระดับชั้น มีเอกสารแสดงการบันทึกผลสรุปจากกระบวนการเรียนรู้แบบชุมชนแห่งการเรียนรู้วิชาชีพ (Professional Learning Community: PLC) ของครูระดับชั้นที่แสดงรูปแบบการจัดกิจกรรม การพัฒนาการความก้าวหน้าของนักเรียนและแก้ไขปัญหา ในแต่ละกิจกรรม มีเอกสารแสดงร่องรอยการทำกิจกรรมของนักเรียนทุกกิจกรรม', 15, 3, CAST(0x0000A5A2011842E0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'aadeeea9-4a15-4100-a9df-aec534ff5631', N'60c83e52-8b84-445f-9063-09f4bb98b57b', N'-', 3, 2, CAST(0x0000A5A700E75838 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'ad738c84-79de-4bec-9755-11fc6999e178', N'5ab2630b-47ec-453a-8777-ef94a4bd6f21', N'มีเอกสารใบกิจกรรม ใบความรู้ และสื่อใช้เป็นเครื่องมือจัดการเรียนรู้ มีแผนและบันทึกผลการให้คำปรึกษาการทำผลงาน มีเอกสารร่องรอยการจัดกิจกรรมการคัดเลือกหรือประกวดผลงานนักเรียนที่ผ่านเกณฑ์คุณภาพ', 10, 2, CAST(0x0000A5A2011E4C94 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'aecf9f61-65d3-42b4-9189-14ab38a712ba', N'1a307ad6-1b9a-4ce4-bd44-ddd17d42f9c4', N'มีคู่มือ หรือใบกิจกรรม ใบความรู้ เป็นเครื่องมือประกอบการจัดการเรียนรู้ มีเอกสารแสดงร่องรอยการจัดกิจกรรมการ จดทะเบียนบริษัทจำลอง กิจกรรมการนำเข้าวัตถุดิบ การผลิต แปรรูป บรรจุภัณฑ์ จัดจำหน่าย และบัญชีรายรับรายจ่าย แสดงได้บางส่วน', 5, 2, CAST(0x0000A5A3008ED154 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'afa12905-fd04-4125-88ab-60908fb8d5bf', N'dadcbc2f-7d26-4063-996f-b3ce788bbb0a', N'ยังไม่ได้จัดทำผังมโนทัศน์แสดงหน่วยเรียนรู้บูรณาการ ยังไม่มีกระบวนการจัดทำ', 3, 1, CAST(0x0000A5A201147D40 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'b221a4dd-0389-4dc8-88b4-f1af2a4d1682', N'9ce80ffd-3506-4c3f-acb9-14ae52d76cd8', N'-', 3, 2, CAST(0x0000A5A700E70F90 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'b3d5583b-b5af-4598-a22b-6f97dc577d56', N'8f3f87e4-1809-43dd-b6ed-799e00a74546', N'มีโปรแกรมการเรียนและโครงสร้างหลักสูตรตามสมรรถนะทางสาขาวิชาชีพ ตรงความต้องการอัตรากำลังแรงงาน และตรงกับความต้องการของนักเรียน ที่มีการจัดกิจกรรมสำรวจความต้องการ กิจกรรมความร่วมมือการจัดทำหลักสูตร แต่ยังขาดเอกสารความร่วมมือเป็นหลักฐาน', 15, 2, CAST(0x0000A5A20107046C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'b47f67b6-9774-47db-b849-71c61e46625f', N'b088599b-7cb8-45e1-924f-43738ece3e77', N'มีแผนการเรียนรู้ หรือคู่มือการฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะสาขาวิชาชีพ มีใบกิจกรรม ใบความรู้ และสื่อเป็นเครื่องมือ มีกิจกรรมของคณะครูในรายวิชาเพิ่มเติม ผ่าน PLC จัดทำแผนการเรียนรู้ หรือคู่มือการเรียนรู้รองรับหลักสูตรต่าง ๆ ตามความต้องการของนักเรียน มีกิจกรรมตามกระบวนการของการเรียนรู้แบบฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะวิชาชีพครบทุกกระบวนการ และมีเอกสารแผนการเรียนรู้ หรือคู่มือครบตามแผนการเปิดหลักสูตร มีเอกสารแสดงร่องรอยการบันทึกสรุปผลการฝึกและถอดประสบการของนักเรียน', 15, 3, CAST(0x0000A5A2011AD578 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'b4b2a7f9-fd55-4097-8ded-8f05c438afda', N'282b01c9-9ac6-4923-b94b-3f4cee8f8dd7', N'การจัดระบบกานำเทคโนโลยียังไม่ต่อเชื่อมเป็นระบบ ไม่มีการพัฒนาต่อยอดให้เป็นรูปธรรม', 8, 1, CAST(0x0000A5A20113238C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'b6eb4bd3-d411-46c9-90c8-c999152876c5', N'8afc3073-833c-407c-af41-69ddcf11f307', N'มีเอกสารเครื่องมือและผลการวัดผลการพัฒนาของนักเรียนตามประเภท (K, P, A) และระดับขั้นพฤติกรรม และหลักความรู้ และตรงกับที่ระบุในมาตรฐานการเรียนรู้และตัวชี้วัดรายวิชา มีร่องรอยหลักฐานแสดงการวิเคราะห์มาตรฐานการเรียนรู้และตัวชี้วัดรายวิชายังไม่ถูกต้องชัดเจน  มีเอกสารแผนการเลือกตัวชี้วัดรายวิชาที่สำคัญที่เป็นตัวแทน และมีเอกสารแสดงการใช้และผลการประเมินบุคลิกภาพของนักเรียนรายบุคคลใช้เป็นข้อมูลเลือกโปรแกรมการเรียน', 5, 2, CAST(0x0000A5A3009339D8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'b74f7965-92ca-4f6e-9097-2836cfa904c8', N'5f6ee31e-6f4b-41e1-bfdd-e9a4f760dfcf', N'ยังไม่สามารถแก้ปัญหาตามวัตถุประสงค์ถึงแม้จะใช้งานได้จริง', 3, 1, CAST(0x0000A5A3009B346C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'b76df386-1c0c-4ed6-bb68-16f3e869607a', N'0ebed82d-8c45-45bb-8145-7723a7ba254f', N'มีผังมโนทัศน์แสดงหน่วยเรียนรู้บูรณาการ  มีกิจกรรมการสำรวจแหล่งเรียนรู้ร่วมกันระหว่างครูกับนักเรียน มีกิจกรรมการจัดทำหน่วยเรียนรู้บูรณาการระดับชั้นแบบไม่แยกส่วนมีจำนวนมากกว่า ๕ วิชา และมีเอกสารตารางวิเคราะห์มาตรฐานการเรียนรู้และตัวชี้วัด  รูปถ่าย หรือหลักฐานอื่นที่แสดงร่องรอยการปฏิบัติการสำรวจจริงเป็นหลักฐาน', 10, 3, CAST(0x0000A5A20113B158 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'b839c693-807f-4da2-8bb9-7c63413fbef5', N'203a364c-98d6-42db-a21f-f58cd3569cba', N'มีแผนการเรียนรู้ หรือคู่มือการฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะสาขาวิชาชีพ มีใบกิจกรรม ใบความรู้ และสื่อเป็นเครื่องมือ มีกิจกรรมของคณะครูในรายวิชาเพิ่มเติม ผ่าน PLC จัดทำแผนการเรียนรู้ หรือคู่มือการเรียนรู้รองรับหลักสูตรต่าง ๆ ตามความต้องการของนักเรียน มีกิจกรรมตามกระบวนการของการเรียนรู้แบบฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะวิชาชีพครบยังไม่ครบทุกกระบวนการ และมีเอกสารแผนการเรียนรู้ หรือคู่มือไม่ครบตามแผนการเปิดหลักสูตร และยังขาดหรือมีเอกสารไม่สมบูรณ์แสดงร่องรอยการบันทึกสรุปผลการฝึกและถอดประสบการของนักเรียน', 10, 2, CAST(0x0000A5A2011BEB34 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'b862aa9e-bc07-4514-a924-3ed8104c657b', N'6a821855-e867-4b9b-bba4-e2390103066b', N'มีเอกสารใบกิจกรรม ใบความรู้ และสื่อใช้เป็นเครื่องมือจัดการเรียนรู้ มีแผนและบันทึกผลการให้คำปรึกษาการทำผลงาน มีเอกสารร่องรอยการจัดกิจกรรมการสืบค้นแลกเปลี่ยนเรียนรู้ กิจกรรมสร้างแรงบันดานใจตั้งประเด็นสนใจพัฒนานวัตกรรม กิจกรรมการปฏิบัติตามกระบวนการละขั้นตอน และอธิบายผลปรากฎการณ์กับทฤษฎีความรู้ กิจกรรมการสรุปผล สื่อสาร นำเสนอด้วยวิธีที่หลากหลาย และกิจกรรมการคัดเลือกหรือประกวดผลงานนักเรียนที่ผ่านเกณฑ์คุณภาพ', 15, 3, CAST(0x0000A5A2011C77D4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'b8a43a4c-fe93-442b-9b94-5ffe24f8eb18', N'4e0ce081-d759-4113-882e-71f1d241ee12', N'มีเอกสารแต่ไม่ได้แสดงที่มาของปัญหาหรือประเด็นสนใจและประโยชน์ที่จะเกิดขึ้น และขาดร่องรอยหลักฐานต่าง ๆ ที่แสดงถึงความต้องการต่อยอดพัฒนากระบวนการผลิต หรือพัฒนาผลิตภัณฑ์ หรือพัฒนานวัตกรรม', 3, 1, CAST(0x0000A5A3009590AC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'b9470c64-71cc-4bdc-ba0e-152256a9f70f', N'76388d62-cb26-421c-a473-8ca9ea949d9d', N'มีการออกแบบเหมาะการใช้งานโดดเด่น ใช้วัสดุอุปกรณ์ และวิธีการผลิตที่เหมาะสม ยังขาดความเป็นมิตรกับธรรมชาติ และสิ่งแวดล้อม', 6, 2, CAST(0x0000A5A300B3DAF8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'b98c7520-5fac-4519-83fc-fb23553ce908', N'927bf4bd-a9a2-40a8-a2d2-3d4cf45a1cdf', N'มีเอกสารแผนการทำงาน มีเอกสารการบันทึกผลและอธิบายความเป็นไปได้ทุกกระบวนการและขั้นตอน ขาดร่องรอยหลักฐานมีที่แสดงกิจกรรมการทำงาน การสรุป และการนำเสนอด้วยวิธีที่หลากหลาย', 6, 2, CAST(0x0000A5A3009A18D4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'b9eb68d8-718c-40c2-8596-5a4c7736efc4', N'993fc983-87e0-4d21-b062-023e6238a3ed', N'มีเอกสารเครื่องมือและผลการวัดผลการพัฒนาของนักเรียนตามประเภท (K, P, A) และระดับขั้นพฤติกรรม และหลักความรู้ และตรงกับที่ระบุในมาตรฐานการเรียนรู้และตัวชี้วัดรายวิชา มีร่องรอยหลักฐานแสดงการวิเคราะห์มาตรฐานการเรียนรู้และตัวชี้วัดรายวิชายังไม่ถูกต้องชัดเจน  มีเอกสารแผนการเลือกตัวชี้วัดรายวิชาที่สำคัญที่เป็นตัวแทน และมีเอกสารแสดงการใช้และผลการประเมินบุคลิกภาพของนักเรียนรายบุคคลใช้เป็นข้อมูลเลือกโปรแกรมการเรียน', 5, 2, CAST(0x0000A5A30090AE48 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'ba578311-9ad5-45cf-8fe2-b1dd1094efe1', N'a9aff62e-9315-4fe7-87eb-ff9508d83a2c', N'-', 3, 2, CAST(0x0000A5A700E61F54 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'ba8f6dac-1ce9-4b46-a3b6-a16a0bd4e023', N'96948f03-0fb5-419d-9bd1-d678f97051e9', N'มีใบกิจกรรม ใบความรู้ของกิจกรรมตามกรอบบันได ๕ ขั้น แบบ Problem-Based Learning ของคณะครูระดับชั้น มีเอกสารแสดงการบันทึกผลสรุปจากกระบวนการเรียนรู้แบบชุมชนแห่งการเรียนรู้วิชาชีพ (Professional Learning Community: PLC) ของครูระดับชั้นที่แสดงรูปแบบการจัดกิจกรรม การพัฒนาการความก้าวหน้าของนักเรียนและแก้ไขปัญหา ในแต่ละกิจกรรม มีเอกสารแสดงร่องรอยการทำกิจกรรมของนักเรียนทุกกิจกรรม', 15, 3, CAST(0x0000A5A2011702F4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'bac8d5d4-945e-432e-af25-34cd8a69fdb1', N'84360abb-dcc7-4ebe-9dbc-652e3ef0ae2c', N'-', 3, 2, CAST(0x0000A5A700E4A4D0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'bd69f653-ecb0-4585-87a3-f3b6c854b2c7', N'53dfd0b2-7aa4-41c6-9878-fd12ef69cb2f', N'มีระดับผลการเรียนเฉลี่ยน้อยกว่า ๒.๕๐ ในรายวิชาเพิ่มเติมเฉลี่ยน้อยกว่า ๓.๐๐ มีเอกสารการเข้าร่วมการเรียนรู้การเป็นผู้ประกอบการไม่ชัดเจน', 5, 1, CAST(0x0000A5A30093E61C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'bdc74a52-26ea-45b2-a89b-0ce105ade29f', N'c962d40c-cbba-4cfd-8a71-8b202ef9e506', N'-', 0, 1, CAST(0x0000A5A700E38488 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'be54602e-d2c9-4292-90b8-cd7604eb2044', N'8c597661-1934-4b3b-9e35-743b9dc3be05', N'จัดทำใบกิจกรรม ใบความรู้ ยังไม่เป็นไปตามกรอบบันได ๕ ขั้น ของกิจกรรมแบบ Problem-Based Learning', 5, 1, CAST(0x0000A5A20117E2C8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'c4862b36-04ac-4250-90bc-6b1d0dd84216', N'927bf4bd-a9a2-40a8-a2d2-3d4cf45a1cdf', N'มีเอกสารแผนการทำงาน มีเอกสารการบันทึกผลและอธิบายความเป็นไปได้ทุกกระบวนการและขั้นตอน และมีรูปถ่าย วิดีโอ หรือเอกสารร่องรอยอื่นที่แสดงกิจกรรมการทำงาน การสรุป นำเสนอด้วยวิธีที่หลากหลาย', 10, 3, CAST(0x0000A5A3009A18D4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'c58a0f21-8370-464b-8281-66710ec87247', N'ba44b17b-3f0e-4a9b-9485-920b3a093895', N'มีรายวิชาเพิ่มเติมแสดงรูปแบบการจัดหลักสูตรวิชาชีพระยะสั้น ทวิศึกษา และสมรรถนะสาขาวิชาชีพตามสาขาการศึกษาต่อในระดับอุดมศึกษา และมีผังมโนทัศน์หน่วยเรียนรู้บูรณาการแสดงรูปแบบการจัดพื้นฐานทักษะการเรียนรู้ในศตวรรษที่ ๒๑ และมีแสดงผลการเรียนรู้ เป็นหลักฐาน', 20, 2, CAST(0x0000A5A20108B730 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'c64b62c9-caf8-408d-874f-dd226258ed04', N'83525fa0-28e5-40b6-b0e1-3e20511f089c', N'มีคลังทะเบียนแหล่งเรียนรู้ มีสื่อแนะนำรายละเอียด และมีการจัดกิจกรรมความร่วมมือและสำรวจความต้องการที่จะเรียนรู้ และมีเอกสารความต้องการที่จะเรียนรู้ร่วมกันเป็นหลักฐาน', 3, 2, CAST(0x0000A5A200BDF420 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'c74f0d43-3f90-4b3c-8078-fc154be6b2c5', N'a416e5de-9ee0-4bc8-a303-fd14b53fb693', N'มีคลังทะเบียน มีสื่อแนะนำรายละเอียด และมีแผนความต้องการ ที่มีข้อมูลถูกต้องเป็นปัจจุบัน และจัดทำขึ้นโดยความร่วมมือจากทุกภาคส่วน ที่มีบันความร่วมมือ เอกสารหนังสือการประสานงานเป็นหลักฐาน', 5, 3, CAST(0x0000A5A300BC58CC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'c8828d4b-0e7c-4edd-8f15-34474178f36b', N'665a4b09-091a-4412-b687-60e635f52923', N'มีคลังทะเบียน มีสื่อแนะนำรายละเอียด และมีแผนความต้องการ ที่มีข้อมูลถูกต้องเป็นปัจจุบัน และจัดทำขึ้นโดยความร่วมมือจากทุกภาคส่วน ที่มีบันความร่วมมือ เอกสารหนังสือการประสานงานเป็นหลักฐาน', 5, 3, CAST(0x0000A5A200BB2F24 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'c91d845f-61ee-4059-ac10-b30668de81d6', N'c792c70e-80d3-44c0-813a-d4da7c471a05', N'-', 4, 2, CAST(0x0000A5A700E47AA0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'cadc063c-1c02-479f-ba85-76753b26b2a2', N'a422fdb1-cf28-43cb-bdec-66122809c5f3', N'ไม่มีคู่มือ หรือใบกิจกรรม ใบความรู้ เป็นเครื่องมือการเรียนรู้ มีการจัดกิจกรรม Project-Based ที่ยังไม่ชัดเจนไม่เป็นไปตามกระบวนการ', 5, 1, CAST(0x0000A5A2011D44E8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'caf2b17c-25d3-477e-8abc-81212d08b077', N'282b01c9-9ac6-4923-b94b-3f4cee8f8dd7', N'มีระบบเทคโนโลยีช่วยการสนับสนุนการบริหารจัดการ การจัดกระบวนการเรียนรู้ และการเรียนรู้ของนักเรียน ที่มีการกำหนดในรูปกิจกรรมการเข้าไปใช้งานตลอดทั้งปีการศึกษา และมีเอกสารตารางการใช้และจำนวนปริมาณผู้ใช้ต่อเนื่องทุกวันทำการ    มีเอกสารระเบียบการใช้เทคโนโลยีของโรงเรียนและมีกิจกรรมการพัฒนาจริยธรรมการใช้ ICT ตามแนวทางของระเบียบ', 15, 3, CAST(0x0000A5A20113238C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'cb91dc5a-56af-4667-ad01-4073c9e27e66', N'd703eaf3-6258-4333-9db7-126a24e20267', N'มีเอกสารโครงร่าง Project-Based มีเอกสารทฤษฎีความรู้เขียนอธิบายทุกกระบวนการและขั้นตอนการเกิดสมมติฐานสอดคล้องกับการแก้ปัญหา สามารถนำไปใช้ได้จริง', 6, 2, CAST(0x0000A5A30098BA70 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'cc8e4843-ed3f-44eb-b648-137808c7824a', N'3973e3b2-08c7-4c10-bbed-11ef2c22f3c7', N'-', 0, 1, CAST(0x0000A5A700E56758 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'cd934475-7e25-42ec-9838-5029fc8ef8b5', N'993fc983-87e0-4d21-b062-023e6238a3ed', N'มีเอกสารเครื่องมือและผลการวัดผลการพัฒนาของนักเรียนตามประเภท (K, P, A) และระดับขั้นพฤติกรรม และหลักความรู้ ตรงกับที่ระบุในมาตรฐานการเรียนรู้และตัวชี้วัดรายวิชา มีร่องรอยหลักฐานแสดงการวิเคราะห์มาตรฐานการเรียนรู้และตัวชี้วัดรายวิชา  มีเอกสารแผนการเลือกตัวชี้วัดรายวิชาที่สำคัญที่เป็นตัวแทน มีเอกสารแสดงรูปแบบการแปลและแสดงผลการประเมินความสมดุลเชิงคุณภาพของนักเรียนรายบุคคล มีเอกสารเครื่องมือและผลการประเมินระดับคุณภาพการเกิดสมรรถนะ และคุณลักษณะ ตลอดจนค่านิยม ๑๒ ประการ และมีเอกสารแสดงการใช้และผลการประเมินบุคลิกภาพของนักเรียนรายบุคคลใช้เป็นข้อมูลเลือกโปรแกรมการเรียน', 10, 3, CAST(0x0000A5A30090AE48 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'ce3bd19d-a5b6-496e-bd91-fb8871605353', N'86b37ec9-2e4c-4877-8f9b-04be13e14cc0', N'-', 4, 2, CAST(0x0000A5A700E7318C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'cee8bdad-35a5-4f41-8a44-a2ff611b3351', N'48038dcf-9986-4adc-a99e-8d9236d82ea1', N'มีระดับผลการเรียนเฉลี่ยตั้งแต่ ๒.๕๐ ขึ้นไป และมีกราฟหรือเอกสารอื่นที่แสดงทิศทางระดับผลการเรียนด้านความรู้ ด้านทักษะ และด้านเจตนคติที่สอดคล้องดีขึ้นทิศทางเดียวกัน มีระดับผลการการเรียนเฉลี่ยในรายวิชาเพิ่มเติมตามหลักสูตรสมรรถนะสาขาวิชาชีพตั้งแต่ ๓.๐๐ ขึ้นไป', 7, 2, CAST(0x0000A5A300946254 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'cf343a85-c7e5-4815-a9a4-bd12458bfdb5', N'665a4b09-091a-4412-b687-60e635f52923', N'มีคลังทะเบียน มีสื่อแนะนำรายละเอียด และมีแผนความต้องการ ที่มีข้อมูลถูกต้อง และจัดทำขึ้นโดยความร่วมมือจากทุกภาคส่วน', 3, 2, CAST(0x0000A5A200BB2F24 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'cfe332e5-4a47-42df-b302-f3ab6fe278c7', N'70285852-13af-4d35-9b00-5b6bfbf4f6ef', N'-', 2, 2, CAST(0x0000A5A700E41A88 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'd0ff5570-4fb1-4f4f-8c39-cd151ff796b4', N'9dac559a-7585-47ee-b545-4af71cd1b1fc', N'มีการจัดรูปแบบการพัฒนาสมรรถนะทางสาขาวิชาชีพให้กับนักเรียนในวิชาเพิ่มเติมยังไม่ชัดเจน ไม่เป็นรูปธรรม', 10, 1, CAST(0x0000A5A20109EB64 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'd2fdae82-421e-42ef-a8c5-a6b02d965534', N'1b9a6618-ece6-4134-9b64-4b7af263ebd0', N'มีเอกสารการเรียบเรียงหลักความรู้และทฤษฎีความรู้ หรือผังมโนทัศน์ ยังขาดบรรณานุกรมความรู้ที่แสดงความเชื่อถือได้ของทฤษฎีความรู้', 3, 1, CAST(0x0000A5A300970D88 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'd34ccf65-7fc5-400f-8a63-ddf5848ab183', N'e6625304-5dec-4bc1-8c00-3c0f9d8c939e', N'มีเอกสารโครงร่าง Project-Based ขาดเอกสารทฤษฎีความรู้ที่เขียนอธิบายกระบวนการและขั้นตอนการเกิดสมมติฐาน', 3, 1, CAST(0x0000A5A300988488 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'd45ea478-cf91-4c9e-927e-cbd3a61c1702', N'203a364c-98d6-42db-a21f-f58cd3569cba', N'มีแผนการเรียนรู้ หรือคู่มือการฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะสาขาวิชาชีพ มีใบกิจกรรม ใบความรู้ และสื่อเป็นเครื่องมือ มีกิจกรรมของคณะครูในรายวิชาเพิ่มเติม ผ่าน PLC จัดทำแผนการเรียนรู้ หรือคู่มือการเรียนรู้รองรับหลักสูตรต่าง ๆ ตามความต้องการของนักเรียน มีกิจกรรมตามกระบวนการของการเรียนรู้แบบฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะวิชาชีพครบทุกกระบวนการ และมีเอกสารแผนการเรียนรู้ หรือคู่มือครบตามแผนการเปิดหลักสูตร มีเอกสารแสดงร่องรอยการบันทึกสรุปผลการฝึกและถอดประสบการของนักเรียน', 15, 3, CAST(0x0000A5A2011BEB34 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'd5627258-55ab-4b3c-a458-9ca7fb1b55b8', N'4e0ce081-d759-4113-882e-71f1d241ee12', N'มีเอกสารแต่การแสดงที่มาของปัญหาหรือประเด็นสนใจและประโยชน์ที่จะเกิดขึ้นยังไม่ชัดเจน และมีร่องรอยหลักฐานต่าง ๆ ไม่ครบสมบูรณ์ที่แสดงถึงความต้องการต่อยอดพัฒนากระบวนการผลิต หรือพัฒนาผลิตภัณฑ์ หรือพัฒนานวัตกรรม', 6, 2, CAST(0x0000A5A3009590AC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'd603d9df-1f8a-47ea-80a9-5c28e9d1d09a', N'a7d1ab3f-ec96-4170-9072-2dc7d3edf61b', N'มีคลังทะเบียนแหล่งเรียนรู้ มีสื่อแนะนำรายละเอียด และมีการจัดกิจกรรมความร่วมมือและสำรวจความต้องการที่จะเรียนรู้ ที่มีข้อมูลถูกต้องเป็นปัจจุบัน และมีคำสั่ง หรือเอกสารการมอบหมายงาน และเอกสารความต้องการที่จะเรียนรู้ร่วมกันเป็นหลักฐาน', 5, 3, CAST(0x0000A5A200BE36EC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'd84a6dcc-4e99-4f8e-bc67-1d32c742ac0c', N'156ff13a-bb20-4f7f-97d0-cec604b4b8e9', N'มีคู่มือ หรือใบกิจกรรม ใบความรู้ เป็นเครื่องมือประกอบการจัดการเรียนรู้ มีเอกสารแสดงร่องรอยการจัดกิจกรรมการ จดทะเบียนบริษัทจำลอง กิจกรรมการนำเข้าวัตถุดิบ การผลิต แปรรูป บรรจุภัณฑ์ จัดจำหน่าย และบัญชีรายรับรายจ่าย แสดงได้บางส่วน', 5, 2, CAST(0x0000A5A3008E8780 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'd8738cdf-e924-4be1-8fe1-bc87e86cf9bc', N'9af1f6ba-9b23-42e0-80e5-b945ed5c45ff', N'มีการนำเสนอเผยแพร่การใช้งานนำไปสู่ช่องทางการใช้ประโยชน์ การสร้างงานและพัฒนางานอาชีพของชุมชน สังคม และประเทศชาติ', 5, 3, CAST(0x0000A5A300B4BD24 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'd8fa083c-d542-4c44-8974-616808b9bab8', N'156ff13a-bb20-4f7f-97d0-cec604b4b8e9', N'มีคู่มือ หรือใบกิจกรรม ใบความรู้ เป็นเครื่องมือประกอบการจัดการเรียนรู้ มีเอกสารแสดงร่องรอยการจัดกิจกรรมการจดทะเบียนบริษัทจำลอง กิจกรรมการนำเข้าวัตถุดิบ การผลิต แปรรูป บรรจุภัณฑ์ จัดจำหน่าย และบัญชีรายรับรายจ่าย ครบและชัดเจน', 10, 3, CAST(0x0000A5A3008E8780 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'e04c985a-026d-4407-ab3d-1ce6d5361026', N'c193aa26-c5db-42f2-95c9-41187e7ef891', N'มีการออกใบรับรองตามเกณฑ์การผ่านสมรรถนะตามสาขาอาชีพ มีความร่วมมือจัดทำหลักสูตรตามสมรรถนะสาขาอาชีพแบบต่าง ๆ ตามความต้องการของนักเรียน  และมีเอกสารความร่วมมือ หรือเอกสารการประสานงาน และเอกสารการออกหลักฐานการประเมินสมรรถนะตามสาขาวิชาชีพเป็นหลักฐาน', 5, 3, CAST(0x0000A5A20110EC5C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'e2074dcd-552c-4d88-8af1-34611f7283e4', N'2fc2d6af-4bea-4552-a7c8-179a9c2fd911', N'ยังไม่ได้จัดทำตารางสอนหน่วยเรียนรู้   บูรณาการ และตารางการฝึกและถอดประสบการณ์', 1, 1, CAST(0x0000A5A201154F04 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'e2cdb719-f0d1-4ef8-9abf-a8b3736916c5', N'ae9bdc9a-4154-49aa-ae0e-36d51230f07b', N'มีโปรแกรมการเรียนที่มีโครงสร้างหลักสูตรยังไม่สอดคล้องความต้องการ และยังขาดร่องรอยหลักฐาน', 10, 1, CAST(0x0000A5A200FBC9D0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'e2ebffab-45f6-468c-afe7-17f1cc4b53ca', N'8afc3073-833c-407c-af41-69ddcf11f307', N'มีร่องรอยหลักฐานแสดงการวิเคราะห์มาตรฐานการเรียนรู้และตัวชี้วัดรายวิชายังไม่ถูกต้องชัดเจน และมีเอกสารแสดงการวัดผลประเมินผลยังไม่มีคุณภาพสูง และยังไม่ไดแสดงผลความสมดุลเชิงคุณภาพของนักเรียนรายบุคคล', 3, 1, CAST(0x0000A5A3009339D8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'e3b3bcae-ef9d-481a-8e45-106d28a9d1d5', N'6076e517-5ab2-403c-85eb-aa3ac42940cc', N'มีร่องรอยหลักฐานแสดงการวิเคราะห์มาตรฐานการเรียนรู้และตัวชี้วัดรายวิชายังไม่ถูกต้องชัดเจน และมีเอกสารแสดงการวัดผลประเมินผลยังไม่มีคุณภาพสูง และยังไม่ไดแสดงผลความสมดุลเชิงคุณภาพของนักเรียนรายบุคคล', 3, 1, CAST(0x0000A5A3009281DC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'e998bc96-d7d4-486c-89a1-1dc827694724', N'c9599360-0962-4654-b86c-d6dc29bc1cac', N'มีโปรแกรมการเรียนที่มีโครงสร้างหลักสูตรยังไม่สอดคล้องความต้องการ และยังขาดร่องรอยหลักฐาน', 10, 1, CAST(0x0000A5A20107E0BC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'ed04df8d-1ff5-4952-b20a-2c91dabeb0b9', N'1b9a6618-ece6-4134-9b64-4b7af263ebd0', N'มีเอกสารการเรียบเรียงหลักความรู้และทฤษฎีความรู้ หรือผังมโนทัศน์ ยังขาดบรรณานุกรมความรู้บางส่วนที่แสดงความเชื่อถือได้ของทฤษฎีความรู้', 6, 2, CAST(0x0000A5A300970D88 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'ed664cf8-5916-41a6-88a3-86fddb3ed5ab', N'ba44b17b-3f0e-4a9b-9485-920b3a093895', N'มีรายวิชาเพิ่มเติมแสดงรูปแบบการจัดหลักสูตรวิชาชีพระยะสั้น ทวิศึกษา และสมรรถนะสาขาวิชาชีพตามสาขาการศึกษาต่อในระดับอุดมศึกษา และมีผังมโนทัศน์หน่วยเรียนรู้บูรณาการแสดงรูปแบบการจัดพื้นฐานทักษะการเรียนรู้ในศตวรรษที่ ๒๑ และจัดกิจกกรมการสำรวจความต้องการ จัดกิจกรรมความร่วมมือการจัดทำคู่มือการเรียนแบบฝึกและถอดประสบการณ์ และมีเอกสารประสานงาน เอกสารแสดงผลการเรียนรู้ และเอกสารคู่มือเป็นหลักฐาน', 25, 3, CAST(0x0000A5A20108B730 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'edb4006c-fb82-4971-aa2d-b21977de9a6c', N'5865fd39-f2f9-43b8-ad41-2b1d01441565', N'-', 3, 2, CAST(0x0000A5A700E4F6D8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'ef26d798-5f96-49b5-94d8-b3d9cee7b820', N'ffb04e0e-5ae2-4865-906e-dafb30c32c18', N'มีรายวิชาเพิ่มเติมแสดงรูปแบบการจัดหลักสูตรวิชาชีพระยะสั้น ทวิศึกษา และสมรรถนะสาขาวิชาชีพตามสาขาการศึกษาต่อในระดับอุดมศึกษา และมีผังมโนทัศน์หน่วยเรียนรู้บูรณาการแสดงรูปแบบการจัดพื้นฐานทักษะการเรียนรู้ในศตวรรษที่ ๒๑ และมีแสดงผลการเรียนรู้ เป็นหลักฐาน', 20, 2, CAST(0x0000A5A20109611C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'ef2ebc33-5066-4892-a46c-f042317f636d', N'8f06b0bb-e1ae-4cd0-af99-fdb768c47de8', N'มี Portfolios มีเครื่องมือและผลการวัดและประเมินบุคลิกภาพ ความถนัด ทักษะ คุณลักษณะ และผลงานของนักเรียนรายบุคคล มีกิจกรรมแนะแนวอาชีพ และมีเอกสาร Portfolios เอกสารรายงานผลบุคลิกภาพ ความถนัด ทักษะ คุณลักษณะ และผลงานเป็นหลักฐาน', 3, 2, CAST(0x0000A5A300C67320 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'f0240df2-3f8d-43fe-92a6-aafd1f1c2c2f', N'993fc983-87e0-4d21-b062-023e6238a3ed', N'มีร่องรอยหลักฐานแสดงการวิเคราะห์มาตรฐานการเรียนรู้และตัวชี้วัดรายวิชายังไม่ถูกต้องชัดเจน และมีเอกสารแสดงการวัดผลประเมินผลยังไม่มีคุณภาพสูง และยังไม่ไดแสดงผลความสมดุลเชิงคุณภาพของนักเรียนรายบุคคล', 3, 1, CAST(0x0000A5A30090AE48 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'f1e2438a-20eb-4fa9-99a8-aaf8a73310e5', N'b088599b-7cb8-45e1-924f-43738ece3e77', N'มีแผนการเรียนรู้ หรือคู่มือการฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะสาขาวิชาชีพ มีใบกิจกรรม ใบความรู้ และสื่อเป็นเครื่องมือ มีกิจกรรมของคณะครูในรายวิชาเพิ่มเติม ผ่าน PLC จัดทำแผนการเรียนรู้ หรือคู่มือการเรียนรู้รองรับหลักสูตรต่าง ๆ ตามความต้องการของนักเรียน มีกิจกรรมตามกระบวนการของการเรียนรู้แบบฝึกและถอดประสบการณ์ความรู้ตามสมรรถนะวิชาชีพครบยังไม่ครบทุกกระบวนการ และมีเอกสารแผนการเรียนรู้ หรือคู่มือไม่ครบตามแผนการเปิดหลักสูตร และยังขาดหรือมีเอกสารไม่สมบูรณ์แสดงร่องรอยการบันทึกสรุปผลการฝึกและถอดประสบการของนักเรียน', 10, 2, CAST(0x0000A5A2011AD578 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'f2dbbe8b-e43b-47f5-9248-607c91e2afcb', N'd75eac0b-3571-4fb3-b36b-9c0cac4bfd56', N'มีผังมโนทัศน์แสดงหน่วยเรียนรู้บูรณาการ  มีกิจกรรมการสำรวจแหล่งเรียนรู้ร่วมกันระหว่างครูกับนักเรียน มีกิจกรรมการจัดทำหน่วยเรียนรู้บูรณาการระดับชั้น มีจำนวนน้อยกว่า ๕ วิชา และมีเอกสารตารางวิเคราะห์มาตรฐานการเรียนรู้และตัวชี้วัด รูปถ่าย หรือหลักฐานอื่นที่แสดงร่องรอยการปฏิบัติการสำรวจจริงเป็นหลักฐาน', 5, 2, CAST(0x0000A5A201142688 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'f328c5ec-1591-42ec-b6f4-8655239163c7', N'797e3d48-fdba-4509-9695-f3639f3f1eda', N'มีการออกใบรับรองตามเกณฑ์การผ่านสมรรถนะตามสาขาอาชีพ มีความร่วมมือจัดทำหลักสูตรตามสมรรถนะสาขาอาชีพแบบต่าง ๆ ตามความต้องการของนักเรียน  และมีเอกสารความร่วมมือ หรือเอกสารการประสานงาน และเอกสารการออกหลักฐานการประเมินสมรรถนะตามสาขาวิชาชีพเป็นหลักฐาน', 5, 3, CAST(0x0000A5A201116C18 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'f4ee7ec6-1c6f-4a33-99a3-f2deca3dbc46', N'a9aff62e-9315-4fe7-87eb-ff9508d83a2c', N'-', 0, 1, CAST(0x0000A5A700E61F54 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'f605ebbc-84e2-4e35-a659-f0ceb1da0546', N'bcc8193b-da4a-42be-9999-501e0bafcba4', N'-', 0, 1, CAST(0x0000A5A700E6D750 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'f7f129cd-d87f-459b-addd-663ccaf320d6', N'93a56cea-b6c6-4420-8f09-8f7fc68828f9', N'มีการบูรณาการทฤษฎีความรู้เพียง ๘ กลุ่มสาระการเรียนรู้', 3, 2, CAST(0x0000A5A300B20AE8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 1)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'f9ca7148-bc67-421f-b3d8-ec8a1906754b', N'83525fa0-28e5-40b6-b0e1-3e20511f089c', N'มีคลังทะเบียนแหล่งเรียนรู้ มีสื่อแนะนำรายละเอียด และมีการจัดกิจกรรมความร่วมมือและสำรวจความต้องการที่จะเรียนรู้ ที่มีข้อมูลถูกต้องเป็นปัจจุบัน และมีคำสั่ง หรือเอกสารการมอบหมายงาน และเอกสารความต้องการที่จะเรียนรู้ร่วมกันเป็นหลักฐาน', 5, 3, CAST(0x0000A5A200BDF420 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'f9ed0b5e-5a8a-4a5c-b114-9f2e933370bb', N'c532dfcc-781a-478f-98c3-4b7c834b2b0e', N'มี Portfolios มีเครื่องมือและผลการวัดและประเมินบุคลิกภาพ ความถนัด ทักษะ คุณลักษณะ และผลงานของนักเรียนรายบุคคล มีการจัดกิจกรรมสร้างความเข้าใจใช้รายงานผลจาก Portfolios ให้นักเรียนและผู้ปกครองเลือกโปรแกรมการเรียน มีกิจกรรมความร่วมมือกับหน่วยงานที่เกี่ยวข้องแนะแนวอาชีพตามความต้องการอัตรากำลังแรงงานของจังหวัด และมีเอกสาร Portfolios เอกสารรายงานผลบุคลิกภาพ ความถนัด ทักษะ คุณลักษณะ และผลงานเป็นหลักฐาน', 5, 3, CAST(0x0000A5A2010F41CC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'fac5f606-86a6-407a-b53b-ec1b91415fa5', N'53dfd0b2-7aa4-41c6-9878-fd12ef69cb2f', N'มีระดับผลการเรียนเฉลี่ยตั้งแต่ ๒.๗๕ ขึ้นไป และมีกราฟหรือเอกสารอื่นที่แสดงทิศทางระดับผลการเรียนด้านความรู้ ด้านทักษะ และด้านเจตนคติที่สอดคล้องดีขึ้นทิศทางเดียวกัน มีระดับผลการการเรียนเฉลี่ยในรายวิชาเพิ่มเติมตามหลักสูตรสมรรถนะสาขาวิชาชีพตั้งแต่ ๓.๐๐ ขึ้นไป มีเอกสารแสดงการผ่านการเข้าร่วมกิจกรรมการเรียนรู้เป็นผู้ประกอบการ และมีเอกสารที่แสดงการเข้าร่วมตามกระบวนการบันได ๕ ขั้น', 10, 3, CAST(0x0000A5A30093E61C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 0)

INSERT [dbo].[Education21Criterion] ([Education21CriterionID], [Education21IndicatorID], [Detail], [Score], [Sort], [UpdateDate], [UpdateUser], [RecNum]) VALUES (N'fff12792-6246-4b65-905c-f15d2350df04', N'1a307ad6-1b9a-4ce4-bd44-ddd17d42f9c4', N'ไม่มีคู่มือ หรือใบกิจกรรม ใบความรู้ เป็นเครื่องมือประกอบการจัดการเรียนรู้ และไม่มีมีเอกสารแสดงร่องรอยการจัดกิจกรรม', 3, 1, CAST(0x0000A5A3008ED154 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', 2)

End


------------- V 11.1.0.3 ---------------------
--เพิ่มฟิวส์รหัสรายการเบิกย่อย
Go
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('CostsDetail') And Name = 'ItemID')
Begin
	alter table CostsDetail add ItemID nVarchar(50)
End

Go
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ActivityCostsDetail') And Name = 'ItemID')
Begin
	alter table ActivityCostsDetail add ItemID nVarchar(50)
End

--ใส่รหัส ItemID ให้รายการ และ Update รายการเดิมทั้งหมด
Go
Update CostsDetail Set ItemID = newid() Where ItemID Is Null

Go
Update CostsDetail Set ItemID = newid() Where ItemID = ''

Go
Update ActivityCostsDetail 
Set ActivityCostsDetail.ItemID = (CostsDetail.ItemID) 
From ActivityCostsDetail inner join CostsDetail 
On ActivityCostsDetail.ActivityCode = CostsDetail.ActivityCode
And ActivityCostsDetail.EntryCostsCode = CostsDetail.ListName


------------------- V 11.1.0.4 ----------------------------
Go
--เพิ่มฟิวตัวเช็คโหมด เศรษฐกิจพอเพียง
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckSuffice')
Begin
	alter table MR_School add ckSuffice bit
End

Go
----------- เพิ่ม Table SufficeSide  ด้านเศรษฐกิจพอเพียง ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('SufficeSide'))
Begin
	CREATE TABLE [dbo].[SufficeSide](
		[SufficeSideID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[SufficeSideName] [nvarchar](300) NULL,
		[Detail] [nvarchar](2000) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_SufficeSide] PRIMARY KEY CLUSTERED 
	(
		[SufficeSideID] ASC
	)) ON [PRIMARY]
End

Go
----------- เพิ่ม Table SufficeStandard  องค์ประกอบเศรษฐกิจพอเพียง ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('SufficeStandard'))
Begin
	CREATE TABLE [dbo].[SufficeStandard](
		[SufficeStandardID] [nvarchar](50) NOT NULL,
		[SufficeSideID] [nvarchar](50) NOT NULL,
		[SufficeStandardName] [nvarchar](300) NULL,
		[Detail] [nvarchar](2000) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_SufficeStandard] PRIMARY KEY CLUSTERED 
	(
		[SufficeStandardID] ASC
	)) ON [PRIMARY]
End

Go
----------- เพิ่ม Table SufficeIndicator  ตัวบ่งชี้เศรษฐกิจพอเพียง ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('SufficeIndicator'))
Begin
	CREATE TABLE [dbo].[SufficeIndicator](
		[SufficeIndicatorID] [nvarchar](50) NOT NULL,
		[SufficeStandardID] [nvarchar](50) NOT NULL,
		[SufficeIndicatorName] [nvarchar](500) NULL,
		[Detail] [nvarchar](2000) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_SufficeIndicator] PRIMARY KEY CLUSTERED 
	(
		[SufficeIndicatorID] ASC
	)) ON [PRIMARY]
End

Go
----------- เพิ่ม Table dtSuffice  เชื่อมโยง โครงการกับเศรษฐกิจพอเพียง ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtSuffice'))
Begin
	CREATE TABLE [dbo].[dtSuffice](
		[ProjectsCode] [nvarchar](50) NULL,
		[SufficeIndicatorID] [nvarchar](50) NULL
	) ON [PRIMARY]
End

Go
--เพิ่มข้อมูลด้านเศรษฐกิจพอเพียง
If Not Exists(Select * From SufficeSide)                                                                                                                      
Begin
	INSERT [dbo].[SufficeSide] ([SufficeSideID], [StudyYear], [SufficeSideName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'0ef455e8-b3f6-4543-9809-f8dd45d32eec', 2558, N'ด้านผลลัพธ์/ภาพความสำเร็จ', N'', 5, 0, CAST(0x0000A5B500F59AA8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500F59AA8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeSide] ([SufficeSideID], [StudyYear], [SufficeSideName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'5d71403c-b4ce-4575-98fe-ea434cb71cb0', 2558, N'การจัดกิจกรรมพัฒนาผู้เรียน', N'', 3, 0, CAST(0x0000A5B500F53166 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500F53166 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeSide] ([SufficeSideID], [StudyYear], [SufficeSideName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'b235d01c-5ef5-4bdf-9310-21343cfa9203', 2558, N'การบริหารจัดการสถานศึกษา', N'', 1, 0, CAST(0x0000A5B500F46465 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500F46465 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeSide] ([SufficeSideID], [StudyYear], [SufficeSideName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'c599d1d1-e247-467c-992f-e4e346d5d1ce', 2558, N'การพัฒนาบุคลากรของสถานศึกษา', N'', 4, 0, CAST(0x0000A5B500F577A7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500F577A7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeSide] ([SufficeSideID], [StudyYear], [SufficeSideName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'dea59fb4-abef-4712-b999-f0d0118fb490', 2558, N'หลักสูตรและการจัดกิจกรรมการเรียนรู้', N'', 2, 0, CAST(0x0000A5B500F50B99 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500F50B99 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
End

Go
--เพิ่มข้อมูลองค์ประกอบศรษฐกิจพอเพียง
If Not Exists(Select * From SufficeStandard)                                                                                                                      
Begin
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'15ac977f-e581-46e8-94d7-2bdae2250a26', N'b235d01c-5ef5-4bdf-9310-21343cfa9203', N'บริหารทั่วไป', N'', 4, 0, CAST(0x0000A5B500F64A77 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500F64A77 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'2adb927a-e833-4027-a5ca-6a0bf1713bd7', N'c599d1d1-e247-467c-992f-e4e346d5d1ce', N'การพัฒนาบุคลากรตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 1, 0, CAST(0x0000A5B500FBDE0F AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500FBDE0F AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'42bedfbf-79a8-40c6-bbf1-06a973578b6d', N'c599d1d1-e247-467c-992f-e4e346d5d1ce', N'การติดตามและขยายผล', N'', 2, 0, CAST(0x0000A5B500FC1B4C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500FC1B4C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'486b7316-f59c-4ec9-8534-b925583df574', N'0ef455e8-b3f6-4543-9809-f8dd45d32eec', N'บุคลากรของสถานศึกษา', N'', 3, 0, CAST(0x0000A5B500FE9EE9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500FE9EE9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'4f4b18c4-36a5-4120-a417-eedef8076dd8', N'b235d01c-5ef5-4bdf-9310-21343cfa9203', N'นโยบาย', N'', 1, 0, CAST(0x0000A5B500F6055D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500F6055D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'581325cf-47bb-4d68-8790-e3eb5754c920', N'5d71403c-b4ce-4575-98fe-ea434cb71cb0', N'การแนะแนวและระบบดูแลช่วยเหลือผู้เรียน', N'', 1, 0, CAST(0x0000A5B500FAE902 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500FAE903 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'5c118e47-e0af-4497-8b2a-6abb23e1217f', N'5d71403c-b4ce-4575-98fe-ea434cb71cb0', N'กิจกรรมเพื่อสังคมและสาธารณประโยชน์', N'', 3, 0, CAST(0x0000A5B500FB6B5A AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500FB6B5B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'5e8e54ec-0a02-48b0-8146-fd3d0da1cd19', N'b235d01c-5ef5-4bdf-9310-21343cfa9203', N'วิชาการ', N'', 2, 0, CAST(0x0000A5B500F62A69 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500F62A6A AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'6bf5379f-72e0-44f2-9342-68bcb648a8b2', N'b235d01c-5ef5-4bdf-9310-21343cfa9203', N'งบประมาณ', N'', 3, 0, CAST(0x0000A5B500F637F8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500F637F8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'765c3ee9-7a50-4258-872d-2cf2fb89dca0', N'0ef455e8-b3f6-4543-9809-f8dd45d32eec', N'ผู้บริหารสถานศึกษา', N'', 2, 0, CAST(0x0000A5B500FD6B32 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500FD6B33 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'857b2a38-a93d-494e-8059-28b9d30cc641', N'dea59fb4-abef-4712-b999-f0d0118fb490', N'การวัดและประเมินผลการจัดกิจกรรมการเรียนรู้ตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 4, 0, CAST(0x0000A5B500FA784E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500FA784E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'a6196889-e4fb-4b97-95db-d888cf7d8b60', N'5d71403c-b4ce-4575-98fe-ea434cb71cb0', N'กิจกรรมนักเรียน', N'', 2, 0, CAST(0x0000A5B500FB3120 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500FB3121 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'ae8f855d-962a-48c9-899a-2c7bb82c6af7', N'0ef455e8-b3f6-4543-9809-f8dd45d32eec', N'ผู้เรียน', N'', 4, 0, CAST(0x0000A5B500FEBB1E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500FEBB1F AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'd6b73e2d-a130-4139-8d7d-27b443c1c7b7', N'dea59fb4-abef-4712-b999-f0d0118fb490', N'การบูรณาการหลักปรัชญาของเศรษฐกิจพอเพียงสู่การจัดกิจกรรมการเรียนรู้', N'', 2, 0, CAST(0x0000A5B500F8E28C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500F8E28C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'e392711e-7dad-48a7-91cf-a491101a4ed0', N'dea59fb4-abef-4712-b999-f0d0118fb490', N'สื่อและแหล่งเรียนรู้เกี่ยวกับหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 3, 0, CAST(0x0000A5B500F997EA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500F997EA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'e646bc7f-2a65-407d-84d4-2996cabf037c', N'0ef455e8-b3f6-4543-9809-f8dd45d32eec', N'สถานศึกษา', N'', 1, 0, CAST(0x0000A5B500FCFD5A AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500FCFD5A AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeStandard] ([SufficeStandardID], [SufficeSideID], [SufficeStandardName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'f8bfabc3-9600-4229-a189-e1b0216b1901', N'dea59fb4-abef-4712-b999-f0d0118fb490', N'หน่วยการเรียนรู้ปรัชญาของเศรษฐกิจพอเพียง', N'', 1, 0, CAST(0x0000A5B500F86160 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500F86161 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
End

Go
--เพิ่มข้อมูลตัวบ่งชี้ศรษฐกิจพอเพียง
If Not Exists(Select * From SufficeIndicator)                                                                                                                      
Begin
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'01163432-589b-411d-a3b0-680e71bdc319', N'581325cf-47bb-4d68-8790-e3eb5754c920', N'มีระบบดูแลช่วยเหลือผู้เรียนให้สามารถแก้ปัญหาและพัฒนาตนเองได้อย่างสอดคล้องกับหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 3, 0, CAST(0x0000A5B50116934C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50116934D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'036447f0-94a5-4c7f-81be-9d5809f00425', N'ae8f855d-962a-48c9-899a-2c7bb82c6af7', N'ผู้เรียนมีความรู้ความเข้าใจเกี่ยวกับหลักปรัชญาของเศรษฐกิจพอเพียงตามมาตรฐานการเรียนรู้หลักเศรษฐกิจพอเพียงของแต่ละระดับชั้นปีการศึกษา', N'', 1, 0, CAST(0x0000A5B50123A970 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50123A971 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'09ec279d-7e94-4480-8de3-7c61e591ee70', N'42bedfbf-79a8-40c6-bbf1-06a973578b6d', N'ขยายผลและเผยแพร่ ผลการดำเนินชีวิตและปฏิบัติภารกิจหน้าที่ของบุคลากรตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 3, 0, CAST(0x0000A5B50120DCBB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50120DCBB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'129b22dc-1139-40e4-9260-86cfcd2ddc0e', N'6bf5379f-72e0-44f2-9342-68bcb648a8b2', N'นำผลการติดตามมาพัฒนาและปรับปรุง การบริหารจัดการงบประมาณตามหลักของปรัชญาเศรษฐกิจพอเพียง', N'', 4, 0, CAST(0x0000A5B50107F0DE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50107F0DE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'1f4f4880-782f-42b9-8bcd-eb4d303836ce', N'd6b73e2d-a130-4139-8d7d-27b443c1c7b7', N'ผู้เรียนมีส่วนร่วมในการจัดกิจกรรมการเรียนรู้ที่บูรณาการหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 4, 0, CAST(0x0000A5B5010E4F58 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5010E4F59 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'2b495e2e-ebad-496d-b3c8-389f4d4f846c', N'ae8f855d-962a-48c9-899a-2c7bb82c6af7', N'ผู้เรียนปฏิบัติตนให้ดำเนินชีวิตได้อย่างสมดุลและพร้อมรับต่อการเปลี่ยนแปลงในด้านวัตถุ/เศรษฐกิจ', N'', 2, 0, CAST(0x0000A5B501240109 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B501240109 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'2e527cb0-0618-451d-a5d6-16c9c7573aac', N'5e8e54ec-0a02-48b0-8146-fd3d0da1cd19', N'นำผลการติดตามไปพัฒนา แผนงาน/โครงการ/กิจกรรม ด้านวิชาการที่ส่งเสริมการบูรณาการหลักปรัชญาเศรษฐกิจพอเพียงสู่การจัดกิจกรรมการเรียนรู้', N'', 4, 0, CAST(0x0000A5B50105A72E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50105A72E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'2f23374b-bfa4-4b2c-84e9-e98e18f8a067', N'581325cf-47bb-4d68-8790-e3eb5754c920', N'จัดกิจกรรมแนะแนวให้ผู้เรียนได้รู้จักการวางแผนชีวิตของตนเองได้อย่างสอดคล้องกับหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 2, 0, CAST(0x0000A5B5011625FE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5011625FF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'2f89af1c-79a0-428b-86ac-4bc230f61b15', N'e646bc7f-2a65-407d-84d4-2996cabf037c', N'คุณลักษณะของสถานศึกษาพอเพียง', N'', 1, 0, CAST(0x0000A5B50121046A AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50121046A AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'35e7f6a8-f3fe-4e32-a26d-525c969fa6fb', N'a6196889-e4fb-4b97-95db-d888cf7d8b60', N'จัดกิจกรรมลูกเสือ/เนตรนารี/ยุวกาชาด หรือผู้บำเพ็ญประโยชน์ สอดคล้องกับหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 2, 0, CAST(0x0000A5B5011829ED AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5011829ED AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'3711468d-bd1c-4e1e-9d96-c201632b61cc', N'486b7316-f59c-4ec9-8534-b925583df574', N'บุคลากรรู้จักใช้และจัดการทรัพยากรธรรมชาติและสิ่งแวดล้อมได้อย่างสมดุลและพร้อมรับต่อการเปลี่ยนแปลงต่างๆ', N'', 4, 0, CAST(0x0000A5B50122D381 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50122D381 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'374a74e6-7179-476b-bb6a-d1c53fbe440f', N'15ac977f-e581-46e8-94d7-2bdae2250a26', N'ประสานสัมพันธ์กับชุมชนให้มีส่วนร่วมในการจัดกิจกรรมการเรียนรู้เพื่อเสริมสร้างคุณลักษณะอยู่อย่างพอเพียงของผู้เรียน', N'', 2, 0, CAST(0x0000A5B5010956EC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5010956EC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'382337c0-4b6e-4df2-b08f-c230199ea841', N'd6b73e2d-a130-4139-8d7d-27b443c1c7b7', N'จัดกิจกรรมการเรียนรู้ที่บูรณาการหลักปรัชญาของเศรษฐกิจพอเพียงในกลุ่มสาระการเรียนรู้ต่างๆ', N'', 3, 0, CAST(0x0000A5B5010DF9C9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5010DF9C9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'41695369-38c7-4a5d-a7a5-d7a11de2e66a', N'2adb927a-e833-4027-a5ca-6a0bf1713bd7', N'มีแผนงาน/โครงการพัฒนาบุคลากรของสถานศึกษาเพื่อสร้างความรู้ความเข้าใจ และตระหนักในคุณค่าของหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 1, 0, CAST(0x0000A5B5011C759E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5011C759F AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'41d146e0-4c99-4c37-9757-2083c04251fa', N'ae8f855d-962a-48c9-899a-2c7bb82c6af7', N'ผู้เรียนปฏิบัติตนให้ดำเนินชีวิตได้อย่างสมดุลและพร้อมรับต่อการเปลี่ยนแปลงในด้านวัฒนธรรม', N'', 5, 0, CAST(0x0000A5B50124827E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50124827E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'4807a720-71a3-414c-a93c-fa57cff78815', N'e392711e-7dad-48a7-91cf-a491101a4ed0', N'จัดหา/ผลิต/ใช้/เผยแพร่ สื่อการเรียนรู้ เพื่อบูรณาการหลักปรัชญาของเศรษฐกิจพอเพียงในการจัดกิจกรรมการเรียนรู้', N'', 1, 0, CAST(0x0000A5B5010EAE0E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5010EAE0F AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'5251832b-4275-4751-a565-671ad3bdf3aa', N'857b2a38-a93d-494e-8059-28b9d30cc641', N'รายงานผลการประเมิน และนำมาปรับปรุง/พัฒนา การจัดกิจกรรมการเรียนรู้ที่บูรณาการหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 3, 0, CAST(0x0000A5B501140470 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B501140471 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'5693d897-6bf8-44b6-8e80-47ddce0575f8', N'486b7316-f59c-4ec9-8534-b925583df574', N'บุคลากรอยู่ร่วมกับผู้อื่นในสังคมตามหลักปรัชญาของเศรษฐกิจพอเพียงและสามารถเป็นแบบอย่างที่ดีในการปฏิบัติตนเพื่อส่วนรวมและสาธารณประโยชน์', N'', 3, 0, CAST(0x0000A5B50122698B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50122698B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'596d2cc2-8ac1-4380-a2d5-97681b785087', N'15ac977f-e581-46e8-94d7-2bdae2250a26', N'บริหารจัดการอาคารสถานที่และแหล่งเรียนรู้ในสถานศึกษา ตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 1, 0, CAST(0x0000A5B50108B643 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50108B643 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'59e01643-15bc-41e0-910c-723a5b15809e', N'a6196889-e4fb-4b97-95db-d888cf7d8b60', N'ส่งเสริมให้มีการจัดตั้ง ชุมนุม/ชมรม ตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 3, 0, CAST(0x0000A5B50118802D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50118802D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'5eeeed89-95ea-46c1-8377-f01f311b858b', N'4f4b18c4-36a5-4120-a417-eedef8076dd8', N'ติดตามผลการดำเนินการตามนโยบายและแผนปฏิบัติงานประจำปีที่น้อมนำหลักปรัชญาของเศรษฐกิจพอเพียงมาขับเคลื่อนในสถานศึกษา', N'', 3, 0, CAST(0x0000A5B501026866 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B501026867 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'601dc1d1-289c-42a3-a639-1ff660f65258', N'2adb927a-e833-4027-a5ca-6a0bf1713bd7', N'ประชุม/อบรม/สัมมนา/ศึกษาดูงานแหล่งเรียนรู้ต่างๆ เพื่อส่งเสริมการประยุกต์ใช้หลักปรัชญาของเศรษฐกิจพอเพียงในการดำเนินชีวิตและปฏิบัติภารกิจหน้าที่', N'', 2, 0, CAST(0x0000A5B5011D29BA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5BC00EF91E7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'64646c01-efe9-47ff-a651-c157f5ab9de2', N'6bf5379f-72e0-44f2-9342-68bcb648a8b2', N'ติดตามผลการดำเนินงานตามแผนงบประมาณของสถานศึกษาตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 3, 0, CAST(0x0000A5B501074060 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B501074060 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'680605b5-ffcb-4102-a109-69b949f96e31', N'2adb927a-e833-4027-a5ca-6a0bf1713bd7', N'จัดกิจกรรมส่งเสริมการดำเนินชีวิตและการปฏิบัติภารกิจหน้าที่ตามหลักปรัชญาของเศรษฐกิจพอเพียง แก่บุคลากรของสถานศึกษา', N'', 4, 0, CAST(0x0000A5B5011E06B9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5011E06B9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'6a197836-bfbb-4477-9e5b-932e4db9200e', N'4f4b18c4-36a5-4120-a417-eedef8076dd8', N'มีนโยบายน้อมนำหลักปรัชญาของเศรษฐกิจพอเพียงมาขับเคลื่อนในสถานศึกษา และบูรณาการในแผนปฏิบัติงานประจำปี', N'', 1, 0, CAST(0x0000A5B501011E84 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5BC00EC054B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'734d9427-8887-4c60-99b4-a44688517626', N'5c118e47-e0af-4497-8b2a-6abb23e1217f', N'มีกิจกรรมเพื่อสนับสนุนให้ผู้เรียนเกิดจิตอาสา และมีส่วนร่วมในกิจกรรมเพื่อสังคมและสาธารณประโยชน์ ตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 1, 0, CAST(0x0000A5B5011A1D87 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5011A1D87 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'7a22cbdb-43d0-40b2-98d4-0d7970bf1b34', N'ae8f855d-962a-48c9-899a-2c7bb82c6af7', N'ผู้เรียนปฏิบัติตนให้ดำเนินชีวิตได้อย่างสมดุลและพร้อมรับต่อการเปลี่ยนแปลงในด้านสิ่งแวดล้อม', N'', 4, 0, CAST(0x0000A5B501246556 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B501246557 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'7c173eea-5e60-4bbb-ac94-3d3d1ae0ef12', N'2adb927a-e833-4027-a5ca-6a0bf1713bd7', N'ส่งเสริมให้บุคลากรแสวงหาความรู้เกี่ยวกับหลักปรัชญาของเศรษฐกิจพอเพียงอย่างสม่ำเสมอ', N'', 3, 0, CAST(0x0000A5B5011D87DD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5011D87DD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'7c5ca3f7-3f3f-4fdf-a048-6fec0d366e45', N'5c118e47-e0af-4497-8b2a-6abb23e1217f', N'ติดตามผลการดำเนินกิจกรรมเพื่อสังคมและสาธารณประโยชน์ของผู้เรียนตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 3, 0, CAST(0x0000A5B5011B74BF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5011B74BF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'80d838e3-a11f-47b9-9060-99a40259e4ef', N'581325cf-47bb-4d68-8790-e3eb5754c920', N'นำผลการติดตามมาใช้พัฒนาการจัดกิจกรรมแนะแนว และระบบดูแลช่วยเหลือผู้เรียนตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 5, 0, CAST(0x0000A5B501176E4E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B501176E4E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'8fba5158-653c-4966-807b-31fae2e6250a', N'f8bfabc3-9600-4229-a189-e1b0216b1901', N'มีหน่วยการเรียนรู้ปรัชญาของเศรษฐกิจพอเพียง ตามมาตรฐานการเรียนรู้', N'', 1, 0, CAST(0x0000A5B50109B5C1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50109B5C1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'991c84a7-2929-4369-a6fc-b45f73d921ab', N'd6b73e2d-a130-4139-8d7d-27b443c1c7b7', N'คุณภาพของแผนจัดการเรียนรู้ที่บูรณาการหลักปรัชญาของเศรษฐกิจพอเพียงในกลุ่มสาระการเรียนรู้ต่างๆ', N'', 2, 0, CAST(0x0000A5B5010D95A2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5010D95A2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'9ba39b15-8ddb-44ec-ba33-23770639056b', N'5e8e54ec-0a02-48b0-8146-fd3d0da1cd19', N'ติดตามผลการดำเนินการตามแผนงาน/โครงการ/กิจกรรม ด้านวิชาการที่ส่งเสริมการบูรณาการหลักปรัชญาของเศรษฐกิจพอเพียงสู่การจัดกิจกรรมการเรียนรู้', N'', 3, 0, CAST(0x0000A5B50104E6CA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5BC00ECEFA7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'a110bee2-87e5-4c1d-975e-1a2f429f5459', N'42bedfbf-79a8-40c6-bbf1-06a973578b6d', N'ติดตามผลการดำเนินโครงการ/กิจกรรมพัฒนาบุคลากรเพื่อส่งเสริมการดำเนินชีวิต และปฏิบัติภารกิจหน้าที่ตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 1, 0, CAST(0x0000A5B5011FBE2A AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5011FBE2B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'a158551b-e5e7-4162-9870-695b1387a110', N'6bf5379f-72e0-44f2-9342-68bcb648a8b2', N'ดำเนินการตามแผนงานงบประมาณของสถานศึกษาตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 2, 0, CAST(0x0000A5B50106AD59 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50106AD59 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'a2bfb8a5-5d90-47a9-8e58-c4904c9bf220', N'4f4b18c4-36a5-4120-a417-eedef8076dd8', N'ดำเนินการตามนโยบายและแผนปฏิบัติงานประจำปีที่น้อมนำหลักปรัชญาของเศรษฐกิจพอเพียงมาขับเคลื่อนในสถานศึกษา', N'', 2, 0, CAST(0x0000A5B501019B17 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5BC00EC39E9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'a841d011-03b3-4796-ab67-c30eb77eb56c', N'5c118e47-e0af-4497-8b2a-6abb23e1217f', N'นำผลการติดตามมาปรับปรุง/พัฒนา การดำเนินกิจกรรมเพื่อสังคมและสาธารณประโยชน์ของผู้เรียนตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 4, 0, CAST(0x0000A5B5011BCC99 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5011BCC9A AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'b1eb6b0e-026b-450f-8bca-01f4377825dc', N'486b7316-f59c-4ec9-8534-b925583df574', N'บุคลากรของสถานศึกษามีความรู้ความเข้าใจเกี่ยวกับหลักปรัชญาเศรษฐกิจพอเพียง', N'', 1, 0, CAST(0x0000A5B501219186 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B501219187 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'b3f30cdb-4794-4fc4-9005-f7da4b81b606', N'857b2a38-a93d-494e-8059-28b9d30cc641', N'จัดทำเครื่องมือวัดผลและประเมินผลที่หลากหลาย และสอดคล้องกับวัตถุประสงค์ของการจัดกิจกรรมการเรียนรู้หลักปรัญชาของเศรษฐกิจพอเพียง', N'', 1, 0, CAST(0x0000A5B50112964C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50112964C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'b41ef742-3d26-4a1e-b735-3105c30bc722', N'f8bfabc3-9600-4229-a189-e1b0216b1901', N'มีการนิเทศ/ติดตาม/ประเมินผล การนำหน่วยการเรียนรู้ปรัชญาของเศรษฐกิจพอเพียงไปใช้ในการจัดกิจกรรมการเรียนรู้', N'', 2, 0, CAST(0x0000A5B5010A4A82 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5010A4A82 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'b6f082a4-b84b-4f34-ab69-1f8b86f05b93', N'486b7316-f59c-4ec9-8534-b925583df574', N'บุคลากรดำเนินชีวิตอย่างมีฐานรากทางวัฒนธรรม และพร้อมรับต่อการเปลี่ยนแปลงทางวัฒนธรรมจากกระแสโลกาภิวัฒน์', N'', 5, 0, CAST(0x0000A5B501233457 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5BC00F25AA3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'c802163a-9ef4-4674-99f7-ba722e96e99a', N'ae8f855d-962a-48c9-899a-2c7bb82c6af7', N'ผู้เรียนปฏิบัติตนให้ดำเนินชีวิตได้อย่างสมดุลและพร้อมรับต่อการเปลี่ยนแปลงในด้านสังคม', N'', 3, 0, CAST(0x0000A5B501244496 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B501244496 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'cd73c288-7b6a-45b9-bb91-19b65f22ce77', N'f8bfabc3-9600-4229-a189-e1b0216b1901', N'มีการศึกษา/วิเคราะห์/วิจัย เพื่อพัฒนาการจัดกิจกรรมการเรียนรู้ หน่วยการเรียนรู้ปรัชญาของเศรษฐกิจพอเพียง', N'', 3, 0, CAST(0x0000A5B5010AB8EA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5010AB8EA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'ced063a5-aa68-47d7-a0ce-85febf1f0275', N'581325cf-47bb-4d68-8790-e3eb5754c920', N'ติดตามผลการจัดกิจกรรมแนะแนว และระบบดูแลช่วยเหลือผู้เรียนตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 4, 0, CAST(0x0000A5B50116ECDC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50116ECDC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'cf1a3933-dec3-4a7a-bc92-fb6e1a00ef29', N'5c118e47-e0af-4497-8b2a-6abb23e1217f', N'ผู้เรียนมีส่วนร่วมในการแก้ปัญหา/พัฒนาสถานศึกษา/ชุมชน ด้านเศรษฐกิจ/สังคม/สิ่งแวดล้อม/วัฒนธรรม ตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 2, 0, CAST(0x0000A5B5011ACE02 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5011ACE02 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'cf69eda0-eadf-4096-abd0-fcfc845c7341', N'e392711e-7dad-48a7-91cf-a491101a4ed0', N'ใช้แหล่งเรียนรู้/ภูมิปัญญาท้องถิ่นในชุมชน ที่เสริมสร้างการพัฒนาคุณลักษณะ"อยู่อย่างพอเพียง" ของผู้เรียน', N'', 3, 0, CAST(0x0000A5B501115959 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B501115959 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'd31489fa-8955-472b-83b5-c362b6366c5d', N'42bedfbf-79a8-40c6-bbf1-06a973578b6d', N'นำผลการติดตามมาปรับปรุง/พัฒนาการดำเนินโครงการ/กิจกรรม พัฒนาบุคลากรเพื่อส่งเสริมการดำเนินชีวิตและปฏิบัติภารกิจหน้าที่ตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 2, 0, CAST(0x0000A5B5012055EE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5012055EE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'd351caae-4f48-4484-8ec3-62a86308b13b', N'e392711e-7dad-48a7-91cf-a491101a4ed0', N'จัดทำ/พัฒนา/เผยแพร่ แหล่งเรียนรูู้ในสถานศึกษาเพื่อสนับสนุนการเรียนรู้เกี่ยวกับหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 2, 0, CAST(0x0000A5B50110E9CD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50110E9CD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'd36753ee-85ab-4335-a0bd-aca01bae4144', N'5e8e54ec-0a02-48b0-8146-fd3d0da1cd19', N'ดำเนินการตามแผนงาน/โครงการ/กิจกรรม ด้านวิชาการที่ส่งเสริมการบูรณาการหลักปรัชญาของเศรษฐกิจพอเพียงสู่การจัดกิจกรรมการเรียนรู้', N'', 2, 0, CAST(0x0000A5B501044C77 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5BC00ECB258 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'd5b54c65-06d4-4bea-8f81-923e11192dfc', N'a6196889-e4fb-4b97-95db-d888cf7d8b60', N'ติดตามผลการจัดกิจกรรมนักเรียนตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 5, 0, CAST(0x0000A5B501193D0D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B501193D0E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'd83447f7-08ff-4d21-af6f-328a67945623', N'4f4b18c4-36a5-4120-a417-eedef8076dd8', N'นำผลการติดตามมาพัฒนา นโยบาย/แผนงาน/โครงการ/กิจกรรมขับเคลื่อนหลักปรัชญาของเศรษฐกิจพอเพียงในสถานศึกษา', N'', 4, 0, CAST(0x0000A5B50103145D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50103145D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'dac79b55-c706-4b4e-8f18-15ddbb5d2ab9', N'581325cf-47bb-4d68-8790-e3eb5754c920', N'มีแผนงานแนะแนวเพื่อสนับสนุนการดำเนินชีวิตที่สอดคล้องกับหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 1, 0, CAST(0x0000A5B501156E5E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B501156E5E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'db8431d8-5c61-47c7-b9e1-d8b89f9fd3eb', N'857b2a38-a93d-494e-8059-28b9d30cc641', N'จัดแสดง/เผยแพร่/ประกวด/แลกเปลี่ยนเรียนรู้ ผลงานของผู้เรียนที่เกิดจากการนำหลักปรัชญาของเศรษฐกิจพอเพียงไปประยุกต์ใช้', N'', 4, 0, CAST(0x0000A5B50114D05E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50114D05F AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'e7404269-0b42-4ecc-ab90-0fbecfca3f74', N'5e8e54ec-0a02-48b0-8146-fd3d0da1cd19', N'มีแผนงาน/โครงการ/กิจกรรม ด้านวิชาการที่ส่งเสริมการบูรณาการหลักปรัชญาเศรษฐกิจพอเพียงสู่การจัดกิจกรรมการเรียนรู้', N'', 1, 0, CAST(0x0000A5B50103B386 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50103B386 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'eb877c5b-cb7c-4225-82c5-4c3c45e15620', N'486b7316-f59c-4ec9-8534-b925583df574', N'บุคลากรจัดการทรัพยากรและดำเนินชีวิตด้านเศรษฐกิจ อย่างสอดคล้องกับหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 2, 0, CAST(0x0000A5B50121E8C0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50121E8C0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'ed8f936e-649c-4940-8270-badf5b08469b', N'a6196889-e4fb-4b97-95db-d888cf7d8b60', N'นำผลการติดตามมาปรับปรุง/พัฒนากิจกรรมนักเรียนตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 6, 0, CAST(0x0000A5B5011996AA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5011996AB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'f1866ceb-99df-4647-8635-885ef23dc3fd', N'6bf5379f-72e0-44f2-9342-68bcb648a8b2', N'มีการวางแผนการบริหารจัดการงบประมาณของสถานศึกษาที่สอดคล้องกับหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 1, 0, CAST(0x0000A5B50105F71B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50105F71B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'f4bcced4-0c54-40ed-8a32-adf4a763d360', N'a6196889-e4fb-4b97-95db-d888cf7d8b60', N'มีการประยุกต์ใช้ภูมิปัญญาท้องถิ่น/วัฒนธรรม/หลักคำสอนทางศาสนาในการจัดกิจกรรมนักเรียนตามหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 4, 0, CAST(0x0000A5B50118F4BC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50118F4BD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'f6690122-bea3-45d3-98e2-48733879dbdb', N'a6196889-e4fb-4b97-95db-d888cf7d8b60', N'มีแผนงาน/โครงการ ส่งเสริมกิจกรรมนักเรียนเพื่อให้ผู้เรียนอยู่อย่างพอเพียง', N'', 1, 0, CAST(0x0000A5B50117BED8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50117BED9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'f919e2f1-2dd4-4a7a-a706-f94d6b958124', N'765c3ee9-7a50-4258-872d-2cf2fb89dca0', N'คุณลักษณะของผู้บริหารสถานศึกษาพอเพียง', N'', 1, 0, CAST(0x0000A5B5012134BB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5012134BB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'fa813656-2af8-4fcb-9f22-37b47b1067e3', N'857b2a38-a93d-494e-8059-28b9d30cc641', N'ใช้วิธีการวัดผลและประเมินผลที่หลากหลาย และสอดคล้องกับการจัดกิจกรรมการเรียนรู้ที่บูรณาการหลักปรัชญาของเศรษฐกิจพอเพียง', N'', 2, 0, CAST(0x0000A5B50113857B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B50113857C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[SufficeIndicator] ([SufficeIndicatorID], [SufficeStandardID], [SufficeIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'fb2324b9-398d-4d1e-9bd8-ea2da9c9181c', N'd6b73e2d-a130-4139-8d7d-27b443c1c7b7', N'มีแผนจัดการเรียนรู้บูรณาการหลักปรัชญาของเศรษฐกิจพอเพียงในกลุ่มสาระการเรียนรู้ต่างๆตามมาตรฐานการเรียนรู้', N'', 1, 0, CAST(0x0000A5B5010CF78C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B5010CF78C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
End

Go
--เพิ่มเมนูด้านหลักปรัชญาเศรษฐกิจพอเพียง
If Not Exists(Select * From MySubMenu Where MySubMenuID = '8EFE4D8C-CFCF-438A-8F3A-5C361C9F3275')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('8EFE4D8C-CFCF-438A-8F3A-5C361C9F3275', 'ด้านปรัชญาเศรษฐกิจพอเพียง', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 41, 'MasterData/SufficeSide.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S21.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('8EFE4D8C-CFCF-438A-8F3A-5C361C9F3275', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('8EFE4D8C-CFCF-438A-8F3A-5C361C9F3275', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('8EFE4D8C-CFCF-438A-8F3A-5C361C9F3275', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('8EFE4D8C-CFCF-438A-8F3A-5C361C9F3275', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มเมนูองค์ประกอบหลักปรัชญาเศรษฐกิจพอเพียง
If Not Exists(Select * From MySubMenu Where MySubMenuID = '309BD150-2B6F-42C7-9F2F-69A5BAA30AA4')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('309BD150-2B6F-42C7-9F2F-69A5BAA30AA4', 'องค์ประกอบปรัชญาเศรษฐกิจพอเพียง', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 42, 'MasterData/SufficeStandard.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S22.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('309BD150-2B6F-42C7-9F2F-69A5BAA30AA4', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('309BD150-2B6F-42C7-9F2F-69A5BAA30AA4', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('309BD150-2B6F-42C7-9F2F-69A5BAA30AA4', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('309BD150-2B6F-42C7-9F2F-69A5BAA30AA4', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มเมนูตัวชี้วัดหลักปรัชญาเศรษฐกิจพอเพียง
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'CF53EA55-A5E1-4628-AD89-F7C63C9AC362')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('CF53EA55-A5E1-4628-AD89-F7C63C9AC362', 'ตัวบ่งชี้ปรัชญาเศรษฐกิจพอเพียง', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 43, 'MasterData/SufficeIndicator.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S23.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('CF53EA55-A5E1-4628-AD89-F7C63C9AC362', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('CF53EA55-A5E1-4628-AD89-F7C63C9AC362', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('CF53EA55-A5E1-4628-AD89-F7C63C9AC362', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('CF53EA55-A5E1-4628-AD89-F7C63C9AC362', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มเมนูคัดลอกด้าน/องค์ประกอบ/ตัวชี้วัดหลักปรัชญาเศรษฐกิจพอเพียง
If Not Exists(Select * From MySubMenu Where MySubMenuID = '9B2CD419-55D6-40B1-BE4A-26418ED58446')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('9B2CD419-55D6-40B1-BE4A-26418ED58446', 'คัดลอกด้าน/องค์ประกอบ/ตัวบ่งชี้ปรัชญาฯ', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 44, 'MasterData/CopySuffice.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S24.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('9B2CD419-55D6-40B1-BE4A-26418ED58446', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('9B2CD419-55D6-40B1-BE4A-26418ED58446', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('9B2CD419-55D6-40B1-BE4A-26418ED58446', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('9B2CD419-55D6-40B1-BE4A-26418ED58446', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มเมนูจำนวนโครงการรายตัวบ่งชี้ของเศรษฐกิจพอเพียง
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'F6E8DCA4-EF38-4843-B144-AEBBEFA3E9CA')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('F6E8DCA4-EF38-4843-B144-AEBBEFA3E9CA', 'จำนวนโครงการรายตัวบ่งชี้เศรษฐกิจพอเพียง', '8de87893-6cd6-4900-968a-db0e8832d043', 14, 'MasterData/ReportCountSufficeView.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S09.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('F6E8DCA4-EF38-4843-B144-AEBBEFA3E9CA', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('F6E8DCA4-EF38-4843-B144-AEBBEFA3E9CA', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('F6E8DCA4-EF38-4843-B144-AEBBEFA3E9CA', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('F6E8DCA4-EF38-4843-B144-AEBBEFA3E9CA', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
----------ลบ StoreProcedure เมนู Suffice
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuSuffice')
Begin
	DROP PROCEDURE ckMenuSuffice
End

Go
--เพิ่ม Store เมนู Suffice
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuSuffice
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '8EFE4D8C-CFCF-438A-8F3A-5C361C9F3275'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '309BD150-2B6F-42C7-9F2F-69A5BAA30AA4'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'CF53EA55-A5E1-4628-AD89-F7C63C9AC362'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '9B2CD419-55D6-40B1-BE4A-26418ED58446'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'F6E8DCA4-EF38-4843-B144-AEBBEFA3E9CA'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '8EFE4D8C-CFCF-438A-8F3A-5C361C9F3275'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '309BD150-2B6F-42C7-9F2F-69A5BAA30AA4'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'CF53EA55-A5E1-4628-AD89-F7C63C9AC362'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '9B2CD419-55D6-40B1-BE4A-26418ED58446'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'F6E8DCA4-EF38-4843-B144-AEBBEFA3E9CA'
	End
END

Go
----------Update ค่าตัวเช็ค
Update MR_School Set ckSuffice = 0 Where ckSuffice Is Null


--------------------------FourthAssessment---------------------------
Go
--เพิ่มฟิวตัวเช็คตัว FourthAssessment
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckFourthAssessment')
Begin
	alter table MR_School add ckFourthAssessment bit
End

Go
----------- เพิ่ม Table FourthAssessmentSide  ด้านการประเมินรอบ 4 ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('FourthAssessmentSide'))
Begin
	CREATE TABLE [dbo].[FourthAssessmentSide](
		[FourthAssessmentSideID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[FourthAssessmentSideName] [nvarchar](500) NULL,
		[Detail] [nvarchar](2000) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_FourthAssessmentSide] PRIMARY KEY CLUSTERED 
	(
		[FourthAssessmentSideID] ASC
	)) ON [PRIMARY]
End

Go
----------- เพิ่ม Table FourthAssessmentIndicator  ตัวบ่งชี้การประเมินรอบ 4 ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('FourthAssessmentIndicator'))
Begin
	CREATE TABLE [dbo].[FourthAssessmentIndicator](
		[FourthAssessmentIndicatorID] [nvarchar](50) NOT NULL,
		[FourthAssessmentSideID] [nvarchar](50) NOT NULL,
		[FourthAssessmentIndicatorName] [nvarchar](300) NULL,
		[Detail] [nvarchar](2000) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_FourthAssessmentIndicator] PRIMARY KEY CLUSTERED 
	(
		[FourthAssessmentIndicatorID] ASC
	)) ON [PRIMARY]
End

Go
----------- เพิ่ม Table dtFourthAssessment  เชื่อมโยง โครงการกับการประเมินรอบ 4 ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtFourthAssessment'))
Begin
	CREATE TABLE [dbo].[dtFourthAssessment](
		[ProjectsCode] [nvarchar](50) NULL,
		[FourthAssessmentIndicatorID] [nvarchar](50) NULL
	) ON [PRIMARY]
End

Go
--เพิ่มข้อมูลด้านการประเมินภายนอกรอบ 4
If Not Exists(Select * From FourthAssessmentSide)                                                                                                                      
Begin
	INSERT [dbo].[FourthAssessmentSide] ([FourthAssessmentSideID], [StudyYear], [FourthAssessmentSideName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'06b4334b-9648-4c45-83a9-49c6c3691cdc', 2558, N'คุณภาพศิษย์', N'', 1, 0, CAST(0x0000A5B500C0CFEE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500C13CB2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentSide] ([FourthAssessmentSideID], [StudyYear], [FourthAssessmentSideName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'5f88ab24-b4a0-4cf5-8f9c-ffd4b70298fc', 2558, N'ความสัมพันธ์กับชุมชน / สังคม', N'', 4, 0, CAST(0x0000A5B500C123E8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500C15374 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentSide] ([FourthAssessmentSideID], [StudyYear], [FourthAssessmentSideName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'6d62f750-bbac-4082-8f36-5cda4e137dcc', 2558, N'การทำนุบำรุงศิลปะและวัฒนธรรม', N'', 5, 0, CAST(0x0000A5B500C16FF2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500C16FF2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentSide] ([FourthAssessmentSideID], [StudyYear], [FourthAssessmentSideName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'82e2526a-e230-46b6-9f56-0e87d03f3f4e', 2558, N'การบริหารและธรรมาภิบาลของสถานศึกษา', N'', 3, 0, CAST(0x0000A5B500C109FC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500C14D78 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentSide] ([FourthAssessmentSideID], [StudyYear], [FourthAssessmentSideName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'e2d045fb-854b-43c4-a0de-076b6fdca1e1', 2558, N'คุณภาพครู / อาจารย์', N'', 2, 0, CAST(0x0000A5B500C0F42D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B500C14524 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
End

Go
--เพิ่มข้อมูลตัวบ่งชี้การประเมินรอบ 4
If Not Exists(Select * From FourthAssessmentIndicator)                                                                                                                                                                                                              
Begin 
	INSERT [dbo].[FourthAssessmentIndicator] ([FourthAssessmentIndicatorID], [FourthAssessmentSideID], [FourthAssessmentIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'16497756-5480-43c9-98dd-efd1c8958776', N'06b4334b-9648-4c45-83a9-49c6c3691cdc', N'ผู้เรียนมีความสามารถในการคิด', N'ความสามารถทางความคิดเป็นหนึ่งในทักษะที่สำคัญของการดำรงชีวิตในสังคมปัจจุบัน ผู้เรียนจึงต้องมีความสามารถในการคิดวิเคราะห์ คิดสังเคราะห์ คิดแก้ปัญหาและคิดสร้างสรรค์', 3, 0, CAST(0x0000A5B600B83E0B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5BC00F37B4D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentIndicator] ([FourthAssessmentIndicatorID], [FourthAssessmentSideID], [FourthAssessmentIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'261f06a5-1a46-4db1-9dbb-9e958794fab9', N'82e2526a-e230-46b6-9f56-0e87d03f3f4e', N'การพัฒนาบุคลากรสายสนับสนุน', N'สถานศึกษามีบุคลากรประจำสายสนับสนุนด้านวิชาการ/ธุรการ ที่ได้รับการอบรมเพิ่มพูนความรู้ ประสบการณ์ทั้งในและต่างประเทศ', 4, 0, CAST(0x0000A5B600C5BBAB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B600C5BBAB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentIndicator] ([FourthAssessmentIndicatorID], [FourthAssessmentSideID], [FourthAssessmentIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'55e17e9b-ec12-4221-a5c5-2224e6714efe', N'5f88ab24-b4a0-4cf5-8f9c-ffd4b70298fc', N'การให้ความร่วมมือกับชุมชน/สังคม ที่ส่งผลต่อสถานศึกษา', N'สถานศึกษามีการนำความรู้และประสบการณ์ที่เกิดจากกิจกรรมความร่วมมือกับชุมชน/สังคมไปพัฒนาการเรียนการสอนและสถานศึกษา เพื่อเป็นแบบอย่างที่ดีต่อสถานศึกษาอื่น', 2, 0, CAST(0x0000A5B600C88D14 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B600C88D14 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentIndicator] ([FourthAssessmentIndicatorID], [FourthAssessmentSideID], [FourthAssessmentIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'57971b91-0fa3-4fa1-bd81-133921fabc82', N'e2d045fb-854b-43c4-a0de-076b6fdca1e1', N'ครู/อาจารย์มีผลงานที่นำไปใช้ประโยชน์', N'ครู/อาจารย์มีผลงานจากการจัดการความรู้ เช่น คู่มือ สื่อการสอน สิ่งประดิษฐ์ แบบจำลอง งานสร้างสรรค์ นวัตกรรมหรืองานวิจัยที่นำไปใช้ในการปรับปรุง/พัฒนาการจัดการเรียนการสอนจนเกิดผลกับผู้เรียน', 3, 0, CAST(0x0000A5B600BF0547 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B600BF0547 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentIndicator] ([FourthAssessmentIndicatorID], [FourthAssessmentSideID], [FourthAssessmentIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'7c779cf1-1e29-4971-9fe3-c5a2a1bee2ca', N'06b4334b-9648-4c45-83a9-49c6c3691cdc', N'ผู้เรียนมีความรู้ความสามารถตามหลักสูตร', N'ผู้เรียนมีคุณลักษณะตามมาตรฐานการเรียนรู้ที่กำหนดไว้ในหลักสูตรการศึกษาขั้นพื้นฐาน', 2, 0, CAST(0x0000A5B600B517C1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B600B6FC92 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentIndicator] ([FourthAssessmentIndicatorID], [FourthAssessmentSideID], [FourthAssessmentIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'81c04d81-1a20-4f12-a402-4a6d7442722c', N'e2d045fb-854b-43c4-a0de-076b6fdca1e1', N'ครู/อาจารย์ได้รับการเพิ่มพูนความรู้/ประสบการณ์', N'ครู/อาจารย์ ประจำได้รับการเพิ่มพูนความรู้/ประสบการณ์ เพื่อพัฒนาความรู้/ทักษะที่สำคัญ เช่น วิธีการจัดการเรียนการสอน การวัดประเมินผล การส่งเสริมความคิดสร้างสรรค์ ตลอดจนความรู้ในวิชาที่สอนเพื่อให้ทันสมัย ทันโลก ฯลฯ โดยการเข้าร่วมการประชุมวิชาการ/เข้ารับการอบรม/ศึกษาบางวิชา/ดูงาน/แลกเปลี่ยนเรียนรู้ภายในและระหว่างสถานศึกษา ทั้งในและ/หรือต่างประเทศ', 4, 0, CAST(0x0000A5B600C0AED1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B600C0AED1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentIndicator] ([FourthAssessmentIndicatorID], [FourthAssessmentSideID], [FourthAssessmentIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'8659253e-40a5-4236-9309-161ea50534c2', N'5f88ab24-b4a0-4cf5-8f9c-ffd4b70298fc', N'การให้ความร่วมมือที่ส่งผลต่อชุมชน/สังคม', N'สถานศึกษาสนับสนุนให้ครู/อาจารย์ มีส่วนร่วมในกิจกรรมของชุมชน/สังคม เพื่อก่อให้เกิดการเปลี่ยนแปลงในทางที่ดีขึ้นต่อชุมชน/สังคม จากความร่วมมือระหว่างสถานศึกษากับชุมชน/สังคม และเกิดการถ่ายโอนความรู้ระหว่างสถานศึกษากับชุมชน/สังคม', 1, 0, CAST(0x0000A5B600C73FC0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B600C73FC0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentIndicator] ([FourthAssessmentIndicatorID], [FourthAssessmentSideID], [FourthAssessmentIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'8f4f1005-baae-4a7b-b2c0-33481a4896e9', N'6d62f750-bbac-4082-8f36-5cda4e137dcc', N'ส่งเสริมสนับสนุนศิลปะและวัฒนธรรม', N'ความดีความงามในมิติของศิลปะและวัฒนธรรม คือสิ่งที่บ่งบอกถึงลักษณะเฉพาะของคนและสังคมนั้นๆ ซึ่งมีการสืบทอดและปรับเปลี่ยนไปตามกาลเวลา สถานศึกษาจึงควรเป็นแหล่งให้ความรู้และส่งเสริมสนับสนุนให้นักเรียนเข้าใจ เห็นคุณค่าศิลปะและวัฒนธรรม โดยเป็นส่วนหนึ่งของการเรียนการสอนและการดำรงชีวิตก่อให้เกิดทัศนคติและพฤติกรรมที่ดีงาม', 1, 0, CAST(0x0000A5B600C9084B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B600E40ADB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentIndicator] ([FourthAssessmentIndicatorID], [FourthAssessmentSideID], [FourthAssessmentIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'a9ee34b6-8e06-4e07-ba3a-924e69b5603a', N'06b4334b-9648-4c45-83a9-49c6c3691cdc', N'ผู้เรียนเป็นคนดี', N'ผู้เรียนดำรงชีวิตอย่างมีคุณค่า มีน้ำใจไมตรี มีจิตอาสา และมีการพัฒนาคุณธรรมด้านต่างๆ อาทิ วินัย สติ กตัญญู เมตตา อดทน ซื่อสัตย์ ประหยัด ขยัน ไม่เห็นแก่ตัว ฯลฯ ผ่านการทำงาน ทำกิจกรรม บำเพ็ญประโยชน์', 1, 0, CAST(0x0000A5B600B4E0E1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B600B69E0B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentIndicator] ([FourthAssessmentIndicatorID], [FourthAssessmentSideID], [FourthAssessmentIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'b5ab43bc-2e08-4e64-81eb-9780fa1b3fe8', N'e2d045fb-854b-43c4-a0de-076b6fdca1e1', N'ครู/อาจารย์เป็นคนดี มีความสามารถ', N'ครู/อาจารย์ปฏิบัติตนตามจรรยาบรรณอย่างเคร่งครัด สม่ำเสมอเป็นแบบอย่างที่ดีต่อผู้เรียน สามารถจัดการเรียนรู้ที่เน้นผู้เรียนเป็นสำคัญ และส่งเสริมให้ผู้เรียนรายบุคคลพัฒนาตนเองอย่างเต็มตามศักยภาพ', 1, 0, CAST(0x0000A5B600BBAB66 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B600BBAB6B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentIndicator] ([FourthAssessmentIndicatorID], [FourthAssessmentSideID], [FourthAssessmentIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'c25b0a72-0af7-43c7-80d4-5829d04c2c9a', N'e2d045fb-854b-43c4-a0de-076b6fdca1e1', N'ครู/อาจารย์สร้างสรรค์ห้องเรียน/แหล่งเรียนรู้คุณภาพ', N'ครู/อาจารย์ นำประสบการณ์จากการสอนมาสร้างสรรค์ห้องเรียน/แหล่งเรียนรู้คุณภาพภายในสถานศึกษา เพื่อพัฒนาผู้เรียนให้บรรลุเป้าหมายตามหลักสูตร โดยเน้นความเหมาะสม สอดคล้องกับความสนใจของผู้เรียน ทำให้ผู้เรียนใฝ่รู้ ใฝ่เรียน และมาใช้บริการห้องเรียน/แหล่งเรียนรู้นั้นอย่างสม่ำเสมอ', 2, 0, CAST(0x0000A5B600BD921B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B600BD921B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentIndicator] ([FourthAssessmentIndicatorID], [FourthAssessmentSideID], [FourthAssessmentIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'c2f0903c-3f23-4628-9b0d-1ab66b1fb601', N'82e2526a-e230-46b6-9f56-0e87d03f3f4e', N'การดำเนินงานของผู้อำนวยการ', N'ผู้อำนวยการมีผลการดำเนินงานตามแผนพัฒนาสถานศึกษา เพื่อให้เกิดประสิทธิภาพและประสิทธิผลทั้งในระยะสั้นและระยะยาวตามหลักธรรมาภิบาล มีระบบตรวจสอบการทำงานตามภารกิจ ตลอดจนมีการติดตามและประเมินผลอย่างต่อเนื่อง', 2, 0, CAST(0x0000A5B600C38D6B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B600C38D6B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentIndicator] ([FourthAssessmentIndicatorID], [FourthAssessmentSideID], [FourthAssessmentIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'c42d6ac5-80aa-466a-bf35-c7582f0a848d', N'82e2526a-e230-46b6-9f56-0e87d03f3f4e', N'การบริหารความเสี่ยง', N'สถานศึกษามีผลการบริหารความเสี่ยงจากกระบวนการประเมินสถานการณ์ จัดลำดับความสำคัญ จัดการ ควบคุม ติดตาม เฝ้าระวัง ป้องกัน และแก้ไขความเสี่ยง ส่งผลให้ลดสาเหตุและโอกาสที่จะเกิดความเสียหายต่อชีวิต ทรัพย์สิน ชื่อเสียง และสังคม', 3, 0, CAST(0x0000A5B600C4E9AB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B600C4E9AB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentIndicator] ([FourthAssessmentIndicatorID], [FourthAssessmentSideID], [FourthAssessmentIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'c9b59814-890f-49ab-87f7-3018b88001ff', N'82e2526a-e230-46b6-9f56-0e87d03f3f4e', N'การดำเนินงานของคณะกรรมการสถานศึกษา', N'คณะกรรมการสถานศึกษาขั้นพื้นฐานมีผลการดำเนินงานตามบทบาทหน้าที่ ซึ่งกำหนดไว้ในระเบียบกระทรวงศึกษาธิการว่าด้วยคณะกรรมการสถานศึกษาขั้นพื้นฐาน พ.ศ.2543 โดยมุ่งเน้นการกำหนด นโยบาย กำกับ ติดตาม และสนับสนุนการดำเนินงานของสถานศึกษา และขับเคลื่อนการดำเนินงาน เพื่อการพัฒนาปรับปรุงคุณภาพการศึกษาให้บรรลุผลสำเร็จตามเป้าหมายที่กำหนด', 1, 0, CAST(0x0000A5B600C27874 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5B600C27874 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[FourthAssessmentIndicator] ([FourthAssessmentIndicatorID], [FourthAssessmentSideID], [FourthAssessmentIndicatorName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'f9e396eb-70ac-41f6-a266-cbfbf8044a02', N'06b4334b-9648-4c45-83a9-49c6c3691cdc', N'ผู้เรียนมีทักษะชีวิต', N'ผู้เรียนมีทักษะในการดูแลสุขภาพ สามารถดำเนินชีวิตประจำวันอย่างมีคุณค่า ใฝ่เรียนรู้ อยู่ร่วมกันในสังคมด้วยการเสริมสร้างความสัมพันธ์อันดีระหว่างบุคคล จัดการปัญหาและความขัดแย้งต่างๆได้อย่างเหมาะสม ปรับตัวให้ทันกับการเปลี่ยนแปลงของสังคมและสภาพแวดล้อม ตลอดจนรู้จักหลีกเลี่ยงพฤติกรรมไม่พึงประสงค์ที่ส่งผลกระทบต่อตนเองและผู้อื่น', 4, 0, CAST(0x0000A5B600BA5E9E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5BC00F3CE1C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
End

Go 
--เพิ่มเมนูด้านการประเมินรอบ 4 
If Not Exists(Select * From MySubMenu Where MySubMenuID = '7004BD52-7F9D-4CE5-8433-54F836C6C296')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('7004BD52-7F9D-4CE5-8433-54F836C6C296', 'ด้านการประเมินภายนอกรอบ 4', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 45, 'MasterData/FourthAssessmentSide.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S43.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('7004BD52-7F9D-4CE5-8433-54F836C6C296', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('7004BD52-7F9D-4CE5-8433-54F836C6C296', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('7004BD52-7F9D-4CE5-8433-54F836C6C296', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('7004BD52-7F9D-4CE5-8433-54F836C6C296', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go  
--เพิ่มเมนูตัวบ่งชี้การประเมินรอบ 4 
If Not Exists(Select * From MySubMenu Where MySubMenuID = '79AE44E2-98A3-49A5-A94B-D5654AAC6F4F')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('79AE44E2-98A3-49A5-A94B-D5654AAC6F4F', 'ตัวบ่งชี้การประเมินภายนอกรอบ 4', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 46, 'MasterData/FourthAssessmentIndicator.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S44.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('79AE44E2-98A3-49A5-A94B-D5654AAC6F4F', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('79AE44E2-98A3-49A5-A94B-D5654AAC6F4F', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('79AE44E2-98A3-49A5-A94B-D5654AAC6F4F', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('79AE44E2-98A3-49A5-A94B-D5654AAC6F4F', '079c4976-49a8-4b30-83bf-3e13cbaa9382')

End
                                                                                                                                                                                                                                                                                                                     
Go  
--เพิ่มเมนูคัดลอกด้านและตัวบ่งชี้การประเมินรอบ 4
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'D33E419B-F4EE-4983-AE46-6BB620574589')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('D33E419B-F4EE-4983-AE46-6BB620574589', 'คัดลอกด้าน/ตัวบ่งชี้การประเมินรอบ 4', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 47, 'MasterData/CopyFourthAssessment.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S09.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('D33E419B-F4EE-4983-AE46-6BB620574589', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('D33E419B-F4EE-4983-AE46-6BB620574589', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('D33E419B-F4EE-4983-AE46-6BB620574589', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('D33E419B-F4EE-4983-AE46-6BB620574589', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มเมนูจำนวนโครงการรายตัวบ่งชี้การประเมินรอบ 4
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'F71C6515-1DEE-4C72-87DD-C271FEB746C7')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('F71C6515-1DEE-4C72-87DD-C271FEB746C7', 'จำนวนโครงการรายตัวบ่งชี้การประเมินรอบ 4', '8de87893-6cd6-4900-968a-db0e8832d043', 15, 'MasterData/ReportCountFourthAssessmentView.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S21.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('F71C6515-1DEE-4C72-87DD-C271FEB746C7', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('F71C6515-1DEE-4C72-87DD-C271FEB746C7', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('F71C6515-1DEE-4C72-87DD-C271FEB746C7', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('F71C6515-1DEE-4C72-87DD-C271FEB746C7', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
----------ลบ StoreProcedure เมนู FourthAssessment
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuFourthAssessment')
Begin
	DROP PROCEDURE ckMenuFourthAssessment
End

Go
--เพิ่ม Store เมนู FourthAssessment
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuFourthAssessment
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '7004BD52-7F9D-4CE5-8433-54F836C6C296'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '79AE44E2-98A3-49A5-A94B-D5654AAC6F4F'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'D33E419B-F4EE-4983-AE46-6BB620574589'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'F71C6515-1DEE-4C72-87DD-C271FEB746C7'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '7004BD52-7F9D-4CE5-8433-54F836C6C296'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '79AE44E2-98A3-49A5-A94B-D5654AAC6F4F'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'D33E419B-F4EE-4983-AE46-6BB620574589'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'F71C6515-1DEE-4C72-87DD-C271FEB746C7'
	End
END

Go
----------Update ค่าตัวเช็ค
Update MR_School Set ckFourthAssessment = 0 Where ckFourthAssessment Is Null

Go
--เพิ่มข้อมูลตัวชี้ตัวบ่งชี้ สมศ.
If Not Exists(Select * From IndicatorSMS Where StudyYear = 2558)                                                                                                                                                                                                              
Begin
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'1b838e1e-521f-4024-b1d9-bd1cb830f08c', 2558, N'เอกลักษณ์สถานศึกษา', 18, 0, CAST(0x0000A5A300AE12DE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE90D9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'3b4988b6-2631-4ad3-a2b1-3abd508355d1', 2558, N'มาตรการส่งเสริม', 19, 0, CAST(0x0000A5A300AE17A3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE9356 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'42f5ae0a-c664-4b61-8ee8-59ce38d694c7', 2558, N'การดำเนินงานของผู้อำนวยการ', 10, 0, CAST(0x0000A5A300AD8B3E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE76D1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'477b1d46-7edb-4723-ae2f-f9d27be87b77', 2558, N'ผู้เรียนเป็นคนดี', 1, 0, CAST(0x0000A5A300AC57DA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE5940 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'4cd3920d-ce91-4728-941c-ec431a8484be', 2558, N'ครู/อาจารย์มีผลงานที่นำไปใช้ประโยชน์', 7, 0, CAST(0x0000A5A300AD61C6 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE6DFE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'4d3dfbf9-5465-411e-9313-63cea41b12a1', 2558, N'การพัฒนาสุนทรียภาพ', 16, 0, CAST(0x0000A5A300AE0878 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE8BB6 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'549aad5c-f4c7-4eb4-b966-624ebff11035', 2558, N'ผู้เรียนมีความรู้ความสามารถตามหลักสูตร', 2, 0, CAST(0x0000A5A300ACD418 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE5D5A AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'58fd7c60-67df-4a33-8857-2328521bcfbb', 2558, N'ผู้เรียนมีทักษะชีวิต', 4, 0, CAST(0x0000A5A300ACEA48 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE65DF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'6111a6ab-df8b-46f5-bd5e-1797e1df03b8', 2558, N'การให้ความร่วมมือที่ส่งผลต่อชุมชน/สังคม', 13, 0, CAST(0x0000A5A300ADF3CF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE8177 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'82338b3d-5c37-4ad2-a2a9-b6490bd45318', 2558, N'มาตรการส่งเสริม (ภายนอกสถานศึกษา)', 20, 0, CAST(0x0000A5A300AE1DF3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE9666 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'8bb38e8d-d816-430d-86a6-ebe8680e2447', 2558, N'การดำเนินงานของคณะกรรมการสถานศึกษา', 9, 0, CAST(0x0000A5A300AD83B3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE73CB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'90f3b8f6-b4e5-440a-a9c3-e3155a0d26b6', 2558, N'การให้ความร่วมมือกับชุมชน/สังคมที่ส่งผลต่อสถานศึกษา', 14, 0, CAST(0x0000A5A300ADF98B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE85C8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'94218ae4-0cc9-42c2-85ca-a34ff73bf544', 2558, N'อัตลักษณ์ผู้เรียน', 17, 0, CAST(0x0000A5A300AE0D9B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE8E2C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'a516cb0c-df89-4e7b-b450-de4dbe72df26', 2558, N'ครู/อาจารย์ได้รับการเพิ่มพูนความรู้/ประสบการณ์', 8, 0, CAST(0x0000A5A300AD77C8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE70BB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'ae24506c-eaa1-4f03-95d5-51fb49d1bb40', 2558, N'ครู/อาจารย์สร้างสรรค์ห้องเรียน/แหล่งเรียนรู้คุณภาพ', 6, 0, CAST(0x0000A5A300AD5837 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE6B2D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'bbd1293e-cd0f-4f1e-a3c4-a4e7771ae480', 2558, N'การพัฒนาบุคลากรสายสนับสนุน', 12, 0, CAST(0x0000A5A300ADDDBF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE7E51 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'bc9fe1d1-6bdd-48b4-89d9-077a87bda52b', 2558, N'ครู/อาจารย์เป็นคนดี มีความสามารถ', 5, 0, CAST(0x0000A5A300AD4E0C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE6886 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'cb274bcc-226b-4617-ad9f-c79610693dab', 2558, N'การส่งเสริมสนับสนุนศิลปะและวัฒนธรรม', 15, 0, CAST(0x0000A5A300AE01ED AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE88E2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'd08f5b0f-8a7b-4496-ac51-d2b81e3de05d', 2558, N'ผู้เรียนมีความสามารถในการคิด', 3, 0, CAST(0x0000A5A300ACDF07 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE6280 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[IndicatorSMS] ([IndicatorSMSCode], [StudyYear], [IndicatorSMSName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'f34345b0-5010-4ec6-984b-89240b280bd5', 2558, N'การบริหารความเสี่ยง', 11, 0, CAST(0x0000A5A300ADD6B8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE7BC7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
End


--------------------- Ver 11.1.0.6 -----------------------
--/////////////////////////////////////////////////////////

Go
----------- เพิ่ม Table BudgetIncome รายรับตามประเภทเงิน ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('BudgetIncome'))
Begin
	CREATE TABLE [dbo].[BudgetIncome](
		[BudgetIncomeID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[BudgetTypeCode] [nvarchar](50) NULL,
		[MaAmount] [float] NULL,
		[TotalAmount] [float] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_BudgetIncome] PRIMARY KEY CLUSTERED 
	(
		[BudgetIncomeID] ASC
	)) ON [PRIMARY]
End

Go
----------- เพิ่ม Table BudgetExpenses รายจ่ายประจำตามประเภทเงิน ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('BudgetExpenses'))
Begin
	CREATE TABLE [dbo].[BudgetExpenses](
		[BudgetExpensesID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[BudgetTypeCode] [nvarchar](50) NULL,
		[TotalAmount] [float] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_BudgetExpenses] PRIMARY KEY CLUSTERED 
	(
		[BudgetExpensesID] ASC
	)) ON [PRIMARY]
End

--------------V 11.2.0.0---------------
GO

ALTER FUNCTION [dbo].[GetStandardSort]
(
	 @ProjectCode nvarchar(50) , @studyYear nvarchar(4)
)
RETURNS nvarchar(1500)
AS
BEGIN
	declare @StandardSort nvarchar(1000)
Select @StandardSort = coalesce(@StandardSort+char(10)+'','')+'มฐ.ที่ '+convert(nvarchar(5),s.Sort)+' ตัวบ่งชี้ '+ dbo.GetIndicatorSort(@ProjectCode , e.StandardCode)
from Evaluation e ,Indicators i , Standard s,Projects p 
where e.IndicatorsCode = i.IndicatorsCode and i.StandardCode = s.StandardCode and p.ProjectsCode = e.ProjectsCode
and p.ProjectsCode = @ProjectCode and s.StudyYear = @studyYear
group by s.Sort,e.StandardCode
order by s.Sort
	RETURN @StandardSort
END

--------------------------strTotalArea---------------------------
Go
--เพิ่มฟิวขนาดพื้นที่โรงเรียน strTotalArea
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'strTotalArea')
Begin
	alter table MR_School add strTotalArea nVarchar(100)
End

--------------------------ckReportProject---------------------------
Go
--เพิ่มฟิวตัวเช็คตัวรายงานโครงการ ckReportProject
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckReportProject')
Begin
	alter table MR_School add ckReportProject nVarchar(50)
End

--------------------------ckReportActivity---------------------------
Go
--เพิ่มฟิวตัวเช็คตัวรายงานกิจกรรม ckReportActivity
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckReportActivity')
Begin
	alter table MR_School add ckReportActivity nVarchar(50)
End

Go
----------Update ค่าตัวเช็ค
Update MR_School Set ckReportProject = '0,1,2,3' Where ckReportProject Is Null
Update MR_School Set ckReportActivity = '0,1' Where ckReportActivity Is Null


-----------------------------------------------------------------
------------------------ V 11.2.0.2 -----------------------------

----------------------------Risk----------------------------
Go
--เพิ่มฟิวตัวเช็คโหมดความเสี่ยง ckRisk
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckRisk')
Begin
	alter table MR_School add ckRisk bit
End

Go
--เพิ่มฟิวความเสี่ยง Risk
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'Risk')
Begin
	alter table Activity add Risk nVarchar(4000)
End

Go
--เพิ่มฟิวแนวทางป้องกัน Protect
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'Protect')
Begin
	alter table Activity add Protect nVarchar(4000)
End

Go
--เพิ่มฟิวรอง ผอ. กลุ่ม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'UnderManagerName')
Begin
	alter table MR_School add UnderManagerName nVarchar(100)
End

Go
--เพิ่มฟิวตำแหน่งรอง ผอ. กลุ่ม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'PositionUnderManagerName')
Begin
	alter table MR_School add PositionUnderManagerName nVarchar(100)
End

Go
----------Update ค่าตัวเช็ค
Update MR_School Set ckRisk = 0 Where ckRisk Is Null


-----------------------------------------------------------------
------------------------ V 11.2.0.6 -----------------------------

Go
--เพิ่มฟิวตัวเช็คตัวแผนงาน ckPlan
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckPlan')
Begin
	alter table MR_School add ckPlan bit
End

Go
--เพิ่มฟิวตัวเช็คติดตามประเมินผลแบบตาราง ckAcAssessment
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckAcAssessment')
Begin
	alter table MR_School add ckAcAssessment bit
End

Go
--เพิ่มฟิวตัวเช็คตัวหน่วยงานในโครงการ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckDeptProjects')
Begin
	alter table MR_School add ckDeptProjects bit
End

Go
--เพิ่มฟิวตัวเช็คงบประมาณแยกเทอม (สวนนนท์)
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckBudgetTerm')
Begin
	alter table MR_School add ckBudgetTerm bit
End

Go
--เพิ่มฟิวหน่วยงานในโครงการ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Projects') And Name = 'DeptProjectsName')
Begin
	alter table Projects add DeptProjectsName nVarChar(200)
End

Go
--เพิ่มฟิวงบอื่น ๆ ในขั้นตอนดำเนินงานในกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ActivityOperation2') And Name = 'BudgetOther')
Begin
	alter table ActivityOperation2 add BudgetOther float
End

Go
--เพิ่มฟิวจำนวนงบประมาณแยกเทอม1
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('CostsDetail') And Name = 'TotalBudgetTerm1')
Begin
	alter table CostsDetail add TotalBudgetTerm1 float
End

Go
--เพิ่มฟิวจำนวนงบประมาณแยกเทอม2
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('CostsDetail') And Name = 'TotalBudgetTerm2')
Begin
	alter table CostsDetail add TotalBudgetTerm2 float
End

Go
----------- เพิ่ม Table dtPlan  เชื่อมโยง โครงการกับแผนงาน ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtPlan'))
Begin
	CREATE TABLE [dbo].[dtPlan](
		[ProjectsCode] [nvarchar](50) NULL,
		[PlanMode] [nvarchar](1) NULL
	) ON [PRIMARY]
End

--เพิ่ม Table การประเมินผลในโครงการ
GO
CREATE TABLE [dbo].[ProjectsAssessment](
	[ProjectsCode] [nvarchar](50) NULL,
	[RecNum] [int] NULL,
	[IndicatorsName] [nvarchar](300) NULL,
	[MethodAss] [nvarchar](300) NULL,
	[ToolsAss] [nvarchar](300) NULL
) ON [PRIMARY]

--เพิ่ม Table การประเมินผลในกิจกรรม
GO
CREATE TABLE [dbo].[ActivityAssessment](
	[ActivityCode] [nvarchar](50) NULL,
	[RecNum] [int] NULL,
	[IndicatorsName] [nvarchar](300) NULL,
	[MethodAss] [nvarchar](300) NULL,
	[ToolsAss] [nvarchar](300) NULL
) ON [PRIMARY]

----------- เพิ่ม Table dtStrategicPlan  กลยุทธ์แผนงานกับโครงการ ------------
Go
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtStrategicPlan'))
Begin
	CREATE TABLE [dbo].[dtStrategicPlan](
		[ProjectsCode] [nvarchar](50) NULL,
		[StrategicPlanID] [nvarchar](50) NULL
	) ON [PRIMARY]
End

Go
Update MR_School Set ckPlan = 0 Where ckPlan Is Null
Go
Update MR_School Set ckAcAssessment = 0 Where ckAcAssessment Is Null
Go
Update MR_School Set ckDeptProjects = 0 Where ckDeptProjects Is Null
Go
Update MR_School Set ckBudgetTerm = 0 Where ckBudgetTerm Is Null
Go
Update CostsDetail Set TotalBudgetTerm1 = 0 Where TotalBudgetTerm1 Is Null
Go
Update CostsDetail Set TotalBudgetTerm2 = 0 Where TotalBudgetTerm2 Is Null
Go
Update ActivityOperation2 Set BudgetOther = 0 Where BudgetOther Is Null


-----------------------------------------------------------------
------------------------ V 11.2.0.7 -----------------------------
alter table ActivityAssessment alter column IndicatorsName nvarchar(1000)
alter table ActivityAssessment alter column MethodAss nvarchar(1000)
alter table ActivityAssessment alter column ToolsAss nvarchar(1000)


-------------------------------------------------------------------
------------------------- V 11.2.0.8 ------------------------------

----------- เพิ่ม Table dtCorporateStrategy  กลยุทธ์องค์กรกับโครงการ ------------
Go
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtCorporateStrategy'))
Begin
	CREATE TABLE [dbo].[dtCorporateStrategy](
		[ProjectsCode] [nvarchar](50) NULL,
		[CorporateStrategyID] [nvarchar](50) NULL
	) ON [PRIMARY]
End

--------ส่วนการเบิกย่อย
Go
--เพิ่มฟิวรอง ผอ. กลุ่ม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ActivityDetail') And Name = 'UnderManagerName')
Begin
	alter table ActivityDetail add UnderManagerName nVarchar(100)
End

Go
--เพิ่มฟิวตำแหน่งรอง ผอ. กลุ่ม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ActivityDetail') And Name = 'PositionUnderManagerName')
Begin
	alter table ActivityDetail add PositionUnderManagerName nVarchar(150)
End


-------------------------------------------------------------------
------------------------- V 11.2.0.9 ------------------------------
--------ส่วนการเบิกย่อย
Go
--เพิ่มฟิวผู้รับผิดชอบกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ActivityDetail') And Name = 'ResponsibleName')
Begin
	alter table ActivityDetail add ResponsibleName nVarchar(100)
End

Go
--เพิ่มฟิวตำแหน่งผู้รับผิดชอบกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ActivityDetail') And Name = 'PositionResponsible')
Begin
	alter table ActivityDetail add PositionResponsible nVarchar(150)
End

Go
--เพิ่มฟิวหัวหน้ากลุ่มงาน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ActivityDetail') And Name = 'HeadGroupName')
Begin
	alter table ActivityDetail add HeadGroupName nVarchar(100)
End

Go
--เพิ่มฟิวตำแหน่งหัวหน้ากลุ่มงาน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ActivityDetail') And Name = 'PositionHeadGroup')
Begin
	alter table ActivityDetail add PositionHeadGroup nVarchar(150)
End

Go
--เพิ่มฟิวหัวหน้างาน/กลุ่มสาระฯ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ActivityDetail') And Name = 'HeadGroupSaraName')
Begin
	alter table ActivityDetail add HeadGroupSaraName nVarchar(100)
End

Go
--เพิ่มฟิวตำแหน่งหัวหน้างาน/กลุ่มสาระฯ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ActivityDetail') And Name = 'PositionHeadGroupSara')
Begin
	alter table ActivityDetail add PositionHeadGroupSara nVarchar(150)
End

Go
--เพิ่มลำดับที่รายการเบิกย่อยใบกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('CostsDetail') And Name = 'ListNo')
Begin
	alter table CostsDetail add ListNo tinyint
End

Go
--เพิ่มลำดับที่รายการเบิกย่อยใบเบิกย่อยกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ActivityCostsDetail') And Name = 'ListNo')
Begin
	alter table ActivityCostsDetail add ListNo tinyint
End


-------------------------------------------------------------------
------------------------- V 11.2.0.10 ------------------------------
------ Update รูปกิจกรรม
GO
INSERT [dbo].[Multimedia] ([ItemId], [TypeId], [ParentId], [Title], [Description], [Detail], [FileUrl], [FileSize], [FileType], [CategoryId], [SubjectId], [ChapterId], [LessonID], [DepID], [MediaYear], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [Source], [Shared], [Enabled], [SchoolID], [ReferID], [Flag]) VALUES (N'44bb8c12-39ad-435e-ba27-6dcd87cbad69', 0, NULL, N'Adventurer Donut.jpg', NULL, NULL, N'', 148037, N'image/jpeg', NULL, NULL, NULL, NULL, NULL, N'2016', N'8a26b24d-89f1-4e79-b66e-10b5b043e02d', CAST(0xA6B500C2 AS SmallDateTime), N'8a26b24d-89f1-4e79-b66e-10b5b043e02d', CAST(0xA6B500C2 AS SmallDateTime), N'1', 0, 1, NULL, N'99999999-aaaa-bbbb-cccc-999999999999', 0)
GO
INSERT [dbo].[Multimedia] ([ItemId], [TypeId], [ParentId], [Title], [Description], [Detail], [FileUrl], [FileSize], [FileType], [CategoryId], [SubjectId], [ChapterId], [LessonID], [DepID], [MediaYear], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [Source], [Shared], [Enabled], [SchoolID], [ReferID], [Flag]) VALUES (N'b7a1a7b4-b7e8-4f5e-8889-7681ab058664', 0, NULL, N'Adventurer Cheesecake Brownie.jpg', NULL, NULL, N'', 345132, N'image/jpeg', NULL, NULL, NULL, NULL, NULL, N'2016', N'8a26b24d-89f1-4e79-b66e-10b5b043e02d', CAST(0xA6B500C2 AS SmallDateTime), N'8a26b24d-89f1-4e79-b66e-10b5b043e02d', CAST(0xA6B500C2 AS SmallDateTime), N'1', 0, 1, NULL, N'99999999-aaaa-bbbb-cccc-999999999999', 0)
GO
INSERT [dbo].[Multimedia] ([ItemId], [TypeId], [ParentId], [Title], [Description], [Detail], [FileUrl], [FileSize], [FileType], [CategoryId], [SubjectId], [ChapterId], [LessonID], [DepID], [MediaYear], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [Source], [Shared], [Enabled], [SchoolID], [ReferID], [Flag]) VALUES (N'f8645a35-2adc-4d3e-b8f9-923c22c2402b', 0, NULL, N'Adventurer Caramel.jpg', NULL, NULL, N'', 293458, N'image/jpeg', NULL, NULL, NULL, NULL, NULL, N'2016', N'8a26b24d-89f1-4e79-b66e-10b5b043e02d', CAST(0xA6B500C2 AS SmallDateTime), N'8a26b24d-89f1-4e79-b66e-10b5b043e02d', CAST(0xA6B500C2 AS SmallDateTime), N'1', 0, 1, NULL, N'99999999-aaaa-bbbb-cccc-999999999999', 0)
GO
INSERT [dbo].[Multimedia] ([ItemId], [TypeId], [ParentId], [Title], [Description], [Detail], [FileUrl], [FileSize], [FileType], [CategoryId], [SubjectId], [ChapterId], [LessonID], [DepID], [MediaYear], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [Source], [Shared], [Enabled], [SchoolID], [ReferID], [Flag]) VALUES (N'14b9416a-767b-4f56-9183-965a0cd375e8', 0, NULL, N'Adventurer Lemon.jpg', NULL, NULL, N'', 284215, N'image/jpeg', NULL, NULL, NULL, NULL, NULL, N'2016', N'8a26b24d-89f1-4e79-b66e-10b5b043e02d', CAST(0xA6B500C2 AS SmallDateTime), N'8a26b24d-89f1-4e79-b66e-10b5b043e02d', CAST(0xA6B500C2 AS SmallDateTime), N'1', 0, 1, NULL, N'99999999-aaaa-bbbb-cccc-999999999999', 0)


 ------------------------------ V 11.2.0.11-------------------------
 Go
 Update Multimedia Set Title = 'Change Picture.jpg' Where ItemID = '44bb8c12-39ad-435e-ba27-6dcd87cbad69'
 Go
 Update Multimedia Set Title = 'Upload Picture.jpg' Where ItemID = 'b7a1a7b4-b7e8-4f5e-8889-7681ab058664'


 ------------------------------- V 11.3.0.3------------------------
 Go
--เพิ่มฟิวตำแหน่ง ผอ.
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'PositionManagerName')
Begin
	alter table MR_School add PositionManagerName nVarchar(100)
End

--------///////////////////////////////////////
--------- V 11.3.0.11 -------------

----------------------------NewStandard----------------------------
Go
--เพิ่มฟิวตัวเช็คโหมดมาตรฐานใหม่ ckNewStandard
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckNewStandard')
Begin
	alter table MR_School add ckNewStandard bit
End

----------------------------SUAN Model สวนกุหลาบ----------------------------
Go
--เพิ่มฟิวตัวเช็คโหมดสวนกุหลาบโมเดล ckSuan
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckSuan')
Begin
	alter table MR_School add ckSuan bit
End

Go
--เพิ่มฟิวเอกลักษณ์
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'SuanIdentityName')
Begin
	alter table Activity add SuanIdentityName tinyint
End

Go
--เพิ่มฟิวเอกลักษณ์ด้าน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'SuanIdentitySideName')
Begin
	alter table Activity add SuanIdentitySideName nVarChar(50)
End

Go
--เพิ่มฟิวอัตลักษณ์
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'SuanIdentityName2')
Begin
	alter table Activity add SuanIdentityName2 tinyint
End

Go
--เพิ่มฟิวผลดี
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'SuanGood')
Begin
	alter table Activity add SuanGood tinyint
End

Go
--เพิ่ม Table มาตรฐานใหม่
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('NewStandard'))
Begin
	CREATE TABLE [dbo].[NewStandard](
		[StandardCode] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[StandardName] [nvarchar](500) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
		[ScoreGroupID] [nvarchar](50) NULL,
	 CONSTRAINT [PK_NewStandard] PRIMARY KEY CLUSTERED 
	(
		[StandardCode] ASC
	)) ON [PRIMARY]
End

Go
----------- เพิ่ม Table dtNewStandard  เชื่อมโยง โครงการกับมาตรฐานใหม่ ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtNewStandard'))
Begin
	CREATE TABLE [dbo].[dtNewStandard](
		[ProjectsCode] [nvarchar](50) NULL,
		[StandardCode] [nvarchar](50) NULL
	) ON [PRIMARY]
End

Go
--เพิ่มข้อมูลมาตรฐานใหม่
If Not Exists(Select * From NewStandard)                                                                                                                      
Begin
	INSERT [dbo].[NewStandard] ([StandardCode], [StudyYear], [StandardName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'bc512fce-1970-47c3-92a0-4ca70252ffdf', 2560, N'คุณภาพของผู้เรียน', 1, 0, CAST(0x0000A5A300AE12DE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE90D9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[NewStandard] ([StandardCode], [StudyYear], [StandardName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'9149680b-8f0b-47b9-adae-152eb1ed04df', 2560, N'กระบวนการบริหารและการจัดการของผู้บริหารสถานศึกษา', 2, 0, CAST(0x0000A5A300AE12DE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE90D9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[NewStandard] ([StandardCode], [StudyYear], [StandardName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'66a17ee5-0c59-4978-937e-d80c4841c225', 2560, N'กระบวนการจัดการเรียนการสอนที่เน้นผู้เรียนเป็นสำคัญ', 3, 0, CAST(0x0000A5A300AE12DE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE90D9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[NewStandard] ([StandardCode], [StudyYear], [StandardName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'3641c8ed-59e8-4989-80c4-764edac29acc', 2560, N'ระบบการประกันคุณภาพภายในที่มีประสิทธิผล', 4, 0, CAST(0x0000A5A300AE12DE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A5A300AE90D9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
End

Go
--เพิ่มเมนูมาตรฐานใหม่
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'DFD97AE1-AD7D-4536-A8FB-5DDF4CA16F42')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('DFD97AE1-AD7D-4536-A8FB-5DDF4CA16F42', 'มาตรฐานใหม่', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 10, 'MasterData/NewStandard.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S43.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('DFD97AE1-AD7D-4536-A8FB-5DDF4CA16F42', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('DFD97AE1-AD7D-4536-A8FB-5DDF4CA16F42', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('DFD97AE1-AD7D-4536-A8FB-5DDF4CA16F42', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('DFD97AE1-AD7D-4536-A8FB-5DDF4CA16F42', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End


Go
--เพิ่มเมนูจำนวนโครงการตามมาตรฐานใหม่
If Not Exists(Select * From MySubMenu Where MySubMenuID = '44EA78A3-A832-4B4F-8A73-05B986A111A9')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('44EA78A3-A832-4B4F-8A73-05B986A111A9', 'จำนวนโครงการตามมาตรฐานใหม่', '8de87893-6cd6-4900-968a-db0e8832d043', 16, 'MasterData/ReportCountNewStandard.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S23.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('44EA78A3-A832-4B4F-8A73-05B986A111A9', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('44EA78A3-A832-4B4F-8A73-05B986A111A9', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('44EA78A3-A832-4B4F-8A73-05B986A111A9', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('44EA78A3-A832-4B4F-8A73-05B986A111A9', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
----------ลบ StoreProcedure เมนู NewStandard
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuNewStandard')
Begin
	DROP PROCEDURE ckMenuNewStandard
End

Go
--เพิ่ม Store เมนู NewStandard
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuNewStandard
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'DFD97AE1-AD7D-4536-A8FB-5DDF4CA16F42'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '44EA78A3-A832-4B4F-8A73-05B986A111A9'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'DFD97AE1-AD7D-4536-A8FB-5DDF4CA16F42'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '44EA78A3-A832-4B4F-8A73-05B986A111A9'
	End
END

Go
Update MR_School Set ckNewStandard = 0 Where ckNewStandard Is Null
Go
Update MR_School Set ckSuan = 0 Where ckSuan Is Null


-----------//// V 11.3.0.12 /////////
Go
--แก้ไขฟิวอัตลักษณ์
alter table Activity alter column SuanIdentityName2 nvarchar(50)
Go
alter table Activity alter column SuanGood nvarchar(50)


-----------//// V 11.3.0.14 /////////
Go
--เพิ่มเมนูรายงานสรุปการใช้งบประมาณ
If Not Exists(Select * From MySubMenu Where MySubMenuID = '21589C0E-97E5-4AB6-821F-6815114F9A7F')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('21589C0E-97E5-4AB6-821F-6815114F9A7F', 'รายงานสรุปการใช้งบประมาณ', '434de3e9-c4d5-4bed-9b00-c7603e4c335e', 22, 'MasterData/ReportBudgetNotCloseByBudgetType.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S07.gif')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('21589C0E-97E5-4AB6-821F-6815114F9A7F', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('21589C0E-97E5-4AB6-821F-6815114F9A7F', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('21589C0E-97E5-4AB6-821F-6815114F9A7F', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('21589C0E-97E5-4AB6-821F-6815114F9A7F', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End


--------- V 11.3.0.16 -------------
----------------------------StandardNew----------------------------
Go
--เพิ่มฟิวตัวเช็คโหมดมาตรฐานใหม่ ckStandardNew
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckStandardNew')
Begin
	alter table MR_School add ckStandardNew bit
End

Go
--เพิ่มข้อมูลมาตรฐานใหม่ (ด้านเดิม)
If Not Exists(Select * From Side Where StudyYear = 2560 And DelFlag = 0)                                                                                                                      
Begin
	INSERT [dbo].[Side] ([SideCode], [StudyYear], [SideName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID]) VALUES (N'072c31ab-ad14-4298-86f9-e3a613f69da8', 2560, N'คุณภาพของผู้เรียน', 1, 0, CAST(0x0000A35700E3DD5F AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x0000A35700E547F6 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', N'950E2A3C-5B5B-4A51-8613-4EC393A1F495')
	INSERT [dbo].[Side] ([SideCode], [StudyYear], [SideName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID]) VALUES (N'625bcf8c-f1a2-45cf-b0e9-ef61c77a6b12', 2560, N'กระบวนการบริหารและการจัดการของผู้บริหารสถานศึกษา', 2, 0, CAST(0x0000A35700E3DD5F AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x0000A35700E547F6 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', N'950E2A3C-5B5B-4A51-8613-4EC393A1F495')
	INSERT [dbo].[Side] ([SideCode], [StudyYear], [SideName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID]) VALUES (N'804505d2-fe43-42c9-93d2-a7b6bee7813a', 2560, N'กระบวนการจัดการเรียนการสอนที่เน้นผู้เรียนเป็นสำคัญ', 3, 0, CAST(0x0000A35700E3DD5F AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x0000A35700E547F6 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', N'4996ad20-57fc-4dbc-a01d-698393d7affb')
	INSERT [dbo].[Side] ([SideCode], [StudyYear], [SideName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID]) VALUES (N'13b7a50d-533a-4714-8cff-ceb8c2001d90', 2560, N'ระบบการประกันคุณภาพภายในที่มีประสิทธิภาพ', 4, 0, CAST(0x0000A35700E3DD5F AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x0000A35700E547F6 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', N'4996ad20-57fc-4dbc-a01d-698393d7affb')
End

Go
If Not Exists(Select * From Standard Where StudyYear = 2560 And DelFlag = 0)                                                                                                                      
Begin
	INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES 
	(N'd3947874-2c71-40aa-b340-f33f47a2c9fd', N'ผลสัมฤทธิ์ทางวิชาการของผู้เรียน', N'072c31ab-ad14-4298-86f9-e3a613f69da8', 2560, N'', 1, 0, CAST(0x00009F7C00DEEF85 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F7C00DEEF86 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', N'4996ad20-57fc-4dbc-a01d-698393d7affb', NULL, NULL, NULL)
	INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES 
	(N'951da5cc-2fa5-4fad-a445-0a6929ebcaf3', N'คุณลักษณะที่พึงประสงค์ของผู้เรียน', N'072c31ab-ad14-4298-86f9-e3a613f69da8', 2560, N'', 2, 0, CAST(0x00009F7C00DEEF85 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F7C00DEEF86 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', N'3D9F922B-77D7-410E-8CC1-9BEA731E4F61', NULL, NULL, NULL)
	INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES 
	(N'29b55e83-0d23-48af-8413-d20fddeee7d0', N'การมีเป้าหมาย วิสัยทัศน์ และพันธกิจที่สถานศึกษากำหนดชัดเจน', N'625bcf8c-f1a2-45cf-b0e9-ef61c77a6b12', 2560, N'', 3, 0, CAST(0x00009F7C00DEEF85 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F7C00DEEF86 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', N'B434D787-CBAA-41E5-BA94-DDB60A8E3952', NULL, NULL, NULL)
	INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES 
	(N'0f9ec77e-19ba-4836-b623-14d2ca21f8c9', N'การวางแผนพัฒนาคุณภาพการจัดการศึกษาของสถานศึกษา', N'625bcf8c-f1a2-45cf-b0e9-ef61c77a6b12', 2560, N'', 4, 0, CAST(0x00009F7C00DEEF85 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F7C00DEEF86 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', N'4996ad20-57fc-4dbc-a01d-698393d7affb', NULL, NULL, NULL)
	INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES 
	(N'2f30a034-5b3e-4c77-9891-2008c3f8aada', N'การมีส่วนร่วมของผู้เกี่ยวข้องทุกฝ่าย และการร่วมรับผิดชอบต่อผลการจัดการศึกษาให้มีคุณภาพและได้มาตรฐาน', N'625bcf8c-f1a2-45cf-b0e9-ef61c77a6b12', 2560, N'', 5, 0, CAST(0x00009F7C00DEEF85 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F7C00DEEF86 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', N'8203609C-DC86-4409-9CC8-89A8AC90674A', NULL, NULL, NULL)
	INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES 
	(N'0b1c4530-2a2e-4015-8c8a-d3630d910216', N'การกำกับ ติดตาม ประเมินผลการบริหารและการจัดการศึกษา', N'625bcf8c-f1a2-45cf-b0e9-ef61c77a6b12', 2560, N'', 6, 0, CAST(0x00009F7C00DEEF85 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F7C00DEEF86 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', N'00EB2C36-B042-472F-BD5D-1DF7C57568C4', NULL, NULL, NULL)
	INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES 
	(N'a83f7691-fd2d-429b-ac95-0892461f4273', N'การมีกระบวนการเรียนการสอนที่สร้างโอกาสให้ผู้เรียนทุกคนมีส่วนร่วม', N'804505d2-fe43-42c9-93d2-a7b6bee7813a', 2560, N'', 7, 0, CAST(0x00009F7C00DEEF85 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F7C00DEEF86 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', N'4996ad20-57fc-4dbc-a01d-698393d7affb', NULL, NULL, NULL)
	INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES 
	(N'ee4b9d0e-2285-4ca3-a7da-a42bd49c45e5', N'การจัดการเรียนการสอนที่ยึดโยงกับบริบทของชุมชนและท้องถิ่น', N'804505d2-fe43-42c9-93d2-a7b6bee7813a', 2560, N'', 8, 0, CAST(0x00009F7C00DEEF85 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F7C00DEEF86 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', N'B434D787-CBAA-41E5-BA94-DDB60A8E3952', NULL, NULL, NULL)
	INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES 
	(N'18818e2b-f4f0-4f88-ab7c-8e87e069d321', N'การตรวจสอบประเมินความรู้ความเข้าใจของผู้เรียนอย่างเป็นระบบ และมีประสิทธิภาพ', N'804505d2-fe43-42c9-93d2-a7b6bee7813a', 2560, N'', 9, 0, CAST(0x00009F7C00DEEF85 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F7C00DEEF86 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', N'B434D787-CBAA-41E5-BA94-DDB60A8E3952', NULL, NULL, NULL)
	INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES 
	(N'3baa7ae0-2b24-47ea-8c72-a4c6221a058d', N'การใช้ระบบการประกันคุณภาพภายในเพื่อยกระดับคุณภาพการจัดการศึกษาให้ดียิ่งขึ้น', N'13b7a50d-533a-4714-8cff-ceb8c2001d90', 2560, N'', 10, 0, CAST(0x00009F7C00DEEF85 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F7C00DEEF86 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', N'4996ad20-57fc-4dbc-a01d-698393d7affb', NULL, NULL, NULL)
End

Go
If Not Exists(Select I.* From Standard S, Indicators I Where S.StandardCode = I.StandardCode And S.StudyYear = 2560 And I.DelFlag = 0)                                                                                                                      
Begin
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'3b8f717d-e08c-424c-881c-394b2fbe9222', N'd3947874-2c71-40aa-b340-f33f47a2c9fd', N'ความสามารถในการอ่าน การเขียน การสื่อสารและการคิดคำนวณ ตามเกณฑ์ของแต่ละดับชั้น', N'', N'', 5, N'', N'', 1, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'951f3c80-06b2-4ee1-b4a3-2a4c3de1fb92', N'd3947874-2c71-40aa-b340-f33f47a2c9fd', N'ความสามารถในการคิดวิเคราะห์และคิดอย่างมีวิจารณญาณ อภิปรายแลกเปลี่ยนความคิดเห็นและแก้ปัญหา', N'', N'', 5, N'', N'', 2, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'3e1e09a1-4083-4671-ae72-8e4ba5cc927a', N'd3947874-2c71-40aa-b340-f33f47a2c9fd', N'ความสามารถในการใช้เทคโนโลยีสารสนเทศและการสื่อสาร', N'', N'', 3, N'', N'', 3, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'8203609C-DC86-4409-9CC8-89A8AC90674A')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'3c12421d-b127-45b1-b17c-6a62cbef0441', N'd3947874-2c71-40aa-b340-f33f47a2c9fd', N'ความก้าวหน้าทางการเรียนตามหลักสูตรสถานศึกษา', N'', N'', 2, N'', N'', 4, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'6c8cba5d-207c-4cd5-b154-aa849bc7a898', N'd3947874-2c71-40aa-b340-f33f47a2c9fd', N'ผลสัมฤทธิ์ทางการเรียนและพัฒนาการจากผลการสอบวัดระดับชาติ', N'', N'', 3, N'', N'', 5, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'8203609C-DC86-4409-9CC8-89A8AC90674A')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'031d8a24-3677-46ff-b531-e3872e2b27c9', N'd3947874-2c71-40aa-b340-f33f47a2c9fd', N'ความพร้อมในการศึกษาต่อ การฝึกงานหรือการทำงาน', N'', N'', 2, N'', N'', 6, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'53587cb8-8a0f-419a-b647-4fed05df4666', N'951da5cc-2fa5-4fad-a445-0a6929ebcaf3', N'การมีคุณลักษณะและค่านิยมที่ดีตามที่สถานศึกษากำหนด โดยไม่ขัดกฏหมายและวัฒนธรรมอันดีของสังคม', N'', N'', 2, N'', N'', 1, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'c7bd4e51-39a1-43d7-b84d-098132ef3e13', N'951da5cc-2fa5-4fad-a445-0a6929ebcaf3', N'ความภูมิใจในท้องถิ่นและความเป็นไทย', N'', N'', 3, N'', N'', 2, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'8203609C-DC86-4409-9CC8-89A8AC90674A')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'2c4b5660-eafb-43e6-971b-b0b3afee8cc8', N'951da5cc-2fa5-4fad-a445-0a6929ebcaf3', N'การยอมรับที่จะอยู่ร่วมกันบนความแตกต่างและหลากหลาย', N'', N'', 2, N'', N'', 3, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'dcd2d76c-c5e3-42bb-8b9b-d68a4e1f82a9', N'951da5cc-2fa5-4fad-a445-0a6929ebcaf3', N'สุขภาวะทางร่างกายและลักษณะจิตสังคม', N'', N'', 3, N'', N'', 4, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'8203609C-DC86-4409-9CC8-89A8AC90674A')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'e73cbc15-7f92-4b46-9b0e-c689f5528ad2', N'29b55e83-0d23-48af-8413-d20fddeee7d0', N'ไม่มีประเด็นย่อย', N'', N'', 5, N'', N'', 1, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'c3ab8f4f-59b1-4af9-9e5b-83da2597a3ad', N'0f9ec77e-19ba-4836-b623-14d2ca21f8c9', N'การวางแผนและดำเนินงานพัฒนาวิชาการที่เน้นคุณภาพของผู้เรียนรอบด้านทุกกลุ่มเป้าหมาย และดำเนินการอย่างเป็นรูปธรรม', N'', N'', 5, N'', N'', 1, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'dff82aa6-a63b-47da-a8c3-fbe6a8ceae85', N'0f9ec77e-19ba-4836-b623-14d2ca21f8c9', N'การวางแผนและดำเนินงานพัฒนาครูและบุคลากรให้มีความเชี่ยวชาญทางวิชาชีพ', N'', N'', 5, N'', N'', 2, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'b9fe34b2-9655-4c9c-8797-c11fd0b8e3c4', N'0f9ec77e-19ba-4836-b623-14d2ca21f8c9', N'การวางแผนการบริหารและการจัดการข้อมูลสารสนเทศอย่างเป็นระบบ', N'', N'', 5, N'', N'', 3, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'8c2bccdc-a300-43c2-87a2-06d8baef3352', N'0f9ec77e-19ba-4836-b623-14d2ca21f8c9', N'การวางแผนและจัดสภาพแวดล้อมทางกายภาพและสังคมที่เอื้อต่อการจัดการเรียนรู้อย่างมีคุณภาพ', N'', N'', 5, N'', N'', 4, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'f3b18886-5940-4841-b0c3-09d457ab58b4', N'2f30a034-5b3e-4c77-9891-2008c3f8aada', N'ไม่มีประเด็นย่อย', N'', N'', 3, N'', N'', 1, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'8203609C-DC86-4409-9CC8-89A8AC90674A')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'329eb992-232a-4237-9b57-67abe1481bac', N'0b1c4530-2a2e-4015-8c8a-d3630d910216', N'ไม่มีประเด็นย่อย', N'', N'', 2, N'', N'', 1, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'ae07d5ef-f193-4c5c-aa3d-cda2b80469a9', N'a83f7691-fd2d-429b-ac95-0892461f4273', N'ไม่มีประเด็นย่อย', N'', N'', 10, N'', N'', 1, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'3D9F922B-77D7-410E-8CC1-9BEA731E4F61')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'dc3ebdc5-129e-43bf-a7c3-46aaa9f6a6e1', N'ee4b9d0e-2285-4ca3-a7da-a42bd49c45e5', N'ไม่มีประเด็นย่อย', N'', N'', 5, N'', N'', 1, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'105f8855-c5fe-43a0-96e8-c2ea1acd4822', N'18818e2b-f4f0-4f88-ab7c-8e87e069d321', N'ไม่มีประเด็นย่อย', N'', N'', 5, N'', N'', 1, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
	INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES 
	(N'858e4708-b94c-4d94-af94-ba649a346eaa', N'3baa7ae0-2b24-47ea-8c72-a4c6221a058d', N'ไม่มีประเด็นย่อย', N'', N'', 20, N'', N'', 1, 0, CAST(0x00009D7200E35798 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', CAST(0x00009F10012D5624 AS DateTime), N'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', 0, N'4996ad20-57fc-4dbc-a01d-698393d7affb')
End

GO
/****** Object:  StoredProcedure [dbo].[GenRate]    Script Date: 3/7/2560 15:46:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	ALTER PROCEDURE [dbo].[GenRate]
		@RateType int
	AS
	BEGIN
		SET NOCOUNT ON;
		IF @RateType = 0
		Begin
			----------------เก่า---------------------
			-----------0.5
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๒๔', TMin = 0, TMax = 0.24 Where TcriteriaID = '990f80da-c07c-41b5-ac1f-5e8a45e5bb0e'
			Update TCriteria Set Detail = '๐.๒๕ - ๐.๒๙', TMin = 0.25, TMax = 0.29 Where TcriteriaID = '50a812bd-f27e-4259-8946-004c1044fabf'
			Update TCriteria Set Detail = '๐.๓๐ - ๐.๓๔', TMin = 0.3, TMax = 0.34 Where TcriteriaID = '573fcdb2-0f1d-42d4-95a9-2ce3b2dd5fd4'
			Update TCriteria Set Detail = '๐.๓๕ - ๐.๓๙', TMin = 0.35, TMax = 0.39, Translation = N'ดีมาก' Where TcriteriaID = 'de5b6ed8-a080-468d-8cca-a302d0f5e73b'
			Update TCriteria Set Detail = '๐.๔๐ - ๐.๕๐', TMin = 0.4, TMax = 0.5, DelFlag = 0 Where TcriteriaID = 'db2bedf7-9cf8-4495-a3b8-9ca572bd1f55'

			-----------1.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๔๙', TMin = 0, TMax = 0.49 Where TcriteriaID = '523325f5-5610-4074-8788-eeedf6b35e6c'
			Update TCriteria Set Detail = '๐.๕๐ - ๐.๕๙', TMin = 0.5, TMax = 0.59 Where TcriteriaID = '9a340d20-7c31-4955-a3c7-7fe5eb0a6be3'
			Update TCriteria Set Detail = '๐.๖๐ - ๐.๖๙', TMin = 0.6, TMax = 0.69 Where TcriteriaID = '6344b6e3-cfa7-4fdd-8b71-34470dd661ab'
			Update TCriteria Set Detail = '๐.๗๐ - ๐.๗๙', TMin = 0.7, TMax = 0.79, Translation = N'ดีมาก' Where TcriteriaID = '98d32855-a9ac-444e-a3f2-558961400149'
			Update TCriteria Set Detail = '๐.๘๐ - ๑.๐๐', TMin = 0.8, TMax = 1, DelFlag = 0 Where TcriteriaID = '138fb5bd-2a19-4a09-855e-43205d18ca7b'

			-----------2.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๙๙', TMin = 0, TMax = 0.99 Where TcriteriaID = '944cee00-2cea-400a-b5dc-081cf16e83a6'
			Update TCriteria Set Detail = '๑.๐๐ - ๑.๑๙', TMin = 1.0, TMax = 1.19 Where TcriteriaID = '6469c8d5-6542-471e-a31a-9c1b1681110b'
			Update TCriteria Set Detail = '๑.๒๐ - ๑.๓๙', TMin = 1.2, TMax = 1.39 Where TcriteriaID = 'fb08528d-fb28-4382-931d-cbbf28cf6b14'
			Update TCriteria Set Detail = '๑.๔๐ - ๑.๕๙', TMin = 1.4, TMax = 1.59, Translation = N'ดีมาก' Where TcriteriaID = '970f9571-a05c-4a6e-9270-e3b8b6346832'
			Update TCriteria Set Detail = '๑.๖๐ - ๒.๐๐', TMin = 1.6, TMax = 2, DelFlag = 0 Where TcriteriaID = 'e1923d69-300a-49e8-b2dd-558a1c9778a0'

			-----------3.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๔๙', TMin = 0, TMax = 1.49 Where TcriteriaID = 'e68d09a7-053d-4812-a5e2-5019600fc59a'
			Update TCriteria Set Detail = '๑.๕๐ - ๑.๗๙', TMin = 1.5, TMax = 1.79 Where TcriteriaID = 'c40a7ddb-5bf7-45f1-8339-bf23765d686d'
			Update TCriteria Set Detail = '๑.๘๐ - ๒.๐๙', TMin = 1.8, TMax = 2.09 Where TcriteriaID = 'a1c46154-02c8-47da-9c07-26d2fdd36eee'
			Update TCriteria Set Detail = '๒.๑๐ - ๒.๓๙', TMin = 2.1, TMax = 2.39, Translation = N'ดีมาก' Where TcriteriaID = '948736f6-16c6-4e50-96dd-f038ff34ff83'
			Update TCriteria Set Detail = '๒.๔๐ - ๓.๐๐', TMin = 2.4, TMax = 3, DelFlag = 0 Where TcriteriaID = '8b7b8f2e-cad2-4b76-b18b-d0066192b40a'

			-----------4.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๙๙', TMin = 0, TMax = 1.99 Where TcriteriaID = 'cfe6e7f9-d797-45d3-97bf-384a7ea2288d'
			Update TCriteria Set Detail = '๒.๐๐ - ๒.๓๙', TMin = 2, TMax = 2.39 Where TcriteriaID = '8c907257-17c1-45ed-a605-34721f5d1c5e'
			Update TCriteria Set Detail = '๒.๔๐ - ๒.๗๙', TMin = 2.4, TMax = 2.79 Where TcriteriaID = '5319e303-bff3-4ae9-9b2d-5138a43aa3bd'
			Update TCriteria Set Detail = '๒.๘๐ - ๓.๑๙', TMin = 2.8, TMax = 3.19, Translation = N'ดีมาก' Where TcriteriaID = '05a882f1-b133-4131-ad72-43cbc4d932cb'
			Update TCriteria Set Detail = '๓.๒๐ - ๔.๐๐', TMin = 3.2, TMax = 4, DelFlag = 0 Where TcriteriaID = 'fee73c78-23c3-4590-9fe4-08c98f72d1cd'

			-----------5.0
			Update TCriteria Set Detail = '๐.๐๐ - ๒.๔๙', TMin = 0, TMax = 2.49 Where TcriteriaID = 'a810252f-9bb6-48a7-b610-dc7a86996451'
			Update TCriteria Set Detail = '๒.๕๐ - ๒.๙๙', TMin = 2.5, TMax = 2.99 Where TcriteriaID = 'ecb48ab5-37ad-4ad0-b8ff-0fffefa8a3b3'
			Update TCriteria Set Detail = '๓.๐๐ - ๓.๔๙', TMin = 3, TMax = 3.49 Where TcriteriaID = 'af07711a-3896-4e93-9794-4c27b670acbf'
			Update TCriteria Set Detail = '๓.๕๐ - ๓.๙๙', TMin = 3.5, TMax = 3.99, Translation = N'ดีมาก' Where TcriteriaID = 'f4a8dcb9-7687-4f2c-9741-f2f8f1da694b'
			Update TCriteria Set Detail = '๔.๐๐ - ๕.๐๐', TMin = 4, TMax = 5, DelFlag = 0 Where TcriteriaID = 'aeb0b92f-8949-47d0-99cd-af3980734f21'

			-----------10.0
			Update TCriteria Set Detail = '๐.๐๐ - ๔.๙๙', TMin = 0, TMax = 4.99 Where TcriteriaID = 'c2c6d92d-e887-4bf0-885c-ca8bee4e807f'
			Update TCriteria Set Detail = '๕.๐๐ - ๕.๙๙', TMin = 5, TMax = 5.99 Where TcriteriaID = 'e0424d8a-e013-4482-895b-f0e8f4c52b12'
			Update TCriteria Set Detail = '๖.๐๐ - ๖.๙๙', TMin = 6, TMax = 6.99 Where TcriteriaID = 'b3f28c05-5d4d-43fb-9284-a84117a4c566'
			Update TCriteria Set Detail = '๗.๐๐ - ๗.๙๙', TMin = 7, TMax = 7.99, Translation = N'ดีมาก' Where TcriteriaID = '5f4e7061-4705-42b4-be20-01f144f08d5e'
			Update TCriteria Set Detail = '๘.๐๐ - ๑๐.๐๐', TMin = 8, TMax = 10, DelFlag = 0 Where TcriteriaID = '16b3f3e2-b8a1-481e-9661-5177aad558d3'

			-----------20.0
			Update TCriteria Set Detail = '๐.๐๐ - ๙.๙๙', TMin = 0, TMax = 9.99 Where TcriteriaID = '68927e0c-0400-4d0a-aec9-5bbebdedc891'
			Update TCriteria Set Detail = '๑๐.๐๐ - ๑๑.๙๙', TMin = 10, TMax = 11.99 Where TcriteriaID = '8f1c8c9b-b0bf-43e3-98df-4e75dcf3a098'
			Update TCriteria Set Detail = '๑๒.๐๐ - ๑๔.๙๙', TMin = 12, TMax = 14.99 Where TcriteriaID = '5e989d3b-1f19-437e-aab3-db1af0d6953f'
			Update TCriteria Set Detail = '๑๕.๐๐ - ๑๗.๙๙', TMin = 15, TMax = 17.99, Translation = N'ดีมาก' Where TcriteriaID = '2c3771cc-ef05-4448-be15-a51215e11e89'
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๐.๐๐', TMin = 18, TMax = 20, DelFlag = 0 Where TcriteriaID = 'e49d9c94-22f6-4c8a-9a5c-32fcdbe149a3'

			-----------30.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑๔.๙๙', TMin = 0, TMax = 14.99 Where TcriteriaID = 'b930e376-717b-4f50-bc69-803f88ff6402'
			Update TCriteria Set Detail = '๑๕.๐๐ - ๑๗.๙๙', TMin = 15, TMax = 17.99 Where TcriteriaID = '90983ed4-0799-4ca1-8145-a3b007a53a69'
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๐.๙๙', TMin = 18, TMax = 20.99 Where TcriteriaID = 'f497f305-8316-4d54-bcc8-2da0dc4fd9be'
			Update TCriteria Set Detail = '๒๑.๐๐ - ๒๓.๙๙', TMin = 21, TMax = 23.99, Translation = N'ดีมาก' Where TcriteriaID = '6c3191d9-13ab-4bfb-bddb-dc50623b4c3a'
			Update TCriteria Set Detail = '๒๔.๐๐ - ๓๐.๐๐', TMin = 24, TMax = 30, DelFlag = 0 Where TcriteriaID = 'f7818b1f-6b6b-46fc-9611-169c481e2c4d'

			-----------50.0
			Update TCriteria Set Detail = '๐.๐๐ - ๒๔.๙๙', TMin = 0, TMax = 24.99 Where TcriteriaID = '0e4d3521-401d-408f-8f2f-d69a509a2117'
			Update TCriteria Set Detail = '๒๕.๐๐ - ๒๙.๙๙', TMin = 25, TMax = 29.99 Where TcriteriaID = '32d76bf4-7e87-4575-910c-92761b2da74d'
			Update TCriteria Set Detail = '๓๐.๐๐ - ๓๔.๙๙', TMin = 30, TMax = 34.99 Where TcriteriaID = '7722765c-3e54-42a4-b209-5cafe57cc7b2'
			Update TCriteria Set Detail = '๓๕.๐๐ - ๓๙.๙๙', TMin = 35, TMax = 39.99, Translation = N'ดีมาก' Where TcriteriaID = 'bcc684de-202a-44ae-948e-d7dbb78f572e'
			Update TCriteria Set Detail = '๔๐.๐๐ - ๕๐.๐๐', TMin = 40, TMax = 50, DelFlag = 0 Where TcriteriaID = '48c0564e-b8d8-4963-8ab1-4910057944a6'

			-----------100.0
			Update TCriteria Set Detail = '๐.๐๐ - ๔๙.๙๙', TMin = 0, TMax = 49.99 Where TcriteriaID = '69c5bc62-b443-48c5-9a46-cd1e4df27003'
			Update TCriteria Set Detail = '๕๐.๐๐ - ๕๙.๙๙', TMin = 50, TMax = 59.99 Where TcriteriaID = '59291c4d-2eec-4ea2-8a2d-922b6a34fa4c'
			Update TCriteria Set Detail = '๖๐.๐๐ - ๖๙.๙๙', TMin = 60, TMax = 69.99 Where TcriteriaID = 'e277de33-3d86-4f09-b7b8-f3c97d585cb5'
			Update TCriteria Set Detail = '๗๐.๐๐ - ๗๙.๙๙', TMin = 70, TMax = 79.99, Translation = N'ดีมาก' Where TcriteriaID = 'facf0afb-b6f4-4675-9c47-774eb1d1b8af'
			Update TCriteria Set Detail = '๘๐.๐๐ - ๑๐๐.๐๐', TMin = 80, TMax = 100, DelFlag = 0 Where TcriteriaID = '6ecc7610-19d8-47cc-b728-15efd128fe21'
		End
		
		IF @RateType = 1
		Begin
			----------------ใหม่------------------
			---------0.5 (1)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๒๔', TMin = 0, TMax = 0.24 Where TcriteriaID = '990f80da-c07c-41b5-ac1f-5e8a45e5bb0e'
			Update TCriteria Set Detail = '๐.๒๕ - ๐.๒๙', TMin = 0.25, TMax = 0.29 Where TcriteriaID = '50a812bd-f27e-4259-8946-004c1044fabf'
			Update TCriteria Set Detail = '๐.๓๐ - ๐.๓๗', TMin = 0.3, TMax = 0.37 Where TcriteriaID = '573fcdb2-0f1d-42d4-95a9-2ce3b2dd5fd4'
			Update TCriteria Set Detail = '๐.๓๘ - ๐.๔๔', TMin = 0.38, TMax = 0.44, Translation = N'ดีมาก' Where TcriteriaID = 'de5b6ed8-a080-468d-8cca-a302d0f5e73b'
			Update TCriteria Set Detail = '๐.๔๕ - ๐.๕๐', TMin = 0.45, TMax = 0.50, DelFlag = 0 Where TcriteriaID = 'db2bedf7-9cf8-4495-a3b8-9ca572bd1f55'

			-----------1.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๔๙', TMin = 0, TMax = 0.49 Where TcriteriaID = '523325f5-5610-4074-8788-eeedf6b35e6c'
			Update TCriteria Set Detail = '๐.๕๐ - ๐.๕๙', TMin = 0.5, TMax = 0.59 Where TcriteriaID = '9a340d20-7c31-4955-a3c7-7fe5eb0a6be3'
			Update TCriteria Set Detail = '๐.๖๐ - ๐.๗๔', TMin = 0.6, TMax = 0.74 Where TcriteriaID = '6344b6e3-cfa7-4fdd-8b71-34470dd661ab'
			Update TCriteria Set Detail = '๐.๗๕ - ๐.๘๙', TMin = 0.75, TMax = 0.89, Translation = N'ดีมาก' Where TcriteriaID = '98d32855-a9ac-444e-a3f2-558961400149'
			Update TCriteria Set Detail = '๐.๙๐ - ๑.๐๐', TMin = 0.9, TMax = 1, DelFlag = 0 Where TcriteriaID = '138fb5bd-2a19-4a09-855e-43205d18ca7b'

			-----------1.0 (2)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๒๐', TMin = 0, TMax = 0.2 Where TcriteriaID = '223EFC01-5C93-46CD-B3F5-8EA36DCF8FDC'
			Update TCriteria Set Detail = '๐.๒๑ - ๐.๔๐', TMin = 0.21, TMax = 0.4 Where TcriteriaID = '36365A43-EBA9-478F-B337-98F3C0D12ACF'
			Update TCriteria Set Detail = '๐.๔๑ - ๐.๖๐', TMin = 0.41, TMax = 0.6 Where TcriteriaID = '0633B326-32A3-4018-A6E4-071CCA336DF9'
			Update TCriteria Set Detail = '๐.๖๑ - ๐.๘๐', TMin = 0.61, TMax = 0.8 Where TcriteriaID = 'A6411A5F-B47D-4578-A7FC-6B4924AC42BB'
			Update TCriteria Set Detail = '๐.๘๑ - ๑.๐๐', TMin = 0.81, TMax = 1 Where TcriteriaID = 'AB835423-2FDA-4348-B3EC-7AB735C3E4CC'

			-----------2.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๙๙', TMin = 0, TMax = 0.99 Where TcriteriaID = '944cee00-2cea-400a-b5dc-081cf16e83a6'
			Update TCriteria Set Detail = '๑.๐๐ - ๑.๑๙', TMin = 1.0, TMax = 1.19 Where TcriteriaID = '6469c8d5-6542-471e-a31a-9c1b1681110b'
			Update TCriteria Set Detail = '๑.๒๐ - ๑.๔๙', TMin = 1.2, TMax = 1.49 Where TcriteriaID = 'fb08528d-fb28-4382-931d-cbbf28cf6b14'
			Update TCriteria Set Detail = '๑.๕๐ - ๑.๗๙', TMin = 1.5, TMax = 1.79, Translation = N'ดีมาก' Where TcriteriaID = '970f9571-a05c-4a6e-9270-e3b8b6346832'
			Update TCriteria Set Detail = '๑.๘๐ - ๒.๐๐', TMin = 1.8, TMax = 2, DelFlag = 0 Where TcriteriaID = 'e1923d69-300a-49e8-b2dd-558a1c9778a0'

			-----------2.0 (2)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๔๐', TMin = 0, TMax = 0.4 Where TcriteriaID = '22656210-A80D-4BA6-88D7-0D18235CAE6B'
			Update TCriteria Set Detail = '๐.๔๑ - ๐.๘๐', TMin = 0.41, TMax = 0.8 Where TcriteriaID = 'A6680FCD-11E8-46B3-A447-F9ACBAC8A627'
			Update TCriteria Set Detail = '๐.๘๑ - ๑.๒๐', TMin = 0.81, TMax = 1.2 Where TcriteriaID = '76CCC37D-CA07-458F-83DC-C32FA1E8D1D6'
			Update TCriteria Set Detail = '๑.๒๑ - ๑.๖๐', TMin = 1.21, TMax = 1.6 Where TcriteriaID = '943675D4-E2CD-4EEA-8AB0-BA5D743A90C9'
			Update TCriteria Set Detail = '๑.๖๑ - ๒.๐๐', TMin = 1.61, TMax = 2 Where TcriteriaID = 'B72385BA-FAC6-4EC9-AC62-F3594CCB5753'

			-----------3.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๖๐', TMin = 0, TMax = 0.6 Where TcriteriaID = 'e68d09a7-053d-4812-a5e2-5019600fc59a'
			Update TCriteria Set Detail = '๐.๖๑ - ๑.๒๐', TMin = 0.61, TMax = 1.20 Where TcriteriaID = 'c40a7ddb-5bf7-45f1-8339-bf23765d686d'
			Update TCriteria Set Detail = '๑.๒๑ - ๑.๘๐', TMin = 1.21, TMax = 1.8 Where TcriteriaID = 'a1c46154-02c8-47da-9c07-26d2fdd36eee'
			Update TCriteria Set Detail = '๑.๘๑ - ๒.๔๐', TMin = 1.81, TMax = 2.4, Translation = N'ดีมาก' Where TcriteriaID = '948736f6-16c6-4e50-96dd-f038ff34ff83'
			Update TCriteria Set Detail = '๒.๔๑ - ๓.๐๐', TMin = 2.41, TMax = 3, DelFlag = 0 Where TcriteriaID = '8b7b8f2e-cad2-4b76-b18b-d0066192b40a'

			-----------4.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๘๐', TMin = 0, TMax = 0.8 Where TcriteriaID = 'cfe6e7f9-d797-45d3-97bf-384a7ea2288d'
			Update TCriteria Set Detail = '๐.๘๑ - ๑.๖๐', TMin = 0.81, TMax = 1.6 Where TcriteriaID = '8c907257-17c1-45ed-a605-34721f5d1c5e'
			Update TCriteria Set Detail = '๑.๖๑ - ๒.๔๐', TMin = 1.61, TMax = 2.4 Where TcriteriaID = '5319e303-bff3-4ae9-9b2d-5138a43aa3bd'
			Update TCriteria Set Detail = '๒.๔๑ - ๓.๒๐', TMin = 2.41, TMax = 3.2, Translation = N'ดีมาก' Where TcriteriaID = '05a882f1-b133-4131-ad72-43cbc4d932cb'
			Update TCriteria Set Detail = '๓.๒๑ - ๔.๐๐', TMin = 3.21, TMax = 4, DelFlag = 0 Where TcriteriaID = 'fee73c78-23c3-4590-9fe4-08c98f72d1cd'

			-----------5.0
			Update TCriteria Set Detail = '๐.๐๐ - ๒.๔๙', TMin = 0, TMax = 2.49 Where TcriteriaID = 'a810252f-9bb6-48a7-b610-dc7a86996451'
			Update TCriteria Set Detail = '๒.๕๐ - ๒.๙๙', TMin = 2.5, TMax = 2.99 Where TcriteriaID = 'ecb48ab5-37ad-4ad0-b8ff-0fffefa8a3b3'
			Update TCriteria Set Detail = '๓.๐๐ - ๓.๗๔', TMin = 3, TMax = 3.74 Where TcriteriaID = 'af07711a-3896-4e93-9794-4c27b670acbf'
			Update TCriteria Set Detail = '๓.๗๕ - ๔.๔๙', TMin = 3.75, TMax = 4.49, Translation = N'ดีมาก' Where TcriteriaID = 'f4a8dcb9-7687-4f2c-9741-f2f8f1da694b'
			Update TCriteria Set Detail = '๔.๕๐ - ๕.๐๐', TMin = 4.5, TMax = 5, DelFlag = 0 Where TcriteriaID = 'aeb0b92f-8949-47d0-99cd-af3980734f21'

			-----------5.0 (2)
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๐๐', TMin = 0, TMax = 1 Where TcriteriaID = '9A480D12-7160-4E72-B8AE-C9E9A663EBD4'
			Update TCriteria Set Detail = '๑.๐๑ - ๒.๐๐', TMin = 1.01, TMax = 2 Where TcriteriaID = 'E855AD6C-F412-4796-8C22-CF0587501079'
			Update TCriteria Set Detail = '๒.๐๑ - ๓.๐๐', TMin = 2.01, TMax = 3 Where TcriteriaID = '6163F6D7-70E3-4CAD-9DA6-77B7C9ABB5D5'
			Update TCriteria Set Detail = '๓.๐๑ - ๔.๐๐', TMin = 3.01, TMax = 4 Where TcriteriaID = '98C64437-9C98-44C8-A25F-880D62937C97'
			Update TCriteria Set Detail = '๔.๐๑ - ๕.๐๐', TMin = 4.01, TMax = 5 Where TcriteriaID = '5062F4F5-AE1E-4570-918A-A78C1F21E10E'

			-----------10.0
			Update TCriteria Set Detail = '๐.๐๐ - ๔.๙๙', TMin = 0, TMax = 4.99 Where TcriteriaID = 'c2c6d92d-e887-4bf0-885c-ca8bee4e807f'
			Update TCriteria Set Detail = '๕.๐๐ - ๕.๙๙', TMin = 5, TMax = 5.99 Where TcriteriaID = 'e0424d8a-e013-4482-895b-f0e8f4c52b12'
			Update TCriteria Set Detail = '๖.๐๐ - ๗.๔๙', TMin = 6, TMax = 7.49 Where TcriteriaID = 'b3f28c05-5d4d-43fb-9284-a84117a4c566'
			Update TCriteria Set Detail = '๗.๕๐ - ๘.๙๙', TMin = 7.5, TMax = 8.99, Translation = N'ดีมาก' Where TcriteriaID = '5f4e7061-4705-42b4-be20-01f144f08d5e'
			Update TCriteria Set Detail = '๙.๐๐ - ๑๐.๐๐', TMin = 9, TMax = 10, DelFlag = 0 Where TcriteriaID = '16b3f3e2-b8a1-481e-9661-5177aad558d3'

			-----------20.0
			Update TCriteria Set Detail = '๐.๐๐ - ๙.๙๙', TMin = 0, TMax = 9.99 Where TcriteriaID = '68927e0c-0400-4d0a-aec9-5bbebdedc891'
			Update TCriteria Set Detail = '๑๐.๐๐ - ๑๑.๙๙', TMin = 10, TMax = 11.99 Where TcriteriaID = '8f1c8c9b-b0bf-43e3-98df-4e75dcf3a098'
			Update TCriteria Set Detail = '๑๒.๐๐ - ๑๔.๙๙', TMin = 12, TMax = 14.99 Where TcriteriaID = '5e989d3b-1f19-437e-aab3-db1af0d6953f'
			Update TCriteria Set Detail = '๑๕.๐๐ - ๑๗.๙๙', TMin = 15, TMax = 17.99, Translation = N'ดีมาก' Where TcriteriaID = '2c3771cc-ef05-4448-be15-a51215e11e89'
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๐.๐๐', TMin = 18, TMax = 20, DelFlag = 0 Where TcriteriaID = 'e49d9c94-22f6-4c8a-9a5c-32fcdbe149a3'

			-----------30.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑๔.๙๙', TMin = 0, TMax = 14.99 Where TcriteriaID = 'b930e376-717b-4f50-bc69-803f88ff6402'
			Update TCriteria Set Detail = '๑๕.๐๐ - ๑๗.๙๙', TMin = 15, TMax = 17.99 Where TcriteriaID = '90983ed4-0799-4ca1-8145-a3b007a53a69'
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๒.๔๙', TMin = 18, TMax = 22.49 Where TcriteriaID = 'f497f305-8316-4d54-bcc8-2da0dc4fd9be'
			Update TCriteria Set Detail = '๒๒.๕๐ - ๒๖.๙๙', TMin = 22.5, TMax = 26.99, Translation = N'ดีมาก' Where TcriteriaID = '6c3191d9-13ab-4bfb-bddb-dc50623b4c3a'
			Update TCriteria Set Detail = '๒๗.๐๐ - ๓๐.๐๐', TMin = 27, TMax = 30, DelFlag = 0 Where TcriteriaID = 'f7818b1f-6b6b-46fc-9611-169c481e2c4d'

			-----------50.0
			Update TCriteria Set Detail = '๐.๐๐ - ๒๔.๙๙', TMin = 0, TMax = 24.99 Where TcriteriaID = '0e4d3521-401d-408f-8f2f-d69a509a2117'
			Update TCriteria Set Detail = '๒๕.๐๐ - ๒๙.๙๙', TMin = 25, TMax = 29.99 Where TcriteriaID = '32d76bf4-7e87-4575-910c-92761b2da74d'
			Update TCriteria Set Detail = '๓๐.๐๐ - ๓๗.๔๙', TMin = 30, TMax = 37.49 Where TcriteriaID = '7722765c-3e54-42a4-b209-5cafe57cc7b2'
			Update TCriteria Set Detail = '๓๗.๕๐ - ๔๔.๙๙', TMin = 37.5, TMax = 44.99, Translation = N'ดีมาก' Where TcriteriaID = 'bcc684de-202a-44ae-948e-d7dbb78f572e'
			Update TCriteria Set Detail = '๔๕.๐๐ - ๕๐.๐๐', TMin = 45, TMax = 50, DelFlag = 0 Where TcriteriaID = '48c0564e-b8d8-4963-8ab1-4910057944a6'

			-----------100.0
			Update TCriteria Set Detail = '๐.๐๐ - ๔๙.๙๙', TMin = 0, TMax = 49.99 Where TcriteriaID = '69c5bc62-b443-48c5-9a46-cd1e4df27003'
			Update TCriteria Set Detail = '๕๐.๐๐ - ๕๙.๙๙', TMin = 50, TMax = 59.99 Where TcriteriaID = '59291c4d-2eec-4ea2-8a2d-922b6a34fa4c'
			Update TCriteria Set Detail = '๖๐.๐๐ - ๗๔.๙๙', TMin = 60, TMax = 74.99 Where TcriteriaID = 'e277de33-3d86-4f09-b7b8-f3c97d585cb5'
			Update TCriteria Set Detail = '๗๕.๐๐ - ๘๙.๙๙', TMin = 75, TMax = 89.99, Translation = N'ดีมาก' Where TcriteriaID = 'facf0afb-b6f4-4675-9c47-774eb1d1b8af'
			Update TCriteria Set Detail = '๙๐.๐๐ - ๑๐๐.๐๐', TMin = 90, TMax = 100, DelFlag = 0 Where TcriteriaID = '6ecc7610-19d8-47cc-b728-15efd128fe21'
		End

		IF @RateType = 2
		Begin
			--------เกณฑ์ใหม่ 12 มาตรฐาน (2)-------------
			---------0.5 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๑๕', TMin = 0, TMax = 0.15 Where TcriteriaID = '990f80da-c07c-41b5-ac1f-5e8a45e5bb0e'
			Update TCriteria Set Detail = '๐.๑๖ - ๐.๓๐', TMin = 0.16, TMax = 0.30 Where TcriteriaID = '50a812bd-f27e-4259-8946-004c1044fabf'
			Update TCriteria Set Detail = '๐.๓๑ - ๐.๔๐', TMin = 0.31, TMax = 0.40 Where TcriteriaID = '573fcdb2-0f1d-42d4-95a9-2ce3b2dd5fd4'
			Update TCriteria Set Detail = '๐.๔๑ - ๐.๔๕', TMin = 0.41, TMax = 0.45, Translation = N'ดีมาก' Where TcriteriaID = 'de5b6ed8-a080-468d-8cca-a302d0f5e73b'
			Update TCriteria Set Detail = '๐.๔๖ - ๐.๕๐', TMin = 0.46, TMax = 0.50, DelFlag = 0 Where TcriteriaID = 'db2bedf7-9cf8-4495-a3b8-9ca572bd1f55'

			-----------1.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๕๙', TMin = 0, TMax = 0.59 Where TcriteriaID = '523325f5-5610-4074-8788-eeedf6b35e6c'
			Update TCriteria Set Detail = '๐.๖๐ - ๐.๗๔', TMin = 0.6, TMax = 0.74 Where TcriteriaID = '9a340d20-7c31-4955-a3c7-7fe5eb0a6be3'
			Update TCriteria Set Detail = '๐.๗๕ - ๐.๘๙', TMin = 0.75, TMax = 0.89 Where TcriteriaID = '6344b6e3-cfa7-4fdd-8b71-34470dd661ab'
			Update TCriteria Set Detail = '๐.๙๐ - ๐.๙๔', TMin = 0.9, TMax = 0.94, Translation = N'ดีมาก' Where TcriteriaID = '98d32855-a9ac-444e-a3f2-558961400149'
			Update TCriteria Set Detail = '๐.๙๕ - ๑.๐๐', TMin = 0.95, TMax = 1, DelFlag = 0 Where TcriteriaID = '138fb5bd-2a19-4a09-855e-43205d18ca7b'

			-----------1.0 (N2)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๓๐', TMin = 0, TMax = 0.3 Where TcriteriaID = '223EFC01-5C93-46CD-B3F5-8EA36DCF8FDC'
			Update TCriteria Set Detail = '๐.๓๑ - ๐.๖๐', TMin = 0.31, TMax = 0.6 Where TcriteriaID = '36365A43-EBA9-478F-B337-98F3C0D12ACF'
			Update TCriteria Set Detail = '๐.๖๑ - ๐.๘๐', TMin = 0.61, TMax = 0.8 Where TcriteriaID = '0633B326-32A3-4018-A6E4-071CCA336DF9'
			Update TCriteria Set Detail = '๐.๘๑ - ๐.๙๐', TMin = 0.81, TMax = 0.9 Where TcriteriaID = 'A6411A5F-B47D-4578-A7FC-6B4924AC42BB'
			Update TCriteria Set Detail = '๐.๙๑ - ๑.๐๐', TMin = 0.91, TMax = 1 Where TcriteriaID = 'AB835423-2FDA-4348-B3EC-7AB735C3E4CC'

			-----------2.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๑๙', TMin = 0, TMax = 1.19 Where TcriteriaID = '944cee00-2cea-400a-b5dc-081cf16e83a6'
			Update TCriteria Set Detail = '๑.๒๐ - ๑.๔๙', TMin = 1.2, TMax = 1.49 Where TcriteriaID = '6469c8d5-6542-471e-a31a-9c1b1681110b'
			Update TCriteria Set Detail = '๑.๕๐ - ๑.๗๙', TMin = 1.5, TMax = 1.79 Where TcriteriaID = 'fb08528d-fb28-4382-931d-cbbf28cf6b14'
			Update TCriteria Set Detail = '๑.๘๐ - ๑.๘๙', TMin = 1.8, TMax = 1.89, Translation = N'ดีมาก' Where TcriteriaID = '970f9571-a05c-4a6e-9270-e3b8b6346832'
			Update TCriteria Set Detail = '๑.๙๐ - ๒.๐๐', TMin = 1.9, TMax = 2, DelFlag = 0 Where TcriteriaID = 'e1923d69-300a-49e8-b2dd-558a1c9778a0'

			-----------2.0 (N2)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๖๐', TMin = 0, TMax = 0.6 Where TcriteriaID = '22656210-A80D-4BA6-88D7-0D18235CAE6B'
			Update TCriteria Set Detail = '๐.๖๑ - ๑.๒๐', TMin = 0.61, TMax = 1.2 Where TcriteriaID = 'A6680FCD-11E8-46B3-A447-F9ACBAC8A627'
			Update TCriteria Set Detail = '๐.๒๑ - ๑.๖๐', TMin = 1.21, TMax = 1.6 Where TcriteriaID = '76CCC37D-CA07-458F-83DC-C32FA1E8D1D6'
			Update TCriteria Set Detail = '๑.๖๑ - ๑.๘๐', TMin = 1.61, TMax = 1.8 Where TcriteriaID = '943675D4-E2CD-4EEA-8AB0-BA5D743A90C9'
			Update TCriteria Set Detail = '๑.๘๑ - ๒.๐๐', TMin = 1.81, TMax = 2 Where TcriteriaID = 'B72385BA-FAC6-4EC9-AC62-F3594CCB5753'

			-----------3.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๙๐', TMin = 0, TMax = 0.9 Where TcriteriaID = 'e68d09a7-053d-4812-a5e2-5019600fc59a'
			Update TCriteria Set Detail = '๐.๙๑ - ๑.๘๐', TMin = 0.91, TMax = 1.8 Where TcriteriaID = 'c40a7ddb-5bf7-45f1-8339-bf23765d686d'
			Update TCriteria Set Detail = '๑.๘๑ - ๒.๔๐', TMin = 1.81, TMax = 2.4 Where TcriteriaID = 'a1c46154-02c8-47da-9c07-26d2fdd36eee'
			Update TCriteria Set Detail = '๑.๔๑ - ๒.๗๐', TMin = 2.41, TMax = 2.7, Translation = N'ดีมาก' Where TcriteriaID = '948736f6-16c6-4e50-96dd-f038ff34ff83'
			Update TCriteria Set Detail = '๒.๗๑ - ๓.๐๐', TMin = 2.71, TMax = 3, DelFlag = 0 Where TcriteriaID = '8b7b8f2e-cad2-4b76-b18b-d0066192b40a'

			-----------4.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๒.๓๙', TMin = 0, TMax = 2.39 Where TcriteriaID = 'cfe6e7f9-d797-45d3-97bf-384a7ea2288d'
			Update TCriteria Set Detail = '๒.๔๐ - ๒.๙๙', TMin = 2.4, TMax = 2.99 Where TcriteriaID = '8c907257-17c1-45ed-a605-34721f5d1c5e'
			Update TCriteria Set Detail = '๓.๐๐ - ๓.๕๙', TMin = 3, TMax = 3.59 Where TcriteriaID = '5319e303-bff3-4ae9-9b2d-5138a43aa3bd'
			Update TCriteria Set Detail = '๓.๖๐ - ๓.๗๙', TMin = 3.6, TMax = 3.79, Translation = N'ดีมาก' Where TcriteriaID = '05a882f1-b133-4131-ad72-43cbc4d932cb'
			Update TCriteria Set Detail = '๓.๘๐ - ๔.๐๐', TMin = 3.8, TMax = 4, DelFlag = 0 Where TcriteriaID = 'fee73c78-23c3-4590-9fe4-08c98f72d1cd'

			-----------5.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๒.๐๐', TMin = 0, TMax = 2 Where TcriteriaID = 'a810252f-9bb6-48a7-b610-dc7a86996451'
			Update TCriteria Set Detail = '๒.๐๑ - ๓.๐๐', TMin = 2.01, TMax = 3 Where TcriteriaID = 'ecb48ab5-37ad-4ad0-b8ff-0fffefa8a3b3'
			Update TCriteria Set Detail = '๓.๐๑ - ๔.๐๐', TMin = 3.01, TMax = 4 Where TcriteriaID = 'af07711a-3896-4e93-9794-4c27b670acbf'
			Update TCriteria Set Detail = '๔.๐๑ - ๔.๕๐', TMin = 4.01, TMax = 4.5, Translation = N'ดีมาก' Where TcriteriaID = 'f4a8dcb9-7687-4f2c-9741-f2f8f1da694b'
			Update TCriteria Set Detail = '๔.๕๑ - ๕.๐๐', TMin = 4.51, TMax = 5, DelFlag = 0 Where TcriteriaID = 'aeb0b92f-8949-47d0-99cd-af3980734f21'

			-----------5.0 (N2)
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๐๐', TMin = 0, TMax = 1 Where TcriteriaID = '9A480D12-7160-4E72-B8AE-C9E9A663EBD4'
			Update TCriteria Set Detail = '๑.๐๑ - ๒.๐๐', TMin = 1.01, TMax = 2 Where TcriteriaID = 'E855AD6C-F412-4796-8C22-CF0587501079'
			Update TCriteria Set Detail = '๒.๐๑ - ๓.๐๐', TMin = 2.01, TMax = 3 Where TcriteriaID = '6163F6D7-70E3-4CAD-9DA6-77B7C9ABB5D5'
			Update TCriteria Set Detail = '๓.๐๑ - ๔.๐๐', TMin = 3.01, TMax = 4 Where TcriteriaID = '98C64437-9C98-44C8-A25F-880D62937C97'
			Update TCriteria Set Detail = '๔.๐๑ - ๕.๐๐', TMin = 4.01, TMax = 5 Where TcriteriaID = '5062F4F5-AE1E-4570-918A-A78C1F21E10E'

			-----------10.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๕.๙๙', TMin = 0, TMax = 5.99 Where TcriteriaID = 'c2c6d92d-e887-4bf0-885c-ca8bee4e807f'
			Update TCriteria Set Detail = '๖.๐๐ - ๗.๔๙', TMin = 6, TMax = 7.49 Where TcriteriaID = 'e0424d8a-e013-4482-895b-f0e8f4c52b12'
			Update TCriteria Set Detail = '๗.๕๐ - ๘.๙๙', TMin = 7.5, TMax = 8.99 Where TcriteriaID = 'b3f28c05-5d4d-43fb-9284-a84117a4c566'
			Update TCriteria Set Detail = '๙.๐๐ - ๙.๔๙', TMin = 9, TMax = 9.49, Translation = N'ดีมาก' Where TcriteriaID = '5f4e7061-4705-42b4-be20-01f144f08d5e'
			Update TCriteria Set Detail = '๙.๕๐ - ๑๐.๐๐', TMin = 9.5, TMax = 10, DelFlag = 0 Where TcriteriaID = '16b3f3e2-b8a1-481e-9661-5177aad558d3'

			-----------20.0
			Update TCriteria Set Detail = '๐.๐๐ - ๙.๙๙', TMin = 0, TMax = 9.99 Where TcriteriaID = '68927e0c-0400-4d0a-aec9-5bbebdedc891'
			Update TCriteria Set Detail = '๑๐.๐๐ - ๑๑.๙๙', TMin = 10, TMax = 11.99 Where TcriteriaID = '8f1c8c9b-b0bf-43e3-98df-4e75dcf3a098'
			Update TCriteria Set Detail = '๑๒.๐๐ - ๑๔.๙๙', TMin = 12, TMax = 14.99 Where TcriteriaID = '5e989d3b-1f19-437e-aab3-db1af0d6953f'
			Update TCriteria Set Detail = '๑๕.๐๐ - ๑๗.๙๙', TMin = 15, TMax = 17.99, Translation = N'ดีมาก' Where TcriteriaID = '2c3771cc-ef05-4448-be15-a51215e11e89'
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๐.๐๐', TMin = 18, TMax = 20, DelFlag = 0 Where TcriteriaID = 'e49d9c94-22f6-4c8a-9a5c-32fcdbe149a3'

			-----------50.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๒๙.๙๙', TMin = 0, TMax = 29.99 Where TcriteriaID = '0e4d3521-401d-408f-8f2f-d69a509a2117'
			Update TCriteria Set Detail = '๓๐.๐๐ - ๓๗.๔๙', TMin = 30, TMax = 37.49 Where TcriteriaID = '32d76bf4-7e87-4575-910c-92761b2da74d'
			Update TCriteria Set Detail = '๓๗.๕๐ - ๔๔.๙๙', TMin = 37.5, TMax = 44.99 Where TcriteriaID = '7722765c-3e54-42a4-b209-5cafe57cc7b2'
			Update TCriteria Set Detail = '๔๕.๐๐ - ๔๗.๔๙', TMin = 45, TMax = 47.49, Translation = N'ดีมาก' Where TcriteriaID = 'bcc684de-202a-44ae-948e-d7dbb78f572e'
			Update TCriteria Set Detail = '๔๗.๕๐ - ๕๐.๐๐', TMin = 47.5, TMax = 50, DelFlag = 0 Where TcriteriaID = '48c0564e-b8d8-4963-8ab1-4910057944a6'

			-----------100.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๕๙.๙๙', TMin = 0, TMax = 59.99 Where TcriteriaID = '69c5bc62-b443-48c5-9a46-cd1e4df27003'
			Update TCriteria Set Detail = '๖๐.๐๐ - ๗๔.๙๙', TMin = 60, TMax = 74.99 Where TcriteriaID = '59291c4d-2eec-4ea2-8a2d-922b6a34fa4c'
			Update TCriteria Set Detail = '๗๕.๐๐ - ๘๙.๙๙', TMin = 75, TMax = 89.99 Where TcriteriaID = 'e277de33-3d86-4f09-b7b8-f3c97d585cb5'
			Update TCriteria Set Detail = '๙๐.๐๐ - ๙๔.๙๙', TMin = 90, TMax = 94.99, Translation = N'ดีมาก' Where TcriteriaID = 'facf0afb-b6f4-4675-9c47-774eb1d1b8af'
			Update TCriteria Set Detail = '๙๕.๐๐ - ๑๐๐.๐๐', TMin = 95, TMax = 100, DelFlag = 0 Where TcriteriaID = '6ecc7610-19d8-47cc-b728-15efd128fe21'
		End

		IF @RateType = 3
		Begin
			----------------แบบใหม่ 4 มาตรฐาน---------------------
			-----------0.5
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๒๔', TMin = 0, TMax = 0.24 Where TcriteriaID = '990f80da-c07c-41b5-ac1f-5e8a45e5bb0e'
			Update TCriteria Set Detail = '๐.๒๕ - ๐.๒๙', TMin = 0.25, TMax = 0.29 Where TcriteriaID = '50a812bd-f27e-4259-8946-004c1044fabf'
			Update TCriteria Set Detail = '๐.๓๐ - ๐.๓๔', TMin = 0.3, TMax = 0.34 Where TcriteriaID = '573fcdb2-0f1d-42d4-95a9-2ce3b2dd5fd4'
			Update TCriteria Set Detail = '๐.๓๕ - ๐.๕๐', TMin = 0.35, TMax = 0.5, Translation = N'ดีเยี่ยม' Where TcriteriaID = 'de5b6ed8-a080-468d-8cca-a302d0f5e73b'
			Update TCriteria Set Detail = '๐.๔๐ - ๐.๕๐', TMin = 0.4, TMax = 0.5, DelFlag = 1 Where TcriteriaID = 'db2bedf7-9cf8-4495-a3b8-9ca572bd1f55'

			-----------1.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๔๙', TMin = 0, TMax = 0.49 Where TcriteriaID = '523325f5-5610-4074-8788-eeedf6b35e6c'
			Update TCriteria Set Detail = '๐.๕๐ - ๐.๕๙', TMin = 0.5, TMax = 0.59 Where TcriteriaID = '9a340d20-7c31-4955-a3c7-7fe5eb0a6be3'
			Update TCriteria Set Detail = '๐.๖๐ - ๐.๖๙', TMin = 0.6, TMax = 0.69 Where TcriteriaID = '6344b6e3-cfa7-4fdd-8b71-34470dd661ab'
			Update TCriteria Set Detail = '๐.๗๐ - ๐.๗๙', TMin = 0.7, TMax = 1, Translation = N'ดีเยี่ยม' Where TcriteriaID = '98d32855-a9ac-444e-a3f2-558961400149'
			Update TCriteria Set Detail = '๐.๘๐ - ๑.๐๐', TMin = 0.8, TMax = 1, DelFlag = 1 Where TcriteriaID = '138fb5bd-2a19-4a09-855e-43205d18ca7b'

			-----------2.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๙๙', TMin = 0, TMax = 0.99 Where TcriteriaID = '944cee00-2cea-400a-b5dc-081cf16e83a6'
			Update TCriteria Set Detail = '๑.๐๐ - ๑.๑๙', TMin = 1.0, TMax = 1.19 Where TcriteriaID = '6469c8d5-6542-471e-a31a-9c1b1681110b'
			Update TCriteria Set Detail = '๑.๒๐ - ๑.๓๙', TMin = 1.2, TMax = 1.39 Where TcriteriaID = 'fb08528d-fb28-4382-931d-cbbf28cf6b14'
			Update TCriteria Set Detail = '๑.๔๐ - ๑.๕๙', TMin = 1.4, TMax = 2, Translation = N'ดีเยี่ยม' Where TcriteriaID = '970f9571-a05c-4a6e-9270-e3b8b6346832'
			Update TCriteria Set Detail = '๑.๖๐ - ๒.๐๐', TMin = 1.6, TMax = 2, DelFlag = 1 Where TcriteriaID = 'e1923d69-300a-49e8-b2dd-558a1c9778a0'

			-----------3.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๔๙', TMin = 0, TMax = 1.49 Where TcriteriaID = 'e68d09a7-053d-4812-a5e2-5019600fc59a'
			Update TCriteria Set Detail = '๑.๕๐ - ๑.๗๙', TMin = 1.5, TMax = 1.79 Where TcriteriaID = 'c40a7ddb-5bf7-45f1-8339-bf23765d686d'
			Update TCriteria Set Detail = '๑.๘๐ - ๒.๐๙', TMin = 1.8, TMax = 2.09 Where TcriteriaID = 'a1c46154-02c8-47da-9c07-26d2fdd36eee'
			Update TCriteria Set Detail = '๒.๑๐ - ๒.๓๙', TMin = 2.1, TMax = 3, Translation = N'ดีเยี่ยม' Where TcriteriaID = '948736f6-16c6-4e50-96dd-f038ff34ff83'
			Update TCriteria Set Detail = '๒.๔๐ - ๓.๐๐', TMin = 2.4, TMax = 3, DelFlag = 1 Where TcriteriaID = '8b7b8f2e-cad2-4b76-b18b-d0066192b40a'

			-----------4.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๙๙', TMin = 0, TMax = 1.99 Where TcriteriaID = 'cfe6e7f9-d797-45d3-97bf-384a7ea2288d'
			Update TCriteria Set Detail = '๒.๐๐ - ๒.๓๙', TMin = 2, TMax = 2.39 Where TcriteriaID = '8c907257-17c1-45ed-a605-34721f5d1c5e'
			Update TCriteria Set Detail = '๒.๔๐ - ๒.๗๙', TMin = 2.4, TMax = 2.79 Where TcriteriaID = '5319e303-bff3-4ae9-9b2d-5138a43aa3bd'
			Update TCriteria Set Detail = '๒.๘๐ - ๓.๑๙', TMin = 2.8, TMax = 4, Translation = N'ดีเยี่ยม' Where TcriteriaID = '05a882f1-b133-4131-ad72-43cbc4d932cb'
			Update TCriteria Set Detail = '๓.๒๐ - ๔.๐๐', TMin = 3.2, TMax = 4, DelFlag = 1 Where TcriteriaID = 'fee73c78-23c3-4590-9fe4-08c98f72d1cd'

			-----------5.0
			Update TCriteria Set Detail = '๐.๐๐ - ๒.๔๙', TMin = 0, TMax = 2.49 Where TcriteriaID = 'a810252f-9bb6-48a7-b610-dc7a86996451'
			Update TCriteria Set Detail = '๒.๕๐ - ๒.๙๙', TMin = 2.5, TMax = 2.99 Where TcriteriaID = 'ecb48ab5-37ad-4ad0-b8ff-0fffefa8a3b3'
			Update TCriteria Set Detail = '๓.๐๐ - ๓.๔๙', TMin = 3, TMax = 3.49 Where TcriteriaID = 'af07711a-3896-4e93-9794-4c27b670acbf'
			Update TCriteria Set Detail = '๓.๕๐ - ๓.๙๙', TMin = 3.5, TMax = 5, Translation = N'ดีเยี่ยม' Where TcriteriaID = 'f4a8dcb9-7687-4f2c-9741-f2f8f1da694b'
			Update TCriteria Set Detail = '๔.๐๐ - ๕.๐๐', TMin = 4, TMax = 5, DelFlag = 1 Where TcriteriaID = 'aeb0b92f-8949-47d0-99cd-af3980734f21'

			-----------10.0
			Update TCriteria Set Detail = '๐.๐๐ - ๔.๙๙', TMin = 0, TMax = 4.99 Where TcriteriaID = 'c2c6d92d-e887-4bf0-885c-ca8bee4e807f'
			Update TCriteria Set Detail = '๕.๐๐ - ๕.๙๙', TMin = 5, TMax = 5.99 Where TcriteriaID = 'e0424d8a-e013-4482-895b-f0e8f4c52b12'
			Update TCriteria Set Detail = '๖.๐๐ - ๖.๙๙', TMin = 6, TMax = 6.99 Where TcriteriaID = 'b3f28c05-5d4d-43fb-9284-a84117a4c566'
			Update TCriteria Set Detail = '๗.๐๐ - ๗.๙๙', TMin = 7, TMax = 10, Translation = N'ดีเยี่ยม' Where TcriteriaID = '5f4e7061-4705-42b4-be20-01f144f08d5e'
			Update TCriteria Set Detail = '๘.๐๐ - ๑๐.๐๐', TMin = 8, TMax = 10, DelFlag = 1 Where TcriteriaID = '16b3f3e2-b8a1-481e-9661-5177aad558d3'

			-----------20.0
			Update TCriteria Set Detail = '๐.๐๐ - ๙.๙๙', TMin = 0, TMax = 9.99 Where TcriteriaID = '68927e0c-0400-4d0a-aec9-5bbebdedc891'
			Update TCriteria Set Detail = '๑๐.๐๐ - ๑๑.๙๙', TMin = 10, TMax = 11.99 Where TcriteriaID = '8f1c8c9b-b0bf-43e3-98df-4e75dcf3a098'
			Update TCriteria Set Detail = '๑๒.๐๐ - ๑๔.๙๙', TMin = 12, TMax = 14.99 Where TcriteriaID = '5e989d3b-1f19-437e-aab3-db1af0d6953f'
			Update TCriteria Set Detail = '๑๕.๐๐ - ๑๗.๙๙', TMin = 15, TMax = 20, Translation = N'ดีเยี่ยม' Where TcriteriaID = '2c3771cc-ef05-4448-be15-a51215e11e89'
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๐.๐๐', TMin = 18, TMax = 20, DelFlag = 1 Where TcriteriaID = 'e49d9c94-22f6-4c8a-9a5c-32fcdbe149a3'

			-----------30.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑๔.๙๙', TMin = 0, TMax = 14.99 Where TcriteriaID = 'b930e376-717b-4f50-bc69-803f88ff6402'
			Update TCriteria Set Detail = '๑๕.๐๐ - ๑๗.๙๙', TMin = 15, TMax = 17.99 Where TcriteriaID = '90983ed4-0799-4ca1-8145-a3b007a53a69'
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๐.๙๙', TMin = 18, TMax = 20.99 Where TcriteriaID = 'f497f305-8316-4d54-bcc8-2da0dc4fd9be'
			Update TCriteria Set Detail = '๒๑.๐๐ - ๒๓.๙๙', TMin = 21, TMax = 30, Translation = N'ดีเยี่ยม' Where TcriteriaID = '6c3191d9-13ab-4bfb-bddb-dc50623b4c3a'
			Update TCriteria Set Detail = '๒๔.๐๐ - ๓๐.๐๐', TMin = 24, TMax = 30, DelFlag = 1 Where TcriteriaID = 'f7818b1f-6b6b-46fc-9611-169c481e2c4d'

			-----------50.0
			Update TCriteria Set Detail = '๐.๐๐ - ๒๔.๙๙', TMin = 0, TMax = 24.99 Where TcriteriaID = '0e4d3521-401d-408f-8f2f-d69a509a2117'
			Update TCriteria Set Detail = '๒๕.๐๐ - ๒๙.๙๙', TMin = 25, TMax = 29.99 Where TcriteriaID = '32d76bf4-7e87-4575-910c-92761b2da74d'
			Update TCriteria Set Detail = '๓๐.๐๐ - ๓๔.๙๙', TMin = 30, TMax = 34.99 Where TcriteriaID = '7722765c-3e54-42a4-b209-5cafe57cc7b2'
			Update TCriteria Set Detail = '๓๕.๐๐ - ๓๙.๙๙', TMin = 35, TMax = 50, Translation = N'ดีเยี่ยม' Where TcriteriaID = 'bcc684de-202a-44ae-948e-d7dbb78f572e'
			Update TCriteria Set Detail = '๔๐.๐๐ - ๕๐.๐๐', TMin = 40, TMax = 50, DelFlag = 1 Where TcriteriaID = '48c0564e-b8d8-4963-8ab1-4910057944a6'

			-----------100.0
			Update TCriteria Set Detail = '๐.๐๐ - ๔๙.๙๙', TMin = 0, TMax = 49.99 Where TcriteriaID = '69c5bc62-b443-48c5-9a46-cd1e4df27003'
			Update TCriteria Set Detail = '๕๐.๐๐ - ๕๙.๙๙', TMin = 50, TMax = 59.99 Where TcriteriaID = '59291c4d-2eec-4ea2-8a2d-922b6a34fa4c'
			Update TCriteria Set Detail = '๖๐.๐๐ - ๖๙.๙๙', TMin = 60, TMax = 69.99 Where TcriteriaID = 'e277de33-3d86-4f09-b7b8-f3c97d585cb5'
			Update TCriteria Set Detail = '๗๐.๐๐ - ๗๙.๙๙', TMin = 70, TMax = 100, Translation = N'ดีเยี่ยม' Where TcriteriaID = 'facf0afb-b6f4-4675-9c47-774eb1d1b8af'
			Update TCriteria Set Detail = '๘๐.๐๐ - ๑๐๐.๐๐', TMin = 80, TMax = 100, DelFlag = 1 Where TcriteriaID = '6ecc7610-19d8-47cc-b728-15efd128fe21'
		End
	END

	GO
/****** Object:  StoredProcedure [dbo].[GenScoreGroupSideAndStandard]    Script Date: 3/7/2560 15:46:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	ALTER PROCEDURE [dbo].[GenScoreGroupSideAndStandard]
		@RateType int,
		@StudyYear int
	AS
	BEGIN
		SET NOCOUNT ON;
		IF @RateType = 2  
		Begin
			-- เกณฑ์ใหม่ปี 59 12 มาตรฐาน
			---/////////// ด้านที่ 1 ////////////  50
			Update Side Set ScoreGroupID = '5D9C042C-A0AC-42DC-9DC6-20C4B601D127' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 1 

			---/////////// ด้านที่ 2 ////////////  15
			Update Side Set ScoreGroupID = 'D7A04A29-300F-4E0F-B100-8026FF7D66D6' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 2

			---/////////// ด้านที่ 3 ////////////  25
			Update Side Set ScoreGroupID = 'C40FC9F0-2645-4651-9FEC-D3AC1C345F96' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 3

			---/////////// ด้านที่ 4 ////////////  5
			Update Side Set ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 4

			---/////////// ด้านที่ 5 ////////////  5
			Update Side Set ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 5


			---/////////// มาตรฐานที่ 1 ////////////  10
			Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 1

			---/////////// มาตรฐานที่ 2 ////////////  10
			Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 2

			---/////////// มาตรฐานที่ 3 ////////////  5
			Update Standard Set ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 3

			---/////////// มาตรฐานที่ 4 ////////////  5
			Update Standard Set ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 4

			---/////////// มาตรฐานที่ 5 ////////////  15
			Update Standard Set ScoreGroupID = 'D7A04A29-300F-4E0F-B100-8026FF7D66D6' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 5

			---/////////// มาตรฐานที่ 6 ////////////  5
			Update Standard Set ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 6

			---/////////// มาตรฐานที่ 7 ////////////  15
			Update Standard Set ScoreGroupID = 'D7A04A29-300F-4E0F-B100-8026FF7D66D6' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 7

			---/////////// มาตรฐานที่ 8 ////////////  10
			Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 8

			---/////////// มาตรฐานที่ 9 ////////////  10
			Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 9

			---/////////// มาตรฐานที่ 10 ////////////  5
			Update Standard Set ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 10

			---/////////// มาตรฐานที่ 11 ////////////  5
			Update Standard Set ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 11

			---/////////// มาตรฐานที่ 12 ////////////  5
			Update Standard Set ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 12

		End
		Else
		Begin
			IF @RateType = 3  
			Begin
				-- เกณฑ์ใหม่ปี 60 4 มาตรฐาน
				---/////////// มาตรฐานที่ 1 ////////////  30
				Update Side Set ScoreGroupID = '950E2A3C-5B5B-4A51-8613-4EC393A1F495' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 1 

				---/////////// มาตรฐานที่ 2 ////////////  30
				Update Side Set ScoreGroupID = '950E2A3C-5B5B-4A51-8613-4EC393A1F495' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 2

				---/////////// มาตรฐานที่ 3 ////////////  20
				Update Side Set ScoreGroupID = '4996ad20-57fc-4dbc-a01d-698393d7affb' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 3

				---/////////// มาตรฐานที่ 4 ////////////  20
				Update Side Set ScoreGroupID = '4996ad20-57fc-4dbc-a01d-698393d7affb' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 4

				---/////////// ประเด็นพิจารณาที่ 1 ////////////  20
				Update Standard Set ScoreGroupID = '4996ad20-57fc-4dbc-a01d-698393d7affb' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 1

				---/////////// ประเด็นพิจารณาที่ 2 ////////////  10
				Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 2

				---/////////// ประเด็นพิจารณาที่ 3 ////////////  5
				Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 3

				---/////////// ประเด็นพิจารณาที่ 4 ////////////  20
				Update Standard Set ScoreGroupID = '4996ad20-57fc-4dbc-a01d-698393d7affb' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 4

				---/////////// ประเด็นพิจารณาที่ 5 ////////////  3
				Update Standard Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 5

				---/////////// ประเด็นพิจารณาที่ 6 ////////////  2
				Update Standard Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 6

				---/////////// ประเด็นพิจารณาที่ 7 ////////////  10
				Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 7

				---/////////// ประเด็นพิจารณาที่ 8 ////////////  5
				Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 8

				---/////////// ประเด็นพิจารณาที่ 9 ////////////  5
				Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 9

				---/////////// ประเด็นพิจารณาที่ 10 ////////////  20
				Update Standard Set ScoreGroupID = '4996ad20-57fc-4dbc-a01d-698393d7affb' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 10

			End
			Else
			Begin
				-- เกณฑ์เดิม 15 มาตรฐาน
				---/////////// ด้านที่ 1 ////////////  30
				Update Side Set ScoreGroupID = '950E2A3C-5B5B-4A51-8613-4EC393A1F495' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 1 

				---/////////// ด้านที่ 2 ////////////  50
				Update Side Set ScoreGroupID = '5D9C042C-A0AC-42DC-9DC6-20C4B601D127' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 2

				---/////////// ด้านที่ 3 ////////////  10
				Update Side Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 3

				---/////////// ด้านที่ 4 ////////////  5
				Update Side Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 4

				---/////////// ด้านที่ 5 ////////////  5
				Update Side Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 5



				---/////////// มาตรฐานที่ 1 ////////////  5
				Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 1

				---/////////// มาตรฐานที่ 2 ////////////  5
				Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 2

				---/////////// มาตรฐานที่ 3 ////////////  5
				Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 3

				---/////////// มาตรฐานที่ 4 ////////////  5
				Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 4

				---/////////// มาตรฐานที่ 5 ////////////  5
				Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 5

				---/////////// มาตรฐานที่ 6 ////////////  5
				Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 6

				---/////////// มาตรฐานที่ 7 ////////////  10
				Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 7

				---/////////// มาตรฐานที่ 8 ////////////  10
				Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 8

				---/////////// มาตรฐานที่ 9 ////////////  5
				Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 9

				---/////////// มาตรฐานที่ 10 ////////////  10
				Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 10

				---/////////// มาตรฐานที่ 11 ////////////  10
				Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 11

				---/////////// มาตรฐานที่ 12 ////////////  5
				Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 12

				---/////////// มาตรฐานที่ 13 ////////////  10
				Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 13

				---/////////// มาตรฐานที่ 14 ////////////  5
				Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 14

				---/////////// มาตรฐานที่ 15 ////////////  5
				Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where StudyYear = @StudyYear And DelFlag = 0 And Sort = 15
			End
		End
	End

	GO
/****** Object:  StoredProcedure [dbo].[GenIndRate]    Script Date: 4/7/2560 11:45:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GenIndRate]
		@RateType int,
		@StudyYear int
	AS
	BEGIN
		SET NOCOUNT ON;
		IF @RateType = 0
		Begin
			------------เกณฑ์เก่า

			---/////////// มาตรฐานที่ 1 ////////////

			---ตัวบ่งชี้ที่  1.1  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 1

			---ตัวบ่งชี้ที่  1.2  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 2

			---ตัวบ่งชี้ที่  1.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 3

			---ตัวบ่งชี้ที่  1.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 4

			---ตัวบ่งชี้ที่  1.5  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 5

			---ตัวบ่งชี้ที่  1.6  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 6


			---/////////// มาตรฐานที่ 2 ////////////

			---ตัวบ่งชี้ที่  2.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 1

			---ตัวบ่งชี้ที่  2.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 2

			---ตัวบ่งชี้ที่  2.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 3

			---ตัวบ่งชี้ที่  2.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 4


			---/////////// มาตรฐานที่ 3 ////////////

			---ตัวบ่งชี้ที่  3.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 1

			---ตัวบ่งชี้ที่  3.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 2

			---ตัวบ่งชี้ที่  3.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 3

			---ตัวบ่งชี้ที่  3.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 4


			---/////////// มาตรฐานที่ 4 ////////////

			---ตัวบ่งชี้ที่  4.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 1

			---ตัวบ่งชี้ที่  4.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 2

			---ตัวบ่งชี้ที่  4.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 3

			---ตัวบ่งชี้ที่  4.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 4


			---/////////// มาตรฐานที่ 5 ////////////

			---ตัวบ่งชี้ที่  5.1  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 1

			---ตัวบ่งชี้ที่  5.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 2

			---ตัวบ่งชี้ที่  5.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 3

			---ตัวบ่งชี้ที่  5.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 4


			---/////////// มาตรฐานที่ 6 ////////////

			---ตัวบ่งชี้ที่  6.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 1

			---ตัวบ่งชี้ที่  6.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 2

			---ตัวบ่งชี้ที่  6.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 3

			---ตัวบ่งชี้ที่  6.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 4


			---/////////// มาตรฐานที่ 7 ////////////

			---ตัวบ่งชี้ที่  7.1  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 1

			---ตัวบ่งชี้ที่  7.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 2

			---ตัวบ่งชี้ที่  7.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 3

			---ตัวบ่งชี้ที่  7.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 4

			---ตัวบ่งชี้ที่  7.5  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 5

			---ตัวบ่งชี้ที่  7.6  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 6

			---ตัวบ่งชี้ที่  7.7  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 7

			---ตัวบ่งชี้ที่  7.8  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 8

			---ตัวบ่งชี้ที่  7.9  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 9


			---/////////// มาตรฐานที่ 8 ////////////

			---ตัวบ่งชี้ที่  8.1  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 1

			---ตัวบ่งชี้ที่  8.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 2

			---ตัวบ่งชี้ที่  8.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 3

			---ตัวบ่งชี้ที่  8.4  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 4

			---ตัวบ่งชี้ที่  8.5  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 5

			---ตัวบ่งชี้ที่  8.6  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 6


			---/////////// มาตรฐานที่ 9 ////////////

			---ตัวบ่งชี้ที่  9.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 1

			---ตัวบ่งชี้ที่  9.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 2

			---ตัวบ่งชี้ที่  9.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 3

			
			---/////////// มาตรฐานที่ 10 ////////////

			---ตัวบ่งชี้ที่  10.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 1

			---ตัวบ่งชี้ที่  10.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 2

			---ตัวบ่งชี้ที่  10.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 3

			---ตัวบ่งชี้ที่  10.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 4

			---ตัวบ่งชี้ที่  10.5  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 5

			---ตัวบ่งชี้ที่  10.6  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 6

			
			---/////////// มาตรฐานที่ 11 ////////////

			---ตัวบ่งชี้ที่  11.1  คะแนนเต็ม  4.0
			Update Indicators Set ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 1

			---ตัวบ่งชี้ที่  11.2  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 2

			---ตัวบ่งชี้ที่  11.3  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 3


			---/////////// มาตรฐานที่ 12 ////////////

			---ตัวบ่งชี้ที่  12.1  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 1

			---ตัวบ่งชี้ที่  12.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 2

			---ตัวบ่งชี้ที่  12.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 3

			---ตัวบ่งชี้ที่  12.4  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 4

			---ตัวบ่งชี้ที่  12.5  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 5

			---ตัวบ่งชี้ที่  12.6  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 6


			---/////////// มาตรฐานที่ 13 ////////////

			---ตัวบ่งชี้ที่  13.1  คะแนนเต็ม  5.0
			Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 13 And b.Sort = 1

			---ตัวบ่งชี้ที่  13.2  คะแนนเต็ม  5.0
			Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 13 And b.Sort = 2


			---/////////// มาตรฐานที่ 14 ////////////

			---ตัวบ่งชี้ที่  14.1  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 14 And b.Sort = 1

			---ตัวบ่งชี้ที่  14.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 14 And b.Sort = 2


			---/////////// มาตรฐานที่ 15 ////////////

			---ตัวบ่งชี้ที่  15.1  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 15 And b.Sort = 1

			---ตัวบ่งชี้ที่  15.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 15 And b.Sort = 2		
			
			
			--0.5--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'

			--1.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'

			--2.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'

			--3.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'

			--4.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'

			--5.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'	
		End

		IF @RateType = 1
		Begin
			------------เกณฑ์ใหม่

			---/////////// มาตรฐานที่ 1 ////////////

			---ตัวบ่งชี้ที่  1.1  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 1

			---ตัวบ่งชี้ที่  1.2  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 2

			---ตัวบ่งชี้ที่  1.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 3

			---ตัวบ่งชี้ที่  1.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 4

			---ตัวบ่งชี้ที่  1.5  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 5

			---ตัวบ่งชี้ที่  1.6  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 6


			---/////////// มาตรฐานที่ 2 ////////////

			---ตัวบ่งชี้ที่  2.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 1

			---ตัวบ่งชี้ที่  2.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 2

			---ตัวบ่งชี้ที่  2.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 3

			---ตัวบ่งชี้ที่  2.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 4


			---/////////// มาตรฐานที่ 3 ////////////

			---ตัวบ่งชี้ที่  3.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 1

			---ตัวบ่งชี้ที่  3.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 2

			---ตัวบ่งชี้ที่  3.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 3

			---ตัวบ่งชี้ที่  3.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 4


			---/////////// มาตรฐานที่ 4 ////////////

			---ตัวบ่งชี้ที่  4.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 1

			---ตัวบ่งชี้ที่  4.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 2

			---ตัวบ่งชี้ที่  4.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 3

			---ตัวบ่งชี้ที่  4.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 4


			---/////////// มาตรฐานที่ 5 ////////////

			---ตัวบ่งชี้ที่  5.1  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 1

			---ตัวบ่งชี้ที่  5.2  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 2

			---ตัวบ่งชี้ที่  5.3  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 3

			---ตัวบ่งชี้ที่  5.4  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 4


			---/////////// มาตรฐานที่ 6 ////////////

			---ตัวบ่งชี้ที่  6.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 1

			---ตัวบ่งชี้ที่  6.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 2

			---ตัวบ่งชี้ที่  6.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 3

			---ตัวบ่งชี้ที่  6.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 4


			---/////////// มาตรฐานที่ 7 ////////////

			---ตัวบ่งชี้ที่  7.1  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 1

			---ตัวบ่งชี้ที่  7.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 2

			---ตัวบ่งชี้ที่  7.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 3

			---ตัวบ่งชี้ที่  7.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 4

			---ตัวบ่งชี้ที่  7.5  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 5

			---ตัวบ่งชี้ที่  7.6  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 6

			---ตัวบ่งชี้ที่  7.7  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 7

			---ตัวบ่งชี้ที่  7.8  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 8

			---ตัวบ่งชี้ที่  7.9  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 9
			

			---/////////// มาตรฐานที่ 8 ////////////

			---ตัวบ่งชี้ที่  8.1  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 1

			---ตัวบ่งชี้ที่  8.2  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 2

			---ตัวบ่งชี้ที่  8.3  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 3

			---ตัวบ่งชี้ที่  8.4  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 4

			---ตัวบ่งชี้ที่  8.5  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 5

			---ตัวบ่งชี้ที่  8.6  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 6


			---/////////// มาตรฐานที่ 9 ////////////

			---ตัวบ่งชี้ที่  9.1  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 1

			---ตัวบ่งชี้ที่  9.2  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 2

			---ตัวบ่งชี้ที่  9.3  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 3

			
			---/////////// มาตรฐานที่ 10 ////////////

			---ตัวบ่งชี้ที่  10.1  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 1

			---ตัวบ่งชี้ที่  10.2  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 2

			---ตัวบ่งชี้ที่  10.3  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 3

			---ตัวบ่งชี้ที่  10.4  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 4

			---ตัวบ่งชี้ที่  10.5  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 5

			---ตัวบ่งชี้ที่  10.6  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 6

			
			---/////////// มาตรฐานที่ 11 ////////////

			---ตัวบ่งชี้ที่  11.1  คะแนนเต็ม  4.0
			Update Indicators Set ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 1

			---ตัวบ่งชี้ที่  11.2  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 2

			---ตัวบ่งชี้ที่  11.3  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 3

				
			---/////////// มาตรฐานที่ 12 ////////////

			---ตัวบ่งชี้ที่  12.1  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 1

			---ตัวบ่งชี้ที่  12.2  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 2

			---ตัวบ่งชี้ที่  12.3  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 3

			---ตัวบ่งชี้ที่  12.4  คะแนนเต็ม  0.5 (2)
			Update Indicators Set ScoreGroupID = 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 4

			---ตัวบ่งชี้ที่  12.5  คะแนนเต็ม  0.5 (2)
			Update Indicators Set ScoreGroupID = 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 5			

			---ตัวบ่งชี้ที่  12.6  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 6

			
			---/////////// มาตรฐานที่ 13 ////////////

			---ตัวบ่งชี้ที่  13.1  คะแนนเต็ม  5.0 (2)
			Update Indicators Set ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 13 And b.Sort = 1

			---ตัวบ่งชี้ที่  13.2  คะแนนเต็ม  5.0 (2)
			Update Indicators Set ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 13 And b.Sort = 2


			---/////////// มาตรฐานที่ 14 ////////////

			---ตัวบ่งชี้ที่  14.1  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 14 And b.Sort = 1

			---ตัวบ่งชี้ที่  14.2  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 14 And b.Sort = 2


			---/////////// มาตรฐานที่ 15 ////////////

			---ตัวบ่งชี้ที่  15.1  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 15 And b.Sort = 1

			---ตัวบ่งชี้ที่  15.2  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 15 And b.Sort = 2		


			--0.5--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'

			--0.5-- (2)
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35'

			--1.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'

			--1.0-- (2)
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'

			--2.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'

			--2.0-- (2)
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'

			--3.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'

			--4.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'

			--5.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'

			--5.0-- (2)
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
		End

		IF @RateType = 2
		Begin
			------------เกณฑ์ใหม่ 12 มาตรฐาน ปี 59

			---/////////// มาตรฐานที่ 1 ////////////

			---ตัวบ่งชี้ที่  1.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 1

			---ตัวบ่งชี้ที่  1.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 2

			---ตัวบ่งชี้ที่  1.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 3

			---ตัวบ่งชี้ที่  1.4  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 4

			---ตัวบ่งชี้ที่  1.5  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 5


			---/////////// มาตรฐานที่ 2 ////////////

			---ตัวบ่งชี้ที่  2.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 1

			---ตัวบ่งชี้ที่  2.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 2

			---ตัวบ่งชี้ที่  2.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 3

			---ตัวบ่งชี้ที่  2.4  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 4

			---ตัวบ่งชี้ที่  2.5  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 5


			---/////////// มาตรฐานที่ 3 ////////////

			---ตัวบ่งชี้ที่  3.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 1

			---ตัวบ่งชี้ที่  3.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 2

			---ตัวบ่งชี้ที่  3.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 3


			---/////////// มาตรฐานที่ 4 ////////////

			---ตัวบ่งชี้ที่  4.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 1

			---ตัวบ่งชี้ที่  4.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 2

			---ตัวบ่งชี้ที่  4.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 3


			---/////////// มาตรฐานที่ 5 ////////////

			---ตัวบ่งชี้ที่  5.1  คะแนนเต็ม  4.0
			Update Indicators Set ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 1

			---ตัวบ่งชี้ที่  5.2  คะแนนเต็ม  4.0
			Update Indicators Set ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 2

			---ตัวบ่งชี้ที่  5.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 3

			---ตัวบ่งชี้ที่  5.4  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 4

			---ตัวบ่งชี้ที่  5.5  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 5


			---/////////// มาตรฐานที่ 6 ////////////

			---ตัวบ่งชี้ที่  6.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 1

			---ตัวบ่งชี้ที่  6.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 2

			---ตัวบ่งชี้ที่  6.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 3


			---/////////// มาตรฐานที่ 7 ////////////

			---ตัวบ่งชี้ที่  7.1  คะแนนเต็ม  5.0
			Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 1

			---ตัวบ่งชี้ที่  7.2  คะแนนเต็ม  10.0
			Update Indicators Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 2


			---/////////// มาตรฐานที่ 8 ////////////

			---ตัวบ่งชี้ที่  8.1  คะแนนเต็ม  5.0 (2)
			Update Indicators Set ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 1

			---ตัวบ่งชี้ที่  8.2  คะแนนเต็ม  5.0 (2)
			Update Indicators Set ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 2

			
			---/////////// มาตรฐานที่ 9 ////////////
			
			---ตัวบ่งชี้ที่  9.1  คะแนนเต็ม  3.0
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 1

			---ตัวบ่งชี้ที่  9.2  คะแนนเต็ม  5.0 (2)
			Update Indicators Set ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 2

			---ตัวบ่งชี้ที่  9.3  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 3


			---/////////// มาตรฐานที่ 10 ////////////

			---ตัวบ่งชี้ที่  10.1  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 1

			---ตัวบ่งชี้ที่  10.2  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 2

			---ตัวบ่งชี้ที่  10.3  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 3

			---ตัวบ่งชี้ที่  10.4  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 4

			---ตัวบ่งชี้ที่  10.5  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 5

			---ตัวบ่งชี้ที่  10.6  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 6

			---ตัวบ่งชี้ที่  10.7  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 7

			---ตัวบ่งชี้ที่  10.8  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 8

			
			---/////////// มาตรฐานที่ 11 ////////////

			---ตัวบ่งชี้ที่  11.1  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 1

			---ตัวบ่งชี้ที่  11.2  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 2

			---ตัวบ่งชี้ที่  11.3  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 11 And b.Sort = 3


			---/////////// มาตรฐานที่ 12 ////////////

			---ตัวบ่งชี้ที่  12.1  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 1

			---ตัวบ่งชี้ที่  12.2  คะแนนเต็ม  2.0 (2)
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 2

			---ตัวบ่งชี้ที่  12.3  คะแนนเต็ม  1.0 (2)
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 3


			--0.5--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'

			--1.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'

			--1.0-- (2)
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'

			--2.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'

			--2.0-- (2)
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'

			--3.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'

			--4.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'

			--5.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'

			--5.0-- (2)
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'

			--10.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61'
		End

		IF @RateType = 3
		Begin
			------------แบบใหม่ 4 มาตรฐาน 

			---/////////// มาตรฐานที่ 1 ////////////

			---ตัวบ่งชี้ที่  1.1  คะแนนเต็ม  5
			Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 1

			---ตัวบ่งชี้ที่  1.2  คะแนนเต็ม  5
			Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 2

			---ตัวบ่งชี้ที่  1.3  คะแนนเต็ม  3
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 3

			---ตัวบ่งชี้ที่  1.4  คะแนนเต็ม  2
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 4

			---ตัวบ่งชี้ที่  1.5  คะแนนเต็ม  3
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 5

			---ตัวบ่งชี้ที่  1.6  คะแนนเต็ม  2
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 1 And b.Sort = 6


			---/////////// มาตรฐานที่ 2 ////////////

			---ตัวบ่งชี้ที่  2.1  คะแนนเต็ม  2
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 1

			---ตัวบ่งชี้ที่  2.2  คะแนนเต็ม  3
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 2

			---ตัวบ่งชี้ที่  2.3  คะแนนเต็ม  2
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 3

			---ตัวบ่งชี้ที่  2.4  คะแนนเต็ม  3
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 2 And b.Sort = 4


			---/////////// มาตรฐานที่ 3 ////////////

			---ตัวบ่งชี้ที่  3.1  คะแนนเต็ม  5
			Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 3 And b.Sort = 1

			---/////////// มาตรฐานที่ 4 ////////////

			---ตัวบ่งชี้ที่  4.1  คะแนนเต็ม  5
			Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 1

			---ตัวบ่งชี้ที่  4.2  คะแนนเต็ม  5
			Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 2

			---ตัวบ่งชี้ที่  4.3  คะแนนเต็ม  5
			Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 3

			---ตัวบ่งชี้ที่  4.4  คะแนนเต็ม  5
			Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 4 And b.Sort = 4


			---/////////// มาตรฐานที่ 5 ////////////

			---ตัวบ่งชี้ที่  5.1  คะแนนเต็ม  3
			Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 1


			---/////////// มาตรฐานที่ 6 ////////////

			---ตัวบ่งชี้ที่  6.1  คะแนนเต็ม  2
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 6 And b.Sort = 1


			---/////////// มาตรฐานที่ 7 ////////////

			---ตัวบ่งชี้ที่  7.1  คะแนนเต็ม  10
			Update Indicators Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 7 And b.Sort = 1


			---/////////// มาตรฐานที่ 8 ////////////

			---ตัวบ่งชี้ที่  8.1  คะแนนเต็ม  5
			Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 1


			---/////////// มาตรฐานที่ 9 ////////////

			---ตัวบ่งชี้ที่  9.1  คะแนนเต็ม  5
			Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 1

			
			---/////////// มาตรฐานที่ 10 ////////////

			---ตัวบ่งชี้ที่  10.1  คะแนนเต็ม  20
			Update Indicators Set ScoreGroupID = '4996ad20-57fc-4dbc-a01d-698393d7affb'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 1

			
			--0.5--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'

			--1.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'

			--2.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'

			--3.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'

			--4.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'

			--5.0--
			Update Indicators Set WeightScore = (Select WeightScore from ScoreGroup Where ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear And b.ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'	
		End
	End


Go
----------ลบ StoreProcedure เมนู ModeStandardNew
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuModeStandardNew')
Begin
	DROP PROCEDURE ckMenuModeStandardNew
End

Go
--เพิ่ม Store เมนู NewStandard
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuModeStandardNew
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set MySubMenuName = N'ด้าน' Where MySubMenuID = 'be6cf047-27b5-4591-b334-42e9c0435d86'
		Update MySubMenu Set MySubMenuName = N'มาตรฐาน' Where MySubMenuID = '74334f9f-14bc-4c18-9197-d3a7ac18def2'
		Update MySubMenu Set MySubMenuName = N'ตัวบ่งชี้' Where MySubMenuID = '075f0695-53cd-4886-9a13-72b8873c8137'
		Update MySubMenu Set MySubMenuName = N'คัดลอกด้าน/มาตรฐาน/ตัวบ่งชี้' Where MySubMenuID = '9513380c-a4b1-4096-9789-0ad701f0d0da'
	End
	Else
	Begin
		Update MySubMenu Set MySubMenuName = N'มาตรฐาน' Where MySubMenuID = 'be6cf047-27b5-4591-b334-42e9c0435d86'
		Update MySubMenu Set MySubMenuName = N'ประเด็นการพิจารณา' Where MySubMenuID = '74334f9f-14bc-4c18-9197-d3a7ac18def2'
		Update MySubMenu Set MySubMenuName = N'ประเด็นการพิจารณาย่อย' Where MySubMenuID = '075f0695-53cd-4886-9a13-72b8873c8137'
		Update MySubMenu Set MySubMenuName = N'คัดลอกมาตรฐาน/ประเด็นฯ/ประเด็นฯย่อย' Where MySubMenuID = '9513380c-a4b1-4096-9789-0ad701f0d0da'
	End
END

Go
Update MR_School Set ckStandardNew = 0 Where ckStandardNew Is Null


-------- v 11.3.0.17-------
GO
/****** Object:  StoredProcedure [dbo].[GenRate]    Script Date: 3/7/2560 15:46:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	ALTER PROCEDURE [dbo].[GenRate]
		@RateType int
	AS
	BEGIN
		SET NOCOUNT ON;
		IF @RateType = 0
		Begin
			----------------เก่า---------------------
			-----------0.5
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๒๔', TMin = 0, TMax = 0.24 Where TcriteriaID = '990f80da-c07c-41b5-ac1f-5e8a45e5bb0e'
			Update TCriteria Set Detail = '๐.๒๕ - ๐.๒๙', TMin = 0.25, TMax = 0.29 Where TcriteriaID = '50a812bd-f27e-4259-8946-004c1044fabf'
			Update TCriteria Set Detail = '๐.๓๐ - ๐.๓๔', TMin = 0.3, TMax = 0.34 Where TcriteriaID = '573fcdb2-0f1d-42d4-95a9-2ce3b2dd5fd4'
			Update TCriteria Set Detail = '๐.๓๕ - ๐.๓๙', TMin = 0.35, TMax = 0.39, Translation = N'ดีมาก' Where TcriteriaID = 'de5b6ed8-a080-468d-8cca-a302d0f5e73b'
			Update TCriteria Set Detail = '๐.๔๐ - ๐.๕๐', TMin = 0.4, TMax = 0.5, DelFlag = 0 Where TcriteriaID = 'db2bedf7-9cf8-4495-a3b8-9ca572bd1f55'

			-----------1.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๔๙', TMin = 0, TMax = 0.49 Where TcriteriaID = '523325f5-5610-4074-8788-eeedf6b35e6c'
			Update TCriteria Set Detail = '๐.๕๐ - ๐.๕๙', TMin = 0.5, TMax = 0.59 Where TcriteriaID = '9a340d20-7c31-4955-a3c7-7fe5eb0a6be3'
			Update TCriteria Set Detail = '๐.๖๐ - ๐.๖๙', TMin = 0.6, TMax = 0.69 Where TcriteriaID = '6344b6e3-cfa7-4fdd-8b71-34470dd661ab'
			Update TCriteria Set Detail = '๐.๗๐ - ๐.๗๙', TMin = 0.7, TMax = 0.79, Translation = N'ดีมาก' Where TcriteriaID = '98d32855-a9ac-444e-a3f2-558961400149'
			Update TCriteria Set Detail = '๐.๘๐ - ๑.๐๐', TMin = 0.8, TMax = 1, DelFlag = 0 Where TcriteriaID = '138fb5bd-2a19-4a09-855e-43205d18ca7b'

			-----------2.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๙๙', TMin = 0, TMax = 0.99 Where TcriteriaID = '944cee00-2cea-400a-b5dc-081cf16e83a6'
			Update TCriteria Set Detail = '๑.๐๐ - ๑.๑๙', TMin = 1.0, TMax = 1.19 Where TcriteriaID = '6469c8d5-6542-471e-a31a-9c1b1681110b'
			Update TCriteria Set Detail = '๑.๒๐ - ๑.๓๙', TMin = 1.2, TMax = 1.39 Where TcriteriaID = 'fb08528d-fb28-4382-931d-cbbf28cf6b14'
			Update TCriteria Set Detail = '๑.๔๐ - ๑.๕๙', TMin = 1.4, TMax = 1.59, Translation = N'ดีมาก' Where TcriteriaID = '970f9571-a05c-4a6e-9270-e3b8b6346832'
			Update TCriteria Set Detail = '๑.๖๐ - ๒.๐๐', TMin = 1.6, TMax = 2, DelFlag = 0 Where TcriteriaID = 'e1923d69-300a-49e8-b2dd-558a1c9778a0'

			-----------3.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๔๙', TMin = 0, TMax = 1.49 Where TcriteriaID = 'e68d09a7-053d-4812-a5e2-5019600fc59a'
			Update TCriteria Set Detail = '๑.๕๐ - ๑.๗๙', TMin = 1.5, TMax = 1.79 Where TcriteriaID = 'c40a7ddb-5bf7-45f1-8339-bf23765d686d'
			Update TCriteria Set Detail = '๑.๘๐ - ๒.๐๙', TMin = 1.8, TMax = 2.09 Where TcriteriaID = 'a1c46154-02c8-47da-9c07-26d2fdd36eee'
			Update TCriteria Set Detail = '๒.๑๐ - ๒.๓๙', TMin = 2.1, TMax = 2.39, Translation = N'ดีมาก' Where TcriteriaID = '948736f6-16c6-4e50-96dd-f038ff34ff83'
			Update TCriteria Set Detail = '๒.๔๐ - ๓.๐๐', TMin = 2.4, TMax = 3, DelFlag = 0 Where TcriteriaID = '8b7b8f2e-cad2-4b76-b18b-d0066192b40a'

			-----------4.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๙๙', TMin = 0, TMax = 1.99 Where TcriteriaID = 'cfe6e7f9-d797-45d3-97bf-384a7ea2288d'
			Update TCriteria Set Detail = '๒.๐๐ - ๒.๓๙', TMin = 2, TMax = 2.39 Where TcriteriaID = '8c907257-17c1-45ed-a605-34721f5d1c5e'
			Update TCriteria Set Detail = '๒.๔๐ - ๒.๗๙', TMin = 2.4, TMax = 2.79 Where TcriteriaID = '5319e303-bff3-4ae9-9b2d-5138a43aa3bd'
			Update TCriteria Set Detail = '๒.๘๐ - ๓.๑๙', TMin = 2.8, TMax = 3.19, Translation = N'ดีมาก' Where TcriteriaID = '05a882f1-b133-4131-ad72-43cbc4d932cb'
			Update TCriteria Set Detail = '๓.๒๐ - ๔.๐๐', TMin = 3.2, TMax = 4, DelFlag = 0 Where TcriteriaID = 'fee73c78-23c3-4590-9fe4-08c98f72d1cd'

			-----------5.0
			Update TCriteria Set Detail = '๐.๐๐ - ๒.๔๙', TMin = 0, TMax = 2.49 Where TcriteriaID = 'a810252f-9bb6-48a7-b610-dc7a86996451'
			Update TCriteria Set Detail = '๒.๕๐ - ๒.๙๙', TMin = 2.5, TMax = 2.99 Where TcriteriaID = 'ecb48ab5-37ad-4ad0-b8ff-0fffefa8a3b3'
			Update TCriteria Set Detail = '๓.๐๐ - ๓.๔๙', TMin = 3, TMax = 3.49 Where TcriteriaID = 'af07711a-3896-4e93-9794-4c27b670acbf'
			Update TCriteria Set Detail = '๓.๕๐ - ๓.๙๙', TMin = 3.5, TMax = 3.99, Translation = N'ดีมาก' Where TcriteriaID = 'f4a8dcb9-7687-4f2c-9741-f2f8f1da694b'
			Update TCriteria Set Detail = '๔.๐๐ - ๕.๐๐', TMin = 4, TMax = 5, DelFlag = 0 Where TcriteriaID = 'aeb0b92f-8949-47d0-99cd-af3980734f21'

			-----------10.0
			Update TCriteria Set Detail = '๐.๐๐ - ๔.๙๙', TMin = 0, TMax = 4.99 Where TcriteriaID = 'c2c6d92d-e887-4bf0-885c-ca8bee4e807f'
			Update TCriteria Set Detail = '๕.๐๐ - ๕.๙๙', TMin = 5, TMax = 5.99 Where TcriteriaID = 'e0424d8a-e013-4482-895b-f0e8f4c52b12'
			Update TCriteria Set Detail = '๖.๐๐ - ๖.๙๙', TMin = 6, TMax = 6.99 Where TcriteriaID = 'b3f28c05-5d4d-43fb-9284-a84117a4c566'
			Update TCriteria Set Detail = '๗.๐๐ - ๗.๙๙', TMin = 7, TMax = 7.99, Translation = N'ดีมาก' Where TcriteriaID = '5f4e7061-4705-42b4-be20-01f144f08d5e'
			Update TCriteria Set Detail = '๘.๐๐ - ๑๐.๐๐', TMin = 8, TMax = 10, DelFlag = 0 Where TcriteriaID = '16b3f3e2-b8a1-481e-9661-5177aad558d3'

			-----------20.0
			Update TCriteria Set Detail = '๐.๐๐ - ๙.๙๙', TMin = 0, TMax = 9.99 Where TcriteriaID = '68927e0c-0400-4d0a-aec9-5bbebdedc891'
			Update TCriteria Set Detail = '๑๐.๐๐ - ๑๑.๙๙', TMin = 10, TMax = 11.99 Where TcriteriaID = '8f1c8c9b-b0bf-43e3-98df-4e75dcf3a098'
			Update TCriteria Set Detail = '๑๒.๐๐ - ๑๔.๙๙', TMin = 12, TMax = 14.99 Where TcriteriaID = '5e989d3b-1f19-437e-aab3-db1af0d6953f'
			Update TCriteria Set Detail = '๑๕.๐๐ - ๑๗.๙๙', TMin = 15, TMax = 17.99, Translation = N'ดีมาก' Where TcriteriaID = '2c3771cc-ef05-4448-be15-a51215e11e89'
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๐.๐๐', TMin = 18, TMax = 20, DelFlag = 0 Where TcriteriaID = 'e49d9c94-22f6-4c8a-9a5c-32fcdbe149a3'

			-----------30.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑๔.๙๙', TMin = 0, TMax = 14.99 Where TcriteriaID = 'b930e376-717b-4f50-bc69-803f88ff6402'
			Update TCriteria Set Detail = '๑๕.๐๐ - ๑๗.๙๙', TMin = 15, TMax = 17.99 Where TcriteriaID = '90983ed4-0799-4ca1-8145-a3b007a53a69'
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๐.๙๙', TMin = 18, TMax = 20.99 Where TcriteriaID = 'f497f305-8316-4d54-bcc8-2da0dc4fd9be'
			Update TCriteria Set Detail = '๒๑.๐๐ - ๒๓.๙๙', TMin = 21, TMax = 23.99, Translation = N'ดีมาก' Where TcriteriaID = '6c3191d9-13ab-4bfb-bddb-dc50623b4c3a'
			Update TCriteria Set Detail = '๒๔.๐๐ - ๓๐.๐๐', TMin = 24, TMax = 30, DelFlag = 0 Where TcriteriaID = 'f7818b1f-6b6b-46fc-9611-169c481e2c4d'

			-----------50.0
			Update TCriteria Set Detail = '๐.๐๐ - ๒๔.๙๙', TMin = 0, TMax = 24.99 Where TcriteriaID = '0e4d3521-401d-408f-8f2f-d69a509a2117'
			Update TCriteria Set Detail = '๒๕.๐๐ - ๒๙.๙๙', TMin = 25, TMax = 29.99 Where TcriteriaID = '32d76bf4-7e87-4575-910c-92761b2da74d'
			Update TCriteria Set Detail = '๓๐.๐๐ - ๓๔.๙๙', TMin = 30, TMax = 34.99 Where TcriteriaID = '7722765c-3e54-42a4-b209-5cafe57cc7b2'
			Update TCriteria Set Detail = '๓๕.๐๐ - ๓๙.๙๙', TMin = 35, TMax = 39.99, Translation = N'ดีมาก' Where TcriteriaID = 'bcc684de-202a-44ae-948e-d7dbb78f572e'
			Update TCriteria Set Detail = '๔๐.๐๐ - ๕๐.๐๐', TMin = 40, TMax = 50, DelFlag = 0 Where TcriteriaID = '48c0564e-b8d8-4963-8ab1-4910057944a6'

			-----------100.0
			Update TCriteria Set Detail = '๐.๐๐ - ๔๙.๙๙', TMin = 0, TMax = 49.99 Where TcriteriaID = '69c5bc62-b443-48c5-9a46-cd1e4df27003'
			Update TCriteria Set Detail = '๕๐.๐๐ - ๕๙.๙๙', TMin = 50, TMax = 59.99 Where TcriteriaID = '59291c4d-2eec-4ea2-8a2d-922b6a34fa4c'
			Update TCriteria Set Detail = '๖๐.๐๐ - ๖๙.๙๙', TMin = 60, TMax = 69.99 Where TcriteriaID = 'e277de33-3d86-4f09-b7b8-f3c97d585cb5'
			Update TCriteria Set Detail = '๗๐.๐๐ - ๗๙.๙๙', TMin = 70, TMax = 79.99, Translation = N'ดีมาก' Where TcriteriaID = 'facf0afb-b6f4-4675-9c47-774eb1d1b8af'
			Update TCriteria Set Detail = '๘๐.๐๐ - ๑๐๐.๐๐', TMin = 80, TMax = 100, DelFlag = 0 Where TcriteriaID = '6ecc7610-19d8-47cc-b728-15efd128fe21'
		End
		
		IF @RateType = 1
		Begin
			----------------ใหม่------------------
			---------0.5 (1)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๒๔', TMin = 0, TMax = 0.24 Where TcriteriaID = '990f80da-c07c-41b5-ac1f-5e8a45e5bb0e'
			Update TCriteria Set Detail = '๐.๒๕ - ๐.๒๙', TMin = 0.25, TMax = 0.29 Where TcriteriaID = '50a812bd-f27e-4259-8946-004c1044fabf'
			Update TCriteria Set Detail = '๐.๓๐ - ๐.๓๗', TMin = 0.3, TMax = 0.37 Where TcriteriaID = '573fcdb2-0f1d-42d4-95a9-2ce3b2dd5fd4'
			Update TCriteria Set Detail = '๐.๓๘ - ๐.๔๔', TMin = 0.38, TMax = 0.44, Translation = N'ดีมาก' Where TcriteriaID = 'de5b6ed8-a080-468d-8cca-a302d0f5e73b'
			Update TCriteria Set Detail = '๐.๔๕ - ๐.๕๐', TMin = 0.45, TMax = 0.50, DelFlag = 0 Where TcriteriaID = 'db2bedf7-9cf8-4495-a3b8-9ca572bd1f55'

			-----------1.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๔๙', TMin = 0, TMax = 0.49 Where TcriteriaID = '523325f5-5610-4074-8788-eeedf6b35e6c'
			Update TCriteria Set Detail = '๐.๕๐ - ๐.๕๙', TMin = 0.5, TMax = 0.59 Where TcriteriaID = '9a340d20-7c31-4955-a3c7-7fe5eb0a6be3'
			Update TCriteria Set Detail = '๐.๖๐ - ๐.๗๔', TMin = 0.6, TMax = 0.74 Where TcriteriaID = '6344b6e3-cfa7-4fdd-8b71-34470dd661ab'
			Update TCriteria Set Detail = '๐.๗๕ - ๐.๘๙', TMin = 0.75, TMax = 0.89, Translation = N'ดีมาก' Where TcriteriaID = '98d32855-a9ac-444e-a3f2-558961400149'
			Update TCriteria Set Detail = '๐.๙๐ - ๑.๐๐', TMin = 0.9, TMax = 1, DelFlag = 0 Where TcriteriaID = '138fb5bd-2a19-4a09-855e-43205d18ca7b'

			-----------1.0 (2)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๒๐', TMin = 0, TMax = 0.2 Where TcriteriaID = '223EFC01-5C93-46CD-B3F5-8EA36DCF8FDC'
			Update TCriteria Set Detail = '๐.๒๑ - ๐.๔๐', TMin = 0.21, TMax = 0.4 Where TcriteriaID = '36365A43-EBA9-478F-B337-98F3C0D12ACF'
			Update TCriteria Set Detail = '๐.๔๑ - ๐.๖๐', TMin = 0.41, TMax = 0.6 Where TcriteriaID = '0633B326-32A3-4018-A6E4-071CCA336DF9'
			Update TCriteria Set Detail = '๐.๖๑ - ๐.๘๐', TMin = 0.61, TMax = 0.8 Where TcriteriaID = 'A6411A5F-B47D-4578-A7FC-6B4924AC42BB'
			Update TCriteria Set Detail = '๐.๘๑ - ๑.๐๐', TMin = 0.81, TMax = 1 Where TcriteriaID = 'AB835423-2FDA-4348-B3EC-7AB735C3E4CC'

			-----------2.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๙๙', TMin = 0, TMax = 0.99 Where TcriteriaID = '944cee00-2cea-400a-b5dc-081cf16e83a6'
			Update TCriteria Set Detail = '๑.๐๐ - ๑.๑๙', TMin = 1.0, TMax = 1.19 Where TcriteriaID = '6469c8d5-6542-471e-a31a-9c1b1681110b'
			Update TCriteria Set Detail = '๑.๒๐ - ๑.๔๙', TMin = 1.2, TMax = 1.49 Where TcriteriaID = 'fb08528d-fb28-4382-931d-cbbf28cf6b14'
			Update TCriteria Set Detail = '๑.๕๐ - ๑.๗๙', TMin = 1.5, TMax = 1.79, Translation = N'ดีมาก' Where TcriteriaID = '970f9571-a05c-4a6e-9270-e3b8b6346832'
			Update TCriteria Set Detail = '๑.๘๐ - ๒.๐๐', TMin = 1.8, TMax = 2, DelFlag = 0 Where TcriteriaID = 'e1923d69-300a-49e8-b2dd-558a1c9778a0'

			-----------2.0 (2)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๔๐', TMin = 0, TMax = 0.4 Where TcriteriaID = '22656210-A80D-4BA6-88D7-0D18235CAE6B'
			Update TCriteria Set Detail = '๐.๔๑ - ๐.๘๐', TMin = 0.41, TMax = 0.8 Where TcriteriaID = 'A6680FCD-11E8-46B3-A447-F9ACBAC8A627'
			Update TCriteria Set Detail = '๐.๘๑ - ๑.๒๐', TMin = 0.81, TMax = 1.2 Where TcriteriaID = '76CCC37D-CA07-458F-83DC-C32FA1E8D1D6'
			Update TCriteria Set Detail = '๑.๒๑ - ๑.๖๐', TMin = 1.21, TMax = 1.6 Where TcriteriaID = '943675D4-E2CD-4EEA-8AB0-BA5D743A90C9'
			Update TCriteria Set Detail = '๑.๖๑ - ๒.๐๐', TMin = 1.61, TMax = 2 Where TcriteriaID = 'B72385BA-FAC6-4EC9-AC62-F3594CCB5753'

			-----------3.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๖๐', TMin = 0, TMax = 0.6 Where TcriteriaID = 'e68d09a7-053d-4812-a5e2-5019600fc59a'
			Update TCriteria Set Detail = '๐.๖๑ - ๑.๒๐', TMin = 0.61, TMax = 1.20 Where TcriteriaID = 'c40a7ddb-5bf7-45f1-8339-bf23765d686d'
			Update TCriteria Set Detail = '๑.๒๑ - ๑.๘๐', TMin = 1.21, TMax = 1.8 Where TcriteriaID = 'a1c46154-02c8-47da-9c07-26d2fdd36eee'
			Update TCriteria Set Detail = '๑.๘๑ - ๒.๔๐', TMin = 1.81, TMax = 2.4, Translation = N'ดีมาก' Where TcriteriaID = '948736f6-16c6-4e50-96dd-f038ff34ff83'
			Update TCriteria Set Detail = '๒.๔๑ - ๓.๐๐', TMin = 2.41, TMax = 3, DelFlag = 0 Where TcriteriaID = '8b7b8f2e-cad2-4b76-b18b-d0066192b40a'

			-----------4.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๘๐', TMin = 0, TMax = 0.8 Where TcriteriaID = 'cfe6e7f9-d797-45d3-97bf-384a7ea2288d'
			Update TCriteria Set Detail = '๐.๘๑ - ๑.๖๐', TMin = 0.81, TMax = 1.6 Where TcriteriaID = '8c907257-17c1-45ed-a605-34721f5d1c5e'
			Update TCriteria Set Detail = '๑.๖๑ - ๒.๔๐', TMin = 1.61, TMax = 2.4 Where TcriteriaID = '5319e303-bff3-4ae9-9b2d-5138a43aa3bd'
			Update TCriteria Set Detail = '๒.๔๑ - ๓.๒๐', TMin = 2.41, TMax = 3.2, Translation = N'ดีมาก' Where TcriteriaID = '05a882f1-b133-4131-ad72-43cbc4d932cb'
			Update TCriteria Set Detail = '๓.๒๑ - ๔.๐๐', TMin = 3.21, TMax = 4, DelFlag = 0 Where TcriteriaID = 'fee73c78-23c3-4590-9fe4-08c98f72d1cd'

			-----------5.0
			Update TCriteria Set Detail = '๐.๐๐ - ๒.๔๙', TMin = 0, TMax = 2.49 Where TcriteriaID = 'a810252f-9bb6-48a7-b610-dc7a86996451'
			Update TCriteria Set Detail = '๒.๕๐ - ๒.๙๙', TMin = 2.5, TMax = 2.99 Where TcriteriaID = 'ecb48ab5-37ad-4ad0-b8ff-0fffefa8a3b3'
			Update TCriteria Set Detail = '๓.๐๐ - ๓.๗๔', TMin = 3, TMax = 3.74 Where TcriteriaID = 'af07711a-3896-4e93-9794-4c27b670acbf'
			Update TCriteria Set Detail = '๓.๗๕ - ๔.๔๙', TMin = 3.75, TMax = 4.49, Translation = N'ดีมาก' Where TcriteriaID = 'f4a8dcb9-7687-4f2c-9741-f2f8f1da694b'
			Update TCriteria Set Detail = '๔.๕๐ - ๕.๐๐', TMin = 4.5, TMax = 5, DelFlag = 0 Where TcriteriaID = 'aeb0b92f-8949-47d0-99cd-af3980734f21'

			-----------5.0 (2)
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๐๐', TMin = 0, TMax = 1 Where TcriteriaID = '9A480D12-7160-4E72-B8AE-C9E9A663EBD4'
			Update TCriteria Set Detail = '๑.๐๑ - ๒.๐๐', TMin = 1.01, TMax = 2 Where TcriteriaID = 'E855AD6C-F412-4796-8C22-CF0587501079'
			Update TCriteria Set Detail = '๒.๐๑ - ๓.๐๐', TMin = 2.01, TMax = 3 Where TcriteriaID = '6163F6D7-70E3-4CAD-9DA6-77B7C9ABB5D5'
			Update TCriteria Set Detail = '๓.๐๑ - ๔.๐๐', TMin = 3.01, TMax = 4 Where TcriteriaID = '98C64437-9C98-44C8-A25F-880D62937C97'
			Update TCriteria Set Detail = '๔.๐๑ - ๕.๐๐', TMin = 4.01, TMax = 5 Where TcriteriaID = '5062F4F5-AE1E-4570-918A-A78C1F21E10E'

			-----------10.0
			Update TCriteria Set Detail = '๐.๐๐ - ๔.๙๙', TMin = 0, TMax = 4.99 Where TcriteriaID = 'c2c6d92d-e887-4bf0-885c-ca8bee4e807f'
			Update TCriteria Set Detail = '๕.๐๐ - ๕.๙๙', TMin = 5, TMax = 5.99 Where TcriteriaID = 'e0424d8a-e013-4482-895b-f0e8f4c52b12'
			Update TCriteria Set Detail = '๖.๐๐ - ๗.๔๙', TMin = 6, TMax = 7.49 Where TcriteriaID = 'b3f28c05-5d4d-43fb-9284-a84117a4c566'
			Update TCriteria Set Detail = '๗.๕๐ - ๘.๙๙', TMin = 7.5, TMax = 8.99, Translation = N'ดีมาก' Where TcriteriaID = '5f4e7061-4705-42b4-be20-01f144f08d5e'
			Update TCriteria Set Detail = '๙.๐๐ - ๑๐.๐๐', TMin = 9, TMax = 10, DelFlag = 0 Where TcriteriaID = '16b3f3e2-b8a1-481e-9661-5177aad558d3'

			-----------20.0
			Update TCriteria Set Detail = '๐.๐๐ - ๙.๙๙', TMin = 0, TMax = 9.99 Where TcriteriaID = '68927e0c-0400-4d0a-aec9-5bbebdedc891'
			Update TCriteria Set Detail = '๑๐.๐๐ - ๑๑.๙๙', TMin = 10, TMax = 11.99 Where TcriteriaID = '8f1c8c9b-b0bf-43e3-98df-4e75dcf3a098'
			Update TCriteria Set Detail = '๑๒.๐๐ - ๑๔.๙๙', TMin = 12, TMax = 14.99 Where TcriteriaID = '5e989d3b-1f19-437e-aab3-db1af0d6953f'
			Update TCriteria Set Detail = '๑๕.๐๐ - ๑๗.๙๙', TMin = 15, TMax = 17.99, Translation = N'ดีมาก' Where TcriteriaID = '2c3771cc-ef05-4448-be15-a51215e11e89'
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๐.๐๐', TMin = 18, TMax = 20, DelFlag = 0 Where TcriteriaID = 'e49d9c94-22f6-4c8a-9a5c-32fcdbe149a3'

			-----------30.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑๔.๙๙', TMin = 0, TMax = 14.99 Where TcriteriaID = 'b930e376-717b-4f50-bc69-803f88ff6402'
			Update TCriteria Set Detail = '๑๕.๐๐ - ๑๗.๙๙', TMin = 15, TMax = 17.99 Where TcriteriaID = '90983ed4-0799-4ca1-8145-a3b007a53a69'
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๒.๔๙', TMin = 18, TMax = 22.49 Where TcriteriaID = 'f497f305-8316-4d54-bcc8-2da0dc4fd9be'
			Update TCriteria Set Detail = '๒๒.๕๐ - ๒๖.๙๙', TMin = 22.5, TMax = 26.99, Translation = N'ดีมาก' Where TcriteriaID = '6c3191d9-13ab-4bfb-bddb-dc50623b4c3a'
			Update TCriteria Set Detail = '๒๗.๐๐ - ๓๐.๐๐', TMin = 27, TMax = 30, DelFlag = 0 Where TcriteriaID = 'f7818b1f-6b6b-46fc-9611-169c481e2c4d'

			-----------50.0
			Update TCriteria Set Detail = '๐.๐๐ - ๒๔.๙๙', TMin = 0, TMax = 24.99 Where TcriteriaID = '0e4d3521-401d-408f-8f2f-d69a509a2117'
			Update TCriteria Set Detail = '๒๕.๐๐ - ๒๙.๙๙', TMin = 25, TMax = 29.99 Where TcriteriaID = '32d76bf4-7e87-4575-910c-92761b2da74d'
			Update TCriteria Set Detail = '๓๐.๐๐ - ๓๗.๔๙', TMin = 30, TMax = 37.49 Where TcriteriaID = '7722765c-3e54-42a4-b209-5cafe57cc7b2'
			Update TCriteria Set Detail = '๓๗.๕๐ - ๔๔.๙๙', TMin = 37.5, TMax = 44.99, Translation = N'ดีมาก' Where TcriteriaID = 'bcc684de-202a-44ae-948e-d7dbb78f572e'
			Update TCriteria Set Detail = '๔๕.๐๐ - ๕๐.๐๐', TMin = 45, TMax = 50, DelFlag = 0 Where TcriteriaID = '48c0564e-b8d8-4963-8ab1-4910057944a6'

			-----------100.0
			Update TCriteria Set Detail = '๐.๐๐ - ๔๙.๙๙', TMin = 0, TMax = 49.99 Where TcriteriaID = '69c5bc62-b443-48c5-9a46-cd1e4df27003'
			Update TCriteria Set Detail = '๕๐.๐๐ - ๕๙.๙๙', TMin = 50, TMax = 59.99 Where TcriteriaID = '59291c4d-2eec-4ea2-8a2d-922b6a34fa4c'
			Update TCriteria Set Detail = '๖๐.๐๐ - ๗๔.๙๙', TMin = 60, TMax = 74.99 Where TcriteriaID = 'e277de33-3d86-4f09-b7b8-f3c97d585cb5'
			Update TCriteria Set Detail = '๗๕.๐๐ - ๘๙.๙๙', TMin = 75, TMax = 89.99, Translation = N'ดีมาก' Where TcriteriaID = 'facf0afb-b6f4-4675-9c47-774eb1d1b8af'
			Update TCriteria Set Detail = '๙๐.๐๐ - ๑๐๐.๐๐', TMin = 90, TMax = 100, DelFlag = 0 Where TcriteriaID = '6ecc7610-19d8-47cc-b728-15efd128fe21'
		End

		IF @RateType = 2
		Begin
			--------เกณฑ์ใหม่ 12 มาตรฐาน (2)-------------
			---------0.5 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๑๕', TMin = 0, TMax = 0.15 Where TcriteriaID = '990f80da-c07c-41b5-ac1f-5e8a45e5bb0e'
			Update TCriteria Set Detail = '๐.๑๖ - ๐.๓๐', TMin = 0.16, TMax = 0.30 Where TcriteriaID = '50a812bd-f27e-4259-8946-004c1044fabf'
			Update TCriteria Set Detail = '๐.๓๑ - ๐.๔๐', TMin = 0.31, TMax = 0.40 Where TcriteriaID = '573fcdb2-0f1d-42d4-95a9-2ce3b2dd5fd4'
			Update TCriteria Set Detail = '๐.๔๑ - ๐.๔๕', TMin = 0.41, TMax = 0.45, Translation = N'ดีมาก' Where TcriteriaID = 'de5b6ed8-a080-468d-8cca-a302d0f5e73b'
			Update TCriteria Set Detail = '๐.๔๖ - ๐.๕๐', TMin = 0.46, TMax = 0.50, DelFlag = 0 Where TcriteriaID = 'db2bedf7-9cf8-4495-a3b8-9ca572bd1f55'

			-----------1.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๕๙', TMin = 0, TMax = 0.59 Where TcriteriaID = '523325f5-5610-4074-8788-eeedf6b35e6c'
			Update TCriteria Set Detail = '๐.๖๐ - ๐.๗๔', TMin = 0.6, TMax = 0.74 Where TcriteriaID = '9a340d20-7c31-4955-a3c7-7fe5eb0a6be3'
			Update TCriteria Set Detail = '๐.๗๕ - ๐.๘๙', TMin = 0.75, TMax = 0.89 Where TcriteriaID = '6344b6e3-cfa7-4fdd-8b71-34470dd661ab'
			Update TCriteria Set Detail = '๐.๙๐ - ๐.๙๔', TMin = 0.9, TMax = 0.94, Translation = N'ดีมาก' Where TcriteriaID = '98d32855-a9ac-444e-a3f2-558961400149'
			Update TCriteria Set Detail = '๐.๙๕ - ๑.๐๐', TMin = 0.95, TMax = 1, DelFlag = 0 Where TcriteriaID = '138fb5bd-2a19-4a09-855e-43205d18ca7b'

			-----------1.0 (N2)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๓๐', TMin = 0, TMax = 0.3 Where TcriteriaID = '223EFC01-5C93-46CD-B3F5-8EA36DCF8FDC'
			Update TCriteria Set Detail = '๐.๓๑ - ๐.๖๐', TMin = 0.31, TMax = 0.6 Where TcriteriaID = '36365A43-EBA9-478F-B337-98F3C0D12ACF'
			Update TCriteria Set Detail = '๐.๖๑ - ๐.๘๐', TMin = 0.61, TMax = 0.8 Where TcriteriaID = '0633B326-32A3-4018-A6E4-071CCA336DF9'
			Update TCriteria Set Detail = '๐.๘๑ - ๐.๙๐', TMin = 0.81, TMax = 0.9 Where TcriteriaID = 'A6411A5F-B47D-4578-A7FC-6B4924AC42BB'
			Update TCriteria Set Detail = '๐.๙๑ - ๑.๐๐', TMin = 0.91, TMax = 1 Where TcriteriaID = 'AB835423-2FDA-4348-B3EC-7AB735C3E4CC'

			-----------2.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๑๙', TMin = 0, TMax = 1.19 Where TcriteriaID = '944cee00-2cea-400a-b5dc-081cf16e83a6'
			Update TCriteria Set Detail = '๑.๒๐ - ๑.๔๙', TMin = 1.2, TMax = 1.49 Where TcriteriaID = '6469c8d5-6542-471e-a31a-9c1b1681110b'
			Update TCriteria Set Detail = '๑.๕๐ - ๑.๗๙', TMin = 1.5, TMax = 1.79 Where TcriteriaID = 'fb08528d-fb28-4382-931d-cbbf28cf6b14'
			Update TCriteria Set Detail = '๑.๘๐ - ๑.๘๙', TMin = 1.8, TMax = 1.89, Translation = N'ดีมาก' Where TcriteriaID = '970f9571-a05c-4a6e-9270-e3b8b6346832'
			Update TCriteria Set Detail = '๑.๙๐ - ๒.๐๐', TMin = 1.9, TMax = 2, DelFlag = 0 Where TcriteriaID = 'e1923d69-300a-49e8-b2dd-558a1c9778a0'

			-----------2.0 (N2)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๖๐', TMin = 0, TMax = 0.6 Where TcriteriaID = '22656210-A80D-4BA6-88D7-0D18235CAE6B'
			Update TCriteria Set Detail = '๐.๖๑ - ๑.๒๐', TMin = 0.61, TMax = 1.2 Where TcriteriaID = 'A6680FCD-11E8-46B3-A447-F9ACBAC8A627'
			Update TCriteria Set Detail = '๐.๒๑ - ๑.๖๐', TMin = 1.21, TMax = 1.6 Where TcriteriaID = '76CCC37D-CA07-458F-83DC-C32FA1E8D1D6'
			Update TCriteria Set Detail = '๑.๖๑ - ๑.๘๐', TMin = 1.61, TMax = 1.8 Where TcriteriaID = '943675D4-E2CD-4EEA-8AB0-BA5D743A90C9'
			Update TCriteria Set Detail = '๑.๘๑ - ๒.๐๐', TMin = 1.81, TMax = 2 Where TcriteriaID = 'B72385BA-FAC6-4EC9-AC62-F3594CCB5753'

			-----------3.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๙๐', TMin = 0, TMax = 0.9 Where TcriteriaID = 'e68d09a7-053d-4812-a5e2-5019600fc59a'
			Update TCriteria Set Detail = '๐.๙๑ - ๑.๘๐', TMin = 0.91, TMax = 1.8 Where TcriteriaID = 'c40a7ddb-5bf7-45f1-8339-bf23765d686d'
			Update TCriteria Set Detail = '๑.๘๑ - ๒.๔๐', TMin = 1.81, TMax = 2.4 Where TcriteriaID = 'a1c46154-02c8-47da-9c07-26d2fdd36eee'
			Update TCriteria Set Detail = '๑.๔๑ - ๒.๗๐', TMin = 2.41, TMax = 2.7, Translation = N'ดีมาก' Where TcriteriaID = '948736f6-16c6-4e50-96dd-f038ff34ff83'
			Update TCriteria Set Detail = '๒.๗๑ - ๓.๐๐', TMin = 2.71, TMax = 3, DelFlag = 0 Where TcriteriaID = '8b7b8f2e-cad2-4b76-b18b-d0066192b40a'

			-----------4.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๒.๓๙', TMin = 0, TMax = 2.39 Where TcriteriaID = 'cfe6e7f9-d797-45d3-97bf-384a7ea2288d'
			Update TCriteria Set Detail = '๒.๔๐ - ๒.๙๙', TMin = 2.4, TMax = 2.99 Where TcriteriaID = '8c907257-17c1-45ed-a605-34721f5d1c5e'
			Update TCriteria Set Detail = '๓.๐๐ - ๓.๕๙', TMin = 3, TMax = 3.59 Where TcriteriaID = '5319e303-bff3-4ae9-9b2d-5138a43aa3bd'
			Update TCriteria Set Detail = '๓.๖๐ - ๓.๗๙', TMin = 3.6, TMax = 3.79, Translation = N'ดีมาก' Where TcriteriaID = '05a882f1-b133-4131-ad72-43cbc4d932cb'
			Update TCriteria Set Detail = '๓.๘๐ - ๔.๐๐', TMin = 3.8, TMax = 4, DelFlag = 0 Where TcriteriaID = 'fee73c78-23c3-4590-9fe4-08c98f72d1cd'

			-----------5.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๒.๐๐', TMin = 0, TMax = 2 Where TcriteriaID = 'a810252f-9bb6-48a7-b610-dc7a86996451'
			Update TCriteria Set Detail = '๒.๐๑ - ๓.๐๐', TMin = 2.01, TMax = 3 Where TcriteriaID = 'ecb48ab5-37ad-4ad0-b8ff-0fffefa8a3b3'
			Update TCriteria Set Detail = '๓.๐๑ - ๔.๐๐', TMin = 3.01, TMax = 4 Where TcriteriaID = 'af07711a-3896-4e93-9794-4c27b670acbf'
			Update TCriteria Set Detail = '๔.๐๑ - ๔.๕๐', TMin = 4.01, TMax = 4.5, Translation = N'ดีมาก' Where TcriteriaID = 'f4a8dcb9-7687-4f2c-9741-f2f8f1da694b'
			Update TCriteria Set Detail = '๔.๕๑ - ๕.๐๐', TMin = 4.51, TMax = 5, DelFlag = 0 Where TcriteriaID = 'aeb0b92f-8949-47d0-99cd-af3980734f21'

			-----------5.0 (N2)
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๐๐', TMin = 0, TMax = 1 Where TcriteriaID = '9A480D12-7160-4E72-B8AE-C9E9A663EBD4'
			Update TCriteria Set Detail = '๑.๐๑ - ๒.๐๐', TMin = 1.01, TMax = 2 Where TcriteriaID = 'E855AD6C-F412-4796-8C22-CF0587501079'
			Update TCriteria Set Detail = '๒.๐๑ - ๓.๐๐', TMin = 2.01, TMax = 3 Where TcriteriaID = '6163F6D7-70E3-4CAD-9DA6-77B7C9ABB5D5'
			Update TCriteria Set Detail = '๓.๐๑ - ๔.๐๐', TMin = 3.01, TMax = 4 Where TcriteriaID = '98C64437-9C98-44C8-A25F-880D62937C97'
			Update TCriteria Set Detail = '๔.๐๑ - ๕.๐๐', TMin = 4.01, TMax = 5 Where TcriteriaID = '5062F4F5-AE1E-4570-918A-A78C1F21E10E'

			-----------10.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๕.๙๙', TMin = 0, TMax = 5.99 Where TcriteriaID = 'c2c6d92d-e887-4bf0-885c-ca8bee4e807f'
			Update TCriteria Set Detail = '๖.๐๐ - ๗.๔๙', TMin = 6, TMax = 7.49 Where TcriteriaID = 'e0424d8a-e013-4482-895b-f0e8f4c52b12'
			Update TCriteria Set Detail = '๗.๕๐ - ๘.๙๙', TMin = 7.5, TMax = 8.99 Where TcriteriaID = 'b3f28c05-5d4d-43fb-9284-a84117a4c566'
			Update TCriteria Set Detail = '๙.๐๐ - ๙.๔๙', TMin = 9, TMax = 9.49, Translation = N'ดีมาก' Where TcriteriaID = '5f4e7061-4705-42b4-be20-01f144f08d5e'
			Update TCriteria Set Detail = '๙.๕๐ - ๑๐.๐๐', TMin = 9.5, TMax = 10, DelFlag = 0 Where TcriteriaID = '16b3f3e2-b8a1-481e-9661-5177aad558d3'

			-----------20.0
			Update TCriteria Set Detail = '๐.๐๐ - ๙.๙๙', TMin = 0, TMax = 9.99 Where TcriteriaID = '68927e0c-0400-4d0a-aec9-5bbebdedc891'
			Update TCriteria Set Detail = '๑๐.๐๐ - ๑๑.๙๙', TMin = 10, TMax = 11.99 Where TcriteriaID = '8f1c8c9b-b0bf-43e3-98df-4e75dcf3a098'
			Update TCriteria Set Detail = '๑๒.๐๐ - ๑๔.๙๙', TMin = 12, TMax = 14.99 Where TcriteriaID = '5e989d3b-1f19-437e-aab3-db1af0d6953f'
			Update TCriteria Set Detail = '๑๕.๐๐ - ๑๗.๙๙', TMin = 15, TMax = 17.99, Translation = N'ดีมาก' Where TcriteriaID = '2c3771cc-ef05-4448-be15-a51215e11e89'
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๐.๐๐', TMin = 18, TMax = 20, DelFlag = 0 Where TcriteriaID = 'e49d9c94-22f6-4c8a-9a5c-32fcdbe149a3'

			-----------50.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๒๙.๙๙', TMin = 0, TMax = 29.99 Where TcriteriaID = '0e4d3521-401d-408f-8f2f-d69a509a2117'
			Update TCriteria Set Detail = '๓๐.๐๐ - ๓๗.๔๙', TMin = 30, TMax = 37.49 Where TcriteriaID = '32d76bf4-7e87-4575-910c-92761b2da74d'
			Update TCriteria Set Detail = '๓๗.๕๐ - ๔๔.๙๙', TMin = 37.5, TMax = 44.99 Where TcriteriaID = '7722765c-3e54-42a4-b209-5cafe57cc7b2'
			Update TCriteria Set Detail = '๔๕.๐๐ - ๔๗.๔๙', TMin = 45, TMax = 47.49, Translation = N'ดีมาก' Where TcriteriaID = 'bcc684de-202a-44ae-948e-d7dbb78f572e'
			Update TCriteria Set Detail = '๔๗.๕๐ - ๕๐.๐๐', TMin = 47.5, TMax = 50, DelFlag = 0 Where TcriteriaID = '48c0564e-b8d8-4963-8ab1-4910057944a6'

			-----------100.0 (N)
			Update TCriteria Set Detail = '๐.๐๐ - ๕๙.๙๙', TMin = 0, TMax = 59.99 Where TcriteriaID = '69c5bc62-b443-48c5-9a46-cd1e4df27003'
			Update TCriteria Set Detail = '๖๐.๐๐ - ๗๔.๙๙', TMin = 60, TMax = 74.99 Where TcriteriaID = '59291c4d-2eec-4ea2-8a2d-922b6a34fa4c'
			Update TCriteria Set Detail = '๗๕.๐๐ - ๘๙.๙๙', TMin = 75, TMax = 89.99 Where TcriteriaID = 'e277de33-3d86-4f09-b7b8-f3c97d585cb5'
			Update TCriteria Set Detail = '๙๐.๐๐ - ๙๔.๙๙', TMin = 90, TMax = 94.99, Translation = N'ดีมาก' Where TcriteriaID = 'facf0afb-b6f4-4675-9c47-774eb1d1b8af'
			Update TCriteria Set Detail = '๙๕.๐๐ - ๑๐๐.๐๐', TMin = 95, TMax = 100, DelFlag = 0 Where TcriteriaID = '6ecc7610-19d8-47cc-b728-15efd128fe21'
		End

		IF @RateType = 3
		Begin
			----------------แบบใหม่ 4 มาตรฐาน---------------------
			-----------0.5
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๒๔', TMin = 0, TMax = 0.24 Where TcriteriaID = '990f80da-c07c-41b5-ac1f-5e8a45e5bb0e'
			Update TCriteria Set Detail = '๐.๒๕ - ๐.๒๙', TMin = 0.25, TMax = 0.29 Where TcriteriaID = '50a812bd-f27e-4259-8946-004c1044fabf'
			Update TCriteria Set Detail = '๐.๓๐ - ๐.๓๔', TMin = 0.3, TMax = 0.34 Where TcriteriaID = '573fcdb2-0f1d-42d4-95a9-2ce3b2dd5fd4'
			Update TCriteria Set Detail = '๐.๓๕ - ๐.๕๐', TMin = 0.35, TMax = 0.5, Translation = N'ดีเยี่ยม' Where TcriteriaID = 'de5b6ed8-a080-468d-8cca-a302d0f5e73b'
			Update TCriteria Set Detail = '๐.๔๐ - ๐.๕๐', TMin = 0.4, TMax = 0.5, DelFlag = 1 Where TcriteriaID = 'db2bedf7-9cf8-4495-a3b8-9ca572bd1f55'

			-----------1.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๔๙', TMin = 0, TMax = 0.49 Where TcriteriaID = '523325f5-5610-4074-8788-eeedf6b35e6c'
			Update TCriteria Set Detail = '๐.๕๐ - ๐.๕๙', TMin = 0.5, TMax = 0.59 Where TcriteriaID = '9a340d20-7c31-4955-a3c7-7fe5eb0a6be3'
			Update TCriteria Set Detail = '๐.๖๐ - ๐.๖๙', TMin = 0.6, TMax = 0.69 Where TcriteriaID = '6344b6e3-cfa7-4fdd-8b71-34470dd661ab'
			Update TCriteria Set Detail = '๐.๗๐ - ๐.๗๙', TMin = 0.7, TMax = 1, Translation = N'ดีเยี่ยม' Where TcriteriaID = '98d32855-a9ac-444e-a3f2-558961400149'
			Update TCriteria Set Detail = '๐.๘๐ - ๑.๐๐', TMin = 0.8, TMax = 1, DelFlag = 1 Where TcriteriaID = '138fb5bd-2a19-4a09-855e-43205d18ca7b'

			-----------2.0
			Update TCriteria Set Detail = '๐.๐๐ - ๐.๙๙', TMin = 0, TMax = 0.99 Where TcriteriaID = '944cee00-2cea-400a-b5dc-081cf16e83a6'
			Update TCriteria Set Detail = '๑.๐๐ - ๑.๑๙', TMin = 1.0, TMax = 1.19 Where TcriteriaID = '6469c8d5-6542-471e-a31a-9c1b1681110b'
			Update TCriteria Set Detail = '๑.๒๐ - ๑.๓๙', TMin = 1.2, TMax = 1.39 Where TcriteriaID = 'fb08528d-fb28-4382-931d-cbbf28cf6b14'
			Update TCriteria Set Detail = '๑.๔๐ - ๑.๕๙', TMin = 1.4, TMax = 2, Translation = N'ดีเยี่ยม' Where TcriteriaID = '970f9571-a05c-4a6e-9270-e3b8b6346832'
			Update TCriteria Set Detail = '๑.๖๐ - ๒.๐๐', TMin = 1.6, TMax = 2, DelFlag = 1 Where TcriteriaID = 'e1923d69-300a-49e8-b2dd-558a1c9778a0'

			-----------3.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๔๙', TMin = 0, TMax = 1.49 Where TcriteriaID = 'e68d09a7-053d-4812-a5e2-5019600fc59a'
			Update TCriteria Set Detail = '๑.๕๐ - ๑.๗๙', TMin = 1.5, TMax = 1.79 Where TcriteriaID = 'c40a7ddb-5bf7-45f1-8339-bf23765d686d'
			Update TCriteria Set Detail = '๑.๘๐ - ๒.๐๙', TMin = 1.8, TMax = 2.09 Where TcriteriaID = 'a1c46154-02c8-47da-9c07-26d2fdd36eee'
			Update TCriteria Set Detail = '๒.๑๐ - ๒.๓๙', TMin = 2.1, TMax = 3, Translation = N'ดีเยี่ยม' Where TcriteriaID = '948736f6-16c6-4e50-96dd-f038ff34ff83'
			Update TCriteria Set Detail = '๒.๔๐ - ๓.๐๐', TMin = 2.4, TMax = 3, DelFlag = 1 Where TcriteriaID = '8b7b8f2e-cad2-4b76-b18b-d0066192b40a'

			-----------4.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑.๙๙', TMin = 0, TMax = 1.99 Where TcriteriaID = 'cfe6e7f9-d797-45d3-97bf-384a7ea2288d'
			Update TCriteria Set Detail = '๒.๐๐ - ๒.๓๙', TMin = 2, TMax = 2.39 Where TcriteriaID = '8c907257-17c1-45ed-a605-34721f5d1c5e'
			Update TCriteria Set Detail = '๒.๔๐ - ๒.๗๙', TMin = 2.4, TMax = 2.79 Where TcriteriaID = '5319e303-bff3-4ae9-9b2d-5138a43aa3bd'
			Update TCriteria Set Detail = '๒.๘๐ - ๓.๑๙', TMin = 2.8, TMax = 4, Translation = N'ดีเยี่ยม' Where TcriteriaID = '05a882f1-b133-4131-ad72-43cbc4d932cb'
			Update TCriteria Set Detail = '๓.๒๐ - ๔.๐๐', TMin = 3.2, TMax = 4, DelFlag = 1 Where TcriteriaID = 'fee73c78-23c3-4590-9fe4-08c98f72d1cd'

			-----------5.0
			Update TCriteria Set Detail = '๐.๐๐ - ๒.๔๙', TMin = 0, TMax = 2.49 Where TcriteriaID = 'a810252f-9bb6-48a7-b610-dc7a86996451'
			Update TCriteria Set Detail = '๒.๕๐ - ๒.๙๙', TMin = 2.5, TMax = 2.99 Where TcriteriaID = 'ecb48ab5-37ad-4ad0-b8ff-0fffefa8a3b3'
			Update TCriteria Set Detail = '๓.๐๐ - ๓.๔๙', TMin = 3, TMax = 3.49 Where TcriteriaID = 'af07711a-3896-4e93-9794-4c27b670acbf'
			Update TCriteria Set Detail = '๓.๕๐ - ๓.๙๙', TMin = 3.5, TMax = 5, Translation = N'ดีเยี่ยม' Where TcriteriaID = 'f4a8dcb9-7687-4f2c-9741-f2f8f1da694b'
			Update TCriteria Set Detail = '๔.๐๐ - ๕.๐๐', TMin = 4, TMax = 5, DelFlag = 1 Where TcriteriaID = 'aeb0b92f-8949-47d0-99cd-af3980734f21'

			-----------10.0
			Update TCriteria Set Detail = '๐.๐๐ - ๔.๙๙', TMin = 0, TMax = 4.99 Where TcriteriaID = 'c2c6d92d-e887-4bf0-885c-ca8bee4e807f'
			Update TCriteria Set Detail = '๕.๐๐ - ๕.๙๙', TMin = 5, TMax = 5.99 Where TcriteriaID = 'e0424d8a-e013-4482-895b-f0e8f4c52b12'
			Update TCriteria Set Detail = '๖.๐๐ - ๖.๙๙', TMin = 6, TMax = 6.99 Where TcriteriaID = 'b3f28c05-5d4d-43fb-9284-a84117a4c566'
			Update TCriteria Set Detail = '๗.๐๐ - ๗.๙๙', TMin = 7, TMax = 10, Translation = N'ดีเยี่ยม' Where TcriteriaID = '5f4e7061-4705-42b4-be20-01f144f08d5e'
			Update TCriteria Set Detail = '๘.๐๐ - ๑๐.๐๐', TMin = 8, TMax = 10, DelFlag = 1 Where TcriteriaID = '16b3f3e2-b8a1-481e-9661-5177aad558d3'

			-----------20.0
			Update TCriteria Set Detail = '๐.๐๐ - ๙.๙๙', TMin = 0, TMax = 9.99 Where TcriteriaID = '68927e0c-0400-4d0a-aec9-5bbebdedc891'
			Update TCriteria Set Detail = '๑๐.๐๐ - ๑๑.๙๙', TMin = 10, TMax = 11.99 Where TcriteriaID = '8f1c8c9b-b0bf-43e3-98df-4e75dcf3a098'
			Update TCriteria Set Detail = '๑๒.๐๐ - ๑๔.๙๙', TMin = 12, TMax = 14.99 Where TcriteriaID = '5e989d3b-1f19-437e-aab3-db1af0d6953f'
			Update TCriteria Set Detail = '๑๕.๐๐ - ๑๗.๙๙', TMin = 15, TMax = 20, Translation = N'ดีเยี่ยม' Where TcriteriaID = '2c3771cc-ef05-4448-be15-a51215e11e89'
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๐.๐๐', TMin = 18, TMax = 20, DelFlag = 1 Where TcriteriaID = 'e49d9c94-22f6-4c8a-9a5c-32fcdbe149a3'

			-----------30.0
			Update TCriteria Set Detail = '๐.๐๐ - ๑๔.๙๙', TMin = 0, TMax = 14.99 Where TcriteriaID = 'b930e376-717b-4f50-bc69-803f88ff6402'
			Update TCriteria Set Detail = '๑๕.๐๐ - ๑๗.๙๙', TMin = 15, TMax = 17.99 Where TcriteriaID = '90983ed4-0799-4ca1-8145-a3b007a53a69'
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๐.๙๙', TMin = 18, TMax = 20.99 Where TcriteriaID = 'f497f305-8316-4d54-bcc8-2da0dc4fd9be'
			Update TCriteria Set Detail = '๒๑.๐๐ - ๒๓.๙๙', TMin = 21, TMax = 30, Translation = N'ดีเยี่ยม' Where TcriteriaID = '6c3191d9-13ab-4bfb-bddb-dc50623b4c3a'
			Update TCriteria Set Detail = '๒๔.๐๐ - ๓๐.๐๐', TMin = 24, TMax = 30, DelFlag = 1 Where TcriteriaID = 'f7818b1f-6b6b-46fc-9611-169c481e2c4d'

			-----------50.0
			Update TCriteria Set Detail = '๐.๐๐ - ๒๔.๙๙', TMin = 0, TMax = 24.99 Where TcriteriaID = '0e4d3521-401d-408f-8f2f-d69a509a2117'
			Update TCriteria Set Detail = '๒๕.๐๐ - ๒๙.๙๙', TMin = 25, TMax = 29.99 Where TcriteriaID = '32d76bf4-7e87-4575-910c-92761b2da74d'
			Update TCriteria Set Detail = '๓๐.๐๐ - ๓๔.๙๙', TMin = 30, TMax = 34.99 Where TcriteriaID = '7722765c-3e54-42a4-b209-5cafe57cc7b2'
			Update TCriteria Set Detail = '๓๕.๐๐ - ๓๙.๙๙', TMin = 35, TMax = 50, Translation = N'ดีเยี่ยม' Where TcriteriaID = 'bcc684de-202a-44ae-948e-d7dbb78f572e'
			Update TCriteria Set Detail = '๔๐.๐๐ - ๕๐.๐๐', TMin = 40, TMax = 50, DelFlag = 1 Where TcriteriaID = '48c0564e-b8d8-4963-8ab1-4910057944a6'

			-----------100.0
			Update TCriteria Set Detail = '๐.๐๐ - ๔๙.๙๙', TMin = 0, TMax = 49.99 Where TcriteriaID = '69c5bc62-b443-48c5-9a46-cd1e4df27003'
			Update TCriteria Set Detail = '๕๐.๐๐ - ๕๙.๙๙', TMin = 50, TMax = 59.99 Where TcriteriaID = '59291c4d-2eec-4ea2-8a2d-922b6a34fa4c'
			Update TCriteria Set Detail = '๖๐.๐๐ - ๖๙.๙๙', TMin = 60, TMax = 69.99 Where TcriteriaID = 'e277de33-3d86-4f09-b7b8-f3c97d585cb5'
			Update TCriteria Set Detail = '๗๐.๐๐ - ๗๙.๙๙', TMin = 70, TMax = 100, Translation = N'ดีเยี่ยม' Where TcriteriaID = 'facf0afb-b6f4-4675-9c47-774eb1d1b8af'
			Update TCriteria Set Detail = '๘๐.๐๐ - ๑๐๐.๐๐', TMin = 80, TMax = 100, DelFlag = 1 Where TcriteriaID = '6ecc7610-19d8-47cc-b728-15efd128fe21'
		End
	END


---------------------- v 11.3.0.21 --------------------------
 Go
--เพิ่มฟิวผลผลิตของหน่วยงาน เชิงปริมาณ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MainActivity') And Name = 'aTarget')
Begin
	alter table MainActivity add aTarget nVarchar(1000)
End

 Go
--เพิ่มฟิวผลผลิตของหน่วยงาน เชิงคุณภาพ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MainActivity') And Name = 'aTarget2')
Begin
	alter table MainActivity add aTarget2 nVarchar(1000)
End

---------------------- v 11.3.0.24 ---------------------------
Go
----------ลบ StoreProcedure เมนูวัตถุประสงค์เชิงกลยุทธ์
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuStrategicObjectives')
Begin
	DROP PROCEDURE ckMenuStrategicObjectives
End

Go
--เพิ่มฟิวตัวเช็ควัตถุประสงค์เชิงกลยุทธ์
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckStrategicObjectives')
Begin
	alter table MR_School add ckStrategicObjectives bit
End

Go
----------- เพิ่ม Table StrategicObjectives วัตถุประสงค์เชิงกลยุทธ์ ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('StrategicObjectives'))
Begin
	CREATE TABLE [dbo].[StrategicObjectives](
		[StrategicObjectivesCode] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[StrategicObjectivesName] [nvarchar](300) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_StrategicObjectives] PRIMARY KEY CLUSTERED 
	(
		[StrategicObjectivesCode] ASC
	)) ON [PRIMARY]
End

Go
----------- เพิ่ม Table dtStrategicObjectives วัตถุประสงค์เชิงกลยุทธ์------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtStrategicObjectives'))
Begin
	CREATE TABLE [dbo].[dtStrategicObjectives](
		[ProjectsCode] [nvarchar](50) NULL,
		[StrategicObjectivesCode] [nvarchar](50) NULL
	) ON [PRIMARY]
End

Go
--เพิ่ม Store เมนูวัตถุประสงค์เชิงกลยุทธ์
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuStrategicObjectives 
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '15E9D552-583F-4F4D-A190-840AA87A007C'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '15E9D552-583F-4F4D-A190-840AA87A007C'
	End
END

Go
--เพิ่มเมนูวัตถุประสงค์เชิงกลยุทธ์
If Not Exists(Select * From MySubMenu Where MySubMenuID = '15E9D552-583F-4F4D-A190-840AA87A007C')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('15E9D552-583F-4F4D-A190-840AA87A007C', N'วัตถุประสงค์เชิงกลยุทธ์', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 14, 'MasterData/StrategicObjectives.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S42.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('15E9D552-583F-4F4D-A190-840AA87A007C', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('15E9D552-583F-4F4D-A190-840AA87A007C', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('15E9D552-583F-4F4D-A190-840AA87A007C', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('15E9D552-583F-4F4D-A190-840AA87A007C', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
Update MR_School Set ckStrategicObjectives = 0 Where ckStrategicObjectives Is Null

------------------V 11.3.0.27 ------------------------------------------------------------
Go
--เพิ่มข้อมูลวัตถุประสงค์เชิงกลยุทธ์
If Not Exists(Select * From StrategicObjectives Where StudyYear = '2561')
Begin
	INSERT INTO StrategicObjectives (StrategicObjectivesCode, StudyYear, StrategicObjectivesName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('129046DD-BC7C-4052-94EF-F9C27FEDD1EE', '2561', N'เพื่อพัฒนาผู้บริหารให้มีคุณภาพตามมาตรฐาน  ระบบสารสนเทศเพื่อบริหารการศึกษา', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067');

	INSERT INTO StrategicObjectives (StrategicObjectivesCode, StudyYear, StrategicObjectivesName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('59D18B93-E62E-45D2-8556-79606D24C94D', '2561', N'โรงเรียนมีการบริหารจัดการคุณภาพตามขั้นตอนของระบบสารสนเทศเพื่อบริหารการศึกษา', 2, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067');

	INSERT INTO StrategicObjectives (StrategicObjectivesCode, StudyYear, StrategicObjectivesName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('8F422302-F1BC-464E-B698-19C4607EB6AB', '2561', N'โรงเรียนจัดหาปัจจัยพื้นฐานให้นักเรียนตามมาตรฐานสากล', 3, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067');

	INSERT INTO StrategicObjectives (StrategicObjectivesCode, StudyYear, StrategicObjectivesName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('80316322-D8E6-4677-81EA-E96AB3FDD490', '2561', N'โรงเรียนจัดหลักสูตรเทียบเคียงมาตรฐานสากล  มีการจัดกระบวนการเรียนรู้โดยใช้ระบบห้องเรียนคุณภาพและใช้ระบบการวัดและประเมินผลแบบมาตรฐานสากล', 4, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067');

	INSERT INTO StrategicObjectives (StrategicObjectivesCode, StudyYear, StrategicObjectivesName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('DB59D970-0C37-485D-8366-5F4B32DB422F', '2561', N'เพื่อเพิ่มการสื่อสารโยงการใช้ภาษาต่างประเทศ  การใช้สื่ออิเล็กทรอนิกส์หรือตำราเรียนภาษาต่างประเทศของครูในการจัดการเรียนการสอน  และแลกเปลี่ยนเรียนรู้ประสบการณ์กับนานาชาติได้', 5, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067');

	INSERT INTO StrategicObjectives (StrategicObjectivesCode, StudyYear, StrategicObjectivesName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('13007C7D-9956-4F84-A480-3342D076F6D8', '2561', N'โรงเรียนมีการจัดทำวิจัยและพัฒนาการจัดการศึกษา  และใช้ผลการวิจัยเพื่อยกระดับคุณภาพการศึกษาเทียบเคียงมาตรฐานสากล', 6, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067');

	INSERT INTO StrategicObjectives (StrategicObjectivesCode, StudyYear, StrategicObjectivesName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('2FDA1D1B-5190-42D3-A9D1-F3EFFD6D755C', '2561', N'เพื่อให้นักเรียนมีผลสัมฤทธิ์ทางการเรียนสูงขึ้น สามารถศึกษาต่อในระดับอุดมศึกษาทั้งในและต่างประเทศตลอดจนใช้ความถนัดเฉพาะทางไปแข่งขันในประเทศระดับชาติและนานาชาติได้', 7, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067');

	INSERT INTO StrategicObjectives (StrategicObjectivesCode, StudyYear, StrategicObjectivesName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('49DBFB15-B468-47A8-853B-F29C3D07926B', '2561', N'นักเรียนสามารถใช้ภาษาไทย  ภาษาอังกฤษ  ภาษาจีนและญี่ปุ่นในการสื่อสารได้ดี', 8, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067');

	INSERT INTO StrategicObjectives (StrategicObjectivesCode, StudyYear, StrategicObjectivesName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('90A284E1-4DB8-400A-B812-D2EF4B6BFEB2', '2561', N'เพื่อให้นักเรียนใช้กรอบความคิด  วิเคราะห์  สร้างสรรค์ผลงานเพื่อตนเอง  ประเทศชาติและสังคมโลกได้', 9, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067');

	INSERT INTO StrategicObjectives (StrategicObjectivesCode, StudyYear, StrategicObjectivesName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('0385BF5F-7CA0-41E4-A589-406D2B7FAACC', '2561', N'นักเรียนสามารถนำเทคโนโลยีมาใช้ในการผลิตผลงาน  การเผยแพร่  แลกเปลี่ยน  เรียนรู้และเข้าแข่งขันในประเทศ  ระดับชาติและนานาชาติได้', 10, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067');

	INSERT INTO StrategicObjectives (StrategicObjectivesCode, StudyYear, StrategicObjectivesName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('44A008ED-A6F8-4256-9C1C-DC09256BA3FB', '2561', N'นักเรียนมีคุณลักษณะอันที่พึงประสงค์', 11, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067');

	INSERT INTO StrategicObjectives (StrategicObjectivesCode, StudyYear, StrategicObjectivesName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('CADF6E87-519B-491C-BD5C-09E13EE82BC7', '2561', N'เพื่อให้ผู้เรียนพร้อมรับกระแสโลกาภิวัฒน์  สามารถจัดการสถานการณ์ต่าง ๆ  ในกรอบของความเป็น  พลเมืองดี  รับผิดชอบต่อประเทศชาติและสังคมโลกได้', 12, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067');

	INSERT INTO StrategicObjectives (StrategicObjectivesCode, StudyYear, StrategicObjectivesName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('4A9A8BCD-31FF-43BB-B8B8-C070C88DABEA', '2561', N'เพื่อให้นักเรียน  ครู  มีการแลกเปลี่ยนเรียนรู้กับภาคีเครือข่ายอุปถัมภ์ในระดับท้องถิ่น  ภูมิภาค  ประเทศ  และระหว่างประเทศ', 13, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067');

	INSERT INTO StrategicObjectives (StrategicObjectivesCode, StudyYear, StrategicObjectivesName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('52FF51FE-6CB6-49C4-9D4F-777EAE49DED1', '2561', N'เพื่อพัฒนาคุณธรรม  จริยธรรมและสำนึกความเป็นชาติไทย', 14, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067');

	INSERT INTO StrategicObjectives (StrategicObjectivesCode, StudyYear, StrategicObjectivesName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('5A7696A4-3068-47A1-B87F-11631CEDED02', '2561', N'เพื่อพัฒนาทักษะการดำรงชีวิตตามวิถีปรัชญาของเศรษฐกิจพอเพียง', 15, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2017-10-03 10:28:53.067');
End

Go
--เพิ่มฟิว key word ผู้รับผิดชอบกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'KeyWordResponsibleActivity')
Begin
	alter table MR_School add KeyWordResponsibleActivity nVarchar(100)
End

Go
--เพิ่มฟิว key word ผู้เสนอกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'KeyWordProposeActivity')
Begin
	alter table MR_School add KeyWordProposeActivity nVarchar(100)
End

Go
--เพิ่มฟิว key word ผู้เห็นชอบกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'KeyWordApprovalActivity')
Begin
	alter table MR_School add KeyWordApprovalActivity nVarchar(100)
End

Go
--เพิ่มฟิว key word ผู้เห็นชอบกิจกรรม2
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'KeyWordApproval2Activity')
Begin
	alter table MR_School add KeyWordApproval2Activity nVarchar(100)
End

Go
Update MR_School Set KeyWordResponsibleActivity = N'ผู้รับผิดชอบกิจกรรม' Where KeyWordResponsibleActivity Is Null
Go
Update MR_School Set KeyWordProposeActivity = N'ผู้เสนอกิจกรรม' Where KeyWordProposeActivity Is Null
Go
Update MR_School Set KeyWordApprovalActivity = N'ผู้เห็นชอบกิจกรรม' Where KeyWordApprovalActivity Is Null
Go
Update MR_School Set KeyWordApproval2Activity = N'ผู้เห็นชอบกิจกรรมที่ 2' Where KeyWordApproval2Activity Is Null


------------------------------------------------------------
------------------------v 11.3.0.36-------------------------

If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'CloseAcDate')
Begin
	alter table Activity add CloseAcDate datetime
End

-------------------------------------------------------------
-------------------------v 11.3.0.41-------------------------
Go
----------- เพิ่ม Table DeputyDirector  รองผู้อำนวยการโรงเรียน ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('DeputyDirector'))
Begin
	CREATE TABLE [dbo].[DeputyDirector](
		[DeputyDirectorID] [nvarchar](50) NOT NULL,
		[DeputyDirectorName] [nvarchar](100) NULL,
		[DeputyDirectorPosition] [nvarchar](100) NULL,
		[Sort] [int] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_DeputyDirector] PRIMARY KEY CLUSTERED 
	(
		[DeputyDirectorID] ASC
	)) ON [PRIMARY]
End













-----------------------------------------------------------------------
------------------------ทำเฉพาะ นครนนท์เท่านั้น--------------------------
Go
--เพิ่มฟิวตัวเช็คส่วนกลาง  Run ทั้งหมด
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('UserRole') And Name = 'IsCenter')
Begin
	alter table UserRole add IsCenter bit
End

Go
------------------------- เพิ่ม สิทธ์ส่วนกลาง Run ทั้งหมด ------------------------------
INSERT INTO UserRole (UserRoleID, UserRoleName, IsAdmin, IsAllDept, IsDept, IsManager, IsHeadDept, IsCenter, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
VALUES ('51853CD9-247C-4CDD-B6C4-92639B42B9B3', 'ส่วนกลาง', 1, 1, 0, 0, 0, 1, 6, 0, '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A', '2016-10-31 11:00:00.000', '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A', '2016-10-31 11:00:00.000')

Go
--เพิ่มสิทธิ์เมนู ผลการประเมิน ณ ปัจจุบัน ให้ส่วนกลาง RUN เครือข่าย
If Exists(Select * From MySubMenu Where MySubMenuID = 'f167696e-3dbc-4f76-abf3-582c000ba6b6')
Begin
	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('f167696e-3dbc-4f76-abf3-582c000ba6b6', '51853CD9-247C-4CDD-B6C4-92639B42B9B3')
End

Go
Update UserRole Set IsCenter = 0 Where IsCenter Is Null

---เพิ่ม user ส่วนกลางนครนนทบุรี Run ทั้งหมด
Go
INSERT INTO Employee (EmpID, UserName, Pwd, EmpName, Email, Tel, SchoolID, DeptCode, UserRoleID, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, HideFlag)
VALUES ('8723000D-7C2D-48D5-985E-34E2CD3102E8', 'NakornnonCenter', '0YmYPomoknUXNLmGzSR1fg==', 'ส่วนกลาง นครนนทบุรี', '-', '-', '2761172b-06c4-450a-a8e7-ace3c8a49792', '0b2d8678-5b69-4667-8347-86234d25d311', '51853CD9-247C-4CDD-B6C4-92639B42B9B3', 0, '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A', '2016-10-31 11:00:00.000', '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A', '2016-10-31 11:00:00.000', 0)


select newid()
select * from Department
Select * from UserRole
Select * from Employee

