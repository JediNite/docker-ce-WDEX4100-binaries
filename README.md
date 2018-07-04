# docker-ce-WDEX4100-binaries

This repository hosts the binary files for running Docker CE on a WD EX4100.  There are also additional files that can be used to take an existing docker-ce commit and prepare it for compilation on a WD EX4100.


## Installation

1. Download the official docker-ce source
```
# mkdir docker-ce-WDEX4100
# cd docker-ce-WDEX4100
# git clone https://github.com/docker/docker-ce.git
```
2. Once downloaded apply the patch to update the build version and the build of the docker-runc executable.
```
# cd docker-ce
# wget https://raw.githubusercontent.com/JediNite/docker-ce-WDEX4100-binaries/master/docker-ce-build/docker-ce-build.patch
# patch < docker-ce-build.patch
```
3. Make the Linux package files.
```
# cd packaging/static
# make static-linux
```
4. The build will now run and when completed will save the files into components/packaging/static/build/linux.
```
# ls -al
drwxr-xr-x    3 root     root          4096 Jun 30 08:26 .
drwxr-xr-x    3 root     root          4096 Jun 28 07:04 ..
drwxr-xr-x    2 root     root          4096 Jul  3 21:57 docker
-rw-r--r--    1 root     root      36262915 Jul  3 21:58 docker-18.05.0-ce.tgz
# ls -al docker
drwxr-xr-x    2 root     root          4096 Jul  3 21:57 .
drwxr-xr-x    3 root     root          4096 Jun 30 08:26 ..
-rwxr-xr-x    1 root     root      31321118 Jul  3 21:57 docker
-rwxr-xr-x    1 root     root      12749156 Jul  3 21:57 docker-containerd
-rwxr-xr-x    1 root     root      10638276 Jul  3 21:57 docker-containerd-ctr
-rwxr-xr-x    1 root     root       3624368 Jul  3 21:57 docker-containerd-shim
-rwxr-xr-x    1 root     root        387556 Jul  3 21:57 docker-init
-rwxr-xr-x    1 root     root       2655721 Jul  3 21:57 docker-proxy
-rwxr-xr-x    1 root     root       5894200 Jul  3 21:57 docker-runc
-rwxr-xr-x    1 root     root      41693300 Jul  3 21:57 dockerd
```


