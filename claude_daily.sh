#!/bin/bash

# Get today's date in MM-DD format  
today=$(date +%m-%d)

# Get daily usage for today - look for the date row and get the cost from the previous row
usage=$(ccusage daily 2>/dev/null | sed 's/\x1b\[[0-9;]*m//g' | grep -B1 " ${today} " | head -1 | grep -oE '\$[0-9]+\.[0-9]+' | tail -1)

# Check if we got a valid result
if [ -z "$usage" ]; then
    echo "D: $0"
else
    # Extract the number without dollar sign and round down
    num=$(echo "$usage" | sed 's/\$//')
    rounded=$(echo "$num" | cut -d'.' -f1)
    echo "D: \$${rounded}"
fi