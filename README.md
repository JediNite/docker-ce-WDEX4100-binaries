# docker-ce-WDEX4100-binaries

This repository hosts the binary files for running Docker CE on a WD EX4100 running OS5.  There are also additional files that can be used to take an existing docker-ce commit and prepare it for compilation on a WD EX4100.


## Installation

1. Take a copy of the "build.sh" script in this repository and place into an empty directory on the WD EX4100 NAS (eg. /shares/Public/docker-build)
```
# mkdir /shares/Public/docker-build
# cd /shares/Public/docker-build
# wget https://raw.githubusercontent.com/JediNite/docker-ce-WDEX4100-binaries/master/docker-ce-build/build.sh --no-check-certificate
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
5. The binaries will be located in build/linux.
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
