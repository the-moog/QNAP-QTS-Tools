include gmtt/gmtt.mk


DOCKER_COLLECTION = moog
DOCKER_IMAGE = $(basename $(shell pwd))

DOCKER_TAG_BASE = $(DOCKER_COLLECTION)/$(DOCKER_IMAGE)

images != system-docker image ls | tail -n +2


TABLEDATA = 7 $(images)


NAME = 1
TAG = 2
ID = 3
N_AGO = 4
HMS_AGO = 5
SIZE = 7
versions = $(call select,,table,where-clause)


VERSIONS = $(call select,$(NAME) $(TAG) $(ID),$(test-tbl),$$(call str-match,$$1,$(DOCKER_COLLECTION)/$(DOCKER_IMAGE)))

$(info $(VERSIONS))

all:
