---
layout: default
title: Reader Accounts
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

> Which statement describes how Snowflake supports reader accounts?
>
> ❌ A consumer needs to become a licensed Snowflake customer as data sharing is only supported between Snowflake accounts.
> 
> ❌ The users in a reader account can query data that has been shared with the reader account and can perform DML tasks.
> 
> ❌ A reader account can consume data from the provider account that created it and combine it with its own data.
> 
> ✅ **The SHOW MANAGED ACCOUNTS command will view all the reader accounts that have been created for an account.**

*** 

Reader accounts (formerly known as “read-only accounts”) enable providers to share data with consumers who are not already Snowflake customers, without requiring the consumers to become Snowflake customers.

The reader account is created, owned, and managed by the provider account, which assumes all responsibility for credit charges incurred by users in the reader account.

To enable creating and managing reader accounts, Snowflake provides a first-class object, `MANAGED ACCOUNT`.
