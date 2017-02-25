#!/bin/bash

cd data
for i in S*; do
    PTH="$i/data/S1"
    jobs=$PTH/jobs_list
    echo "Closing: " $jobs
    scancel -v `awk '{print $4}' $jobs`
done
