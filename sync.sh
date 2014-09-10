#!/bin/bash
set -e

usage () {
    echo "$0 FROM TO"
}

FROM=$1
shift || (usage; exit 1)

TO=$1
shift || (usage; exit 1)

rsync -av --delete --exclude=.git/ $FROM/* $TO
