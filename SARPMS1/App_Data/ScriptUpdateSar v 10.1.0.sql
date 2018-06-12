-----------Script Update Ver 5.3.0 Build 2013-09-23------------------

-----------Table Config------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('Config'))
Begin
	CREATE TABLE [dbo].[Config](
		[Version] [nvarchar](15) NULL,
		[ProjectName] [nvarchar](500) NULL,
		[LastUpdate] [datetime] NULL,
	) ON [PRIMARY]

	INSERT INTO Config (Version, ProjectName, LastUpdate)
	VALUES ('5.3.0', 'ระบบจัดทำแผนอิงระบบประกัน', '2013-11-13 09:09:09.009')
End
Else
Begin
	Update Config Set Version = '5.3.0', LastUpdate = '2013-11-13 09:09:09.009'
End

------------------4.6.0--------------------------
--เพิ่มฟิวใส่โลโก้
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'LogoPath')
Begin
	alter table MR_School add LogoPath nvarchar(max)
End

--เพิ่มฟิวเปิด-ปิดระบบ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'IsCon')
Begin
	alter table MR_School add IsCon bit
	Update MR_School Set IsCon = 0
End

If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ConUser')
Begin
	alter table MR_School add ConUser nvarChar(50)
End

--เพิ่มฟิวใส่ปริมาณที่คาดหวัง กับปริมาณผลลัพธ์ที่ได้
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'VolumeExpect')
Begin
	alter table Activity add VolumeExpect float
End

If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'VolumeCan')
Begin
	alter table Activity add VolumeCan float
End 

------------------4.6.1--------------------------
--เพิ่มฟิวจังหวัด
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ProvinceID')
Begin
	alter table MR_School add ProvinceID nvarchar(50)
End

------------------4.6.10------------------------เพิ่มเมนูปฏิทินงานใหม่ 1 เมนู
If Not Exists(Select * From MySubMenu Where MySubMenuID = '1af59a2f-f41b-4ba2-bc3e-66da5e479110')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('1af59a2f-f41b-4ba2-bc3e-66da5e479110', 'ปฏิทินปฏิบัติงาน', '434de3e9-c4d5-4bed-9b00-c7603e4c335e', 19, 'MasterData/RptCalendar.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('1af59a2f-f41b-4ba2-bc3e-66da5e479110', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('1af59a2f-f41b-4ba2-bc3e-66da5e479110', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('1af59a2f-f41b-4ba2-bc3e-66da5e479110', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('1af59a2f-f41b-4ba2-bc3e-66da5e479110', '079c4976-49a8-4b30-83bf-3e13cbaa9382')

	Update MySubMenu Set Sort = 20 Where MySubMenuID = '45faeb03-ccef-422a-bd70-3800540f2b1d'
End

-----------------4.7.1--------------------------
--Update หมวดค่าใช้จ่าย
Update EntryCosts Set EntryCostsName = 'ค่าตอบแทน', Sort = 1 Where EntryCostsCode = '09b55eae-4334-4c0c-bab3-724dfb85e7f3'
Update EntryCosts Set EntryCostsName = 'ค่าใช้สอย', Sort = 2 Where EntryCostsCode = '32582770-d362-48f6-88c9-66b6dc6f0943'
Update EntryCosts Set EntryCostsName = 'ค่าวัสดุ', Sort = 3 Where EntryCostsCode = '4f4f26bf-8166-4aaa-b81e-2e5cf0428650'
Update EntryCosts Set EntryCostsName = 'ค่าสาธารณูปโภค', Sort = 4 Where EntryCostsCode = '60656f13-692f-4657-aabf-4a1a72c8a513'
Update EntryCosts Set EntryCostsName = 'ค่าครุภัณฑ์', Sort = 5 Where EntryCostsCode = '747476d1-8be6-4c9d-8898-35434d692551'
Update EntryCosts Set EntryCostsName = 'ค่าที่ดินและสิ่งก่อสร้าง', Sort = 6 Where EntryCostsCode = '7afcea8f-1cfa-4985-b554-20238bac36c7'
Update EntryCosts Set EntryCostsName = 'ค่าจ้างชั่วคราว', Sort = 7 Where EntryCostsCode = '7e9ccfea-e755-49d3-963c-a1708cebf95f'
Update EntryCosts Set EntryCostsName = 'รายจ่ายอื่น', Sort = 8 Where EntryCostsCode = 'aa61b8d5-ae23-4ce1-a3e9-9d74460b4b3b'

Update EntryCosts Set DelFlag = 1 Where EntryCostsCode = 'b403a0da-6b04-4635-a021-3fc556efeb53'
Update EntryCosts Set DelFlag = 1 Where EntryCostsCode = 'bc829f71-94e4-42db-be57-a02c5dfbc106'
Update EntryCosts Set DelFlag = 1 Where EntryCostsCode = 'c11b63fe-ce03-417d-be30-3eae185d904c'
Update EntryCosts Set DelFlag = 1 Where EntryCostsCode = 'cfac3d9e-0bd4-4f80-be01-7cc10344f0eb'
Update EntryCosts Set DelFlag = 1 Where EntryCostsCode = 'dca98d05-a8c8-4081-b7d0-867ac651a37c'
Update EntryCosts Set DelFlag = 1 Where EntryCostsCode = 'feb00d9a-84d8-409f-be91-9cd994f8dc0e'

--เพิ่มเมนูรายงานรายละเอียดการใช้จ่ายเงินใหม่ 1 เมนู
If Not Exists(Select * From MySubMenu Where MySubMenuID = '03CC3E0E-C42A-4C6F-82A2-3D6207906E32')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('03CC3E0E-C42A-4C6F-82A2-3D6207906E32', 'รายละเอียดแผนการใช้จ่ายเงิน', '434de3e9-c4d5-4bed-9b00-c7603e4c335e', 19, 'MasterData/ReportEntryCosts.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('03CC3E0E-C42A-4C6F-82A2-3D6207906E32', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('03CC3E0E-C42A-4C6F-82A2-3D6207906E32', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('03CC3E0E-C42A-4C6F-82A2-3D6207906E32', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('03CC3E0E-C42A-4C6F-82A2-3D6207906E32', '079c4976-49a8-4b30-83bf-3e13cbaa9382')

	Update MySubMenu Set Sort = 20 Where MySubMenuID = '1af59a2f-f41b-4ba2-bc3e-66da5e479110'
	Update MySubMenu Set Sort = 21 Where MySubMenuID = '45faeb03-ccef-422a-bd70-3800540f2b1d'
End

------------------4.7.4----------------------
--ขยายขนาด Column
alter table CostsDetail alter column ListName nvarchar(Max)
alter table CostsDetail alter column EntryCostsCode nvarchar(Max)
alter table ActivityCostsDetail alter column EntryCostsCode nvarchar(Max)

--เพิ่มฟิวเช็คลำดับการเบิกย่อย ก่อนหลัง
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ActivityDetail') And Name = 'Sort')
Begin
	alter table ActivityDetail add Sort Int
End

------------------4.8.0----------------------
--เพิ่มฟิวล์รูปภาพในเมนูหลัก และ เมนูย่อย
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MyMainMenu') And Name = 'ImgName')
Begin
	alter table MyMainMenu add ImgName nVarChar(10)
End

If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MySubMenu') And Name = 'ImgName')
Begin
	alter table MySubMenu add ImgName nVarChar(10)
End

--select 'Update MySubMenu Set ImgName = '''+ ImgName +''' 
--Where MySubMenuID = '''+ CAST(MySubMenuID as nvarchar(36))+''''
--from MySubMenu order by ImgName
									
Update MyMainMenu Set ImgName = 'M3.png' Where MyMainMenuID = '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4'
Update MyMainMenu Set ImgName = 'M9.png' Where MyMainMenuID = '434de3e9-c4d5-4bed-9b00-c7603e4c335e'
Update MyMainMenu Set ImgName = 'M6.png' Where MyMainMenuID = '6f38c3ab-4db5-4d5a-88f2-b4b7858464a9'
Update MyMainMenu Set ImgName = 'M3.png' Where MyMainMenuID = '7934c5b9-61e8-40bc-b0be-0ff20f1ee609'
Update MyMainMenu Set ImgName = 'M8.png' Where MyMainMenuID = '8de87893-6cd6-4900-968a-db0e8832d043'
Update MyMainMenu Set ImgName = 'M2.png' Where MyMainMenuID = 'dbf638f6-87ef-4e99-a18a-3992ee5fff87'
Update MyMainMenu Set ImgName = 'M7.png' Where MyMainMenuID = 'dd43213f-becd-4d63-85a3-f2d6936aa982'
								
Update MySubMenu Set ImgName = 'S0.png' Where MySubMenuID = 'ffd16c8e-2aff-42a8-a108-155ec70e21f1'
Update MySubMenu Set ImgName = 'S14.png' Where MySubMenuID = 'f5da1686-03c5-4b78-a99f-d06651ed8952'
Update MySubMenu Set ImgName = 'S0.png' Where MySubMenuID = 'f50f2444-488a-4067-8f0c-b48f91e7e067'
Update MySubMenu Set ImgName = 'S4.png' Where MySubMenuID = 'f167696e-3dbc-4f76-abf3-582c000ba6b6'
Update MySubMenu Set ImgName = 'S05.png' Where MySubMenuID = 'ef9780a7-3587-4818-b3dc-33c99b938985'
Update MySubMenu Set ImgName = 'S0.png' Where MySubMenuID = 'E8B4A7F9-6E68-498D-831D-D9EFCD04AE2D'
Update MySubMenu Set ImgName = 'S23.png' Where MySubMenuID = 'e83bed1b-431f-4969-a27e-e4ba7444c87e'
Update MySubMenu Set ImgName = 'S06.gif' Where MySubMenuID = 'dc6c772a-0fd7-4c51-a770-33fb17cb286b'
Update MySubMenu Set ImgName = 'S44.png' Where MySubMenuID = 'd81a3ef8-46b6-471c-8104-c871be9213fe'
Update MySubMenu Set ImgName = 'S42.png' Where MySubMenuID = 'd6bf4087-f7bc-4838-8928-dd81410e75db'
Update MySubMenu Set ImgName = 'S9.png' Where MySubMenuID = 'd6294e78-3e4d-4d4d-b84b-98f93aac52bc'
Update MySubMenu Set ImgName = 'S4.png' Where MySubMenuID = 'd544e82b-148c-4329-9fa6-67b279732445'
Update MySubMenu Set ImgName = 'S0.png' Where MySubMenuID = 'd326d46f-755f-4ef5-9a05-dcdba5b42de1'
Update MySubMenu Set ImgName = 'S0.png' Where MySubMenuID = 'ca469a20-0883-4da0-bf33-e9ab9b640f03'
Update MySubMenu Set ImgName = 'S05.png' Where MySubMenuID = 'c98ca0c1-40c7-49db-ae7b-e42cedd772b5'
Update MySubMenu Set ImgName = 'S32.png' Where MySubMenuID = 'be6cf047-27b5-4591-b334-42e9c0435d86'
Update MySubMenu Set ImgName = 'S0.png' Where MySubMenuID = 'bbf659c6-5eca-40fa-a6e3-71a6feaa1c8b'
Update MySubMenu Set ImgName = 'S53.png' Where MySubMenuID = 'b648c207-61dd-40bd-aff8-5a59673daf14'
Update MySubMenu Set ImgName = 'S0.png' Where MySubMenuID = 'b2c8b420-1b17-4688-8678-d06c91b2ecde'
Update MySubMenu Set ImgName = 'S07.png' Where MySubMenuID = 'b1d20c9f-c4de-4379-b342-b648293f4a91'
Update MySubMenu Set ImgName = 'S07.png' Where MySubMenuID = 'a0cde503-79ad-4794-b149-c153a95a502f'
Update MySubMenu Set ImgName = 'S12.png' Where MySubMenuID = '9e2e57a9-91f2-44b4-94b0-3ac5d8e7d2c1'
Update MySubMenu Set ImgName = 'S01.png' Where MySubMenuID = '9a81e35a-7219-4d01-aa22-e129dff62654'
Update MySubMenu Set ImgName = 'S5.png' Where MySubMenuID = '9a720139-2609-438a-8e37-4bcc2077d344'
Update MySubMenu Set ImgName = 'S1.png' Where MySubMenuID = '9944e5bb-50d8-4ca2-9693-aec4e53fd523'
Update MySubMenu Set ImgName = 'S21.png' Where MySubMenuID = '972d4dcd-a94c-4756-85d3-0c843f35d006'
Update MySubMenu Set ImgName = 'S09.png' Where MySubMenuID = '9513380c-a4b1-4096-9789-0ad701f0d0da'
Update MySubMenu Set ImgName = 'S08.gif' Where MySubMenuID = '927dce6c-ec37-4429-b02e-8842ee8ebccd'
Update MySubMenu Set ImgName = 'S07.gif' Where MySubMenuID = '91f8cd77-ea96-4d74-a3fe-04e8384737d1'
Update MySubMenu Set ImgName = 'S41.png' Where MySubMenuID = '8a9dd888-3cf2-4cde-8523-157321f09c1e'
Update MySubMenu Set ImgName = 'S0.png' Where MySubMenuID = '880f927f-26dc-495d-be46-504c21fe2279'
Update MySubMenu Set ImgName = 'S31.png' Where MySubMenuID = '7f3259c9-4d16-4dbc-909a-69a8aafaf2e0'
Update MySubMenu Set ImgName = 'S0.png' Where MySubMenuID = '77d0079e-95b5-4721-b1d2-b0aec13af6b5'
Update MySubMenu Set ImgName = 'S33.png' Where MySubMenuID = '74334f9f-14bc-4c18-9197-d3a7ac18def2'
Update MySubMenu Set ImgName = 'S06.gif' Where MySubMenuID = '6d42035f-1588-4b93-802d-b0682dc011fe'
Update MySubMenu Set ImgName = 'S42.png' Where MySubMenuID = '6997f371-50c4-48ee-9f96-c3c77eba7399'
Update MySubMenu Set ImgName = 'S43.png' Where MySubMenuID = '66f41bc5-fb42-4ebb-b64c-0c4289e2a4bc'
Update MySubMenu Set ImgName = 'S22.png' Where MySubMenuID = '52eea82d-489f-4ffa-9336-1a03153d47a4'
Update MySubMenu Set ImgName = 'S07.gif' Where MySubMenuID = '4e403690-8cb4-4f92-bfa2-dc2ea819953b'
Update MySubMenu Set ImgName = 'S9.png' Where MySubMenuID = '4d957aef-26ce-4d26-997d-1807acae5d48'
Update MySubMenu Set ImgName = 'S05.png' Where MySubMenuID = '4a74ae64-627a-46e9-98ba-d823fc58fedd'
Update MySubMenu Set ImgName = 'S11.png' Where MySubMenuID = '47bc8df6-5b12-4388-b795-83c0cc06f029'
Update MySubMenu Set ImgName = 'S0.png' Where MySubMenuID = '4789dc79-857d-4229-8e36-4c74f33ea210'
Update MySubMenu Set ImgName = 'S02.gif' Where MySubMenuID = '45faeb03-ccef-422a-bd70-3800540f2b1d'
Update MySubMenu Set ImgName = 'S51.png' Where MySubMenuID = '431ea9a5-3d1c-4d3d-a136-e931c2017c1f'
Update MySubMenu Set ImgName = 'S15.png' Where MySubMenuID = '3c7d3915-5b91-4b50-b00d-c4ad0c148665'
Update MySubMenu Set ImgName = 'S24.png' Where MySubMenuID = '335b21bf-6e00-43dc-a243-31abb26d532c'
Update MySubMenu Set ImgName = 'S41.png' Where MySubMenuID = '2d5f9e36-dc85-4e30-8894-1286653c954d'
Update MySubMenu Set ImgName = 'S0.png' Where MySubMenuID = '22342a9e-5d49-42c0-9b9e-25413234029c'
Update MySubMenu Set ImgName = 'S001.png' Where MySubMenuID = '21546c40-d0be-43ec-ae6b-b38f726b74c2'
Update MySubMenu Set ImgName = 'S13.png' Where MySubMenuID = '1c4f1d8b-c854-4d86-96e4-910d5af25519'
Update MySubMenu Set ImgName = 'S03.png' Where MySubMenuID = '1af59a2f-f41b-4ba2-bc3e-66da5e479110'
Update MySubMenu Set ImgName = 'S44.png' Where MySubMenuID = '1807103a-3fdb-424e-af62-cdb4b4701e18'
Update MySubMenu Set ImgName = 'S09.png' Where MySubMenuID = '0f5b8c7b-720d-400b-beed-becd59f84fc7'
Update MySubMenu Set ImgName = 'S0.png' Where MySubMenuID = '0bbbfd4f-ab83-44e8-a773-e31acf78481c'
Update MySubMenu Set ImgName = 'S0.png' Where MySubMenuID = '08b4fb3f-2ea8-43fc-8e0f-ab202e6180ab'
Update MySubMenu Set ImgName = 'S52.png' Where MySubMenuID = '0898fff2-3c00-4033-9b49-6ed897168e88'
Update MySubMenu Set ImgName = 'S43.png' Where MySubMenuID = '085eb349-5ea9-42da-b9a6-69fbcfc4cf64'
Update MySubMenu Set ImgName = 'S34.png' Where MySubMenuID = '075f0695-53cd-4886-9a13-72b8873c8137'
Update MySubMenu Set ImgName = 'S0.png' Where MySubMenuID = '04e2d93b-e003-4e38-ad52-bd999657c9b1'
Update MySubMenu Set ImgName = 'S05.png' Where MySubMenuID = '03CC3E0E-C42A-4C6F-82A2-3D6207906E32'
Update MySubMenu Set ImgName = 'S0.png' Where MySubMenuID = '0327c806-6da0-47ce-976f-16245c8848db'
Update MySubMenu Set ImgName = 'S0.png' Where MySubMenuID = '002f4ef2-1a6f-4ef3-a1e1-ccd2eb5901d8'

------------------4.9.0----------------------
--เพิ่มฟิวล์สีประจำโรงเรียน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'SchoolColor')
Begin
	alter table MR_School add SchoolColor nVarChar(100)
End

--เพิ่มฟิวล์เอกลักษณ์ กับ อัตลักษณ์
If Not Exists(Select * From Sys.Columns where Object_ID = Object_ID('MR_School') And Name = 'IdentityName2')
Begin
	alter table MR_School add IdentityName2 nVarChar(max)
End

If Not Exists(Select * From Sys.Columns where Object_ID = Object_ID('MR_School') And Name = 'iNameShow')
Begin
	alter table MR_School add iNameShow bit
End

If Not Exists(Select * From Sys.Columns where Object_ID = Object_ID('MR_School') And Name = 'iNameShow2')
Begin
	alter table MR_School add iNameShow2 bit
End

If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'IdentityName')
Begin
	alter table Activity add IdentityName nVarChar(max)
End

If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'IdentityName2')
Begin
	alter table Activity add IdentityName2 nVarChar(max)
End

Update MR_School Set iNameShow = 0 Where iNameShow Is Null
Update MR_School Set iNameShow2 = 0 Where iNameShow2 Is Null

--เพิ่มเมนูรายงานงานประจำตามโครงสร้างการบริหารโรงเรียนใหม่ 1 เมนู
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'F2B4CDBD-22BA-4FB1-9676-56869C71BA43')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('F2B4CDBD-22BA-4FB1-9676-56869C71BA43', 'งานประจำตามโครงสร้างการบริหารโรงเรียน', '434de3e9-c4d5-4bed-9b00-c7603e4c335e', 20, 'MasterData/ReportRoutine.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S07.gif')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('F2B4CDBD-22BA-4FB1-9676-56869C71BA43', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('F2B4CDBD-22BA-4FB1-9676-56869C71BA43', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('F2B4CDBD-22BA-4FB1-9676-56869C71BA43', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('F2B4CDBD-22BA-4FB1-9676-56869C71BA43', '079c4976-49a8-4b30-83bf-3e13cbaa9382')

	Update MySubMenu Set Sort = 21 Where MySubMenuID = '1af59a2f-f41b-4ba2-bc3e-66da5e479110'
	Update MySubMenu Set Sort = 22 Where MySubMenuID = '45faeb03-ccef-422a-bd70-3800540f2b1d'
End


--------------------4.10.0------------------
--เพิ่มเมนูรายงานงานประจำตามโครงสร้างการบริหารโรงเรียนใหม่ 1 เมนู
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'B7801973-9F71-44E5-91C0-12367123837F')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('B7801973-9F71-44E5-91C0-12367123837F', 'แบบสรุปการดำเนินงาน', '434de3e9-c4d5-4bed-9b00-c7603e4c335e', 21, 'MasterData/ReportResults.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S06.gif')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B7801973-9F71-44E5-91C0-12367123837F', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B7801973-9F71-44E5-91C0-12367123837F', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B7801973-9F71-44E5-91C0-12367123837F', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B7801973-9F71-44E5-91C0-12367123837F', '079c4976-49a8-4b30-83bf-3e13cbaa9382')

	Update MySubMenu Set Sort = 22 Where MySubMenuID = '1af59a2f-f41b-4ba2-bc3e-66da5e479110'
	Update MySubMenu Set Sort = 23 Where MySubMenuID = '45faeb03-ccef-422a-bd70-3800540f2b1d'
End

--11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111

--------------------4.10.1------------------
--เพิ่มฟิวเป้าหมาย
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'Goal')
Begin
	alter table Activity add Goal nvarchar(max)
End

--เพิ่มฟิวผลการดำเนินงาน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'Results')
Begin
	alter table Activity add Results nvarchar(max)
End

--------------------4.11.0------------------
--เพิ่มฟิวประเภทการประเมิน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Indicators2') And Name = 'RateType')
Begin
	alter table Indicators2 add RateType int
End

--------------------4.12.0------------------
--เพิ่มฟิวงบสำรอง
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Income') And Name = 'Reserve')
Begin
	alter table Income add Reserve float
End

--111111111111111111111111111111111111111111111111111111111111111111111111111111111111111



--22222222222222222222222222222222222222222222222222222222222222222222222222222222222222

--ย้ายเมนูตัดงบประมาณ
Update MySubMenu Set MyMainMenuID = '6f38c3ab-4db5-4d5a-88f2-b4b7858464a9' Where MySubMenuID = '1807103a-3fdb-424e-af62-cdb4b4701e18'
Update MySubMenu Set ImgName = 'S16.png' Where MySubMenuID = '1807103a-3fdb-424e-af62-cdb4b4701e18'

--แก้หน้าตัวชี้วัด
Update Indicators2 Set OffAll = 1 Where OffAll = 0

--222222222222222222222222222222222222222222222222222222222222222222222222222222222222



--33333333333333333333333333333333333333333333333333333333333333333333333333333333333

---------------------4.13.0--------------------------
--เพิ่ม Table EmpDept ให้ผู้ใช้  1 คน อยู่ได้หลายหน่วยงาน
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('EmpDept'))
Begin
	CREATE TABLE [dbo].[EmpDept](
		[EmpID] [nvarchar](50) NULL,
		[DeptCode] [nvarchar](50) NULL,
	) ON [PRIMARY]	

	INSERT INTO EmpDept (EmpID, DeptCode)
	Select EmpID, DeptCode From Employee Where DelFlag = 0
End

-----------Table SubDepartment------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('SubDepartment'))
Begin
	CREATE TABLE [dbo].[SubDepartment](
	[SubDeptCode] [nvarchar](50) NOT NULL,
	[DeptCode] [nvarchar](50) NULL,
	[SubDeptName] [nvarchar](150) NULL,
	[Sort] [int] NULL,
	[DelFlag] [bit] NULL,
	[CreateUser] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateUser] [nvarchar](50) NULL,
	[UpdateDate] [datetime] NULL,
	 CONSTRAINT [PK_SubDepartment] PRIMARY KEY CLUSTERED 
	(
		[SubDeptCode] ASC
	)) ON [PRIMARY]
End

-----------Table dtAcSubDept------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtAcSubDept'))
Begin
CREATE TABLE [dbo].[dtAcSubDept](
	[ActivityCode] [nvarchar](50) NULL,
	[SubDeptCode] [nvarchar](50) NULL
) ON [PRIMARY]
End

-----------Table ScoreGroup------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('ScoreGroup'))
Begin
	CREATE TABLE [dbo].[ScoreGroup](
	[ScoreGroupID] [nvarchar](50) NOT NULL,
	[ScoreGroupName] [nvarchar](100) NULL,
	[Sort] [int] NULL,
	CONSTRAINT [PK_ScoreGroup] PRIMARY KEY CLUSTERED 
	(
		[ScoreGroupID] ASC
	)) ON [PRIMARY]
End

-----------เพิ่มฟิวกลุ่มหมวดคะแนน----------------------
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('TCriteria') And Name = 'ScoreGroupID')
Begin
	alter table TCriteria add ScoreGroupID nvarchar(50)
End

-------------------เพิ่มฟิว ScoreGroupID ให้ ด้าน มาตรฐาน ตัวบ่งชี้-------------------
	If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Side') And Name = 'ScoreGroupID')
	Begin
		alter table Side add ScoreGroupID nVarChar(50)
	End

	If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Standard') And Name = 'ScoreGroupID')
	Begin
		alter table Standard add ScoreGroupID nVarChar(50)
	End

	If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Indicators') And Name = 'ScoreGroupID')
	Begin
		alter table Indicators add ScoreGroupID nVarChar(50)
	End
--33333333333333333333333333333333333333333333333333333333333333333333333333333333333333



--44444444444444444444444444444444444444444444444444444444444444444444444444444444444444
---------เพิ่มเมนูหน่วยงานย่อย
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'C9973F90-8A8A-43D4-8747-E0EC0D023A18')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('C9973F90-8A8A-43D4-8747-E0EC0D023A18', 'หน่วยงานย่อย', '7934c5b9-61e8-40bc-b0be-0ff20f1ee609', 3, 'Setting/SubDepartment.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S6.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('C9973F90-8A8A-43D4-8747-E0EC0D023A18', '869f7a68-dd78-4f03-9320-e28b76e219fc')
End

----------เพิ่มข้อมูลกลุ่มคะแนนใน Table----------------------------------
	--เพิ่มกลุ่มคะแนน 0.5 (1)
	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8')
	Begin
		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
		VALUES ('422A806A-D3F6-41B0-BBAA-C40CEB3E23B8', 'หมวดคะแนนเต็ม 0.5', 1)
	End

	--เพิ่มกลุ่มคะแนน 0.5 (2)
	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35')
	Begin
		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
		VALUES ('E2EF2D9F-7052-418E-8CE4-8E93525D5C35', 'หมวดคะแนนเต็ม 0.5 (2)', 2)
	End

	--เพิ่มกลุ่มคะแนน 1.0 (1)
	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
	Begin
		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
		VALUES ('F5A541C2-8F01-468E-B92A-3B2D03E0F9A3', 'หมวดคะแนนเต็ม 1.0', 3)
	End

	--เพิ่มกลุ่มคะแนน 1.0 (2)
	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7')
	Begin
		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
		VALUES ('25E2142B-3F11-48DF-8D66-681E6FDDC5E7', 'หมวดคะแนนเต็ม 1.0 (2)', 4)
	End

	--เพิ่มกลุ่มคะแนน 2.0 (1)
	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4')
	Begin
		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
		VALUES ('00EB2C36-B042-472F-BD5D-1DF7C57568C4', 'หมวดคะแนนเต็ม 2.0', 5)
	End

	--เพิ่มกลุ่มคะแนน 2.0 (2)
	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1')
	Begin
		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
		VALUES ('E82BB47C-6C65-409F-818E-6ADE319CA8A1', 'หมวดคะแนนเต็ม 2.0 (2)', 6)
	End

	--เพิ่มกลุ่มคะแนน 3.0
	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A')
	Begin
		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
		VALUES ('8203609C-DC86-4409-9CC8-89A8AC90674A', 'หมวดคะแนนเต็ม 3.0', 7)
	End

	--เพิ่มกลุ่มคะแนน 4.0
	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A')
	Begin
		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
		VALUES ('AA41533E-12C7-4D29-8320-3CCB797A550A', 'หมวดคะแนนเต็ม 4.0', 8)
	End

	--เพิ่มกลุ่มคะแนน 5.0 (1)
	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
	Begin
		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
		VALUES ('B434D787-CBAA-41E5-BA94-DDB60A8E3952', 'หมวดคะแนนเต็ม 5.0', 9)
	End

	--เพิ่มกลุ่มคะแนน 5.0 (2)
	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45')
	Begin
		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
		VALUES ('7211D888-9FDA-4691-AA80-13D38710AA45', 'หมวดคะแนนเต็ม 5.0 (2)', 10)
	End

	--เพิ่มกลุ่มคะแนน 10
	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61')
	Begin
		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
		VALUES ('3D9F922B-77D7-410E-8CC1-9BEA731E4F61', 'หมวดคะแนนเต็ม 10', 11)
	End

	--เพิ่มกลุ่มคะแนน 30
	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = '950E2A3C-5B5B-4A51-8613-4EC393A1F495')
	Begin
		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
		VALUES ('950E2A3C-5B5B-4A51-8613-4EC393A1F495', 'หมวดคะแนนเต็ม 30', 12)
	End

	--เพิ่มกลุ่มคะแนน 50
	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = '5D9C042C-A0AC-42DC-9DC6-20C4B601D127')
	Begin
		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
		VALUES ('5D9C042C-A0AC-42DC-9DC6-20C4B601D127', 'หมวดคะแนนเต็ม 50', 13)
	End

	--เพิ่มกลุ่มคะแนน 100
	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = '63B1FF9E-CD47-4C46-9B6D-9F14CEA6E0C0')
	Begin
		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
		VALUES ('63B1FF9E-CD47-4C46-9B6D-9F14CEA6E0C0', 'หมวดคะแนนเต็ม 100', 14)
	End

-----------------เพิ่มกลุ่มคะแนนให้ตารางต่าง ๆ-----------------------------
	--Update กลุ่มคะแนน 0.5 (1) ให้คะแนนเต็ม 0.5
	If Not Exists(Select * From TCriteria Where TCriteria = 0.5 And ScoreGroupID is not null)
	Begin
		Update TCriteria Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8' Where TCriteria = 0.5
	End

--	--เพิ่มกลุ่มคะแนน 0.5 (2)
--	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35')
--	Begin
--		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
--		VALUES ('E2EF2D9F-7052-418E-8CE4-8E93525D5C35', 'หมวดคะแนนเต็ม 0.5 (2)', 2)
--	End

	--Update กลุ่มคะแนน 1.0 (1) ให้คะแนนเต็ม 1
	If Not Exists(Select * From TCriteria Where TCriteria = 1 And ScoreGroupID is not null)
	Begin
		Update TCriteria Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3' Where TCriteria = 1
	End

--	--เพิ่มกลุ่มคะแนน 1.0 (2)
--	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7')
--	Begin
--		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
--		VALUES ('25E2142B-3F11-48DF-8D66-681E6FDDC5E7', 'หมวดคะแนนเต็ม 1.0 (2)', 4)
--	End

	--Update กลุ่มคะแนน 2.0 (1) ให้คะแนนเต็ม 2
	If Not Exists(Select * From TCriteria Where TCriteria = 2 And ScoreGroupID is not null)
	Begin
		Update TCriteria Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4' Where TCriteria = 2
	End

--	--เพิ่มกลุ่มคะแนน 2.0 (2)
--	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1')
--	Begin
--		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
--		VALUES ('E82BB47C-6C65-409F-818E-6ADE319CA8A1', 'หมวดคะแนนเต็ม 2.0 (2)', 6)
--	End

	--Update กลุ่มคะแนน 3.0 ให้คะแนนเต็ม 3
	If Not Exists(Select * From TCriteria Where TCriteria = 3 And ScoreGroupID is not null)
	Begin
		Update TCriteria Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A' Where TCriteria = 3
	End

	--Update กลุ่มคะแนน 4.0 ให้คะแนนเต็ม 4
	If Not Exists(Select * From TCriteria Where TCriteria = 4 And ScoreGroupID is not null)
	Begin
		Update TCriteria Set ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A' Where TCriteria = 4
	End

	--Update กลุ่มคะแนน 5.0 (1) ให้คะแนนเต็ม 5
	If Not Exists(Select * From TCriteria Where TCriteria = 5 And ScoreGroupID is not null)
	Begin
		Update TCriteria Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where TCriteria = 5
	End

--	--เพิ่มกลุ่มคะแนน 5.0 (2)
--	If Not Exists(Select * From ScoreGroup Where ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45')
--	Begin
--		INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort)
--		VALUES ('7211D888-9FDA-4691-AA80-13D38710AA45', 'หมวดคะแนนเต็ม 5.0 (2)', 10)
--	End

	--Update กลุ่มคะแนน 10 ให้คะแนนเต็ม 10
	If Not Exists(Select * From TCriteria Where TCriteria = 10 And ScoreGroupID is not null)
	Begin
		Update TCriteria Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where TCriteria = 10
	End

	--เพิ่มกลุ่มคะแนน 30
	If Not Exists(Select * From TCriteria Where TCriteria = 30 And ScoreGroupID is not null)
	Begin
		Update TCriteria Set ScoreGroupID = '950E2A3C-5B5B-4A51-8613-4EC393A1F495' Where TCriteria = 30
	End

	--เพิ่มกลุ่มคะแนน 50
	If Not Exists(Select * From TCriteria Where TCriteria = 50 And ScoreGroupID is not null)
	Begin
		Update TCriteria Set ScoreGroupID = '5D9C042C-A0AC-42DC-9DC6-20C4B601D127' Where TCriteria = 50
	End

	--เพิ่มกลุ่มคะแนน 100
	If Not Exists(Select * From TCriteria Where TCriteria = 100 And ScoreGroupID is not null)
	Begin
		Update TCriteria Set ScoreGroupID = '63B1FF9E-CD47-4C46-9B6D-9F14CEA6E0C0' Where TCriteria = 100
	End


------------------Update กลุ่มคะแนน ให้ ด้าน มาตรฐาน  ตัวบ่งชี้---------------------------------------------
-----ด้านที่ 1
If Not Exists(Select * From Side Where Sort = 1 And ScoreGroupID is not null )
	Begin
		Update Side Set ScoreGroupID = '950E2A3C-5B5B-4A51-8613-4EC393A1F495' Where Sort = 1
	End

-----ด้านที่ 2
If Not Exists(Select * From Side Where Sort = 2 And ScoreGroupID is not null )
	Begin
		Update Side Set ScoreGroupID = '5D9C042C-A0AC-42DC-9DC6-20C4B601D127' Where Sort = 2
	End

-----ด้านที่ 3
If Not Exists(Select * From Side Where Sort = 3 And ScoreGroupID is not null )
	Begin
		Update Side Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where Sort = 3
	End

-----ด้านที่ 4
If Not Exists(Select * From Side Where Sort = 4 And ScoreGroupID is not null )
	Begin
		Update Side Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where Sort = 4
	End

-----ด้านที่ 5
If Not Exists(Select * From Side Where Sort = 5 And ScoreGroupID is not null )
	Begin
		Update Side Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where Sort = 5
	End


-----มาตรฐานที่ 1
If Not Exists(Select * From Standard Where Sort = 1 And ScoreGroupID is not null )
	Begin
		Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where Sort = 1
	End

-----มาตรฐานที่ 2
If Not Exists(Select * From Standard Where Sort = 2 And ScoreGroupID is not null )
	Begin
		Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where Sort = 2
	End

-----มาตรฐานที่ 3
If Not Exists(Select * From Standard Where Sort = 3 And ScoreGroupID is not null )
	Begin
		Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where Sort = 3
	End

-----มาตรฐานที่ 4
If Not Exists(Select * From Standard Where Sort = 4 And ScoreGroupID is not null )
	Begin
		Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where Sort = 4
	End

-----มาตรฐานที่ 5
If Not Exists(Select * From Standard Where Sort = 5 And ScoreGroupID is not null )
	Begin
		Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where Sort = 5
	End

-----มาตรฐานที่ 6
If Not Exists(Select * From Standard Where Sort = 6 And ScoreGroupID is not null )
	Begin
		Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where Sort = 6
	End

-----มาตรฐานที่ 7
If Not Exists(Select * From Standard Where Sort = 7 And ScoreGroupID is not null )
	Begin
		Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where Sort = 7
	End

-----มาตรฐานที่ 8
If Not Exists(Select * From Standard Where Sort = 8 And ScoreGroupID is not null )
	Begin
		Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where Sort = 8
	End

-----มาตรฐานที่9
If Not Exists(Select * From Standard Where Sort = 9 And ScoreGroupID is not null )
	Begin
		Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where Sort = 9
	End

-----มาตรฐานที่ 10
If Not Exists(Select * From Standard Where Sort = 10 And ScoreGroupID is not null )
	Begin
		Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where Sort = 10
	End

-----มาตรฐานที่ 11
If Not Exists(Select * From Standard Where Sort = 11 And ScoreGroupID is not null )
	Begin
		Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where Sort = 11
	End

-----มาตรฐานที่ 12
If Not Exists(Select * From Standard Where Sort = 12 And ScoreGroupID is not null )
	Begin
		Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where Sort = 12
	End

-----มาตรฐานที่ 13
If Not Exists(Select * From Standard Where Sort = 13 And ScoreGroupID is not null )
	Begin
		Update Standard Set ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61' Where Sort = 13
	End

-----มาตรฐานที่ 14
If Not Exists(Select * From Standard Where Sort = 14 And ScoreGroupID is not null )
	Begin
		Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where Sort = 14
	End

-----มาตรฐานที่ 15
If Not Exists(Select * From Standard Where Sort = 15 And ScoreGroupID is not null )
	Begin
		Update Standard Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952' Where Sort = 15
	End


-----ตัวบ่งชี้ที่ 1.1
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 1 And a.Sort = 1 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 1 And a.Sort = 1
End

-----ตัวบ่งชี้ที่ 1.2
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 1 And a.Sort = 2 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 1 And a.Sort = 2
End

-----ตัวบ่งชี้ที่ 1.3
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 1 And a.Sort = 3 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 1 And a.Sort = 3
End

-----ตัวบ่งชี้ที่ 1.4
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 1 And a.Sort = 4 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 1 And a.Sort = 4
End

-----ตัวบ่งชี้ที่ 1.5
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 1 And a.Sort = 5 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 1 And a.Sort = 5
End

-----ตัวบ่งชี้ที่ 1.6
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 1 And a.Sort = 6 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 1 And a.Sort = 6
End

-----ตัวบ่งชี้ที่ 2.1
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 2 And a.Sort = 1 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 2 And a.Sort = 1
End

-----ตัวบ่งชี้ที่ 2.2
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 2 And a.Sort = 2 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 2 And a.Sort = 2
End

-----ตัวบ่งชี้ที่ 2.3
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 2 And a.Sort = 3 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 2 And a.Sort = 3
End

-----ตัวบ่งชี้ที่ 2.4
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 2 And a.Sort = 4 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 2 And a.Sort = 4
End

-----ตัวบ่งชี้ที่ 3.1
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 3 And a.Sort = 1 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 3 And a.Sort = 1
End

-----ตัวบ่งชี้ที่ 3.2
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 3 And a.Sort = 2 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 3 And a.Sort = 2
End

-----ตัวบ่งชี้ที่ 3.3
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 3 And a.Sort = 3 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 3 And a.Sort = 3
End

-----ตัวบ่งชี้ที่ 3.4
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 3 And a.Sort = 4 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 3 And a.Sort = 4
End

-----ตัวบ่งชี้ที่ 4.1
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 4 And a.Sort = 1 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 4 And a.Sort = 1
End

-----ตัวบ่งชี้ที่ 4.2
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 4 And a.Sort = 2 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 4 And a.Sort = 2
End

-----ตัวบ่งชี้ที่ 4.3
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 4 And a.Sort = 3 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 4 And a.Sort = 3
End

-----ตัวบ่งชี้ที่ 4.4
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 4 And a.Sort = 4 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 4 And a.Sort = 4
End

-----ตัวบ่งชี้ที่ 5.1
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 5 And a.Sort = 1 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 5 And a.Sort = 1
End

-----ตัวบ่งชี้ที่ 5.2
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 5 And a.Sort = 2 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 5 And a.Sort = 2
End

-----ตัวบ่งชี้ที่ 5.3
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 5 And a.Sort = 3 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 5 And a.Sort = 3
End

-----ตัวบ่งชี้ที่ 5.4
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 5 And a.Sort = 4 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 5 And a.Sort = 4
End

-----ตัวบ่งชี้ที่ 6.1
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 6 And a.Sort = 1 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 6 And a.Sort = 1
End

-----ตัวบ่งชี้ที่ 6.2
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 6 And a.Sort = 2 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 6 And a.Sort = 2
End

-----ตัวบ่งชี้ที่ 6.3
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 6 And a.Sort = 3 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 6 And a.Sort = 3
End

-----ตัวบ่งชี้ที่ 6.4
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 6 And a.Sort = 4 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 6 And a.Sort = 4
End

-----ตัวบ่งชี้ที่ 7.1
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 7 And a.Sort = 1 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 7 And a.Sort = 1
End

-----ตัวบ่งชี้ที่ 7.2
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 7 And a.Sort = 2 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 7 And a.Sort = 2
End

-----ตัวบ่งชี้ที่ 7.3
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 7 And a.Sort = 3 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 7 And a.Sort = 3
End

-----ตัวบ่งชี้ที่ 7.4
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 7 And a.Sort = 4 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 7 And a.Sort = 4
End

-----ตัวบ่งชี้ที่ 7.5
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 7 And a.Sort = 5 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 7 And a.Sort = 5
End

-----ตัวบ่งชี้ที่ 7.6
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 7 And a.Sort = 6 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 7 And a.Sort = 6
End

-----ตัวบ่งชี้ที่ 7.7
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 7 And a.Sort = 7 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 7 And a.Sort = 7
End

-----ตัวบ่งชี้ที่ 7.8
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 7 And a.Sort = 8 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 7 And a.Sort = 8
End

-----ตัวบ่งชี้ที่ 7.9
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 7 And a.Sort = 9 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 7 And a.Sort = 9
End

-----ตัวบ่งชี้ที่ 8.1
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 8 And a.Sort = 1 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 8 And a.Sort = 1
End

-----ตัวบ่งชี้ที่ 8.2
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 8 And a.Sort = 2 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 8 And a.Sort = 2
End

-----ตัวบ่งชี้ที่ 8.3
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 8 And a.Sort = 3 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 8 And a.Sort = 3
End

-----ตัวบ่งชี้ที่ 8.4
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 8 And a.Sort = 4 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 8 And a.Sort = 4
End

-----ตัวบ่งชี้ที่ 8.5
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 8 And a.Sort = 5 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 8 And a.Sort = 5
End

-----ตัวบ่งชี้ที่ 8.6
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 8 And a.Sort = 6 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 8 And a.Sort = 6
End

-----ตัวบ่งชี้ที่ 9.1
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 9 And a.Sort = 1 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 9 And a.Sort = 1
End

-----ตัวบ่งชี้ที่ 9.2
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 9 And a.Sort = 2 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 9 And a.Sort = 2
End

-----ตัวบ่งชี้ที่ 9.3
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 9 And a.Sort = 3 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 9 And a.Sort = 3
End

-----ตัวบ่งชี้ที่ 10.1
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 10 And a.Sort = 1 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 10 And a.Sort = 1
End

-----ตัวบ่งชี้ที่ 10.2
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 10 And a.Sort = 2 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 10 And a.Sort = 2
End

-----ตัวบ่งชี้ที่ 10.3
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 10 And a.Sort = 3 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 10 And a.Sort = 3
End

-----ตัวบ่งชี้ที่ 10.4
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 10 And a.Sort = 4 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 10 And a.Sort = 4
End

-----ตัวบ่งชี้ที่ 10.5
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 10 And a.Sort = 5 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 10 And a.Sort = 5
End

-----ตัวบ่งชี้ที่ 10.6
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 10 And a.Sort = 6 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 10 And a.Sort = 6
End

-----ตัวบ่งชี้ที่ 11.1
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 11 And a.Sort = 1 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 11 And a.Sort = 1
End

-----ตัวบ่งชี้ที่ 11.2
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 11 And a.Sort = 2 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 11 And a.Sort = 2
End

-----ตัวบ่งชี้ที่ 11.3
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 11 And a.Sort = 3 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 11 And a.Sort = 3
End

-----ตัวบ่งชี้ที่ 12.1
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 12 And a.Sort = 1 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 12 And a.Sort = 1
End

-----ตัวบ่งชี้ที่ 12.2
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 12 And a.Sort = 2 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 12 And a.Sort = 2
End

-----ตัวบ่งชี้ที่ 12.3
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 12 And a.Sort = 3 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 12 And a.Sort = 3
End

-----ตัวบ่งชี้ที่ 12.4
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 12 And a.Sort = 4 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 12 And a.Sort = 4
End

-----ตัวบ่งชี้ที่ 12.5
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 12 And a.Sort = 5 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 12 And a.Sort = 5
End

-----ตัวบ่งชี้ที่ 12.6
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 12 And a.Sort = 6 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 12 And a.Sort = 6
End

-----ตัวบ่งชี้ที่ 13.1
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 13 And a.Sort = 1 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 13 And a.Sort = 1
End

-----ตัวบ่งชี้ที่ 13.2
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 13 And a.Sort = 2 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 13 And a.Sort = 2
End

-----ตัวบ่งชี้ที่ 14.1
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 14 And a.Sort = 1 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 14 And a.Sort = 1
End

-----ตัวบ่งชี้ที่ 14.2
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 14 And a.Sort = 2 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 14 And a.Sort = 2
End

-----ตัวบ่งชี้ที่ 15.1
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 15 And a.Sort = 1 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 15 And a.Sort = 1
End

-----ตัวบ่งชี้ที่ 15.2
If Not Exists(Select a.*, b.Sort From Indicators a, Standard b 
	Where a.StandardCode = b.StandardCode And b.Sort = 15 And a.Sort = 2 And a.ScoreGroupID is not null )
Begin
	Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
	From Indicators a inner join Standard b On a.StandardCode = b.StandardCode 
	Where b.Sort = 15 And a.Sort = 2
End

--4444444444444444444444444444444444444444444444444444444444444444444444444444444


--555555555555555555555555555555555555555555555555555555555555555555555555555555555

---------------4.14.0--------------------
----------- เพิ่ม Table Factor ปัจจัยที่ประสบความสำเร็จ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('Factor'))
Begin
	CREATE TABLE [dbo].[Factor](
		[FactorCode] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[FactorName] [nvarchar](max) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_Factor] PRIMARY KEY CLUSTERED 
	(
		[FactorCode] ASC
	)) ON [PRIMARY]
End

----------- เพิ่ม Table dtFactor ปัจจัยที่ประสบความสำเร็จในกิจกรรม------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtFactor'))
Begin
	CREATE TABLE [dbo].[dtFactor](
		[ActivityCode] [nvarchar](50) NULL,
		[FactorCode] [nvarchar](50) NULL
	) ON [PRIMARY]
End


--เพิ่มฟิวความสำเร็จของโครงการใน Activity
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'FactorRateID')
Begin
	alter table Activity add FactorRateID nvarchar(50)
End


----------- เพิ่ม Table FactorRate เกณฑ์ความสำเร็จ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('FactorRate'))
Begin
	CREATE TABLE [dbo].[FactorRate](
	[FactorRateID] [nvarchar](50) NOT NULL,
	[StudyYear] [int] NULL,
	[Detail] [nvarchar](20) NULL,
	[Criterion] [int] NULL,
	[Translation] [nvarchar](20) NULL,
	[TMin] [float] NULL,
	[TMax] [float] NULL,
	[DelFlag] [bit] NULL,
	[CreateUser] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[UpdateUser] [nvarchar](50) NULL,
	[UpdateDate] [datetime] NULL,
	 CONSTRAINT [PK_FactorRateID] PRIMARY KEY CLUSTERED 
	(
		[FactorRateID] ASC
	)) ON [PRIMARY]
End

--เพิ่มฟิววันที่ปฏิบัติกิจกรรมจริงใน Activity
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'RealSDate')
Begin
	alter table Activity add RealSDate datetime
End

If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'RealEDate')
Begin
	alter table Activity add RealEDate datetime
End

----------- เพิ่ม Table StrategySPT  กลยุทธ์ สพฐ.------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('StrategySPT'))
Begin
	CREATE TABLE [dbo].[StrategySPT](
		[StrategySPTCode] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[StrategySPTName] [nvarchar](300) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_StrategySPT] PRIMARY KEY CLUSTERED 
	(
		[StrategySPTCode] ASC
	)) ON [PRIMARY]
End

--เพิ่มฟิวแผนพัฒนาระยะที่
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Projects') And Name = 'PlanNo')
Begin
	alter table Projects add PlanNo nVarChar(3)
End

--เพิ่มฟิวพระราชบัญญัติ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Projects') And Name = 'StatuteNo')
Begin
	alter table Projects add StatuteNo nVarChar(100)
End

--เพิ่มฟิวแผนพัฒนาระยะที่
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'PlanNo')
Begin
	alter table MR_School add PlanNo nVarChar(3)
End

--เพิ่มฟิวตัวเช็คแผนพัฒนา
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckPlanNo')
Begin
	alter table MR_School add ckPlanNo bit
End

--เพิ่มฟิวตัวเช็คกลยุทธ์ สพฐ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckStrategySPT')
Begin
	alter table MR_School add ckStrategySPT bit
End

--เพิ่มฟิวตัวเช็คพระราชบัญญัติ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckStatute')
Begin
	alter table MR_School add ckStatute bit
End


----------- เพิ่ม Table dtStrategySPT กลยุทธ์ สพฐ. ในโครงการ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtStrategySPT'))
Begin
	CREATE TABLE [dbo].[dtStrategySPT](
		[ProjectsCode] [nvarchar](50) NULL,
		[StrategySPTCode] [nvarchar](50) NULL
	) ON [PRIMARY]
End

----------- เพิ่มฟิว เอกลักณ์ อัตลักษณ์ ในโครงการ------------
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Projects') And Name = 'IdentityName')
Begin
	alter table Projects add IdentityName nVarChar(max)
End

If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Projects') And Name = 'IdentityName2')
Begin
	alter table Projects add IdentityName2 nVarChar(max)
End

--555555555555555555555555555555555555555555555555555555555555555555555555555555555555555



--666666666666666666666666666666666666666666666666666666666666666666666666666666666666666

--เพิ่มข้อมูลปัจจัยที่ประสบความสำเร็จ
If Not Exists(Select * From Factor)
Begin
	INSERT INTO Factor (FactorCode, StudyYear, FactorName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('1db944f0-bbeb-4aa8-98f3-f5997c7c3524', '2555', 'งบประมาณเพียงพอ', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO Factor (FactorCode, StudyYear, FactorName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('a13f5277-05d0-4993-852e-cb67806779ad', '2555', 'ได้รับการสนับสนุนจากผู้บังคับบัญชา', 2, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO Factor (FactorCode, StudyYear, FactorName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('56730e38-e877-408f-96bb-e642035b08f8', '2555', 'ได้รับการสนับสนุนจากองค์กรที่เกี่ยวข้อง', 3, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO Factor (FactorCode, StudyYear, FactorName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('a0d564fc-dae7-4cf1-b320-129fc645be51', '2555', 'บุคลากรให้ความร่วมมือ', 4, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO Factor (FactorCode, StudyYear, FactorName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('7caa078c-392e-4504-82fb-321b8acf323b', '2555', 'มีขวัญและกำลังใจในการทำงาน', 5, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO Factor (FactorCode, StudyYear, FactorName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('d34e4c84-703b-4175-86f2-6eed57add02f', '2555', 'ผู้เกี่ยวข้องมีความพึงพอใจ', 6, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO Factor (FactorCode, StudyYear, FactorName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('7d24ccfd-4ef4-46cd-adf1-71f2b1e7ca0b', '2555', 'สภาพแวดล้อมเอื้ออำนวย', 7, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End

--เพิ่มเมนูปัจจัยที่ประสบความสำเร็จ
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'B906F7F0-E09C-4C3B-A2F6-DFF9806A1955')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('B906F7F0-E09C-4C3B-A2F6-DFF9806A1955', 'ปัจจัยที่ประสบความสำเร็จ', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 14, 'MasterData/Factor.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S5.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B906F7F0-E09C-4C3B-A2F6-DFF9806A1955', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B906F7F0-E09C-4C3B-A2F6-DFF9806A1955', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B906F7F0-E09C-4C3B-A2F6-DFF9806A1955', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B906F7F0-E09C-4C3B-A2F6-DFF9806A1955', '079c4976-49a8-4b30-83bf-3e13cbaa9382')

	Update MySubMenu Set Sort = 16 Where MySubMenuID = '21546c40-d0be-43ec-ae6b-b38f726b74c2'
End


--เพิ่มเมนูตารางเกณฑ์ความสำเร็จ
If Not Exists(Select * From MySubMenu Where MySubMenuID = '331E5560-A5B6-4A5D-A08B-F0798FA5DE94')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('331E5560-A5B6-4A5D-A08B-F0798FA5DE94', 'ตารางเกณฑ์ความสำเร็จ', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 15, 'MasterData/FactorRate.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S1.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('331E5560-A5B6-4A5D-A08B-F0798FA5DE94', '46aada1c-386e-4be8-be6d-6efdc96a9537')
End

--เพิ่มข้อมูลเกณฑ์ความสำเร็จ
If Not Exists(Select * From FactorRate)
Begin
	INSERT INTO FactorRate (FactorRateID, StudyYear, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('3e152ca0-1f19-4778-a8b9-4183e150db73', '2555', '0 - 49 %', 1, 'ปรับปรุง', 0, 49, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO FactorRate (FactorRateID, StudyYear, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('75c2024b-b87b-4846-b76d-68c6594fa9b3', '2555', '50 - 74 %', 2, 'ปานกลาง', 50, 74, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO FactorRate (FactorRateID, StudyYear, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('c7ef00d3-9741-4281-a33e-e26f0eb236c9', '2555', '75 - 84 %', 3, 'ดี', 75, 84, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO FactorRate (FactorRateID, StudyYear, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('ef1c249e-56ba-4615-ad7a-d94631362912', '2555', '85 - 100 %', 4, 'ดีมาก', 85, 100, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End

--เพิ่มเมนูกลยุทธ์ สพฐ.
If Not Exists(Select * From MySubMenu Where MySubMenuID = '2F21019F-5861-4909-BB43-14A031FB89A7')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('2F21019F-5861-4909-BB43-14A031FB89A7', 'กลยุทธ์ สพฐ.', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 14, 'MasterData/StrategySPT.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S10.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('2F21019F-5861-4909-BB43-14A031FB89A7', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('2F21019F-5861-4909-BB43-14A031FB89A7', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('2F21019F-5861-4909-BB43-14A031FB89A7', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('2F21019F-5861-4909-BB43-14A031FB89A7', '079c4976-49a8-4b30-83bf-3e13cbaa9382')

	Update MySubMenu Set Sort = 20 Where MySubMenuID = '21546c40-d0be-43ec-ae6b-b38f726b74c2'
	Update MySubMenu Set Sort = 19 Where MySubMenuID = '331E5560-A5B6-4A5D-A08B-F0798FA5DE94'
	Update MySubMenu Set Sort = 18 Where MySubMenuID = 'B906F7F0-E09C-4C3B-A2F6-DFF9806A1955'
End

--เพิ่มข้อมูลกลยุทธ์ สพฐ.
If Not Exists(Select * From StrategySPT)
Begin
	INSERT INTO StrategySPT (StrategySPTCode, StudyYear, StrategySPTName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('7EECCD17-42D5-4931-8325-802F468938DB', '2555', 'พัฒนาคุณภาพและมาตรฐานการศึกษาทุกระดับตามหลักสูตรและส่งเสริมความสามารถด้านเทคโนโลยีเพื่อเป็นเครื่องมือในการเรียนรู้', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StrategySPT (StrategySPTCode, StudyYear, StrategySPTName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('BEBE1D85-953F-42C8-B3BB-19C90E2C63F5', '2555', 'ปลูกฝังคุณธรรมความสำนึกในความเป็นชาติไทยและวิถีชีวิตตามหลักปรัชญาของเศรษฐกิจพอเพียง', 2, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StrategySPT (StrategySPTCode, StudyYear, StrategySPTName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('CF3E8D4C-0919-4826-9245-B3BE54C25A1E', '2555', 'ขยายโอกาสทางการศึกษาให้ทั่วถึง  ครอบคลุม  ผู้เรียนได้รับโอกาสในการพัฒนาเต็มศักยภาพ', 3, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StrategySPT (StrategySPTCode, StudyYear, StrategySPTName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('15202A10-AA0B-4AF5-833C-4FC1812C4F18', '2555', 'พัฒนาครูและบุคลากรทางการศึกษาทั้งระบบ  ให้สามารถจัดการเรียนการสอนได้อย่างมีคุณภาพ', 4, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StrategySPT (StrategySPTCode, StudyYear, StrategySPTName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('C51B7466-45B2-44E7-9DB8-25670093078C', '2555', 'พัฒนาประสิทธิภาพการบริหารจัดการศึกษา  ตามแนวทางการกระจายอำนาจทางการศึกษา  หลักธรรมมาภิบาลเน้นการมีส่วนร่วมจากทุกภาคส่วนและความร่วมมือกับองค์กรปกครองส่วนท้องถิ่น  เพื่อส่งเสริมและสนับสนุนการจัดการศึกษา', 5, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StrategySPT (StrategySPTCode, StudyYear, StrategySPTName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('AB0807BC-1073-4EC3-B4BA-0C964D9B342F', '2555', 'พัฒนาการศึกษาในเขตพัฒนาพิเศษเฉพาะกิจจังหวัดชายแดนภาคใต้', 6, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End

----------Update ค่าตัวเช็ค
Update MR_School Set ckPlanNo = 0 Where ckPlanNo Is Null
Update MR_School Set ckStrategySPT = 0 Where ckStrategySPT Is Null
Update MR_School Set ckStatute = 0 Where ckStatute Is Null

--666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666



--77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777

--------- Sar v 4.15.0----------
--เพิ่มฟิวแนวทางแก้ไขในกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'Solutions')
Begin
	alter table Activity add Solutions nVarChar(max)
End

--เพิ่มฟิวเช็คมาตรฐานการศึกษาชาติ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckStandardNation')
Begin
	alter table MR_School add ckStandardNation bit
End

--เพิ่มฟิวเช็คมาตรฐานตามกฏกระทรวง
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckStandardMinistry')
Begin
	alter table MR_School add ckStandardMinistry bit
End

--77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777



--888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
----------Update ค่าตัวเช็ค
Update MR_School Set ckStandardNation = 0 Where ckStandardNation Is Null
Update MR_School Set ckStandardMinistry = 0 Where ckStandardMinistry Is Null

--เพิ่มเมนูตั้งค่า
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'C7C199C5-0CDB-4004-83E5-33ED40A5442D')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('C7C199C5-0CDB-4004-83E5-33ED40A5442D', 'ตั้งค่าระบบ', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 0, 'MasterData/SarConfig.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S0.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('C7C199C5-0CDB-4004-83E5-33ED40A5442D', '46aada1c-386e-4be8-be6d-6efdc96a9537')
End

--888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888


--9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
-------------Sar ver 5.0.0----------------
--ลบเมนูประเมินเชิงคุณภาพตามตัวบ่งชี้
If Exists(Select * From MenuRole Where MySubMenuID = 'e83bed1b-431f-4969-a27e-e4ba7444c87e')
Begin
	Delete MenuRole Where MySubMenuID = 'e83bed1b-431f-4969-a27e-e4ba7444c87e'
End

--เพิ่มฟิวเช็คเลือกเกณฑ์การประเมิน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckRate')
Begin
	alter table MR_School add ckRate bit
End

----------ลบ StoreProcedure Update เกณฑ์
If Exists(Select * From Sys.Procedures Where Name = 'GenRate')
Begin
	DROP PROCEDURE GenRate
End
-------------------------------------------
	
----------ลบ StoreProcedure Update เกณฑ์ในตัวบ่งชี้
If Exists(Select * From Sys.Procedures Where Name = 'GenIndRate')
Begin
	DROP PROCEDURE GenIndRate
End

----------ลบ StoreProcedure เมนูมาตรฐานชาติ
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuStandardNation')
Begin
	DROP PROCEDURE ckMenuStandardNation
End

----------ลบ StoreProcedure เมนูมาตรฐานกระทรวง
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuStandardMinistry')
Begin
	DROP PROCEDURE ckMenuStandardMinistry
End

----------ลบ StoreProcedure เมนูกลยุทธ์ สพฐ.
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuStrategySPT')
Begin
	DROP PROCEDURE ckMenuStrategySPT
End

----------ลบ StoreProcedure เมนูต้นทุนศูนย์
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuCostsCenter')
Begin
	DROP PROCEDURE ckMenuCostsCenter
End

----------ลบ StoreProcedure เมนูกลยุทธ์ สพม.
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuStrategySPM')
Begin
	DROP PROCEDURE ckMenuStrategySPM
End

----------ลบ StoreProcedure เมนูมาตรฐาน สพม.
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuStandardSPM')
Begin
	DROP PROCEDURE ckMenuStandardSPM
End

--99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999



--00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
--เพิ่มเมนูรายงานรายจ่ายอื่น ๆ
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'B30B2EA7-0A88-460A-A2F0-843F780A5664')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('B30B2EA7-0A88-460A-A2F0-843F780A5664', 'รายงานรายจ่ายอื่น ๆ', '434de3e9-c4d5-4bed-9b00-c7603e4c335e', 20, 'MasterData/RptOther.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S06.gif')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B30B2EA7-0A88-460A-A2F0-843F780A5664', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B30B2EA7-0A88-460A-A2F0-843F780A5664', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B30B2EA7-0A88-460A-A2F0-843F780A5664', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B30B2EA7-0A88-460A-A2F0-843F780A5664', '079c4976-49a8-4b30-83bf-3e13cbaa9382')

	Update MySubMenu Set ImgName = 'S05.png' Where MySubMenuID = 'B7801973-9F71-44E5-91C0-12367123837F'
End


------เพิ่มตารางคะแนนหมวดที่ 2
---------0.5 (2)
--เพิ่มเกณฑ์คะแนน  0.5 (2)
If Not Exists(Select * From TCriteria Where TcriteriaID = '3718F3A7-B317-469E-9130-E193F42542DC')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('3718F3A7-B317-469E-9130-E193F42542DC', 0.5, '๐.๐๐ - ๐.๑๐', 1, 'ปรับปรุง', 0, 0.1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = '11FF16DA-10CD-4150-8A29-6AE7B1972A4B')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('11FF16DA-10CD-4150-8A29-6AE7B1972A4B', 0.5, '๐.๑๑ - ๐.๒๐', 2, 'พอใช้', 0.11, 0.2, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = 'AE1CCAD9-4115-4B56-BD74-F1B5F1867782')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('AE1CCAD9-4115-4B56-BD74-F1B5F1867782', 0.5, '๐.๒๑ - ๐.๓๐', 3, 'ดี', 0.21, 0.3, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = '50D15E0D-CAA2-4423-B3F3-570584053200')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('50D15E0D-CAA2-4423-B3F3-570584053200', 0.5, '๐.๓๑ - ๐.๔๐', 4, 'ดีมาก', 0.31, 0.4, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = 'DEFCE217-618E-44D5-A8CE-29FFDE83A1A4')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('DEFCE217-618E-44D5-A8CE-29FFDE83A1A4', 0.5, '๐.๔๑ - ๐.๕๐', 5, 'ดีเยี่ยม', 0.41, 0.5, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35')
End

---------1.0 (2)
--เพิ่มเกณฑ์คะแนน  1.0 (2)
If Not Exists(Select * From TCriteria Where TcriteriaID = '223EFC01-5C93-46CD-B3F5-8EA36DCF8FDC')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('223EFC01-5C93-46CD-B3F5-8EA36DCF8FDC', 1, '๐.๐๐ - ๐.๒๐', 1, 'ปรับปรุง', 0, 0.2, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', '25E2142B-3F11-48DF-8D66-681E6FDDC5E7')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = '36365A43-EBA9-478F-B337-98F3C0D12ACF')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('36365A43-EBA9-478F-B337-98F3C0D12ACF', 1, '๐.๒๑ - ๐.๔๐', 2, 'พอใช้', 0.21, 0.4, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', '25E2142B-3F11-48DF-8D66-681E6FDDC5E7')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = '0633B326-32A3-4018-A6E4-071CCA336DF9')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('0633B326-32A3-4018-A6E4-071CCA336DF9', 1, '๐.๔๑ - ๐.๖๐', 3, 'ดี', 0.41, 0.6, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', '25E2142B-3F11-48DF-8D66-681E6FDDC5E7')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = 'A6411A5F-B47D-4578-A7FC-6B4924AC42BB')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('A6411A5F-B47D-4578-A7FC-6B4924AC42BB', 1, '๐.๖๑ - ๐.๘๐', 4, 'ดีมาก', 0.61, 0.8, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', '25E2142B-3F11-48DF-8D66-681E6FDDC5E7')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = 'AB835423-2FDA-4348-B3EC-7AB735C3E4CC')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('AB835423-2FDA-4348-B3EC-7AB735C3E4CC', 1, '๐.๘๑ - ๑.๐๐', 5, 'ดีเยี่ยม', 0.81, 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', '25E2142B-3F11-48DF-8D66-681E6FDDC5E7')
End

---------2.0 (2)
--เพิ่มเกณฑ์คะแนน  2.0 (2)
If Not Exists(Select * From TCriteria Where TcriteriaID = '22656210-A80D-4BA6-88D7-0D18235CAE6B')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('22656210-A80D-4BA6-88D7-0D18235CAE6B', 2, '๐.๐๐ - ๐.๔๐', 1, 'ปรับปรุง', 0, 0.4, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'E82BB47C-6C65-409F-818E-6ADE319CA8A1')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = 'A6680FCD-11E8-46B3-A447-F9ACBAC8A627')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('A6680FCD-11E8-46B3-A447-F9ACBAC8A627', 2, '๐.๔๑ - ๐.๘๐', 2, 'พอใช้', 0.41, 0.8, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'E82BB47C-6C65-409F-818E-6ADE319CA8A1')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = '76CCC37D-CA07-458F-83DC-C32FA1E8D1D6')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('76CCC37D-CA07-458F-83DC-C32FA1E8D1D6', 2, '๐.๘๑ - ๑.๒๐', 3, 'ดี', 0.81, 1.2, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'E82BB47C-6C65-409F-818E-6ADE319CA8A1')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = '943675D4-E2CD-4EEA-8AB0-BA5D743A90C9')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('943675D4-E2CD-4EEA-8AB0-BA5D743A90C9', 2, '๑.๒๑ - ๑.๖๐', 4, 'ดีมาก', 1.21, 1.6, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'E82BB47C-6C65-409F-818E-6ADE319CA8A1')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = 'B72385BA-FAC6-4EC9-AC62-F3594CCB5753')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('B72385BA-FAC6-4EC9-AC62-F3594CCB5753', 2, '๑.๖๑ - ๒.๐๐', 5, 'ดีเยี่ยม', 1.61, 2, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'E82BB47C-6C65-409F-818E-6ADE319CA8A1')
End

---------5.0 (2)
--เพิ่มเกณฑ์คะแนน  5.0 (2)
If Not Exists(Select * From TCriteria Where TcriteriaID = '9A480D12-7160-4E72-B8AE-C9E9A663EBD4')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('9A480D12-7160-4E72-B8AE-C9E9A663EBD4', 5, '๐.๐๐ - ๑.๐๐', 1, 'ปรับปรุง', 0, 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', '7211D888-9FDA-4691-AA80-13D38710AA45')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = 'E855AD6C-F412-4796-8C22-CF0587501079')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('E855AD6C-F412-4796-8C22-CF0587501079', 5, '๑.๐๑ - ๒.๐๐', 2, 'พอใช้', 1.01, 2, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', '7211D888-9FDA-4691-AA80-13D38710AA45')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = '6163F6D7-70E3-4CAD-9DA6-77B7C9ABB5D5')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('6163F6D7-70E3-4CAD-9DA6-77B7C9ABB5D5', 5, '๒.๐๑ - ๓.๐๐', 3, 'ดี', 2.01, 3, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', '7211D888-9FDA-4691-AA80-13D38710AA45')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = '98C64437-9C98-44C8-A25F-880D62937C97')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('98C64437-9C98-44C8-A25F-880D62937C97', 5, '๓.๐๑ - ๔.๐๐', 4, 'ดีมาก', 3.01, 4, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', '7211D888-9FDA-4691-AA80-13D38710AA45')
End

If Not Exists(Select * From TCriteria Where TcriteriaID = '5062F4F5-AE1E-4570-918A-A78C1F21E10E')
Begin
	INSERT INTO TCriteria (TcriteriaID, Tcriteria, Detail, Criterion, Translation, TMin, TMax, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ScoreGroupID)
	VALUES ('5062F4F5-AE1E-4570-918A-A78C1F21E10E', 5, '๔.๐๑ - ๕.๐๐', 5, 'ดีเยี่ยม', 4.01, 5, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', '7211D888-9FDA-4691-AA80-13D38710AA45')
End

----------Update ค่าตัวเช็ค
Update MR_School Set ckRate = 0 Where ckRate Is Null
	
-----------------เพิ่ม StoreProcedure Update เกณฑ์---------------------------
	SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
	CREATE PROCEDURE GenRate
		@RateType int
	AS
	BEGIN
		SET NOCOUNT ON;
		IF @RateType = 0
		Begin
			----------------เก่า---------------------
			-----------0.5
			Update TCriteria Set Detail = '๐.๓๐ - ๐.๓๔', TMin = 0.3, TMax = 0.34 Where TcriteriaID = '573fcdb2-0f1d-42d4-95a9-2ce3b2dd5fd4'
			Update TCriteria Set Detail = '๐.๓๕ - ๐.๓๙', TMin = 0.35, TMax = 0.39 Where TcriteriaID = 'de5b6ed8-a080-468d-8cca-a302d0f5e73b'
			Update TCriteria Set Detail = '๐.๔๐ - ๐.๕๐', TMin = 0.4, TMax = 0.5 Where TcriteriaID = 'db2bedf7-9cf8-4495-a3b8-9ca572bd1f55'

			-----------1.0
			Update TCriteria Set Detail = '๐.๖๐ - ๐.๖๙', TMin = 0.6, TMax = 0.69 Where TcriteriaID = '6344b6e3-cfa7-4fdd-8b71-34470dd661ab'
			Update TCriteria Set Detail = '๐.๗๐ - ๐.๗๙', TMin = 0.7, TMax = 0.79 Where TcriteriaID = '98d32855-a9ac-444e-a3f2-558961400149'
			Update TCriteria Set Detail = '๐.๘๐ - ๑.๐๐', TMin = 0.8, TMax = 1 Where TcriteriaID = '138fb5bd-2a19-4a09-855e-43205d18ca7b'

			-----------2.0
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
			Update TCriteria Set Detail = '๓.๐๐ - ๓.๔๙', TMin = 3, TMax = 3.49 Where TcriteriaID = 'af07711a-3896-4e93-9794-4c27b670acbf'
			Update TCriteria Set Detail = '๓.๕๐ - ๓.๙๙', TMin = 3.5, TMax = 3.99 Where TcriteriaID = 'f4a8dcb9-7687-4f2c-9741-f2f8f1da694b'
			Update TCriteria Set Detail = '๔.๐๐ - ๕.๐๐', TMin = 4, TMax = 5 Where TcriteriaID = 'aeb0b92f-8949-47d0-99cd-af3980734f21'

			-----------10.0
			Update TCriteria Set Detail = '๖.๐๐ - ๖.๙๙', TMin = 6, TMax = 6.99 Where TcriteriaID = 'b3f28c05-5d4d-43fb-9284-a84117a4c566'
			Update TCriteria Set Detail = '๗.๐๐ - ๗.๙๙', TMin = 7, TMax = 7.99 Where TcriteriaID = '5f4e7061-4705-42b4-be20-01f144f08d5e'
			Update TCriteria Set Detail = '๘.๐๐ - ๑๐.๐๐', TMin = 8, TMax = 10 Where TcriteriaID = '16b3f3e2-b8a1-481e-9661-5177aad558d3'

			-----------30.0
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๐.๙๙', TMin = 18, TMax = 20.99 Where TcriteriaID = 'f497f305-8316-4d54-bcc8-2da0dc4fd9be'
			Update TCriteria Set Detail = '๒๑.๐๐ - ๒๓.๙๙', TMin = 21, TMax = 23.99 Where TcriteriaID = '6c3191d9-13ab-4bfb-bddb-dc50623b4c3a'
			Update TCriteria Set Detail = '๒๔.๐๐ - ๓๐.๐๐', TMin = 24, TMax = 30 Where TcriteriaID = 'f7818b1f-6b6b-46fc-9611-169c481e2c4d'

			-----------50.0
			Update TCriteria Set Detail = '๓๐.๐๐ - ๓๔.๙๙', TMin = 30, TMax = 34.99 Where TcriteriaID = '7722765c-3e54-42a4-b209-5cafe57cc7b2'
			Update TCriteria Set Detail = '๓๕.๐๐ - ๓๙.๙๙', TMin = 35, TMax = 39.99 Where TcriteriaID = 'bcc684de-202a-44ae-948e-d7dbb78f572e'
			Update TCriteria Set Detail = '๔๐.๐๐ - ๕๐.๐๐', TMin = 40, TMax = 50 Where TcriteriaID = '48c0564e-b8d8-4963-8ab1-4910057944a6'

			-----------100.0
			Update TCriteria Set Detail = '๖๐.๐๐ - ๖๙.๙๙', TMin = 60, TMax = 69.99 Where TcriteriaID = 'e277de33-3d86-4f09-b7b8-f3c97d585cb5'
			Update TCriteria Set Detail = '๗๐.๐๐ - ๗๙.๙๙', TMin = 70, TMax = 79.99 Where TcriteriaID = 'facf0afb-b6f4-4675-9c47-774eb1d1b8af'
			Update TCriteria Set Detail = '๘๐.๐๐ - ๑๐๐.๐๐', TMin = 80, TMax = 100 Where TcriteriaID = '6ecc7610-19d8-47cc-b728-15efd128fe21'
		End
		Else
		Begin
			----------------ใหม่------------------
			---------0.5 (1)
			Update TCriteria Set Detail = '๐.๓๐ - ๐.๓๗', TMin = 0.3, TMax = 0.37 Where TcriteriaID = '573fcdb2-0f1d-42d4-95a9-2ce3b2dd5fd4'
			Update TCriteria Set Detail = '๐.๓๘ - ๐.๔๔', TMin = 0.38, TMax = 0.44 Where TcriteriaID = 'de5b6ed8-a080-468d-8cca-a302d0f5e73b'
			Update TCriteria Set Detail = '๐.๔๕ - ๐.๕๐', TMin = 0.45, TMax = 0.50 Where TcriteriaID = 'db2bedf7-9cf8-4495-a3b8-9ca572bd1f55'

			-----------1.0
			Update TCriteria Set Detail = '๐.๖๐ - ๐.๗๔', TMin = 0.6, TMax = 0.74 Where TcriteriaID = '6344b6e3-cfa7-4fdd-8b71-34470dd661ab'
			Update TCriteria Set Detail = '๐.๗๕ - ๐.๘๙', TMin = 0.75, TMax = 0.89 Where TcriteriaID = '98d32855-a9ac-444e-a3f2-558961400149'
			Update TCriteria Set Detail = '๐.๙๐ - ๑.๐๐', TMin = 0.9, TMax = 1 Where TcriteriaID = '138fb5bd-2a19-4a09-855e-43205d18ca7b'

			-----------2.0
			Update TCriteria Set Detail = '๑.๒๐ - ๑.๔๙', TMin = 1.2, TMax = 1.49 Where TcriteriaID = 'fb08528d-fb28-4382-931d-cbbf28cf6b14'
			Update TCriteria Set Detail = '๑.๕๐ - ๑.๗๙', TMin = 1.5, TMax = 1.79 Where TcriteriaID = '970f9571-a05c-4a6e-9270-e3b8b6346832'
			Update TCriteria Set Detail = '๑.๘๐ - ๒.๐๐', TMin = 1.8, TMax = 2 Where TcriteriaID = 'e1923d69-300a-49e8-b2dd-558a1c9778a0'

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
			Update TCriteria Set Detail = '๓.๐๐ - ๓.๗๔', TMin = 3, TMax = 3.74 Where TcriteriaID = 'af07711a-3896-4e93-9794-4c27b670acbf'
			Update TCriteria Set Detail = '๓.๗๕ - ๔.๔๙', TMin = 3.75, TMax = 4.49 Where TcriteriaID = 'f4a8dcb9-7687-4f2c-9741-f2f8f1da694b'
			Update TCriteria Set Detail = '๔.๕๐ - ๕.๐๐', TMin = 4.5, TMax = 5 Where TcriteriaID = 'aeb0b92f-8949-47d0-99cd-af3980734f21'

			-----------10.0
			Update TCriteria Set Detail = '๖.๐๐ - ๗.๔๙', TMin = 6, TMax = 7.49 Where TcriteriaID = 'b3f28c05-5d4d-43fb-9284-a84117a4c566'
			Update TCriteria Set Detail = '๗.๕๐ - ๘.๙๙', TMin = 7.5, TMax = 8.99 Where TcriteriaID = '5f4e7061-4705-42b4-be20-01f144f08d5e'
			Update TCriteria Set Detail = '๙.๐๐ - ๑๐.๐๐', TMin = 9, TMax = 10 Where TcriteriaID = '16b3f3e2-b8a1-481e-9661-5177aad558d3'

			-----------30.0
			Update TCriteria Set Detail = '๑๘.๐๐ - ๒๒.๔๙', TMin = 18, TMax = 22.49 Where TcriteriaID = 'f497f305-8316-4d54-bcc8-2da0dc4fd9be'
			Update TCriteria Set Detail = '๒๒.๕๐ - ๒๖.๙๙', TMin = 22.5, TMax = 26.99 Where TcriteriaID = '6c3191d9-13ab-4bfb-bddb-dc50623b4c3a'
			Update TCriteria Set Detail = '๒๗.๐๐ - ๓๐.๐๐', TMin = 27, TMax = 30 Where TcriteriaID = 'f7818b1f-6b6b-46fc-9611-169c481e2c4d'

			-----------50.0
			Update TCriteria Set Detail = '๓๐.๐๐ - ๓๗.๔๙', TMin = 30, TMax = 37.49 Where TcriteriaID = '7722765c-3e54-42a4-b209-5cafe57cc7b2'
			Update TCriteria Set Detail = '๓๗.๕๐ - ๔๔.๙๙', TMin = 37.5, TMax = 44.99 Where TcriteriaID = 'bcc684de-202a-44ae-948e-d7dbb78f572e'
			Update TCriteria Set Detail = '๔๕.๐๐ - ๕๐.๐๐', TMin = 45, TMax = 50 Where TcriteriaID = '48c0564e-b8d8-4963-8ab1-4910057944a6'

			-----------100.0
			Update TCriteria Set Detail = '๖๐.๐๐ - ๗๔.๙๙', TMin = 60, TMax = 74.99 Where TcriteriaID = 'e277de33-3d86-4f09-b7b8-f3c97d585cb5'
			Update TCriteria Set Detail = '๗๕.๐๐ - ๘๙.๙๙', TMin = 75, TMax = 89.99 Where TcriteriaID = 'facf0afb-b6f4-4675-9c47-774eb1d1b8af'
			Update TCriteria Set Detail = '๙๐.๐๐ - ๑๐๐.๐๐', TMin = 90, TMax = 100 Where TcriteriaID = '6ecc7610-19d8-47cc-b728-15efd128fe21'
		End
	END

-------------เพิ่ม StoreProcedure Update เกณฑ์ในตัวบ่งชี้---------------------------------------------------

	SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
	CREATE PROCEDURE GenIndRate
		@RateType int,
		@StudyYear int
	AS
	BEGIN
		SET NOCOUNT ON;
		IF @RateType = 0
		Begin
			------------เกณฑ์เก่า
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

			---ตัวบ่งชี้ที่  5.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 4

			---ตัวบ่งชี้ที่  8.1  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 1

			---ตัวบ่งชี้ที่  8.5  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 5

			---ตัวบ่งชี้ที่  9.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 2

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

			---ตัวบ่งชี้ที่  12.6  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 6

			---ตัวบ่งชี้ที่  5.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 3

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

			---ตัวบ่งชี้ที่  8.6  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 6

			---ตัวบ่งชี้ที่  9.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 1

			---ตัวบ่งชี้ที่  9.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 3

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

			---ตัวบ่งชี้ที่  14.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 14 And b.Sort = 2

			---ตัวบ่งชี้ที่  15.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 15 And b.Sort = 2

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
		End
		Else
		Begin
			------------เกณฑ์ใหม่
			---ตัวบ่งชี้ที่  12.4  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 4

			---ตัวบ่งชี้ที่  12.5  คะแนนเต็ม  0.5
			Update Indicators Set ScoreGroupID = 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 5

			---ตัวบ่งชี้ที่  5.1  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 1

			---ตัวบ่งชี้ที่  5.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 2

			---ตัวบ่งชี้ที่  5.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 4

			---ตัวบ่งชี้ที่  8.1  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 1

			---ตัวบ่งชี้ที่  8.5  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 5

			---ตัวบ่งชี้ที่  9.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 2

			---ตัวบ่งชี้ที่  10.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 3

			---ตัวบ่งชี้ที่  10.4  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 4

			---ตัวบ่งชี้ที่  12.1  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 1

			---ตัวบ่งชี้ที่  12.2  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 2

			---ตัวบ่งชี้ที่  12.3  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 3

			---ตัวบ่งชี้ที่  12.6  คะแนนเต็ม  1.0
			Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 12 And b.Sort = 6

			---ตัวบ่งชี้ที่  5.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 5 And b.Sort = 3

			---ตัวบ่งชี้ที่  8.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 2

			---ตัวบ่งชี้ที่  8.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 3

			---ตัวบ่งชี้ที่  8.4  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 4

			---ตัวบ่งชี้ที่  8.6  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 8 And b.Sort = 6

			---ตัวบ่งชี้ที่  9.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 1

			---ตัวบ่งชี้ที่  9.3  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 9 And b.Sort = 3

			---ตัวบ่งชี้ที่  10.1  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 1

			---ตัวบ่งชี้ที่  10.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 2

			---ตัวบ่งชี้ที่  10.5  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 5

			---ตัวบ่งชี้ที่  10.6  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 10 And b.Sort = 6

			---ตัวบ่งชี้ที่  14.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 14 And b.Sort = 2

			---ตัวบ่งชี้ที่  15.2  คะแนนเต็ม  2.0
			Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 15 And b.Sort = 2

			---ตัวบ่งชี้ที่  13.1  คะแนนเต็ม  5.0
			Update Indicators Set ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 13 And b.Sort = 1

			---ตัวบ่งชี้ที่  13.2  คะแนนเต็ม  5.0
			Update Indicators Set ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
			From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
			And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = @StudyYear 
			And a.Sort = 13 And b.Sort = 2
		End
	End

------ Update ScoreGroup--------------
Update ScoreGroup Set ScoreGroupName = 'หมวดคะแนนเต็ม 0.5' Where ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
Update ScoreGroup Set ScoreGroupName = 'หมวดคะแนนเต็ม 1.0' Where ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
Update ScoreGroup Set ScoreGroupName = 'หมวดคะแนนเต็ม 2.0' Where ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
Update ScoreGroup Set ScoreGroupName = 'หมวดคะแนนเต็ม 5.0' Where ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'

--00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000



--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-----------------5.0.1----5.0.2---------------------------
------------เปลี่ยนผู้ดูแลระบบให้ตั้งค่าแทนฝ่ายแผน-----------------------------
Update MenuRole Set UserRoleID = '869f7a68-dd78-4f03-9320-e28b76e219fc' Where MySubMenuID = 'C7C199C5-0CDB-4004-83E5-33ED40A5442D' And UserRoleID = '46aada1c-386e-4be8-be6d-6efdc96a9537'


--เพิ่มเมนูรายงานต้นทุนกิจกรรม
If Not Exists(Select * From MySubMenu Where MySubMenuID = '1E3EEA8A-F160-4366-8393-A9C69316B829')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('1E3EEA8A-F160-4366-8393-A9C69316B829', 'รายงานต้นทุนกิจกรรม', '434de3e9-c4d5-4bed-9b00-c7603e4c335e', 21, 'MasterData/ReportCosts.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S99.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('1E3EEA8A-F160-4366-8393-A9C69316B829', '46aada1c-386e-4be8-be6d-6efdc96a9537')
End

--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



--###########################################################################
----------------5.1.0-----------------
--เพิ่มฟิวห้อง อ. 1
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('IncomeDetail') And Name = 'ClassA1')
Begin
	alter table IncomeDetail add ClassA1 int
End

--เพิ่มฟิวห้อง อ. 2
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('IncomeDetail') And Name = 'ClassA2')
Begin
	alter table IncomeDetail add ClassA2 int
End

--เพิ่มฟิวห้อง อ. 3
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('IncomeDetail') And Name = 'ClassA3')
Begin
	alter table IncomeDetail add ClassA3 int
End


--เพิ่มฟิวห้อง ป. 1
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('IncomeDetail') And Name = 'ClassP1')
Begin
	alter table IncomeDetail add ClassP1 int
End

--เพิ่มฟิวห้อง ป. 2
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('IncomeDetail') And Name = 'ClassP2')
Begin
	alter table IncomeDetail add ClassP2 int
End

--เพิ่มฟิวห้อง ป. 3
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('IncomeDetail') And Name = 'ClassP3')
Begin
	alter table IncomeDetail add ClassP3 int
End

--เพิ่มฟิวห้อง ป. 4
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('IncomeDetail') And Name = 'ClassP4')
Begin
	alter table IncomeDetail add ClassP4 int
End

--เพิ่มฟิวห้อง ป. 5
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('IncomeDetail') And Name = 'ClassP5')
Begin
	alter table IncomeDetail add ClassP5 int
End

--เพิ่มฟิวห้อง ป. 6
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('IncomeDetail') And Name = 'ClassP6')
Begin
	alter table IncomeDetail add ClassP6 int
End


--เพิ่มฟิวห้อง ม. 1
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('IncomeDetail') And Name = 'ClassM1')
Begin
	alter table IncomeDetail add ClassM1 int
End

--เพิ่มฟิวห้อง ม. 2
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('IncomeDetail') And Name = 'ClassM2')
Begin
	alter table IncomeDetail add ClassM2 int
End

--เพิ่มฟิวห้อง ม. 3
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('IncomeDetail') And Name = 'ClassM3')
Begin
	alter table IncomeDetail add ClassM3 int
End

--เพิ่มฟิวห้อง ม. 4
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('IncomeDetail') And Name = 'ClassM4')
Begin
	alter table IncomeDetail add ClassM4 int
End

--เพิ่มฟิวห้อง ม. 5
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('IncomeDetail') And Name = 'ClassM5')
Begin
	alter table IncomeDetail add ClassM5 int
End

--เพิ่มฟิวห้อง ม. 6
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('IncomeDetail') And Name = 'ClassM6')
Begin
	alter table IncomeDetail add ClassM6 int
End

--เพิ่ม HideFlag ใน Emplyoee ให้มองไม่เห็นแต่ยังใช้งานได้
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Employee') And Name = 'HideFlag')
Begin
	alter table Employee add HideFlag bit
End

--เพิ่ม txtTarget1 ใน MR_School แก้ชื่อเรียกเป้าหมายเชิงปริมาณ เป็น ผลผลิต (Outputs) 
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'txtTarget1')
Begin
	alter table MR_School add txtTarget1 nVarChar(50)
End

--เพิ่ม txtTarget2 ใน MR_School แก้ชื่อเรียกเป้าหมายเชิงคุณภาพ เป็น ผลลัพธ์ (Outcomes)
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'txtTarget2')
Begin
	alter table MR_School add txtTarget2 nVarChar(50)
End


--เพิ่มฟิวเช็คต้นทุนศูนย์
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckCostsCenter')
Begin
	alter table MR_School add ckCostsCenter bit
End

--เพิ่ม WeightScore ใน ScoreGroup
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ScoreGroup') And Name = 'WeightScore')
Begin
	alter table ScoreGroup add WeightScore float 
End

--เพิ่มฟิวตัวเช็คกลยุทธ์ สพม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckStrategySPM')
Begin
	alter table MR_School add ckStrategySPM bit
End

--เพิ่มฟิวตัวเช็คมาตรฐาน สพม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckStandardSPM')
Begin
	alter table MR_School add ckStandardSPM bit
End

--###########################################################################



--/////////////////////////////////////////////////////////////////////////////

----------- เพิ่ม Table CostsCenter ต้นทุนศูนย์------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('CostsCenter'))
Begin
	CREATE TABLE [dbo].[CostsCenter](
		[CostsCode] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[CostsName] [nvarchar](500) NULL,
		[CostsDetail] [nvarchar](max) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_CostsCenter] PRIMARY KEY CLUSTERED
	(
		[CostsCode] ASC
	)) ON [PRIMARY]
End


----------- เพิ่ม Table CostsSubCenter ต้นทุนศูนย์ย่อย------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('CostsSubCenter'))
Begin
	CREATE TABLE [dbo].[CostsSubCenter](
		[CostsSubCode] [nvarchar](50) NOT NULL,
		[CostsCode] [nvarchar](50) NULL,
		[CostsSubName] [nvarchar](500) NULL,
		[CostsSubDetail] [nvarchar](max) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_CostsSubCenter] PRIMARY KEY CLUSTERED
	(
		[CostsSubCode] ASC
	)) ON [PRIMARY]
End


----------- เพิ่ม Table dtAcCostsCenter ต้นทุนศูนย์ของกิจกรรม------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtAcCostsCenter'))
Begin
	CREATE TABLE [dbo].[dtAcCostsCenter](
		[ActivityCode] [nvarchar](50) NULL,
		[CostsCode] [nvarchar](50) NULL,
		[CostsSubCode] [nvarchar](50) NULL,
		[CostsWeight] [float] NULL,
	 ) ON [PRIMARY]
End


----------- เพิ่ม Table StrategySPM  กลยุทธ์ สพม.------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('StrategySPM'))
Begin
	CREATE TABLE [dbo].[StrategySPM](
		[StrategySPMCode] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[StrategySPMName] [nvarchar](300) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_StrategySPM] PRIMARY KEY CLUSTERED 
	(
		[StrategySPMCode] ASC
	)) ON [PRIMARY]
End


----------- เพิ่ม Table StandardSPM  มาตรฐาน สพม.------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('StandardSPM'))
Begin
	CREATE TABLE [dbo].[StandardSPM](
		[StandardSPMCode] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[StandardSPMName] [nvarchar](300) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_StandardSPM] PRIMARY KEY CLUSTERED 
	(
		[StandardSPMCode] ASC
	)) ON [PRIMARY]
End


----------- เพิ่ม Table dtStrategySPM กลยุทธ์ สพม. ในโครงการ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtStrategySPM'))
Begin
	CREATE TABLE [dbo].[dtStrategySPM](
		[ProjectsCode] [nvarchar](50) NULL,
		[StrategySPMCode] [nvarchar](50) NULL
	) ON [PRIMARY]
End


----------- เพิ่ม Table dtStandardSPM กลยุทธ์ สพม. ในโครงการ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtStandardSPM'))
Begin
	CREATE TABLE [dbo].[dtStandardSPM](
		[ProjectsCode] [nvarchar](50) NULL,
		[StandardSPMCode] [nvarchar](50) NULL
	) ON [PRIMARY]
End


--/////////////////////////////////////////////////////////////////////////////////////////



--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

Update Employee Set HideFlag = 0 Where HideFlag Is Null
Update MR_School Set txtTarget1 = 'เชิงปริมาณ :' Where txtTarget1 Is Null
Update MR_School Set txtTarget2 = 'เชิงคุณภาพ :' Where txtTarget2 Is Null

--Update ตารางเกณฑ์ให้อยู่ท้ายสุด
Update MySubMenu Set Sort = 98 Where MySubMenuID = '331E5560-A5B6-4A5D-A08B-F0798FA5DE94'
Update MySubMenu Set Sort = 99 Where MySubMenuID = '21546c40-d0be-43ec-ae6b-b38f726b74c2'

--ลบเมนูตารางเกณฑ์ความสำเร็จให้ฝ่ายแผนดูฝ่ายเดียว
Delete MenuRole Where MySubMenuID = '331E5560-A5B6-4A5D-A08B-F0798FA5DE94' And UserRoleID = '68486861-2c0c-40f7-91e0-acd1c035c911'
Delete MenuRole Where MySubMenuID = '331E5560-A5B6-4A5D-A08B-F0798FA5DE94' And UserRoleID = '91c15c5c-3b69-4957-a15a-baf6560f891f'
Delete MenuRole Where MySubMenuID = '331E5560-A5B6-4A5D-A08B-F0798FA5DE94' And UserRoleID = '079c4976-49a8-4b30-83bf-3e13cbaa9382'

--เพิ่มเมนูต้นทุนศูนย์
If Not Exists(Select * From MySubMenu Where MySubMenuID = '9DE7B292-EBE7-4302-A5F7-71DB9BE2F700')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('9DE7B292-EBE7-4302-A5F7-71DB9BE2F700', 'ต้นทุนศูนย์', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 19, 'MasterData/CostsCenter.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S99.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('9DE7B292-EBE7-4302-A5F7-71DB9BE2F700', '46aada1c-386e-4be8-be6d-6efdc96a9537')
End

--เพิ่มเมนูต้นทุนศูนย์ย่อย
If Not Exists(Select * From MySubMenu Where MySubMenuID = '26AA67E7-62D9-4112-8380-104F7BDA3CA8')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('26AA67E7-62D9-4112-8380-104F7BDA3CA8', 'ต้นทุนศูนย์ย่อย', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 20, 'MasterData/CostsSubCenter.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S98.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('26AA67E7-62D9-4112-8380-104F7BDA3CA8', '46aada1c-386e-4be8-be6d-6efdc96a9537')
End

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4

--เพิ่ม Store เมนูมาตรฐานชาติ
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuStandardNation
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '085eb349-5ea9-42da-b9a6-69fbcfc4cf64'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '085eb349-5ea9-42da-b9a6-69fbcfc4cf64'
	End
END


--เพิ่ม Store เมนูมาตรฐานกระทรวง
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuStandardMinistry
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'd81a3ef8-46b6-471c-8104-c871be9213fe'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'd81a3ef8-46b6-471c-8104-c871be9213fe'
	End
END


--เพิ่ม Store เมนูกลยุทธ์ สพฐ.
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuStrategySPT
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '2F21019F-5861-4909-BB43-14A031FB89A7'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '2F21019F-5861-4909-BB43-14A031FB89A7'
	End
END


--เพิ่ม Store เมนูต้นทุนศูนย์  ต้นทุนศูนย์ย่อย
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuCostsCenter
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '9DE7B292-EBE7-4302-A5F7-71DB9BE2F700'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '26AA67E7-62D9-4112-8380-104F7BDA3CA8'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '1E3EEA8A-F160-4366-8393-A9C69316B829'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '9DE7B292-EBE7-4302-A5F7-71DB9BE2F700'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '26AA67E7-62D9-4112-8380-104F7BDA3CA8'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '1E3EEA8A-F160-4366-8393-A9C69316B829'
	End
END


--เพิ่ม Store เมนูกลยุทธ์ สพม.
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuStrategySPM
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '5F365E18-3144-45EF-93C5-002CD1AFBD6B'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '5F365E18-3144-45EF-93C5-002CD1AFBD6B'
	End
END


--เพิ่ม Store เมนูมาตรฐาน สพม.
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuStandardSPM
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'C2805D77-2298-4446-B4E0-637CAD2B83E8'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'C2805D77-2298-4446-B4E0-637CAD2B83E8'
	End
END


--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$



--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

----------Update ค่าตัวเช็ค
Update MR_School Set ckCostsCenter = 0 Where ckCostsCenter Is Null


--เพิ่ม Score ใน ScoreGroup
Update ScoreGroup Set WeightScore = 2 Where ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
Update ScoreGroup Set WeightScore = 1 Where ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
Update ScoreGroup Set WeightScore = 10 Where ScoreGroupID = '3D9F922B-77D7-410E-8CC1-9BEA731E4F61'
Update ScoreGroup Set WeightScore = 0.5 Where ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
Update ScoreGroup Set WeightScore = 50 Where ScoreGroupID = '5D9C042C-A0AC-42DC-9DC6-20C4B601D127'
Update ScoreGroup Set WeightScore = 100 Where ScoreGroupID = '63B1FF9E-CD47-4C46-9B6D-9F14CEA6E0C0'
Update ScoreGroup Set WeightScore = 5 Where ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
Update ScoreGroup Set WeightScore = 3 Where ScoreGroupID = '8203609C-DC86-4409-9CC8-89A8AC90674A'
Update ScoreGroup Set WeightScore = 30 Where ScoreGroupID = '950E2A3C-5B5B-4A51-8613-4EC393A1F495'
Update ScoreGroup Set WeightScore = 4 Where ScoreGroupID = 'AA41533E-12C7-4D29-8320-3CCB797A550A'
Update ScoreGroup Set WeightScore = 5 Where ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
Update ScoreGroup Set WeightScore = 0.5 Where ScoreGroupID = 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35'
Update ScoreGroup Set WeightScore = 2 Where ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
Update ScoreGroup Set WeightScore = 1 Where ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'

---เพิ่มข้อมูลต้นทุนศูนย์
If Not Exists(Select * From CostsCenter Where CostsCode = '59b4e98f-1fe5-4410-8dfb-e206d5179c78')
Begin
	INSERT INTO CostsCenter (CostsCode, StudyYear, CostsName, CostsDetail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('59b4e98f-1fe5-4410-8dfb-e206d5179c78', '2555', 'การบริการอาคารสถานที่และสภาพแวดล้อม', '', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End

If Not Exists(Select * From CostsCenter Where CostsCode = '83c7528c-91ba-4c4a-b4c2-cbfb9dfd9031')
Begin
	INSERT INTO CostsCenter (CostsCode, StudyYear, CostsName, CostsDetail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('83c7528c-91ba-4c4a-b4c2-cbfb9dfd9031', '2555', 'การจัดทำแผนงานและการประกันคุณภาพ', '', 2, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End

If Not Exists(Select * From CostsCenter Where CostsCode = 'cd823d40-bccf-424d-9967-8465b42174ce')
Begin
	INSERT INTO CostsCenter (CostsCode, StudyYear, CostsName, CostsDetail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('cd823d40-bccf-424d-9967-8465b42174ce', '2555', 'การบริหารจัดการงานวิชาการ', '', 3, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End

If Not Exists(Select * From CostsCenter Where CostsCode = '070da6f3-ee23-4d55-bef6-2acae8796de3')
Begin
	INSERT INTO CostsCenter (CostsCode, StudyYear, CostsName, CostsDetail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('070da6f3-ee23-4d55-bef6-2acae8796de3', '2555', 'การจัดกิจกรรมการเรียนการสอน', '', 4, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End

If Not Exists(Select * From CostsCenter Where CostsCode = 'e28e8b2e-0ac8-4399-b7f6-ba28d9d9f046')
Begin
	INSERT INTO CostsCenter (CostsCode, StudyYear, CostsName, CostsDetail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('e28e8b2e-0ac8-4399-b7f6-ba28d9d9f046', '2555', 'การพัฒนาและส่งเสริมทางด้านวิชาการ', '', 5, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End


If Not Exists(Select * From CostsCenter Where CostsCode = 'deff0de0-215d-4cc0-9901-6d23ba315ffd')
Begin
	INSERT INTO CostsCenter (CostsCode, StudyYear, CostsName, CostsDetail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('deff0de0-215d-4cc0-9901-6d23ba315ffd', '2555', 'การวัดผลและประเมินผลการเรียนและงานทะเบียนนักเรียน', '(จัดทำระเบียนวัดผลและประเมินผลการเรียน สร้างเครื่องมือในการวัดผลให้เป็นไปตามมาตรฐานการเรียนรีรายวิชา และมีการจัดทำคลังข้อสอบทุกกลุ่มสาระรายวิชา จัดทำเอกสารและแบบฟอร์มเกี่ยวกับการวัดผลประเมินผลการเรียนให้เกิดการดำเนินการใช้งานเป็นหลักฐาน และตามงานทะเบียนนักเรียน)
   - ค่าใช้สอยและวัสดุจัดทำเอกสาร แบบฟอร์มเกี่ยวกับการวัดผลประเมินผล
   - ค่าตอบแทน ใช้สอยและวัสดุพัฒนาจัดทำเครื่องมือการวัดผลประเมินผล
   - ค่าใช้สอยและวัสดุการพัฒนาจัดทำคลังข้อสอบ', 6, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End

If Not Exists(Select * From CostsCenter Where CostsCode = '7d6d76d0-1c56-4d42-af5e-d73f2c279ba1')
Begin
	INSERT INTO CostsCenter (CostsCode, StudyYear, CostsName, CostsDetail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('7d6d76d0-1c56-4d42-af5e-d73f2c279ba1', '2555', 'การแนะแนวการศึกษา', '(พัฒนาจัดทำเครื่องมือแนะแนวอาชีพ การศึกษาต่อ เครื่องมือวัดความถนัด ความสนใจ แนะแนวการศึกษาต่อ จัดกิจกรรมระบบดูแลช่วยเหลือนักเรียน และกิจกรรมประสานความร่วมมือ และแลกเปลี่ยนเรียนรู้ประสบการณ์ด้านการแนะแนวการศึกษากับโรงเรียนหรือเครือข่าย)
   - ค่าใช้สอยและวัสดุพัฒนาเครื่องมือและจัดกิจกรรมแนะแนวการศึกษา แนะแนวอาชีพ และแลกเปลี่ยนประสบการณ์การเรียนรู้ด้านการแนะแนว)', 7, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End

If Not Exists(Select * From CostsCenter Where CostsCode = 'f41fb8f7-373e-4a8c-93ef-8cb0a1de9cfc')
Begin
	INSERT INTO CostsCenter (CostsCode, StudyYear, CostsName, CostsDetail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('f41fb8f7-373e-4a8c-93ef-8cb0a1de9cfc', '2555', 'สนับสนุนงานกิจการนักเรียน', '', 8, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End

If Not Exists(Select * From CostsCenter Where CostsCode = '08718a59-84b6-4899-b9a7-71762062ecf9')
Begin
	INSERT INTO CostsCenter (CostsCode, StudyYear, CostsName, CostsDetail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('08718a59-84b6-4899-b9a7-71762062ecf9', '2555', 'ส่งเสริมงานบุคคล', '', 9, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End

If Not Exists(Select * From CostsCenter Where CostsCode = '33513eee-db48-4c85-8dd9-751c6dfa81b8')
Begin
	INSERT INTO CostsCenter (CostsCode, StudyYear, CostsName, CostsDetail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('33513eee-db48-4c85-8dd9-751c6dfa81b8', '2555', 'ส่งเสริมงานธุรการ', '', 10, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End

If Not Exists(Select * From CostsCenter Where CostsCode = 'ef6ab86a-07f0-4cb0-8b9c-9f353db9fea7')
Begin
	INSERT INTO CostsCenter (CostsCode, StudyYear, CostsName, CostsDetail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('ef6ab86a-07f0-4cb0-8b9c-9f353db9fea7', '2555', 'ส่งเสริมงานการเงินและพัสดุ', '', 11, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End

If Not Exists(Select * From CostsCenter Where CostsCode = '1f758851-80c3-42d2-a487-16b6cdd13803')
Begin
	INSERT INTO CostsCenter (CostsCode, StudyYear, CostsName, CostsDetail, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('1f758851-80c3-42d2-a487-16b6cdd13803', '2555', 'ส่งเสริมงานชุมชนและภาคีเครือข่าย', '', 12, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End


Update MySubMenu Set MySubMenuName = 'รายงานต้นทุนศูนย์' Where MySubMenuID = '1E3EEA8A-F160-4366-8393-A9C69316B829'


--เพิ่มเมนูกลยุทธ์ สพม.
If Not Exists(Select * From MySubMenu Where MySubMenuID = '5F365E18-3144-45EF-93C5-002CD1AFBD6B')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('5F365E18-3144-45EF-93C5-002CD1AFBD6B', 'กลยุทธ์ สพม.', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 15, 'MasterData/StrategySPM.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'SS10.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('5F365E18-3144-45EF-93C5-002CD1AFBD6B', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('5F365E18-3144-45EF-93C5-002CD1AFBD6B', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('5F365E18-3144-45EF-93C5-002CD1AFBD6B', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('5F365E18-3144-45EF-93C5-002CD1AFBD6B', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End


--เพิ่มข้อมูลกลยุทธ์ สพม.
If Not Exists(Select * From StrategySPM)
Begin
	INSERT INTO StrategySPM (StrategySPMCode, StudyYear, StrategySPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('7EECCD17-42D5-4931-8325-802F468938DB', '2555', 'พัฒนาคุณภาพและมาตรฐานการศึกษาทุกระดับตามหลักสูตรและส่งเสริมความสามารถด้านเทคโนโลยีเพื่อเป็นเครื่องมือในการเรียนรู้', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StrategySPM (StrategySPMCode, StudyYear, StrategySPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('BEBE1D85-953F-42C8-B3BB-19C90E2C63F5', '2555', 'ปลูกฝังคุณธรรม ความสำนึกในความเป็นไทย ศรัทธาและยึดมั่นการปกครองในระบอบประชาธิปไตยอันมีพระมหากษัตริย์ทรงเป็นประมุขและวิถีชีวิตตามหลักปรัชญาเศรษฐกิจพอเพียง', 2, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StrategySPM (StrategySPMCode, StudyYear, StrategySPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('CF3E8D4C-0919-4826-9245-B3BE54C25A1E', '2555', ' ขยายโอกาสทางการศึกษาให้ทั่วถึงครอบคลุมผู้เรียนในเขตพื้นที่การศึกษา ได้เรียนตามศักยภาพของตนเองและมีส่วนร่วมในการพัฒนาผู้เรียน ในเขตพัฒนาพิเศษเฉพาะกิจเขตภาคใต้', 3, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StrategySPM (StrategySPMCode, StudyYear, StrategySPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('15202A10-AA0B-4AF5-833C-4FC1812C4F18', '2555', 'พัฒนาครูและบุคลากรทางการศึกษาทั้งระบบ', 4, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StrategySPM (StrategySPMCode, StudyYear, StrategySPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('C51B7466-45B2-44E7-9DB8-25670093078C', '2555', 'พัฒนาประสิทธิภาพการจัดการศึกษา เน้นการมีส่วนร่วมจากทุกภาคส่วน', 5, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StrategySPM (StrategySPMCode, StudyYear, StrategySPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('AB0807BC-1073-4EC3-B4BA-0C964D9B342F', '2555', ' ส่งเสริมสนับสนุนการวิจัยและพัฒนานวัตกรรมการพัฒนาคุณภาพการศึกษาที่เทียบเคียงกับมาตรฐานสากล', 6, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End

Update MR_School Set ckStrategySPM = 0 Where ckStrategySPM Is Null


--เพิ่มเมนูมาตรฐาน สพม.
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'C2805D77-2298-4446-B4E0-637CAD2B83E8')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('C2805D77-2298-4446-B4E0-637CAD2B83E8', 'มาตรฐาน สพม.', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 16, 'MasterData/StandardSPM.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'SS10.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('C2805D77-2298-4446-B4E0-637CAD2B83E8', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('C2805D77-2298-4446-B4E0-637CAD2B83E8', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('C2805D77-2298-4446-B4E0-637CAD2B83E8', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('C2805D77-2298-4446-B4E0-637CAD2B83E8', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Update MR_School Set ckStandardSPM = 0 Where ckStandardSPM Is Null


--เพิ่มเมนูตั้งค่าสำหรับเจ้าหน้าที่
If Not Exists(Select * From MySubMenu Where MySubMenuID = '25338490-2A67-49BB-A10D-B9EA4076B0A2')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('25338490-2A67-49BB-A10D-B9EA4076B0A2', 'ตั้งค่าสำหรับเจ้าหน้าที่', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 1, 'MasterData/SarManage.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S0.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('25338490-2A67-49BB-A10D-B9EA4076B0A2', '869f7a68-dd78-4f03-9320-e28b76e219fc')
End

--เพิ่ม User สำหรับเจ้าหน้าที่  2 คน เป็น AdminSS และ PlannerSS
If Not Exists(Select * From Employee Where EmpID = '4E975C83-6E7B-4A48-A815-F733094B1234')
Begin
	INSERT INTO Employee (EmpID, UserName, Pwd, EmpName, Email, Tel, SchoolID, DeptCode, UserRoleID, HideFlag, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('4E975C83-6E7B-4A48-A815-F733094B1234', 'AdminSS', '+iSBLchCynpqcAk6Uu/Ung==', 'เจ้าหน้าที่ Admin', 'AD.StarSoftware@gmail.com', '029658975', '2761172b-06c4-450a-a8e7-ace3c8a49792', '52ef77d2-b705-45b7-b61e-f5baefe0dfae', '869f7a68-dd78-4f03-9320-e28b76e219fc', 0, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End

If Not Exists(Select * From Employee Where EmpID = '4C3E218F-D513-416E-BD10-B4F161717F70')
Begin
	INSERT INTO Employee (EmpID, UserName, Pwd, EmpName, Email, Tel, SchoolID, DeptCode, UserRoleID, HideFlag, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('4C3E218F-D513-416E-BD10-B4F161717F70', 'PlannerSS', '+iSBLchCynpqcAk6Uu/Ung==', 'เจ้าหน้าที่ Planner', 'AD.StarSoftware@gmail.com', '029658975', '2761172b-06c4-450a-a8e7-ace3c8a49792', '4f9b4601-3f2f-4402-85aa-87c43d4911ee', '46aada1c-386e-4be8-be6d-6efdc96a9537', 0, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End


--เพิ่มข้อมูลมาตรฐาน สพม.
If Not Exists(Select * From StandardSPM)
Begin
	INSERT INTO StandardSPM (StandardSPMCode, StudyYear, StandardSPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('ef43e074-48cb-4c33-baa5-2bd6f3ebe074', '2555', 'ผู้เรียนมีสุขภาวะที่ดีและมีสุนทรียภาพ', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StandardSPM (StandardSPMCode, StudyYear, StandardSPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('5173c4bd-9e14-4839-abe0-aad11e9a7a6a', '2555', 'ผู้เรียนมีคุณธรรม จริยธรรม และค่านิยมที่พึงประสงค์', 2, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StandardSPM (StandardSPMCode, StudyYear, StandardSPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('aa876ddf-48cb-47a1-89c0-f11f677156fc', '2555', 'ผู้เรียนมีทักษะในการแสวงหาความรู้ด้วยตนเอง รักเรียนรู้และพัฒนาตนเองอย่างต่อเนื่อง', 3, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StandardSPM (StandardSPMCode, StudyYear, StandardSPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('0cf6949a-8035-4c1b-b1b9-2800174b23af', '2555', 'ผู้เรียนมีความสามารถในการคิดอย่างเป็นระบบ คิดสร้างสรรค์ ตัดสินใจแก้ปัญหาได้อย่างมีสติสมเหตุผล', 4, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StandardSPM (StandardSPMCode, StudyYear, StandardSPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('9e6ff07b-41f6-4ed8-9829-fdb649ae7f45', '2555', 'ผู้เรียนมีความรู้และทักษะที่จำเป็นตามหลักสูตร', 5, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StandardSPM (StandardSPMCode, StudyYear, StandardSPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('d17a18ff-7c5e-4d55-b1e6-f34681679a2a', '2555', 'ผู้เรียนมีทักษะในการทำงาน รักการทำงาน สามารถทำงานร่วมกับผู้อื่นได้ และมีเจตคติที่ดีต่ออาชีพสุจริต', 6, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
	
    INSERT INTO StandardSPM (StandardSPMCode, StudyYear, StandardSPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('38dd31dc-7511-491f-b196-5b3442e0ab2f', '2555', 'ครูปฏิบัติงานตามบทบาทหน้าที่อย่างมีประสิทธิภาพและเกิดประสิทธิผล', 7, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StandardSPM (StandardSPMCode, StudyYear, StandardSPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('90090791-ef10-493f-b4ff-0ab8ba826da7', '2555', 'ผู้บริหารปฏิบัติงานตามบทบาทหน้าที่อย่างมีประสิทธิภาพและเกิดประสิทธิผล', 8, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StandardSPM (StandardSPMCode, StudyYear, StandardSPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('4fa25678-fb49-4cc6-977c-81fcd34f1745', '2555', 'คณะกรรมการสถานศึกษา และผู้ปกครอง ชุมชนปฏิบัติงานตามบทบาทหน้าที่อย่างมีประสิทธิภาพและเกิดประสิทธิผล', 9, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StandardSPM (StandardSPMCode, StudyYear, StandardSPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('f1f15811-ddbb-42a4-9418-b230d581d18d', '2555', 'สถานศึกษามีการจัดหลักสูตร กระบวนการเรียนรู้ และกิจกรรมพัฒนาคุณภาพผู้เรียนอย่างรอบด้าน', 10, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StandardSPM (StandardSPMCode, StudyYear, StandardSPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('26864260-21eb-4f3b-af76-f2c10ceae87f', '2555', 'สถานศึกษามีการจัดสภาพแวดล้อมและการบริการที่ส่งเสริมให้ผู้เรียนพัฒนาเต็มศักยภาพ', 11, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StandardSPM (StandardSPMCode, StudyYear, StandardSPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('6660c60d-5268-4754-9456-52ad58de3925', '2555', 'สถานศึกษามีการประกันคุณภาพภายในของสถานศึกษาตามที่กำหนดในกฎกระทรวง', 12, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StandardSPM (StandardSPMCode, StudyYear, StandardSPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('366428f4-4cad-4584-a13e-69e4b5a32ad2', '2555', 'สถานศึกษามีการสร้าง ส่งเสริม สนับสนุน ให้สถานศึกษาเป็นสังคมแห่งการเรียนรู้', 13, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StandardSPM (StandardSPMCode, StudyYear, StandardSPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('b9b4bbbd-929e-4cf7-97a9-3aab3c4e7fe4', '2555', 'การพัฒนาสถานศึกษาให้บรรลุเป้าหมายตามวิสัยทัศน์ ปรัชญา และจุดเน้นที่กำหนดขึ้น', 14, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StandardSPM (StandardSPMCode, StudyYear, StandardSPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('c6bbf306-d6c5-49b2-b50a-62970646aaaa', '2555', 'สถานศึกษาดำเนินการพัฒนาผู้เรียนตามเอกลักษณ์ของสำนักงานเขตพื้นที่การศึกษามัธยมศึกษาเขต 1  ( รักความเป็นไทย  ก้าวไกลสู่สากล )', 15, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO StandardSPM (StandardSPMCode, StudyYear, StandardSPMName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('6114a0a9-c954-40c1-b65e-ab875f5b2df9', '2555', 'การจัดกิจกรรมตามนโยบาย จุดเน้น แนวทางการปฏิรูปการศึกษา เพื่อพัฒนาและส่งเสริมสถานศึกษาให้ยกระดับคุณภาพสูงขึ้น', 16, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

End

--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

--((((((((((((((((((((((((((((((((((((Sar V 5.2.2((((((((((((((((((((((((((((((((((((((((

--เพิ่มฟิวยอดยกมาเงินรายได้สถานศึกษา
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Income') And Name = 'MaRevenue')
Begin
	alter table Income add MaRevenue float
End

--เพิ่มฟิวยอดยกมาเงินเรียนฟรี 15 ปี
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Income') And Name = 'MaFree')
Begin
	alter table Income add MaFree float
End

--เพิ่มฟิวยอดยกมาเงินสำรอง
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Income') And Name = 'MaReserve')
Begin
	alter table Income add MaReserve float
End

--เพิ่มฟิวยอดยกมาเงินอื่นๆ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Income') And Name = 'MaOther')
Begin
	alter table Income add MaOther float
End
--))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
---- เอาเมนู  ตัดงบประมาณออก ไม่ให้ผู้บริหารเห็นเมนู เพราะมีในหน้าสำหรับผู้บริหารแล้ว
Delete MenuRole Where MySubMenuID = '1807103a-3fdb-424e-af62-cdb4b4701e18' And UserRoleID = '079c4976-49a8-4b30-83bf-3e13cbaa9382'


---- เอาเมนู  ผลการประเมิน ณ ปัจจุบันออก ไม่ให้ผู้บริหารเห็นเมนู เพราะมีในหน้าสำหรับผู้บริหารแล้ว
Delete MenuRole Where MySubMenuID = 'f167696e-3dbc-4f76-abf3-582c000ba6b6' And UserRoleID = '079c4976-49a8-4b30-83bf-3e13cbaa9382'


---- เอาเมนู  สถานะการทำกิจกรรมออก ไม่ให้ผู้บริหารเห็นเมนู เพราะมีในหน้าสำหรับผู้บริหารแล้ว
Delete MenuRole Where MySubMenuID = '2d5f9e36-dc85-4e30-8894-1286653c954d' And UserRoleID = '079c4976-49a8-4b30-83bf-3e13cbaa9382'


---- เอาเมนู  จำนวนกิจกรรมตามตัวบ่งชี้ออก ไม่ให้ผู้บริหารเห็นเมนู เพราะมีในหน้าสำหรับผู้บริหารแล้ว
Delete MenuRole Where MySubMenuID = '6997f371-50c4-48ee-9f96-c3c77eba7399' And UserRoleID = '079c4976-49a8-4b30-83bf-3e13cbaa9382'


---- เอาเมนูง  บประมาณคงเหลือโครงการออก ไม่ให้ผู้บริหารเห็นเมนู เพราะมีในหน้าสำหรับผู้บริหารแล้ว
Delete MenuRole Where MySubMenuID = '66f41bc5-fb42-4ebb-b64c-0c4289e2a4bc' And UserRoleID = '079c4976-49a8-4b30-83bf-3e13cbaa9382'


---- เอาเมนู  กราฟจำนวนกิจกรรมตามตัวชี้วัดออก ไม่ให้ผู้บริหารเห็นเมนู เพราะมีในหน้าสำหรับผู้บริหารแล้ว
Delete MenuRole Where MySubMenuID = '4d957aef-26ce-4d26-997d-1807acae5d48' And UserRoleID = '079c4976-49a8-4b30-83bf-3e13cbaa9382'


---- เอาเมนู  กราฟงบประมาณในแต่ละปีออก ไม่ให้ผู้บริหารเห็นเมนู เพราะมีในหน้าสำหรับผู้บริหารแล้ว
Delete MenuRole Where MySubMenuID = 'd6294e78-3e4d-4d4d-b84b-98f93aac52bc' And UserRoleID = '079c4976-49a8-4b30-83bf-3e13cbaa9382'

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- ปรับตัวชี้วัดไมให้ประเมินเชิงคุณภาพแล้ว
Update Indicators Set QualityFlag = 0 Where QualityFlag <> 0

------ เอาเมนูจัดทำโครงการออก ให้ฝ่ายแผนเห็นคนเดียว (ยังไม่ confirm ว่าจะใช้แบบนี้)
--Delete MenuRole Where MySubMenuID = '47bc8df6-5b12-4388-b795-83c0cc06f029' And UserRoleID = '91c15c5c-3b69-4957-a15a-baf6560f891f'
--Delete MenuRole Where MySubMenuID = '47bc8df6-5b12-4388-b795-83c0cc06f029' And UserRoleID = '68486861-2c0c-40f7-91e0-acd1c035c911'

----เพิ่มเมนูรายงานต้นทุนนักเรียนต่อหัว
--If Not Exists(Select * From MySubMenu Where MySubMenuID = '49ED1507-59E9-4A4E-A460-6CC9E016E230')
--Begin
--	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
--	VALUES ('49ED1507-59E9-4A4E-A460-6CC9E016E230', 'รายงานต้นทุนนักเรียนต่อหัว', '434de3e9-c4d5-4bed-9b00-c7603e4c335e', 21, 'MasterData/ReportCosts.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S99.png')
--
--	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
--	VALUES ('49ED1507-59E9-4A4E-A460-6CC9E016E230', '46aada1c-386e-4be8-be6d-6efdc96a9537')
--
--	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
--	VALUES ('49ED1507-59E9-4A4E-A460-6CC9E016E230', '68486861-2c0c-40f7-91e0-acd1c035c911')
--
--	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
--	VALUES ('49ED1507-59E9-4A4E-A460-6CC9E016E230', '91c15c5c-3b69-4957-a15a-baf6560f891f')
--
--	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
--	VALUES ('49ED1507-59E9-4A4E-A460-6CC9E016E230', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
--
--End

----เพิ่มฟิวชื่อผู้ขายใน LogSar
--If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('LogSchoolSar') And Name = 'SaleName')
--Begin
--	alter table LogSchoolSar add SaleName nVarChar(100)
--End



--//////////////////////////////////////////////////////////////////////////////////////
--//////////////////////// ตั้งแต่ 5.2.2 ให้เริ่มจากตรงนี้  ///////////////////////////////////////
--//////////////////////// ตั้งแต่ 5.2.2 ให้เริ่มจากตรงนี้  ///////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////

--/////////////////////////// เพิ่มโหมดกลุ่มสังกัด รร. จุฬาภรณ์ //////////////////////////////////

----------- เพิ่ม Table Strategic  ยุทธศาสตร์ ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('Strategic'))
Begin
	CREATE TABLE [dbo].[Strategic](
		[StrategicCode] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[StrategicName] [nvarchar](300) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_Strategic] PRIMARY KEY CLUSTERED 
	(
		[StrategicCode] ASC
	)) ON [PRIMARY]
End

----------- เพิ่ม Table dtStrategic ยุทธศาสตร์ ในโครงการ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtStrategic'))
Begin
	CREATE TABLE [dbo].[dtStrategic](
		[ProjectsCode] [nvarchar](50) NULL,
		[StrategicCode] [nvarchar](50) NULL
	) ON [PRIMARY]
End

----------- เพิ่ม Table ProjectsMoneyDetail  งบประมาณที่ไดัรับจัดสรรโครงการ --------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('ProjectsMoneyDetail'))
Begin
	CREATE TABLE [dbo].[ProjectsMoneyDetail](
		[ProjectsCode] [uniqueidentifier] NULL,
		[MoneyNo] [int] NULL,
		[MoneyDetail] [nvarchar](max) NULL,
		[Money] [float] NULL
	) ON [PRIMARY]
End

----------- เพิ่ม Table ProjectsQuarterDetail  แผนการดำเนินงานแต่ละไตรมาส --------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('ProjectsQuarterDetail'))
Begin
	CREATE TABLE [dbo].[ProjectsQuarterDetail](
		[ProjectsCode] [uniqueidentifier] NULL,
		[QuarterNo] [int] NULL,
		[QuarterSort] [int] NULL,
		[QuarterTime] [nvarchar](300) NULL,
		[QuarterPlan] [nvarchar](max) NULL,
		[QuarterTarget] [nvarchar](max) NULL,
		[QuarterBudget] [float] NULL
	) ON [PRIMARY]
End


--เพิ่มฟิวชื่อกิจกรรมหลัก
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Projects') And Name = 'ActivityName')
Begin
	alter table Projects add ActivityName nvarchar(max)
End

--เพิ่มฟิวชื่อกิจกรรมย่อย
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Projects') And Name = 'ActivitySubName')
Begin
	alter table Projects add ActivitySubName nvarchar(max)
End

--เพิ่มฟิวปีของแผน 4 ปี
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Projects') And Name = 'YearPlan4')
Begin
	alter table Projects add YearPlan4 nvarchar(100)
End

--เพิ่มฟิวเช็คโหมดกลุ่มโรงเรียนจุฬาภรณ์
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckJuraporn')
Begin
	alter table MR_School add ckJuraporn bit
End

--เพิ่มฟิวเช็คยุทธศาสตร์
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckStrategic')
Begin
	alter table MR_School add ckStrategic bit
End

--เพิ่มข้อมูลยุทธศาสตร์
If Not Exists(Select * From Strategic)
Begin
	INSERT INTO Strategic (StrategicCode, StudyYear, StrategicName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('A7E6DD3F-3186-4FCD-8BA2-BB6F3CD459FE', '2555', 'ด้านคุณธรรม  จริยธรรม', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO Strategic (StrategicCode, StudyYear, StrategicName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('687708D6-4BC8-4581-AB9F-80272D7FA7EB', '2555', 'ด้านความเป็นเลิศทางด้านวิทยาศาสตร์', 2, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO Strategic (StrategicCode, StudyYear, StrategicName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('E2808413-4278-4D9B-9E26-4DA97C6961C8', '2555', 'ด้านความเป็นเลิศทางด้านคณิตศาสตร์', 3, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO Strategic (StrategicCode, StudyYear, StrategicName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('A4BFC715-70A5-4FF6-8355-2C94C964D01B', '2555', 'ด้านความเป็นเลิศทางด้านภาษาต่างประเทศ', 4, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')

	INSERT INTO Strategic (StrategicCode, StudyYear, StrategicName, Sort, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate)
	VALUES ('05845302-954F-42FD-8796-F9C74EA2C40A', '2555', 'ด้านความเป็นเลิศทางด้านเทคโนโลยี', 5, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067')
End

--เพิ่มเมนูยุทธศาสตร์ 
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'B4D370FF-4607-4F2B-A071-A90470A5B2E4')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('B4D370FF-4607-4F2B-A071-A90470A5B2E4', 'ยุทธศาสตร์', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 17, 'MasterData/Strategic.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S21.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B4D370FF-4607-4F2B-A071-A90470A5B2E4', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B4D370FF-4607-4F2B-A071-A90470A5B2E4', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B4D370FF-4607-4F2B-A071-A90470A5B2E4', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B4D370FF-4607-4F2B-A071-A90470A5B2E4', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

----------ลบ StoreProcedure เมนูยุทธศาสตร์
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuStrategic')
Begin
	DROP PROCEDURE ckMenuStrategic
End

----------ลบ StoreProcedure หน้าโครงการ
If Exists(Select * From Sys.Procedures Where Name = 'ckModeJulaporn')
Begin
	DROP PROCEDURE ckModeJulaporn
End

-------------------------------------------------------------------

----------Update ค่าตัวเช็ค
Update MR_School Set ckStrategic = 0 Where ckStrategic Is Null
Update MR_School Set ckJuraporn = 0 Where ckJuraporn Is Null

--ลบเมนูตั้งค่าระบบ ให้ไปอยู่ในสำหรับเจ้าหน้าที่
Delete MenuRole Where MySubMenuID = 'C7C199C5-0CDB-4004-83E5-33ED40A5442D'


--เพิ่ม Store เมนูยุทธศาสตร์
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuStrategic
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'B4D370FF-4607-4F2B-A071-A90470A5B2E4'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'B4D370FF-4607-4F2B-A071-A90470A5B2E4'
	End
END

--เพิ่ม Store เปลี่ยนโหมดกลุ่มโรงเรียนจุฬาภรณ์
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckModeJulaporn
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set LinkName = 'MasterData/Projects.aspx' Where MySubMenuID = '47bc8df6-5b12-4388-b795-83c0cc06f029'
	End
	Else
	Begin
		Update MySubMenu Set LinkName = 'MasterData/Projects2.aspx' Where MySubMenuID = '47bc8df6-5b12-4388-b795-83c0cc06f029'
	End
END

--//////////////////////// ตั้งแต่ 5.3.2 ให้เริ่มตรงนี้  ///////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////
------------------------เพิ่ม Table AttachFile------------------------------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('Multimedia'))
Begin
CREATE TABLE [dbo].[Multimedia](
	[ItemId] [uniqueidentifier] NOT NULL  DEFAULT (newid()),
	[TypeId] [tinyint] NULL,
	[ParentId] [uniqueidentifier] NULL,
	[Title] [nvarchar](150) NULL,
	[Description] [nvarchar](500) NULL,
	[Detail] [nvarchar](max) NULL,
	[FileUrl] [nvarchar](250) NULL,
	[FileSize] [int] NULL,
	[FileType] [nvarchar](80) NULL,
	[CategoryId] [nvarchar](6) NULL,
	[SubjectId] [uniqueidentifier] NULL,
	[ChapterId] [uniqueidentifier] NULL,
	[LessonID] [uniqueidentifier] NULL,
	[DepID] [uniqueidentifier] NULL,
	[MediaYear] [nvarchar](4) NULL,
	[CreateUser] [uniqueidentifier] NULL,
	[CreateDate] [smalldatetime] NULL CONSTRAINT [DF_Multimedia_CreateDate]  DEFAULT (getdate()),
	[UpdateUser] [uniqueidentifier] NULL,
	[UpdateDate] [smalldatetime] NULL CONSTRAINT [DF_Multimedia_UpdateDate]  DEFAULT (getdate()),
	[Source] [char](1) NULL,
	[Shared] [tinyint] NULL CONSTRAINT [DF_Multimedia_Shared]  DEFAULT ((0)),
	[Enabled] [bit] NULL CONSTRAINT [DF_Multimedia_Enabled]  DEFAULT ((1)),
	[SchoolID] [varchar](5) NULL,
	[ReferID] [uniqueidentifier] NULL,
	[Flag] [bit] NULL CONSTRAINT [DF_Multimedia_Flag]  DEFAULT ((0)),
 CONSTRAINT [PK_Multimedia] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)) ON [PRIMARY]
End

------------------------เพิ่ม Store AttachFile------------------------------------
----------ลบ StoreProcedure เมนูยุทธศาสตร์
If Exists(Select * From Sys.Procedures Where Name = 'getAttachFile')
Begin
	DROP PROCEDURE getAttachFile
End

Create PROCEDURE [dbo].[getAttachFile]
	@ReferID uniqueidentifier
AS
BEGIN
	SET NOCOUNT ON;
	Select ItemID, Title, FileUrl, Filesize, ReferID, FileType, TypeId
	From Multimedia 
	Where ReferID = @ReferID 
	Order By CreateDate
END

--//////////////////////// ตั้งแต่ 5.4.0 ให้เริ่มตรงนี้  ///////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////
--/////////////////////////////////////////////////////////////////////////////////////

--เพิ่มฟิวผู้อนุมัติ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'ApproveUser')
Begin
	alter table Activity add ApproveUser nvarchar(50)
End
---/////////////ส่วนนี้ไม่ต้อง Run////////////
----เพิ่มวันที่เริ่มต้น
--If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('LogSchoolSar') And Name = 'sDate')
--Begin
--	alter table LogSchoolSar add sDate datetime
--End
--
----เพิ่มวันที่สิ้นสุด
--If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('LogSchoolSar') And Name = 'eDate')
--Begin
--	alter table LogSchoolSar add eDate datetime
--End
---///////////////ส่วนนี้ไม่ต้อง Run////////////



-- Store ใช้ AutoUpdate
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateScriptByName]
	@storedprocedure_name sysname
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @sphelptext TABLE(script NVARCHAR(MAX));
	INSERT INTO @sphelptext EXEC sp_helptext @storedprocedure_name;
	SELECT script FROM @sphelptext
END
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateScriptDatabase]
	 @PATH nvarchar(500),
	 @V NCHAR(2) = N'V',
	 @P NCHAR(2) = N'P',
	 @FN NCHAR(2) = N'FN',
	 @TF NCHAR(2) = N'TF',
	 @IF NCHAR(2) = N'IF'
AS
BEGIN

	SET NOCOUNT ON;
	EXEC master.dbo.sp_configure 'show advanced options', 1
	RECONFIGURE WITH OVERRIDE

	EXEC master.dbo.sp_configure 'xp_cmdshell', 1
	RECONFIGURE WITH OVERRIDE

	DECLARE @object_name nvarchar(150)
	DECLARE @cmd VARCHAR(4000)

	DECLARE spCursor CURSOR FAST_FORWARD FOR SELECT name FROM sys.objects WHERE TYPE IN (@V, @P, @TF, @IF, @FN) ORDER BY create_date
	OPEN spCursor
	FETCH NEXT FROM spCursor INTO @object_name
	WHILE @@fetch_status = 0
	BEGIN

	SET @cmd = 'bcp "exec [' + DB_NAME() + '].dbo.GenerateScriptByName ' +
	  @object_name + '" queryout "'+ @PATH + @object_name + '.sql" -c -UTF8 -T -S' + @@ServerName
	 --PRINT @cmd
	 EXEC master..xp_cmdshell @cmd

	 FETCH NEXT FROM spCursor INTO @object_name
	END
	CLOSE spCursor
	DEALLOCATE spCursor
END
GO


--*********************Ver 5.5.0*** หรือ Ver 10.1.0.0 **************************
--****************************************************************************
--****************************************************************************

--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

----------ลบ StoreProcedure เมนูนโยบาย
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuPolicy')
Begin
	DROP PROCEDURE ckMenuPolicy
End

--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


--)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

--เพิ่มฟิวเช็คนโยบาย
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckPolicy')
Begin
	alter table MR_School add ckPolicy bit
End

----------- เพิ่ม Table Policy  นโยบาย------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('Policy'))
Begin
	CREATE TABLE [dbo].[Policy](
		[PolicyCode] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[PolicyName] [nvarchar](500) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_Policy] PRIMARY KEY CLUSTERED 
	(
		[PolicyCode] ASC
	)) ON [PRIMARY]
End

----------- เพิ่ม Table dtPolicy นโยบาย ในโครงการ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtPolicy'))
Begin
	CREATE TABLE [dbo].[dtPolicy](
		[ProjectsCode] [nvarchar](50) NULL,
		[PolicyCode] [nvarchar](50) NULL
	) ON [PRIMARY]
End

--เพิ่มฟิว ลิงค์ใช้ Update
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'UpdateLink')
Begin
	alter table MR_School add UpdateLink nVarChar(200)
End

--เพิ่มฟิว ลิงค์ LogSar
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'LogSarLink')
Begin
	alter table MR_School add LogSarLink nVarChar(200)
End

--เพิ่มฟิว ส่ง Email แจ้งปัญหา
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'MailTo')
Begin
	alter table MR_School add MailTo nVarChar(200)
End

--เพิ่มฟิว CreateUser
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ScoreGroup') And Name = 'CreateUser')
Begin
	alter table ScoreGroup add CreateUser nVarChar(50)
End

--เพิ่มฟิว CreateDate
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ScoreGroup') And Name = 'CreateDate')
Begin
	alter table ScoreGroup add CreateDate datetime
End

--เพิ่มฟิว UpdateUser
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ScoreGroup') And Name = 'UpdateUser')
Begin
	alter table ScoreGroup add UpdateUser nVarChar(50)
End

--เพิ่มฟิว UpdateDate
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ScoreGroup') And Name = 'UpdateDate')
Begin
	alter table ScoreGroup add UpdateDate datetime
End

--เพิ่มฟิว DelFlag
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ScoreGroup') And Name = 'DelFlag')
Begin
	alter table ScoreGroup add DelFlag bit
End

--เพิ่มฟิวเช็ค FullText
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckFullText')
Begin
	alter table MR_School add ckFullText bit
End

--เพิ่มฟิวเช็ค ckBudgetYear
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckBudgetYear')
Begin
	alter table MR_School add ckBudgetYear bit
End

--เพิ่มฟิว งบประมาณตั้งไว้ ในโครงการ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Projects') And Name = 'SetBudget')
Begin
	alter table Projects add SetBudget float
End

--เพิ่มฟิว จำนวนที่เบิก ในเบิกย่อย
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ActivityCostsDetail') And Name = 'TotalDD')
Begin
	alter table ActivityCostsDetail add TotalDD float
End

--)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
--)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))


--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

--เพิ่ม Store เมนูนโยบาย
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuPolicy
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'D14CBB7A-A320-4965-B2E8-BC29EA4ABCFF'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'D14CBB7A-A320-4965-B2E8-BC29EA4ABCFF'
	End
END

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--เพิ่มเมนูนโยบาย
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'D14CBB7A-A320-4965-B2E8-BC29EA4ABCFF')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('D14CBB7A-A320-4965-B2E8-BC29EA4ABCFF', 'นโยบาย', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 21, 'MasterData/Policy.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S22.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('D14CBB7A-A320-4965-B2E8-BC29EA4ABCFF', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('D14CBB7A-A320-4965-B2E8-BC29EA4ABCFF', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('D14CBB7A-A320-4965-B2E8-BC29EA4ABCFF', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('D14CBB7A-A320-4965-B2E8-BC29EA4ABCFF', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

--เพิ่มกลุ่มคะแนน
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'CE8D26A2-0ABF-4D25-A849-D3793F6210D0')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('CE8D26A2-0ABF-4D25-A849-D3793F6210D0', 'กลุ่มคะแนน', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 97, 'MasterData/ScoreGroup.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'SS12.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('CE8D26A2-0ABF-4D25-A849-D3793F6210D0', '46aada1c-386e-4be8-be6d-6efdc96a9537')
End

Update MR_School Set ckPolicy = 0 Where ckPolicy Is Null
Update MySubMenu Set Sort = 96 Where MySubMenuID = 'B906F7F0-E09C-4C3B-A2F6-DFF9806A1955'

Update MR_School Set UpdateLink = 'http://122.155.0.135/ProductUpdate'
Update MR_School Set LogSarLink = 'http://122.155.0.135/Sar/MasterData/LogSchoolSar.aspx'
Update MR_School Set MailTo = 'noom.lfc@hotmail.com'

Update ScoreGroup Set CreateUser = '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A'
Update ScoreGroup Set CreateDate = getdate()
Update ScoreGroup Set UpdateUser = '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A'
Update ScoreGroup Set UpdateDate = getdate()
Update ScoreGroup Set DelFlag = 0

Update MySubMenu Set ImgName = 'S22.png'  Where MySubMenuID = 'D14CBB7A-A320-4965-B2E8-BC29EA4ABCFF'
Update MR_School Set ckFullText = 0 Where ckFullText Is Null
Update MR_School Set ckBudgetYear = 0 Where ckBudgetYear Is Null
Update Projects Set SetBudget = 0 Where SetBudget Is Null
Update ActivityCostsDetail Set TotalDD = 0 Where TotalDD Is Null

Update TCriteria Set CreateUser = '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A'
Where (Day(CreateDate) = 9 And Month(CreateDate) = 8 And Year(CreateDate) = 2011)
or(Day(CreateDate) = 14 And Month(CreateDate) = 9 And Year(CreateDate) = 2012)

--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


--*********************Ver 10.2.0.0 **************************
--****************************************************************************
--****************************************************************************

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--เพิ่มฟิวเช็ค ckSale
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckSale')
Begin
	alter table MR_School add ckSale bit
End

--เพิ่มฟิวเช็ค ckWord
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckWord')
Begin
	alter table MR_School add ckWord bit
End
--เพิ่มฟิวเช็ค ckExcel
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckExcel')
Begin
	alter table MR_School add ckExcel bit
End
--เพิ่มฟิวเช็ค ckPDF
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckPDF')
Begin
	alter table MR_School add ckPDF bit
End

--เพิ่มฟิวเช็คการยกโครงการ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Projects') And Name = 'RefProjectsCode')
Begin
	alter table Projects add RefProjectsCode nvarchar(50)
End

----------- เพิ่ม Table LogUndoActivity  เก็บ Log การ Undo กิจกรรม------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('LogUndoActivity'))
Begin
	CREATE TABLE [dbo].[LogUndoActivity](
		[LogID] [nvarchar](50) NOT NULL,
		[Detail] [nvarchar](500) NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL
	 CONSTRAINT [PK_LogUndoActivity] PRIMARY KEY CLUSTERED 
	(
		[LogID] ASC
	)) ON [PRIMARY]
End

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

--********************************************************
--*****************ver 10.3.0*****************************

----------- เพิ่ม Table ResponseProblems  ปัญหาของโครงการ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('ResponseProblems'))
Begin
	CREATE TABLE [dbo].[ResponseProblems](
		[ResponseProblemsCode] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[ResponseProblemsName] [nvarchar](300) NULL,
		[Detail] [nvarchar](2000) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_ResponseProblems] PRIMARY KEY CLUSTERED 
	(
		[ResponseProblemsCode] ASC
	)) ON [PRIMARY]
End

----------- เพิ่ม Table dtResponseProblems  ปัญหาของโครงการ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtResponseProblems'))
Begin
	CREATE TABLE [dbo].[dtResponseProblems](
		[ResponseProblemsCode] [nvarchar](50) NULL,
		[ProjectsCode] [nvarchar](50) NULL
	 ) ON [PRIMARY]
End

--เพิ่มฟิวเช็คแบบประเมิน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckEstimate')
Begin
	alter table MR_School add ckEstimate bit
End

--เพิ่มฟิวเช็คโหมดโครงการตอบสนองปัญหาปีที่ผ่านมา
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckResponseProblems')
Begin
	alter table MR_School add ckResponseProblems bit
End

--เพิ่มฟิวโครงการตอบสนองปัญหาปีที่ผ่านมาในโครงการ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Projects') And Name = 'ResponseProblemsCode')
Begin
	alter table Projects add ResponseProblemsCode nVarchar(50)
End

--เพิ่มฟิว แจ้งข้อมูลข่าวสารประกาศ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'Announce')
Begin
	alter table MR_School add Announce nVarChar(500)
End

--เพิ่มฟิว ชื่อหัวหน้างาน/กลุ่มสาระ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ManagerSaraGroupName')
Begin
	alter table MR_School add ManagerSaraGroupName nVarChar(80)
End

--เพิ่มฟิว ชื่อหัวหน้างานนโยบายและแผน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ManagerPlanName')
Begin
	alter table MR_School add ManagerPlanName nVarChar(80)
End

--เพิ่มฟิว ชื่อตำแหน่งหัวหน้างานนโยบายและแผน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'PositionPlanName')
Begin
	alter table MR_School add PositionPlanName nVarChar(80)
End

--เพิ่มฟิว ชื่อหัวหน้างานพัสดุ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ManagerSuppliesName')
Begin
	alter table MR_School add ManagerSuppliesName nVarChar(80)
End

--เพิ่มฟิว ชื่อตำแหน่งหัวหน้างานพัสดุ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'PositionSuppliesName')
Begin
	alter table MR_School add PositionSuppliesName nVarChar(80)
End

--เพิ่มฟิว ชื่อหัวหน้างานการเงิน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ManagerMoneyName')
Begin
	alter table MR_School add ManagerMoneyName nVarChar(80)
End

--เพิ่มฟิว ชื่อตำแหน่งหัวหน้างานการเงิน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'PositionMoneyName')
Begin
	alter table MR_School add PositionMoneyName nVarChar(80)
End

--เพิ่มฟิว ชื่อรอง ผอ. กลุ่มบริหารงานงบประมาณ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'UnderBudgetName')
Begin
	alter table MR_School add UnderBudgetName nVarChar(80)
End

--เพิ่มฟิว ชื่อตำแหน่งรอง ผอ. กลุ่มบริหารงานงบประมาณ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'PositionManagerBudgetName')
Begin
	alter table MR_School add PositionManagerBudgetName nVarChar(80)
End

--เพิ่มฟิว งบประมาณของหน่วยงาน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('dtAcDept') And Name = 'TotalAmount')
Begin
	alter table dtAcDept add TotalAmount float
End


--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

--เพิ่ม Store เมนูปัญหาโครงการ
--If Not Exists(Select * From Sys.PROCEDURES Where Object_ID = Object_ID('ckMenuResponseProblems'))
--Begin
	SET ANSI_NULLS ON
		GO
		SET QUOTED_IDENTIFIER ON
		GO
	CREATE PROCEDURE ckMenuResponseProblems
		@ck int
	AS
	BEGIN
		SET NOCOUNT ON;
		IF @ck = 0
		Begin
			Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'BB317793-5F98-42BF-AF5C-F0A3071AB679'
		End
		Else
		Begin
			Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'BB317793-5F98-42BF-AF5C-F0A3071AB679'
		End
	END
--End


--เพิ่ม Store โหมดปีงบประมาณ
--If Not Exists(Select * From Sys.PROCEDURES Where Object_ID = Object_ID('ckMenuBudgetYear'))
--Begin
	SET ANSI_NULLS ON
		GO
		SET QUOTED_IDENTIFIER ON
		GO
	CREATE PROCEDURE ckMenuBudgetYear
		@ck int
	AS
	BEGIN
		SET NOCOUNT ON;
		IF @ck = 0
		Begin
			Update MySubMenu Set MySubMenuName = 'ปีการศึกษา' Where MySubMenuID = '431ea9a5-3d1c-4d3d-a136-e931c2017c1f'
		End
		Else
		Begin
			Update MySubMenu Set MySubMenuName = 'ปีงบประมาณ' Where MySubMenuID = '431ea9a5-3d1c-4d3d-a136-e931c2017c1f'
		End
	END
--End

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--เพิ่มเมนูปัญหาโครงการ
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'BB317793-5F98-42BF-AF5C-F0A3071AB679')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('BB317793-5F98-42BF-AF5C-F0A3071AB679', 'ปัญหาโครงการ', 'dd43213f-becd-4d63-85a3-f2d6936aa982', 5, 'MasterData/ResponseProblems.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S23.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('BB317793-5F98-42BF-AF5C-F0A3071AB679', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('BB317793-5F98-42BF-AF5C-F0A3071AB679', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('BB317793-5F98-42BF-AF5C-F0A3071AB679', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('BB317793-5F98-42BF-AF5C-F0A3071AB679', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

-- เปลี่ยน PlannerSS ให้อยู่ในหน่วยงานบริหารทั่วไป
Update Employee Set DeptCode = '52ef77d2-b705-45b7-b61e-f5baefe0dfae' Where UserName = 'PlannerSS'

-- set ค่าเริ่มต้น
Update MR_School Set ckResponseProblems = 0
Update MR_School Set ckEstimate = 0

Update MR_School Set PositionPlanName = 'หัวหน้างานนโยบายและแผน'
Update MR_School Set PositionSuppliesName = 'หัวหน้างานพัสดุ'
Update MR_School Set PositionMoneyName = 'หัวหน้างานการเงิน'
Update MR_School Set PositionManagerBudgetName = 'รองผู้อำนวยการกลุ่มบริหารงบประมาณ'


--###############################################################################################################


--****************  10.4.0  *********************
--เพิ่มฟิว ชื่อตำแหน่งผู้รับผิดชอบกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'PositionResponsible')
Begin
	alter table MR_School add PositionResponsible nVarChar(80)
End

--เพิ่มฟิว ชื่อตำแหน่งหัวหน้างาน /กลุ่มสาระฯ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'PositionHeadGroupSara')
Begin
	alter table MR_School add PositionHeadGroupSara nVarChar(80)
End

--เพิ่มฟิว ชื่อตำแหน่งหัวหน้ากลุ่มงาน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'PositionHeadGroup')
Begin
	alter table MR_School add PositionHeadGroup nVarChar(80)
End

Go
Update MR_School Set PositionResponsible = 'ผู้รับผิดชอบกิจกรรม'
Update MR_School Set PositionHeadGroupSara = 'หัวหน้างาน/กลุ่มสาระฯ'
Update MR_School Set PositionHeadGroup = 'หัวหน้ากลุ่มงาน'
Go

--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& 10.5.0 &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

--เพิ่มฟิว โหมดอนุบาล
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckAnuban')
Begin
	alter table MR_School add ckAnuban bit
End

--เพิ่มฟิวตัวเช็คตัวชี้วัด สมศ.
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckIndicatorSMS')
Begin
	alter table MR_School add ckIndicatorSMS bit
End

--เพิ่มฟิวตัวเช็คทรัพยากรที่ต้องการ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckResource')
Begin
	alter table MR_School add ckResource bit
End

--เพิ่มฟิวทรัพยากรที่ต้องการในกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'Resource')
Begin
	alter table Activity add Resource nVarChar(1000)
End

--เพิ่มฟิวใน  มาตรฐาน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Standard') And Name = 'HowDevelopment')
Begin
	alter table Standard add HowDevelopment nVarChar(3000)
End

--เพิ่มฟิวใน  มาตรฐาน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Standard') And Name = 'resultDevelopment')
Begin
	alter table Standard add resultDevelopment nVarChar(3000)
End

--เพิ่มฟิวใน  มาตรฐาน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Standard') And Name = 'FutureDevelopment')
Begin
	alter table Standard add FutureDevelopment nVarChar(3000)
End

--เพิ่มฟิวราคาสินค้า ในเบิกย่อย
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ActivityCostsDetail') And Name = 'Cost')
Begin
	alter table ActivityCostsDetail add Cost float
End


----------- เพิ่ม Table IndicatorSMS  ตัวชี้วัด สมศ.------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('IndicatorSMS'))
Begin
	CREATE TABLE [dbo].[IndicatorSMS](
		[IndicatorSMSCode] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[IndicatorSMSName] [nvarchar](300) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_IndicatorSMS] PRIMARY KEY CLUSTERED 
	(
		[IndicatorSMSCode] ASC
	)) ON [PRIMARY]
End

----------- เพิ่ม Table dtIndicatorSMS ตัวชี้วัด สมศ. ในโครงการ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtIndicatorSMS'))
Begin
	CREATE TABLE [dbo].[dtIndicatorSMS](
		[ProjectsCode] [nvarchar](50) NULL,
		[IndicatorSMSCode] [nvarchar](50) NULL
	) ON [PRIMARY]
End

Go
----------ลบ StoreProcedure เมนูกลยุทธ์ สพฐ.
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuIndicatorSMS')
Begin
	DROP PROCEDURE ckMenuIndicatorSMS
End

Go
If Exists(Select * From Sys.Procedures Where Name = 'GenMasterAnuban')
Begin
	DROP PROCEDURE GenMasterAnuban
End

Go
Drop Function [dbo].[GetActivityName]
Go
Drop Function [dbo].[GetStandardSort]
Go
Drop Function [dbo].[GetIndicatorSort]


Go
--เพิ่ม ฟังก์ชั่น get กิจกรรม
CREATE FUNCTION [dbo].[GetActivityName]
(
	@StrategiesCode nvarchar(50) , @ProjectsCode nvarchar(50)
)
RETURNS nvarchar(1500)
AS
BEGIN
	declare @ActivityName nvarchar(1000)
Select @ActivityName = coalesce(@ActivityName+char(10)+' ','')+CONVERT(varchar(10), a.Sort)+'. '+a.ActivityName
From  Strategies s , Projects p,Activity a
Where p.StrategiesCode = s.StrategiesCode and a.StrategiesCode = s.StrategiesCode and a.ProjectsCode = p.ProjectsCode
and p.ProjectsCode = @ProjectsCode and s.StrategiesCode = @StrategiesCode
Group By s.StrategiesCode,a.ActivityName,a.Sort
order by a.Sort
	RETURN @ActivityName
END

Go

CREATE FUNCTION [dbo].[GetStandardSort]
(
	 @ProjectCode nvarchar(50) , @studyYear nvarchar(4)
)
RETURNS nvarchar(1500)
AS
BEGIN
	declare @StandardSort nvarchar(1000)
Select @StandardSort = coalesce(@StandardSort+char(10)+'','')+'มตฐ.ที่ '+convert(nvarchar(5),s.Sort)+' ตัวบ่งชี้ '+ dbo.GetIndicatorSort(@ProjectCode , e.StandardCode)
from Evaluation e ,Indicators i , Standard s,Projects p 
where e.IndicatorsCode = i.IndicatorsCode and i.StandardCode = s.StandardCode and p.ProjectsCode = e.ProjectsCode
and p.ProjectsCode = @ProjectCode and s.StudyYear = @studyYear
group by s.Sort,e.StandardCode
order by s.Sort
	RETURN @StandardSort
END

Go

CREATE FUNCTION [dbo].[GetIndicatorSort]
(
	 @ProjectCode nvarchar(50)  ,@StandardCode nvarchar(50)
)
RETURNS nvarchar(1500)
AS
BEGIN
	declare @ISort nvarchar(1000)
Select @ISort = coalesce(@ISort+',','','')+Convert(nvarchar(10),i.Sort)
from Evaluation e ,Indicators i , Standard s,Projects p 
where e.IndicatorsCode = i.IndicatorsCode and i.StandardCode = s.StandardCode and p.ProjectsCode = e.ProjectsCode
and e.ProjectsCode = @ProjectCode and s.StandardCode = @StandardCode
group by s.Sort, i.Sort
order by s.Sort, i.Sort
	RETURN @ISort
END

Go
--แก้ไข Store เมนูกลยุทธ์ สพม.
Alter PROCEDURE ckMenuStrategySPM
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '5F365E18-3144-45EF-93C5-002CD1AFBD6B'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '5F365E18-3144-45EF-93C5-002CD1AFBD6B'
		IF (Select ckAnuban From MR_School) = 1 
		Begin
			Update MySubMenu Set MySubMenuName = 'กลยุทธ์ สพป.' Where MySubMenuID = '5F365E18-3144-45EF-93C5-002CD1AFBD6B'
		End
		Else
		Begin
			Update MySubMenu Set MySubMenuName = 'กลยุทธ์ สพม.' Where MySubMenuID = '5F365E18-3144-45EF-93C5-002CD1AFBD6B'
		End
	End
END

Go
--เพิ่ม Store เมนูตัวชี้วัด สมศ.
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuIndicatorSMS
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '32F3AF64-3838-4496-BEC5-4139E799D787'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '32F3AF64-3838-4496-BEC5-4139E799D787'
	End
END

Go
-- เพิ่ม Store  ด้าน มาตรฐาน  ตัวชี้วัด ของอนุบาล
Create PROCEDURE [dbo].[GenMasterAnuban]
		@StudyYear int
	AS
	BEGIN
		SET NOCOUNT ON;

		INSERT [dbo].[Side] ([SideCode], [StudyYear], [SideName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID]) VALUES (N'3b43d652-cccb-4004-b884-2a136b2b9de2', @StudyYear, N'ด้านอัตลักษณ์ของสถานศึกษา', 4, 0, CAST(0x0000A3C40112DD5C AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C40112DD5C AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
		INSERT [dbo].[Side] ([SideCode], [StudyYear], [SideName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID]) VALUES (N'52c20179-474a-4ab0-9ab1-4ae2f668f23d', @StudyYear, N'ด้านคุณภาพผู้เรียน', 1, 0, CAST(0x0000A3C40111450E AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C40111450E AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', N'4996ad20-57fc-4dbc-a01d-698393d7affb')
		INSERT [dbo].[Side] ([SideCode], [StudyYear], [SideName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID]) VALUES (N'a84fc559-86d0-4b59-9460-6d62a36d300d', @StudyYear, N'ด้านมาตรการส่งเสริม', 5, 0, CAST(0x0000A3C4011311ED AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C4011311ED AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')
		INSERT [dbo].[Side] ([SideCode], [StudyYear], [SideName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID]) VALUES (N'd6f83d04-1391-4290-80b7-c9c407ae0ff1', @StudyYear, N'ด้านการจัดการศึกษา', 2, 0, CAST(0x0000A3C4011250CA AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C401153D0A AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', N'fe43801a-1fa1-4cc1-8789-385df50aa650')
		INSERT [dbo].[Side] ([SideCode], [StudyYear], [SideName], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID]) VALUES (N'e845a4a6-006d-4e9a-85dc-92bfe879d8e9', @StudyYear, N'ด้านการสร้างสังคมแห่งการเรียนรู้', 3, 0, CAST(0x0000A3C40112B3BE AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C40112B3BF AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', N'B434D787-CBAA-41E5-BA94-DDB60A8E3952')

		INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES (N'0e3a4d70-2f44-4fc3-96bb-662ded72ed79', N'สถานศึกษามีการสร้าง ส่งเสริม สนับสนุนให้สถานศึกษาเป็นสังคมแห่งการเรียนรู้', N'e845a4a6-006d-4e9a-85dc-92bfe879d8e9', @StudyYear, N'', 9, 0, CAST(0x0000A3C5008FF54F AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5008FF54F AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', N'B434D787-CBAA-41E5-BA94-DDB60A8E3952', NULL, NULL, NULL)
		INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES (N'3ee683ba-7a5a-439f-91d6-4fcfe86e6357', N'เด็กมีพัฒนาการด้านสังคม', N'52c20179-474a-4ab0-9ab1-4ae2f668f23d', @StudyYear, N'', 3, 0, CAST(0x0000A3C40116053B AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C40116053C AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', N'B434D787-CBAA-41E5-BA94-DDB60A8E3952', NULL, NULL, NULL)
		INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES (N'599c7392-ac95-4a59-947e-28e24708c964', N'การพัฒนาสถานศึกษาให้บรรลุเป้าหมายตามปรัชญา วิสัยทัศน์ และจุดเน้นของการศึกษาปฐมวัย', N'3b43d652-cccb-4004-b884-2a136b2b9de2', @StudyYear, N'', 10, 0, CAST(0x0000A3C5009044B4 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5009044B4 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', N'B434D787-CBAA-41E5-BA94-DDB60A8E3952', NULL, NULL, NULL)
		INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES (N'599fe197-6368-4ba7-a63e-75dbbf7657f4', N'เด็กมีพัฒนาการด้านอารมณ์และจิตใจ', N'52c20179-474a-4ab0-9ab1-4ae2f668f23d', @StudyYear, N'', 2, 0, CAST(0x0000A3C40115DEC8 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C40115DEC8 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', N'B434D787-CBAA-41E5-BA94-DDB60A8E3952', NULL, NULL, NULL)
		INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES (N'75ec63a6-4952-46c8-97c8-6f973a76ea92', N'เด็กมีพัฒนาการด้านร่างกาย', N'52c20179-474a-4ab0-9ab1-4ae2f668f23d', @StudyYear, N'', 1, 0, CAST(0x0000A3C40115B261 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500F1397A AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', N'B434D787-CBAA-41E5-BA94-DDB60A8E3952', N'eeee', N'eee', N'eee')
		INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES (N'8301ceeb-0203-48db-ac3b-feb400f4a33e', N'เด็กมีพัฒนาการด้านสติปัญญา', N'52c20179-474a-4ab0-9ab1-4ae2f668f23d', @StudyYear, N'', 4, 0, CAST(0x0000A3C401161F4D AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C401161F4D AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', N'B434D787-CBAA-41E5-BA94-DDB60A8E3952', NULL, NULL, NULL)
		INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES (N'85397099-408b-4794-b45c-822b6b03b0b8', N'แนวการจัดการศึกษา', N'd6f83d04-1391-4290-80b7-c9c407ae0ff1', @StudyYear, N'', 7, 0, CAST(0x0000A3C40116C6A4 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C40116C6A4 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', N'4996ad20-57fc-4dbc-a01d-698393d7affb', NULL, NULL, NULL)
		INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES (N'a0193755-9c06-46ab-9a19-43daa05d3527', N'สถานศึกษามีการประกันคุณภาพภายในของสถานศึกษาตามที่กำหนดในกฎกระทรวง', N'd6f83d04-1391-4290-80b7-c9c407ae0ff1', @StudyYear, N'', 8, 0, CAST(0x0000A3C401174E04 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C40117FA9E AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', N'c68263a8-5339-41f6-a19a-9e02167577b4', NULL, NULL, NULL)
		INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES (N'dd3a1a57-b28c-4660-a1e1-7ddd418fa2f2', N'ผู้บริหารปฏิบัติงานตามบทบาทหน้าที่อย่างประสิทธิภาพ และเกิดประสิทธิผล', N'd6f83d04-1391-4290-80b7-c9c407ae0ff1', @StudyYear, N'', 6, 0, CAST(0x0000A3C40116A774 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C40116A774 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', N'4996ad20-57fc-4dbc-a01d-698393d7affb', NULL, NULL, NULL)
		INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES (N'e9666e03-a004-4481-92d6-a8aba3fb0fc1', N'การพัฒนาสถานศึกษาตามนโยบายและแนวทางปฏิรูปการศึกษาเพื่อยกระดับคุณภาพให้สูงขึ้น', N'a84fc559-86d0-4b59-9460-6d62a36d300d', @StudyYear, N'', 11, 0, CAST(0x0000A3C500909DA9 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500909DA9 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', N'B434D787-CBAA-41E5-BA94-DDB60A8E3952', NULL, NULL, NULL)
		INSERT [dbo].[Standard] ([StandardCode], [StandardName], [SideCode], [StudyYear], [Note], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [ScoreGroupID], [HowDevelopment], [resultDevelopment], [FutureDevelopment]) VALUES (N'fa9f2aca-9617-482e-a66b-abb8d8c1c6fc', N'ครูปฏิบัติงานตามบทบาทหน้าที่อย่างมีประสิทธิภาพและเกิดประสิทธิผล', N'd6f83d04-1391-4290-80b7-c9c407ae0ff1', @StudyYear, N'', 5, 0, CAST(0x0000A3C40116650B AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C40116650B AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', N'4996ad20-57fc-4dbc-a01d-698393d7affb', NULL, NULL, NULL)


		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'019646f1-45b5-47d8-aacd-adc86ad4f5c7', N'dd3a1a57-b28c-4660-a1e1-7ddd418fa2f2', N'ผู้บริหารเข้าใจปรัชญาและหลักการจัดการศึกษาปฐมวัย', N'', N'', 3, N'', N'', 1, 0, CAST(0x0000A3C5009B6C0F AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5009B6C0F AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'8203609C-DC86-4409-9CC8-89A8AC90674A')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'0a8b47aa-c21c-44c8-bb4e-7c2c58204b06', N'3ee683ba-7a5a-439f-91d6-4fcfe86e6357', N'ประพฤติตนตามวัฒนธรรมไทยและศาสนาที่ตนนับถือ', N'', N'', 1, N'', N'', 4, 0, CAST(0x0000A3C500970DD7 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500970DD7 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'0aafff65-7bd8-48fe-a559-be0ace41a8e0', N'fa9f2aca-9617-482e-a66b-abb8d8c1c6fc', N'ครูจัดทำสารนิทัศน์และนำมาไตร่ตรองเพื่อใช้ประโยชน์ในการพัฒนาเด็ก', N'', N'', 2, N'', N'', 10, 0, CAST(0x0000A3C5009AAEF0 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5009AAEF0 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'17683e2e-a97f-4cbc-b219-5f8bdef74fe2', N'e9666e03-a004-4481-92d6-a8aba3fb0fc1', N'จัดโครงการ กิจกรรมส่งเสริมสนับสนุนตามนโยบายเกี่ยวกับการจัดการศึกษาปฐมวัย', N'', N'', 3, N'', N'', 1, 0, CAST(0x0000A3C500B038EA AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500B038EA AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'8203609C-DC86-4409-9CC8-89A8AC90674A')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'1d864ecc-5f00-4df4-8eb6-9c3d5f6b63df', N'599c7392-ac95-4a59-947e-28e24708c964', N'จัดโครงการ กิจกรรมที่ส่งเสริมให้เด็กบรรลุตามเป้าหมายปรัชญาวิสัยทัศน์และจุดเน้นการจัดการศึกษาปฐมวัยของสถานศึกษา', N'', N'', 3, N'', N'', 1, 0, CAST(0x0000A3C500AFD785 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500AFD785 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'8203609C-DC86-4409-9CC8-89A8AC90674A')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'2397fbfe-9b5e-4d37-b52d-5ba0501059eb', N'599fe197-6368-4ba7-a63e-75dbbf7657f4', N'ควบคุมอารมณ์ตนเองได้ เหมาะสมกับวัย', N'', N'', 1, N'', N'', 3, 0, CAST(0x0000A3C5009629DB AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5009629DB AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'24f13807-426b-418c-b8be-0bb985954419', N'fa9f2aca-9617-482e-a66b-abb8d8c1c6fc', N'ครูจัดสิ่งแวดล้อมให้เกิดการเรียนรู้ได้ตลอดเวลา', N'', N'', 2, N'', N'', 7, 0, CAST(0x0000A3C50099DF8E AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C50099DF8E AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'265dd3dc-55e9-4b15-96c7-9c94ae475039', N'dd3a1a57-b28c-4660-a1e1-7ddd418fa2f2', N'ผู้บริหารมีวิสัยทัศน์ ภาวะผู้นำ และความคิดริเริ่มที่เน้นการพัฒนาเด็กปฐมวัย', N'', N'', 3, N'', N'', 2, 0, CAST(0x0000A3C5009BAB37 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5009BAB37 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'8203609C-DC86-4409-9CC8-89A8AC90674A')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'35f2e3fb-4da6-4014-9c40-da2e68088ddf', N'dd3a1a57-b28c-4660-a1e1-7ddd418fa2f2', N'ผู้บริหารให้คำแนะนำ คำปรึกษาทางวิชาการ และเอาใจใส่การจัดการศึกษาปฐมวัยเต็มศักยภาพและเต็มเวลา', N'', N'', 3, N'', N'', 6, 0, CAST(0x0000A3C5009CAD45 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5009CAD45 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'8203609C-DC86-4409-9CC8-89A8AC90674A')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'39312c18-f35b-4627-8557-8ee7d6d49a70', N'85397099-408b-4794-b45c-822b6b03b0b8', N'จัดสิ่งอำนวยความสะดวกเพื่อพัฒนาเด็กอย่างรอบด้าน', N'', N'', 4, N'', N'', 5, 0, CAST(0x0000A3C500A42710 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500A42710 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'AA41533E-12C7-4D29-8320-3CCB797A550A')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'465d23ff-775b-4707-85b7-6e18c572434d', N'75ec63a6-4952-46c8-97c8-6f973a76ea92', N'มีน้ำหนักส่วนสูงเป็นไปตามเกณฑ์มาตรฐาน', N'', N'', 1, N'', N'', 1, 0, CAST(0x0000A3C500913246 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500913246 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'49c03326-76c3-4ec0-892c-ce1b74fea61d', N'a0193755-9c06-46ab-9a19-43daa05d3527', N'ติดตามตรวจสอบและประเมินคุณภาพภายในตามมาตรฐานการศึกษาของสถานศึกษา', N'', N'', 0.5, N'', N'', 4, 0, CAST(0x0000A3C500A94E0B AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500C0850A AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'422A806A-D3F6-41B0-BBAA-C40CEB3E23B8')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'560ff109-d22b-49fc-b9d0-dac8e8d429cf', N'fa9f2aca-9617-482e-a66b-abb8d8c1c6fc', N'ครูมีวุฒิและความรู้ความสามารถในด้านการศึกษาปฐมวัย', N'', N'', 2, N'', N'', 9, 0, CAST(0x0000A3C5009A3A58 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5009A3A58 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'586329fc-9f98-4f9d-9d11-1c3491f246f5', N'fa9f2aca-9617-482e-a66b-abb8d8c1c6fc', N'ครูเข้าใจปรัชญา หลักการ และธรรมชาติของการจัดการศึกษาปฐมวัยและสามารถนำมาประยุกต์ใช้ในการจัดประสบการณ์', N'', N'', 2, N'', N'', 1, 0, CAST(0x0000A3C500987B8E AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500987B8E AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'5aec91b6-3690-413d-b9ea-019bb0997eb1', N'dd3a1a57-b28c-4660-a1e1-7ddd418fa2f2', N'ผู้บริหารส่งเสริมและพัฒนาศัยกภาพของบุคลากรให้มีประสิทธิภาพ', N'', N'', 3, N'', N'', 5, 0, CAST(0x0000A3C5009C6684 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5009C6684 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'8203609C-DC86-4409-9CC8-89A8AC90674A')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'65879b64-5a90-40bc-a00f-9d9403f891f5', N'a0193755-9c06-46ab-9a19-43daa05d3527', N'จัดระบบข้อมูลสารสนเทศและใช้สารสนเทศในการบริหารจัดการ', N'', N'', 1, N'', N'', 3, 0, CAST(0x0000A3C500A90876 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500A90877 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'6632593f-07f5-4f26-893b-2610cfd193fd', N'fa9f2aca-9617-482e-a66b-abb8d8c1c6fc', N'ครูบริหารจัดการชั้นเรียนที่สร้างวินัยเชิงบวก', N'', N'', 2, N'', N'', 3, 0, CAST(0x0000A3C500991219 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500991219 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'6f5c0f79-3921-4456-b2ce-50cffc41c796', N'8301ceeb-0203-48db-ac3b-feb400f4a33e', N'มีความคิดรวบยอดเกี่ยวกับสิ่งต่าง ๆ ที่เกิดจากประสบการณ์การเรียนรู้', N'', N'', 1, N'', N'', 2, 0, CAST(0x0000A3C500978C82 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500978C83 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'71dbdcf1-cf23-4c9c-b218-90bd3bb637bf', N'0e3a4d70-2f44-4fc3-96bb-662ded72ed79', N'มีการแลกเปลี่ยนเรียนรู้ระหว่างบุคลากรภายในสถานศึกษาระหว่างสถานศึกษากับครอบครัว', N'', N'', 2.5, N'', N'', 2, 0, CAST(0x0000A3C500AF8038 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500AF8038 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'921aae33-10ee-4c06-9818-361c88f75dbd')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'7813a1e4-81b0-43db-9ba8-86c6430ddd56', N'85397099-408b-4794-b45c-822b6b03b0b8', N'สร้างการมีส่วนร่วมและแสวงหาความร่วมมือกับผู้ปกครอง ชุมชนและท้องถิ่น', N'', N'', 4, N'', N'', 4, 0, CAST(0x0000A3C500A40432 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500A40432 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'AA41533E-12C7-4D29-8320-3CCB797A550A')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'78644ecf-7886-45a1-9ff1-64446f5343fc', N'8301ceeb-0203-48db-ac3b-feb400f4a33e', N'มีจิตนาการและความคิดสร้างสรรค์', N'', N'', 1, N'', N'', 5, 0, CAST(0x0000A3C50097FC83 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C50097FC83 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'79bc72d2-a029-4e9a-a0e7-a39c6aab8b65', N'8301ceeb-0203-48db-ac3b-feb400f4a33e', N'สนใจเรียนรู้สิ่งรอบตัว ซักถามอย่างตั้งใจ และรักการเรียนรู้', N'', N'', 1, N'', N'', 1, 0, CAST(0x0000A3C5009759A7 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5009759A8 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'7d17fb0b-d4d1-43a0-ae81-812e0f5cd882', N'85397099-408b-4794-b45c-822b6b03b0b8', N'จัดกิจกรรมเสริมสร้างความตะหนักรู้และเข้าใจหลักการจัดการศึกษาปฐมวัย', N'', N'', 4, N'', N'', 3, 0, CAST(0x0000A3C500A3D2AA AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500A3D2AA AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'AA41533E-12C7-4D29-8320-3CCB797A550A')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'84ac6d75-3c56-41e4-a508-83d31caa01bf', N'85397099-408b-4794-b45c-822b6b03b0b8', N'มีหลักสูตรการศึกษาปฐมวัยของสถานศึกษา และนำสู่การปฏิบัติได้อย่างมีประสิทธิภาพ', N'', N'', 4, N'', N'', 1, 0, CAST(0x0000A3C500A3152D AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500A3152D AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'AA41533E-12C7-4D29-8320-3CCB797A550A')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'87fa59a5-762f-4bf6-bb35-4d9519ffb8ad', N'0e3a4d70-2f44-4fc3-96bb-662ded72ed79', N'เป็นแหล่งเรียนรู้เพื่อพัฒนาการเรียนรู้ของเด็กและบคลากรในสถานศึกษา', N'', N'', 2.5, N'', N'', 1, 0, CAST(0x0000A3C500AC9952 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500AF4522 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'921aae33-10ee-4c06-9818-361c88f75dbd')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'8f14e6be-e9ce-4d93-b4a0-c235b52a9a39', N'a0193755-9c06-46ab-9a19-43daa05d3527', N'จัดทำรายงานประจำปีที่เป็นรายงานการประเมินคุณภาพภายใน', N'', N'', 1, N'', N'', 6, 0, CAST(0x0000A3C500A9A4AA AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500A9A4AA AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'933dec71-642d-4dbe-96f5-2a7304443508', N'a0193755-9c06-46ab-9a19-43daa05d3527', N'นำผลการประเมินคุณภาพทั้งภายในและภายนอกไปใช้วางแผนพัฒนา', N'', N'', 0.5, N'', N'', 5, 0, CAST(0x0000A3C500A97CFA AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500C08BBD AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'422A806A-D3F6-41B0-BBAA-C40CEB3E23B8')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'9374a2e7-168d-4a58-97a5-06b9aa61afd7', N'e9666e03-a004-4481-92d6-a8aba3fb0fc1', N'ผลการดำเนินงานบรรลุเป้าหมาย', N'', N'', 2, N'', N'', 2, 0, CAST(0x0000A3C500B0547B AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500B0547B AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'948d79f8-31f2-46b0-a800-696accdaf6dc', N'fa9f2aca-9617-482e-a66b-abb8d8c1c6fc', N'ครูใช้เครื่องมือการวัดและประเมินผลพัฒนาการของเด็กอย่างหลากหลาย', N'', N'', 2, N'', N'', 5, 0, CAST(0x0000A3C500996ABA AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500996ABB AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'9a23834c-e808-405e-8e76-cc1a46e0cda0', N'599fe197-6368-4ba7-a63e-75dbbf7657f4', N'ร่าเริงแจ่มใส มีความรู้สึกที่ดีต่อตนเอง', N'', N'', 1, N'', N'', 1, 0, CAST(0x0000A3C50095C3ED AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C50095C3ED AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'9db4496e-7dc5-4cf8-9319-9062d7c479ed', N'85397099-408b-4794-b45c-822b6b03b0b8', N'มีระบบและกลไกให้ผู้มีส่วนทุกฝ่ายตระหนักและเข้าใจการจัดการศึกษาปฐมวัย', N'', N'', 4, N'', N'', 2, 0, CAST(0x0000A3C500A37CEC AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500A37CEC AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'AA41533E-12C7-4D29-8320-3CCB797A550A')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'9ebdc57e-9cb9-4dd6-986a-0ce3804e4c15', N'fa9f2aca-9617-482e-a66b-abb8d8c1c6fc', N'ครูวิจัยและพัฒนาการจัดการเรียนรู้ที่ตนรับผิดชอบและใช้ผลในการปรับการจัดประสบการณ์', N'', N'', 2, N'', N'', 6, 0, CAST(0x0000A3C50099B234 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C50099B235 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'a1b292b3-9af6-4f76-8912-29c889f69f7f', N'a0193755-9c06-46ab-9a19-43daa05d3527', N'จัดทำและดำเนินการตามแผนพัฒนาการจัดการศึกษาของสถานศึกษาที่มุ่งคุณภาพตามมาตรฐานของสถานศึกษา', N'', N'', 1, N'', N'', 2, 0, CAST(0x0000A3C500A8B5B4 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500A8B5B5 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'a381572f-c0ed-4cc6-8916-60af71c29f6b', N'75ec63a6-4952-46c8-97c8-6f973a76ea92', N'มีทักษะการเคลื่อนไหวตามวัย', N'', N'', 1.5, N'', N'', 2, 0, CAST(0x0000A3C50091679C AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C50093856D AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'1c167bba-813c-43ce-a37f-9c634610d960')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'ad31f777-c333-4330-b8ee-b3949983a8a1', N'599c7392-ac95-4a59-947e-28e24708c964', N'ผลการดำเนินงานบรรลุเป้าหมาย', N'', N'', 2, N'', N'', 2, 0, CAST(0x0000A3C500AFF66B AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500AFF66B AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'b554e905-930a-4a95-bb3d-1c1615987e98', N'dd3a1a57-b28c-4660-a1e1-7ddd418fa2f2', N'ผู้บริหารสามารถบริหารจัดการศึกษาให้บรรลุเป้าหมายตามแผนพัฒนาคุณภาพสถานศึกษา', N'', N'', 3, N'', N'', 4, 0, CAST(0x0000A3C5009C2B27 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5009C2B27 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'8203609C-DC86-4409-9CC8-89A8AC90674A')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'b69621fc-a2a6-43a2-9bc3-3514ed4e841a', N'8301ceeb-0203-48db-ac3b-feb400f4a33e', N'มีทักษะทางภาษาที่เหมาะสมกับวัย', N'', N'', 1, N'', N'', 3, 0, CAST(0x0000A3C50097AFE5 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C50097AFE5 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'bb1ebf22-e280-4bd7-8d39-c1db719c9e20', N'3ee683ba-7a5a-439f-91d6-4fcfe86e6357', N'เล่นและทำงานร่วมกับผู้อื่นได้', N'', N'', 1, N'', N'', 3, 0, CAST(0x0000A3C50096D62F AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C50096D62F AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'be737896-43c2-40c2-b715-a1478d7f0c9d', N'75ec63a6-4952-46c8-97c8-6f973a76ea92', N'มีสุขนิสัยในการดูแลสุขภาะของตน', N'', N'', 1.5, N'', N'', 3, 0, CAST(0x0000A3C500954C33 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500954C33 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'1c167bba-813c-43ce-a37f-9c634610d960')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'c5fa8570-67fb-479f-8501-eba43172bc31', N'dd3a1a57-b28c-4660-a1e1-7ddd418fa2f2', N'เด็ก ผู้ปกครอง และชุมชนพึงพอใจผลการบริหารจัดการศึกษาปฐมวัย', N'', N'', 2, N'', N'', 7, 0, CAST(0x0000A3C5009CE3AA AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5009CE3AA AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'cb6dd3e6-365a-4dbd-9b59-a05f0e2e926b', N'dd3a1a57-b28c-4660-a1e1-7ddd418fa2f2', N'ผู้บริหารใช้หลักการบริหารแบบมีส่วนร่วมและใช้ข้อมูลการประเมินผลหรือการวิจัยเป็นฐานคิดทั้งด้านวิชาการและการจัดการ', N'', N'', 3, N'', N'', 3, 0, CAST(0x0000A3C5009BED54 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5009BED54 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'8203609C-DC86-4409-9CC8-89A8AC90674A')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'cb9d64e8-0e0e-47ef-b76a-97a3d0274938', N'599fe197-6368-4ba7-a63e-75dbbf7657f4', N'มีความมั่นใจและกล้าแสดงออก', N'', N'', 1, N'', N'', 2, 0, CAST(0x0000A3C50095F7A3 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C50095F7A4 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'cfa9a384-e10f-4f67-aa1d-13ba735218ad', N'3ee683ba-7a5a-439f-91d6-4fcfe86e6357', N'มีวินัย รับผิดชอบ เชื่อฟังคำสั่งสอนของพ่อแม่ ครู อาจารย์', N'', N'', 2, N'', N'', 1, 0, CAST(0x0000A3C50096874D AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C50096874D AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'dada9480-fdab-4f4d-a5e4-014cfef7c9cf', N'a0193755-9c06-46ab-9a19-43daa05d3527', N'กำหนดมาตรฐานการศึกษาปฐมวัยของสถานศึกษา', N'', N'', 1, N'', N'', 1, 0, CAST(0x0000A3C500A879A5 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500A879A5 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'db4c45cb-0601-4d1f-8724-b624ec12c043', N'fa9f2aca-9617-482e-a66b-abb8d8c1c6fc', N'ครูมีปฏิสัมพันธ์ที่ดีกับเด็กและผู้ปกครอง', N'', N'', 2, N'', N'', 8, 0, CAST(0x0000A3C5009A04AC AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5009A04AD AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'de854d8c-8ba9-44a2-a5e5-0e1dc85f4362', N'fa9f2aca-9617-482e-a66b-abb8d8c1c6fc', N'ครูจัดทำแผนการจัดประสบการณ์ที่สอดคล้องกับหลักสูตรการศึกษาปฐมวัยและสามารถจัดประสบการณ์การเรียนรู้ที่หลากหลายสอดคล้องกับความแตกต่างระหว่างบุคคล', N'', N'', 2, N'', N'', 2, 0, CAST(0x0000A3C50098EAC2 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C50098EAC3 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'dee4095d-3d68-4b05-bb58-53400b864e65', N'3ee683ba-7a5a-439f-91d6-4fcfe86e6357', N'มีความซื่อสัตย์สุจริต ช่วยเหลือแบ่งปัน', N'', N'', 1, N'', N'', 2, 0, CAST(0x0000A3C50096B6C4 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C50096B6C4 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'e0e51eeb-721f-4f47-b6a1-92094b8cde65', N'fa9f2aca-9617-482e-a66b-abb8d8c1c6fc', N'ครูใช้สื่อและเทคโนโลยีที่เหมาะสมสอดคล้องกับพัฒนาการของเด็ก', N'', N'', 2, N'', N'', 4, 0, CAST(0x0000A3C5009942D8 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5009942D8 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'e223b3f4-0828-416f-92f3-f50dfff4d148', N'599fe197-6368-4ba7-a63e-75dbbf7657f4', N'ชื่นชมศิลปะ ดนตรี การเคลื่อนไหวและรักธรรมชาติ', N'', N'', 2, N'', N'', 4, 0, CAST(0x0000A3C500965218 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500965218 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'00EB2C36-B042-472F-BD5D-1DF7C57568C4')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'e54e5176-5274-49d3-8e4a-bcf447428cc9', N'75ec63a6-4952-46c8-97c8-6f973a76ea92', N'หลีกเลี่ยงต่อสภาวะที่เสี่ยงต่อโรค อุบัติเหตุ ภัย และสิ่งเสพติด', N'', N'', 1, N'', N'', 4, 0, CAST(0x0000A3C500958C12 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500958C12 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
		INSERT [dbo].[Indicators] ([IndicatorsCode], [StandardCode], [IndicatorsName], [Detail], [DevelopIssues], [WeightScore], [DataSource1], [DataSource2], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser], [QualityFlag], [ScoreGroupID]) VALUES (N'eac102f2-5a1f-471a-b663-b88540d9e030', N'8301ceeb-0203-48db-ac3b-feb400f4a33e', N'มีทักษะกระบวนการทางวิทยาศาสตร์และคณิตศาสตร์', N'', N'', 1, N'', N'', 4, 0, CAST(0x0000A3C50097D76C AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C50097D76C AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', 0, N'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3')
	End																												

Go
--เพิ่มเมนูตัวชี้วัด สมศ.  
If Not Exists(Select * From MySubMenu Where MySubMenuID = '32F3AF64-3838-4496-BEC5-4139E799D787')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('32F3AF64-3838-4496-BEC5-4139E799D787', 'ตัวชี้วัด สมศ.', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 16, 'MasterData/IndicatorSMS.aspx', 1, 0, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S10.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('32F3AF64-3838-4496-BEC5-4139E799D787', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('32F3AF64-3838-4496-BEC5-4139E799D787', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('32F3AF64-3838-4496-BEC5-4139E799D787', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('32F3AF64-3838-4496-BEC5-4139E799D787', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
Update MR_School Set ckAnuban = 0 Where ckAnuban Is Null
Update MR_School Set ckIndicatorSMS = 0 Where ckIndicatorSMS Is Null
Update MR_School Set ckResource = 0 Where ckResource Is Null
Update ActivityCostsDetail Set Cost = 0 Where Cost Is NULL
Update MR_School Set ckWord = 0 Where ckWord Is NULL
Update MR_School Set ckExcel = 0 Where ckExcel Is NULL
Update MR_School Set ckPDF = 1 Where ckPDF Is NULL


--- เพิ่ม Master กลุ่มคะแนน
GO
If Not Exists(Select * From ScoreGroup Where ScoreGroupID = '1c167bba-813c-43ce-a37f-9c634610d960')
Begin
	INSERT [dbo].[ScoreGroup] ([ScoreGroupID], [ScoreGroupName], [Sort], [WeightScore], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [DelFlag]) 
	VALUES (N'1c167bba-813c-43ce-a37f-9c634610d960', N'หมวดคะแนนเต็ม 1.5', 5, 1.5, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500918B6B AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500918B6B AS DateTime), 0)
End

GO
If Not Exists(Select * From ScoreGroup Where ScoreGroupID = '4996ad20-57fc-4dbc-a01d-698393d7affb')
Begin
	INSERT [dbo].[ScoreGroup] ([ScoreGroupID], [ScoreGroupName], [Sort], [WeightScore], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [DelFlag]) 
	VALUES (N'4996ad20-57fc-4dbc-a01d-698393d7affb', N'หมวดคะแนนเต็ม 20', 15, 20, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C4010DE7E4 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C4010DFB6D AS DateTime), 0)
End

GO
If Not Exists(Select * From ScoreGroup Where ScoreGroupID = '921aae33-10ee-4c06-9818-361c88f75dbd')
Begin
	INSERT [dbo].[ScoreGroup] ([ScoreGroupID], [ScoreGroupName], [Sort], [WeightScore], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [DelFlag]) 
	VALUES (N'921aae33-10ee-4c06-9818-361c88f75dbd', N'หมวดคะแนนเต็ม 2.5', 8, 2.5, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500ACB1BE AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500ACB1BE AS DateTime), 0)
End

GO
If Not Exists(Select * From ScoreGroup Where ScoreGroupID = 'c68263a8-5339-41f6-a19a-9e02167577b4')
Begin
	INSERT [dbo].[ScoreGroup] ([ScoreGroupID], [ScoreGroupName], [Sort], [WeightScore], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [DelFlag]) 
	VALUES (N'c68263a8-5339-41f6-a19a-9e02167577b4', N'หมวดคะแนนเต็ม 6.0', 13, 6, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C4011768DE AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C4011768DE AS DateTime), 0)
End

GO
If Not Exists(Select * From ScoreGroup Where ScoreGroupID = 'fe43801a-1fa1-4cc1-8789-385df50aa650')
Begin
	INSERT [dbo].[ScoreGroup] ([ScoreGroupID], [ScoreGroupName], [Sort], [WeightScore], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [DelFlag]) 
	VALUES (N'fe43801a-1fa1-4cc1-8789-385df50aa650', N'หมวดคะแนนเต็ม 65', 18, 65, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C401135464 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C401135464 AS DateTime), 0)
End

-- เพิ่ม Master ตารางคะแนน
GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = '0050134c-6a56-49d7-9665-cdcf062ddde4')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'0050134c-6a56-49d7-9665-cdcf062ddde4', 1.5, N'๑.๐๕ - ๑.๑๙', 4, N'ดีมาก', 1.05, 1.19, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C50094C74B AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C50094C74C AS DateTime), N'1c167bba-813c-43ce-a37f-9c634610d960')
END

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = '0e422467-aa63-49dd-8054-06b32ae650e7')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'0e422467-aa63-49dd-8054-06b32ae650e7', 1.5, N'๑.๓๐ - ๑.๕๐', 5, N'ดีเยี่ยม', 1.3, 1.5, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C50094F54E AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3D10113271E AS DateTime), N'1c167bba-813c-43ce-a37f-9c634610d960')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = '1275de1d-598b-49bb-94fc-28efc630a99d')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'1275de1d-598b-49bb-94fc-28efc630a99d', 6, N'๐.๐๐ - ๒.๙๙', 1, N'ปรับปรุง', 0, 2.99, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C4011852A3 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C4011852A3 AS DateTime), N'c68263a8-5339-41f6-a19a-9e02167577b4')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = '19c5b41c-bd84-4b78-96e9-00b6829809cf')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'19c5b41c-bd84-4b78-96e9-00b6829809cf', 65, N'๓๙.๐๐ - ๔๘.๗๙', 3, N'ดี', 39, 48.79, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C4011498BC AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3D101139326 AS DateTime), N'fe43801a-1fa1-4cc1-8789-385df50aa650')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = '2c3771cc-ef05-4448-be15-a51215e11e89')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'2c3771cc-ef05-4448-be15-a51215e11e89', 20, N'๑๕.๐๐ - ๑๗.๙๙', 4, N'ดีมาก', 15, 17.99, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C40110E43F AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3D200B5A7B2 AS DateTime), N'4996ad20-57fc-4dbc-a01d-698393d7affb')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = '4fe0147d-c483-42c8-9949-db2a63c10c3d')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'4fe0147d-c483-42c8-9949-db2a63c10c3d', 2.5, N'๑.๗๕ - ๑.๙๙', 4, N'ดีมาก', 1.75, 1.99, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500AEC760 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500AEC760 AS DateTime), N'921aae33-10ee-4c06-9818-361c88f75dbd')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = '53a4c682-5525-4e9b-8eb9-71b9d7dfe576')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'53a4c682-5525-4e9b-8eb9-71b9d7dfe576', 65, N'๐.๐๐ - ๓๒.๔๙', 1, N'ปรับปรุง', 0, 32.49, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C40113DBCE AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C40113F54E AS DateTime), N'fe43801a-1fa1-4cc1-8789-385df50aa650')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = '5e989d3b-1f19-437e-aab3-db1af0d6953f')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'5e989d3b-1f19-437e-aab3-db1af0d6953f', 20, N'๑๒.๐๐ - ๑๔.๙๙', 3, N'ดี', 12, 14.99, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C401109A99 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3D200B58401 AS DateTime), N'4996ad20-57fc-4dbc-a01d-698393d7affb')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = '67fde609-85b8-4c62-a5af-337650ff6fb2')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'67fde609-85b8-4c62-a5af-337650ff6fb2', 1.5, N'๐.๐๐ - ๐.๕๙', 1, N'ปรับปรุง', 0, 0.59, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C50093EA0F AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3D10112742D AS DateTime), N'1c167bba-813c-43ce-a37f-9c634610d960')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = '68927e0c-0400-4d0a-aec9-5bbebdedc891')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'68927e0c-0400-4d0a-aec9-5bbebdedc891', 20, N'๐.๐๐ - ๙.๙๙', 1, N'ปรับปรุง', 0, 9.99, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C4010F2266 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C4010F2267 AS DateTime), N'4996ad20-57fc-4dbc-a01d-698393d7affb')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = '771d525f-0039-46f9-b245-31e2c413e788')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'771d525f-0039-46f9-b245-31e2c413e788', 2.5, N'๒.๐๐ - ๒.๕๐', 5, N'ดีเยี่ยม', 2, 2.5, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500AEFE46 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500AEFE46 AS DateTime), N'921aae33-10ee-4c06-9818-361c88f75dbd')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = '7fd91006-3dd1-4295-9a6f-75443e01a0cd')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'7fd91006-3dd1-4295-9a6f-75443e01a0cd', 65, N'๓๒.๕๐ - ๓๘.๙๙', 2, N'พอใช้', 32.5, 38.99, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C401143E35 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C401143E35 AS DateTime), N'fe43801a-1fa1-4cc1-8789-385df50aa650')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = '80a919c8-5c96-45f7-8a05-4fb6ce76df1e')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'80a919c8-5c96-45f7-8a05-4fb6ce76df1e', 65, N'๔๘.๘๐ - ๕๘.๔๙', 4, N'ดีมาก', 48.8, 58.49, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C40114F3B7 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3D10113F521 AS DateTime), N'fe43801a-1fa1-4cc1-8789-385df50aa650')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = '8f1c8c9b-b0bf-43e3-98df-4e75dcf3a098')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'8f1c8c9b-b0bf-43e3-98df-4e75dcf3a098', 20, N'๑๐.๐๐ - ๑๑.๙๙', 2, N'พอใช้', 10, 11.99, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C401105878 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C401105878 AS DateTime), N'4996ad20-57fc-4dbc-a01d-698393d7affb')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = '9314220e-d52c-44e5-8801-314a0e447f2f')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'9314220e-d52c-44e5-8801-314a0e447f2f', 6, N'๓.๐๐ - ๓.๕๙', 2, N'พอใช้', 3, 3.59, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C40118AAEE AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C40118AAEE AS DateTime), N'c68263a8-5339-41f6-a19a-9e02167577b4')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = 'ae7defdb-261f-446a-a4ca-23340b9be202')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'ae7defdb-261f-446a-a4ca-23340b9be202', 6, N'๔.๒๐ - ๔.๗๙', 4, N'ดีมาก', 4.2, 4.79, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5008F2C3E AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5008F2C3E AS DateTime), N'c68263a8-5339-41f6-a19a-9e02167577b4')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = 'b48d21fb-58e4-495a-9a65-4a4d7de93024')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'b48d21fb-58e4-495a-9a65-4a4d7de93024', 1.5, N'๐.๙๕ - ๑.๒๙', 2, N'พอใช้', 0.95, 1.29, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500942EC3 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3D10113154C AS DateTime), N'1c167bba-813c-43ce-a37f-9c634610d960')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = 'bb800508-487f-46ad-9d1c-39d9208fed3d')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'bb800508-487f-46ad-9d1c-39d9208fed3d', 1.5, N'๐.๘๐ - ๐.๙๔', 3, N'ดี', 0.8, 0.94, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500948041 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3D10112C3E2 AS DateTime), N'1c167bba-813c-43ce-a37f-9c634610d960')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = 'cfd9dde9-12db-4999-a798-f1277a0569ef')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'cfd9dde9-12db-4999-a798-f1277a0569ef', 2.5, N'๑.๕๐ - ๑.๗๔', 3, N'ดี', 1.5, 1.74, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500AE819A AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500AE819A AS DateTime), N'921aae33-10ee-4c06-9818-361c88f75dbd')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = 'dee1c382-d22c-473c-bd36-74f56da49837')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'dee1c382-d22c-473c-bd36-74f56da49837', 2.5, N'๐.๐๐ - ๑.๒๔', 1, N'ปรับปรุง', 0, 1.24, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500ADADB9 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500ADADB9 AS DateTime), N'921aae33-10ee-4c06-9818-361c88f75dbd')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = 'e49d9c94-22f6-4c8a-9a5c-32fcdbe149a3')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'e49d9c94-22f6-4c8a-9a5c-32fcdbe149a3', 20, N'๑๘.๐๐ - ๒๐.๐๐', 5, N'ดีเยี่ยม', 18, 20, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C401111DCA AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3D200B5B8E3 AS DateTime), N'4996ad20-57fc-4dbc-a01d-698393d7affb')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = 'f438a625-7f59-47c6-b51e-212ea6e73cba')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'f438a625-7f59-47c6-b51e-212ea6e73cba', 2.5, N'๑.๒๕ - ๑.๔๙', 2, N'พอใช้', 1.25, 1.49, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500AE33D8 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C500AE33D9 AS DateTime), N'921aae33-10ee-4c06-9818-361c88f75dbd')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = 'f4e7ee9b-e925-4fe8-ac6d-2e7053dde652')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'f4e7ee9b-e925-4fe8-ac6d-2e7053dde652', 65, N'๕๘.๕๐ - ๖๕.๐๐', 5, N'ดีเยี่ยม', 58.5, 65, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C401152AA6 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3D101142602 AS DateTime), N'fe43801a-1fa1-4cc1-8789-385df50aa650')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = 'f75ea78f-97e5-42e0-bfa8-221d7da9f04d')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'f75ea78f-97e5-42e0-bfa8-221d7da9f04d', 6, N'๔.๘๐ - ๖.๐๐', 5, N'ดีเยี่ยม', 4.8, 6, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5008FA1A1 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5008FA1A2 AS DateTime), N'c68263a8-5339-41f6-a19a-9e02167577b4')
End

GO
If Not Exists(Select * From Tcriteria Where TcriteriaID = '04dfeded-9a00-4f70-9ddd-471bdfff714e')
Begin
	INSERT [dbo].[Tcriteria] ([TcriteriaID], [Tcriteria], [Detail], [Criterion], [Translation], [TMin], [TMax], [DelFlag], [CreateUser], [CreateDate], [UpdateUser], [UpdateDate], [ScoreGroupID]) 
	VALUES (N'04dfeded-9a00-4f70-9ddd-471bdfff714e', 6, N'๓.๕๐ - ๔.๑๙', 3, N'ดี', 3.8, 4.19, 0, N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5008FA1A1 AS DateTime), N'd251947c-e616-4048-95e7-929e5d877cd9', CAST(0x0000A3C5008FA1A2 AS DateTime), N'c68263a8-5339-41f6-a19a-9e02167577b4')
End




--------- เฉพาะ เครื่อง 135 LogSchoolSar ---------------------------
--เพิ่มฟิวเช็คเครื่องเช่าใช้
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('LogSchoolSar') And Name = 'LogStatus')
Begin
	alter table LogSchoolSar add LogStatus int
End

Go
-- 0:เช่า   1:ซื้อ   2:ทดสอบ
Update LogSchoolSar Set LogStatus = 0

--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&




--********************************** V 10.6.0 **********************************
--******************************************************************************

--ผู้เสนอกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'ProposeName')
Begin
	alter table Activity add ProposeName nvarchar(100)
End

--ตำแหน่งผู้เสนอกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'ProposePosition')
Begin
	alter table Activity add ProposePosition nvarchar(100)
End

--ผู้เห็นชอบกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'ApprovalName')
Begin
	alter table Activity add ApprovalName nvarchar(100)
End

--ตำแหน่งผู้เห็นชอบกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'ApprovalPosition')
Begin
	alter table Activity add ApprovalPosition nvarchar(100)
End

--ผู้เห็นชอบกิจกรรม 2
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'ApprovalName2')
Begin
	alter table Activity add ApprovalName2 nvarchar(100)
End

--ตำแหน่งผู้เห็นชอบกิจกรรม 2
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'ApprovalPosition2')
Begin
	alter table Activity add ApprovalPosition2 nvarchar(100)
End


--******************************************************************************
--******************************************************************************



--********************************** V 10.7.0 **********************************
--******************************************************************************

--เพิ่มฟิวตัวเช็คตัว QA
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckQA')
Begin
	alter table MR_School add ckQA bit
End
Go
----------- เพิ่ม Table QACategory  หมวด QA ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('QACategory'))
Begin
	CREATE TABLE [dbo].[QACategory](
		[QACategoryID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[QACategoryName] [nvarchar](300) NULL,
		[Comment] [nvarchar](300) NULL,
		[Detail] [nvarchar](MAX) NULL,
		[Score] [int] NULL,
		[QAScoreGroupID] [nvarchar](50) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_QACategory] PRIMARY KEY CLUSTERED 
	(
		[QACategoryID] ASC
	)) ON [PRIMARY]
End
Go

----------- เพิ่ม Table QACategorySub  หัวข้อย่อย QA ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('QACategorySub'))
Begin
	CREATE TABLE [dbo].[QACategorySub](
		[QACategorySubID] [nvarchar](50) NOT NULL,
		[QACategoryID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[QACategorySubName] [nvarchar](300) NULL,
		[Comment] [nvarchar](300) NULL,
		[Detail] [nvarchar](MAX) NULL,
		[Score] [int] NULL,
		[QAScoreGroupID] [nvarchar](50) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_QACategorySub] PRIMARY KEY CLUSTERED 
	(
		[QACategorySubID] ASC
	)) ON [PRIMARY]
End
Go
----------- เพิ่ม Table QALink  เชื่อมโยง QA ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('QALink'))
Begin
	CREATE TABLE [dbo].[QALink](
		[QALinkCode] [nvarchar](50) NOT NULL,
		[QACategoryID] [nvarchar](50) NULL,
		[QACategorySubID] [nvarchar](50) NULL,
		[StrategiesCode] [nvarchar](50) NULL,
		[ProjectsCode] [nvarchar](50) NULL,
		[ActivityCode] [nvarchar](50) NULL,
		[Indicators2Code] [nvarchar](50) NULL,
		[OffAll] [float] NULL,
		[OffThat] [float] NULL,
		[APercent] [float] NULL,
		[CkCriterion] [int] NULL,
		[DelFlag] [bit] NULL,
		[StudyYear] [int] NULL,
		[SchoolID] [nvarchar](50) NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_QALink] PRIMARY KEY CLUSTERED 
	(
		[QALinkCode] ASC
	)) ON [PRIMARY]
End
Go
--ตำแหน่งผู้รับผิดชอบกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'ResponsiblePosition')
Begin
	alter table Activity add ResponsiblePosition nvarchar(100)
End

Go
--เพิ่มเมนูหมวด QA
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'C8211D72-CDDE-43CE-85AA-28EE3F473621')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('C8211D72-CDDE-43CE-85AA-28EE3F473621', 'หมวดเกณฑ์รางวัลคุณภาพ', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 22, 'MasterData/QACategory.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S15.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('C8211D72-CDDE-43CE-85AA-28EE3F473621', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('C8211D72-CDDE-43CE-85AA-28EE3F473621', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('C8211D72-CDDE-43CE-85AA-28EE3F473621', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('C8211D72-CDDE-43CE-85AA-28EE3F473621', '079c4976-49a8-4b30-83bf-3e13cbaa9382')

End
Go
--เพิ่มข้อมูลหมวด QA
If Not Exists(Select * From QACategory)
Begin

	INSERT [dbo].[QACategory] ([QACategoryID], [StudyYear], [QACategoryName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'03c0712a-d13b-4d15-bdd6-ca383f7652a1', 2556, N'การมุ่งเน้นนักเรียน', N'', N'ในหมวดการมุ่งเน้นนักเรียนนี้เป็นการตรวจประเมินถึงวิธีการที่โรงเรียนสร้างความผูกพันกับนักเรียนเพื่อความสำเร็จด้านการตลาดในระยะยาว กลยุทธ์ในการสร้างความผูกพันครอบคลุมถึงวิธีสร้างวัฒนธรรมมุ่งเน้นนักเรียน รวมทั้งวิธีการที่โรงเรียนรับฟังเสียงของนักเรียน และการใช้ข้อมูลสารสนเทศเพื่อปรับปรุงและค้นหาโอกาสในการสร้างนวัตกรรม', 100, N'', 3, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategory] ([QACategoryID], [StudyYear], [QACategoryName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'118fccf9-a66d-4367-9bd9-e8b36ddabc67', 2555, N'การนำองค์กร', NULL, N'ในหมวดการนำองค์กรนี้ เป็นการตรวจประเมินว่า การดำเนินการโดยฝ่ายบริหารของโรงเรียนได้กำหนดนโยบายและส่งเสริมสนับสนุนให้โรงเรียนมีการพัฒนาอย่างต่อเนื่องและยั่งยืนอย่างไร รวมทั้งตรวจประเมินระบบกำกับดูแลโรงเรียนและวิธีการที่โรงเรียนใช้เพื่อบรรลุผลด้านกฎหมาย จริยธรรม และความรับผิดชอบต่อสังคมในวงกว้าง', 110, NULL, 1, 0, CAST(0x0000A4CE00FF173B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00C558CD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategory] ([QACategoryID], [StudyYear], [QACategoryName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'16b29784-f272-4b6c-a3ff-992077c1f0f5', 2555, N'ผลลัพธ์', NULL, N'', 400, NULL, 7, 0, CAST(0x0000A4CF00B929C6 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00B929C6 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategory] ([QACategoryID], [StudyYear], [QACategoryName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'29f5053e-1b3f-4f83-a4ba-ffdb8629e732', 2555, N'การมุ่งเน้นบุคลากร', NULL, N'', 100, NULL, 5, 0, CAST(0x0000A4CF00B88A71 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00B88A71 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategory] ([QACategoryID], [StudyYear], [QACategoryName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'5b0cd783-fabb-4276-a760-0f260c9146cc', 2556, N'การวัด  การวิเคราะห์  และการจัดการความรู้', N'', N'ในหมวดการวัด การวิเคราะห์และการจัดการความรู้ เป็นการตรวจประเมินว่าโรงเรียนเลือก รวบรวม วิเคราะห์ จัดการ ปรับปรุงข้อมูลสารสนเทศ และสินทรัพย์ทางปัญญาที่มีการสั่งสมความรู้ภายในองค์กรอย่างไร โรงเรียนมีการบริหารจัดการเทคโนโลยีสารสนเทศอย่างไร นอกจากนี้ยังตรวจประเมินว่าโรงเรียนใช้ผลการทบทวนเพื่อปรับปรุงผลการดำเนินการอย่างไร', 90, N'', 4, 0, CAST(0x0000A4CF00CD8FE1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF7F07 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategory] ([QACategoryID], [StudyYear], [QACategoryName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'6971c9b0-c9da-464f-9cd1-a0879a5f6963', 2555, N'การมุ่งเน้นการดำเนินการ', NULL, N'', 110, NULL, 6, 0, CAST(0x0000A4CF00B8A162 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00B8A163 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategory] ([QACategoryID], [StudyYear], [QACategoryName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'6edffcd5-a396-4066-82ef-4ab5a8ee698b', 2556, N'การมุ่งเน้นบุคลากร', N'', N'หมวดการมุ่งเน้นบุคลากรเป็นการตรวจประเมินความสามารถของโรงเรียน มีวิธีการอย่างไรในการกำหนดขีดความสามารถของบุคลากรอัตรากำลัง และการสร้างสภาพแวดล้อมการทำงานที่นำไปสู่ผลการดำเนินงานที่ดี นอกจากนี้ ในหมวดนี้ยังเป็นการตรวจประเมินว่าโรงเรียนมีวิธีการอย่างไรในความผูกพัน จัดการ และพัฒนาบุคลากร เพื่อนำศักยภาพของพวกเขามาใช้อย่างเต็มที่ โดยสอดคล้องไปในทิศทางเดียวกับพันธกิจ กลยุทธ์ และแผนปฏิบัติการของโรงเรียน', 100, N'', 5, 0, CAST(0x0000A4CF00CD8FEE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00D0CF37 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategory] ([QACategoryID], [StudyYear], [QACategoryName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'742bd4d6-4a74-4c34-9b6c-650f9d682313', 2556, N'ผลลัพธ์', N'', N'', 400, N'', 7, 0, CAST(0x0000A4CF00CD8FF4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF4 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategory] ([QACategoryID], [StudyYear], [QACategoryName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'a5d76b18-8cb4-4896-bad0-b5fc67268ad0', 2556, N'การวางแผนเชิงกลยุทธ์', N'', N'หมวดการวางแผนเชิงกลยุทธ์ เป็ินการตรวจประเมินว่าโรงเรียนของท่านมีการพัฒนาวัตถุประสงค์เชิงกลยุทธ์และแผนปฏิบัติการของโรงเรียนอย่างไร รวมทั้งตรวจประเมินวัตถะประสงค์เชิงกลยุทธ์และแผนปฏิบัติการที่เลือกไว้ เพื่อนำไปปฏิบัติ มีการปรับเปลี่ยนเมื่อสถานการณ์เปลี่ยนไปและมีการวัดความก้าวหน้าอย่างไร', 90, N'', 2, 0, CAST(0x0000A4CF00CD8FDC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FDC AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategory] ([QACategoryID], [StudyYear], [QACategoryName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'aa622b39-fb6f-42b6-8e1e-a773e6210489', 2556, N'การมุ่งเน้นการดำเนินการ', N'', N'ในหมวด การมุ่งเน้นการดำเนินการ (Operation Focus) นี้ เป็นการอธิบายว่าโรงเรียนมีวิธีการออกแบบจัดการ และปรับปรุงระบบงานและกระบวนการทำงานเพื่อนำไปสร้างคุณค่าให้นักเรียน ทำให้โรงเรียนประสบความสำเร็จและยั่งยืน รวมทั้งอธิบายถึงการเตรียมความพร้อมสำหรับภาวะฉุกเฉิน', 110, N'', 6, 0, CAST(0x0000A4CF00CD8FF1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00D1B57A AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategory] ([QACategoryID], [StudyYear], [QACategoryName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'ad0d21fc-51f1-453a-a5fc-8599591999c0', 2555, N'การวางแผนเชิงกลยุทธ์', NULL, N'หมวดการวางแผนเชิงกลยุทธ์ เป็ินการตรวจประเมินว่าโรงเรียนของท่านมีการพัฒนาวัตถุประสงค์เชิงกลยุทธ์และแผนปฏิบัติการของโรงเรียนอย่างไร รวมทั้งตรวจประเมินวัตถะประสงค์เชิงกลยุทธ์และแผนปฏิบัติการที่เลือกไว้ เพื่อนำไปปฏิบัติ มีการปรับเปลี่ยนเมื่อสถานการณ์เปลี่ยนไปและมีการวัดความก้าวหน้าอย่างไร', 90, NULL, 2, 0, CAST(0x0000A4CE00FFA7C9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00C5DDCF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategory] ([QACategoryID], [StudyYear], [QACategoryName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'c2d9039d-1408-45cb-9626-224f2f1da111', 2555, N'การวัด  การวิเคราะห์  และการจัดการความรู้', NULL, N'', 90, NULL, 4, 0, CAST(0x0000A4CE00FFE1AE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CE00FFE1AE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategory] ([QACategoryID], [StudyYear], [QACategoryName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'cea3d824-ffbe-4501-9dd4-852cf3c6ee73', 2556, N'การนำองค์กร', N'', N'ในหมวดการนำองค์กรนี้ เป็นการตรวจประเมินว่า การดำเนินการโดยฝ่ายบริหารของโรงเรียนได้กำหนดนโยบายและส่งเสริมสนับสนุนให้โรงเรียนมีการพัฒนาอย่างต่อเนื่องและยั่งยืนอย่างไร รวมทั้งตรวจประเมินระบบกำกับดูแลโรงเรียนและวิธีการที่โรงเรียนใช้เพื่อบรรลุผลด้านกฎหมาย จริยธรรม และความรับผิดชอบต่อสังคมในวงกว้าง', 110, N'', 1, 0, CAST(0x0000A4CF00CD8FD8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FD9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategory] ([QACategoryID], [StudyYear], [QACategoryName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'ef24de03-7eb2-45da-97c1-e6ddc7d8396b', 2555, N'การมุ่งเน้นนักเรียน', NULL, N'', 100, NULL, 3, 0, CAST(0x0000A4CE00FFC18D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CE00FFC18D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
End
Go
--เพิ่มเมนูหัวข้อย่อย QA
If Not Exists(Select * From MySubMenu Where MySubMenuID = '2D903F07-D054-459A-88E7-91FC2C731527')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('2D903F07-D054-459A-88E7-91FC2C731527', 'หัวข้อเกณฑ์รางวัลคุณภาพ', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 23, 'MasterData/QACategorySub.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S16.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('2D903F07-D054-459A-88E7-91FC2C731527', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('2D903F07-D054-459A-88E7-91FC2C731527', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('2D903F07-D054-459A-88E7-91FC2C731527', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('2D903F07-D054-459A-88E7-91FC2C731527', '079c4976-49a8-4b30-83bf-3e13cbaa9382')

End
Go
--เพิ่มข้อมูลหัวข้อย่อย QA
If Not Exists(Select * From QACategorySub)
Begin
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'13fdfa8a-5251-4bbc-a630-e2fd6f182757', N'742bd4d6-4a74-4c34-9b6c-650f9d682313', 2556, N'ผลลัพธ์ด้านหลักสูตรและกระบวนการ', N'ผลลัพธ์ด้านหลักสูตรสถานศึกษา และประสิทธิผลของกระบวนการเป็นอย่างไร', N'', 130, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'188f8393-4a9b-434a-8726-7801bbc0da5d', N'5b0cd783-fabb-4276-a760-0f260c9146cc', 2556, N'การวัด การวิเคราะห์ และการปรับปรุงผลการดำเนินการของโรงเรียน', N'โรงเรียน มีวิธีการอย่างไรในการวัด วิเคราะห์ และนำมาปรับปรุงผลการดำเนินการของโรงเรียน', N'', 50, N'', 1, 0, CAST(0x0000A4CF00CD8FE2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FE2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'2a2a5533-c2c3-4c7d-9e25-b01b51ed1015', N'ad0d21fc-51f1-453a-a5fc-8599591999c0', 2555, N'การจัดทำกลยุทธ์', N'โรงเรียนมีกลยุทธ์ในการพัฒนาอย่างไร', N'', 40, NULL, 1, 0, CAST(0x0000A4CE011FC588 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CE011FC589 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'2f84c368-2b4c-41c6-937e-0949e90b29f9', N'6edffcd5-a396-4066-82ef-4ab5a8ee698b', 2556, N'สภาพแวดล้อมในการทำงาน', N'โรงเรียนมีวิธีการอย่างไรในการสร้างสภาพแวดล้อมในการทำงานที่มีประสิทธิภาพ และสนับสนุนบุคลากร', N'', 45, N'', 1, 0, CAST(0x0000A4CF00CD8FEF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FEF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'43ec8195-2fee-468b-9240-f657bff6468a', N'16b29784-f272-4b6c-a3ff-992077c1f0f5', 2555, N'ผลลัพธ์ด้านหลักสูตรและกระบวนการ', N'ผลลัพธ์ด้านหลักสูตรสถานศึกษา และประสิทธิผลของกระบวนการเป็นอย่างไร', N'', 130, NULL, 1, 0, CAST(0x0000A4CF00C0DFB8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00C0DFB8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'53bce50f-b3fc-42ae-8871-0fcad15375d6', N'c2d9039d-1408-45cb-9626-224f2f1da111', 2555, N'การวัด การวิเคราะห์ และการปรับปรุงผลการดำเนินการของโรงเรียน', N'โรงเรียน มีวิธีการอย่างไรในการวัด วิเคราะห์ และนำมาปรับปรุงผลการดำเนินการของโรงเรียน', N'', 50, NULL, 1, 0, CAST(0x0000A4CF00BEC097 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00BEC097 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'59807e1c-0c24-4397-a9ff-902ec1b3b5e3', N'cea3d824-ffbe-4501-9dd4-852cf3c6ee73', 2556, N'การกำกับดูแลองค์กรและความรับผิดชอบต่อสังคมในวงกว้าง', N'โรงเรียนดำเนินการอย่างไรในการกำกับดูแลโรงเรียน และทำให้บรรลุผลด้านความรับผิดชอบต่อสังคม', N'', 50, N'', 2, 0, CAST(0x0000A4CF00CD8FDB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FDB AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'6139dac0-4fda-4a92-925d-cffe3d2c3bfa', N'a5d76b18-8cb4-4896-bad0-b5fc67268ad0', 2556, N'การจัดทำกลยุทธ์', N'โรงเรียนมีกลยุทธ์ในการพัฒนาอย่างไร', N'', 40, N'', 1, 0, CAST(0x0000A4CF00CD8FDD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FDD AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'713e0bca-ccd9-446b-96de-5ff04762fce0', N'ef24de03-7eb2-45da-97c1-e6ddc7d8396b', 2555, N'การรับฟังนักเรียน', N'โรงเรียนมีวิธีการอย่างไรในการรวบรวมข้อมูลและใช้สารสนเทศจากนักเรียน', N'', 50, NULL, 1, 0, CAST(0x0000A4CF00BC8FAF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00BC8FAF AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'9172fe4d-eaea-42b3-a22b-1ff1c1522e34', N'cea3d824-ffbe-4501-9dd4-852cf3c6ee73', 2556, N'การนำองค์กร', N'ฝ่ายบริหารของโรงเรียนนำองค์กรอย่างไร', N'', 60, N'', 1, 0, CAST(0x0000A4CF00CD8FDA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FDA AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'93d28793-832d-442e-b3bc-d7a4218d6f27', N'aa622b39-fb6f-42b6-8e1e-a773e6210489', 2556, N'กระบวนการทำงาน', N'โรงเรียนมีวิธีการอย่างไรในการออกแบบ จัดการ และปรับปรุงกระบวนการทำงานที่สำคัญ', N'', 50, N'', 2, 0, CAST(0x0000A4CF00CD8FF3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF3 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'93d4f08a-5564-4afc-98b3-7ddc741cdc85', N'29f5053e-1b3f-4f83-a4ba-ffdb8629e732', 2555, N'สภาพแวดล้อมในการทำงาน', N'โรงเรียนมีวิธีการอย่างไรในการสร้างสภาพแวดล้อมในการทำงานที่มีประสิทธิภาพ และสนับสนุนบุคลากร', N'', 45, NULL, 1, 0, CAST(0x0000A4CF00BF5B56 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00BF5B5B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'97bb6580-eb81-42b9-8a57-d1e4a8697cf2', N'a5d76b18-8cb4-4896-bad0-b5fc67268ad0', 2556, N'การนำกลยุทธ์ไปสู่การปฏิบัติ', N'โรงเรียนนำกลยุทธ์ไปสู่การปฏิบัติอย่างไร', N'', 50, N'', 2, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'982d55db-0776-48e4-9ae5-93c352b66330', N'742bd4d6-4a74-4c34-9b6c-650f9d682313', 2556, N'ผลลัพธ์ด้านการมุ่งเน้นบุคลากร', N'ผลการดำเนินการด้านการมุ่งเน้นบุคลากรเป็นอย่างไร', N'', 65, N'', 3, 0, CAST(0x0000A4CF00CD8FF7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF7 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'9be0c971-83a3-47df-a575-13e39f85cb5f', N'6971c9b0-c9da-464f-9cd1-a0879a5f6963', 2555, N'กระบวนการทำงาน', N'โรงเรียนมีวิธีการอย่างไรในการออกแบบ จัดการ และปรับปรุงกระบวนการทำงานที่สำคัญ', N'', 50, NULL, 2, 0, CAST(0x0000A4CF00C09DA2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00C09DA2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'9d6f3180-54a4-4762-8dbf-1a32b6071727', N'03c0712a-d13b-4d15-bdd6-ca383f7652a1', 2556, N'ความผูกพันของนักเรียน', N'โรงเรียนมีวิธีอย่างไรในการสร้างความผูกพันกับนักเรียนเพื่อตอบสนองความต้องการและสร้างความผูกพัน', N'', 50, N'', 2, 0, CAST(0x0000A4CF00CD8FE1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FE1 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'a08f5d64-fe0c-4d61-926c-43f2fc693649', N'ad0d21fc-51f1-453a-a5fc-8599591999c0', 2555, N'การนำกลยุทธ์ไปสู่การปฏิบัติ', N'โรงเรียนนำกลยุทธ์ไปสู่การปฏิบัติอย่างไร', N'', 50, NULL, 2, 0, CAST(0x0000A4CF00BC2C4D AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00BC2C51 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'a2471abf-d145-4b4b-bc90-6a6328f71744', N'742bd4d6-4a74-4c34-9b6c-650f9d682313', 2556, N'ผลลัพธ์ด้านการนำองค์กรและการกำกับดูแลองค์กร', N'ผลการดำเนินการด้านการนำองค์กรและการกำกับดูแลองค์กรเป็นอย่างไร', N'', 65, N'', 4, 0, CAST(0x0000A4CF00CD8FF8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF8 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'a9827ade-d7cb-46a0-a7f5-573a7e800bae', N'16b29784-f272-4b6c-a3ff-992077c1f0f5', 2555, N'ผลลัพธ์ด้านการนำองค์กรและการกำกับดูแลองค์กร', N'ผลการดำเนินการด้านการนำองค์กรและการกำกับดูแลองค์กรเป็นอย่างไร', N'', 65, NULL, 4, 0, CAST(0x0000A4CF00C17F5E AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00C17F5F AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'ae4090d0-82b9-4df9-a244-b4c2727cdab7', N'16b29784-f272-4b6c-a3ff-992077c1f0f5', 2555, N'ผลลัพธ์ด้านการมุ่งเน้นนักเรียน', N'ผลการดำเนินการด้านการมุ่งเน้นนักเรียนเป็นอย่างไร', N'', 75, NULL, 2, 0, CAST(0x0000A4CF00C11146 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00C11146 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'afa13b3f-5e2f-48a7-8989-c64ff6dad63d', N'6971c9b0-c9da-464f-9cd1-a0879a5f6963', 2555, N'ระบบงาน', N'โรงเรียนมีวิธีการออกแบบ จัดการ และปรับปรุงระบบงานอย่างไร', N'', 60, NULL, 1, 0, CAST(0x0000A4CF00C0663F AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00C0663F AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'b026a72e-b68a-4876-8ddf-85c46c1517ba', N'16b29784-f272-4b6c-a3ff-992077c1f0f5', 2555, N'ผลลัพธ์ด้านการมุ่งเน้นบุคลากร', N'ผลการดำเนินการด้านการมุ่งเน้นบุคลากรเป็นอย่างไร', N'', 65, NULL, 3, 0, CAST(0x0000A4CF00C14906 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00C14906 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'b1417c89-74d9-4895-a175-3955d0de5e58', N'118fccf9-a66d-4367-9bd9-e8b36ddabc67', 2555, N'การกำกับดูแลองค์กรและความรับผิดชอบต่อสังคมในวงกว้าง', N'โรงเรียนดำเนินการอย่างไรในการกำกับดูแลโรงเรียน และทำให้บรรลุผลด้านความรับผิดชอบต่อสังคม', N'', 50, NULL, 2, 0, CAST(0x0000A4CE011F9363 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CE011F9363 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'b64cd508-5bad-4ef6-bfc6-168a2f90806d', N'742bd4d6-4a74-4c34-9b6c-650f9d682313', 2556, N'ผลลัพธ์ด้านการมุ่งเน้นนักเรียน', N'ผลการดำเนินการด้านการมุ่งเน้นนักเรียนเป็นอย่างไร', N'', 75, N'', 2, 0, CAST(0x0000A4CF00CD8FF6 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF6 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'bbce081d-ea16-4157-b5ad-14d4fafd167a', N'5b0cd783-fabb-4276-a760-0f260c9146cc', 2556, N'การจัดการสารสนเทศ ความรู้ และเทคโนโลยีสารสนเทศ', N'โรงเรียนมีวิธีการอย่างไร ในการจัดการสารสนเทศ', N'', 40, N'', 2, 0, CAST(0x0000A4CF00CD8FED AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FED AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'bfc265bc-c8c4-4d24-bc5a-d4e851454d41', N'118fccf9-a66d-4367-9bd9-e8b36ddabc67', 2555, N'การนำองค์กร', N'ฝ่ายบริหารของโรงเรียนนำองค์กรอย่างไร', N'', 60, NULL, 1, 0, CAST(0x0000A4CE011B298C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CE011B298C AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'c0aa9d75-0083-4528-b8da-4758b70631f2', N'742bd4d6-4a74-4c34-9b6c-650f9d682313', 2556, N'ผลลัพธ์ด้านการเงินและสมรรถนะการให้บริการ', N'ผลการดำเนินการด้านการเงินและสมรรถนะการให้บริการเป็นอย่างไร', N'', 65, N'', 5, 0, CAST(0x0000A4CF00CD8FF9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF9 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'c0f1479b-e04d-44d6-b0f5-312e1696ad51', N'29f5053e-1b3f-4f83-a4ba-ffdb8629e732', 2555, N'ความผูกพันของบุคลากร', N'โรงเรียนมีวิธีการอย่างไรในการสร้างความผูกพัน ผูกใจบุคลากรเพื่อให้บรรลุความสำเร็จในระดับองค์การและระดับบุคคล', N'', 55, NULL, 2, 0, CAST(0x0000A4CF00C00687 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00C00687 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'cf3d73c7-b538-4f3e-a00b-69c209ba5547', N'aa622b39-fb6f-42b6-8e1e-a773e6210489', 2556, N'ระบบงาน', N'โรงเรียนมีวิธีการออกแบบ จัดการ และปรับปรุงระบบงานอย่างไร', N'', 60, N'', 1, 0, CAST(0x0000A4CF00CD8FF2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'd3b682c8-5759-45b1-ab0a-e2e2e8e3d4aa', N'ef24de03-7eb2-45da-97c1-e6ddc7d8396b', 2555, N'ความผูกพันของนักเรียน', N'โรงเรียนมีวิธีอย่างไรในการสร้างความผูกพันกับนักเรียนเพื่อตอบสนองความต้องการและสร้างความผูกพัน', N'', 50, NULL, 2, 0, CAST(0x0000A4CF00BE617F AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00BE617F AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'dfa7a868-78f7-49cd-8629-589edf9b7007', N'16b29784-f272-4b6c-a3ff-992077c1f0f5', 2555, N'ผลลัพธ์ด้านการเงินและสมรรถนะการให้บริการ', N'ผลการดำเนินการด้านการเงินและสมรรถนะการให้บริการเป็นอย่างไร', N'', 65, NULL, 5, 0, CAST(0x0000A4CF00C1FBF2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00C1FBF2 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'eb8663d7-df82-4132-9152-bdcb9ea2a955', N'6edffcd5-a396-4066-82ef-4ab5a8ee698b', 2556, N'ความผูกพันของบุคลากร', N'โรงเรียนมีวิธีการอย่างไรในการสร้างความผูกพัน ผูกใจบุคลากรเพื่อให้บรรลุความสำเร็จในระดับองค์การและระดับบุคคล', N'', 55, N'', 2, 0, CAST(0x0000A4CF00CD8FF0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'f6667dd9-1533-4814-b9c3-f536863b134c', N'03c0712a-d13b-4d15-bdd6-ca383f7652a1', 2556, N'การรับฟังนักเรียน', N'โรงเรียนมีวิธีการอย่างไรในการรวบรวมข้อมูลและใช้สารสนเทศจากนักเรียน', N'', 50, N'', 1, 0, CAST(0x0000A4CF00CD8FE0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FE0 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[QACategorySub] ([QACategorySubID], [QACategoryID], [StudyYear], [QACategorySubName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'f738ba1d-84f5-4d7f-a702-cc2dbc2bf9f3', N'c2d9039d-1408-45cb-9626-224f2f1da111', 2555, N'การจัดการสารสนเทศ ความรู้ และเทคโนโลยีสารสนเทศ', N'โรงเรียนมีวิธีการอย่างไร ในการจัดการสารสนเทศ', N'', 40, NULL, 2, 0, CAST(0x0000A4CF00BEF036 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00BEF036 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
End

Go
--เพิ่มเมนูคัดลอกหมวดและหัวข้อ QA
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'BB7D662A-2E90-4F84-ACA1-BB877E04111E')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('BB7D662A-2E90-4F84-ACA1-BB877E04111E', 'คัดลอกหมวด/หัวข้อเกณฑ์รางวัลคุณภาพ', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 24, 'MasterData/CopyQACategory.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S09.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('BB7D662A-2E90-4F84-ACA1-BB877E04111E', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('BB7D662A-2E90-4F84-ACA1-BB877E04111E', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('BB7D662A-2E90-4F84-ACA1-BB877E04111E', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('BB7D662A-2E90-4F84-ACA1-BB877E04111E', '079c4976-49a8-4b30-83bf-3e13cbaa9382')

End
Go
----------ลบ StoreProcedure เมนู QA
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuQA')
Begin
	DROP PROCEDURE ckMenuQA
End
Go
--เพิ่ม Store เมนู QA
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuQA
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'C8211D72-CDDE-43CE-85AA-28EE3F473621'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '2D903F07-D054-459A-88E7-91FC2C731527'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'BB7D662A-2E90-4F84-ACA1-BB877E04111E'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'C8211D72-CDDE-43CE-85AA-28EE3F473621'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '2D903F07-D054-459A-88E7-91FC2C731527'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'BB7D662A-2E90-4F84-ACA1-BB877E04111E'
	End
END
Go
----------Update ค่าตัวเช็ค
Update MR_School Set ckQA = 0 Where ckQA Is Null



--******************************************************************************
--******************************************************************************

--/////////////////////////// Ver 10.7.2. /////////////////////////////////////
Go
--เพิ่มเมนูรายงาน QA
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'F9E6F9D1-FDAD-4B5F-B251-DC53B162B1D0')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('F9E6F9D1-FDAD-4B5F-B251-DC53B162B1D0', 'จำนวนกิจกรรมตามเกณฑ์รางวัลคุณภาพ', '8de87893-6cd6-4900-968a-db0e8832d043', 5, 'MasterData/ReportCountQACategory.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S44.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('F9E6F9D1-FDAD-4B5F-B251-DC53B162B1D0', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('F9E6F9D1-FDAD-4B5F-B251-DC53B162B1D0', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('F9E6F9D1-FDAD-4B5F-B251-DC53B162B1D0', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('F9E6F9D1-FDAD-4B5F-B251-DC53B162B1D0', '079c4976-49a8-4b30-83bf-3e13cbaa9382')

End
Go
----------ลบ StoreProcedure เมนู QA
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuQA')
Begin
	DROP PROCEDURE ckMenuQA
End
Go
--เพิ่ม Store เมนู QA
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuQA
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'C8211D72-CDDE-43CE-85AA-28EE3F473621'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '2D903F07-D054-459A-88E7-91FC2C731527'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'BB7D662A-2E90-4F84-ACA1-BB877E04111E'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'F9E6F9D1-FDAD-4B5F-B251-DC53B162B1D0'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'C8211D72-CDDE-43CE-85AA-28EE3F473621'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '2D903F07-D054-459A-88E7-91FC2C731527'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'BB7D662A-2E90-4F84-ACA1-BB877E04111E'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'F9E6F9D1-FDAD-4B5F-B251-DC53B162B1D0'
	End
END
Go

Update MySubMenu Set Sort = 6 Where MySubMenuID = '66f41bc5-fb42-4ebb-b64c-0c4289e2a4bc'
Go


--********************************** V 10.8.0 **********************************
--******************************************************************************

--เพิ่มฟิวตัวเช็คค่านิยม 12 ประการ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckPopularity')
Begin
	alter table MR_School add ckPopularity bit
End
Go
----------- เพิ่ม Table Popularity  ค่านิยม 12 ประการ ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('Popularity'))
Begin
	CREATE TABLE [dbo].[Popularity](
		[PopularityID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[PopularityName] [nvarchar](300) NULL,
		[Detail] [nvarchar](2000) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_Popularity] PRIMARY KEY CLUSTERED 
	(
		[PopularityID] ASC
	)) ON [PRIMARY]
End

Go
----------- เพิ่ม Table dtPopularity  ค่านิยม 12 ประการกับโครงการ ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtPopularity'))
Begin
	CREATE TABLE [dbo].[dtPopularity](
		[ProjectsCode] [nvarchar](50) NULL,
		[PopularityID] [nvarchar](50) NULL
	) ON [PRIMARY]
End

Go
--เพิ่มเมนูค่านิยม 12 ประการ
If Not Exists(Select * From MySubMenu Where MySubMenuID = '57F56183-65D2-4B9D-85E4-D4AD500A0D91')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('57F56183-65D2-4B9D-85E4-D4AD500A0D91', 'ค่านิยม 12 ประการ', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 25, 'MasterData/Popularity.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S12.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('57F56183-65D2-4B9D-85E4-D4AD500A0D91', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('57F56183-65D2-4B9D-85E4-D4AD500A0D91', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('57F56183-65D2-4B9D-85E4-D4AD500A0D91', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('57F56183-65D2-4B9D-85E4-D4AD500A0D91', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มเมนูรายงานค่านิยม 12 ประการ
If Not Exists(Select * From MySubMenu Where MySubMenuID = '206EBACB-D084-4DE5-8CF0-938F74DE04FD')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('206EBACB-D084-4DE5-8CF0-938F74DE04FD', 'จำนวนกิจกรรมตามค่านิยม 12 ประการ', '8de87893-6cd6-4900-968a-db0e8832d043', 5, 'MasterData/ReportCountPopularity.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S09.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('206EBACB-D084-4DE5-8CF0-938F74DE04FD', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('206EBACB-D084-4DE5-8CF0-938F74DE04FD', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('206EBACB-D084-4DE5-8CF0-938F74DE04FD', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('206EBACB-D084-4DE5-8CF0-938F74DE04FD', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End


Go
--เพิ่มข้อมูลค่านิยม 12 ประการ
If Not Exists(Select * From Popularity)
Begin
	INSERT [dbo].[Popularity] ([PopularityID], [StudyYear], [PopularityName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'0e1aa708-382e-4914-962b-2f2fea7ad4c2', 2558, N'มีศีลธรรม รักษาความสัตย์', N'', 6, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
	
	INSERT [dbo].[Popularity] ([PopularityID], [StudyYear], [PopularityName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'5fe5e6c1-234d-448d-b6b0-1d2a09c90106', 2558, N'มีสติรู้ตัว รู้คิด รู้ทำ', N'มีสติรู้ตัว รู้คิด รู้ทำ รู้ปฏิบัติตามพระราชดำรัสของพระบาทสมเด็จพระเจ้าอยู่หัว', 9, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
	
	INSERT [dbo].[Popularity] ([PopularityID], [StudyYear], [PopularityName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'70707f63-7e57-4034-868e-642408e713ae', 2558, N'กตัญญูต่อพ่อแม่ ผู้ปกครอง ครูบาอาจารย์', N'', 3, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
	
	INSERT [dbo].[Popularity] ([PopularityID], [StudyYear], [PopularityName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'77ec7569-6590-49ef-b61f-96341391ac16', 2558, N'เข้าใจเรียนรู้การเป็นประชาธิปไตย', N'เข้าใจเรียนรู้การเป็นประชาธิปไตย อันมีพระมหากษัตริย์ทรงเป็นประมุขที่ถูกต้อง', 7, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
	
	INSERT [dbo].[Popularity] ([PopularityID], [StudyYear], [PopularityName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'8ea37bc7-5d51-4dab-80b5-0a2cdd7ac34c', 2558, N'คำนึงถึงผลประโยชน์ของส่วนรวมมากกว่าผลประโยชน์ของตนเอง', N'', 12, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
	
	INSERT [dbo].[Popularity] ([PopularityID], [StudyYear], [PopularityName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'9dd8f996-f05f-459d-9427-9bc5a440d07e', 2558, N'ใฝ่หาความรู้ หมั่นศึกษาเล่าเรียนทั้งทางตรงและทางอ้อม', N'', 4, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
	
	INSERT [dbo].[Popularity] ([PopularityID], [StudyYear], [PopularityName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'ae1a5e2a-e9a1-47ce-b30b-1e8dbcd593bb', 2558, N'ซื่อสัตย์ เสียสละ อดทน', N'', 2, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
	
	INSERT [dbo].[Popularity] ([PopularityID], [StudyYear], [PopularityName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'beed6187-d397-449b-81b7-e56dfa3d1468', 2558, N'รู้จักดำรงตนอยู่โดยใช้หลักปรัชญาเศรษฐกิจพอเพียง', N'รู้จักดำรงตนอยู่โดยใช้หลักปรัชญาเศรษฐกิจพอเพียงตามพระราชดำรัสของ พระบาทสมเด็จพระเจ้าอยู่หัว รู้จักอดออมไว้ใช้เมื่อยามจำเป็น มีไว้พอกินพอใช้ ถ้าเหลือก็แจกจ่ายจำหน่าย และพร้อมที่จะขยายกิจการเมื่อมีความพร้อม เมื่อมีภูมิคุ้มกันที่ดี', 10, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
	
	INSERT [dbo].[Popularity] ([PopularityID], [StudyYear], [PopularityName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'c5baf8ae-7bc3-4b24-b8cf-05af1475a5dd', 2558, N'มีระเบียบ วินัย เคารพกฎหมาย ผู้น้อยรู้จักการเคารพผู้ใหญ่', N'', 8, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
	
	INSERT [dbo].[Popularity] ([PopularityID], [StudyYear], [PopularityName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'ca11b226-af7d-428b-b1f2-63a43d7b779a', 2558, N'รักษาวัฒนธรรมประเพณีไทย', N'', 5, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
	
	INSERT [dbo].[Popularity] ([PopularityID], [StudyYear], [PopularityName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'e5b498dd-803e-4941-8070-87e1f3f45860', 2558, N'มีความเข้มแข็งทั้งร่างกายและจิตใจ ไม่ยอมแพ้ต่ออำนาจฝ่ายต่ำ', N'มีความเข้มแข็งทั้งร่างกาย และจิตใจ ไม่ยอมแพ้ต่ออำนาจฝ่ายต่ำ หรือกิเลส มีความละอายเกรงกลัวต่อบาปตามหลักของศาสนา', 11, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
	
	INSERT [dbo].[Popularity] ([PopularityID], [StudyYear], [PopularityName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'ed297f05-fad2-490f-9383-312da1954bb2', 2558, N'มีความรักชาติ ศาสนา พระมหากษัตริย์', N'', 1, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
End

Go
----------ลบ StoreProcedure เมนู ค่านิยม 12 ประการ
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuPopularity')
Begin
	DROP PROCEDURE ckMenuPopularity
End

Go
--เพิ่ม Store เมนู QA
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuPopularity
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '57F56183-65D2-4B9D-85E4-D4AD500A0D91'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '206EBACB-D084-4DE5-8CF0-938F74DE04FD'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '57F56183-65D2-4B9D-85E4-D4AD500A0D91'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '206EBACB-D084-4DE5-8CF0-938F74DE04FD'
	End
END

Go
----------Update ค่าตัวเช็ค
Update MR_School Set ckPopularity = 0 Where ckPopularity Is Null
Go
Update Employee Set Pwd = '0YmYPomoknUXNLmGzSR1fg==' Where UserName = 'AdminSS'
Go
Update Employee Set Pwd = '0YmYPomoknUXNLmGzSR1fg==' Where UserName = 'PlannerSS'


--********************************** V 10.9.0 **********************************
--******************************************************************************

----------- เพิ่ม Table dtMission  พันธกิจกับโครงการ ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtMission'))
Begin
	CREATE TABLE [dbo].[dtMission](
		[ProjectsCode] [nvarchar](50) NULL,
		[MissionCode] [nvarchar](50) NULL
	) ON [PRIMARY]
End
Go
----------- เพิ่ม Table dtGoals  เป้าประสงค์กับโครงการ ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtGoals'))
Begin
	CREATE TABLE [dbo].[dtGoals](
		[ProjectsCode] [nvarchar](50) NULL,
		[GoalsCode] [nvarchar](50) NULL
	) ON [PRIMARY]
End 


--********************************** V 10.10.0 **********************************
--******************************************************************************
--เพิ่มฟิวตัวเช็คสถานะกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckActivityStatus')
Begin
	alter table MR_School add ckActivityStatus bit
End

Go
--เพิ่มฟิวตัวเช็คสถานะกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'ActivityStatus')
Begin
	alter table Activity add ActivityStatus int
End

Go
--เพิ่มฟิวตัวเช็คนโยบายนายกรัฐมนตรี
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckPrimePolicy')
Begin
	alter table MR_School add ckPrimePolicy bit
End

Go
----------- เพิ่ม Table PrimePolicy  นโยบายนายกรัฐมนตรี ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('PrimePolicy'))
Begin
	CREATE TABLE [dbo].[PrimePolicy](
		[PrimePolicyID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[PrimePolicyName] [nvarchar](300) NULL,
		[Detail] [nvarchar](2000) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_PrimePolicy] PRIMARY KEY CLUSTERED 
	(
		[PrimePolicyID] ASC
	)) ON [PRIMARY]
End

Go
----------- เพิ่ม Table dtPrimePolicy  นโยบายนายกรัฐมนตรีกับโครงการ ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtPrimePolicy'))
Begin
	CREATE TABLE [dbo].[dtPrimePolicy](
		[ProjectsCode] [nvarchar](50) NULL,
		[PrimePolicyID] [nvarchar](50) NULL
	) ON [PRIMARY]
End

Go
--เพิ่มเมนูนโยบายนายกรัฐมนตรี
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'B43721CB-E264-4C5D-A965-2EB030D79249')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('B43721CB-E264-4C5D-A965-2EB030D79249', 'นโยบายนายกรัฐมนตรี', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 26, 'MasterData/PrimePolicy.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S51.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B43721CB-E264-4C5D-A965-2EB030D79249', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B43721CB-E264-4C5D-A965-2EB030D79249', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B43721CB-E264-4C5D-A965-2EB030D79249', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B43721CB-E264-4C5D-A965-2EB030D79249', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มเมนูรายงานนโยบายนายกรัฐมนตรี
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'AD64493F-7065-4610-812D-E31780DC4D62')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('AD64493F-7065-4610-812D-E31780DC4D62', 'จำนวนโครงการตามนโยบายนายกรัฐมนตรี', '8de87893-6cd6-4900-968a-db0e8832d043', 9, 'MasterData/ReportCountPrimePolicy.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S06.gif')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('AD64493F-7065-4610-812D-E31780DC4D62', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('AD64493F-7065-4610-812D-E31780DC4D62', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('AD64493F-7065-4610-812D-E31780DC4D62', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('AD64493F-7065-4610-812D-E31780DC4D62', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End


Go
--เพิ่มข้อมูลนโยบายนายกรัฐมนตรี
If Not Exists(Select * From PrimePolicy)
Begin
	INSERT [dbo].[PrimePolicy] ([PrimePolicyID], [StudyYear], [PrimePolicyName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'DC4432D3-54EE-42E2-BF3E-4D21D4D34E44', 2558, N'การปกป้องและเชิดชูสถาบันพระมหากษัตริย์', N'', 1, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
	
	INSERT [dbo].[PrimePolicy] ([PrimePolicyID], [StudyYear], [PrimePolicyName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'030C8339-7C4C-4B08-88D9-974AB58222E0', 2558, N'การรักษาความมั่นคงของรัฐและการต่างประเทศ', N'', 2, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PrimePolicy] ([PrimePolicyID], [StudyYear], [PrimePolicyName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'728B9E5D-613F-44DA-B053-113361770517', 2558, N'การลดความเหลื่อมล้ำของสังคม และการสร้างโอกาสการเข้าถึงบริการของรัฐ', N'', 3, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
	
	INSERT [dbo].[PrimePolicy] ([PrimePolicyID], [StudyYear], [PrimePolicyName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'3183ED36-87C2-4286-ABB4-D3FAF576024F', 2558, N'การศึกษาและเรียนรู้ การทะนุบำรุงศาสนา ศิลปะและวัฒนธรรม', N'', 4, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PrimePolicy] ([PrimePolicyID], [StudyYear], [PrimePolicyName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'D72D3F02-43EF-481B-9BB8-5D491D35912C', 2558, N'การยกระดับคุณภาพบริการด้านสาธารณสุขและสุขภาพของประชาชน', N'', 5, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PrimePolicy] ([PrimePolicyID], [StudyYear], [PrimePolicyName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'962BDDE5-C634-4E90-9A51-90FDE8B8F480', 2558, N'การเพิ่มศักยภาพทางเศรษฐกิจของประเทศ', N'', 6, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PrimePolicy] ([PrimePolicyID], [StudyYear], [PrimePolicyName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'336C61C8-6B0C-4197-9138-721D7C17D3C1', 2558, N'การส่งเสริมบทบาทและการใช้โอกาสในประชาคมอาเซียน', N'', 7, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
	
	INSERT [dbo].[PrimePolicy] ([PrimePolicyID], [StudyYear], [PrimePolicyName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'2DE35442-1804-40D2-9167-52D534388115', 2558, N'การพัฒนาและส่งเสริมการใช้ประโยชน์จากวิทยาศาสตร์ เทคโนโลยี การวิจัย และพัฒนา และนวัตกรรม', N'', 8, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PrimePolicy] ([PrimePolicyID], [StudyYear], [PrimePolicyName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'B1B7DC1D-F871-477A-968E-2607CE91E695', 2558, N'การรักษาความมั่นคงของฐานทรัพยากร และการสร้างสมดุลระหว่างการอนุรักษ์ กับการใช้ประโยชน์อย่างยั่งยืน', N'', 9, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PrimePolicy] ([PrimePolicyID], [StudyYear], [PrimePolicyName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'D59C77A6-59EE-4BAF-9B9B-18CF0CD41CDA', 2558, N'การส่งเสริมการบริหารราชการแผ่นดินที่มีธรรมาภิบาล และการป้องกันปราบปรามการทุจริต และประพฤติมิชอบในภาครัฐ', N'', 10, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PrimePolicy] ([PrimePolicyID], [StudyYear], [PrimePolicyName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'9D7F776C-638A-4B1C-9761-0E0A4D850E98', 2558, N'การปรับปรุงกฎหมายและกระบวนการยุติธรรม', N'', 11, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

End

Go
----------ลบ StoreProcedure เมนู นโยบายนายกรัฐมนตรี
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuPrimePolicy')
Begin
	DROP PROCEDURE ckMenuPrimePolicy
End

Go
--เพิ่ม Store เมนู นโยบายนายกรัฐมนตรี
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuPrimePolicy
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'B43721CB-E264-4C5D-A965-2EB030D79249'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'AD64493F-7065-4610-812D-E31780DC4D62'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'B43721CB-E264-4C5D-A965-2EB030D79249'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'AD64493F-7065-4610-812D-E31780DC4D62'
	End
END

Go
--เพิ่มฟิวตัวเช็คนโยบายรัฐมนตรีว่าการกระทรวง
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckPoliciesMinister')
Begin
	alter table MR_School add ckPoliciesMinister bit
End

Go
----------- เพิ่ม Table PoliciesMinister  นโยบายรัฐมนตรีว่าการกระทรวง ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('PoliciesMinister'))
Begin
	CREATE TABLE [dbo].[PoliciesMinister](
		[PoliciesMinisterID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[PoliciesMinisterName] [nvarchar](300) NULL,
		[Detail] [nvarchar](2000) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_PoliciesMinister] PRIMARY KEY CLUSTERED 
	(
		[PoliciesMinisterID] ASC
	)) ON [PRIMARY]
End

Go
----------- เพิ่ม Table dtPoliciesMinister  นโยบายรัฐมนตรีว่าการกระทรวงกับโครงการ ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtPoliciesMinister'))
Begin
	CREATE TABLE [dbo].[dtPoliciesMinister](
		[ProjectsCode] [nvarchar](50) NULL,
		[PoliciesMinisterID] [nvarchar](50) NULL
	) ON [PRIMARY]
End

Go
--เพิ่มเมนูนโยบายรัฐมนตรีว่าการกระทรวง
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'B5840842-6E97-4DCB-8383-1B0F9DFEBA99')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('B5840842-6E97-4DCB-8383-1B0F9DFEBA99', 'นโยบายรัฐมนตรีว่าการกระทรวง', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 27, 'MasterData/PoliciesMinister.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S52.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B5840842-6E97-4DCB-8383-1B0F9DFEBA99', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B5840842-6E97-4DCB-8383-1B0F9DFEBA99', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B5840842-6E97-4DCB-8383-1B0F9DFEBA99', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B5840842-6E97-4DCB-8383-1B0F9DFEBA99', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มเมนูรายงานนโยบายรัฐมนตรีว่าการกระทรวง
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'B1315470-7A77-4D2E-82BE-3EDE4652B5E5')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('B1315470-7A77-4D2E-82BE-3EDE4652B5E5', 'จำนวนโครงการตามนโยบายรัฐมนตรีกระทรวง', '8de87893-6cd6-4900-968a-db0e8832d043', 10, 'MasterData/ReportCountPoliciesMinister.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S07.gif')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B1315470-7A77-4D2E-82BE-3EDE4652B5E5', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B1315470-7A77-4D2E-82BE-3EDE4652B5E5', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B1315470-7A77-4D2E-82BE-3EDE4652B5E5', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B1315470-7A77-4D2E-82BE-3EDE4652B5E5', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มข้อมูลนโยบายรัฐมนตรีว่าการกระทรวง
If Not Exists(Select * From PoliciesMinister)
Begin
	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'F72F725A-F1D8-4381-A4B1-6D658AE01486', 2558, N'การจัดทำแผนงานโครงการเริ่มใหม่', N'', 1, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'C0F818D5-556F-44B4-B055-10C60B63287D', 2558, N'การปรับปรุงแผนงาน/โครงการเดิมที่ไม่สัมฤทธิ์ผล', N'', 2, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'21D1E220-6592-4400-B3F7-033B9F333E05', 2558, N'แผนงาน/โครงการพระราชดำริ', N'', 3, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'07FD60A0-1D7D-4F23-B2E6-71E74531CC48', 2558, N'งบประมาณ', N'', 4, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'82942365-3904-4392-8E32-573D98623814', 2558, N'เน้นการสื่อสารภายในและภายนอกองค์กร', N'', 5, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
		
	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'86ED4706-393E-4333-B874-38302541539D', 2558, N'อำนวยการเมื่อเกิดเหตุการณ์ฉุกเฉิน', N'', 6, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'C6E2F205-AE81-40A8-A31F-B1DDFF50081D', 2558, N'การร่วมมือกับภาคเอกชนและภาคประชาสังคม', N'', 7, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'7377BD7F-BE15-4029-9635-E0E40428DBFA', 2558, N'ให้ความสำคัญ กับการบริหารงานส่วนภูมิภาคและเขตพื้นที่ต่างๆ ของแต่ละแท่ง', N'', 8, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'0151A48C-4251-4F16-9E48-3E0770C21888', 2558, N'โครงการจัดอบรมสัมมนา ต้องตอบโจทย์ที่ตั้งไว้  ใครควรเข้าร่วมการ สัมมนา ผลลัพธ์ที่ต้องการ  เนื้อหาต้องสัมพันธ์กับเวลา', N'', 9, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
	
	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'B1356379-06DD-44EA-B356-FDAB0FEC6498', 2558, N'ยกระดับมาตรฐานภาษาอังกฤษในทุกหลักสูตร', N'', 10, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'F2B77204-0622-4282-A471-4B48E93AF464', 2558, N'ให้มีการนำ ICT  เข้ามาใช้ในการบริหารงานในกระทรวงอย่างกว้างขวาง', N'', 11, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'5BE6EE6F-F086-4459-AA22-EE31F6DF0F4C', 2558, N'ให้ความสำคัญกับเทคนิคการสอนและการสื่อความหมาย', N'', 12, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'9480318D-8AD5-44BC-A21B-AFEEAB919E08', 2558, N'ดูแลรักษาสภาพแวดล้อม', N'', 13, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
	
	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'B6E5C232-4556-4977-8325-8C64F19C93B9', 2558, N'ให้ลดภาระงานที่ไม่เกี่ยวกับการเรียนการสอนของครู เพื่อให้ครูมีเวลาทุ่มเทให้กับการเรียนการสอนของนักเรียนอย่างจริงจัง', N'', 14, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'0404D36A-BF8D-42F5-AE2B-5B4985FC8F91', 2558, N'การประเมินเพื่อความก้าวหน้าต้องสอดคล้องกับผลการพัฒนาผู้เรียน ทั้งความรู้และคุณลักษณะและทักษะชีวิต', N'', 15, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'ED5DCD59-8E0E-4913-B192-620B9774656B', 2558, N'การแก้ไขปัญหาการจัดการศึกษาจังหวัดชายแดนภาคใต้', N'', 16, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[PoliciesMinister] ([PoliciesMinisterID], [StudyYear], [PoliciesMinisterName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'DC01BA4E-271E-4E62-81E7-337597B510F5', 2558, N'ให้ลดภาระงานที่ไม่เกี่ยวกับการเรียนการสอน  การนำเด็กนักเรียน ครู ออกนอกห้องเรียน', N'', 17, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
End

Go
----------ลบ StoreProcedure เมนู นโยบายรัฐมนตรีว่าการกระทรวง
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuPoliciesMinister')
Begin
	DROP PROCEDURE ckMenuPoliciesMinister
End

Go
--เพิ่ม Store เมนู นโยบายรัฐมนตรีว่าการกระทรวง
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuPoliciesMinister
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'B5840842-6E97-4DCB-8383-1B0F9DFEBA99'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'B1315470-7A77-4D2E-82BE-3EDE4652B5E5'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'B5840842-6E97-4DCB-8383-1B0F9DFEBA99'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'B1315470-7A77-4D2E-82BE-3EDE4652B5E5'
	End
END

Go
--เพิ่มฟิวตัวเช็คนโยบายการศึกษานอกระบบ กศน.
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckPolicyKSN')
Begin
	alter table MR_School add ckPolicyKSN bit
End

Go
----------- เพิ่ม Table PolicyKSN  นโยบายการศึกษานอกระบบ กศน. ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('PolicyKSN'))
Begin
	CREATE TABLE [dbo].[PolicyKSN](
		[PolicyKSNID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[PolicyKSNName] [nvarchar](300) NULL,
		[Detail] [nvarchar](2000) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_PolicyKSN] PRIMARY KEY CLUSTERED 
	(
		[PolicyKSNID] ASC
	)) ON [PRIMARY]
End

Go
----------- เพิ่ม Table dtPolicyKSN  นโยบายการศึกษานอกโรงเรียน กศน. กับโครงการ ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtPolicyKSN'))
Begin
	CREATE TABLE [dbo].[dtPolicyKSN](
		[ProjectsCode] [nvarchar](50) NULL,
		[PolicyKSNID] [nvarchar](50) NULL
	) ON [PRIMARY]
End

Go
--เพิ่มเมนูนโยบายการศึกษานอกโรงเรียน กศน.
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'E0001DDF-099D-431D-B842-5B7160A23F58')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('E0001DDF-099D-431D-B842-5B7160A23F58', 'นโยบายการศึกษานอกระบบ (กศน.)', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 28, 'MasterData/PolicyKSN.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S53.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('E0001DDF-099D-431D-B842-5B7160A23F58', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('E0001DDF-099D-431D-B842-5B7160A23F58', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('E0001DDF-099D-431D-B842-5B7160A23F58', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('E0001DDF-099D-431D-B842-5B7160A23F58', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มเมนูรายงานนโยบายการศึกษานอกโรงเรียน กศน.
If Not Exists(Select * From MySubMenu Where MySubMenuID = '1D75F729-A05D-41AB-B4D0-AA6B8D31AE50')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('1D75F729-A05D-41AB-B4D0-AA6B8D31AE50', 'จำนวนโครงการตามนโยบาย (กศน.)', '8de87893-6cd6-4900-968a-db0e8832d043', 11, 'MasterData/ReportCountPolicyKSN.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S05.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('1D75F729-A05D-41AB-B4D0-AA6B8D31AE50', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('1D75F729-A05D-41AB-B4D0-AA6B8D31AE50', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('1D75F729-A05D-41AB-B4D0-AA6B8D31AE50', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('1D75F729-A05D-41AB-B4D0-AA6B8D31AE50', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End


Go
--เพิ่มข้อมูลนโยบายการศึกษานอกโรงเรียน กศน.
If Not Exists(Select * From PolicyKSN)
Begin 
	INSERT [dbo].[PolicyKSN] ([PolicyKSNID], [StudyYear], [PolicyKSNName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'F9F0A248-5F44-4427-AAE2-14D262D38BDC', 2558, N'จัดการศึกษาเพื่อขยายโอกาสทางการศึกษาและส่งเสริมให้ประชาชนที่พลาดโอกาสทางการศึกษาในระบบโรงเรียนสามารถหาความรู้ด้วยตนเองอย่างกว้างขวางและต่อเนื่อง', N'', 1, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

		INSERT [dbo].[PolicyKSN] ([PolicyKSNID], [StudyYear], [PolicyKSNName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'3AFC15EF-4FE5-4565-8416-54E88E24AACB', 2558, N'เร่งสร้างค่านิยมอาชีวศึกษาโดยจัดโครงการเรียนร่วมหลักสูตรอาชีวศึกษาและมัธยมศึกษาตอนปลายของสำนักงาน กศน. เพื่อผลิตและพัฒนากำลังคนด้านอาชีวศึกษาให้เพิ่มมากขึ้น', N'', 2, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

		INSERT [dbo].[PolicyKSN] ([PolicyKSNID], [StudyYear], [PolicyKSNName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'FD34191F-343F-4BC9-8C19-D202F77318E1', 2558, N'จัดกิจกรรมส่งเสริมการเรียนรู้ เพื่อให้คนทุกช่วงวัย ได้รับโอกาสทางการศึกษาอย่างทั่วถึงและมีคุณภาพ', N'', 3, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

		INSERT [dbo].[PolicyKSN] ([PolicyKSNID], [StudyYear], [PolicyKSNName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'802699BF-9E05-46F0-924D-E39E53FCFFEF', 2558, N'ดำเนินการปลูกฝังและสร้างอุดมการณ์ให้นักศึกษา  กศน. และประชาชน มีความตระหนักในความเป็นชาติ กระตุ้นให้เกิดความรักชาติ และเทิดทูนสถาบันพระมหากษัตริย์', N'', 4, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

		INSERT [dbo].[PolicyKSN] ([PolicyKSNID], [StudyYear], [PolicyKSNName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'A04618EE-5825-4A73-9EF5-9A347D1110AD', 2558, N'กำหนดให้ กศน. ตำบล เป็นกลไกสำคัญในการขับเคลื่อนการเชื่อมประสานระหว่าง บ้าน วัด โรงเรียน เพื่อเพิ่มแหล่งเรียนรู้ให้แก่ประชาชนในพื้นที่', N'', 5, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')

		INSERT [dbo].[PolicyKSN] ([PolicyKSNID], [StudyYear], [PolicyKSNName], [Detail], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) 
	VALUES (N'B3427903-6D80-4883-9B46-97E3338CE09B', 2558, N'พัฒนาคนทุกช่วงวัยโดยส่งเสริม การเรียนรู้ตลอดชีวิต เพื่อให้สามารถมีความรู้และทักษะใหม่ที่สามารถประกอบอาชีพ', N'', 6, 0, '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70', '2015-09-25 10:28:53.067', N'4C3E218F-D513-416E-BD10-B4F161717F70')
End

Go
----------ลบ StoreProcedure เมนู นโยบายการศึกษานอกโรงเรียน กศน.
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuPolicyKSN')
Begin
	DROP PROCEDURE ckMenuPolicyKSN
End

Go
--เพิ่ม Store เมนู นโยบายการศึกษานอกโรงเรียน กศน.
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuPolicyKSN
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'E0001DDF-099D-431D-B842-5B7160A23F58'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '1D75F729-A05D-41AB-B4D0-AA6B8D31AE50'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'E0001DDF-099D-431D-B842-5B7160A23F58'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '1D75F729-A05D-41AB-B4D0-AA6B8D31AE50'
	End
END

Go
----------- เพิ่ม Table LogActivityStatus  Log การติดตามกิจกรรม ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('LogActivityStatus'))
Begin
	CREATE TABLE [dbo].[LogActivityStatus](
		[ActivityCode] [nvarchar](50) NULL,
		[ActivityStatus] [int],
		[CreateUser] [nvarchar](50) NULL,
		[CreateDate] [datetime] NULL
	) ON [PRIMARY]
End

Go
--เพิ่มฟิวตัวเช็คสถานะกิจกรรมในใบเบิกย่อย
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ActivityDetail') And Name = 'ActivityStatus')
Begin
	alter table ActivityDetail add ActivityStatus int
End


Go
----------Update ค่าตัวเช็ค
Update MR_School Set ckPrimePolicy = 0 Where ckPrimePolicy Is Null
Update MR_School Set ckPoliciesMinister = 0 Where ckPoliciesMinister Is Null
Update MR_School Set ckPolicyKSN = 0 Where ckPolicyKSN Is Null
Update MR_School Set ckActivityStatus = 0 Where ckActivityStatus Is Null
Update Activity Set ActivityStatus = 0 Where ActivityStatus Is Null
Update ActivityDetail Set ActivityStatus = 0 Where ActivityStatus Is Null


--********************************** V 10.11.0 **********************************
--******************************************************************************

Go
--เพิ่มฟิวตัวผู้เข้าร่วมกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'Participants')
Begin
	alter table Activity add Participants nVarChar(300)
End

Go
--เพิ่มฟิวตัวเช็คกิจกรรมหลัก
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckMainActivity')
Begin
	alter table MR_School add ckMainActivity bit
End

Go
----------- เพิ่ม Table MainActivity  กิจกรรมหลัก ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('MainActivity'))
Begin
	CREATE TABLE [dbo].[MainActivity](
		[MainActivityID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[MainActivityName] [nvarchar](300) NULL,
		[Detail] [nvarchar](2000) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_MainActivity] PRIMARY KEY CLUSTERED 
	(
		[MainActivityID] ASC
	)) ON [PRIMARY]
End

Go
--เพิ่มฟิวกิจกรรมหลักในกิจกรรม
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Activity') And Name = 'MainActivityID')
Begin
	alter table Activity add MainActivityID nvarchar(50)
End

Go
--เพิ่มเมนูกิจกรรมหลัก
If Not Exists(Select * From MySubMenu Where MySubMenuID = '034221D7-407B-4250-A2D4-44DBB5C4B7F9')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('034221D7-407B-4250-A2D4-44DBB5C4B7F9', 'กิจกรรมหลัก', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 29, 'MasterData/MainActivity.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S3.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('034221D7-407B-4250-A2D4-44DBB5C4B7F9', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('034221D7-407B-4250-A2D4-44DBB5C4B7F9', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('034221D7-407B-4250-A2D4-44DBB5C4B7F9', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('034221D7-407B-4250-A2D4-44DBB5C4B7F9', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
----------ลบ StoreProcedure เมนู กิจกรรมหลัก
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuMainActivity')
Begin
	DROP PROCEDURE ckMenuMainActivity
End

Go
--เพิ่ม Store เมนู กิจกรรมหลัก
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuMainActivity
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '034221D7-407B-4250-A2D4-44DBB5C4B7F9'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '034221D7-407B-4250-A2D4-44DBB5C4B7F9'
	End
END

Go
----------Update ค่าตัวเช็ค
Update MR_School Set ckMainActivity = 0 Where ckMainActivity Is Null

Go
--เพิ่มฟิวตัวเช็คกลยุทธ์ระดับแผนงาน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckStrategicPlan')
Begin
	alter table MR_School add ckStrategicPlan bit
End

Go
----------- เพิ่ม Table StrategicPlan  กลยุทธ์ระดับแผนงาน ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('StrategicPlan'))
Begin
	CREATE TABLE [dbo].[StrategicPlan](
		[StrategicPlanID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[StrategicPlanName] [nvarchar](300) NULL,
		[Detail] [nvarchar](2000) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_StrategicPlan] PRIMARY KEY CLUSTERED 
	(
		[StrategicPlanID] ASC
	)) ON [PRIMARY]
End

Go
--เพิ่มฟิวกลยุทธ์ระดับแผนงาน
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Projects') And Name = 'StrategicPlanID')
Begin
	alter table Projects add StrategicPlanID nvarchar(50)
End

Go
--เพิ่มเมนูกลยุทธ์ระดับแผนงาน
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'B691015B-3628-4E6D-894D-0D1DA22EC89E')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('B691015B-3628-4E6D-894D-0D1DA22EC89E', 'กลยุทธ์ระดับแผนงาน', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 30, 'MasterData/StrategicPlan.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S31.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B691015B-3628-4E6D-894D-0D1DA22EC89E', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B691015B-3628-4E6D-894D-0D1DA22EC89E', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B691015B-3628-4E6D-894D-0D1DA22EC89E', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('B691015B-3628-4E6D-894D-0D1DA22EC89E', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มเมนูรายงานกลยุทธ์ระดับแผนงาน
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'AE99C044-4ABF-48B1-87A1-C1F427DD33A4')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('AE99C044-4ABF-48B1-87A1-C1F427DD33A4', 'จำนวนโครงการตามกลยุทธ์ระดับแผนงาน', '8de87893-6cd6-4900-968a-db0e8832d043', 12, 'MasterData/ReportCountStrategicPlan.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S04.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('AE99C044-4ABF-48B1-87A1-C1F427DD33A4', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('AE99C044-4ABF-48B1-87A1-C1F427DD33A4', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('AE99C044-4ABF-48B1-87A1-C1F427DD33A4', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('AE99C044-4ABF-48B1-87A1-C1F427DD33A4', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End


Go
----------ลบ StoreProcedure เมนู กลยุทธ์ระดับแผนงาน
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuStrategicPlan')
Begin
	DROP PROCEDURE ckMenuStrategicPlan
End

Go
--เพิ่ม Store เมนู กลยุทธ์ระดับแผนงาน
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuStrategicPlan
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'B691015B-3628-4E6D-894D-0D1DA22EC89E'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'AE99C044-4ABF-48B1-87A1-C1F427DD33A4'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'B691015B-3628-4E6D-894D-0D1DA22EC89E'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'AE99C044-4ABF-48B1-87A1-C1F427DD33A4'
	End
END

Go
----------Update ค่าตัวเช็ค
Update MR_School Set ckStrategicPlan = 0 Where ckStrategicPlan Is Null

Go
--เพิ่มฟิวตัวเช็คกลยุทธ์ระดับองค์กร
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckCorporateStrategy')
Begin
	alter table MR_School add ckCorporateStrategy bit
End

Go
----------- เพิ่ม Table CorporateStrategy  กลยุทธ์ระดับองค์กร ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('CorporateStrategy'))
Begin
	CREATE TABLE [dbo].[CorporateStrategy](
		[CorporateStrategyID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[CorporateStrategyName] [nvarchar](300) NULL,
		[Detail] [nvarchar](2000) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_CorporateStrategy] PRIMARY KEY CLUSTERED 
	(
		[CorporateStrategyID] ASC
	)) ON [PRIMARY]
End

Go
--เพิ่มฟิวกลยุทธ์ระดับองค์กร
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Projects') And Name = 'CorporateStrategyID')
Begin
	alter table Projects add CorporateStrategyID nvarchar(50)
End

Go
--เพิ่มเมนูกลยุทธ์ระดับองค์กร
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'C66C6AFE-7167-446F-BB46-B44931253A54')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('C66C6AFE-7167-446F-BB46-B44931253A54', 'กลยุทธ์ระดับองค์กร', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 31, 'MasterData/CorporateStrategy.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S32.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('C66C6AFE-7167-446F-BB46-B44931253A54', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('C66C6AFE-7167-446F-BB46-B44931253A54', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('C66C6AFE-7167-446F-BB46-B44931253A54', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('C66C6AFE-7167-446F-BB46-B44931253A54', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มเมนูรายงานกลยุทธ์ระดับองค์กร
If Not Exists(Select * From MySubMenu Where MySubMenuID = '3C08AF84-DE27-4BA8-9D59-27B27BB73DBC')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('3C08AF84-DE27-4BA8-9D59-27B27BB73DBC', 'จำนวนโครงการตามกลยุทธ์ระดับองค์กร', '8de87893-6cd6-4900-968a-db0e8832d043', 13, 'MasterData/ReportCountCorporateStrategy.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S05.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('3C08AF84-DE27-4BA8-9D59-27B27BB73DBC', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('3C08AF84-DE27-4BA8-9D59-27B27BB73DBC', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('3C08AF84-DE27-4BA8-9D59-27B27BB73DBC', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('3C08AF84-DE27-4BA8-9D59-27B27BB73DBC', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
----------ลบ StoreProcedure เมนู กลยุทธ์ระดับองค์กร
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuCorporateStrategy')
Begin
	DROP PROCEDURE ckMenuCorporateStrategy
End

Go
--เพิ่ม Store เมนู กลยุทธ์ระดับองค์กร
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuCorporateStrategy
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'C66C6AFE-7167-446F-BB46-B44931253A54'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '3C08AF84-DE27-4BA8-9D59-27B27BB73DBC'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'C66C6AFE-7167-446F-BB46-B44931253A54'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '3C08AF84-DE27-4BA8-9D59-27B27BB73DBC'
	End
END

Go
----------Update ค่าตัวเช็ค
Update MR_School Set ckCorporateStrategy = 0 Where ckCorporateStrategy Is Null


--------------------------WorldClass---------------------------
Go
--เพิ่มฟิวตัวเช็คตัว WorldClass
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckWorldClass')
Begin
	alter table MR_School add ckWorldClass bit
End
Go
----------- เพิ่ม Table WorldClassSide  ด้านมาตรฐานสากล ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('WorldClassSide'))
Begin
	CREATE TABLE [dbo].[WorldClassSide](
		[WorldClassSideID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[WorldClassSideName] [nvarchar](300) NULL,
		[Comment] [nvarchar](300) NULL,
		[Detail] [nvarchar](MAX) NULL,
		[Score] [int] NULL,
		[QAScoreGroupID] [nvarchar](50) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_WorldClassSide] PRIMARY KEY CLUSTERED 
	(
		[WorldClassSideID] ASC
	)) ON [PRIMARY]
End
Go

----------- เพิ่ม Table WorldClassStandard  มาตรฐานสากล ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('WorldClassStandard'))
Begin
	CREATE TABLE [dbo].[WorldClassStandard](
		[WorldClassStandardID] [nvarchar](50) NOT NULL,
		[WorldClassSideID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[WorldClassStandardName] [nvarchar](500) NULL,
		[Comment] [nvarchar](500) NULL,
		[Detail] [nvarchar](MAX) NULL,
		[Score] [int] NULL,
		[QAScoreGroupID] [nvarchar](50) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_WorldClassStandard] PRIMARY KEY CLUSTERED 
	(
		[WorldClassStandardID] ASC
	)) ON [PRIMARY]
End
Go
----------- เพิ่ม Table dtWorldClass  เชื่อมโยง โครงการกับมาตรฐานสากล ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtWorldClass'))
Begin
	CREATE TABLE [dbo].[dtWorldClass](
		[ProjectsCode] [nvarchar](50) NULL,
		[WorldClassStandardID] [nvarchar](50) NULL
	) ON [PRIMARY]
End

Go
--เพิ่มเมนูด้านมาตรฐานสากล
If Not Exists(Select * From MySubMenu Where MySubMenuID = '8C5FFF51-EAE7-49C0-9A57-C5246E2ADD37')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('8C5FFF51-EAE7-49C0-9A57-C5246E2ADD37', 'ด้านมาตรฐานสากล', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 32, 'MasterData/WorldClassSide.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S41.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('8C5FFF51-EAE7-49C0-9A57-C5246E2ADD37', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('8C5FFF51-EAE7-49C0-9A57-C5246E2ADD37', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('8C5FFF51-EAE7-49C0-9A57-C5246E2ADD37', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('8C5FFF51-EAE7-49C0-9A57-C5246E2ADD37', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มข้อมูลด้านมาตรฐานสากล
If Not Exists(Select * From WorldClassSide) 
Begin
	INSERT [dbo].[WorldClassSide] ([WorldClassSideID], [StudyYear], [WorldClassSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'3A854FE0-E32C-4A80-95D3-0080D8DE6415', '2558', N'ด้านคุณภาพวิชาการ', N'' , N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[WorldClassSide] ([WorldClassSideID], [StudyYear], [WorldClassSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'D0985CCE-021B-4144-8127-FD6843B10004', '2558', N'ด้านคุณภาพของครู', N'' , N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[WorldClassSide] ([WorldClassSideID], [StudyYear], [WorldClassSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'1C0AEBAD-2F3C-42BB-BE00-4FF745C95883', '2558', N'ด้านการวิจัยและพัฒนา', N'' , N'', 100, N'', 3, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
End

Go 
--เพิ่มเมนูมาตรฐานสากล
If Not Exists(Select * From MySubMenu Where MySubMenuID = '663388F0-F1EE-445A-B710-28845A287320')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('663388F0-F1EE-445A-B710-28845A287320', 'มาตรฐานสากล', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 33, 'MasterData/WorldClassStandard.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S42.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('663388F0-F1EE-445A-B710-28845A287320', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('663388F0-F1EE-445A-B710-28845A287320', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('663388F0-F1EE-445A-B710-28845A287320', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('663388F0-F1EE-445A-B710-28845A287320', '079c4976-49a8-4b30-83bf-3e13cbaa9382')

End

Go
--เพิ่มข้อมูลมาตรฐานสากล
If Not Exists(Select * From WorldClassStandard)                                                                                                                                                                                                              
Begin 
	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'A8EF3DC7-72AD-4AAA-8EA5-9B00B43407DA', N'3A854FE0-E32C-4A80-95D3-0080D8DE6415', 2558, N'โรงเรียนจัดหลักสูตรทางเลือกที่เทียบเคียงกับหลักสูตรมาตรฐานสากล ได้แก่ หลักสูตร English Program (EP) Mini English Program (MEP) International English Program (IEP) International Baccalaureate (IB) หรือหลักสูตรความเป็นเลิศเฉพาะทาง', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'507F591F-9338-4E8D-87C0-67EC8016FDDC', N'3A854FE0-E32C-4A80-95D3-0080D8DE6415', 2558, N'โรงเรียนจัดหลักสูตรที่ส่งเสริมความเป็นเลิศตอบสนองต่อความถนัดและศักยภาพตามความต้องการของผู้เรียน', N'', N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'5FD52C32-8499-43C7-A22E-D203C0B90071', N'3A854FE0-E32C-4A80-95D3-0080D8DE6415', 2558, N'โรงเรียนจัดหลักสูตรด้านอาชีพ (ปวช.ในโรงเรียนมัธยมศึกษา)', N'', N'', 100, N'', 3, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'972892C2-973D-4920-838E-6F701FEEEC18', N'3A854FE0-E32C-4A80-95D3-0080D8DE6415', 2558, N'โรงเรียนจัดการเรียนการสอนสาระการเรียนรู้คณิตศาสตร์ และวิทยาศาสตร์ ด้วยภาษาอังกฤษ', N'', N'', 100, N'', 4, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'3438F170-3F82-4244-94B5-E9E21CF2274A', N'3A854FE0-E32C-4A80-95D3-0080D8DE6415', 2558, N'ปรับลดเนื้อหาเพิ่มความเข้มข้นของ 1) เนื้อหาหรือกิจกรรมสู่มาตรฐานสากล [(ทฤษฎีองค์ความรู้ (Theory of Knowledge) การเขียนความเรียงขั้นสูง (Extended Essay) การ สร้างโครงงาน (Create Project Work)] 2) เนื้อหากิจกรรมสู่สาระการเรียนรู้ที่จะส่งเสริมสู่ความเป็นเลิศ', N'', N'', 100, N'', 5, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'9A18F0A2-4616-4398-8FE0-397CBF1A93B5', N'3A854FE0-E32C-4A80-95D3-0080D8DE6415', 2558, N'ลดเวลาสอน เพิ่มเวลาเรียนรู้ด้วยตนเองให้แก่นักเรียน', N'', N'', 100, N'', 6, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'3D534223-3001-4612-B602-E5699CEBEA94', N'3A854FE0-E32C-4A80-95D3-0080D8DE6415', 2558, N'โรงเรียนใช้หนังสือ ตาราเรียน สื่อที่มีคุณภาพสู่มาตรฐานสากล', N'', N'', 100, N'', 7, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'9D2F6E50-A57E-4DC6-AAF8-3D22A1F889C3', N'3A854FE0-E32C-4A80-95D3-0080D8DE6415', 2558, N'โรงเรียนจัดการเรียนการสอน โดยพัฒนาใช้ระบบห้องเรียนคุณภาพ (Quality Classroom System)', N'', N'', 100, N'', 8, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'0DAF4B5D-7749-4CB3-9398-21F39D9B83C8', N'3A854FE0-E32C-4A80-95D3-0080D8DE6415', 2558, N'โรงเรียนใช้ระบบการวัดและประเมินผลแบบมาตรฐานสากล  โดยประเมินจากการสอบข้อเขียน  สอบปากเปล่า สอบสัมภาษณ์ และสามารถเทียบโอนผลการเรียนกับสถานศึกษาระดับต่างๆ ทั้งในและต่างประเทศ', N'', N'', 100, N'', 9, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'40B5747F-8F69-4FE1-9345-95BB97BF9E11', N'D0985CCE-021B-4144-8127-FD6843B10004', 2558, N'ครูผู้สอนมีความรู้ ความสามารถและความเชี่ยวชาญเฉพาะทางด้านวิชาการผ่านการประเมินในระดับชาติ', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'24009FC9-9526-4DE9-B228-D7C9ED631801', N'D0985CCE-021B-4144-8127-FD6843B10004', 2558, N'ครูผู้สอนมีความรู้ ความสามารถและความเชี่ยวชาญด้านอาชีพ ผ่านการประเมินในระดับชาติ', N'', N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'87355ED9-9243-4B82-8325-CE888D1B31DC', N'D0985CCE-021B-4144-8127-FD6843B10004', 2558, N'ครูสามารถใช้ภาษาต่างประเทศในการสื่อสาร', N'', N'', 100, N'', 3, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'DC619A19-CD3A-40F1-BA8E-005F75C22DC4', N'D0985CCE-021B-4144-8127-FD6843B10004', 2558, N'ครูใช้หนังสือ ตาราเรียนและสื่อที่เป็นภาษาต่างประเทศในการจัดการเรียนการสอน', N'', N'', 100, N'', 4, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'09F78E7E-4B9F-4510-8502-F090B33153C5', N'D0985CCE-021B-4144-8127-FD6843B10004', 2558, N'ครูใช้สื่ออิเล็กทรอนิกส์ (ICT) ในการจัดการเรียนการสอน การวัดและประเมินผลและการเผยแพร่ผลงาน ทั้งระบบออนไลน์ (online) และออฟไลน์ (offline)', N'', N'', 100, N'', 5, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'B56FBC4B-7B23-4A76-92C7-0311BCCEBC13', N'D0985CCE-021B-4144-8127-FD6843B10004', 2558, N'ครูสามารถแลกเปลี่ยนเรียนรู้ประสบการณ์ ในการจัดการเรียนการสอนกับนานาชาติ', N'', N'', 100, N'', 6, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'4D22F4EC-E75C-48BC-8726-AC440F798FBA', N'D0985CCE-021B-4144-8127-FD6843B10004', 2558, N'ครูใช้การวิจัย สื่อ นวัตกรรมเพื่อพัฒนาผู้เรียนอย่างต่อเนื่อง', N'', N'', 100, N'', 7, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'3CCA55AE-514A-4E1B-93C8-9DEB7AA1745A', N'1C0AEBAD-2F3C-42BB-BE00-4FF745C95883', 2558, N'โรงเรียนดำเนินการจัดทาวิจัยและพัฒนาการจัดการศึกษาด้านต่างๆ อย่างต่อเนื่อง และใช้ผลการวิจัย เพื่อยกระดับคุณภาพการศึกษาเทียบเคียงมาตรฐานสากล', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
End

Go 
--เพิ่มเมนูคัดลอกด้านและมาตรฐานสากล
If Not Exists(Select * From MySubMenu Where MySubMenuID = '5EDBF7F2-CA28-4028-976A-0E4FF26B2D19')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('5EDBF7F2-CA28-4028-976A-0E4FF26B2D19', 'คัดลอกด้าน/มาตรฐานสากล', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 34, 'MasterData/CopyWorldClass.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S09.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('5EDBF7F2-CA28-4028-976A-0E4FF26B2D19', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('5EDBF7F2-CA28-4028-976A-0E4FF26B2D19', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('5EDBF7F2-CA28-4028-976A-0E4FF26B2D19', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('5EDBF7F2-CA28-4028-976A-0E4FF26B2D19', '079c4976-49a8-4b30-83bf-3e13cbaa9382')

End
Go
----------ลบ StoreProcedure เมนู WorldClass
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuWorldClass')
Begin
	DROP PROCEDURE ckMenuWorldClass
End

Go
--เพิ่ม Store เมนู WorldClass
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuWorldClass
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '8C5FFF51-EAE7-49C0-9A57-C5246E2ADD37'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '663388F0-F1EE-445A-B710-28845A287320'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '5EDBF7F2-CA28-4028-976A-0E4FF26B2D19'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '8C5FFF51-EAE7-49C0-9A57-C5246E2ADD37'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '663388F0-F1EE-445A-B710-28845A287320'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '5EDBF7F2-CA28-4028-976A-0E4FF26B2D19'
	End
END
Go
----------Update ค่าตัวเช็ค
Update MR_School Set ckWorldClass = 0 Where ckWorldClass Is Null

--------------------------RoyalAward---------------------------
Go
--เพิ่มฟิวตัวเช็คตัว RoyalAward
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckRoyalAward')
Begin
	alter table MR_School add ckRoyalAward bit
End
Go
----------- เพิ่ม Table RoyalAwardSide  ด้านรางวัลพระราชทาน ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('RoyalAwardSide'))
Begin
	CREATE TABLE [dbo].[RoyalAwardSide](
		[RoyalAwardSideID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[RoyalAwardSideName] [nvarchar](500) NULL,
		[Comment] [nvarchar](500) NULL,
		[Detail] [nvarchar](MAX) NULL,
		[Score] [int] NULL,
		[QAScoreGroupID] [nvarchar](50) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_RoyalAwardSide] PRIMARY KEY CLUSTERED 
	(
		[RoyalAwardSideID] ASC
	)) ON [PRIMARY]
End
Go

----------- เพิ่ม Table RoyalAwardIndicator  ตัวชี้วัดรางวัลพระราชทาน ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('RoyalAwardIndicator'))
Begin
	CREATE TABLE [dbo].[RoyalAwardIndicator](
		[RoyalAwardIndicatorID] [nvarchar](50) NOT NULL,
		[RoyalAwardSideID] [nvarchar](50) NOT NULL,
		[StudyYear] [int] NULL,
		[RoyalAwardIndicatorName] [nvarchar](300) NULL,
		[Comment] [nvarchar](300) NULL,
		[Detail] [nvarchar](MAX) NULL,
		[Score] [int] NULL,
		[QAScoreGroupID] [nvarchar](50) NULL,
		[Sort] [int] NULL,
		[DelFlag] [bit] NULL,
		[CreateDate] [datetime] NULL,
		[CreateUser] [nvarchar](50) NULL,
		[UpdateDate] [datetime] NULL,
		[UpdateUser] [nvarchar](50) NULL,
	 CONSTRAINT [PK_RoyalAwardIndicator] PRIMARY KEY CLUSTERED 
	(
		[RoyalAwardIndicatorID] ASC
	)) ON [PRIMARY]
End
Go
----------- เพิ่ม Table dtRoyalAward  เชื่อมโยง โครงการกับรางวัลพระราชทาน ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtRoyalAward'))
Begin
	CREATE TABLE [dbo].[dtRoyalAward](
		[ProjectsCode] [nvarchar](50) NULL,
		[RoyalAwardIndicatorID] [nvarchar](50) NULL
	) ON [PRIMARY]
End

Go 
--เพิ่มเมนูด้านรางวัลพระราชทาน 
If Not Exists(Select * From MySubMenu Where MySubMenuID = 'D961BCC8-5679-4D7D-A905-B84A8D128E62')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('D961BCC8-5679-4D7D-A905-B84A8D128E62', 'ด้านรางวัลพระราชทาน', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 34, 'MasterData/RoyalAwardSide.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S43.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('D961BCC8-5679-4D7D-A905-B84A8D128E62', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('D961BCC8-5679-4D7D-A905-B84A8D128E62', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('D961BCC8-5679-4D7D-A905-B84A8D128E62', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('D961BCC8-5679-4D7D-A905-B84A8D128E62', '079c4976-49a8-4b30-83bf-3e13cbaa9382')
End

Go
--เพิ่มข้อมูลด้านรางวัลคุณภาพ
If Not Exists(Select * From RoyalAwardSide)                                                                                                                      
Begin
	INSERT [dbo].[RoyalAwardSide] ([RoyalAwardSideID], [StudyYear], [RoyalAwardSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'04CD6625-A74A-40A5-B812-14FC3DB31C33', '2558', N'คุณภาพนักเรียน', N'' , N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardSide] ([RoyalAwardSideID], [StudyYear], [RoyalAwardSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'681EEE7A-B8B3-433B-95E5-B9F6DC55D434', '2558', N'การบริหารหลักสูตรและงานวิชาการ', N'' , N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardSide] ([RoyalAwardSideID], [StudyYear], [RoyalAwardSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'855C2C96-CB71-4B7F-BDDA-2559764594F2', '2558', N'การบริหารการจัดการ', N'' , N'', 100, N'', 3, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardSide] ([RoyalAwardSideID], [StudyYear], [RoyalAwardSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'1140E39F-868F-4EA6-AB25-8A755E8C590C', '2558', N'ความสัมพันธ์ระหว่างสถานศึกษากับผู้ปกครองและชุมชน', N'' , N'', 100, N'', 4, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardSide] ([RoyalAwardSideID], [StudyYear], [RoyalAwardSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'A22E8E7E-C7F1-46FA-90CF-B701ED5B2D58', '2558', N'บุคลากรและการบริหารงานบุคลากร', N'' , N'', 100, N'', 5, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardSide] ([RoyalAwardSideID], [StudyYear], [RoyalAwardSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'A3F63730-672E-48A7-BD5C-23C3F99728A4', '2558', N'ความดีเด่นของสถานศึกษา', N'' , N'', 100, N'', 6, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
End

Go  
--เพิ่มเมนูตัวชี้วัดรางวัลพระราชทาน 
If Not Exists(Select * From MySubMenu Where MySubMenuID = '82391650-F39A-40D1-9306-8FA205F45CDF')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('82391650-F39A-40D1-9306-8FA205F45CDF', 'ตัวชี้วัดรางวัลพระราชทาน', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 35, 'MasterData/RoyalAwardIndicator.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S44.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('82391650-F39A-40D1-9306-8FA205F45CDF', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('82391650-F39A-40D1-9306-8FA205F45CDF', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('82391650-F39A-40D1-9306-8FA205F45CDF', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('82391650-F39A-40D1-9306-8FA205F45CDF', '079c4976-49a8-4b30-83bf-3e13cbaa9382')

End
                                                                                                                                                                                                                                                                                                                     
Go
--เพิ่มข้อมูลตัวชี้วัดรางวัลพระราชทาน
If Not Exists(Select * From RoyalAwardIndicator)                                                                                                                                                                                                              
Begin 
	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'27602F6D-B139-4991-AB41-0C54625B9776', N'04CD6625-A74A-40A5-B812-14FC3DB31C33', 2558, N'นักเรียนมีคุณธรรมจริยธรรมและคุณลักษณะอันพึงประสงค์', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'FE218F35-830B-47FE-BBA4-5C532FFCDEEB', N'04CD6625-A74A-40A5-B812-14FC3DB31C33', 2558, N'นักเรียนมีความรู้ความสามารถทางวิชาการ', N'', N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'611FE04A-0AC3-451D-92DE-F515B6EDB595', N'04CD6625-A74A-40A5-B812-14FC3DB31C33', 2558, N'นักเรียนมีสุขภาพแข็งแรงจิตใจแจ่มใสมีสุนทรียภาพด้านศิลปะดนตรี/นาฏศิลป์และกีฬา/นันทนาการ', N'', N'', 100, N'', 3, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'30464416-0519-4409-940B-9D21E9BCC597', N'681EEE7A-B8B3-433B-95E5-B9F6DC55D434', 2558, N'การพัฒนาหลักสูตรสถานศึกษา', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'6AF98DA9-4753-4292-8ED5-3B6B2E6EF477', N'681EEE7A-B8B3-433B-95E5-B9F6DC55D434', 2558, N'การจัดกระบวนการเรียนรู้ที่เน้นนักเรียนเป็นสำคัญ', N'', N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'7DE5489C-DE88-4BD0-85EB-40F88DF1035E', N'681EEE7A-B8B3-433B-95E5-B9F6DC55D434', 2558, N'การพัฒนาระบบการวัดและประเมินผลการเรียน', N'', N'', 100, N'', 3, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'432412A4-3F78-48D6-8722-F6AFE1F0C909', N'681EEE7A-B8B3-433B-95E5-B9F6DC55D434', 2558, N'การผลิตการใช้การพัฒนาสื่อและเทคโนโลยีเพื่อการเรียนรู้', N'', N'', 100, N'', 4, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'2033EBB6-76A4-4AD8-A7A2-E7CFB717C27B', N'681EEE7A-B8B3-433B-95E5-B9F6DC55D434', 2558, N'การจัดกิจกรรมพัฒนานักเรียน', N'', N'', 100, N'', 5, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'A53DA760-75BA-40DE-929D-07613781B640', N'681EEE7A-B8B3-433B-95E5-B9F6DC55D434', 2558, N'การพัฒนาแหล่งการเรียนรู้', N'', N'', 100, N'', 6, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'30392B0D-9F0B-41D9-A948-AB71FC42BB9C', N'855C2C96-CB71-4B7F-BDDA-2559764594F2', 2558, N'การพัฒนาระบบข้อมูลและสารสนเทศ', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'394214A8-5C05-4554-9B33-21642BDA3FAB', N'855C2C96-CB71-4B7F-BDDA-2559764594F2', 2558, N'การพัฒนาคุณภาพของสถานศึกษา', N'', N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'7B589546-21BD-40F5-852F-B7752EE7F170', N'855C2C96-CB71-4B7F-BDDA-2559764594F2', 2558, N'การบริหารงบประมาณและการบริการ', N'', N'', 100, N'', 3, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'31391CD1-8869-4022-83D4-613D322D8EC3', N'855C2C96-CB71-4B7F-BDDA-2559764594F2', 2558, N'การบริหารงานอาคารสถานที่', N'', N'', 100, N'', 4, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'BC61300D-399A-4A92-A884-AE48D3BFB014', N'1140E39F-868F-4EA6-AB25-8A755E8C590C', 2558, N'การมีส่วนร่วมของผู้ปกครองและชุมชนต่อการจัดการศึกษา', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'559E4DF3-C527-49BC-BF39-0BBC82B27C71', N'1140E39F-868F-4EA6-AB25-8A755E8C590C', 2558, N'การมีส่วนร่วมของสถานศึกษาต่อการพัฒนาท้องถิ่นและชุมชน', N'', N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'71C9F34A-D2D1-4CE7-8834-3469E52BFA0C', N'A22E8E7E-C7F1-46FA-90CF-B701ED5B2D58', 2558, N'คุณลักษณะของผู้บริหาร', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'76DE2F98-8231-4049-A294-94F80C905DCB', N'A22E8E7E-C7F1-46FA-90CF-B701ED5B2D58', 2558, N'คุณลักษณะของครู', N'', N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'32E9B25C-0F0A-483B-91A4-432426BCF2A9', N'A22E8E7E-C7F1-46FA-90CF-B701ED5B2D58', 2558, N'คุณลักษณะของบุคลากรสนับสนุน', N'', N'', 100, N'', 3, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'CF94CF54-E527-4132-ABCD-28B1AFBC0F5D', N'A22E8E7E-C7F1-46FA-90CF-B701ED5B2D58', 2558, N'การบริหารงานบุคลากร', N'', N'', 100, N'', 4, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')

	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'CFC6CB00-F10B-4531-BEFA-F6B2EB84F51B', N'A3F63730-672E-48A7-BD5C-23C3F99728A4', 2558, N'โครงการ/กิจกรรมดีเด่นของสถานศึกษา', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
	INSERT [dbo].[RoyalAwardIndicator] ([RoyalAwardIndicatorID], [RoyalAwardSideID], [StudyYear], [RoyalAwardIndicatorName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'3EFBF6B1-C3F7-4997-A167-9006732D1954', N'A3F63730-672E-48A7-BD5C-23C3F99728A4', 2558, N'ผลงานจากการดำเนินโครงการ/กิจกรรมดีเด่น', N'', N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
End

Go  
--เพิ่มเมนูคัดลอกด้านและตัวชี้วัดรางวัลพระราชทาน
If Not Exists(Select * From MySubMenu Where MySubMenuID = '2D188778-DA68-48A3-951E-55D5681E25A1')
Begin
	INSERT INTO MySubMenu (MySubMenuID, MySubMenuName, MyMainMenuID, Sort, LinkName, Status, DelFlag, CreateUser, CreateDate, UpdateUser, UpdateDate, ImgName)
	VALUES ('2D188778-DA68-48A3-951E-55D5681E25A1', 'คัดลอกด้าน/ตัวชี้วัดรางวัลพระราชทาน', '1b9f4ba0-3f3b-4b3c-babf-a2b5a33079f4', 36, 'MasterData/CopyRoyalAward.aspx', 1, 1, 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'EA5D2FE9-57DE-40F9-BCCB-7C9E708521F6', '2012-09-14 10:28:53.067', 'S09.png')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('2D188778-DA68-48A3-951E-55D5681E25A1', '46aada1c-386e-4be8-be6d-6efdc96a9537')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('2D188778-DA68-48A3-951E-55D5681E25A1', '68486861-2c0c-40f7-91e0-acd1c035c911')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('2D188778-DA68-48A3-951E-55D5681E25A1', '91c15c5c-3b69-4957-a15a-baf6560f891f')

	INSERT INTO MenuRole (MySubMenuID, UserRoleID)
	VALUES ('2D188778-DA68-48A3-951E-55D5681E25A1', '079c4976-49a8-4b30-83bf-3e13cbaa9382')

End
Go
----------ลบ StoreProcedure เมนู RoyalAward
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuRoyalAward')
Begin
	DROP PROCEDURE ckMenuRoyalAward
End

Go
--เพิ่ม Store เมนู RoyalAward
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
CREATE PROCEDURE ckMenuRoyalAward
	@ck int
AS
BEGIN
	SET NOCOUNT ON;
	IF @ck = 0
	Begin
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = 'D961BCC8-5679-4D7D-A905-B84A8D128E62'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '82391650-F39A-40D1-9306-8FA205F45CDF'
		Update MySubMenu Set DelFlag = 1 Where MySubMenuID = '2D188778-DA68-48A3-951E-55D5681E25A1'
	End
	Else
	Begin
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = 'D961BCC8-5679-4D7D-A905-B84A8D128E62'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '82391650-F39A-40D1-9306-8FA205F45CDF'
		Update MySubMenu Set DelFlag = 0 Where MySubMenuID = '2D188778-DA68-48A3-951E-55D5681E25A1'
	End
END
Go
----------Update ค่าตัวเช็ค
Update MR_School Set ckRoyalAward = 0 Where ckRoyalAward Is Null


--------///////-----------------Ver 10.12.0.0-------------------////////--------------

Go
--เพิ่มฟิวตัวเช็คตัวเป้าหมายการพัฒนาคุณภาพ ckTargetMode
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckTargetMode')
Begin
	alter table MR_School add ckTargetMode bit
End

Go
--เพิ่มฟิวตัวเช็คตัวลักษณะโครงการ ckProjectDes
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckProjectDes')
Begin
	alter table MR_School add ckProjectDes bit
End

Go
--เพิ่มฟิวตัวเช็คตัวกลยุทธ์หลายตัว ckStrategies
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckStrategies')
Begin
	alter table MR_School add ckStrategies bit
End

Go
----------- เพิ่ม Table dtStrategies  เชื่อมโยง โครงการกับกลยุทธ์ ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtStrategies'))
Begin
	CREATE TABLE [dbo].[dtStrategies](
		[ProjectsCode] [nvarchar](50) NULL,
		[StrategiesCode] [nvarchar](50) NULL
	) ON [PRIMARY]
End

Go
----------- เพิ่ม Table dtTargetMode  เชื่อมโยง โครงการกับเป้าหมายการพัฒนาคุณภาพ ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtTargetMode'))
Begin
	CREATE TABLE [dbo].[dtTargetMode](
		[ProjectsCode] [nvarchar](50) NULL,
		[TargetMode] [nvarchar](1) NULL
	) ON [PRIMARY]
End

Go
----------- เพิ่ม Table dtProjectDes  เชื่อมโยง โครงการกับลักษณะโครงการ ------------
If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('dtProjectDes'))
Begin
	CREATE TABLE [dbo].[dtProjectDes](
		[ProjectsCode] [nvarchar](50) NULL,
		[ProjectDes] [nvarchar](1) NULL
	) ON [PRIMARY]
End

Go
Update MR_School Set ckTargetMode = 0 Where ckTargetMode Is Null
Go
Update MR_School Set ckProjectDes = 0 Where ckProjectDes Is Null
Go
Update MR_School Set ckStrategies = 0 Where ckStrategies Is Null

--------------------------WorldClass---------------------------
Go
--เพิ่มฟิวตัวเรียงลำดับ MasterSide WorldClass
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('WorldClassSide') And Name = 'MsSideSort')
Begin
	alter table WorldClassSide add MsSideSort smallint
End

Go
--เพิ่มข้อมูลด้านมาตรฐานสากล                                                                                                                                                                                                                                                                           

Go
INSERT [dbo].[WorldClassSide] ([WorldClassSideID], [StudyYear], [WorldClassSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [MsSideSort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'5715C0F6-B91E-4C61-9DF7-F9128D902970', '2558', N'ด้านคุณภาพผู้เรียน (เป็นเลิศวิชาการ)', N'' , N'', 100, N'', 1, 1, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassSide] ([WorldClassSideID], [StudyYear], [WorldClassSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [MsSideSort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'BD5AD459-9DD8-41BB-BDB5-C2224D9B048F', '2558', N'ด้านคุณภาพผู้เรียน (สื่อสารได้อย่างน้อย 2 ภาษา)', N'' , N'', 100, N'', 2, 1, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassSide] ([WorldClassSideID], [StudyYear], [WorldClassSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [MsSideSort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'6AC5C2C8-3CAC-4C46-A349-0342F7DCA58A', '2558', N'ด้านคุณภาพผู้เรียน (ล้ำหน้าทางความคิด)', N'' , N'', 100, N'', 3, 1, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassSide] ([WorldClassSideID], [StudyYear], [WorldClassSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [MsSideSort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'26613E89-5BDD-45C2-BE47-1F40C7CC093E', '2558', N'ด้านคุณภาพผู้เรียน (ผลิตงานอย่างสร้างสรรค์)', N'' , N'', 100, N'', 4, 1, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')


Go
INSERT [dbo].[WorldClassSide] ([WorldClassSideID], [StudyYear], [WorldClassSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [MsSideSort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'B1E30507-89D0-471F-97AF-3991F8BA9A95', '2558', N'ด้านคุณภาพผู้บริหารโรงเรียน', N'' , N'', 100, N'', 1, 3, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassSide] ([WorldClassSideID], [StudyYear], [WorldClassSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [MsSideSort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'791A6A59-D80F-495C-AFA2-69543ED8BCAF', '2558', N'ด้านระบบการบริหารจัดการ', N'' , N'', 100, N'', 2, 3, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassSide] ([WorldClassSideID], [StudyYear], [WorldClassSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [MsSideSort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'566ACA98-FE5F-4CDB-A228-6E3010347E6C', '2558', N'ด้านปัจจัยพื้นฐาน', N'' , N'', 100, N'', 3, 3, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassSide] ([WorldClassSideID], [StudyYear], [WorldClassSideName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [MsSideSort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'544B8F44-1D88-49C9-8288-438B0FF0D46C', '2558', N'ด้านเครือข่ายร่วมพัฒนา', N'' , N'', 100, N'', 4, 3, 0, CAST(0x0000A4CF00CD8FDE AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CF005B AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')


--เพิ่มข้อมูลมาตรฐานสากล                                                                                                                                                                                                                                                                                                                                                        
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'48710E37-8386-4EE2-97C5-974B75C163E7', N'5715C0F6-B91E-4C61-9DF7-F9128D902970', 2558, N'นักเรียนมีผลสัมฤทธิ์การเรียนผ่านการประเมินระดับชาติอยู่ในระดับดี  เป็นที่ยอมรับจากสถาบันนานาชาติ', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'48AF62A5-8459-4A91-BFCE-14699DFEBF8E', N'5715C0F6-B91E-4C61-9DF7-F9128D902970', 2558, N'นักเรียนมีความสามารถ ความถนัดเฉพาะทางเป็นที่ประจักษ์ สามารถแข่งขันในระดับชาติและนานาชาติ', N'', N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'BB0F441D-8249-4A57-85F3-F8C17528F583', N'5715C0F6-B91E-4C61-9DF7-F9128D902970', 2558, N'นักเรียนสามารถเข้าศึกษาต่อในระดับที่สูงขึ้นจนถึงระดับอุดมศึกษา ทั้งในประเทศและ ต่างประเทศได้ในอัตราสูง', N'', N'', 100, N'', 3, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'B39BA27E-B3D9-4206-8179-11244F99C5BA', N'5715C0F6-B91E-4C61-9DF7-F9128D902970', 2558, N'นักเรียนมีผลการเรียนที่สามารถถ่ายโอนกับสถานศึกษาระดับต่างๆ ในนานาชาติได้', N'', N'', 100, N'', 4, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')


Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'5177D7B2-4720-44DD-A8B2-9B63BD6067D1', N'BD5AD459-9DD8-41BB-BDB5-C2224D9B048F', 2558, N'นักเรียนใช้ภาษาไทย/ภาษาอังกฤษ  และภาษาต่างประเทศอื่นๆ ในการสื่อสารได้ดี', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'4F98BF24-6074-4DD5-9864-4CCAF1AE1B22', N'BD5AD459-9DD8-41BB-BDB5-C2224D9B048F', 2558, N'นักเรียนสามารถสอบผ่านการวัดระดับความสามารถทางภาษาจากสถาบันภาษานานาชาติ', N'', N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')


Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'F1B4FFFF-598A-49F2-A737-2504C70017E2', N'6AC5C2C8-3CAC-4C46-A349-0342F7DCA58A', 2558, N'นักเรียนสร้างกิจกรรมแลกเปลี่ยนเรียนรู้และจัดทาโครงงานที่เสนอแนวคิดเพื่อสาธารณะ ประโยชน์ร่วมกับนักเรียนนานาชาติ', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'8F1A9682-9D45-416D-8C56-5FAEFF0592BD', N'6AC5C2C8-3CAC-4C46-A349-0342F7DCA58A', 2558, N'นักเรียนสามารถเขียนเรียงความขั้นสูง', N'', N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')


Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'0D3E0B0B-A834-4AEA-9304-DB30F361DDE0', N'26613E89-5BDD-45C2-BE47-1F40C7CC093E', 2558, N'นักเรียนสามารถเลือกเรียนและฝึกวิชาชีพตามความถนัดและความสนใจ', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'EA128032-CF0F-48A4-80C3-D615C93103E4', N'26613E89-5BDD-45C2-BE47-1F40C7CC093E', 2558, N'นักเรียนมีผลงานการประดิษฐ์ สร้างสรรค์ และออกแบบผลงานเข้าแข่งขันในเวทีระดับชาติ และนานาชาติ ', N'', N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'B5D6FAA0-AC34-4271-83F6-CD5E0C9CA1B2', N'26613E89-5BDD-45C2-BE47-1F40C7CC093E', 2558, N'นักเรียนสามารถใช้เทคโนโลยีในการเรียนรู้  ออกแบบ  สร้างสรรค์งาน สื่อสาร นำเสนอ เผยแพร่ และแลกเปลี่ยนผลงานได้ในระดับนานาชาติ', N'', N'', 100, N'', 3, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')


Go                                                                                                                                                                                                                                                                                                                                                                
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'E5CE5A9D-DAEE-4085-8674-5A829AEEC520', N'B1E30507-89D0-471F-97AF-3991F8BA9A95', 2558, N'ผู้บริหารมีวิสัยทัศน์และสามารถนาโรงเรียนสู่การเป็นมาตรฐานสากล', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'7580BD65-DAB5-487F-B0EA-2387E9B925C1', N'B1E30507-89D0-471F-97AF-3991F8BA9A95', 2558, N'ผู้บริหารบริหารจัดการด้วยระบบคุณภาพ', N'', N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'7F7AA2E7-0B18-4524-AD47-DA7CEBD41A2A', N'B1E30507-89D0-471F-97AF-3991F8BA9A95', 2558, N'ผู้บริหารมีความเป็นผู้นาทางวิชาการ (Academic Leadership) ที่มีผลงานปรากฏเป็นที่ยอมรับ', N'', N'', 100, N'', 3, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'B402D6C2-A44A-4028-8AAC-C662061A13CE', N'B1E30507-89D0-471F-97AF-3991F8BA9A95', 2558, N'ผู้บริหารมีความสามารถในการใช้เทคโนโลยีในการสื่อสารและการบริหารจัดการ', N'', N'', 100, N'', 4, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'904E9F04-244A-4578-9E79-8781D083EAA9', N'B1E30507-89D0-471F-97AF-3991F8BA9A95', 2558, N'ผู้บริหารสามารถใช้ภาษาต่างประเทศในการสื่อสาร', N'', N'', 100, N'', 5, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'C9E4902E-EE28-4C0E-B95F-56A6E5AD634A', N'B1E30507-89D0-471F-97AF-3991F8BA9A95', 2558, N'ผู้บริหารมีประสบการณ์อบรม ศึกษาดูงาน แลกเปลี่ยนเรียนรู้ในการจัดการศึกษานานาชาติ', N'', N'', 100, N'', 6, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')


Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'B6E060CA-C56B-40C6-A6B3-5A0EEEC3BE89', N'791A6A59-D80F-495C-AFA2-69543ED8BCAF', 2558, N'โรงเรียนบริหารจัดการด้วยระบบคุณภาพที่ได้รับการรับรองจากองค์กรมาตรฐานสากลระดับโลก', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'4517C369-6424-4A95-A220-7F7412507F66', N'791A6A59-D80F-495C-AFA2-69543ED8BCAF', 2558, N'โรงเรียนมีระบบการจัดการความรู้ (KM) และการสร้างนวัตกรรมเผยแพร่ ทั้งในประเทศและต่างประเทศ', N'', N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'034DA51F-FA14-4A29-9D38-0AD06F3F1296', N'791A6A59-D80F-495C-AFA2-69543ED8BCAF', 2558, N'โรงเรียนนำวิธีปฏิบัติที่เป็นเลิศ (Best Practices) มาใช้ในการบริหารจัดการครอบคลุมภารกิจทุกด้านของโรงเรียน', N'', N'', 100, N'', 3, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'F051ED5A-FD04-4C7E-B978-65CBFBA38A14', N'791A6A59-D80F-495C-AFA2-69543ED8BCAF', 2558, N'โรงเรียนมีการแลกเปลี่ยนเรียนรู้ การบริหารจัดทั้งในประเทศ/ต่างประเทศ', N'', N'', 100, N'', 4, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'0D631425-0389-41B3-B322-0A92585E029A', N'791A6A59-D80F-495C-AFA2-69543ED8BCAF', 2558, N'โรงเรียนมีการบริหารด้านบุคลากรอย่างมีอิสระ และคล่องตัว โดย สามารถกำหนดอัตรากำลัง   สรรหา บรรจุ จัดจ้าง ส่งเสริม และพัฒนา', N'', N'', 100, N'', 5, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'B99CDEE3-6EA3-4F04-8059-AD09E8FAE57F', N'791A6A59-D80F-495C-AFA2-69543ED8BCAF', 2558, N'โรงเรียนสามารถแสวงหา ระดมทรัพยากรด้านต่างๆ เพื่อพัฒนาความเป็นเลิศในการจัดการศึกษา โดยสามารถบริหารจัดการได้อย่างคล่องตัวตามสภาพความต้องการและจำเป็น', N'', N'', 100, N'', 6, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')


Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'0A3B0B37-513D-4B18-90FA-2AC02F8A298E', N'566ACA98-FE5F-4CDB-A228-6E3010347E6C', 2558, N'โรงเรียนมีขนาดชั้นเรียนเหมาะสม โดยมีจานวนนักเรียนต่อห้อง ( ปฐมวัย 25 คน :1 ห้อง, ประถมศึกษา 30 คน : 1 ห้อง,มัธยมศึกษา 35 คน : 1 ห้อง ) โดยมีจำนวนครูที่มีความรู้ตรงสาขาวิชาที่สอนเพียงพอ และมีอัตรา ส่วนครู 1 คน ต่อนักเรียนไม่เกิน 20 คน', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'A9CCEF7D-381E-4C08-94AA-83195FFD2B2D', N'566ACA98-FE5F-4CDB-A228-6E3010347E6C', 2558, N'ภาระงานการสอนของครู มีความเหมาะสมไม่เกิน 20 ชั่วโมงต่อสัปดาห์', N'', N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'18203C9C-34A1-40BB-A653-79E6BAD4D694', N'566ACA98-FE5F-4CDB-A228-6E3010347E6C', 2558, N'โรงเรียนจัดให้มีหนังสือ/ตำราเรียนที่มีคุณภาพระดับมาตรฐานสากล เพื่อให้นักเรียนได้ใช้เรียนอย่างเพียงพอ', N'', N'', 100, N'', 3, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'A740547D-3EB2-4F45-92C4-51307AEDDAEA', N'566ACA98-FE5F-4CDB-A228-6E3010347E6C', 2558, N'โรงเรียนมีคอมพิวเตอร์พกพา สำหรับนักเรียนทุกคน', N'', N'', 100, N'', 4, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'C752F76F-2FF1-469E-ACFF-FC267ADD6A55', N'566ACA98-FE5F-4CDB-A228-6E3010347E6C', 2558, N'โรงเรียนมีเครือข่ายอินเตอร์เน็ตแบบความเร็วสูงเชื่อมโยงครอบคลุมพื้นที่ ของโรงเรียน', N'', N'', 100, N'', 5, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'4FEE02CD-1F92-4DE4-B689-F3283F8F62F7', N'566ACA98-FE5F-4CDB-A228-6E3010347E6C', 2558, N'โรงเรียนมีห้องเรียนอิเล็กทรอนิกส์มัลติมีเดีย  (Electronic Multi - Media Classroom) ห้องทดลอง  ห้องปฏิบัติการและมีอุปกรณ์เทคโนโลยีที่ทันสมัย  เน้นความเป็นเลิศของนักเรียนตามกลุ่มสาระอย่างพอเพียง และสามารถเชื่อมโยงเครือข่าย เพื่อการเรียนรู้และสืบค้นข้อมูลได้รวดเร็ว', N'', N'', 100, N'', 6, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'51C09F82-FE00-48AF-9DB6-3647A2DB23A8', N'566ACA98-FE5F-4CDB-A228-6E3010347E6C', 2558, N'โรงเรียนมีห้องสมุด  แหล่งเรียนรู้  ศูนย์วิทยบริการ (Resource Center) ที่มีสภาพแวดล้อม บรรยากาศเอื้อต่อการใช้บริการ  มีสื่อที่พอเพียงเหมาะสมทันสมัย  มีกิจกรรมที่ส่งเสริมการอ่านการเรียนรู้ และการค้นคว้าอย่างหลากหลาย', N'', N'', 100, N'', 7, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')


Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'F9E2FE90-DE59-47A0-AF26-055E8BD5CCF7', N'544B8F44-1D88-49C9-8288-438B0FF0D46C', 2558, N'โรงเรียนมีสถานศึกษาที่จัดการศึกษาในระดับเดียวกันเป็นเครือข่ายร่วมพัฒนา  ทั้งในระดับท้องถิ่น ภูมิภาค ระดับประเทศและระหว่างประเทศ', N'', N'', 100, N'', 1, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'D97FBE54-2882-46BB-8DE3-5AEB0EAABCBA', N'544B8F44-1D88-49C9-8288-438B0FF0D46C', 2558, N'โรงเรียนจัดกิจกรรมการเรียนรู้แลกเปลี่ยนประสบการณ์และทรัพยากรระหว่างเครือข่าย  โรงเรียนร่วมพัฒนา', N'', N'', 100, N'', 2, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'F74D6138-9EA4-43DA-8CB3-1F281030F93C', N'544B8F44-1D88-49C9-8288-438B0FF0D46C', 2558, N'โรงเรียนมีเครือข่ายสนับสนุนจากสถาบันอุดมศึกษาและองค์กรอื่นๆ ที่เกี่ยวข้องทั้งภาครัฐและเอกชน ทั้งในประเทศและต่างประเทศ', N'', N'', 100, N'', 3, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')
Go
INSERT [dbo].[WorldClassStandard] ([WorldClassStandardID], [WorldClassSideID], [StudyYear], [WorldClassStandardName], [Comment], [Detail], [Score], [QAScoreGroupID], [Sort], [DelFlag], [CreateDate], [CreateUser], [UpdateDate], [UpdateUser]) VALUES (N'7B2BDF29-1C35-4364-9E68-2D43D764F44A', N'544B8F44-1D88-49C9-8288-438B0FF0D46C', 2558, N'นักเรียนและครูมีเครือข่ายแลกเปลี่ยนเรียนรู้กับบุคคลอื่นทั้งในประเทศและต่างประเทศ', N'', N'', 100, N'', 4, 0, CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70', CAST(0x0000A4CF00CD8FF5 AS DateTime), N'4C3E218F-D513-416E-BD10-B4F161717F70')


Go
Update WorldClassSide Set MsSideSort = 2 Where WorldClassSideID = '3A854FE0-E32C-4A80-95D3-0080D8DE6415'
Go
Update WorldClassSide Set MsSideSort = 2 Where WorldClassSideID = 'D0985CCE-021B-4144-8127-FD6843B10004'
Go
Update WorldClassSide Set MsSideSort = 2 Where WorldClassSideID = '1C0AEBAD-2F3C-42BB-BE00-4FF745C95883'



--------///////-----------------Ver 11.0.0.0-------------------////////--------------

--ขยายขนาด Column
Go
alter table MR_School alter column ckRate int

--เพิ่มฟิวส์ span หน้าชื่อผู้เซ็น
Go
alter table MR_School add spnResponsibleName nVarchar(200)
Go
alter table MR_School add spnProposeName nVarchar(200)
Go
alter table MR_School add spnApprovalName nVarchar(200)
Go
alter table MR_School add spnApprovalName2 nVarchar(200)


Go
----------เพิ่มข้อมูลกลุ่มคะแนนใน Table----------------------------------
--เพิ่มกลุ่มคะแนน 5 (3)
If Not Exists(Select * From ScoreGroup Where ScoreGroupID = '4BD33310-AE51-4E69-9D84-A4A8173D81F0')
Begin
	INSERT INTO ScoreGroup (ScoreGroupID, ScoreGroupName, Sort, WeightScore, CreateUser, CreateDate, UpdateUser, UpdateDate, DelFlag)
	VALUES ('4BD33310-AE51-4E69-9D84-A4A8173D81F0', 'หมวดคะแนนเต็ม 5 (3)', 10, 5, '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A', '2015-12-18 10:28:53.067', '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A', '2015-12-18 10:28:53.067', 0)
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
--เพิ่ม Store GenRate
SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO

	Create PROCEDURE GenIndRate
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








----&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

----สร้างชุดแบบประเมิน
--If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('Estimation'))
--Begin
--	CREATE TABLE [dbo].[Estimation](
--		[EstimationID] [uniqueidentifier] NOT NULL,
--		[EstimationName] [nvarchar](500) NULL,
--		[EstimationType] [tinyint] NULL,
--		[Rating] [tinyint] NULL,
--		[SchoolID] [nvarchar](50) NULL,
--		[DelFlag] [bit] NULL CONSTRAINT [DF_Estimation_DelFlag]  DEFAULT ((0)),
--		[CreateUser] [uniqueidentifier] NULL,
--		[CreateDate] [smalldatetime] NULL,
--		[UpdateUser] [uniqueidentifier] NULL,
--		[UpdateDate] [smalldatetime] NULL,
--		[Enabled] [bit] NULL CONSTRAINT [DF_Estimation_Enabled]  DEFAULT ((1)),
--	 CONSTRAINT [PK_Estimation] PRIMARY KEY CLUSTERED 
--	(
--		[EstimationID] ASC
--	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--	) ON [PRIMARY]

--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'รหัสแบบประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Estimation', @level2type=N'COLUMN',@level2name=N'EstimationID'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ชื่อแบบประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Estimation', @level2type=N'COLUMN',@level2name=N'EstimationName'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ประเภทแบบประเมิน 0=Rating Scale, 1=Rubric Score' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Estimation', @level2type=N'COLUMN',@level2name=N'EstimationType'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Scale ของ Rating เช่น 5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Estimation', @level2type=N'COLUMN',@level2name=N'Rating'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-ไม่ลบ, 1-ลบ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Estimation', @level2type=N'COLUMN',@level2name=N'DelFlag'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ผู้สร้าง' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Estimation', @level2type=N'COLUMN',@level2name=N'CreateUser'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'วันที่สร้าง' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Estimation', @level2type=N'COLUMN',@level2name=N'CreateDate'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ผู้แก้ไข' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Estimation', @level2type=N'COLUMN',@level2name=N'UpdateUser'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'วันที่แก้ไข' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Estimation', @level2type=N'COLUMN',@level2name=N'UpdateDate'
--End

----กลุ่มแบบประเมิน
--If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('EstimationGroup'))
--Begin
--	CREATE TABLE [dbo].[EstimationGroup](
--		[GroupID] [uniqueidentifier] NOT NULL,
--		[GroupName] [nvarchar](300) NULL,
--		[GroupIndex] [int] NULL,
--		[EstimationID] [uniqueidentifier] NULL,
--		[DelFlag] [bit] NULL CONSTRAINT [DF_EstimationGroup_DelFlag]  DEFAULT ((0)),
--	 CONSTRAINT [PK_EstimationGroup] PRIMARY KEY CLUSTERED 
--	(
--		[GroupID] ASC
--	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--	) ON [PRIMARY]

--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'รหัสกลุ่มแบบประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimationGroup', @level2type=N'COLUMN',@level2name=N'GroupID'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ชื่อกลุ่มแบบประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimationGroup', @level2type=N'COLUMN',@level2name=N'GroupName'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'รหัสแบบประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimationGroup', @level2type=N'COLUMN',@level2name=N'EstimationID'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-ไม่ลบ, 1-ลบ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimationGroup', @level2type=N'COLUMN',@level2name=N'DelFlag'
--	GO
--	ALTER TABLE [dbo].[EstimationGroup]  WITH NOCHECK ADD  CONSTRAINT [FK_EstimationGroup_Estimation] FOREIGN KEY([EstimationID])
--	REFERENCES [dbo].[Estimation] ([EstimationID])
--	ON UPDATE CASCADE
--	ON DELETE CASCADE
--	GO
--	ALTER TABLE [dbo].[EstimationGroup] CHECK CONSTRAINT [FK_EstimationGroup_Estimation]
--End


----รายละเอียดแบบประเมิน
--If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('EstimationList'))
--Begin
--	CREATE TABLE [dbo].[EstimationList](
--		[ListID] [uniqueidentifier] NOT NULL,
--		[ListDetail] [nvarchar](max) NULL,
--		[ListIndex] [int] NULL,
--		[GroupID] [uniqueidentifier] NULL,
--		[DelFlag] [bit] NULL CONSTRAINT [DF_EstimationList_DelFlag]  DEFAULT ((0)),
--	 CONSTRAINT [PK_EstimationList] PRIMARY KEY CLUSTERED 
--	(
--		[ListID] ASC
--	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--	) ON [PRIMARY]

--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'รหัสรายละเอียดแบบประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimationList', @level2type=N'COLUMN',@level2name=N'ListID'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'รายละเอียดแบบประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimationList', @level2type=N'COLUMN',@level2name=N'ListDetail'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'รหัสกลุ่มแบบประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimationList', @level2type=N'COLUMN',@level2name=N'GroupID'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-ไม่ลบ, 1-ลบ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimationList', @level2type=N'COLUMN',@level2name=N'DelFlag'
--	GO
--	ALTER TABLE [dbo].[EstimationList]  WITH NOCHECK ADD  CONSTRAINT [FK_EstimationList_EstimationGroup] FOREIGN KEY([GroupID])
--	REFERENCES [dbo].[EstimationGroup] ([GroupID])
--	ON UPDATE CASCADE
--	ON DELETE CASCADE
--	GO
--	ALTER TABLE [dbo].[EstimationList] CHECK CONSTRAINT [FK_EstimationList_EstimationGroup]
--End


----ระดับผลการประเมิน
--If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('EstimateSetting'))
--Begin
--	CREATE TABLE [dbo].[EstimateSetting](
--		[GroupID] [uniqueidentifier] NOT NULL,
--		[RubricLevel] [tinyint] NOT NULL,
--		[Detail] [nvarchar](200) NULL,
--		[Translation] [nvarchar](50) NULL,
--		[TMin] [tinyint] NOT NULL,
--		[TMax] [tinyint] NOT NULL,
--		[DelFlag] [bit] NULL,
--	 CONSTRAINT [PK_EstimateSetting] PRIMARY KEY CLUSTERED 
--	(
--		[GroupID] ASC,
--		[RubricLevel] ASC
--	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--	) ON [PRIMARY]

--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'รหัสกลุ่มแบบประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimateSetting', @level2type=N'COLUMN',@level2name=N'GroupID'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ระดับ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimateSetting', @level2type=N'COLUMN',@level2name=N'RubricLevel'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'รายละเอียด' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimateSetting', @level2type=N'COLUMN',@level2name=N'Detail'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'หมายความว่า' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimateSetting', @level2type=N'COLUMN',@level2name=N'Translation'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ระดับต่ำสุด' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimateSetting', @level2type=N'COLUMN',@level2name=N'TMin'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ระดับสูงสุด' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimateSetting', @level2type=N'COLUMN',@level2name=N'TMax'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-ไม่ลบ, 1-ลบ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimateSetting', @level2type=N'COLUMN',@level2name=N'DelFlag'
--	GO
--	ALTER TABLE [dbo].[EstimateSetting]  WITH CHECK ADD  CONSTRAINT [FK_EstimateSetting_EstimationGroup] FOREIGN KEY([GroupID])
--	REFERENCES [dbo].[EstimationGroup] ([GroupID])
--	ON UPDATE CASCADE
--	ON DELETE CASCADE
--	GO
--	ALTER TABLE [dbo].[EstimateSetting] CHECK CONSTRAINT [FK_EstimateSetting_EstimationGroup]
--End


----ผูกแบบประเมิน
--If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('EstimationItems'))
--Begin
--	CREATE TABLE [dbo].[EstimationItems](
--		[EstimateItemID] [uniqueidentifier] NOT NULL,
--		[EstimationID] [uniqueidentifier] NULL,
--		[EstimateIndex] [int] NULL,
--		[ReferID] [uniqueidentifier] NULL,
--		[ReferType] [char](1) NULL,
--		[AcademicYear] [varchar](4) NULL,
--	 CONSTRAINT [PK_EstimationItems] PRIMARY KEY CLUSTERED 
--	(
--		[EstimateItemID] ASC
--	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--	) ON [PRIMARY]

--	GO
--	SET ANSI_PADDING OFF
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'รหัสใบประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimationItems', @level2type=N'COLUMN',@level2name=N'EstimateItemID'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'รหัสแบบประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimationItems', @level2type=N'COLUMN',@level2name=N'EstimationID'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ครั้งที่ประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimationItems', @level2type=N'COLUMN',@level2name=N'EstimateIndex'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'รหัสตารางที่ประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimationItems', @level2type=N'COLUMN',@level2name=N'ReferID'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'จากตาราง เช่น S=วิชา,T=ครู,A=กิจกรรม' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimationItems', @level2type=N'COLUMN',@level2name=N'ReferType'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ปีการศึกษา' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimationItems', @level2type=N'COLUMN',@level2name=N'AcademicYear'
--	GO
--	ALTER TABLE [dbo].[EstimationItems]  WITH NOCHECK ADD  CONSTRAINT [FK_EstimationItems_Estimation] FOREIGN KEY([EstimationID])
--	REFERENCES [dbo].[Estimation] ([EstimationID])
--	ON UPDATE CASCADE
--	ON DELETE CASCADE
--	GO
--	ALTER TABLE [dbo].[EstimationItems] CHECK CONSTRAINT [FK_EstimationItems_Estimation]
--End


----ผู้ประเมิน
--If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('EstimateUser'))
--Begin
--	CREATE TABLE [dbo].[EstimateUser](
--		[ItemID] [uniqueidentifier] NOT NULL,
--		[EstimateItemID] [uniqueidentifier] NULL,
--		[UserID] [uniqueidentifier] NULL,
--		[Score] [real] NULL,
--		[CreateDate] [smalldatetime] NULL,
--	 CONSTRAINT [PK_EstimateUser] PRIMARY KEY CLUSTERED 
--	(
--		[ItemID] ASC
--	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--	) ON [PRIMARY]

--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'รหัสการประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimateUser', @level2type=N'COLUMN',@level2name=N'ItemID'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'รหัสใบประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimateUser', @level2type=N'COLUMN',@level2name=N'EstimateItemID'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ผู้ประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimateUser', @level2type=N'COLUMN',@level2name=N'UserID'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'คะแนนการประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimateUser', @level2type=N'COLUMN',@level2name=N'Score'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'วันที่สร้าง' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimateUser', @level2type=N'COLUMN',@level2name=N'CreateDate'
--	GO
--	ALTER TABLE [dbo].[EstimateUser]  WITH CHECK ADD  CONSTRAINT [FK_EstimateUser_EstimationItems] FOREIGN KEY([EstimateItemID])
--	REFERENCES [dbo].[EstimationItems] ([EstimateItemID])
--	ON UPDATE CASCADE
--	ON DELETE CASCADE
--	GO
--	ALTER TABLE [dbo].[EstimateUser] CHECK CONSTRAINT [FK_EstimateUser_EstimationItems]
--End


----ผู้ประเมินเลือก
--If Not Exists(Select * From Sys.Tables Where Object_ID = Object_ID('EstimateUserList'))
--Begin
--	CREATE TABLE [dbo].[EstimateUserList](
--		[ItemID] [uniqueidentifier] NOT NULL,
--		[ListID] [uniqueidentifier] NOT NULL,
--		[Rating] [tinyint] NULL,
--	 CONSTRAINT [PK_EstimateUserList] PRIMARY KEY CLUSTERED 
--	(
--		[ItemID] ASC,
--		[ListID] ASC
--	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
--	) ON [PRIMARY]

--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'รหัสการประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimateUserList', @level2type=N'COLUMN',@level2name=N'ItemID'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'รหัสรายละเอียดแบบประเมิน' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimateUserList', @level2type=N'COLUMN',@level2name=N'ListID'
--	GO
--	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'คะแนน Rating' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'EstimateUserList', @level2type=N'COLUMN',@level2name=N'Rating'
--	GO
--	ALTER TABLE [dbo].[EstimateUserList]  WITH CHECK ADD  CONSTRAINT [FK_EstimateUserList_EstimateUser] FOREIGN KEY([ItemID])
--	REFERENCES [dbo].[EstimateUser] ([ItemID])
--	ON UPDATE CASCADE
--	ON DELETE CASCADE
--	GO
--	ALTER TABLE [dbo].[EstimateUserList] CHECK CONSTRAINT [FK_EstimateUserList_EstimateUser]
--End

------------------------------------------------------------
----บันทึกแบบประเมิน
--If Not Exists(Select * From Sys.PROCEDURES Where Object_ID = Object_ID('ExecuteEstimation'))
--Begin
--	CREATE PROCEDURE [dbo].[ExecuteEstimation]
--		@EstimateID uniqueidentifier,
--		@EstimateName nvarchar(500),
--		@EstimateType tinyint,
--		@UserID uniqueidentifier,
--		@SchoolID nvarchar(50),
--		@Datas nvarchar(max)
--	AS
--	BEGIN
--	--gid●gname●idx…List¡idx…List●setting¦gid●gname●item●setting¦
--		DECLARE @Data nvarchar(max)

--		UPDATE [Estimation] SET [EstimationName]=@EstimateName,[EstimationType]=@EstimateType,[UpdateUser]=@UserID,[UpdateDate]=GETDATE() WHERE [EstimationID]=@EstimateID IF @@ROWCOUNT=0 INSERT INTO [Estimation]([EstimationID],[EstimationName],[EstimationType],[Rating],[CreateUser],[SchoolID],[CreateDate]) VALUES (@EstimateID,@EstimateName,@EstimateType,5,@UserID,@SchoolID,GETDATE())
--		UPDATE [EstimationGroup] SET [DelFlag] = 1 WHERE [EstimationID]=@EstimateID
--		IF CHARINDEX(N'¦',@Datas) = 0 AND LEN(@Datas) > 0 SET @Datas = @Datas + N'¦'
--		WHILE CHARINDEX(N'¦',@Datas)>0
--			BEGIN
--				SET @Data = SUBSTRING(@Datas,0, CHARINDEX(N'¦',@Datas))

--				DECLARE @GroupIdx int SET @GroupIdx  = SUBSTRING(@Data,0, CHARINDEX(N'●',@Data))
--				SET @Data = SUBSTRING(@Data, CHARINDEX(N'●',@Data)+1, LEN(@Data))
--				DECLARE @GroupName nvarchar(300) SET @GroupName = SUBSTRING(@Data,0, CHARINDEX(N'●',@Data))
--				SET @Data = SUBSTRING(@Data, CHARINDEX(N'●',@Data)+1, LEN(@Data))
--				DECLARE @Lists nvarchar(max) SET @Lists = SUBSTRING(@Data,0, CHARINDEX(N'●',@Data))
--				DECLARE @Settings nvarchar(max) SET @Settings = SUBSTRING(@Data, CHARINDEX(N'●',@Data)+1, LEN(@Data))
				
--				DECLARE @GroupId uniqueidentifier SET @GroupId = NULL
--				SELECT @GroupId = GroupID FROM [EstimationGroup] WHERE [GroupIndex]=@GroupIdx AND [EstimationID]=@EstimateID
--				IF @GroupId IS NULL SET @GroupId = NEWID()
--				UPDATE [EstimationGroup] SET [GroupName]=@GroupName,[DelFlag]=0 WHERE [GroupIndex]=@GroupIdx AND [EstimationID]=@EstimateID IF @@ROWCOUNT=0 INSERT INTO [EstimationGroup]([GroupID],[GroupName],[GroupIndex],[EstimationID]) VALUES (@GroupId,@GroupName,@GroupIdx,@EstimateID)
--				--Insert List
--				UPDATE [EstimationList] SET [DelFlag] = 1 WHERE [GroupID]=@GroupId
--				IF CHARINDEX(N'¡',@Lists) = 0 AND LEN(@Lists) > 0 SET @Lists = @Lists + N'¡'
--				WHILE CHARINDEX(N'¡',@Lists)>0
--					BEGIN
--						DECLARE @List nvarchar(max) SET @List = SUBSTRING(@Lists,0, CHARINDEX(N'¡',@Lists))
--						DECLARE @ListIndex int SET @ListIndex = SUBSTRING(@List,0, CHARINDEX(N'…',@List))
--						DECLARE @ListDetail nvarchar(max) SET @ListDetail = SUBSTRING(@List, CHARINDEX(N'…',@List)+1, LEN(@List))

--						UPDATE [EstimationList] SET [ListDetail]=@ListDetail,[DelFlag]=0 WHERE [ListIndex]=@ListIndex AND [GroupID]=@GroupId IF @@ROWCOUNT=0 INSERT INTO [EstimationList]([ListID],[ListDetail],[ListIndex],[GroupID]) VALUES (NEWID(),@ListDetail,@ListIndex,@GroupId)

--						SET @Lists = SUBSTRING(@Lists, CHARINDEX(N'¡',@Lists)+1, LEN(@Lists))
--						IF CHARINDEX(N'¡',@Lists) = 0 AND LEN(@Lists) > 0 SET @Lists = @Lists + N'¡'
--					END
--				DELETE [EstimationList] WHERE [GroupID]=@GroupId AND [DelFlag] = 1
--				--End Insert List

--				--Insert Setting
--				--IF @EstimateType = 0 DELETE EstimateSetting WHERE [GroupID]=@GroupId
--				IF @EstimateType = 1 UPDATE [EstimateSetting] SET [DelFlag] = 1 WHERE [GroupID]=@GroupId
--				IF CHARINDEX(N'¡',@Settings) = 0 AND LEN(@Settings) > 0 SET @Settings = @Settings + N'¡'
--				WHILE CHARINDEX(N'¡',@Settings)>0
--					BEGIN
--						DECLARE @Setting nvarchar(max) SET @Setting = SUBSTRING(@Settings,0, CHARINDEX(N'¡',@Settings))

--						DECLARE @RubricLevel int SET @RubricLevel = SUBSTRING(@Setting,0, CHARINDEX(N'…',@Setting))
--						SET @Setting = SUBSTRING(@Setting, CHARINDEX(N'…',@Setting)+1, LEN(@Setting))
--						DECLARE @TMin int SET @TMin = SUBSTRING(@Setting,0, CHARINDEX(N'…',@Setting))
--						DECLARE @TMax int SET @TMax = SUBSTRING(@Setting, CHARINDEX(N'…',@Setting)+1, LEN(@Setting))

--						UPDATE [EstimateSetting] SET [TMin]=@TMin,[TMax]=@TMax,[DelFlag]=0 WHERE [RubricLevel]=@RubricLevel AND [GroupID]=@GroupId IF @@ROWCOUNT=0 INSERT INTO [EstimateSetting]([GroupID],[RubricLevel],[TMin],[TMax]) VALUES (@GroupId,@RubricLevel,@TMin,@TMax)
						
--						SET @Settings = SUBSTRING(@Settings, CHARINDEX(N'¡',@Settings)+1, LEN(@Settings))
--						IF CHARINDEX(N'¡',@Settings) = 0 AND LEN(@Settings) > 0 SET @Settings = @Settings + N'¡'
--					END
--				DELETE [EstimateSetting] WHERE [GroupID]=@GroupId AND [DelFlag] = 1
--				--End Insert Setting

--				SET @Datas = SUBSTRING(@Datas, CHARINDEX(N'¦',@Datas)+1, LEN(@Datas))
--				IF CHARINDEX(N'¦',@Datas) = 0 AND LEN(@Datas) > 0 SET @Datas = @Datas + N'¦'
--			END

--		DELETE [EstimationGroup] WHERE [EstimationID]=@EstimateID AND [DelFlag] = 1
--	END
--End

--------------------------------------------------
--If Not Exists(Select * From Sys.PROCEDURES Where Object_ID = Object_ID('ExecuteEstimationItems'))
--Begin
--	CREATE PROCEDURE [dbo].[ExecuteEstimationItems]
--		@EstimateItemID uniqueidentifier=NULL,
--		@EstimationID uniqueidentifier,
--		@ReferID uniqueidentifier,
--		@ReferType char(1),
--		@AcademicYear nvarchar(4)
--	AS
--	BEGIN

--	UPDATE [EstimationItems] SET [EstimationID]=@EstimationID 
--	WHERE [ReferID]=@ReferID AND [ReferType]=@ReferType AND [AcademicYear] = @AcademicYear
--	IF @@ROWCOUNT=0 
--		INSERT INTO [EstimationItems]([EstimateItemID],[EstimationID],[EstimateIndex],[ReferID],[ReferType],[AcademicYear]) 
--		VALUES (ISNULL(@EstimateItemID,NEWID()),@EstimationID,1,@ReferID,@ReferType,@AcademicYear)

--	END
--End

-----------------------------------------------
--If Not Exists(Select * From Sys.PROCEDURES Where Object_ID = Object_ID('get_RubricLevel'))
--Begin
--	Create PROCEDURE [dbo].[get_RubricLevel]
--		@GroupID uniqueidentifier,
--		@ListIndex int
--	AS
--	BEGIN
--		SET NOCOUNT ON;
--		Select RubricLevel From EstimateSetting
--		Where GroupID = @GroupID
--		And (@ListIndex Between TMin And TMax)
--	END
--End

----------------------------------------------
--If Not Exists(Select * From Sys.PROCEDURES Where Object_ID = Object_ID('getData_Asessment'))
--Begin
--	CREATE PROCEDURE [dbo].[getData_Asessment] 	
--		@EstimateItemID uniqueidentifier,
--		@AcademicYear int,
--		@StrategiesCode nVarChar(50),
--		@ProjectsCode nVarChar(50),
--		@ActivityCode nVarChar(50),
--		@UserID nVarChar(50),
--		@SchoolID nVarChar(50),
--		@txtSearch nVarChar(100)
--	AS
--	BEGIN
--		SET NOCOUNT ON;
		
--		IF @EstimateItemID Is Not Null
--			Begin
--				SET NOCOUNT ON;
--				Select z.*, a.EstimationID, a.EstimationName, a.Rating, b.GroupID, b.GroupName
--				From EstimationItems z, Estimation a, EstimationGroup b
--				Where z.EstimationID = a.EstimationID And a.DelFlag = 0 And b.DelFlag = 0 
--				And a.EstimationID = b.EstimationID And z.EstimateItemID = @EstimateItemID
--				And a.SchoolID = @SchoolID
--				Order By b.GroupIndex
--			End
--		Else
--			Begin
--				DECLARE @SQL NVARCHAR(2000)
--				DECLARE @Params NVARCHAR(200)
--				SELECT @Params = N'@AcademicYear int,'+
--					N'@StrategiesCode uniqueidentifier,'+
--					N'@ProjectsCode uniqueidentifier,'+
--					N'@ActivityCode uniqueidentifier,'+
--					N'@UserID uniqueidentifier,'+
--					N'@SchoolID nVarChar(50)';			
				
--					Select @SQL = N'Select a.EstimateItemID, b.ActivityName, c.EstimationName, a.EstimateIndex, ' +
--						N' EstimateType = Case c.EstimationType When 0 Then ''Rating Score'' When 1 Then ''Rubric Score'' End ' +
--						N' From EstimationItems a, Activity b, Estimation c ' +
--						N' Where b.DelFlag = 0 And c.DelFlag = 0 And a.AcademicYear = @AcademicYear And c.SchoolID = @SchoolID ' +
--						N' And a.ReferID = b.ActivityCode And a.EstimationID = c.EstimationID ' 

--				IF @StrategiesCode Is Not Null Set @SQL = @SQL + N' And b.StrategiesCode = @StrategiesCode ' 
--				IF @ProjectsCode Is Not Null Set @SQL = @SQL + N' And b.ProjectsCode = @ProjectsCode '
--				IF @ActivityCode Is Not Null Set @SQL = @SQL + N' And b.ActivityCode = @ActivityCode '
--				IF @UserID Is Not Null Set @SQL = @SQL + N' And @UserID In (Select EmpCode From dtAcEmp Where ActivityCode = b.ActivityCode) '
--				IF @txtSearch Is Not Null Set @SQL = @SQL + N' And (b.ActivityName Like N''%'+ @txtSearch +'%'' Or c.EstimationName Like N''%'+ @txtSearch +'%'') '
--				SET @SQL = @SQL + N' Order By b.Sort, a.EstimateIndex '

--				Exec Sp_ExecuteSQL @SQL, @Params, @AcademicYear, @StrategiesCode, @ProjectsCode, @ActivityCode, @UserID, @SchoolID  
--			End 
--	END
--End

-----------------------------------------------------
--If Not Exists(Select * From Sys.PROCEDURES Where Object_ID = Object_ID('getData_EstimationGroup'))
--Begin
--	CREATE PROCEDURE [dbo].[getData_EstimationGroup]
--		@EstimateItemID uniqueidentifier
--	AS
--	BEGIN
--		SET NOCOUNT ON;
--		Select z.*, a.EstimationID, a.EstimationName, a.Rating, b.GroupID, b.GroupName
--		From EstimationItems z, Estimation a, EstimationGroup b
--		Where z.EstimationID = a.EstimationID And a.DelFlag = 0 And b.DelFlag = 0 
--		And a.EstimationID = b.EstimationID And z.EstimateItemID = @EstimateItemID
--		Order By b.GroupIndex
--	END
--End

---------------------------------------------------
--If Not Exists(Select * From Sys.PROCEDURES Where Object_ID = Object_ID('getData_EstimationList'))
--Begin
--	CREATE PROCEDURE [dbo].[getData_EstimationList]
--		@EstimationID uniqueidentifier,
--		@GroupID uniqueidentifier
--	AS
--	BEGIN
--		SET NOCOUNT ON;
--		Select a.GroupID, a.GroupName, a.GroupIndex, b.ListID, b.ListDetail, b.ListIndex
--		From EstimationGroup a, EstimationList b
--		Where a.DelFlag = 0 And b.DelFlag = 0
--		And a.GroupID = b.GroupID
--		And a.EstimationID = @EstimationID
--		And a.GroupID = @GroupID
--		Order By a.GroupIndex, b.ListIndex
--	END
--End

----------------------------------------------------
--If Not Exists(Select * From Sys.PROCEDURES Where Object_ID = Object_ID('getData_EstimationSetting'))
--Begin
--	CREATE PROCEDURE [dbo].[getData_EstimationSetting]
--		@EstimationID uniqueidentifier,
--		@GroupID uniqueidentifier
--	AS
--	BEGIN
--		SET NOCOUNT ON;
--		Select a.GroupID, a.GroupName, 
--		b.RubricLevel, b.Detail, b.Translation,
--		b.TMin, b.TMax
--		From EstimationGroup a, EstimateSetting b
--		Where a.DelFlag = 0 And b.DelFlag = 0
--		And a.GroupID = b.GroupID
--		And a.EstimationID = @EstimationID
--		And a.GroupID = @GroupID
--		Order By a.GroupIndex, b.RubricLevel
--	END
--End

------------------------------------------------
--If Not Exists(Select * From Sys.PROCEDURES Where Object_ID = Object_ID('GetEstimate'))
--Begin
--	CREATE PROCEDURE [dbo].[GetEstimate]
--		@ReferID uniqueidentifier,
--		@AcademicYear varchar(4)=NULL
--	AS
--	BEGIN
--		SET NOCOUNT ON;

--		DECLARE @Type CHAR(1)
--		SELECT @Type = ReferType FROM EstimationItems WHERE ReferID = @ReferID
--		IF @Type = 'S'
--		BEGIN
--			IF @AcademicYear IS NULL
--			BEGIN
--				SELECT EI.EstimateItemID,EI.EstimationID,E.EstimationType,EI.EstimateIndex,EI.ReferType,EI.ReferID,S.Title,E.EstimationName,E.Rating
--				FROM Subject S INNER JOIN EstimationItems EI ON EI.ReferID = S.SubjectID
--					 INNER JOIN Estimation E ON EI.EstimationID = E.EstimationID
--				WHERE EI.ReferID = @ReferID AND E.Enabled = 1
--			END
--			ELSE
--			BEGIN
--				SELECT EI.EstimateItemID,EI.EstimationID,E.EstimationType,EI.EstimateIndex,EI.ReferType,EI.ReferID,S.Title,E.EstimationName,E.Rating
--				FROM Subject S INNER JOIN EstimationItems EI ON EI.ReferID = S.SubjectID
--					 INNER JOIN Estimation E ON EI.EstimationID = E.EstimationID
--				WHERE EI.ReferID = @ReferID AND E.Enabled = 1 AND EI.AcademicYear = @AcademicYear
--			END
--		END

--		IF @Type = 'A'
--		BEGIN
--			IF @AcademicYear IS NULL
--			BEGIN
--				SELECT EI.EstimateItemID,EI.EstimationID,E.EstimationType,EI.EstimateIndex,EI.ReferType,EI.ReferID,A.ActivityName As Title,E.EstimationName,E.Rating
--				FROM Activity A INNER JOIN EstimationItems EI ON Cast(EI.ReferID As nVarChar(50)) = A.ActivityCode
--					 INNER JOIN Estimation E ON EI.EstimationID = E.EstimationID
--				WHERE EI.ReferID = @ReferID AND E.Enabled = 1
--			END
--			ELSE
--			BEGIN
--				SELECT EI.EstimateItemID,EI.EstimationID,E.EstimationType,EI.EstimateIndex,EI.ReferType,EI.ReferID,A.ActivityName As Title,E.EstimationName,E.Rating
--				FROM Activity A INNER JOIN EstimationItems EI ON Cast(EI.ReferID As nVarChar(50)) = A.ActivityCode
--					 INNER JOIN Estimation E ON EI.EstimationID = E.EstimationID
--				WHERE EI.ReferID = @ReferID AND E.Enabled = 1 AND EI.AcademicYear = @AcademicYear
--			END
--		END
--	END
--End

---------------------------------------------------
--If Not Exists(Select * From Sys.PROCEDURES Where Object_ID = Object_ID('GetEstimateItems'))
--Begin
--	CREATE PROCEDURE [dbo].[GetEstimateItems]
--		@UserID uniqueidentifier,
--		@AcademicYear varchar(4)=NULL
--	AS
--	BEGIN
--		SET NOCOUNT ON;

--		If @UserID Is Not Null
--		Begin

--		SELECT EI.EstimateItemID,EI.EstimationID,EI.EstimateIndex,EI.ReferType,EI.ReferID,A.ActivityName As Title,E.EstimationName,EU.ItemID
--		FROM dtAcEmp EN INNER JOIN Activity A ON EN.ActivityCode = A.ActivityCode LEFT JOIN 
--			 EstimationItems EI ON EI.ReferID = A.ActivityCode AND EI.ReferType = 'A' AND A.StudyYear = EI.AcademicYear
--			 INNER JOIN Estimation E ON EI.EstimationID = E.EstimationID LEFT JOIN EstimateUser EU ON EU.EstimateItemID = EI.EstimateItemID 
--			 AND EU.UserID = EN.EmpCode
--		WHERE EN.EmpCode = @UserID AND A.StudyYear = @AcademicYear AND E.Enabled = 1


--	--	SELECT EI.EstimateItemID,EI.EstimationID,EI.EstimateIndex,EI.ReferType,EI.ReferID,A.ActivityName As Title,E.EstimationName,EU.ItemID
--	--	FROM Activity A LEFT JOIN 
--	--		 EstimationItems EI ON EI.ReferID = A.ActivityCode AND EI.ReferType = 'A' AND A.StudyYear = EI.AcademicYear
--	--		 INNER JOIN Estimation E ON EI.EstimationID = E.EstimationID LEFT JOIN EstimateUser EU ON EU.EstimateItemID = EI.EstimateItemID 
--	--		 AND EU.UserID = A.CreateUser
--	--			 WHERE A.CreateUser = @UserID AND A.StudyYear = @AcademicYear AND E.Enabled = 1
--	--			 --WHERE A.StudyYear = @AcademicYear AND E.Enabled = 1
--		End
--		Else
--		Begin
--			SELECT EI.EstimateItemID,EI.EstimationID,EI.EstimateIndex,EI.ReferType,EI.ReferID,A.ActivityName As Title,E.EstimationName
--			FROM Activity A LEFT JOIN 
--				 EstimationItems EI ON EI.ReferID = A.ActivityCode AND EI.ReferType = 'A' AND A.StudyYear = EI.AcademicYear
--				 INNER JOIN Estimation E ON EI.EstimationID = E.EstimationID
--				 WHERE A.StudyYear = @AcademicYear AND E.Enabled = 1
--		End
--	END
--End

---------------------------------------------
--If Not Exists(Select * From Sys.PROCEDURES Where Object_ID = Object_ID('GetEstimateList'))
--Begin
--	CREATE PROCEDURE [dbo].[GetEstimateList]
--		@EstimationID uniqueidentifier
--	AS
--	BEGIN
--		SET NOCOUNT ON;

--		SELECT G.GroupID, G.GroupName, G.GroupIndex, L.ListID, L.ListDetail, L.ListIndex
--		FROM EstimationGroup AS G INNER JOIN EstimationList AS L ON G.GroupID = L.GroupID
--		WHERE  G.EstimationID = @EstimationID AND G.DelFlag = 0 AND L.DelFlag = 0
--		ORDER BY G.GroupIndex, L.ListIndex
--	END
--End

------------------------------------------
--If Not Exists(Select * From Sys.PROCEDURES Where Object_ID = Object_ID('GetEstimates'))
--Begin
--	CREATE PROCEDURE [dbo].[GetEstimates]
--		@SchoolID nVarchar(50) = NULL,
--		@EstimationType tinyint = NULL,
--		@AcademicYear varchar(4)=NULL,
--		@ReferID uniqueidentifier=NULL
--	AS
--	BEGIN
--		SET NOCOUNT ON;
--		IF @ReferID IS NOT NULL
--		BEGIN
--		--สำหรับจับคู่แบบประเมิน
--			IF @SchoolID IS NULL
--			BEGIN
--				IF @EstimationType IS NULL
--				BEGIN
--					SELECT E.EstimationID, E.EstimationName, E.EstimationType, E.Rating, E.SchoolID, E.Enabled, E.CreateUser, U.EmpName As DisplayName, S.SchoolName,COUNT(EI.EstimateItemID) Existing
--					FROM Estimation E LEFT JOIN Employee U ON E.CreateUser = U.EmpID LEFT JOIN MR_School S ON E.SchoolID = S.SchoolID
--						 LEFT JOIN EstimationItems EI ON E.EstimationID = EI.EstimationID AND EI.ReferID = @ReferID AND EI.AcademicYear = @AcademicYear
--					GROUP BY E.EstimationID, E.EstimationName, E.EstimationType, E.Rating, E.SchoolID, E.Enabled, E.CreateUser, U.EmpName, S.SchoolName
--				END
--				ELSE
--				BEGIN
--					SELECT E.EstimationID, E.EstimationName, E.EstimationType, E.Rating, E.SchoolID, E.Enabled, E.CreateUser, U.EmpName As DisplayName, S.SchoolName,COUNT(EI.EstimateItemID) Existing
--					FROM Estimation E LEFT JOIN Employee U ON E.CreateUser = U.EmpID LEFT JOIN MR_School S ON E.SchoolID = S.SchoolID
--					LEFT JOIN EstimationItems EI ON E.EstimationID = EI.EstimationID AND EI.ReferID = @ReferID AND EI.AcademicYear = @AcademicYear
--					WHERE E.EstimationType = @EstimationType
--					GROUP BY E.EstimationID, E.EstimationName, E.EstimationType, E.Rating, E.SchoolID, E.Enabled, E.CreateUser, U.EmpName, S.SchoolName
--				END
--			END
--			ELSE
--			BEGIN
--				IF @EstimationType IS NULL
--				BEGIN
--					SELECT E.EstimationID, E.EstimationName, E.EstimationType, E.Rating, E.SchoolID, E.Enabled, E.CreateUser, U.EmpName As DisplayName, S.SchoolName,COUNT(EI.EstimateItemID) Existing
--					FROM Estimation E LEFT JOIN Employee U ON E.CreateUser = U.EmpID LEFT JOIN MR_School S ON E.SchoolID = S.SchoolID
--					LEFT JOIN EstimationItems EI ON E.EstimationID = EI.EstimationID AND EI.ReferID = @ReferID AND EI.AcademicYear = @AcademicYear
--					WHERE E.SchoolID = @SchoolID
--					GROUP BY E.EstimationID, E.EstimationName, E.EstimationType, E.Rating, E.SchoolID, E.Enabled, E.CreateUser, U.EmpName, S.SchoolName
--				END
--				ELSE
--				BEGIN
--					SELECT E.EstimationID, E.EstimationName, E.EstimationType, E.Rating, E.SchoolID, E.Enabled, E.CreateUser, U.EmpName As DisplayName, S.SchoolName,COUNT(EI.EstimateItemID) Existing
--					FROM Estimation E LEFT JOIN Employee U ON E.CreateUser = U.EmpID LEFT JOIN MR_School S ON E.SchoolID = S.SchoolID
--					LEFT JOIN EstimationItems EI ON E.EstimationID = EI.EstimationID AND EI.ReferID = @ReferID AND EI.AcademicYear = @AcademicYear
--					WHERE  E.SchoolID = @SchoolID AND E.EstimationType = @EstimationType
--					GROUP BY E.EstimationID, E.EstimationName, E.EstimationType, E.Rating, E.SchoolID, E.Enabled, E.CreateUser, U.EmpName, S.SchoolName
--				END
--			END

--		END
--		ELSE
--		BEGIN
--		--สำหรับแสดงรายการแบบประเมิน
--			IF @SchoolID IS NULL
--			BEGIN
--				IF @EstimationType IS NULL
--				BEGIN
--					SELECT E.EstimationID, E.EstimationName, E.EstimationType, E.Rating, E.SchoolID, E.Enabled, E.CreateUser, U.EmpName As DisplayName, S.SchoolName
--					FROM Estimation E LEFT JOIN Employee U ON E.CreateUser = U.EmpID LEFT JOIN MR_School S ON E.SchoolID = S.SchoolID
--				END
--				ELSE
--				BEGIN
--					SELECT E.EstimationID, E.EstimationName, E.EstimationType, E.Rating, E.SchoolID, E.Enabled, E.CreateUser, U.EmpName As DisplayName, S.SchoolName
--					FROM Estimation E LEFT JOIN Employee U ON E.CreateUser = U.EmpID LEFT JOIN MR_School S ON E.SchoolID = S.SchoolID
--					WHERE E.EstimationType = @EstimationType
--				END
--			END
--			ELSE
--			BEGIN
--				IF @EstimationType IS NULL
--				BEGIN
--					SELECT E.EstimationID, E.EstimationName, E.EstimationType, E.Rating, E.SchoolID, E.Enabled, E.CreateUser, U.EmpName As DisplayName, S.SchoolName
--					FROM Estimation E LEFT JOIN Employee U ON E.CreateUser = U.EmpID LEFT JOIN MR_School S ON E.SchoolID = S.SchoolID
--					WHERE E.SchoolID = @SchoolID
--				END
--				ELSE
--				BEGIN
--					SELECT E.EstimationID, E.EstimationName, E.EstimationType, E.Rating, E.SchoolID, E.Enabled, E.CreateUser, U.EmpName As DisplayName, S.SchoolName
--					FROM Estimation E LEFT JOIN Employee U ON E.CreateUser = U.EmpID LEFT JOIN MR_School S ON E.SchoolID = S.SchoolID
--					WHERE  E.SchoolID = @SchoolID AND E.EstimationType = @EstimationType
--				END
--			END
--		END		
--	END
--End
------------------------------------------------
--If Not Exists(Select * From Sys.PROCEDURES Where Object_ID = Object_ID('ReportEstimation'))
--Begin
--	CREATE PROCEDURE [dbo].[ReportEstimation]
--		@EstimationID uniqueidentifier,
--		@ReferID uniqueidentifier = NULL,
--		@UserID uniqueidentifier = NULL,
--		@Type int
--	AS
--	BEGIN
--		SET NOCOUNT ON;
--		IF @UserID IS NOT NULL
--		BEGIN
--			If @Type = 0 --ratting
--			Begin
--				SELECT G.GroupID, G.GroupName, L.ListID, L.ListDetail,ROUND(SUM(EUL.Rating)/CAST(COUNT(EUL.ListID) AS FLOAT),0) AS Score
--				FROM EstimationGroup AS G INNER JOIN EstimationList AS L ON G.GroupID = L.GroupID
--					 INNER JOIN EstimateUserList EUL ON EUL.ListID = L.ListID INNER JOIN EstimateUser EU ON EUL.ItemID = EU.ItemID
--					 INNER JOIN EstimationItems EI ON EU.EstimateItemID = EI.EstimateItemID
--				WHERE  G.EstimationID = @EstimationID AND EI.ReferID = @ReferID AND EU.UserID = @UserID AND G.DelFlag = 0 AND L.DelFlag = 0
--				GROUP BY G.GroupID, G.GroupName, L.ListID, L.ListDetail,G.GroupIndex, L.ListIndex
--				ORDER BY G.GroupIndex, L.ListIndex
--			End

--			If @Type = 1 --rubric
--			Begin
--				WITH TB AS (
--					SELECT G.GroupID, G.GroupName, L.ListID, L.ListDetail, G.GroupIndex, L.ListIndex, ROUND(SUM(EUL.Rating)/CAST(COUNT(EUL.ListID) AS FLOAT),0) AS Score
--				,COUNT(EUL.Rating) Number
--					FROM EstimationGroup AS G INNER JOIN EstimationList AS L ON G.GroupID = L.GroupID
--						 INNER JOIN EstimateUserList EUL ON EUL.ListID = L.ListID INNER JOIN EstimateUser EU ON EUL.ItemID = EU.ItemID
--						 INNER JOIN EstimationItems EI ON EU.EstimateItemID = EI.EstimateItemID
--					WHERE  G.EstimationID = @EstimationID AND EI.ReferID = @ReferID  AND EU.UserID = @UserID AND G.DelFlag = 0 AND L.DelFlag = 0
--					GROUP BY G.GroupID, G.GroupName, L.ListID, L.ListDetail,G.GroupIndex, L.ListIndex
--					)
--				SELECT * FROM TB
--				WHERE TB.Number  = (SELECT MAX(Number) FROM TB)
--				ORDER BY GroupIndex, ListIndex
--			End
--		END
--		ELSE
--		BEGIN
--			If @Type = 0 --ratting
--			Begin
--				SELECT G.GroupID, G.GroupName, L.ListID, L.ListDetail,ROUND(SUM(EUL.Rating)/CAST(COUNT(EUL.ListID) AS FLOAT),0) AS Score
--				FROM EstimationGroup AS G INNER JOIN EstimationList AS L ON G.GroupID = L.GroupID
--					 INNER JOIN EstimateUserList EUL ON EUL.ListID = L.ListID INNER JOIN EstimateUser EU ON EUL.ItemID = EU.ItemID
--					 INNER JOIN EstimationItems EI ON EU.EstimateItemID = EI.EstimateItemID
--				WHERE  G.EstimationID = @EstimationID AND EI.ReferID = @ReferID AND G.DelFlag = 0 AND L.DelFlag = 0
--				GROUP BY G.GroupID, G.GroupName, L.ListID, L.ListDetail,G.GroupIndex, L.ListIndex
--				ORDER BY G.GroupIndex, L.ListIndex
--			End

--			If @Type = 1 --rubric
--			Begin
--				WITH TB AS (
--					SELECT G.GroupID, G.GroupName, L.ListID, L.ListDetail, G.GroupIndex, L.ListIndex, ROUND(SUM(EUL.Rating)/CAST(COUNT(EUL.ListID) AS FLOAT),0) AS Score
--				,COUNT(EUL.Rating) Number
--					FROM EstimationGroup AS G INNER JOIN EstimationList AS L ON G.GroupID = L.GroupID
--						 INNER JOIN EstimateUserList EUL ON EUL.ListID = L.ListID INNER JOIN EstimateUser EU ON EUL.ItemID = EU.ItemID
--						 INNER JOIN EstimationItems EI ON EU.EstimateItemID = EI.EstimateItemID
--					WHERE  G.EstimationID = @EstimationID AND EI.ReferID = @ReferID AND G.DelFlag = 0 AND L.DelFlag = 0
--					GROUP BY G.GroupID, G.GroupName, L.ListID, L.ListDetail,G.GroupIndex, L.ListIndex
--					)
--				SELECT * FROM TB
--				WHERE TB.Number  = (SELECT MAX(Number) FROM TB)
--				ORDER BY GroupIndex, ListIndex
--			End
--		END
--	END
--End

--------------------------------------------
--If Not Exists(Select * From Sys.PROCEDURES Where Object_ID = Object_ID('SaveEvaluation'))
--Begin
--	CREATE PROCEDURE [dbo].[SaveEvaluation]
--		@EstimateItemId uniqueidentifier,
--		@UserID uniqueidentifier,
--		@Values nvarchar(max)
--	AS
--	BEGIN
--		IF NOT EXISTS(SELECT ItemID FROM EstimateUser WHERE EstimateItemID = @EstimateItemId AND UserID = @UserID)
--		BEGIN
--			DECLARE @Value nvarchar(50)
--			DECLARE @ItemID uniqueidentifier 
--			SET @ItemID = NEWID()
--			INSERT INTO [EstimateUser]([ItemID],[EstimateItemID],[UserID],[Score],[CreateDate]) VALUES (@ItemID,@EstimateItemId,@UserID,NULL,GETDATE())

--			IF CHARINDEX(',',@Values) = 0 AND LEN(@Values) > 0 SET @Values = @Values + ','
--			WHILE CHARINDEX(',',@Values)>0
--				BEGIN
--					SET @Value = SUBSTRING(@Values,0, CHARINDEX(',',@Values))
--					INSERT INTO [EstimateUserList]([ItemID],[ListID],[Rating]) VALUES (@ItemID,	SUBSTRING(@Value,0, CHARINDEX('_',@Value)),	SUBSTRING(@Value, CHARINDEX('_',@Value)+1, LEN(@Value)))
--					SET @Values = SUBSTRING(@Values, CHARINDEX(',',@Values)+1, LEN(@Values))
--					IF CHARINDEX(',',@Values) = 0 AND LEN(@Values) > 0 SET @Values = @Values + ','
--				END
--		END
--	END
--End





