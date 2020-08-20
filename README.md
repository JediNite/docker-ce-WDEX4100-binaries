# docker-ce-WDEX4100-binaries

This repository hosts the binary files for running Docker CE on a WD EX4100.  There are also additional files that can be used to take an existing docker-ce commit and prepare it for compilation on a WD EX4100.


## Installation

1. Download the official docker-ce source and chekout the required commit.
```
# mkdir docker-ce-WDEX4100
# cd docker-ce-WDEX4100
# git clone https://github.com/docker/docker-ce.git
# cd docker-ce
# git checkout -q <COMMIT>
```
2. Once downloaded apply the patch to update the build version and the build process for the docker-runc executable.
```
# wget https://raw.githubusercontent.com/JediNite/docker-ce-WDEX4100-binaries/master/docker-ce-build/docker-ce-build.patch --no-check-certificate
# patch -p0 < docker-ce-build.patch
```
3. Make the Linux package files.
```
# cd components/packaging/static
# export DOCKER_BUILDKIT=0
# export DOCKER_BUILD_OPTS="--network host"
# make static-linux
```
4. The build will now run and when completed will save the files into docker-ce-WDEX4100/docker-ce/components/packaging/static/build/linux.
```

root@WDMyCloudEX4100 linux # ls -al *
-rw-r--r--    1 root     root      58228722 Mar  5 06:11 docker-19.03.7.tgz
-rw-r--r--    1 root     root       9045209 Mar  5 06:11 docker-rootless-extras-19.03.7.tgz

docker:
drwxr-xr-x    2 root     root          4096 Mar  5 06:11 .
drwxr-xr-x    4 root     root          4096 Mar  5 06:11 ..
-rwxr-xr-x    1 root     root      30723896 Mar  5 06:11 containerd
-rwxr-xr-x    1 root     root       5464400 Mar  5 06:11 containerd-shim
-rwxr-xr-x    1 root     root      16622464 Mar  5 06:11 ctr
-rwxr-xr-x    1 root     root      50073252 Mar  5 06:10 docker
-rwxr-xr-x    1 root     root        387564 Mar  5 06:11 docker-init
-rwxr-xr-x    1 root     root       2669160 Mar  5 06:11 docker-proxy
-rwxr-xr-x    1 root     root      64013260 Mar  5 06:11 dockerd
-rwxr-xr-x    1 root     root       7826036 Mar  5 06:11 runc

docker-rootless-extras:
drwxr-xr-x    2 root     root          4096 Mar  5 06:11 .
drwxr-xr-x    4 root     root          4096 Mar  5 06:11 ..
-rwxr-xr-x    1 root     root          3173 Mar  5 06:11 dockerd-rootless.sh
-rwxr-xr-x    1 root     root      10703184 Mar  5 06:11 rootlesskit
-rwxr-xr-x    1 root     root       6565656 Mar  5 06:11 rootlesskit-docker-proxy

```
