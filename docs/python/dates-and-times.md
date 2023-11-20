---
layout: default
title: Dates and Times
parent: Python
nav_order: 2
---

#### Calculate the time difference 

```python
from datetime import datetime

# Define the time format
time_format = "%H:%M:%S"

# Define the two times
time1 = datetime.strptime("13:33:57", time_format)
time2 = datetime.strptime("13:34:32", time_format)

# Calculate the difference between the two times
time_difference = time2 - time1
time_difference.seconds
```
