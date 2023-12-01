---
layout: default
title: Cache
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

> Query results are stored in the Result Cache for how long after they are last accessed, assuming no data changes have occurred?
>
> ❌ 3 hours
>
> ❌ 12 hours
>
> ❌ 1 hour
> 
> ✅ **24 hours**

***

> A deterministic query is run at 8am, takes 5 minutes, and the results are cached. Which of the following statements are true? (Choose two.)
>
> ✅ **The same exact query will return the precomputed results if the underlying data hasn't changed and the results were last accessed within previous 24 hour period**
>
> ❌ The same exact query will return the precomputed results even if the underlying data has changed as long as the results were last accessed within the previous 24 hour period
>
> ❌ Snowflake edition is Enterprise or higher
> 
> ✅ **The 24 hours timer on the precomputed results gets renewed every time the exact query is executed**
>
> ❌ The exact query will ALWAYS return the precomputed result set for the RESULT_CACHE_ACTIVE = time_period
