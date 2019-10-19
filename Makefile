.PHONY: scripts data

data: \
	_data/titanic.csv

_data/titanic.csv:
	wget -O _data/titanic.csv https://query.data.world/s/if4ykslee7vgdydwtf22xdazmfik6m
	sed -i.bak '/,,,,,,,,,,,,,/d' _data/titanic.csv && rm _data/titanic.csv.bak

scripts:
	for nbfile in */*.ipynb; do \
		jupyter nbconvert --to script $$nbfile --output-dir $$(dirname $$nbfile)/scripts; \
	done
