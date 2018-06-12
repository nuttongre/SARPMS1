
GO
PRINT N'Altering [dbo].[Activity]...';


GO
ALTER TABLE [dbo].[Activity]
    ADD [ApproveUser] NVARCHAR (50) NULL;


GO
PRINT N'Altering [dbo].[LogSchoolSar]...';


GO
ALTER TABLE [dbo].[LogSchoolSar]
    ADD [sDate] DATETIME NULL,
        [eDate] DATETIME NULL;


GO
PRINT N'Update complete.'
GO
