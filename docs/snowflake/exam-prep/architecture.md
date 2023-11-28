---
layout: default
title: Architecture
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

#### Snowflake's database architecture
{: .fs-5 }

> Which of the following terms best describes Snowflake's database architecture?
>
> ❌ Columnar shared nothing
>
> ❌ Cloud-native shared memory
>
> ✅ **Multi-cluster, shared data**
>
> ❌ Shared disk

***

Snowflake employs a unique architecture known as the multi-cluster, shared data architecture. This approach allows for the separation of storage and compute resources, enabling efficient scaling and management of large data sets. In this architecture, data is stored in a central repository and can be accessed by multiple compute clusters, ensuring high availability and scalability. This differs from traditional architectures like columnar shared-nothing, cloud-native shared memory, or shared disk models.

***

> In which layer of Snowflake architecture is stored all security-related information?
>
> ✅ **Cloud Services**
> 
> ❌ All of the above
>
> ❌ Compute
>
> ❌ Storage
> 
***

> In which layer of its architecture does Snowflake store its metadata statistics?
>
> ❌ Database Layer
> 
> ✅ **Cloud Services Layer**
>
> ❌ Compute Layer
>
> ❌ Storage Layer

***

The Cloud Services layer is a collection of services coordinating activities across Snowflake. It's in charge of Authentication, Infrastructure management, Metadata management, Query parsing and optimization, and Access control.








