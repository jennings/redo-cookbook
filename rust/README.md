# Redo scripts for Rust

This project builds a binary `helloworld`.

It always builds in debug mode (for now).

## Simple example

After building, Cargo writes a file in the target dir named `<project>.d` which
contains a Makefile-like list of files that were used to build the crate:

```make
# target/debug/helloworld.d
/path/to/helloworld: /path/to/src/main.rs /path/to/src/lib.rs /path/to/src/message.rs
```

We just need the list of dependencies to pass to `redo-ifchange`, which we can
get with `cut -d: -f2 < target/debug/helloworld.d`. So, the simplest redo script is
a single `helloworld.do`:

```sh
# helloworld/helloworld.do

d=`dirname "$1"`
cargo build --manifest-path "$d/Cargo.toml"
ln -f "$d/target/debug/helloworld" $3

# mark dependencies
cat -d: -f2 < target/debug/helloworld.d | xargs redo-ifchange
```

## Making it reusable

Our repository might contain several crates and it would be nice to write a
single .do script for all of them.

We could rename `helloworld.do` to `default.do`, but then it could be invoked
for any target name, which may not be what we want. So instead, we create a
virtual target with the file `default.cargo.build.do`, where `$2` is the binary
name.

```sh
# default.cargo.build.do

d=`dirname "$1"`
bin=`basename $2`

cargo build --manifest-path "$d/Cargo.toml"
ln -f "$d/target/debug/$2" "$d/$2"

# mark dependencies
redo-ifchange $d/Cargo.toml $d/Cargo.lock
cut -d: -f2 < $d/target/debug/$bin.d | xargs redo-ifchange
```

```sh
# all.do
redo-ifchange helloworld/helloworld.cargo.build
```

This works, but redo won't know to rebuild `helloworld` if you delete the
output file. We want a `helloworld.do` so redo knows when the output file has
been removed. To do this, we move the linking step into a second redo script:

```sh
# default.cargo.build.do

d=`dirname "$1"`
bin=`basename $2`

cargo build --manifest-path "$d/Cargo.toml"

# mark dependencies
redo-ifchange $d/Cargo.toml $d/Cargo.lock
cut -d: -f2 < $d/target/debug/$bin.d | xargs redo-ifchange
```

```sh
# helloworld/helloworld.do

redo-ifchange helloworld.cargo.build
ln -f target/debug/$2 $2
```

```sh
# all.do
redo-ifchange helloworld/helloworld
```
