CREATE TABLE [stg].[supply_chain] (
    [ShipmentID]        VARCHAR (8000) NULL,
    [ProductID]         VARCHAR (8000) NULL,
    [Supplier]          VARCHAR (8000) NULL,
    [Warehouse]         VARCHAR (8000) NULL,
    [OrderedQuantity]   VARCHAR (8000) NULL,
    [LeadTimeDays]      VARCHAR (8000) NULL,
    [DelayDays]         VARCHAR (8000) NULL,
    [OrderStatus]       VARCHAR (8000) NULL,
    [OrderDate]         VARCHAR (8000) NULL,
    [DeliveryDate]      VARCHAR (8000) NULL,
    [IngestionDateTime] VARCHAR (8000) NULL,
    [SourceFileName]    VARCHAR (255)  NULL
);


GO