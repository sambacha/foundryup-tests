VERSION?=
CHANNEL?=

VOLUME_MOUNTS=-v "$(CURDIR)":/v
SHELLCHECK_EXCLUSIONS=$(addprefix -e, SC1091 SC1117)
SHELLCHECK=docker run --rm $(VOLUME_MOUNTS) -w /v koalaman/shellcheck $(SHELLCHECK_EXCLUSIONS)

ENVSUBST_VARS=LOAD_SCRIPT_COMMIT_SHA

.PHONY: build
build: foundryup/install

foundryup/install: install
	mkdir -p $(@D)
	LOAD_SCRIPT_COMMIT_SHA='$(shell git rev-parse HEAD)' envsubst '$(addprefix $$,$(ENVSUBST_VARS))' < $< > $@

.PHONY: clean
clean:
	$(RM) -r build/