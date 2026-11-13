CREATE TABLE [gold].[FactSupplyChain] (
    [ProductID]            VARCHAR (50)    NOT NULL,
    [SupplierName]         VARCHAR (100)   NULL,
    [WarehouseName]        VARCHAR (100)   NULL,
    [OrderStatus]          VARCHAR (50)    NULL,
    [OrderDate]            DATE            NULL,
    [OrderDateKey]         INT             NULL,
    [DeliveryDate]         DATE            NULL,
    [DeliveryDateKey]      INT             NULL,
    [TotalShipmentCount]   INT             NULL,
    [TotalOrderedQuantity] BIGINT          NULL,
    [LeadTimeDays]         DECIMAL (10, 2) NULL,
    [MaxDelayDays]         INT             NULL,
    [SourceFileName]       VARCHAR (255)   NULL,
    [IngestionDateTime]    DATETIME2 (6)   NULL,
    [LoadedToGoldDateTime] DATETIME2 (6)   NULL
);


GO