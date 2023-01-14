#!/bin/bash
DST_DIR="$1"
SRC_DIR=`dirname "$0"`
rsync -a --del --exclude .git --exclude rocks --exclude .gitignore "$SRC_DIR"  "$DST_DIR"
