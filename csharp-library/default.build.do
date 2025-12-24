#!/bin/bash
# Reusable default build script for C# projects
# This script can build any C# project without modification.
# It automatically:
#   - Detects and builds dependencies from ProjectReferences
#   - Tracks source files to enable incremental builds
#   - Determines output type (library vs executable) and builds accordingly
#
# Usage: redo ProjectName.build
# Example: redo MyLibrary.build, redo MyApp.build
exec >&2

# $1 is the full target name (e.g., "MyLibrary.build")
# $2 is the base name without extension (e.g., "MyLibrary")
# $3 is the temporary output file

# Extract the project name (directory) from the target
PROJECT_NAME="$2"

cd "$PROJECT_NAME"

# Check for ProjectReferences and track them as dependencies
if [ -f *.csproj ]; then
    # Extract ProjectReference paths and convert to build targets
    grep -o 'Include="[^"]*\.csproj"' *.csproj | sed 's/Include="//;s/"$//' | while read -r ref; do
        # Convert relative path to build target
        # e.g., "../MyLibrary/MyLibrary.csproj" -> "MyLibrary.build"
        ref_name=$(basename "$(dirname "$ref")")
        redo-ifchange "../$ref_name.build"
    done
fi

# Track all source files and project file as dependencies
find . -name '*.cs' -o -name '*.csproj' -print0 | xargs -0 -r redo-ifchange

# Determine the output type from the .csproj file
OUTPUT_TYPE=$(grep -o '<OutputType>[^<]*</OutputType>' *.csproj | sed 's/<[^>]*>//g')

# Build the project
if [ "$OUTPUT_TYPE" = "Exe" ]; then
    # For executables, build to the parent bin directory
    dotnet build -c Release -o ../bin
else
    # For libraries, just build (output goes to project's bin directory)
    dotnet build -c Release
fi
