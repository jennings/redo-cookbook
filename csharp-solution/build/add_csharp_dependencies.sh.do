#!/bin/bash
#
# Recursively adds dependencies to a csproj build target. This depends on dotnet
# having built the project and the sourcefiles.deps files existing inside of the
# obj directory.
#
# Must use bash, there's something about the default sh on some systems that
# outputs control characters instead of '\1'

redo-ifchange build_vars.sh
. ./build_vars.sh

echo >$3 '#!/bin/bash
set -euo pipefail

ifchange_dependencies() {
	prev=$(pwd)
	cd "$1"

	targetframework=$(sed <"$2" -nE '\''s/^[[:blank:]]*<TargetFramework>(.+)<\/TargetFramework>[[:blank:]]*$/\1/p'\'')

	# depend on any files this project directly uses
	grep -vE '\''^(obj/|/|\w:)'\'' <"obj/'$DOTNET_CONFIGURATION'/$targetframework/sourcefiles.deps" |
		xargs redo-ifchange

	# recursively depend on the files in each project reference
	# they should also have sourcefiles.deps built, since building this project
	# required building them
	dotnet list "$2" reference | tail -n+3 | tr "\\\\" "/" |
		while IFS="" read -r proj_path; do
			ifchange_dependencies $(dirname $proj_path) $(basename $proj_path)
		done | xargs redo-ifchange

	cd "$prev"
}

ifchange_dependencies "$1" "$2"'

chmod +x $3
redo-stamp <$3