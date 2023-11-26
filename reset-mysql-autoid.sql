/*
 * Query: Reset and Increment User IDs in the 'users' Table
 *
 * This SQL script is designed to reset and sequentially increment the IDs of all users in the 'users' table. 
 * It's particularly useful for reordering user IDs in a continuous sequence, starting from 1. This can be 
 * beneficial after deleting rows or when you want to reorganize the table for consistency.

 * Key Features and Usage:
 * - Sequentially updates user IDs starting from 1.
 * - Useful for maintaining a contiguous range of IDs, especially after deletion of records.
 * - Helps in keeping the user IDs organized and easily manageable.

 * The script performs the following actions:
 * - Initializes a variable `@count` to zero.
 * - Iteratively updates each row in the `users` table, setting the `id` to the current value of `@count` and then increments `@count`.

 * Usage Example:
 * To execute this script, run it in your MySQL database environment where you have a `users` table. 
 * The script will reset the ID of every user to a new incremental value starting from 1.

 * Caution:
 * - This operation will change the primary key (`id`) for every user. Ensure that there are no foreign key dependencies or other constraints that might cause issues.
 * - It is highly recommended to backup your database before running this script.

 * Author: [Zawadul Kawum]
 * Repository: https://github.com/zawad1992/mysql_pro_tips
 */

-- SQL Script
SET @count = 0;
UPDATE `users` SET `users`.`id` = @count:= @count + 1;
