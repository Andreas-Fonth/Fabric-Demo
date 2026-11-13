CREATE TABLE [bronze].[production] (
    [ProductionID]      VARCHAR (8000) NULL,
    [ProductID]         VARCHAR (8000) NULL,
    [Plant]             VARCHAR (8000) NULL,
    [Machine]           VARCHAR (8000) NULL,
    [PlannedQuantity]   VARCHAR (8000) NULL,
    [ProducedQuantity]  VARCHAR (8000) NULL,
    [DefectiveQuantity] VARCHAR (8000) NULL,
    [DurationHours]     VARCHAR (8000) NULL,
    [ProductionDate]    VARCHAR (8000) NULL,
    [IngestionDateTime] DATETIME2 (6)  NULL,
    [SourceFileName]    VARCHAR (250)  NULL
);


GO