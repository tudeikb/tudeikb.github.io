---
layout: default
title: Virtual Warehouses
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

#### Standard vs Economy Scaling Policy
{: .fs-5 }

> How should a virtual warehouse be configured if a user wants to ensure that additional multi-clusters are resumed with the shortest delay possible?
> {: .fs-4 } 
> {: .fw-300 }
> ❌ Set the minimum and maximum clusters to autoscale
> {: .fs-3 } 
> {: .fw-300 }
> ❌ Use the economy warehouse scaling policy
> {: .fs-3 } 
> {: .fw-300 }
> ❌ Configure the warehouse to a size larger than generally required
> {: .fs-3 } 
> {: .fw-300 }
> ✅ **Use the standard warehouse scaling policy**
> {: .fs-3 } 
> {: .fw-300 }

***

#### Auto-resume and Auto-suspend options
{: .fs-5 }

> Which of the following are options when creating a Virtual Warehouse? (Choose two.)
> {: .fs-4 } 
> {: .fw-300 }
> ❌ Auto-enable
> {: .fs-3 } 
> {: .fw-300 }
> ❌ Auto-drop
> {: .fs-3 } 
> {: .fw-300 }
> ❌ Auto-disable
> {: .fs-3 } 
> {: .fw-300 }
> ✅ **Auto-resume**
> {: .fs-3 } 
> {: .fw-300 }
> ❌ Auto-resize
> {: .fs-3 } 
> {: .fw-300 }
> ✅ **Auto-suspend**
> {: .fs-3 } 
> {: .fw-300 }

***

#### Multi-cluster warehouses
{: .fs-5 }

Enterprise edition
{: .label .label-blue } 

> How can a Snowflake user configure a virtual warehouse to support over 100 users if their company has Enterprise Edition?
> {: .fs-4 } 
> {: .fw-300 }
> ❌ Add additional warehouses and configure them as cluster.
> {: .fs-3 } 
> {: .fw-300 }
> ❌ Set the auto-scale to 100.
> {: .fs-3 } 
> {: .fw-300 }
> ✅ **Use a multi-cluster warehouse.**
> {: .fs-3 } 
> {: .fw-300 }
> ❌ Use a larger warehouse.
> {: .fs-3 } 
> {: .fw-300 }

Multi-cluster warehouses are designed specifically for handling **queuing and performance** issues related to **large numbers of concurrent users and/or queries**. In addition, multi-cluster warehouses can help automate this process if your number of users/queries tend to fluctuate.
{: .fw-300 }

***






