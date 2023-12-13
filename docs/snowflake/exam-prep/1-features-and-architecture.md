---
layout: default
title: "Domain 1.0: Data Cloud Features and Architecture"
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

## 1.1 Outline key features of the Snowflake Data Cloud 
Snowflake is a <u>self-managed</u> service. There is no hardware or software to install, configure, or manage.

All components of Snowflake’s service (other than optional command line clients, drivers, and connectors), run in <u>public cloud infrastructures</u>.

Snowflake’s architecture is a <u>hybrid of traditional shared-disk and shared-nothing database architectures</u>. Similar to shared-disk architectures, Snowflake uses a central data repository for persisted data that is accessible from all compute nodes in the platform. But similar to shared-nothing architectures, Snowflake processes queries using <u>MPP (massively parallel processing) compute clusters</u> where each node in the cluster stores a portion of the entire data set locally. This approach offers the data management simplicity of a shared-disk architecture, but with the performance and scale-out benefits of a shared-nothing architecture.

### Elastic storage
When data is loaded into Snowflake, Snowflake reorganizes that data into its internal <u>optimized, compressed, columnar</u> format.

Snowflake manages all aspects of how this data is stored — the organization, file size, structure, compression, metadata, statistics, and other aspects of data storage are handled by Snowflake. The data objects stored by Snowflake are <u>not directly visible nor accessible by customers</u>; they are only accessible through SQL query operations run using Snowflake.

### Elastic compute
Query execution is performed in the <u>processing layer</u>. Snowflake processes queries using “virtual warehouses”. Each virtual warehouse is an MPP compute cluster composed of multiple compute nodes allocated by Snowflake from a cloud provider.

Each virtual warehouse is an independent compute cluster that does not share compute resources with other virtual warehouses. As a result, each virtual warehouse has no impact on the performance of other virtual warehouses.

