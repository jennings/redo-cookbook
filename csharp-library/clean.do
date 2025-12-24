#!/bin/bash
# Clean all build artifacts
exec >&2

rm -rf MyLibrary/bin MyLibrary/obj
rm -rf MyApp/bin MyApp/obj
rm -rf bin
