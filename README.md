
Write a “loader” that is executed with parameters:
path, file_mask

This loader shall connect to DB, look to given path, read a tab separated text file, load file content to DB and move file to {path}/executed

Rules:
If there already exists record in DB with given ID, that record is updated with information from file and Update_timestamp is set to system current timestamp.
If new record is detected in file, new record is created in DB with attributes from file and Update_timestamp is set to system current timestamp.
If any update is detected, record in DB is updated and Update_timestamp is set to system current timestamp.
If record does not exist in the file, no action is taken.

Files shall contain 3 columns:
ID (varchar 32)
Name (varchar 255)
Date (date)

Database stores in one table
ID (varchar 32)
Name (varchar 255)
Date (date)
Update_timestamp (timestamp)

Example:
path = /var/loader_files
file_mask = headers.tsv

DB implementation is up to you and will not be evaluated.

