# Build the TypeScript Hello World application
find . -name "*.ts" -o -name "tsconfig.json" | xargs redo-ifchange
npx tsc
