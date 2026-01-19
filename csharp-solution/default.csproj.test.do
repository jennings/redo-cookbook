# Runs `dotnet test` on a C# project.

exec >&2

# static files we know will affect the build
redo-ifchange global.json \
    Directory.Build.props \
    build/dotnet \
    build/add_csharp_dependencies.sh \
    "$2.csproj"

.if [ -f "Directory.Packages.props" ]; then
    redo-ifchange Directory.Packages.props
else
    redo-ifcreate Directory.Packages.props
fi

/build/dotnet test "$2.csproj"

./build/add_csharp_dependencies.sh $(dirname "$1") $(basename "$2").csproj
