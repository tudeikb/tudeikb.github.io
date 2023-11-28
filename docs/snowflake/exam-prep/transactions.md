---
layout: default
title: Transactions
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

#### Locking resources
{: .fs-5 }

> Which of the following commands are not blocking operations? (Choose two.)
>
> ❌ UPDATE
>
> ✅ **INSERT**
>
> ❌ DELETE
>
> ❌ MERGE
> 
> ✅ **COPY**

*** 

The following guidelines apply in most situations:

`COMMIT` operations (including both `AUTOCOMMIT` and explicit `COMMIT`) lock resources, but usually only briefly.

`CREATE [ DYNAMIC] TABLE`, `CREATE STREAM`, and `ALTER TABLE` operations all lock their underlying resources when setting `CHANGE_TRACKING = TRUE`, but usually only briefly. Only `UPDATE` and `DELETE` DML operations are blocked when a table is locked. `INSERT` operations are NOT blocked.

`UPDATE`, `DELETE`, and `MERGE` statements hold locks that generally prevent them from running in parallel with other `UPDATE`, `DELETE`, and `MERGE` statements.

Most `INSERT` and `COPY` statements write only new partitions. Those statements often can run in parallel with other `INSERT` and `COPY` operations, and sometimes can run in parallel with an `UPDATE`, `DELETE`, or `MERGE` statement.
