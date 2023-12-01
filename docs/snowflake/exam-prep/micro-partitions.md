---
layout: default
title: Micro-partitions
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

> How does Snowflake store a table's underlying data? (Choose two.)
>
> ✅ **Micro-partitions**
>
> ❌ Text file format
>
> ❌ Uncompressed
>
> ✅ **Columnar file format**
>
> ❌ User-defined partitions

***

> What technique does Snowflake use to limit the number of micro-partitions retrieved as part of a query?
>
> ✅ **Pruning**
>
> ❌ Clustering
>
> ❌ Indexing
>
> ❌ Computing

***

Query pruning consists of analyzing the smallest number of micro-partitions to solve a query. This technique retrieves all the necessary data to give a solution without looking at all the micro-partitions, saving a lot of time to return for the result.

***

#### Data compression
{: .fs-5 }

> How is table data compressed in Snowflake?
>
> ❌ Each micro-partition is compressed as it is written into cloud storage using GZIP. 
>
> ❌ The text data in a micro-partition is compressed with GZIP but other types are not compressed. 
>
> ✅ **Each column is compressed as it is stored in a micro-partition.**
>
> ❌ The micro-partitions are stored in compressed cloud storage and the cloud storage handles compression.
