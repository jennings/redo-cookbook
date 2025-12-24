# C# Library and Application Example

This example demonstrates how to use redo to build a C# class library and a console application that depends on it. It showcases incremental builds using `redo-ifchange` to avoid rebuilding up-to-date work.

## Project Structure

- **MyLibrary** - A C# class library containing reusable code
  - `Calculator.cs` - A simple calculator class
  - `Greeter.cs` - A greeting helper class
  - `MyLibrary.csproj` - The library project file

- **MyApp** - A console application that uses MyLibrary
  - `Program.cs` - The main application entry point
  - `MyApp.csproj` - The console app project file

## Build Scripts

- `library.do` - Builds the MyLibrary NuGet package
  - Uses `redo-ifchange` to track all `.cs` and `.csproj` files
  - Only rebuilds if source files have changed
  - Creates a NuGet package in the `packages` directory

- `app.do` - Builds the MyApp console application
  - Depends on the library package via `redo-ifchange ../library`
  - Only rebuilds if the library or app source files have changed
  - Outputs the built application to the `bin` directory

- `all.do` - Builds both the library and the application
- `clean.do` - Removes all build artifacts

## How redo-ifchange Avoids Rebuilds

The key to avoiding unnecessary rebuilds is the `redo-ifchange` command:

1. **In library.do**: `find . -name '*.cs' -o -name '*.csproj' -print0 | xargs -0 -r redo-ifchange`
   - This tells redo to track all C# source files and project files
   - The library will only be rebuilt if any of these files change

2. **In app.do**: `redo-ifchange ../library`
   - This tells redo that the app depends on the library being built
   - The app will only be rebuilt if the library is rebuilt or if the app's own source files change

## Building

To build everything:

```bash
redo all
```

To build just the library:

```bash
redo library
```

To build just the app (this will build the library first if needed):

```bash
redo app
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
