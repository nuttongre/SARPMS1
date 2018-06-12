USE [Sar]
GO
/****** Object:  StoredProcedure [dbo].[GenIndRate]    Script Date: 17/12/2558 16:27:30 ******/
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

------ Update ScoreGroup--------------
--Update ScoreGroup Set ScoreGroupName = 'หมวดคะแนนเต็ม 0.5' Where ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
--Update ScoreGroup Set ScoreGroupName = 'หมวดคะแนนเต็ม 1.0' Where ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
--Update ScoreGroup Set ScoreGroupName = 'หมวดคะแนนเต็ม 2.0' Where ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
--Update ScoreGroup Set ScoreGroupName = 'หมวดคะแนนเต็ม 5.0' Where ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'

