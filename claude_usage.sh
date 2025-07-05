#!/bin/bash

# Get current month in YYYY-MM format
current_month=$(date +%Y-%m)

# Get monthly usage for current month, stripping ANSI codes and extracting the cost
usage=$(ccusage monthly 2>/dev/null | sed 's/\x1b\[[0-9;]*m//g' | grep " ${current_month} " | grep -oE '\$[0-9]+\.[0-9]+' | tail -1)

# Check if we got a valid result
if [ -z "$usage" ]; then
    echo "M: $0"
else
    # Extract the number without dollar sign and round down
    num=$(echo "$usage" | sed 's/\$//')
    rounded=$(echo "$num" | cut -d'.' -f1)
    echo "M: \$${rounded}"
fi