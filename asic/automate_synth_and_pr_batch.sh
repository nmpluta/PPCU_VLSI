#!/bin/bash

cd synth
# run synthesis script
./run_synth.sh

cd ../pr
# run place and route script in batch mode
./run_pr_batch.sh

