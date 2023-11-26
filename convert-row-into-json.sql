/*
 * SQL Queries for Aggregating Device Data in Logbook
 *
 * These SQL queries are designed to aggregate data from IoT devices and store the summarized information
 * in a logbook table. There are two versions of the query: one for older versions of MySQL and another for newer versions.
 *
 * The queries perform the following actions:
 * - Aggregate device readings from the `logsdata` and `devicedata` tables.
 * - Create a JSON array of device data including model number, battery condition, device reading, RSSI, and log RTC time.
 * - Store the latest log date and current timestamp in the logbook.
 * - Group data by `DeviceID`.
 *
 * Usage:
 *
 * - The first query is for older MySQL versions that do not support the `JSON_ARRAYAGG` function. 
 *   It uses `GROUP_CONCAT` to aggregate JSON objects into a JSON array.
 * - The second query is for newer MySQL versions that support `JSON_ARRAYAGG`, which directly aggregates 
 *   JSON objects into a JSON array.
 * 
 * Example:
 * 
 * -- For Old MySQL Version
 * INSERT INTO logbook (DeviceID, DeviceLog, LogDate, CreateDate) 
 * SELECT ...
 * 
 * -- For New MySQL Version
 * INSERT INTO logbook (DeviceID, DeviceLog, LogDate, CreateDate) 
 * SELECT ...
 *
 * These queries are suitable for applications requiring data aggregation from multiple devices, particularly 
 * in contexts like IoT data management, device monitoring systems, or for logging purposes.
 *
 * Ensure to adjust the table and column names according to your database schema.
 *
 * Author: [Zawadul Kawum]
 * Repository: [https://github.com/zawad1992/mysql_pro_tips]
 * License: [License Type]
 */


/* For Old MySQL version */

INSERT INTO temperaturelog (TagID, TempLog, LogDate, CreateDate)
SELECT 
    tagsdata.TagID, 
    CONCAT('[', GROUP_CONCAT(
        JSON_OBJECT(
            'IMEI', devicedata.IMEI, 
            'BatteryVoltage', tagsdata.BatteryVoltage, 
            'Temperature', tagsdata.Temperature, 
            'Humidity', tagsdata.Humidity, 
            'RSSI', tagsdata.RSSI, 
            'TAGRTCTime', tagsdata.TAGRTCTime
        ) SEPARATOR ','), ']') AS TempLog,
    MAX(devicedata.LogDate) AS LogDate, 
    NOW() AS CreateDate
FROM `tagsdata` 
LEFT JOIN devicedata ON (devicedata.ID = tagsdata.DeviceDataID)
WHERE 
    devicedata.LogDate < CURDATE() AND 
    devicedata.LogDate >  (NOW() - INTERVAL 2 DAY)
GROUP BY tagsdata.TagID
ORDER BY `tagsdata`.TagID ASC;


/* For new MySQL version */

INSERT INTO temperaturelog (TagID, TempLog, LogDate, CreateDate)
SELECT 
    tagsdata.TagID, 
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'IMEI', devicedata.IMEI, 
            'BatteryVoltage', tagsdata.BatteryVoltage, 
            'Temperature', tagsdata.Temperature, 
            'Humidity', tagsdata.Humidity, 
            'RSSI', tagsdata.RSSI, 
            'TAGRTCTime', tagsdata.TAGRTCTime
        )
    ) AS TempLog, 
    MAX(devicedata.LogDate) AS LogDate, 
    NOW() AS CreateDate
FROM `tagsdata` 
LEFT JOIN devicedata ON (devicedata.ID = tagsdata.DeviceDataID)
WHERE 
    devicedata.LogDate < CURDATE() AND 
    devicedata.LogDate >  (NOW() - INTERVAL 2 DAY)
GROUP BY tagsdata.TagID
ORDER BY `tagsdata`.TagID ASC;