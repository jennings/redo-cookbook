# Clean TypeScript build artifacts
exec >&2

find . -not -path './node_modules/*' -and \( -name '*.js' -o -name '*.d.ts' -o -name '*.map' \) |
xargs rm -f
