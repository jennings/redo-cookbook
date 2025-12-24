# Builds a dotnet script that embeds variables from build_vars.sh.
#
# For more information, see:
# https://redo.readthedocs.io/en/latest/FAQSemantics/#should-i-use-environment-variables-to-affect-my-build

redo-ifchange build_vars.sh
. ./build_vars.sh

echo >$3 \
'DOTNET_CONFIGURATION='$DOTNET_CONFIGURATION'
case $1 in
build)
	shift
	dotnet build -c $DOTNET_CONFIGURATION "$@"
	;;
publish)
	shift
	dotnet publish -c $DOTNET_CONFIGURATION "$@"
	;;
*)
	dotnet "$@"
	;;
esac'

chmod +x $3
redo-stamp <$3