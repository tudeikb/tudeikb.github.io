---
layout: default
title: Choose The Right Warehouse Size
parent: Snowflake
nav_order: 1
---

# Choose The Right Warehouse Size

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

Snowflake warehouse size impacts **costs** and **query performance**. 

Snowflake warehouse is a **cluster of computational resources** used for running queries and tasks. It functions as an on-demand resource, separate from any data storage system, and is similar to a virtual machine (VM).

The number of nodes available for a query:

| warehouse size | number of nodes | cost |
|----------------|-----------------|------|
| XS             | 1               | x    |
| S              | 2               | x    |
| M              | 4               | x    |
| L              | 8               | x    |
| XL             | 16              | x    |
| 2XL            | 32              | x    |
| 3XL            | 64              | x    |
| 4XL            | 128             | x    |
| 5XL            | 256             | x    |
| 6XL            | 512             | x    |

{: .important } 
Both the number of nodes and the cost **double** with each increase in warehouse size.

Steps to effectively right-size the virtual warehouse:

## Start small and scale up as needed

Until you find the sweet spot of maximum performance at the lowest cost. 

If the cost of running the warehouse doubles with each increase in size, then you would ideally want the query execution time to be at least halved to justify the increased cost from a performance standpoint. 🤔
    
$$\Rightarrow$$ Choose the size that offers the best cost-to-performance ratio. 🤔

## Check if the warehouse is under or over provisioned

An under-provisioned Snowflake warehouse may not have sufficient resources to handle the workload, leading to sluggish query performance and potential bottlenecks. To identify under-provisioning, monitor performance indicators such as **query execution time**, **queue time**, and **the number of queued queries**. If these metrics consistently show poor performance, increasing the warehouse size to allocate more resources may be necessary.

An over-provisioned Snowflake warehouse may have more resources than required, resulting in unnecessary costs without providing any significant performance improvements. To identify over-provisioning, analyze the warehouse's resource utilization, such as **CPU** and **memory usage**. If these metrics consistently show low utilization, it may be more cost-effective to reduce the warehouse size.

## Monitor disk spillage
It's crucial to monitor both local and remote disk spillage. In Snowflake, when a warehouse cannot fit an operation in memory, it starts spilling data first to the local disk of a warehouse node, and then to remote storage. This process, called disk spilling, leads to decreased performance and can be seen in the query profile as "Bytes spilled to local/remote storage." When the amount of spilled data is significant, it can cause noticeable degradation in warehouse performance.
