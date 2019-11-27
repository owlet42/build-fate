#!/bin/bash

# base
docker build -t federatedai/base-image:1.1-release \
./base/

# egg
docker build --build-arg PREFIX=federatedai --build-arg BASE_TAG=1.1-release \
-t federatedai/egg:1.1-release ./eggroll/egg/

# roll
docker build -t federatedai/roll:1.1-release ./eggroll/roll/

# meta-service
docker build -t federatedai/meta-service:1.1-release ./eggroll/meta-service/

# fateboard
docker build -t federatedai/fateboard:1.1-release ./fateboard/

# federation
docker build -t federatedai/federation:1.1-release ./federation/

# proxy
docker build -t federatedai/proxy:1.1-release ./proxy/

# python
docker build --build-arg PREFIX=federatedai --build-arg BASE_TAG=1.1-release \
-t federatedai/python:1.1-release ./python/
