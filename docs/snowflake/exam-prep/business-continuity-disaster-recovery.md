---
layout: default
title: Business Continuity & Disaster Recovery
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

> What is the MINIMUM role required to set the value for the parameter `ENABLE_ACCOUNT_DATABASE_REPLICATION`?
>
> ❌ SYSADMIN
>
> ❌ ACCOUNTADMIN
>
> ✅ **ORGADMIN**
>
> ❌ SECURITYADMIN

***

To enable replication for accounts, a user with the `ORGADMIN` role uses the `SYSTEM$GLOBAL_ACCOUNT_SET_PARAMETER` function to set the `ENABLE_ACCOUNT_DATABASE_REPLICATION` parameter to true.

❗️ Only organization administrators (i.e. users with the `ORGADMIN` role) can call this SQL function.