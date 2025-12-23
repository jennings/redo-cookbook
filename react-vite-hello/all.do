# Build the React Vite application
find src -type f -print0 | xargs -0 -r redo-ifchange
redo-ifchange package.json package-lock.json
npm run build
