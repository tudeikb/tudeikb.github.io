---
layout: default
title: Snowpipe
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

#### Recreate pipe
{: .fs-5 }

> When a Pipe is recreated using the CREATE OR REPLACE PIPE command:
> 
> ❌ Previously loaded files will be ignored
> 
> ✅ **The pipe load history is reset to empty**
> 
> ❌ Previously loaded files will be purged 
>
> ❌ The refresh parameter is set to true

*** 

Recreating a pipe (using a `CREATE OR REPLACE PIPE` statement) is necessary to modify most pipe properties.

The load history for Snowpipe operations is stored in the metadata of the pipe object. When a pipe is recreated, the load history is dropped.

$$\Rightarrow$$ The newly created pipe has no knowledge of previously loaded files so it cannot ignore them. Due to the same reason files cannot be purged (= removed, deleted).

There is no refresh paramterer. There is either a `PIPE_EXECUTION_PAUSED` parameter or refresh clause.

***

#### Snowpipe via REST API
{: .fs-5 }

> Which of the following is true of Snowpipe via REST API? (Choose two.)
> 
> ❌ Snowpipe removes files after they have been loaded
> 
> ✅ **Snowpipe keeps track of which files it has loaded**
> 
> ❌ All COPY INTO options are available during pipe creation
>
> ✅ **Snowflake automatically manages the compute required to execute the Pipe's COPY INTO commands**
>
> ❌ You can only use it on Internal Stages

***

All these answers concern Snowpipe in general, whether via REST API or not. 

As per [documentation](https://docs.snowflake.com/en/sql-reference/sql/create-pipe#usage-notes): all `COPY INTO <table>` copy options are supported except for the following (...)






