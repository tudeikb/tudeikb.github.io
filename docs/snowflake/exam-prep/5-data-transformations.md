---
layout: default
title: "Domain 5.0: Data Transformations"
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

## 5.1 Explain how to work with standard data

### Estimation functions 
There are four <u>groups of aggregate functions</u> that deal with estimation.

| Function Group           | Description                                        | Algorithm               | Function Name                                                    |
|--------------------------|----------------------------------------------------|-------------------------|------------------------------------------------------------------|
| Cardinality estimation   | Estimate the number of distinct values             | HyperLogLog             | `HLL()` or `APPROX_COUNT_DISTINCT()` (human-friendly alias) + 5 variations |
| Similarity estimation    | Estimate similarity of two or more sets           | MinHash                 | `APPROXIMATE_SIMILARITY` which takes in two MinHash states as an argument; 0 indicates the sets have no overlap, 1 indicates the sets are identical |
| Frequency estimation     | Estimate frequency of values in a set             | Space-Saving algorithm  | `APPROX_TOP_K()` + 3 variations                                    |
| Percentile estimation    | Estimate percentile of values in a set           | t-Digest algorithm      | `APPROX_PERCENTILE()` + 3 variations                                |

### Sampling
Table sampling is a convenient way to read a random subset of rows from a table. It returns more representative group of rows than `LIMIT`. 

`SAMPLE / TABLESAMPLE` → Returns a <u>subset of rows sampled randomly</u> from the specified table.

`SELECT * FROM LINEITEM TABLESAMPLE | SAMPLE [samplingMethod] (<probability>);`

Two methods (ways) of determining how sample records are generated:

- **Fraction-based**: Sample a fraction of a table, with a specified probability for including a given row. The number of rows returned depends on the size of the table and the requested probability. 

  `SELECT * FROM LINEITEM TABLESAMPLE | SAMPLE BERNOULLI | ROW (50)` → includes probability percentage that an individual row will be present in the result.

  `SELECT * FROM LINEITEM TABLESAMPLE | SAMPLE SYSTEM | BLOCK (50)` → instead of applying the probability to single rows, it is applied to groups of rows.

  A seed can be specified to make the sampling deterministic.

  `SELECT * FROM LINEITEM TABLESAMPLE | SAMPLE (50) REPEATABLE | SEED (12345)`

- **Fixed-sized**: Sample a fixed, specified number of rows. The exact number of specified rows is returned unless the table contains fewer rows. 

  `SELECT * FROM LINEITEM TABLESAMPLE | SAMPLE BERNOULLI | ROW (50 rows)`

  The block size method and seed setting are not supported.

### Supported function types
* Scalar functions → return one value per invocation (call). Typically used for returning one value per row. 
* Aggregate functions → operate on values across rows, typically to perform mathematical calculations such as sum, average and counting. Also cover many statistical calculations. 
* Window functions → subset of aggregate functions, allowing to aggregate on a subset of rows (a window) used as input to a function. 
* Table functions → for each input row, a table function can output zero, one or multiple rows. 
* System functions → provide a way to execute actions in the system, provide information about the system  or provide information about queries.  
* User-defined functions
* External functions

#### System functions
Snowflake provides the following types of system functions:
* Control functions that allow you to execute actions in the system (e.g. aborting a query).
* Information functions that return information about the system (e.g. calculating the clustering depth of a table).
* Information functions that return information about queries (e.g. information about EXPLAIN plans).

#### Table functions

#### External functions
An external function has two key properties: an API integration (account level Snowflake object) and a URL for the proxy service. 

External functions can be written in any language as long as they return a type which Snowflake can understand. 

We execute external functions just like UDFs, inside a select statement. 

#### User-Defined Functions (UDFs)
You can write user-defined functions (UDFs) to extend the system to perform operations that are not available through the built-in system-defined functions provided by Snowflake. 

Supported languages:
- Java
- JavaScript
- Python
- Scala
- SQL

Overloading → you can have two functions of the same name as long as they accept a different number of arguments. 

### Stored procedures
Both UDFs and stored procedures overlap a lot in functionality. Typically, stored procedures are rather used for more administrative tasks.

The creator can specify whether the procedure executes with the privileges of the owner or the caller $$\Rightarrow$$ the owner can delegate certain tasks to other roles without giving them explicit privileges. 

It is not required to return anything from stored procedures.

