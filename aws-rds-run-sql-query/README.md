### Features

- Execute a query on the specified RDS server.

Execute a query on the specified RDS server.
-------------

**Script Name:** run-sql-query.sh
**Parameters to the Script:** 4
**Usage:** ../run-sql-query.sh -u rds-user -e rds-end-point -d database-name -q "query-to-be-executed;"
***Where,*** 
```
        -u user-name of the RDS server on which a query has to be executed
        -e end-point of the RDS server on which a query has to be executed
        -d database in the RDS server on which a query has to be executed
        -q query to be executed (in double quotes and semi-colon at the end)
```

**e.g.**
`./run-sql-query.sh -u admin -e database-1.csykuyezi6cx.eu-west-3.rds.amazonaws.com -d information_schema -q "describe COLUMNS;"`

