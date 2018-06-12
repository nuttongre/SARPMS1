USE [Sar]
GO
/****** Object:  StoredProcedure [dbo].[GenRate]    Script Date: 17/12/2558 16:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	Create PROCEDURE [dbo].[GenRate]
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

-------------เพิ่ม StoreProcedure Update เกณฑ์ในตัวบ่งชี้---------------------------------------------------

	SET ANSI_NULLS ON
