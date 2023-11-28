---
layout: default
title: Query Profile
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

#### What does query profile provide
{: .fs-5 }

> What does a Query Profile provide in Snowflake?
> 
> 🤔 A collapsible panel in the operator tree pane that lists nodes by execution time in descending order for a query. 🤔
> 
> ❌ A multi-step query that displays each processing step in the same panel.
> 
> ✅ **A graphical representation of the main components of the processing plan for a query.**
> 
> ❌ A pre-computed data set derived from a query specification and stored for later use.

*** 
Query profile interface elements:
* **Steps**: If the query was processed in multiple steps, you can toggle between each step.

* **Operator tree**: The middle pane displays a graphical representation of all the operator nodes for the selected step, including the relationships between each operator node.

* **Node list**: The middle pane includes a collapsible list of operator nodes by execution time.

* **Overview**: The right pane displays an overview of the query profile. The display changes to operator details when an operator node is selected.

***
An operator tree is a visual representation of the sequence of operations (or steps) that a database management system performs to execute a SQL query. Each node in the tree represents a specific operation, such as a table scan, join, sort, or aggregation.

A collapsible panel in the operator tree pane lists nodes by execution time in descending order, enabling users to quickly locate the costliest operator nodes in terms of execution time.


