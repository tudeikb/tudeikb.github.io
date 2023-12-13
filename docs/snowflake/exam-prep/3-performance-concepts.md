---
layout: default
title: "Domain 3.0: Performance Concepts"
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

## 3.1 Explain the use of the Query Profile.
[Analyzing Queries Using Query Profile](https://docs.snowflake.com/en/user-guide/ui-query-profile)

Query Profile, available through the classic web interface, provides execution details for a query. For the selected query, it provides a <u>graphical representation of the main components of the processing plan for the query, with statistics for each component, along with details and statistics for the overall query</u>.

Query profile interface elements:
* **Steps**: If the query was processed in multiple steps, you can toggle between each step.
* **Operator tree**: The middle pane displays a graphical representation of all the operator nodes for the selected step, including the relationships between each operator node.
* **Node list**: The middle pane includes a collapsible list of operator nodes by execution time.
* **Overview**: The right pane displays an overview of the query profile. The display changes to operator details when an operator node is selected.

### Explain plans
[EXPLAIN](https://docs.snowflake.com/en/sql-reference/sql/explain)

Returns the <u>logical execution plan</u> for the specified SQL statement. An explain plan shows the operations (for example, table scans and joins) that Snowflake would perform to execute the query.

`EXPLAIN` <u>compiles the SQL statement, but does not execute it</u>, so it <u>does not require a running warehouse</u>.

Although `EXPLAIN` does not consume any compute credits, the compilation of the query does <u>consume Cloud Service credits</u>, just as other metadata operations do.

To post-process the output of this command, you can:
* Use the `RESULT_SCAN` function, which treats the output as a table that can be queried.
* Generate the output in JSON format and insert the JSON-formatted output into a table for analysis later. If you store the output in JSON format, you can use the function `SYSTEM$EXPLAIN_JSON_TO_TEXT` or `EXPLAIN_JSON` to convert the JSON to a more human readable format (either tabular or formatted text).

### Data spilling

[Performance impact from local and remote disk spilling](https://community.snowflake.com/s/article/Performance-impact-from-local-and-remote-disk-spilling)

When Snowflake warehouse <u>cannot fit an operation in memory<u>, it starts <u>spilling (storing) data</u> first to the <u>local disk of a warehouse node</u>, and then to <u>remote cloud-provider storage</u>.

Snowflake first tries to temporarily store the data on the warehouse local disk. As this means extra IO operations, any query that requires spilling will take longer than a similar query running on similar data that is capable to fit the operations in memory.

Also, if the local disk is not sufficient to fit the spilled data, Snowflake further tries to write to the remote cloud storage, which will be shown in the query profile as "Bytes spilled to remote storage".

A query spilling bytes to the remote storage will notice even further performance degradation.

The spilling can't always be avoided, especially for large batches of data, but it can be decreased by:
- Reviewing the query for query optimization especially if it is a new query
- Reducing the amount of data processed. For example, by trying to improve partition pruning, or projecting only the columns that are needed in the output.
- Decreasing the number of parallel queries running in the warehouse ($$\Rightarrow$$ reduced memory consumption per query, potentially more CPU cycles available and other system resources)
- Trying to split the processing into several steps (for example by replacing the CTEs with temporary tables).
- Using a larger warehouse - this effectively means more memory and more local disk space.

[Resolving Memory Spillage](https://docs.snowflake.com/en/user-guide/performance-query-warehouse-memory)

When memory spillage is the issue, you can <u>convert your existing warehouse to a Snowpark-optimized warehouse</u>, which provides <u>16x more memory per node and 10x the local cache</u> compared to a standard warehouse. Though a larger warehouse also has more memory available, a query might not require its expanded compute resources.

When a query requires <u>additional memory without additional compute</u>, it is <u>more cost effective to switch to a Snowpark-optimized warehouse</u> rather than increasing the size of the warehouse.

### Use of the data cache

[Caching in Snowflake](https://thinketl.com/caching-in-snowflake/#:~:text=merely%20few%20milliseconds.-,4.,without%20reading%20the%20table%20data.)

There are three types of Cache in Snowflake which improve the query performance:

- Query Result Cache
- Metadata Cache
- Virtual Warehouse Cache (or) Local Disk Cache

All these cache are <u>enabled by default</u> in your Snowflake environment.

The <u>Metadata cache and the Query Result cache are part of the Cloud Services Layer</u> $$\Rightarrow$$ they are <u>available to all virtual warehouses</u>.

The <u>Virtual Warehouse cache is part of the Query Processing Layer</u> and hence it is <u>local to each virtual warehouse</u>.

Since Metadata cache and the Query Result cache are part of the Cloud Services Layer, they can run without the need of an active virtual warehouse.

### Micro-partition pruning
All data in Snowflake tables is <u>automatically divided into micro-partitions</u>, which are <u>contiguous units of storage</u>. Each micro-partition contains <u>between 50 MB and 500 MB of uncompressed data</u> (note that the actual size in Snowflake is smaller because data is always stored compressed). Groups of rows in tables are mapped into individual micro-partitions, <u>organized in a columnar fashion</u>. This size and structure allows for <u>extremely granular pruning of very large tables</u>, which can be comprised of millions, or even hundreds of millions, of micro-partitions.

The micro-partition metadata maintained by Snowflake enables precise pruning of columns in micro-partitions at query run-time, including columns containing semi-structured data. In other words, a query that specifies a filter predicate on a range of values that accesses 10% of the values in the range should ideally only scan 10% of the micro-partitions.

The closer the ratio of scanned micro-partitions and columnar data is to the ratio of actual data selected, the more efficient is the pruning performed on the table.

### Query history
The History tab page allows you to view and drill into the details of all queries executed in the <u>last 14 days</u>. The page displays a historical listing of queries, including queries executed from SnowSQL or other SQL clients. 

The History page columns are derived from the `QUERY_HISTORY` view. 

The `QUERY_HISTORY` family of table functions can be used to query Snowflake query history along various dimensions:

* `QUERY_HISTORY` returns queries within a specified time range.
* `QUERY_HISTORY_BY_SESSION` returns queries within a specified session and time range.
* `QUERY_HISTORY_BY_USER` returns queries submitted by a specified user within a specified time range.
* `QUERY_HISTORY_BY_WAREHOUSE` returns queries executed by a specified warehouse within a specified time range.

Each function is optimized for querying along the specified dimension.

<u>These functions return query activity within the last 7 days</u>.

The Account Usage `QUERY_HISTORY` view can be used to query Snowflake query history by various dimensions (time range, session, user, warehouse, etc.) within the <u>last 365 days (1 year)</u>.

### 3.1: Practice Questions

A Snowflake query took 40 minutes to run. The results indicate that ‘Bytes spilled to local storage’ was a large number.

What is the issue and how can it be resolved?

> A. The warehouse is too large. Decrease the size of the warehouse to reduce the spillage. 
> 
> B. The Snowflake console has timed-out. Contact Snowflake Support.
>
> C. <u>The warehouse is too small. Increase the size of warehouse to reduce the spillage.</u>
>
> D. The warehouse consists of a single cluster. Use a multi-cluster warehouse to reduce the spillage.

***

What does a Query Profile provide in Snowflake?

> A. A collapsible panel in the operator tree pane that lists nodes by execution time in descending order for a query. 
>
> B. A multi-step query that displays each processing step in the same panel.
> 
> C. <u>A graphical representation of the main components of the processing plan for a query.</u>
>
> D. A pre-computed data set derived from a query specification and stored for later use.

***

What are common issues found by using the Query Profile? (Choose two.)

> A. Identifying logical issues with the queries
>
> B. <u>Data spilling to a local or remote disk</u>
> 
> C. Locating queries that consume a high amount of credits
>
> D. Identifying queries that will likely run very slowly before executing them
> 
> E. <u>Identifying inefficient micro-partition pruning</u>

***

What aspect of an executed query is represented by the remote disk I/O statistic of the Query Profile in Snowflake?

> A. Time spent caching the data to remote storage in order to buffer the data being extracted and exported.
> 
> B. Time spent reading and writing data from and to remote storage when the data being accessed does not fit into the executing virtual warehouse node memory.
>
> C. <u>Time spent reading and writing data from and to remote storage when the data being accessed does not fit into either the virtual warehouse memory or the local disk.</u>
>
> D. Time spent scanning the table partitions to filter data based on the predicate.

***

Which statements describe features of Snowflake data caching? (Select TWO)

> A. A user can only access their own queries from the query result cache.
>
> B. <u>When the data cache is full, the least-recently used data will be cleared to make room.</u> 
>
> C. A user must set USE_METADATA_CACHE to TRUE to use the metadata cache in queries. 
>
> <u>D. The RESULT_SCAN table function can access and filter the contents of the query result cache.</u>
>
> E. When a virtual warehouse is suspended, the data cache is saved on the remote storage layer.

***

When is the result set cache no longer available? (Choose two.)

> A. When another warehouse is used to execute the query.
>
> B. When another user executes the query.
>
> C. <u>When the underlying data has changed.</u>
>
> D. When the warehouse used to execute the query is suspended.
>
> E. <u>When it has been 24 hours since the last query.</u>

***

Query results are stored in the Result Cache for how long after they are last accessed, assuming no data changes have occurred?

> A. 3 hours
>
> B. 12 hours
>
> C. 1 hour
> 
> D. <u>24 hours</u>

***

A deterministic query is run at 8am, takes 5 minutes, and the results are cached. Which of the following statements are true? (Choose two.)

> A. <u> The same exact query will return the precomputed results if the underlying data hasn't changed and the results were last accessed within previous 24 hour period</u>
>
> B. The same exact query will return the precomputed results even if the underlying data has changed as long as the results were last accessed within the previous 24 hour period
>
> C. Snowflake edition is Enterprise or higher
> 
> D. <u>The 24 hours timer on the precomputed results gets renewed every time the exact query is executed.</u>
>
> E. The exact query will ALWAYS return the precomputed result set for the RESULT_CACHE_ACTIVE = time_period

***

What actions will prevent leveraging of the ResultSet cache?

> A. <u>Removing a column from the query SELECT list.</u>
>
> B. Executing the RESULTS_SCAN() table function.
>
> C. Stopping the virtual warehouse that the query is running against.
>
> D. If the result has not been reused within the last 12 hours.

***

How does Snowflake store a table's underlying data? (Choose two.)

> A. <u>Micro-partitions</u>
>
> B. Text file format
>
> C. Uncompressed
>
> D. <u>Columnar file format</u>
>
> E. User-defined partitions

***

How is table data compressed in Snowflake?

> A. Each micro-partition is compressed as it is written into cloud storage using GZIP. 
>
> B. The text data in a micro-partition is compressed with GZIP but other types are not compressed. 
>
> C. <u>Each column is compressed as it is stored in a micro-partition.</u>
>
> D. The micro-partitions are stored in compressed cloud storage and the cloud storage handles compression.

***

The Query History in the Snowflake Web Interface (UI) is kept for approximately:
 
> A. 1 year
>
> B. <u>14 days</u>
> 
> C. 30 days
> 
> D. 60 minutes
>
> E. 24 hours

************************************************************************************

## 3.2 Explain virtual warehouse configurations

### Types of warehouses
Warehouses are required for queries, as well as all DML operations, including loading data into tables. In addition to being defined by its type as either <u>Standard</u> or <u>Snowpark-optimized</u>, a warehouse is defined by its size, as well as the other properties that can be set to help control and automate warehouse activity.

Warehouses can be <u>started and stopped at any time</u>. They can also be <u>resized at any time, even while running</u>, to accommodate the need for more or less compute resources.

### Multi-cluster warehouses

Multi-cluster warehouses are designed specifically for handling <u>queuing and performance</u> issues related to <u>large numbers of concurrent users and/or queries</u>. In addition, multi-cluster warehouses can help automate this process if your number of users/queries tend to fluctuate.

They are **<u>not</u>** as beneficial for improving the performance of slow-running queries or data loading. For these types of operations, resizing the warehouse provides more benefits.

For a multi-cluster warehouse, the <u>number of credits billed</u> is calculated based on the <u>warehouse size</u> and the <u>number of clusters</u> that run within the time period.

_For example, if a 3X-Large multi-cluster warehouse runs 1 cluster for one full hour and then runs 2 clusters for the next full hour, the total number of credits billed would be 192 (i.e. 64 + 128)._

#### Scaling policies

| Policy | Description | Warehouse Starts... | Warehouse Shuts Down... |
|----|----|----|----|
| Standard (default) | **<u>Prevents/minimizes queuing</u>** by favoring starting additional clusters over conserving credits. | The <u>first cluster starts immediately when either a query is queued</u> or the system detects that there’s one more query than the currently-running clusters can execute. <u>Each successive cluster waits to start 20 seconds</u> after the prior one has started. For example, if your warehouse is configured with 10 max clusters, it can take a full 200+ seconds to start all 10 clusters. | After <u>2 to 3 consecutive successful checks</u> (performed at <u>1-minute intervals</u>), which determine whether the load on the least-loaded cluster could be redistributed to the other clusters without spinning up the cluster again. |
| Economy | **<u>Conserves credits</u>** by favoring keeping running clusters fully-loaded rather than starting additional clusters, which may result in queries being queued and taking longer to complete. | Only if the <u>system estimates there’s enough query load to keep the cluster busy for at least 6 minutes</u>. | After <u>5 to 6 consecutive successful checks</u> (performed at <u>1-minute intervals</u>), which determine whether the load on the least-loaded cluster could be redistributed to the other clusters without spinning up the cluster again. |

#### Scaling modes
You can choose to run a multi-cluster warehouse in either of the following modes:

**Maximized**
This mode is enabled by specifying the <u>same value for both maximum and minimum number of clusters</u> (note that the specified value must be <u>larger than 1</u>). In this mode, when the warehouse is started, Snowflake starts all the clusters so that maximum resources are available while the warehouse is running.

This mode is effective for statically controlling the available compute resources, particularly if you have large numbers of concurrent user sessions and/or queries and the numbers do not fluctuate significantly.

**Auto-scale**
This mode is enabled by specifying <u>different values for maximum and minimum number of clusters</u>. In this mode, Snowflake starts and stops clusters as needed to dynamically manage the load on the warehouse:

* As the number of concurrent user sessions and/or queries for the warehouse increases, and queries start to queue due to insufficient resources, Snowflake automatically starts additional clusters, up to the maximum number defined for the warehouse.
* Similarly, as the load on the warehouse decreases, Snowflake automatically shuts down clusters to reduce the number of running clusters and, correspondingly, the number of credits used by the warehouse.

To help control the usage of credits in Auto-scale mode, Snowflake provides a property, `SCALING_POLICY`, that determines the scaling policy to use when automatically starting or shutting down additional clusters.

### Warehouse sizing
<u>Size specifies the amount of compute resources available per cluster</u> in a warehouse.

Default size:
- for warehouses created in <u>Snowsight</u> and using <u>CREATE WAREHOUSE</u> is <u>XS</u>
- for warehouses created using the <u>Classic Console</u> is <u>XL</u>

| warehouse size | number of nodes | cost (credits per hour) | cost (credits per second) |
|----------------|-----------------|------|---------|
| XS             | 1               | 1    | 0.0003  |
| S              | 2               | 2    | 0.0006  | 
| M              | 4               | 4    | 0.0011  |
| L              | 8               | 8    | 0.0022  |
| XL             | 16              | 16   | 0.0044  |
| 2XL            | 32              | 32   | 0.0089  |
| 3XL            | 64              | 64   | 0.0178  |
| 4XL            | 128             | 128  | 0.0356  |
| 5XL            | 256             | 256  | 0.0711  |
| 6XL            | 512             | 512  | 0.1422  |

### Warehouse settings and access

### 3.2: Practice Questions

A user has a multi-cluster virtual warehouse with the standard scaling policy. There is a single large cluster running, and a query comes in that gets queued. What will happen next?

> A. Snowflake will immediately scale the cluster up to an extra-large cluster and run the query that was queued. 
>
> B. Snowflake will immedately start another large cluster and run the query on it, regardless of how long the current cluster will be busy. 
>
> C. Snowflake will start another large cluster and run the query on it only if the existing cluster will stay busy for 6 minutes or more.
>
> D. Nothing will happen until the query has been queued for at least 6 minutes, at which point Snowflake will start another large cluster. 

***

Which statement accurately describes how a virtual warehouse functions?
 
> A. <u>Each virtual warehouse is a compute cluster composed of multiple compute nodes allocated by Snowflake from a cloud provider.</u>
> 
> B. Each virtual warehouse is an independent compute cluster that shares compute resources with other warehouses.
> 
> C. All virtual warehouses share the same compute resources so performance degradation of one warehouse can significantly affect all the other warehouses.
> 
> D. Increasing the size of a virtual warehouse will always improve data loading performance.

***

Why would a customer size a Virtual Warehouse from an X-Small to a Medium?

> A. To accomodate fluctuations in workload 
> 
> B. To accomodate more queries
>
> C. <u>To accomodate a more complex workload</u>
>
> D. To accomodate more users

***

A Virtual Warehouse's auto-suspend and auto-resume settings apply to:

> A. <u>The entire Virtual Warehouse</u>
> 
> B. The database the Virtual Warehouse resides in
>
> C. The primary cluster in the Virtual Warehouse
> 
> D. The queries currently being run by the Virtual Warehouse

***

When should you consider disabling auto-suspend for a Virtual Warehouse? (Choose two.)

> A. <u>When the compute must be available with no delay or lag time</u>
> 
> B. When you do not want to have to manually turn on the Warehouse each time a user needs it
>
> C. When users will be using compute at different times throughout a 24/7 period
>
> D. When you want to avoid queuing and handle concurrency
>
> E. <u>When managing a steady workflow</u>

***

To run a Multi-Cluster Warehouse in auto-scale mode, a user would:

> A. Configure the Maximum Clusters to Auto-Scale
> 
> B. Set the Warehouse type to Auto
>
> C. Set the Minimum Clusters and Maximum Clusters setting to the same value
>
> D. <u>Set the Minimum Clusters and Maximum Clusters settings to be different values</u>

***

How should a virtual warehouse be configured if a user wants to ensure that additional multi-clusters are resumed with the shortest delay possible?
 
> A. Set the minimum and maximum clusters to autoscale
> 
> B. Use the economy warehouse scaling policy
> 
> C. Configure the warehouse to a size larger than generally required
>
> D. <u>Use the standard warehouse scaling policy</u>

***

************************************************************************************

## 3.3 Outline virtual warehouse performance tools

[Optimizing Warehouses for Performance](https://docs.snowflake.com/user-guide/performance-query-warehouse)

#### Reduce queues 
[Reducing Queues](https://docs.snowflake.com/user-guide/performance-query-warehouse-queue)

Minimize queuing can improve performance because the time between submitting a query and getting its results is longer when the query must wait in a queue before starting.

To determine if a particular warehouse is experiencing queues: Snowsight > Admin > Warehouses > Warehouse Activity > Queued load.

Options to stop warehouse queuing:
* For a regular warehouse (i.e. not a multi-cluster warehouse), consider creating additional warehouses, and then distribute the queries among them. If specific queries are causing usage spikes, focus on moving those queries.
* Consider converting a warehouse to a multi-cluster warehouse so the warehouse can elastically provision additional compute resources when demand spikes. 
* If you are already using a multi-cluster warehouse, increase the maximum number of clusters.

#### Resolve memory spillage
[Resolving Memory Spillage](https://docs.snowflake.com/en/user-guide/performance-query-warehouse-memory)

Adjusting the available memory of a warehouse can improve performance because a query runs substantially slower when a warehouse runs out of memory, which results in bytes “spilling” onto storage.

#### Increase warehouse size
The larger a warehouse, the more compute resources are available to execute a query or set of queries.

Using a larger warehouse has the biggest impact on larger, more complex queries, and may not improve the performance of small, basic queries.

#### Try query acceleration
[Using the Query Acceleration Service](https://docs.snowflake.com/user-guide/query-acceleration-service)
[Trying Query Acceleration](https://docs.snowflake.com/user-guide/performance-query-warehouse-qas)

The query acceleration service <u>offloads portions of query processing to serverless compute resources</u>, which speeds up the processing of a query while reducing its demand on the warehouse’s compute resources.

#### Optimize the warehouse cache
[Optimizing the Warehouse Cache](https://docs.snowflake.com/user-guide/performance-query-warehouse-cache)

A running warehouse maintains a cache of table data that can be accessed by queries running on the same warehouse. Query performance improves if a query can read from the warehouse’s cache instead of from tables.

The auto-suspension setting of the warehouse can have a direct impact on query performance because the cache is dropped when the warehouse is suspended. If a warehouse is running frequent and similar queries, it might not make sense to suspend the warehouse in between queries because the cache might be dropped before the next query is executed.

#### Limit concurrently running queries
[Limiting Concurrently Running Queries](https://docs.snowflake.com/user-guide/performance-query-warehouse-max-concurrency)

Limiting the number of queries that are running concurrently in a warehouse can improve performance because there are fewer queries putting demands on the warehouse’s resources.

You can use the `MAX_CONCURRENCY_LEVEL` parameter to limit the number of concurrent queries running in a warehouse.

Lowering the concurrency level may boost performance for individual queries, especially large, complex, or multi-statement queries, but these adjustments should be thoroughly tested to ensure they have the desired effect.

Be aware that lowering the `MAX_CONCURRENCY_LEVEL` for a warehouse can lead to more queries being placed in a queue.

The <u>default maximum concurrency level is 8</u>.

Adjusting the `STATEMENT_QUEUED_TIMEOUT_IN_SECONDS` parameter can cancel queries rather than let them remain in the queue for an extended period of time.

### Monitoring warehouse loads

<u>Warehouse contention</u> refers to a situation where multiple queries or tasks are competing for resources within the same virtual warehouse, leading to decreased performance and longer processing times. 

Contention occurs when multiple queries or jobs are executed simultaneously in the same warehouse, and these queries collectively demand more resources than the warehouse can provide. This leads to a queue forming, where some queries must wait for others to complete before they can access the necessary resources.

The primary effects of warehouse contention are increased query runtimes and potential timeouts. 

Important parameters: 
- `STATEMENT_QUEUED_TIMEOUT_IN_SECONDS` → Amount of time, in seconds, a SQL statement remains queued for a warehouse before it is canceled by the system. 
- `MAX_CONCURRENCY_LEVEL` → In general, it limits the number of statements that can be executed concurrently by a warehouse cluster. When the limit is reached, statements are queued or additional resources provided. `MAX_CONCURRENCY_LEVEL` can be used in conjunction with the `STATEMENT_QUEUED_TIMEOUT_IN_SECONDS` parameter to ensure a warehouse is never backlogged (experiencing a buildup of queries or tasks waiting to be executed). 
- `STATEMENT_TIMEOUT_IN_SECONDS` → Amount of time, in seconds, after which a running SQL statement is canceled by the system.

### Scaling up compared to scaling out

Examples:
- Accomodate fluctuations in workload $$\Rightarrow$$ concurrency $$\Rightarrow$$ scale out (multi-cluster warehouse)
- Accomodate more queries $$\Rightarrow$$ concurrency $$\Rightarrow$$ scale out (multi-cluster warehouse)
- Accomodate a more complex workload $$\Rightarrow$$ scale up (resize warehouse)
- Accomodate more users $$\Rightarrow$$ concurrency $$\Rightarrow$$ scale out (multi-cluster warehouse)

### Resource monitors
[Working with Resource Monitors](https://docs.snowflake.com/en/user-guide/resource-monitors)

A resource monitor can be used to <u>monitor credit usage</u> by virtual warehouses and the cloud services needed to support those warehouses. If desired, the warehouse can be suspended when it reaches a credit limit.

Limits can be set for a <u>specified interval or date range</u>.

Resource monitors can <u>only be created by account administrators</u> (i.e. users with the `ACCOUNTADMIN` role); however, account administrators can choose to enable users with other roles to view and modify resource monitors using SQL.

<u>Credit quota</u> specifies the number of Snowflake credits allocated to the monitor for the specified frequency interval. Any number can be specified.

Credit quota accounts for credits consumed by both user-managed virtual warehouses and virtual warehouses used by cloud services.

<u>Monitor Level</u> specifies whether the resource monitor is used to monitor the credit usage for your entire Account (i.e. all warehouses in the account) or a specific set of individual warehouses.

If this property is not set, the resource monitor doesn’t monitor any credit usage. It simply remains dormant.

**Actions (triggers)**

↳ each action specifies a <u>threshold, as a percentage of the credit quota</u> for the resource monitor, and the <u>action to perform when the threshold is reached</u> within the specified interval. Note that actions support thresholds greater than 100.

* Notify & Suspend (waits until all statements being executed by the warehouse(s) are completed)
* Notify & Suspend Immediately
* Notify 

Each resource monitor can have the following actions:
* One Suspend action.
* One Suspend Immediate action.
* Up to five Notify actions.

### Query acceleration service
[Query Acceleration Service in Snowflake](https://thinketl.com/query-acceleration-service-in-snowflake/)

When a warehouse has <u>outlier queries</u> (i.e. queries that use more resources than a typical query), the query acceleration service might also improve the performance of the warehouse’s other queries because the <u>extra computing demands of the outlier queries are offloaded to serverless compute resources</u>.

Examples of workloads that might benefit from the query acceleration service include <u>ad hoc analytics</u>, workloads with <u>unpredictable data volume per query</u>, and queries with <u>large scans</u> and <u>selective filters</u>.

The `SYSTEM$ESTIMATE_QUERY_ACCELERATION` function or `QUERY_ACCELERATION_ELIGIBLE` view allow you to check whether a specific query is a good candidate for query acceleration service.

The Scale Factor in Query Acceleration Service is a control mechanism which lets you select the maximum number of the compute resources a warehouse can lease for Query Acceleration. The scale factor is a <u>multiplier value</u> for number of compute resources of same warehouse size and cost.

Few key points related to Scale Factor:

* The <u>default value of Scale Factor is 8</u> if it is not explicitly set.
* Setting the scale factor to 0 eliminates the upper bound limit and allows queries to lease as many resources as necessary and available to execute the query.
* The Query Acceleration Service is billed by the second, only when the service is in use. These credits are billed separately from warehouse usage.
* Snowflake automatically determines whether the query would benefit from using the Query Acceleration Service, and will only deploy this if it’s estimated to improve query performance and overall throughput.

### 3.3: Practice Questions

During periods of warehouse contention, which parameter controls the maximum length of time a warehouse will hold a query for processing?

> A. STATEMENT_TIMEOUT_IN_SECONDS
> 
> B. <u>STATEMENT_QUEUED_TIMEOUT_IN_SECONDS</u>
>
> C. QUERY_TIMEOUT_IN_SECONDS
>
> D. MAX_CONCURRENCY_LEVEL

************************************************************************************

## 3.4 Optimize query performance.

### Describe the use of materialized views

### Use of specific SELECT commands

### Clustering

### Search optimization service
[Search Optimization Service in Snowflake](https://thinketl.com/search-optimization-service-in-snowflake/)

The Search Optimization Service in Snowflake is a query optimization service that can enhance the performance of certain types of lookup and analytical queries which retrieves a small subset of results from large data volumes.

When Search Optimization Service is enabled on a table, it creates an additional data set called Search Access Path that keeps tracks of all the micro partitions where the values of the table are stored. The Search Access Path improves query performance by reducing the amount of partitions scanned during the table scan operation instead of searching all the partitions of the table.

The following are the Key points related to search access paths:

* When search optimization is enabled on a table, the process of populating data into search access path for the first time might take significant time depending on the size of the data.
* When data in the table is modified, the search access path is automatically updated by Snowflake maintenance service.
* There is additional cost involved for the storage and compute resources for maintaining the search access path.

The following are the recommended checks to consider a table and its columns for Search Optimization Service:

* The data volume of the table on which the query is executed is typically at least in few hundreds of GBs.
* The columns used in the query filter operation has at least 100K-200K distinct values.
* The query returns only a few rows with highly selective filters.
* The query typically runs for at least few seconds or longer.
* The table is either not clustered or the table is frequently queried on columns other than the cluster key columns.

### Persisted query results

### Understanding the impact of different types of caching

#### Metadata Cache

Snowflake stores certain information about each table like <u>row count, min/max values</u> of a column in its <u>metadata in the cloud services layer</u> so that certain queries about the table can be easily answered <u>without reading the table data</u>. This table information stored in metadata is referred as Metadata Cache in Snowflake.

The information that Snowflake stores about each table in metadata include:
- ROW COUNT of a table
- MIN and MAX values of a column
- number of DISTINCT values in a column

Every time when data in table is either inserted, updated or deleted, new micro partitions are written and Snowflake keeps track of these changes in the metadata. Hence <u>latest data of above discussed details of a table is always available in the metadata cache</u>.

#### Query Result Cache 

When a query is executed in Snowflake, the <u>query results are persisted (stored) for a defined period of time</u>. The results are purged from the system at the end of time period. The persisted query results are referred to as Query Result Cache.

The Query Result cache helps avoiding re-executing the queries when a same query is submitted by user which was previously executed and there is no change in the underlying table data.

The following conditions should be met for the query results to be reused:
- The <u>underlying data of the table used in the query have not changed</u>.
- The <u>new query syntactically matches the previously-executed query</u>.
- The query <u>does not include functions that are evaluated at execution time</u> (ex: CURRENT_TIMESTAMP()), user-defined functions (UDFs) or external functions.
- The persisted result for the previous query is still available.
- The table’s micro-partitions have not changed (e.g. been reclustered).

Once the query result cache is generated for a query, it stays available for <u>24 hours</u>.

The result cache expiry is extended for an additional 24 hours if a subsequent query that makes use of the query result cache is run during those 24 hours. Otherwise, after 24 hours, the query result cache is cleared.

The result cache expiry is <u>extended up to a maximum of 31 days</u> from the date and time the query was first executed. After 31 days, the result cache is purged and the next time the query is submitted, a new result cache is generated and persisted.

#### Virtual Warehouse Cache

Every time a virtual warehouse extracts data from a table, it <u>caches that data locally</u>. The subsequent queries can reuse the data in the cache rather than reading from the table in the cloud storage. This cache which gets stored at the local disk is referred to as Virtual Warehouse Cache or Local Disk Cache in Snowflake.

Reading data from a local cache is a much more efficient operation than reading data from the remote cloud storage. Therefore the warehouse cache improves performance of queries which can take advantage of it.

The Virtual Warehouse Cache is <u>removed if the virtual warehouse is suspended</u>.

When the virtual warehouse is resumed, the cache is rebuilt over time as queries are processed. Therefore, it is worth analyzing if suspending a virtual warehouse gives you more cost benefit or keeping it running to have the cache improve query performance.

Note that the size of a virtual warehouse cache is dependent on the size the virtual warehouse. <u>Bigger the virtual warehouse size, larger the cache</u>.
