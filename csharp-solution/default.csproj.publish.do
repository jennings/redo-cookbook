exec >&2

# static files we know will affect the build
redo-ifchange global.json \
    Directory.Build.props \
    build/dotnet \
    build/add_csharp_dependencies.sh

projdir=$(dirname "$1")
./build/dotnet publish "$2.csproj" -o "$projdir/publish"

./build/add_csharp_dependencies.sh $(dirname "$1") $(basename "$2").csproj
