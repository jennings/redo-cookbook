# Build the TypeScript Hello World application
exec >&2
find . -name '*.ts' -o -name 'tsconfig.json' -print0 | xargs -0 -r redo-ifchange
npx tsc
