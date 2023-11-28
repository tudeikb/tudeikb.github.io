---
layout: default
title: Semi-Structured Data
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

#### FLATTEN command
{: .fs-5 }

> What columns are returned when performing a FLATTEN command on semi-structured data? (Choose two.)
>
> ✅ **VALUE**
> 
> ✅ **KEY**
>
> ❌ ROOT
> 
> ❌ LEVEL
>
> ❌ NODE

*** 

The FLATTEN command in Snowflake is used to handle semi-structured data types like JSON, Avro, ORC, Parquet, or XML (`VARIANT`, `OBJECT` or `ARRAY` data type). It effectively "flattens" nested data structures into a format that can be easily queried with SQL.

`FLATTEN` can be used to convert semi-structured data to a relational representation.

The returned rows consist of a fixed set of columns:
```
+-----+------+------+-------+-------+------+
| SEQ |  KEY | PATH | INDEX | VALUE | THIS |
|-----+------+------+-------+-------+------|
```

`SEQ`: A unique sequence number associated with the input record; the sequence is not guaranteed to be gap-free or ordered in any particular way.

`KEY`: For maps or objects, this column contains the key to the exploded value.

`PATH`: The path to the element within a data structure which needs to be flattened.

`INDEX`: The index of the element, if it is an array; otherwise NULL.

`VALUE`: The value of the element of the flattened array/object.

`THIS`: The element being flattened (useful in recursive flattening).

***

#### VARIANT data type

> What is the recommended Snowflake data type to store semi-structured data like JSON?
>
> ❌ RAW
> 
> ✅ **VARIANT**
>
> ❌ LOB
>
> ❌ VARCHAR

***

Semi-structured data is saved as `VARIANT` type in Snowflake tables, with a maximum limit size of 16MB, and it can be queried using JSON notation. You can store arrays, objects, etc.

***

> What is the purpose of using the OBJECT_CONSTRUCT function with the COPY INTO command?
>
> ❌ Reorder the data columns according to a target table definition and then unload the rows into the table.
>
> ❌ Reorder the rows in a relational table and then unload the rows into a file. 
>
> ✅ Convert the rows in a relational table to a single VARIANT column and then unload the rows into a file. 
>
> ❌ Convert the rows in a source file to a single VARIANT column and then load the rows from the file to a variant table.

***

An `OBJECT` can contain semi-structured data and can be used to create hierarchical data structures.

`OBJECT_CONSTRUCT` returns a `VARIANT` object, essentially a JSON document, as an output, with either the key:value pairs as inputs or an asterisk (as in `SELECT *`) from a relational query.

You can use the `OBJECT_CONSTRUCT` function combined with the `COPY` command to convert the rows in a relational table to a single `VARIANT` column and unload the rows into a file.

***