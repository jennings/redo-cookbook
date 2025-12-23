# Lint the React Vite application with Biome
exec >&2
redo-ifchange install
find src -type f -print0 | xargs -0 -r redo-ifchange
redo-ifchange package.json biome.json
npx biome check .
