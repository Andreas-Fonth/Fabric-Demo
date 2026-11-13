CREATE TABLE [gold].[FactOrders] (
    [CustomerID]           VARCHAR (100) NULL,
    [ProductID]            VARCHAR (100) NULL,
    [OrderDate]            DATE          NULL,
    [OrderDateKey]         INT           NULL,
    [TotalOrderCount]      INT           NULL,
    [TotalQuantity]        BIGINT        NULL,
    [SourceFileName]       VARCHAR (255) NULL,
    [IngestionDateTime]    DATETIME2 (6) NULL,
    [LoadedToGoldDateTime] DATETIME2 (6) NOT NULL
);


GO