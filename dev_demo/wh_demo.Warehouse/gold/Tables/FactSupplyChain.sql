CREATE TABLE [gold].[FactSupplyChain] (

	[ShipmentID] varchar(100) NOT NULL, 
	[ProductID] varchar(50) NOT NULL, 
	[SupplierName] varchar(100) NULL, 
	[WarehouseName] varchar(100) NULL, 
	[OrderedQuantity] int NULL, 
	[LeadTimeDays] decimal(10,2) NULL, 
	[DelayDays] int NULL, 
	[OrderStatus] varchar(50) NULL, 
	[OrderDate] date NULL, 
	[OrderDateKey] int NULL, 
	[DeliveryDate] date NULL, 
	[DeliveryDateKey] int NULL, 
	[SourceFileName] varchar(255) NULL, 
	[IngestionDateTime] datetime2(6) NULL, 
	[LoadedToGoldDateTime] datetime2(6) NULL
);