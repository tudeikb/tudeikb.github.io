---
layout: default
title: Query Profile
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

#### What does query profile provide
{: .fs-5 }

> What does a Query Profile provide in Snowflake?
> 
> 🤔 A collapsible panel in the operator tree pane that lists nodes by execution time in descending order for a query. 🤔
> 
> ❌ A multi-step query that displays each processing step in the same panel.
> 
> ✅ **A graphical representation of the main components of the processing plan for a query.**
> 
> ❌ A pre-computed data set derived from a query specification and stored for later use.

*** 
Query profile interface elements:
* **Steps**: If the query was processed in multiple steps, you can toggle between each step.

* **Operator tree**: The middle pane displays a graphical representation of all the operator nodes for the selected step, including the relationships between each operator node.

* **Node list**: The middle pane includes a collapsible list of operator nodes by execution time.

* **Overview**: The right pane displays an overview of the query profile. The display changes to operator details when an operator node is selected.

***

An operator tree is a visual representation of the sequence of operations (or steps) that a database management system performs to execute a SQL query. Each node in the tree represents a specific operation, such as a table scan, join, sort, or aggregation.

A collapsible panel in the operator tree pane lists nodes by execution time in descending order, enabling users to quickly locate the costliest operator nodes in terms of execution time.

***

> What are common issues found by using the Query Profile? (Choose two.)
> 
> ❌ Identifying logical issues with the queries
>
> ✅ **Data spilling to a local or remote disk**
> 
> ❌ Locating queries that consume a high amount of credits
>
> ❌ Identifying queries that will likely run very slowly before executing them
> 
> ✅ **Identifying inefficient micro-partition pruning**

***

> What aspect of an executed query is represented by the remote disk I/O statistic of the Query Profile in Snowflake?
> 
> ❌ Time spent caching the data to remote storage in order to buffer the data being extracted and exported
> 
> ❌ Time spent reading and writing data from and to remote storage when the data being accessed does not fit into the executing virtual warehouse node memory
>
> ✅ **Time spent reading and writing data from and to remote storage when the data being accessed does not fit into either the virtual warehouse memory or the local disk**
>
> ❌ Time spent scanning the table partitions to filter data based on the predicate

***

For some operations (e.g. duplicate elimination for a huge data set), the amount of memory available for the compute resources used to execute the operation might not be sufficient to hold intermediate results. As a result, the query processing engine will start spilling the data to local disk. If the local disk space is not sufficient, the spilled data is then saved to remote disks.

This spilling can have a profound effect on query performance (especially if remote disk is used for spilling). Performance degrades drastically when a warehouse runs out of memory while executing a query because memory bytes must “spill” onto local disk storage. If the query requires even more memory, it spills onto remote cloud-provider storage, which results in even worse performance.

Remote Disk I/O is the metric of the Query profile which can analyze the time spent reading/writing data from/it remote storage (i.e. S3 or Azure Blob storage). This would include things like spilling to remote disk, or reading your datasets.