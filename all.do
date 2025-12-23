#!/bin/sh
# Build all examples in the redo cookbook

# Build C# console application
cd csharp-hello && redo-ifchange all

# Build TypeScript console application
cd ../typescript-hello && redo-ifchange all

# Build React Vite application
cd ../react-vite-hello && redo-ifchange all

echo "All examples built successfully!"
