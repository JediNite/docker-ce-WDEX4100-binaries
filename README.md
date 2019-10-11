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
# DOCKER_BUILDKIT=0 make static-linux
```
4. The build will now run and when completed will save the files into docker-ce-WDEX4100/docker-ce/components/packaging/static/build/linux.
```
# ls -al
drwxr-xr-x    4 root     root          4096 Oct 10 09:14 .
drwxr-xr-x    3 root     root          4096 Oct 10 09:14 ..
drwxr-xr-x    2 root     root          4096 Oct 10 09:14 docker
-rw-r--r--    1 root     root      57845465 Oct 10 09:14 docker-19.03.3.tgz
drwxr-xr-x    2 root     root          4096 Oct 10 09:14 docker-rootless-extras
-rw-r--r--    1 root     root       9043302 Oct 10 09:15 docker-rootless-extras-19.03.3.tgz
# ls -al docker
drwxr-xr-x    2 root     root          4096 Oct 10 09:14 .
drwxr-xr-x    4 root     root          4096 Oct 10 09:14 ..
-rwxr-xr-x    1 root     root      30686808 Oct 10 09:14 containerd
-rwxr-xr-x    1 root     root       5464400 Oct 10 09:14 containerd-shim
-rwxr-xr-x    1 root     root      16597664 Oct 10 09:14 ctr
-rwxr-xr-x    1 root     root      49924846 Oct 10 09:14 docker
-rwxr-xr-x    1 root     root        387564 Oct 10 09:14 docker-init
-rwxr-xr-x    1 root     root       2669160 Oct 10 09:14 docker-proxy
-rwxr-xr-x    1 root     root      63878000 Oct 10 09:14 dockerd
-rwxr-xr-x    1 root     root       6980584 Oct 10 09:14 runc
# ls -al docker-rootless-extras
drwxr-xr-x    2 root     root          4096 Oct 10 09:14 .
drwxr-xr-x    4 root     root          4096 Oct 10 09:14 ..
-rwxr-xr-x    1 root     root          2893 Oct 10 09:14 dockerd-rootless.sh
-rwxr-xr-x    1 root     root      10712745 Oct 10 09:14 rootlesskit
-rwxr-xr-x    1 root     root       6565656 Oct 10 09:14 rootlesskit-docker-proxy
```
