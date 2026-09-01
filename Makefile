.PHONY: build test lint clean fmt tidy proto ci

GO ?= go
PROTOC_GEN_GO_VERSION ?= v1.36.6
PROTOC_GEN_GO_GRPC_VERSION ?= v1.5.1

build:
	$(GO) build ./...

test:
	$(GO) test -count=1 -timeout 60s ./...

lint:
	$(GO) vet ./...

clean:
	rm -f gen/muxcore/media/admin/v1/*.go

fmt:
	$(GO) fmt ./...

tidy:
	$(GO) mod tidy

# go_package points at gen/... — strip module prefix; do not use paths=source_relative.
proto:
	$(GO) install google.golang.org/protobuf/cmd/protoc-gen-go@$(PROTOC_GEN_GO_VERSION)
	$(GO) install google.golang.org/grpc/cmd/protoc-gen-go-grpc@$(PROTOC_GEN_GO_GRPC_VERSION)
	PATH="$$(go env GOPATH)/bin:$$PATH" protoc \
		--go_out=. --go_opt=module=github.com/Muxcore-Media/contracts-media-admin \
		--go-grpc_out=. --go-grpc_opt=module=github.com/Muxcore-Media/contracts-media-admin \
		-I proto proto/muxcore/media/admin/v1/media_admin.proto

ci: lint test build
