CREATE TABLE [meta].[TableLoadLog] (
    [LogID]             BIGINT          IDENTITY NOT NULL,
    [ExecutionID]       VARCHAR (36)    NOT NULL,
    [TargetSchema]      VARCHAR (50)    NOT NULL,
    [TargetTable]       VARCHAR (100)   NOT NULL,
    [LoadType]          VARCHAR (20)    NOT NULL,
    [RowsAffected]      BIGINT          NULL,
    [StartTime]         DATETIME2 (6)   NOT NULL,
    [EndTime]           DATETIME2 (6)   NOT NULL,
    [DurationSeconds]   DECIMAL (10, 2) NOT NULL,
    [Status]            VARCHAR (20)    NOT NULL,
    [ErrorMessage]      VARCHAR (MAX)   NULL,
    [CreatedEngineTime] DATETIME2 (6)   NOT NULL
);


GO