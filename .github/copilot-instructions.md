# Copilot Instructions for redo-cookbook

## Project Overview

This repository contains example build scripts demonstrating the **redo** build system across different programming languages and frameworks. It serves as a cookbook of patterns for using redo in various project types.

## Repository Structure

- **Root directory**: Contains the main `all.do` script that builds all examples
- **csharp-hello/**: C# console application example using .NET
- **typescript-hello/**: TypeScript console application example using Node.js
- **react-vite-hello/**: React application example using Vite

Each example directory is self-contained with its own:
- `all.do` - Main build script for that example
- `clean.do` - Cleanup script
- `README.md` - Specific documentation
- Source files and configuration

## Build System: redo

This project uses [redo](https://redo.readthedocs.io/), a build system where build scripts are executable files with `.do` extensions.

### Key redo Concepts

- **`.do` files**: Executable build scripts (shell scripts by default)
- **`redo-ifchange`**: Declares dependencies and triggers builds
- **`$3`**: In `.do` scripts, this is the output file path
- **`exec >&2`**: Common pattern to redirect all output to stderr
- **`redo-stamp`**: Used to stamp outputs based on content, not timestamps

### Common redo Patterns in This Repository

1. **Dependency tracking**: Use `redo-ifchange` to declare file dependencies
2. **Finding source files**: Use `find` with `-print0` and `xargs -0` for safe file handling
3. **npm installations**: Custom `run.npm.install` targets handle Node.js dependencies

## Building

### Build All Examples
```bash
redo all
```

### Build Individual Examples
```bash
cd csharp-hello && redo all
cd typescript-hello && redo all
cd react-vite-hello && redo all
```

### Clean Build Artifacts
```bash
redo clean           # Clean all examples
cd <example> && redo clean  # Clean specific example
```

## Prerequisites

- **redo** build system (minimal version is downloaded via `do.do` if needed)
- **For C# example**: .NET SDK 10.0+
- **For TypeScript example**: Node.js and npm
- **For React example**: Node.js and npm

## Development Guidelines

### When Adding New Examples

1. Create a new directory with a descriptive name (e.g., `python-hello`)
2. Add an `all.do` script for building
3. Add a `clean.do` script for cleanup
4. Add a `README.md` explaining the example
5. Update the root `all.do` to include the new example
6. Update the root `README.md` with the new example

### .do Script Conventions

- Use `exec >&2` at the start to redirect output to stderr
- Use `redo-ifchange` to declare all dependencies
- Use `find ... -print0 | xargs -0 -r redo-ifchange` for multiple source files
- For npm projects, depend on `run.npm.install` before building
- Write output to `$3` when generating files

### File Organization

- Keep build artifacts out of source control (see `.gitignore`)
- Each example should be independently buildable
- Use relative paths within examples, absolute when cross-referencing

## Testing

Currently, this is a cookbook/example repository without automated tests. To verify examples work:

1. Build the example: `cd <example> && redo all`
2. Run the built artifact manually
3. Clean and rebuild to verify reproducibility: `redo clean && redo all`

## Common Tasks

### Adding a new dependency to a Node.js example
1. Navigate to the example directory
2. Run `npm install <package>`
3. The `package.json` and `package-lock.json` will be updated
4. The build will automatically pick up changes via `redo-ifchange package.json`

### Modifying build scripts
- Edit the relevant `.do` file
- redo will automatically detect changes and rebuild
- No need to "clean" unless you want to verify a full rebuild

### Debugging redo builds
- Run `redo -v` for verbose output
- Run `redo -x` to see shell command execution
- Check `.redo/` directory for build logs and dependencies
