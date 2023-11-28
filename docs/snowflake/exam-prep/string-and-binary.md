---
layout: default
title: String & Binary
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

#### SPLIT_TO_TABLE
{: .fs-5 }

> What is the purpose of the Snowflake SPLIT_TO_TABLE function?
>
> ✅ **To split a string and flatten the results into rows**
>
> ❌ To split a string and flatten the results into columns
> 
> ❌ To split a string into an array of sub-strings
>
> ❌ To count the number of characters in a string

*** 

`SPLIT_TO_TABLE`: This table function splits a string (based on a specified delimiter) and **flattens the results into rows**.

The returned rows consist of a fixed set of columns:

```
+-----+-------+-------+
| SEQ | INDEX | VALUE |
|-----+-------+-------|
```

`SEQ`: A unique sequence number associated with the input record; the sequence is not guaranteed to be gap-free or ordered in any particular way.

`INDEX`: The index of the element. One based.

`VALUE`: The value of the element of the flattened array.

***

`SPLIT`: Splits a given string with a given separator and returns the result in an **array of strings**.



