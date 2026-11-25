# Pipeline: `csv2stg`

**Zweck:** Lädt Rohdaten aus dem Lakehouse in das `stg`-Schema des Warehouses und protokolliert den Lauf in den `meta`-Tabellen.  
**Trigger:** Manuell (aktuell kein Zeitplan)  
**Abhängigkeiten:** Delta-Tabellen im Lakehouse müssen aktuell sein.

---

## 1. Vorbedingungen (Manueller Ingest)

Solange keine automatisierte Anbindung besteht, müssen vor dem Pipeline-Start folgende CSV-Dateien manuell in das Lakehouse (`58aebfb8-fbba-4664-b42d-e39de7fe64d4`) geladen und per Rechtsklick (*Load to Tables*) als Delta-Tabelle bereitgestellt werden:

| Quell-CSV | Ziel-Delta-Tabelle (Lakehouse) | Lademodus |
| :--- | :--- | :--- |
| `orders.csv` | `orders` | Overwrite *(bitte anpassen, falls Append)* |
| `supply_chain.csv` | `supply_chain` | Overwrite |
| `production.csv` | `production` | Overwrite |

---

## 2. Pipeline-Aufbau & Datenfluss

Die Pipeline `csv2stg` führt drei Copy-Jobs und anschließend die Ladesteuerung aus:

1. **Copy Job 1:** Lakehouse.`orders` $\rightarrow$ Warehouse.`stg.orders`
2. **Copy Job 2:** Lakehouse.`supply_chain` $\rightarrow$ Warehouse.`stg.supply_chain`
3. **Copy Job 3:** Lakehouse.`production` $\rightarrow$ Warehouse.`stg.production`
4. **Ladesteuerung:** Aufruf von `[meta].[sp_DeineProzedur]` *(hier exakten Namen eintragen)* $\rightarrow$ schreibt Laufzeit und Zeilenzahlen in `meta.ExecutionRun` und `meta.TableLoadLog`.

---

## 3. Stolpersteine & Konfiguration (Copy Jobs)

1. **Zusatzspalte `Source File Name`:** Der Quelldateiname wird als zusätzliche Spalte mit übergeben – bei Schema-Mapping und Zieltabellen in `stg` berücksichtigen.
2. **Händische Pflege pro Copy Job:** Quelle, Ziel und Datenverbindung müssen für jeden Copy Job einzeln konfiguriert werden.
3. **Hardcodierte Quelltabelle:** Quelltabellen sind fest eingetragen (keine Systemvariablen nutzbar) – bei Umbenennungen oder neuen Tabellen den Copy Job direkt anpassen.

## 4. Ladesteuerung & Logging (Pipeline)

Im Anschluss an die Copy Jobs wird die Ladesteuerung in der Pipeline angestoßen und das Tabellen-Logging über `[meta].[sp_LogTableLoad]` ins Warehouse (`ce0a493b-7f62-4c13-bd57-4ea3d7643d6e`) geschrieben.

### Was `[meta].[sp_LogTableLoad]` erledigt

1. **Zentraler Zeitstempel:** Holt `@CurrentTime` über `[util].[sp_GetIngestionTime]` (Fallback für fehlende `@StartTime`/`@EndTime`).
2. **Ingestion-Zeitstempel setzen:** Bei `@Status = 'SUCCESS'` und `@UpdateIngestionColumn = 1` werden Datensätze in `[TargetSchema].[TargetTable]` mit `WHERE [IngestionDateTime] IS NULL` auf `@EndTime` gesetzt.
3. **Zeilenzahl ermitteln:** Ist `@RowsAffected IS NULL` und `@Status = 'SUCCESS'`, zählt die Prozedur per `COUNT_BIG(1)` automatisch die Zeilen in der Zieltabelle.
4. **Dauer & Log-Eintrag:** Berechnet `DurationSeconds` (`DATEDIFF_BIG(MILLISECOND, ...) / 1000.0`) und schreibt den Eintrag in `[meta].[TableLoadLog]` inkl. `CreatedEngineTime`.

### Prüfung nach dem Pipeline-Lauf

```sql
SELECT TOP 20
    l.ExecutionID,
    l.TargetSchema,
    l.TargetTable,
    l.LoadType,
    l.Status,
    l.RowsAffected,
    l.StartTime,
    l.EndTime,
    l.DurationSeconds,
    l.CreatedEngineTime,
    l.ErrorMessage
FROM [meta].[TableLoadLog] l
ORDER BY l.CreatedEngineTime DESC, l.StartTime DESC;
```
