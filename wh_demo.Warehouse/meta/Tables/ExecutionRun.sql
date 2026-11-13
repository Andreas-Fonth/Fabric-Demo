CREATE TABLE [meta].[ExecutionRun] (
    [ExecutionID]  VARCHAR (36)  NOT NULL,
    [PipelineName] VARCHAR (100) NOT NULL,
    [Status]       VARCHAR (20)  NOT NULL,
    [StartTime]    DATETIME2 (6) NOT NULL,
    [EndTime]      DATETIME2 (6) NULL,
    [ErrorMessage] VARCHAR (MAX) NULL
);


GO