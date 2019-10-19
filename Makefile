.PHONY: scripts test

export-env:
	conda env export -n rosetta-stone --no-builds | grep -v "^prefix: " > environment.yml

_data/titanic.csv:
	wget -O _data/titanic.csv https://query.data.world/s/if4ykslee7vgdydwtf22xdazmfik6m
	sed -i.bak '/,,,,,,,,,,,,,/d' _data/titanic.csv && rm _data/titanic.csv.bak

scripts:
	for nbfile in */*.ipynb; do \
		jupyter nbconvert --to script $$nbfile --output-dir $$(dirname $$nbfile)/scripts; \
	done

test:
	for pyscript in */scripts/*.py; do \
		echo "=== Testing $$pyscript ==="; \
		(cd $$(dirname $$pyscript) && cd .. && python scripts/$$(basename $$pyscript)); \
		echo ""; \
	done
	for rscript in */scripts/*.r; do \
		echo "=== Testing $$rscript ==="; \
		(cd $$(dirname $$rscript) && cd .. && Rscript scripts/$$(basename $$rscript)); \
		echo ""; \
	done
