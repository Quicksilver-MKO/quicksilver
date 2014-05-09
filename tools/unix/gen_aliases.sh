#!/bin/sh
cd $(dirname $0)/../.. # we want to be at the root of the project
echo "Generating aliases.xml..." >&2
lua tools/gen_aliases.lua qs_aliases/ > aliases.xml && (echo "Done!" >&2;exit 0) || (rm aliases.xml; echo "Failure!">&2;exit 1)

