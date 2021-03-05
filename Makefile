
MAIN_PATH=main.go
BUILD_PATH=build/
LINUX_BINARY_NAME=yamlsplit_linux
DARWIN_BINARY_NAME=yamlsplit_darwin
# export YAMLSPLIT_COMMIT_HASH="$(git rev-parse HEAD)"
GIT_COMMIT_HASH=${YAMLSPLIT_COMMIT_HASH}
# export YAMLSPLIT_VERSION="x.x.x"
VERSION=${YAMLSPLIT_VERSION}
GOARCH ?= amd64

build:
	make build-linux
	make build-darwin

build-linux:
	GOOS=linux GOARCH=amd64 go build -o $(BUILD_PATH)$(LINUX_BINARY_NAME) -v $(MAIN_PATH)

build-darwin:
	GOOS=darwin GOARCH=amd64 go build -o $(BUILD_PATH)$(DARWIN_BINARY_NAME) -v $(MAIN_PATH)


releases:
	make build-rel-linux
	make build-rel-darwin

check-env:
ifndef YAMLSPLIT_COMMIT_HASH
  $(error YAMLSPLIT_COMMIT_HASH is not set)
endif
ifndef YAMLSPLIT_VERSION
	$(error YAMLSPLIT_VERSION is not set)
endif

build-rel-linux: check-env
	GOOS=linux GOARCH=$(GOARCH) go build \
			-ldflags '-X github.com/komish/yamlsplit/version.Version=$(VERSION) -X github.com/komish/yamlsplit/version.CommitHash=$(GIT_COMMIT_HASH)' \
		 	-o $(BUILD_PATH)$(LINUX_BINARY_NAME)_$(GOARCH)_$(VERSION) -v $(MAIN_PATH)

build-rel-darwin: check-env
	GOOS=darwin GOARCH=$(GOARCH) go build \
			 -ldflags '-X github.com/komish/yamlsplit/version.Version=$(VERSION) -X github.com/komish/yamlsplit/version.CommitHash=$(GIT_COMMIT_HASH)' \
			 -o $(BUILD_PATH)$(DARWIN_BINARY_NAME)_$(GOARCH)_$(VERSION) -v $(MAIN_PATH)

clean:
	rm -rf $(BUILD_PATH)
