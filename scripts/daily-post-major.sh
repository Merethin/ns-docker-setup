#!/usr/bin/bash

set -e

cd "$(dirname "$0")"/..

./scripts/download-dumps.sh

# Place scripts to run post-dump download here.
