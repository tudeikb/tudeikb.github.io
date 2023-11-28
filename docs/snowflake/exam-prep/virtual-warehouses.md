---
layout: default
title: Virtual Warehouses
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

#### Virtual Warehouse Definition
{: .fs-5 }

> Which statement accurately describes how a virtual warehouse functions?
> 
> ✅ **Each virtual warehouse is a compute cluster composed of multiple compute nodes allocated by Snowflake from a cloud provider.**
> 
> ❌ Each virtual warehouse is an independent compute cluster that shares compute resources with other warehouses.
> 
> ❌ All virtual warehouses share the same compute resources so performance degradation of one warehouse can significantly affect all the other warehouses.
> 
> ❌ Increasing the size of a virtual warehouse will always improve data loading performance.

***




#### Resizing warehouses
{: .fs-5 }

> Why would a customer size a Virtual Warehouse from an X-Small to a Medium?
> 
> ❌ To accomodate fluctuations in workload 
> 
> ❌ To accomodate more queries
>
> ✅ **To accomodate a more complex workload**
>
> ❌ To accomodate more users

***

To accomodate fluctuations in workload $$\Rightarrow$$ concurrency $$\Rightarrow$$ scale out

To accomodate more queries $$\Rightarrow$$ concurrency $$\Rightarrow$$ scale out

To accomodate a more complex workload $$\Rightarrow$$ scale up

To accomodate more users $$\Rightarrow$$ concurrency $$\Rightarrow$$ scale out

***




#### Auto-resume and Auto-suspend options
{: .fs-5 }

> Which of the following are options when creating a Virtual Warehouse? (Choose two.)
> 
> ❌ Auto-enable
> 
> ❌ Auto-drop
> 
> ❌ Auto-disable
> 
> ✅ **Auto-resume**
> 
> ❌ Auto-resize
> 
> ✅ **Auto-suspend**

***

> A Virtual Warehouse's auto-suspend and auto-resume settings apply to:
> 
> ✅ **The entire Virtual Warehouse**
> 
> ❌ The database the Virtual Warehouse resides in
> 
> ❌ The primary cluster in the Virtual Warehouse
> 
> ❌ The queries currently being run by the Virtual Warehouse

***




#### When to disable auto-suspend
{: .fs-5 }

> When should you consider disabling auto-suspend for a Virtual Warehouse? (Choose two.)
> 
> ✅ **When the compute must be available with no delay or lag time**
> 
> ❌ When you do not want to have to manually turn on the Warehouse each time a user needs it
>
> ❌ When users will be using compute at different times throughout a 24/7 period
>
> ❌ When you want to avoid queuing and handle concurrency
>
> ✅ **When managing a steady workflow**

***




#### Multi-cluster warehouses (concurrency)
{: .fs-5 }

Enterprise edition
{: .label .label-blue } 

> How can a Snowflake user configure a virtual warehouse to support over 100 users if their company has Enterprise Edition?
> 
> ❌ Add additional warehouses and configure them as cluster.
> 
> ❌ Set the auto-scale to 100.
> 
> ✅ **Use a multi-cluster warehouse.**
>
> ❌ Use a larger warehouse.

*** 

Multi-cluster warehouses are designed specifically for handling **queuing and performance** issues related to **large numbers of concurrent users and/or queries**. In addition, multi-cluster warehouses can help automate this process if your number of users/queries tend to fluctuate.

***

> What action can a user take to address query concurrency issues?
>
> ❌ Resize the virtual warehouse to a larger instance size. 
>
> ❌ Enable the query acceleration service.
>
> ✅ **Add additional clusters to the virtual warehouse.**
>
> ❌ Enable the search optimization service.

***

Multi-cluster warehouses are best utilized for scaling resources to improve concurrency for users/queries. They are not as beneficial for improving the performance of slow-running queries or data loading. For these types of operations, resizing the warehouse provides more benefits.

***




#### Auto-scale mode
{: .fs-5 }

> To run a Multi-Cluster Warehouse in auto-scale mode, a user would:
> 
> ❌ Configure the Maximum Clusters to Auto-Scale
> 
> ❌ Set the Warehouse type to Auto
>
> ❌ Set the Minimum Clusters and Maximum Clusters setting to the same value
>
> ✅ **Set the Minimum Clusters and Maximum Clusters settings to be different values**

***

If you set the minimum cluster count less than the maximum cluster count, then the warehouse runs in Auto-scale mode.

***




#### Standard vs Economy Scaling Policy
{: .fs-5 }

