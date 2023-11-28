---
layout: default
title: Access Control
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

#### Object owner role is dropped
{: .fs-5 }

> A role is created and owns 2 tables. This role is then dropped. Who will now own the two tables?
>
> ✅ **The assumed role that dropped the role**
>
> ❌ SYSADMIN
>
> ❌ The user that deleted the role
>
> ❌ The tables are now orphaned

***

Ownership of any objects owned by the dropped role is transferred to the role that executes the DROP ROLE command.



