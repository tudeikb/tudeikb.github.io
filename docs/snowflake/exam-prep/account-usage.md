---
layout: default
title: Account Usage
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

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




