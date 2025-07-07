#!/bin/bash

# Get today's date in MM-DD format  
today=$(date +%m-%d)

# Get daily usage for today
# The table format has year and date on separate lines in the first column
# The cost is in the last column of the row with the year
usage=$(ccusage daily 2>/dev/null | grep -B1 "${today}" | head -1 | grep -oE '\$[0-9]+\.[0-9]+' | tail -1)

# Check if we got a valid result
if [ -z "$usage" ]; then
    echo "D:--"
else
    # Extract the number without dollar sign and round down
    num=$(echo "$usage" | sed 's/\$//')
    rounded=$(echo "$num" | cut -d'.' -f1)
    echo "D:\$${rounded}"
fi
