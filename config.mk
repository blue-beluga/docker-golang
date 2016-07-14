export GIT_REVISION=$(shell git rev-parse --short HEAD)

REGISTRY = docker.io
REPOSITORY = bluebeluga/golang

PUSH_REGISTRIES = $(REGISTRY)
PUSH_TAGS = $(TAG) go-$(TAG)
