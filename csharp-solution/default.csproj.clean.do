exec >&2

redo-ifchange build/dotnet
./build/dotnet clean "$2.csproj"

cd "$(dirname $1)"
rm -rf bin obj publish
