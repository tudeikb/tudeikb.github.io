---
layout: default
title: Secure Data Sharing
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

> A Snowflake user wants to share data using my_share with account xy12345. Which command should be used?
>
> ❌ grant select on share my_share to account xy12345;
>
> ❌ grant usage on share my_share to account xy12345;
>
> ✅ alter share my_share add accounts = xy12345;
>
> ❌ alter account xy12345 add share my_share;

***

Secure Data Sharing lets you share selected objects in a database in your account with other Snowflake accounts. You can share the following Snowflake database objects:
- External tables
- Dynamic tables
- Secure views
- Secure materialized views
- Secure UDFs
- Tables

Snowflake enables the sharing of databases through shares, which are created by data providers and “imported” by data consumers.

Shares are named Snowflake objects that encapsulate all of the information required to share a database.

Data providers add Snowflake objects (databases, schemas, tables, secure views, etc.) to a share using either or both of the following options:

Option 1: Grant privileges on objects to a share via a database role.

Option 2: Grant privileges on objects directly to a share.

You choose which accounts can consume data from the share by adding the accounts to the share.

***

> By default, which Snowflake role is required to create a share?
>
> ✅ ACCOUNTADMIN
>
> ❌ SHAREADMIN
>
> ❌ SECURITYADMIN
>
> ❌ ORGADMIN

*** 

Only the `ACCOUNTADMIN` role has this privilege by default. The privilege can be granted to additional roles as needed.




