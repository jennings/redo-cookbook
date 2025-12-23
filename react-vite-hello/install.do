# Install npm packages for React Vite project
exec >&2
redo-ifchange package.json package-lock.json
npm install
