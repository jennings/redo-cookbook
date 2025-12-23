# Clean all example projects
exec >&2

# Clean C# console application
redo-ifchange csharp-hello/clean

# Clean TypeScript console application
redo-ifchange typescript-hello/clean

# Clean React Vite application
redo-ifchange react-vite-hello/clean
