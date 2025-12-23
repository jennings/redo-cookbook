# Build the C# Hello World application
find . -name "*.cs" -o -name "*.csproj" | xargs redo-ifchange
dotnet build -o bin
