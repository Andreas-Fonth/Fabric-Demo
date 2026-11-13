CREATE TABLE [gold].[DimDate] (
    [DateKey]       INT          NOT NULL,
    [FullDate]      DATE         NOT NULL,
    [Year]          INT          NOT NULL,
    [Quarter]       INT          NOT NULL,
    [Month]         INT          NOT NULL,
    [MonthName]     VARCHAR (20) NOT NULL,
    [Day]           INT          NOT NULL,
    [DayOfWeek]     INT          NOT NULL,
    [DayName]       VARCHAR (20) NOT NULL,
    [IsWeekend]     BIT          NOT NULL,
    [YearMonthSort] INT          NULL,
    [YearMonth]     VARCHAR (7)  NULL
);


GO