### Snowflake’s three distinct layers
1. Database Storage [(Elastic storage)](#elastic-storage)
2. Query Processing (Compute) [(Elastic compute)](#elastic-compute)
3. Cloud Services

The cloud services layer is a collection of services that coordinate activities across Snowflake:
- Authentication
- Infrastructure management
- Metadata management
- Query parsing and optimization
- Access control

All three layers of Snowflake’s architecture (storage, compute, and cloud services) are deployed and managed entirely on a selected cloud platform.

### Cloud partner categories
[Snowflake Ecosystem](https://docs.snowflake.com/en/user-guide/ecosystem)

[All Partners & Technologies (Alphabetical)](https://docs.snowflake.com/en/user-guide/ecosystem-all)

1. Data Integration → e.g. Fivetran, Qlik, Matillion, dbt
2. Business Intelligence → e.g. Tableau, Power BI, Looker
3. ML & Data Science → e.g. DataRobot, Alteryx, Dataiku, Databricks
4. Security, Governance & Observability → e.g. Alation, Collibra
5. SQL Development & Management → e.g. DBeaver
6. Native Programming Interfaces → Go, Java, .NET, Node.js, C, PHP, Python

[Snowflake Partner Connect](https://docs.snowflake.com/en/user-guide/ecosystem-partner-connect)

Partner Connect lets you easily create trial accounts with selected Snowflake business partners and integrate these accounts with Snowflake. This feature provides a convenient option for trying various 3rd-party tools and services, and then adopting the ones that best meet your business needs.

Partner Connect is limited to <u>account administrators</u> (i.e. users with the `ACCOUNTADMIN` role) who have a <u>verified email address</u> in Snowflake.

### Overview of Snowflake editions

[Snowflake Editions](https://docs.snowflake.com/en/user-guide/intro-editions)

Comparison of key features in different editions:

| Feature                        | Standard       | Enterprise     | Business Critical  |
|--------------------------------|----------------|----------------|--------------------|
| Time Travel                    | Maximum 1 day  | Maximum 90 days| Maximum 90 days    |
| Multi-Cluster Warehouses       | ❌ No           | ✅ Yes         | ✅ Yes             |
| Materialized Views             | ❌ No           | ✅ Yes         | ✅ Yes             |
| Column Level Security          | ❌ No           | ✅ Yes         | ✅ Yes             |
| Access History                 | ❌ No           | ✅ Yes         | ✅ Yes             |
| Query Acceleration Service     | ❌ No           | ✅ Yes         | ✅ Yes             |
| Search Optimization Service    | ❌ No           | ✅ Yes         | ✅ Yes             |
| Query Statement Encryption     | ❌ No           | ❌ No          | ✅ Yes             |
| Failover/Failback & Replication of objects other than database and share | ❌ No           | ❌ No          | ✅ Yes             |
| Private Link                   | ❌ No           | ❌ No          | ✅ Yes             |
| Tri-Secret Secure Encryption   | ❌ No           | ❌ No          | ✅ Yes             |

### 1.1: Practice Questions

Which of the following terms best describes Snowflake's database architecture?

> A. Columnar shared nothing
>
> B. Cloud-native shared memory
>
> C. <u> Multi-cluster, shared data </u>
>
> D. Shared disk

***

In which layer of Snowflake architecture is stored all security-related information?

> A. <u>Cloud Services</u>
> 
> B. All of the above
>
> C. Compute
>
> D. Storage

***

In which layer of its architecture does Snowflake store its metadata statistics?

> A. Database Layer
> 
> B. <u>Cloud Services Layer</u>
>
> C. Compute Layer
>
> D. Storage Layer

***

What are the main differences between the Virtual Private Snowflake (VPS) and Business Critical Editions? (Select TWO)

> A. <u>Snowflake VPS provides a completely separate Snowflake environment, isolated from all other Snowflake accounts, whereas it's not included in the Business Critical Edition.</u>
>
> B. <u>Snowflake VPS provides a dedicated metadata store and pool of computing resources, whereas it's not included in the Business Critical Edition.</u>
>
> C. Snowflake VPS provides customer-managed encryption keys through Tri-Secret secure, whereas it's not included in the Business Critical Edition.
>
> D. Snowflake VPS provides a direct proxy to virtual networks // on-premises data centers using AWS PrivateLink, whereas it's not included in the Business Critical Edition.

***

You have two virtual warehouses in your Snowflake account. If one of them updates the data in the storage layer, when will the other one see it?

> A. Once all the compute resources are provisioned for the second warehouse.
> 
> B. After an average time of 5 seconds. 
>
> C. <u>Immediately.</u>
>
> D. After the sync process.

***

Which role is required to initiate a trial in Snowflake Partner Connect?

> A. <u>ACCOUNTADMIN</u>
>
> B. SECURITYADMIN
>
> C. SYSADMIN
>
> D. USERADMIN

************************************************************************************

## 1.2 Outline key Snowflake tools and user interfaces
### Snowsight 
↳ the web interface (UI)

### SnowSQL 
↳ CLI client (platform-specific versions)

### Snowflake connectors 
↳ native integrations of third-party applications and database systems

- Kafka connector
- Spark connector

The Snowflake Connector for Spark brings Snowflake into the Apache Spark ecosystem, enabling Spark to read data from, and write data to, Snowflake. From Spark’s perspective, Snowflake looks similar to other Spark data sources (PostgreSQL, HDFS, S3, etc.).

### Snowflake drivers 
↳ write applications that perform operations on Snowflake

- Go
- JDBC (Java Database Connectivity)
- .NET
- Node.js
- ODBC (Open Database Connectivity)
- PHP PDO (PHP Data Objects)
- Python

JDBC & ODBC → APIs that enable software applications to interact with databases (connect to various types of databases, query data, retrieve results) → a bridge between applications and databases 

### Snowpark API 
↳ Java, Python or Scala

The Snowpark library provides an intuitive library for querying and processing data at scale in Snowflake. Using a library for any of three languages, you can build applications that process data in Snowflake without moving data to the system where your application code runs, and process at scale as part of the elastic and serverless Snowflake engine.

### SnowCD (Connectivity Diagnostic Tool) 
↳ helps users to diagnose and troubleshoot their network connection to Snowflake

### Streamlit 
(only AWS commercial regions)

An open-source Python library that makes it easy to create and share custom web apps for machine learning and data science. Build applications that process and use data in Snowflake without moving data or application code to an external system.

### 1.2: Practice Questions

What authentication method does the Kafka connector use within Snowflake?

> A. Multi-Factor Authentication (MFA)
>
> B. OAuth
> 
> C. <u>Key pair authentication</u>
>
> D. Username and password

************************************************************************************

## 1.3 Outline Snowflake’s catalog and objects 
### Databases 
Each database consists of one or more schemas, which are logical groupings of database objects, such as tables and views. Snowflake does not place any hard limits on the number of databases, schemas (within a database), or objects (within a schema) you can create.

### Stages
- External → references data files stored in external location (outside Snowflake)
  - Permanent
  - Temporary → will be dropped at the end of the session in which was created
  - 
- Internal → stores data files internally within Snowflake
  - Named Stage
    - Permanent
    - Temporary → will be dropped at the end of the session in which was created; in case of internal stage also all files are dropped
  - User Stage
  - Table Stage

An internal or external stage can include a **directory table**. Directory tables store a catalog of staged files in cloud storage.

Recreating a stage (using `CREATE OR REPLACE STAGE`) has the following additional, potentially undesirable, outcomes:
- The existing directory table for the stage, if any, is dropped. If the stage is recreated with a directory table, the directory is empty by default.
- The association breaks between the stage and any external table that references it. External tables must be recreated.
- Any pipes that reference the stage stop loading data. The execution status of the pipes changes to `STOPPED_STAGE_DROPPED`. To resume loading data, these pipe objects must be recreated


`GET_STAGE_LOCATION` → retrieve the URL for an external or internal named stage using the stage name as input

`GET_RELATIVE_PATH` → extract the path of a staged file relative to its location in the stage using the stage name and absolute file path in cloud storage as inputs

```sql 
SELECT GET_RELATIVE_PATH(@images_stage, 's3://photos/national_parks/us/yosemite/half_dome.jpg');
-- result: us/yosemite/half_dome.jpg                                                                 
```

`GET_ABSOLUTE_PATH` → extract the absolute path of a staged file using the stage name and path of the file relative to its location in the stage as inputs

``` sql
SELECT GET_ABSOLUTE_PATH(@images_stage, 'us/yosemite/half_dome.jpg');
-- result: s3://photos/national_parks/us/yosemite/half_dome.jpg
```

A directory table is an implicit object layered on a stage (not a separate database object) and is conceptually similar to an external table because it stores file-level metadata about the data files in the stage. A directory table has no grantable privileges of its own.

Syntax for querying a directory table:
`SELECT * FROM DIRECTORY( @<stage_name> )`

The output from a directory table can include the following columns:
- `RELATIVE_PATH` → path to the files
- `SIZE` → size of the file (in bytes)
- `LAST_MODIFIED` → timestamp when the file was last updated in the stage
- `MD5` → MD5 checksum for the file
- `ETAG`
- `FILE_URL`

### Schema types
Schemas can be **transient**. By definition, all tables created in a transient schema are transient. Transient schemas do not have a fail-safe period. 

**Managed access schemas** centralize privilege management with the schema owner.
In regular schemas, the owner of an object (i.e. the role that has the `OWNERSHIP` privilege on the object) can grant further privileges on their objects to other roles. In managed schemas, the schema owner manages all privilege grants, including future grants, on objects in the schema. Object owners retain the `OWNERSHIP` privileges on the objects; however, only the schema owner can manage privilege grants on the objects.

`DATA_RETENTION_TIME_IN_DAYS` parameter:
- Standard edition: 0 or 1 (default: 1)
- Enterprise edition:
  - permanent schemas: 0 - 90 (default: 1, configurable at account level)
  - transient schemas: 0 or 1 (default: 1)

### Table types
- Permanent (default)

- Transient
    
    Persist until explicitly dropped and are available to all users with the appropriate privileges.
    Specifically designed for transitory data that needs to be maintained beyond each session (in contrast to temporary tables).
    After creation, transient tables cannot be converted to any other table type.

- Temporary
    
    ↳ Non-permanent, transitory, session-specific data.
    
    ↳ Exists only within a single user session and only within the duration of the session.
    
    ↳ Not visible to other users or sessions and do not support some standard features (e.g. cloning). 
    
    ↳ Once the session ends, the data is not recoverable.

    ↳ Have no Fail-safe and have a Time Travel retention period of only 0 or 1 day; however, the Time Travel period ends when the table is dropped ⇒ the actual retention period is for 24 hours or the remainder of the session, whichever is shorter.

    ↳ You can create temporary and non-temporary tables with the same name within the same schema. However, note that the temporary table takes precedence in the session over any other table with the same name in the same schema.

- External Tables 
    
    A feature that allows you to query data stored in an external stage as if the data were inside a table in Snowflake. 
    All external tables include the following columns: `VALUE`, `METADATA$FILENAME`, `METADATA$FILE_ROW_NUMBER`. 
    `SELECT *` always returns the `VALUE` column in which all regular or semi-structured data is cast to variant rows.

Recommended file sizing for external tables:

Parquet files: 256 - 512 MB

Parquet row groups: 16 - 256 MB (Snowflake can operate on different row groups using different servers) 

All other supported file formats: 16 - 256 MB

### View types
#### Non-materialized (standard, regular) views 

* A view is basically a named definition of a query.
* A non-materialized view’s results are created by executing the query at the time that the view is referenced in a query. 
* Most commonly used.
* Underlying DDL available to any role with access to the view.

#### Secure views 

* The view definition and details are visible only to authorized users (with the role that owns the view) ⇒ improved data privacy and data sharing. 
* Both non-materialized and materialized views can be defined as secure. 
* Snowflake query optimizer behaves differently when running the SQL contained in a secure view so that it doesn't accidentally reveal things about the underlying data.
* Secure views can be slower than non-secure views, because the optimizer isn't used the same way.

#### Materialized views 

* A materialized view’s results are stored which allows for faster access but requires storage space and active maintenance, both of which incur additional costs. 
* Behave more like a table.
* In Snowflake, these are auto-refreshed.
* Can provide cost savings, but are inflexible and somewhat limited in use.

### Data types

### User-Defined Functions (UDFs)

### User-Defined Table Functions (UDTFs)

### Stored procedures

### Streams

#### Tasks

### Pipes

[Snowpipe](https://docs.snowflake.com/en/user-guide/data-load-snowpipe-intro)
[Managing Snowpipe](https://docs.snowflake.com/en/user-guide/data-load-snowpipe-manage)

Snowpipe enables <u>loading data from files as soon as they’re available in a stage</u>. The data is loaded according to the COPY statement defined in a referenced pipe.

The COPY statement identifies the source location of the data files (i.e., a stage) and a target table. <u>All data types are supported</u>.

Two mechanisms for detecting the staged files:
- Automating Snowpipe using cloud messaging
- Calling Snowpipe REST endpoints

Snowpipe load history is stored in the metadata of the pipe for <u>14 days</u>. Must be requested from Snowflake via a REST endpoint, SQL table function, or ACCOUNT_USAGE view.

<u>When a pipe is recreated, the load history is dropped</u>. In general, this condition only affects users if they subsequently execute an `ALTER PIPE … REFRESH` statement on the pipe. Doing so could load duplicate data from staged files in the storage location for the pipe if the data was already loaded successfully and the files were not deleted subsequently.

Bulk data load is stored in the metadata of the target table for <u>64 days</u>. Available upon completion of the COPY statement as the statement output.

To optimize the number of parallel operations for a load, it is recommended to produce data files roughly <u>100-250 MB (or larger) in size compressed</u> and <u>staging files once per minute</u>. 

If a <u>data loading operation</u> continues beyond the <u>maximum allowed duration of 24 hours</u>, it could be aborted without any portion of the file being committed.

Not all COPY INTO options are available during pipe creation (e.g. `ON_ERROR` or `VALIDATION_MODE` are <u>not</u> available). [See: Usage Notes](https://docs.snowflake.com/en/sql-reference/sql/create-pipe#usage-notes)

Snowflake automatically manages the compute required to execute the Pipe's `COPY INTO` commands.

### Shares

### Sequences

### 1.3: Practice Questions

Which Snowflake table type is only visible to the user who creates it, can have the same name as permanent tables in the same schema, and is dropped at the end of the session?

> A. Transient
>
> B. Local
>
> C. <u>Temporary</u>
>
> D. User

*** 

A role is created and owns 2 tables. This role is then dropped. Who will now own the two tables?

> A. <u>The assumed role that dropped the role</u>
>
> B. SYSADMIN
>
> C. The user that deleted the role
>
> D. The tables are now orphaned

***

When a Pipe is recreated using the CREATE OR REPLACE PIPE command:

> A. Previously loaded files will be ignored.
>
> B. <u>The Pipe load history is reset to empty.</u>
>
> C. Previously loaded files will be purged.
>
> D. The REFRESH parameter is set to TRUE.

***

Which of the following is true of Snowpipe via REST API? (Choose two.)

> A. Snowpipe removes files after they have been loaded.
>
> B. <u>Snowpipe keeps track of which files it has loaded.</u>
>
> C. All COPY INTO options are available during pipe creation.
>
> D. <u>Snowflake automatically manages the compute required to execute the Pipe's COPY INTO commands.</u>
>
> E. You can only use it on Internal Stages.

************************************************************************************

## 1.3 Outline Snowflake storage concepts

### Micro-partitions

### Data clustering 

### Data storage monitoring

### 1.4: Practice Questions
