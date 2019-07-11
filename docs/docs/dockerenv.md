# .docker.env file

This is the shared docker configuration file. You can configure things like PHP version, MySQL version, PHP, settings and all you need to fit the project into the docker.

## General 
| PROJECT VARS                      | MEANING                                    | |
|--------------------------|--------------------------------------------|--------------------------------------------------------------------------------------------|
| PROJECT_NAME             | The project base name                      | Needs to be customized                                                                     |
| PROJECT_BASE_PATH        | Base project's path                        | If your project resides in a subdir you can specify it on PROJECT_BASE_PATH                |

## PHP specific
| PHP VARS                      | MEANING                                    | |
|--------------------------|--------------------------------------------|--------------------------------------------------------------------------------------------|
| PHP_MAX_EXECUTION_TIME   | PHP max execution time                     | |
| PHP_POST_MAX_SIZE        | PHP max $_POST size                        | |
| PHP_UPLOAD_MAX_FILESIZE  | PHP max $_POST file size                   | |
| PHP_MEMORY_LIMIT         | PHP apache memory limit (cli is unlimited) | |
| PHP_TAG                  | Sets the php container/version to be used. | For **linux and mac there are two group of possible values**. *"7.1-dev-4.8.0"* format for linux and *"7.2-dev-macos-4.8.0"* for mac.|

## MariaDB/MYSQL specific
The MariaDB default values ( defined in `docker-compose.override.yml` ) are configured for a system with 2 GB RAM available and SSD/NVMe disks. You can comment out these vars to get a default MariaDB configuration.

| MariaDB VARS                      | MEANING                                    | |
|--------------------------|--------------------------------------------|--------------------------------------------------------------------------------------------|
| MYSQL_INNODB_BUFFER_POOL_SIZE    | Size of memory available for data structures of InnoDB, buffers, caches, indexes |               |
| MYSQL_INNODB_IO_CAPACITY         | I/O activity for XtraDB/InnoDB background tasks                            |                             |
| MYSQL_INNODB_LOG_BUFFER_SIZE         | Size in bytes of the buffer for writing InnoDB redo log files to disk  |                              |
| MYSQL_INNODB_LOG_FILE_SIZE         | Size in bytes of each InnoDB redo log file in the log group              |                              |
| MYSQL_INNODB_READ_IO_THREADS         | Number of I/O threads for XtraDB/InnoDB reads                          |                              |
| MYSQL_INNODB_WRITE_IO_THREADS         | Number of I/O threads for XtraDB/InnoDB writes                        |                              |
| MYSQL_OPTIMIZER_SEARCH_DEPTH         | How deep into the execution path the optimizer should look before deciding which plan to use  | |
| MYSQL_QUERY_CACHE_TYPE         | Type of cache for SELECT queries                          |                                                 |
| MYSQL_QUERY_CACHE_SIZE         | Size in bytes available to the query cache              |                                                   |

For the rest of available variables please see  [https://github.com/wodby/docker4drupal](https://github.com/wodby/docker4drupal)

## Modifying variables just for you
Since `.docker.env` is a common shared file you will not be able to make personal modifications on it. For this kind of customizations you should use `.docker.override.env`

`.docker.override.env` should be never committed since it is only for you and your environment. The usage is really simple. Just put in there the variables you want to override with the new value like in the original `.docker.env` file.
