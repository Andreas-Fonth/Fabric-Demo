CREATE TABLE [stg].[production] (
    [ProductionID]      VARCHAR (8000) NULL,
    [ProductID]         VARCHAR (8000) NULL,
    [Plant]             VARCHAR (8000) NULL,
    [Machine]           VARCHAR (8000) NULL,
    [PlannedQuantity]   VARCHAR (8000) NULL,
    [ProducedQuantity]  VARCHAR (8000) NULL,
    [DefectiveQuantity] VARCHAR (8000) NULL,
    [DurationHours]     VARCHAR (8000) NULL,
    [ProductionDate]    VARCHAR (8000) NULL,
    [IngestionDateTime] VARCHAR (8000) NULL,
    [SourceFileName]    VARCHAR (255)  NULL
);


GO