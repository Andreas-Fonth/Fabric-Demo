CREATE TABLE [meta].[PipelineControl] (
    [ID]                    INT           NOT NULL,
    [SourceSchema]          VARCHAR (50)  NOT NULL,
    [SourceTable]           VARCHAR (100) NOT NULL,
    [TargetSchema]          VARCHAR (50)  NOT NULL,
    [TargetTable]           VARCHAR (100) NOT NULL,
    [LoadType]              VARCHAR (20)  NOT NULL,
    [UpdateIngestionColumn] BIT           NOT NULL,
    [IsActive]              BIT           NOT NULL
);


GO

ALTER TABLE [meta].[PipelineControl]
    ADD CONSTRAINT [PK_PipelineControl] PRIMARY KEY NONCLUSTERED ([ID] ASC) NOT ENFORCED;


GO