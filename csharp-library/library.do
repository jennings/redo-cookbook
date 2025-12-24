#!/bin/bash
# Build the MyLibrary NuGet package
exec >&2

cd MyLibrary

# Track all source files and project file as dependencies
find . -name '*.cs' -o -name '*.csproj' -print0 | xargs -0 -r redo-ifchange

# Pack the library into a NuGet package
dotnet pack -c Release -o ../packages /p:PackageVersion=1.0.0
