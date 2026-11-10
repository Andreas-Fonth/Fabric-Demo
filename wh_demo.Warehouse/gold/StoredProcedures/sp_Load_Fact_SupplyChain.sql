CREATE OR ALTER PROCEDURE [gold].[sp_Load_Fact_SupplyChain]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CurrentGoldTime DATETIME2(6);
    EXEC [util].[sp_GetIngestionTime] @IngestionTime = @CurrentGoldTime OUTPUT;

    TRUNCATE TABLE [gold].[FactSupplyChain];

    INSERT INTO [gold].[FactSupplyChain] (
        [ProductID],
        [SupplierName],
        [WarehouseName],
        [OrderStatus],
        [OrderDate],
        [OrderDateKey],
        [DeliveryDate],
        [DeliveryDateKey],
        [TotalShipmentCount],
        [TotalOrderedQuantity],
        [LeadTimeDays],
        [MaxDelayDays],
        [SourceFileName],
        [IngestionDateTime],
        [LoadedToGoldDateTime]
    )
    SELECT 
        [ProductID],
        [Supplier]                                                  AS [SupplierName],
        [Warehouse]                                                 AS [WarehouseName],
        [OrderStatus],
        CAST([OrderDate] AS DATE)                                   AS [OrderDate],
        CONVERT(INT, FORMAT(CAST([OrderDate] AS DATE), 'yyyyMMdd')) AS [OrderDateKey],
        CAST([DeliveryDate] AS DATE)                                AS [DeliveryDate],
        CONVERT(INT, FORMAT(CAST([DeliveryDate] AS DATE), 'yyyyMMdd')) AS [DeliveryDateKey],
        COUNT([ShipmentID])                                         AS [TotalShipmentCount],
        SUM(TRY_CAST([OrderedQuantity] AS BIGINT))                  AS [TotalOrderedQuantity],
        AVG(TRY_CAST([LeadTimeDays] AS DECIMAL(10,2)))              AS [LeadTimeDays],
        MAX(TRY_CAST([DelayDays] AS INT))                           AS [MaxDelayDays],
        MAX([SourceFileName])                                       AS [SourceFileName],
        MAX([IngestionDateTime])                                    AS [IngestionDateTime],
        @CurrentGoldTime                                            AS [LoadedToGoldDateTime]
    FROM [bronze].[supply_chain]
    GROUP BY 
        [ProductID], [Supplier], [Warehouse], [OrderStatus],
        CAST([OrderDate] AS DATE), CAST([DeliveryDate] AS DATE);
END;
