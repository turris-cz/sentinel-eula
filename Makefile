MAKEFLAGS += --no-builtin-rules

EULAS:=$(wildcard eulas/*.txt)
DESTDIR?=/usr/share/sentinel-eula/
LIST:=EULAs.csv

.PHONY: all clean

all: $(LIST)

$(LIST): $(EULAS)
	for filename in $^; do \
		eula_file="$$(basename "$$filename")"; \
		echo "$${eula_file%.*},\"$$eula_file\" "; \
	done > "$@"

install: $(EULAS) $(LIST)
	install -d $(DESTDIR)
	install -t $(DESTDIR) $^

clean:
	rm -f $(LIST)
