# Build all examples in the redo cookbook

# Build C# console application
redo-ifchange csharp-hello/all

# Build C# library and application example
redo-ifchange csharp-library/all

# Build TypeScript console application
redo-ifchange typescript-hello/all

# Build React Vite application
redo-ifchange react-vite-hello/all
