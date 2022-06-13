TOPDIR=$(dir $(lastword $(MAKEFILE_LIST)))

PROJECT_NAME=kafka-cli-oauth

DOCKERFILE_DIR     ?= ./
DOCKER_CMD         ?= docker
DOCKER_REGISTRY    ?= docker.io
DOCKER_ORG         ?= strimzi
STRIMZI_RELEASE    ?= 0.27.1-kafka-3.0.0
BUILD_TAG          ?= latest

docker_build_default:
	# Build Docker image ...
	$(DOCKER_CMD) $(DOCKER_BUILDX) build $(DOCKER_PLATFORM) --build-arg STRIMZI_IMAGE=$(STRIMZI_IMAGE) -t strimzi/$(PROJECT_NAME):latest $(DOCKERFILE_DIR)
#   The Dockerfiles all use FROM ...:latest, so it is necessary to tag images with latest (-t above)
	# Also tag with $(BUILD_TAG)
	$(DOCKER_CMD) tag strimzi/$(PROJECT_NAME):latest strimzi/$(PROJECT_NAME):$(BUILD_TAG)$(DOCKER_PLATFORM_TAG_SUFFIX)

docker_tag_default:
	# Tag the $(BUILD_TAG) image we built with the given $(STRIMZI_RELEASE) tag
	$(DOCKER_CMD) tag strimzi/$(PROJECT_NAME):$(BUILD_TAG)$(DOCKER_PLATFORM_TAG_SUFFIX) $(DOCKER_REGISTRY)/$(DOCKER_ORG)/$(PROJECT_NAME):$(STRIMZI_RELEASE)$(DOCKER_PLATFORM_TAG_SUFFIX)


docker_push_default: docker_tag
	# Push the $(STRIMZI_RELEASE)-tagged image to the registry
	$(DOCKER_CMD) push $(DOCKER_REGISTRY)/$(DOCKER_ORG)/$(PROJECT_NAME):$(STRIMZI_RELEASE)$(DOCKER_PLATFORM_TAG_SUFFIX)

docker_%: docker_%_default
	@  true