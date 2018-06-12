USE [Sar]
GO
/****** Object:  StoredProcedure [dbo].[GenRate]    Script Date: 17/12/2558 16:27:07 ******/
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