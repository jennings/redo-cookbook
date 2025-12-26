# Clean all example projects
exec >&2

# Clean C# console application
redo-ifchange csharp-single-project/clean

# Clean TypeScript console application
redo-ifchange typescript-single-program/clean

# Clean React Vite application
redo-ifchange react-vite-hello/clean
