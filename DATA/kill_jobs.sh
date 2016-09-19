#!/bin/bash


PTH="./data/S0.900/data/S1"

jobs=$PTH/jobs_list
#echo "Closing: " $jobs

scancel -v `awk '{print $4}' $jobs`

