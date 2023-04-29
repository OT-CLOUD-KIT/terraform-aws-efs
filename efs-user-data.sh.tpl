#!/bin/bash
apt-get update
apt-get install -y nfs-common
mkdir -p ${efs_mount_point}
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${efs_dns_name}:/ ${efs_mount_point}