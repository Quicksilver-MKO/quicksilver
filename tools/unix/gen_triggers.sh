#!/bin/sh
cd $(dirname $0)/../.. # we want to be at the root of the project
echo "Generating triggers.xml..." >&2
lua tools/gen_triggers.lua qs_triggers/ > triggers.xml && (echo "Done!" >&2;exit 0) || (rm triggers.xml; echo "Failure!">&2;exit 1)

