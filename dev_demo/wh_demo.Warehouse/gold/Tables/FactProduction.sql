CREATE TABLE [gold].[FactProduction] (
    [ProductID]              VARCHAR (100)   NULL,
    [Plant]                  VARCHAR (100)   NULL,
    [Machine]                VARCHAR (100)   NULL,
    [ProductionDate]         DATE            NULL,
    [ProductionDateKey]      INT             NULL,
    [TotalProductionRuns]    INT             NULL,
    [TotalPlannedQuantity]   BIGINT          NULL,
    [TotalProducedQuantity]  BIGINT          NULL,
    [TotalDefectiveQuantity] BIGINT          NULL,
    [TotalDurationHours]     DECIMAL (10, 2) NULL,
    [SourceFileName]         VARCHAR (255)   NULL,
    [IngestionDateTime]      DATETIME2 (6)   NULL,
    [LoadedToGoldDateTime]   DATETIME2 (6)   NOT NULL
);


GO