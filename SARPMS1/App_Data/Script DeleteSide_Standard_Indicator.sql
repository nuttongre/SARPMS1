----ส่วนนี้ไว้ดูข้อมูล
Select * From Side Where StudyYear = 2560 And DelFlag = 0
Select * From Standard Where StudyYear = 2560 And DelFlag = 0
Select I.* From Standard S, Indicators I Where S.StandardCode = I.StandardCode And S.StudyYear = 2560 And I.DelFlag = 0

-----ส่วนนี้ไว้ใช้ลบช้อมูล ปีที่ต้องการ
--Delete Side Where StudyYear = 2560 
--Delete Standard Where StudyYear = 2560 
--Delete Indicators From Standard S, Indicators I Where S.StandardCode = I.StandardCode And S.StudyYear = 2560

