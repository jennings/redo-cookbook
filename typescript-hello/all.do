# Build the TypeScript Hello World application
exec >&2
redo-ifchange run.npm.install
find . -name '*.ts' -o -name 'tsconfig.json' -print0 | xargs -0 -r redo-ifchange
redo-ifchange package.json
npm run build
