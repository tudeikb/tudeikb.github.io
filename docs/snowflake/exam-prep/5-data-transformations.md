---
layout: default
title: "Domain 5.0: Data Transformations"
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

## 5.1 Explain how to work with standard data
### Estimation functions 

[Snowflake Estimating Functions](https://www.in516ht.com/snowflake-estimating-functions/)

[Similarity Estimation](https://docs.snowflake.com/en/user-guide/querying-approximate-similarity)

[Frequency Estimation](https://docs.snowflake.com/en/user-guide/querying-approximate-frequent-values)

[Estimating Percentile Values](https://docs.snowflake.com/en/user-guide/querying-approximate-percentile-values)


Similarity of Two or More Sets → Snowflake uses <u>MinHash</u> for estimating the approximate similarity between two or more data sets. The MinHash scheme compares sets without computing the intersection or union of the sets, which enables efficient and effective estimation. Result: a value between 0 and 1 that tells us how similar or dissimilar two tables are. Implemented in the `APPROXIMATE_SIMILARITY` function.

Frequent Values → Snowflake uses the <u>Space-Saving algorithm</u>, a space and time efficient way of estimating approximate frequent values in data sets. Implemented in the `APPROX_TOP_K` function.

Percentile Values → Snowflake uses an improved version of the <u>t-Digest algorithm</u>, a space and time efficient way of estimating approximate percentile values in data sets. Implemented in the `APPROX_PERCENTILE` function.

### Sampling

[SAMPLE](https://docs.snowflake.com/en/sql-reference/constructs/sample)

`SAMPLE / TABLESAMPLE` → Returns a subset of rows sampled randomly from the specified table.

Two methods are supported:
- <u>Fraction-based</u>: Sample a fraction of a table, with a specified probability for including a given row. The number of rows returned depends on the size of the table and the requested probability. A seed can be specified to make the sampling deterministic.
- <u>Fixed-sized</u>: Sample a fixed, specified number of rows. The exact number of specified rows is returned unless the table contains fewer rows.





## 5.3 Explain how to work with unstructured data
Define and use directory tables
(see Domain 1.0 > 1.3 > Stages)


SQL file functions. Types of URLs available to access files.
Both external (external cloud storage) and internal (i.e. Snowflake) stages support unstructured data. 

Scoped URL → Encoded URL that permits temporary access to a staged file without granting privileges to the stage. The URL expires when the persisted query result period ends (i.e. the results cache expires), which is currently 24 hours.
Generate: query the BUILD_SCOPED_FILE_URL function

File URL → URL that identifies the database, schema, stage, and file path to a set of files. A role that has sufficient privileges on the stage can access the files.
Generate: query the BUILD_STAGE_FILE_URL function or query the directory table for the stage that references the staged files
Pre-signed URL → Simple HTTPS URL used to access a file via a web browser. A file is temporarily accessible to users via this URL using a pre-signed access token. The expiration time for the access token is configurable.
Generate: Query the GET_PRESIGNED_URL function.


## Practice questions
A table needs to be loaded. The input data is in a JSON format and is a concatenation of multiple JSON documents. The file size is 3 GB. A virtual warehouse size Small is being used. The following COPY INTO command was executed:

COPY INTO SAMPLE FROM @~SAMPLE.JSON (TYPE=JSON)

The load failed with this error:

Max LOB size (16777216) exceeded, actual size of parsed column is 17894470.

How can this issue be resolved?

> A. Use a larger-sized warehouse.
> 
> B. Compress the file and load the compressed file.
> 
> C. Set STRIP_OUTER_ARRAY=TRUE in the COPY INTO command.
> 
> D. <u>Split the file into multiple files in the recommended size range (100 MB - 250 MB).</u>

***

Which file functions are non-deterministic? (Select TWO)

> A. <u>BUILD_SCOPED_FILE_URL</u>
>
> B. BUILD_STAGE_FILE_URL
>
> C. GET_ABSOLUTE_PATH
> 
> D. <u>GET_PRESIGNED_URL</u>
>
> E. GET_RELATIVE_PATH
