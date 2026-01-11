#!/usr/bin/bash

set -e

cd "$(dirname "$0")"/..

source .env

export DATABASE_URL="postgres://postgres:${POSTGRES_PASSWORD}@127.0.0.1/nationstates"
export NS_USER_AGENT="${USER_AGENT}"

swash/target/release/swash
