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
### Explain plans

### Data spilling

[Performance impact from local and remote disk spilling](https://community.snowflake.com/s/article/Performance-impact-from-local-and-remote-disk-spilling)

When Snowflake warehouse cannot fit an operation in memory, it starts spilling (storing) data first to the local disk of a warehouse node, and then to remote storage.

In such a case, Snowflake first tries to temporarily store the data on the warehouse local disk. As this means extra IO operations, any query that requires spilling will take longer than a similar query running on similar data that is capable to fit the operations in memory.

Also, if the local disk is not sufficient to fit the spilled data, Snowflake further tries to write to the remote cloud storage, which will be shown in the query profile as "Bytes spilled to remote storage".

A query spilling bytes to the remote storage will notice even further performance degradation.

The spilling can't always be avoided, especially for large batches of data, but it can be decreased by:
- Reviewing the query for query optimization especially if it is a new query
- Reducing the amount of data processed. For example, by trying to improve partition pruning, or projecting only the columns that are needed in the output.
- Decreasing the number of parallel queries running in the warehouse ($$\Rightarrow$$ reduced memory consumption per query, potentially more CPU cycles available and other system resources)
- Trying to split the processing into several steps (for example by replacing the CTEs with temporary tables).
- Using a larger warehouse - this effectively means more memory and more local disk space.

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

#### Query Result Cache 

When a query is executed in Snowflake, the query results are persisted (stored) for a defined period of time. The results are purged from the system at the end of time period. The persisted query results are referred to as Query Result Cache.

The Query Result cache helps avoiding re-executing the queries when a same query is submitted by user which was previously executed and there is no change in the underlying table data.

The following conditions should be met for the query results to be reused:
- The underlying data of the table used in the query have not changed.
- The new query syntactically matches the previously-executed query.
- The query does not include functions that are evaluated at execution time (ex: CURRENT_TIMESTAMP()), user-defined functions (UDFs) or external functions.
- The persisted result for the previous query is still available.
- The table’s micro-partitions have not changed (e.g. been reclustered).

Once the query result cache is generated for a query, it stays available for <u>24 hours</u>.

The result cache expiry is extended for an additional 24 hours if a subsequent query that makes use of the query result cache is run during those 24 hours. Otherwise, after 24 hours, the query result cache is cleared.

The result cache expiry is <u>extended up to a maximum of 31 days</u> from the date and time the query was first executed. After 31 days, the result cache is purged and the next time the query is submitted, a new result cache is generated and persisted.

#### Metadata Cache

Snowflake stores certain information about each table like row count, min/max values of a column in its metadata in the cloud services layer so that certain queries about the table can be easily answered without reading the table data. This table information stored in metadata is referred as Metadata Cache in Snowflake.

The information that Snowflake stores about each table in metadata include:
- ROW COUNT of a table
- MIN and MAX values of a column
- number of DISTINCT values in a column

Every time when data in table is either inserted, updated or deleted, new micro partitions are written and Snowflake keeps track of these changes in the metadata. Hence latest data of above discussed details of a table is always available in the metadata cache.

#### Virtual Warehouse Cache

Every time a virtual warehouse extracts data from a table, it caches that data locally. The subsequent queries can reuse the data in the cache rather than reading from the table in the cloud storage. This cache which gets stored at the local disk is referred to as Virtual Warehouse Cache or Local Disk Cache in Snowflake.

Reading data from a local cache is a much more efficient operation than reading data from the remote cloud storage. Therefore the warehouse cache improves performance of queries which can take advantage of it.

The Virtual Warehouse Cache is removed if the virtual warehouse is suspended.

When the virtual warehouse is resumed, the cache is rebuilt over time as queries are processed. Therefore, it is worth analyzing if suspending a virtual warehouse gives you more cost benefit or keeping it running to have the cache improve query performance.

Note that the size of a virtual warehouse cache is dependent on the size the virtual warehouse. Bigger the virtual warehouse size, larger the cache.



### Micro-partition pruning

### Query history

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

************************************************************************************

## 3.2 Explain virtual warehouse configurations

### Types of warehouses
Warehouses are required for queries, as well as all DML operations, including loading data into tables. In addition to being defined by its type as either <u>Standard</u> or <u>Snowpark-optimized</u>, a warehouse is defined by its size, as well as the other properties that can be set to help control and automate warehouse activity.

Warehouses can be <u>started and stopped at any time</u>. They can also be <u>resized at any time, even while running</u>, to accommodate the need for more or less compute resources.

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

### Warehouse sizing

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

### Query acceleration service

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