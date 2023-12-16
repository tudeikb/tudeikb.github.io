---
layout: default
title: "Domain 2.0: Account Access and Security"
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

## 2.1 Outline security principles

### Network security and policies
Network policies allow restricting access to your account based on user IP address. Effectively, a network policy enables you to create an <u>IP allowed list</u>, as well as an <u>IP blocked list</u>, if desired.

By default, Snowflake allows users to connect to the service from any computer or device IP address. A security administrator (or higher) can create a network policy to allow or deny access to a single IP address or a list of addresses. Network policies currently <u>support only Internet Protocol version 4 (i.e. IPv4) addresses</u>.

An administrator with sufficient permissions can create <u>any number of network policies</u>. A network policy is <u>not enabled until it is activated</u> at the account or individual user level. To activate a network policy, modify the account or user properties and apply the network policy to the object. Only a single network policy can be applied to the account or a specific user at a time.

Only security administrators (i.e. users with the `SECURITYADMIN` role) or higher or a role with the global `CREATE NETWORK POLICY` privilege can create network policies.

When a network policy includes values in both the allowed and blocked IP address lists, Snowflake applies the blocked IP address list first.

### Multi-Factor Authentication (MFA)

### Federated authentication
In a federated environment, user authentication is separated from user access through the use of one or more external entities that provide independent authentication of user credentials. The authentication is then passed to one or more services, enabling users to access the services through SSO.

Snowflake supports most SAML 2.0-compliant vendors as an IdP (Identity provider).

### Key pair authentication

### Single Sign-On (SSO)

### 2.1: Practice Questions

What can be used to allow or block connections to a Snowflake account from configured IP addresses?

> A. An authentication policy
>
> B. A masking policy
>
> C. <u>A network policy</u>
>
> D. A security policy

************************************************************************************

## 2.2 Define the entities and roles that are used in Snowflake

### Overview of access control

#### Access control frameworks

Snowflake’s approach to access control combines aspects from both of the following models:

<u>Discretionary Access Control (DAC)</u>: Each object has an owner, who can in turn grant access to that object.

<u>Role-based Access Control (RBAC)</u>: Access privileges are assigned to roles, which are in turn assigned to users.

#### Access control privileges

| Role           | Account Panel | Notifications | Create Shares | Network Policies | Use                    |
|----------------|---------------|----------------|---------------|-------------------|------------------------|
| ACCOUNTADMIN   | ✅ yes         | ✅ yes         | ✅ yes        | ✅ yes            | Top level role          |
| SECURITYADMIN  | ✅ yes         | ❌ no          | ❌ no         | ✅ yes            | Manage users & roles & network policies |
| SYSADMIN       | ❌ no          | ❌ no          | ❌ no         | ❌ no             | Manage objects          |
| USERADMIN      | ❌ no          | ❌ no          | ❌ no         | ❌ no             | Manage users & roles   |
| PUBLIC         | ❌ no          | ❌ no          | ❌ no         | ❌ no             | Lowest role             |
| CUSTOM         | ❌ no          | ❌ no          | ❌ no         | ❌ no             | Depends on assigned privileges |

### Outline how privileges can be granted and revoked

`SHOW GRANTS OF ROLE...` → Lists all users and roles to which the role has been granted.

`SHOW GRANTS TO ROLE...` → Lists all privileges and roles granted to the role. 

### Explain role hierarchy and privilege inheritance

The default system-defined roles in Snowflake:

#### ACCOUNTADMIN

#### SECURITYADMIN

#### ORGADMIN

The organization administrator (`ORGADMIN`) system role is responsible for managing operations at the organization level.

* Create an account in the organization.
* View/show all accounts within the organization.
* View/show a list of regions enabled for the organization.
* View usage information for all accounts in the organization. 
* Enable database replication for an account in the organization.

Snowflake provides historical usage data for all accounts in your organization via views in the `ORGANIZATION_USAGE` schema in a shared database `SNOWFLAKE`.

DDL examples:
* `CREATE ACCOUNT`
* `DROP ACCOUNT`
* `SHOW ORGANIZATION ACCOUNTS`
* `UNDROP ACCOUNT` 

#### USERADMIN

#### SYSADMIN

#### PUBLIC

### 2.2: Practice Questions

A manager has concerns about employees with access to sensitive Snowflake data, and needs to confirm which FINANCE users have been granted the role PAYROLL_VIEW_R.

Which statement will display the information?

> A. <u>SHOW GRANTS OF ROLE PAYROLL_VIEW_R;</u>
>
> B. SELECT GRANTS OF ROLE PAYROLL_VIEW_R;
>
> C. SHOW GRANTS HISTORY for ROLE PAYROLL_VIEW_R;
>
> D. SELECT * from account_usage.GRANTS_OF_ROLES WHERE ROLE = 'PAYROLL_VIEW_R';

************************************************************************************

## 2.3 Outline data governance capabilities in Snowflake

### Accounts

### Organizations

An organization is a first-class Snowflake object that <u>links the accounts owned by your business entity</u>. Organizations simplify account management and billing, Replication and Failover/Failback, Snowflake Secure Data Sharing, and other account administration tasks.

This feature allows organization administrators to <u>view, create, and manage all of your accounts across different regions and cloud platforms</u>.

Benefits:
* A central view of all accounts within your organization.
* Self-service account creation.
* Data availability and durability by leveraging data replication and failover. 
* Seamless data sharing with Snowflake consumers across regions.
* Ability to monitor and understand usage across all accounts in the organization.

### Secure views

### Secure functions
To help ensure that sensitive information is concealed from users who should not have access to it, you can use the `SECURE` keyword when creating a <u>user-defined function (UDF) and stored procedure</u>.

