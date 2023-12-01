---
layout: default
title: Materialized Views
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

> A Snowflake user wants to optimize performance for a query that queries only a small number of rows in a table. The rows require significant processing. The data in the table does not change frequently. What should the user do?
>
> ✅ **Create a materialized view based on the query.**
>
> ❌ Add the search optimization service to the table. 
>
> ❌ Enable the query acceleration service for the virtual warehouse.
>
> ❌ Add a clustering key to the table.

***

Materialized views are particularly useful when:

- Query results contain a small number of rows and/or columns relative to the base table (the table on which the view is defined).
- Query results contain results that require significant processing, including:
  - Analysis of semi-structured data.
  - Aggregates that take a long time to calculate.
- The query is on an external table (i.e. data sets stored in files in an external stage), which might have slower performance compared to querying native database tables.
- The view’s base table does not change frequently.
