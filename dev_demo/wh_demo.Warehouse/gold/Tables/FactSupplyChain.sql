CREATE TABLE [gold].[FactSupplyChain] (
    [ShipmentID]           VARCHAR (100)   NOT NULL,
    [ProductID]            VARCHAR (50)    NOT NULL,
    [SupplierName]         VARCHAR (100)   NULL,
    [WarehouseName]        VARCHAR (100)   NULL,
    [OrderedQuantity]      INT             NULL,
    [LeadTimeDays]         DECIMAL (10, 2) NULL,
    [DelayDays]            INT             NULL,
    [OrderStatus]          VARCHAR (50)    NULL,
    [OrderDate]            DATE            NULL,
    [OrderDateKey]         INT             NULL,
    [DeliveryDate]         DATE            NULL,
    [DeliveryDateKey]      INT             NULL,
    [SourceFileName]       VARCHAR (255)   NULL,
    [IngestionDateTime]    DATETIME2 (6)   NULL,
    [LoadedToGoldDateTime] DATETIME2 (6)   NULL
);
GO
