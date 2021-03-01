#!/bin/bash

# Failures exit immediately
set -e

for pyscript in */script/*.py; do
    echo "=== Testing $pyscript ==="
    python $pyscript
    echo ""
done
for rscript in */script/*.r; do \
    echo "=== Testing $rscript ==="
    Rscript $rscript
    echo ""
done

echo "Tests passed."
