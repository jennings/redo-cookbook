#!/bin/bash
# Build everything in the csharp-library example
exec >&2

# First build the library package
redo-ifchange library

# Then build the app (which depends on the library)
redo-ifchange app
