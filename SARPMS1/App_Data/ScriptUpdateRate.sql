Select * From Indicators
Select * From Standard
Select * From TCriteria Where Tcriteria = 5 Order By ScoreGroupID, Criterion

Select a.Sort AS StdSort, b.Sort AS IndSort, b.ScoreGroupID
From Standard a, Indicators b
Where a.StandardCode = b.StandardCode And a.StudyYear = '2555' 
And a.DelFlag = 0 And b.DelFlag = 0
Order By a.Sort, b.Sort




------------เกณฑ์เก่า
---ตัวบ่งชี้ที่  12.4  คะแนนเต็ม  0.5
Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 12 And b.Sort = 4

---ตัวบ่งชี้ที่  12.5  คะแนนเต็ม  0.5
Update Indicators Set ScoreGroupID = '422A806A-D3F6-41B0-BBAA-C40CEB3E23B8'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 12 And b.Sort = 5

---ตัวบ่งชี้ที่  5.1  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 5 And b.Sort = 1

---ตัวบ่งชี้ที่  5.2  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 5 And b.Sort = 2

---ตัวบ่งชี้ที่  5.4  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 5 And b.Sort = 4

---ตัวบ่งชี้ที่  8.1  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 8 And b.Sort = 1

---ตัวบ่งชี้ที่  8.5  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 8 And b.Sort = 5

---ตัวบ่งชี้ที่  9.2  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 9 And b.Sort = 2

---ตัวบ่งชี้ที่  10.3  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 10 And b.Sort = 3

---ตัวบ่งชี้ที่  10.4  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 10 And b.Sort = 4

---ตัวบ่งชี้ที่  12.1  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 12 And b.Sort = 1

---ตัวบ่งชี้ที่  12.2  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 12 And b.Sort = 2

---ตัวบ่งชี้ที่  12.3  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 12 And b.Sort = 3

---ตัวบ่งชี้ที่  12.6  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = 'F5A541C2-8F01-468E-B92A-3B2D03E0F9A3'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 12 And b.Sort = 6

---ตัวบ่งชี้ที่  5.3  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 5 And b.Sort = 3

---ตัวบ่งชี้ที่  8.2  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 8 And b.Sort = 2

---ตัวบ่งชี้ที่  8.3  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 8 And b.Sort = 3

---ตัวบ่งชี้ที่  8.4  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 8 And b.Sort = 4

---ตัวบ่งชี้ที่  8.6  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 8 And b.Sort = 6

---ตัวบ่งชี้ที่  9.1  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 9 And b.Sort = 1

---ตัวบ่งชี้ที่  9.3  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 9 And b.Sort = 3

---ตัวบ่งชี้ที่  10.1  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 10 And b.Sort = 1

---ตัวบ่งชี้ที่  10.2  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 10 And b.Sort = 2

---ตัวบ่งชี้ที่  10.5  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 10 And b.Sort = 5

---ตัวบ่งชี้ที่  10.6  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 10 And b.Sort = 6

---ตัวบ่งชี้ที่  14.2  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 14 And b.Sort = 2

---ตัวบ่งชี้ที่  15.2  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = '00EB2C36-B042-472F-BD5D-1DF7C57568C4'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 15 And b.Sort = 2

---ตัวบ่งชี้ที่  13.1  คะแนนเต็ม  5.0
Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 13 And b.Sort = 1

---ตัวบ่งชี้ที่  13.2  คะแนนเต็ม  5.0
Update Indicators Set ScoreGroupID = 'B434D787-CBAA-41E5-BA94-DDB60A8E3952'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 13 And b.Sort = 2


------------เกณฑ์ใหม่
---ตัวบ่งชี้ที่  12.4  คะแนนเต็ม  0.5
Update Indicators Set ScoreGroupID = 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 12 And b.Sort = 4

---ตัวบ่งชี้ที่  12.5  คะแนนเต็ม  0.5
Update Indicators Set ScoreGroupID = 'E2EF2D9F-7052-418E-8CE4-8E93525D5C35'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 12 And b.Sort = 5

---ตัวบ่งชี้ที่  5.1  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 5 And b.Sort = 1

---ตัวบ่งชี้ที่  5.2  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 5 And b.Sort = 2

---ตัวบ่งชี้ที่  5.4  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 5 And b.Sort = 4

---ตัวบ่งชี้ที่  8.1  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 8 And b.Sort = 1

---ตัวบ่งชี้ที่  8.5  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 8 And b.Sort = 5

---ตัวบ่งชี้ที่  9.2  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 9 And b.Sort = 2

---ตัวบ่งชี้ที่  10.3  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 10 And b.Sort = 3

---ตัวบ่งชี้ที่  10.4  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 10 And b.Sort = 4

---ตัวบ่งชี้ที่  12.1  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 12 And b.Sort = 1

---ตัวบ่งชี้ที่  12.2  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 12 And b.Sort = 2

---ตัวบ่งชี้ที่  12.3  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 12 And b.Sort = 3

---ตัวบ่งชี้ที่  12.6  คะแนนเต็ม  1.0
Update Indicators Set ScoreGroupID = '25E2142B-3F11-48DF-8D66-681E6FDDC5E7'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 12 And b.Sort = 6

---ตัวบ่งชี้ที่  5.3  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 5 And b.Sort = 3

---ตัวบ่งชี้ที่  8.2  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 8 And b.Sort = 2

---ตัวบ่งชี้ที่  8.3  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 8 And b.Sort = 3

---ตัวบ่งชี้ที่  8.4  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 8 And b.Sort = 4

---ตัวบ่งชี้ที่  8.6  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 8 And b.Sort = 6

---ตัวบ่งชี้ที่  9.1  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 9 And b.Sort = 1

---ตัวบ่งชี้ที่  9.3  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 9 And b.Sort = 3

---ตัวบ่งชี้ที่  10.1  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 10 And b.Sort = 1

---ตัวบ่งชี้ที่  10.2  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 10 And b.Sort = 2

---ตัวบ่งชี้ที่  10.5  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 10 And b.Sort = 5

---ตัวบ่งชี้ที่  10.6  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 10 And b.Sort = 6

---ตัวบ่งชี้ที่  14.2  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 14 And b.Sort = 2

---ตัวบ่งชี้ที่  15.2  คะแนนเต็ม  2.0
Update Indicators Set ScoreGroupID = 'E82BB47C-6C65-409F-818E-6ADE319CA8A1'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 15 And b.Sort = 2

---ตัวบ่งชี้ที่  13.1  คะแนนเต็ม  5.0
Update Indicators Set ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 13 And b.Sort = 1

---ตัวบ่งชี้ที่  13.2  คะแนนเต็ม  5.0
Update Indicators Set ScoreGroupID = '7211D888-9FDA-4691-AA80-13D38710AA45'
From Standard a Inner Join Indicators b On a.StandardCode = b.StandardCode
And a.DelFlag = 0 And b.DelFlag = 0 And a.StudyYear = '2555' 
And a.Sort = 13 And b.Sort = 2
