.EXPORT_ALL_VARIABLES:

# Keep docker before podman due to:
# https://github.com/containers/podman/issues/7602
ENGINE ?= $(shell command -v docker podman|head -n1)
IMAGE_TAG=localhost/toolset

all: deps
	$(ENGINE) build -t $(IMAGE_TAG) .
	@echo "Image size: $$($(ENGINE) image inspect --format='scale=0; {{.Size}}/1024/1024' $(IMAGE_TAG) | bc)MB"

deps:
	tox -e deps
