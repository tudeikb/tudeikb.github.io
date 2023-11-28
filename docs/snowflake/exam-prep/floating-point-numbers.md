---
layout: default
title: Floating-point numbers
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

> Which file format will keep floating-point numbers from being truncated when data is unloaded?
>
> ❌ JSON
>
> ❌ ORC
>
> ✅ **Parquet**
> 
> ❌ CSV

***

The data types such as FLOAT/DOUBLE/REAL (underlying using DOUBLE ), all are approximate values, they are all stored as DOUBLE which has a precision/scale of 15/9. When we are unloading floats/doubles, columns are unloaded to CSV or JSON files, Snowflake truncates the values to approximately (15,9). Precision is always not accurate. Snowflake can’t precisely represent any arbitrary value with double precision, it's as per industry standard. 

When floating-point number columns are unloaded to CSV or JSON files, Snowflake truncates the values to approximately (15,9).

The values are **not** truncated when unloading floating-point number columns to Parquet files.

Parquet, a columnar storage file format, is designed to efficiently store and retrieve data. When floating-point numbers are stored in Parquet files, they are typically stored in their binary representation as defined by the IEEE standards (usually IEEE 754). This binary representation is designed to preserve the precision and range of the floating-point numbers.


