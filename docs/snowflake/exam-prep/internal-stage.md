---
layout: default
title: Internal Stage
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

> Which command will we use to download the files from the stage / location loaded through the `COPY INTO <LOCATION>` command?
>
> ❌ INSERT INTO
> 
> ❌ UNLOAD
> 
> ✅ **GET**
> 
> ❌ PUT

*** 

We will use the `GET` command to DOWNLOAD files from a Snowflake internal stage (named internal stage, user stage, or table stage) into a directory / folder on a client machine. You need to use SnowSQL to use this command.

***

> What is the use of the `OVERWRITE=TRUE` option in the `PUT` command?
>
> ❌ It is not possible to use `OVERWRITE=TRUE` option with `PUT` command.
> 
> ❌ It specified whether Snowflake should overwrite the gzip compress algorithm with another one that you provide. 
> 
> ❌ It specified whether Snowflake overwrites the encryption key you used to upload the files.
> 
> ✅ **It specified whether Snowflake overwrites an existing file with the same name during upload.**

*** 

The `OVERWRITE=TRUE` option in the Snowflake `PUT` command is used to overwrite an existing file with the same name in the target location. Imagine you run the following command:

`PUT file:///tmp/data/mydata.csv @my_int_stage;`

If there is a file called "mydata.csv" in the stage, it won't load it. However, using the `OVERWRITE` option, it will load it:

`PUT file:///tmp/data/mydata.csv @my_int_stage OVERWRITE=TRUE;`




