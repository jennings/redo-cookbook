# redo-cookbook

Example build scripts using the redo build system.

## Examples

This repository contains examples of using [redo](https://redo.readthedocs.io/) to build different types of applications:

- **csharp-single-project** - A single C# console application
- **csharp-solution** - A C# class library and console application demonstrating
  incremental builds with `redo-ifchange`
- **typescript-single-program** - A TypeScript console application
- **react-vite-hello** - A React application using Vite ("Hello, World!")

## Building

Each example directory contains its own `all.do` file that builds that specific example.

To build all examples at once, run from the repository root:

```bash
redo all
```

Or to build individual examples:

```bash
redo csharp-single-project/all
redo csharp-solution/all
redo typescript-single-program/all
redo react-vite-hello/all
```

## Prerequisites

- [redo](https://redo.readthedocs.io/) build system
- For C# examples: .NET SDK (10.0+)
- For TypeScript example: Node.js and npm
- For React example: Node.js and npm
