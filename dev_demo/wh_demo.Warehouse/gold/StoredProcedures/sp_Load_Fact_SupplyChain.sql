CREATE   PROCEDURE [gold].[sp_Load_Fact_SupplyChain]
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE [gold].[FactSupplyChain];

    INSERT INTO [gold].[FactSupplyChain] (
        [ShipmentID],
        [ProductID],
        [SupplierName],
        [WarehouseName],
        [OrderedQuantity],
        [LeadTimeDays],
        [DelayDays],
        [OrderStatus],
        [OrderDate],
        [OrderDateKey],
        [DeliveryDate],
        [DeliveryDateKey],
        [SourceFileName],
        [IngestionDateTime],
        [LoadedToGoldDateTime]
    )
    SELECT 
        [ShipmentID],
        [ProductID],
        [Supplier]                              AS [SupplierName],
        [Warehouse]                             AS [WarehouseName],
        CAST([OrderedQuantity] AS INT)          AS [OrderedQuantity],
        CAST([LeadTimeDays] AS DECIMAL(10,2))   AS [LeadTimeDays],
        CAST([DelayDays] AS INT)                AS [DelayDays],
        [OrderStatus],
        CAST([OrderDate] AS DATE)               AS [OrderDate],
        CONVERT(INT, FORMAT(CAST([OrderDate] AS DATE), 'yyyyMMdd')) AS [OrderDateKey],
        CAST([DeliveryDate] AS DATE)            AS [DeliveryDate],
        CONVERT(INT, FORMAT(CAST([DeliveryDate] AS DATE), 'yyyyMMdd')) AS [DeliveryDateKey],
        [SourceFileName],
        [IngestionDateTime],
        CAST(SYSDATETIMEOFFSET() AT TIME ZONE 'W. Europe Standard Time' AS DATETIME2) AS [LoadedToGoldDateTime]
    FROM [bronze].[supply_chain];
END;