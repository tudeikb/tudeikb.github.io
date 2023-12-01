---
layout: default
title: Data Sharing
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

> How does Snowflake allow a data provider with an Azure account in central Canada to share data with a data consumer on AWS in Australia?
>
> ❌ The data provider in Azure Central Canada can create a direct share to AWS Asia Pacific, if they are both in the same organization.
>
> ❌ The data provider uses the GET DATA workflow in the Snowflake Data Marketplace to create a share between Azure Central Canada and AWS Asia Pacific
>
> ✅ **The data provider must replicate the database to a secondary account in AWS Asia Pacific within the same organization then create a share to the data consumer's account**
> 
> ❌ The data consumer and data provider can form a Data Exchange within the same organization to create a share from Azure Central Canada to AWS Asia Pacific