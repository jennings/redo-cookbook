# Install npm packages for TypeScript project
exec >&2
redo-ifchange package.json package-lock.json
npm install
