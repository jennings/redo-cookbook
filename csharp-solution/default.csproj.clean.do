exec >&2

redo-ifchange build/dotnet

if [ -f "Directory.Packages.props" ]; then
    redo-ifchange Directory.Packages.props
else
    redo-ifcreate Directory.Packages.props
fi

./build/dotnet clean "$2.csproj"

cd "$(dirname $1)"
rm -rf bin obj publish
