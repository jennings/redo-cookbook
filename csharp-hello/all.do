#!/bin/sh
# Build the C# Hello World application
redo-ifchange HelloWorld.csproj Program.cs
dotnet build -o bin