> How should a virtual warehouse be configured if a user wants to ensure that additional multi-clusters are resumed with the shortest delay possible?
> 
> ❌ Set the minimum and maximum clusters to autoscale
> 
> ❌ Use the economy warehouse scaling policy
> 
> ❌ Configure the warehouse to a size larger than generally required
>
> ✅ **Use the standard warehouse scaling policy**

***

The first sentence doesn't make sense. You can set minimum and maximum clusters in the multi-cluster architecture. The minimum setting ensures that specified number of clusters are always running (=> maintain baseline level of performance). The maximum setting => control cost even if the demand would call for more resources. Autoscaling happens between the min and max, according to the scaling policy. 

The economy warehouse policy will not result in the shortest delay, because additional clusters start only if the system estimates there’s enough query load to keep the cluster busy for at least 6 minutes.

Configure the warehouse to a size larger than generally required - that simply makes no sense (possibly wasting resources + adding cost), plus warehouse sizes change is vertical scaling, not horizontal scaling. 

In the standard scaling policy the first cluster starts immediately when either a query is queued or the system detects that there’s one more query than the currently-running clusters can execute.

***




#### Statement queued timeout
{: .fs-5 }

> During periods of warehouse contention, which parameter controls the maximum length of time a warehouse will hold a query for processing?
> 
> ❌ STATEMENT_TIMEOUT_IN_SECONDS
> 
> ✅ **STATEMENT_QUEUED_TIMEOUT_IN_SECONDS**
>
> ❌ QUERY_TIMEOUT_IN_SECONDS
>
> ❌ MAX_CONCURRENCY_LEVEL

***

contention = rywalizacja

Warehouse contention refers to a situation where multiple queries or tasks are competing for resources within the same virtual warehouse, leading to decreased performance and longer processing times. 

Contention occurs when multiple queries or jobs are executed simultaneously in the same warehouse, and these queries collectively demand more resources than the warehouse can provide. This leads to a queue forming, where some queries must wait for others to complete before they can access the necessary resources.

The primary effects of warehouse contention are increased query runtimes and potential timeouts. 

***

`STATEMENT_QUEUED_TIMEOUT_IN_SECONDS` → Amount of time, in seconds, a SQL statement remains queued for a warehouse before it is canceled by the system. 

`MAX_CONCURRENCY_LEVEL` → In general, it limits the number of statements that can be executed concurrently by a warehouse cluster. When the limit is reached, statements are queued or additional resources provided.

`MAX_CONCURRENCY_LEVEL` can be used in conjunction with the `STATEMENT_QUEUED_TIMEOUT_IN_SECONDS` parameter to ensure a warehouse is never backlogged ($$\Rightarrow$$ experiencing a buildup of queries or tasks waiting to be executed). 

`STATEMENT_TIMEOUT_IN_SECONDS` → Amount of time, in seconds, after which a running SQL statement is canceled by the system.

The 4th one does not exist.

***




#### Spilling (Bytes spilled to local/remote storage)
{: .fs-5 }

> A Snowflake query took 40 minutes to run. The results indicate that ‘Bytes spilled to local storage’ was a large number.
>
> What is the issue and how can it be resolved?
> 
> ❌ The warehouse is too large. Decrease the size of the warehouse to reduce the spillage. 
> 
> ❌ The Snowflake console has timed-out. Contact Snowflake Support.
>
> ✅ **The warehouse is too small. Increase the size of warehouse to reduce the spillage.**
>
> ❌ The warehouse consists of a single cluster. Use a multi-cluster warehouse to reduce the spillage.

***

What is disk spilling? When Snowflake warehouse cannot fit an operation in memory, it starts spilling (storing) data first to the local disk of a warehouse node, and then to remote storage.

In such a case, Snowflake first tries to temporarily store the data on the warehouse local disk. As this means extra IO operations, any query that requires spilling will take longer than a similar query running on similar data that is capable to fit the operations in memory.

Also, if the local disk is not sufficient to fit the spilled data, Snowflake further tries to write to the remote cloud storage, which will be shown in the query profile as "Bytes spilled to remote storage".

A query spilling bytes to the remote storage will notice even further performance degradation.

[Solution](https://community.snowflake.com/s/article/Performance-impact-from-local-and-remote-disk-spilling){: .btn .btn-green }

The spilling can't always be avoided, especially for large batches of data, but it can be decreased by:
* Reviewing the query for query optimization especially if it is a new query
* Reducing the amount of data processed. For example, by trying to improve partition pruning, or projecting only the columns that are needed in the output.
* Decreasing the number of parallel queries running in the warehouse ($$\Rightarrow$$ reduced memory consumption per query, potentially more CPU cycles available and other system resources)
* Trying to split the processing into several steps (for example by replacing the CTEs with temporary tables).
* Using a larger warehouse - this effectively means more memory and more local disk space.
















