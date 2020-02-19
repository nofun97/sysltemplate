all: sysl

input = simple.sysl
app = simple
down = mydependency # this can be a list separated by a space





####################################################################
#                                                                  #
#                                                                  #
#                                                                  #
# START SYSL MAKEFILE: you shouldn't need to edit anything below   #
#                                                                  #
#                                                                  #
#                                                                  #
####################################################################

TMP = .tmp# Cache the server lib directory in tmp
SERVERLIB = /var/tmp
TRANSLOCATION = .tmp/server-lib/codegen/transforms
TRANSFORMS= svc_error_types.sysl svc_handler.sysl svc_interface.sysl svc_router.sysl svc_types.sysl
DOWNSTREAMTRANSFORMS = svc_client.sysl svc_error_types.sysl svc_types.sysl
GRAMMAR=$(wildcard .tmp/server-lib/codegen/grammars/go.gen.g)
START=goFile


# Always execute these with just `make`
.PHONY: setup clean gen
sysl: setup gen downstream format tmp

# try to clone, then try to fetch and pull
setup:
	# Syncing server-lib to $(SERVERLIB)
	git clone https://github.service.anz/sysl/server-lib/ $(SERVERLIB)/server-lib || true  # Don't fail
	cd  $(SERVERLIB)/server-lib && git fetch && git checkout tags/v0.1.9 || true
	mkdir -p $(TMP)/server-lib/
	mkdir -p gen/${app}
	# Copying server-lib to $(TMP)
	cp -rf $(SERVERLIB)/server-lib $(TMP)/
	$(foreach path, $(down), $(shell mkdir -p gen/$(path)))
    $(foreach path, $(app), $(shell mkdir -p gen/$(path)))

# Grab the import path for sysl from the go mod (in the same directory)
goModLocation = go.mod
goMod = $(shell cat $(goModLocation) | grep module | sed 's/module//' | sed -e 's/^[[:space:]]*//')


# Generate files with internal git service
gen:
	$(foreach file, $(TRANSFORMS), $(shell sysl codegen --basepath=$(goMod)/gen --transform $(TRANSLOCATION)/$(file) --grammar ${GRAMMAR} --start ${START} --outdir=gen/${app} --app-name ${app} $(input)))

downstream:
	$(foreach file, $(DOWNSTREAMTRANSFORMS), $(foreach downstream, $(down), $(shell sysl codegen --transform $(TRANSLOCATION)/$(file) --grammar ${GRAMMAR} --start ${START} --outdir=gen/${downstream} --app-name ${downstream} $(input))))

format:
	gofmt -s -w gen/${app}/*
	goimports -w gen/${app}/*
	$(foreach path, $(down), $(shell gofmt -s -w gen/${path}/*))
	$(foreach path, $(down), $(shell goimports -w gen/${path}/*))


# Remove the tmp directory after
tmp:
	rm -rf $(TMP)

# Remove the generated files
clean:
	rm -rf ${app}