.PHONY: scripts data

requirements:
	conda env create -f environment.yml

freeze:
	conda env export | grep -v "^prefix: " > environment-freeze.yml

precommit:
	cp .precommithook .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit

data: \
	_data/titanic.csv

_data/titanic.csv:
	wget -O _data/titanic.csv https://query.data.world/s/if4ykslee7vgdydwtf22xdazmfik6m
	sed -i.bak '/,,,,,,,,,,,,,/d' _data/titanic.csv && rm _data/titanic.csv.bak

scripts:
	for dir in [!_]*/; do \
		python -m nbautoexport export $$dir; \
	done
