d=`dirname "$1"`
bin=`basename $2`

cargo build --manifest-path "$d/Cargo.toml"

# mark dependencies
redo-ifchange $d/Cargo.toml $d/Cargo.lock
cut -d: -f2 < $d/target/debug/$bin.d | xargs redo-ifchange
