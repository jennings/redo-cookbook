#!/bin/sh
# Build the React Vite application
redo-ifchange package.json package-lock.json src/App.jsx src/main.jsx
npm run build
