/*
 * Script: Generate SQL Statements to Convert Tables from MyISAM to InnoDB
 *
 * This script generates a series of ALTER TABLE statements to convert tables from the MyISAM engine to the InnoDB engine in a specified database. This is particularly useful for databases that were initially created with the MyISAM engine and need to be converted to InnoDB for its advantages like transaction support, row-level locking, and crash recovery.

 * Key Features:
 * - Automatically generates ALTER TABLE statements for all MyISAM tables in a given database.
 * - Facilitates the migration from MyISAM to InnoDB engine.
 * - Helps in optimizing database performance and integrity.

 * Usage Instructions:
 * 1. Set the `@DATABASE_NAME` variable to the name of your database.
 * 2. Run this script in your MySQL environment.
 * 3. The script will output ALTER TABLE statements for each MyISAM table in the specified database.
 * 4. Copy and execute these statements to convert the tables to InnoDB.

 * Example:
 * ```sql
 * SET @DATABASE_NAME = 'your_database_name';
 * SELECT  CONCAT('ALTER TABLE `', table_name, '` ENGINE=InnoDB;') AS sql_statements ...
 * ```
 * After running the above, copy the output SQL statements and execute them to alter the engine of the tables.

 * Important Notes:
 * - Ensure that your application is compatible with InnoDB features and transactional requirements.
 * - It's advisable to perform this operation during a maintenance window as it might lock the tables being altered.
 * - Always back up your database before performing such operations.

 * Author: [Your Name]
 * Repository: https://github.com/[YourUsername]/mysql_pro_tips
 */

-- SQL Script to Generate ALTER TABLE Statements
SET @DATABASE_NAME = 'your_table';

SELECT  CONCAT('ALTER TABLE `', table_name, '` ENGINE=InnoDB;') AS sql_statements
FROM    information_schema.tables AS tb
WHERE   table_schema = @DATABASE_NAME
AND     `ENGINE` = 'MyISAM'
AND     `TABLE_TYPE` = 'BASE TABLE'
ORDER BY table_name DESC;

-- Then, copy the output and run as a new SQL query.
