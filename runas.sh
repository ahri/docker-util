#!/bin/sh

set -ue

uid=$1
gid=$2
shift 2

# remove any conflicting user/group
echo "$(awk -vFS=: -vOFS=: -vuid=$uid '$3 != uid { print }' < /etc/passwd)" > /etc/passwd
echo "$(awk -vFS=: -vOFS=: -vgid=$gid '$3 != gid { print }' < /etc/group)" > /etc/group

# add in user/group for mapping
addgroup -g  $gid
adduser -U $uid -G $gid

# run as the user
su user "$@"
