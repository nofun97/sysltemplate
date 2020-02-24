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
out = gen
TMP = .tmp# Cache the server lib directory in tmp
SERVERLIB = /var/tmp
# SERVERLIB = /Users/allanadn/work/github.service.anz/sysl/
TRANSLOCATION = .tmp/server-lib/codegen/transforms
TRANSFORMS= svc_error_types.sysl svc_handler.sysl svc_interface.sysl svc_router.sysl svc_types.sysl
DOWNSTREAMTRANSFORMS = svc_client.sysl svc_error_types.sysl svc_types.sysl
GRAMMAR=$(wildcard .tmp/server-lib/codegen/grammars/go.gen.g)
START=goFile


# Always execute these with just `make`
.PHONY: setup clean gen
sysl: setup gen downstream format tmp build

# try to clone, then try to fetch and pull
setup:
	# Syncing server-lib to $(SERVERLIB)
	git clone https://github.service.anz/allanadn/server-lib/ $(SERVERLIB)/server-lib || true  # Don't fail
	cd  $(SERVERLIB)/server-lib && git fetch && git checkout rest-ui || true
	mkdir -p $(TMP)/server-lib/
	mkdir -p ${out}/${app}
	# Copying server-lib to $(TMP)
	cp -rf $(SERVERLIB)/server-lib $(TMP)/
	$(foreach path, $(down), $(shell mkdir -p ${out}/$(path)))
    $(foreach path, $(app), $(shell mkdir -p ${out}/$(path)))

# Grab the import path for sysl from the go mod (in the same directory)
goMod = $(shell cat go.mod | grep module | sed 's/module//' | sed -e 's/^[[:space:]]*//')


# Generate files with internal git service
gen:
	$(foreach file, $(TRANSFORMS), $(shell sysl codegen --basepath=$(goMod)/${out} --transform $(TRANSLOCATION)/$(file) --grammar ${GRAMMAR} --start ${START} --outdir=${out}/${app} --app-name ${app} $(input)))
	$(shell sysl export -f "swagger" -o gen/model/out.json --app-name ${app} $(input))
	# $(shell resources -help || go get github.com/omeid/go-resources/cmd/resources)
	$(shell cd gen/model && resources -declare -var=swaggerFile -output=../${app}/swagger_file.go -package=${app} out.json && cd ../../)

downstream:
	$(foreach file, $(DOWNSTREAMTRANSFORMS), $(foreach downstream, $(down), $(shell sysl codegen --basepath=$(goMod)/${out} --transform $(TRANSLOCATION)/$(file) --grammar ${GRAMMAR} --start ${START} --outdir=${out}/${downstream} --app-name ${downstream} $(input))))

format:
	gofmt -s -w ${out}/${app}/*
	goimports -w ${out}/${app}/*
	$(foreach path, $(down), $(shell gofmt -s -w ${out}/${path}/*))
	$(foreach path, $(down), $(shell goimports -w ${out}/${path}/*))

build:
	go build -o ${app}

# Remove the tmp directory after
tmp:
	rm -rf $(TMP)

# Remove the generated files
clean:
	rm -rf ${app}