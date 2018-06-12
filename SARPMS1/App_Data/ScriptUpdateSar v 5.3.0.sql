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


--*********************Ver 5.5.0******************************
--************************************************************

--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
----------ลบ StoreProcedure เมนูนโยบาย
If Exists(Select * From Sys.Procedures Where Name = 'ckMenuPolicy')
Begin
	DROP PROCEDURE ckMenuPolicy
End

--$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

--######################################################################################

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

--######################################################################################

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

Update MR_School Set ckPolicy = 0 Where ckPolicy Is Null

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
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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

Update MySubMenu Set Sort = 96 Where MySubMenuID = 'B906F7F0-E09C-4C3B-A2F6-DFF9806A1955'
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

--)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
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


--)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

Update MR_School Set UpdateLink = 'http://122.155.0.135/ProductUpdate'
Update MR_School Set LogSarLink = 'http://122.155.0.135/Sar/MasterData/LogSchoolSar.aspx'
Update MR_School Set MailTo = 'noom.lfc@hotmail.com'

Update ScoreGroup Set CreateUser = '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A'
Update ScoreGroup Set CreateDate = getdate()
Update ScoreGroup Set UpdateUser = '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A'
Update ScoreGroup Set UpdateDate = getdate()
Update ScoreGroup Set DelFlag = 0


Update TCriteria Set CreateUser = '9A9A9A9A-9A9A-9A9A-9A9A-9A9A9A9A9A9A'
Where (Day(CreateDate) = 9 And Month(CreateDate) = 8 And Year(CreateDate) = 2011)
or(Day(CreateDate) = 14 And Month(CreateDate) = 9 And Year(CreateDate) = 2012)


Select

Select * From MR_School
Select * From ScoreGroup 
Select * From Indicators

Update MySubMenu Set ImgName = 'S22.png'  Where MySubMenuID = 'D14CBB7A-A320-4965-B2E8-BC29EA4ABCFF'


--//////////////////////////////

--เพิ่มฟิวเช็ค FullText
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckFullText')
Begin
	alter table MR_School add ckFullText bit
End

Update MR_School Set ckFullText = 0 Where ckFullText Is Null

--เพิ่มฟิวเช็ค ckBudgetYear
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('MR_School') And Name = 'ckBudgetYear')
Begin
	alter table MR_School add ckBudgetYear bit
End

Update MR_School Set ckBudgetYear = 0 Where ckBudgetYear Is Null

--เพิ่มฟิว งบประมาณตั้งไว้ ในโครงการ
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('Projects') And Name = 'SetBudget')
Begin
	alter table Projects add SetBudget float
End

Update Projects Set SetBudget = 0 Where SetBudget Is Null

--เพิ่มฟิว จำนวนที่เบิก ในเบิกย่อย
If Not Exists(Select * From Sys.Columns Where Object_ID = Object_ID('ActivityCostsDetail') And Name = 'TotalDD')
Begin
	alter table ActivityCostsDetail add TotalDD float
End

Update ActivityCostsDetail Set TotalDD = 0 Where TotalDD Is Null








