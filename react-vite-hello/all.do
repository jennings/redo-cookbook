# Build the React Vite application
find src -type f | xargs redo-ifchange
redo-ifchange package.json package-lock.json
npm run build
