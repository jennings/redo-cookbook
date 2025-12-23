exec >&2

cd `dirname $1`
redo-ifchange package.json package-lock.json
npm ci