### Information schemas
The Snowflake Information Schema functions as a comprehensive data dictionary. It is a set of views against the metadata layer that make it easy for you to examine some of the information about the databases, schemas, and tables you have built in Snowflake.

The Information Schema is implemented as a schema named `INFORMATION_SCHEMA` that Snowflake automatically creates in every database in an account.

The schema contains the following objects:
- Views for all the objects contained in the database, as well as views for account-level objects (i.e. non-database objects such as roles, warehouses, and databases)
- Table functions for historical and usage data across your account.

### Account usage
The `SNOWFLAKE` database contains information about account usage. It is automatically added by Snowflake to each new account. It is sometimes called the <u>"Account Usage Share"</u> because it is shared by Snowflake with customers.

`LOGIN_HISTORY` view → query <u>login attempts</u> by Snowflake users within the <u>last 365 days (1 year)</u>. Includes IP address where the login request originated from, error code, if the request was not successful and other. <u>Latency for the view may be up to 120 minutes (2 hours)</u>.

`QUERY_HISTORY` view → query Snowflake query history by various dimensions (time range, session, user, warehouse, etc.) within the <u>last 365 days (1 year)</u>. <u>Latency for the view may be up to 45 minutes</u>.

The Account Usage views and the corresponding views (or table functions) in the Snowflake Information Schema utilize identical structures and naming conventions, but with some key differences:

| Difference | Account Usage | Information Schema |
|----|----|----|
| Includes dropped objects | Yes | No |
| Latency of data | From 45 minutes to 3 hours (varies by view) | None |
| Retention of historical data | 1 Year | From 7 days to 6 months (varies by view/table function) |

### Access history; tracking read/write operations
The records in this view facilitate regulatory compliance auditing and provide insights on popular and frequently accessed tables and columns because there is a direct link between the user (i.e. query operator), the query, the table or view, the column, and the data.

Each row in the `ACCESS_HISTORY` view contains a single record per SQL statement. The record contains information about the source columns the query accessed directly and indirectly (i.e. the underlying tables that the data for the query comes from) and the projected columns the user sees in the query result.

Access history in Snowflake provides the following benefits pertaining to read and write operations:
- **Data discovery**: Discover unused data to determine whether to archive or delete the data.
- **Track how sensitive data moves**: Track data movement from an external cloud storage location (e.g. Amazon S3 bucket) to the target Snowflake table, and vice versa. Track internal data movement from a Snowflake table to a different Snowflake table.
- **Data validation**: The accuracy and integrity of reports, dashboards, and data visualization products.
- **Compliance auditing**: Identify the Snowflake user who performed a write operation on a table or stage and when the write operation occurred to meet compliance regulations, such as GDPR and CCPA.
- **Enhance overall data governance**: The `ACCESS_HISTORY` view provides a unified picture of what data was accessed, when the data access took place, and how the accessed data moved from the data source object to the data target object.

### Overview of row/column-level security

### Object tags

### 2.3: Practice Questions

Which statements describe the type of information that INFORMATION_SCHEMA metadata views contain? (Select TWO)

> A. Metadata for micro-partitions
>
> B. Metadata about SQL commands
>
> C. <u>Metadata about database objects</u>
>
> D. <u>Metadata for account level objects</u>
>
> E. Metadata about user rights and grants 

***

Can the LOGIN_HISTORY view in the SNOWFLAKE.ACCOUNT_USAGE schema be used for real-time security alerts?

> A. Yes, because any login attempts are logged in the view.
>
> B. No, because failed login attempts are not logged in the view. 
>
> C. <u>No, because the view is not updated in real time. 
>
> D. No, because the view does not include users that logged in using Single Sign-On (SSO).

***

A company’s security audit requires generating a report listing all Snowflake logins (e.g., date and user) within the last 90 days. Which of the following statements will return the required information?

> A. SELECT LAST_SUCCESS_LOGIN, LOGIN_NAME FROM ACCOUNT_USAGE.USERS;
>
> B. <u>SELECT EVENT_TIMESTAMP, USER_NAME FROM ACCOUNT_USAGE.LOGIN_HISTORY;</u>
>
> C. SELECT EVENT_TIMESTAMP, USER_NAME FROM table(information_schema.login_history_by_user());
>
> D. SELECT EVENT_TIMESTAMP, USER_NAME FROM ACCOUNT_USAGE.ACCESS_HISTORY;

***

Which view in SNOWFLAKE.ACCOUNT_USAGE shows from which IP address a user connected to Snowflake?

> A. <u>LOGIN_HISTORY</u>
>
> B. ACCESS_HISTORY
>
> C. SESSIONS
> 
> D. QUERY_HISTORY

***

What are the key characteristics of ACСOUNT_USAGE views? (Choose two.)

> A. <u>The data latency can vary from 45 minutes to 3 hours</u>
>
> B. The historical data is not retained
>
> C. There is no data latency
> 
> D. <u>Records for dropped objects are included in each view</u>
>
> E. The historical data can be retained from 7 days to 6 months

*** 

What is an organization in Snowflake and what is an example of the benefits of using one?

> A. An organization provides a mechanism for the customer to classify data categories across tables and databases.
>
> B. An organization allows a customer to manage account objects such as databases, schemas, tables, and views and to organize them easily. 
>
> C. An organization allows a customer to self-manage Snowflake account creation including synching users, roles, and databases across Snowflake accounts.
>
> D. <u> An organization allows a customer to conduct self-service Snowflake account creation and also self-manage and monitor those accounts individually and as a group across all accounts</u>.