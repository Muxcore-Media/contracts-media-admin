.PHONY: build test lint clean fmt tidy proto

GO ?= go

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

# go_package points at gen/... — do not use paths=source_relative here.
proto:
	protoc --go_out=. --go-grpc_out=. \
		-I proto proto/muxcore/media/admin/v1/media_admin.proto

ci: lint test build
