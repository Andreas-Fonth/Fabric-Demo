CREATE   Procedure dbo.sp_checkinvalidproc
AS
BEGIN
-- 1. Tabelle für die Validierungsergebnisse vorbereiten
DROP TABLE IF EXISTS #ValidationResults;
CREATE TABLE #ValidationResults (
    SchemaName VARCHAR(128),
    ProcedureName VARCHAR(128),
    ValidationStatus VARCHAR(20),
    ErrorMessage VARCHAR(MAX),
    ErrorNumber INT
);

-- 2. Zu prüfende Prozeduren aus dem Gold-Schema ermitteln
DROP TABLE IF EXISTS #ProcedureQueue;
CREATE TABLE #ProcedureQueue (
    RowID INT IDENTITY(1,1),
    SchemaName VARCHAR(128),
    ProcedureName VARCHAR(128)
);

INSERT INTO #ProcedureQueue (SchemaName, ProcedureName)
SELECT s.name, p.name
FROM sys.procedures AS p
JOIN sys.schemas AS s ON p.schema_id = s.schema_id
WHERE s.name = 'gold';

DECLARE @CurrentRow INT = 1;
DECLARE @MaxRow INT;
DECLARE @SchemaName VARCHAR(128);
DECLARE @ProcName VARCHAR(128);
DECLARE @ExecSQL NVARCHAR(MAX);

SELECT @MaxRow = MAX(RowID) FROM #ProcedureQueue;

IF @MaxRow IS NULL OR @MaxRow = 0
BEGIN
    PRINT 'Keine Prozeduren im Schema "gold" gefunden.';
END
ELSE
BEGIN
    -- 3. Ausführungs-Runner mit erzwungenem Test-Rollback
    WHILE @CurrentRow <= @MaxRow
    BEGIN
        SELECT 
            @SchemaName = SchemaName,
            @ProcName = ProcedureName
        FROM #ProcedureQueue 
        WHERE RowID = @CurrentRow;

        SET @ExecSQL = 'EXEC ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@ProcName);

        -- Jede Prozedur läuft in einer isolierten Test-Transaktion
        BEGIN TRY
            BEGIN TRANSACTION;

            -- Prozedur ausführen
            EXEC sp_executesql @ExecSQL;

            -- WICHTIG: Auch bei Erfolg rollen wir bewusst zurück, 
            -- damit produktive Daten nicht verändert werden ("Dry Run")
            ROLLBACK TRANSACTION;

            -- Wenn bis hierhin kein Fehler geflogen ist, war der Code valide
            INSERT INTO #ValidationResults (SchemaName, ProcedureName, ValidationStatus, ErrorMessage, ErrorNumber)
            VALUES (@SchemaName, @ProcName, 'VALID', NULL, 0);

        END TRY
        BEGIN CATCH
            -- Falls die Transaktion noch offen ist, im Fehlerfall sauber verwerfen
            IF @@TRANCOUNT > 0
            BEGIN
                ROLLBACK TRANSACTION;
            END

            -- Fehler dokumentieren
            INSERT INTO #ValidationResults (SchemaName, ProcedureName, ValidationStatus, ErrorMessage, ErrorNumber)
            VALUES (
                @SchemaName, 
                @ProcName, 
                'INVALID', 
                ERROR_MESSAGE(), 
                ERROR_NUMBER()
            );
        END CATCH

        SET @CurrentRow = @CurrentRow + 1;
    END;
END;

-- 4. Ergebnis-Report ausgeben
SELECT 
    SchemaName,
    ProcedureName,
    ValidationStatus,
    ErrorNumber,
    ErrorMessage
FROM #ValidationResults
ORDER BY ValidationStatus DESC, ProcedureName;

-- 5. Aufräumen
DROP TABLE IF EXISTS #ProcedureQueue;
DROP TABLE IF EXISTS #ValidationResults;

END;

--exec dbo.sp_checkinvalidproc;

GO