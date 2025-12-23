#!/bin/sh
# Build the TypeScript Hello World application
redo-ifchange index.ts tsconfig.json
npx tsc
