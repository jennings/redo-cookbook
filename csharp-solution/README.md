# Multiple C# project example

This example demonstrates how to use redo to build a C# solution that contains
multiple projects.

## Project Structure

- **MyLibrary** - A C# class library containing reusable code

- **MyApp** - A console application that uses MyLibrary via ProjectReference

## Build Scripts

This example uses a **reusable** `default.build.do` script that can build any C# project:

- `default.build.do` - A generic build script for C# projects
  - Automatically detects project dependencies via ProjectReferences
  - Tracks all `.cs` and `.csproj` files with `redo-ifchange`
  - Determines if a project is a library or executable and builds accordingly
  - Can be reused for any number of C# projects without modification

- `all.do` - Builds both the library and the application using the reusable script
- `clean.do` - Removes all build artifacts

### How the Reusable Build Script Works

The `default.build.do` script matches any target ending in `.build` (e.g., `MyLibrary.build`, `MyApp.build`). This means:
- You can add more C# projects without writing new `.do` files
- Each project is built using the same script
- Dependencies are automatically tracked via ProjectReferences in the `.csproj` files

## How redo-ifchange Avoids Rebuilds

The key to avoiding unnecessary rebuilds is the `redo-ifchange` command in `default.build.do`:

1. **Tracking source files**: `find . -name '*.cs' -o -name '*.csproj' -print0 | xargs -0 -r redo-ifchange`
   - This tells redo to track all C# source files and project files
   - A project will only be rebuilt if any of these files change

2. **Automatic dependency tracking**: The script parses ProjectReferences from `.csproj` files
   - When building MyApp, it automatically detects the dependency on MyLibrary
   - It calls `redo-ifchange MyLibrary.build` before building MyApp
   - This ensures the library is built first and rebuilds MyApp only when the library changes

## Building

To build everything:

```bash
redo all
```

To build just the library:

```bash
redo MyLibrary.build
```

To build just the app (this will build the library first if needed):

```bash
redo MyApp.build
```

## Testing Incremental Builds

1. Build everything: `redo all`
2. Run `redo all` again - nothing should rebuild because everything is up-to-date
3. Modify a file in MyLibrary (e.g., `MyLibrary/Calculator.cs`)
4. Run `redo all` again - only the library and app will rebuild
5. Modify a file in MyApp (e.g., `MyApp/Program.cs`)
6. Run `redo all` again - only the app will rebuild, not the library

## Running

After building, you can run the application:

```bash
dotnet run --project MyApp
```

Or run the built executable directly:

```bash
dotnet bin/MyApp.dll
```

## Cleaning

To remove all build artifacts:

```bash
redo clean
```
