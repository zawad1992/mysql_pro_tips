/*
 * Query: Retrieve Recent Logs for 'root' User in MySQL
 *
 * This SQL query is designed to fetch recent activity from the MySQL general log, specifically focusing on actions initiated by users with 'root' in their username. It is particularly useful for database administrators who need to audit or review the activities performed by administrative users.

 * Key Features and Usage:
 * - Retrieves the last 14 entries from the general log where the user's host begins with 'root'.
 * - Provides a snapshot of recent administrative activities including command types and arguments.
 * - Useful in monitoring and auditing scenarios, especially for tracking potential administrative changes or interventions.

 * The query selects the following columns:
 * - event_time: Timestamp of the logged event.
 * - user_host: User and host information initiating the event.
 * - thread_id: Identifier for the thread processing the event.
 * - server_id: Identifier for the server on which the event occurred.
 * - command_type: Type of command executed.
 * - argument: Arguments or queries associated with the command.

 * Usage Example:
 * To execute this query, run it in your MySQL database environment. It will return the latest 14 log entries for users with 'root' in their username, helping you monitor recent root-level activities.

 * Note: Ensure that the general log is enabled in your MySQL server to capture the necessary data.

 * Author: [Your Name]
 * Repository: https://github.com/[YourUsername]/mysql_pro_tips
 */

-- SQL Query
SELECT event_time AS time,
       user_host,
       thread_id,
       server_id,
       command_type,
       argument
FROM mysql.general_log
WHERE user_host LIKE 'root%'
ORDER BY event_time DESC
LIMIT 14;
