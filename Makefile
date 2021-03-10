.PHONY: data docs requirements

requirements:
	conda env update -f environment.yml --prune

# Generate symlinks from notebooks to docs
.docs/docs/%:
	ln -sf --relative $(notdir $@)/ $@

symlinks: .docs/docs/data-frame-creation .docs/docs/data-frame-manipulation .docs/docs/plotting

docs:
	cp README.md .docs/docs/index.md
	cd .docs && mkdocs build

freeze:
	conda env export | grep -v "^prefix: " > environment-freeze.yml

precommit:
	cp .precommithook .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit

data: .data/titanic.csv

.data/titanic.csv:
	wget -O .data/titanic.csv https://query.data.world/s/if4ykslee7vgdydwtf22xdazmfik6m
	sed -i.bak '/,,,,,,,,,,,,,/d' .data/titanic.csv && rm .data/titanic.csv.bak

scripts:
	for dir in [!.]*/; do \
		python -m nbautoexport export $$dir; \
	done

test:
	bash tests.sh
