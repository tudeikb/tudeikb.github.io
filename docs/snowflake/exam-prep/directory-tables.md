---
layout: default
title: Directory Tables
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

#### Output of a Snowflake directory table
{: .fs-5 }

> Which columns are available in the output of a Snowflake directory table? (Choose two.)
>
> ❌ STAGE_NAME
>
> ✅ **RELATIVE_PATH**
>
> ✅ **LAST_MODIFIED**
>
> ❌ CATALOG_NAME
>
> ❌ FILE_NAME


***

A directory table is an implicit object layered on a stage (not a separate database object) and is conceptually similar to an external table because it stores file-level metadata about the data files in the stage. A directory table has no grantable privileges of its own.

Both external (external cloud storage) and internal (Snowflake) stages support directory tables. You can add a directory table to a stage when you create a stage (using `CREATE STAGE`) or later (using `ALTER STAGE`).

