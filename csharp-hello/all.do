# Build the C# Hello World application
exec >&2
find . -name '*.cs' -o -name '*.csproj' -print0 | xargs -0 -r redo-ifchange
dotnet build -o bin
