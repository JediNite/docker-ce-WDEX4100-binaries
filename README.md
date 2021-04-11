# docker-ce-WDEX4100-binaries

This repository hosts the binary files for running Docker CE on a WD EX4100 running OS5.  There are also additional files that can be used to take an existing docker-ce commit and prepare it for compilation on a WD EX4100.

The background for this procedure was worked out by GitHub user gabrielitos87 per discussions in https://github.com/WDCommunity/wdpksrc/issues/85.


## Installation

1. Take a copy of the "build.sh" script and "Dockerfile.patch" in this repository and place into an empty directory on the WD EX4100 NAS (eg. /shares/Public/docker-build)
```
# mkdir /shares/Public/docker-build
# cd /shares/Public/docker-build
# wget https://github.com/JediNite/docker-ce-WDEX4100-binaries/raw/master/build.sh --no-check-certificate
# wget https://github.com/JediNite/docker-ce-WDEX4100-binaries/raw/master/Dockerfile.patch --no-check-certificate
```
2. Check the values in the top of the script are correct for what you require.  For example :
```
export CLI_DIR="cli"
export ENGINE_DIR="moby"
export GEN_STATIC_VER="20.10.5"
export GIT_DOCKER_CLI="https://github.com/docker/cli.git"
export GIT_DOCKER_ENGINE="https://github.com/moby/moby.git"
```
3. Run the script
```
# cd /shares/Public/docker-build
# ./build.sh
```
4. The script will then download the required content for both CLI and ENGINE, "checkout" the correct versions, patch DOCKER_ENGINE to use "stretch", compile the required binaries and then finally build the bundle packages
```
root@WDMyCloudEX4100 docker-build # ./build.sh
Cloning GitHub repositories...
Cloning into 'cli'...
remote: Enumerating objects: 111, done.
remote: Counting objects: 100% (111/111), done.
remote: Compressing objects: 100% (69/69), done.
remote: Total 393154 (delta 51), reused 74 (delta 40), pack-reused 393043
Receiving objects: 100% (393154/393154), 165.54 MiB | 2.13 MiB/s, done.
Resolving deltas: 100% (199029/199029), done.
Updating files: 100% (4835/4835), done.
Cloning into 'moby'...
remote: Enumerating objects: 61, done.
remote: Counting objects: 100% (61/61), done.
remote: Compressing objects: 100% (48/48), done.
remote: Total 300398 (delta 39), reused 13 (delta 13), pack-reused 300337
Receiving objects: 100% (300398/300398), 158.43 MiB | 2.93 MiB/s, done.
Resolving deltas: 100% (201556/201556), done.
Updating files: 100% (6318/6318), done.
Started compile of Docker CLI...
Note: switching to 'tags/v20.10.5'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at 55c4c88966 Merge pull request #2987 from thaJeztah/20.10_revert_backport_ignore_sigurg
# build dockerfile from stdin so that we don't send the build-context; source is bind-mounted in the development environment
cat ./dockerfiles/Dockerfile.binary-native | docker build --build-arg=GO_VERSION -t docker-cli-native -
[+] Building 1.9s (7/7) FINISHED
 => [internal] load .dockerignore                                                                                                                                                                         0.7s
 => => transferring context: 2B                                                                                                                                                                           0.0s
 => [internal] load build definition from Dockerfile                                                                                                                                                      1.0s
 => => transferring dockerfile: 286B                                                                                                                                                                      0.1s
 => [internal] load metadata for docker.io/library/golang:1.13.15-alpine                                                                                                                                  0.0s
 => [1/3] FROM docker.io/library/golang:1.13.15-alpine                                                                                                                                                    0.0s
 => CACHED [2/3] RUN     apk add -U git bash coreutils gcc musl-dev                                                                                                                                       0.0s
 => CACHED [3/3] WORKDIR /go/src/github.com/docker/cli                                                                                                                                                    0.0s
 => exporting to image                                                                                                                                                                                    0.5s
 => => exporting layers                                                                                                                                                                                   0.0s
 => => writing image sha256:12fdd946e02ea9562e8df8d7363b8379a1602080e33fa5c6cd1164b6d7d6cc22                                                                                                              0.1s
 => => naming to docker.io/library/docker-cli-native                                                                                                                                                      0.0s
docker run --rm -e VERSION=20.10.5 -e GITCOMMIT -e PLATFORM -e TESTFLAGS -e TESTDIRS -e GOOS -e GOARCH -e GOARM -e TEST_ENGINE_VERSION= -v "/mnt/HD/HD_a2/Public/docker-build/cli":/go/src/github.com/docker/cli -v "docker-cli-dev-cache:/root/.cache/go-build"  docker-cli-native
Building statically linked build/docker-linux-arm
Completed compile of Docker CLI...
Started compile of Docker ENGINE...
Note: switching to 'tags/v20.10.5'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at 363e9a88a1 Merge pull request #42061 from thaJeztah/20.10_backport_bump_buildkit
patching file Dockerfile
mkdir -p autogen
docker build  --build-arg=GO_VERSION  -f "Dockerfile" --output=bundles/ --target=binary --build-arg VERSION --build-arg DOCKER_GITCOMMIT --build-arg PRODUCT --build-arg PLATFORM --build-arg DEFAULT_PRODUCT_LICENSE .
[+] Building 1391.4s (32/32) FINISHED
 => [internal] load build definition from Dockerfile                                                                                                                                                      5.1s
 => => transferring dockerfile: 16.76kB                                                                                                                                                                   0.1s
 => [internal] load .dockerignore                                                                                                                                                                         4.5s
 => => transferring context: 87B                                                                                                                                                                          0.2s
 => resolve image config for docker.io/docker/dockerfile:1.1.7-experimental                                                                                                                               3.0s
 => CACHED docker-image://docker.io/docker/dockerfile:1.1.7-experimental@sha256:de85b2f3a3e8a2f7fe48e8e84a65f6fdd5cd5183afa6412fff9caa6871649c44                                                          0.0s
 => [internal] load metadata for docker.io/library/golang:1.13.15-stretch                                                                                                                                 1.1s
 => [internal] load metadata for docker.io/djs55/vpnkit:0.4.0                                                                                                                                             1.3s
 => [internal] load build context                                                                                                                                                                        33.0s
 => => transferring context: 53.37MB                                                                                                                                                                     32.0s
 => CACHED [vpnkit 1/1] FROM docker.io/djs55/vpnkit:0.4.0@sha256:e0e226d66cf3a7f2b4c3707aba207d4803be8a4f3a4e070a380de6d737a44669                                                                         0.2s
 => [base 1/3] FROM docker.io/library/golang:1.13.15-stretch@sha256:25c0ff4b9aae31d585a446895c455f251fde408c3194afade9b043f9c0522320                                                                      0.0s
 => CACHED [base 2/3] RUN echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache                                                                                      0.0s
 => CACHED [base 3/3] RUN sed -ri "s/(httpredir|deb).debian.org/${APT_MIRROR:-deb.debian.org}/g" /etc/apt/sources.list  && sed -ri "s/(security).debian.org/${APT_MIRROR:-security.debian.org}/g" /etc/a  0.0s
 => [tini 1/2] RUN --mount=type=cache,sharing=locked,id=moby-tini-aptlib,target=/var/lib/apt     --mount=type=cache,sharing=locked,id=moby-tini-aptcache,target=/var/cache/apt         apt-get update   174.7s
 => CACHED [containerd 1/3] RUN echo 'deb http://deb.debian.org/debian stretch-backports main' > /etc/apt/sources.list.d/backports.list                                                                   0.2s
 => [runtime-dev-cross-false 2/2] RUN --mount=type=cache,sharing=locked,id=moby-cross-false-aptlib,target=/var/lib/apt     --mount=type=cache,sharing=locked,id=moby-cross-false-aptcache,target=/var/  351.4s
 => [containerd 2/3] RUN --mount=type=cache,sharing=locked,id=moby-containerd-aptlib,target=/var/lib/apt     --mount=type=cache,sharing=locked,id=moby-containerd-aptcache,target=/var/cache/apt        201.6s
 => CACHED [proxy 1/1] RUN --mount=type=cache,target=/root/.cache/go-build     --mount=type=cache,target=/go/pkg/mod     --mount=type=bind,src=hack/dockerfile/install,target=/tmp/install         PREFI  0.0s
 => CACHED [rootlesskit 1/3] RUN --mount=type=cache,target=/root/.cache/go-build     --mount=type=cache,target=/go/pkg/mod     --mount=type=bind,src=hack/dockerfile/install,target=/tmp/install          0.0s
 => CACHED [rootlesskit 2/3] COPY ./contrib/dockerd-rootless.sh /build                                                                                                                                    0.0s
 => CACHED [rootlesskit 3/3] COPY ./contrib/dockerd-rootless-setuptool.sh /build                                                                                                                          0.0s
 => [tini 2/2] RUN --mount=type=cache,target=/root/.cache/go-build     --mount=type=cache,target=/go/pkg/mod     --mount=type=bind,src=hack/dockerfile/install,target=/tmp/install         PREFIX=/bui  160.7s
 => [containerd 3/3] RUN --mount=type=cache,target=/root/.cache/go-build     --mount=type=cache,target=/go/pkg/mod     --mount=type=bind,src=hack/dockerfile/install,target=/tmp/install         PREFI  583.1s
 => [runc 1/1] RUN --mount=type=cache,target=/root/.cache/go-build     --mount=type=cache,target=/go/pkg/mod     --mount=type=bind,src=hack/dockerfile/install,target=/tmp/install         PREFIX=/bui  199.9s
 => [binary-base 1/7] COPY --from=tini        /build/ /usr/local/bin/                                                                                                                                   153.7s
 => [binary-base 2/7] COPY --from=runc        /build/ /usr/local/bin/                                                                                                                                   101.0s
 => [binary-base 3/7] COPY --from=containerd  /build/ /usr/local/bin/                                                                                                                                    78.2s
 => [binary-base 4/7] COPY --from=rootlesskit /build/ /usr/local/bin/                                                                                                                                    67.7s
 => [binary-base 5/7] COPY --from=proxy       /build/ /usr/local/bin/                                                                                                                                    63.3s
 => [binary-base 6/7] COPY --from=vpnkit      /vpnkit /usr/local/bin/vpnkit.x86_64                                                                                                                       61.5s
 => [binary-base 7/7] WORKDIR /go/src/github.com/docker/docker                                                                                                                                           60.8s
 => [build-binary 1/1] RUN --mount=type=cache,target=/root/.cache/go-build     --mount=type=bind,target=/go/src/github.com/docker/docker         hack/make.sh binary                                    225.8s
 => [binary 1/1] COPY --from=build-binary /build/bundles/ /                                                                                                                                               2.2s
 => exporting to client                                                                                                                                                                                  16.4s
 => => copying files 169.06MB                                                                                                                                                                            16.3s
Completed compile of Docker ENGINE...
Started build of Docker Bundle file...
Completed build of Docker Bundle file...
Started build of Docker Rootless-Extras Bundle file...
Completed build of Docker Rootless-Extras Bundle file...
Docker bundle files are located in /shares/Public/docker-build/build/linux/docker ...
```
6. The binaries will be located in build/linux.
```
root@WDMyCloudEX4100 linux # ls -al *
-rw-r--r--    1 root     root      64564329 Apr 11 22:39 docker-20.10.5.tgz
-rw-r--r--    1 root     root       9544749 Apr 11 22:39 docker-rootless-extras-20.10.5.tgz

docker:
drwxr-xr-x    2 root     root          4096 Apr 11 22:38 .
drwxr-xr-x    4 root     root          4096 Apr 11 22:39 ..
-rwxr-xr-x    1 root     root      34632460 Apr 11 22:38 containerd
-rwxr-xr-x    1 root     root       6356992 Apr 11 22:38 containerd-shim
-rwxr-xr-x    1 root     root       8585216 Apr 11 22:38 containerd-shim-runc-v2
-rwxr-xr-x    1 root     root      18685380 Apr 11 22:38 ctr
-rwxr-xr-x    1 root     root      47289435 Apr 11 22:38 docker
-rwxr-xr-x    1 root     root        387564 Apr 11 22:38 docker-init
-rwxr-xr-x    1 root     root       2713383 Apr 11 22:38 docker-proxy
-rwxr-xr-x    1 root     root      68100472 Apr 11 22:38 dockerd
-rwxr-xr-x    1 root     root      11849128 Apr 11 22:38 runc

docker-rootless-extras:
drwxr-xr-x    2 root     root          4096 Apr 11 22:39 .
drwxr-xr-x    4 root     root          4096 Apr 11 22:39 ..
-rwxr-xr-x    1 root     root         12625 Apr 11 22:39 dockerd-rootless-setuptool.sh
-rwxr-xr-x    1 root     root          3985 Apr 11 22:39 dockerd-rootless.sh
-rwxr-xr-x    1 root     root      11036043 Apr 11 22:39 rootlesskit
-rwxr-xr-x    1 root     root       6651372 Apr 11 22:39 rootlesskit-docker-proxy
```
