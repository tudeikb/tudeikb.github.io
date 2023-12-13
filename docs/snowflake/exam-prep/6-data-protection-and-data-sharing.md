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
| Standard         | 7                 | ❌                 | ❌                |
| Enterprise       | 7                 | ❌                 | ❌                |
| Business Critical| 7                 | ❌                 | ❌                |

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

[Introduction to replication and failover](https://docs.snowflake.com/en/user-guide/account-replication-intro)

Database and share replication are available to all accounts.

Replication of other account objects & failover/failback require Business Critical Edition (or higher). 

This feature enables the replication of objects from a <u>source account</u> to <u>one or more target accounts in the same organization</u>. Replicated objects in each target account are referred to as <u>secondary objects</u> and are <u>replicas of the primary objects</u> in the source account. Replication is <u>supported across regions and across cloud platforms</u>.

Customers can replicate across all regions within a region group. To replicate between regions in different region groups, (i.e. from a Snowflake commercial region to a Snowflake government or Virtual Private Snowflake region), please contact Snowflake Support.

A <u>replication group is a defined collection of objects in a source account that are replicated as a unit to one or more target accounts</u>. Replication groups provide <u>read-only access</u> for the replicated objects.

A <u>failover group</u> is a <u>replication group that can also fail over</u>. A secondary failover group in a target account provides read-only access for the replicated objects. <u>When a secondary failover group is promoted to become the primary failover group, read-write access is available</u>. Any target account specified in the list of allowed accounts in a failover group can be promoted to serve as the primary failover group.

Some database objects are <u>not replicated</u>: temporary tables, external tables, event tables, temporary stages, class instances.

As a best practice, Snowflake recommends scheduling automatic refreshes using the `REPLICATION_SCHEDULE` parameter. The schedule can be defined when creating a new replication or failover group with `CREATE <object>` or later (using `ALTER <object>`).

To enable replication for accounts, a user with the `ORGADMIN` role uses the `SYSTEM$GLOBAL_ACCOUNT_SET_PARAMETER` function to set the `ENABLE_ACCOUNT_DATABASE_REPLICATION` parameter to true.

***

Business Continuity and Disaster Recovery is the process of ensuring an organization can continue to <u>provide critical services even in the face of unexpected events</u> such as:

* natural disasters
* man-made disasters
* utility failures
* cybersecurity attacks

Snowflake offers a comprehensive solution to this challenge through its <u>replication and failback / failover functionality</u>.

Key components of the Replication and Failback / Failover functionality:

1. <u>Account object replication</u> → Focuses on replicating important account-level information, such as <u>user information, roles and security settings</u>. This helps ensure that your account information is available and accessible even if one of the locations goes down. 
2. <u>Database replication</u> → Refers to the process of <u>copying your database data to multiple locations</u>. This helps ensure that your data is available and accessible even if one of the locations goes down. 
3. <u>Client redirect</u> → A feature that allows you to automatically <u>route database connection requests</u> from one Snowflake account to another. When enabled, client redirect automatically redirects client connections to the closest available Snowflake service in the event of a service interruption or failure. 

Collectively, these individual features are designed to support a number of different fundamental business continuity scenarios:

Planned failovers → pre-scheduled events where Snowflake switches from the primary site to the secondary site in order to perform maintenance or upgrade the system.

Unplanned failovers → trigerred automatically by Snowflake when the primary site becomes unavailable due to a disaster.

Migration → migrate your Snowflake account to a new region or cloud platform without any interruption to your business operations. This can be beneficial during mergers and acquisitions for maintaining business continuity or when aligning with a revised cloud strategy. 

Multiple readable secondaries → replicate your account objects and databases to multiple accounts across different regions and cloud platforms to reduce the risk of regional or cloud platform outages.

Possible failures and how Snowflake mitigates these:

| Failure Type        | Description                                           | Snowflake Feature(s)                                    |
|---------------------|-------------------------------------------------------|---------------------------------------------------------|
| User error          | Mistakes, such as accidentally deleting a table       | - Time travel<br>- Fail-safe<br>- Zero-copy cloning (for test/dev or backup) |
| Single instance failure | Hardware or system error                            | - Triple-redundancy for critical services<br>- Automatic query retries |
| Zone failure        | Single-zone loss of service availability             | - Availability zones<br>- Azure availability sets        |
| Region failure      | Multiple-zone loss of service availability           | - Cross-region database replication and failover         |
| Multi-region failure | Cloud provider loss of service availability in multiple zones | - Cross-cloud database replication and failover          |

### 6.1: Practice questions

Which of the following objects is not covered by Time Travel?

> A. Schemas 
>
> B. Tables
>
> C. <u>Stages</u>
>
> D. Databases

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

***

What is the MINIMUM role required to set the value for the parameter `ENABLE_ACCOUNT_DATABASE_REPLICATION`?

> A. SYSADMIN
>
> B. ACCOUNTADMIN
>
> C. <u>ORGADMIN</u>
>
> D. SECURITYADMIN

***

Which features automatically protect your Snowflake data WITHOUT user or system administrator intervention?

> A. <u>Availability zones (AWS, Azure, Google)</u>
>
> B. Cloning
>
> C. Database replication
>
> D. <u>Triple redundancy for critical services</u>

***

Which statements are true for Snowflake's fail-over capabilities?

> A. <u>Must have Snowflake Business Critical Edition or higher</u>
>
> B. <u>Must have an account in the region where you wish to share replicated data</u>
>
> C. The replicated database must be in the same region
>
> D. The replicated database must be on the same cloud platform

************************************************************************************

## 6.2 Outline Snowflake data sharing capabilities

### Account types
Snowflake enables data access between accounts through the secure data sharing features. Shares are <u>created by data providers</u> and <u>imported by data consumers</u>, either <u>through their own Snowflake account or a provisioned Snowflake Reader account</u>. The consumer can be an external entity or a different internal business unit that is required to have its own unique Snowflake account.

With secure data sharing:

* There is <u>only one copy of the data</u> that lives in the data provider's account.
* Shared data is always <u>live, real-time, and immediately available</u> to consumers.
* Providers can establish <u>revocable, fine-grained access to shares</u>.
* Data sharing is simple and safe, especially compared to older data sharing methods, which were often manual and insecure, such as transferring large .csv files across the internet.

**Cross-region & cross-cloud data sharing**: To share data across regions or cloud platforms, you <u>must set up replication</u>.

### Snowflake Marketplace
Secure data sharing also powers the Snowflake Data Marketplace, which is <u>available to all Snowflake customers</u> and allows you to <u>discover and access third-party datasets</u> from numerous data providers and SaaS vendors. Again, in this data sharing model, the data doesn't leave the provider's account and you can use the datasets without any transformation.

### Data Exchange

### Access control options

#### DDL commands to create and manage shares

#### Privileges required for working with shares
By default, the privileges required to create and manage shares are granted only to the `ACCOUNTADMIN` role.

### Secure Data Sharing (for example, Direct Share, Listing)

Secure Data Sharing lets you share selected objects in a database in your account with other Snowflake accounts. You can share the following Snowflake database objects:
- Tables
- Dynamic tables
- External tables
- Secure views
- Secure materialized views
- Secure UDFs

Snowflake enables the sharing of databases through shares, which are created by data providers and “imported” by data consumers.

<u>Shares are named Snowflake objects that encapsulate all of the information required to share a database</u>.

Data providers add Snowflake objects (databases, schemas, tables, secure views, etc.) to a share using either or both of the following options:

Option 1: Grant privileges on objects to a share via a database role.

Option 2: Grant privileges on objects directly to a share.

You choose which accounts can consume data from the share by adding the accounts to the share.

### 6.2: Practice Questions

By default, which Snowflake role is required to create a share?

> A. <u>ACCOUNTADMIN</u>
>
> B. SHAREADMIN
>
> C. SECURITYADMIN
>
> D. ORGADMIN

***

A Snowflake user wants to share data using my_share with account xy12345. Which command should be used?

> A. grant select on share my_share to account xy12345;
>
> B. grant usage on share my_share to account xy12345;
>
> C. <u>alter share my_share add accounts = xy12345;</u>
>
> D. alter account xy12345 add share my_share;

***

There are two Snowflake accounts in the same cloud provider region: one is production and the other is non-production.

How can data be easily transferred from the production account to the non-production account?

> A. Clone the data from the production account to the non-production account. 
>
> B. Create a subscription in the production account and have it publish to the non-production account.
>
> C. <u>Create a data share from the production account to the non-production account.</u>
>
> D. Create a reader account using the production account and link the reader account to the non-production account. 

_Zero Copy Clone would be the Snowflake tool to cover this case but the question states that we want to do it between 2 different accounts. It is not possible to use Zero Copy Clone between different accounts (even if they use the same Cloud Provider), so we have to use Data Sharing._

***

What happens to the shared objects for users in a consumer account from a share, once a database has been created in that account?

> A. The shared objects are copied. 
>
> B. The shared objects are transferred.
>
> C. The shared objects can be re-shared.
>
> D. <u>The shared objects become accessible.</u>

***

By default, how many inbound share(s) have every Snowflake account?

> A. Three, the ACCOUNT_USAGE, the DATA, and the INFORMATION shares.
>
> B. <u>Two, the ACCOUNT_USAGE and the SAMPLE_DATA shares.</u>
>
> C. One, the ACCOUNT_USAGE share.
>
> D. Two, the ACCOUNT_USAGE and the INFORMATION shares.

***

What role has the privileges to create and manage data shares by default?

> A. SYSADMIN
>
> B. <u>ACCOUNTADMIN</u>
>
> C. SECURITYADMIN
>
> D. USERADMIN

***

How does Snowflake allow a data provider with an Azure account in central Canada to share data with a data consumer on AWS in Australia?

> A. The data provider in Azure Central Canada can create a direct share to AWS Asia Pacific, if they are both in the same organization.
>
> B. The data provider uses the GET DATA workflow in the Snowflake Data Marketplace to create a share between Azure Central Canada and AWS Asia Pacific.
>
> C. <u>The data provider must replicate the database to a secondary account in AWS Asia Pacific within the same organization then create a share to the data consumer's account.</u>
> 
> D. The data consumer and data provider can form a Data Exchange within the same organization to create a share from Azure Central Canada to AWS Asia Pacific.

***

Which database objects can be shared through Secure Data Sharing? (Select TWO)

> A. <u>External tables</u>
>
> B. Materialized views
>
> C. <u>Secure views</u>
>
> D. Sequences
>
> E. User-Defined Functions (UDFs)

***

What does the Private Sharing area of Snowsight allow a user to do? (Select TWO)

> A. View their login history for up to 7 days.
>
> B. Create and manage provider accounts.
>
> C. Create and share visualizations and dashboards.
>
> D. <u>View and work with data that others have shared.</u>
>
> E. <u>View data that their account has shared with others.</u>

***

Who is required to accept the Snowflake Consumer Terms of Service?

> A. ACCOUNTADMIN
>
> B. SECURITYADMIN
>
> C. SYSADMIN
>
> D. <u>ORGADMIN</u>