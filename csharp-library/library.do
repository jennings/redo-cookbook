#!/bin/bash
# Build the MyLibrary class library
exec >&2

cd MyLibrary

# Track all source files and project file as dependencies
find . -name '*.cs' -o -name '*.csproj' -print0 | xargs -0 -r redo-ifchange

# Build the library
dotnet build -c Release