### Streams
A stream is an object created to view & track DML changes to a source table (Change Data Capture).

When queried, stream has the same structure as the underlying table + 3 additional columns: `METADATA$ACTION` (insert or delete), `METADATA$ISUPDATE` (true or false - indicates whether the operation in the action column was a part of an update statement) and `METADATA$ROW_ID` (unique row identifier - we can track changes to a specific row over time).

Note that a <u>stream itself does not contain any table data</u>. A stream only stores an offset for the source object and returns CDC records by leveraging the versioning history for the source object. 

When the first stream for a table is created, several <u>hidden columns are added to the source table</u> and begin storing change tracking metadata. These columns consume a small amount of storage. The CDC records returned when querying a stream rely on a <u>combination of the offset stored in the stream and the change tracking metadata</u> stored in the table.

Types of streams:
- Standard (delta): tables, directory tables, views. Tracks all DML changes (inserts, updates, deletes including truncates).
- Append-only: tables, directory tables, views. Tracks inserts only. 
- Insert-only: external tables. Tracks inserts only (overwritten or appended files are essentially handled as new files).

### Tasks
A task is an object used to schedule the execution of a SQL statement, a stored procedure or procedural logic using Snowflake Scripting. 

To create a task, the `ACCOUNTADMIN` role or a role with `CREATE TASK` privilege is required. 

To start a task, the `ACCOUNTADMIN` role or a role with `EXECUTE TASK` privilege is required + the ownership or `OPERATE` privilege on the task object.

A DAG can be composed of a <u>maximum of 1000 tasks</u> and <u>one task can be linked to a maximum of 100 other tasks</u>.

All tasks in a DAG must have the same owner and they must exist in the same database and schema. 

## 5.1: Practice Questions
Which stream type can be used for tracking the records in external tables?

> A. Standard
>
> B. Append-only
>
> C. External
> 
> D. <u>Insert only</u>

************************************************************************************

## 5.2 Explain how to work with semi-structured data

### Supported data formats, data types, and sizes

### VARIANT column

### Flattening the nested structure

#### FLATTEN command

#### LATERAL FLATTEN command

### Semi-structured data functions

#### ARRAY/OBJECT creation and manipulation

#### Extracting values

#### Type predicates

## 5.2: Practice Questions

************************************************************************************

## 5.3 Explain how to work with unstructured data
### Define and use directory tables

### SQL file functions. Types of URLs available to access files.
Both external (external cloud storage) and internal (i.e. Snowflake) stages support unstructured data. 

Scoped URL → Encoded URL that permits temporary access to a staged file without granting privileges to the stage. The URL expires when the persisted query result period ends (i.e. the results cache expires), which is currently 24 hours.
Generate: query the BUILD_SCOPED_FILE_URL function

File URL → URL that identifies the database, schema, stage, and file path to a set of files. A role that has sufficient privileges on the stage can access the files.
Generate: query the BUILD_STAGE_FILE_URL function or query the directory table for the stage that references the staged files
Pre-signed URL → Simple HTTPS URL used to access a file via a web browser. A file is temporarily accessible to users via this URL using a pre-signed access token. The expiration time for the access token is configurable.
Generate: Query the GET_PRESIGNED_URL function.

### Outline the purpose of User-Defined Functions (UDFs) for data analysis

### 5.3: Practice Questions
A table needs to be loaded. The input data is in a JSON format and is a concatenation of multiple JSON documents. The file size is 3 GB. A virtual warehouse size Small is being used. The following COPY INTO command was executed:

COPY INTO SAMPLE FROM @~SAMPLE.JSON (TYPE=JSON)

The load failed with this error:

Max LOB size (16777216) exceeded, actual size of parsed column is 17894470.

How can this issue be resolved?

> A. Use a larger-sized warehouse.
> 
> B. Compress the file and load the compressed file.
> 
> C. Set STRIP_OUTER_ARRAY=TRUE in the COPY INTO command.
> 
> D. <u>Split the file into multiple files in the recommended size range (100 MB - 250 MB).</u>

***

Which file functions are non-deterministic? (Select TWO)

> A. <u>BUILD_SCOPED_FILE_URL</u>
>
> B. BUILD_STAGE_FILE_URL
>
> C. GET_ABSOLUTE_PATH
> 
> D. <u>GET_PRESIGNED_URL</u>
>
> E. GET_RELATIVE_PATH
