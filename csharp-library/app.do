#!/bin/bash
# Build the MyApp console application
exec >&2

cd MyApp

# Depend on the library package being built
redo-ifchange ../library

# Track all source files and project file as dependencies
find . -name '*.cs' -o -name '*.csproj' -print0 | xargs -0 -r redo-ifchange

# Build the console app
dotnet build -c Release -o ../bin
