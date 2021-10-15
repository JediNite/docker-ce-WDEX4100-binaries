#!/usr/bin/env bash

export CLI_DIR="cli"
export ENGINE_DIR="moby"
export GEN_STATIC_VER="20.10.9"
export GIT_DOCKER_CLI="https://github.com/docker/cli.git"
export GIT_DOCKER_ENGINE="https://github.com/moby/moby.git"

# Cloning the Docker CLI and Docker ENGINE
echo "Cloning GitHub repositories..."
git clone ${GIT_DOCKER_CLI}
git clone ${GIT_DOCKER_ENGINE}

# Make the Docker CLI binary
echo "Started compile of Docker CLI..."
cd ${CLI_DIR}
# Checkout the correct version of Docker CLI
git checkout tags/v${GEN_STATIC_VER}
echo "${GEN_STATIC_VER}" > VERSION
make -f docker.Makefile binary
cd ..
echo "Completed compile of Docker CLI..."

# Make the Docker ENGINE binaries
echo "Started compile of Docker ENGINE..."
cd ${ENGINE_DIR}
# Checkout the correct version of Docker ENGINE
git checkout tags/v${GEN_STATIC_VER}
# Apply the Dockerfile.patch patch to set the Debian base to "stretch" and update some container Debian package repositories
cp ../Dockerfile.patch .
patch < Dockerfile.patch
make VERSION=${GEN_STATIC_VER} binary
cd ..
echo "Completed compile of Docker ENGINE..."

# build bundle file for docker
echo "Started build of Docker Bundle file..."
mkdir -p build/linux/docker
cp ${CLI_DIR}/build/docker build/linux/docker/
for file in dockerd containerd ctr containerd-shim containerd-shim-runc-v2 docker-init docker-proxy runc
do
	cp -L ${ENGINE_DIR}/bundles/binary-daemon/${file} build/linux/docker/${file}
done
tar -C build/linux -c -z -f build/linux/docker-${GEN_STATIC_VER}.tgz docker
echo "Completed build of Docker Bundle file..."

# extra binaries for running rootless
echo "Started build of Docker Rootless-Extras Bundle file..."
mkdir -p build/linux/docker-rootless-extras
for file in rootlesskit rootlesskit-docker-proxy dockerd-rootless.sh dockerd-rootless-setuptool.sh vpnkit
do
	if [ -f ${ENGINE_DIR}/bundles/binary-daemon/${file} ]
	then
		cp -L ${ENGINE_DIR}/bundles/binary-daemon/${file} build/linux/docker-rootless-extras/${file}
	fi
done
tar -C build/linux -c -z -f build/linux/docker-rootless-extras-${GEN_STATIC_VER}.tgz docker-rootless-extras
echo "Completed build of Docker Rootless-Extras Bundle file..."

echo "Docker bundle files are located in `pwd`/build/linux ..."
