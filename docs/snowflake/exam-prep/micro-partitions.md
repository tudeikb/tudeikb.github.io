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
