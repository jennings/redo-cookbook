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