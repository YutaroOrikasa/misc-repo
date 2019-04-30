#!/bin/sh

set -e

source "$(dirname "$0")"/shlib.sh

test x"$(shlib test/lib.sh)" = x"lib" || echo error
