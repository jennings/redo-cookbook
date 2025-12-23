# Downloads the minimal do script using... redo

curl https://github.com/apenwarr/redo/raw/refs/heads/main/minimal/do -L -o "$3" >&2
chmod +x "$3"
redo-stamp < "$3"
