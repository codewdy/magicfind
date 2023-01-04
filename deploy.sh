#!/bin/bash
DST_DIR="$1"
SRC_DIR=`dirname "$0"`
rsync -r "$SRC_DIR"  "$DST_DIR"
