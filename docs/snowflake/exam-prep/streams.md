---
layout: default
title: Streams
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

#### Types of streams
{: .fs-5 }

> Which stream type can be used for tracking the records in external tables?
>
> ❌ Standard
>
> ❌ Append-only
>
> ❌ External
> 
> ✅ **Insert only**

***

Types of streams:
- Standard (delta): tables, directory tables, views. Tracks all DML changes (inserts, updates, deletes including truncates).
- Append-only: tables, directory tables, views. Tracks inserts only. 
- Insert-only: external tables. Tracks inserts only (overwritten or appended files are essentially handled as new files).





