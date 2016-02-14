# FileLoader

A "loader" that is executed with parameters: path, file_mask

Then connects to the DB (MySQL), looks to given path, reads a tab separated text file, loads file content to DB and moves file to {path}/executed

Rules:

- If there already exists record in DB with given ID, that record is updated with information from file and update_timestamp is set to system current timestamp.
- If new record is detected in file, new record is created in DB with attributes from file and Update_timestamp is set to system current timestamp.
- If any update is detected, record in DB is updated and Update_timestamp is set to system current timestamp.
- If record does not exist in the file, no action is taken.

Files shall contain 3 columns:

```
ID (varchar 32)
Name (varchar 255)
Date (date)
```

Database stores in one table:

```
ID (varchar 32)
Name (varchar 255)
Date (date)
Update_timestamp (timestamp)
```

Usage: 

```
fileloader.pl path file_mask
```

Example:

```
fileloader.pl /var/loader_files headers.tsv
```

----

TODO:

- Improve error handling
- Implement Unit Tests