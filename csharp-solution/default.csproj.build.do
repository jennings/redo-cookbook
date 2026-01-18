exec >&2

# static files we know will affect the build
redo-ifchange global.json \
    Directory.Build.props \
    build/dotnet \
    build/add_csharp_dependencies.sh

# build the project
./build/dotnet build "$2.csproj"

./build/add_csharp_dependencies.sh $(dirname "$1") $(basename "$2").csproj
