---
layout: default
title: Account Usage
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

[Account usage reference](https://docs.snowflake.com/en/sql-reference/account-usage)

#### LOGIN_HISTORY View
{: .fs-5 }

> A company’s security audit requires generating a report listing all Snowflake logins (e.g., date and user) within the last 90 days. Which of the following statements will return the required information?
>
> ❌ SELECT LAST_SUCCESS_LOGIN, LOGIN_NAME FROM ACCOUNT_USAGE.USERS;
>
> ✅ SELECT EVENT_TIMESTAMP, USER_NAME FROM ACCOUNT_USAGE.LOGIN_HISTORY;
>
> ❌ SELECT EVENT_TIMESTAMP, USER_NAME FROM table(information_schema.login_history_by_user());
>
> ❌ SELECT EVENT_TIMESTAMP, USER_NAME FROM ACCOUNT_USAGE.ACCESS_HISTORY;

***

`LOGIN_HISTORY` View: This Account Usage view can be used to query login attempts by Snowflake users within the **last 365 days (1 year)**.

The `LOGIN_HISTORY` family of table functions can be used to query login attempts by Snowflake users along various dimensions:

`LOGIN_HISTORY` returns login events within a specified time range.

`LOGIN_HISTORY_BY_USER` returns login events of a specified user within a specified time range.

**These functions return login activity within the last 7 days.**

***

> Which view in SNOWFLAKE.ACCOUNT_USAGE shows from which IP address a user connected to Snowflake?
>
> ✅ **LOGIN_HISTORY**
>
> ❌ ACCESS_HISTORY
>
> ❌ SESSIONS
> 
> ❌ QUERY_HISTORY

*** 

`LOGIN_HISTORY` → query login attempts within last 365 days

`ACCESS_HISTORY` → Enterprise edition or higher; related with data lineage and dependencies, shows accessed data objects.

`SESSIONS` → information on sessions, including authentication method and login events (there is no information about IP addresses)

`QUERY_HISTORY` → query history by various dimensions within last 365 days

***

> What are the key characteristics of ACСOUNT_USAGE views? (Choose two.)
>
> ✅ **The data latency can vary from 45 minutes to 3 hours**
>
> ❌ The historical data is not retained
>
> ❌ There is no data latency
> 
> ✅ **Records for dropped objects are included in each view**
>
> ❌ The historical data can be retained from 7 days to 6 months
