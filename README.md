# redo-cookbook

Example build scripts using the redo build system.

## Examples

This repository contains examples of using [redo](https://redo.readthedocs.io/) to build different types of applications:

- **csharp-hello** - A C# console application ("Hello, World!")
- **typescript-hello** - A TypeScript console application ("Hello, World!")
- **react-vite-hello** - A React application using Vite ("Hello, World!")

## Building

Each example directory contains its own `all.do` file that builds that specific example.

To build all examples at once, run from the repository root:

```bash
redo all
```

Or to build individual examples:

```bash
cd csharp-hello && redo all
cd typescript-hello && redo all
cd react-vite-hello && redo all
```

## Prerequisites

- [redo](https://redo.readthedocs.io/) build system
- For C# example: .NET SDK (10.0+)
- For TypeScript example: Node.js and npm
- For React example: Node.js and npm
