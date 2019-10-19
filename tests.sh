#!/bin/bash

# Failures exit immediately
set -e

for pyscript in */scripts/*.py; do
    echo "=== Testing $pyscript ==="
    (cd $(dirname $pyscript) && cd .. && python scripts/$(basename $pyscript))
    echo ""
done
for rscript in */scripts/*.r; do \
    echo "=== Testing $rscript ==="
    (cd $(dirname $rscript) && cd .. && Rscript scripts/$(basename $rscript))
    echo ""
done
