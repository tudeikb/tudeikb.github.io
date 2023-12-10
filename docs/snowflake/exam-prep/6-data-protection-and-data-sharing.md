---
layout: default
title: "Domain 6.0: Data Protection and Data Sharing"
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

## 6.1 Outline Continuous Data Protection with Snowflake

[Continuous Data Protection](https://docs.snowflake.com/en/user-guide/data-cdp)

### Time Travel
Using Time Travel, you can perform the following actions within a defined period of time:
- Query data in the past that has since been updated or deleted.
- Create clones of entire tables, schemas, and databases at or before specific points in the past.
- Restore tables, schemas, and databases that have been dropped.

A key component of Snowflake Time Travel is the <u>data retention period</u>.

The <u>standard (default) retention period is 1 day</u> (24 hours) and is automatically enabled for all Snowflake accounts.

The `DATA_RETENTION_TIME_IN_DAYS` object parameter can be used by users with the `ACCOUNTADMIN` role to set the default retention period for your account.

Note that <u>extended data retention requires additional storage</u> which will be reflected in your monthly storage charges.

| Edition          | Permanent Objects | Transient Objects | Temporary Objects |
|------------------|-------------------|-------------------|-------------------|
| Standard         | 0 or 1            | 0 or 1            | 0 or 1 ✵          |
| Enterprise       | From 0 to 90      | 0 or 1            | 0 or 1 ✵           |
| Business Critical| From 0 to 90      | 0 or 1            | 0 or 1 ✵           |

✵ The Time Travel period for a temporary table ends when the table is explicitly dropped or dropped as a result of terminating the session. 

### Fail-safe
When the retention period ends for an object, the historical data is moved into Snowflake Fail-safe.

Fail-safe provides a <u>(non-configurable) 7-day period</u> during which historical data may be <u>recoverable by Snowflake</u>. This period starts <u>immediately after the Time Travel retention period ends</u>. 

Fail-safe is not provided as a means for accessing historical data after the Time Travel retention period has ended. It is for use only by Snowflake to <u>recover data that may have been lost or damaged due to extreme operational failures</u>.

Data recovery through Fail-safe may take from several hours to several days to complete.

| Edition          | Permanent Objects | Transient Objects | Temporary Objects |
|------------------|-------------------|-------------------|-------------------|
| Standard         | 7                 | 7                 | ❌                |
| Enterprise       | 7                 | 7                 | ❌                |
| Business Critical| 7                 | 7                 | ❌                |

### Data Encryption

All ingested data stored in Snowflake tables, and all files stored in internal stages for data loading and unloading, are encrypted using <u>AES-256</u> strong encryption. 

### Cloning

[CREATE <object> ... CLONE](https://docs.snowflake.com/en/sql-reference/sql/create-clone)

For databases and schemas, cloning is <u>recursive</u>.

If the source object is a database or schema, <u>the clone inherits all granted privileges on the clones of all child objects</u> contained in the source object. 

<u>The clone of the container itself does not inherit the privileges</u> granted on the source container.

The following object types are <u>**not** cloned</u>:
- External tables
- Internal (Snowflake) stages



### Replication


### 6.1: Practice questions


***

How does Fail-safe protect data in a permanent table?

> A. Fail-safe makes data available up to 1 day, recoverable by user operations.
>
> B. Fail-safe makes data available for 7 days, recoverable by user operations.
>
> C. Fail-safe makes data available up to 1 day, recoverable only by Snowflake Support.
>
> D. <u>Fail-safe makes data available for 7 days, recoverable only by Snowflake Support.</u>

***

What happens to historical data when the retention period for an object ends?

> A. <u>The data moves to Fail-safe.</u>
>
> B. The data is cloned into a historical object.
>
> C. The object containing the historical data is dropped.
>
> D. Time Travel on the historical data is dropped.

***

What should be the first option to restore data into a table?

> A. Fail-safe
>
> B. Ask Snowflake Support
>
> C. <u>Time Travel</u>
>
> D. Zero-copy cloning

***

Which Snowflake edition allows only one day of Time Travel?

> A. No version allow only one day of Time Travel.
>
> B. Enterprise.
>
> C. Business Critical.
>
> D. <u>Standard.</u>

***

What feature of Snowflake Continuous Data Protection can be used for maintenance of historical data?

> A. Access control
>
> B. <u>Time Travel</u>
>
> C. Network policies
>
> D. Fail-safe

***

Which of the following objects is not covered by Time Travel?

> A. Schemas
>
> B. Tables
>
> C. <u>Stages</u>
>
> D. Databases

***

Which of the following Snowflake features provide continuous data protection automatically? (Choose two.)

> A. Internal stages
>
> B. <u>Time Travel</u>
>
> C. Zero-copy clones
>
> D. <u>Fail-safe</u>
>
> E. Incremental backups

***

Which Snowflake edition (and above) allows until 90 days of Time Travel?

> A. Business Critical
>
> B. Virtual Private Snowflake
>
> C. <u>Enterprise</u>
>
> D. Standard

***

Which Snowflake feature is used for both querying and restoring data?

> A. Cluster keys
>
> B. <u>Time Travel</u>
>
> C. Cloning
>
> D. Fail-safe

***

What is the maximum total Continuous Data Protection (CDP) charges incurred for a temporary table?

> A. 48 hours
>
> B. 7 days 
>
> C. <u>24 hours</u>
>
> D. 30 days

***

In which different ways can we query historical data? (Choose three.)

> A. By user.
>
> B. <u>By query statement ID.</u>
>
> C. <u>By offset.</u>
>
> D. By session.
>
> E. <u>By timestamp.</u>
>
> F. By backup.

***

A user created a transient table and made several changes to it over the course of several days. Three days after the table was created, the user would like to go back to the first version of the table.

How can this be accomplished?

> A. <u>The transient table version cannot be retrieved after 24 hours.</u>
>
> B. Use the FAIL_SAFE parameter for Time Travel to retrieve the data from Fail-safe storage.
>
> C. Contact Snowflake Support to have the data retrieved from Fail-safe storage.
>
> D. Use Time Travel, as long as DATA_RETENTION_TIME_IN_DAYS was set to at least 3 days.

***

Which encryption algorithm is used by Snowflake tables when we load data into them?

> A. <u>AES 256</u>
>
> B. SHA 128
>
> C. SHA 256
>
> D. AES 128